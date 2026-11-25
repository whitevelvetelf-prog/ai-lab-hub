<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тест «Поломки дня» і мʼякої серії днів «Багвіля» (міграція № 40; app/bugville/bv-daily.php).
 *   php tests/bugville-daily-tests.php [http://127.0.0.1:8099]
 * Потрібно локально: міграції № 33–40, сид tools/bugville-seed.php, 'bugville_public' => true, запущений сервер.
 *
 * Перевіряє: той самий день — та сама місія й seed; 30 днів — різні seed, один тип не більше 2 днів поспіль, усі типи;
 * гонитва двох перших запитів дня (два процеси) — один рядок; короткий варіант (3 поломки, здати від 2), без поломок
 * у браузері; нагорода раз на день, повтор — без XP; серія (день за днем, вихідний, обрив без повернення вихідного,
 * найкраща не зменшується, значки 3/7/14/30); опівніч і літній/зимовий час за Europe/Kyiv; здача після опівночі —
 * за день початку; гість не пише в bv_daily_results і не зараховується після входу; підроблений клієнт без дій — без
 * нагороди; через HTTP — картка на карті (гість / акаунт до й після проходу), сторінка дня, гра й нагорода.
 * Тестові записи видаляються (дні 2099 року, тестові акаунти, рядок сьогоднішнього дня — якщо його створив тест). Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

if (($argv[1] ?? '') === '--race') {   // дочірній процес тесту гонитви: перший запит дня
    /** @var PDO $pdo */
    $pdo = require __DIR__ . '/../config/database.php';
    require_once __DIR__ . '/../app/bugville/bv-daily.php';
    $until = (float) $argv[3];
    while (microtime(true) < $until) {
        usleep(200);
    }
    echo json_encode(bv_daily_get($pdo, $argv[2]));
    exit(0);
}

ini_set('session.use_cookies', '0');
ini_set('session.save_path', sys_get_temp_dir());
session_start();   // гість у процесі: ✓ Поломки дня в сесії
$base = rtrim($argv[1] ?? 'http://127.0.0.1:8099', '/');
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
require_once __DIR__ . '/../app/bugville/bv-scene-play.php';
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

/** @return array{code:int, body:string} */
function page(string $jar, string $url, ?array $post = null): array
{
    $ch = curl_init($url);
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_TIMEOUT => 30,
        CURLOPT_USERAGENT => 'Mozilla/5.0 bugville-daily-tests']);
    if ($post !== null) {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post));
    }
    $body = (string) curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    unset($ch);

    return ['code' => $code, 'body' => $body];
}

function api(string $base, string $jar, string $csrf, array $data): array
{
    $ch = curl_init($base . '/bv-api.php');
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode($data), CURLOPT_HTTPHEADER => ['Content-Type: application/json', 'X-CSRF-Token: ' . $csrf, 'Origin: ' . $base]]);
    $raw = (string) curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    unset($ch);

    return ((array) json_decode($raw, true)) + ['_code' => $code];
}

function csrf_of(string $html): string
{
    return preg_match('/name="csrf-token" content="([a-f0-9]{64})"/', $html, $m) === 1 ? $m[1]
        : (preg_match('/name="csrf" value="([a-f0-9]{64})"/', $html, $m2) === 1 ? $m2[1] : '');
}

/**
 * Знайти всі поломки варіанта (тест знає правила — гравець ні). $act(op, input) → відповідь scene_act.
 * @return int скільки дій повідомили про нову поломку
 */
function bv_test_solve(array $rules, callable $act): int
{
    $hits = 0;
    $got = static function (array $r) use (&$hits): void {
        $hits += count((array) ($r['reaction']['bugs'] ?? (isset($r['reaction']['bug']) ? [1] : [])));
    };
    if ($rules['type'] === 'input_machine') {
        $in = ['zero' => '0', 'neg' => '-1', 'over' => (string) ($rules['max'] + 1), 'nan' => 'abc', 'dec' => '1.5'];
        $order = array_values(array_unique(array_merge(in_array('over', $rules['bugs'], true) ? ['over'] : [], $rules['bugs'])));
        foreach ($order as $b) {
            $act('refill', '');
            $got($act('buy', $in[$b]));
        }
    } elseif ($rules['type'] === 'form_scene') {
        $vals = array_column($rules['fields'], 'value', 'key');
        $email = ['email_no_at' => 'ivanposhta.bv', 'email_at_word' => 'ivan(at)poshta.bv', 'email_double_at' => 'ivan@@poshta.bv', 'email_space' => 'iv an@poshta.bv'];
        $phone = ['phone_o' => 'O513580000', 'phone_l' => '05l3580000', 'phone_z' => '051З580000', 'phone_s' => '0513S80000', 'phone_b' => '05135B0000'];
        foreach ($rules['bugs'] as $b) {
            $v = $vals;
            if (isset($email[$b])) {
                $v['email'] = $email[$b];
            } else {
                $v['phone'] = $phone[$b];
            }
            $got($act('submit', $v));
        }
    } else {
        foreach ($rules['bug_defs'] as $d) {
            $got($act('check', $d['cells']));
        }
    }

    return $hits;
}

if (bv_cfg('bugville_public') !== true) {
    fwrite(STDERR, "need 'bugville_public' => true\n");
    exit(2);
}
try {
    $pdo->query('SELECT 1 FROM bv_daily_results LIMIT 0');
} catch (Throwable) {
    fwrite(STDERR, "need migration 40 (bv_daily, bv_daily_results)\n");
    exit(2);
}

$GLOBALS['bv_cfg_override'] = ['bugville_starts_per_min_player' => 1000, 'bugville_acts_per_min_player' => 5000, 'bugville_checks_per_min_player' => 1000];
$_SERVER['REMOTE_ADDR'] = '';
$tag = bin2hex(random_bytes(3));
$pass = 'E2e-' . bin2hex(random_bytes(6));
$users = [];
$jars = [];
$testDays = [];
$realToday = bv_day_at();
$t0 = bv_now();
$hadToday = (bool) $pdo->query('SELECT COUNT(*) FROM bv_daily WHERE day = ' . $pdo->quote($realToday))->fetchColumn();
$mk = static function (string $n, bool $age = true) use ($pdo, $tag, $pass, &$users): array {
    $email = "bv-daily-$n-$tag@example.test";
    $pdo->prepare("INSERT INTO users (name, email, password_hash, role, created_at) VALUES (:n, :e, :h, 'user', NOW())")
        ->execute([':n' => "BV daily $n", ':e' => $email, ':h' => password_hash($pass, PASSWORD_DEFAULT)]);
    $users[] = $id = (int) $pdo->lastInsertId();
    if ($age) {
        bv_confirm_age($pdo, $id);
    }

    return ['id' => $id, 'email' => $email];
};
$day = static function (string $d) use (&$testDays): string {
    $testDays[$d] = true;

    return $GLOBALS['bv_today'] = $d;
};
/** Зіграти Поломку дня в процесі (без HTTP): старт → дії → здача. */
$play = static function (array $ctx, bool $solve = true) use ($pdo): array {
    $s = bv_daily_start($pdo, $ctx);
    if (!$s['ok']) {
        return ['start' => $s];
    }
    $st = $pdo->prepare('SELECT seed FROM bv_attempts WHERE token = :t');
    $st->execute([':t' => $s['token']]);
    $rules = bv_scene_rules('daily', (string) $st->fetchColumn(), BV_DAILY_ID);
    $hits = $solve ? bv_test_solve($rules, static fn(string $op, mixed $in) => bv_scene_act($pdo, $s['token'], $op, $in, $ctx)) : 0;

    return ['start' => $s, 'rules' => $rules, 'hits' => $hits, 'finish' => bv_scene_finish($pdo, $s['token'], $ctx)];
};
$xpLog = static function (int $uid) use ($pdo): array {
    $st = $pdo->prepare("SELECT COUNT(*), COALESCE(SUM(xp), 0), COALESCE(SUM(coins), 0) FROM bv_xp_log WHERE user_id = :u AND source = 'daily'");
    $st->execute([':u' => $uid]);

    return array_map('intval', $st->fetch(PDO::FETCH_NUM));
};

try {
    echo "Вибір місії дня\n";
    $a = bv_daily_choose('2099-03-10');
    check($a === bv_daily_choose('2099-03-10') && strlen($a['seed']) === 24, 'та сама дата — та сама місія й seed (чиста функція)');
    $day('2099-03-10');
    $g1 = bv_daily_get($pdo);
    $g2 = bv_daily_get($pdo);
    check($g1 === $g2 && $g1['seed'] === $a['seed'] && $g1['mission_type'] === $a['mission_type'], 'та сама дата з БД — той самий рядок');
    $seeds = [];
    $types = [];
    $run = 1;
    $maxRun = 1;
    $prev = null;
    for ($i = 0; $i < 30; $i++) {
        $d = (new DateTimeImmutable('2099-05-01'))->modify("+$i day")->format('Y-m-d');
        $c = bv_daily_choose($d);
        $seeds[$c['seed']] = true;
        $types[$c['mission_type']] = ($types[$c['mission_type']] ?? 0) + 1;
        $run = $c['mission_type'] === $prev ? $run + 1 : 1;
        $maxRun = max($maxRun, $run);
        $prev = $c['mission_type'];
    }
    check(count($seeds) === 30, '30 днів — 30 різних seed');
    check($maxRun <= 2 && count($types) === count(bv_daily_types()), "один тип не більше 2 днів поспіль (найдовше: $maxRun), усі типи трапляються");
    $GLOBALS['bv_cfg_override']['bugville_daily_salt'] = 'other-salt';
    check(bv_daily_choose('2099-03-10')['seed'] !== $a['seed'], 'інша сіль — інший seed (не вгадати наперед без солі)');
    unset($GLOBALS['bv_cfg_override']['bugville_daily_salt']);
    $GLOBALS['bv_cfg_override']['bugville_daily_types'] = ['table_scene', 'bogus'];
    check(bv_daily_choose('2099-03-11')['mission_ref'] === 'daily_table', 'лише типи з config (невідомі пропускаються)');
    unset($GLOBALS['bv_cfg_override']['bugville_daily_types']);

    echo "Гонитва першого запиту дня\n";
    $raceDay = '2099-04-0' . random_int(1, 9);
    $testDays[$raceDay] = true;
    $pdo->prepare('DELETE FROM bv_daily WHERE day = :d')->execute([':d' => $raceDay]);
    $at = microtime(true) + 1.5;
    $procs = [];
    for ($p = 0; $p < 2; $p++) {
        $procs[] = proc_open([PHP_BINARY, __FILE__, '--race', $raceDay, (string) $at], [1 => ['pipe', 'w'], 2 => ['pipe', 'w']], $pipes[$p]);
    }
    $outs = [];
    foreach ($procs as $p => $h) {
        $outs[] = stream_get_contents($pipes[$p][1]);
        proc_close($h);
    }
    $cnt = (int) $pdo->query('SELECT COUNT(*) FROM bv_daily WHERE day = ' . $pdo->quote($raceDay))->fetchColumn();
    check($cnt === 1 && $outs[0] !== '' && $outs[0] === $outs[1], 'два одночасні перші запити — один рядок, обидва бачать ту саму місію');

    echo "Короткий варіант дня\n";
    $okShort = true;
    $leak = false;
    foreach (['dm', 'df', 'dt'] as $gen) {
        for ($i = 0; $i < 40; $i++) {
            $r = bv_scene_rules('daily', $gen . ':' . bin2hex(random_bytes(12)), BV_DAILY_ID);
            $okShort = $okShort && $r !== null && count($r['bugs']) === 3 && $r['min_found'] === 2 && count(array_unique($r['bugs'])) === 3;
            $pub = json_encode(bv_scene_public($r), JSON_UNESCAPED_UNICODE);
            foreach ($r['bugs'] as $b) {
                $leak = $leak || str_contains($pub, '"' . $b . '"');
            }
            $leak = $leak || str_contains($pub, '"bugs"') || str_contains($pub, 'seed');
        }
    }
    check($okShort, 'автомат, пошта, бібліотека: 3 поломки, здати від 2 (120 варіантів)');
    check(!$leak, 'у браузер не йдуть поломки й seed');
    check(bv_scene_rules('daily', 'daily_machine:abc', BV_DAILY_ID) === null && bv_scene_rules('daily', 'abc', BV_DAILY_ID) === null,
        'seed спроби дня лише з генераторами дня');
    $fr = bv_scene_rules('daily', 'df:1234abcd', BV_DAILY_ID);
    check(str_contains($fr['intro'], 'Сьогодні поломок 3. Знайдіть щонайменше <b>2 поломки</b>.'), 'вступ пошти дня: «Сьогодні поломок 3, знайдіть щонайменше 2»');

    echo "Нагорода раз на день\n";
    $u = $mk('reward');
    $ctxU = bv_ctx($u['id']);
    $d1 = $day('2099-06-01');
    $fake = bv_daily_start($pdo, $ctxU);
    $ff = bv_scene_finish($pdo, $fake['token'], $ctxU);
    check(!$ff['ok'] && $ff['error'] === 'not_enough' && $xpLog($u['id'])[0] === 0, 'здача без дій — «замало поломок», нагороди немає');
    $p1 = $play($ctxU);
    $f1 = $p1['finish'];
    check($p1['hits'] === 3 && $f1['ok'] && ($f1['earned']['xp'] ?? 0) === 15 && ($f1['earned']['coins'] ?? 0) === 2 && $f1['awarded'],
        'перший успішний прохід дня: 3 поломки, +15 XP, +2 монети');
    check(($f1['daily']['day'] ?? '') === $d1 && !empty($f1['daily']['tomorrow']), 'відповідь із днем і «завтра буде нова поломка»');
    $res = bv_daily_result($pdo, $u['id'], $d1);
    check($res['done'] === 1 && $res['rewarded'] === 1 && $res['found_count'] === 3 && $res['tries'] === 2, 'bv_daily_results: done, rewarded, 3 знайдено, 2 спроби');
    $p2 = $play($ctxU);
    check($p2['finish']['ok'] && ($p2['finish']['earned']['xp'] ?? -1) === 0 && !empty($p2['finish']['daily']['already']) && !$p2['finish']['awarded'],
        'повторний прохід того ж дня — дозволено, без XP і монет');
    check($xpLog($u['id']) === [1, 15, 2], 'у журналі XP — один запис дня (15 XP, 2 монети)');
    check($p2['start']['scene'] == $p1['start']['scene'], 'повтор того ж дня — той самий варіант');
    $rep = bv_scene_finish($pdo, $p1['start']['token'], $ctxU);
    check(!empty($rep['repeat']) && empty($rep['awarded']), 'повторна здача того самого токена — без нагороди');
    check($p1['finish']['stars'] === 3 && $p2['finish']['stars'] === 2, 'зірки дня: перша здана спроба — 3 (нездана не рахується), повтор — 2');
    $day('2099-06-02');
    $p3 = $play($ctxU);
    check(($p3['finish']['earned']['xp'] ?? 0) === 15 && $p3['finish']['stars'] === 3 && $xpLog($u['id']) === [2, 30, 4], 'наступний день — нова нагорода, 3 зірки з першої спроби');

    echo "Серія днів\n";
    $s = $mk('streak');
    $t = static fn(string $d) => bv_streak_touch($pdo, $s['id'], $d);
    check($t('2099-06-01')['current'] === 1 && $t('2099-06-02')['current'] === 2 && $t('2099-06-03')['current'] === 3, 'прохід щодня — серія росте (1, 2, 3)');   // пн–ср
    check($t('2099-06-03')['changed'] === false, 'той самий день удруге — без змін');
    $x = $t('2099-06-05');   // пт: пропуск чт
    check($x['current'] === 4 && $x['rested'], 'пропуск 1 дня при доступному вихідному — серія триває (4)');
    $GLOBALS['bv_today'] = '2099-06-06';
    check(bv_streak_view($pdo, $s['id'])['rest_left'] === false, 'вихідний цього тижня вже використано');
    $x = $t('2099-06-07');   // нд: пропуск сб, вихідний тижня вже був
    check($x['current'] === 1 && $x['restarted'] && $x['best'] === 4, 'ще пропуск того ж тижня — нова серія з 1, найкраща лишається 4');
    $x = $t('2099-06-09');   // наступний тиждень, вт: пропуск пн — вихідний нового тижня
    check($x['current'] === 2 && $x['rested'], 'новий тиждень — новий вихідний');
    $x = $t('2099-06-12');   // пт: пропуск ср і чт (2 дні)
    check($x['current'] === 1 && $x['restarted'] && $x['best'] === 4, 'пропуск 2 днів — нова серія, найкраща не зменшується');
    $GLOBALS['bv_today'] = '2099-06-12';
    check(bv_streak_view($pdo, $s['id'])['rest_left'] === false, 'після обриву вихідний того ж тижня не повертається');
    $x = $t('2099-06-10');
    check($x['changed'] === false && $x['current'] === 1, 'день, раніший за останній, нічого не змінює');
    $GLOBALS['bv_today'] = '2099-06-20';
    check(bv_streak_view($pdo, $s['id']) === ['current' => 0, 'best' => 4, 'rest_left' => true, 'today' => false], 'після довгої перерви показ — 0, найкраща 4');
    $GLOBALS['bv_cfg_override']['bugville_streak_rest_per_week'] = 0;
    $s0 = $mk('norest');
    bv_streak_touch($pdo, $s0['id'], '2099-06-01');
    check(bv_streak_touch($pdo, $s0['id'], '2099-06-03')['current'] === 1, 'config без вихідних — пропуск обриває серію');
    unset($GLOBALS['bv_cfg_override']['bugville_streak_rest_per_week']);
    $pdo->prepare('UPDATE bv_streaks SET best_days = 30 WHERE user_id = :u')->execute([':u' => $s['id']]);
    $nb = array_column(bv_badges_check($pdo, $s['id']), 'key');
    check(array_intersect(['streak', 'streak_7', 'streak_14', 'streak_30'], $nb) === ['streak', 'streak_7', 'streak_14', 'streak_30'], 'значки серії 3, 7, 14, 30 днів');
    $titles = array_column(bv_badges($pdo), 'title', 'key');
    check(($titles['streak_7'] ?? '') === 'Тиждень пошуків' && ($titles['streak_30'] ?? '') === 'Місяць майстра', 'назви значків серії — з БД (сид)');

    echo "Серію рахує лише Поломка дня\n";
    $v = $mk('only');
    $day('2099-07-01');
    $pv = bv_progress_update($pdo, $v['id'], 0, false);
    check($pv['streak']['current'] === 0, 'звичайна місія / іспит (active = false) серію не зараховує');
    $pd = $play(bv_ctx($v['id']));
    $pr = bv_progress_update($pdo, $v['id'], 0, true, $pd['finish']['daily']['day']);
    check($pr['streak']['current'] === 1 && bv_streak_view($pdo, $v['id'])['today'] === true, 'здана Поломка дня — день у серії');

    echo "Опівніч і літній / зимовий час (Europe/Kyiv)\n";
    check(bv_day_at('2099-01-15 21:59:59') === '2099-01-15' && bv_day_at('2099-01-15 22:00:00') === '2099-01-16', 'зима (UTC+2): 21:59:59 UTC — той самий день, 22:00 UTC — наступний');
    check(bv_day_at('2099-07-15 20:59:59') === '2099-07-15' && bv_day_at('2099-07-15 21:00:00') === '2099-07-16', 'літо (UTC+3): 20:59:59 UTC — той самий день, 21:00 UTC — наступний');
    check(bv_day_at('2026-03-28 21:59:59') === '2026-03-28' && bv_day_at('2026-03-29 20:59:59') === '2026-03-29' && bv_day_at('2026-03-29 21:00:00') === '2026-03-30',
        'перехід на літній час (29.03.2026): межа доби зсувається з 22:00 на 21:00 UTC');
    check(bv_day_at('2026-10-24 21:00:00') === '2026-10-25' && bv_day_at('2026-10-25 21:59:59') === '2026-10-25' && bv_day_at('2026-10-25 22:00:00') === '2026-10-26',
        'перехід на зимовий час (25.10.2026): доба 25 жовтня має 25 годин');
    $m = $mk('midnight');
    $ctxM = bv_ctx($m['id']);
    $day('2099-08-01');
    $sm = bv_daily_start($pdo, $ctxM);
    $st = $pdo->prepare('SELECT seed FROM bv_attempts WHERE token = :t');
    $st->execute([':t' => $sm['token']]);
    $rm = bv_scene_rules('daily', (string) $st->fetchColumn(), BV_DAILY_ID);
    bv_test_solve($rm, static fn(string $op, mixed $in) => bv_scene_act($pdo, $sm['token'], $op, $in, $ctxM));
    $day('2099-08-02');   // здача вже після опівночі
    $fm = bv_scene_finish($pdo, $sm['token'], $ctxM);
    check(($fm['daily']['day'] ?? '') === '2099-08-01' && (bv_daily_result($pdo, $m['id'], '2099-08-01')['done'] ?? 0) === 1
        && bv_daily_result($pdo, $m['id'], '2099-08-02') === null, 'спроба, почата до опівночі, зараховується за день початку');
    $p8 = $play($ctxM);
    check(($p8['finish']['earned']['xp'] ?? 0) === 15 && $p8['rules'] != $rm, 'новий день після опівночі — нова поломка й нова нагорода');

    echo "Гість\n";
    $_SESSION = [];
    $ctxG = bv_ctx(null);
    $before = (int) $pdo->query('SELECT COUNT(*) FROM bv_daily_results')->fetchColumn();
    $day('2099-09-01');
    $pg = $play($ctxG);
    $after = (int) $pdo->query('SELECT COUNT(*) FROM bv_daily_results')->fetchColumn();
    check($pg['finish']['ok'] && $before === $after, 'гість проходить, але в bv_daily_results нічого не пишеться');
    check(empty($pg['finish']['saved']) && empty($pg['finish']['earned']) && ($pg['finish']['would_earn']['xp'] ?? 0) === 15 && !empty($pg['finish']['daily']['guest']),
        'гостю — результат і «було б +15 XP», без збереження');
    check(!in_array($pg['start']['token'], (array) ($_SESSION['bv_guest']['tokens'] ?? []), true), 'токен дня гостя не стає кандидатом на зарахування після входу');
    $c = $mk('credit');
    $cr = bv_credit_guest_session($pdo, $c['id']);
    check(($cr['credited'] ?? 0) === 0 && $xpLog($c['id'])[0] === 0 && bv_daily_result($pdo, $c['id'], '2099-09-01') === null, 'після входу гостьова Поломка дня не зараховується');
    check(bv_daily_card($pdo, null)['done'] === true && bv_daily_card($pdo, null)['streak'] === null, 'картка гостя: ✓ у цьому сеансі, без серії');
    unset($GLOBALS['bv_today']);

    echo "Через HTTP\n";
    $g = $jars[] = (string) tempnam(sys_get_temp_dir(), 'bvd');
    $gm = page($g, $base . '/bugville.php')['body'];
    check(str_contains($gm, 'id="bv-daily-h"') && str_contains($gm, 'Зареєструйтесь</a>, щоб рахувати дні підряд') && !str_contains($gm, 'Днів поспіль'),
        'карта гостя: картка «Поломка дня» без серії, «Зареєструйтесь, щоб рахувати дні підряд»');
    $w = $mk('http');
    $jar = $jars[] = (string) tempnam(sys_get_temp_dir(), 'bvd');
    $lp = page($jar, $base . '/login.php');
    page($jar, $base . '/login.php', ['csrf' => csrf_of($lp['body']), 'email' => $w['email'], 'password' => $pass]);
    $m0 = page($jar, $base . '/bugville.php')['body'];
    check(str_contains($m0, 'Днів поспіль: <strong>0</strong> · Найкраща серія: <strong>0</strong>') && !str_contains($m0, 'bv-daily__done') && str_contains($m0, '>Грати</a>'),
        'карта акаунта до проходу: серія 0, кнопка «Грати», без ✓');
    $dp = page($jar, $base . '/bugville-daily.php');
    $todayRow = bv_daily_get($pdo, bv_day_at());
    check($dp['code'] === 200 && str_contains($dp['body'], 'data-daily="1"') && !preg_match('/daily_(machine|form|table)/', $dp['body'])
        && !str_contains($dp['body'], $todayRow['seed']),
        'сторінка дня: оболонка без seed і генератора');
    $csrf = csrf_of($dp['body']);
    $sd = api($base, $jar, $csrf, ['action' => 'start', 'daily' => true]);
    check(($sd['ok'] ?? false) && isset($sd['scene'], $sd['daily']['title']) && !isset($sd['scene']['bugs']) && !str_contains(json_encode($sd), 'seed'),
        'start {daily: true}: сцена дня без поломок і seed');
    $fk = api($base, $jar, $csrf, ['action' => 'scene_finish', 'token' => $sd['token'] ?? '', 'found' => 3, 'bugs' => ['zero', 'neg', 'over'], 'summary' => ['found' => 3]]);
    check($fk['_code'] === 409 && ($fk['error'] ?? '') === 'not_enough' && $xpLog($w['id'])[0] === 0, 'підроблений клієнт («знайдено 3» без дій) — 409, нагороди немає');
    $todayRow = bv_daily_get($pdo, bv_day_at());
    $rules = bv_scene_rules('daily', bv_daily_attempt_seed($todayRow), BV_DAILY_ID);
    $hits = bv_test_solve($rules, static fn(string $op, mixed $in) => api($base, $jar, $csrf, ['action' => 'scene_act', 'token' => $sd['token'], 'op' => $op, 'input' => $in]));
    $fh = api($base, $jar, $csrf, ['action' => 'scene_finish', 'token' => $sd['token']]);
    check($hits === 3 && ($fh['earned']['xp'] ?? 0) === 15 && ($fh['progress']['streak']['current'] ?? 0) === 1, 'гра через API: 3 поломки, +15 XP, серія 1');
    $m1 = page($jar, $base . '/bugville.php')['body'];
    check(str_contains($m1, 'class="bv-daily__done"') && str_contains($m1, 'Днів поспіль: <strong>1</strong>') && str_contains($m1, 'Зіграти ще раз'),
        'карта після проходу: ✓ Пройдено, серія 1, «Зіграти ще раз»');
    $sg = api($base, $g, csrf_of(page($g, $base . '/bugville-daily.php')['body']), ['action' => 'start', 'daily' => true]);
    $hg = bv_test_solve($rules, static fn(string $op, mixed $in) => api($base, $g, csrf_of(page($g, $base . '/bugville-daily.php')['body']),
        ['action' => 'scene_act', 'token' => $sg['token'] ?? '', 'op' => $op, 'input' => $in]));
    $gcs = csrf_of(page($g, $base . '/bugville-daily.php')['body']);
    $fg = api($base, $g, $gcs, ['action' => 'scene_finish', 'token' => $sg['token'] ?? '']);
    check($hg === 3 && ($fg['ok'] ?? false) && empty($fg['saved']) && !isset($fg['progress']), 'гість через API: той самий варіант дня, результат без збереження');
    check(str_contains(page($g, $base . '/bugville.php')['body'], 'class="bv-daily__done"'), 'карта гостя після проходу: ✓ у цьому сеансі');

    echo "Видалення даних\n";
    $dry = bv_delete_player_data($pdo, $u['id'], true);
    check(($dry['bv_daily_results'] ?? 0) === 2, 'видалення даних гравця охоплює bv_daily_results');
} finally {
    unset($GLOBALS['bv_today']);
    foreach ($users as $id) {
        bv_delete_player_data($pdo, $id);
        $pdo->prepare('DELETE FROM users WHERE id = :u')->execute([':u' => $id]);
    }
    $pdo->prepare("DELETE FROM bv_attempts WHERE kind = 'daily' AND user_id IS NULL AND (variant_key LIKE 'd:2099-%' OR started_at >= :t)")->execute([':t' => $t0]);
    foreach (array_keys($testDays) as $d) {
        $pdo->prepare('DELETE FROM bv_daily WHERE day = :d')->execute([':d' => $d]);
    }
    $pdo->exec("DELETE FROM bv_daily WHERE day >= '2099-01-01'");
    if (!$hadToday) {   // рядок сьогоднішнього дня створив тест (на справжньому сайті він зʼявиться сам при першому зверненні)
        $pdo->prepare('DELETE FROM bv_daily WHERE day = :d')->execute([':d' => $realToday]);
    }
    foreach ($jars as $f) {
        @unlink($f);
    }
    session_destroy();
}

echo "\n" . ($fails === 0 ? "PASS $total/$total" : "FAIL $fails з $total") . "\n";
exit($fails === 0 ? 0 : 1);
