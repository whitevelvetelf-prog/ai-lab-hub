<?php

declare(strict_types=1);

/**
 * Багвіль — гравець (крок 2 плану): вік 16+, нагороди лише на сервері, зарахування гостьового сеансу після входу.
 *
 * Хто грає «з акаунтом»: увійшов І підтвердив вік (bv_players.age_confirmed_at). Інакше — як гість:
 * нічого не зберігається, після місії — «що заробили б» (would_earn).
 * Нагорода = запис у bv_reward_log (UNIQUE attempt_id) — тож одна спроба не дає балів двічі.
 * Зарахування гостьових спроб: лише токени з $_SESSION['bv_guest']['tokens'] цієї сесії; атомарно
 *   UPDATE … WHERE token = ? AND user_id IS NULL AND credited = 0 AND session_hash = ?
 * (друга спроба зарахувати ту саму спробу — 0 рядків, тож двом акаунтам не дістанеться); ліміти — на вхід і на добу.
 */

require_once __DIR__ . '/bv-attempts.php';

// ---------- Вік 16+ -----------------------------------------------------------------------------------------------

function bv_min_age(): int
{
    return max(1, (int) (bv_cfg('bugville_min_age_for_account') ?: 16));
}

function bv_age_confirmed(PDO $pdo, int $userId): bool
{
    $st = $pdo->prepare('SELECT age_confirmed_at FROM bv_players WHERE user_id = :u');
    $st->execute([':u' => $userId]);

    return (string) $st->fetchColumn() !== '';
}

/** Разове підтвердження «мені виповнилося N років» (у грі або з форми реєстрації). */
function bv_confirm_age(PDO $pdo, int $userId): void
{
    $pdo->prepare('INSERT INTO bv_players (user_id, age_confirmed_at, created_at) VALUES (:u, :a, :c)
                   ON DUPLICATE KEY UPDATE age_confirmed_at = COALESCE(age_confirmed_at, VALUES(age_confirmed_at))')
        ->execute([':u' => $userId, ':a' => bv_now(), ':c' => bv_now()]);
}

/**
 * Контекст запиту з урахуванням віку: акаунт без підтвердження грає як гість.
 * 'account_id' — хто увійшов (навіть без 16+), 'user_id' — від чийого імені зберігається (або null).
 */
function bv_request_ctx(PDO $pdo, ?int $loggedUserId, string $lang = 'uk'): array
{
    $saving = $loggedUserId !== null && bv_age_confirmed($pdo, $loggedUserId);
    $ctx = bv_ctx($saving ? $loggedUserId : null, $lang);
    $ctx['account_id'] = $loggedUserId;
    if ($saving) {
        $ctx['guest_key'] = $_SESSION['bv_guest']['key'] ?? null;   // спроби, початі ще гостем, лишаються його
    }

    return $ctx;
}

// ---------- Нагороди -----------------------------------------------------------------------------------------------

/** Нагорода за результат (ПОПЕРЕДНІ правила до основного завдання). @return array{xp:int, stars:int, coins:int} */
function bv_reward_for(int $score, int $stars): array
{
    $ok = $score > 0;

    return ['xp' => $ok ? max(0, (int) bv_cfg('bugville_reward_xp')) : 0, 'stars' => $ok ? $stars : 0,
        'coins' => $ok ? max(0, (int) bv_cfg('bugville_reward_coins')) : 0];
}

/** Записує нагороду спроби в журнал (раз на спробу). true — записано зараз. */
function bv_award(PDO $pdo, int $userId, int $attemptId, int $missionId, array $reward, string $source = 'play'): bool
{
    if ($reward['xp'] <= 0 && $reward['stars'] <= 0 && $reward['coins'] <= 0) {
        return false;
    }
    $st = $pdo->prepare('INSERT IGNORE INTO bv_reward_log (user_id, attempt_id, mission_id, xp, stars, coins, source, created_at)
                         VALUES (:u, :a, :m, :xp, :st, :c, :src, :t)');
    $st->execute([':u' => $userId, ':a' => $attemptId, ':m' => $missionId, ':xp' => $reward['xp'], ':st' => $reward['stars'],
        ':c' => $reward['coins'], ':src' => $source, ':t' => bv_now()]);

    return $st->rowCount() === 1;
}

/** @return array{xp:int, stars:int, coins:int} */
function bv_totals(PDO $pdo, int $userId): array
{
    $st = $pdo->prepare('SELECT COALESCE(SUM(xp),0), COALESCE(SUM(stars),0), COALESCE(SUM(coins),0) FROM bv_reward_log WHERE user_id = :u');
    $st->execute([':u' => $userId]);
    [$xp, $stars, $coins] = array_map('intval', $st->fetch(PDO::FETCH_NUM) ?: [0, 0, 0]);

    return ['xp' => $xp, 'stars' => $stars, 'coins' => $coins];
}

// ---------- Зарахування гостьового сеансу -------------------------------------------------------------------------

/** Скільки ще можна зарахувати: min(ліміт за вхід − уже за цей вхід, ліміт за добу − уже за 24 год). */
function bv_credit_room(PDO $pdo, int $userId): int
{
    $login = $_SESSION['bv_credit_login'] ?? null;
    $sid = session_status() === PHP_SESSION_ACTIVE ? session_id() : 'cli';
    if (!is_array($login) || ($login['uid'] ?? null) !== $userId || ($login['sid'] ?? null) !== $sid) {
        $_SESSION['bv_credit_login'] = $login = ['uid' => $userId, 'sid' => $sid, 'n' => 0];   // новий вхід — новий лічильник
    }
    $st = $pdo->prepare('SELECT COUNT(*) FROM bv_attempts WHERE user_id = :u AND credited = 1 AND credited_at > :t');
    $st->execute([':u' => $userId, ':t' => bv_now(-86400)]);
    $perLogin = max(0, (int) bv_cfg('bugville_credit_max_per_login')) - (int) $login['n'];
    $perDay = max(0, (int) bv_cfg('bugville_credit_max_per_day')) - (int) $st->fetchColumn();

    return max(0, min($perLogin, $perDay));
}

/**
 * Зараховує ОДНУ завершену гостьову спробу акаунту (атомарно) і пише нагороду. true — зараховано.
 * $attempt — рядок bv_attempts; $sessionHash — хеш гостя цієї сесії.
 */
function bv_credit_one(PDO $pdo, int $userId, array $attempt, ?string $sessionHash): bool
{
    if ($sessionHash === null || bv_credit_room($pdo, $userId) <= 0) {
        return false;
    }
    $st = $pdo->prepare('UPDATE bv_attempts SET user_id = :u, credited = 1, credited_at = :t
                         WHERE id = :id AND user_id IS NULL AND credited = 0 AND used = 1 AND session_hash = :s');
    $st->execute([':u' => $userId, ':t' => bv_now(), ':id' => (int) $attempt['id'], ':s' => $sessionHash]);
    if ($st->rowCount() !== 1) {
        return false;
    }
    $_SESSION['bv_credit_login']['n'] = (int) ($_SESSION['bv_credit_login']['n'] ?? 0) + 1;
    bv_award($pdo, $userId, (int) $attempt['id'], (int) $attempt['mission_id'],
        bv_reward_for((int) $attempt['score'], (int) $attempt['stars']), 'credit');
    if (!empty($attempt['variant_key'])) {
        bv_mark_seen($pdo, (int) $attempt['mission_id'], $userId, (string) $attempt['variant_key']);
    }

    return true;
}

/**
 * Зарахування гостьового сеансу після входу (+ підтвердженого віку). Завершені спроби сесії зараховуються в межах
 * лімітів, решта завершених більше не зараховується (зникне з гостьовими за 24 год). Незавершені лишаються в сесії —
 * їх зарахує перевірка відповіді. @return array{credited:int, skipped:int, xp:int, stars:int, coins:int}
 */
function bv_credit_guest_session(PDO $pdo, int $userId): array
{
    $out = ['credited' => 0, 'skipped' => 0, 'xp' => 0, 'stars' => 0, 'coins' => 0];
    $tokens = array_values(array_unique(array_filter((array) ($_SESSION['bv_guest']['tokens'] ?? []), 'is_string')));
    if ($tokens === [] || !bv_age_confirmed($pdo, $userId)) {
        return $out;
    }
    $hash = bv_session_hash($_SESSION['bv_guest']['key'] ?? null);
    $in = implode(',', array_fill(0, count($tokens), '?'));
    $st = $pdo->prepare("SELECT * FROM bv_attempts WHERE token IN ($in)");
    $st->execute($tokens);
    $keep = [];
    foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $a) {
        if ($a['user_id'] !== null || (int) $a['credited'] === 1 || $a['session_hash'] !== $hash) {
            continue;   // уже чийсь або не з цієї сесії
        }
        if ((int) $a['used'] === 0) {
            $keep[] = (string) $a['token'];
            continue;
        }
        if (bv_credit_one($pdo, $userId, $a, $hash)) {
            $r = bv_reward_for((int) $a['score'], (int) $a['stars']);
            $out['credited']++;
            $out['xp'] += $r['xp'];
            $out['stars'] += $r['stars'];
            $out['coins'] += $r['coins'];
        } else {
            $out['skipped']++;
        }
    }
    $_SESSION['bv_guest']['tokens'] = $keep;

    return $out;
}

// ---------- Перевірка з нагородою -------------------------------------------------------------------------------

/**
 * bv_attempt_check + нагорода: акаунт → запис у журнал (saved = true); гість → would_earn (нічого не пишеться);
 * гостьова спроба, перевірена вже після входу з 16+ → зараховується одразу (у межах лімітів).
 */
function bv_check_and_reward(PDO $pdo, string $token, mixed $given, array $ctx): array
{
    $r = bv_attempt_check($pdo, $token, $given, $ctx);
    if (!$r['ok']) {
        return $r;
    }
    $st = $pdo->prepare('SELECT * FROM bv_attempts WHERE token = :t');
    $st->execute([':t' => $token]);
    $a = (array) $st->fetch(PDO::FETCH_ASSOC);
    $reward = bv_reward_for((int) ($r['score'] ?? 0), (int) ($r['stars'] ?? 0));
    $r['saved'] = false;
    if ($r['repeat']) {
        $r['saved'] = $a['user_id'] !== null;

        return $r;
    }
    $uid = $ctx['user_id'];
    if ($uid !== null && $a['user_id'] === null) {   // почато гостем, перевірено вже з акаунтом
        if (bv_credit_one($pdo, (int) $uid, $a, bv_session_hash($_SESSION['bv_guest']['key'] ?? null))) {
            $_SESSION['bv_guest']['tokens'] = array_values(array_diff((array) ($_SESSION['bv_guest']['tokens'] ?? []), [$token]));
            $r['saved'] = true;
            $r['earned'] = $reward;
        } else {
            $r['would_earn'] = $reward;
            $r['credit_limit'] = true;
        }
    } elseif ($a['user_id'] !== null) {
        bv_award($pdo, (int) $a['user_id'], (int) $a['id'], (int) $a['mission_id'], $reward);
        $r['saved'] = true;
        $r['earned'] = $reward;
    } else {
        $r['would_earn'] = $reward;   // гість: «+30 XP, 3 зірки — зареєструйтесь (16+), щоб зберегти»
    }
    $r['awarded'] = $r['saved'] && $r['correct'];

    return $r;
}
