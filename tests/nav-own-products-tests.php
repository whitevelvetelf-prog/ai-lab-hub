<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тест пункту меню «Власні продукти» → «Ігри» → «Багвіль» (app/site-header.php).
 *   php tests/nav-own-products-tests.php
 * Перевіряє: поки bugville_public = false, пункт бачить лише admin (гість і user — ні, бо гра для них 404);
 * коли bugville_public = true — усі; структура: <details>, підзаголовок «Ігри», посилання «Багвіль» на bugville.php,
 * скрипт site-nav-group.js; українські рядки є. Лише CLI, нічого не змінює.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$_SERVER['REQUEST_METHOD'] = 'GET';
$_SERVER['SCRIPT_NAME'] = '/index.php';
require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/bugville/bv-config.php';
while (ob_get_level() > 0) {
    ob_end_clean();   // auth.php відкриває буфер для OG-тегів
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

/** Розмітка шапки для ролі (null — гість) і значення bugville_public. */
function header_html(?string $role, bool $public): string
{
    $_SESSION = $role === null ? [] : ['user_id' => 990000999, 'role' => $role];
    $GLOBALS['bv_cfg_override'] = ['bugville_public' => $public];
    ob_start();
    include __DIR__ . '/../app/site-header.php';

    return (string) ob_get_clean();
}

check(t('nav_own_products') === 'Власні продукти' && t('nav_games') === 'Ігри' && t('nav_bugville') === 'Багвіль', 'українські підписи');
check(!str_contains(header_html(null, false), 'site-nav__group'), 'гра закрита: гість не бачить пункту');
check(!str_contains(header_html('user', false), 'site-nav__group'), 'гра закрита: user не бачить пункту');
$admin = header_html('admin', false);
check(str_contains($admin, 'site-nav__group'), 'гра закрита: admin бачить пункт');
check(str_contains(header_html(null, true), 'site-nav__group'), 'гра відкрита: гість бачить пункт');

$h = header_html(null, true);
$posGroup = strpos($h, 'Власні продукти');
$posGames = strpos($h, '>Ігри<');
$posBv = strpos($h, 'href="bugville.php">Багвіль</a>');
check(str_contains($h, '<details class="site-nav__group">') && $posGroup !== false && $posGames > $posGroup && $posBv > $posGames,
    'структура: «Власні продукти» → «Ігри» → «Багвіль» (bugville.php)');
check(str_contains($h, '/assets/js/site-nav-group.js'), 'скрипт закриття меню підключено');
$GLOBALS['bv_cfg_override'] = [];

echo "\n" . ($fails === 0 ? "PASS $total/$total" : "FAIL $fails з $total") . "\n";
exit($fails === 0 ? 0 : 1);
