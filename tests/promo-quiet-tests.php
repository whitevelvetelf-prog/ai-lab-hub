<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тести «тиші» реклами (app/promo-quiet.php): сторінки автентифікації,
 * мітка після входу / реєстрації / виходу, закінчення через N хвилин.
 *   php tests/promo-quiet-tests.php
 * Лише CLI. Налаштування — з локальної БД (ad_settings не змінюються: хвилини підміняються кешем).
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/promo.php';
require_once __DIR__ . '/../app/promo-admin.php';

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
$minutes = promo_quiet_minutes($pdo);
echo "Тиша: {$minutes} хв (ad_settings.promo_suppress_after_auth_minutes або " . PROMO_QUIET_DEFAULT_MINUTES . ")\n";

// --- Сторінки автентифікації
foreach (['login.php', 'register.php', 'logout.php', 'forgot-password.php', 'login-via-token.php', 'auth-google.php',
          'auth-google-callback.php', 'auth-facebook-callback.php', 'mp-verify.php', 'mp-verify-email.php', '/LOGIN.PHP'] as $p) {
    check(promo_is_auth_page($p), "сторінка автентифікації: {$p}");
}
foreach (['index.php', 'catalog.php', 'account.php', 'product.php', 'blog-post.php', 'ad-next.php', 'promo-serve.php', 'author.php', ''] as $p) {
    check(!promo_is_auth_page($p), 'звичайна сторінка: ' . ($p === '' ? '(порожньо)' : $p));
}

// --- Мітка й закінчення
$_SESSION = [];
check(promo_suppress_until($pdo) === 0 && !promo_quiet($pdo, 'catalog.php'), 'без мітки — тиші немає');

$_SESSION = ['promo_auth_at' => time()];
$until = promo_suppress_until($pdo);
check($minutes === 0 ? $until === 0 : abs($until - (time() + $minutes * 60)) <= 1, 'щойно після входу: тиша до «зараз + N хв»');
check(!isset($_SESSION['promo_auth_at']) && ($minutes === 0 || isset($_SESSION['promo_suppress_until'])), 'мітка події → promo_suppress_until у сесії');
check($minutes === 0 || promo_quiet($pdo, 'catalog.php'), 'у тиші promo_quiet() = true на звичайній сторінці');

$_SESSION = ['promo_auth_at' => time() - $minutes * 60 + 5];
check($minutes === 0 || promo_quiet($pdo, 'catalog.php'), 'за 5 с до кінця — ще тиша');

$_SESSION = ['promo_auth_at' => time() - $minutes * 60 - 1];
check(!promo_quiet($pdo, 'catalog.php'), 'через N хв — реклама повертається');
check(!isset($_SESSION['promo_suppress_until']), 'прострочена мітка прибирається із сесії');
check(promo_quiet($pdo, 'login.php'), 'на сторінці входу — без реклами й після тиші');

// Новий вхід під час тиші лише подовжує її, не скорочує.
$_SESSION = ['promo_suppress_until' => time() + 3600, 'promo_auth_at' => time()];
check(promo_suppress_until($pdo) >= time() + 3599, 'нова подія не скорочує довшу тишу');

// auth_promo_quiet_mark() — лише при активній сесії.
$_SESSION = [];
auth_promo_quiet_mark();
check(session_status() === PHP_SESSION_ACTIVE ? isset($_SESSION['promo_auth_at']) : !isset($_SESSION['promo_auth_at']), 'auth_promo_quiet_mark() поважає стан сесії');

// Налаштування в адмінці: правило збереження.
check((PROMO_SETTING_RULES['promo_suppress_after_auth_minutes'] ?? null) === ['int', 0, 1440] , 'адмінка: правило int 0–1440');

echo "\n" . ($fails === 0 ? "УСЕ PASS ({$total})" : "FAIL: {$fails} з {$total}") . "\n";
exit($fails === 0 ? 0 : 1);
