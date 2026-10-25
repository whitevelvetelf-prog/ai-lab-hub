<?php

declare(strict_types=1);

/**
 * AI LAB HUB — обробник чату з AI-асистенткою Елею.
 *
 * AJAX POST (form-urlencoded або JSON), поле `message` — вільний опис задачі.
 * Уся логіка — app/eli.php: eli_answer() (ліміт частоти, кеш, відбір
 * кандидатів, AI з повторами й запасною моделлю, запасний режим без AI).
 *
 * Відповідь: {ok, mode: ai|fallback|limited, reply_text, steps:[{step_title, product_ids}],
 * products:[картки], links?:[{title, href}]}. Запасний режим — звичайна
 * відповідь; повідомлення про «технічні труднощі» — лише коли недоступна база.
 * Текст запиту ніде не зберігається й не логується.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/analytics.php';
require_once __DIR__ . '/../app/eli.php';
require_once __DIR__ . '/../app/search-log.php';

header('Content-Type: application/json; charset=utf-8');
header('X-Content-Type-Options: nosniff');
@set_time_limit(45);

function eli_respond(array $data, int $httpCode = 200): void
{
    http_response_code($httpCode);
    echo json_encode($data, JSON_UNESCAPED_UNICODE);
    exit;
}

function eli_tech_error(): void
{
    eli_respond(['ok' => false, 'mode' => 'error', 'reply_text' => t('eli_tech_error'), 'steps' => [], 'products' => []]);
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    eli_respond(['ok' => false, 'mode' => 'error', 'reply_text' => '', 'steps' => [], 'products' => []], 405);
}

// --- Вхідне повідомлення ---------------------------------------------------
$message = '';
if (isset($_POST['message'])) {
    $message = (string) $_POST['message'];
} else {
    $body = json_decode((string) file_get_contents('php://input'), true);
    if (is_array($body) && isset($body['message'])) {
        $message = (string) $body['message'];
    }
}
// Биті UTF-8 байти відкидаємо, щоб json_encode запиту до API не падав.
if (!mb_check_encoding($message, 'UTF-8')) {
    $message = (string) mb_convert_encoding($message, 'UTF-8', 'UTF-8');
}
$message = trim($message);
if ($message === '') {
    eli_respond(['ok' => true, 'mode' => 'hint', 'reply_text' => t('eli_empty_message'), 'steps' => [], 'products' => []]);
}
if (mb_strlen($message) > 2000) {
    $message = mb_substr($message, 0, 2000);
}

$aiConfigPath = __DIR__ . '/../config/ai-assistant.php';
$cfg = eli_settings(is_file($aiConfigPath) ? (array) (require $aiConfigPath) : []);
$lang = current_lang() === 'en' ? 'en' : 'uk';

try {
    /** @var PDO $pdo */
    $pdo = require __DIR__ . '/../config/database.php';
} catch (Throwable $e) {
    error_log('[eli-chat] db connect: ' . $e->getMessage());
    eli_tech_error();
}

$sessionHash = analytics_session_hash();
$userId = (auth_check() && auth_user_id() !== null) ? (int) auth_user_id() : null;

try {
    $session = $_SESSION;
    $result = eli_answer($pdo, $message, $lang, $cfg, $session, $sessionHash, $userId, 'eli_http_post');
    $_SESSION['eli_hits'] = $session['eli_hits'] ?? [];
} catch (Throwable $e) {
    error_log('[eli-chat] db error: ' . $e->getMessage());
    eli_log($pdo, ['provider' => $cfg['provider'], 'model' => $cfg['model'], 'error_type' => 'other', 'source' => 'fail',
                   'latency_ms' => 0, 'lang' => $lang, 'session_hash' => $sessionHash]);
    eli_tech_error();
}

eli_log($pdo, $result['log']);
search_log_query($pdo, $message, 'eli', is_array($result['response']['products'] ?? null) ? count($result['response']['products']) : 0);
eli_respond($result['response']);
