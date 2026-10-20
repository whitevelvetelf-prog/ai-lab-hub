<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Цифрові матеріали» маркетплейсу (mp_listings.section = 'asset' + mp_assets).
 *
 * Мета захисту (чесно): (1) не віддавати оригінал без умов ліцензії, (2) робити публічні превʼю малоцінними
 * для використання, (3) мати докази авторства й слід завантажень, (4) швидко видаляти порушення. Повністю
 * унеможливити копіювання того, що показано на екрані, неможливо — ніде не обіцяємо «повного захисту».
 *
 * Шари:
 *   a) оригінали — у приватному каталозі поза public/ (config/storage.php), прямої адреси немає;
 *   b) превʼю — GD: довша сторона ≤ assets_preview_px, перекодування (EXIF/XMP/GPS не копіюються), видимий
 *      діагональний повторюваний водяний знак «AI LAB HUB #ID» по всьому зображенню (звичайна/висока щільність);
 *   c) видача превʼю — лише asset-preview.php з підписаною адресою й терміном дії (assets_preview_ttl_min);
 *   d) антискрапінг — ліміт запитів превʼю на анонімний хеш IP, блок на різке зростання унікальних превʼю,
 *      журнал підозрілої активності без персональних даних, ручне блокування хешу;
 *   e) оригінал — лише залогіненим, за ліцензією, що дозволяє завантаження, з прийняттям ліцензії, через
 *      одноразовий токен, з денним лімітом; журнал asset_downloads (sha256 виданого файлу, хеш IP — не IP);
 *   f) у виданий файл — XMP: автор, права, адреса ліцензії, унікальний download_id (метадані легко прибрати —
 *      це доказова підтримка, а не захист); EXIF автора (зокрема GPS) з виданого файлу прибирається;
 *   g) sha256 і dHash кожного оригіналу; схожі на наявні — сигнал модератору «схоже на оголошення #N»;
 *   h) «Підтвердження публікації» — технічний запис (не юридичне свідоцтво).
 *
 * Без GD публікація активів відхиляється з поясненням (ast_capabilities()).
 */

require_once __DIR__ . '/marketplace-board.php';   // mp_*, mpb_*: сесія продавця, CSRF, IP-ключ
require_once __DIR__ . '/asset-i18n.php';
require_once __DIR__ . '/site-settings.php';

const AST_KINDS = ['image', 'illustration', 'character'];
const AST_ORIGINS = ['human', 'ai_assisted', 'ai_generated'];
const AST_MIME_EXT = ['image/png' => 'png', 'image/jpeg' => 'jpg', 'image/webp' => 'webp'];
const AST_TITLE_MAX = 120;
const AST_DESC_MAX = 3000;
const AST_MAX_MEGAPIXELS = 60;      // захист пам'яті GD (60 МП ≈ 240 МБ у truecolor)
const AST_MAX_PENDING = 5;
const AST_PER_PAGE = 24;
const AST_CLAIM_STATUSES = ['new', 'under_review', 'content_disabled', 'counter_notice', 'restored', 'rejected'];
/** Відомі стокові джерела в метаданих — сигнал модератору. */
const AST_STOCK_MARKERS = ['shutterstock', 'gettyimages', 'getty images', 'istock', 'adobe stock', 'adobestock', 'depositphotos',
    'dreamstime', 'alamy', '123rf', 'freepik', 'pond5', 'bigstock', 'stocksy'];

// =========================================================================
// Налаштування, сховище, можливості сервера
// =========================================================================

/** @return array<string,int|bool> */
function ast_settings(PDO $pdo): array
{
    $i = static fn(string $k, int $def, int $min, int $max): int => max($min, min($max, (int) site_setting($pdo, $k, (string) $def)));

    return [
        'max_mb' => $i('assets_max_mb', 20, 1, 200),
        'preview_px' => $i('assets_preview_px', 1000, 300, 2000),
        'preview_ttl_min' => $i('assets_preview_ttl_min', 15, 1, 240),
        'preview_per_min' => $i('assets_preview_per_min', 60, 5, 1000),
        'unique_burst' => $i('assets_unique_burst', 40, 5, 1000),
        'block_minutes' => $i('assets_block_minutes', 30, 1, 1440),
        'downloads_per_day' => $i('assets_downloads_per_day', 20, 1, 1000),
        'download_token_min' => $i('assets_download_token_min', 5, 1, 60),
        'similarity_threshold' => $i('assets_similarity_threshold', 10, 0, 32),
        'context_guard' => site_setting($pdo, 'assets_context_guard', '1') === '1',
        'listing_days' => $i('assets_listing_days', 365, 7, 3650),
        'auto_hide' => site_setting($pdo, 'copyright_auto_hide', '1') === '1',
        'counter_days' => $i('copyright_counter_days', 10, 1, 90),
        'strikes_limit' => $i('copyright_strikes_limit', 3, 1, 20),
    ];
}

/**
 * Каталоги й секрет: config/storage.php, інакше локальні storage/assets/… і секрет із config/promo.php.
 *
 * @return array{original:string,preview:string,secret:string,warnings:list<string>}
 */
function ast_storage(): array
{
    static $s = null;
    if ($s !== null) {
        return $s;
    }
    $file = __DIR__ . '/../config/storage.php';
    $cfg = is_file($file) ? require $file : [];
    $cfg = is_array($cfg) ? $cfg : [];
    $warnings = [];
    if (!is_file($file)) {
        $warnings[] = 'Немає config/storage.php — використовуються локальні каталоги storage/assets/ (на хостингу задайте каталоги поза www).';
    }
    $orig = rtrim((string) ($cfg['assets_original_dir'] ?? ''), '/\\');
    $prev = rtrim((string) ($cfg['assets_preview_dir'] ?? ''), '/\\');
    if ($orig === '' || str_contains($orig, '/home/USER/')) {
        $orig = dirname(__DIR__) . '/storage/assets/original';
    }
    if ($prev === '' || str_contains($prev, '/home/USER/')) {
        $prev = dirname(__DIR__) . '/storage/assets/preview';
    }
    $publicDir = realpath(dirname(__DIR__) . '/public');
    foreach (['original' => $orig, 'preview' => $prev] as $label => $dir) {
        $real = realpath($dir);
        if ($publicDir !== false && $real !== false && str_starts_with($real, $publicDir)) {
            $warnings[] = 'Каталог ' . $label . ' лежить усередині public/ — файли матимуть пряму адресу. Перенесіть його поза корінь сайту.';
        }
    }
    $secret = (string) ($cfg['secret'] ?? '');
    if (strlen($secret) < 32) {
        $promo = __DIR__ . '/../config/promo.php';
        $p = is_file($promo) ? require $promo : [];
        $secret = is_array($p) ? (string) ($p['secret'] ?? '') : '';
        $warnings[] = strlen($secret) >= 32
            ? 'Секрет підпису превʼю взято з config/promo.php — краще задати окремий у config/storage.php.'
            : 'Немає секрету підпису превʼю (config/storage.php → secret) — використовується запасний, слабкий.';
        if (strlen($secret) < 32) {
            $secret = hash('sha256', 'ast-fallback|' . dirname(__DIR__) . '|' . (string) mp_config()['rate_limit_salt']);
        }
    }

    return $s = ['original' => $orig, 'preview' => $prev, 'secret' => $secret, 'warnings' => $warnings];
}

/** Каталог сховища (створює з правами 0750, якщо немає). */
function ast_dir(string $which): string
{
    $dir = ast_storage()[$which];
    if (!is_dir($dir) && !@mkdir($dir, 0750, true) && !is_dir($dir)) {
        throw new RuntimeException('asset storage dir is not writable: ' . $which);
    }

    return $dir;
}

/**
 * Що є на сервері: GD (обов'язково), WebP, imagerotate, fileinfo, exif.
 *
 * @return array{ok:bool,gd:bool,webp:bool,rotate:bool,fileinfo:bool,exif:bool,message:string}
 */
function ast_capabilities(): array
{
    $gd = extension_loaded('gd') && function_exists('imagecreatetruecolor');
    $c = [
        'gd' => $gd,
        'webp' => $gd && function_exists('imagecreatefromwebp') && function_exists('imagewebp'),
        'rotate' => $gd && function_exists('imagerotate'),
        'fileinfo' => class_exists('finfo'),
        'exif' => function_exists('exif_read_data'),
    ];
    $c['ok'] = $c['gd'] && $c['fileinfo'];
    $missing = [];
    foreach (['gd' => 'GD', 'fileinfo' => 'fileinfo'] as $k => $n) {
        if (!$c[$k]) {
            $missing[] = $n;
        }
    }
    $c['message'] = $c['ok'] ? '' : 'Немає розширень PHP: ' . implode(', ', $missing) . ' — публікація активів вимкнена.';

    return $c;
}

/** Анонімний хеш IP (sha256 + сіль; IPv6 → /64). IP ніде не зберігається. */
function ast_anon_hash(): string
{
    return mpb_ip_key(mpb_client_ip());
}

// =========================================================================
// Ліцензії
// =========================================================================

/** @return array<string,array<string,mixed>> code => рядок asset_license_types (активні, за sort_order) */
function ast_licenses(PDO $pdo): array
{
    static $cache = null;
    if ($cache === null) {
        $cache = [];
        try {
            foreach ($pdo->query('SELECT * FROM asset_license_types WHERE active = 1 ORDER BY sort_order, code') as $r) {
                $cache[(string) $r['code']] = $r;
            }
        } catch (Throwable $e) {
            // міграцію ще не застосовано
        }
    }

    return $cache;
}

function ast_license_title(array $lic, string $lang): string
{
    return (string) ($lang === 'en' ? $lic['title_en'] : $lic['title_uk']);
}

/** Чи можна завантажити оригінал: ліцензія дозволяє й автор дозволив (view_only / commercial_paid — ніколи). */
function ast_downloadable(PDO $pdo, array $asset): bool
{
    $lic = ast_licenses($pdo)[(string) $asset['license_code']] ?? null;

    return $lic !== null && (int) $lic['allows_download'] === 1 && (int) $asset['allow_download'] === 1
        && !in_array((string) $asset['license_code'], ['view_only', 'commercial_paid'], true);
}

// =========================================================================
// Файл: перевірка, оригінал, метадані
// =========================================================================

/**
 * Перевірка завантаженого файлу: помилка завантаження, розмір, MIME за вмістом (finfo), декодування.
 *
 * @return array{tmp:string,mime:string,w:int,h:int,size:int}|string ключ помилки або [ключ, аргумент]
 */
function ast_inspect_upload(array $file, int $maxBytes): array|string
{
    $err = (int) ($file['error'] ?? UPLOAD_ERR_NO_FILE);
    if ($err === UPLOAD_ERR_NO_FILE) {
        return 'err_file_required';
    }
    if ($err === UPLOAD_ERR_INI_SIZE || $err === UPLOAD_ERR_FORM_SIZE) {
        return 'err_file_size';
    }
    if ($err !== UPLOAD_ERR_OK || !is_string($file['tmp_name'] ?? null) || !is_file($file['tmp_name'])) {
        return 'err_upload';
    }

    return ast_inspect_path((string) $file['tmp_name'], $maxBytes);
}

/** @return array{tmp:string,mime:string,w:int,h:int,size:int}|string */
function ast_inspect_path(string $path, int $maxBytes): array|string
{
    $size = (int) @filesize($path);
    if ($size <= 0) {
        return 'err_upload';
    }
    if ($size > $maxBytes) {
        return 'err_file_size';
    }
    $mime = (string) (new finfo(FILEINFO_MIME_TYPE))->file($path);
    if (!isset(AST_MIME_EXT[$mime])) {
        return 'err_file_type';
    }
    $info = @getimagesize($path);
    if ($info === false || (int) $info[0] < 1 || (int) $info[1] < 1 || ($info['mime'] ?? '') !== $mime) {
        return 'err_file_broken';
    }
    if ((int) $info[0] * (int) $info[1] > AST_MAX_MEGAPIXELS * 1000000) {
        return 'err_file_dims';
    }
    // Справжнє декодування: файл, що лише «прикидається» зображенням (поліглот), не пройде.
    $img = ast_gd_load($path, $mime);
    if ($img === null) {
        return 'err_file_broken';
    }
    imagedestroy($img);

    return ['tmp' => $path, 'mime' => $mime, 'w' => (int) $info[0], 'h' => (int) $info[1], 'size' => $size];
}

function ast_gd_load(string $path, string $mime): ?\GdImage
{
    if (!function_exists('imagecreatetruecolor')) {
        return null;
    }
    $img = match ($mime) {
        'image/jpeg' => @imagecreatefromjpeg($path),
        'image/png' => @imagecreatefrompng($path),
        'image/webp' => function_exists('imagecreatefromwebp') ? @imagecreatefromwebp($path) : false,
        default => false,
    };

    return $img instanceof \GdImage ? $img : null;
}

/**
 * Метадані оригіналу для модератора: автор і права з EXIF/XMP, ознаки стокових джерел.
 *
 * @return array{artist:string,copyright:string,software:string,stock:list<string>,has_gps:bool}
 */
function ast_read_meta(string $path, string $mime): array
{
    $out = ['artist' => '', 'copyright' => '', 'software' => '', 'stock' => [], 'has_gps' => false];
    if ($mime === 'image/jpeg' && function_exists('exif_read_data')) {
        $exif = @exif_read_data($path, null, true);
        if (is_array($exif)) {
            $ifd = $exif['IFD0'] ?? [];
            $out['artist'] = mb_substr(trim((string) ($ifd['Artist'] ?? '')), 0, 120);
            $out['copyright'] = mb_substr(trim((string) ($ifd['Copyright'] ?? '')), 0, 200);
            $out['software'] = mb_substr(trim((string) ($ifd['Software'] ?? '')), 0, 120);
            $out['has_gps'] = !empty($exif['GPS']);
        }
    }
    // XMP / IPTC — пошук текстом у перших 512 КБ файлу (без розбору форматів).
    $head = (string) @file_get_contents($path, false, null, 0, 524288);
    if (preg_match('~<dc:creator>.*?<rdf:li[^>]*>([^<]{1,120})</rdf:li>~s', $head, $m) === 1 && $out['artist'] === '') {
        $out['artist'] = trim(html_entity_decode($m[1], ENT_QUOTES | ENT_XML1));
    }
    if (preg_match('~<dc:rights>.*?<rdf:li[^>]*>([^<]{1,200})</rdf:li>~s', $head, $m) === 1 && $out['copyright'] === '') {
        $out['copyright'] = trim(html_entity_decode($m[1], ENT_QUOTES | ENT_XML1));
    }
    $low = strtolower($head . ' ' . $out['artist'] . ' ' . $out['copyright']);
    foreach (AST_STOCK_MARKERS as $marker) {
        if (str_contains($low, $marker)) {
            $out['stock'][] = $marker;
        }
    }
    $out['stock'] = array_values(array_unique($out['stock']));

    return $out;
}

/** Зберегти оригінал під випадковим ім'ям у приватному сховищі. @return array{name:string,sha256:string} */
function ast_store_original(string $tmp, string $mime, bool $uploaded = true): array
{
    $dir = ast_dir('original');
    $name = bin2hex(random_bytes(16)) . '.' . AST_MIME_EXT[$mime];
    $dest = $dir . '/' . $name;
    $ok = $uploaded ? @move_uploaded_file($tmp, $dest) : @copy($tmp, $dest);
    if (!$ok) {
        throw new RuntimeException('cannot store original');
    }
    @chmod($dest, 0640);

    return ['name' => $name, 'sha256' => (string) hash_file('sha256', $dest)];
}

/** Повний шлях до файлу сховища або null (лише імена, що їх згенерував код — без «..»). */
function ast_path(string $which, ?string $name): ?string
{
    if ($name === null || preg_match('/^[a-f0-9]{32}\.(png|jpg|webp)$/', $name) !== 1) {
        return null;
    }
    $p = ast_storage()[$which] . '/' . $name;

    return is_file($p) ? $p : null;
}

function ast_delete_files(?string $orig, ?string $preview): void
{
    foreach ([['original', $orig], ['preview', $preview]] as [$w, $n]) {
        $p = ast_path($w, $n);
        if ($p !== null) {
            @unlink($p);
        }
    }
}

// =========================================================================
// Перцептивний хеш
// =========================================================================

/** dHash 64 біти (16 hex): зменшення до 9×8, відтінки сірого, порівняння сусідніх пікселів. */
function ast_dhash(\GdImage $img): string
{
    $small = imagecreatetruecolor(9, 8);
    imagecopyresampled($small, $img, 0, 0, 0, 0, 9, 8, imagesx($img), imagesy($img));
    $hex = '';
    for ($y = 0; $y < 8; $y++) {
        $row = [];
        for ($x = 0; $x < 9; $x++) {
            $c = imagecolorat($small, $x, $y);
            $row[] = ((($c >> 16) & 0xFF) * 299 + (($c >> 8) & 0xFF) * 587 + ($c & 0xFF) * 114) / 1000;
        }
        $byte = 0;
        for ($x = 0; $x < 8; $x++) {
            $byte = ($byte << 1) | ($row[$x] > $row[$x + 1] ? 1 : 0);
        }
        $hex .= sprintf('%02x', $byte);
    }
    imagedestroy($small);

    return $hex;
}

/** Відстань Хеммінга між двома dHash (0 — однакові, 64 — повністю різні). */
function ast_hamming(string $a, string $b): int
{
    if (strlen($a) !== 16 || strlen($b) !== 16) {
        return 64;
    }
    $d = 0;
    for ($i = 0; $i < 16; $i++) {
        $x = hexdec($a[$i]) ^ hexdec($b[$i]);
        $d += ($x & 1) + (($x >> 1) & 1) + (($x >> 2) & 1) + (($x >> 3) & 1);
    }

    return $d;
}

/**
 * Схожі активи (інші оголошення): той самий sha256 або dHash у межах порогу.
 *
 * @return list<array{id:int,distance:int,same_file:bool}>
 */
function ast_find_similar(PDO $pdo, string $dhash, string $sha, int $excludeId, int $threshold): array
{
    $out = [];
    $st = $pdo->prepare('SELECT listing_id, dhash, orig_sha256 FROM mp_assets WHERE listing_id <> :id');
    $st->execute([':id' => $excludeId]);
    foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $r) {
        $same = hash_equals((string) $r['orig_sha256'], $sha);
        $dist = $same ? 0 : ast_hamming($dhash, (string) $r['dhash']);
        if ($same || $dist <= $threshold) {
            $out[] = ['id' => (int) $r['listing_id'], 'distance' => $dist, 'same_file' => $same];
        }
    }
    usort($out, static fn($a, $b) => $a['distance'] <=> $b['distance']);

    return array_slice($out, 0, 10);
}

// =========================================================================
// Превʼю з водяним знаком
// =========================================================================

/**
 * Накласти видимий водяний знак: діагональний повторюваний напис «AI LAB HUB #ID» по всьому зображенню
 * (напівпрозорий білий із темною тінню — видно і на світлому, і на темному). Шрифт — вбудований у GD
 * (TTF не потрібен). $density: normal | high.
 */
function ast_watermark(\GdImage $img, string $text, string $density): void
{
    $font = 5;
    $tw = imagefontwidth($font) * strlen($text) + 8;
    $th = imagefontheight($font) + 6;
    $tile = imagecreatetruecolor($tw, $th);
    imagealphablending($tile, false);
    imagesavealpha($tile, true);
    imagefill($tile, 0, 0, imagecolorallocatealpha($tile, 0, 0, 0, 127));
    imagealphablending($tile, true);
    imagestring($tile, $font, 5, 4, $text, imagecolorallocatealpha($tile, 0, 0, 0, 80));     // тінь
    imagestring($tile, $font, 4, 3, $text, imagecolorallocatealpha($tile, 255, 255, 255, 48)); // напис
    // Масштаб під розмір превʼю: на 1000 пікселів напис ≈ 1/4 ширини.
    $scale = max(1.0, min(imagesx($img), imagesy($img)) / 480);
    if ($scale > 1.05) {
        $scaled = imagescale($tile, (int) round($tw * $scale), (int) round($th * $scale));
        if ($scaled instanceof \GdImage) {
            imagedestroy($tile);
            $tile = $scaled;
            imagealphablending($tile, false);
            imagesavealpha($tile, true);
        }
    }
    if (function_exists('imagerotate')) {
        $rot = imagerotate($tile, 30, imagecolorallocatealpha($tile, 0, 0, 0, 127));
        if ($rot instanceof \GdImage) {
            imagedestroy($tile);
            $tile = $rot;
            imagealphablending($tile, false);
            imagesavealpha($tile, true);
        }
    }
    $w = imagesx($tile);
    $h = imagesy($tile);
    $step = $density === 'high' ? 0.75 : 1.35;
    $sx = max(20, (int) round($w * $step));
    $sy = max(20, (int) round($h * $step * 0.9));
    imagealphablending($img, true);
    for ($y = -$h, $row = 0; $y < imagesy($img) + $h; $y += $sy, $row++) {
        $offset = ($row % 2) * (int) ($sx / 2);
        for ($x = -$w + $offset; $x < imagesx($img) + $w; $x += $sx) {
            imagecopy($img, $tile, $x, $y, 0, 0, $w, $h);
        }
    }
    imagedestroy($tile);
}

/**
 * Згенерувати превʼю: зменшення, перекодування (метадані не копіюються), водяний знак.
 * Формат — WebP (якщо є), інакше JPEG. @return array{name:string,w:int,h:int}
 */
function ast_make_preview(string $origPath, string $mime, int $listingId, string $density, int $maxPx): array
{
    $img = ast_gd_load($origPath, $mime);
    if ($img === null) {
        throw new RuntimeException('cannot decode original');
    }
    // Спершу зменшити (менше пам'яті), потім білий фон під прозорість; довша сторона ≤ $maxPx.
    $small = mpb_gd_fit($img, $maxPx);
    $fit = mpb_gd_flatten($small);
    if ($small !== $img) {
        imagedestroy($small);
    }
    imagedestroy($img);
    ast_watermark($fit, 'AI LAB HUB #' . $listingId, $density === 'high' ? 'high' : 'normal');
    $webp = function_exists('imagewebp');
    $name = bin2hex(random_bytes(16)) . ($webp ? '.webp' : '.jpg');
    $dest = ast_dir('preview') . '/' . $name;
    $ok = $webp ? imagewebp($fit, $dest, 78) : imagejpeg($fit, $dest, 80);
    $w = imagesx($fit);
    $h = imagesy($fit);
    imagedestroy($fit);
    if (!$ok) {
        throw new RuntimeException('cannot write preview');
    }
    @chmod($dest, 0640);

    return ['name' => $name, 'w' => $w, 'h' => $h];
}

/** Демонстрація водяного знака для форми (PNG у пам'яті, data: URI). */
function ast_watermark_demo(string $density): string
{
    if (!function_exists('imagecreatetruecolor')) {
        return '';
    }
    $img = imagecreatetruecolor(480, 270);
    for ($y = 0; $y < 270; $y++) {
        $c = imagecolorallocate($img, 40 + (int) ($y / 3), 60 + (int) ($y / 4), 140);
        imageline($img, 0, $y, 479, $y, $c);
    }
    imagefilledellipse($img, 330, 120, 160, 160, imagecolorallocate($img, 255, 200, 90));
    ast_watermark($img, 'AI LAB HUB #123', $density);
    ob_start();
    imagepng($img);
    imagedestroy($img);

    return 'data:image/png;base64,' . base64_encode((string) ob_get_clean());
}

// =========================================================================
// Підписані адреси превʼю й антискрапінг
// =========================================================================

function ast_sign(string $payload): string
{
    return substr(hash_hmac('sha256', $payload, ast_storage()['secret']), 0, 32);
}

/** Адреса превʼю з терміном дії (округлено до хвилини — сусідні сторінки отримують ту саму адресу). */
function ast_preview_url(PDO $pdo, int $listingId): string
{
    $ttl = (int) ast_settings($pdo)['preview_ttl_min'] * 60;
    $exp = (int) (ceil((time() + $ttl) / 60) * 60);

    return 'asset-preview.php?id=' . $listingId . '&e=' . $exp . '&s=' . ast_sign('pv|' . $listingId . '|' . $exp);
}

function ast_preview_sig_ok(int $listingId, int $exp, string $sig): bool
{
    return $exp >= time() && $exp <= time() + 86400 && hash_equals(ast_sign('pv|' . $listingId . '|' . $exp), $sig);
}

/** Хеш заблоковано (вручну або тимчасово)? */
function ast_hash_blocked(PDO $pdo, string $anon): bool
{
    try {
        $st = $pdo->prepare('SELECT 1 FROM asset_blocked_hashes WHERE anon_hash = :h AND (expires_at IS NULL OR expires_at > NOW())');
        $st->execute([':h' => $anon]);

        return (bool) $st->fetchColumn();
    } catch (Throwable $e) {
        return false;
    }
}

function ast_suspicious(PDO $pdo, string $anon, string $reason, string $detail = '', int $blockMinutes = 0): void
{
    try {
        $pdo->prepare('INSERT INTO asset_suspicious (anon_hash, reason, detail, created_at) VALUES (:h, :r, :d, NOW())')
            ->execute([':h' => $anon, ':r' => $reason, ':d' => mb_substr($detail, 0, 255)]);
        if ($blockMinutes > 0) {
            $pdo->prepare(
                'INSERT INTO asset_blocked_hashes (anon_hash, reason, blocked_by, expires_at, created_at)
                 VALUES (:h, :r, NULL, NOW() + INTERVAL ' . $blockMinutes . ' MINUTE, NOW())
                 ON DUPLICATE KEY UPDATE expires_at = IF(expires_at IS NULL, NULL, GREATEST(expires_at, VALUES(expires_at))), reason = VALUES(reason)'
            )->execute([':h' => $anon, ':r' => 'auto: ' . $reason]);
        }
    } catch (Throwable $e) {
        error_log('[asset] suspicious log: ' . $e->getMessage());
    }
}

/**
 * Облік запиту превʼю й ліміти. true — віддавати; false — тимчасово заблоковано (429).
 * $signal — 'hotlink' (Sec-Fetch-Site/Referer чужого сайту — лише сигнал, превʼю все одно віддається).
 */
function ast_preview_gate(PDO $pdo, string $anon, int $listingId, ?string $signal): bool
{
    if (ast_hash_blocked($pdo, $anon)) {
        return false;
    }
    $s = ast_settings($pdo);
    try {
        $pdo->prepare('INSERT INTO asset_access_log (anon_hash, asset_id, sig, created_at) VALUES (:h, :a, :s, NOW())')
            ->execute([':h' => $anon, ':a' => $listingId, ':s' => $signal]);
        if ($signal === 'hotlink') {
            ast_suspicious($pdo, $anon, 'hotlink', 'asset #' . $listingId);
        }
        $st = $pdo->prepare('SELECT COUNT(*), COUNT(DISTINCT asset_id) FROM asset_access_log WHERE anon_hash = :h AND created_at >= NOW() - INTERVAL 60 SECOND');
        $st->execute([':h' => $anon]);
        [$perMin] = array_map('intval', $st->fetch(PDO::FETCH_NUM) ?: [0, 0]);
        $st = $pdo->prepare('SELECT COUNT(DISTINCT asset_id) FROM asset_access_log WHERE anon_hash = :h AND created_at >= NOW() - INTERVAL 5 MINUTE');
        $st->execute([':h' => $anon]);
        $unique5 = (int) $st->fetchColumn();
        if (mt_rand(1, 200) === 1) {
            $pdo->exec('DELETE FROM asset_access_log WHERE created_at < NOW() - INTERVAL 7 DAY');
        }
    } catch (Throwable $e) {
        error_log('[asset] preview gate: ' . $e->getMessage());

        return true;   // без таблиць — не ламаємо показ
    }
    if ($perMin > $s['preview_per_min']) {
        ast_suspicious($pdo, $anon, 'rate', $perMin . ' запитів/хв', (int) $s['block_minutes']);

        return false;
    }
    if ($unique5 > $s['unique_burst']) {
        ast_suspicious($pdo, $anon, 'burst', $unique5 . ' різних превʼю за 5 хв', (int) $s['block_minutes']);

        return false;
    }

    return true;
}

// =========================================================================
// Виданий оригінал: метадані (XMP), без EXIF автора
// =========================================================================

function ast_xmp(string $creator, string $rights, string $licenseUrl, string $downloadId, string $licenseCode): string
{
    $x = static fn(string $v): string => htmlspecialchars($v, ENT_XML1 | ENT_QUOTES, 'UTF-8');

    return '<?xpacket begin="' . "\u{FEFF}" . '" id="W5M0MpCehiHzreSzNTczkc9d"?>'
        . '<x:xmpmeta xmlns:x="adobe:ns:meta/"><rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">'
        . '<rdf:Description rdf:about="" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:xmpRights="http://ns.adobe.com/xap/1.0/rights/"'
        . ' xmlns:ailh="https://ailabhub-directory.com/ns/asset/1.0/">'
        . '<dc:creator><rdf:Seq><rdf:li>' . $x($creator) . '</rdf:li></rdf:Seq></dc:creator>'
        . '<dc:rights><rdf:Alt><rdf:li xml:lang="x-default">' . $x($rights) . '</rdf:li></rdf:Alt></dc:rights>'
        . '<xmpRights:Marked>True</xmpRights:Marked><xmpRights:WebStatement>' . $x($licenseUrl) . '</xmpRights:WebStatement>'
        . '<ailh:DownloadID>' . $x($downloadId) . '</ailh:DownloadID><ailh:Licence>' . $x($licenseCode) . '</ailh:Licence>'
        . '</rdf:Description></rdf:RDF></x:xmpmeta><?xpacket end="w"?>';
}

/** JPEG: прибрати APP1 (EXIF/XMP) і APP13 (IPTC), вставити APP1 з нашим XMP після SOI/APP0. */
function ast_jpeg_with_xmp(string $data, string $xmp): ?string
{
    if (strncmp($data, "\xFF\xD8", 2) !== 0) {
        return null;
    }
    $ns = "http://ns.adobe.com/xap/1.0/\0";
    if (strlen($ns . $xmp) + 2 > 65535) {
        return null;
    }
    $out = "\xFF\xD8";
    $app1 = "\xFF\xE1" . pack('n', strlen($ns . $xmp) + 2) . $ns . $xmp;
    $pos = 2;
    $len = strlen($data);
    $inserted = false;
    while ($pos + 4 <= $len && $data[$pos] === "\xFF") {
        $marker = ord($data[$pos + 1]);
        if ($marker === 0xDA) {   // SOS — далі дані зображення
            break;
        }
        $segLen = unpack('n', substr($data, $pos + 2, 2))[1];
        $seg = substr($data, $pos, 2 + $segLen);
        $pos += 2 + $segLen;
        if (!$inserted && $marker !== 0xE0) {
            $out .= $app1;
            $inserted = true;
        }
        if ($marker === 0xE1 || $marker === 0xED) {
            continue;   // EXIF / XMP / IPTC автора — не видаємо (зокрема GPS)
        }
        $out .= $seg;
    }
    if (!$inserted) {
        $out .= $app1;
    }

    return $out . substr($data, $pos);
}

/** PNG: прибрати eXIf і текстові чанки, вставити iTXt XML:com.adobe.xmp перед IEND. */
function ast_png_with_xmp(string $data, string $xmp): ?string
{
    if (strncmp($data, "\x89PNG\r\n\x1A\n", 8) !== 0) {
        return null;
    }
    $out = substr($data, 0, 8);
    $pos = 8;
    $len = strlen($data);
    while ($pos + 12 <= $len) {
        $n = unpack('N', substr($data, $pos, 4))[1];
        $type = substr($data, $pos + 4, 4);
        $chunk = substr($data, $pos, 12 + $n);
        $pos += 12 + $n;
        if (in_array($type, ['eXIf', 'tEXt', 'zTXt', 'iTXt', 'tIME'], true)) {
            continue;
        }
        if ($type === 'IEND') {
            $body = "XML:com.adobe.xmp\0\0\0\0\0" . $xmp;
            $out .= pack('N', strlen($body)) . 'iTXt' . $body . pack('N', crc32('iTXt' . $body));
        }
        $out .= $chunk;
        if ($type === 'IEND') {
            break;
        }
    }

    return $out;
}

/** WebP: прибрати EXIF/XMP, додати XMP-чанк і VP8X (створити для простого формату). */
function ast_webp_with_xmp(string $data, string $xmp, int $w, int $h): ?string
{
    if (strncmp($data, 'RIFF', 4) !== 0 || substr($data, 8, 4) !== 'WEBP') {
        return null;
    }
    $chunks = [];
    $pos = 12;
    $len = strlen($data);
    while ($pos + 8 <= $len) {
        $fourcc = substr($data, $pos, 4);
        $n = unpack('V', substr($data, $pos + 4, 4))[1];
        $payload = substr($data, $pos + 8, $n);
        $pos += 8 + $n + ($n % 2);
        if ($fourcc === 'EXIF' || $fourcc === 'XMP ') {
            continue;
        }
        $chunks[] = [$fourcc, $payload];
    }
    $chunk = static fn(string $f, string $p): string => $f . pack('V', strlen($p)) . $p . (strlen($p) % 2 ? "\0" : '');
    $hasVp8x = $chunks !== [] && $chunks[0][0] === 'VP8X';
    if ($hasVp8x) {
        $flags = (ord($chunks[0][1][0]) | 0x04) & ~0x08;   // XMP так, EXIF ні
        $chunks[0][1][0] = chr($flags);
    } else {
        $flags = 0x04 | (($chunks[0][0] ?? '') === 'VP8L' ? 0x10 : 0);
        $wh = substr(pack('V', $w - 1), 0, 3) . substr(pack('V', $h - 1), 0, 3);
        array_unshift($chunks, ['VP8X', chr($flags) . "\0\0\0" . $wh]);
    }
    $body = 'WEBP';
    foreach ($chunks as [$f, $p]) {
        $body .= $chunk($f, $p);
    }
    $body .= $chunk('XMP ', $xmp);

    return 'RIFF' . pack('V', strlen($body)) . $body;
}

/** Байти оригіналу з нашим XMP (null — формат не вдалося обробити; тоді віддаємо без змін не можна). */
function ast_build_download(string $origPath, string $mime, string $xmp, int $w, int $h): ?string
{
    $data = (string) file_get_contents($origPath);

    return match ($mime) {
        'image/jpeg' => ast_jpeg_with_xmp($data, $xmp),
        'image/png' => ast_png_with_xmp($data, $xmp),
        'image/webp' => ast_webp_with_xmp($data, $xmp, $w, $h),
        default => null,
    };
}

// =========================================================================
// Читання оголошень
// =========================================================================

/** Видиме публічно (alias l). */
function ast_visible_sql(): string
{
    return "l.section = 'asset' AND l.status = 'published' AND (l.expires_at IS NULL OR l.expires_at > NOW())";
}

function ast_select_sql(): string
{
    return "SELECT l.id, l.section, l.status, l.slug, l.seller_id, l.source_lang, l.published_at, l.expires_at, l.created_at, l.updated_at AS listing_updated_at,
                   l.reject_reason, l.views_count, l.contact_email, l.contact_telegram,
                   s.display_name AS seller_name, s.user_id AS seller_user_id,
                   COALESCE(NULLIF(tc.title, ''), ts.title) AS title,
                   COALESCE(NULLIF(tc.full_desc, ''), ts.full_desc) AS full_desc,
                   a.*
            FROM mp_listings l
            JOIN mp_assets a ON a.listing_id = l.id
            LEFT JOIN mp_sellers s ON s.id = l.seller_id
            LEFT JOIN mp_listing_translations tc ON tc.listing_id = l.id AND tc.lang = :lang
            LEFT JOIN mp_listing_translations ts ON ts.listing_id = l.id AND ts.lang = l.source_lang";
}

function ast_listing(PDO $pdo, int $id, string $lang): ?array
{
    $st = $pdo->prepare(ast_select_sql() . " WHERE l.id = :id AND l.section = 'asset'");
    $st->execute([':lang' => $lang, ':id' => $id]);
    $r = $st->fetch(PDO::FETCH_ASSOC);

    return $r === false ? null : $r;
}

function ast_is_live(array $row): bool
{
    return (string) $row['status'] === 'published' && ($row['expires_at'] === null || strtotime((string) $row['expires_at']) > time());
}

function ast_url(array $row): string
{
    return 'asset.php?id=' . (int) ($row['listing_id'] ?? $row['id']);
}

/** @return array{rows:list<array>,total:int,pages:int,page:int} */
function ast_search(PDO $pdo, string $lang, array $f, int $page): array
{
    $where = [ast_visible_sql()];
    $params = [':lang' => $lang];
    if (in_array($f['kind'] ?? '', AST_KINDS, true)) {
        $where[] = 'a.asset_kind = :kind';
        $params[':kind'] = $f['kind'];
    }
    if (isset(ast_licenses($pdo)[$f['license'] ?? ''])) {
        $where[] = 'a.license_code = :lic';
        $params[':lic'] = $f['license'];
    }
    $q = trim((string) ($f['q'] ?? ''));
    if ($q !== '') {
        $like = '%' . addcslashes($q, '%_\\') . '%';
        $where[] = "(tc.title LIKE :q1 ESCAPE '\\\\' OR ts.title LIKE :q2 ESCAPE '\\\\' OR a.tags LIKE :q3 ESCAPE '\\\\' OR a.character_name LIKE :q4 ESCAPE '\\\\')";
        $params += [':q1' => $like, ':q2' => $like, ':q3' => $like, ':q4' => $like];
    }
    $sql = ast_select_sql() . ' WHERE ' . implode(' AND ', $where);
    $cnt = $pdo->prepare('SELECT COUNT(*) FROM (' . $sql . ') x');
    $cnt->execute($params);
    $total = (int) $cnt->fetchColumn();
    $pages = max(1, (int) ceil($total / AST_PER_PAGE));
    $page = min(max(1, $page), $pages);
    $st = $pdo->prepare($sql . ' ORDER BY l.published_at DESC, l.id DESC LIMIT ' . AST_PER_PAGE . ' OFFSET ' . (($page - 1) * AST_PER_PAGE));
    $st->execute($params);

    return ['rows' => $st->fetchAll(PDO::FETCH_ASSOC), 'total' => $total, 'pages' => $pages, 'page' => $page];
}

/** Активи користувача (усі статуси) з лічильниками завантажень і скарг. */
function ast_user_assets(PDO $pdo, int $userId): array
{
    $st = $pdo->prepare(
        "SELECT l.id, l.status, l.published_at, l.expires_at, l.views_count, l.reject_reason, t.title, a.license_code, a.asset_kind,
                (SELECT COUNT(*) FROM asset_downloads d WHERE d.asset_id = l.id) AS downloads,
                (SELECT COUNT(*) FROM copyright_claims c WHERE c.listing_id = l.id) AS claims,
                (SELECT c.id FROM copyright_claims c WHERE c.listing_id = l.id AND c.status IN ('new', 'under_review', 'content_disabled')
                    AND c.counter_at IS NULL ORDER BY c.id DESC LIMIT 1) AS open_claim
         FROM mp_listings l JOIN mp_assets a ON a.listing_id = l.id JOIN mp_sellers s ON s.id = l.seller_id
         LEFT JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = l.source_lang
         WHERE l.section = 'asset' AND s.user_id = :u ORDER BY l.id DESC"
    );
    $st->execute([':u' => $userId]);

    return $st->fetchAll(PDO::FETCH_ASSOC);
}

function ast_own(PDO $pdo, int $id, int $userId): ?array
{
    $st = $pdo->prepare(
        "SELECT l.*, a.* FROM mp_listings l JOIN mp_assets a ON a.listing_id = l.id JOIN mp_sellers s ON s.id = l.seller_id
         WHERE l.id = :id AND l.section = 'asset' AND s.user_id = :u"
    );
    $st->execute([':id' => $id, ':u' => $userId]);
    $r = $st->fetch(PDO::FETCH_ASSOC);

    return $r === false ? null : $r;
}

// =========================================================================
// Збереження й модерація
// =========================================================================

function ast_pending_count(PDO $pdo, int $userId, int $exceptId = 0): int
{
    $st = $pdo->prepare(
        "SELECT COUNT(*) FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id
         WHERE l.section = 'asset' AND l.status = 'pending' AND s.user_id = :u AND l.id <> :x"
    );
    $st->execute([':u' => $userId, ':x' => $exceptId]);

    return (int) $st->fetchColumn();
}

/** Кількість підтверджених порушень (strikes) і чи заблоковано публікацію активів. */
function ast_strikes(PDO $pdo, int $userId): int
{
    try {
        $st = $pdo->prepare('SELECT COUNT(*) FROM copyright_strikes WHERE user_id = :u');
        $st->execute([':u' => $userId]);

        return (int) $st->fetchColumn();
    } catch (Throwable $e) {
        return 0;
    }
}

function ast_posting_blocked(PDO $pdo, int $userId): bool
{
    return ast_strikes($pdo, $userId) >= (int) ast_settings($pdo)['strikes_limit'];
}

/**
 * Створити / оновити актив (→ pending). $file — результат ast_inspect_* (новий файл) або null (лишити файл).
 * Оригінал і превʼю пишуться у сховище; при помилці нові файли видаляються.
 *
 * @param array<string,mixed> $d title, desc, kind, origin, license, license_custom, allow_download, alt, tags,
 *                               char_name, char_desc, char_terms, density, noimageindex, contact_email, contact_telegram
 */
function ast_save(PDO $pdo, array $d, ?array $existing, int $userId, int $sellerId, string $lang, ?array $file, bool $uploaded = true): int
{
    $s = ast_settings($pdo);
    $newOrig = null;
    $newPreview = null;
    $origName = $existing['orig_name'] ?? null;
    $meta = null;
    try {
        if ($file !== null) {
            $stored = ast_store_original($file['tmp'], $file['mime'], $uploaded);
            $newOrig = $stored['name'];
            $origPath = (string) ast_path('original', $newOrig);
            $img = ast_gd_load($origPath, $file['mime']);
            $dhash = $img !== null ? ast_dhash($img) : null;
            if ($img !== null) {
                imagedestroy($img);
            }
            $meta = ast_read_meta($origPath, $file['mime']);
            $fileCols = ['orig_name' => $newOrig, 'orig_mime' => $file['mime'], 'orig_size' => $file['size'], 'orig_sha256' => $stored['sha256'],
                'width' => $file['w'], 'height' => $file['h'], 'dhash' => $dhash];
        }

        $pdo->beginTransaction();
        if ($existing === null) {
            $pdo->prepare(
                "INSERT INTO mp_listings (section, seller_id, status, pricing_model, price_type, delivery_type, source_lang, is_remote,
                     license, slug, contact_email, contact_telegram, rules_accepted_at, created_by)
                 VALUES ('asset', :sid, 'pending', 'free', 'none', 'file', :lang, 1, :lic, :slug, :ce, :ct, NOW(), :u)"
            )->execute([':sid' => $sellerId, ':lang' => $lang, ':lic' => $d['license'], ':slug' => mb_substr(lst_slug_safe($d['title']), 0, 140),
                ':ce' => $d['contact_email'] ?: null, ':ct' => $d['contact_telegram'] ?: null, ':u' => $userId]);
            $id = (int) $pdo->lastInsertId();
            $textLang = $lang;
            mp_log($pdo, $id, $userId, 'created', 'актив на модерації');
        } else {
            $id = (int) $existing['id'];
            $textLang = (string) $existing['source_lang'];
            $pdo->prepare("UPDATE mp_listings SET status = 'pending', license = :lic, slug = :slug, contact_email = :ce, contact_telegram = :ct,
                               rules_accepted_at = NOW(), reject_reason = NULL
                           WHERE id = :id AND section = 'asset'")
                ->execute([':lic' => $d['license'], ':slug' => mb_substr(lst_slug_safe($d['title']), 0, 140),
                    ':ce' => $d['contact_email'] ?: null, ':ct' => $d['contact_telegram'] ?: null, ':id' => $id]);
            mp_log($pdo, $id, $userId, 'edited', 'актив після редагування — на модерації (було: ' . $existing['status'] . ')');
        }
        $pdo->prepare(
            "INSERT INTO mp_listing_translations (listing_id, lang, title, short_desc, full_desc, is_auto) VALUES (:id, :lang, :t, NULL, :f, 0)
             ON DUPLICATE KEY UPDATE title = VALUES(title), full_desc = VALUES(full_desc), is_auto = 0"
        )->execute([':id' => $id, ':lang' => $textLang, ':t' => $d['title'], ':f' => $d['desc'] !== '' ? $d['desc'] : null]);

        // Превʼю: новий файл або змінена щільність водяного знака.
        $densityChanged = $existing !== null && (string) $existing['watermark_density'] !== $d['density'];
        if ($file !== null || $densityChanged || ($existing !== null && ast_path('preview', $existing['preview_name']) === null)) {
            $srcName = $newOrig ?? $origName;
            $srcMime = $file['mime'] ?? (string) $existing['orig_mime'];
            $p = ast_make_preview((string) ast_path('original', $srcName), $srcMime, $id, $d['density'], (int) $s['preview_px']);
            $newPreview = $p['name'];
        }

        $similar = null;
        if (isset($fileCols)) {
            $similar = json_encode(ast_find_similar($pdo, (string) $fileCols['dhash'], $fileCols['orig_sha256'], $id, (int) $s['similarity_threshold']));
        }
        $cols = [
            'asset_kind' => $d['kind'], 'origin' => $d['origin'], 'ownership_user_id' => $userId, 'license_code' => $d['license'],
            'license_custom' => $d['license'] === 'custom' ? $d['license_custom'] : null, 'allow_download' => $d['allow_download'] ? 1 : 0,
            'alt_text' => $d['alt'], 'tags' => $d['tags'] !== '' ? $d['tags'] : null,
            'character_name' => $d['kind'] === 'character' ? $d['char_name'] : null,
            'character_desc' => $d['kind'] === 'character' ? ($d['char_desc'] ?: null) : null,
            'character_terms' => $d['kind'] === 'character' ? ($d['char_terms'] ?: null) : null,
            'watermark_density' => $d['density'], 'noimageindex' => $d['noimageindex'] ? 1 : 0,
        ];
        if (isset($fileCols)) {
            $cols += $fileCols + ['similar_json' => $similar, 'meta_json' => json_encode($meta, JSON_UNESCAPED_UNICODE)];
        }
        if ($newPreview !== null) {
            $cols += ['preview_name' => $newPreview, 'preview_w' => $p['w'], 'preview_h' => $p['h']];
        }
        if ($existing === null) {
            $names = array_keys($cols);
            $pdo->prepare('INSERT INTO mp_assets (listing_id, ownership_declared_at, uploaded_at, ' . implode(', ', $names) . ')
                           VALUES (:id, UTC_TIMESTAMP(), UTC_TIMESTAMP(), ' . implode(', ', array_map(static fn($n) => ':' . $n, $names)) . ')')
                ->execute([':id' => $id] + array_combine(array_map(static fn($n) => ':' . $n, $names), array_values($cols)));
        } else {
            $set = implode(', ', array_map(static fn($n) => $n . ' = :' . $n, array_keys($cols)));
            $extra = $file !== null ? ', uploaded_at = UTC_TIMESTAMP()' : '';
            $pdo->prepare('UPDATE mp_assets SET ' . $set . ', ownership_declared_at = UTC_TIMESTAMP()' . $extra . ' WHERE listing_id = :id')
                ->execute([':id' => $id] + array_combine(array_map(static fn($n) => ':' . $n, array_keys($cols)), array_values($cols)));
        }
        $pdo->commit();
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        ast_delete_files($newOrig, $newPreview);
        throw $e;
    }
    // Старі файли — лише після успішного збереження.
    if ($existing !== null) {
        ast_delete_files($newOrig !== null ? (string) $existing['orig_name'] : null, $newPreview !== null ? $existing['preview_name'] : null);
    }

    return $id;
}

/** Slug без залежності від app/listing.php. */
function lst_slug_safe(string $title): string
{
    if (function_exists('lst_slug')) {
        return lst_slug($title);
    }
    $s = strtolower(trim((string) preg_replace('/[^a-z0-9]+/i', '-', $title), '-'));

    return $s !== '' ? $s : 'asset';
}

function ast_approve(PDO $pdo, int $id, int $actorId): bool
{
    $days = (int) ast_settings($pdo)['listing_days'];
    $upd = $pdo->prepare(
        "UPDATE mp_listings SET status = 'published', published_at = COALESCE(published_at, NOW()), expires_at = NOW() + INTERVAL {$days} DAY,
                moderated_by = :a, moderated_at = NOW(), reject_reason = NULL
         WHERE id = :id AND section = 'asset' AND status = 'pending'"
    );
    $upd->execute([':a' => $actorId, ':id' => $id]);
    if ($upd->rowCount() === 0) {
        return false;
    }
    mp_log($pdo, $id, $actorId, 'approved', 'актив');
    ast_mail($pdo, $id, 'asset_approved');

    return true;
}

function ast_reject(PDO $pdo, int $id, int $actorId, string $reason): bool
{
    $reason = mb_substr(trim($reason), 0, 500);
    if ($reason === '') {
        return false;
    }
    $upd = $pdo->prepare(
        "UPDATE mp_listings SET status = 'rejected', reject_reason = :r, moderated_by = :a, moderated_at = NOW()
         WHERE id = :id AND section = 'asset' AND status IN ('pending', 'published')"
    );
    $upd->execute([':r' => $reason, ':a' => $actorId, ':id' => $id]);
    if ($upd->rowCount() === 0) {
        return false;
    }
    mp_log($pdo, $id, $actorId, 'rejected', $reason);
    ast_mail($pdo, $id, 'asset_rejected', ['reason' => $reason]);

    return true;
}

/** Зняти з публікації (власник / модератор) → archived. */
function ast_remove(PDO $pdo, int $id, int $actorId, string $note = ''): bool
{
    $upd = $pdo->prepare("UPDATE mp_listings SET status = 'archived' WHERE id = :id AND section = 'asset' AND status IN ('pending', 'published', 'rejected', 'expired')");
    $upd->execute([':id' => $id]);
    if ($upd->rowCount() === 0) {
        return false;
    }
    mp_log($pdo, $id, $actorId, 'archived', $note !== '' ? $note : null);

    return true;
}

/** Продовжити опублікований актив ще на assets_listing_days. */
function ast_extend(PDO $pdo, int $id, int $userId): bool
{
    $days = (int) ast_settings($pdo)['listing_days'];
    $upd = $pdo->prepare("UPDATE mp_listings SET expires_at = NOW() + INTERVAL {$days} DAY, status = 'published'
                          WHERE id = :id AND section = 'asset' AND status IN ('published', 'expired') AND published_at IS NOT NULL");
    $upd->execute([':id' => $id]);
    if ($upd->rowCount() > 0) {
        mp_log($pdo, $id, $userId, 'extended', 'актив');

        return true;
    }

    return false;
}

// =========================================================================
// Завантаження оригіналу
// =========================================================================

function ast_downloads_today(PDO $pdo, int $userId): int
{
    $st = $pdo->prepare('SELECT COUNT(*) FROM asset_downloads WHERE user_id = :u AND created_at >= NOW() - INTERVAL 1 DAY');
    $st->execute([':u' => $userId]);

    return (int) $st->fetchColumn();
}

/** Новий одноразовий токен (після прийняття ліцензії). */
function ast_token_create(PDO $pdo, int $assetId, int $userId): string
{
    $min = (int) ast_settings($pdo)['download_token_min'];
    $token = bin2hex(random_bytes(32));
    $pdo->prepare("INSERT INTO asset_download_tokens (token, asset_id, user_id, expires_at, created_at)
                   VALUES (:t, :a, :u, NOW() + INTERVAL {$min} MINUTE, NOW())")
        ->execute([':t' => hash('sha256', $token), ':a' => $assetId, ':u' => $userId]);

    return $token;
}

/** Використати токен (атомарно): id активу або null (немає / минув / використаний / чужий). */
function ast_token_consume(PDO $pdo, string $token, int $userId): ?int
{
    if (preg_match('/^[a-f0-9]{64}$/', $token) !== 1) {
        return null;
    }
    $hash = hash('sha256', $token);
    $upd = $pdo->prepare('UPDATE asset_download_tokens SET used_at = NOW() WHERE token = :t AND user_id = :u AND used_at IS NULL AND expires_at > NOW()');
    $upd->execute([':t' => $hash, ':u' => $userId]);
    if ($upd->rowCount() === 0) {
        return null;
    }
    $st = $pdo->prepare('SELECT asset_id FROM asset_download_tokens WHERE token = :t');
    $st->execute([':t' => $hash]);

    return (int) $st->fetchColumn() ?: null;
}

/**
 * Зібрати виданий файл і записати в asset_downloads.
 *
 * @return array{bytes:string,download_id:string,filename:string,mime:string}|null
 */
function ast_issue_download(PDO $pdo, array $asset, int $userId): ?array
{
    $path = ast_path('original', (string) $asset['orig_name']);
    if ($path === null) {
        return null;
    }
    $downloadId = bin2hex(random_bytes(16));
    $author = (string) ($asset['seller_name'] ?? '') !== '' ? (string) $asset['seller_name'] : 'AI LAB HUB author';
    $url = mail_site_url_safe() . '/asset.php?id=' . (int) $asset['listing_id'] . '#license';
    $xmp = ast_xmp($author, '© ' . $author . ' — ' . (string) $asset['license_code'], $url, $downloadId, (string) $asset['license_code']);
    $bytes = ast_build_download($path, (string) $asset['orig_mime'], $xmp, (int) $asset['width'], (int) $asset['height']);
    if ($bytes === null) {
        return null;
    }
    $pdo->prepare(
        'INSERT INTO asset_downloads (download_id, asset_id, user_id, license_code, sha256, anon_hash, created_at)
         VALUES (:d, :a, :u, :l, :s, :h, NOW())'
    )->execute([':d' => $downloadId, ':a' => (int) $asset['listing_id'], ':u' => $userId, ':l' => (string) $asset['license_code'],
        ':s' => hash('sha256', $bytes), ':h' => ast_anon_hash()]);

    return ['bytes' => $bytes, 'download_id' => $downloadId, 'mime' => (string) $asset['orig_mime'],
        'filename' => 'ailabhub-asset-' . (int) $asset['listing_id'] . '-' . substr($downloadId, 0, 8) . '.' . AST_MIME_EXT[(string) $asset['orig_mime']]];
}

function mail_site_url_safe(): string
{
    if (!function_exists('mail_site_url')) {
        require_once __DIR__ . '/mailer.php';
    }

    return mail_site_url();
}

// =========================================================================
// Скарги на порушення авторських прав
// =========================================================================

function ast_claim_log(PDO $pdo, int $claimId, ?int $actorId, string $action, string $note = ''): void
{
    $pdo->prepare('INSERT INTO copyright_claim_log (claim_id, actor_id, action, note, created_at) VALUES (:c, :a, :ac, :n, NOW())')
        ->execute([':c' => $claimId, ':a' => $actorId, ':ac' => $action, ':n' => $note !== '' ? mb_substr($note, 0, 2000) : null]);
}

/** Номер оголошення з посилання чи числа. */
function ast_listing_id_from_ref(string $ref): int
{
    if (preg_match('/^\s*#?(\d{1,9})\s*$/', $ref, $m) === 1) {
        return (int) $m[1];
    }
    if (preg_match('/[?&]id=(\d{1,9})/', $ref, $m) === 1) {
        return (int) $m[1];
    }

    return 0;
}

/**
 * Нова скарга. Актив + copyright_auto_hide → тимчасово приховано (status 'disabled') до розгляду,
 * автору — лист із формою зустрічної заяви. @return int id скарги
 */
function ast_claim_create(PDO $pdo, array $d): int
{
    $s = ast_settings($pdo);
    $listingId = ast_listing_id_from_ref($d['ref']);
    $row = null;
    if ($listingId > 0) {
        $st = $pdo->prepare('SELECT id, section, status FROM mp_listings WHERE id = :id');
        $st->execute([':id' => $listingId]);
        $row = $st->fetch(PDO::FETCH_ASSOC) ?: null;
    }
    $hide = $row !== null && $row['section'] === 'asset' && $row['status'] === 'published' && $s['auto_hide'];
    $pdo->beginTransaction();
    try {
        $pdo->prepare(
            "INSERT INTO copyright_claims (listing_id, listing_ref, what_infringed, evidence, claimant_name, claimant_email, claimant_contact,
                 good_faith_at, status, auto_hidden, counter_deadline, anon_hash, created_at)
             VALUES (:l, :ref, :w, :e, :n, :em, :c, NOW(), :st, :h, NOW() + INTERVAL {$s['counter_days']} DAY, :ah, NOW())"
        )->execute([':l' => $row !== null ? (int) $row['id'] : null, ':ref' => mb_substr($d['ref'], 0, 500), ':w' => $d['what'], ':e' => $d['evidence'] ?: null,
            ':n' => $d['name'], ':em' => $d['email'], ':c' => $d['contact'] ?: null, ':st' => $hide ? 'content_disabled' : 'new', ':h' => $hide ? 1 : 0,
            ':ah' => ast_anon_hash()]);
        $claimId = (int) $pdo->lastInsertId();
        ast_claim_log($pdo, $claimId, null, 'created', $hide ? 'оголошення автоматично приховано до розгляду' : '');
        if ($hide) {
            $pdo->prepare("UPDATE mp_listings SET status = 'disabled' WHERE id = :id AND status = 'published'")->execute([':id' => (int) $row['id']]);
            mp_log($pdo, (int) $row['id'], null, 'disabled', 'скарга на авторські права №' . $claimId);
        }
        $pdo->commit();
    } catch (Throwable $e) {
        $pdo->rollBack();
        throw $e;
    }
    if ($row !== null && $row['section'] === 'asset') {
        ast_mail_claim_owner($pdo, $claimId);
    }

    return $claimId;
}

function ast_claim(PDO $pdo, int $id): ?array
{
    $st = $pdo->prepare(
        "SELECT c.*, l.section, l.status AS listing_status, s.user_id AS owner_user_id, t.title
         FROM copyright_claims c LEFT JOIN mp_listings l ON l.id = c.listing_id LEFT JOIN mp_sellers s ON s.id = l.seller_id
         LEFT JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = l.source_lang
         WHERE c.id = :id"
    );
    $st->execute([':id' => $id]);
    $r = $st->fetch(PDO::FETCH_ASSOC);

    return $r === false ? null : $r;
}

/** Зустрічна заява автора (до строку). */
function ast_claim_counter(PDO $pdo, int $claimId, int $userId, string $text): bool
{
    $c = ast_claim($pdo, $claimId);
    if ($c === null || (int) $c['owner_user_id'] !== $userId || $c['counter_at'] !== null
        || !in_array($c['status'], ['new', 'under_review', 'content_disabled'], true)
        || ($c['counter_deadline'] !== null && strtotime((string) $c['counter_deadline']) < time())) {
        return false;
    }
    $pdo->prepare("UPDATE copyright_claims SET counter_text = :t, counter_at = NOW(), status = 'counter_notice' WHERE id = :id")
        ->execute([':t' => mb_substr($text, 0, 5000), ':id' => $claimId]);
    ast_claim_log($pdo, $claimId, $userId, 'counter_notice');

    return true;
}

/**
 * Рішення адміна: under_review | content_disabled | restored | rejected (+ нотатка). content_disabled — порушення
 * підтверджено: оголошення знято, автору зараховано strike. Листи обом сторонам.
 */
function ast_claim_decide(PDO $pdo, int $claimId, int $adminId, string $status, string $note): bool
{
    $c = ast_claim($pdo, $claimId);
    if ($c === null || !in_array($status, ['under_review', 'content_disabled', 'restored', 'rejected'], true)) {
        return false;
    }
    $pdo->beginTransaction();
    try {
        $pdo->prepare('UPDATE copyright_claims SET status = :s, decision_note = :n WHERE id = :id')
            ->execute([':s' => $status, ':n' => $note !== '' ? mb_substr($note, 0, 2000) : null, ':id' => $claimId]);
        ast_claim_log($pdo, $claimId, $adminId, 'status:' . $status, $note);
        $lid = (int) $c['listing_id'];
        if ($lid > 0 && $c['section'] === 'asset') {
            if ($status === 'content_disabled') {
                $pdo->prepare("UPDATE mp_listings SET status = 'disabled' WHERE id = :id AND status IN ('published', 'disabled', 'pending')")->execute([':id' => $lid]);
                if ((int) $c['owner_user_id'] > 0) {
                    $pdo->prepare('INSERT IGNORE INTO copyright_strikes (user_id, claim_id, created_at) VALUES (:u, :c, NOW())')
                        ->execute([':u' => (int) $c['owner_user_id'], ':c' => $claimId]);
                }
            } elseif (in_array($status, ['restored', 'rejected'], true)) {
                $pdo->prepare("UPDATE mp_listings SET status = 'published' WHERE id = :id AND status = 'disabled'")->execute([':id' => $lid]);
                $pdo->prepare('DELETE FROM copyright_strikes WHERE claim_id = :c')->execute([':c' => $claimId]);
            }
            mp_log($pdo, $lid, $adminId, 'claim_' . $status, 'скарга №' . $claimId);
        }
        $pdo->commit();
    } catch (Throwable $e) {
        $pdo->rollBack();
        error_log('[asset] claim decide: ' . $e->getMessage());

        return false;
    }
    if ($status !== 'under_review') {
        ast_mail_claim_decision($pdo, $claimId);
    }

    return true;
}

// =========================================================================
// Листи
// =========================================================================

function ast_enqueue(PDO $pdo, string $email, string $name, string $lang, string $key, array $vars): bool
{
    if (filter_var($email, FILTER_VALIDATE_EMAIL) === false) {
        return false;
    }
    require_once __DIR__ . '/promo-mail.php';
    $vars['site'] = mail_site_url_safe();
    $subject = ast_tr_lang('mail_' . $key . '_subject', $lang, $vars);
    $body = ast_tr_lang('mail_' . $key . '_body', $lang, $vars) . "\n\n" . ast_tr_lang('mail_footer', $lang, $vars);
    $html = '<div style="font-family:Arial,sans-serif;font-size:15px;line-height:1.55;color:#1d2433">'
        . nl2br(preg_replace('~(https?://[^\s<]+)~', '<a href="$1" style="color:#2f5bd3">$1</a>', htmlspecialchars($body, ENT_QUOTES)) ?? '') . '</div>';

    return promo_mail_enqueue($pdo, $email, $name, $subject, $body, $html, $lang);
}

/** Лист автору активу: asset_received | asset_approved | asset_rejected | asset_proof. */
function ast_mail(PDO $pdo, int $id, string $event, array $extra = []): bool
{
    $st = $pdo->prepare(
        "SELECT l.id, l.source_lang, u.email, u.name, t.title FROM mp_listings l JOIN mp_sellers s ON s.id = l.seller_id JOIN users u ON u.id = s.user_id
         LEFT JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = l.source_lang WHERE l.id = :id"
    );
    $st->execute([':id' => $id]);
    $r = $st->fetch(PDO::FETCH_ASSOC);
    if ($r === false) {
        return false;
    }
    $site = mail_site_url_safe();
    $lang = (string) $r['source_lang'] === 'en' ? 'en' : 'uk';

    return ast_enqueue($pdo, (string) $r['email'], (string) $r['name'], $lang, $event, [
        'title' => (string) $r['title'], 'url' => $site . '/asset.php?id=' . $id, 'cabinet' => $site . '/account.php#acc-assets',
        'reason' => (string) ($extra['reason'] ?? ''),
    ]);
}

function ast_mail_claim_owner(PDO $pdo, int $claimId): void
{
    $c = ast_claim($pdo, $claimId);
    if ($c === null || (int) $c['owner_user_id'] <= 0) {
        return;
    }
    $u = $pdo->prepare('SELECT email, name FROM users WHERE id = :u');
    $u->execute([':u' => (int) $c['owner_user_id']]);
    $user = $u->fetch(PDO::FETCH_ASSOC);
    if ($user === false) {
        return;
    }
    $lang = 'uk';
    $site = mail_site_url_safe();
    ast_enqueue($pdo, (string) $user['email'], (string) $user['name'], $lang, 'claim_owner', [
        'title' => (string) $c['title'], 'claim' => (string) $claimId,
        'hidden' => (int) $c['auto_hidden'] === 1 ? ast_tr_lang('mail_claim_hidden', $lang) : '',
        'deadline' => $c['counter_deadline'] !== null ? date('d.m.Y', (int) strtotime((string) $c['counter_deadline'])) : '—',
        'counter' => $site . '/copyright-counter.php?id=' . $claimId,
    ]);
}

function ast_mail_claim_decision(PDO $pdo, int $claimId): void
{
    $c = ast_claim($pdo, $claimId);
    if ($c === null) {
        return;
    }
    $lang = 'uk';
    $vars = ['claim' => (string) $claimId, 'title' => (string) ($c['title'] ?? $c['listing_ref']),
        'decision' => ast_tr_lang('cst_' . $c['status'], $lang), 'note' => (string) ($c['decision_note'] ?? '')];
    ast_enqueue($pdo, (string) $c['claimant_email'], (string) $c['claimant_name'], $lang, 'claim_decision', $vars);
    if ((int) $c['owner_user_id'] > 0) {
        $u = $pdo->prepare('SELECT email, name FROM users WHERE id = :u');
        $u->execute([':u' => (int) $c['owner_user_id']]);
        if (($user = $u->fetch(PDO::FETCH_ASSOC)) !== false) {
            ast_enqueue($pdo, (string) $user['email'], (string) $user['name'], $lang, 'claim_decision', $vars);
        }
    }
}

// =========================================================================
// Розмітка
// =========================================================================

/** Позначка походження (видима на картці й сторінці). */
function ast_origin_badge(string $origin): string
{
    $o = in_array($origin, AST_ORIGINS, true) ? $origin : 'human';

    return '<span class="ast-origin ast-origin--' . $o . '">' . ast_e(ast_tr('origin_' . $o)) . '</span>';
}

function ast_license_badge(PDO $pdo, string $code): string
{
    $lic = ast_licenses($pdo)[$code] ?? null;
    if ($lic === null) {
        return '';
    }

    return '<span class="ast-license" title="' . ast_e(ast_lang() === 'en' ? $lic['summary_en'] : $lic['summary_uk']) . '">'
        . '<span aria-hidden="true">' . ast_e($lic['icon']) . '</span> ' . ast_e(ast_license_title($lic, ast_lang())) . '</span>';
}

/** Картка активу у списку (превʼю — підписана адреса, alt обов'язковий). */
function ast_card_html(PDO $pdo, array $r): string
{
    $id = (int) $r['listing_id'];

    return '<article class="mp-card ast-card">'
        . '<a class="ast-card__img" href="' . ast_e(ast_url($r)) . '"><img src="' . ast_e(ast_preview_url($pdo, $id)) . '" alt="' . ast_e($r['alt_text']) . '"'
        . ' width="' . (int) $r['preview_w'] . '" height="' . (int) $r['preview_h'] . '" loading="lazy" decoding="async" draggable="false"></a>'
        . '<p class="mp-card__tag">' . ast_e(ast_tr('kind_' . $r['asset_kind'])) . ' · ' . ast_origin_badge((string) $r['origin']) . '</p>'
        . '<h3 class="mp-card__title"><a href="' . ast_e(ast_url($r)) . '">' . ast_e($r['title']) . '</a></h3>'
        . '<p class="ast-card__meta">' . ast_license_badge($pdo, (string) $r['license_code']) . '</p>'
        . '<p class="mp-card__seller">' . ast_e($r['seller_name']) . '</p>'
        . '</article>';
}

/** Мета-теги сторінок з активами: noai/noimageai (добровільні сигнали) і noimageindex за вибором автора. */
function ast_meta_robots(bool $noimageindex, bool $noindex = false): string
{
    $v = ['noai', 'noimageai'];
    if ($noimageindex) {
        $v[] = 'noimageindex';
    }
    if ($noindex) {
        $v = array_merge(['noindex', 'nofollow'], $v);
    }

    return '<meta name="robots" content="' . implode(', ', $v) . '">';
}

/** Початок сторінки активів: як mpb_open(), але з додатковими тегами в <head> (robots, ліцензія). */
function ast_open(string $title, string $head, string $nav = 'assets'): void
{
    $lang = current_lang();
    echo "<!DOCTYPE html>\n<html lang=\"" . ast_e($lang) . "\">\n<head>\n<meta charset=\"utf-8\">\n"
        . "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n"
        . '<title>' . ast_e($title) . ' — ' . ast_e(t('title_marketplace')) . "</title>\n" . $head . "\n";
    include __DIR__ . '/header.php';
    echo "\n<link rel=\"stylesheet\" href=\"/assets/css/site-nav.css\">\n"
        . '<link rel="stylesheet" href="' . css_asset('mp-public.css') . "\">\n</head>\n<body class=\"mp-body\">\n";
    include __DIR__ . '/site-header.php';
    if ($nav !== '') {
        echo mp_section_nav($nav);
    }
}

/**
 * Легка перешкода збереженню превʼю (налаштування assets_context_guard): вимкнене контекстне меню й
 * перетягування лише на зображеннях .ast-guard; клавіатуру й доступність не чіпає. Чесно: це лише перешкода.
 */
function ast_guard_script(PDO $pdo): string
{
    if (!ast_settings($pdo)['context_guard']) {
        return '';
    }

    return "<script>document.addEventListener('contextmenu',function(e){if(e.target.closest&&e.target.closest('.ast-guard')){e.preventDefault();}});"
        . "document.addEventListener('dragstart',function(e){if(e.target.closest&&e.target.closest('.ast-guard')){e.preventDefault();}});</script>";
}
