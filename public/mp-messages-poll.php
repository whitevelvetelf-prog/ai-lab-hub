<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: нові повідомлення розмови (JSON) для сторінки mp-thread.php.
 *
 *   GET mp-messages-poll.php?c=N&since=ID   → {ok, messages:[…до 50], last_id, readonly}
 *
 * Лише учасник розмови (перевірка на кожен запит; чужа → 404). ETag = останнє повідомлення + стан «лише читання»;
 * If-None-Match збігається → 304 без тіла. Ліміт частоти: не частіше 1 запиту на 4 с на розмову в сесії (429)
 * і добовий IP-ліміт ip_limit_poll. Повертає лише нові повідомлення й позначає їх прочитаними.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/mp-messages.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
msg_private_headers();
header('Content-Type: application/json; charset=utf-8');

$fail = static function (int $status, string $code): never {
    http_response_code($status);
    echo json_encode(['ok' => false, 'error' => $code]);
    exit;
};

if (!msg_enabled($pdo)) {
    $fail(404, 'disabled');
}
if (!auth_check()) {
    $fail(401, 'login');
}
$uid = (int) auth_user_id();
$convId = (int) ($_GET['c'] ?? 0);
$since = max(0, (int) ($_GET['since'] ?? 0));
$conv = $convId > 0 ? msg_conversation($pdo, $convId) : null;
$role = $conv !== null ? msg_access($conv, $uid) : null;
if ($role === null) {
    $fail(404, 'notfound');
}

// Частота: сесія (на розмову) + IP за добу.
$key = 'msg_poll_' . $convId;
$now = microtime(true);
if (isset($_SESSION[$key]) && $now - (float) $_SESSION[$key] < 4.0) {
    header('Retry-After: 5');
    $fail(429, 'rate');
}
$_SESSION[$key] = $now;
if (!mpb_is_staff() && !mpb_ip_hit($pdo, 'msg_poll', (int) msg_cfg('ip_limit_poll'))) {
    header('Retry-After: 60');
    $fail(429, 'rate');
}

$listing = msg_listing($pdo, (int) $conv['listing_id']);
$readonly = msg_is_readonly($conv, $listing);
$lastId = msg_last_id($pdo, $convId);
$etag = '"m' . $convId . '-' . $lastId . '-' . $since . '-' . ($readonly ? 1 : 0) . '"';
header('ETag: ' . $etag);
$given = (string) ($_SERVER['HTTP_IF_NONE_MATCH'] ?? '');
if ($given !== '' && hash_equals($etag, trim($given))) {
    http_response_code(304);
    exit;
}

$rows = $lastId > $since ? msg_messages($pdo, $conv, $role, $uid, $since, MSG_POLL_MAX) : [];
if ($rows !== []) {
    msg_mark_read($pdo, $convId, msg_state_uid($role, $uid), (int) end($rows)['id']);
}
echo json_encode(['ok' => true, 'messages' => $rows, 'last_id' => $lastId, 'readonly' => $readonly], JSON_UNESCAPED_UNICODE);
