<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тести контенту «Багвіля», Етап 1 (крок 6): генератори app/bugville/bv-content.php і сид tools/bugville-seed.php.
 *   php tests/bugville-content-tests.php
 * Потрібно локально: міграції № 33 і 34 та сид (php tools/bugville-seed.php).
 *
 * Перевіряє: кожен генератор на 300 seed — сцена, питання, ≥ 4 різні варіанти, правильна відповідь серед них (або число
 * з полем для числа), розбір і підказка, без {{…}} і слова «тестування», детермінованість і різноманітність; смисл
 * хитрих місій (довжина імені, літера в телефоні, решта); сюжети пулів проходять перевірку CRM, усі {{плейсхолдери}}
 * змішаних мають значення; після сиду грабельні всі 15 місій (MAIN_TASK §16: генератор або ≥ 6 варіантів), пули
 * трьох іспитів увімкнені, CRM без попереджень; сид ідемпотентний. Лише CLI, нічого не змінює (сид — без нових рядків).
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

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

echo "Генератори (по 300 варіантів)\n";
$flags = JSON_UNESCAPED_UNICODE;
foreach (bv_content_generators() as $key => $fn) {
    if (in_array($key, ['boundary_mix', 'report_mix'], true)) {
        continue;   // числа для змішаних — перевіряються з сюжетами пулу нижче
    }
    $errors = [];
    $distinct = [];
    for ($i = 0; $i < 300; $i++) {
        $g = $fn($pdo, new BvRng("ct-$key-$i"), [], 'uk');
        $p = $g['payload'];
        $a = $g['answer'];
        if (trim((string) ($p['text'] ?? '')) === '' || trim((string) ($p['question'] ?? '')) === '') {
            $errors[] = 'без тексту чи питання';
        }
        if ($a['type'] === 'single') {
            $ids = array_column($p['options'], 'id');
            $texts = array_column($p['options'], 'text');
            if (!in_array($a['correct'], $ids, true) || count($ids) < 4 || count($texts) !== count(array_unique($texts))) {
                $errors[] = 'варіанти: ' . implode(' | ', $texts);
            }
        } elseif ($a['type'] !== 'number' || ($p['input'] ?? '') !== 'number' || $a['value'] < 0) {
            $errors[] = 'число';
        }
        if (trim((string) ($g['explain']['text'] ?? '')) === '' || trim((string) ($g['hint']['text'] ?? '')) === '') {
            $errors[] = 'без розбору чи підказки';
        }
        if (preg_match('/\{\{|тестуванн/u', json_encode($g, $flags)) === 1) {
            $errors[] = '{{…}} або «тестування»';
        }
        if (json_encode($fn($pdo, new BvRng("ct-$key-$i"), [], 'uk'), $flags) !== json_encode($g, $flags)) {
            $errors[] = 'не детермінований';
        }
        $distinct[json_encode($p, $flags)] = true;
    }
    check($errors === [] && count($distinct) >= 270, sprintf('%-16s різних %d / 300%s', $key, count($distinct),
        $errors ? ' — ' . implode('; ', array_slice(array_unique($errors), 0, 3)) : ''));
}

echo "Смисл\n";
$bad = 0;
for ($i = 0; $i < 300; $i++) {
    $g = bv_gen_name_length($pdo, new BvRng("cn$i"), [], 'uk');
    foreach ($g['payload']['options'] as $o) {
        preg_match('/^(.+) \((\d+)\) → (.+)$/u', $o['text'], $m);
        $isBug = $o['id'] === $g['answer']['correct'];
        if (mb_strlen($m[1]) !== (int) $m[2] || $isBug !== ($m[3] === 'прийнято' && mb_strlen($m[1]) > $g['params']['limit'])) {
            $bad++;
        }
    }
}
check($bad === 0, '2.4: довжина в дужках правильна, поломка — єдине прийняте задовге імʼя');
$bad = 0;
for ($i = 0; $i < 300; $i++) {
    $g = bv_gen_phone_digits($pdo, new BvRng("cp$i"), [], 'uk');
    foreach ($g['payload']['options'] as $o) {
        $num = explode(' →', $o['text'])[0];
        $letters = preg_match_all('/[^0-9 +]/u', $num);
        $accepted = str_contains($o['text'], 'прийнято');
        if (($o['id'] === $g['answer']['correct']) !== ($accepted && $letters > 0) || ($letters > 0 && $accepted && $letters !== 1)) {
            $bad++;
        }
    }
}
check($bad === 0, '2.3: поломка — єдиний прийнятий номер, у ньому рівно одна літера');
$bad = 0;
for ($i = 0; $i < 300; $i++) {
    $pp = bv_gen_change_due($pdo, new BvRng("cc$i"), [], 'uk')['params'];
    if ($pp['paid'] - $pp['price'] !== $pp['due'] || $pp['shown'] === $pp['due'] || $pp['shown'] < 0 || $pp['due'] <= 0) {
        $bad++;
    }
}
check($bad === 0, '1.1: решта = внесено − ціна, показана решта інша й не відʼємна');

echo "Сюжети пулів\n";
$mixGen = [105 => 'bv_gen_boundary_mix', 305 => 'bv_gen_report_mix'];
foreach (bv_pool_content() as $m => $variants) {
    $ok = count($variants) >= 6 && count(array_unique(array_column($variants, 'key'))) === count($variants);
    foreach ($variants as $v) {
        [$er] = bv_crm_check_variant(['payload_json' => json_encode($v['payload'], $flags), 'answer_json' => json_encode($v['answer'], $flags),
            'explain_json' => json_encode($v['explain'], $flags), 'skill' => $v['skill'], 'status' => 'active']);
        $ok = $ok && $er === [] && trim((string) ($v['explain']['hint'] ?? '')) !== '' && !str_contains(json_encode($v, $flags), 'тестуванн');
        if (isset($mixGen[$m])) {
            for ($s = 0; $s < 20; $s++) {
                $params = $mixGen[$m]($pdo, new BvRng("cm$m-$s"), [], 'uk')['params'];
                $filled = json_encode(bv_fill(['p' => $v['payload'], 'e' => $v['explain']], $params), $flags);
                $ok = $ok && !str_contains($filled, '{{');
            }
        }
    }
    check($ok, "місія $m: " . count($variants) . ' сюжетів, перевірка CRM, підказки' . (isset($mixGen[$m]) ? ', усі {{…}} заповнюються' : ''));
}

echo "Після сиду\n";
$playable = array_filter(array_keys(bv_world_missions()), static fn($id) => bv_world_playable($id));
check(count($playable) === 15, 'грабельні всі 15 місій (генератор або ≥ 6 активних варіантів)');
foreach ([9001, 9002, 9003] as $ex) {
    $pool = bv_exam_pool($pdo, $ex);
    check($pool['ok'] && count($pool['items']) === 5, "іспит $ex: 5 місій, пул {$pool['weight']} / {$pool['need']}");
}
$warn = array_filter(bv_crm_missions($pdo), static fn($r) => $r['warnings'] !== []);
check($warn === [], 'CRM: жодного попередження' . ($warn ? ' (' . implode(', ', array_map(static fn($r) => $r['mission']['n'], $warn)) . ')' : ''));
$out = (string) shell_exec(escapeshellarg(PHP_BINARY) . ' ' . escapeshellarg(__DIR__ . '/../tools/bugville-seed.php') . ' 2>&1');
check(str_contains($out, 'варіантів пулу 0, завдань іспитів 0'), 'сид ідемпотентний: повторний запуск нічого не додає');
$sql = (string) shell_exec(escapeshellarg(PHP_BINARY) . ' ' . escapeshellarg(__DIR__ . '/../tools/bugville-seed.php') . ' --sql 2>&1');
$sql = (string) preg_replace('/^--.*$/m', '', $sql);   // коментарі заголовка не рахуються
check(substr_count($sql, 'INSERT INTO') === 80 && preg_match('/\b(DELETE|UPDATE|DROP|TRUNCATE|ALTER)\b|^USE /mi', $sql) === 0,
    'SQL для проду: 80 INSERT … WHERE NOT EXISTS (з 15 словами, 12 предметами Майстерні й 15 значками), без DELETE / UPDATE / DROP / USE');

echo "\n" . ($fails === 0 ? "PASS $total/$total" : "FAIL $fails з $total") . "\n";
exit($fails === 0 ? 0 : 1);
