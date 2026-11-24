<?php

declare(strict_types=1);

/**
 * Багвіль — іспити рівнів (крок 4 плану; MAIN_TASK, розділи 5–6).
 *
 * Іспит рівня L має id 9000 + L; це рядок bv_attempts (kind = 'exam', mission_id = id іспиту, один токен на весь іспит),
 * а його завдання — bv_exam_tasks (варіанти місій із пулу bv_exam_items). Лише для акаунтів із підтвердженим віком.
 * Пул: активні завдання з місіями, в які можна грати; сума ваг ≥ 3 × bugville_exam_tasks, інакше іспит вимкнено.
 * Повтор — не раніше ніж через bugville_exam_retry_minutes після завершеної спроби; незавершений іспит продовжується
 * (ті самі завдання), тож «перекинути» завдання перезапуском не вийде.
 * Нагорода (bugville_exam_xp / _coins) і грамота — лише за перше складання іспиту (bugville_exam_pass_percent).
 * Відповіді й розбори — лише після завершення; браузер отримує лише сцени з одноразовими id.
 */

require_once __DIR__ . '/bv-player.php';
require_once __DIR__ . '/bv-world.php';

const BV_EXAM_BASE = 9000;

function bv_exam_id(int $level): int
{
    return BV_EXAM_BASE + $level;
}

/** Рівень іспиту зі світу (['id','title',…]) або null. Тести можуть додати іспит через $GLOBALS['bv_exam_extra']. */
function bv_exam_level(int $examId): ?array
{
    if (isset($GLOBALS['bv_exam_extra'][$examId])) {
        return $GLOBALS['bv_exam_extra'][$examId];
    }
    foreach (bv_world() as $ch) {
        foreach ($ch['levels'] as $lv) {
            if (bv_exam_id((int) $lv['id']) === $examId) {
                return $lv;
            }
        }
    }

    return null;
}

function bv_exam_tasks_count(): int
{
    return max(1, (int) (bv_cfg('bugville_exam_tasks') ?: 5));
}

/**
 * Пул іспиту: активні завдання з місіями, в які можна грати (template_key — пізніше).
 * @return array{items: list<array{mission_id:int, weight:int}>, weight:int, need:int, ok:bool}
 */
function bv_exam_pool(PDO $pdo, int $examId, string $lang = 'uk'): array
{
    $items = [];
    try {
        $st = $pdo->prepare("SELECT mission_id, weight FROM bv_exam_items WHERE exam_id = :e AND status = 'active'
                             AND mission_id IS NOT NULL AND lang IN (:l, 'uk') ORDER BY id");
        $st->execute([':e' => $examId, ':l' => bv_lang($lang)]);
        foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $r) {
            if (bv_mission((int) $r['mission_id']) !== null && (int) $r['weight'] > 0) {
                $items[] = ['mission_id' => (int) $r['mission_id'], 'weight' => (int) $r['weight']];
            }
        }
    } catch (Throwable) {
        $items = [];
    }
    $weight = array_sum(array_column($items, 'weight'));
    $need = 3 * bv_exam_tasks_count();

    return ['items' => $items, 'weight' => $weight, 'need' => $need, 'ok' => $items !== [] && $weight >= $need];
}

/** Зважений вибір місій для завдань; та сама місія двічі поспіль — лише коли інших немає. @return list<int> */
function bv_exam_pick_missions(array $items, int $count): array
{
    $out = [];
    $total = array_sum(array_column($items, 'weight'));
    for ($i = 0; $i < $count; $i++) {
        $pool = $items;
        if ($out !== [] && count(array_unique(array_column($items, 'mission_id'))) > 1) {
            $prev = end($out);
            $pool = array_values(array_filter($items, static fn($it) => $it['mission_id'] !== $prev));
        }
        $sum = array_sum(array_column($pool, 'weight'));
        $r = random_int(1, max(1, $sum ?: $total));
        foreach ($pool as $it) {
            $r -= $it['weight'];
            if ($r <= 0) {
                $out[] = $it['mission_id'];
                break;
            }
        }
    }

    return $out;
}

/**
 * Сцена завдання з карти одноразових id (у порядку варіантів payload) — детерміновано від $seed (токен + номер),
 * тож продовження іспиту показує ті самі завдання в тому самому порядку.
 */
function bv_exam_scene(array $payload, array $map, string $seed): array
{
    $rng = new BvRng($seed);
    $textOf = [];
    foreach ((array) ($payload['options'] ?? []) as $o) {
        $textOf[(string) $o['id']] = (string) ($o['text'] ?? '');
    }
    $options = [];
    foreach ($map as $pub => $internal) {
        $options[] = ['id' => (string) $pub, 'text' => $textOf[(string) $internal] ?? ''];
    }
    if (empty($payload['keep_order'])) {
        $options = $rng->shuffle($options);
    }
    $items = array_map(static fn($it) => ['text' => (string) ($it['text'] ?? '')], (array) ($payload['items'] ?? []));
    if (!empty($payload['shuffle_items'])) {
        $items = $rng->shuffle($items);
    }
    $scene = ['text' => (string) ($payload['text'] ?? ''), 'question' => (string) ($payload['question'] ?? '')];
    if ($items !== []) {
        $scene['items'] = $items;
    }
    if ($options !== []) {
        $scene['options'] = $options;
    }
    if (isset($payload['input'])) {
        $scene['input'] = (string) $payload['input'];
    }

    return $scene;
}

/** Нова карта одноразових id для варіантів payload. @return array<string,string> */
function bv_exam_new_map(array $payload): array
{
    $map = [];
    foreach ((array) ($payload['options'] ?? []) as $o) {
        do {
            $pub = 'k' . bin2hex(random_bytes(3));
        } while (isset($map[$pub]));
        $map[$pub] = (string) $o['id'];
    }

    return $map;
}

/** Чи вже складено іспит (була нагорода source = 'exam'). */
function bv_exam_passed(PDO $pdo, int $userId, int $examId): bool
{
    $st = $pdo->prepare("SELECT COUNT(*) FROM bv_xp_log WHERE user_id = :u AND mission_id = :e AND source = 'exam'");
    $st->execute([':u' => $userId, ':e' => $examId]);

    return (int) $st->fetchColumn() > 0;
}

/** Код грамоти акаунта за іспит або null. */
function bv_exam_certificate_code(PDO $pdo, int $userId, int $examId): ?string
{
    $st = $pdo->prepare('SELECT code FROM bv_certificates WHERE user_id = :u AND exam_id = :e');
    $st->execute([':u' => $userId, ':e' => $examId]);
    $c = $st->fetchColumn();

    return $c === false ? null : (string) $c;
}

/** Незавершена спроба іспиту в межах строку дії або null. */
function bv_exam_open_attempt(PDO $pdo, int $userId, int $examId): ?array
{
    $ttl = 60 * max(1, (int) bv_cfg('bugville_attempt_ttl_minutes'));
    $st = $pdo->prepare("SELECT * FROM bv_attempts WHERE user_id = :u AND mission_id = :e AND kind = 'exam' AND used = 0
                         AND started_at >= :t ORDER BY id DESC LIMIT 1");
    $st->execute([':u' => $userId, ':e' => $examId, ':t' => bv_now(-$ttl)]);
    $a = $st->fetch(PDO::FETCH_ASSOC);

    return $a ?: null;
}

/** Коли можна знову (UTC 'Y-m-d H:i:s') або null — після завершеної спроби минуло менше bugville_exam_retry_minutes. */
function bv_exam_retry_at(PDO $pdo, int $userId, int $examId): ?string
{
    $st = $pdo->prepare("SELECT finished_at FROM bv_attempts WHERE user_id = :u AND mission_id = :e AND kind = 'exam' AND used = 1
                         ORDER BY id DESC LIMIT 1");
    $st->execute([':u' => $userId, ':e' => $examId]);
    $f = $st->fetchColumn();
    if ($f === false || $f === null) {
        return null;
    }
    $at = strtotime($f . ' UTC') + 60 * max(0, (int) bv_cfg('bugville_exam_retry_minutes'));

    return $at > time() ? gmdate('Y-m-d H:i:s', $at) : null;
}

/** Стан іспиту для сторінки: доступність пулу, складено, грамота, повтор, незавершена спроба. */
function bv_exam_status(PDO $pdo, ?int $userId, int $examId): array
{
    $pool = bv_exam_pool($pdo, $examId);
    $s = ['exam' => $examId, 'enabled' => $pool['ok'], 'tasks' => bv_exam_tasks_count(),
        'pass_percent' => (int) bv_cfg('bugville_exam_pass_percent'), 'passed' => false, 'certificate' => null,
        'retry_at' => null, 'open' => false];
    if ($userId !== null) {
        $s['passed'] = bv_exam_passed($pdo, $userId, $examId);
        $s['certificate'] = bv_exam_certificate_code($pdo, $userId, $examId);
        $s['retry_at'] = bv_exam_retry_at($pdo, $userId, $examId);
        $s['open'] = bv_exam_open_attempt($pdo, $userId, $examId) !== null;
    }

    return $s;
}

/** Завдання спроби для браузера: [{n, scene, answered}]. */
function bv_exam_public_tasks(PDO $pdo, array $attempt): array
{
    $st = $pdo->prepare('SELECT * FROM bv_exam_tasks WHERE attempt_id = :a ORDER BY n');
    $st->execute([':a' => (int) $attempt['id']]);
    $out = [];
    foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $t) {
        $mission = bv_mission((int) $t['mission_id']);
        $v = $mission === null ? null
            : bv_build_variant($pdo, $mission, $t['variant_id'] !== null ? (int) $t['variant_id'] : null, $t['seed'], (string) $attempt['lang']);
        if ($v === null) {
            continue;
        }
        $map = (array) json_decode((string) $t['opt_map_json'], true);
        $out[] = ['n' => (int) $t['n'], 'scene' => bv_exam_scene($v['payload'], $map, $attempt['token'] . '|' . $t['n']),
            'answered' => (int) $t['answered'] === 1];
    }

    return $out;
}

/** Власник спроби іспиту (лише акаунт). */
function bv_exam_load(PDO $pdo, string $token, array $ctx): array
{
    if ($ctx['user_id'] === null) {
        return ['ok' => false, 'error' => 'auth_required'];
    }
    if (preg_match('/^[A-Za-z0-9_-]{43}$/', $token) !== 1) {
        return ['ok' => false, 'error' => 'not_found'];
    }
    $st = $pdo->prepare("SELECT * FROM bv_attempts WHERE token = :t AND kind = 'exam'");
    $st->execute([':t' => $token]);
    $a = $st->fetch(PDO::FETCH_ASSOC);
    if (!$a || (int) $a['user_id'] !== (int) $ctx['user_id']) {
        return ['ok' => false, 'error' => 'not_found'];
    }

    return ['ok' => true, 'attempt' => $a];
}

/**
 * Початок (або продовження) іспиту. @return array{ok:bool, error?:string, token?:string, tasks?:array, retry_at?:string,
 * resumed?:bool}
 */
function bv_exam_start(PDO $pdo, int $examId, array $ctx): array
{
    if ($ctx['user_id'] === null) {
        return ['ok' => false, 'error' => 'auth_required'];
    }
    $uid = (int) $ctx['user_id'];
    if (bv_exam_level($examId) === null) {
        return ['ok' => false, 'error' => 'not_found'];
    }
    $open = bv_exam_open_attempt($pdo, $uid, $examId);
    if ($open !== null) {
        return ['ok' => true, 'resumed' => true, 'token' => $open['token'], 'tasks' => bv_exam_public_tasks($pdo, $open)];
    }
    $pool = bv_exam_pool($pdo, $examId, (string) $ctx['lang']);
    if (!$pool['ok']) {
        return ['ok' => false, 'error' => 'exam_unavailable'];
    }
    $retry = bv_exam_retry_at($pdo, $uid, $examId);
    if ($retry !== null) {
        return ['ok' => false, 'error' => 'cooldown', 'retry_at' => $retry];
    }
    $ipHash = bv_ip_hash((string) $ctx['ip']);
    if (!bv_rate_hit($pdo, 'bv_start_p', 'u:' . $uid, (int) bv_cfg('bugville_starts_per_min_player'))
        || ($ipHash !== null && !bv_rate_hit($pdo, 'bv_start_ip', $ipHash, (int) bv_cfg('bugville_starts_per_min_ip')))) {
        return ['ok' => false, 'error' => 'rate_limited'];
    }

    $tasks = [];
    foreach (bv_exam_pick_missions($pool['items'], bv_exam_tasks_count()) as $i => $mid) {
        $mission = bv_mission($mid);
        $picked = $mission === null ? null : bv_pick_variant($pdo, $mission, $uid, (string) $ctx['lang']);
        if ($picked === null) {
            return ['ok' => false, 'error' => 'exam_unavailable'];
        }
        $tasks[] = ['n' => $i + 1, 'mission_id' => $mid, 'picked' => $picked, 'map' => bv_exam_new_map($picked['variant']['payload'])];
    }

    $token = bv_new_token();
    $pdo->beginTransaction();
    try {
        $pdo->prepare("INSERT INTO bv_attempts (token, user_id, session_hash, mission_id, variant_id, seed, variant_key, kind, lang,
                           opt_map_json, started_at, ip_hash) VALUES (:t, :u, NULL, :e, NULL, NULL, 'exam', 'exam', :l, NULL, :at, :ip)")
            ->execute([':t' => $token, ':u' => $uid, ':e' => $examId, ':l' => $ctx['lang'], ':at' => bv_now(), ':ip' => $ipHash]);
        $attemptId = (int) $pdo->lastInsertId();
        $ins = $pdo->prepare('INSERT INTO bv_exam_tasks (attempt_id, user_id, n, mission_id, variant_id, seed, variant_key, opt_map_json)
                              VALUES (:a, :u, :n, :m, :v, :s, :k, :map)');
        foreach ($tasks as $t) {
            $ins->execute([':a' => $attemptId, ':u' => $uid, ':n' => $t['n'], ':m' => $t['mission_id'], ':v' => $t['picked']['variant_id'],
                ':s' => $t['picked']['seed'], ':k' => $t['picked']['variant']['key'], ':map' => json_encode($t['map'])]);
        }
        $pdo->commit();
    } catch (Throwable $e) {
        $pdo->rollBack();
        throw $e;
    }
    $st = $pdo->prepare('SELECT * FROM bv_attempts WHERE id = :id');
    $st->execute([':id' => $attemptId]);

    return ['ok' => true, 'resumed' => false, 'token' => $token, 'tasks' => bv_exam_public_tasks($pdo, (array) $st->fetch(PDO::FETCH_ASSOC))];
}

/** Відповідь на n-те завдання: приймається один раз, до завершення й у межах строку. Правильність не повертається. */
function bv_exam_answer(PDO $pdo, string $token, int $n, mixed $given, array $ctx): array
{
    if (!bv_check_rate_ok($pdo, $ctx)) {
        return ['ok' => false, 'error' => 'rate_limited'];
    }
    $l = bv_exam_load($pdo, $token, $ctx);
    if (!$l['ok']) {
        return $l;
    }
    $a = $l['attempt'];
    if ((int) $a['used'] === 1) {
        return ['ok' => false, 'error' => 'already_finished'];
    }
    $ttl = 60 * max(1, (int) bv_cfg('bugville_attempt_ttl_minutes'));
    if (strtotime($a['started_at'] . ' UTC') < time() - $ttl) {
        return ['ok' => false, 'error' => 'expired'];
    }
    $st = $pdo->prepare('SELECT * FROM bv_exam_tasks WHERE attempt_id = :a AND n = :n');
    $st->execute([':a' => (int) $a['id'], ':n' => $n]);
    $t = $st->fetch(PDO::FETCH_ASSOC);
    if (!$t) {
        return ['ok' => false, 'error' => 'not_found'];
    }
    if ((int) $t['answered'] === 1) {
        return ['ok' => false, 'error' => 'already_answered'];
    }
    $mission = bv_mission((int) $t['mission_id']);
    $v = $mission === null ? null
        : bv_build_variant($pdo, $mission, $t['variant_id'] !== null ? (int) $t['variant_id'] : null, $t['seed'], (string) $a['lang']);
    if ($v === null) {
        return ['ok' => false, 'error' => 'not_found'];
    }
    $ok = bv_evaluate($v['answer'], $given, (array) json_decode((string) $t['opt_map_json'], true));
    if ($ok === null) {
        return ['ok' => false, 'error' => 'bad_answer'];
    }
    $upd = $pdo->prepare('UPDATE bv_exam_tasks SET answered = 1, correct = :c, answered_at = :t WHERE id = :id AND answered = 0');
    $upd->execute([':c' => $ok ? 1 : 0, ':t' => bv_now(), ':id' => (int) $t['id']]);
    if ($upd->rowCount() !== 1) {
        return ['ok' => false, 'error' => 'already_answered'];
    }

    return ['ok' => true, 'n' => $n, 'answered' => true];
}

/**
 * Завершення іспиту: бал = частка правильних (без відповіді — неправильно), складено ≥ bugville_exam_pass_percent.
 * Атомарно (used 0 → 1); повторний виклик — той самий підсумок без нагороди. Нагорода й грамота — за перше складання.
 */
function bv_exam_finish(PDO $pdo, string $token, array $ctx): array
{
    $l = bv_exam_load($pdo, $token, $ctx);
    if (!$l['ok']) {
        return $l;
    }
    $a = $l['attempt'];
    $uid = (int) $ctx['user_id'];
    $examId = (int) $a['mission_id'];
    $st = $pdo->prepare('SELECT * FROM bv_exam_tasks WHERE attempt_id = :a ORDER BY n');
    $st->execute([':a' => (int) $a['id']]);
    $tasks = $st->fetchAll(PDO::FETCH_ASSOC);
    $total = max(1, count($tasks));
    $right = count(array_filter($tasks, static fn($t) => (int) $t['correct'] === 1));
    $score = (int) round(100 * $right / $total);
    $passed = $score >= (int) bv_cfg('bugville_exam_pass_percent');

    $first = false;
    if ((int) $a['used'] === 0) {
        $upd = $pdo->prepare('UPDATE bv_attempts SET used = 1, finished_at = :f, score = :s, stars = 0 WHERE id = :id AND used = 0');
        $upd->execute([':f' => bv_now(), ':s' => $score, ':id' => (int) $a['id']]);
        $first = $upd->rowCount() === 1;
    } else {
        $score = (int) $a['score'];
        $passed = $score >= (int) bv_cfg('bugville_exam_pass_percent');
    }

    $earned = ['xp' => 0, 'stars' => 0, 'coins' => 0];
    if ($first && $passed && !bv_exam_passed($pdo, $uid, $examId)) {
        $xp = (int) bv_cfg('bugville_exam_xp');
        $coins = (int) bv_cfg('bugville_exam_coins');
        $ins = $pdo->prepare("INSERT IGNORE INTO bv_xp_log (user_id, attempt_id, mission_id, xp, stars, coins, source, created_at)
                              VALUES (:u, :a, :e, :xp, 0, :c, 'exam', :t)");
        $ins->execute([':u' => $uid, ':a' => (int) $a['id'], ':e' => $examId, ':xp' => $xp, ':c' => $coins, ':t' => bv_now()]);
        if ($ins->rowCount() === 1) {
            $earned = ['xp' => $xp, 'stars' => 0, 'coins' => $coins];
            $pdo->prepare('INSERT IGNORE INTO bv_certificates (user_id, exam_id, attempt_id, code, score, lang, created_at)
                           VALUES (:u, :e, :a, :c, :s, :l, :t)')
                ->execute([':u' => $uid, ':e' => $examId, ':a' => (int) $a['id'], ':c' => strtoupper(bin2hex(random_bytes(10))),
                    ':s' => $score, ':l' => $a['lang'], ':t' => bv_now()]);
        }
    }

    $results = [];
    foreach ($tasks as $t) {
        $mission = bv_mission((int) $t['mission_id']);
        $v = $mission === null ? null
            : bv_build_variant($pdo, $mission, $t['variant_id'] !== null ? (int) $t['variant_id'] : null, $t['seed'], (string) $a['lang']);
        $map = (array) json_decode((string) $t['opt_map_json'], true);
        $correctIds = $v === null ? [] : array_map('strval', array_keys(array_filter($map, static fn($internal) => in_array($internal,
            array_map('strval', (array) ($v['answer']['correct'] ?? [])), true))));
        $results[] = ['n' => (int) $t['n'], 'answered' => (int) $t['answered'] === 1, 'correct' => (int) $t['correct'] === 1,
            'correct_ids' => $correctIds, 'explain' => (string) ($v['explain']['text'] ?? '')];
    }

    return ['ok' => true, 'repeat' => !$first, 'score' => $score, 'passed' => $passed, 'right' => $right, 'total' => count($tasks),
        'earned' => $earned, 'certificate' => bv_exam_certificate_code($pdo, $uid, $examId), 'results' => $results,
        'retry_at' => bv_exam_retry_at($pdo, $uid, $examId)];
}
