<?php

declare(strict_types=1);

/**
 * AI LAB HUB — видача превʼю «Цифрового матеріалу» (зменшене, з водяним знаком, без EXIF).
 *
 *   asset-preview.php?id=N&e=ЧАС&s=ПІДПИС   — адреса з терміном дії (ast_preview_url), без неї — 403.
 *
 * Публічно — лише живий актив; власник і співробітники бачать і неопубліковані (модерація).
 * Ліміти на анонімний хеш IP (ast_preview_gate): забагато запитів або різке зростання унікальних превʼю →
 * тимчасове блокування з нейтральним 429. Чужий сайт (Sec-Fetch-Site / Referer) — лише СИГНАЛ у журнал,
 * превʼю віддається (доступність не ламаємо). Заголовки: Cache-Control private, X-Robots-Tag noai/noimageai
 * (+ noimageindex за вибором автора).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/asset.php';

header('X-Content-Type-Options: nosniff');

$id = (int) ($_GET['id'] ?? 0);
$exp = (int) ($_GET['e'] ?? 0);
$sig = is_string($_GET['s'] ?? null) ? (string) $_GET['s'] : '';
if ($id <= 0 || !ast_preview_sig_ok($id, $exp, $sig)) {
    http_response_code(403);
    header('Cache-Control: no-store');
    exit;
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$row = ast_listing($pdo, $id, 'uk');
if ($row === null) {
    http_response_code(404);
    exit;
}
$staff = mp_is_staff();
$owner = auth_user_id() !== null && (int) $row['seller_user_id'] === auth_user_id();
if (!ast_is_live($row) && !$staff && !$owner) {
    http_response_code(404);
    exit;
}

// Сигнал вставлення на чужій сторінці (hotlink) — без блокування.
$bare = static fn(string $h): string => (string) preg_replace('/^www\./', '', strtolower(explode(':', $h)[0]));
$host = $bare((string) ($_SERVER['HTTP_HOST'] ?? ''));
$refHost = $bare((string) parse_url((string) ($_SERVER['HTTP_REFERER'] ?? ''), PHP_URL_HOST));
$fetchSite = strtolower((string) ($_SERVER['HTTP_SEC_FETCH_SITE'] ?? ''));
$signal = $fetchSite === 'cross-site' || ($refHost !== '' && $refHost !== $host) ? 'hotlink' : null;

if (!$staff && !$owner && !ast_preview_gate($pdo, ast_anon_hash(), $id, $signal)) {
    http_response_code(429);
    header('Retry-After: 300');
    header('Cache-Control: no-store');
    header('Content-Type: text/plain; charset=utf-8');
    echo ast_tr('rate_limited');
    exit;
}

$path = ast_path('preview', $row['preview_name'] ?? null);
if ($path === null) {
    http_response_code(404);
    exit;
}
$robots = ['noai', 'noimageai'];
if ((int) $row['noimageindex'] === 1) {
    $robots[] = 'noimageindex';
}
header('Content-Type: ' . (str_ends_with($path, '.webp') ? 'image/webp' : 'image/jpeg'));
header('Content-Length: ' . (string) filesize($path));
header('Cache-Control: private, max-age=' . max(0, min(3600, $exp - time())));
header('X-Robots-Tag: ' . implode(', ', $robots));
header('Content-Disposition: inline; filename="ailabhub-preview-' . $id . (str_ends_with($path, '.webp') ? '.webp' : '.jpg') . '"');
readfile($path);
