<?php

declare(strict_types=1);

/**
 * AI LAB HUB — toggle збереження продукту в «Мою добірку».
 *
 * POST (form-urlencoded або JSON), поле `product_id`.
 *   - лише для залогінених користувачів; без сесії → 401
 *     (фронтенд обробляє редіректом на вхід);
 *   - якщо запису немає — додає, якщо є — видаляє (toggle);
 *   - повертає JSON { ok: true, saved: true|false }.
 */

require_once __DIR__ . '/../app/auth.php';

header('Content-Type: application/json; charset=utf-8');
header('X-Content-Type-Options: nosniff');

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

/** JSON-відповідь + вихід. */
function saved_respond(array $payload, int $status = 200): void
{
    http_response_code($status);
    echo json_encode($payload, JSON_UNESCAPED_UNICODE);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    saved_respond(['ok' => false, 'error' => 'method_not_allowed'], 405);
}

// auth_current_user() (а не лише auth_user_id()) — звіряє, що акаунт із
// сесії ще існує в БД, і скидає «протухлу» сесію (напр. після видалення
// користувача чи синхронізації бази). Інакше INSERT з мертвим user_id
// падав би на FK-обмеженні (SQLSTATE 23000 / 1452) → 500 замість 401.
if (!auth_check()) {
    saved_respond(['ok' => false, 'error' => 'auth_required'], 401);
}

$currentUser = auth_current_user($pdo);
if ($currentUser === null) {
    saved_respond(['ok' => false, 'error' => 'auth_required'], 401);
}
$userId = (int) $currentUser['id'];

// product_id: з form-urlencoded або з JSON-тіла.
$productId = (int) ($_POST['product_id'] ?? 0);
if ($productId === 0) {
    $raw = file_get_contents('php://input') ?: '';
    $json = json_decode($raw, true);
    if (is_array($json)) {
        $productId = (int) ($json['product_id'] ?? 0);
    }
}

if ($productId <= 0) {
    saved_respond(['ok' => false, 'error' => 'bad_request'], 400);
}

// Продукт має існувати (users / products не чіпаємо — лише перевірка).
$exists = $pdo->prepare('SELECT id FROM products WHERE id = :pid');
$exists->execute([':pid' => $productId]);
if ($exists->fetch() === false) {
    saved_respond(['ok' => false, 'error' => 'not_found'], 404);
}

try {
    // Спершу пробуємо прибрати — якщо рядок був, це зняття з добірки.
    $del = $pdo->prepare('DELETE FROM saved_products WHERE user_id = :uid AND product_id = :pid');
    $del->execute([':uid' => $userId, ':pid' => $productId]);

    if ($del->rowCount() > 0) {
        saved_respond(['ok' => true, 'saved' => false]);
    }

    // Рядка не було — додаємо. Гонка двох запитів: дубль ловимо як «збережено».
    try {
        $ins = $pdo->prepare('INSERT INTO saved_products (user_id, product_id) VALUES (:uid, :pid)');
        $ins->execute([':uid' => $userId, ':pid' => $productId]);
    } catch (PDOException $dup) {
        $code = (int) ($dup->errorInfo[1] ?? 0);
        if ($code === 1062) {
            // дубль (гонка) — уже збережено, це не помилка
        } elseif ($code === 1452) {
            // FK: user_id більше не існує (сесія протухла між перевіркою і INSERT)
            if ($pdo->inTransaction()) {
                $pdo->rollBack();
            }
            saved_respond(['ok' => false, 'error' => 'auth_required'], 401);
        } else {
            throw $dup;
        }
    }

    saved_respond(['ok' => true, 'saved' => true]);
} catch (PDOException $ex) {
    if ($pdo->inTransaction()) {
        $pdo->rollBack();
    }
    error_log('[saved-products] ' . $ex->getMessage());
    saved_respond(['ok' => false, 'error' => 'server_error'], 500);
}
