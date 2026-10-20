<?php

declare(strict_types=1);

/**
 * AI LAB HUB — завантаження оригіналу «Цифрового матеріалу».
 *
 *   POST id, accept=1, CSRF      — перевірки й одноразовий токен (assets_download_token_min хвилин) → 303 на ?t=
 *   GET  ?t=ТОКЕН                — видача файлу (токен використовується атомарно, лише тим самим користувачем)
 *
 * Умови: вхід в акаунт, живий актив, ліцензія дозволяє завантаження й автор дозволив (ast_downloadable),
 * прийняття ліцензії, денний ліміт на користувача (assets_downloads_per_day). Шлях до файлу не розкривається.
 * У виданий файл додається XMP (автор, права, адреса ліцензії, download_id), EXIF автора прибирається;
 * запис у asset_downloads (sha256 виданого файлу, хеш IP — не IP).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/asset.php';

mp_public_or_staff_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$userId = mpb_require_login();
$s = ast_settings($pdo);

$fail = static function (int $code, string $key, int $assetId = 0): never {
    mpb_message_page($code, ast_tr('download_btn'), '<p class="mp-text">' . ast_e(ast_tr($key)) . '</p>', $assetId > 0 ? 'asset.php?id=' . $assetId : 'assets.php');
};

if (($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'POST') {
    $id = (int) ($_POST['id'] ?? 0);
    if (!mp_csrf_verify()) {
        mpb_message_page(403, t('mpb_err_csrf_title'), '<p class="mp-text">' . mp_e(t('mpb_err_csrf')) . '</p>', 'asset.php?id=' . $id);
    }
    $row = $id > 0 ? ast_listing($pdo, $id, 'uk') : null;
    if ($row === null || !ast_is_live($row)) {
        mp_not_found();
    }
    if (!ast_downloadable($pdo, $row)) {
        $fail(403, 'download_not_allowed', $id);
    }
    if (($_POST['accept'] ?? '') !== '1') {
        $fail(400, 'download_need_accept', $id);
    }
    if (!mp_is_staff() && ast_downloads_today($pdo, $userId) >= (int) $s['downloads_per_day']) {
        $fail(429, 'download_limit', $id);
    }
    $token = ast_token_create($pdo, $id, $userId);
    header('Location: asset-download.php?t=' . $token, true, 303);
    exit;
}

$token = is_string($_GET['t'] ?? null) ? (string) $_GET['t'] : '';
$id = ast_token_consume($pdo, $token, $userId);
if ($id === null) {
    $fail(410, 'download_expired');
}
$row = ast_listing($pdo, $id, 'uk');
if ($row === null || !ast_is_live($row) || !ast_downloadable($pdo, $row)) {
    $fail(403, 'download_not_allowed', $id);
}
$file = ast_issue_download($pdo, $row, $userId);
if ($file === null) {
    error_log('[asset] download build failed for #' . $id);
    $fail(500, 'err_save', $id);
}
header('Content-Type: ' . $file['mime']);
header('Content-Length: ' . strlen($file['bytes']));
header('Content-Disposition: attachment; filename="' . $file['filename'] . '"');
header('Cache-Control: no-store, private');
header('X-Content-Type-Options: nosniff');
header('X-Robots-Tag: noindex, noai, noimageai');
echo $file['bytes'];
