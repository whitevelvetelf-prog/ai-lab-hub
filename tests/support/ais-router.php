<?php

declare(strict_types=1);

/**
 * Роутер вбудованого сервера PHP лише для tests/ai-statement-tests.php (tests/ у збірку не потрапляє).
 * AIS_TEST_FILE (env) — тимчасова копія тексту замість docs/ai_statement_uk.md; заголовки X-Ais-Test-Uid /
 * X-Ais-Test-Lang — вхід тестовим користувачем (роль береться з БД через mp_live_role()) і мова. Вбудований сервер
 * .htaccess не читає, тому прямий доступ до docs/ тест перевіряє на Apache (Laragon).
 */
if (PHP_SAPI !== 'cli-server') {
    http_response_code(404);
    exit;
}
$path = (string) parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$public = realpath(__DIR__ . '/../../public');
$file = realpath($public . $path);
if ($file === false || !str_starts_with($file, $public) || !str_ends_with($file, '.php')) {
    http_response_code(404);
    exit;
}
$override = getenv('AIS_TEST_FILE');
if (is_string($override) && $override !== '') {
    define('AIS_FILE', $override);
}
$_SERVER['SCRIPT_NAME'] = $path;
$_SERVER['PHP_SELF'] = $path;
chdir($public);
require_once __DIR__ . '/../../app/auth.php';
$uid = (int) ($_SERVER['HTTP_X_AIS_TEST_UID'] ?? 0);
if ($uid > 0) {
    $_SESSION['user_id'] = $uid;
}
$lang = (string) ($_SERVER['HTTP_X_AIS_TEST_LANG'] ?? '');
if ($lang !== '') {
    $_SESSION['lang'] = $lang;   // current_lang() бере мову з сесії
}
require $file;
