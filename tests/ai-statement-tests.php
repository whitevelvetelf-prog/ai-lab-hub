<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тести сторінки «Як ми використовуємо АІ» (public/ai-statement.php) на ЛОКАЛЬНІЙ базі.
 *
 *   php tests/ai-statement-tests.php [http://ai-lab-hub.test]
 *
 * docs/ai_statement_uk.md НЕ змінюється: сценарії з маркерами й без них ідуть на тимчасових копіях через вбудований
 * сервер PHP (tests/support/ais-router.php, env AIS_TEST_FILE). Прямий доступ до docs/ — через Apache (аргумент).
 * Створює трьох користувачів «AIS-TEST» (user/employee/admin) і видаляє їх за id. Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
$apache = rtrim($argv[1] ?? 'http://ai-lab-hub.test', '/');
require_once __DIR__ . '/../app/ai-statement.php';
require_once __DIR__ . '/../app/mpb-rules.php';
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$T = 0;
$F = 0;
function ok(bool $cond, string $name): void
{
    global $T, $F;
    $T++;
    if (!$cond) {
        $F++;
    }
    echo ($cond ? '  OK   ' : '  FAIL ') . $name . "\n";
}
function http(string $url, ?int $uid = null, ?string $lang = null): array
{
    $ch = curl_init($url);
    $h = [];
    if ($uid !== null) {
        $h[] = 'X-Ais-Test-Uid: ' . $uid;
    }
    if ($lang !== null) {
        $h[] = 'X-Ais-Test-Lang: ' . $lang;
    }
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_TIMEOUT => 30, CURLOPT_HTTPHEADER => $h,
        CURLOPT_USERAGENT => 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 Safari/604.1']);
    $body = (string) curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    return [$code, $body];
}
/** Вбудований сервер PHP із підставленим файлом тексту. */
function serve(string $textFile, int $port): array
{
    $env = getenv();
    $env['AIS_TEST_FILE'] = $textFile;
    $null = PHP_OS_FAMILY === 'Windows' ? 'NUL' : '/dev/null';
    $proc = proc_open([PHP_BINARY, '-S', '127.0.0.1:' . $port, __DIR__ . '/support/ais-router.php'],
        [0 => ['pipe', 'r'], 1 => ['file', $null, 'w'], 2 => ['file', $null, 'w']], $pipes, dirname(__DIR__), $env);
    for ($i = 0; $i < 50; $i++) {
        $s = @fsockopen('127.0.0.1', $port, $e, $es, 0.2);
        if ($s) {
            fclose($s);
            break;
        }
        usleep(100000);
    }

    return [$proc, 'http://127.0.0.1:' . $port];
}
function stop($proc): void
{
    $st = proc_get_status($proc);
    if (PHP_OS_FAMILY === 'Windows') {
        exec('taskkill /F /T /PID ' . (int) $st['pid'] . ' >NUL 2>&1');
    } else {
        proc_terminate($proc);
    }
    proc_close($proc);
}

$orig = (string) file_get_contents(AIS_FILE);
$origHash = sha1($orig);
$tmpDir = sys_get_temp_dir() . DIRECTORY_SEPARATOR . 'ais-test-' . bin2hex(random_bytes(3));
if (!@mkdir($tmpDir, 0700, true) || !is_dir($tmpDir)) {
    fwrite(STDERR, "не вдалося створити тимчасову теку\n");
    exit(1);
}
$withMarkers = $tmpDir . DIRECTORY_SEPARATOR . 'with-markers.md';
$noMarkers = $tmpDir . DIRECTORY_SEPARATOR . 'no-markers.md';
$md = $tmpDir . DIRECTORY_SEPARATOR . 'markup.md';
file_put_contents($withMarkers, $orig);
file_put_contents($noMarkers, (string) preg_replace('/\[ПІДТВЕРДИТИ[^\]]*\]/u', 'підтверджено', $orig));
file_put_contents($md, "# Заголовок\n\nАбзац з <script>alert(1)</script> & **жирним**.\nДругий рядок абзацу.\n\n## Розділ\n\n- пункт **один**\n- пункт [посилання](privacy.php)\n- [погане](javascript:alert(1))\n");

$ids = [];
$proc = null;
try {
    foreach (['user', 'employee', 'admin'] as $role) {
        $pdo->prepare("INSERT INTO users (name, email, password_hash, role) VALUES (:n, :e, 'x', :r)")
            ->execute([':n' => 'AIS-TEST ' . $role, ':e' => 'ais-test-' . $role . '-' . bin2hex(random_bytes(3)) . '@example.invalid', ':r' => $role]);
        $ids[$role] = (int) $pdo->lastInsertId();
    }
    $n = substr_count($orig, AIS_MARKER);

    echo "== Чернетка з маркерами (копія docs/ai_statement_uk.md, маркерів: $n)\n";
    ok($n > 0, 'у чернетці є маркери');
    [$proc, $base] = serve($withMarkers, 8791);
    [$c] = http($base . '/ai-statement.php');
    ok($c === 404, "гість — 404 ($c)");
    [$c] = http($base . '/ai-statement.php', $ids['user']);
    ok($c === 404, "звичайний користувач — 404 ($c)");
    foreach (['admin', 'employee'] as $role) {
        [$c, $b] = http($base . '/ai-statement.php', $ids[$role]);
        ok($c === 200, "$role — 200 ($c)");
        ok(str_contains($b, 'mp-alert--error') && str_contains($b, 'маркерів [ПІДТВЕРДИТИ]: ' . $n), "$role — попередження з числом маркерів ($n)");
        ok(str_contains($b, 'noindex'), "$role — noindex");
    }
    [$c, $b] = http($base . '/ai-statement.php', $ids['admin'], 'en');
    ok($c === 200 && str_contains($b, '[CONFIRM] markers left') && str_contains($b, ': ' . $n), 'admin EN — попередження англійською');
    [$c, $b] = http($base . '/about.php', $ids['admin']);
    ok($c === 200 && !str_contains($b, 'href="ai-statement.php"'), "з маркерами — у підвалі посилання немає навіть для admin ($c)");
    stop($proc);
    $proc = null;

    echo "== Без маркерів (тимчасова копія)\n";
    [$proc, $base] = serve($noMarkers, 8792);
    [$c, $b] = http($base . '/ai-statement.php');
    ok($c === 200 && str_contains($b, 'Як ми використовуємо АІ'), "гість — 200 ($c)");
    ok(!str_contains($b, 'mp-alert--error') && !str_contains($b, 'noindex'), 'без попередження й без noindex');
    [$c] = http($base . '/ai-statement.php', $ids['user']);
    ok($c === 200, "користувач — 200 ($c)");
    [$c, $b] = http($base . '/about.php');
    ok(str_contains($b, 'href="ai-statement.php"'), 'посилання в підвалі з’явилося');
    [$c, $b] = http($base . '/ai-statement.php', null, 'en');
    ok($c === 200 && str_contains($b, 'Text in the original language: UA') && str_contains($b, 'lang="uk"'), 'EN — текст оригіналу з позначкою «Text in the original language: UA»');
    ok(str_contains($b, 'href="ai-statement.php">How we use AI<'), 'EN — пункт підвалу «How we use AI»');
    [$c, $b] = http($base . '/ai-statement.php');
    ok(!str_contains($b, 'Text in the original language') && !str_contains($b, 'Текст мовою оригіналу'), 'UA — без позначки мови');
    stop($proc);
    $proc = null;

    echo "== Markdown\n";
    $r = mpb_rules_render($md);
    $h = $r['html'] ?? '';
    ok(($r['title'] ?? '') === 'Заголовок', '# → заголовок сторінки');
    ok(str_contains($h, '<h2>Розділ</h2>'), '## → h2');
    ok(str_contains($h, '<p>Абзац з &lt;script&gt;alert(1)&lt;/script&gt; &amp; <strong>жирним</strong>. Другий рядок абзацу.</p>'), 'абзац (рядки злито), екранування, **жирний**');
    ok(str_contains($h, '<ul><li>пункт <strong>один</strong></li>'), 'список і жирний у пункті');
    ok(str_contains($h, '<a href="privacy.php">посилання</a>'), 'відносне посилання *.php');
    ok(!str_contains($h, 'href="javascript'), 'javascript: не стає посиланням');
    $real = mpb_rules_render(AIS_FILE);
    ok($real !== null && substr_count($real['html'], '<h2>') === 9, 'чернетка: 9 розділів ## → h2');
    ok($real !== null && str_contains($real['html'], '<mark class="mp-ph">[ПІДТВЕРДИТИ: дата]</mark>'), 'маркери підсвічено');
    ok($real !== null && !str_contains($real['html'], '**') && str_contains($real['html'], '<a href="privacy.php">Політиці конфіденційності</a>'), 'у чернетці немає «сирої» розмітки, посилання на Політику працює');

    echo "== docs/ напряму (Apache: $apache)\n";
    [$c] = http($apache . '/docs/ai_statement_uk.md');
    ok($c === 403 || $c === 404, "/docs/ai_statement_uk.md — $c");
    [$c] = http($apache . '/docs/marketplace_rules_uk.md');
    ok($c === 403 || $c === 404, "/docs/marketplace_rules_uk.md (як для Правил) — $c");
} catch (Throwable $e) {
    ok(false, 'виняток: ' . $e->getMessage() . ' @ ' . basename($e->getFile()) . ':' . $e->getLine());
} finally {
    if ($proc !== null) {
        stop($proc);
    }
    if ($ids !== []) {
        $pdo->exec('DELETE FROM users WHERE id IN (' . implode(',', array_map('intval', $ids)) . ')');
    }
    foreach ([$withMarkers, $noMarkers, $md] as $f) {
        if (is_file($f)) {
            unlink($f);
        }
    }
    @rmdir($tmpDir);
    ok(sha1((string) file_get_contents(AIS_FILE)) === $origHash, 'docs/ai_statement_uk.md не змінено');
}
echo "\nРазом: $T, помилок: $F\n";
exit($F > 0 ? 1 : 0);
