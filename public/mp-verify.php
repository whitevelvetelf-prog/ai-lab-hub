<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: підтвердження email за посиланням з листа (?token=...).
 * Токен одноразовий, дійсний 24 год; у БД лише sha256. Результат — повідомлення; причини відмови
 * (невірний / прострочений / використаний / email змінено) не розкривають нічого про акаунти.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-email.php';

mp_public_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$token = is_string($_GET['token'] ?? null) ? trim((string) $_GET['token']) : '';
$res = mpv_confirm($pdo, $token);
header('Cache-Control: no-store');
header('Referrer-Policy: no-referrer');

$links = '<p class="mp-actions">';
if ($res === 'ok') {
    $links .= '<a class="mp-btn mp-btn--primary" href="mp-post.php">' . mp_e(t('mpb_post_btn')) . '</a><a class="mp-btn" href="marketplace.php">' . mp_e(t('mp_heading')) . '</a>';
} else {
    $links .= '<a class="mp-btn mp-btn--primary" href="mp-verify-email.php">' . mp_e(t('mpv_send_btn')) . '</a>';
}
$links .= '</p>';

$key = match ($res) {
    'ok'      => 'mpv_ok',
    'expired' => 'mpv_expired',
    'used'    => 'mpv_used',
    'changed' => 'mpv_changed',
    default   => 'mpv_invalid',
};
mpb_message_page($res === 'ok' ? 200 : 400, t($res === 'ok' ? 'mpv_ok_title' : 'mpv_fail_title'), '<p class="mp-text">' . mp_e(t($key)) . '</p>' . $links, null);
