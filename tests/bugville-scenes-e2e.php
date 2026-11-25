<?php

declare(strict_types=1);

/**
 * AI LAB HUB — наскрізний тест сцени «Автомат» через HTTP (public/bv-api.php: start / scene_act / scene_finish).
 *   php -S 127.0.0.1:8097 -t public   (з робочої копії)
 *   php tests/bugville-scenes-e2e.php [http://127.0.0.1:8097]
 * Перевіряє: сторінка й JSON без правил варіанта; правильні й марні дії; підроблений клієнт (поля found / bugs / stars
 * у запиті ігноруються, старий check закрито, чужа сесія); повторне використання токена; задовгий ввід і не-рядок;
 * зовнішніх запитів на сторінці місії немає. Тестові спроби видаляються. Лише CLI.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$base = rtrim($argv[1] ?? 'http://127.0.0.1:8097', '/');
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../app/bugville/bv-scene-play.php';

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

function page(string $jar, string $url): string
{
    $ch = curl_init($url);
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_TIMEOUT => 30]);
    $b = (string) curl_exec($ch);
    unset($ch);

    return $b;
}

/** @return array{code:int, json:array, body:string} */
function call(string $base, string $jar, string $csrf, array $data): array
{
    $ch = curl_init($base . '/bv-api.php');
    curl_setopt_array($ch, [CURLOPT_RETURNTRANSFER => true, CURLOPT_COOKIEJAR => $jar, CURLOPT_COOKIEFILE => $jar, CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode($data), CURLOPT_TIMEOUT => 30,
        CURLOPT_HTTPHEADER => ['Content-Type: application/json', 'X-CSRF-Token: ' . $csrf, 'Origin: ' . $base]]);
    $body = (string) curl_exec($ch);
    $code = (int) curl_getinfo($ch, CURLINFO_RESPONSE_CODE);
    unset($ch);

    return ['code' => $code, 'json' => (array) json_decode($body, true), 'body' => $body];
}

$csrfOf = static fn(string $html) => preg_match('/name="csrf-token" content="([a-f0-9]{64})"/', $html, $m) === 1 ? $m[1] : '';
$jar = (string) tempnam(sys_get_temp_dir(), 'bvs');
$jar2 = (string) tempnam(sys_get_temp_dir(), 'bvs');
$tokens = [];

try {
    echo "1. Сторінка місії\n";
    $html = page($jar, $base . '/bugville-mission.php?m=105');
    $csrf = $csrfOf($html);
    check($csrf !== '' && str_contains($html, 'id="bv-game"'), 'сторінка 1.5 відкривається, є оболонка гри');
    check(!preg_match('/"bugs"|bug_notes|"kinds"|seed/i', $html), 'HTML без правил варіанта');
    preg_match_all('~(?:src|href)="(https?:)?//([^/"]+)~i', $html, $ext);
    check($ext[2] === [], 'жодного зовнішнього src / href');
    $css = page($jar, $base . '/assets/css/bugville.css');
    check(str_contains($css, '../fonts/bugville/nunito-cyrillic-400-normal.woff2') && !preg_match('~fonts\.googleapis|fonts\.gstatic|https?://~i', $css),
        'шрифти — лише локальні файли, без Google Fonts і сторонніх адрес у CSS');
    $font = page($jar, $base . '/assets/fonts/bugville/rubik-cyrillic-800-normal.woff2');
    check(str_starts_with($font, 'wOF2'), 'файл шрифту віддається з власного сайту');

    echo "2. Старт і правила\n";
    $st = call($base, $jar, $csrf, ['action' => 'start', 'mission' => 105]);
    $tok = (string) ($st['json']['token'] ?? '');
    $tokens[] = $tok;
    check($st['code'] === 200 && ($st['json']['scene']['type'] ?? '') === 'input_machine' && ($st['json']['scene']['total'] ?? 0) === 5,
        'start: сцена input_machine, 5 комірок колекції');
    check(!preg_match('/"(bugs|kinds|bug_notes|seed|zero|neg|over|nan|dec)"/', $st['body']), 'JSON старту без поломок і seed');
    $a = $pdo->query('SELECT seed FROM bv_attempts WHERE token = ' . $pdo->quote($tok))->fetch(PDO::FETCH_ASSOC);
    $rules = bv_scene_rules('machine_boundary', (string) $a['seed'], 105);
    check($rules !== null && str_contains($st['body'], 'від 1 до ' . $rules['max']), 'на наліпці — межа саме цього варіанта');

    echo "3. Підроблений клієнт\n";
    $f = call($base, $jar, $csrf, ['action' => 'scene_finish', 'token' => $tok, 'found' => 5, 'bugs' => ['zero', 'neg', 'over'], 'stars' => 3]);
    check($f['code'] === 409 && ($f['json']['error'] ?? '') === 'not_enough' && ($f['json']['found'] ?? -1) === 0,
        'scene_finish із «found: 5» у запиті — 409 not_enough: сервер рахує сам');
    $ck = call($base, $jar, $csrf, ['action' => 'check', 'token' => $tok, 'answer' => '0']);
    check($ck['code'] === 400 && ($ck['json']['error'] ?? '') === 'bad_answer', 'старий check на токені сцени — 400');
    $fake = call($base, $jar, $csrf, ['action' => 'scene_act', 'token' => $tok, 'op' => 'found', 'input' => 'zero']);
    check($fake['code'] === 400, 'op = found — 400');
    $arr = call($base, $jar, $csrf, ['action' => 'scene_act', 'token' => $tok, 'op' => 'buy', 'input' => ['0']]);
    check($arr['code'] === 400 && ($arr['json']['error'] ?? '') === 'too_long', 'ввід-масив — 400');
    $long = call($base, $jar, $csrf, ['action' => 'scene_act', 'token' => $tok, 'op' => 'buy', 'input' => str_repeat('a', 31)]);
    check($long['code'] === 400 && ($long['json']['error'] ?? '') === 'too_long', 'ввід 31 символ — 400 too_long');
    $html2 = page($jar2, $base . '/bugville-mission.php?m=105');
    $alien = call($base, $jar2, $csrfOf($html2), ['action' => 'scene_act', 'token' => $tok, 'op' => 'buy', 'input' => '0']);
    check($alien['code'] === 404, 'токен з чужої сесії — 404');
    $xss = call($base, $jar, $csrf, ['action' => 'scene_act', 'token' => $tok, 'op' => 'buy', 'input' => '<img src=x>']);
    check($xss['code'] === 200 && !str_contains($xss['body'], '<img'), 'HTML у вводі не повертається у відповіді');

    echo "4. Правильні дії\n";
    $ok = call($base, $jar, $csrf, ['action' => 'scene_act', 'token' => $tok, 'op' => 'buy', 'input' => '1']);
    check(($ok['json']['reaction']['result'] ?? '') === 'ok' && ($ok['json']['found'] ?? -1) === 1 && !isset($ok['json']['reaction']['bug']),
        '1 пляшка — працює правильно (знайдене не змінилося)');
    $found = [];
    foreach (['0', '-2', (string) ($rules['max'] + 1)] as $in) {
        $x = call($base, $jar, $csrf, ['action' => 'scene_act', 'token' => $tok, 'op' => 'buy', 'input' => $in]);
        $found[] = $x['json']['found'] ?? -1;
    }
    check($found === [2, 3, 4] && ($x['json']['can_submit'] ?? false) === true, '0, мінус, max + 1 — поломки; здавати можна');
    check(isset($x['json']['reaction']['bug']['exp']) && str_contains($x['json']['reaction']['bug']['exp'], (string) $rules['max']),
        'міні-звіт «мало бути» з числом межі варіанта');

    echo "5. Здача й токен\n";
    $fin = call($base, $jar, $csrf, ['action' => 'scene_finish', 'token' => $tok]);
    check($fin['code'] === 200 && ($fin['json']['stars'] ?? 0) === 3 && ($fin['json']['summary']['found'] ?? 0) === 4
        && ($fin['json']['would_earn']['xp'] ?? 0) === 20 && !isset($fin['json']['earned']), 'здано: 3 зірки, 4 з 5, гостю — would_earn 20 XP');
    $fin2 = call($base, $jar, $csrf, ['action' => 'scene_finish', 'token' => $tok]);
    check(($fin2['json']['repeat'] ?? false) === true && ($fin2['json']['awarded'] ?? true) === false && !isset($fin2['json']['would_earn']),
        'повторне здавання тим самим токеном — repeat, без нагороди');
    $after = call($base, $jar, $csrf, ['action' => 'scene_act', 'token' => $tok, 'op' => 'buy', 'input' => '0']);
    check($after['code'] === 409 && ($after['json']['error'] ?? '') === 'already_checked', 'дія після здачі — 409');
    $hint = call($base, $jar, $csrf, ['action' => 'hint', 'token' => $tok]);
    check($hint['code'] === 409, 'підказка після здачі — 409');

    echo "6. Місія 1.1 через API\n";
    $html3 = page($jar, $base . '/bugville-mission.php?m=101');
    $c = call($base, $jar, $csrfOf($html3), ['action' => 'start', 'mission' => 101]);
    $tokens[] = $ct = (string) ($c['json']['token'] ?? '');
    check(($c['json']['scene']['claim'] ?? false) === true && !str_contains($c['body'], 'bug_notes'), '1.1: сцена з кнопкою «Решта неправильна», без купюр-поломок');
    $seed = (string) $pdo->query('SELECT seed FROM bv_attempts WHERE token = ' . $pdo->quote($ct))->fetchColumn();
    $cr = bv_scene_rules('machine_change', $seed, 101);
    $note = $cr['bug_notes']['change_swap'];
    $b = call($base, $jar, $csrfOf($html3), ['action' => 'scene_act', 'token' => $ct, 'op' => 'buy', 'input' => (string) $note]);
    check(($b['json']['reaction']['result'] ?? '') === 'ok' && ($b['json']['found'] ?? -1) === 0, 'оплата купюрою з поломкою — автомат не підказує, що це поломка');
    $cl = call($base, $jar, $csrfOf($html3), ['action' => 'scene_act', 'token' => $ct, 'op' => 'claim', 'input' => (string) ($note - $cr['price'])]);
    check(($cl['json']['found'] ?? 0) === 1 && ($cl['json']['can_submit'] ?? false), 'скарга з правильною рештою — поломку знайдено');
} finally {
    foreach ($tokens as $t) {
        $pdo->prepare('DELETE FROM bv_attempts WHERE token = :t AND user_id IS NULL')->execute([':t' => $t]);
    }
    $left = 0;
    foreach ($tokens as $t) {
        $left += (int) $pdo->query('SELECT COUNT(*) FROM bv_attempts WHERE token = ' . $pdo->quote($t))->fetchColumn();
    }
    check($left === 0, 'тестові спроби прибрано');
    @unlink($jar);
    @unlink($jar2);
}

echo "\n" . ($fails === 0 ? "PASS $total/$total" : "FAIL $fails з $total") . "\n";
exit($fails === 0 ? 0 : 1);
