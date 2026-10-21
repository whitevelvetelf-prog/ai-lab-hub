<?php

declare(strict_types=1);

/**
 * AI LAB HUB — система відеореклами (promo): налаштування, підпис токенів,
 * відбір креативу, облік подій і атомарне списання.
 *
 * Схема — database/migration-2026-10-11-promo-video.sql (ad_campaigns з
 * format='video', ad_creatives, ad_targets, ad_events, ad_stats_daily,
 * ad_balances, ad_transactions, ad_rate_card, ad_settings, ad_reports).
 *
 * Назви файлів і CSS-класів — нейтральні (promo / sponsored): шляхи з «ad»
 * блокуються розширеннями-блокувальниками реклами.
 *
 * Гроші — цілі копійки. CPM: ціна за 1000 показів, тож один показ коштує
 * unit_price/1000 копійки; частки накопичуються в ad_campaigns.cpm_accrual
 * (тисячні копійки) і списуються цілою копійкою, щойно набирається.
 *
 * Підключати після app/auth.php (потрібна сесія для session_hash):
 *   require_once __DIR__ . '/../app/auth.php';
 *   require_once __DIR__ . '/../app/promo.php';
 */

require_once __DIR__ . '/analytics.php';
require_once __DIR__ . '/promo-exclusions.php';
require_once __DIR__ . '/promo-placements.php';
require_once __DIR__ . '/promo-select.php';

/** Валюта прайсу, балансів і списань (з 2026-10-17; раніше UAH). Суми — центи. */
const PROMO_CURRENCY = 'USD';
/** Місця показу (ad_placements, app/promo-placements.php); старі ключі — PROMO_LEGACY_PLACEMENTS. */
const PROMO_PLACEMENTS = ['category_page', 'subcategory_list', 'search_results', 'product_page', 'blog_list', 'blog_article',
    'marketplace_home', 'marketplace_feed', 'marketplace_category', 'marketplace_search', 'marketplace_listing_page', 'popup'];

/** Баланс в іншій валюті, ніж операція (повідомлення — код валюти балансу). */
final class PromoCurrencyMismatch extends RuntimeException
{
}
const PROMO_CTA_KEYS = ['learn_more', 'try', 'go', 'download'];
const PROMO_REPORT_REASONS = ['misleading', 'inappropriate', 'scam', 'irrelevant', 'other'];

/** Скільки живе токен показу (сек): події з давнішим токеном не рахуються. */
const PROMO_TOKEN_TTL = 7200;
/** Повторний клік того ж сеансу по тому ж креативу протягом цього часу (сек) не рахується. */
const PROMO_CLICK_DEDUP_SEC = 1800;
/** Ліміт подій від одного сеансу за хвилину. */
const PROMO_EVENTS_PER_MINUTE = 30;
/** Сирі події (з 2026-10-21 — лише кліки) зберігаються стільки днів (агрегати в ad_stats_daily — назавжди). */
const PROMO_EVENTS_KEEP_DAYS = 30;

// --- Налаштування й секрети ------------------------------------------------

/**
 * Значення ad_settings (кеш на запит). Якщо таблиці ще немає (міграцію не
 * застосовано) — порожній масив, тобто система вимкнена.
 *
 * @return array<string,string>
 */
function promo_settings(PDO $pdo, bool $refresh = false): array
{
    static $cache = null;
    if ($cache !== null && !$refresh) {
        return $cache;
    }
    try {
        $rows = $pdo->query('SELECT setting_key, setting_value FROM ad_settings')->fetchAll(PDO::FETCH_KEY_PAIR);
        $cache = array_map('strval', $rows);
    } catch (Throwable $e) {
        error_log('[promo] settings: ' . $e->getMessage());
        $cache = [];
    }

    return $cache;
}

function promo_setting(PDO $pdo, string $key, string $default = ''): string
{
    return promo_settings($pdo)[$key] ?? $default;
}

/**
 * Глобальний перемикач реклами (ad_settings.enabled). Вимикає ВСЮ рекламу на
 * сайті — і відеорекламу, і старі банери (app/ads.php). За замовчуванням 0.
 */
function promo_enabled(PDO $pdo): bool
{
    return promo_setting($pdo, 'enabled', '0') === '1';
}

/** @return array{secret:string,cron_key:string} */
function promo_config(): array
{
    static $cfg = null;
    if ($cfg === null) {
        $file = __DIR__ . '/../config/promo.php';
        $raw = is_file($file) ? require $file : [];
        $cfg = [
            'secret'   => is_array($raw) ? (string) ($raw['secret'] ?? '') : '',
            'cron_key' => is_array($raw) ? (string) ($raw['cron_key'] ?? '') : '',
        ];
    }

    return $cfg;
}

/** Відеореклама може працювати: перемикач увімкнено й секрет токенів задано. */
function promo_video_ready(PDO $pdo): bool
{
    return promo_enabled($pdo) && strlen(promo_config()['secret']) >= 32;
}

// --- Час: UTC у БД, «доба» — за Києвом ------------------------------------

/**
 * Часовий пояс, за яким рахуються «доба» (денний бюджет, stat_date, звіти).
 * Час подій у БД — UTC: promo-ендпоінти й cron перемикають сесію MySQL на UTC
 * (promo_db_utc), а дати доби передаються параметром (promo_today), а не CURDATE().
 */
function promo_tz(): DateTimeZone
{
    static $tz = null;
    if ($tz === null) {
        try {
            $tz = new DateTimeZone('Europe/Kyiv');
        } catch (Throwable $e) {
            $tz = new DateTimeZone('Europe/Kiev'); // стара база часових поясів
        }
    }

    return $tz;
}

/** Поточна київська дата (Y-m-d) або зі зсувом у днях. */
function promo_today(int $offsetDays = 0): string
{
    $d = new DateTimeImmutable('now', promo_tz());

    return ($offsetDays !== 0 ? $d->modify(($offsetDays > 0 ? '+' : '') . $offsetDays . ' days') : $d)->format('Y-m-d');
}

/** Поточний час UTC для DATETIME-колонок. */
function promo_utc_now(): string
{
    return gmdate('Y-m-d H:i:s');
}

/** Межі київської доби в UTC: [початок, наступна північ). */
function promo_day_bounds_utc(string $kyivDate): array
{
    $start = new DateTimeImmutable($kyivDate . ' 00:00:00', promo_tz());
    $utc = new DateTimeZone('UTC');

    return [$start->setTimezone($utc)->format('Y-m-d H:i:s'), $start->modify('+1 day')->setTimezone($utc)->format('Y-m-d H:i:s')];
}

/** UTC-час з БД → київський для показу. */
function promo_local_time(?string $utc, string $format = 'Y-m-d H:i'): string
{
    if ($utc === null || $utc === '') {
        return '';
    }
    try {
        return (new DateTimeImmutable($utc, new DateTimeZone('UTC')))->setTimezone(promo_tz())->format($format);
    } catch (Throwable $e) {
        return (string) $utc;
    }
}

/**
 * Перемкнути сесію MySQL на UTC (NOW(), DEFAULT CURRENT_TIMESTAMP у DATETIME).
 * Викликають лише ендпоінти реклами й cron — інші сторінки сайту не зачіпає.
 */
function promo_db_utc(PDO $pdo): void
{
    try {
        $pdo->exec("SET time_zone = '+00:00'");
    } catch (Throwable $e) {
        error_log('[promo] time_zone: ' . $e->getMessage());
    }
}

/**
 * Подія реклами → листи в чергу (app/promo-mail.php підключається лише тоді, коли
 * подія справді сталася). Помилки не ламають основну дію.
 */
function promo_event_notify(PDO $pdo, string $event, array $data): void
{
    try {
        require_once __DIR__ . '/promo-mail.php';
        promo_notify($pdo, $event, $data);
    } catch (Throwable $e) {
        error_log('[promo] notify: ' . $e->getMessage());
    }
}

// --- Токени (HMAC) ---------------------------------------------------------

function promo_b64u_encode(string $bin): string
{
    return rtrim(strtr(base64_encode($bin), '+/', '-_'), '=');
}

function promo_b64u_decode(string $txt): string|false
{
    return base64_decode(strtr($txt, '-_', '+/'), true);
}

/** Короткий відбиток сеансу для токена (повний session_hash у токен не кладемо). */
function promo_session_tag(): string
{
    return substr(analytics_session_hash(), 0, 16);
}

/**
 * Підписаний токен показу: креатив, кампанія, розміщення, сеанс, час.
 * x=1 — адмін-перегляд: події й кліки за таким токеном не рахуються.
 *
 * @param array{c:int,k:int,p:string,x?:int} $data
 */
function promo_token_make(array $data): string
{
    $payload = promo_b64u_encode((string) json_encode([
        'c' => $data['c'],
        'k' => $data['k'],
        'p' => $data['p'],
        's' => promo_session_tag(),
        't' => time(),
    ] + (!empty($data['x']) ? ['x' => 1] : [])));
    $sig = promo_b64u_encode(hash_hmac('sha256', $payload, promo_config()['secret'], true));

    return $payload . '.' . $sig;
}

/**
 * Перевірити токен. null — підпис невірний або формат зламаний (підробка).
 * Повертає дані з прапорцями fresh (не прострочений) і own (той самий сеанс).
 *
 * @return array{c:int,k:int,p:string,s:string,t:int,fresh:bool,own:bool,preview:bool}|null
 */
function promo_token_read(string $token): ?array
{
    $secret = promo_config()['secret'];
    if (strlen($secret) < 32 || strlen($token) > 512 || substr_count($token, '.') !== 1) {
        return null;
    }
    [$payload, $sig] = explode('.', $token);
    $expected = promo_b64u_encode(hash_hmac('sha256', $payload, $secret, true));
    if (!hash_equals($expected, $sig)) {
        return null;
    }
    $json = promo_b64u_decode($payload);
    $data = $json === false ? null : json_decode($json, true);
    if (!is_array($data) || !isset($data['c'], $data['k'], $data['p'], $data['s'], $data['t'])
        || !promo_placement_valid((string) $data['p'])) {
        return null;
    }

    return [
        'c' => (int) $data['c'],
        'k' => (int) $data['k'],
        'p' => (string) $data['p'],
        's' => (string) $data['s'],
        't' => (int) $data['t'],
        'fresh' => time() - (int) $data['t'] <= PROMO_TOKEN_TTL && (int) $data['t'] <= time() + 60,
        'own' => hash_equals(promo_session_tag(), (string) $data['s']),
        'preview' => !empty($data['x']),
    ];
}

// --- Контекст відвідувача (без персональних даних) -------------------------

/** Відомі боти, сканери й прев'ю посилань — їхні покази/кліки не рахуються. */
function promo_is_bot(): bool
{
    $ua = (string) ($_SERVER['HTTP_USER_AGENT'] ?? '');
    if ($ua === '') {
        return true;
    }

    return (bool) preg_match(
        '~bot|crawl|spider|slurp|scrap|headless|lighthouse|pagespeed|preview|facebookexternalhit|embedly|whatsapp|telegram|curl|wget|python|java/|go-http|httpclient|okhttp|axios|node-fetch|monitor|uptime~i',
        $ua
    );
}

/** mobile / desktop: явний параметр сторінки, інакше — за User-Agent. */
function promo_device(?string $param = null): string
{
    if ($param === 'mobile' || $param === 'desktop') {
        return $param;
    }

    return preg_match('~Mobi|Android|iPhone|iPad|iPod~i', (string) ($_SERVER['HTTP_USER_AGENT'] ?? '')) ? 'mobile' : 'desktop';
}

function promo_lang(?string $param = null): string
{
    if ($param === 'uk' || $param === 'en') {
        return $param;
    }

    return function_exists('current_lang') && current_lang() === 'en' ? 'en' : 'uk';
}

// --- Відбір креативу -------------------------------------------------------

/**
 * Один креатив для слота або null — перший із promo_pick_set (app/promo-select.php):
 * кешований індексований список кандидатів, фільтри сеансу й зважений вибір у PHP.
 * Платні кампанії мають пріоритет над власною рекламою сайту.
 *
 * @param list<int> $categoryIds
 * @param list<int> $subcategoryIds
 * @param list<int> $excludeCreatives
 */
function promo_pick(PDO $pdo, string $placement, array $categoryIds, array $subcategoryIds, string $lang, string $device, string $sessionHash, array $page = [], array $excludeCreatives = []): ?array
{
    return promo_pick_set($pdo, $placement, $categoryIds, $subcategoryIds, $lang, $device, $sessionHash, $page, $excludeCreatives, 1)[0] ?? null;
}

/** Публічні дані креативу для промальовування (JSON для sponsored.js). $preview — адмін-перегляд без обліку. */
function promo_public_payload(array $creative, string $placement, bool $preview = false, ?PDO $pdo = null): array
{
    if (($creative['creative_type'] ?? 'video') === 'card') {
        return promo_card_payload($creative, $placement, $preview, $pdo);
    }
    $isImage = ($creative['creative_type'] ?? 'video') === 'image';
    $isUpload = $creative['video_type'] === 'upload';

    return [
        'house'       => ($creative['campaign_type'] ?? '') === 'internal',
        'id'          => (int) $creative['id'],
        'token'       => promo_token_make(['c' => (int) $creative['id'], 'k' => (int) $creative['campaign_id'], 'p' => $placement, 'x' => $preview ? 1 : 0]),
        'preview'     => $preview,
        'placement'   => $placement,
        'title'       => promo_creative_text($pdo, $creative, 'title'),
        'description' => promo_creative_text($pdo, $creative, 'description'),
        'cta'         => promo_cta_label($creative),
        'type'        => $isImage ? 'image' : ($isUpload ? 'upload' : 'youtube'),
        'video'       => !$isImage && $isUpload && $creative['video_path'] ? '/' . ltrim((string) $creative['video_path'], '/') : null,
        'youtube'     => !$isImage && !$isUpload ? (string) $creative['youtube_id'] : null,
        'poster'      => $creative['poster_path'] ? '/' . ltrim((string) $creative['poster_path'], '/') : null,
    ];
}

/**
 * Заголовок / підпис креативу мовою інтерфейсу. Текст живе в БД (ad_creatives), у
 * зображенні чи відео його немає. Не мова оригіналу: ручний переклад (*_en), інакше —
 * система перекладу сайту (cached_translation → ad_creative_translations, автопереклад
 * кешується; manual-рядки не перезаписуються). Без таблиці чи ключа — оригінал.
 */
function promo_creative_text(?PDO $pdo, array $creative, string $field): string
{
    $source = (string) ($creative[$field] ?? '');
    $lang = function_exists('current_lang') ? current_lang() : 'uk';
    if ($pdo === null || trim($source) === '' || !function_exists('translation_source_lang') || $lang === translation_source_lang()) {
        return $source;
    }
    $manual = trim((string) ($creative[$field . '_en'] ?? ''));
    if ($lang === 'en' && $manual !== '') {
        return $manual;
    }
    try {
        return cached_translation($pdo, 'ad_creative_translations', ['creative_id' => (int) $creative['id'], 'field_name' => $field], $lang, $source);
    } catch (Throwable $e) {
        error_log('[promo] creative translation: ' . $e->getMessage());

        return $source;
    }
}

/** Написи картки мовою інтерфейсу. */
function promo_labels(): array
{
    $reasons = [];
    foreach (PROMO_REPORT_REASONS as $r) {
        $reasons[$r] = t('promo_reason_' . $r);
    }

    return [
        'label'        => t('ad_label'),
        'soundOn'      => t('promo_sound_on'),
        'soundOff'     => t('promo_sound_off'),
        'play'         => t('promo_play'),
        'report'       => t('promo_report'),
        'reportSend'   => t('promo_report_send'),
        'reportCancel' => t('promo_report_cancel'),
        'reportThanks' => t('promo_report_thanks'),
        'reasons'      => $reasons,
    ];
}

// --- Облік подій і списання ------------------------------------------------

/**
 * Записати подію (impression / view / click / skip — «Пропустити» у спливаючому вікні) з перевірками на дублі та частоту,
 * оновити ad_stats_daily і списати кошти. true — подію зараховано.
 *
 * Покази й перегляди НЕ пишуться сирими рядками (таблиця росла б безмежно): дублі,
 * частота й ліміт показів кампанії — у стані сеансу (promo_session_event), у БД —
 * лише агрегат ad_stats_daily (INSERT … ON DUPLICATE KEY UPDATE у promo_charge).
 * Правила: impression — не частіше раза на 10 с для пари сеанс+креатив; view — лише
 * для upload-відео й лише після зарахованого показу цьому сеансу. Кліки, як і раніше,
 * пишуться в ad_events (захист від накрутки): повтор того ж сеансу протягом
 * PROMO_CLICK_DEDUP_SEC не рахується. Понад PROMO_EVENTS_PER_MINUTE подій сеансу за хвилину — ігнор.
 */
function promo_record_event(PDO $pdo, int $creativeId, string $type, string $placement, string $sessionHash): bool
{
    if (!in_array($type, ['impression', 'view', 'click', 'skip'], true) || !promo_placement_valid($placement)) {
        return false;
    }

    $cr = $pdo->prepare('SELECT cr.id, cr.campaign_id, cr.video_type FROM ad_creatives cr WHERE cr.id = :id');
    $cr->execute([':id' => $creativeId]);
    $creative = $cr->fetch();
    if ($creative === false || ($type === 'view' && $creative['video_type'] !== 'upload')) {
        return false;
    }
    $campaignId = (int) $creative['campaign_id'];

    if ($type !== 'click') {
        if (!promo_session_event($sessionHash, $creativeId, $campaignId, $type, 10)) {
            return false;
        }
        promo_charge($pdo, $campaignId, $type, $placement, $creativeId);

        return true;
    }

    $rate = $pdo->prepare('SELECT COUNT(*) FROM ad_events WHERE session_hash = :sh AND created_at >= NOW() - INTERVAL 1 MINUTE');
    $rate->execute([':sh' => $sessionHash]);
    if ((int) $rate->fetchColumn() >= PROMO_EVENTS_PER_MINUTE) {
        return false;
    }
    $dup = $pdo->prepare(
        "SELECT COUNT(*) FROM ad_events
         WHERE session_hash = :sh AND creative_id = :cr AND type = 'click'
           AND created_at >= NOW() - INTERVAL " . PROMO_CLICK_DEDUP_SEC . ' SECOND'
    );
    $dup->execute([':sh' => $sessionHash, ':cr' => $creativeId]);
    if ((int) $dup->fetchColumn() > 0) {
        return false;
    }

    $pdo->prepare(
        'INSERT INTO ad_events (creative_id, campaign_id, type, placement, session_hash)
         VALUES (:cr, :c, :type, :pl, :sh)'
    )->execute([':cr' => $creativeId, ':c' => $campaignId, ':type' => $type, ':pl' => $placement, ':sh' => $sessionHash]);

    promo_charge($pdo, $campaignId, $type, $placement, $creativeId);

    return true;
}

/**
 * Атомарне списання за подію й оновлення ad_stats_daily (у тій самій
 * транзакції). Повертає списану суму (копійки).
 *
 * Транзакція з SELECT ... FOR UPDATE на рядку кампанії, потім балансу (завжди
 * в цьому порядку — без дедлоків): паралельні запити по одній кампанії
 * виконуються строго по черзі, тож бюджет і баланс не перевитрачаються.
 * Сума обрізається до найменшого із залишків (загальний бюджет, денний,
 * баланс). Витрачене «сьогодні» рахується з ad_stats_daily за поточну
 * київську добу (окремого «скидання» денного бюджету немає). Вичерпано загальний бюджет → completed; баланс → paused
 * (stop_reason показується рекламодавцю). Денний ліміт лише виключає
 * кампанію з показу до кінця дня (promo_pick).
 *
 * Журнал: один агрегований рядок ad_transactions (type=spend) на кампанію на
 * день, reference = spend:<id>:<дата>; amount — від'ємна сума за день.
 *
 * Ціна — знімок для розміщення події (ad_targets.unit_price; рядок зі старим ключем
 * місця теж підходить), інакше ad_campaigns.unit_price.
 */
function promo_charge(PDO $pdo, int $campaignId, string $type, ?string $placement = null, ?int $creativeId = null): int
{
    $today = promo_today();
    $col = ['impression' => 'impressions', 'view' => 'views', 'click' => 'clicks', 'skip' => 'skips'][$type] ?? null;
    $addStats = static function (int $amount) use ($pdo, $today, $col, $campaignId, $creativeId, $placement): void {
        if ($col === null || $creativeId === null || $placement === null) {
            return;
        }
        $pdo->prepare(
            "INSERT INTO ad_stats_daily (stat_date, campaign_id, creative_id, placement, {$col}, spend)
             VALUES (:d, :c, :cr, :pl, 1, :sp)
             ON DUPLICATE KEY UPDATE {$col} = {$col} + 1, spend = spend + VALUES(spend)"
        )->execute([':d' => $today, ':c' => $campaignId, ':cr' => $creativeId, ':pl' => $placement, ':sp' => $amount]);
    };

    $ownTx = !$pdo->inTransaction();
    if ($ownTx) {
        $pdo->beginTransaction();
    }
    try {
        $st = $pdo->prepare('SELECT * FROM ad_campaigns WHERE id = :id FOR UPDATE');
        $st->execute([':id' => $campaignId]);
        $c = $st->fetch();

        $billable = $c !== false
            && $c['format'] === 'video'
            && $c['campaign_type'] !== 'internal'
            && $c['status'] === 'active'
            && $c['user_id'] !== null
            && (int) $c['unit_price'] > 0;
        $isCpm = $billable && $c['pricing_model'] === 'cpm' && $type === 'impression';
        $isCpc = $billable && $c['pricing_model'] === 'cpc' && $type === 'click';
        if (!$isCpm && !$isCpc) {
            $addStats(0);
            if ($ownTx) {
                $pdo->commit();
            }

            return 0;
        }

        $price = (int) $c['unit_price'];
        if ($placement !== null) {
            $keys = promo_placement_match_keys($placement);
            $pp = $pdo->prepare('SELECT MAX(unit_price) FROM ad_targets WHERE campaign_id = ? AND placement IN (' . implode(',', array_fill(0, count($keys), '?')) . ')');
            $pp->execute(array_merge([$campaignId], $keys));
            $placementPrice = (int) ($pp->fetchColumn() ?: 0);
            if ($placementPrice > 0) {
                $price = $placementPrice;
            }
        }

        $accrual = (int) $c['cpm_accrual'];
        if ($isCpm) {
            $acc = $accrual + $price;
            $amount = intdiv($acc, 1000);
            $accrual = $acc % 1000;
        } else {
            $amount = $price;
        }

        $bal = $pdo->prepare('SELECT balance, currency FROM ad_balances WHERE user_id = :u FOR UPDATE');
        $bal->execute([':u' => $c['user_id']]);
        $balRow = $bal->fetch();
        // Баланс в іншій валюті, ніж ціна кампанії, не списується.
        $balance = $balRow !== false && $balRow['currency'] === $c['currency'] ? (int) $balRow['balance'] : 0;

        $sd = $pdo->prepare('SELECT COALESCE(SUM(spend), 0) FROM ad_stats_daily WHERE campaign_id = :c AND stat_date = :d');
        $sd->execute([':c' => $campaignId, ':d' => $today]);
        $spentToday = (int) $sd->fetchColumn();
        $limits = [$amount, max(0, $balance)];
        if ($c['total_budget'] !== null) {
            $limits[] = max(0, (int) $c['total_budget'] - (int) $c['spent']);
        }
        if ($c['daily_budget'] !== null) {
            $limits[] = max(0, (int) $c['daily_budget'] - $spentToday);
        }
        $amount = min($limits);

        $newSpent = (int) $c['spent'] + $amount;
        $newBalance = $balance - $amount;
        $status = 'active';
        $stopReason = null;
        if ($c['total_budget'] !== null && $newSpent >= (int) $c['total_budget']) {
            $status = 'completed';
            $stopReason = 'budget';
        } elseif ($newBalance <= 0) {
            $status = 'paused';
            $stopReason = 'balance';
        }

        $pdo->prepare(
            'UPDATE ad_campaigns
             SET spent = :spent, spent_today = :today_spent, spent_today_date = :today,
                 cpm_accrual = :acc, status = :status, stop_reason = COALESCE(:reason, stop_reason)
             WHERE id = :id'
        )->execute([
            ':spent' => $newSpent,
            ':today_spent' => $spentToday + $amount,
            ':today' => $today,
            ':acc' => $accrual,
            ':status' => $status,
            ':reason' => $stopReason,
            ':id' => $campaignId,
        ]);

        $addStats($amount);

        if ($amount > 0) {
            $pdo->prepare('UPDATE ad_balances SET balance = balance - :a WHERE user_id = :u')
                ->execute([':a' => $amount, ':u' => $c['user_id']]);

            $ref = 'spend:' . $campaignId . ':' . $today;
            $upd = $pdo->prepare(
                "UPDATE ad_transactions SET amount = amount - :a
                 WHERE user_id = :u AND type = 'spend' AND reference = :ref"
            );
            $upd->execute([':a' => $amount, ':u' => $c['user_id'], ':ref' => $ref]);
            if ($upd->rowCount() === 0) {
                $pdo->prepare(
                    "INSERT INTO ad_transactions (user_id, campaign_id, type, amount, currency, status, method, reference, note, confirmed_at)
                     VALUES (:u, :c, 'spend', :a, :cur, 'confirmed', 'manual', :ref, :note, :now)"
                )->execute([
                    ':u' => $c['user_id'],
                    ':c' => $campaignId,
                    ':a' => -$amount,
                    ':cur' => $c['currency'],
                    ':ref' => $ref,
                    ':note' => 'Витрати кампанії за ' . $today,
                    ':now' => promo_utc_now(),
                ]);
            }
        }

        if ($ownTx) {
            $pdo->commit();
        }
        // Кампанія вибула з показу (зупинена чи вичерпано денний бюджет) — кеш кандидатів застарів.
        if ($status !== 'active' || ($c['daily_budget'] !== null && $spentToday + $amount >= (int) $c['daily_budget'])) {
            promo_cache_flush();
        }
        // Система зупинила кампанію (кошти чи бюджет) — лист рекламодавцю.
        if ($ownTx && $status !== 'active') {
            promo_event_notify($pdo, $status === 'completed' ? 'campaign_completed' : 'campaign_paused_system',
                ['campaign_id' => $campaignId, 'reason_key' => (string) $stopReason]);
        }

        return $amount;
    } catch (Throwable $e) {
        if ($ownTx && $pdo->inTransaction()) {
            $pdo->rollBack();
        }
        error_log('[promo] charge: ' . $e->getMessage());

        return 0;
    }
}

// --- Обслуговування --------------------------------------------------------

/**
 * Cron: завершити кампанії з минулою датою завершення й видалити сирі події,
 * старші за PROMO_EVENTS_KEEP_DAYS (агрегати в ad_stats_daily оновлюються в
 * момент події, тож нічого не втрачається).
 *
 * @return array{completed:int,purged:int}
 */
function promo_maintenance(PDO $pdo): array
{
    $ids = $pdo->prepare(
        "SELECT id FROM ad_campaigns
         WHERE format = 'video' AND status IN ('active', 'paused') AND end_date IS NOT NULL AND end_date < :today"
    );
    $ids->execute([':today' => promo_today()]);
    $completed = 0;
    foreach ($ids->fetchAll(PDO::FETCH_COLUMN) as $id) {
        $st = $pdo->prepare("UPDATE ad_campaigns SET status = 'completed', stop_reason = 'end_date' WHERE id = :id AND status IN ('active', 'paused')");
        $st->execute([':id' => $id]);
        if ($st->rowCount() > 0) {
            $completed++;
            promo_event_notify($pdo, 'campaign_completed', ['campaign_id' => (int) $id, 'reason_key' => 'end_date']);
        }
    }
    if ($completed > 0) {
        promo_cache_flush();
    }
    promo_cache_gc();
    $purge = $pdo->prepare('DELETE FROM ad_events WHERE created_at < :before');
    $purge->execute([':before' => gmdate('Y-m-d H:i:s', time() - PROMO_EVENTS_KEEP_DAYS * 86400)]);

    return ['completed' => $completed, 'purged' => $purge->rowCount()];
}

// --- Розмітка слота --------------------------------------------------------

/**
 * Порожній слот, який sponsored.js заповнює креативом із promo-serve.php.
 * Слот прихований (display:none) доки немає реклами — порожнього місця не лишається.
 * Нічого не виводить, якщо система вимкнена, місце вимкнене/недоступне, сторінку
 * виключено (no_promo) або на сторінці вже стоїть slots_per_page блоків цього місця.
 * Адмін із ?promo_preview=1 бачить слот і при вимкненій системі чи місці — його
 * заповнює креатив тестової кампанії (is_test) без обліку подій.
 * $page: ['product' => id] або ['article' => slug] — для перевірки прапорців;
 * ['mp' => розділи] — сторінка маркетплейсу (promo_mp_page_sections).
 * Маркетплейс: слот лише коли marketplace_public = 1 (місце доступне); адмін-перегляд — завжди.
 *
 * @param list<int> $categoryIds
 * @param list<int> $subcategoryIds
 */
function promo_slot(PDO $pdo, string $placement, array $categoryIds = [], array $subcategoryIds = [], array $page = []): string
{
    static $perPage = [];
    if (!in_array($placement, PROMO_PLACEMENTS, true)) {
        return '';
    }
    $preview = promo_preview_active($pdo);
    if (!$preview && (!promo_video_ready($pdo) || !promo_placement_available($pdo, $placement))) {
        return '';
    }
    // Чутлива сторінка (no_promo) — жодного слота, жодного порожнього місця (і в перегляді).
    if (promo_page_excluded($pdo, $categoryIds, $subcategoryIds, $page) !== null) {
        return '';
    }
    $perPage[$placement] = ($perPage[$placement] ?? 0) + 1;
    if ($perPage[$placement] > promo_placement_slots($pdo, $placement)) {
        return '';
    }

    $html = '<div class="sponsored-slot sponsored-slot--' . $placement . '" hidden'
        . ' data-placement="' . $placement . '"'
        . ' data-category="' . htmlspecialchars(implode(',', array_map('intval', $categoryIds)), ENT_QUOTES) . '"'
        . ' data-subcategory="' . htmlspecialchars(implode(',', array_map('intval', $subcategoryIds)), ENT_QUOTES) . '"'
        . (!empty($page['product']) ? ' data-product="' . (int) $page['product'] . '"' : '')
        . (!empty($page['article']) ? ' data-article="' . htmlspecialchars((string) $page['article'], ENT_QUOTES) . '"' : '')
        . (!empty($page['mp']) ? ' data-mp="' . htmlspecialchars(implode(',', array_filter((array) $page['mp'], static fn($v) => is_string($v) && promo_mp_section_valid($v))), ENT_QUOTES) . '"' : '')
        . (promo_placement_is_marketplace($pdo, $placement) ? ' data-group="marketplace"' : '')
        . ($preview ? ' data-preview="1"' : '')
        . ' data-lang="' . promo_lang() . '"></div>';

    return $html . promo_assets_html();
}

/** CSS і JS реклами — один раз на сторінку (перший слот чи картка), далі ''. */
function promo_assets_html(): string
{
    static $printed = false;
    if ($printed) {
        return '';
    }
    $printed = true;
    $ver = static fn(string $f): string => (string) (@filemtime(__DIR__ . '/../public/assets/' . $f) ?: 1);

    return '<link rel="stylesheet" href="/assets/css/sponsored.css?v=' . $ver('css/sponsored.css') . '">'
        . '<script src="/assets/js/sponsored.js?v=' . $ver('js/sponsored.js') . '" defer></script>';
}

/**
 * Стан реклами поточної сторінки (спільний для слотів сторінки):
 * shown — креативи, уже поставлені на сторінку (не повторюються); house — уже є блок
 * власної реклами (не більше одного на сторінку).
 *
 * @return array{shown:list<int>,house:bool}
 */
function &promo_page_state(): array
{
    static $state = ['shown' => [], 'house' => false];

    return $state;
}

// --- Адмін-перегляд місць --------------------------------------------------

/**
 * Адмін-перегляд: ?promo_preview=1 в адресі сторінки й роль admin (за БД). Слоти
 * виводяться навіть при вимкненій системі чи місці; promo-serve.php віддає креатив
 * тестової кампанії (is_test) з позначкою перегляду — події й кліки не рахуються.
 */
function promo_preview_active(PDO $pdo): bool
{
    static $active = null;
    if ($active !== null) {
        return $active;
    }
    $active = false;
    $uid = ($_GET['promo_preview'] ?? '') === '1' && function_exists('auth_user_id') ? auth_user_id() : null;
    if ($uid !== null) {
        try {
            $st = $pdo->prepare('SELECT role FROM users WHERE id = :u');
            $st->execute([':u' => $uid]);
            $active = $st->fetchColumn() === 'admin';
        } catch (Throwable $e) {
            $active = false;
        }
    }

    return $active;
}

/** Креатив тестової кампанії (is_test = 1) для адмін-перегляду, або null. */
function promo_preview_creative(PDO $pdo): ?array
{
    try {
        // Тестова кампанія може бути й власною рекламою з картками (без відео).
        $card = promo_house_columns($pdo) ? " OR cr.creative_type = 'card' OR (cr.creative_type = 'image' AND cr.poster_path IS NOT NULL)" : '';
        $row = $pdo->query(
            "SELECT cr.*, c.campaign_type
             FROM ad_creatives cr JOIN ad_campaigns c ON c.id = cr.campaign_id
             WHERE c.is_test = 1 AND c.format = 'video'
               AND ((cr.video_type = 'upload' AND cr.video_path IS NOT NULL) OR (cr.video_type = 'youtube' AND cr.youtube_id IS NOT NULL){$card})
             ORDER BY cr.id"
        )->fetchAll();
        $row = $row !== [] ? $row[mt_rand(0, count($row) - 1)] : false;
    } catch (Throwable $e) {
        return null; // міграцію 2026-10-18 ще не застосовано
    }

    return $row === false ? null : $row;
}

/** Текст кнопки креативу: свій (EN — з cta_text_en, інакше UA) або зі списку PROMO_CTA_KEYS мовою інтерфейсу. */
function promo_cta_label(array $creative): string
{
    $own = trim((string) ($creative['cta_text'] ?? ''));
    if ($own !== '') {
        $en = trim((string) ($creative['cta_text_en'] ?? ''));

        return promo_lang() === 'en' && $en !== '' ? $en : $own;
    }

    return t('promo_cta_' . (in_array($creative['cta_key'] ?? '', PROMO_CTA_KEYS, true) ? $creative['cta_key'] : 'learn_more'));
}

// --- Власна реклама платформи (картки, умови показу) ----------------------

/** Колонки міграції 2026-10-23 (картки, house_rules) є? Без них відбір працює як раніше. */
function promo_house_columns(PDO $pdo): bool
{
    static $has = null;
    if ($has === null) {
        try {
            $has = (bool) $pdo->query("SHOW COLUMNS FROM ad_creatives LIKE 'creative_type'")->fetch();
        } catch (Throwable $e) {
            $has = false;
        }
    }

    return $has;
}

/**
 * Умови показу власної кампанії (ad_campaigns.house_rules, JSON):
 *   requires_setting — налаштування сайту має бути '1' (кампанія B чекає marketplace_public);
 *   site_only        — лише місця сайту й блогу, не всередині маркетплейсу;
 *   hide_if_campaign — не показувати користувачу, який уже створив рекламну кампанію;
 *   hide_if_listing  — не показувати користувачу, який уже публікував оголошення;
 *   exclude_pages    — список сторінок (advertise, cabinet), де кампанія не показується ($page['page']).
 */
function promo_house_allowed(PDO $pdo, array $row, string $placement, array $page = []): bool
{
    $rules = json_decode((string) ($row['house_rules'] ?? ''), true);
    if (!is_array($rules)) {
        return true;
    }
    if (!empty($rules['requires_setting']) && site_setting($pdo, (string) $rules['requires_setting'], '0') !== '1') {
        return false;
    }
    if (!empty($rules['site_only']) && promo_placement_is_marketplace($pdo, $placement)) {
        return false;
    }
    if (!empty($rules['exclude_pages']) && !empty($page['page']) && in_array($page['page'], (array) $rules['exclude_pages'], true)) {
        return false;
    }
    $uid = function_exists('auth_user_id') ? auth_user_id() : null;
    if ($uid !== null) {
        try {
            if (!empty($rules['hide_if_campaign'])) {
                $st = $pdo->prepare("SELECT 1 FROM ad_campaigns WHERE user_id = :u AND campaign_type = 'paid' LIMIT 1");
                $st->execute([':u' => $uid]);
                if ($st->fetchColumn()) {
                    return false;
                }
            }
            if (!empty($rules['hide_if_listing'])) {
                $st = $pdo->prepare('SELECT 1 FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id WHERE s.user_id = :u LIMIT 1');
                $st->execute([':u' => $uid]);
                if ($st->fetchColumn()) {
                    return false;
                }
            }
        } catch (Throwable $e) {
            error_log('[promo] house rules: ' . $e->getMessage());
        }
    }

    return true;
}

/** Дата marketplace_free_until мовою інтерфейсу («31 грудня 2026» / «December 31, 2026»); '' — немає або минула. */
function promo_free_until_text(?PDO $pdo, string $lang): string
{
    $raw = $pdo !== null ? site_setting($pdo, 'marketplace_free_until', '') : '';
    $d = DateTime::createFromFormat('!Y-m-d', $raw);
    if ($d === false || $d->format('Y-m-d') !== $raw || $raw < date('Y-m-d')) {
        return '';
    }
    $m = (int) $d->format('n');
    if ($lang === 'en') {
        return $d->format('F j, Y');
    }
    $uk = ['січня', 'лютого', 'березня', 'квітня', 'травня', 'червня', 'липня', 'серпня', 'вересня', 'жовтня', 'листопада', 'грудня'];

    return $d->format('j') . ' ' . $uk[$m - 1] . ' ' . $d->format('Y');
}

/**
 * Текст власного креативу мовою: EN — з колонки *_en (порожньо — UA). Змінна {free_until}: підставляється дата;
 * немає дати — запасний текст (description_fallback*), а без нього — текст без змінної.
 */
function promo_card_text(array $cr, string $field, string $lang, ?PDO $pdo): string
{
    $txt = $lang === 'en' && trim((string) ($cr[$field . '_en'] ?? '')) !== '' ? (string) $cr[$field . '_en'] : (string) ($cr[$field] ?? '');
    if (!str_contains($txt, '{free_until}')) {
        return $txt;
    }
    $date = promo_free_until_text($pdo, $lang);
    if ($date !== '') {
        return str_replace('{free_until}', $date, $txt);
    }
    $fb = $lang === 'en' && trim((string) ($cr['description_fallback_en'] ?? '')) !== '' ? (string) $cr['description_fallback_en'] : (string) ($cr['description_fallback'] ?? '');

    return $field === 'description' && trim($fb) !== '' ? $fb : trim(str_replace('{free_until}', '', $txt));
}

/** Дані картки без відео (тип creative_type = 'card') для sponsored.js. */
function promo_card_payload(array $cr, string $placement, bool $preview, ?PDO $pdo): array
{
    $lang = promo_lang();
    $cta = $lang === 'en' && trim((string) ($cr['cta_text_en'] ?? '')) !== '' ? (string) $cr['cta_text_en'] : trim((string) ($cr['cta_text'] ?? ''));
    if ($cta === '') {
        $cta = t('promo_cta_' . (in_array($cr['cta_key'] ?? '', PROMO_CTA_KEYS, true) ? $cr['cta_key'] : 'learn_more'));
    }

    return [
        'id'          => (int) $cr['id'],
        'token'       => promo_token_make(['c' => (int) $cr['id'], 'k' => (int) $cr['campaign_id'], 'p' => $placement, 'x' => $preview ? 1 : 0]),
        'preview'     => $preview,
        'house'       => ($cr['campaign_type'] ?? 'internal') === 'internal',
        'placement'   => $placement,
        'type'        => 'card',
        'layout'      => ($cr['card_layout'] ?? '') === 'compact' || in_array($placement, ['subcategory_list', 'search_results', 'marketplace_feed', 'marketplace_search'], true) ? 'compact' : 'wide',
        'title'       => promo_card_text($cr, 'title', $lang, $pdo),
        'description' => promo_card_text($cr, 'description', $lang, $pdo),
        'cta'         => $cta,
        'video'       => null,
        'youtube'     => null,
        'poster'      => null,
    ];
}
