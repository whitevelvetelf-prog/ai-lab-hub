<?php

declare(strict_types=1);

/**
 * Багвіль — гравець (крок 2 плану): вік 16+, нагороди лише на сервері, зарахування гостьового сеансу після входу.
 *
 * Хто грає «з акаунтом»: увійшов І підтвердив вік (bv_players.age_confirmed_at). Інакше — як гість:
 * нічого не зберігається, після місії — «що заробили б» (would_earn).
 * Нагорода = запис приросту в bv_xp_log (UNIQUE attempt_id) — тож одна спроба не дає балів двічі; за повтор місії —
 * лише покращення найкращого результату (config bugville_reward_improvement_only).
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

/**
 * Повна нагорода місії за зірки (MAIN_TASK, розділ 6): XP = base + per_extra_star × (зірки − 1); монети = 5 (+5 за 3 зірки).
 * $account = false (гість) → монет немає. @return array{xp:int, stars:int, coins:int}
 */
function bv_reward_for(int $stars, bool $account = true): array
{
    if ($stars <= 0) {
        return ['xp' => 0, 'stars' => 0, 'coins' => 0];
    }
    $coins = (int) bv_cfg('bugville_coins_mission') + ($stars >= 3 ? (int) bv_cfg('bugville_coins_three_stars_bonus') : 0);

    return ['xp' => (int) bv_cfg('bugville_xp_mission_base') + (int) bv_cfg('bugville_xp_per_extra_star') * ($stars - 1),
        'stars' => $stars, 'coins' => $account ? max(0, $coins) : 0];
}

/** Приріст нагороди при переході від найкращих $best зірок до $stars (лише покращення, якщо так у config). */
function bv_reward_delta(int $stars, int $best, bool $account = true): array
{
    if (bv_cfg('bugville_reward_improvement_only') === false) {
        return bv_reward_for($stars, $account);
    }
    if ($stars <= $best) {
        return ['xp' => 0, 'stars' => 0, 'coins' => 0];
    }
    $new = bv_reward_for($stars, $account);
    $old = bv_reward_for($best, $account);

    return ['xp' => $new['xp'] - $old['xp'], 'stars' => $new['stars'] - $old['stars'], 'coins' => $new['coins'] - $old['coins']];
}

/** Найкращі зірки акаунта за місію = сума приростів зірок у журналі. */
function bv_best_stars(PDO $pdo, int $userId, int $missionId): int
{
    $st = $pdo->prepare('SELECT COALESCE(SUM(stars), 0) FROM bv_xp_log WHERE user_id = :u AND mission_id = :m');
    $st->execute([':u' => $userId, ':m' => $missionId]);

    return (int) $st->fetchColumn();
}

/**
 * Нагорода спроби акаунту: приріст відносно найкращого результату місії → bv_xp_log (UNIQUE attempt_id: раз на спробу).
 * @return array{xp:int, stars:int, coins:int} записаний приріст (нулі — нічого не записано)
 */
function bv_award_attempt(PDO $pdo, int $userId, array $attempt, string $source = 'play'): array
{
    $zero = ['xp' => 0, 'stars' => 0, 'coins' => 0];
    $delta = bv_reward_delta((int) $attempt['stars'], bv_best_stars($pdo, $userId, (int) $attempt['mission_id']));
    if ($delta['xp'] <= 0 && $delta['stars'] <= 0 && $delta['coins'] <= 0) {
        return $zero;
    }
    $st = $pdo->prepare('INSERT IGNORE INTO bv_xp_log (user_id, attempt_id, mission_id, xp, stars, coins, source, created_at)
                         VALUES (:u, :a, :m, :xp, :st, :c, :src, :t)');
    $st->execute([':u' => $userId, ':a' => (int) $attempt['id'], ':m' => (int) $attempt['mission_id'], ':xp' => $delta['xp'],
        ':st' => $delta['stars'], ':c' => $delta['coins'], ':src' => $source, ':t' => bv_now()]);

    return $st->rowCount() === 1 ? $delta : $zero;
}

/** Гість: «що заробили б» — приріст відносно найкращого результату цієї місії в сесії (без монет). */
function bv_guest_would_earn(int $missionId, int $stars): array
{
    $best = (int) ($_SESSION['bv_guest']['best'][$missionId] ?? 0);
    $delta = bv_reward_delta($stars, $best, false);
    if ($stars > $best) {
        $_SESSION['bv_guest']['best'][$missionId] = $stars;
    }

    return $delta;
}

/** @return array{xp:int, stars:int, coins:int} */
function bv_totals(PDO $pdo, int $userId): array
{
    $st = $pdo->prepare('SELECT COALESCE(SUM(xp),0), COALESCE(SUM(stars),0), COALESCE(SUM(coins),0) FROM bv_xp_log WHERE user_id = :u');
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
 * Зараховує ОДНУ завершену гостьову спробу акаунту (атомарно) і пише нагороду (приріст).
 * $attempt — рядок bv_attempts; $sessionHash — хеш гостя цієї сесії. Повертає нагороду або null (не зараховано).
 * @return array{xp:int, stars:int, coins:int}|null
 */
function bv_credit_one(PDO $pdo, int $userId, array $attempt, ?string $sessionHash): ?array
{
    if ($sessionHash === null || bv_credit_room($pdo, $userId) <= 0) {
        return null;
    }
    $st = $pdo->prepare('UPDATE bv_attempts SET user_id = :u, credited = 1, credited_at = :t
                         WHERE id = :id AND user_id IS NULL AND credited = 0 AND used = 1 AND session_hash = :s');
    $st->execute([':u' => $userId, ':t' => bv_now(), ':id' => (int) $attempt['id'], ':s' => $sessionHash]);
    if ($st->rowCount() !== 1) {
        return null;
    }
    $_SESSION['bv_credit_login']['n'] = (int) ($_SESSION['bv_credit_login']['n'] ?? 0) + 1;
    $reward = bv_award_attempt($pdo, $userId, $attempt, 'credit');
    if (!empty($attempt['variant_key'])) {
        bv_mark_seen($pdo, (int) $attempt['mission_id'], $userId, (string) $attempt['variant_key']);
    }

    return $reward;
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
        $r = bv_credit_one($pdo, $userId, $a, $hash);
        if ($r !== null) {
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

    return bv_reward_checked($pdo, $token, $r, $ctx);
}

/**
 * Нагорода після перевіреної спроби ($r — результат bv_attempt_check або bv_scene_finish: ok, repeat, correct, stars):
 * акаунт → bv_xp_log (приріст), почато гостем і здано з акаунтом → зарахування з лімітами, гість → would_earn.
 */
function bv_reward_checked(PDO $pdo, string $token, array $r, array $ctx): array
{
    $st = $pdo->prepare('SELECT * FROM bv_attempts WHERE token = :t');
    $st->execute([':t' => $token]);
    $a = (array) $st->fetch(PDO::FETCH_ASSOC);
    $r['saved'] = false;
    if ($r['repeat']) {
        $r['saved'] = $a['user_id'] !== null;

        return $r;
    }
    $uid = $ctx['user_id'];
    $earned = null;
    if ($uid !== null && $a['user_id'] === null) {   // почато гостем, перевірено вже з акаунтом
        $earned = bv_credit_one($pdo, (int) $uid, $a, bv_session_hash($_SESSION['bv_guest']['key'] ?? null));
        if ($earned !== null) {
            $_SESSION['bv_guest']['tokens'] = array_values(array_diff((array) ($_SESSION['bv_guest']['tokens'] ?? []), [$token]));
        } else {
            $r['would_earn'] = bv_guest_would_earn((int) $a['mission_id'], (int) $a['stars']);
            $r['credit_limit'] = true;
        }
    } elseif ($a['user_id'] !== null) {
        $earned = bv_award_attempt($pdo, (int) $a['user_id'], $a);
    } else {
        // гість: «+20 XP, 3 зірки — зареєструйтесь (16+), щоб зберегти»; монет гостям немає
        $r['would_earn'] = bv_guest_would_earn((int) $a['mission_id'], (int) $a['stars']);
    }
    if ($earned !== null) {
        $r['saved'] = true;
        $r['earned'] = $earned;
    }
    $r['awarded'] = $r['saved'] && $r['correct'] && $earned !== null && $earned['xp'] > 0;

    return $r;
}

// ---------- Видалення даних гравця на його запит (другий і останній дозволений DELETE гри) ------------------------

/**
 * Таблиці гри з даними гравця (поле user_id). Включно з майбутніми з MAIN_TASK §11: доки таблиці немає, її пропущено.
 * Нова таблиця bv_* з user_id ОБОВ'ЯЗКОВО додається сюди (tests/bugville-delete-tests.php це перевіряє).
 * Порядок: спершу похідні дані (журнали, прогрес), наприкінці bv_players (підтвердження віку).
 */
const BV_PLAYER_TABLES = [
    'bv_xp_log', 'bv_exam_tasks', 'bv_attempts', 'bv_seen_variants',
    'bv_progress', 'bv_wallet', 'bv_user_badges', 'bv_user_words', 'bv_user_items', 'bv_streaks', 'bv_certificates',
    'bv_players',
];

/**
 * Видаляє всі ігрові дані одного акаунта (запит гравця через «Контакти», Політика конфіденційності, розділ «Багвіль»).
 * Сам акаунт сайту (users) не чіпає. Зараховані гостьові спроби вже мають user_id акаунта — видаляються теж.
 * Одна транзакція: або все, або нічого. $dryRun = true — лише порахувати рядки.
 * Лічильники лімітів у mp_rate_limits (sha256 від 'u:<id>') не видаляються тут: їх прибирає mpb_rate_cleanup() за 3 доби.
 * @return array<string, int|null> таблиця → рядків (null — таблиці ще немає)
 */
function bv_delete_player_data(PDO $pdo, int $userId, bool $dryRun = false): array
{
    if ($userId <= 0) {
        throw new InvalidArgumentException('user_id must be positive');
    }
    $exists = [];
    foreach (BV_PLAYER_TABLES as $t) {
        try {
            $pdo->query("SELECT 1 FROM $t LIMIT 0");
            $exists[$t] = true;
        } catch (Throwable) {
            $exists[$t] = false;
        }
    }
    $out = [];
    $pdo->beginTransaction();
    try {
        foreach (BV_PLAYER_TABLES as $t) {
            if (!$exists[$t]) {
                $out[$t] = null;
                continue;
            }
            $st = $pdo->prepare($dryRun ? "SELECT COUNT(*) FROM $t WHERE user_id = :u" : "DELETE FROM $t WHERE user_id = :u");
            $st->execute([':u' => $userId]);
            $out[$t] = $dryRun ? (int) $st->fetchColumn() : $st->rowCount();
        }
        $dryRun ? $pdo->rollBack() : $pdo->commit();
    } catch (Throwable $e) {
        if ($pdo->inTransaction()) {
            $pdo->rollBack();
        }
        throw $e;
    }

    return $out;
}

// ---------- Прогрес для карти (крок 3) -----------------------------------------------------------------------------

/**
 * Найкращі зірки по місіях: акаунт 16+ — сума приростів у bv_xp_log, гість — найкращі в сесії ($_SESSION['bv_guest']['best']).
 * @return array<int,int> mission_id => зірки (0–3)
 */
function bv_stars_by_mission(PDO $pdo, ?int $userId): array
{
    if ($userId === null) {
        return array_map('intval', (array) ($_SESSION['bv_guest']['best'] ?? []));
    }
    $st = $pdo->prepare('SELECT mission_id, SUM(stars) FROM bv_xp_log WHERE user_id = :u GROUP BY mission_id');
    $st->execute([':u' => $userId]);

    return array_map('intval', $st->fetchAll(PDO::FETCH_KEY_PAIR) ?: []);
}

/** Підсумки гостя в сесії (як в акаунта, але без монет): XP і зірки з найкращих результатів місій. */
function bv_guest_totals(): array
{
    $xp = 0;
    $stars = 0;
    foreach ((array) ($_SESSION['bv_guest']['best'] ?? []) as $s) {
        $r = bv_reward_for((int) $s, false);
        $xp += $r['xp'];
        $stars += $r['stars'];
    }

    return ['xp' => $xp, 'stars' => $stars, 'coins' => 0];
}
