<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тест CRM гри «Багвіль» (крок 5): public/crm-bugville.php + app/bugville/bv-crm.php.
 *   php tests/bugville-crm-e2e.php [http://127.0.0.1:8097]
 * Потрібно локально: міграції № 33 і 34, 'bugville_demo' => true і 'bugville_public' => true; у місії 2.5 (#205) ще
 * не має бути варіантів (тест додає й прибирає свої).
 *
 * Перевіряє: лише admin (гість і user — на account.php); перевірку варіанта (JSON, відповідь серед варіантів, розбір,
 * number); збереження лише з CSRF; чернетка не робить місію грабельною, 6 активних — робить (і в грі, і в CRM без
 * попередження «менше 6»); попередження «варіанти перевіряють різне»; редагування й статус off (без видалення);
 * «Згенерувати 5 прикладів» — 5 різних; перегляд seed детермінований; пул іспиту: лічильник, вимкнення завдання,
 * помилка ваги; слова. Тестові записи видаляються. Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$base = rtrim($argv[1] ?? 'http://127.0.0.1:8097', '/');
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
require_once __DIR__ . '/../app/bugville/bv-crm.php';
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

/** @return array{code:int, body:string, location:string} */
function page(string $jar, string $url, ?array $post = null): array
{
    $ch = curl_init($url);
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_TIMEOUT => 30,
        CURLOPT_USERAGENT => 'Mozilla/5.0 bugville-crm-e2e', CURLOPT_HEADER => true]);
    if ($post !== null) {
        curl_setopt($ch, CURLOPT_POST, true);
        curl_setopt($ch, CURLOPT_POSTFIELDS, http_build_query($post));
    }
    $raw = (string) curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    $hs = (int) curl_getinfo($ch, CURLINFO_HEADER_SIZE);
    unset($ch);

    return ['code' => $code, 'body' => substr($raw, $hs),
        'location' => preg_match('/^Location:\s*(\S+)/mi', substr($raw, 0, $hs), $m) === 1 ? $m[1] : ''];
}

function csrf_of(string $html): string
{
    return preg_match('/name="csrf" value="([a-f0-9]{64})"/', $html, $m) === 1 ? $m[1]
        : (preg_match('/name="csrf-token" content="([a-f0-9]{64})"/', $html, $m2) === 1 ? $m2[1] : '');
}

const POOL_M = 205;   // 2.5 «Двічі натиснули» (pool)
if ((int) $pdo->query('SELECT COUNT(*) FROM bv_mission_variants WHERE mission_id = ' . POOL_M)->fetchColumn() > 0) {
    fwrite(STDERR, "mission 205 already has variants — test skipped to keep them intact\n");
    exit(2);
}

$tag = bin2hex(random_bytes(3));
$pass = 'E2e-' . bin2hex(random_bytes(6));
$users = [];
$itemIds = [];
$jars = [];
$mk = static function (string $role) use ($pdo, $tag, $pass, &$users): string {
    $email = "bv-crm-$role-$tag@example.test";
    $pdo->prepare('INSERT INTO users (name, email, password_hash, role, created_at) VALUES (:n, :e, :h, :r, NOW())')
        ->execute([':n' => "BV crm $role", ':e' => $email, ':h' => password_hash($pass, PASSWORD_DEFAULT), ':r' => $role]);
    $users[] = (int) $pdo->lastInsertId();

    return $email;
};
$login = static function (string $email) use ($base, $pass, &$jars): string {
    $jar = $jars[] = (string) tempnam(sys_get_temp_dir(), 'bvc');
    $p = page($jar, $base . '/login.php');
    page($jar, $base . '/login.php', ['csrf' => csrf_of($p['body']), 'email' => $email, 'password' => $pass]);

    return $jar;
};
$variant = static fn(int $i, string $skill = 'duplicate', string $status = 'active') => [
    'payload_json' => json_encode(['text' => "Тест $i: бланк відправили двічі.", 'question' => 'Що не так?',
        'options' => [['id' => 'o1', 'text' => "Два однакові листи $i"], ['id' => 'o2', 'text' => 'Усе гаразд'], ['id' => 'o3', 'text' => 'Порожнє поле']]],
        JSON_UNESCAPED_UNICODE),
    'answer_json' => '{"type":"single","correct":"o1"}', 'explain_json' => json_encode(['text' => "Розбір $i", 'hint' => 'Порахуйте листи'],
        JSON_UNESCAPED_UNICODE), 'skill' => $skill, 'status' => $status];

try {
    echo "Перевірка варіанта\n";
    [$er] = bv_crm_check_variant(['payload_json' => '{', 'answer_json' => '{}', 'explain_json' => '{}', 'skill' => 'x', 'status' => 'draft']);
    check($er !== [] && str_contains($er[0], 'payload'), 'некоректний JSON — помилка');
    $bad = $variant(0);
    $bad['answer_json'] = '{"type":"single","correct":"o9"}';
    [$er] = bv_crm_check_variant($bad);
    check($er !== [] && str_contains(implode(' ', $er), 'correct'), 'відповідь не серед варіантів — помилка');
    $bad = $variant(0);
    $bad['explain_json'] = '{"text":""}';
    check(bv_crm_check_variant($bad)[0] !== [], 'без розбору — помилка');
    $num = ['payload_json' => '{"text":"t","question":"q","input":"number"}', 'answer_json' => '{"type":"number","value":12}',
        'explain_json' => '{"text":"e"}', 'skill' => 's', 'status' => 'draft'];
    check(bv_crm_check_variant($num)[0] === [], 'number з input "number" — гаразд');
    check(bv_crm_check_variant($variant(0))[0] === [], 'коректний single — гаразд');

    echo "Доступ\n";
    $g = $jars[] = (string) tempnam(sys_get_temp_dir(), 'bvc');
    check(str_contains(page($g, $base . '/crm-bugville.php')['location'], 'account.php'), 'гість — на account.php');
    $ju = $login($mk('user'));
    check(str_contains(page($ju, $base . '/crm-bugville.php')['location'], 'account.php'), 'user — на account.php');
    $ja = $login($mk('admin'));
    $home = page($ja, $base . '/crm-bugville.php');
    check($home['code'] === 200 && substr_count($home['body'], 'view=mission&amp;m=') === 15, 'admin: 15 місій у списку');
    check(str_contains($home['body'], 'менше 6 активних варіантів (0)') && str_contains($home['body'], 'немає генератора'), 'попередження «менше 6» і «немає генератора»');
    check(str_contains(page($ja, $base . '/account.php')['body'], 'crm-bugville.php'), 'посилання «Багвіль» у CRM кабінету адміна');

    echo "Варіанти місії 2.5 (пул)\n";
    $mp = page($ja, $base . '/crm-bugville.php?view=mission&m=' . POOL_M);
    $csrf = csrf_of($mp['body']);
    $noCsrf = page($ja, $base . '/crm-bugville.php', ['action' => 'save_variant', 'm' => POOL_M, 'id' => 0] + $variant(1));
    check(str_contains($noCsrf['body'], 'застаріла') && (int) $pdo->query('SELECT COUNT(*) FROM bv_mission_variants WHERE mission_id = ' . POOL_M)->fetchColumn() === 0,
        'без CSRF — не збережено');
    $draft = page($ja, $base . '/crm-bugville.php', ['csrf' => $csrf, 'action' => 'save_variant', 'm' => POOL_M, 'id' => 0] + $variant(1, 'duplicate', 'draft'));
    check($draft['code'] === 302 && str_contains($draft['location'], 'preview='), 'чернетку збережено, перехід до перегляду');
    for ($i = 2; $i <= 6; $i++) {
        page($ja, $base . '/crm-bugville.php', ['csrf' => $csrf, 'action' => 'save_variant', 'm' => POOL_M, 'id' => 0] + $variant($i));
    }
    $ids = array_map('intval', $pdo->query('SELECT id FROM bv_mission_variants WHERE mission_id = ' . POOL_M . ' ORDER BY id')->fetchAll(PDO::FETCH_COLUMN));
    check(count($ids) === 6, '6 варіантів збережено');
    check(!str_contains(page($ja, $base . '/bugville-mission.php?m=' . POOL_M)['body'], 'id="bv-game"'), '5 активних + чернетка — місія ще не грається');
    page($ja, $base . '/crm-bugville.php', ['csrf' => $csrf, 'action' => 'save_variant', 'm' => POOL_M, 'id' => $ids[0]] + $variant(1));
    check(str_contains(page($ja, $base . '/bugville-mission.php?m=' . POOL_M)['body'], 'id="bv-game"'), '6 активних — місія грається');
    $home2 = page($ja, $base . '/crm-bugville.php');
    check(preg_match('~2\.5 Двічі натиснули</a></td>.*?<td>6 / 6</td>.*?<td class="bvc-warn">(.*?)</td>~s', $home2['body'], $row25) === 1 && trim($row25[1]) === '',
        'CRM: 6 / 6 і без попереджень для 2.5');
    page($ja, $base . '/crm-bugville.php', ['csrf' => $csrf, 'action' => 'save_variant', 'm' => POOL_M, 'id' => $ids[5]] + $variant(6, 'counting'));
    check(str_contains(page($ja, $base . '/crm-bugville.php')['body'], 'варіанти перевіряють різне'), 'різні навички — попередження');
    page($ja, $base . '/crm-bugville.php', ['csrf' => $csrf, 'action' => 'save_variant', 'm' => POOL_M, 'id' => $ids[5]] + $variant(6, 'duplicate', 'off'));
    $left = (int) $pdo->query('SELECT COUNT(*) FROM bv_mission_variants WHERE mission_id = ' . POOL_M)->fetchColumn();
    $offRow = $pdo->query('SELECT status FROM bv_mission_variants WHERE id = ' . $ids[5])->fetchColumn();
    check($left === 6 && $offRow === 'off', 'статус off — запис лишається (без видалення)');
    $pv = page($ja, $base . '/crm-bugville.php?view=mission&m=' . POOL_M . '&preview=' . $ids[1]);
    check(str_contains($pv['body'], 'Тест 2: бланк') && str_contains($pv['body'], 'Відповідь:') && str_contains($pv['body'], 'Розбір 2'),
        'перегляд варіанта: сцена + відповідь і розбір');
    $bad = page($ja, $base . '/crm-bugville.php', ['csrf' => $csrf, 'action' => 'save_variant', 'm' => POOL_M, 'id' => 0,
        'answer_json' => '{"type":"single","correct":"zz"}'] + $variant(7));
    check($bad['code'] === 200 && str_contains($bad['body'], 'correct') && str_contains($bad['body'], 'Тест 7'), 'помилка форми — введене лишається у формі');

    echo "Генератор (1.5, демо)\n";
    $gen = page($ja, $base . '/crm-bugville.php?view=mission&m=105&gen=5');
    preg_match_all('/seed ([a-f0-9]{16})/', $gen['body'], $seeds);
    check(count(array_unique($seeds[1])) === 5 && substr_count($gen['body'], 'Відповідь:') === 5, '«Згенерувати 5 прикладів» — 5 різних');
    $s1 = page($ja, $base . '/crm-bugville.php?view=mission&m=105&seed=abc123')['body'];
    $s2 = page($ja, $base . '/crm-bugville.php?view=mission&m=105&seed=abc123')['body'];
    $cut = static fn(string $h) => preg_match('~Перегляд seed.*?</div></div>~s', $h, $m) === 1 ? $m[0] : '';
    check($cut($s1) !== '' && $cut($s1) === $cut($s2), 'той самий seed — той самий варіант');

    echo "Пул іспитів\n";
    page($ja, $base . '/crm-bugville.php', ['csrf' => $csrf, 'action' => 'save_variant', 'm' => POOL_M, 'id' => $ids[5]] + $variant(6));   // знову 6 активних
    $ex = page($ja, $base . '/crm-bugville.php?view=exams');
    check($ex['code'] === 200 && substr_count($ex['body'], 'Іспит рівня «') === 3, '3 іспити рівнів');
    $c2 = csrf_of($ex['body']);
    $r = page($ja, $base . '/crm-bugville.php', ['csrf' => $c2, 'action' => 'save_item', 'id' => 0, 'exam_id' => 9002, 'mission_id' => POOL_M, 'weight' => 99, 'status' => 'active']);
    check(str_contains($r['body'], 'Вага — від 1 до 50'), 'вага 99 — помилка');
    page($ja, $base . '/crm-bugville.php', ['csrf' => $c2, 'action' => 'save_item', 'id' => 0, 'exam_id' => 9002, 'mission_id' => POOL_M, 'weight' => 15, 'status' => 'active']);
    $itemIds = array_map('intval', $pdo->query('SELECT id FROM bv_exam_items WHERE exam_id = 9002 AND mission_id = ' . POOL_M)->fetchAll(PDO::FETCH_COLUMN));
    check(count($itemIds) === 1 && str_contains(preg_replace('/\s+/u', ' ', page($ja, $base . '/crm-bugville.php?view=exams')['body']), 'Пул: 15 / потрібно 15 — іспит увімкнено'),
        'пул 15 / 15 — іспит увімкнено');
    page($ja, $base . '/crm-bugville.php', ['csrf' => $c2, 'action' => 'save_item', 'id' => $itemIds[0], 'exam_id' => 9002, 'mission_id' => POOL_M, 'weight' => 15, 'status' => 'off']);
    check(str_contains(preg_replace('/\s+/u', ' ', page($ja, $base . '/crm-bugville.php?view=exams')['body']), 'Пул: 0 / потрібно 15 — іспит вимкнено'), 'завдання off — пул 0, іспит вимкнено');

    echo "Слова\n";
    $w = page($ja, $base . '/crm-bugville.php?view=words');
    check(substr_count($w['body'], '<td lang="en">') === 15 && str_contains($w['body'], 'бáундері'), '15 слів із вимовою');
} finally {
    $pdo->exec('DELETE FROM bv_mission_variants WHERE mission_id = ' . POOL_M);
    foreach ($itemIds as $id) {
        $pdo->prepare('DELETE FROM bv_exam_items WHERE id = :id')->execute([':id' => $id]);
    }
    foreach ($users as $id) {
        $pdo->prepare('DELETE FROM users WHERE id = :u')->execute([':u' => $id]);
    }
    foreach ($jars as $f) {
        @unlink($f);
    }
}

echo "\n" . ($fails === 0 ? "PASS $total/$total" : "FAIL $fails з $total") . "\n";
exit($fails === 0 ? 0 : 1);
