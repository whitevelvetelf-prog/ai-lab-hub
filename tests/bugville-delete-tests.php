<?php

declare(strict_types=1);

/**
 * AI LAB HUB — тести видалення ігрових даних гравця «Багвіля» (bv_delete_player_data, tools/bugville-delete-player.php).
 *   php tests/bugville-delete-tests.php
 *
 * Перевіряє: перевірка (dry run) лише рахує й нічого не видаляє; видаляються всі рядки акаунта A в усіх таблицях гри,
 * включно із зарахованою гостьовою спробою; дані акаунта B і гостьові спроби лишаються; повторний виклик — 0;
 * таблиць, яких ще немає, — null; неправильний id — виняток; кожна таблиця bv_* з полем user_id є в BV_PLAYER_TABLES;
 * CLI-інструмент без --yes нічого не видаляє, з --yes видаляє.
 * Тестові записи (mission_id ≥ 990000, користувачі 990000001+) видаляються наприкінці. Лише CLI, локальна БД.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../app/bugville/bv-player.php';

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

const T_M = 990101;
$uBase = 990000000 + random_int(10, 9999) * 1000;
$uA = $uBase + 1;
$uB = $uBase + 2;
$guestHash = hash('sha256', 'bv-delete-test-' . $uBase);

$count = static function (string $t, string $where, array $p) use ($pdo): int {
    $st = $pdo->prepare("SELECT COUNT(*) FROM $t WHERE $where");
    $st->execute($p);

    return (int) $st->fetchColumn();
};
$cleanup = static function () use ($pdo, $uBase): void {
    foreach (['bv_attempts', 'bv_seen_variants', 'bv_xp_log'] as $t) {
        $pdo->exec("DELETE FROM $t WHERE mission_id >= 990000");
    }
    $pdo->exec('DELETE FROM bv_players WHERE user_id BETWEEN ' . ($uBase + 1) . ' AND ' . ($uBase + 999));
};

$insAttempt = $pdo->prepare('INSERT INTO bv_attempts (token, user_id, session_hash, mission_id, variant_key, started_at, used, credited)
                             VALUES (:t, :u, :s, :m, :k, :at, 1, :c)');
$seed = static function (int $u, bool $withCredited) use ($pdo, $insAttempt, $guestHash): void {
    foreach ([1, 2] as $i) {
        $insAttempt->execute([':t' => bv_new_token(), ':u' => $u, ':s' => null, ':m' => T_M, ':k' => "g:t$i", ':at' => bv_now(), ':c' => 0]);
    }
    if ($withCredited) {   // почата гостем, зарахована до акаунта
        $insAttempt->execute([':t' => bv_new_token(), ':u' => $u, ':s' => $guestHash, ':m' => T_M, ':k' => 'g:t3', ':at' => bv_now(), ':c' => 1]);
    }
    $id = (int) $pdo->lastInsertId();
    $pdo->prepare('INSERT INTO bv_xp_log (user_id, attempt_id, mission_id, xp, stars, coins, source, created_at)
                   VALUES (:u, :a, :m, 20, 3, 10, :src, :t)')
        ->execute([':u' => $u, ':a' => $id, ':m' => T_M, ':src' => $withCredited ? 'credit' : 'play', ':t' => bv_now()]);
    $pdo->prepare('INSERT INTO bv_seen_variants (user_id, mission_id, variant_key, seen_at) VALUES (:u, :m, :k, :t)')
        ->execute([':u' => $u, ':m' => T_M, ':k' => 'g:t1', ':t' => bv_now()]);
    bv_confirm_age($pdo, $u);
};

try {
    $cleanup();
    $seed($uA, true);
    $seed($uB, false);
    $insAttempt->execute([':t' => bv_new_token(), ':u' => null, ':s' => $guestHash, ':m' => T_M, ':k' => 'g:guest', ':at' => bv_now(), ':c' => 0]);
    $userTotal = static fn(int $u): int => $count('bv_attempts', 'user_id = :u', [':u' => $u]) + $count('bv_xp_log', 'user_id = :u', [':u' => $u])
        + $count('bv_seen_variants', 'user_id = :u', [':u' => $u]) + $count('bv_players', 'user_id = :u', [':u' => $u]);

    echo "Перевірка без видалення\n";
    $dry = bv_delete_player_data($pdo, $uA, true);
    check($dry['bv_attempts'] === 3 && $dry['bv_xp_log'] === 1 && $dry['bv_seen_variants'] === 1 && $dry['bv_players'] === 1,
        'dry run рахує 3 / 1 / 1 / 1 рядків акаунта A');
    check($userTotal($uA) === 6, 'dry run нічого не видалив');
    check(!$pdo->inTransaction(), 'після dry run транзакцію закрито');

    echo "Видалення\n";
    $done = bv_delete_player_data($pdo, $uA);
    check($done['bv_attempts'] === 3 && $done['bv_xp_log'] === 1 && $done['bv_seen_variants'] === 1 && $done['bv_players'] === 1,
        'видалено 3 / 1 / 1 / 1 рядків, включно із зарахованою гостьовою спробою');
    check($userTotal($uA) === 0, 'у таблицях гри не лишилось рядків акаунта A');
    check(!bv_age_confirmed($pdo, $uA), 'підтвердження віку A видалено');
    check(bv_totals($pdo, $uA)['xp'] === 0, 'підсумки A — нуль');
    check($userTotal($uB) === 5, 'дані акаунта B не зачеплено');
    check($count('bv_attempts', 'user_id IS NULL AND session_hash = :s', [':s' => $guestHash]) === 1, 'незарахована гостьова спроба лишилась');
    $missing = array_keys(array_filter($done, static fn($n) => $n === null));
    check(in_array('bv_progress', $missing, true) && !in_array('bv_attempts', $missing, true), 'таблиці, яких ще немає, — null (напр. bv_progress)');

    $again = bv_delete_player_data($pdo, $uA);
    check(array_sum(array_map('intval', $again)) === 0, 'повторний виклик видаляє 0');

    $threw = false;
    try {
        bv_delete_player_data($pdo, 0);
    } catch (InvalidArgumentException) {
        $threw = true;
    }
    check($threw, 'user_id 0 — виняток');

    echo "Перелік таблиць\n";
    $cols = $pdo->query("SELECT DISTINCT TABLE_NAME FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE()
                         AND TABLE_NAME LIKE 'bv\\_%' AND COLUMN_NAME = 'user_id'")->fetchAll(PDO::FETCH_COLUMN);
    $notListed = array_diff(array_map('strtolower', $cols), BV_PLAYER_TABLES);
    check($cols !== [] && $notListed === [], 'кожна таблиця bv_* з user_id є в BV_PLAYER_TABLES'
        . ($notListed ? ' (немає: ' . implode(', ', $notListed) . ')' : ''));

    echo "CLI-інструмент\n";
    $php = escapeshellarg(PHP_BINARY);
    $tool = escapeshellarg(__DIR__ . '/../tools/bugville-delete-player.php');
    $outDry = (string) shell_exec("$php $tool $uB 2>&1");
    check(str_contains($outDry, 'разом: 5') && $userTotal($uB) === 5, 'без --yes показує 5 й нічого не видаляє');
    $outYes = (string) shell_exec("$php $tool $uB --yes 2>&1");
    check(str_contains($outYes, 'Видалено') && $userTotal($uB) === 0, 'з --yes видаляє дані B');
    $outBad = (string) shell_exec("$php $tool abc 2>&1");
    check(str_contains($outBad, 'Використання'), 'неправильний id — підказка, без видалення');
} finally {
    $cleanup();
}

echo "\n" . ($fails === 0 ? "PASS $total/$total" : "FAIL $fails з $total") . "\n";
exit($fails === 0 ? 0 : 1);
