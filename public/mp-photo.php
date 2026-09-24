<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: видача фото оголошення (?f=<32 hex>[_t].jpg|png|webp).
 *
 * Фото лежать ПОЗА webroot (config 'photo_dir'): заборону виконання PHP у публічній теці через .htaccess
 * shared-хостинг (adm.tools) не підтримує — будь-який варіант дає 500. Тому файл віддає цей скрипт:
 *   - ім'я лише за MPB_PHOTO_NAME_RE (без шляхів і «..»), файл має бути записаний у mp_listing_photos;
 *   - права як у app/mpb-offer.php: живе оголошення — усім; інші статуси — лише власнику та employee/admin;
 *   - при public_enabled = false — лише employee/admin (як offer.php), решта → 404;
 *   - Content-Type за розширенням (вміст перекодований GD), nosniff; ETag/Last-Modified → 304.
 * Тільки GET/HEAD.
 */

session_cache_limiter('');   // заголовки кешу ставимо самі (замість no-store сесії)

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';   // підключає app/marketplace.php

mp_public_or_staff_require();

$method = $_SERVER['REQUEST_METHOD'] ?? '';
if ($method !== 'GET' && $method !== 'HEAD') {
    http_response_code(405);
    header('Allow: GET, HEAD');
    exit;
}

$name = (string) ($_GET['f'] ?? '');
$path = mpb_photo_path($name);
if ($path === null) {
    mp_not_found();
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$stmt = $pdo->prepare(
    'SELECT (' . mpb_visible_sql() . ') AS is_live, s.user_id AS seller_user_id
     FROM mp_listing_photos p
     JOIN mp_listings l ON l.id = p.listing_id
     LEFT JOIN mp_sellers s ON s.id = l.seller_id
     WHERE (p.file_name = :f1 OR p.thumb_name = :f2) AND l.section = \'board\'
     LIMIT 1'
);
$stmt->execute([':f1' => $name, ':f2' => $name]);
$row = $stmt->fetch(PDO::FETCH_ASSOC);
if ($row === false) {
    mp_not_found();
}

$isLive = (int) $row['is_live'] === 1;
if (!$isLive) {
    $viewerId = auth_user_id();
    $isOwner = $viewerId !== null && $row['seller_user_id'] !== null && (int) $row['seller_user_id'] === $viewerId;
    if (!$isOwner && !mpb_is_staff()) {
        mp_not_found();
    }
}
session_write_close();   // не тримати блокування сесії, поки віддаються кілька фото сторінки паралельно

$type = match (strtolower(pathinfo($name, PATHINFO_EXTENSION))) {
    'png'   => 'image/png',
    'webp'  => 'image/webp',
    default => 'image/jpeg',
};
$size = (int) filesize($path);
$mtime = (int) filemtime($path);
$etag = '"' . substr(hash('sha256', $name . '|' . $size . '|' . $mtime), 0, 32) . '"';

header('X-Content-Type-Options: nosniff');
header("Content-Security-Policy: default-src 'none'");
header('Content-Disposition: inline; filename="' . $name . '"');
// Лише кеш браузера (private: відповідь може нести Set-Cookie сесії). Живе оголошення — година;
// неопубліковане (власник/модератор) — з перевіркою щоразу.
header($isLive ? 'Cache-Control: private, max-age=3600' : 'Cache-Control: private, no-cache');
if (!$isLive) {
    header('X-Robots-Tag: noindex, nofollow');
}
header('ETag: ' . $etag);
header('Last-Modified: ' . gmdate('D, d M Y H:i:s', $mtime) . ' GMT');

$inm = (string) ($_SERVER['HTTP_IF_NONE_MATCH'] ?? '');
$ims = (string) ($_SERVER['HTTP_IF_MODIFIED_SINCE'] ?? '');
if (($inm !== '' && in_array($etag, array_map('trim', explode(',', $inm)), true))
    || ($inm === '' && $ims !== '' && strtotime($ims) >= $mtime)) {
    http_response_code(304);
    exit;
}

header('Content-Type: ' . $type);
header('Content-Length: ' . $size);
if ($method === 'HEAD') {
    exit;
}
readfile($path);
