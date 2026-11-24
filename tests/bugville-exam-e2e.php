<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тест іспитів «Багвіля» (крок 4): bv-api.php (exam_*), bugville-exam.php, bugville-certificate.php, карта.
 *   php tests/bugville-exam-e2e.php [http://127.0.0.1:8097]
 * Потрібно локально: міграції № 33 і 34, 'bugville_demo' => true і 'bugville_public' => true у config/bugville.local.php.
 *
 * Перевіряє: замалий пул (< 3 × завдань) — іспит вимкнено; гість і акаунт без 16+ — 403; 5 завдань без відповідей у JSON;
 * продовження — ті самі завдання; повторна відповідь — 409; 4 з 5 → 80%, складено, +50 XP, +30 монет, грамота; повторне
 * завершення — без нагороди; одразу знову — 409 (повтор через годину); друге складання — без нагороди й нової грамоти;
 * провал — без нагороди; грамота лише власнику, імʼя з форми екранується, задовге — помилка; карта — «Іспит складено»;
 * видалення даних гравця прибирає завдання іспиту й грамоти. Тестові записи видаляються. Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$base = rtrim($argv[1] ?? 'http://127.0.0.1:8097', '/');
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
require_once __DIR__ . '/../app/bugville/bv-exam.php';
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

/** @return array{code:int, body:string} */
function page(string $jar, string $url, ?array $post = null): array
{
    $ch = curl_init($url);
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_TIMEOUT => 30,
        CURLOPT_USERAGENT => 'Mozilla/5.0 bugville-exam-e2e']);
    if ($post !== null) {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post));
    }
    $body = (string) curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    unset($ch);

    return ['code' => $code, 'body' => $body];
}

/** @return array{code:int, json:array, raw:string} */
function api(string $base, string $jar, string $csrf, array $data): array
{
    $ch = curl_init($base . '/bv-api.php');
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode($data), CURLOPT_HTTPHEADER => ['Content-Type: application/json', 'X-CSRF-Token: ' . $csrf,
            'Origin: ' . $base]]);
    $raw = (string) curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    unset($ch);

    return ['code' => $code, 'json' => (array) json_decode($raw, true), 'raw' => $raw];
}

function csrf_of(string $html): string
{
    return preg_match('/name="csrf-token" content="([a-f0-9]{64})"/', $html, $m) === 1 ? $m[1]
        : (preg_match('/name="csrf" value="([a-f0-9]{64})"/', $html, $m2) === 1 ? $m2[1] : '');
}

/** Правильний одноразовий id завдання іспиту (сервер знає, браузер — ні). */
function right_answer(PDO $pdo, string $token, int $n): string
{
    $st = $pdo->prepare('SELECT t.* , a.lang FROM bv_exam_tasks t JOIN bv_attempts a ON a.id = t.attempt_id WHERE a.token = :t AND t.n = :n');
    $st->execute([':t' => $token, ':n' => $n]);
    $t = $st->fetch(PDO::FETCH_ASSOC);
    $v = bv_build_variant($pdo, bv_mission((int) $t['mission_id']), $t['variant_id'] !== null ? (int) $t['variant_id'] : null, $t['seed'], 'uk');

    return (string) array_search($v['answer']['correct'], (array) json_decode((string) $t['opt_map_json'], true), true);
}

function wrong_answer(PDO $pdo, string $token, int $n): string
{
    $st = $pdo->prepare('SELECT t.opt_map_json FROM bv_exam_tasks t JOIN bv_attempts a ON a.id = t.attempt_id WHERE a.token = :t AND t.n = :n');
    $st->execute([':t' => $token, ':n' => $n]);
    $ids = array_keys((array) json_decode((string) $st->fetchColumn(), true));
    $right = right_answer($pdo, $token, $n);

    return (string) current(array_filter($ids, static fn($i) => (string) $i !== $right));
}

if (bv_mission(105) === null || bv_cfg('bugville_public') !== true) {
    fwrite(STDERR, "set 'bugville_demo' => true and 'bugville_public' => true in config/bugville.local.php\n");
    exit(2);
}

const EXAM = 9001;   // іспит рівня 1 «Автомат»
$tag = bin2hex(random_bytes(3));
$pass = 'E2e-' . bin2hex(random_bytes(6));
$users = [];
$itemIds = [];
$mkUser = static function (string $n, bool $age) use ($pdo, $tag, $pass, &$users): array {
    $email = "bv-exam-$n-$tag@example.test";
    $pdo->prepare("INSERT INTO users (name, email, password_hash, role, created_at) VALUES (:n, :e, :h, 'user', NOW())")
        ->execute([':n' => "BV exam $n", ':e' => $email, ':h' => password_hash($pass, PASSWORD_DEFAULT)]);
    $users[] = $id = (int) $pdo->lastInsertId();
    if ($age) {
        bv_confirm_age($pdo, $id);
    }

    return ['id' => $id, 'email' => $email];
};
$login = static function (string $jar, array $u) use ($base, $pass): string {
    $p = page($jar, $base . '/login.php');
    page($jar, $base . '/login.php', ['csrf' => csrf_of($p['body']), 'email' => $u['email'], 'password' => $pass]);

    return csrf_of(page($jar, $base . '/bugville-exam.php?e=1')['body']);
};
$jars = [];
$newJar = static function () use (&$jars): string {
    return $jars[] = (string) tempnam(sys_get_temp_dir(), 'bve');
};

try {
    $existing = (int) $pdo->query('SELECT COUNT(*) FROM bv_exam_items WHERE exam_id = ' . EXAM)->fetchColumn();
    if ($existing > 0) {
        fwrite(STDERR, "bv_exam_items already has rows for exam 9001 — test skipped to keep them intact\n");
        exit(2);
    }

    echo "Пул\n";
    check(!bv_exam_pool($pdo, EXAM)['ok'], 'без завдань у пулі іспит вимкнено');
    $ins = $pdo->prepare("INSERT INTO bv_exam_items (exam_id, mission_id, lang, weight, status, created_at) VALUES (:e, :m, 'uk', :w, 'active', :t)");
    $ins->execute([':e' => EXAM, ':m' => 105, ':w' => 14, ':t' => bv_now()]);
    $itemIds[] = (int) $pdo->lastInsertId();
    $ins->execute([':e' => EXAM, ':m' => 101, ':w' => 10, ':t' => bv_now()]);   // місія без контенту — не рахується
    $itemIds[] = (int) $pdo->lastInsertId();
    $p = bv_exam_pool($pdo, EXAM);
    check(!$p['ok'] && $p['weight'] === 14 && $p['need'] === 15, 'вага 14 < 15 (місія без контенту не рахується) — вимкнено');
    $pdo->prepare('UPDATE bv_exam_items SET weight = 15 WHERE id = :id')->execute([':id' => $itemIds[0]]);
    check(bv_exam_pool($pdo, EXAM)['ok'], 'вага 15 = 3 × 5 — іспит увімкнено');

    echo "Доступ\n";
    $g = $newJar();
    $gp = page($g, $base . '/bugville-exam.php?e=1');
    check($gp['code'] === 200 && str_contains($gp['body'], 'data-exam="9001"'), 'сторінка іспиту 200 (гість)');
    check(page($g, $base . '/bugville-exam.php?e=9')['code'] === 404, 'невідомий іспит — 404');
    $gc = csrf_of($gp['body']);
    $st = api($base, $g, $gc, ['action' => 'exam_state', 'exam' => EXAM]);
    check($st['code'] === 200 && ($st['json']['enabled'] ?? false) === true && ($st['json']['guest'] ?? false) === true, 'exam_state для гостя');
    check(api($base, $g, $gc, ['action' => 'exam_start', 'exam' => EXAM])['code'] === 403, 'гість: exam_start → 403');
    $u0 = $mkUser('noage', false);
    $j0 = $newJar();
    $c0 = $login($j0, $u0);
    check(api($base, $j0, $c0, ['action' => 'exam_start', 'exam' => EXAM])['code'] === 403, 'акаунт без 16+: exam_start → 403');

    echo "Іспит\n";
    $u = $mkUser('a', true);
    $j = $newJar();
    $c = $login($j, $u);
    $s = api($base, $j, $c, ['action' => 'exam_start', 'exam' => EXAM]);
    $tok = (string) ($s['json']['token'] ?? '');
    check($s['code'] === 200 && count($s['json']['tasks'] ?? []) === 5, 'старт: 5 завдань');
    check(!preg_match('/"(answer|correct|correct_ids|explain|params|seed)"/', $s['raw']), 'у JSON завдань немає відповідей і параметрів');
    $s2 = api($base, $j, $c, ['action' => 'exam_start', 'exam' => EXAM]);
    check(($s2['json']['token'] ?? '') === $tok && ($s2['json']['resumed'] ?? false) === true
        && json_encode($s2['json']['tasks']) === json_encode($s['json']['tasks']), 'продовження — ті самі завдання й порядок');
    for ($n = 1; $n <= 5; $n++) {
        $ans = $n === 5 ? wrong_answer($pdo, $tok, $n) : right_answer($pdo, $tok, $n);
        $r = api($base, $j, $c, ['action' => 'exam_answer', 'token' => $tok, 'n' => $n, 'answer' => $ans]);
        if ($n === 1) {
            check($r['code'] === 200 && !array_key_exists('correct', $r['json']), 'відповідь прийнято без показу правильності');
        }
    }
    check(api($base, $j, $c, ['action' => 'exam_answer', 'token' => $tok, 'n' => 1, 'answer' => right_answer($pdo, $tok, 1)])['code'] === 409,
        'повторна відповідь на завдання — 409');
    $f = api($base, $j, $c, ['action' => 'exam_finish', 'token' => $tok]);
    $fj = $f['json'];
    check(($fj['score'] ?? 0) === 80 && ($fj['passed'] ?? false) === true && ($fj['right'] ?? 0) === 4, '4 з 5 → 80%, складено');
    check(($fj['earned']['xp'] ?? 0) === 50 && ($fj['earned']['coins'] ?? 0) === 30, 'нагорода: +50 XP, +30 монет');
    check(preg_match('/^[0-9A-F]{20}$/', (string) ($fj['certificate'] ?? '')) === 1, 'видано грамоту');
    check(count($fj['results'] ?? []) === 5 && ($fj['results'][4]['correct'] ?? true) === false && ($fj['results'][0]['explain'] ?? '') !== '',
        'підсумок із розбором кожного завдання');
    $f2 = api($base, $j, $c, ['action' => 'exam_finish', 'token' => $tok]);
    check(($f2['json']['repeat'] ?? false) === true && ($f2['json']['earned']['xp'] ?? 1) === 0, 'повторне завершення — без нагороди');
    $again = api($base, $j, $c, ['action' => 'exam_start', 'exam' => EXAM]);
    check($again['code'] === 409 && ($again['json']['error'] ?? '') === 'cooldown' && !empty($again['json']['retry_at']), 'одразу знову — 409, повтор пізніше');
    $xpRows = (int) $pdo->query("SELECT COUNT(*) FROM bv_xp_log WHERE user_id = {$u['id']} AND source = 'exam'")->fetchColumn();
    check($xpRows === 1 && bv_totals($pdo, $u['id'])['xp'] === 50, 'журнал: один запис іспиту, 50 XP');

    echo "Повтор і провал (напряму, повтор без очікування)\n";
    $GLOBALS['bv_cfg_override'] = ['bugville_exam_retry_minutes' => 0];
    $ctx = ['user_id' => $u['id'], 'guest_key' => null, 'ip' => '203.0.113.7', 'lang' => 'uk'];
    $r2 = bv_exam_start($pdo, EXAM, $ctx);
    for ($n = 1; $n <= 5; $n++) {
        bv_exam_answer($pdo, $r2['token'], $n, right_answer($pdo, $r2['token'], $n), $ctx);
    }
    $f3 = bv_exam_finish($pdo, $r2['token'], $ctx);
    check($f3['passed'] && $f3['score'] === 100 && $f3['earned']['xp'] === 0 && $f3['certificate'] === $fj['certificate'],
        'друге складання (100%) — без нагороди, та сама грамота');
    $ub = $mkUser('b', true);
    $ctxB = ['user_id' => $ub['id'], 'guest_key' => null, 'ip' => '203.0.113.8', 'lang' => 'uk'];
    $rb = bv_exam_start($pdo, EXAM, $ctxB);
    for ($n = 1; $n <= 5; $n++) {
        bv_exam_answer($pdo, $rb['token'], $n, $n <= 3 ? right_answer($pdo, $rb['token'], $n) : wrong_answer($pdo, $rb['token'], $n), $ctxB);
    }
    $fb = bv_exam_finish($pdo, $rb['token'], $ctxB);
    check(!$fb['passed'] && $fb['score'] === 60 && $fb['earned']['xp'] === 0 && $fb['certificate'] === null, '3 з 5 → 60%, не складено, без нагороди й грамоти');
    $GLOBALS['bv_cfg_override'] = [];

    echo "Грамота й карта\n";
    $cert = (string) $fj['certificate'];
    $cp = page($j, $base . '/bugville-certificate.php?c=' . $cert);
    check($cp['code'] === 200 && str_contains($cp['body'], 'не офіційна сертифікація') && str_contains($cp['body'], 'Помічник майстра'),
        'грамота власнику: 200, примітка, імʼя за замовчуванням');
    check(page($g, $base . '/bugville-certificate.php?c=' . $cert)['code'] === 404, 'грамота гостю — 404');
    $jb = $newJar();
    $login($jb, $ub);
    check(page($jb, $base . '/bugville-certificate.php?c=' . $cert)['code'] === 404, 'грамота іншому акаунту — 404');
    $cs = csrf_of($cp['body']);
    $saved = page($j, $base . '/bugville-certificate.php?c=' . $cert, ['csrf' => $cs, 'display_name' => 'Котик <b>Майстер</b>']);
    check(str_contains($saved['body'], 'недопустимі символи'), 'імʼя з < > — помилка');
    $saved = page($j, $base . '/bugville-certificate.php?c=' . $cert, ['csrf' => $cs, 'display_name' => 'Котик-Майстер']);
    check(str_contains($saved['body'], 'Збережено') && str_contains($saved['body'], 'Котик-Майстер'), 'імʼя збережено й показано');
    $long = page($j, $base . '/bugville-certificate.php?c=' . $cert, ['csrf' => $cs, 'display_name' => str_repeat('я', 61)]);
    check(str_contains($long['body'], 'не довше за 60'), 'задовге імʼя — помилка');
    $map = page($j, $base . '/bugville.php');
    check(str_contains($map['body'], '✓ Іспит складено') && str_contains($map['body'], 'bugville-certificate.php?c=' . $cert), 'карта: «Іспит складено» й грамота');
    check(str_contains(page($g, $base . '/bugville.php')['body'], 'bugville-exam.php?e=1'), 'карта гостя: посилання на іспит рівня 1');

    echo "Видалення даних гравця\n";
    $dry = bv_delete_player_data($pdo, $u['id'], true);
    check(($dry['bv_exam_tasks'] ?? 0) === 10 && ($dry['bv_certificates'] ?? 0) === 1, 'видалення охоплює 10 завдань іспиту й грамоту');
} finally {
    $GLOBALS['bv_cfg_override'] = [];
    foreach ($users as $id) {
        bv_delete_player_data($pdo, $id);
        $pdo->prepare('DELETE FROM users WHERE id = :u')->execute([':u' => $id]);
    }
    foreach ($itemIds as $id) {
        $pdo->prepare('DELETE FROM bv_exam_items WHERE id = :id')->execute([':id' => $id]);
    }
    foreach ($jars as $f) {
        @unlink($f);
    }
}

echo "\n" . ($fails === 0 ? "PASS $total/$total" : "FAIL $fails з $total") . "\n";
exit($fails === 0 ? 0 : 1);
