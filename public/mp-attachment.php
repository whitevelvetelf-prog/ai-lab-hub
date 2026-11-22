<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: видача вкладення повідомлення (?m=<id повідомлення>).
 *
 * Файл лежить ПОЗА коренем сайту (app/mp-messages.php → msg_attach_dir()), прямої адреси немає. Доступ:
 *   - учасник розмови (покупець, автор; для оголошень платформи — employee/admin скриньки платформи) — msg_access();
 *   - employee/admin поза скринькою платформи — ЛИШЕ якщо на цю розмову є скарга (розгляд у CRM mp-message-reports.php)
 *     або відкрито повний перегляд із записаною причиною (mp_admin_access_log, 10 хв у сесії);
 *   - усі інші, неіснуюче чи вимкнене → 404 (без підказки, що файл існує).
 * Зображення — inline (перекодовані GD при завантаженні), PDF — лише як завантаження (attachment), ніколи не в сторінці сайту.
 * nosniff, CSP sandbox, приватний кеш. Тільки GET/HEAD.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/mp-messages.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
msg_require_enabled($pdo);
msg_private_headers();

$method = $_SERVER['REQUEST_METHOD'] ?? '';
if ($method !== 'GET' && $method !== 'HEAD') {
    http_response_code(405);
    header('Allow: GET, HEAD');
    exit;
}
if (!auth_check() || !msg_chat_ready($pdo)) {
    mp_not_found();
}
$uid = (int) auth_user_id();
$mid = (int) ($_GET['m'] ?? 0);
$st = $pdo->prepare('SELECT conversation_id, attachment_path, attachment_name, attachment_mime FROM mp_messages WHERE id = :m AND attachment_path IS NOT NULL');
$st->execute([':m' => $mid]);
$row = $mid > 0 ? $st->fetch(PDO::FETCH_ASSOC) : false;
$conv = $row !== false ? msg_conversation($pdo, (int) $row['conversation_id']) : null;
if ($conv === null) {
    mp_not_found();
}
$allowed = msg_access($conv, $uid) !== null;
if (!$allowed && mp_is_staff()) {
    $rep = $pdo->prepare('SELECT 1 FROM mp_message_reports WHERE conversation_id = :c LIMIT 1');
    $rep->execute([':c' => (int) $conv['id']]);
    $allowed = $rep->fetchColumn() !== false
        || (int) ($_SESSION['msg_admin_view'][(int) $conv['id']] ?? 0) > time();   // повний перегляд із записаною причиною (журнал)
}
$path = $allowed ? msg_attach_abs((string) $row['attachment_path']) : null;
$mime = (string) $row['attachment_mime'];
if ($path === null || !isset(MSG_ATTACH_TYPES[$mime])) {
    mp_not_found();
}
session_write_close();

$ext = MSG_ATTACH_TYPES[$mime];
$name = preg_replace('/[^\p{L}\p{N} ._()-]+/u', '_', (string) $row['attachment_name']) ?? '';
$name = trim($name) !== '' ? trim($name) : 'file.' . $ext;
if (strtolower(pathinfo($name, PATHINFO_EXTENSION)) !== $ext && !($ext === 'jpg' && preg_match('/\.jpe?g$/i', $name))) {
    $name .= '.' . $ext;
}
$ascii = preg_replace('/[^A-Za-z0-9._-]+/', '_', $name) ?: ('file.' . $ext);
$disp = $ext === 'pdf' ? 'attachment' : 'inline';

header('Content-Type: ' . $mime);
header('Content-Length: ' . (string) filesize($path));
header('Content-Disposition: ' . $disp . '; filename="' . $ascii . '"; filename*=UTF-8\'\'' . rawurlencode($name));
header('X-Content-Type-Options: nosniff');
header("Content-Security-Policy: default-src 'none'; img-src 'self'; style-src 'unsafe-inline'; sandbox");
header('Cache-Control: private, max-age=3600');
if ($method === 'HEAD') {
    exit;
}
readfile($path);
