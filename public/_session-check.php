<?php

declare(strict_types=1);

/**
 * AI LAB HUB — разова діагностика сесії й кешу на живому хостингу (лише admin, лише читання, без секретів).
 *
 *   /_session-check.php          — крок 1: записує в сесію випадкову мітку й переходить на крок 2
 *   /_session-check.php?step=2   — крок 2: чи збереглася сесія між двома запитами + звіт; після показу ФАЙЛ ВИДАЛЯЄ СЕБЕ
 *
 * Не admin (або гість) — 404, файл лишається. Ідентифікатор сесії показується лише першими 6 символами;
 * сіль, паролі й вміст конфігів не виводяться.
 */

require_once __DIR__ . '/../app/auth.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$user = auth_current_user($pdo);
if ($user === null || (string) $user['role'] !== 'admin') {
    http_response_code(404);
    exit;
}

header('Cache-Control: no-store');
header('X-Robots-Tag: noindex, nofollow');

if (($_GET['step'] ?? '') !== '2') {
    $_SESSION['sc_probe'] = bin2hex(random_bytes(8));
    $_SESSION['sc_sid'] = session_id();
    header('Location: _session-check.php?step=2', true, 302);
    exit;
}

$probeOk = isset($_SESSION['sc_probe']) && is_string($_SESSION['sc_probe']) && strlen($_SESSION['sc_probe']) === 16;
$sameId = ($_SESSION['sc_sid'] ?? '') === session_id();
unset($_SESSION['sc_probe'], $_SESSION['sc_sid']);

$cookie = session_get_cookie_params();
$savePath = (string) ini_get('session.save_path');
$ownDir = realpath(dirname(__DIR__) . '/storage/sessions');
$base = app_canonical_base();
$host = strtolower((string) ($_SERVER['HTTP_HOST'] ?? ''));
$siteUrl = '';
foreach (['marketplace.local.php', 'marketplace.php'] as $n) {
    $f = __DIR__ . '/../config/' . $n;
    $c = is_file($f) ? require $f : null;
    if (is_array($c) && $siteUrl === '' && !empty($c['site_url'])) {
        $siteUrl = (string) $c['site_url'];
    }
}
// Що отримав би www-варіант (без реального запиту).
$saved = $_SERVER;
$_SERVER['HTTP_HOST'] = $base !== null ? 'www.' . $base['host'] : $host;
$_SERVER['REQUEST_METHOD'] = 'GET';
$_SERVER['REQUEST_URI'] = '/login.php';
$wwwTarget = app_canonical_redirect_target();
$_SERVER = $saved;
$sw = (string) @file_get_contents(__DIR__ . '/sw.js');
preg_match("/CACHE_NAME = '([^']+)'/", $sw, $swm);
$cacheHeaders = array_values(array_filter(headers_list(), static fn(string $h): bool => (bool) preg_match('/^(Cache-Control|Expires|Pragma):/i', $h)));

$rows = [
    'Схема запиту' => app_request_is_https() ? 'https' : 'http',
    'Хост запиту' => $host,
    'site_url (конфіг)' => $siteUrl !== '' ? $siteUrl : '(порожньо)',
    'Канонічна адреса' => $base !== null ? $base['scheme'] . '://' . $base['host'] . $base['port'] : '(вимкнено / не задано)',
    'www → куди (симуляція)' => $wwwTarget ?? '(без редіректу)',
    'Сесія збереглася між 2 запитами' => $probeOk ? 'ТАК' : 'НІ',
    'Той самий id сесії' => $sameId ? 'так' : 'ні',
    'Кукі сесії надіслано браузером' => isset($_COOKIE[session_name()]) ? 'так' : 'ні',
    'Ім\'я кукі' => session_name(),
    'id сесії (початок)' => substr(session_id(), 0, 6) . '…',
    'cookie lifetime' => $cookie['lifetime'] . ' с (' . round($cookie['lifetime'] / 86400, 1) . ' дн.)',
    'cookie path / domain' => $cookie['path'] . ' / ' . ($cookie['domain'] !== '' ? $cookie['domain'] : '(лише цей хост)'),
    'cookie Secure / HttpOnly / SameSite' => ($cookie['secure'] ? 'Secure' : 'не Secure') . ' / ' . ($cookie['httponly'] ? 'HttpOnly' : 'не HttpOnly') . ' / ' . ($cookie['samesite'] ?: '(не задано)'),
    'session.save_path' => $ownDir !== false && realpath($savePath) === $ownDir ? 'storage/sessions (власна тека)' : 'типова тека хостингу',
    'Тека storage/sessions' => $ownDir === false ? 'немає' : (is_writable($ownDir) ? 'є, запис дозволено' : 'є, БЕЗ права запису'),
    'session.gc_maxlifetime' => ini_get('session.gc_maxlifetime') . ' с',
    'session.gc_probability / divisor' => ini_get('session.gc_probability') . ' / ' . ini_get('session.gc_divisor'),
    'session.use_strict_mode' => ini_get('session.use_strict_mode'),
    'session.cache_limiter' => (string) ini_get('session.cache_limiter'),
    'Заголовки кешу цієї сторінки' => implode(' | ', $cacheHeaders),
    'Версія кешу sw.js' => $swm[1] ?? '?',
    'PHP' => PHP_VERSION,
];

$deleted = @unlink(__FILE__);
?>
<!DOCTYPE html>
<html lang="uk">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="robots" content="noindex, nofollow">
<title>Перевірка сесії</title>
<style>
    body { margin: 0; padding: 16px; background: #00032c; color: #fff; font: 15px/1.5 system-ui, sans-serif; }
    table { width: 100%; border-collapse: collapse; }
    td { padding: 8px; border-bottom: 1px solid rgba(255,255,255,.15); vertical-align: top; overflow-wrap: anywhere; }
    td:first-child { width: 40%; color: rgba(255,255,255,.75); }
    .ok { color: #7ee2a8; } .bad { color: #fca5a5; }
</style>
</head>
<body>
<h1>Перевірка сесії й кешу</h1>
<table>
<?php foreach ($rows as $k => $v): ?>
    <tr><td><?= htmlspecialchars($k, ENT_QUOTES) ?></td><td><?= htmlspecialchars((string) $v, ENT_QUOTES) ?></td></tr>
<?php endforeach; ?>
</table>
<p class="<?= $deleted ? 'ok' : 'bad' ?>"><?= $deleted ? 'Файл _session-check.php видалено з сервера.' : 'Не вдалося видалити файл — видаліть public/_session-check.php вручну.' ?></p>
</body>
</html>
