<?php

declare(strict_types=1);

/**
 * AI LAB HUB — збереження реквізитів донатів (розділ «Донати» в account.php).
 * Лише POST, лише admin (перевірка за БД), CSRF обов'язковий.
 * Помилка валідації — нічого не зберігається, введене повертається у форму.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/donations.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST' || !donate_is_admin($pdo, auth_user_id())) {
    header('Location: account.php');
    exit;
}

$back = static function (bool $ok, array $msgs): never {
    $_SESSION['donate_flash'] = ['ok' => $ok, 'msgs' => $msgs];
    header('Location: account.php#acc-donate', true, 303);
    exit;
};

if (!donate_csrf_verify()) {
    $back(false, ['Сесія застаріла. Оновіть сторінку й спробуйте ще раз.']);
}

[$values, $errors] = donate_validate($_POST);
if ($errors !== []) {
    $_SESSION['donate_old'] = array_intersect_key($_POST, DONATE_FIELDS);
    $back(false, $errors);
}

try {
    site_settings_save($pdo, $values);
} catch (Throwable $e) {
    error_log('[donate] save: ' . $e->getMessage());
    $back(false, ['Не вдалося зберегти. Чи застосовано міграцію site_settings?']);
}

$back(true, [$values['donate_enabled'] === '1'
    ? 'Збережено. Сторінка донатів увімкнена.'
    : 'Збережено. Сторінка донатів вимкнена — відвідувачі бачать «Скоро».']);
