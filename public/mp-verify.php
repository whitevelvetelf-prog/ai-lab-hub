<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: підтвердження email за посиланням з листа (?token=...).
 *
 * Працює БЕЗ входу: токен прив'язаний до user_id, успіх записується в БД незалежно від поточної сесії
 * (посилання часто відкривається в іншому браузері чи застосунку, ніж той, де користувач залогінений).
 * GET лише показує сторінку з кнопкою і токен НЕ витрачає (поштові сканери, що відкривають посилання,
 * не «спалюють» його). Підтвердження — POST з тим самим токеном. CSRF-токен сесії тут не потрібен:
 * секрет — сам токен з листа, а вимога сесії ламала підтвердження, коли кукі в цьому браузері ще немає.
 * Токен одноразовий, дійсний 24 год; у БД лише sha256. Повторне відкриття посилання після успіху —
 * «Пошту вже підтверджено», а не помилка. Після успіху — «Продовжити» на сторінку, з якої просили
 * підтвердження (next_path токена); без сесії — вхід із поверненням туди ж.
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

$res = $isPost ? mpv_confirm($pdo, $token) : mpv_check($pdo, $token);
if ($isPost && $res['status'] === 'ok') {
    auth_promo_quiet_mark();   // пошту підтверджено — кілька хвилин без реклами (app/promo-quiet.php)
}

// Посилання вже використане чи прострочене, але пошту цього акаунта підтверджено — це успіх, не помилка.
$alreadyVerified = $res['user_id'] > 0 && in_array($res['status'], ['used', 'expired'], true) && mpv_verified_at($pdo, $res['user_id']) !== null;

/** Кнопка «Продовжити»: зі сесією цього користувача — на next; без сесії — вхід із поверненням. */
$continueHtml = static function (array $res): string {
    $next = $res['next'] ?? null;
    $sessionUser = auth_user_id();
    $html = '';
    if ($sessionUser === null) {
        $html .= '<p class="mp-text">' . mp_e(mpf_tr('v_done_login')) . '</p>';
        $href = auth_login_url($next ?? 'account.php');
        $label = mpf_tr('v_login_continue');
    } else {
        if ($sessionUser !== $res['user_id']) {
            $html .= '<p class="mp-note">' . mp_e(mpf_tr('v_done_other_user')) . '</p>';
        }
        $href = $next ?? 'account.php';
        $label = mpf_tr('v_continue');
    }

    return $html . '<p class="mp-actions"><a class="mp-btn mp-btn--primary" href="' . mp_e($href) . '">' . mp_e($label) . '</a></p>';
};

if (($isPost && $res['status'] === 'ok') || $alreadyVerified) {
    mpb_message_page(200, mpf_tr('v_done_title'), '<p class="mp-text">' . mp_e(mpf_tr('v_done_text')) . '</p>' . $continueHtml($res), null);
}

if ($res['status'] !== 'ok') {
    $key = match ($res['status']) {
        'expired' => 'mpv_expired',
        'used'    => 'mpv_used',
        'changed' => 'mpv_changed',
        default   => 'mpv_invalid',
    };
    mpb_message_page(
        400,
        t('mpv_fail_title'),
        '<p class="mp-text">' . mp_e(t($key)) . '</p><p class="mp-actions"><a class="mp-btn mp-btn--primary" href="'
        . mp_e(mpv_page_url($res['next'] ?? null)) . '">' . mp_e(t('mpv_send_btn')) . '</a></p>',
        null
    );
}

// GET, токен чинний: сторінка з кнопкою (POST з токеном; входити не потрібно).
mpb_message_page(
    200,
    t('mpv_confirm_title'),
    '<p class="mp-text">' . mp_e(mpf_tr('v_confirm_text')) . '</p>'
    . '<form method="post" action="mp-verify.php" class="mp-inline-form">'
    . '<input type="hidden" name="token" value="' . mp_e($token) . '">'
    . '<button class="mp-btn mp-btn--primary mp-btn--lg" type="submit">' . mp_e(t('mpv_confirm_btn')) . '</button></form>',
    null
);
