<?php

declare(strict_types=1);

/**
 * AI LAB HUB — перемикачі сайту в кабінеті адміна (POST + CSRF, лише admin).
 *
 * Зараз один: marketplace_public (site_settings) — показувати Marketplace відвідувачам
 * (app/marketplace.php: mp_public_switch_on()). Форма — account.php, розділ CRM.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/site-settings.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

if (auth_role() !== 'admin' || ($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
    header('Location: account.php', true, 303);
    exit;
}

$sent = $_POST['csrf'] ?? '';
$ok = false;
if (is_string($sent) && is_string($_SESSION['site_settings_csrf'] ?? null) && hash_equals($_SESSION['site_settings_csrf'], $sent)) {
    $key = (string) ($_POST['key'] ?? '');
    if ($key === 'marketplace_public') {
        try {
            site_settings_save($pdo, ['marketplace_public' => ($_POST['value'] ?? '') === '1' ? '1' : '0']);
            $ok = true;
        } catch (Throwable $e) {
            error_log('[admin-site-settings] ' . $e->getMessage());
        }
    }
}
$_SESSION['site_settings_flash'] = $ok;
header('Location: account.php#acc-crm', true, 303);
exit;
