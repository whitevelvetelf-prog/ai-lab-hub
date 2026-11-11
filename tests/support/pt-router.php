<?php

declare(strict_types=1);

/**
 * Роутер вбудованого сервера PHP лише для tests/ai-fixes-tests.php (tests/ у збірку не потрапляє).
 * Заголовки: X-Pt-Uid — вхід тестовим користувачем (роль з БД), X-Pt-Lang — мова інтерфейсу.
 * Env AIS_TEST_FILE — тимчасова копія docs/ai_statement_uk.md (як у ais-router.php).
 * Env PT_CALLS_FILE — замість Google Translation підставляється фейковий перекладач ("EN: " + текст),
 * кожен його виклик дописується рядком у цей файл (так тест рахує звернення до API).
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
$ais = getenv('AIS_TEST_FILE');
if (is_string($ais) && $ais !== '') {
    define('AIS_FILE', $ais);   // копія тексту «Як ми використовуємо АІ» (з маркерами чи без)
}
$calls = getenv('PT_CALLS_FILE');
if (is_string($calls) && $calls !== '') {
    function pt_fake_translate(array $texts, string $target, string $source): array
    {
        file_put_contents((string) getenv('PT_CALLS_FILE'), $target . ' ' . count($texts) . "\n", FILE_APPEND | LOCK_EX);

        return array_map(static fn(string $t): string => 'EN: ' . $t, $texts);
    }
    define('PRODUCT_TRANSLATE_FN', 'pt_fake_translate');
}
$_SERVER['SCRIPT_NAME'] = $path;
$_SERVER['PHP_SELF'] = $path;
chdir($public);
require_once __DIR__ . '/../../app/auth.php';
$uid = (int) ($_SERVER['HTTP_X_PT_UID'] ?? 0);
if ($uid > 0) {
    $pdoR = require __DIR__ . '/../../config/database.php';
    $st = $pdoR->prepare('SELECT role FROM users WHERE id = :id');
    $st->execute([':id' => $uid]);
    $_SESSION['user_id'] = $uid;
    $_SESSION['role'] = (string) $st->fetchColumn();
}
$lang = (string) ($_SERVER['HTTP_X_PT_LANG'] ?? '');
if ($lang !== '') {
    $_SESSION['lang'] = $lang;
}
require $file;
