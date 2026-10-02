<?php

declare(strict_types=1);

/**
 * AI LAB HUB — початок входу через Google (OAuth 2.0 + PKCE).
 *
 * Без параметрів — вхід/реєстрація (з login.php, register.php).
 * ?mode=link — прив'язка Google до вже відкритої сесії (з кабінету account.php).
 * Формує URL згоди Google і перенаправляє туди; повернення —
 * public/auth-google-callback.php.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/oauth.php';

$mode = (string) ($_GET['mode'] ?? '') === 'link' ? 'link' : 'login';

if (!oauth_provider_enabled('google')) {
    $_SESSION['oauth_error'] = sprintf(t('social_error_disabled'), 'Google');
    header('Location: ' . ($mode === 'link' && auth_check() ? 'account.php' : 'login.php'));
    exit;
}

// Прив'язка має сенс лише з відкритою сесією; вхід — лише без неї.
if ($mode === 'link' && !auth_check()) {
    $mode = 'login';
}
if ($mode === 'login' && auth_check()) {
    header('Location: account.php');
    exit;
}

$flow = oauth_begin('google', $mode);

header('Location: ' . oauth_google_auth_url($flow['state'], $flow['code_challenge']));
exit;
