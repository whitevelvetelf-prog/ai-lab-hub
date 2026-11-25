<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тест сцени «Бібліотека» (Етап C, table_scene): правила таблиці (bv-scene-table.php) і серверний шар із БД.
 *   php tests/bugville-tables-tests.php
 * Потрібно локально: міграції № 33 і № 38. Тестові записи видаляються. Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../app/bugville/bv-scene-play.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
bv_load_missions($pdo);

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

/** Усі клітинки поломок варіанта. */
function bugCells(array $r): array
{
    $all = [];
    foreach ($r['bug_defs'] as $b) {
        foreach ($b['cells'] as $c) {
            $all[$c[0] . ':' . $c[1]] = $b['id'];
        }
    }

    return $all;
}

/** Перша «чиста» клітинка (без поломки). */
function cleanCell(array $r, int $skip = 0): array
{
    $bc = bugCells($r);
    foreach ($r['rows'] as $ri => $row) {
        foreach ($row as $ci => $v) {
            if (!isset($bc[$ri . ':' . $ci]) && $skip-- <= 0) {
                return [$ri, $ci];
            }
        }
    }

    return [0, 0];
}

$gens = ['table_date' => 301, 'table_twin' => 302, 'table_empty' => 303, 'table_swap' => 304, 'table_report' => 305];

echo "1. Варіанти й правила\n";
foreach ($gens as $g => $m) {
    $counts = [];
    $sigs = [];
    for ($i = 0; $i < 40; $i++) {
        $r = bv_scene_rules($g, "v$i", $m);
        $counts[count($r['bugs'])] = true;
        $sigs[md5(json_encode($r['rows']))] = true;
    }
    check(count($counts) === 1 && count($sigs) >= 30, "$g: однакова кількість поломок, таблиці різні (" . count($sigs) . ' з 40)');
}
$okDates = true;
for ($i = 0; $i < 60; $i++) {
    $r = bv_scene_rules('table_date', "d$i", 301);
    $bc = bugCells($r);
    foreach ($r['rows'] as $ri => $row) {
        if (isset($bc[$ri . ':2']) || isset($bc[$ri . ':3'])) {
            continue;
        }
        [$d1, $m1] = array_map('intval', explode('.', $row[2]));
        [$d2, $m2] = array_map('intval', explode('.', $row[3]));
        $okDates = $okDates && checkdate($m1, $d1, 2026) && checkdate($m2, $d2, 2026) && ($m2 > $m1 || ($m2 === $m1 && $d2 > $d1));
    }
    $imp = $r['bug_defs'][0]['cells'][0];
    [$d, $mm] = array_map('intval', explode('.', $r['rows'][$imp[0]][$imp[1]]));
    $okDates = $okDates && !checkdate($mm, $d, 2026);
}
check($okDates, '3.1: у чистих рядках справжні дати й повернення після видачі; неможлива дата справді неможлива');
$twinOk = true;
for ($i = 0; $i < 30; $i++) {
    $r = bv_scene_rules('table_twin', "t$i", 302);
    $twinOk = $twinOk && count($r['rows']) === 7 && count(array_unique(array_map('json_encode', $r['rows']))) === 6;
}
check($twinOk, '3.2: 7 рядків, з них рівно один повний двійник');
$emptyOk = true;
for ($i = 0; $i < 30; $i++) {
    $r = bv_scene_rules('table_empty', "e$i", 303);
    $empties = 0;
    foreach ($r['rows'] as $row) {
        $empties += count(array_filter($row, static fn($v) => $v === ''));
    }
    $emptyOk = $emptyOk && $empties === 2;
}
check($emptyOk, '3.3: рівно дві порожні клітинки, і обидві — поломки');
check(bv_scene_rules('table_report', 'x', 305)['min_found'] === 1 && bv_scene_rules('table_swap', 'x', 304)['min_found'] === 1, 'мінімум для здачі — 1');

echo "2. Браузер не бачить поломок\n";
$leak = false;
foreach ($gens as $g => $m) {
    for ($i = 0; $i < 15; $i++) {
        $r = bv_scene_rules($g, "p$i", $m);
        $json = json_encode(bv_scene_public($r), JSON_UNESCAPED_UNICODE);
        $leak = $leak || preg_match('/"(bugs|bug_defs|cells|expected|actual)"/', $json) === 1;
        foreach ($r['hints'] as $h) {
            $leak = $leak || str_contains($json, $h);
        }
        foreach ($r['bug_defs'] as $b) {
            $leak = $leak || str_contains($json, $b['card']['exp']);
        }
    }
}
check(!$leak, 'публічна таблиця без координат поломок, правильного звіту, підказок і розборів');

echo "3. Позначки\n";
$r = bv_scene_rules('table_date', 'm1', 301);
$s = bv_scene_initial_state($r);
[$x, $s] = bv_scene_table_act($r, $s, 'check', [cleanCell($r)]);
check($x['result'] === 'useless' && $x['marks'][0]['res'] === 'wrong' && $s['f'] === [] && $s['u'] === 1, 'чиста клітинка — хибна позначка, поломок не знайдено');
$b0 = $r['bug_defs'][0]['cells'][0];
$b1 = $r['bug_defs'][1]['cells'][1];
[$x, $s] = bv_scene_table_act($r, $s, 'check', [$b0, cleanCell($r, 1)]);
check($x['result'] === 'bug' && count($x['bugs']) === 1 && $x['marks'][1]['res'] === 'wrong', 'поломка + хибна разом: поломку зараховано, хибну — ні');
[$x, $s] = bv_scene_table_act($r, $s, 'check', [$b0]);
check($x['result'] === 'ok' && $x['marks'][0]['res'] === 'repeat' && count($s['f']) === 1, 'повторна позначка знайденого — без нової знахідки');
[$x, $s] = bv_scene_table_act($r, $s, 'check', [$b1]);
check($x['result'] === 'bug' && $s['f'] === ['impossible', 'order'] && str_contains($x['bug']['exp'], 'після'), '3.1: друга поломка (будь-яка з двох дат рядка) і міні-звіт');
[$x] = bv_scene_table_act($r, bv_scene_initial_state($r), 'check', []);
check($x['result'] === 'info', 'перевірка без позначок — підказка, не дія');

echo "4. Захист від «позначити все»\n";
$r = bv_scene_rules('table_swap', 'w1', 304);
check(bv_table_clean($r, 'check', [[0, 0], [0, 1], [0, 2], [0, 3]]) === null, 'більше 3 позначок за раз — відмова');
check(bv_table_clean($r, 'check', [[0, 0], [0, 0]]) === [[0, 0]] && bv_table_clean($r, 'check', [[99, 0]]) === null && bv_table_clean($r, 'check', [['0', 0]]) === null,
    'дублі злито; клітинка поза таблицею й рядкові індекси — відмова');
check(bv_table_clean($r, 'check', ['a' => [0, 0]]) === null && bv_table_clean($r, 'check', 'x') === null, 'не список — відмова');
$s = bv_scene_initial_state($r);
$wrongCells = [];
for ($k = 0; count($wrongCells) < 6; $k++) {
    $wrongCells[] = cleanCell($r, $k);
}
foreach (array_chunk($wrongCells, 3) as $ch) {
    [$x, $s] = bv_scene_table_act($r, $s, 'check', $ch);
}
check($x['locked'] === true && $x['wrong_left'] === 0, 'після 6 хибних позначок таблицю заблоковано');
[$x, $s] = bv_scene_table_act($r, $s, 'check', [$r['bug_defs'][0]['cells'][0]]);
check($x['result'] === 'info' && $s['f'] === [], 'після блокування навіть правильна позначка не зараховується');

echo "5. 3.5 «Історія бібліотекаря»: звіт\n";
$stories = [];
$ok = true;
for ($i = 0; $i < 60; $i++) {
    $r = bv_scene_rules('table_report', "s$i", 305);
    $stories[$r['caption'] === '' ? '' : mb_substr($r['caption'], 0, 12)] = true;
    [$x1, $s1] = bv_scene_table_act($r, bv_scene_initial_state($r), 'report', ['expected' => $r['actual'], 'actual' => $r['expected']]);
    [$x2, $s2] = bv_scene_table_act($r, $s1, 'report', ['expected' => $r['expected'], 'actual' => $r['actual']]);
    $ok = $ok && $r['expected'] !== $r['actual'] && $x1['result'] === 'useless' && $x2['result'] === 'bug' && $s2['f'] === ['report'];
}
check($ok, 'переплутані «очікувано / фактично» — марно; правильний звіт — поломку записано');
check(count($stories) >= 6, '6 сюжетів (полиця, розклад, черга, штраф, температура, стільці)');
$r = null;
for ($i = 0; $i < 60 && $r === null; $i++) {
    $t = bv_scene_rules('table_report', "s$i", 305);
    if (str_contains($t['expected'], ':')) {
        $r = $t;
    }
}
[$x] = bv_scene_table_act($r, bv_scene_initial_state($r), 'report', ['expected' => preg_replace('/^(\d):/', '0$1:', $r['expected']), 'actual' => str_replace(':', '.', $r['actual'])]);
check($x['result'] === 'bug', 'час можна писати як «09:00» чи «8.30»');
[$x] = bv_scene_table_act($r, bv_scene_initial_state($r), 'report', ['expected' => '', 'actual' => '5']);
check($x['result'] === 'info', 'порожнє поле звіту — підказка');
check(bv_table_clean($r, 'report', ['expected' => '1', 'actual' => '2', 'found' => 1]) === null && bv_table_clean($r, 'report', ['expected' => str_repeat('1', 31)]) === null,
    'зайве поле у звіті й задовгий ввід — відмова');

echo "6. Сервер\n";
$tag = bin2hex(random_bytes(3));
$pdo->prepare("INSERT INTO users (name, email, password_hash, role, created_at) VALUES ('BV tables', :e, 'x', 'user', NOW())")
    ->execute([':e' => "bv-tables-$tag@example.test"]);
$uid = (int) $pdo->lastInsertId();
$_SESSION = [];
try {
    bv_confirm_age($pdo, $uid);
    $ctx = bv_ctx($uid);
    $ctx['ip'] = '';
    $st = bv_attempt_start($pdo, 303, $ctx);
    check($st['ok'] && $st['scene']['type'] === 'table_scene' && $st['scene']['mode'] === 'mark' && !isset($st['scene']['bug_defs']), 'старт 3.3: таблиця без поломок');
    $tok = $st['token'];
    $seed = (string) $pdo->query('SELECT seed FROM bv_attempts WHERE token = ' . $pdo->quote($tok))->fetchColumn();
    $r = bv_scene_rules('table_empty', $seed, 303);
    check(bv_scene_finish($pdo, $tok, $ctx)['error'] === 'not_enough', 'здати без знахідок — not_enough');
    check(bv_scene_act($pdo, $tok, 'check', '0:0', $ctx)['error'] === 'too_long', 'рядок замість списку клітинок — відмова');
    check(bv_scene_act($pdo, $tok, 'report', ['expected' => '1', 'actual' => '2'], $ctx)['reaction']['result'] === 'info', 'звіт у таблиці з позначками — без знахідки');
    $w = bv_scene_act($pdo, $tok, 'check', [cleanCell($r)], $ctx);
    check($w['found'] === 0 && $w['reaction']['wrong_left'] === 5, 'хибна позначка: знахідок 0, лишилося 5');
    $h = bv_scene_act($pdo, $tok, 'check', [$r['bug_defs'][0]['cells'][0]], $ctx);
    check($h['found'] === 1 && $h['can_submit'], 'порожня клітинка — знайдено');
    $fin = bv_scene_finish($pdo, $tok, $ctx);
    check($fin['ok'] && $fin['stars'] === 3 && ($fin['earned']['xp'] ?? 0) === 20 && $fin['summary']['useless'] === 1 && str_contains($fin['explain'], 'таблиці бібліотеки'),
        'здано: 3 зірки, 20 XP, хибна позначка в підсумку');
    check(bv_scene_finish($pdo, $tok, $ctx)['repeat'] === true && bv_totals($pdo, $uid)['xp'] === 20, 'повторне «Здати» — без нагороди');
    check(bv_scene_act($pdo, $tok, 'check', [[0, 0]], $ctx)['error'] === 'already_checked', 'після здачі позначки не приймаються');
} finally {
    bv_delete_player_data($pdo, $uid);
    $pdo->prepare('DELETE FROM users WHERE id = :u')->execute([':u' => $uid]);
    check((int) $pdo->query('SELECT COUNT(*) FROM bv_attempts WHERE user_id = ' . $uid)->fetchColumn() === 0, 'тестові дані прибрано');
}

echo "\n" . ($fails === 0 ? "PASS $total/$total" : "FAIL $fails з $total") . "\n";
exit($fails === 0 ? 0 : 1);
