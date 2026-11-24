<?php

declare(strict_types=1);

/**
 * AI LAB HUB — API гри «Багвіль» (крок 2 плану). Лише POST, тіло JSON, відповідь JSON.
 * Захист: запит лише з нашого сайту (csrf_same_origin) + токен сесії (заголовок X-CSRF-Token або поле csrf).
 *
 * Дії (поле action):
 *   state        — хто грає (гість / акаунт 16+), мінімальний вік, підсумки акаунта; зарахування сеансу, якщо щойно ввійшли.
 *   start        — {mission} → {token, scene}: лише сцена, без відповіді й параметрів поломки.
 *   hint         — {token} → підказка (безкоштовна, лише знижує зірки: максимум 2).
 *   check        — {token, answer} → результат, розбір побаченого варіанта; акаунт → earned + saved, гість → would_earn.
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

switch ($action) {
    case 'state':
    case 'confirm_age':
        if ($ctx['user_id'] !== null) {
            $who['totals'] = bv_totals($pdo, (int) $ctx['user_id']);
        }
        bv_api_out(['ok' => true] + $who);

    case 'start':
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
        bv_api_out(['ok' => true, 'hint' => $r['hint']] + $who);

    case 'check':
        $token = is_string($in['token'] ?? null) ? $in['token'] : '';
        $answer = $in['answer'] ?? null;
        if ($token === '' || !(is_string($answer) || is_int($answer) || is_float($answer) || is_array($answer))) {
            bv_api_out(['ok' => false, 'error' => 'bad_request'], 400);
        }
        $r = bv_check_and_reward($pdo, $token, $answer, $ctx);
        if (!$r['ok']) {
            $codes = ['rate_limited' => 429, 'not_found' => 404, 'forbidden' => 404, 'expired' => 410, 'bad_answer' => 400];
            bv_api_out(['ok' => false, 'error' => $r['error'] === 'forbidden' ? 'not_found' : $r['error']], $codes[$r['error']] ?? 400);
        }
        if ($ctx['user_id'] !== null) {
            $who['totals'] = bv_totals($pdo, (int) $ctx['user_id']);
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
            $r = bv_exam_finish($pdo, $token, $ctx);
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

    default:
        bv_api_out(['ok' => false, 'error' => 'bad_request'], 400);
}
