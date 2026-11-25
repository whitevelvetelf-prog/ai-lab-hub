<?php

declare(strict_types=1);

/**
 * AI LAB HUB — API гри «Багвіль» (крок 2 плану). Лише POST, тіло JSON, відповідь JSON.
 * Захист: запит лише з нашого сайту (csrf_same_origin) + токен сесії (заголовок X-CSRF-Token або поле csrf).
 *
 * Дії (поле action):
 *   state        — хто грає (гість / акаунт 16+), мінімальний вік, підсумки акаунта; зарахування сеансу, якщо щойно ввійшли.
 *   start        — {mission} → {token, scene}: лише сцена, без відповіді й параметрів поломки.
 *                  {daily: true} → «Поломка дня»: сцена дня (однакова для всіх), {daily: {day, title, done}}.
 *   hint         — {token} → підказка (безкоштовна, лише знижує зірки: максимум 2).
 *   check        — {token, answer} → результат, розбір побаченого варіанта; акаунт → earned + saved, гість → would_earn.
 *   scene_act    — {token, op: buy|claim|refill, input ≤ 30} → реакція сцени від сервера (інтерактивні місії Розділу 1).
 *   scene_finish — {token} → «Здати роботу»: знайдене рахує сервер зі свого стану; ≥ min_found — зірки й нагорода.
 *   word_quiz    — {word} → вправа «Що означає…?» (4 варіанти, правильний лише в сесії); лише акаунт 16+.
 *   word_check   — {word, option} → правильно / ні, «вивчено» й нові значки; вправа одноразова.
 *   ws_buy       — {item} → купити предмет Майстерні за монети гри (лише акаунт 16+); баланс рахує сервер.
 *   ws_equip     — {kind: frame|sticker|background, item: ключ або ''} → вдягнути куплене / зняти.
 *   ws_avatar    — {avatar} → аватар із набору (безкоштовно).
 *   confirm_age  — {confirm: true} для того, хто ввійшов: «мені виповнилося N років» → зарахування гостьового сеансу.
 *   exam_state   — {exam} → доступність, складено, грамота, повтор (для всіх).
 *   exam_start   — {exam} → {token, tasks: [{n, scene, answered}]}; незавершений іспит продовжується (лише акаунт 16+).
 *   exam_answer  — {token, n, answer} → прийнято (правильність — лише в підсумку).
 *   exam_finish  — {token} → бал, складено, розбори, нагорода й грамота за перше складання.
 * Помилки: 400 bad_request / bad_answer, 401 auth_required, 403 cross_site / csrf, 404 not_found, 405, 410 expired,
 *          429 rate_limited, 503 unavailable (таблиці гри не створено).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/csrf.php';
require_once __DIR__ . '/../app/bugville/bv-player.php';
require_once __DIR__ . '/../app/bugville/bv-missions.php';
require_once __DIR__ . '/../app/bugville/bv-exam.php';
require_once __DIR__ . '/../app/bugville/bv-progress.php';
require_once __DIR__ . '/../app/bugville/bv-scene-play.php';
require_once __DIR__ . '/../app/bugville/bv-words.php';
require_once __DIR__ . '/../app/bugville/bv-workshop.php';

header('Content-Type: application/json; charset=utf-8');
header('X-Content-Type-Options: nosniff');
header('Cache-Control: no-store');
header('X-Robots-Tag: noindex');

function bv_api_out(array $payload, int $status = 200): never
{
    http_response_code($status);
    echo json_encode($payload, JSON_UNESCAPED_UNICODE);
    exit;
}

if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST') {
    header('Allow: POST');
    bv_api_out(['ok' => false, 'error' => 'method_not_allowed'], 405);
}
if (!csrf_same_origin()) {
    bv_api_out(['ok' => false, 'error' => 'cross_site'], 403);
}
$raw = (string) file_get_contents('php://input');
$in = json_decode($raw, true);
if (!is_array($in)) {
    $in = $_POST;
}
$sentCsrf = (string) ($_SERVER['HTTP_X_CSRF_TOKEN'] ?? ($in['csrf'] ?? ''));
if ($sentCsrf === '' || !hash_equals(csrf_token(), $sentCsrf)) {
    bv_api_out(['ok' => false, 'error' => 'csrf'], 403);
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
try {
    $pdo->query('SELECT 1 FROM bv_attempts LIMIT 0');
} catch (Throwable) {
    bv_api_out(['ok' => false, 'error' => 'unavailable'], 503);
}
bv_load_missions($pdo);

$account = auth_check() ? auth_current_user($pdo) : null;
$accountId = $account !== null ? (int) $account['id'] : null;
$action = (string) ($in['action'] ?? '');

if ($action === 'confirm_age') {
    if ($accountId === null) {
        bv_api_out(['ok' => false, 'error' => 'auth_required'], 401);
    }
    if (($in['confirm'] ?? null) !== true) {
        bv_api_out(['ok' => false, 'error' => 'bad_request'], 400);
    }
    bv_confirm_age($pdo, $accountId);
}

$ctx = bv_request_ctx($pdo, $accountId, (string) ($in['lang'] ?? 'uk'));
$credited = $ctx['user_id'] !== null ? bv_credit_guest_session($pdo, (int) $ctx['user_id']) : null;
$who = ['guest' => $ctx['user_id'] === null, 'logged_in' => $accountId !== null,
    'age_confirmed' => $ctx['user_id'] !== null, 'min_age' => bv_min_age()];
if ($credited !== null && ($credited['credited'] > 0 || $credited['skipped'] > 0)) {
    $who['credited'] = $credited;
}

/**
 * Звання, нові значки й серія після дії акаунта (app/bugville/bv-progress.php). Без таблиць міграції № 36 — null,
 * гра працює й без них. Серію днів ($active) зараховує лише здана «Поломка дня» за свій день $day.
 */
$progress = static function (int $uid, int $xpBefore, bool $active = false, ?string $day = null) use ($pdo): ?array {
    try {
        return bv_progress_update($pdo, $uid, $xpBefore, $active, $day);
    } catch (Throwable $e) {
        error_log('[bugville] progress: ' . get_class($e));

        return null;
    }
};
$xpNow = static fn(int $uid): int => bv_totals($pdo, $uid)['xp'];

switch ($action) {
    case 'state':
    case 'confirm_age':
        if ($ctx['user_id'] !== null) {
            $who['totals'] = bv_totals($pdo, (int) $ctx['user_id']);
            if (($credited['credited'] ?? 0) > 0) {
                $who['progress'] = $progress((int) $ctx['user_id'], $who['totals']['xp'] - (int) $credited['xp']);
            }
        }
        bv_api_out(['ok' => true] + $who);

    case 'start':
        if (($in['daily'] ?? null) === true) {   // «Поломка дня»: місію обирає сервер
            $r = bv_daily_start($pdo, $ctx);
            if (!$r['ok']) {
                bv_api_out(['ok' => false, 'error' => $r['error']], ['rate_limited' => 429, 'unavailable' => 503][$r['error']] ?? 404);
            }
            bv_api_out(['ok' => true, 'token' => $r['token'], 'scene' => $r['scene'], 'daily' => $r['daily']] + $who);
        }
        $mission = filter_var($in['mission'] ?? null, FILTER_VALIDATE_INT, ['options' => ['min_range' => 1]]);
        if ($mission === false) {
            bv_api_out(['ok' => false, 'error' => 'bad_request'], 400);
        }
        $r = bv_attempt_start($pdo, (int) $mission, $ctx);
        if (!$r['ok']) {
            bv_api_out(['ok' => false, 'error' => $r['error']], $r['error'] === 'rate_limited' ? 429 : 404);
        }
        bv_api_out(['ok' => true, 'token' => $r['token'], 'scene' => $r['scene']] + $who);

    case 'hint':
        $token = is_string($in['token'] ?? null) ? $in['token'] : '';
        if ($token === '') {
            bv_api_out(['ok' => false, 'error' => 'bad_request'], 400);
        }
        $r = bv_attempt_hint($pdo, $token, $ctx);
        if (!$r['ok']) {
            $codes = ['rate_limited' => 429, 'not_found' => 404, 'forbidden' => 404, 'already_checked' => 409];
            bv_api_out(['ok' => false, 'error' => $r['error'] === 'forbidden' ? 'not_found' : $r['error']], $codes[$r['error']] ?? 400);
        }
        bv_api_out(['ok' => true, 'hint' => $r['hint']] + (isset($r['hints']) ? ['hints' => $r['hints']] : []) + $who);

    // ---------- Інтерактивні сцени (Розділ 1): сирі дії → реакція від сервера; знайдене рахує лише сервер ----------
    case 'scene_act':
        $token = is_string($in['token'] ?? null) ? $in['token'] : '';
        $op = is_string($in['op'] ?? null) ? $in['op'] : '';
        if ($token === '' || $op === '') {
            bv_api_out(['ok' => false, 'error' => 'bad_request'], 400);
        }
        $r = bv_scene_act($pdo, $token, $op, $in['input'] ?? '', $ctx);
        if (!$r['ok']) {
            $codes = ['rate_limited' => 429, 'not_found' => 404, 'forbidden' => 404, 'expired' => 410, 'bad_request' => 400, 'too_long' => 400,
                'already_checked' => 409, 'too_many_actions' => 409, 'conflict' => 409];
            bv_api_out(['ok' => false, 'error' => $r['error'] === 'forbidden' ? 'not_found' : $r['error']], $codes[$r['error']] ?? 400);
        }
        bv_api_out($r);

    case 'scene_finish':
        $token = is_string($in['token'] ?? null) ? $in['token'] : '';
        if ($token === '') {
            bv_api_out(['ok' => false, 'error' => 'bad_request'], 400);
        }
        $xpBefore = $ctx['user_id'] !== null ? $xpNow((int) $ctx['user_id']) : 0;
        $r = bv_scene_finish($pdo, $token, $ctx);   // поля на кшталт «found» від клієнта не читаються взагалі
        if (!$r['ok']) {
            $codes = ['rate_limited' => 429, 'not_found' => 404, 'forbidden' => 404, 'expired' => 410, 'not_enough' => 409];
            bv_api_out(['ok' => false, 'error' => $r['error'] === 'forbidden' ? 'not_found' : $r['error']]
                + array_intersect_key($r, ['found' => 1, 'min_found' => 1]), $codes[$r['error']] ?? 400);
        }
        if ($ctx['user_id'] !== null) {
            $who['totals'] = bv_totals($pdo, (int) $ctx['user_id']);
            if (empty($r['repeat']) && !empty($r['saved'])) {   // звання, значки; серія — лише за здану Поломку дня
                $r['progress'] = $progress((int) $ctx['user_id'], $xpBefore, isset($r['daily']), $r['daily']['day'] ?? null);
            }
        }
        bv_api_out($r + $who);

    case 'check':
        $token = is_string($in['token'] ?? null) ? $in['token'] : '';
        $answer = $in['answer'] ?? null;
        if ($token === '' || !(is_string($answer) || is_int($answer) || is_float($answer) || is_array($answer))) {
            bv_api_out(['ok' => false, 'error' => 'bad_request'], 400);
        }
        $xpBefore = $ctx['user_id'] !== null ? $xpNow((int) $ctx['user_id']) : 0;
        $r = bv_check_and_reward($pdo, $token, $answer, $ctx);
        if (!$r['ok']) {
            $codes = ['rate_limited' => 429, 'not_found' => 404, 'forbidden' => 404, 'expired' => 410, 'bad_answer' => 400];
            bv_api_out(['ok' => false, 'error' => $r['error'] === 'forbidden' ? 'not_found' : $r['error']], $codes[$r['error']] ?? 400);
        }
        if ($ctx['user_id'] !== null) {
            $who['totals'] = bv_totals($pdo, (int) $ctx['user_id']);
            if (empty($r['repeat']) && !empty($r['saved'])) {
                $r['progress'] = $progress((int) $ctx['user_id'], $xpBefore);
            }
        }
        bv_api_out($r + $who);

    // ---------- Іспити (крок 4): лише акаунт із підтвердженим віком; гість і акаунт без 16+ — 403 ----------
    case 'exam_state':
    case 'exam_start':
        $exam = filter_var($in['exam'] ?? null, FILTER_VALIDATE_INT, ['options' => ['min_range' => 1]]);
        if ($exam === false || bv_exam_level((int) $exam) === null) {
            bv_api_out(['ok' => false, 'error' => 'bad_request'], 400);
        }
        if ($action === 'exam_state') {
            bv_api_out(['ok' => true] + $who + bv_exam_status($pdo, $ctx['user_id'] !== null ? (int) $ctx['user_id'] : null, (int) $exam));
        }
        if ($ctx['user_id'] === null) {
            bv_api_out(['ok' => false, 'error' => 'auth_required'] + $who, 403);
        }
        $r = bv_exam_start($pdo, (int) $exam, $ctx);
        if (!$r['ok']) {
            $codes = ['rate_limited' => 429, 'cooldown' => 409, 'exam_unavailable' => 404, 'not_found' => 404];
            bv_api_out($r + $who, $codes[$r['error']] ?? 400);
        }
        bv_api_out($r + $who);

    case 'exam_answer':
    case 'exam_finish':
        if ($ctx['user_id'] === null) {
            bv_api_out(['ok' => false, 'error' => 'auth_required'] + $who, 403);
        }
        $token = is_string($in['token'] ?? null) ? $in['token'] : '';
        if ($token === '') {
            bv_api_out(['ok' => false, 'error' => 'bad_request'], 400);
        }
        if ($action === 'exam_answer') {
            $n = filter_var($in['n'] ?? null, FILTER_VALIDATE_INT, ['options' => ['min_range' => 1, 'max_range' => 50]]);
            $answer = $in['answer'] ?? null;
            if ($n === false || !(is_string($answer) || is_int($answer) || is_float($answer) || is_array($answer))) {
                bv_api_out(['ok' => false, 'error' => 'bad_request'], 400);
            }
            $r = bv_exam_answer($pdo, $token, (int) $n, $answer, $ctx);
        } else {
            $xpBefore = $xpNow((int) $ctx['user_id']);
            $r = bv_exam_finish($pdo, $token, $ctx);
            if ($r['ok'] && empty($r['repeat'])) {
                $r['progress'] = $progress((int) $ctx['user_id'], $xpBefore);
            }
        }
        if (!$r['ok']) {
            $codes = ['rate_limited' => 429, 'not_found' => 404, 'expired' => 410, 'bad_answer' => 400, 'auth_required' => 403,
                'already_answered' => 409, 'already_finished' => 409];
            bv_api_out(['ok' => false, 'error' => $r['error']], $codes[$r['error']] ?? 400);
        }
        if ($action === 'exam_finish') {
            $r['totals'] = bv_totals($pdo, (int) $ctx['user_id']);
        }
        bv_api_out($r + $who);

    // ---------- Книга чарівних слів: лише акаунт із підтвердженим віком ----------
    case 'word_quiz':
    case 'word_check':
        if ($ctx['user_id'] === null) {
            bv_api_out(['ok' => false, 'error' => 'auth_required'] + $who, 403);
        }
        $word = is_string($in['word'] ?? null) ? $in['word'] : '';
        if (preg_match('/^[a-z]{1,32}$/', $word) !== 1) {
            bv_api_out(['ok' => false, 'error' => 'bad_request'], 400);
        }
        if (!bv_check_rate_ok($pdo, $ctx)) {
            bv_api_out(['ok' => false, 'error' => 'rate_limited'], 429);
        }
        if ($action === 'word_quiz') {
            $r = bv_word_quiz($pdo, (int) $ctx['user_id'], $word);
        } else {
            $opt = is_string($in['option'] ?? null) ? $in['option'] : '';
            if (preg_match('/^w[0-9a-f]{6}$/', $opt) !== 1) {
                bv_api_out(['ok' => false, 'error' => 'bad_request'], 400);
            }
            $r = bv_word_check($pdo, (int) $ctx['user_id'], $word, $opt);
        }
        if (!$r['ok']) {
            bv_api_out(['ok' => false, 'error' => $r['error']], ['not_found' => 404, 'locked' => 409, 'no_quiz' => 409][$r['error']] ?? 400);
        }
        bv_api_out($r + $who);

    // ---------- Майстерня (MAIN_TASK §7): лише акаунт із підтвердженим віком, лише монети гри ----------
    case 'ws_buy':
    case 'ws_equip':
    case 'ws_avatar':
        if ($ctx['user_id'] === null) {
            bv_api_out(['ok' => false, 'error' => 'auth_required'] + $who, 403);
        }
        if (!bv_check_rate_ok($pdo, $ctx)) {
            bv_api_out(['ok' => false, 'error' => 'rate_limited'], 429);
        }
        $uid = (int) $ctx['user_id'];
        $key = is_string($in['item'] ?? ($in['avatar'] ?? null)) ? (string) ($in['item'] ?? $in['avatar']) : '';
        if ($key !== '' && preg_match('/^[a-z_]{1,32}$/', $key) !== 1) {
            bv_api_out(['ok' => false, 'error' => 'bad_request'], 400);
        }
        $r = match ($action) {
            'ws_buy' => $key === '' ? ['ok' => false, 'error' => 'bad_request'] : bv_ws_buy($pdo, $uid, $key),
            'ws_equip' => bv_ws_equip($pdo, $uid, is_string($in['kind'] ?? null) ? $in['kind'] : '', $key),
            default => bv_ws_set_avatar($pdo, $uid, $key),
        };
        if (!$r['ok']) {
            $codes = ['not_found' => 404, 'owned' => 409, 'not_enough' => 409, 'not_owned' => 409, 'auth_required' => 403];
            bv_api_out(['ok' => false, 'error' => $r['error']] + array_intersect_key($r, ['price' => 1, 'balance' => 1]), $codes[$r['error']] ?? 400);
        }
        bv_api_out($r + ['balance' => bv_ws_balance($pdo, $uid)] + $who);

    default:
        bv_api_out(['ok' => false, 'error' => 'bad_request'], 400);
}
