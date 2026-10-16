<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Перевірити з'єднання з AI» (POST з admin-stats.php, лише admin, CSRF,
 * не частіше разу на ELI_DIAG_COOLDOWN секунд). Результат кладеться в сесію й показується
 * в блоці «Еля» на admin-stats.php (app/eli-diagnostics.php). Ключ ніде не виводиться.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/eli-diagnostics.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

if (auth_role() !== 'admin' || ($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
    header('Location: account.php', true, 303);
    exit;
}

$sent = $_POST['csrf'] ?? '';
if (!is_string($sent) || !is_string($_SESSION['stats_csrf'] ?? null) || !hash_equals($_SESSION['stats_csrf'], $sent)) {
    $_SESSION['eli_diag_flash'] = 'Сесія застаріла — оновіть сторінку й спробуйте ще раз.';
} elseif (($left = eli_diag_cooldown_left($pdo, true)) > 0) {
    $_SESSION['eli_diag_flash'] = 'Перевірку вже запускали щойно. Спробуйте через ' . $left . ' с.';
} else {
    @set_time_limit(60);
    $path = __DIR__ . '/../config/ai-assistant.php';
    $cfg = eli_settings(is_file($path) ? (array) (require $path) : []);
    $_SESSION['eli_diag_result'] = eli_diagnose($pdo, $cfg);
}

header('Location: admin-stats.php#eli-diag', true, 303);
exit;
