<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: підтвердження email за посиланням з листа (?token=...).
 *
 * GET лише показує сторінку з кнопкою «Підтвердити email» і токен НЕ витрачає (поштові сканери, що
 * відкривають посилання, не «спалюють» його). Підтвердження виконує POST із CSRF-токеном.
 * Токен одноразовий, дійсний 24 год; у БД лише sha256. Причини відмови (недійсне / прострочене /
 * використане / email змінено) не розкривають нічого про акаунти.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-email.php';

mp_public_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

header('Cache-Control: no-store');
header('Referrer-Policy: no-referrer');

$isPost = ($_SERVER['REQUEST_METHOD'] ?? '') === 'POST';
$src = $isPost ? $_POST : $_GET;
$token = is_string($src['token'] ?? null) ? trim((string) $src['token']) : '';

if ($isPost) {
    mpb_require_post();
    $res = mpv_confirm($pdo, $token);
} else {
    $res = mpv_check($pdo, $token)['status'];   // лише перевірка, без витрачання
}

if ($res !== 'ok') {
    $key = match ($res) {
        'expired' => 'mpv_expired',
        'used'    => 'mpv_used',
        'changed' => 'mpv_changed',
        default   => 'mpv_invalid',
    };
    mpb_message_page(
        400,
        t('mpv_fail_title'),
        '<p class="mp-text">' . mp_e(t($key)) . '</p><p class="mp-actions"><a class="mp-btn mp-btn--primary" href="mp-verify-email.php">' . mp_e(t('mpv_send_btn')) . '</a></p>',
        null
    );
}

if ($isPost) {
    mpb_message_page(
        200,
        t('mpv_ok_title'),
        '<p class="mp-text">' . mp_e(t('mpv_ok')) . '</p><p class="mp-actions"><a class="mp-btn mp-btn--primary" href="mp-post.php">' . mp_e(t('mpb_post_btn')) . '</a>'
        . '<a class="mp-btn" href="marketplace.php">' . mp_e(t('mp_heading')) . '</a></p>',
        null
    );
}

// GET, токен чинний: сторінка з кнопкою (POST + CSRF).
mpb_message_page(
    200,
    t('mpv_confirm_title'),
    '<p class="mp-text">' . mp_e(t('mpv_confirm_text')) . '</p>'
    . '<form method="post" action="mp-verify.php" class="mp-inline-form">' . mp_csrf_field()
    . '<input type="hidden" name="token" value="' . mp_e($token) . '">'
    . '<button class="mp-btn mp-btn--primary" type="submit">' . mp_e(t('mpv_confirm_btn')) . '</button></form>',
    null
);
