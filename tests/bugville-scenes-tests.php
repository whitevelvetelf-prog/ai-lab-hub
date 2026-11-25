<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тест інтерактивної сцени «Автомат» (Етап A): рушій bv-scenes.php (чисті функції) і серверний шар
 * bv-scene-play.php з БД (старт, дії, «Здати роботу», нагороди, одноразовий токен), без HTTP.
 *   php tests/bugville-scenes-tests.php
 * Потрібно локально: міграції № 33 і № 38. Тестові записи (користувач, спроби, журнал нагород) видаляються. Лише CLI.
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

/** Прогнати дії по правилах: [[op, input], …] → [реакції, стан]. */
function run(array $rules, array $acts): array
{
    $state = bv_scene_initial_state($rules);
    $out = [];
    foreach ($acts as [$op, $in]) {
        [$x, $state] = bv_scene_machine_act($rules, $state, $op, $in);
        $out[] = $x;
    }

    return [$out, $state];
}

$gens = ['machine_change' => 101, 'machine_zero' => 102, 'machine_limit' => 103, 'machine_minus' => 104, 'machine_boundary' => 105];

echo "1. Варіанти від seed\n";
$r1 = bv_scene_rules('machine_boundary', 'seed-a', 105);
$r2 = bv_scene_rules('machine_boundary', 'seed-a', 105);
check($r1 === $r2, 'той самий seed → ті самі правила');
$maxes = [];
$prices = [];
$sameCount = true;
foreach ($gens as $g => $mid) {
    $counts = [];
    for ($i = 0; $i < 60; $i++) {
        $r = bv_scene_rules($g, "s$i", $mid);
        $counts[count($r['bugs'])] = true;
        if ($g === 'machine_boundary') {
            $maxes[$r['max']] = true;
            $prices[$r['price']] = true;
        }
    }
    $sameCount = $sameCount && count($counts) === 1;
}
check($sameCount, 'рівноцінність: у всіх варіантів місії однакова кількість поломок');
check(min(array_keys($maxes)) >= 3 && max(array_keys($maxes)) <= 9 && count($maxes) >= 5, 'межа 1.5 від 3 до 9 і справді змінюється (' . count($maxes) . ' різних)');
check(count($prices) >= 5, 'ціна змінюється між варіантами (' . count($prices) . ' різних)');
check(bv_scene_rules('nope', 's', 105) === null, 'невідомий генератор → null');
check(bv_scene_rules('machine_boundary', 'x', 105)['min_found'] === 3 && bv_scene_rules('machine_zero', 'x', 102)['min_found'] === 1,
    'мінімум для здачі з config: 1.5 — 3 з 5, 1.2 — 1');

echo "2. Браузер не бачить правил\n";
$leak = false;
foreach ($gens as $g => $mid) {
    for ($i = 0; $i < 10; $i++) {
        $r = bv_scene_rules($g, "p$i", $mid);
        $pub = bv_scene_public($r);
        $json = json_encode($pub, JSON_UNESCAPED_UNICODE);
        foreach (['bugs', 'kinds', 'bug_notes', 'seed'] as $k) {
            $leak = $leak || array_key_exists($k, $pub);
        }
        foreach ($r['bugs'] as $b) {
            $leak = $leak || str_contains($json, '"' . $b . '"');
        }
        foreach ((array) $r['hints'] as $h) {
            $leak = $leak || str_contains($json, $h);
        }
    }
}
check(!$leak, 'публічна сцена без переліку поломок, видів, купюр із поломками, seed і текстів підказок');

echo "3. Автомат 1.5: правильні дії, поломки, повтори\n";
$r = bv_scene_rules('machine_boundary', 'case-1', 105);
$max = $r['max'];
[$x, $s] = run($r, [['buy', '1'], ['buy', (string) $max], ['buy', (string) ($max + 2)], ['buy', '']]);
check($x[0]['result'] === 'ok' && $x[1]['result'] === 'ok' && $x[2]['result'] === 'ok' && $s['f'] === [], 'межі 1 і max, max + 2 — працює правильно, поломок не знайдено');
check($x[3]['result'] === 'info' && $x[0]['goods'] === 1 && $x[1]['goods'] === $max, 'порожній ввід — підказка; у лоток падає стільки, скільки куплено');
[$x, $s] = run($r, [['buy', '0'], ['buy', '-3'], ['buy', (string) ($max + 1)], ['buy', 'abc'], ['buy', '0,5'], ['buy', '0']]);
check($s['f'] === ['zero', 'neg', 'over', 'nan', 'dec'], 'усі 5 поломок: 0, мінус, max + 1, літери, дріб');
check(isset($x[0]['bug']['title'], $x[0]['bug']['inp'], $x[0]['bug']['got'], $x[0]['bug']['exp']), 'картка поломки: ввели → сталося → мало бути');
check(!isset($x[5]['bug']) && $x[5]['repeat_bug'] === true && count($s['f']) === 5, 'повторна та сама поломка не рахується вдруге');
check($x[1]['wallet'] > $x[0]['wallet'], '«Гроші з нічого»: мінус додає монети в гаманець сцени');
$sum = bv_scene_summary($r, $s);
check($sum['found'] === 5 && $sum['total'] === 5 && $sum['tries'] === 6, 'підсумок: 5 з 5, 6 спроб');
[$x] = run($r, [['buy', str_repeat('9', 25)], ['buy', '−2'], ['buy', ' 3 ']]);
check($x[0]['result'] === 'ok' && $x[1]['result'] === 'bug' && $x[2]['result'] === 'ok', 'величезне число — відмова; «−» з клавіатури — мінус; пробіли обрізано');
[$x] = run($r, [['refill', ''], ['claim', '5'], ['zzz', '1']]);
check($x[0]['result'] === 'info' && $x[0]['wallet'] === 100 && $x[1]['result'] === 'info' && $x[2]['result'] === 'info', 'поповнення гаманця й зайві дії — без знахідок');

echo "4. Інші місії рівня: лише поломки своєї теми\n";
$z = bv_scene_rules('machine_zero', 'z', 102);
[$x, $s] = run($z, [['buy', '-1'], ['buy', 'abc'], ['buy', '1.5'], ['buy', (string) ($z['max'] + 1)], ['buy', '0']]);
check(array_slice(array_column($x, 'result'), 0, 4) === ['ok', 'ok', 'ok', 'ok'] && $s['f'] === ['zero'], '1.2: мінус, літери, дріб, max + 1 — правильно; поломка лише на 0');
$m = bv_scene_rules('machine_minus', 'm', 104);
[, $s] = run($m, [['buy', '0'], ['buy', '-2']]);
check($s['f'] === ['neg'], '1.4: 0 — правильно, мінус — поломка');
$lim = null;
$stk = null;
for ($i = 0; ($lim === null || $stk === null) && $i < 50; $i++) {
    $t = bv_scene_rules('machine_limit', "l$i", 103);
    if ($t['stock'] === null) {
        $lim = $lim ?? $t;
    } else {
        $stk = $stk ?? $t;
    }
}
[, $s] = run($lim, [['buy', (string) $lim['max']], ['buy', (string) ($lim['max'] + 1)]]);
check($s['f'] === ['over'], '1.3 «за раз»: max — правильно, max + 1 — поломка');
[$x, $s] = run($stk, [['buy', (string) $stk['stock']], ['buy', (string) ($stk['stock'] + 1)]]);
check($x[0]['result'] === 'ok' && $s['f'] === ['stock'] && $x[1]['goods'] === $stk['stock'], '1.3 «запас»: усе, що є, — правильно; на одну більше — гроші взято, видано лише запас');

echo "5. 1.1 «Скільки монет?»: гравець сам рахує решту\n";
$c = bv_scene_rules('machine_change', 'c1', 101);
$good = null;
foreach ([$c['price'] + 1, $c['price'] + 3, 499] as $cand) {
    if (!in_array($cand, $c['bug_notes'], true)) {
        $good = $cand;
        break;
    }
}
$bn = $c['bug_notes']['change_ten'];
$sw = $c['bug_notes']['change_swap'];
[$x, $s] = run($c, [['claim', '1'], ['buy', (string) $good], ['claim', (string) ($good - $c['price'])], ['buy', (string) $bn],
    ['claim', '7777'], ['claim', (string) ($bn - $c['price'])], ['buy', (string) $sw], ['claim', (string) ($sw - $c['price'])]]);
check($x[0]['result'] === 'info', 'скарга без покупки — підказка');
check($x[1]['result'] === 'ok' && $x[1]['change'] === $good - $c['price'] && $x[2]['result'] === 'useless', 'правильна решта; скарга на неї — марна дія');
check($x[3]['result'] === 'ok' && $x[3]['change'] !== $bn - $c['price'], 'на купюрі з поломкою автомат каже те саме «Решта: …», без натяку');
check($x[4]['result'] === 'useless' && $x[5]['result'] === 'bug', 'неправильне число в скарзі — марно; правильне — поломку знайдено');
check($s['f'] === ['change_ten', 'change_swap'] && $s['u'] === 2, 'обидві поломки решти; марних дій 2');
check(str_contains($x[5]['bug']['exp'], (string) ($bn - $c['price'])), 'у міні-звіті — правильна решта саме цього варіанта');

echo "6. Ввід\n";
check(bv_scene_clean_input(str_repeat('я', 30)) === str_repeat('я', 30) && bv_scene_clean_input(str_repeat('я', 31)) === null,
    '30 символів (кирилиця) — можна, 31 — ні');
check(bv_scene_clean_input("1\x002\u{202E}3") === '123' && bv_scene_clean_input(['x']) === null && bv_scene_clean_input("\xff") === null,
    'керівні символи прибрано; масив і не-UTF-8 — відмова');
check(bv_pl(1, 'монету', 'монети', 'монет') === '1 монету' && bv_coins(3) === '3 монети' && bv_coins(12) === '12 монет' && bv_coins(22) === '22 монети',
    'відмінювання: 1 монету, 3 монети, 12 монет, 22 монети');

echo "7. Сервер: спроба, дії, здача, нагорода, токен\n";
$tag = bin2hex(random_bytes(3));
$pdo->prepare("INSERT INTO users (name, email, password_hash, role, created_at) VALUES ('BV scenes', :e, 'x', 'user', NOW())")
    ->execute([':e' => "bv-scenes-$tag@example.test"]);
$uid = (int) $pdo->lastInsertId();
$_SESSION = [];
$guestTokens = [];
try {
    bv_confirm_age($pdo, $uid);
    $ctx = bv_ctx($uid);
    $ctx['ip'] = '';
    $st = bv_attempt_start($pdo, 105, $ctx);
    check($st['ok'] && $st['scene']['type'] === 'input_machine' && !isset($st['scene']['bugs']), 'старт 1.5: сцена без правил');
    $tok = $st['token'];
    $a = $pdo->query('SELECT * FROM bv_attempts WHERE token = ' . $pdo->quote($tok))->fetch(PDO::FETCH_ASSOC);
    check($a['seed'] !== null && (int) $a['act_count'] === 0 && $a['scene_state_json'] !== null, 'у БД: seed, act_count 0, стан сцени');
    $fin = bv_scene_finish($pdo, $tok, $ctx);
    check(!$fin['ok'] && $fin['error'] === 'not_enough', 'здати без знахідок — not_enough (клієнт не може сказати «я знайшов»)');
    $ck = bv_attempt_check($pdo, $tok, '3', $ctx);
    check(!$ck['ok'] && $ck['error'] === 'bad_answer', 'старий check на токені сцени — відмова (обходу вибором відповіді немає)');
    check(bv_scene_act($pdo, $tok, 'found', '', $ctx)['error'] === 'bad_request', 'невідома дія (op = found) — bad_request');
    check(bv_scene_act($pdo, $tok, 'buy', str_repeat('1', 31), $ctx)['error'] === 'too_long', 'ввід 31 символ — too_long');
    $r = bv_scene_rules('machine_boundary', (string) $a['seed'], 105);
    $acts = [];
    foreach (['1', '0', '-1'] as $in) {
        $acts[] = bv_scene_act($pdo, $tok, 'buy', $in, $ctx);
    }
    check($acts[0]['found'] === 0 && $acts[2]['found'] === 2 && !$acts[2]['can_submit'], 'дії: 1 — правильно, 0 і мінус — 2 поломки, здавати ще рано');
    $fin = bv_scene_finish($pdo, $tok, $ctx);
    check(!$fin['ok'] && $fin['found'] === 2 && $fin['min_found'] === 3, 'при 2 з 3 — ще не можна');
    $act3 = bv_scene_act($pdo, $tok, 'buy', 'xyz', $ctx);
    check($act3['can_submit'] && $act3['acts_left'] === bv_scene_max_actions() - 4, 'третя поломка — можна здавати; лишок дій рахує сервер');
    $other = bv_ctx($uid + 1000000);
    $other['ip'] = '';
    check(bv_scene_act($pdo, $tok, 'buy', '0', $other)['error'] === 'forbidden' && bv_scene_finish($pdo, $tok, $other)['error'] === 'forbidden',
        'чужий гравець не може ні діяти, ні здати');
    $fin = bv_scene_finish($pdo, $tok, $ctx);
    check($fin['ok'] && !$fin['repeat'] && $fin['stars'] === 3 && $fin['score'] === 60, 'здано: 3 зірки (перша спроба без підказки), бал 60 (3 з 5)');
    check(($fin['earned']['xp'] ?? 0) === 20 && ($fin['earned']['coins'] ?? 0) === 10 && $fin['saved'] === true, 'нагорода від сервера: 20 XP і 10 монет');
    $fin2 = bv_scene_finish($pdo, $tok, $ctx);
    check($fin2['ok'] && $fin2['repeat'] && !$fin2['awarded'] && bv_totals($pdo, $uid)['xp'] === 20, 'повторне «Здати» тим самим токеном — без нагороди');
    check(bv_scene_act($pdo, $tok, 'buy', '0', $ctx)['error'] === 'already_checked', 'після здачі дії не приймаються');
    $upd = $pdo->prepare('UPDATE bv_attempts SET used = 1 WHERE token = ? AND used = 0');
    $upd->execute([$tok]);
    check($upd->rowCount() === 0, 'токен одноразовий: UPDATE … used = 1 WHERE used = 0 змінює 0 рядків');

    $st2 = bv_attempt_start($pdo, 105, $ctx);
    $a2 = $pdo->query('SELECT seed, variant_key FROM bv_attempts WHERE token = ' . $pdo->quote($st2['token']))->fetch(PDO::FETCH_ASSOC);
    check($a2['seed'] !== $a['seed'] && $a2['variant_key'] !== $a['variant_key'], 'повтор місії — новий автомат (інший seed і варіант)');
    $h = bv_attempt_hint($pdo, $st2['token'], $ctx);
    check($h['ok'] && count($h['hints']) === 2, 'підказки сцени — з правил варіанта');
    foreach (['0', '-1', 'abc', '0.5'] as $in) {
        bv_scene_act($pdo, $st2['token'], 'buy', $in, $ctx);
    }
    $fin3 = bv_scene_finish($pdo, $st2['token'], $ctx);
    check($fin3['stars'] === 2 && ($fin3['earned']['xp'] ?? -1) === 0, 'друга спроба з підказкою — 2 зірки; нагорода лише за покращення (0)');

    $st3 = bv_attempt_start($pdo, 102, $ctx);
    for ($i = 0; $i < bv_scene_max_actions(); $i++) {
        bv_scene_act($pdo, $st3['token'], 'buy', '1', $ctx);
    }
    $over = bv_scene_act($pdo, $st3['token'], 'buy', '0', $ctx);
    $ac = (int) $pdo->query('SELECT act_count FROM bv_attempts WHERE token = ' . $pdo->quote($st3['token']))->fetchColumn();
    check($over['error'] === 'too_many_actions' && $ac === bv_scene_max_actions(), 'журнал дій обмежено: 51-ша дія — відмова, у БД рівно 50');
    $stale = $pdo->prepare('UPDATE bv_attempts SET scene_state_json = :s, act_count = act_count + 1 WHERE token = :t AND used = 0 AND act_count = :old');
    $stale->execute([':s' => '{}', ':t' => $st2['token'], ':old' => 0]);
    check($stale->rowCount() === 0, 'оптимістичне блокування: застарілий act_count не перезапише стан');

    echo "8. Гість\n";
    $_SESSION = [];
    $g = bv_ctx(null);
    $g['ip'] = '';
    $gs = bv_attempt_start($pdo, 104, $g);
    $guestTokens[] = $gs['token'];
    bv_scene_act($pdo, $gs['token'], 'buy', '-5', $g);
    $gf = bv_scene_finish($pdo, $gs['token'], $g);
    check($gf['ok'] && !isset($gf['earned']) && ($gf['would_earn']['xp'] ?? 0) === 20 && ($gf['would_earn']['coins'] ?? 1) === 0,
        'гість: would_earn 20 XP, без монет і без запису нагород');
    $glog = (int) $pdo->query("SELECT COUNT(*) FROM bv_attempts WHERE token = " . $pdo->quote($gs['token']) . " AND user_id IS NULL AND used = 1")->fetchColumn();
    check($glog === 1, 'гостьова спроба лишається гостьовою до входу');
} finally {
    bv_delete_player_data($pdo, $uid);
    $pdo->prepare('DELETE FROM users WHERE id = :u')->execute([':u' => $uid]);
    foreach ($guestTokens as $t) {
        $pdo->prepare('DELETE FROM bv_attempts WHERE token = :t AND user_id IS NULL')->execute([':t' => $t]);
    }
    $left = (int) $pdo->query('SELECT COUNT(*) FROM bv_attempts WHERE user_id = ' . $uid)->fetchColumn();
    check($left === 0, 'тестові дані прибрано');
}

echo "\n" . ($fails === 0 ? "PASS $total/$total" : "FAIL $fails з $total") . "\n";
exit($fails === 0 ? 0 : 1);
