<?php

declare(strict_types=1);

/**
 * Багвіль — гра в інтерактивну сцену через API (scene_act / scene_finish). Правила сцени — app/bugville/bv-scenes.php.
 *
 * scene_act:    сира дія гравця (op + input) → реакція автомата від сервера; стан — у bv_attempts.scene_state_json.
 *               Оптимістичне блокування: UPDATE … WHERE act_count = :old AND used = 0 (дві паралельні дії не загублять
 *               одна одну й не подвоять знахідку). Не більше bugville_scene_max_actions дій, ввід ≤ bugville_scene_max_input.
 * scene_finish: «Здати роботу» — сервер рахує знайдені поломки ЗІ СВОГО стану (клієнт нічого не повідомляє), і лише
 *               при found ≥ min_found закриває токен (UPDATE … SET used = 1 WHERE … used = 0, перевірка rowCount) та
 *               нараховує нагороду тими самими правилами, що й check (bv_reward_checked).
 */

require_once __DIR__ . '/bv-player.php';

const BV_SCENE_OPS = ['buy', 'claim', 'refill', 'submit', 'check', 'report'];

/** Ліміт дій у сцені: гравець / сесія і IP (окремо від лімітів перевірок — дій у сцені набагато більше). */
function bv_scene_rate_ok(PDO $pdo, array $ctx): bool
{
    $who = $ctx['user_id'] !== null ? 'u:' . $ctx['user_id'] : 'g:' . (string) bv_session_hash($ctx['guest_key']);
    if (!bv_rate_hit($pdo, 'bv_act_p', $who, (int) (bv_cfg('bugville_acts_per_min_player') ?? 120))) {
        return false;
    }
    $ipHash = bv_ip_hash((string) $ctx['ip']);

    return $ipHash === null || bv_rate_hit($pdo, 'bv_act_ip', $ipHash, (int) (bv_cfg('bugville_acts_per_min_ip') ?? 2400));
}

/**
 * Спроба сцени за токеном із перевіркою власника. @return array{0: ?array, 1: ?array, 2: ?array, 3: ?string}
 *   [рядок bv_attempts, місія, правила, помилка]
 */
function bv_scene_load(PDO $pdo, string $token, array $ctx): array
{
    if (preg_match('/^[A-Za-z0-9_-]{43}$/', $token) !== 1) {
        return [null, null, null, 'not_found'];
    }
    $st = $pdo->prepare('SELECT * FROM bv_attempts WHERE token = :t');
    $st->execute([':t' => $token]);
    $a = $st->fetch(PDO::FETCH_ASSOC);
    if (!$a || ($a['scene_state_json'] ?? null) === null) {
        return [null, null, null, 'not_found'];
    }
    $owner = $a['user_id'] !== null
        ? ($ctx['user_id'] !== null && (int) $a['user_id'] === (int) $ctx['user_id'])
        : (bv_session_hash($ctx['guest_key'] ?? ($_SESSION['bv_guest']['key'] ?? null)) === $a['session_hash']);
    if (!$owner) {
        return [null, null, null, 'forbidden'];
    }
    $mission = bv_mission((int) $a['mission_id']);
    $rules = $mission === null ? null : bv_scene_rules((string) ($mission['scene_gen'] ?? ''), (string) $a['seed'], (int) $a['mission_id']);
    if ($rules === null) {
        return [null, null, null, 'not_found'];
    }

    return [$a, $mission, $rules, null];
}

function bv_scene_expired(array $a): bool
{
    return strtotime($a['started_at'] . ' UTC') < time() - 60 * max(1, (int) bv_cfg('bugville_attempt_ttl_minutes'));
}

/** Очищення сирого вводу: лише друковані символи, без керівних; довжина — у символах. null — задовгий. */
function bv_scene_clean_input(mixed $input): ?string
{
    if ($input === null) {
        return '';
    }
    if (!is_string($input) && !is_int($input)) {
        return null;
    }
    $s = (string) $input;
    if (!mb_check_encoding($s, 'UTF-8')) {
        return null;
    }
    $s = (string) preg_replace('/[\x00-\x1F\x7F\x{200B}-\x{200F}\x{2028}-\x{202E}]/u', '', $s);

    return mb_strlen($s) > bv_scene_max_input() ? null : $s;
}

/**
 * Одна дія гравця. @return array{ok:bool, error?:string, reaction?:array, found?:int, total?:int, min_found?:int,
 *                                can_submit?:bool, acts_left?:int}
 */
function bv_scene_act(PDO $pdo, string $token, string $op, mixed $input, array $ctx): array
{
    if (!in_array($op, BV_SCENE_OPS, true)) {
        return ['ok' => false, 'error' => 'bad_request'];
    }
    $clean = is_array($input) ? null : bv_scene_clean_input($input);   // бланк (масив) чиститься після завантаження правил
    if ($clean === null && !is_array($input)) {
        return ['ok' => false, 'error' => 'too_long'];
    }
    if (!bv_scene_rate_ok($pdo, $ctx)) {
        return ['ok' => false, 'error' => 'rate_limited'];
    }
    [$a, , $rules, $err] = bv_scene_load($pdo, $token, $ctx);
    if ($err !== null) {
        return ['ok' => false, 'error' => $err];
    }
    if ((int) $a['used'] === 1) {
        return ['ok' => false, 'error' => 'already_checked'];
    }
    if (bv_scene_expired($a)) {
        return ['ok' => false, 'error' => 'expired'];
    }
    $count = (int) $a['act_count'];
    if ($count >= bv_scene_max_actions()) {
        return ['ok' => false, 'error' => 'too_many_actions'];
    }
    $state = (array) json_decode((string) $a['scene_state_json'], true) + bv_scene_initial_state($rules);
    if ($rules['type'] === 'form_scene') {
        $values = bv_form_clean($rules, is_array($input) ? $input : []);
        if ($values === null || !is_array($input)) {
            return ['ok' => false, 'error' => 'too_long'];
        }
        [$react, $state] = bv_scene_form_act($rules, $state, $op, $values);
    } elseif ($rules['type'] === 'table_scene') {
        $in = bv_table_clean($rules, $op, is_array($input) ? $input : null);
        if ($in === null) {
            return ['ok' => false, 'error' => 'too_long'];
        }
        [$react, $state] = bv_scene_table_act($rules, $state, $op, $in);
    } elseif ($clean === null) {
        return ['ok' => false, 'error' => 'too_long'];
    } else {
        [$react, $state] = bv_scene_machine_act($rules, $state, $op, $clean);
    }
    $upd = $pdo->prepare('UPDATE bv_attempts SET scene_state_json = :s, act_count = act_count + 1
                          WHERE id = :id AND used = 0 AND act_count = :old');
    $upd->execute([':s' => json_encode($state, JSON_UNESCAPED_UNICODE), ':id' => (int) $a['id'], ':old' => $count]);
    if ($upd->rowCount() !== 1) {
        return ['ok' => false, 'error' => 'conflict'];   // паралельна дія або токен щойно закрито — клієнт повторить
    }
    $sum = bv_scene_summary($rules, $state);

    return ['ok' => true, 'reaction' => $react, 'found' => $sum['found'], 'total' => $sum['total'], 'min_found' => $sum['min_found'],
        'can_submit' => $sum['found'] >= $sum['min_found'], 'acts_left' => bv_scene_max_actions() - $count - 1];
}

/** Розбір після здачі: що знайдено і скільки лишилося (самі незнайдені поломки не розкриваються — для повтору). */
function bv_scene_explain(array $sum, string $type = 'input_machine'): string
{
    $where = ['form_scene' => 'у бланку пошти', 'table_scene' => 'у таблиці бібліотеки'][$type] ?? 'в автоматі';
    $t = "Знайдено поломок: {$sum['found']} з {$sum['total']}.";
    if ($sum['missing'] > 0) {
        $t .= ' Ще ' . $sum['missing'] . ' ' . ($sum['missing'] === 1 ? 'ховається' : 'ховаються') . ' ' . $where . ' — їх можна пошукати під час повтору.';
    } else {
        $t .= ' Усі знайдено!';
    }
    if ($sum['useless'] > 0) {
        $t .= $type === 'table_scene'
            ? " Хибних позначок і звітів, які майстер не прийняв: {$sum['useless']}."
            : " Перевірок, де автомат працював правильно, а ви сказали «поломка»: {$sum['useless']}.";
    }

    if ($type === 'table_scene') {
        return $t . ' Таблиця має бути чесною: справжні дати, без двійників і порожніх клітинок, кожне значення у своєму стовпці. Звіт — «очікувано» і «фактично».';
    }

    return $t . ($type === 'form_scene' ? ' Форма має зупиняти те, що не можна прийняти: порожнє, задовге, неправильне чи повторне.'
        : ' Помилки люблять жити на межах: найменше, найбільше і на крок за ними.');
}

/**
 * «Здати роботу майстру». Знайдене рахує сервер. Повтор того самого токена — підсумок без нагороди.
 * @return array{ok:bool, error?:string, ...}
 */
function bv_scene_finish(PDO $pdo, string $token, array $ctx): array
{
    if (!bv_check_rate_ok($pdo, $ctx)) {
        return ['ok' => false, 'error' => 'rate_limited'];
    }
    [$a, , $rules, $err] = bv_scene_load($pdo, $token, $ctx);
    if ($err !== null) {
        return ['ok' => false, 'error' => $err];
    }
    $state = (array) json_decode((string) $a['scene_state_json'], true) + bv_scene_initial_state($rules);
    $sum = bv_scene_summary($rules, $state);
    $found = array_map(static fn(string $b) => bv_scene_bug_card($rules, $b)['title'], array_values(array_intersect($state['f'], $rules['bugs'])));
    if ((int) $a['used'] === 1) {
        return ['ok' => true, 'repeat' => true, 'awarded' => false, 'correct' => true, 'score' => (int) $a['score'], 'stars' => (int) $a['stars'],
            'summary' => $sum, 'explain' => bv_scene_explain($sum, (string) $rules['type']), 'saved' => $a['user_id'] !== null];
    }
    if (bv_scene_expired($a)) {
        return ['ok' => false, 'error' => 'expired'];
    }
    if ($sum['found'] < $sum['min_found']) {
        return ['ok' => false, 'error' => 'not_enough', 'found' => $sum['found'], 'min_found' => $sum['min_found']];
    }
    $score = (int) round(100 * $sum['found'] / max(1, $sum['total']));
    $stars = bv_stars_for($pdo, $a);
    $upd = $pdo->prepare('UPDATE bv_attempts SET used = 1, finished_at = :f, score = :sc, stars = :stars WHERE id = :id AND used = 0');
    $upd->execute([':f' => bv_now(), ':sc' => $score, ':stars' => $stars, ':id' => (int) $a['id']]);
    if ($upd->rowCount() !== 1) {   // паралельне «Здати» встигло першим
        return ['ok' => true, 'repeat' => true, 'awarded' => false, 'correct' => true, 'score' => $score, 'stars' => $stars,
            'summary' => $sum, 'explain' => bv_scene_explain($sum, (string) $rules['type']), 'saved' => $a['user_id'] !== null];
    }
    $r = ['ok' => true, 'repeat' => false, 'correct' => true, 'score' => $score, 'stars' => $stars, 'summary' => $sum,
        'found_titles' => $found, 'hint_used' => (int) $a['hint_used'] === 1, 'explain' => bv_scene_explain($sum, (string) $rules['type'])];

    return bv_reward_checked($pdo, $token, $r, $ctx);
}
