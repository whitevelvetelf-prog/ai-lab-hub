<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тест звань, значків і щоденної серії «Багвіля» (MAIN_TASK, розділ 6; міграція № 36).
 *   php tests/bugville-progress-tests.php [http://127.0.0.1:8099]
 * Потрібно локально: міграції № 33, 34, 36, сид tools/bugville-seed.php, 'bugville_public' => true.
 *
 * Перевіряє: звання за порогами; серію (день за днем, той самий день, прощений пропуск раз на тиждень, другий пропуск —
 * з початку, рекорд не зменшується, показ після довгої перерви — 0); значки (перша поломка, три зірки, рівень, без
 * підказок, іспит, серія; без книги слів — слова не видаються; повторно — нічого); підвищення звання; CRM (звання:
 * 0 і різні пороги; значки: поріг); через HTTP: правильна відповідь акаунта → «Новий значок», карта зі званням і
 * значками, гостю — підказка; видалення даних гравця прибирає значки й серію. Тестові записи видаляються. Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$base = rtrim($argv[1] ?? 'http://127.0.0.1:8099', '/');
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
require_once __DIR__ . '/../app/bugville/bv-crm.php';
require_once __DIR__ . '/bugville-unlock-helper.php';
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
        CURLOPT_USERAGENT => 'Mozilla/5.0 bugville-progress-tests']);
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
    unset($ch);

    return (array) json_decode($raw, true);
}

function csrf_of(string $html): string
{
    return preg_match('/name="csrf-token" content="([a-f0-9]{64})"/', $html, $m) === 1 ? $m[1]
        : (preg_match('/name="csrf" value="([a-f0-9]{64})"/', $html, $m2) === 1 ? $m2[1] : '');
}

if (bv_ranks($pdo) === [] || bv_cfg('bugville_public') !== true) {
    fwrite(STDERR, "need migration 36, php tools/bugville-seed.php and 'bugville_public' => true\n");
    exit(2);
}

$tag = bin2hex(random_bytes(3));
$pass = 'E2e-' . bin2hex(random_bytes(6));
$users = [];
$jars = [];
$mk = static function (string $n, bool $age = true) use ($pdo, $tag, $pass, &$users): array {
    $email = "bv-prog-$n-$tag@example.test";
    $pdo->prepare("INSERT INTO users (name, email, password_hash, role, created_at) VALUES (:n, :e, :h, 'user', NOW())")
        ->execute([':n' => "BV prog $n", ':e' => $email, ':h' => password_hash($pass, PASSWORD_DEFAULT)]);
    $users[] = $id = (int) $pdo->lastInsertId();
    if ($age) {
        bv_confirm_age($pdo, $id);
    }

    return ['id' => $id, 'email' => $email];
};
$aid = 990500000 + random_int(1, 99999);   // attempt_id для журналу (UNIQUE), вигаданий для тесту
$log = static function (int $uid, int $mission, int $stars, string $source = 'play') use ($pdo, &$aid): void {
    $r = $source === 'exam' ? ['xp' => 50, 'stars' => 0, 'coins' => 30] : bv_reward_for($stars);
    $pdo->prepare('INSERT INTO bv_xp_log (user_id, attempt_id, mission_id, xp, stars, coins, source, created_at) VALUES (:u, :a, :m, :x, :s, :c, :src, :t)')
        ->execute([':u' => $uid, ':a' => $aid++, ':m' => $mission, ':x' => $r['xp'], ':s' => $r['stars'], ':c' => $r['coins'], ':src' => $source, ':t' => bv_now()]);
};
$attempt = static function (int $uid, int $mission, int $hint) use ($pdo): void {
    $pdo->prepare("INSERT INTO bv_attempts (token, user_id, mission_id, variant_key, kind, started_at, used, score, stars, hint_used)
                   VALUES (:t, :u, :m, 'g:test', 'mission', :at, 1, 100, 3, :h)")
        ->execute([':t' => bv_new_token(), ':u' => $uid, ':m' => $mission, ':at' => bv_now(), ':h' => $hint]);
};

try {
    echo "Звання\n";
    $ranks = bv_ranks($pdo);
    check(count($ranks) === 5 && $ranks[0]['min_xp'] === 0, '5 звань, найнижче — від 0 XP');
    $r0 = bv_rank_for($ranks, 0);
    $r99 = bv_rank_for($ranks, 99);
    $r100 = bv_rank_for($ranks, 100);
    $rTop = bv_rank_for($ranks, 5000);
    check($r0['rank']['title'] === 'Учень-шукач' && $r99['to_next'] === 1 && $r99['next']['title'] === 'Помічник майстра', '0 і 99 XP — Учень-шукач, до наступного 1 XP');
    check($r100['rank']['title'] === 'Помічник майстра' && $rTop['rank']['title'] === 'Головний майстер Багвіля' && $rTop['next'] === null, '100 XP — Помічник майстра; 5000 — найвище');

    echo "Серія\n";
    $s = $mk('streak');
    $day = static fn(string $d) => $GLOBALS['bv_today'] = $d;
    $day('2026-11-02');   // понеділок, ISO-тиждень 45
    check(bv_streak_touch($pdo, $s['id'])['current'] === 1, 'перший день — 1');
    check(bv_streak_touch($pdo, $s['id'])['changed'] === false, 'той самий день — без змін');
    $day('2026-11-03');
    check(bv_streak_touch($pdo, $s['id'])['current'] === 2, 'наступний день — 2');
    $day('2026-11-05');
    check(bv_streak_touch($pdo, $s['id'])['current'] === 3, 'пропуск одного дня (раз на тиждень) прощено — 3');
    $day('2026-11-07');
    $x = bv_streak_touch($pdo, $s['id']);
    check($x['current'] === 1 && $x['best'] === 3, 'другий пропуск того ж тижня — з початку (1), рекорд 3');
    $day('2026-11-20');
    check(array_intersect_key(bv_streak_view($pdo, $s['id']), ['current' => 1, 'best' => 1]) === ['current' => 0, 'best' => 3], 'після довгої перерви показ — 0, рекорд 3');
    unset($GLOBALS['bv_today']);

    echo "Значки\n";
    $u = $mk('badges');
    check(bv_badges_check($pdo, $u['id']) === [], 'без гри — жодного значка');
    $log($u['id'], 101, 2);
    $got = array_column(bv_badges_check($pdo, $u['id']), 'key');
    check($got === ['first_bug'], 'перша місія — «Перша поломка»');
    foreach ([102, 103, 104, 105] as $m) {
        $log($u['id'], $m, $m === 105 ? 3 : 1);
    }
    foreach ([101, 102, 103, 104, 105] as $m) {
        $attempt($u['id'], $m, $m === 103 ? 1 : 0);
    }
    $got = array_column(bv_badges_check($pdo, $u['id']), 'key');
    check(in_array('three_stars', $got, true) && in_array('level_1', $got, true) && !in_array('no_hints', $got, true),
        'усі місії рівня 1 і одна на 3 зірки — «Три зірки», «Автоматник»; з підказкою в 1.3 — без «Без підказок»');
    $attempt($u['id'], 103, 0);
    check(array_column(bv_badges_check($pdo, $u['id']), 'key') === ['no_hints'], 'пройдено 1.3 без підказки — «Без підказок»');
    $log($u['id'], 9001, 0, 'exam');
    $GLOBALS['bv_today'] = '2026-11-02';
    bv_streak_touch($pdo, $u['id']);
    $GLOBALS['bv_today'] = '2026-11-03';
    bv_streak_touch($pdo, $u['id']);
    $GLOBALS['bv_today'] = '2026-11-04';
    bv_streak_touch($pdo, $u['id']);
    unset($GLOBALS['bv_today']);
    $got = array_column(bv_badges_check($pdo, $u['id']), 'key');
    sort($got);
    check($got === ['exam_1', 'streak'], 'іспит рівня 1 і 3 дні поспіль — «Іспит: Автомат», «Серія 3 дні»');
    check(bv_badges_check($pdo, $u['id']) === [], 'повторна перевірка — нічого нового');
    $sum = bv_progress_summary($pdo, $u['id']);
    $earned = array_filter($sum['badges'], static fn($b) => $b['earned']);
    check(count($sum['badges']) === 15 && count($earned) === 6 && !isset(array_column($earned, null, 'key')['words_beginner']),
        'підсумок: 15 значків, отримано 6, слів — ні (книги слів ще немає)');

    echo "Підвищення звання\n";
    $v = $mk('rankup');
    $before = bv_totals($pdo, $v['id'])['xp'];
    foreach ([101, 102, 103, 104, 105] as $m) {
        $log($v['id'], $m, 3);   // 5 × 20 XP = 100
    }
    $p = bv_progress_update($pdo, $v['id'], $before, true);
    check($p['rank_up'] && $p['rank']['title'] === 'Помічник майстра' && $p['streak']['current'] === 1, '100 XP — нове звання «Помічник майстра», серія 1');
    $p2 = bv_progress_update($pdo, $v['id'], 100, true);
    check(!$p2['rank_up'] && $p2['new_badges'] === [], 'повторно — без нового звання й значків');

    echo "CRM\n";
    $orig = array_column(bv_ranks($pdo), null, 'key');
    $rows = array_map(static fn($r) => ['title' => $r['title'], 'min_xp' => $r['min_xp']], $orig);
    $bad = $rows;
    $bad['seeker']['min_xp'] = 5;
    check(bv_crm_save_ranks($pdo, $bad) !== [], 'найнижчий поріг не 0 — помилка');
    $bad = $rows;
    $bad['master']['min_xp'] = 100;
    check(bv_crm_save_ranks($pdo, $bad) !== [], 'однакові пороги — помилка');
    $ok = $rows;
    $ok['helper']['min_xp'] = 120;
    check(bv_crm_save_ranks($pdo, $ok) === [] && bv_rank_for(bv_ranks($pdo), 110)['rank']['key'] === 'seeker', 'поріг 120 збережено: 110 XP — ще Учень-шукач');
    bv_crm_save_ranks($pdo, $rows);
    check(bv_crm_save_badge($pdo, 'streak', ['title' => 'Серія {n} дні', 'description' => 'Грати {n} дні поспіль.', 'param' => 0, 'status' => 'active']) !== [],
        'поріг значка 0 — помилка');
    check(bv_crm_save_badge($pdo, 'nope', ['title' => 'x', 'description' => 'y']) !== [], 'невідомий значок — помилка');

    echo "Через HTTP\n";
    $w = $mk('http');
    $jar = $jars[] = (string) tempnam(sys_get_temp_dir(), 'bvg');
    $lp = page($jar, $base . '/login.php');
    page($jar, $base . '/login.php', ['csrf' => csrf_of($lp['body']), 'email' => $w['email'], 'password' => $pass]);
    // Етап 0: перша місія акаунта — 1.1 (місії відкриваються по черзі). Дії — як у гравця, поломку визначає сервер.
    $mp = page($jar, $base . '/bugville-mission.php?m=101');
    $csrf = csrf_of($mp['body']);
    $st = api($base, $jar, $csrf, ['action' => 'start', 'mission' => 101]);
    $GLOBALS['BVT_TOKENS'][] = (string) ($st['token'] ?? '');
    $seed = (string) $pdo->query('SELECT seed FROM bv_attempts WHERE token = ' . $pdo->quote((string) ($st['token'] ?? '')))->fetchColumn();
    foreach (bvt_moves(bv_scene_rules('machine_change', $seed, 101)) as [$op, $in]) {
        $x = api($base, $jar, $csrf, ['action' => 'scene_act', 'token' => $st['token'] ?? '', 'op' => $op, 'input' => $in]);
        if (($x['can_submit'] ?? false) === true) {
            break;
        }
    }
    $ck = api($base, $jar, $csrf, ['action' => 'scene_finish', 'token' => $st['token'] ?? '']);
    check(($ck['correct'] ?? false) && in_array('first_bug', array_column($ck['progress']['new_badges'] ?? [], 'key'), true)
        && ($ck['progress']['streak']['current'] ?? -1) === 0, 'відповідь акаунта: у відповіді «Перша поломка»; серію звичайна місія не зараховує (лише Поломка дня)');
    $map = page($jar, $base . '/bugville.php')['body'];
    check(str_contains($map, '<b>Учень-шукач</b>') && str_contains($map, 'Значки: 2 з 15') && str_contains($map, 'Днів поспіль: <b>0</b>'),
        'карта акаунта: звання, серія, значки');
    $g = $jars[] = (string) tempnam(sys_get_temp_dir(), 'bvg');
    $gm = page($g, $base . '/bugville.php')['body'];
    check(str_contains($gm, 'Ваше звання') && !str_contains($gm, 'bv-badges') && !str_contains($gm, 'підтвердьте вік'), 'гостю — звання сеансу, без значків і без вимоги віку');
    $cp = page($jar, $base . '/crm-bugville.php?view=progress');
    check(str_contains($cp['body'] ?? '', 'account.php') || $cp['code'] !== 200 || !str_contains($cp['body'], 'Звання за XP'), 'CRM «Звання й значки» — не для user');

    echo "Видалення даних\n";
    $dry = bv_delete_player_data($pdo, $u['id'], true);
    check(($dry['bv_user_badges'] ?? 0) === 6 && ($dry['bv_streaks'] ?? 0) === 1, 'видалення охоплює 6 значків і серію');
} finally {
    unset($GLOBALS['bv_today']);
    bvt_cleanup($pdo);
    foreach ($users as $id) {
        bv_delete_player_data($pdo, $id);
        $pdo->prepare('DELETE FROM users WHERE id = :u')->execute([':u' => $id]);
    }
    foreach ($jars as $f) {
        @unlink($f);
    }
}

echo "\n" . ($fails === 0 ? "PASS $total/$total" : "FAIL $fails з $total") . "\n";
exit($fails === 0 ? 0 : 1);
