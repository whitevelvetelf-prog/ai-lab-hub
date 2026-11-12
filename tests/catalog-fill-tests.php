<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тести звіту «Наповнення каталогу» (app/catalog-fill.php, public/crm-catalog-fill.php).
 *   php tests/catalog-fill-tests.php
 * Лише CLI, ЛОКАЛЬНА база. Таблиці каталогу не змінює; у search_log додає 3 тестові рядки й видаляє їх за id.
 * Наприкінці друкує поточні числа звіту.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}
$_SESSION = [];
require_once __DIR__ . '/../app/catalog-fill.php';
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$pass = 0;
$fail = 0;
function check(bool $ok, string $msg): void
{
    global $pass, $fail;
    $ok ? $pass++ : $fail++;
    echo ($ok ? '  ok   ' : '  FAIL ') . $msg . "\n";
}

echo "== Конфіг і рівні\n";
$min = catalog_fill_min();
check($min === 10, "мета з config/catalog.php = 10 ({$min})");
check(catalog_fill_level(0, 10) === 'zero' && catalog_fill_level(1, 10) === 'low' && catalog_fill_level(9, 10) === 'low'
    && catalog_fill_level(10, 10) === 'ok' && catalog_fill_level(25, 10) === 'ok', '0 — червоний, 1–9 — жовтий, ≥10 — зелений');

echo "== Сортування, фільтр, підсумок (синтетичні рядки)\n";
$syn = [
    ['cat_id' => 2, 'cat_name' => 'Бета', 'sub_id' => 21, 'sub_name' => 'б1', 'published' => 12],
    ['cat_id' => 1, 'cat_name' => 'Альфа', 'sub_id' => 11, 'sub_name' => 'а2', 'published' => 3],
    ['cat_id' => 1, 'cat_name' => 'Альфа', 'sub_id' => 12, 'sub_name' => 'а1', 'published' => 0],
    ['cat_id' => 2, 'cat_name' => 'Бета', 'sub_id' => 22, 'sub_name' => 'б2', 'published' => 3],
];
$r = catalog_fill_rows($syn, 10);
check(array_column($r, 'sub_id') === [12, 11, 22, 21], 'за «Не вистачає» desc, далі категорія/підкатегорія');
check(array_column($r, 'missing') === [10, 7, 7, 0], 'не вистачає = max(0, мета − опубл.)');
check(array_column(catalog_fill_rows($syn, 10, 0, 'asc'), 'sub_id') === [21, 11, 22, 12], 'сортування asc');
check(array_column(catalog_fill_rows($syn, 10, 2), 'sub_id') === [22, 21], 'фільтр за категорією');
check(catalog_fill_summary($r) === ['total' => 4, 'zero' => 1, 'below' => 3, 'needed' => 24], 'підсумок: усього, з нулем, менше мети, потрібно');
check(array_keys(catalog_fill_categories($syn)) === [1, 2], 'категорії фільтра за абеткою');

echo "== CSV\n";
$csv = catalog_fill_csv(catalog_fill_rows($syn + [4 => ['cat_id' => 3, 'cat_name' => '=HYPERLINK("x")', 'sub_id' => 31, 'sub_name' => 'Кома, "лапки"', 'published' => 5]], 10), 10);
check(str_starts_with($csv, "\xEF\xBB\xBF"), 'UTF-8 з BOM');
check(mb_check_encoding($csv, 'UTF-8'), 'валідний UTF-8');
$lines = array_map('str_getcsv', preg_split('/\r?\n/', trim(substr($csv, 3))));
check($lines[0] === ['Категорія', 'Підкатегорія', 'ID підкатегорії', 'Опубліковано', 'Мета', 'Не вистачає'], 'заголовок');
check(count($lines) === 6 && $lines[1] === ['Альфа', 'а1', '12', '0', '10', '10'], 'рядки в порядку таблиці');
$bad = array_values(array_filter($lines, static fn($l) => $l[2] === '31'))[0] ?? [];
check(($bad[0] ?? '') === "'=HYPERLINK(\"x\")" && ($bad[1] ?? '') === 'Кома, "лапки"', 'формула нейтралізована, кома й лапки екрановані');

echo "== Реальна БД\n";
$rows = catalog_fill_query_rows($pdo);
$subTotal = (int) $pdo->query('SELECT COUNT(*) FROM subcategories s JOIN categories c ON c.id = s.category_id')->fetchColumn();
check(count($rows) === $subTotal && $subTotal > 0, "усі підкатегорії, включно з порожніми ({$subTotal})");
$links = (int) $pdo->query("SELECT COUNT(*) FROM product_subcategories ps JOIN products p ON p.id = ps.product_id AND p.status = 'published' JOIN subcategories s ON s.id = ps.subcategory_id")->fetchColumn();
check(array_sum(array_column($rows, 'published')) === $links, "сума = кількість зв'язків опублікованих продуктів ({$links}; мультипідкатегорія рахується в кожній)");
$multi = $pdo->query("SELECT ps.product_id FROM product_subcategories ps JOIN products p ON p.id = ps.product_id AND p.status = 'published' GROUP BY ps.product_id HAVING COUNT(*) > 1 LIMIT 1")->fetchColumn();
if ($multi !== false) {
    $subs = array_map('intval', $pdo->query('SELECT subcategory_id FROM product_subcategories WHERE product_id = ' . (int) $multi)->fetchAll(PDO::FETCH_COLUMN));
    $bySub = array_column($rows, 'published', 'sub_id');
    check(count(array_filter($subs, static fn($s) => ($bySub[$s] ?? 0) >= 1)) === count($subs), "продукт {$multi} врахований у кожній із " . count($subs) . ' підкатегорій');
}
$unpub = $pdo->query("SELECT ps.subcategory_id, COUNT(*) FROM product_subcategories ps JOIN products p ON p.id = ps.product_id AND p.status <> 'published' GROUP BY ps.subcategory_id LIMIT 1")->fetch(PDO::FETCH_NUM);
if ($unpub !== false) {
    $real = (int) $pdo->query("SELECT COUNT(*) FROM product_subcategories ps JOIN products p ON p.id = ps.product_id AND p.status = 'published' WHERE ps.subcategory_id = " . (int) $unpub[0])->fetchColumn();
    check((array_column($rows, 'published', 'sub_id')[(int) $unpub[0]] ?? -1) === $real, 'неопубліковані не рахуються');
}

echo "== Індекси (EXPLAIN)\n";
$plan = $pdo->query(
    "EXPLAIN SELECT c.id, c.name, s.id, s.name, COUNT(p.id) FROM subcategories s JOIN categories c ON c.id = s.category_id
     LEFT JOIN product_subcategories ps ON ps.subcategory_id = s.id
     LEFT JOIN products p ON p.id = ps.product_id AND p.status = 'published' GROUP BY s.id, c.id, c.name, s.name"
)->fetchAll(PDO::FETCH_ASSOC);
$byTable = [];
foreach ($plan as $p) {
    $byTable[(string) $p['table']] = $p;
}
check(in_array((string) ($byTable['ps']['key'] ?? ''), ['idx_psc_subcategory', 'PRIMARY'], true), 'product_subcategories — за індексом (' . ($byTable['ps']['key'] ?? '—') . ')');
check(($byTable['p']['key'] ?? '') === 'PRIMARY', 'products — за PRIMARY');
check((string) ($byTable['c']['key'] ?? '') === 'PRIMARY' || (string) ($byTable['s']['key'] ?? '') !== '', 'categories/subcategories — за ключем');
$lp = $pdo->query("EXPLAIN SELECT LOWER(query), COUNT(*) FROM search_log WHERE created_at >= NOW() - INTERVAL 30 DAY GROUP BY LOWER(query)")->fetch(PDO::FETCH_ASSOC);
check(str_contains((string) ($lp['possible_keys'] ?? ''), 'idx_search_log_created'), 'search_log — idx_search_log_created доступний');

echo "== Попит (search_log, маскування)\n";
$ins = $pdo->prepare("INSERT INTO search_log (query, lang, results_count, created_at) VALUES (:q, 'uk', 0, :t)");
$ids = [];
foreach ([['zzcf тест нотаріус', 'NOW()'], ['ZZCF тест нотаріус', 'NOW()'], ['zzcf пишіть test@example.com', 'NOW()'], ['zzcf старий запит', 'old']] as [$q, $t]) {
    $ins->execute([':q' => $q, ':t' => $t === 'old' ? date('Y-m-d H:i:s', time() - 40 * 86400) : date('Y-m-d H:i:s')]);
    $ids[] = (int) $pdo->lastInsertId();
}
try {
    $dem = catalog_fill_query_demand($pdo, 1000);
    $mine = array_values(array_filter($dem, static fn($d) => str_starts_with($d['q'], 'zzcf')));
    check(($mine[0]['q'] ?? '') === 'zzcf тест нотаріус' && ($mine[0]['cnt'] ?? 0) === 2, 'групування без урахування регістру, найчастіший першим');
    check(!str_contains(json_encode($mine, JSON_UNESCAPED_UNICODE), 'test@example.com'), 'пошта замаскована');
    check(array_filter($mine, static fn($d) => str_contains($d['q'], 'старий')) === [], 'старші за 30 днів не враховуються');
    check(count(catalog_fill_query_demand($pdo)) <= 20, 'не більше 20');
} finally {
    $pdo->exec('DELETE FROM search_log WHERE id IN (' . implode(',', $ids) . ')');
}

echo "== Кеш 5 хвилин\n";
catalog_fill_cache_reset();
$a = catalog_fill_data($pdo);
$file = catalog_fill_cache_file();
$raw = json_decode((string) @file_get_contents($file), true);
check(is_array($raw) && abs((int) $raw['until'] - time() - 300) <= 2, 'кеш записано на 300 с');
$raw['rows'][0]['published'] = 777777;
file_put_contents($file, json_encode($raw, JSON_UNESCAPED_UNICODE));
check(catalog_fill_data($pdo)['rows'][0]['published'] === 777777, 'у межах TTL дані з кешу');
$raw['until'] = time() - 1;
file_put_contents($file, json_encode($raw, JSON_UNESCAPED_UNICODE));
check(catalog_fill_data($pdo)['rows'][0]['published'] !== 777777, 'після TTL — свіжий запит');
check(count($a['rows']) === $subTotal, 'кешовані рядки повні');

echo "== Сторінка (admin, employee, user)\n";
$render = static function (string $role, string $query = '') use ($pdo): string {
    $uid = (int) $pdo->query('SELECT id FROM users WHERE role = ' . $pdo->quote($role) . ' ORDER BY id LIMIT 1')->fetchColumn();
    if ($uid <= 0) {
        return "NO_USER:{$role}";
    }
    parse_str($query, $get);
    $boot = '$_SERVER["REQUEST_METHOD"]="GET";$_SERVER["HTTP_HOST"]="ai-lab-hub.test";$_SERVER["REQUEST_URI"]="/crm-catalog-fill.php";'
        . '$_SERVER["SCRIPT_NAME"]="/crm-catalog-fill.php";$_GET=' . var_export($get, true) . ';'
        . 'session_id("cftest".getmypid());session_start();$_SESSION["user_id"]=' . $uid . ';$_SESSION["role"]=' . var_export($role, true) . ';'
        . 'chdir(' . var_export(realpath(__DIR__ . '/../public'), true) . ');include "crm-catalog-fill.php";';
    $f = tempnam(sys_get_temp_dir(), 'cf') . '.php';
    file_put_contents($f, "<?php\n" . $boot);
    $out = (string) shell_exec(escapeshellarg(PHP_BINARY) . ' ' . escapeshellarg($f) . ' 2>&1');
    @unlink($f);

    return $out;
};
$adm = $render('admin');
check(str_contains($adm, '</html>') && str_contains($adm, 'Наповнення каталогу') && !preg_match('/(Fatal|Warning|Notice|Deprecated)/', $adm), 'admin: сторінка без помилок');
check(str_contains($adm, 'cf-n--zero') || str_contains($adm, 'cf-n--low') || str_contains($adm, 'cf-n--ok'), 'admin: підсвітка рівнів');
check(str_contains($adm, 'href="crm-search.php"'), 'admin: посилання на наявну сторінку «Пошук продуктів»');
check(substr_count($adm, '<tr>') - 2 >= $subTotal, 'admin: усі підкатегорії в таблиці');
$tmpEmp = 0;
if ((int) $pdo->query("SELECT COUNT(*) FROM users WHERE role = 'employee'")->fetchColumn() === 0) {
    // Тимчасовий працівник лише для рендеру; видаляється одразу за id.
    $pdo->prepare("INSERT INTO users (name, email, password_hash, role) VALUES ('cf-test', :e, '!', 'employee')")
        ->execute([':e' => 'cf-test-' . getmypid() . '@invalid.test']);
    $tmpEmp = (int) $pdo->lastInsertId();
}
try {
    $emp = $render('employee');
} finally {
    if ($tmpEmp > 0) {
        $pdo->exec('DELETE FROM users WHERE id = ' . $tmpEmp);
    }
}
if (str_starts_with($emp, 'NO_USER')) {
    echo "  --   employee у локальній БД немає — пропущено\n";
} else {
    check(str_contains($emp, '</html>') && str_contains($emp, 'Наповнення каталогу'), 'employee: доступ є');
    check(!str_contains($emp, 'href="crm-search.php"'), 'employee: без посилання на admin-сторінку');
}
$usr = $render('user');
check(!str_starts_with($usr, 'NO_USER') ? !str_contains($usr, '<html') : true, 'user: сторінки не бачить');
$firstCat = (int) array_key_first(catalog_fill_categories($rows));
$flt = $render('admin', 'cat=' . $firstCat . '&dir=asc');
check(str_contains($flt, 'value="' . $firstCat . '" selected') && str_contains($flt, '▲'), 'фільтр і asc у сторінці');
$csvOut = $render('admin', 'export=csv');
check(str_starts_with($csvOut, "\xEF\xBB\xBF") && substr_count($csvOut, "\n") === $subTotal + 1, 'export=csv: BOM і всі рядки');

echo "\n== Поточні числа (локальна БД, мета {$min})\n";
$s = catalog_fill_summary(catalog_fill_rows($rows, $min));
echo "  підкатегорій: {$s['total']}; з нулем: {$s['zero']}; менше {$min} (з нулем): {$s['below']}; продуктів бракує: {$s['needed']}\n";

echo "\n" . ($fail === 0 ? "УСЕ PASS ({$pass})" : "FAIL: {$fail}, ok: {$pass}") . "\n";
exit($fail === 0 ? 0 : 1);
