<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тест сцени «Пошта» (Етап B, form_scene): правила бланка (bv-scene-form.php) і серверний шар із БД.
 *   php tests/bugville-forms-tests.php
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

function base(array $r): array
{
    return array_column($r['fields'], 'value', 'key');
}

/** Надіслати кілька бланків поспіль: list of змін → [реакції, стан]. */
function sendAll(array $r, array $changes): array
{
    $s = bv_scene_initial_state($r);
    $out = [];
    foreach ($changes as $ch) {
        [$x, $s] = bv_scene_form_act($r, $s, 'submit', array_merge(base($r), $ch));
        $out[] = $x;
    }

    return [$out, $s];
}

function find(string $g, int $m, callable $ok): array
{
    for ($i = 0; $i < 200; $i++) {
        $r = bv_scene_rules($g, "f$i", $m);
        if ($ok($r)) {
            return $r;
        }
    }
    throw new RuntimeException("no variant for $g");
}

$gens = ['form_required' => 201, 'form_email' => 202, 'form_phone' => 203, 'form_length' => 204, 'form_duplicate' => 205];

echo "1. Варіанти\n";
$ok = true;
$titles = [];
foreach ($gens as $g => $m) {
    $counts = [];
    for ($i = 0; $i < 40; $i++) {
        $r = bv_scene_rules($g, "v$i", $m);
        $counts[count($r['bugs'])] = true;
        $titles[$g][$r['title']] = true;
        [$x] = sendAll($r, [[]]);
        $ok = $ok && $x[0]['accepted'] === true && $x[0]['result'] === 'ok';
    }
    check(count($counts) === 1, "$g: однакова кількість поломок у всіх варіантах");
}
check($ok, 'заповнений від початку бланк завжди правильний і приймається без «поломки»');
check(count($titles['form_duplicate']) === 6 && count($titles['form_required']) === 3, '2.5: 6 сюжетів, 2.1: 3 бланки');
check(bv_scene_rules('form_required', 'x', 201)['min_found'] === 1, 'мінімум для здачі в «Пошті» — 1');

echo "2. Браузер не бачить поломок\n";
$leak = false;
foreach ($gens as $g => $m) {
    for ($i = 0; $i < 15; $i++) {
        $r = bv_scene_rules($g, "p$i", $m);
        $json = json_encode(bv_scene_public($r), JSON_UNESCAPED_UNICODE);
        foreach ($r['bugs'] as $b) {
            $leak = $leak || str_contains($json, '"' . $b . '"') || (str_contains($b, ':') && str_contains($json, $b));
        }
        $leak = $leak || preg_match('/"(bugs|real_limit|no_base|done|kind_bug)"/', $json) === 1;
        foreach ($r['hints'] as $h) {
            $leak = $leak || str_contains($json, $h);
        }
    }
}
check(!$leak, 'публічний бланк без категорій поломок, справжньої межі, підказок');
$pub = bv_scene_public(bv_scene_rules('form_length', 'p1', 204));
check(isset($pub['fields'][0]['max']) && !isset($pub['fields'][2]['max']), '2.4: лічильник символів лише біля поля з межею (не біля ваги)');

echo "3. 2.1 «Порожнє поле»\n";
$r = bv_scene_rules('form_required', 'a1', 201);
[$emptyKey] = explode(':', substr($r['bugs'][0], 6)) + [''];
$blankKey = substr($r['bugs'][1], 6);
$other = null;
foreach ($r['fields'] as $f) {
    if ($f['req'] && $f['key'] !== $emptyKey && $f['key'] !== $blankKey) {
        $other = $f['key'];
        break;
    }
}
$opt = null;
foreach ($r['fields'] as $f) {
    if (!$f['req']) {
        $opt = $f['key'];
    }
}
[$x, $s] = sendAll($r, [[$other => ''], [$opt => ''], [$blankKey => ''], [$emptyKey => '   '], [$emptyKey => ''], [$blankKey => '  ']]);
check($x[0]['accepted'] === false && isset($x[0]['field_errors'][$other]) && $x[0]['result'] === 'ok', 'інше обовʼязкове порожнє — правильна відмова з повідомленням біля поля');
check($x[1]['accepted'] === true && $x[1]['result'] === 'ok', 'порожнє необовʼязкове поле — нормально, приймається');
check($x[2]['accepted'] === false && $x[3]['accepted'] === false, 'поле з поломкою «пробіли» порожнім — відмова; поле з поломкою «порожнє» пробілами — відмова');
check($x[4]['result'] === 'bug' && $x[5]['result'] === 'bug' && $s['f'] === $r['bugs'], 'дві поломки: порожнє поле й лише пробіли — бланк прийнято');
check(str_contains($x[4]['bug']['exp'], '*') && $x[4]['record'] !== null, 'міні-звіт і запис у журнал пошти');
[$x2] = sendAll($r, [[$other => '', $emptyKey => '']]);
check($x2[0]['accepted'] === false && $x2[0]['result'] === 'ok', 'поломка разом зі справжньою помилкою — відмова, поломку не зараховано');

echo "4. 2.2 «Дивна адреса»\n";
$r = bv_scene_rules('form_email', 'e1', 202);
$cases = ['email_no_at' => 'max.poshta.bv', 'email_at_word' => 'max(at)poshta.bv', 'email_double_at' => 'max@@poshta.bv', 'email_space' => 'ma x@poshta.bv'];
$good = true;
foreach ($cases as $cat => $addr) {
    [$x] = sendAll($r, [['email' => $addr]]);
    $isBug = in_array($cat, $r['bugs'], true);
    $good = $good && ($isBug ? $x[0]['result'] === 'bug' && $x[0]['accepted'] : $x[0]['accepted'] === false && $x[0]['result'] === 'ok');
}
check($good, 'дві з чотирьох дивних адрес — поломки, решта правильно відхилені');
[$x] = sendAll($r, [['email' => 'ivan@'], ['email' => '@poshta.bv'], ['email' => 'nadia@poshta.bv']]);
check(!$x[0]['accepted'] && !$x[1]['accepted'] && $x[2]['accepted'] && $x[2]['result'] === 'ok', '«ivan@», «@poshta.bv» — відмова; інша правильна адреса — прийнято');

echo "5. 2.3 «Літери замість цифр»\n";
$r = bv_scene_rules('form_phone', 'ph1', 203);
$samples = ['phone_o' => '+380 5O 123 45 67', 'phone_l' => '+380 66 2l4 18 90', 'phone_z' => '+380 5З 123 45 67', 'phone_s' => '+380 5S 123 45 67', 'phone_b' => '+380 5B 123 45 67'];
$good = true;
foreach ($samples as $cat => $ph) {
    [$x] = sendAll($r, [['phone' => $ph]]);
    $good = $good && (in_array($cat, $r['bugs'], true) ? $x[0]['result'] === 'bug' : !$x[0]['accepted']);
}
check($good, 'дві літери-двійники — поломки, решта двійників відхилені');
[$x] = sendAll($r, [['phone' => '+380 93 ABC 12 34'], ['phone' => '+380 98'], ['phone' => '050 111 22 33']]);
check(!$x[0]['accepted'] && !$x[1]['accepted'] && $x[2]['accepted'], 'явні літери й закороткий — відмова; 050 111 22 33 — прийнято');

echo "6. 2.4 «Задовге імʼя»\n";
$r = bv_scene_rules('form_length', 'l1', 204);
$k = $r['fields'][0]['key'];
[$x, $s] = sendAll($r, [[$k => str_repeat('а', $r['limit'])], [$k => str_repeat('б', $r['limit'] + 1)], [$k => str_repeat('в', $r['real_limit'] + 1)]]);
check($x[0]['result'] === 'ok' && $x[0]['accepted'], 'рівно межа — прийнято правильно');
check($x[1]['result'] === 'bug' && str_contains($x[1]['bug']['inp'], '(' . ($r['limit'] + 1) . ')'), 'межа + 1 — поломка, у звіті кількість символів');
check(!$x[2]['accepted'] && $x[2]['result'] === 'ok', 'значно довше — пошта таки відхиляє (справжня межа більша за написану)');
check(bv_scene_rules('form_length', 'l1', 204)['real_limit'] + 1 <= bv_scene_max_input(), 'поломку можна знайти в межах 30 символів вводу');

echo "7. 2.5 «Двічі натиснули» і повтори в інших місіях\n";
$r = bv_scene_rules('form_duplicate', 'd1', 205);
[$x, $s] = sendAll($r, [[], [], []]);
check($x[0]['result'] === 'ok' && $x[1]['result'] === 'bug' && $x[1]['record']['no'] === $x[0]['record']['no'] + 1, 'друге натискання — дубль із новим номером');
check($x[2]['result'] === 'bug' && $x[2]['repeat_bug'] === true && count($s['f']) === 1, 'третє — та сама поломка, вдруге не рахується');
$first = $r['fields'][0]['key'];
[$x] = sendAll($r, [[$first => 'Інше Імʼя'], []]);
check($x[0]['result'] === 'ok' && $x[1]['result'] === 'ok', 'різні дані — дві різні заявки, не дубль');
$req = bv_scene_rules('form_required', 'a1', 201);
[$x] = sendAll($req, [[], []]);
check($x[1]['accepted'] === false && $x[1]['result'] === 'ok' && str_contains($x[1]['text'], 'вже прийнято'), '2.1: повтор тих самих даних — правильна відмова «вже прийнято»');

echo "8. Ввід бланка\n";
$r = bv_scene_rules('form_email', 'e1', 202);
check(bv_form_clean($r, ['email' => 'a@b.cc']) !== null && bv_form_clean($r, ['email' => 'a@b.cc'])['name'] === '', 'відсутні поля — порожні');
check(bv_form_clean($r, ['hack' => 'x']) === null && bv_form_clean($r, 'x') === null && bv_form_clean($r, ['email' => ['x']]) === null,
    'невідоме поле, рядок замість бланка, масив у полі — відмова');
check(bv_form_clean($r, ['email' => str_repeat('a', 31)]) === null, 'поле довше 30 символів — відмова');

echo "9. Сервер\n";
$tag = bin2hex(random_bytes(3));
$pdo->prepare("INSERT INTO users (name, email, password_hash, role, created_at) VALUES ('BV forms', :e, 'x', 'user', NOW())")
    ->execute([':e' => "bv-forms-$tag@example.test"]);
$uid = (int) $pdo->lastInsertId();
$_SESSION = [];
try {
    bv_confirm_age($pdo, $uid);
    $ctx = bv_ctx($uid);
    $ctx['ip'] = '';
    $st = bv_attempt_start($pdo, 202, $ctx);
    check($st['ok'] && $st['scene']['type'] === 'form_scene' && !isset($st['scene']['bugs']), 'старт 2.2: бланк без поломок');
    $tok = $st['token'];
    $a = $pdo->query('SELECT seed FROM bv_attempts WHERE token = ' . $pdo->quote($tok))->fetch(PDO::FETCH_ASSOC);
    $r = bv_scene_rules('form_email', (string) $a['seed'], 202);
    check(bv_scene_finish($pdo, $tok, $ctx)['error'] === 'not_enough', 'здати без знахідок — not_enough');
    check(bv_scene_act($pdo, $tok, 'submit', 'max.poshta.bv', $ctx)['error'] === 'too_long', 'рядок замість бланка — відмова');
    check(bv_scene_act($pdo, $tok, 'submit', ['found' => 'email_no_at'], $ctx)['error'] === 'too_long', 'підроблене поле «found» — відмова');
    check(bv_scene_act($pdo, $tok, 'buy', base($r), $ctx)['reaction']['result'] === 'info', 'дія автомата на бланку — без знахідок');
    $okSend = bv_scene_act($pdo, $tok, 'submit', base($r), $ctx);
    check($okSend['reaction']['accepted'] === true && $okSend['found'] === 0, 'правильний бланк — прийнято, знахідок 0');
    $bugAddr = ['email_no_at' => 'mx.poshta.bv', 'email_at_word' => 'mx(at)poshta.bv', 'email_double_at' => 'mx@@poshta.bv', 'email_space' => 'm x@poshta.bv'][$r['bugs'][0]];
    $hit = bv_scene_act($pdo, $tok, 'submit', ['email' => $bugAddr] + base($r), $ctx);
    check($hit['found'] === 1 && $hit['can_submit'], 'адреса з поломкою — знайдено, можна здавати');
    $fin = bv_scene_finish($pdo, $tok, $ctx);
    check($fin['ok'] && $fin['stars'] === 3 && ($fin['earned']['xp'] ?? 0) === 20 && str_contains($fin['explain'], 'бланку пошти'), 'здано: 3 зірки, 20 XP, розбір про бланк');
    $fin2 = bv_scene_finish($pdo, $tok, $ctx);
    check($fin2['repeat'] && !$fin2['awarded'] && bv_totals($pdo, $uid)['xp'] === 20, 'повторне «Здати» — без нагороди');
    check(bv_scene_act($pdo, $tok, 'submit', base($r), $ctx)['error'] === 'already_checked', 'після здачі бланк не приймається');
    $ck = bv_attempt_check($pdo, $tok, 'x', $ctx);
    check(!$ck['ok'], 'старий check на токені «Пошти» — відмова');
} finally {
    bv_delete_player_data($pdo, $uid);
    $pdo->prepare('DELETE FROM users WHERE id = :u')->execute([':u' => $uid]);
    check((int) $pdo->query('SELECT COUNT(*) FROM bv_attempts WHERE user_id = ' . $uid)->fetchColumn() === 0, 'тестові дані прибрано');
}

echo "\n" . ($fails === 0 ? "PASS $total/$total" : "FAIL $fails з $total") . "\n";
exit($fails === 0 ? 0 : 1);
