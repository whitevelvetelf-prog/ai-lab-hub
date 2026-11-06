<?php

declare(strict_types=1);

/**
 * AI LAB HUB — автозбереження чернетки форми подачі (JSON, лише залогінені, POST + CSRF).
 *
 *   POST action=save   form_key=listing:job|listing:course|listing:service|board  data=<JSON полів форми>
 *   POST action=delete form_key=…
 *
 * Відповідь: {"ok":true} або {"ok":false,"error":"…"}. Див. app/mp-drafts.php.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-email.php';
require_once __DIR__ . '/../app/mp-drafts.php';

header('Content-Type: application/json; charset=utf-8');
header('Cache-Control: no-store');

$fail = static function (int $code, string $error): never {
    http_response_code($code);
    echo json_encode(['ok' => false, 'error' => $error]);
    exit;
};

mpb_require_post(true);
$userId = auth_user_id();
if ($userId === null) {
    $fail(401, 'login');
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$key = is_string($_POST['form_key'] ?? null) ? (string) $_POST['form_key'] : '';
if (!mpd_key_valid($key)) {
    $fail(400, 'form');
}
$action = (string) ($_POST['action'] ?? 'save');
if ($action === 'delete') {
    mpd_delete($pdo, $userId, $key);
    echo json_encode(['ok' => true]);
    exit;
}
$raw = is_string($_POST['data'] ?? null) ? (string) $_POST['data'] : '';
if ($raw === '' || strlen($raw) > MPD_MAX_BYTES) {
    $fail(400, 'size');
}
$data = json_decode($raw, true);
if (!is_array($data)) {
    $fail(400, 'json');
}
if (!mpd_save($pdo, $userId, $key, $data)) {
    $fail(500, 'save');
}
echo json_encode(['ok' => true, 'saved_at' => date('H:i')]);
