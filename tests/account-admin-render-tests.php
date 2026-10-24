<?php

declare(strict_types=1);

/**
 * AI LAB HUB — кабінет адміністратора рендериться до кінця: усі розділи-акордеони,
 * підвал (app/footer.php: «Моя добірка», UA/EN, скрипти шапки й акордеонів) і </html>.
 *   php tests/account-admin-render-tests.php [user_id]
 * Лише CLI. Бере першого admin із локальної БД (або user_id з аргументу).
 * Регресія 2026-10-24: фатальна помилка в «Реклама: адмін» (AD_POPUP_SKIP_MIN без
 * app/ad-popup.php) обривала сторінку — зникали решта розділів і вся інтерактивність.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$fails = 0;
$total = 0;
function check(bool $cond, string $label): void
{
    global $fails, $total;
    $total++;
    echo ($cond ? '  OK   ' : '  FAIL ') . $label . "\n";
    if (!$cond) {
        $fails++;
    }
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$uid = isset($argv[1]) ? (int) $argv[1]
    : (int) $pdo->query("SELECT id FROM users WHERE role = 'admin' ORDER BY id LIMIT 1")->fetchColumn();
$_SERVER['REQUEST_METHOD'] = 'GET';
$_SERVER['HTTP_HOST'] = 'ai-lab-hub.test';
$_SERVER['REQUEST_URI'] = '/account.php';
$_SERVER['SCRIPT_NAME'] = '/account.php';
session_id('acctest' . getmypid());
session_start();
$_SESSION['user_id'] = $uid;
$_SESSION['role'] = 'admin';
check($uid > 0, "є адміністратор у БД (id {$uid})");

$html = '';
$error = null;
chdir(__DIR__ . '/../public');
ob_start();
try {
    include __DIR__ . '/../public/account.php';
} catch (Throwable $e) {
    $error = $e;
}
$html = (string) ob_get_clean();

check($error === null, 'без винятків' . ($error !== null ? ': ' . $error->getMessage() . ' @ ' . basename($error->getFile()) . ':' . $error->getLine() : ''));
check(str_contains($html, '</html>'), 'сторінка дорендерена до </html>');
foreach (['acc-saved', 'acc-login-methods', 'acc-donate', 'acc-listings', 'acc-assets', 'acc-listings-admin',
          'acc-stats', 'requests', 'acc-position', 'acc-crm'] as $id) {
    check(str_contains($html, 'id="' . $id . '"'), "розділ #{$id}");
}
check(str_contains($html, "a.href = 'saved.php'"), 'підвал підключено: пункт «Моя добірка» в шапці');
check(str_contains($html, "box.className = 'site-lang'"), 'підвал підключено: перемикач UA/EN');
check(str_contains($html, 'crm-add-product.php') && str_contains($html, 'crm-list.php'), 'CRM: додати продукт і таблиця продуктів');
check(!str_contains($html, 'Стати працівником') && !str_contains($html, 'id="employee-requests"'), 'свідомо приховані розділи працівника лишаються прихованими');

echo "\n" . ($fails === 0 ? "УСЕ PASS ({$total})" : "FAIL: {$fails} з {$total}") . "\n";
exit($fails === 0 ? 0 : 1);
