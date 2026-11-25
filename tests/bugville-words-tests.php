<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тест Книги чарівних слів «Багвіля» (app/bugville/bv-words.php, bugville-words.php, API word_quiz / word_check).
 *   php -S 127.0.0.1:8097 -t public      (з робочої копії)
 *   php tests/bugville-words-tests.php [http://127.0.0.1:8097]
 * Потрібно локально: міграції № 33, 36, 37, сид (tools/bugville-seed.php), 'bugville_public' => true. Тестові дані видаляються.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$base = rtrim($argv[1] ?? 'http://127.0.0.1:8097', '/');
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../app/bugville/bv-player.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
require_once __DIR__ . '/../app/bugville/bv-words.php';
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
        CURLOPT_USERAGENT => 'Mozilla/5.0 bugville-words-tests']);
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
        CURLOPT_POSTFIELDS => json_encode($data), CURLOPT_HTTPHEADER => ['Content-Type: application/json', 'X-CSRF-Token: ' . $csrf, 'Origin: ' . $base]]);
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

/** Відкрити слово місії: запис у журнал нагород (зірки > 0), як після проходження. */
function open_mission(PDO $pdo, int $uid, int $mid): void
{
    static $att = 900000000;
    $pdo->prepare("INSERT INTO bv_xp_log (user_id, attempt_id, mission_id, xp, stars, coins, source, created_at) VALUES (:u, :a, :m, 10, 1, 0, 'test', UTC_TIMESTAMP())")
        ->execute([':u' => $uid, ':a' => $att++ + random_int(0, 99999) * 100, ':m' => $mid]);
}

/** Правильний id вправи — тест бере його з сесії (як сервер), браузер його не отримує. */
function right_option(string $word): string
{
    return (string) ($_SESSION['bv_word_quiz'][$word]['correct'] ?? '');
}

$users = [];
$jars = [];
$tag = bin2hex(random_bytes(3));
$pass = 'E2e-' . bin2hex(random_bytes(6));
$mk = static function (string $n) use ($pdo, $tag, $pass, &$users): array {
    $email = "bv-words-$n-$tag@example.test";
    $pdo->prepare("INSERT INTO users (name, email, password_hash, role, created_at) VALUES (:n, :e, :h, 'user', NOW())")
        ->execute([':n' => "BV words $n", ':e' => $email, ':h' => password_hash($pass, PASSWORD_DEFAULT)]);
    $users[] = $id = (int) $pdo->lastInsertId();
    bv_confirm_age($pdo, $id);

    return ['id' => $id, 'email' => $email];
};

try {
    echo "1. Слова Етапу 1\n";
    $content = bv_words_content();
    $worldWords = array_column(bv_world_missions(), 'word');
    check(count($content) === 15 && array_column($content, 'key') === $worldWords, '15 слів — по одному на місію, у порядку карти');
    $full = true;
    foreach ($content as $w) {
        $full = $full && $w['say'] !== '' && $w['meaning'] !== '' && $w['example_tr'] !== '' && stripos($w['example_en'], $w['key']) !== false;
    }
    check($full, 'у кожного слова вимова, значення, переклад і приклад, де є саме слово');
    check(count(array_unique(array_column($content, 'meaning'))) === 15, 'значення різні — вправа має чотири різні варіанти');
    $db = bv_words_all($pdo);
    $cnt = (int) $pdo->query("SELECT COUNT(*) FROM bv_words WHERE lang = 'uk' AND status = 'active'")->fetchColumn();
    check($cnt === 15 && count($db) === 15 && $db['boundary']['mission_id'] === 105, 'сид записав 15 слів у bv_words; Книга читає їх із БД');

    echo "2. Стан слів і вправа\n";
    $u = $mk('a');
    $_SESSION = [];
    $book = bv_words_book($pdo, $u['id']);
    check(count(array_filter($book, static fn($w) => $w['state'] === 'locked')) === 15, 'новий гравець: усі 15 слів закриті');
    check(bv_word_quiz($pdo, $u['id'], 'check')['error'] === 'locked', 'вправа закритого слова — locked');
    open_mission($pdo, $u['id'], 102);
    $q = bv_word_quiz($pdo, $u['id'], 'check');
    $texts = array_column($q['options'] ?? [], 'text');
    check($q['ok'] && count($q['options']) === 4 && count(array_unique($texts)) === 4 && in_array($db['check']['meaning'], $texts, true),
        'після місії 1.2 «check» відкрито: 4 різні варіанти, серед них правильне значення');
    check(array_keys($q) === ['ok', 'word', 'question', 'options'] && array_unique(array_map(static fn($o) => implode(',', array_keys($o)), $q['options'])) === ['id,text'] && preg_match('/^w[0-9a-f]{6}$/', $q['options'][0]['id']) === 1,
        'у вправі для браузера немає позначки правильного — лише одноразові id');
    $right = right_option('check');
    $wrong = '';
    foreach ($q['options'] as $o) {
        if ($o['id'] !== $right) {
            $wrong = $o['id'];
            break;
        }
    }
    $c1 = bv_word_check($pdo, $u['id'], 'check', $wrong);
    check($c1['ok'] && $c1['correct'] === false && $c1['learned_count'] === 0 && $c1['meaning'] === $db['check']['meaning'],
        'неправильна відповідь — не вивчено, показано справжнє значення');
    check(bv_word_check($pdo, $u['id'], 'check', $right)['error'] === 'no_quiz', 'вправа одноразова: ту саму не можна перевірити вдруге');
    bv_word_quiz($pdo, $u['id'], 'check');
    check(bv_word_check($pdo, $u['id'], 'check', 'w000000')['error'] === 'no_quiz', 'підроблений id варіанта — відмова');
    bv_word_quiz($pdo, $u['id'], 'check');
    $c2 = bv_word_check($pdo, $u['id'], 'check', right_option('check'));
    check($c2['correct'] && $c2['learned'] && $c2['learned_count'] === 1, 'правильна відповідь — слово вивчено');
    bv_word_quiz($pdo, $u['id'], 'check');
    $c3 = bv_word_check($pdo, $u['id'], 'check', right_option('check'));
    check($c3['correct'] && $c3['learned_count'] === 1, 'повторна вправа: «вивчено» не дублюється');
    $states = array_column(bv_words_book($pdo, $u['id']), 'state', 'key');
    check($states['check'] === 'learned' && $states['bug'] === 'locked', 'Книга: check — вивчено, bug — ще закрито');

    echo "3. Значки за слова\n";
    foreach ([101, 103, 104, 105] as $mid) {
        open_mission($pdo, $u['id'], $mid);
    }
    $newKeys = [];
    foreach (['bug', 'limit', 'input', 'boundary'] as $w) {
        bv_word_quiz($pdo, $u['id'], $w);
        $r = bv_word_check($pdo, $u['id'], $w, right_option($w));
        $newKeys = array_merge($newKeys, array_column($r['new_badges'], 'key'));
    }
    check(in_array('words_beginner', $newKeys, true) && in_array('level_words', $newKeys, true),
        '5 вивчених слів рівня «Автомат» — значки «Слова-початківець» і «Усі слова рівня»');

    echo "4. Гість\n";
    $_SESSION = ['bv_guest' => ['best' => [201 => 3]]];
    $gb = array_column(bv_words_book_guest($pdo), 'state', 'key');
    check($gb['required'] === 'open' && $gb['valid'] === 'locked' && !in_array('learned', $gb, true), 'гість бачить слова пройдених у сеансі місій, без «вивчено»');

    echo "5. HTTP: сторінка й API\n";
    $g = $jars[] = (string) tempnam(sys_get_temp_dir(), 'bvw');
    $gp = page($g, $base . '/bugville-words.php');
    check($gp['code'] === 200 && str_contains($gp['body'], 'Вправи й позначка «вивчено» — для акаунтів') && !str_contains($gp['body'], 'bv-wquiz-btn')
        && substr_count($gp['body'], 'class="bv-wcard is-locked"') === 15, 'гість: сторінка Книги, 15 закритих карток, без вправ');
    $gq = api($base, $g, csrf_of($gp['body']), ['action' => 'word_quiz', 'word' => 'bug']);
    check($gq['code'] === 403 && ($gq['json']['error'] ?? '') === 'auth_required', 'гість: word_quiz — 403');
    $map = page($g, $base . '/bugville.php')['body'];
    check(str_contains($map, 'href="bugville-words.php"') && str_contains($map, 'Книга чарівних слів'), 'на карті є посилання на Книгу');
    $ms = page($g, $base . '/bugville-mission.php?m=105')['body'];
    check(str_contains($ms, 'Bugs like to hide at the boundary.') || str_contains($ms, 'Bugs like to hide at the boundary'), 'картка слова в місії — з прикладом речення');

    $h = $mk('http');
    $jar = $jars[] = (string) tempnam(sys_get_temp_dir(), 'bvw');
    $lp = page($jar, $base . '/login.php?next=bugville-words.php');
    page($jar, $base . '/login.php', ['csrf' => csrf_of($lp['body']), 'email' => $h['email'], 'password' => $pass, 'next' => 'bugville-words.php']);
    open_mission($pdo, $h['id'], 301);
    $ap = page($jar, $base . '/bugville-words.php');
    check($ap['code'] === 200 && str_contains($ap['body'], 'Вивчено: <strong>0</strong> з 15') && substr_count($ap['body'], 'bv-wquiz-btn') === 1,
        'акаунт: лічильник 0 з 15, одна відкрита картка (expected) з вправою');
    $csrf = csrf_of($ap['body']);
    $bad = api($base, $jar, $csrf, ['action' => 'word_quiz', 'word' => '<script>']);
    check($bad['code'] === 400, 'дивне слово в запиті — 400');
    $lk = api($base, $jar, $csrf, ['action' => 'word_quiz', 'word' => 'report']);
    check($lk['code'] === 409 && ($lk['json']['error'] ?? '') === 'locked', 'закрите слово через API — 409 locked');
    $aq = api($base, $jar, $csrf, ['action' => 'word_quiz', 'word' => 'expected']);
    check($aq['code'] === 200 && count($aq['json']['options'] ?? []) === 4 && !str_contains($aq['raw'], 'correct'), 'вправа через API: 4 варіанти, без правильного');
    $opts = array_column($aq['json']['options'], 'text', 'id');
    $rightId = (string) array_search($db['expected']['meaning'], $opts, true);
    $ac = api($base, $jar, $csrf, ['action' => 'word_check', 'word' => 'expected', 'option' => $rightId]);
    check(($ac['json']['correct'] ?? false) === true && ($ac['json']['learned_count'] ?? 0) === 1, 'правильна відповідь через API — вивчено');
    $again = api($base, $jar, $csrf, ['action' => 'word_check', 'word' => 'expected', 'option' => $rightId]);
    check($again['code'] === 409 && ($again['json']['error'] ?? '') === 'no_quiz', 'та сама відповідь удруге — 409');
    check(str_contains(page($jar, $base . '/bugville-words.php')['body'], 'Вивчено: <strong>1</strong> з 15'), 'після вправи на сторінці — 1 з 15');

    echo "6. Видалення даних гравця\n";
    $dry = bv_delete_player_data($pdo, $u['id'], true);
    check(($dry['bv_user_words'] ?? 0) === 5, 'видалення охоплює вивчені слова (5)');
} finally {
    foreach ($users as $id) {
        bv_delete_player_data($pdo, $id);
        $pdo->prepare('DELETE FROM users WHERE id = :u')->execute([':u' => $id]);
    }
    foreach ($jars as $f) {
        @unlink($f);
    }
    $left = 0;
    foreach ($users as $id) {
        $left += (int) $pdo->query('SELECT COUNT(*) FROM bv_user_words WHERE user_id = ' . $id)->fetchColumn()
            + (int) $pdo->query('SELECT COUNT(*) FROM bv_xp_log WHERE user_id = ' . $id)->fetchColumn();
    }
    check($left === 0, 'тестові дані прибрано');
}

echo "\n" . ($fails === 0 ? "PASS $total/$total" : "FAIL $fails з $total") . "\n";
exit($fails === 0 ? 0 : 1);
