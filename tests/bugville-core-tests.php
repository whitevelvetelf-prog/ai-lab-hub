<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тести основи гри «Багвіль» (крок 1 плану, міграція № 33).
 *   php tests/bugville-core-tests.php
 *
 * Перевіряє: таблиці міграції 33 (VARCHAR без ENUM, lang 'uk'), детермінований генератор, повтор місії — інший варіант,
 * два акаунти — різні варіанти, пул: усі 6 небачених по черзі й 7-й не дорівнює 6-му, змішаний режим, сцена без відповіді,
 * перевірку відповіді, повтор токена без нагороди, чужий і прострочений токен, ліміт 30/хв на гравця, вищий ліміт на IP,
 * ip_hash із сіллю (без солі — NULL), прибирання лише гостьових незарахованих спроб старших за 24 год.
 * Тестові записи (mission_id ≥ 990000, користувачі 990000001+) видаляються наприкінці. Лише CLI, локальна БД.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../app/bugville/bv-attempts.php';

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

$_SESSION = [];
const T_GEN = 990001, T_POOL = 990002, T_MIX = 990003;
$uBase = 990000000 + random_int(10, 9999) * 1000;
$uA = $uBase + 1;
$uB = $uBase + 2;
$uC = $uBase + 3;
$ipBase = '198.51.100.' . random_int(1, 250);

bv_register_mission(['id' => T_GEN, 'variant_mode' => 'generator', 'generator_key' => 'vending_boundary', 'generator_json' => []]);
bv_register_mission(['id' => T_POOL, 'variant_mode' => 'pool']);
bv_register_mission(['id' => T_MIX, 'variant_mode' => 'mixed', 'generator_key' => 'vending_boundary', 'generator_json' => []]);

$cleanup = static function () use ($pdo): void {
    foreach (['bv_attempts', 'bv_seen_variants', 'bv_mission_variants'] as $t) {
        $pdo->exec("DELETE FROM $t WHERE mission_id >= 990000");
    }
};
$cleanup();
$ctxU = static fn(int $u, string $ip = '203.0.113.10') => ['user_id' => $u, 'guest_key' => null, 'ip' => $ip, 'lang' => 'uk'];

// Пул: 6 рукописних варіантів однієї навички + 1 вимкнений.
$ins = $pdo->prepare('INSERT INTO bv_mission_variants (mission_id, lang, skill, payload_json, answer_json, explain_json, status, created_at)
                      VALUES (:m, :l, :s, :p, :a, :e, :st, :c)');
$poolIds = [];
foreach (['кав\'ярні', 'аптеці', 'кінотеатрі', 'пекарні', 'бібліотеці', 'зоопарку', 'архіві'] as $i => $place) {
    $ins->execute([':m' => T_POOL, ':l' => 'uk', ':s' => 'boundary', ':st' => $i < 6 ? 'active' : 'off', ':c' => bv_now(),
        ':p' => json_encode(['text' => "Каса в $place", 'question' => 'Де поломка?', 'options' => [['id' => 'a', 'text' => "Рядок А $i"], ['id' => 'b', 'text' => "Рядок Б $i"], ['id' => 'c', 'text' => "Рядок В $i"]]], JSON_UNESCAPED_UNICODE),
        ':a' => json_encode(['type' => 'single', 'correct' => 'b']), ':e' => json_encode(['text' => "Розбір варіанта $i у $place"], JSON_UNESCAPED_UNICODE)]);
    if ($i < 6) {
        $poolIds[] = (int) $pdo->lastInsertId();
    }
}
$ins->execute([':m' => T_MIX, ':l' => 'uk', ':s' => 'boundary', ':st' => 'active', ':c' => bv_now(),
    ':p' => json_encode(['text' => 'Автомат {{place}}: від {{min}} до {{max}} грн', 'question' => 'Яка межа?', 'options' => [['id' => 'x', 'text' => '{{min}}'], ['id' => 'y', 'text' => '{{max}}']]], JSON_UNESCAPED_UNICODE),
    ':a' => json_encode(['type' => 'single', 'correct' => 'y']), ':e' => json_encode(['text' => 'Верхня межа — {{max}} грн'], JSON_UNESCAPED_UNICODE)]);

try {
    echo "1. Міграція № 33\n";
    $cols = $pdo->query("SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, COLUMN_DEFAULT FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME LIKE 'bv\\_%'")->fetchAll(PDO::FETCH_ASSOC);
    $by = [];
    foreach ($cols as $c) {
        $by[$c['TABLE_NAME'] . '.' . $c['COLUMN_NAME']] = $c;
    }
    check(count(array_unique(array_map(static fn($c) => $c['TABLE_NAME'], $cols))) >= 6, '6 нових таблиць bv_*');
    check(!in_array('enum', array_map(static fn($c) => $c['DATA_TYPE'], $cols), true), 'жодного ENUM: режими й статуси — VARCHAR');
    check(trim((string) ($by['bv_mission_variants.lang']['COLUMN_DEFAULT'] ?? ''), "'") === 'uk' && trim((string) ($by['bv_exam_items.lang']['COLUMN_DEFAULT'] ?? ''), "'") === 'uk',
        'lang DEFAULT \'uk\' у bv_mission_variants і bv_exam_items');
    check(isset($by['bv_strings.dict'], $by['bv_strings.lang'], $by['bv_players.age_confirmed_at']), 'словники bv_strings і bv_players.age_confirmed_at');
    check(bv_valid_mode('mixed') && !bv_valid_mode('random') && bv_valid_status('off') && !bv_valid_status('deleted'), 'допустимі значення перевіряє PHP');

    echo "2. Генератор\n";
    $g1 = bv_build_variant($pdo, bv_mission(T_GEN), null, 'abc123', 'uk');
    $g2 = bv_build_variant($pdo, bv_mission(T_GEN), null, 'abc123', 'uk');
    $g3 = bv_build_variant($pdo, bv_mission(T_GEN), null, 'ffff99', 'uk');
    check($g1 === $g2, 'той самий seed → той самий варіант (зберігається лише seed)');
    check($g1['key'] !== $g3['key'], 'інший seed → інший варіант');
    $sixOk = true;
    for ($i = 0; $i < 200; $i++) {
        $v = bv_build_variant($pdo, bv_mission(T_GEN), null, bin2hex(random_bytes(8)), 'uk');
        $texts = array_column($v['payload']['options'], 'text');
        $ids = array_column($v['payload']['options'], 'id');
        $sixOk = $sixOk && count($texts) === 6 && count(array_unique($texts)) === 6 && in_array($v['answer']['correct'], $ids, true);
    }
    check($sixOk, 'рівноцінність: 200 варіантів — завжди 6 різних рядків і рівно одна правильна відповідь');

    echo "3. Повтор і різні акаунти\n";
    $a1 = bv_attempt_start($pdo, T_GEN, $ctxU($uA));
    $a2 = bv_attempt_start($pdo, T_GEN, $ctxU($uA));
    $k = $pdo->prepare('SELECT variant_key FROM bv_attempts WHERE token = :t');
    $key = static function (string $t) use ($k): string {
        $k->execute([':t' => $t]);

        return (string) $k->fetchColumn();
    };
    check($a1['ok'] && $a2['ok'] && $key($a1['token']) !== $key($a2['token']), 'генератор: та сама місія двічі — різні варіанти');
    $b1 = bv_attempt_start($pdo, T_GEN, $ctxU($uB));
    check($key($b1['token']) !== $key($a1['token']), 'генератор: два акаунти — різні варіанти');
    $p1 = bv_attempt_start($pdo, T_POOL, $ctxU($uA));
    $p2 = bv_attempt_start($pdo, T_POOL, $ctxU($uB));
    check($key($p1['token']) !== $key($p2['token']), 'пул: два акаунти поспіль — різні варіанти (найрідше видаваний першим)');
    $keys = [$key($p1['token'])];
    for ($i = 0; $i < 5; $i++) {
        $keys[] = $key(bv_attempt_start($pdo, T_POOL, $ctxU($uA))['token']);
    }
    $offKey = 'v:' . ((int) $poolIds[5] + 1);
    check(count(array_unique($keys)) === 6 && !in_array($offKey, $keys, true), 'пул: 6 спроб — 6 різних небачених варіантів, вимкнений не видається');
    $seventh = $key(bv_attempt_start($pdo, T_POOL, $ctxU($uA))['token']);
    check($seventh !== $keys[5] && $seventh === $keys[0], 'пул: усе бачено — найдавніше бачений, не той, що в попередній спробі');
    $_SESSION = [];
    $gctx = bv_ctx(null);
    $gk = [];
    for ($i = 0; $i < 3; $i++) {
        $gk[] = $key(bv_attempt_start($pdo, T_POOL, $gctx)['token']);
    }
    check(count(array_unique($gk)) === 3 && !empty($_SESSION['bv_guest']['seen'][T_POOL]), 'гість: бачені варіанти — у сесії, повтори різні');
    $gs = $pdo->query('SELECT COUNT(*) FROM bv_seen_variants WHERE mission_id = ' . T_POOL . ' AND user_id NOT IN (' . $uA . ',' . $uB . ')')->fetchColumn();
    check((int) $gs === 0, 'гість: у bv_seen_variants нічого не пишеться');

    echo "4. Змішаний режим\n";
    $m1 = bv_attempt_start($pdo, T_MIX, $ctxU($uC));
    $sceneText = json_encode($m1['scene'], JSON_UNESCAPED_UNICODE);
    check($m1['ok'] && !str_contains($sceneText, '{{') && preg_match('/від \d+ до \d+ грн/u', $m1['scene']['text']) === 1, 'плейсхолдери пулу заповнено генератором');

    echo "5. Сцена без відповіді\n";
    $row = $pdo->prepare('SELECT * FROM bv_attempts WHERE token = :t');
    $row->execute([':t' => $a1['token']]);
    $att = $row->fetch(PDO::FETCH_ASSOC);
    $full = bv_build_variant($pdo, bv_mission(T_GEN), null, $att['seed'], 'uk');
    $sj = json_encode($a1['scene'], JSON_UNESCAPED_UNICODE);
    $internalIds = array_column($full['payload']['options'], 'id');
    $pubIds = array_column($a1['scene']['options'], 'id');
    check(!str_contains($sj, 'answer') && !str_contains($sj, 'correct') && !str_contains($sj, 'explain') && !str_contains($sj, $full['explain']['text']),
        'у сцені немає answer / correct / explain і тексту розбору');
    check(array_intersect($internalIds, $pubIds) === [] && count(array_unique($pubIds)) === 6, 'варіанти відповідей під одноразовими id, не внутрішніми');
    $allAlpha = true;
    for ($i = 0; $i < 3000; $i++) {
        $allAlpha = $allAlpha && preg_match('/^k[0-9a-f]{6}$/', array_key_first(bv_public_scene(['options' => [['id' => 'a', 'text' => 'x']]], new BvRng((string) $i))[1]) ?? '') === 1;
    }
    check($allAlpha, 'id відповіді завжди з літерою (3000 спроб): ключ не стає числом');
    $b2 = bv_attempt_start($pdo, T_GEN, $ctxU($uB));
    check(array_intersect(array_column($b2['scene']['options'], 'id'), $pubIds) === [], 'у кожної спроби свої id варіантів');

    echo "6. Перевірка відповіді\n";
    $map = (array) json_decode($att['opt_map_json'], true);
    $rightPub = (string) array_search($full['answer']['correct'], $map, true);
    $wrongPub = (string) array_key_first(array_filter($map, static fn($v) => $v !== $full['answer']['correct']));
    $r = bv_attempt_check($pdo, $a1['token'], $rightPub, $ctxU($uA));
    check($r['ok'] && $r['correct'] && $r['awarded'] && $r['stars'] === 3 && $r['correct_ids'] === [$rightPub] && $r['explain'] === $full['explain']['text'],
        'правильна відповідь: зараховано, розбір саме цього варіанта');
    $r2 = bv_attempt_check($pdo, $a1['token'], $rightPub, $ctxU($uA));
    check($r2['ok'] && $r2['repeat'] && !$r2['awarded'], 'повторне надсилання того самого токена — без нагороди');
    $r3 = bv_attempt_check($pdo, $a1['token'], $wrongPub, $ctxU($uA));
    check($r3['ok'] && $r3['repeat'] && $r3['correct'] === true && !$r3['awarded'], 'інша відповідь на використаний токен нічого не змінює');
    $used = $pdo->prepare('SELECT used, score FROM bv_attempts WHERE token = :t');
    $used->execute([':t' => $a1['token']]);
    check($used->fetch(PDO::FETCH_NUM) == [1, 100], 'у БД: used = 1, score = 100');
    $rw = bv_attempt_check($pdo, $a2['token'], 'zzzzzz', $ctxU($uA));
    check(!$rw['ok'] && $rw['error'] === 'bad_answer', 'невідомий id відповіді — bad_answer, спроба не витрачена');
    $rf = bv_attempt_check($pdo, $a2['token'], 'x', $ctxU($uB));
    check(!$rf['ok'] && $rf['error'] === 'forbidden', 'чужий токен — forbidden');
    $rn = bv_attempt_check($pdo, str_repeat('A', 43), 'x', $ctxU($uA));
    check(!$rn['ok'] && $rn['error'] === 'not_found', 'неіснуючий токен — not_found');
    $pdo->prepare('UPDATE bv_attempts SET started_at = :t WHERE token = :tk')->execute([':t' => bv_now(-3 * 3600), ':tk' => $a2['token']]);
    $row->execute([':t' => $a2['token']]);
    $att2 = $row->fetch(PDO::FETCH_ASSOC);
    $map2 = (array) json_decode($att2['opt_map_json'], true);
    $re = bv_attempt_check($pdo, $a2['token'], (string) array_key_first($map2), $ctxU($uA));
    check(!$re['ok'] && $re['error'] === 'expired', 'прострочений токен (> 2 год) — expired');
    $gTok = bv_attempt_start($pdo, T_GEN, $gctx)['token'];
    $row->execute([':t' => $gTok]);
    $gAtt = $row->fetch(PDO::FETCH_ASSOC);
    $saved = $_SESSION;
    $_SESSION = [];
    $rg = bv_attempt_check($pdo, $gTok, (string) array_key_first((array) json_decode($gAtt['opt_map_json'], true)), bv_ctx(null));
    check(!$rg['ok'] && $rg['error'] === 'forbidden', 'спроба гостя з іншої сесії — forbidden');
    $_SESSION = $saved;
    $rg2 = bv_attempt_check($pdo, $gTok, (string) array_key_first((array) json_decode($gAtt['opt_map_json'], true)), bv_ctx(null));
    check($rg2['ok'] && $gAtt['user_id'] === null && strlen((string) $gAtt['session_hash']) === 64, 'гість у своїй сесії перевіряє свою спробу; у БД лише хеш сесії');

    echo "7. Ліміти частоти\n";
    if ((int) gmdate('s') > 40) {
        sleep(61 - (int) gmdate('s'));   // усі 31 перевірки — в одній хвилині
    }
    $t = bv_attempt_start($pdo, T_GEN, $ctxU($uC, $ipBase))['token'];
    $codes = [];
    for ($i = 0; $i < 31; $i++) {
        $codes[] = bv_attempt_check($pdo, $t, 'nope00', $ctxU($uC, $ipBase))['error'] ?? 'ok';
    }
    check(count(array_filter($codes, static fn($c) => $c !== 'rate_limited')) === 30 && end($codes) === 'rate_limited', 'гравець: 30 перевірок за хвилину, 31-ша — rate_limited');
    $ip2 = '198.51.100.' . ((int) explode('.', $ipBase)[3] % 250 + 1) . '9';
    $GLOBALS['bv_cfg_override'] = ['bugville_checks_per_min_ip' => 40];
    $blocked = 0;
    for ($u = 0; $u < 45; $u++) {
        $blocked += (bv_attempt_check($pdo, $t, 'nope00', $ctxU($uBase + 100 + $u, $ip2))['error'] ?? '') === 'rate_limited' ? 1 : 0;
    }
    check($blocked === 5, 'IP: 45 різних гравців з одного IP при ліміті 40 — заблоковано лише 5 (ліміт IP окремий і вищий)');
    check((int) bv_cfg_all()['bugville_checks_per_min_ip'] === 40 && (int) (require __DIR__ . '/../config/bugville.php')['bugville_checks_per_min_ip'] >= 20 * (int) (require __DIR__ . '/../config/bugville.php')['bugville_checks_per_min_player'],
        'у config IP-ліміт щонайменше в 20 разів вищий за ліміт гравця');
    $GLOBALS['bv_cfg_override'] = [];

    echo "8. IP лише як хеш із сіллю\n";
    $row->execute([':t' => $t]);
    $ipRow = $row->fetch(PDO::FETCH_ASSOC);
    check($ipRow['ip_hash'] === hash_hmac('sha256', $ipBase, (string) bv_cfg('bugville_ip_salt')) && !str_contains(implode('|', array_map('strval', $ipRow)), $ipBase),
        'ip_hash = HMAC із сіллю; IP відкритим текстом ніде в рядку');
    $GLOBALS['bv_cfg_override'] = ['bugville_ip_salt' => ''];
    $ns = bv_attempt_start($pdo, T_GEN, $ctxU($uC, $ipBase));
    $row->execute([':t' => $ns['token']]);
    check($row->fetch(PDO::FETCH_ASSOC)['ip_hash'] === null, 'без солі ip_hash = NULL');
    $GLOBALS['bv_cfg_override'] = [];

    echo "9. Прибирання — лише гостьові незараховані старші за 24 год\n";
    $mk = static function (?int $uid, int $credited, int $ageH) use ($pdo): string {
        $tok = bv_new_token();
        $pdo->prepare("INSERT INTO bv_attempts (token, user_id, session_hash, mission_id, variant_key, kind, lang, started_at, credited)
                       VALUES (:t, :u, :s, :m, 'g:test', 'mission', 'uk', :at, :c)")
            ->execute([':t' => $tok, ':u' => $uid, ':s' => $uid === null ? str_repeat('a', 64) : null, ':m' => T_GEN, ':at' => bv_now(-3600 * $ageH), ':c' => $credited]);

        return $tok;
    };
    $old = $mk(null, 0, 25);
    $fresh = $mk(null, 0, 23);
    $credOld = $mk(null, 1, 30);
    $userOld = $mk($uA, 0, 500);
    bv_cleanup_guest_attempts($pdo);
    $exists = static function (string $tok) use ($pdo): bool {
        $s = $pdo->prepare('SELECT COUNT(*) FROM bv_attempts WHERE token = :t');
        $s->execute([':t' => $tok]);

        return (int) $s->fetchColumn() === 1;
    };
    check(!$exists($old) && $exists($fresh) && $exists($credOld) && $exists($userOld),
        'видалено лише гостьову незараховану > 24 год; свіжа, зарахована й спроба акаунта лишились');
    $GLOBALS['bv_cfg_override'] = ['bugville_guest_attempt_keep_hours' => 1];
    $h20 = $mk(null, 0, 20);
    bv_cleanup_guest_attempts($pdo);
    check($exists($h20), 'строк не менше 24 год, навіть якщо в config менше');
    $GLOBALS['bv_cfg_override'] = [];
} finally {
    $cleanup();
}

echo "\n" . ($total - $fails) . " / $total OK" . ($fails > 0 ? " — FAILED: $fails" : '') . "\n";
exit($fails > 0 ? 1 : 0);
