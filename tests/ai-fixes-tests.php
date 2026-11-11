<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тести виправлень після перевірки «Як ми використовуємо АІ» (2026-11-11), ЛОКАЛЬНА база.
 *
 *   php tests/ai-fixes-tests.php
 *
 *   1. Маскування й строк зберігання запитів без результатів (search_log), спільне маскування з search_queries.
 *   2. EN-переклад продукту після редагування в CRM: справжній POST у crm-edit-product.php через вбудований сервер
 *      (tests/support/pt-router.php) з фейковим перекладачем — рахуємо звернення до «API»; картка в списку
 *      підкатегорії при EN; ліміт 5 хв.
 *   3. Підказка під полем Елі (UA/EN, посилання лише коли сторінка «Як ми використовуємо АІ» публічна).
 *
 * Тестові записи (користувач, підкатегорія, продукт, рядки search_log) створюються тут і видаляються за id.
 * docs/ai_statement_uk.md не змінюється (тимчасові копії). Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
require_once __DIR__ . '/../app/search.php';
require_once __DIR__ . '/../app/search-log.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/product-translation.php';
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
function http(string $url, ?int $uid = null, ?string $lang = null, ?array $post = null, ?string $jar = null): array
{
    $ch = curl_init($url);
    $h = [];
    if ($uid !== null) {
        $h[] = 'X-Pt-Uid: ' . $uid;
    }
    if ($lang !== null) {
        $h[] = 'X-Pt-Lang: ' . $lang;
    }
    $opt = [CURLOPT_RETURNTRANSFER => true, CURLOPT_TIMEOUT => 60, CURLOPT_HTTPHEADER => $h,
        CURLOPT_USERAGENT => 'Mozilla/5.0 (iPhone; CPU iPhone OS 18_0 like Mac OS X) AppleWebKit/605.1.15 Safari/604.1'];
    if ($jar !== null) {
        $opt[CURLOPT_COOKIEJAR] = $jar;    // сесія CRM (CSRF-токен) між запитами
        $opt[CURLOPT_COOKIEFILE] = $jar;
    }
    if ($post !== null) {
        $opt[CURLOPT_POST] = true;
        $opt[CURLOPT_POSTFIELDS] = http_build_query($post);
    }
    curl_setopt_array($ch, $opt);
    $body = (string) curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    return [$code, $body];
}
function serve(array $env, int $port): array
{
    $e = getenv();
    foreach ($env as $k => $v) {
        $e[$k] = $v;
    }
    $null = PHP_OS_FAMILY === 'Windows' ? 'NUL' : '/dev/null';
    $proc = proc_open([PHP_BINARY, '-S', '127.0.0.1:' . $port, __DIR__ . '/support/pt-router.php'],
        [0 => ['pipe', 'r'], 1 => ['file', $null, 'w'], 2 => ['file', $null, 'w']], $pipes, dirname(__DIR__), $e);
    for ($i = 0; $i < 50; $i++) {
        $s = @fsockopen('127.0.0.1', $port, $errno, $errstr, 0.2);
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
    if (!is_resource($proc)) {
        return;
    }
    $st = proc_get_status($proc);
    if (PHP_OS_FAMILY === 'Windows') {
        exec('taskkill /F /T /PID ' . (int) $st['pid'] . ' >NUL 2>&1');
    } else {
        proc_terminate($proc);
    }
    proc_close($proc);
}
function calls(string $file): int
{
    return is_file($file) ? count(array_filter(explode("\n", (string) file_get_contents($file)))) : 0;
}
function tr(PDO $pdo, int $pid, string $field): ?array
{
    $st = $pdo->prepare("SELECT translated_text, source FROM product_translations WHERE product_id = :p AND field_name = :f AND lang = 'en'");
    $st->execute([':p' => $pid, ':f' => $field]);

    return $st->fetch(PDO::FETCH_ASSOC) ?: null;
}
function card_text(string $html, string $needle): string
{
    return preg_match('~<p class="product-card__desc"([^>]*)>([^<]*' . preg_quote($needle, '~') . '[^<]*)</p>~u', $html, $m) ? $m[1] . '|' . $m[2] : '';
}

$tmp = sys_get_temp_dir() . DIRECTORY_SEPARATOR . 'pt-test-' . bin2hex(random_bytes(3));
@mkdir($tmp, 0700, true);
$ids = ['log' => [], 'user' => 0, 'sub' => 0, 'product' => 0];
$procs = [];

try {
    // ------------------------------------------------------------------ 1
    echo "== 1. Маскування запитів без результатів\n";
    $cases = [
        'chatgpt для резюме' => 'chatgpt для резюме',
        'напишіть на olena.k@gmail.com про midjourney' => 'напишіть на [email] про midjourney',
        'дзвоніть +38 (067) 123-45-67 переклад' => 'дзвоніть [phone] переклад',
        'картка 4149 4999 1234 5678 оплата' => 'картка [card] оплата',
        'картка 4149499912345678' => 'картка [card]',
        'код 123456' => 'код [number]',
        'https://example.com/promo?id=77 знижка' => '[url] знижка',
        'www.site.ua/a' => '[url]',
        'iphone 15 pro відео' => 'iphone 15 pro відео',
        'gpt 2025' => 'gpt 2025',
    ];
    foreach ($cases as $in => $want) {
        ok(search_mask_personal($in) === $want, "маска: «{$in}» → «{$want}» (є: «" . search_mask_personal($in) . "»)");
    }
    ok(search_log_sanitize('пишіть olena@ukr.net код 1234567') === 'пишіть [email] код [number]', 'search_queries використовує те саме маскування');
    ok(search_config()['zero_result_retention_days'] === 30, 'config: zero_result_retention_days = 30');

    $maxId = (int) $pdo->query('SELECT COALESCE(MAX(id), 0) FROM search_log')->fetchColumn();
    search_log_zero($pdo, 'zzpt-test olena@example.com +380671234567 4149 4999 1234 5678 ' . str_repeat('довгий ', 60), 'uk');
    $row = $pdo->query('SELECT id, query, lang, results_count FROM search_log WHERE id > ' . $maxId . " AND query LIKE 'zzpt-test%'")->fetch(PDO::FETCH_ASSOC);
    if ($row) {
        $ids['log'][] = (int) $row['id'];
    }
    ok($row !== false, 'search_log_zero записав рядок');
    ok($row && !str_contains($row['query'], '@') && !preg_match('/\d{6,}/', (string) $row['query']), 'у записі немає пошти й довгих номерів: «' . mb_substr((string) ($row['query'] ?? ''), 0, 60) . '…»');
    ok($row && str_contains($row['query'], '[email]') && str_contains($row['query'], '[card]') && str_contains($row['query'], '[phone]'), 'позначки [email] [phone] [card] на місці');
    ok($row && mb_strlen((string) $row['query']) === 200, 'довжина обрізана до 200 (є ' . mb_strlen((string) ($row['query'] ?? '')) . ')');
    ok($row && $row['lang'] === 'uk' && (int) $row['results_count'] === 0, 'інші поля без змін (lang, results_count = 0)');

    foreach ([31 => 'zzpt-old', 29 => 'zzpt-fresh'] as $days => $q) {
        $pdo->prepare('INSERT INTO search_log (query, lang, results_count, created_at) VALUES (:q, \'uk\', 0, NOW() - INTERVAL ' . $days . ' DAY)')->execute([':q' => $q]);
        $ids['log'][] = (int) $pdo->lastInsertId();
    }
    $deleted = search_log_zero_cleanup($pdo);
    $left = $pdo->query("SELECT query FROM search_log WHERE query IN ('zzpt-old', 'zzpt-fresh')")->fetchAll(PDO::FETCH_COLUMN);
    ok($deleted >= 1 && $left === ['zzpt-fresh'], "очищення: 31 день видалено, 29 днів лишився (видалено $deleted)");
    $cron = (string) shell_exec(escapeshellarg(PHP_BINARY) . ' ' . escapeshellarg(__DIR__ . '/../public/mp-cron-expire.php'));
    ok(str_contains($cron, 'zero_search_deleted:'), 'mp-cron-expire.php чистить search_log: ' . trim($cron));

    // ------------------------------------------------------------------ 2
    echo "== 2. EN-переклад продукту після редагування в CRM\n";
    $pdo->prepare("INSERT INTO users (name, email, password_hash, role) VALUES ('PT-TEST admin', :e, 'x', 'admin')")
        ->execute([':e' => 'pt-test-' . bin2hex(random_bytes(3)) . '@example.invalid']);
    $ids['user'] = (int) $pdo->lastInsertId();
    $catId = (int) $pdo->query('SELECT MIN(id) FROM categories')->fetchColumn();
    $pdo->prepare("INSERT INTO subcategories (category_id, name, name_en, slug) VALUES (:c, 'PT-TEST підкатегорія', 'PT-TEST subcategory', :s)")
        ->execute([':c' => $catId, ':s' => 'pt-test-' . bin2hex(random_bytes(3))]);
    $ids['sub'] = (int) $pdo->lastInsertId();
    $pdo->prepare("INSERT INTO products (name, official_url, short_description, short_description_en, full_description, full_description_en,
                       main_features, target_audience, status, partnership_status)
                   VALUES ('PT-TEST Product', 'https://pt-test.example.invalid', 'Старий короткий опис ПТ', 'Old short PT (manual)',
                       'Повний опис ПТ', 'Full PT (manual)', 'Функція ПТ', 'Аудиторія ПТ', 'published', 'found')")->execute();
    $pid = (int) $pdo->lastInsertId();
    $ids['product'] = $pid;
    $pdo->prepare('INSERT INTO product_categories (product_id, category_id) VALUES (:p, :c)')->execute([':p' => $pid, ':c' => $catId]);
    $pdo->prepare('INSERT INTO product_subcategories (product_id, subcategory_id) VALUES (:p, :s)')->execute([':p' => $pid, ':s' => $ids['sub']]);
    foreach (['short_description' => 'Old short PT (manual)', 'full_description' => 'Full PT (manual)', 'main_features' => 'Feature PT (manual)', 'target_audience' => 'Audience PT (manual)'] as $f => $t) {
        $pdo->prepare("INSERT INTO product_translations (product_id, field_name, lang, translated_text, source) VALUES (:p, :f, 'en', :t, 'manual')")
            ->execute([':p' => $pid, ':f' => $f, ':t' => $t]);
    }

    $callsFile = $tmp . DIRECTORY_SEPARATOR . 'calls.txt';
    [$procs[], $base] = serve(['PT_CALLS_FILE' => $callsFile], 8793);
    $listUrl = $base . '/catalog.php?subcategory=' . $ids['sub'];

    [, $html] = http($listUrl, null, 'en');
    ok(str_contains(card_text($html, 'Old short PT'), 'Old short PT (manual)'), 'до редагування: картка EN — наявний переклад «Old short PT (manual)»');

    // Відтворення старої поведінки: що показала б сторінка, якби переклади не скидались — перевіримо після POST.
    // CSRF: токен береться зі сторінки форми в тій самій сесії (cookie jar).
    $jar = $tmp . DIRECTORY_SEPARATOR . 'cookies.txt';
    $editUrl = $base . '/crm-edit-product.php?id=' . $pid;
    [, $page] = http($editUrl, $ids['user'], null, null, $jar);
    $csrf = preg_match('~name="csrf" value="([0-9a-f]{64})"~', $page, $m) ? $m[1] : '';
    ok($csrf !== '', 'форма CRM містить CSRF-токен');
    $short0 = static fn(): string => (string) $pdo->query('SELECT short_description FROM products WHERE id = ' . $pid)->fetchColumn();
    $form = static fn(string $short, ?string $token = null): array => [
        'csrf' => $token ?? $csrf, 'action' => 'force', 'name' => 'PT-TEST Product', 'official_url' => 'https://pt-test.example.invalid',
        'short_description' => $short, 'full_description' => 'Повний опис ПТ', 'main_features' => 'Функція ПТ',
        'target_audience' => 'Аудиторія ПТ', 'categories' => [$catId], 'subcategories' => [$ids['sub']],
        'partnership_status' => 'found', 'skill_level' => 'none',
    ];
    foreach (['без токена' => '', 'з чужим токеном' => str_repeat('a', 64)] as $label => $bad) {
        $p = $form('Зловмисний опис ПТ', $bad);
        if ($bad === '') {
            unset($p['csrf']);
        }
        [$code, $body] = http($editUrl, $ids['user'], null, $p, $jar);
        ok($code === 200 && str_contains($body, 'Сесія застаріла') && !str_contains($body, 'Продукт оновлено') && $short0() === 'Старий короткий опис ПТ' && calls($callsFile) === 0,
            "POST $label: не збережено, показано помилку, API не викликано");
    }
    [$code, $body] = http($editUrl, $ids['user'], null, $form('Новий короткий опис ПТ'), $jar);
    ok($code === 200 && str_contains($body, 'Продукт оновлено'), "POST у CRM: збережено (HTTP $code)");
    ok(str_contains($body, 'Переклад змінених полів оновлено автоматично: short_description'), 'CRM показує примітку про оновлений переклад');
    ok(calls($callsFile) === 1, 'одне звернення до API (одна мова, лише змінене поле); є: ' . calls($callsFile));
    $t = tr($pdo, $pid, 'short_description');
    ok($t !== null && $t['translated_text'] === 'EN: Новий короткий опис ПТ' && $t['source'] === 'auto', 'short_description EN перекладено заново (auto): «' . ($t['translated_text'] ?? '—') . '»');
    $full = tr($pdo, $pid, 'full_description');
    ok($full !== null && $full['translated_text'] === 'Full PT (manual)' && $full['source'] === 'manual', 'незмінене поле full_description: переклад не чіпали');
    $col = $pdo->query('SELECT short_description_en, full_description_en FROM products WHERE id = ' . $pid)->fetch(PDO::FETCH_ASSOC);
    ok($col['short_description_en'] === null && $col['full_description_en'] === 'Full PT (manual)', 'products.short_description_en очищено, full_description_en лишився');

    [, $html] = http($listUrl, null, 'en');
    ok(str_contains(card_text($html, 'Новий короткий опис'), 'EN: Новий короткий опис ПТ'), 'картка в списку підкатегорії (EN) — новий переклад');
    ok(!str_contains($html, 'Old short PT'), 'старого EN-тексту в списку немає');

    // Друге редагування в межах 5 хв: переклад скидається, але API не викликається.
    [$code, $body] = http($editUrl, $ids['user'], null, $form('Третій короткий опис ПТ'), $jar);
    ok($code === 200 && str_contains($body, 'новий з’явиться автоматично протягом 5 хв'), 'друге збереження в межах 5 хв: примітка про відкладений переклад');
    ok(calls($callsFile) === 1, 'друге збереження: нових звернень до API немає (є ' . calls($callsFile) . ')');
    $t = tr($pdo, $pid, 'short_description');
    ok($t !== null && $t['translated_text'] === '' && $t['source'] === 'auto', 'старий переклад short_description очищено (рядок лишився міткою часу)');
    [, $html] = http($listUrl, null, 'en');
    $c = card_text($html, 'Третій короткий опис');
    ok(str_contains($c, 'Третій короткий опис ПТ') && str_contains($c, 'lang="uk"'), 'картка EN поки показує оригінал з lang="uk" (без старого перекладу)');
    [, $page] = http($base . '/product.php?id=' . $pid, null, 'en');
    // На product.php короткий опис не виводиться, коли є повний, — перевіряємо результат за рядком перекладу.
    ok(!str_contains($page, 'EN: Новий') && calls($callsFile) === 1 && (tr($pdo, $pid, 'short_description')['translated_text'] ?? null) === '',
        'сторінка продукту EN у межах 5 хв: без звернення до API, старого перекладу немає');

    // Минуло 5 хв (зсуваємо час останнього автоперекладу) → сторінка продукту перекладає відсутнє.
    $pdo->exec("UPDATE product_translations SET updated_at = NOW() - INTERVAL 6 MINUTE WHERE product_id = $pid AND source = 'auto'");
    [, $page] = http($base . '/product.php?id=' . $pid, null, 'en');
    ok((tr($pdo, $pid, 'short_description')['translated_text'] ?? null) === 'EN: Третій короткий опис ПТ', 'через 5 хв сторінка продукту EN перекладає змінене поле');
    ok(str_contains($page, 'Full PT (manual)'), 'незмінений повний опис на сторінці — наявний переклад');
    ok(calls($callsFile) === 2, 'рівно одне нове звернення до API (лише відсутнє поле); всього ' . calls($callsFile));
    [, $html] = http($listUrl, null, 'en');
    ok(str_contains(card_text($html, 'Третій короткий опис'), 'EN: Третій короткий опис ПТ'), 'після цього картка в списку EN — новий переклад');
    [, $page] = http($base . '/product.php?id=' . $pid, null, 'en');
    ok(calls($callsFile) === 2, 'повторний перегляд — з кешу, без API');

    // Збереження без зміни тексту — переклади не чіпаються.
    $before = $pdo->query("SELECT COUNT(*) FROM product_translations WHERE product_id = $pid")->fetchColumn();
    http($editUrl, $ids['user'], null, $form('Третій короткий опис ПТ'), $jar);
    ok($pdo->query("SELECT COUNT(*) FROM product_translations WHERE product_id = $pid")->fetchColumn() === $before && calls($callsFile) === 2, 'збереження без зміни тексту: переклади й API без змін');
    ok(product_text_changes(['short_description' => 'a', 'full_description' => null], ['short_description' => 'a ', 'full_description' => '']) === [], 'product_text_changes: NULL = порожнє, пробіли не зміна');

    // ------------------------------------------------------------------ 3
    echo "== 3. Підказка під полем Елі\n";
    $orig = (string) file_get_contents(__DIR__ . '/../docs/ai_statement_uk.md');
    $origHash = sha1($orig);
    $withMarkers = $tmp . DIRECTORY_SEPARATOR . 'with.md';
    $noMarkers = $tmp . DIRECTORY_SEPARATOR . 'without.md';
    file_put_contents($withMarkers, "# Тест\n\n[ПІДТВЕРДИТИ: x]\n");
    file_put_contents($noMarkers, "# Тест\n\nГотово.\n");
    [$procs[], $b1] = serve(['AIS_TEST_FILE' => $withMarkers], 8794);
    [$procs[], $b2] = serve(['AIS_TEST_FILE' => $noMarkers], 8795);
    $hint = static fn(string $h): string => preg_match('~<p class="composer__hint"[^>]*>(.*?)</p>~su', $h, $m) ? $m[1] : '';
    [, $h] = http($b1 . '/eli.php', null, 'uk');
    ok(str_contains($hint($h), 'Не вводьте особисті дані. Запити обробляє сервіс Google.') && !str_contains($hint($h), 'ai-statement.php'), 'UA, сторінка не публічна: текст без посилання');
    [, $h] = http($b2 . '/eli.php', null, 'uk');
    ok(str_contains($hint($h), '<a href="ai-statement.php">Докладніше</a>'), 'UA, сторінка публічна: посилання «Докладніше»');
    [, $h] = http($b2 . '/eli.php', null, 'en');
    ok(str_contains($hint($h), 'Do not enter personal data. Requests are processed by Google.') && str_contains($hint($h), '>Learn more</a>'), 'EN: «Do not enter personal data…» і «Learn more»');
    ok(sha1((string) file_get_contents(__DIR__ . '/../docs/ai_statement_uk.md')) === $origHash, 'docs/ai_statement_uk.md не змінено');
} finally {
    foreach ($procs as $p) {
        stop($p);
    }
    echo "== Прибирання (лише свої записи, за id)\n";
    if ($ids['log'] !== []) {
        $pdo->exec('DELETE FROM search_log WHERE id IN (' . implode(',', array_map('intval', $ids['log'])) . ')');
    }
    if ($ids['product'] > 0) {
        $p = (int) $ids['product'];
        $pdo->exec("DELETE FROM search_index WHERE product_id = $p");
        $pdo->exec("DELETE FROM product_categories WHERE product_id = $p");
        $pdo->exec("DELETE FROM product_subcategories WHERE product_id = $p");
        $pdo->exec("DELETE FROM pricing_plans WHERE product_id = $p");
        $pdo->exec("DELETE FROM product_translations WHERE product_id = $p");
        $pdo->exec("DELETE FROM products WHERE id = $p");
    }
    if ($ids['sub'] > 0) {
        $pdo->exec('DELETE FROM subcategories WHERE id = ' . (int) $ids['sub']);
    }
    if ($ids['user'] > 0) {
        $pdo->exec('DELETE FROM users WHERE id = ' . (int) $ids['user']);
    }
    foreach (glob($tmp . DIRECTORY_SEPARATOR . '*') ?: [] as $f) {
        @unlink($f);
    }
    @rmdir($tmp);
    $left = (int) $pdo->query("SELECT (SELECT COUNT(*) FROM products WHERE name = 'PT-TEST Product') + (SELECT COUNT(*) FROM subcategories WHERE name = 'PT-TEST підкатегорія')
                                 + (SELECT COUNT(*) FROM search_log WHERE query LIKE 'zzpt-%') + (SELECT COUNT(*) FROM users WHERE name = 'PT-TEST admin')")->fetchColumn();
    ok($left === 0, 'тестових записів не лишилося');
}
echo "\nРазом: $T, помилок: $F\n";
exit($F > 0 ? 1 : 0);
