<?php

declare(strict_types=1);

/**
 * Багвіль — спроби (крок 1 плану): одноразовий токен, перевірка відповіді лише на сервері, ліміти частоти.
 *
 * Контекст гравця ($ctx): ['user_id' => ?int, 'guest_key' => ?string, 'ip' => string, 'lang' => string] — bv_ctx().
 * Гість: user_id = null; спроба прив'язана до session_hash = sha256(випадковий ключ гостя з $_SESSION['bv_guest']),
 * а не до id сесії PHP (він змінюється при вході — інакше після входу не вийде зарахувати сеанс).
 * Нагороди (XP, зірки, монети…) рахує лише сервер; бали тут попередні: 100 / 0, зірки 3 / 0 — правила з основного завдання.
 * DELETE гри лише два: bv_cleanup_guest_attempts() (гостьові незараховані спроби, старші за 24 год) і
 * bv_delete_player_data() у bv-player.php (усі дані акаунта на запит гравця).
 */

require_once __DIR__ . '/bv-variants.php';
require_once __DIR__ . '/bv-scenes.php';

/** Контекст поточного запиту: користувач, ключ гостя з сесії, IP, мова. */
function bv_ctx(?int $userId, string $lang = 'uk'): array
{
    return ['user_id' => $userId, 'guest_key' => $userId === null ? bv_guest_key() : null,
        'ip' => (string) ($_SERVER['REMOTE_ADDR'] ?? ''), 'lang' => bv_lang($lang)];
}

/** Випадковий ключ гостя в сесії (переживає session_regenerate_id при вході). */
function bv_guest_key(): string
{
    if (empty($_SESSION['bv_guest']['key'])) {
        $_SESSION['bv_guest']['key'] = bin2hex(random_bytes(16));
    }

    return (string) $_SESSION['bv_guest']['key'];
}

function bv_session_hash(?string $guestKey): ?string
{
    return $guestKey === null || $guestKey === '' ? null : hash('sha256', 'bv-guest|' . $guestKey);
}

/** Новий токен спроби: 32 випадкові байти, base64url без «=» (43 символи). */
function bv_new_token(): string
{
    return rtrim(strtr(base64_encode(random_bytes(32)), '+/', '-_'), '=');
}

// ---------- Ліміти частоти (наявний механізм mp_rate_limits, вікно — хвилина) ----------------------------------

/** Атомарний лічильник за поточну хвилину. true — дозволено. Немає таблиці — дозволено (+ запис у лог). */
function bv_rate_hit(PDO $pdo, string $action, string $key, int $limit): bool
{
    if ($limit <= 0) {
        return true;
    }
    $window = gmdate('Y-m-d H:i:00');
    $hash = hash('sha256', $action . '|' . $key);
    try {
        $pdo->prepare('INSERT INTO mp_rate_limits (key_hash, action, window_start, hits) VALUES (:k, :a, :w, 1)
                       ON DUPLICATE KEY UPDATE hits = hits + 1')->execute([':k' => $hash, ':a' => $action, ':w' => $window]);
        $st = $pdo->prepare('SELECT hits FROM mp_rate_limits WHERE key_hash = :k AND action = :a AND window_start = :w');
        $st->execute([':k' => $hash, ':a' => $action, ':w' => $window]);

        return (int) $st->fetchColumn() <= $limit;
    } catch (Throwable $e) {
        error_log('[bugville] rate limit unavailable: ' . get_class($e));

        return true;
    }
}

/** Ліміти перевірок: гравець / сесія гостя і (лише з сіллю) IP. */
function bv_check_rate_ok(PDO $pdo, array $ctx): bool
{
    $who = $ctx['user_id'] !== null ? 'u:' . $ctx['user_id'] : 'g:' . (string) bv_session_hash($ctx['guest_key']);
    if (!bv_rate_hit($pdo, 'bv_chk_p', $who, (int) bv_cfg('bugville_checks_per_min_player'))) {
        return false;
    }
    $ipHash = bv_ip_hash((string) $ctx['ip']);

    return $ipHash === null || bv_rate_hit($pdo, 'bv_chk_ip', $ipHash, (int) bv_cfg('bugville_checks_per_min_ip'));
}

// ---------- Запуск спроби ---------------------------------------------------------------------------------------

/**
 * Нова спроба місії: обирає варіант (небачені першими), створює токен, повертає лише сцену.
 * @return array{ok:bool, token?:string, scene?:array, error?:string}
 */
function bv_attempt_start(PDO $pdo, int $missionId, array $ctx, string $kind = 'mission'): array
{
    $mission = bv_mission($missionId);
    if ($mission === null || !bv_valid_kind($kind)) {
        return ['ok' => false, 'error' => 'not_found'];
    }
    $who = $ctx['user_id'] !== null ? 'u:' . $ctx['user_id'] : 'g:' . (string) bv_session_hash($ctx['guest_key']);
    $ipHash = bv_ip_hash((string) $ctx['ip']);
    if (!bv_rate_hit($pdo, 'bv_start_p', $who, (int) bv_cfg('bugville_starts_per_min_player'))
        || ($ipHash !== null && !bv_rate_hit($pdo, 'bv_start_ip', $ipHash, (int) bv_cfg('bugville_starts_per_min_ip')))) {
        return ['ok' => false, 'error' => 'rate_limited'];
    }
    if (!empty($mission['scene_gen']) && $kind === 'mission') {
        return bv_scene_start($pdo, $mission, $ctx);
    }
    $picked = bv_pick_variant($pdo, $mission, $ctx['user_id'], $ctx['lang']);
    if ($picked === null) {
        return ['ok' => false, 'error' => 'no_variant'];
    }
    $token = bv_new_token();
    [$scene, $map] = bv_public_scene($picked['variant']['payload'], new BvRng($token));
    $pdo->prepare('INSERT INTO bv_attempts (token, user_id, session_hash, mission_id, variant_id, seed, variant_key, kind, lang,
                       opt_map_json, started_at, ip_hash)
                   VALUES (:t, :u, :s, :m, :v, :seed, :k, :kind, :l, :map, :at, :ip)')
        ->execute([
            ':t' => $token, ':u' => $ctx['user_id'], ':s' => $ctx['user_id'] === null ? bv_session_hash($ctx['guest_key']) : null,
            ':m' => $missionId, ':v' => $picked['variant_id'], ':seed' => $picked['seed'], ':k' => $picked['variant']['key'],
            ':kind' => $kind, ':l' => $ctx['lang'], ':map' => json_encode($map), ':at' => bv_now(), ':ip' => bv_ip_hash((string) $ctx['ip']),
        ]);
    bv_mark_seen($pdo, $missionId, $ctx['user_id'], $picked['variant']['key']);
    if ($ctx['user_id'] === null) {
        $_SESSION['bv_guest']['tokens'][] = $token;   // кандидати на зарахування після входу (крок 2)
    }

    return ['ok' => true, 'token' => $token, 'scene' => $scene];
}

// ---------- Зірки й підказка -------------------------------------------------------------------------------------

/**
 * Зірки за правильну відповідь (MAIN_TASK, розділ 6): 3 — перша спроба місії без підказки; 2 — з підказкою або друга
 * спроба; 1 — третя й далі. «Спроба» — завершена перевірка цієї місії тим самим гравцем (акаунт або сесія гостя).
 */
function bv_stars_for(PDO $pdo, array $attempt): int
{
    // «Поломка дня»: рахуються лише здані спроби того самого дня (variant_key = 'd:дата')
    $day = ($attempt['kind'] ?? '') === 'daily' ? ' AND variant_key = ' . $pdo->quote((string) $attempt['variant_key']) : '';
    if ($attempt['user_id'] !== null) {
        $st = $pdo->prepare('SELECT COUNT(*) FROM bv_attempts WHERE user_id = :w AND mission_id = :m AND used = 1 AND id <> :id' . $day);
        $st->execute([':w' => (int) $attempt['user_id'], ':m' => (int) $attempt['mission_id'], ':id' => (int) $attempt['id']]);
    } else {
        // той самий гість: усі спроби його сесії, і ще не зараховані, і вже зараховані акаунту після входу
        $st = $pdo->prepare('SELECT COUNT(*) FROM bv_attempts WHERE session_hash = :w AND mission_id = :m AND used = 1 AND id <> :id' . $day);
        $st->execute([':w' => (string) $attempt['session_hash'], ':m' => (int) $attempt['mission_id'], ':id' => (int) $attempt['id']]);
    }
    $before = (int) $st->fetchColumn();
    if ($before === 0 && (int) ($attempt['hint_used'] ?? 0) === 0) {
        return 3;
    }

    return $before <= 1 ? 2 : 1;
}

/**
 * Підказка до спроби: безкоштовна, лише знижує зірки (hint_used = 1). Текст — з варіанта ('hint'), інакше загальний.
 * Ті самі перевірки власника й строку, що й у відповіді; після відповіді підказка не потрібна.
 * @return array{ok:bool, hint?:string, error?:string}
 */
function bv_attempt_hint(PDO $pdo, string $token, array $ctx): array
{
    if (!bv_check_rate_ok($pdo, $ctx)) {
        return ['ok' => false, 'error' => 'rate_limited'];
    }
    $st = $pdo->prepare('SELECT * FROM bv_attempts WHERE token = :t');
    $st->execute([':t' => $token]);
    $a = $st->fetch(PDO::FETCH_ASSOC);
    if (!$a) {
        return ['ok' => false, 'error' => 'not_found'];
    }
    $owner = $a['user_id'] !== null
        ? ($ctx['user_id'] !== null && (int) $a['user_id'] === (int) $ctx['user_id'])
        : (bv_session_hash($ctx['guest_key'] ?? ($_SESSION['bv_guest']['key'] ?? null)) === $a['session_hash']);
    $mission = bv_mission((int) $a['mission_id']);
    if (!$owner || $mission === null) {
        return ['ok' => false, 'error' => 'forbidden'];
    }
    if ((int) $a['used'] === 1) {
        return ['ok' => false, 'error' => 'already_checked'];
    }
    if (($a['scene_state_json'] ?? null) !== null) {   // інтерактивна сцена: підказки з правил її варіанта
        $rules = bv_scene_rules((string) ($mission['scene_gen'] ?? ''), (string) $a['seed'], (int) $a['mission_id']);
        $hints = array_values(array_map('strval', (array) ($rules['hints'] ?? [])));
        $pdo->prepare('UPDATE bv_attempts SET hint_used = 1 WHERE id = :id')->execute([':id' => (int) $a['id']]);

        return ['ok' => true, 'hint' => $hints[0] ?? 'Подивіться уважно на межі.', 'hints' => $hints];
    }
    $v = bv_build_variant($pdo, $mission, $a['variant_id'] !== null ? (int) $a['variant_id'] : null, $a['seed'], (string) $a['lang']);
    $pdo->prepare('UPDATE bv_attempts SET hint_used = 1 WHERE id = :id')->execute([':id' => (int) $a['id']]);

    return ['ok' => true, 'hint' => (string) ($v['hint']['text'] ?? 'Подивіться уважно на межі: найменше й найбільше значення.')];
}

// ---------- Перевірка відповіді ---------------------------------------------------------------------------------

/** Чи відповідь ($given — public id або число) збігається з answer (internal id) через карту спроби. */
function bv_evaluate(array $answer, mixed $given, array $map): ?bool
{
    $type = (string) ($answer['type'] ?? '');
    if ($type === 'single') {
        return is_string($given) && isset($map[$given]) ? $map[$given] === (string) ($answer['correct'] ?? '') : null;
    }
    if ($type === 'multi') {
        if (!is_array($given)) {
            return null;
        }
        $picked = [];
        foreach ($given as $g) {
            if (!is_string($g) || !isset($map[$g])) {
                return null;
            }
            $picked[] = $map[$g];
        }
        $want = array_map('strval', (array) ($answer['correct'] ?? []));
        sort($picked);
        sort($want);

        return array_values(array_unique($picked)) === $want;
    }
    if ($type === 'number') {
        if (!is_numeric($given)) {
            return null;
        }

        return abs((float) $given - (float) ($answer['value'] ?? 0)) <= (float) ($answer['tolerance'] ?? 0);
    }

    return null;
}

/**
 * Перевірка відповіді за токеном. Порядок: ліміт частоти → токен → власник → строк → оцінка → атомарне used = 1.
 * Повторне надсилання того самого токена — результат першої перевірки, без нагороди (awarded = false).
 * @return array{ok:bool, error?:string, correct?:bool, score?:int, stars?:int, awarded?:bool, repeat?:bool,
 *               explain?:string, correct_ids?:list<string>}
 */
function bv_attempt_check(PDO $pdo, string $token, mixed $given, array $ctx): array
{
    if (!bv_check_rate_ok($pdo, $ctx)) {
        return ['ok' => false, 'error' => 'rate_limited'];
    }
    if (preg_match('/^[A-Za-z0-9_-]{43}$/', $token) !== 1) {
        return ['ok' => false, 'error' => 'not_found'];
    }
    $st = $pdo->prepare('SELECT * FROM bv_attempts WHERE token = :t');
    $st->execute([':t' => $token]);
    $a = $st->fetch(PDO::FETCH_ASSOC);
    if (!$a) {
        return ['ok' => false, 'error' => 'not_found'];
    }
    $owner = $a['user_id'] !== null
        ? ($ctx['user_id'] !== null && (int) $a['user_id'] === (int) $ctx['user_id'])
        : (bv_session_hash($ctx['guest_key'] ?? ($_SESSION['bv_guest']['key'] ?? null)) === $a['session_hash']);
    if (!$owner) {
        return ['ok' => false, 'error' => 'forbidden'];
    }
    if (($a['scene_state_json'] ?? null) !== null) {
        return ['ok' => false, 'error' => 'bad_answer'];   // сцену здають лише через scene_finish: обхід «вибором відповіді» закрито
    }
    $mission = bv_mission((int) $a['mission_id']);
    $variant = $mission === null ? null
        : bv_build_variant($pdo, $mission, $a['variant_id'] !== null ? (int) $a['variant_id'] : null, $a['seed'], (string) $a['lang']);
    if ($variant === null) {
        return ['ok' => false, 'error' => 'not_found'];
    }
    $map = (array) json_decode((string) $a['opt_map_json'], true);
    $explain = (string) ($variant['explain']['text'] ?? '');
    $correctIds = array_map('strval', array_keys(array_filter($map, static fn($internal) => in_array($internal,
        array_map('strval', (array) ($variant['answer']['correct'] ?? [])), true))));

    if ((int) $a['used'] === 1) {   // повтор: та сама відповідь, без балів
        return ['ok' => true, 'repeat' => true, 'awarded' => false, 'correct' => (int) $a['score'] > 0, 'score' => (int) $a['score'],
            'stars' => (int) $a['stars'], 'explain' => $explain, 'correct_ids' => $correctIds];
    }
    $ttl = 60 * max(1, (int) bv_cfg('bugville_attempt_ttl_minutes'));
    if (strtotime($a['started_at'] . ' UTC') < time() - $ttl) {
        return ['ok' => false, 'error' => 'expired'];
    }
    $ok = bv_evaluate($variant['answer'], $given, $map);
    if ($ok === null) {
        return ['ok' => false, 'error' => 'bad_answer'];
    }
    $score = $ok ? 100 : 0;
    $stars = $ok ? bv_stars_for($pdo, $a) : 0;
    $upd = $pdo->prepare('UPDATE bv_attempts SET used = 1, finished_at = :f, score = :sc, stars = :stars WHERE id = :id AND used = 0');
    $upd->execute([':f' => bv_now(), ':sc' => $score, ':stars' => $stars, ':id' => (int) $a['id']]);
    $first = $upd->rowCount() === 1;

    return ['ok' => true, 'repeat' => !$first, 'awarded' => $first && $ok, 'correct' => $ok, 'score' => $score, 'stars' => $stars,
        'explain' => $explain, 'correct_ids' => $correctIds];
}

// ---------- Старт інтерактивної сцени (bv-scenes.php) ---------------------------------------------------------

/**
 * Нова спроба сцени: seed (не той, що в попередній спробі, і за можливості — небачений), токен, початковий стан.
 * Браузер отримує лише bv_scene_public(); правила й seed лишаються на сервері.
 */
function bv_scene_start(PDO $pdo, array $mission, array $ctx): array
{
    $mid = (int) $mission['id'];
    $gen = (string) $mission['scene_gen'];
    $seen = bv_seen($pdo, $mid, $ctx['user_id']);
    $last = bv_last_key($pdo, $mid, $ctx['user_id']);
    $seed = null;
    $rules = null;
    $key = '';
    for ($i = 0; $i < 12; $i++) {
        $seed = bin2hex(random_bytes(8));
        $rules = bv_scene_rules($gen, $seed, $mid);
        if ($rules === null) {
            return ['ok' => false, 'error' => 'no_variant'];
        }
        $key = 's:' . bv_fingerprint($rules);
        if (!isset($seen[$key]) && $key !== $last) {
            break;
        }
    }
    if ($key === $last) {
        return ['ok' => false, 'error' => 'no_variant'];
    }
    $token = bv_new_token();
    try {
        $pdo->prepare("INSERT INTO bv_attempts (token, user_id, session_hash, mission_id, variant_id, seed, variant_key, kind, lang,
                           opt_map_json, started_at, ip_hash, scene_state_json, act_count)
                       VALUES (:t, :u, :s, :m, NULL, :seed, :k, 'mission', :l, NULL, :at, :ip, :st, 0)")
            ->execute([':t' => $token, ':u' => $ctx['user_id'], ':s' => $ctx['user_id'] === null ? bv_session_hash($ctx['guest_key']) : null,
                ':m' => $mid, ':seed' => $seed, ':k' => $key, ':l' => $ctx['lang'], ':at' => bv_now(), ':ip' => bv_ip_hash((string) $ctx['ip']),
                ':st' => json_encode(bv_scene_initial_state($rules), JSON_UNESCAPED_UNICODE)]);
    } catch (PDOException $e) {
        error_log('[bugville] scene start failed (migration 38?): ' . $e->getCode());

        return ['ok' => false, 'error' => 'unavailable'];
    }
    bv_mark_seen($pdo, $mid, $ctx['user_id'], $key);
    if ($ctx['user_id'] === null) {
        $_SESSION['bv_guest']['tokens'][] = $token;
    }

    return ['ok' => true, 'token' => $token, 'scene' => bv_scene_public($rules)];
}

// ---------- Прибирання гостьових спроб (перший із двох DELETE гри) ---------------------------------------------

/** Видаляє гостьові незараховані спроби, старші за bugville_guest_attempt_keep_hours (не менше 24). Повертає кількість. */
function bv_cleanup_guest_attempts(PDO $pdo): int
{
    $hours = max(24, (int) bv_cfg('bugville_guest_attempt_keep_hours'));
    $st = $pdo->prepare('DELETE FROM bv_attempts WHERE user_id IS NULL AND credited = 0 AND started_at < :t');
    $st->execute([':t' => bv_now(-3600 * $hours)]);

    return $st->rowCount();
}
