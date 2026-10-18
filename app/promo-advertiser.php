<?php

declare(strict_types=1);

/**
 * AI LAB HUB — кабінет рекламодавця: валідація, завантаження відео, кампанії,
 * баланс, статистика. Розмітка — app/promo-cabinet.php, обробник форм —
 * public/promo-action.php.
 *
 * Правила:
 *   * користувач бачить і змінює лише свої кампанії (promo_owned_campaign);
 *   * запуск лише через модерацію: «Надіслати» → pending_review, креатив pending;
 *     будь-яке редагування повертає кампанію в чернетку (знову потрібна модерація);
 *   * ціна — знімок з ad_rate_card на момент надсилання; без ціни для кожного
 *     обраного розміщення надіслати не можна;
 *   * суми — цілі копійки.
 */

require_once __DIR__ . '/promo.php';
require_once __DIR__ . '/promo-i18n.php';
require_once __DIR__ . '/promo-payments.php';
require_once __DIR__ . '/promo-linkcheck.php';

const PROMO_UPLOAD_DIR = __DIR__ . '/../public/uploads/promo';
const PROMO_UPLOAD_URL = 'uploads/promo/';
const PROMO_VIDEO_EXT = ['mp4' => 'video/mp4', 'webm' => 'video/webm'];
const PROMO_POSTER_MIME = ['image/jpeg' => 'jpg', 'image/png' => 'png', 'image/webp' => 'webp'];
const PROMO_POSTER_MAX_BYTES = 2 * 1024 * 1024;
const PROMO_EDITABLE = ['draft', 'paused', 'rejected'];
/** Ліміти дій на користувача за 24 години. */
const PROMO_LIMITS = ['campaign_create' => 10, 'video_upload' => 20, 'topup_request' => 10];

// --- CSRF ------------------------------------------------------------------

function promo_csrf_token(): string
{
    if (empty($_SESSION['promo_csrf']) || !is_string($_SESSION['promo_csrf'])) {
        $_SESSION['promo_csrf'] = bin2hex(random_bytes(32));
    }

    return $_SESSION['promo_csrf'];
}

function promo_csrf_field(): string
{
    return '<input type="hidden" name="csrf" value="' . htmlspecialchars(promo_csrf_token(), ENT_QUOTES) . '">';
}

function promo_csrf_verify(): bool
{
    $sent = $_POST['csrf'] ?? '';

    return is_string($sent) && $sent !== '' && hash_equals(promo_csrf_token(), $sent);
}

// --- Гроші -----------------------------------------------------------------

/** «123,45» / «123.45» → 12345 мінімальних одиниць (центів); null — некоректно або порожньо. */
function promo_parse_money(mixed $value): ?int
{
    $txt = str_replace([' ', "\u{00A0}", ','], ['', '', '.'], trim((string) $value));
    if ($txt === '' || !preg_match('/^\d{1,9}(\.\d{1,2})?$/', $txt)) {
        return null;
    }
    [$whole, $frac] = array_pad(explode('.', $txt, 2), 2, '0');

    return (int) $whole * 100 + (int) str_pad(substr($frac, 0, 2), 2, '0');
}

function promo_money(int|string|null $kop, string $currency = PROMO_CURRENCY): string
{
    $kop = (int) $kop;
    $sign = $kop < 0 ? '−' : '';
    $en = promo_lang() === 'en';
    $num = $en ? number_format(abs($kop) / 100, 2, '.', ',') : number_format(abs($kop) / 100, 2, ',', ' ');

    return match ($currency) {
        // Старі записи (до переходу на долари) лишаються в гривнях.
        'UAH' => $sign . $num . ' ' . promo_tr('currency_uah'),
        'USD' => $en ? $sign . '$' . $num : $sign . $num . ' $',
        default => $sign . $num . ' ' . $currency,
    };
}

/** Значення копійок для поля форми («123.45»). */
function promo_money_input(int|string|null $kop): string
{
    return $kop === null || $kop === '' ? '' : number_format((int) $kop / 100, 2, '.', '');
}

// --- Обмеження частоти -----------------------------------------------------

function promo_rate_ok(PDO $pdo, int $userId, string $action): bool
{
    $limit = PROMO_LIMITS[$action] ?? 0;
    if ($limit <= 0) {
        return true;
    }
    $st = $pdo->prepare(
        'SELECT COUNT(*) FROM ad_rate_limits WHERE user_id = :u AND action = :a AND created_at >= NOW() - INTERVAL 1 DAY'
    );
    $st->execute([':u' => $userId, ':a' => $action]);

    return (int) $st->fetchColumn() < $limit;
}

function promo_rate_hit(PDO $pdo, int $userId, string $action): void
{
    $pdo->prepare('INSERT INTO ad_rate_limits (user_id, action) VALUES (:u, :a)')
        ->execute([':u' => $userId, ':a' => $action]);
}

// --- Перевірки полів -------------------------------------------------------

/** Лише текст: без тегів і керівних символів, пробіли схлопнуто. */
function promo_clean_text(mixed $value): string
{
    $txt = strip_tags((string) $value);
    $txt = preg_replace('/[\x00-\x1F\x7F]+/u', ' ', $txt) ?? '';

    return trim(preg_replace('/\s{2,}/u', ' ', $txt) ?? '');
}

/**
 * Адреса призначення: лише https, без облікових даних у URL, без локальних і
 * приватних адрес (IP-літерал або домен, що резолвиться в приватну мережу).
 * Повертає ключ помилки або null.
 */
function promo_url_error(string $url): ?string
{
    if ($url === '' || mb_strlen($url) > 500 || preg_match('/[\s<>"\']/', $url)) {
        return 'err_url_invalid';
    }
    $parts = parse_url($url);
    if (!is_array($parts) || strtolower((string) ($parts['scheme'] ?? '')) !== 'https' || empty($parts['host'])) {
        return 'err_url_https';
    }
    if (isset($parts['user']) || isset($parts['pass'])) {
        return 'err_url_invalid';
    }
    $host = strtolower(trim((string) $parts['host'], '[]'));
    if ($host === 'localhost' || preg_match('/\.(localhost|local|test|internal|lan|home|example)$/', $host)) {
        return 'err_url_private';
    }
    $publicIp = static fn(string $ip): bool => filter_var(
        $ip,
        FILTER_VALIDATE_IP,
        FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE
    ) !== false;
    if (filter_var($host, FILTER_VALIDATE_IP) !== false) {
        return $publicIp($host) ? null : 'err_url_private';
    }
    if (!preg_match('/^(?=.{1,253}$)([a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\.)+[a-z]{2,63}$/', $host)
        && !preg_match('/^(?=.{1,253}$)([a-z0-9-]+\.)+xn--[a-z0-9-]+$/', $host)) {
        return 'err_url_invalid';
    }
    $ips = @gethostbynamel($host);
    if ($ips === false || $ips === []) {
        return 'err_url_dns';
    }
    foreach ($ips as $ip) {
        if (!$publicIp($ip)) {
            return 'err_url_private';
        }
    }

    return null;
}

/** ID відео YouTube з посилання (watch, youtu.be, shorts, embed) або null. */
function promo_youtube_id(string $url): ?string
{
    $url = trim($url);
    $patterns = [
        '~^https?://(?:www\.|m\.)?youtube\.com/watch\?(?:.*&)?v=([A-Za-z0-9_-]{11})~',
        '~^https?://youtu\.be/([A-Za-z0-9_-]{11})~',
        '~^https?://(?:www\.|m\.)?youtube\.com/(?:shorts|embed|live)/([A-Za-z0-9_-]{11})~',
        '~^https?://(?:www\.)?youtube-nocookie\.com/embed/([A-Za-z0-9_-]{11})~',
    ];
    foreach ($patterns as $p) {
        if (preg_match($p, $url, $m)) {
            return $m[1];
        }
    }

    return null;
}

/**
 * Тривалість MP4 (секунди) з атома mvhd, без ffprobe. null — не вдалося.
 * Для WebM тривалість не визначається на сервері (довіряємо ліміту розміру
 * й перевірці в браузері).
 */
function promo_mp4_duration(string $path): ?float
{
    $data = @file_get_contents($path);
    if ($data === false) {
        return null;
    }
    $pos = strpos($data, 'mvhd');
    if ($pos === false || $pos + 32 > strlen($data)) {
        return null;
    }
    $version = ord($data[$pos + 4]);
    if ($version === 1) {
        $u = unpack('Jcreated/Jmodified/Ntimescale/Jduration', substr($data, $pos + 8, 28));
    } else {
        $u = unpack('Ncreated/Nmodified/Ntimescale/Nduration', substr($data, $pos + 8, 16));
    }
    if (!is_array($u) || (int) $u['timescale'] <= 0) {
        return null;
    }

    return (int) $u['duration'] / (int) $u['timescale'];
}

/** Тривалість через ffprobe, якщо він доступний на сервері. */
function promo_ffprobe_duration(string $path): ?float
{
    if (!function_exists('shell_exec') || in_array('shell_exec', array_map('trim', explode(',', (string) ini_get('disable_functions'))), true)) {
        return null;
    }
    $out = @shell_exec('ffprobe -v error -show_entries format=duration -of csv=p=0 ' . escapeshellarg($path) . ' 2>&1');

    return is_string($out) && is_numeric(trim($out)) ? (float) trim($out) : null;
}

function promo_random_name(string $ext): string
{
    return bin2hex(random_bytes(16)) . '.' . $ext;
}

/**
 * Завантажене відео: розмір, розширення з білого списку, MIME через finfo,
 * тривалість (ffprobe → mvhd для MP4 → значення з браузера). Повертає
 * ['path','mime','size','duration'] або ['error' => ключ].
 */
function promo_store_video(PDO $pdo, array $file, ?int $clientDuration): array
{
    $maxMb = max(1, (int) promo_setting($pdo, 'max_video_mb', '30'));
    $maxSec = max(1, (int) promo_setting($pdo, 'max_video_sec', '30'));

    if (($file['error'] ?? UPLOAD_ERR_NO_FILE) === UPLOAD_ERR_INI_SIZE || ($file['error'] ?? 0) === UPLOAD_ERR_FORM_SIZE) {
        return ['error' => 'err_video_too_big'];
    }
    if (($file['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_OK || !is_uploaded_file((string) $file['tmp_name'])) {
        return ['error' => 'err_video_upload'];
    }
    $size = (int) $file['size'];
    if ($size <= 0 || $size > $maxMb * 1024 * 1024) {
        return ['error' => 'err_video_too_big'];
    }
    $ext = strtolower(pathinfo((string) $file['name'], PATHINFO_EXTENSION));
    if (!isset(PROMO_VIDEO_EXT[$ext])) {
        return ['error' => 'err_video_type'];
    }
    $mime = (new finfo(FILEINFO_MIME_TYPE))->file((string) $file['tmp_name']);
    if (!in_array($mime, ['video/mp4', 'video/webm', 'application/mp4'], true)
        || ($ext === 'webm') !== ($mime === 'video/webm')) {
        return ['error' => 'err_video_type'];
    }

    $duration = promo_ffprobe_duration((string) $file['tmp_name']);
    if ($duration === null && $ext === 'mp4') {
        $duration = promo_mp4_duration((string) $file['tmp_name']);
    }
    if ($duration === null && $clientDuration !== null && $clientDuration > 0) {
        $duration = (float) $clientDuration;
    }
    if ($duration !== null && $duration > $maxSec + 0.5) {
        return ['error' => 'err_video_too_long'];
    }

    if (!is_dir(PROMO_UPLOAD_DIR) && !@mkdir(PROMO_UPLOAD_DIR, 0755, true)) {
        return ['error' => 'err_video_upload'];
    }
    $name = promo_random_name($ext);
    if (!move_uploaded_file((string) $file['tmp_name'], PROMO_UPLOAD_DIR . '/' . $name)) {
        return ['error' => 'err_video_upload'];
    }
    @chmod(PROMO_UPLOAD_DIR . '/' . $name, 0644);

    return [
        'path' => PROMO_UPLOAD_URL . $name,
        'mime' => $ext === 'webm' ? 'video/webm' : 'video/mp4',
        'size' => $size,
        'duration' => $duration !== null ? (int) ceil($duration) : null,
    ];
}

/**
 * Постер: завантажений файл АБО кадр із відео (data:image/jpeg;base64 з браузера).
 * Повертає ['path'] , ['error'] або [] (постера немає).
 */
function promo_store_poster(?array $file, string $dataUrl): array
{
    $bytes = null;
    if ($file !== null && ($file['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_NO_FILE) {
        if (($file['error'] ?? 1) !== UPLOAD_ERR_OK || !is_uploaded_file((string) $file['tmp_name'])
            || (int) $file['size'] > PROMO_POSTER_MAX_BYTES) {
            return ['error' => 'err_poster'];
        }
        $bytes = (string) file_get_contents((string) $file['tmp_name']);
    } elseif ($dataUrl !== '') {
        if (!preg_match('~^data:image/(jpeg|png|webp);base64,([A-Za-z0-9+/=]+)$~', $dataUrl, $m)) {
            return ['error' => 'err_poster'];
        }
        $bytes = base64_decode($m[2], true);
        if ($bytes === false || strlen($bytes) > PROMO_POSTER_MAX_BYTES) {
            return ['error' => 'err_poster'];
        }
    }
    if ($bytes === null) {
        return [];
    }
    $mime = (new finfo(FILEINFO_MIME_TYPE))->buffer($bytes);
    if (!isset(PROMO_POSTER_MIME[$mime]) || @getimagesizefromstring($bytes) === false) {
        return ['error' => 'err_poster'];
    }
    if (!is_dir(PROMO_UPLOAD_DIR) && !@mkdir(PROMO_UPLOAD_DIR, 0755, true)) {
        return ['error' => 'err_poster'];
    }
    $name = promo_random_name(PROMO_POSTER_MIME[$mime]);
    if (file_put_contents(PROMO_UPLOAD_DIR . '/' . $name, $bytes) === false) {
        return ['error' => 'err_poster'];
    }

    return ['path' => PROMO_UPLOAD_URL . $name];
}

// --- Дані ------------------------------------------------------------------

/** Кампанія користувача (лише власна й лише відео) або null. */
function promo_owned_campaign(PDO $pdo, int $userId, int $campaignId): ?array
{
    $st = $pdo->prepare("SELECT * FROM ad_campaigns WHERE id = :id AND user_id = :u AND format = 'video'");
    $st->execute([':id' => $campaignId, ':u' => $userId]);
    $row = $st->fetch();

    return $row === false ? null : $row;
}

function promo_campaign_creative(PDO $pdo, int $campaignId): ?array
{
    $st = $pdo->prepare('SELECT * FROM ad_creatives WHERE campaign_id = :c ORDER BY id LIMIT 1');
    $st->execute([':c' => $campaignId]);
    $row = $st->fetch();

    return $row === false ? null : $row;
}

/**
 * Таргетинг кампанії у вигляді полів форми.
 *
 * @return array{placements:list<string>,cats:list<int>,subs:list<int>,language:string,device:string}
 */
function promo_campaign_targeting(PDO $pdo, int $campaignId): array
{
    $st = $pdo->prepare('SELECT * FROM ad_targets WHERE campaign_id = :c');
    $st->execute([':c' => $campaignId]);
    $out = ['placements' => [], 'cats' => [], 'subs' => [], 'language' => 'all', 'device' => 'all'];
    foreach ($st->fetchAll() as $t) {
        $out['placements'][] = $t['placement'];
        if ($t['subcategory_id'] !== null) {
            $out['subs'][] = (int) $t['subcategory_id'];
        } elseif ($t['category_id'] !== null) {
            $out['cats'][] = (int) $t['category_id'];
        }
        $out['language'] = $t['language'] ?? 'all';
        $out['device'] = $t['device'] ?? 'all';
    }
    $out['placements'] = array_values(array_unique($out['placements']));
    $out['cats'] = array_values(array_unique($out['cats']));
    $out['subs'] = array_values(array_unique($out['subs']));

    return $out;
}

/** Ціни прайсу: [placement][model] => центи (лише активні, PROMO_CURRENCY). */
function promo_rate_card(PDO $pdo): array
{
    $out = [];
    try {
        $st = $pdo->prepare('SELECT placement, pricing_model, price FROM ad_rate_card WHERE active = 1 AND currency = :c');
        $st->execute([':c' => PROMO_CURRENCY]);
        foreach ($st as $r) {
            $out[$r['placement']][$r['pricing_model']] = (int) $r['price'];
        }
    } catch (Throwable $e) {
        error_log('[promo] rate card: ' . $e->getMessage());
    }

    return $out;
}

/** Валюта балансу користувача (старі баланси до переходу на долари — UAH). */
function promo_balance_currency(PDO $pdo, int $userId): string
{
    $st = $pdo->prepare('SELECT currency FROM ad_balances WHERE user_id = :u');
    $st->execute([':u' => $userId]);

    return (string) ($st->fetchColumn() ?: PROMO_CURRENCY);
}

function promo_balance(PDO $pdo, int $userId): int
{
    $st = $pdo->prepare('SELECT balance FROM ad_balances WHERE user_id = :u');
    $st->execute([':u' => $userId]);

    return (int) ($st->fetchColumn() ?: 0);
}

/** Категорії з підкатегоріями для вибору таргету. */
function promo_taxonomy(PDO $pdo): array
{
    $cats = [];
    foreach ($pdo->query('SELECT id, name, name_en FROM categories ORDER BY id') as $c) {
        $cats[(int) $c['id']] = $c + ['subs' => []];
    }
    foreach ($pdo->query('SELECT id, category_id, name, name_en FROM subcategories ORDER BY name') as $s) {
        if (isset($cats[(int) $s['category_id']])) {
            $cats[(int) $s['category_id']]['subs'][(int) $s['id']] = $s;
        }
    }

    return $cats;
}

// --- Збереження кампанії (майстер) -----------------------------------------

/**
 * Зберегти кампанію з майстра: чернетку або надсилання на модерацію.
 *
 * Помилки формату (неправильна адреса, файл, задовгий текст) → нічого не
 * зберігається. Бракує обов'язкових для надсилання полів → зберігається
 * чернетка, повертаються помилки.
 *
 * saved=false — нічого не збережено (id — кампанія, яку редагували, якщо була).
 *
 * @return array{saved:bool,id:?int,errors:list<string>,submitted:bool}
 */
function promo_save_campaign(PDO $pdo, int $userId, array $in, array $files, bool $submit, bool $house = false): array
{
    $errors = [];
    $campaignId = (int) ($in['campaign_id'] ?? 0);
    $campaign = null;
    $creative = null;
    if ($campaignId > 0) {
        $campaign = promo_owned_campaign($pdo, $userId, $campaignId);
        if ($campaign === null || ($campaign['campaign_type'] === 'internal') !== $house) {
            return ['saved' => false, 'id' => null, 'errors' => ['err_not_found'], 'submitted' => false];
        }
        if (!in_array($campaign['status'], PROMO_EDITABLE, true)) {
            return ['saved' => false, 'id' => null, 'errors' => ['err_not_editable'], 'submitted' => false];
        }
        $creative = promo_campaign_creative($pdo, $campaignId);
    } elseif (!$house && !promo_rate_ok($pdo, $userId, 'campaign_create')) {
        return ['saved' => false, 'id' => null, 'errors' => ['err_rate_campaigns'], 'submitted' => false];
    }

    // 1. Ціль і назва
    $name = mb_substr(promo_clean_text($in['name'] ?? ''), 0, 120);
    $objective = in_array($in['objective'] ?? '', ['awareness', 'clicks'], true) ? $in['objective'] : null;
    $model = $objective === 'clicks' ? 'cpc' : ($objective === 'awareness' ? 'cpm' : null);
    $advCategory = is_string($in['advertiser_category'] ?? null) && isset(PROMO_ADVERTISER_CATEGORIES[$in['advertiser_category']])
        ? $in['advertiser_category'] : null;

    // 2. Креатив
    $title = promo_clean_text($in['title'] ?? '');
    $description = promo_clean_text($in['description'] ?? '');
    if (mb_strlen($title) > 60) {
        $errors[] = 'err_title_long';
    }
    if (mb_strlen($description) > 150) {
        $errors[] = 'err_desc_long';
    }
    $cta = in_array($in['cta_key'] ?? '', PROMO_CTA_KEYS, true) ? $in['cta_key'] : 'learn_more';
    $destination = trim((string) ($in['destination_url'] ?? ''));
    if ($destination !== '' && ($e = promo_url_error($destination)) !== null) {
        $errors[] = $e;
    }
    $videoType = in_array($in['video_type'] ?? '', ['upload', 'youtube'], true) ? $in['video_type'] : 'upload';
    $youtubeId = $creative['youtube_id'] ?? null;
    $youtubeUrl = $creative['video_url'] ?? null;
    if ($videoType === 'youtube' && trim((string) ($in['youtube_url'] ?? '')) !== '') {
        $youtubeUrl = trim((string) $in['youtube_url']);
        $youtubeId = promo_youtube_id($youtubeUrl);
        if ($youtubeId === null) {
            $errors[] = 'err_youtube';
        }
    }

    // 3. Аудиторія й розміщення
    $language = in_array($in['language'] ?? '', ['uk', 'en'], true) ? $in['language'] : null;
    $device = in_array($in['device'] ?? '', ['mobile', 'desktop'], true) ? $in['device'] : null;
    $placements = array_values(array_intersect(PROMO_PLACEMENTS, (array) ($in['placements'] ?? [])));
    $allCats = !empty($in['cat_all']);
    $taxonomy = promo_taxonomy($pdo);
    $subParent = [];
    foreach ($taxonomy as $cid => $c) {
        foreach ($c['subs'] as $sid => $s) {
            $subParent[$sid] = $cid;
        }
    }
    $cats = $allCats ? [] : array_values(array_filter(array_map('intval', (array) ($in['cats'] ?? [])), static fn($id) => isset($taxonomy[$id])));
    $subs = $allCats ? [] : array_values(array_filter(array_map('intval', (array) ($in['subs'] ?? [])), static fn($id) => isset($subParent[$id])));
    // Обрано всю категорію — її окремі підкатегорії зайві.
    $subs = array_values(array_filter($subs, static fn($sid) => !in_array($subParent[$sid], $cats, true)));

    // 4. Бюджет і графік
    $daily = trim((string) ($in['daily_budget'] ?? '')) === '' ? null : promo_parse_money($in['daily_budget']);
    $total = trim((string) ($in['total_budget'] ?? '')) === '' ? null : promo_parse_money($in['total_budget']);
    if (trim((string) ($in['daily_budget'] ?? '')) !== '' && ($daily === null || $daily <= 0)) {
        $errors[] = 'err_daily_budget';
    }
    if (trim((string) ($in['total_budget'] ?? '')) !== '' && ($total === null || $total <= 0)) {
        $errors[] = 'err_total_budget';
    }
    if ($daily !== null && $total !== null && $daily > $total) {
        $errors[] = 'err_daily_gt_total';
    }
    $parseDate = static function (mixed $v): ?string {
        $v = trim((string) $v);
        $d = DateTime::createFromFormat('!Y-m-d', $v);

        return ($d !== false && $d->format('Y-m-d') === $v) ? $v : null;
    };
    $startDate = $parseDate($in['start_date'] ?? '');
    $endDate = $parseDate($in['end_date'] ?? '');
    if ($startDate !== null && $endDate !== null && $endDate < $startDate) {
        $errors[] = 'err_dates_order';
    }

    // Файли (лише після перевірки решти полів — не зберігаємо файл даремно).
    $video = null;
    $poster = [];
    $newVideo = $videoType === 'upload' && isset($files['video']) && ($files['video']['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_NO_FILE;
    if ($errors === [] && $newVideo) {
        if (!$house && !promo_rate_ok($pdo, $userId, 'video_upload')) {
            $errors[] = 'err_rate_uploads';
        } else {
            $clientDuration = isset($in['duration_client']) && is_numeric($in['duration_client']) ? (int) ceil((float) $in['duration_client']) : null;
            $video = promo_store_video($pdo, $files['video'], $clientDuration);
            if (isset($video['error'])) {
                $errors[] = $video['error'];
            } else {
                promo_rate_hit($pdo, $userId, 'video_upload');
            }
        }
    }
    if ($errors === []) {
        $poster = promo_store_poster($files['poster'] ?? null, is_string($in['poster_data'] ?? null) ? $in['poster_data'] : '');
        if (isset($poster['error'])) {
            $errors[] = $poster['error'];
        }
    }
    if ($errors !== []) {
        return ['saved' => false, 'id' => $campaignId ?: null, 'errors' => array_values(array_unique($errors)), 'submitted' => false];
    }

    $videoPath = $video['path'] ?? ($creative['video_path'] ?? null);
    $videoMime = $video['mime'] ?? ($creative['mime'] ?? null);
    $videoSize = $video['size'] ?? ($creative['size_bytes'] ?? null);
    $videoDuration = $video['duration'] ?? ($creative['duration_sec'] ?? null);
    $posterPath = $poster['path'] ?? ($creative['poster_path'] ?? null);

    // Повнота — лише для надсилання на модерацію.
    $missing = [];
    $prices = [];
    if ($submit) {
        if ($name === '') {
            $missing[] = 'err_name_required';
        }
        if ($model === null && !$house) {
            $missing[] = 'err_objective_required';
        }
        if ($advCategory === null && !$house) {
            $missing[] = 'err_advcat_required';
        }
        if ($videoType === 'upload' && !$videoPath) {
            $missing[] = 'err_video_required';
        }
        if ($videoType === 'youtube' && !$youtubeId) {
            $missing[] = 'err_youtube';
        }
        if ($title === '') {
            $missing[] = 'err_title_required';
        }
        if ($destination === '') {
            $missing[] = 'err_url_required';
        }
        if ($placements === []) {
            $missing[] = 'err_placements_required';
        }
        if (!$allCats && $cats === [] && $subs === []) {
            $missing[] = 'err_audience_required';
        }
        if ($total === null && !$house) {
            $missing[] = 'err_total_budget';
        }
        if ($startDate === null) {
            $missing[] = 'err_start_required';
        } elseif ($startDate < promo_today()) {
            $missing[] = 'err_start_past';
        }
        if (empty($in['agree']) && !$house) {
            $missing[] = 'err_agree_required';
        }
        if ($model !== null && !$house) {
            $card = promo_rate_card($pdo);
            foreach ($placements as $pl) {
                if (empty($card[$pl][$model])) {
                    $missing[] = 'err_no_price';
                    break;
                }
                $prices[$pl] = (int) $card[$pl][$model];
            }
        }
    }
    // Власна реклама сайту (is_house = campaign_type 'internal'): без білінгу, адмін
    // запускає її сам — «надіслати» одразу робить кампанію активною, креатив схваленим.
    $doSubmit = $submit && $missing === [];
    $campaignStatus = $doSubmit ? ($house ? 'active' : 'pending_review') : 'draft';
    $creativeStatus = $doSubmit ? ($house ? 'approved' : 'pending') : 'draft';
    if ($name === '') {
        $name = promo_tr('default_campaign_name', date('d.m.Y'));
    }

    $user = $pdo->prepare('SELECT name, email FROM users WHERE id = :u');
    $user->execute([':u' => $userId]);
    $owner = $user->fetch() ?: ['name' => '', 'email' => ''];

    $pdo->beginTransaction();
    try {
        $fields = [
            ':name' => $name,
            ':objective' => $objective,
            ':model' => $model,
            ':unit' => $doSubmit && $prices !== [] ? max($prices) : null,
            ':daily' => $daily,
            ':total' => $total,
            ':start' => $startDate,
            ':end' => $endDate,
            ':status' => $campaignStatus,
            ':advcat' => $advCategory,
            ':cur' => PROMO_CURRENCY,
        ];
        if ($campaign === null) {
            $pdo->prepare(
                "INSERT INTO ad_campaigns (campaign_type, format, user_id, name, advertiser_name, contact_email, objective,
                     pricing_model, unit_price, daily_budget, total_budget, start_date, end_date, status, submitted_at, rules_accepted_at,
                     advertiser_category, currency)
                 VALUES (:ctype, 'video', :uid, :name, :adv, :email, :objective, :model, :unit, :daily, :total, :start, :end,
                     :status, :sub_at, :rules_at, :advcat, :cur)"
            )->execute($fields + [
                ':ctype' => $house ? 'internal' : 'paid',
                ':uid' => $userId,
                ':adv' => $house ? 'AI LAB HUB' : (mb_substr((string) $owner['name'], 0, 255) ?: ('user #' . $userId)),
                ':email' => $owner['email'],
                ':sub_at' => $doSubmit ? promo_utc_now() : null,
                ':rules_at' => $doSubmit ? promo_utc_now() : null,
            ]);
            $campaignId = (int) $pdo->lastInsertId();
            promo_rate_hit($pdo, $userId, 'campaign_create');
        } else {
            $pdo->prepare(
                'UPDATE ad_campaigns SET name = :name, objective = :objective, pricing_model = :model, unit_price = :unit,
                     daily_budget = :daily, total_budget = :total, start_date = :start, end_date = :end, status = :status,
                     advertiser_category = :advcat, currency = :cur, rejection_reason = NULL, stop_reason = NULL,
                     submitted_at = IF(:sub = 1, NOW(), submitted_at), rules_accepted_at = IF(:sub2 = 1, NOW(), rules_accepted_at)
                 WHERE id = :id AND user_id = :uid'
            )->execute($fields + [':sub' => $doSubmit ? 1 : 0, ':sub2' => $doSubmit ? 1 : 0, ':id' => $campaignId, ':uid' => $userId]);
        }

        $crFields = [
            ':title' => $title,
            ':desc' => $description,
            ':cta' => $cta,
            ':dest' => $destination,
            ':vtype' => $videoType,
            ':vpath' => $videoType === 'upload' ? $videoPath : null,
            ':vurl' => $videoType === 'youtube' ? $youtubeUrl : null,
            ':yt' => $videoType === 'youtube' ? $youtubeId : null,
            ':poster' => $posterPath,
            ':dur' => $videoType === 'upload' ? $videoDuration : null,
            ':size' => $videoType === 'upload' ? $videoSize : null,
            ':mime' => $videoType === 'upload' ? $videoMime : null,
            ':status' => $creativeStatus,
            ':rby' => $doSubmit && $house ? $userId : null,
            ':rat' => $doSubmit && $house ? promo_utc_now() : null,
        ];
        $creativeId = $creative !== null ? (int) $creative['id'] : 0;
        if ($creative === null) {
            $pdo->prepare(
                'INSERT INTO ad_creatives (campaign_id, title, description, cta_key, destination_url, video_type, video_path,
                     video_url, youtube_id, poster_path, duration_sec, size_bytes, mime, status, reviewed_by, reviewed_at)
                 VALUES (:cid, :title, :desc, :cta, :dest, :vtype, :vpath, :vurl, :yt, :poster, :dur, :size, :mime, :status, :rby, :rat)'
            )->execute($crFields + [':cid' => $campaignId]);
            $creativeId = (int) $pdo->lastInsertId();
        } else {
            $pdo->prepare(
                'UPDATE ad_creatives SET title = :title, description = :desc, cta_key = :cta, destination_url = :dest,
                     video_type = :vtype, video_path = :vpath, video_url = :vurl, youtube_id = :yt, poster_path = :poster,
                     duration_sec = :dur, size_bytes = :size, mime = :mime, status = :status,
                     rejection_reason = NULL, reviewed_by = :rby, reviewed_at = :rat
                 WHERE id = :id'
            )->execute($crFields + [':id' => (int) $creative['id']]);
        }

        // Таргетинг: рядок на розміщення × (усі | кожна категорія | кожна підкатегорія).
        $pdo->prepare('DELETE FROM ad_targets WHERE campaign_id = :c')->execute([':c' => $campaignId]);
        $combos = [];
        if ($allCats || ($cats === [] && $subs === [])) {
            $combos[] = [null, null];
        }
        foreach ($cats as $cid) {
            $combos[] = [$cid, null];
        }
        foreach ($subs as $sid) {
            $combos[] = [$subParent[$sid], $sid];
        }
        $ins = $pdo->prepare(
            'INSERT INTO ad_targets (campaign_id, placement, category_id, subcategory_id, language, device, unit_price)
             VALUES (:c, :pl, :cat, :sub, :lang, :dev, :price)'
        );
        foreach ($placements as $pl) {
            foreach ($combos as [$cid, $sid]) {
                $ins->execute([
                    ':c' => $campaignId, ':pl' => $pl, ':cat' => $cid, ':sub' => $sid,
                    ':lang' => $language, ':dev' => $device, ':price' => $prices[$pl] ?? null,
                ]);
            }
        }
        $pdo->commit();
    } catch (Throwable $e) {
        $pdo->rollBack();
        error_log('[promo] save campaign: ' . $e->getMessage());

        return ['saved' => false, 'id' => $campaign !== null ? $campaignId : null, 'errors' => ['err_generic'], 'submitted' => false];
    }

    if ($doSubmit && !$house) {
        promo_event_notify($pdo, 'creative_pending', ['campaign_id' => $campaignId]);
    }

    // Перевірка адреси переходу (блок G): при надсиланні на модерацію й при кожній зміні адреси.
    $urlChanged = $destination !== '' && $destination !== (string) ($creative['destination_url'] ?? '');
    if ($creativeId > 0 && $destination !== '' && ($doSubmit || $urlChanged)) {
        try {
            $check = promo_linkcheck_creative($pdo, $creativeId, true);
            promo_log_event($pdo, 'link_check', $creativeId, $campaignId, $check['status'] . ': ' . implode(', ', $check['flags']), $userId);
        } catch (Throwable $e) {
            error_log('[promo] link check: ' . $e->getMessage());
        }
    }

    return ['saved' => true, 'id' => $campaignId, 'errors' => array_values(array_unique($missing)), 'submitted' => $doSubmit];
}

// --- Дії зі списку кампаній ------------------------------------------------

/** pause / resume / complete / duplicate. Повертає [ok, ключ повідомлення, id]. */
function promo_campaign_action(PDO $pdo, int $userId, int $campaignId, string $action): array
{
    $c = promo_owned_campaign($pdo, $userId, $campaignId);
    if ($c === null) {
        return [false, 'err_not_found', null];
    }

    switch ($action) {
        case 'pause':
            if ($c['status'] !== 'active') {
                return [false, 'err_action_status', null];
            }
            $pdo->prepare("UPDATE ad_campaigns SET status = 'paused', stop_reason = 'user' WHERE id = :id")->execute([':id' => $campaignId]);

            return [true, 'ok_paused', $campaignId];

        case 'resume':
            $cr = promo_campaign_creative($pdo, $campaignId);
            if ($c['status'] !== 'paused' || $cr === null || $cr['status'] !== 'approved') {
                return [false, 'err_action_status', null];
            }
            if ($c['stop_reason'] === 'budget' || ($c['total_budget'] !== null && (int) $c['spent'] >= (int) $c['total_budget'])) {
                return [false, 'err_budget_spent', null];
            }
            if ($c['campaign_type'] !== 'internal' && promo_balance($pdo, $userId) <= 0) {
                return [false, 'err_balance_empty', null];
            }
            $pdo->prepare("UPDATE ad_campaigns SET status = 'active', stop_reason = NULL WHERE id = :id")->execute([':id' => $campaignId]);

            return [true, 'ok_resumed', $campaignId];

        case 'complete':
            if ($c['status'] === 'completed') {
                return [false, 'err_action_status', null];
            }
            $pdo->prepare("UPDATE ad_campaigns SET status = 'completed', stop_reason = 'user' WHERE id = :id")->execute([':id' => $campaignId]);

            return [true, 'ok_completed', $campaignId];

        case 'duplicate':
            if (!promo_rate_ok($pdo, $userId, 'campaign_create')) {
                return [false, 'err_rate_campaigns', null];
            }
            $pdo->beginTransaction();
            try {
                $pdo->prepare(
                    "INSERT INTO ad_campaigns (campaign_type, format, user_id, name, advertiser_name, contact_email, objective,
                         pricing_model, daily_budget, total_budget, status, advertiser_category)
                     SELECT campaign_type, 'video', user_id, LEFT(CONCAT(COALESCE(name, ''), :suffix), 120), advertiser_name, contact_email,
                         objective, pricing_model, daily_budget, total_budget, 'draft', advertiser_category
                     FROM ad_campaigns WHERE id = :id AND user_id = :u"
                )->execute([':suffix' => ' ' . promo_tr('copy_suffix'), ':id' => $campaignId, ':u' => $userId]);
                $newId = (int) $pdo->lastInsertId();
                $pdo->prepare(
                    "INSERT INTO ad_creatives (campaign_id, title, description, cta_key, destination_url, video_type, video_path,
                         video_url, youtube_id, poster_path, duration_sec, size_bytes, mime, status)
                     SELECT :new, title, description, cta_key, destination_url, video_type, video_path, video_url, youtube_id,
                         poster_path, duration_sec, size_bytes, mime, 'draft'
                     FROM ad_creatives WHERE campaign_id = :id ORDER BY id LIMIT 1"
                )->execute([':new' => $newId, ':id' => $campaignId]);
                $pdo->prepare(
                    'INSERT INTO ad_targets (campaign_id, placement, category_id, subcategory_id, language, device)
                     SELECT :new, placement, category_id, subcategory_id, language, device FROM ad_targets WHERE campaign_id = :id'
                )->execute([':new' => $newId, ':id' => $campaignId]);
                promo_rate_hit($pdo, $userId, 'campaign_create');
                $pdo->commit();
            } catch (Throwable $e) {
                $pdo->rollBack();
                error_log('[promo] duplicate: ' . $e->getMessage());

                return [false, 'err_generic', null];
            }

            return [true, 'ok_duplicated', $newId];
    }

    return [false, 'err_generic', null];
}

// --- Поповнення ------------------------------------------------------------

/** Заявка на поповнення. Повертає [ok, ключ, дані заявки]. */
function promo_request_topup(PDO $pdo, int $userId, mixed $amountInput): array
{
    if (promo_payment_instructions($pdo) === '' && promo_payment_jar_url($pdo) === '') {
        return [false, 'err_topup_unavailable', null];
    }
    $amount = promo_parse_money($amountInput);
    $min = promo_parse_money(promo_setting($pdo, 'min_topup', '')) ?? 0;
    if ($amount === null || $amount <= 0 || $amount > 100000000) {
        return [false, 'err_topup_amount', null];
    }
    if ($min > 0 && $amount < $min) {
        return [false, 'err_topup_min', null];
    }
    if (!promo_rate_ok($pdo, $userId, 'topup_request')) {
        return [false, 'err_rate_topups', null];
    }
    $request = promo_payment_provider()->createTopup($pdo, $userId, $amount, PROMO_CURRENCY);
    promo_rate_hit($pdo, $userId, 'topup_request');
    promo_event_notify($pdo, 'topup_requested', ['user_id' => $userId, 'tx_id' => (int) ($request['id'] ?? 0), 'amount' => $amount]);

    return [true, 'ok_topup_created', $request + ['amount' => $amount]];
}

/**
 * Посилання на банку (monobank) для оплати реклами — окреме від банки донатів.
 * Значення лише в ad_settings (вводить адмін), не в коді.
 */
function promo_payment_jar_url(PDO $pdo): string
{
    $url = trim(promo_setting($pdo, 'payment_jar_url', ''));

    return preg_match('~^https://[^\s<>"\']+$~i', $url) ? $url : '';
}

/** Текст реквізитів мовою інтерфейсу (з запасним українським). */
function promo_payment_instructions(PDO $pdo): string
{
    $lang = promo_lang();
    $txt = trim(promo_setting($pdo, 'payment_instructions_' . $lang, ''));

    return $txt !== '' ? $txt : trim(promo_setting($pdo, 'payment_instructions_uk', ''));
}

// --- Статистика ------------------------------------------------------------

/** Підсумки за кампаніями користувача: [campaign_id => impressions, views, clicks, spend]. */
function promo_campaign_totals(PDO $pdo, int $userId): array
{
    $st = $pdo->prepare(
        "SELECT s.campaign_id, SUM(s.impressions) impressions, SUM(s.views) views, SUM(s.clicks) clicks, SUM(s.spend) spend
         FROM ad_stats_daily s JOIN ad_campaigns c ON c.id = s.campaign_id
         WHERE c.user_id = :u AND c.format = 'video' AND c.campaign_type = 'paid'
         GROUP BY s.campaign_id"
    );
    $st->execute([':u' => $userId]);
    $out = [];
    foreach ($st->fetchAll() as $r) {
        $out[(int) $r['campaign_id']] = $r;
    }

    return $out;
}

/**
 * Рядки статистики користувача за період (лише власні кампанії).
 * $group: day | placement | day_campaign_placement (для CSV).
 */
function promo_stats_rows(PDO $pdo, int $userId, ?int $campaignId, string $from, string $to, string $group): array
{
    $select = match ($group) {
        'placement' => 's.placement AS k',
        'day_campaign_placement' => 's.stat_date AS d, s.campaign_id, c.name, s.placement',
        default => 's.stat_date AS k',
    };
    $groupBy = match ($group) {
        'placement' => 's.placement',
        'day_campaign_placement' => 's.stat_date, s.campaign_id, c.name, s.placement',
        default => 's.stat_date',
    };
    $sql = "SELECT {$select}, SUM(s.impressions) impressions, SUM(s.views) views, SUM(s.clicks) clicks, SUM(s.spend) spend
            FROM ad_stats_daily s JOIN ad_campaigns c ON c.id = s.campaign_id
            WHERE c.user_id = :u AND c.format = 'video' AND s.stat_date BETWEEN :f AND :t"
        . ($campaignId ? ' AND s.campaign_id = :c' : '')
        . " GROUP BY {$groupBy} ORDER BY " . ($group === 'placement' ? 'impressions DESC' : '1');
    $params = [':u' => $userId, ':f' => $from, ':t' => $to];
    if ($campaignId) {
        $params[':c'] = $campaignId;
    }
    $st = $pdo->prepare($sql);
    $st->execute($params);

    return $st->fetchAll();
}

function promo_ctr(int|string $clicks, int|string $impressions): string
{
    return (int) $impressions > 0 ? number_format((int) $clicks / (int) $impressions * 100, 2, ',', '') . '%' : '—';
}
