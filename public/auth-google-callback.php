<?php

declare(strict_types=1);

/**
 * AI LAB HUB — повернення від Google після згоди (OAuth 2.0 + PKCE).
 *
 * 1) Перевіряє state (захист від CSRF) і обмінює код на access token.
 * 2) Отримує профіль: google_user_id (sub), email, email_verified, ім'я.
 * 3) Режим 'link' (з кабінету) — прив'язує Google до поточного користувача.
 *    Режим 'login' — app/oauth.php → social_resolve_login(): наявна прив'язка,
 *    або наявний users з тим самим (підтвердженим Google) email, або новий
 *    користувач (роль user, password_hash = '', вхід лише через Google /
 *    посилання на email). Потім вхід і редірект на account.php.
 * Помилки — повідомлення в $_SESSION['oauth_error'] і повернення на login.php
 * (або account.php у режимі прив'язки).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/oauth.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

/** Повертає з помилкою на сторінку входу чи кабінету. */
function oauth_fail(string $messageKey, string $target): void
{
    $_SESSION['oauth_error'] = sprintf(t($messageKey), 'Google');
    header('Location: ' . $target);
    exit;
}

$flow = oauth_finish('google', (string) ($_GET['state'] ?? ''));
$target = ($flow !== null && $flow['mode'] === 'link' && auth_check()) ? 'account.php' : 'login.php';

if ($flow === null || !oauth_provider_enabled('google')) {
    oauth_fail('social_error_generic', $target);
}

// Користувач відмовився на сторінці згоди або Google повернув помилку.
$code = (string) ($_GET['code'] ?? '');
if (isset($_GET['error']) || $code === '') {
    oauth_fail('social_error_generic', $target);
}

$profile = oauth_google_fetch_profile($code, $flow['verifier']);
if ($profile === null) {
    oauth_fail('social_error_generic', $target);
}

// --- Прив'язка до вже відкритої сесії (кнопка «Прив'язати» в кабінеті) ---
if ($flow['mode'] === 'link' && auth_check()) {
    $userId = (int) auth_user_id();
    $ownerId = social_find_user_id($pdo, 'google', $profile['id']);

    if ($ownerId !== null && $ownerId !== $userId) {
        oauth_fail('social_error_taken', 'account.php');
    }

    try {
        social_link($pdo, $userId, 'google', $profile['id'], $profile['email']);
    } catch (PDOException $ex) {
        // 23000 — у користувача вже прив'язано інший акаунт Google (uq_social_user_provider).
        if ($ex->getCode() === '23000') {
            oauth_fail('social_error_taken', 'account.php');
        }
        throw $ex;
    }

    $_SESSION['account_flash'] = sprintf(t('account_social_linked_flash'), 'Google');
    header('Location: account.php');
    exit;
}

// --- Вхід / реєстрація ---
$result = social_resolve_login($pdo, 'google', $profile);
if (is_string($result)) {
    oauth_fail($result, 'login.php');
}

auth_login($result);

header('Location: account.php');
exit;
