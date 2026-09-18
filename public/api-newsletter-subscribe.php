<?php

declare(strict_types=1);

/**
 * AI LAB HUB — підписка на розсилку (форма в підвалі, app/footer.php).
 *
 * POST (form-urlencoded або JSON), поле `email`.
 *   - публічний ендпоінт, без авторизації;
 *   - валідний формат email обов'язковий;
 *   - дублікат (email уже в базі) — НЕ помилка: окрема відповідь
 *     already=true, фронтенд показує «Ви вже підписані»;
 *   - без реальної інтеграції з сервісом розсилок — лише збереження
 *     в newsletter_subscribers, це на майбутнє.
 *   Повертає JSON { ok: true, already: true|false, message } або
 *   { ok: false, error, message }.
 */

require_once __DIR__ . '/../app/translations.php';

header('Content-Type: application/json; charset=utf-8');
header('X-Content-Type-Options: nosniff');

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

/** JSON-відповідь + вихід. */
function newsletter_respond(array $payload, int $status = 200): void
{
    http_response_code($status);
    echo json_encode($payload, JSON_UNESCAPED_UNICODE);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    newsletter_respond(['ok' => false, 'error' => 'method_not_allowed'], 405);
}

// email: з form-urlencoded або з JSON-тіла.
$email = trim((string) ($_POST['email'] ?? ''));
if ($email === '') {
    $raw = file_get_contents('php://input') ?: '';
    $json = json_decode($raw, true);
    if (is_array($json)) {
        $email = trim((string) ($json['email'] ?? ''));
    }
}

if ($email === '' || filter_var($email, FILTER_VALIDATE_EMAIL) === false) {
    newsletter_respond(['ok' => false, 'error' => 'invalid_email', 'message' => t('newsletter_error_invalid')], 400);
}

try {
    $ins = $pdo->prepare('INSERT INTO newsletter_subscribers (email) VALUES (:email)');
    $ins->execute([':email' => $email]);

    newsletter_respond(['ok' => true, 'already' => false, 'message' => t('newsletter_success')]);
} catch (PDOException $ex) {
    $code = (int) ($ex->errorInfo[1] ?? 0);
    if ($code === 1062) {
        newsletter_respond(['ok' => true, 'already' => true, 'message' => t('newsletter_already')]);
    }
    error_log('[newsletter] ' . $ex->getMessage());
    newsletter_respond(['ok' => false, 'error' => 'server_error', 'message' => t('newsletter_error_generic')], 500);
}
