<?php

declare(strict_types=1);

/**
 * Багвіль — «Поломка дня»: одна коротка сцена на день, однакова для всіх, і мʼяка серія днів (app/bugville/bv-progress.php).
 *
 * Вибір — лише на сервері. День — дата за bugville_daily_timezone (Europe/Kyiv). Для дати сервер детерміновано обирає тип
 * сцени (з bugville_daily_types — лише прийняті етапи) і seed = HMAC(дата, сіль bugville_daily_salt): варіант однаковий для
 * всіх у цей день і непередбачуваний наперед. Перший запит дня пише рядок у bv_daily (INSERT IGNORE за PRIMARY KEY day —
 * гонитва двох запитів не створить двох рядків); далі місія дня читається з таблиці.
 *
 * Типи чергуються блоками: кожні N днів (N — кількість типів) — перестановка всіх типів від солі, тож один тип іде
 * щонайбільше 2 дні поспіль (на стику блоків).
 *
 * Гра: звичайна сцена (scene_act / scene_finish), спроба — bv_attempts з kind = 'daily', mission_id = BV_DAILY_ID,
 * seed = «код генератора:seed дня» (bv_daily_attempt_seed), variant_key = «d:дата». Знайдене рахує сервер зі свого стану (як у місіях).
 * Нагорода: лише акаунт 16+, раз на день — UPDATE bv_daily_results … WHERE done = 0 з перевіркою rowCount; повторний прохід
 * того ж дня дозволено, але без XP і монет. Гостю нічого не пишеться (bv_daily_results), гостьова спроба не зараховується
 * після входу. Нагорода не залежить від швидкості; рейтингів, нагадувань і відліків часу немає.
 */

require_once __DIR__ . '/bv-player.php';
require_once __DIR__ . '/bv-progress.php';
require_once __DIR__ . '/bv-scenes.php';

const BV_DAILY_ID = 8000;
const BV_DAILY_GEN_BY_TYPE = ['input_machine' => 'daily_machine', 'form_scene' => 'daily_form', 'table_scene' => 'daily_table'];

/** Реєструє «Поломку дня» в реєстрі місій (щоб сцени, підказки й власник спроби працювали як у звичайній місії). */
function bv_daily_register(): void
{
    bv_register_mission(['id' => BV_DAILY_ID, 'variant_mode' => 'generator', 'generator_key' => null, 'generator_json' => [],
        'skill' => null, 'scene' => 'daily', 'scene_gen' => 'daily']);
}

/** Сіль вибору: bugville_daily_salt, інакше похідна від bugville_ip_salt, інакше (лише локально без солей) — постійна. */
function bv_daily_salt(): string
{
    $s = (string) (bv_cfg('bugville_daily_salt') ?? '');
    if ($s !== '') {
        return $s;
    }
    $ip = (string) (bv_cfg('bugville_ip_salt') ?? '');

    return $ip !== '' ? hash_hmac('sha256', 'bugville-daily', $ip) : 'bugville-daily-local';
}

/** Типи сцен для місії дня (лише відомі; порядок — як у config). */
function bv_daily_types(): array
{
    $t = array_values(array_filter((array) (bv_cfg('bugville_daily_types') ?? []), static fn($x) => is_string($x) && isset(BV_DAILY_GEN_BY_TYPE[$x])));

    return $t !== [] ? array_values(array_unique($t)) : ['input_machine'];
}

/** Чи схожий рядок на дату 'Y-m-d'. */
function bv_daily_valid_day(string $day): bool
{
    $d = DateTimeImmutable::createFromFormat('!Y-m-d', $day, new DateTimeZone('UTC'));

    return $d !== false && $d->format('Y-m-d') === $day;
}

/** Місія дати (чиста функція, без БД): ['mission_type', 'mission_ref', 'seed']. */
function bv_daily_choose(string $day): array
{
    $types = bv_daily_types();
    $salt = bv_daily_salt();
    $n = count($types);
    $num = intdiv((int) (new DateTimeImmutable($day . ' 00:00:00', new DateTimeZone('UTC')))->format('U'), 86400);
    $block = intdiv($num, $n);
    $perm = (new BvRng('daily-cycle|' . hash_hmac('sha256', 'block|' . $block, $salt)))->shuffle($types);
    $type = $perm[$num % $n];

    return ['mission_type' => $type, 'mission_ref' => BV_DAILY_GEN_BY_TYPE[$type],
        'seed' => substr(hash_hmac('sha256', 'daily|' . $day, $salt), 0, 24)];
}

/** Seed спроби дня для bv_attempts.seed (VARCHAR(32)): «dm:…» / «df:…» / «dt:…». */
function bv_daily_attempt_seed(array $d): string
{
    return (string) array_search($d['mission_ref'], BV_DAILY_GEN_CODES, true) . ':' . substr($d['seed'], 0, 28);
}

/**
 * Місія дня з bv_daily (першого звернення — записати: INSERT IGNORE, потім прочитати те, що в таблиці).
 * @return array{day:string, mission_type:string, mission_ref:string, seed:string}
 * @throws PDOException якщо таблиці міграції № 40 немає
 */
function bv_daily_get(PDO $pdo, ?string $day = null): array
{
    $day ??= bv_today();
    $sel = $pdo->prepare('SELECT day, mission_type, mission_ref, seed FROM bv_daily WHERE day = :d');
    $sel->execute([':d' => $day]);
    $row = $sel->fetch(PDO::FETCH_ASSOC);
    if (!$row) {
        $c = bv_daily_choose($day);
        $pdo->prepare('INSERT IGNORE INTO bv_daily (day, mission_type, mission_ref, seed, created_at) VALUES (:d, :t, :r, :s, :at)')
            ->execute([':d' => $day, ':t' => $c['mission_type'], ':r' => $c['mission_ref'], ':s' => $c['seed'], ':at' => bv_now()]);
        $sel->execute([':d' => $day]);
        $row = $sel->fetch(PDO::FETCH_ASSOC);
    }

    return ['day' => (string) $row['day'], 'mission_type' => (string) $row['mission_type'], 'mission_ref' => (string) $row['mission_ref'],
        'seed' => (string) $row['seed']];
}

/** Один рядок про місію дня — без спойлерів (ні поломок, ні чисел). */
function bv_daily_teaser(string $type): string
{
    return [
        'input_machine' => 'Сьогодні — автомат із напоями. Чи чесно він продає?',
        'form_scene' => 'Сьогодні — бланк на пошті. Чи все він перевіряє?',
        'table_scene' => 'Сьогодні — журнал бібліотеки. Чи все в ньому гаразд?',
    ][$type] ?? 'Сьогодні — нова поломка в Багвілі.';
}

/** Назва сцени дня для заголовка фіналу. */
function bv_daily_title(string $type): string
{
    return ['input_machine' => 'Автомат дня', 'form_scene' => 'Пошта дня', 'table_scene' => 'Бібліотека дня'][$type] ?? 'Поломка дня';
}

/** Результат акаунта за день: null — ще не грав. */
function bv_daily_result(PDO $pdo, int $userId, string $day): ?array
{
    $st = $pdo->prepare('SELECT stars, found_count, tries, done, rewarded FROM bv_daily_results WHERE user_id = :u AND day = :d');
    $st->execute([':u' => $userId, ':d' => $day]);
    $r = $st->fetch(PDO::FETCH_ASSOC);

    return $r ? array_map('intval', $r) : null;
}

/** Усе для картки на карті: місія дня, чи пройдено, серія (для акаунта). null — таблиць міграції № 40 немає. */
function bv_daily_card(PDO $pdo, ?int $userId): ?array
{
    try {
        $d = bv_daily_get($pdo);
    } catch (Throwable) {
        return null;
    }
    $card = ['day' => $d['day'], 'type' => $d['mission_type'], 'teaser' => bv_daily_teaser($d['mission_type']), 'done' => false,
        'stars' => 0, 'streak' => null];
    if ($userId === null) {
        $card['done'] = !empty($_SESSION['bv_guest']['daily'][$d['day']]);
    } else {
        try {
            $res = bv_daily_result($pdo, $userId, $d['day']);
            $card['done'] = $res !== null && $res['done'] === 1;
            $card['stars'] = (int) ($res['stars'] ?? 0);
            $card['streak'] = bv_streak_view($pdo, $userId);
        } catch (Throwable) {
            $card['streak'] = null;
        }
    }

    return $card;
}

/** Початок спроби «Поломки дня». @return array{ok:bool, error?:string, token?:string, scene?:array, daily?:array} */
function bv_daily_start(PDO $pdo, array $ctx): array
{
    $who = $ctx['user_id'] !== null ? 'u:' . $ctx['user_id'] : 'g:' . (string) bv_session_hash($ctx['guest_key']);
    $ipHash = bv_ip_hash((string) $ctx['ip']);
    if (!bv_rate_hit($pdo, 'bv_start_p', $who, (int) bv_cfg('bugville_starts_per_min_player'))
        || ($ipHash !== null && !bv_rate_hit($pdo, 'bv_start_ip', $ipHash, (int) bv_cfg('bugville_starts_per_min_ip')))) {
        return ['ok' => false, 'error' => 'rate_limited'];
    }
    try {
        $d = bv_daily_get($pdo);
    } catch (Throwable $e) {
        error_log('[bugville] daily unavailable (migration 40?): ' . get_class($e));

        return ['ok' => false, 'error' => 'unavailable'];
    }
    $seed = bv_daily_attempt_seed($d);
    $rules = bv_scene_rules('daily', $seed, BV_DAILY_ID);
    if ($rules === null) {
        return ['ok' => false, 'error' => 'no_variant'];
    }
    $token = bv_new_token();
    $pdo->prepare("INSERT INTO bv_attempts (token, user_id, session_hash, mission_id, variant_id, seed, variant_key, kind, lang,
                       opt_map_json, started_at, ip_hash, scene_state_json, act_count)
                   VALUES (:t, :u, :s, :m, NULL, :seed, :k, 'daily', :l, NULL, :at, :ip, :st, 0)")
        ->execute([':t' => $token, ':u' => $ctx['user_id'], ':s' => $ctx['user_id'] === null ? bv_session_hash($ctx['guest_key']) : null,
            ':m' => BV_DAILY_ID, ':seed' => $seed, ':k' => 'd:' . $d['day'], ':l' => $ctx['lang'], ':at' => bv_now(),
            ':ip' => bv_ip_hash((string) $ctx['ip']), ':st' => json_encode(bv_scene_initial_state($rules), JSON_UNESCAPED_UNICODE)]);
    // гість: токен НЕ додається до $_SESSION['bv_guest']['tokens'] — «Поломка дня» гостя після входу не зараховується
    $done = false;
    if ($ctx['user_id'] !== null) {
        $pdo->prepare('INSERT INTO bv_daily_results (user_id, day, stars, found_count, tries, done, rewarded, created_at)
                       VALUES (:u, :d, 0, 0, 1, 0, 0, :at)
                       ON DUPLICATE KEY UPDATE tries = LEAST(tries + 1, 65535)')
            ->execute([':u' => (int) $ctx['user_id'], ':d' => $d['day'], ':at' => bv_now()]);
        $done = (bv_daily_result($pdo, (int) $ctx['user_id'], $d['day'])['done'] ?? 0) === 1;
    }

    return ['ok' => true, 'token' => $token, 'scene' => bv_scene_public($rules),
        'daily' => ['day' => $d['day'], 'title' => bv_daily_title($d['mission_type']), 'done' => $done]];
}

/** День спроби «Поломки дня» з variant_key 'd:Y-m-d' (null — не спроба дня). */
function bv_daily_attempt_day(array $a): ?string
{
    $k = (string) ($a['variant_key'] ?? '');
    $day = str_starts_with($k, 'd:') ? substr($k, 2) : '';

    return (($a['kind'] ?? '') === 'daily' && bv_daily_valid_day($day)) ? $day : null;
}

/**
 * Нагорода після успішної здачі спроби дня (токен уже закрито в bv_scene_finish). Акаунт — перший успішний прохід дня:
 * XP і монети з config (UPDATE … WHERE done = 0, rowCount = 1), інакше лише оновити найкращий результат. Гість — лише
 * «що було б», нічого не пишеться. День — той, на який почато спробу (здача після опівночі зараховує вчорашній день).
 */
function bv_daily_reward(PDO $pdo, array $a, array $r): array
{
    $day = bv_daily_attempt_day($a) ?? bv_today();
    $xp = max(0, (int) (bv_cfg('bugville_daily_xp') ?? 15));
    $coins = max(0, (int) (bv_cfg('bugville_daily_coins') ?? 2));
    $r['daily'] = ['day' => $day, 'tomorrow' => true];
    $r['saved'] = false;
    $r['awarded'] = false;
    if ($a['user_id'] === null) {
        $r['would_earn'] = ['xp' => $xp, 'stars' => (int) $r['stars'], 'coins' => 0];
        $r['daily']['guest'] = true;
        if (session_status() === PHP_SESSION_ACTIVE) {   // лише ✓ на картці в цьому сеансі; у БД гостю нічого не пишеться
            $_SESSION['bv_guest']['daily'] = [$day => true];
        }

        return $r;
    }
    $uid = (int) $a['user_id'];
    $found = (int) ($r['summary']['found'] ?? 0);
    $pdo->prepare('INSERT IGNORE INTO bv_daily_results (user_id, day, stars, found_count, tries, done, rewarded, created_at)
                   VALUES (:u, :d, 0, 0, 1, 0, 0, :at)')->execute([':u' => $uid, ':d' => $day, ':at' => bv_now()]);
    $first = $pdo->prepare('UPDATE bv_daily_results SET done = 1, rewarded = 1, stars = GREATEST(stars, :s), found_count = GREATEST(found_count, :f)
                            WHERE user_id = :u AND day = :d AND done = 0');
    $first->execute([':s' => (int) $r['stars'], ':f' => $found, ':u' => $uid, ':d' => $day]);
    $r['saved'] = true;
    if ($first->rowCount() === 1) {
        $log = $pdo->prepare("INSERT IGNORE INTO bv_xp_log (user_id, attempt_id, mission_id, xp, stars, coins, source, created_at)
                              VALUES (:u, :a, :m, :xp, 0, :c, 'daily', :t)");
        $log->execute([':u' => $uid, ':a' => (int) $a['id'], ':m' => BV_DAILY_ID, ':xp' => $xp, ':c' => $coins, ':t' => bv_now()]);
        $r['earned'] = $log->rowCount() === 1 ? ['xp' => $xp, 'stars' => 0, 'coins' => $coins] : ['xp' => 0, 'stars' => 0, 'coins' => 0];
        $r['awarded'] = $r['earned']['xp'] > 0 || $r['earned']['coins'] > 0;

        return $r;
    }
    $pdo->prepare('UPDATE bv_daily_results SET stars = GREATEST(stars, :s), found_count = GREATEST(found_count, :f) WHERE user_id = :u AND day = :d')
        ->execute([':s' => (int) $r['stars'], ':f' => $found, ':u' => $uid, ':d' => $day]);
    $r['earned'] = ['xp' => 0, 'stars' => 0, 'coins' => 0];
    $r['daily']['already'] = true;   // нагороду за цей день уже отримано

    return $r;
}
