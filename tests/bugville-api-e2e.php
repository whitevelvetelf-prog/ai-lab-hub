<?php

declare(strict_types=1);

/**
 * AI LAB HUB — наскрізний тест API гри «Багвіль» (крок 2 плану): public/bv-api.php через HTTP + функції зарахування.
 *   php tests/bugville-api-e2e.php [http://ai-lab-hub.test]
 * Потрібно локально: міграція № 33 і 'bugville_demo' => true у config/bugville.local.php (демо-місія 900001).
 *
 * Перевіряє: лише POST, CSRF і походження; гість — сцена без відповіді, would_earn, у БД жодних нагород і бачених;
 * повтор місії — інший варіант; повторне надсилання — без балів; вхід без 16+ — усе ще гість; підтвердження віку —
 * зарахування завершених спроб сеансу рівно раз, незавершена зараховується при перевірці; підсумки з журналу;
 * спроба не зараховується двом акаунтам; ліміти зарахування за вхід і за добу; ліміт запусків; без солі — без IP.
 * Тестові записи видаляються. Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$base = rtrim($argv[1] ?? 'http://ai-lab-hub.test', '/');
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../app/bugville/bv-player.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
bv_load_missions();

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

/** @return array{code:int, body:string, json:array} */
function http(string $jar, string $url, ?string $json = null, array $headers = []): array
{
    $ch = curl_init($url);
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_TIMEOUT => 30,
        CURLOPT_USERAGENT => 'Mozilla/5.0 bugville-api-e2e', CURLOPT_HTTPHEADER => $headers]);
    if ($json !== null) {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, $json);
    }
    $body = (string) curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    curl_close($ch);

    return ['code' => $code, 'body' => $body, 'json' => (array) json_decode($body, true)];
}

function csrf_from(string $html): string
{
    return preg_match('/name="csrf" value="([a-f0-9]{64})"/', $html, $m) === 1 ? $m[1] : '';
}

if (bv_mission(BV_DEMO_MISSION) === null) {
    fwrite(STDERR, "demo mission off: set 'bugville_demo' => true in config/bugville.local.php\n");
    exit(2);
}

$jar = (string) tempnam(sys_get_temp_dir(), 'bva');
$tag = bin2hex(random_bytes(3));
$pass = 'E2e-' . bin2hex(random_bytes(6));
$users = [];
$mkUser = static function (string $n) use ($pdo, $tag, $pass, &$users): array {
    $email = "bv-$n-$tag@example.test";
    $pdo->prepare("INSERT INTO users (name, email, password_hash, role, created_at) VALUES (:n, :e, :h, 'user', NOW())")
        ->execute([':n' => "BV $n", ':e' => $email, ':h' => password_hash($pass, PASSWORD_DEFAULT)]);
    $users[] = $id = (int) $pdo->lastInsertId();

    return ['id' => $id, 'email' => $email];
};
$api = static function (array $data, ?string $csrf, array $extra = []) use ($base, $jar): array {
    $h = ['Content-Type: application/json', 'Accept: application/json'];
    if ($csrf !== null) {
        $h[] = 'X-CSRF-Token: ' . $csrf;
    }

    return http($jar, "$base/bv-api.php", json_encode($data), array_merge($h, $extra));
};
$row = $pdo->prepare('SELECT * FROM bv_attempts WHERE token = :t');
$attempt = static function (string $t) use ($row): array {
    $row->execute([':t' => $t]);

    return (array) $row->fetch(PDO::FETCH_ASSOC);
};
/** Правильний / неправильний public id — тест читає відповідь із сервера (браузер цього не може). */
$answerFor = static function (string $t, bool $right) use ($pdo, $attempt): string {
    $a = $attempt($t);
    $v = bv_build_variant($pdo, bv_mission((int) $a['mission_id']), null, $a['seed'], 'uk');
    foreach ((array) json_decode($a['opt_map_json'], true) as $pub => $internal) {
        if (($internal === $v['answer']['correct']) === $right) {
            return (string) $pub;
        }
    }

    return '';
};
$tokens = [];

try {
    echo "1. Захист API\n";
    check(http($jar, "$base/bv-api.php")['code'] === 405, 'GET → 405');
    $page = http($jar, "$base/login.php")['body'];
    $csrf = csrf_from($page);
    check($csrf !== '', 'токен CSRF сесії отримано');
    $r = $api(['action' => 'state'], null);
    check($r['code'] === 403 && ($r['json']['error'] ?? '') === 'csrf', 'без токена → 403 csrf');
    $r = $api(['action' => 'state'], $csrf, ['Origin: https://evil.example']);
    check($r['code'] === 403 && ($r['json']['error'] ?? '') === 'cross_site', 'чужий Origin → 403 cross_site');
    check($api(['action' => 'nope'], $csrf)['code'] === 400, 'невідома дія → 400');

    echo "2. Гість\n";
    $s = $api(['action' => 'state'], $csrf)['json'];
    check(($s['guest'] ?? null) === true && ($s['logged_in'] ?? null) === false && ($s['min_age'] ?? 0) === 16, 'state: гість, мінімальний вік 16');
    $st1 = $api(['action' => 'start', 'mission' => BV_DEMO_MISSION], $csrf);
    $tokens[] = $g1 = (string) ($st1['json']['token'] ?? '');
    $raw = $st1['body'];
    check($st1['code'] === 200 && $g1 !== '' && count($st1['json']['scene']['options'] ?? []) === 6, 'start: токен і сцена з 6 варіантами');
    check(!preg_match('/answer|correct|explain|"id":"o\d/', $raw) && !str_contains($raw, (string) $attempt($g1)['seed']),
        'у відповіді start немає answer / correct / explain, внутрішніх id і seed');
    $st2 = $api(['action' => 'start', 'mission' => BV_DEMO_MISSION], $csrf);
    $tokens[] = $g2 = (string) ($st2['json']['token'] ?? '');
    check($attempt($g1)['variant_key'] !== $attempt($g2)['variant_key'], 'повторний запуск — інший варіант');
    $c1 = $api(['action' => 'check', 'token' => $g1, 'answer' => $answerFor($g1, true)], $csrf)['json'];
    check(($c1['correct'] ?? null) === true && ($c1['saved'] ?? null) === false && ($c1['would_earn']['xp'] ?? 0) === 30
        && ($c1['would_earn']['stars'] ?? 0) === 3 && !isset($c1['earned']), 'гість, правильно: would_earn +30 XP, 3 зірки; не збережено');
    check(is_string($c1['explain'] ?? null) && str_contains($c1['explain'], 'грн') && count($c1['correct_ids'] ?? []) === 1, 'розбір побаченого варіанта і правильний id — лише після перевірки');
    $c1b = $api(['action' => 'check', 'token' => $g1, 'answer' => $answerFor($g1, true)], $csrf)['json'];
    check(($c1b['repeat'] ?? null) === true && ($c1b['awarded'] ?? null) === false, 'повторне надсилання — repeat, без балів');
    $c2 = $api(['action' => 'check', 'token' => $g2, 'answer' => $answerFor($g2, false)], $csrf)['json'];
    check(($c2['correct'] ?? null) === false && ($c2['would_earn']['xp'] ?? -1) === 0, 'гість, неправильно: would_earn 0');
    $tokens[] = $g3 = (string) ($api(['action' => 'start', 'mission' => BV_DEMO_MISSION], $csrf)['json']['token'] ?? '');
    $a1 = $attempt($g1);
    $guestRewards = $pdo->query('SELECT COUNT(*) FROM bv_reward_log WHERE attempt_id IN (' . (int) $a1['id'] . ',' . (int) $attempt($g2)['id'] . ')')->fetchColumn();
    check($a1['user_id'] === null && strlen((string) $a1['session_hash']) === 64 && (int) $guestRewards === 0, 'у БД: спроба без користувача, лише хеш сесії, нагород немає');
    check($api(['action' => 'check', 'token' => str_repeat('Z', 43), 'answer' => 'x'], $csrf)['code'] === 404, 'чужий / неіснуючий токен → 404');

    echo "3. Вхід без підтвердження 16+\n";
    $u = $mkUser('a');
    $lp = http($jar, "$base/login.php");
    $ch = curl_init("$base/login.php");
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => http_build_query(['email' => $u['email'], 'password' => $pass, 'csrf' => csrf_from($lp['body'])])]);
    curl_exec($ch);
    $loginCode = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    unset($ch);   // PHP 8: cookie-файл пишеться при знищенні об'єкта curl (curl_close нічого не робить)
    check($loginCode === 302, 'вхід тестового користувача');
    $s = $api(['action' => 'state'], $csrf)['json'];
    check(($s['logged_in'] ?? null) === true && ($s['age_confirmed'] ?? null) === false && ($s['guest'] ?? null) === true && !isset($s['credited']),
        'увійшов без 16+: грає як гість, нічого не зараховано');
    check($api(['action' => 'confirm_age', 'confirm' => 'yes'], $csrf)['code'] === 400, 'confirm_age лише з confirm: true');

    echo "4. Підтвердження віку → зарахування сеансу\n";
    $ca = $api(['action' => 'confirm_age', 'confirm' => true], $csrf)['json'];
    check(($ca['age_confirmed'] ?? null) === true && ($ca['credited']['credited'] ?? 0) === 2 && ($ca['credited']['xp'] ?? 0) === 30,
        'зараховано 2 завершені спроби сеансу (+30 XP)');
    check(($ca['totals']['xp'] ?? 0) === 30 && ($ca['totals']['stars'] ?? 0) === 3, 'підсумки акаунта з журналу: 30 XP, 3 зірки');
    $a1 = $attempt($g1);
    check((int) $a1['user_id'] === $u['id'] && (int) $a1['credited'] === 1 && $attempt($g3)['user_id'] === null, 'завершені — на акаунті; незавершена ще чекає');
    $seen = $pdo->prepare('SELECT COUNT(*) FROM bv_seen_variants WHERE user_id = :u');
    $seen->execute([':u' => $u['id']]);
    check((int) $seen->fetchColumn() === 2, 'бачені варіанти сеансу перенесено в акаунт');
    $s2 = $api(['action' => 'state'], $csrf)['json'];
    check(!isset($s2['credited']) && ($s2['totals']['xp'] ?? 0) === 30, 'повторний запит нічого не зараховує вдруге');
    $c3 = $api(['action' => 'check', 'token' => $g3, 'answer' => $answerFor($g3, true)], $csrf)['json'];
    check(($c3['saved'] ?? null) === true && ($c3['earned']['xp'] ?? 0) === 30 && ($c3['totals']['xp'] ?? 0) === 60, 'незавершена гостьова — зарахована при перевірці: 60 XP');
    $tokens[] = $u1 = (string) ($api(['action' => 'start', 'mission' => BV_DEMO_MISSION], $csrf)['json']['token'] ?? '');
    check((int) $attempt($u1)['user_id'] === $u['id'] && $attempt($u1)['session_hash'] === null, 'нова спроба акаунта — одразу на акаунті');
    $c4 = $api(['action' => 'check', 'token' => $u1, 'answer' => $answerFor($u1, true)], $csrf)['json'];
    $c4b = $api(['action' => 'check', 'token' => $u1, 'answer' => $answerFor($u1, true)], $csrf)['json'];
    check(($c4['totals']['xp'] ?? 0) === 90 && ($c4b['repeat'] ?? null) === true && ($c4b['totals']['xp'] ?? 0) === 90, 'акаунт: +30, повтор того самого токена — 90 без змін');
    $log = $pdo->prepare('SELECT COUNT(*) FROM bv_reward_log WHERE user_id = :u');
    $log->execute([':u' => $u['id']]);
    check((int) $log->fetchColumn() === 3, 'у журналі нагород рівно 3 записи (по одному на правильну спробу)');

    echo "5. Функції зарахування: два акаунти, ліміти\n";
    $_SESSION = [];
    $ctxG = bv_ctx(null);
    $mkDone = static function () use ($pdo, &$ctxG, $answerFor, &$tokens): array {
        $t = bv_attempt_start($pdo, BV_DEMO_MISSION, $ctxG)['token'];
        $tokens[] = $t;
        bv_attempt_check($pdo, $t, $answerFor($t, true), $ctxG);

        return [$t];
    };
    $mkDone();
    $other = $mkUser('b');
    $third = $mkUser('c');
    bv_confirm_age($pdo, $other['id']);
    bv_confirm_age($pdo, $third['id']);
    $t0 = $_SESSION['bv_guest']['tokens'][0];
    $hash = bv_session_hash($_SESSION['bv_guest']['key']);
    check(bv_credit_one($pdo, $other['id'], $attempt($t0), $hash) === true, 'перший акаунт зарахував спробу');
    check(bv_credit_one($pdo, $third['id'], $attempt($t0), $hash) === false && (int) $attempt($t0)['user_id'] === $other['id'],
        'другий акаунт ту саму спробу не отримає');
    $_SESSION = [];
    $ctxG = bv_ctx(null);
    for ($i = 0; $i < 5; $i++) {
        $mkDone();
    }
    $GLOBALS['bv_cfg_override'] = ['bugville_credit_max_per_login' => 2];
    $cr = bv_credit_guest_session($pdo, $third['id']);
    check($cr['credited'] === 2 && $cr['skipped'] === 3 && ($_SESSION['bv_guest']['tokens'] ?? []) === [], 'ліміт за вхід 2: зараховано 2, решта 3 — ні, і більше не зараховуються');
    $_SESSION = [];
    $ctxG = bv_ctx(null);
    for ($i = 0; $i < 3; $i++) {
        $mkDone();
    }
    $GLOBALS['bv_cfg_override'] = ['bugville_credit_max_per_login' => 20, 'bugville_credit_max_per_day' => 3];
    $cr2 = bv_credit_guest_session($pdo, $third['id']);
    check($cr2['credited'] === 1 && $cr2['skipped'] === 2, 'ліміт за добу 3: після 2 уже зарахованих — лише 1');
    $GLOBALS['bv_cfg_override'] = ['bugville_starts_per_min_player' => 3];
    $_SESSION = [];
    $ctxG = bv_ctx(null);
    $codes = [];
    for ($i = 0; $i < 4; $i++) {
        $st = bv_attempt_start($pdo, BV_DEMO_MISSION, $ctxG);
        $codes[] = $st['ok'] ? 'ok' : $st['error'];
        if ($st['ok']) {
            $tokens[] = $st['token'];
        }
    }
    check($codes === ['ok', 'ok', 'ok', 'rate_limited'], 'ліміт запусків місій за хвилину');
    $GLOBALS['bv_cfg_override'] = [];
} finally {
    $GLOBALS['bv_cfg_override'] = [];
    if ($users !== []) {
        $in = implode(',', $users);
        $pdo->exec("DELETE FROM bv_reward_log WHERE user_id IN ($in)");
        $pdo->exec("DELETE FROM bv_seen_variants WHERE user_id IN ($in)");
        $pdo->exec("DELETE FROM bv_players WHERE user_id IN ($in)");
        $pdo->exec("DELETE FROM bv_attempts WHERE user_id IN ($in)");
        $pdo->exec("DELETE FROM users WHERE id IN ($in)");
    }
    $tokens = array_values(array_filter($tokens));
    if ($tokens !== []) {
        $pdo->prepare('DELETE FROM bv_attempts WHERE token IN (' . implode(',', array_fill(0, count($tokens), '?')) . ')')->execute($tokens);
    }
    @unlink($jar);
}

echo "\n" . ($total - $fails) . " / $total OK" . ($fails > 0 ? " — FAILED: $fails" : '') . "\n";
exit($fails > 0 ? 1 : 0);
