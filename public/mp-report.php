<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: скарга на оголошення (POST + CSRF, лише залогінені).
 * Одна скарга на пару (користувач, оголошення). При ≥ reports_threshold (за замовчуванням 3) унікальних
 * скарг після останньої модерації оголошення автоматично повертається в pending (запис у mp_moderation_log).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-email.php';   // підключає marketplace-board.php

mp_public_require();
mpb_require_post();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$userId = mpb_require_login();
mpv_require_verified($pdo, $userId);   // скаржитись можна лише з підтвердженим email
$id = (int) ($_POST['id'] ?? 0);
$reason = is_string($_POST['reason'] ?? null) ? (string) $_POST['reason'] : '';
$note = is_string($_POST['note'] ?? null) ? trim((string) $_POST['note']) : '';

$res = $id > 0 ? mpb_report($pdo, $id, $userId, $reason, $note) : 'notfound';
$msg = match ($res) {
    'ok'        => ['ok', 'mpb_report_ok'],
    'duplicate' => ['error', 'mpb_report_duplicate'],
    'own'       => ['error', 'mpb_report_own'],
    'invalid'   => ['error', 'mpb_report_invalid'],
    default     => ['error', 'mpb_report_notfound'],
};
mpb_flash($msg[0], t($msg[1]));
// Після скарги оголошення могло піти на модерацію (публічно зникає) — тоді повертаємо в список.
$live = $pdo->prepare('SELECT 1 FROM mp_listings l WHERE l.id = :id AND ' . mpb_visible_sql());
$live->execute([':id' => $id]);
mpb_redirect($live->fetchColumn() !== false ? 'offer.php?id=' . $id : 'marketplace.php');
