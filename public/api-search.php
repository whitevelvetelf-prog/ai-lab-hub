<?php

declare(strict_types=1);

/**
 * AI LAB HUB — живий пошук продуктів для поля в шапці.
 *
 * GET ?q=... (мінімум 2 символи після trim, інакше 400; довше за 100 — обрізається).
 * Пошук — спільна функція search_products() з app/search.php (словниковий індекс назв, категорій
 * і описів усіма мовами, синоніми, «надто загальні» слова). Лише опубліковані продукти.
 * Ліміт частоти з IP — search_rate_ok() (429).
 *
 * Повертає JSON: { ok, query, broad, total, results: [{ id, name, logo_url, initials,
 * category, subcategory }] }, максимум suggest_limit рядків (config/search.php).
 */

require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/search.php';
require_once __DIR__ . '/../app/search-log.php';

header('Content-Type: application/json; charset=utf-8');
header('X-Content-Type-Options: nosniff');

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

/** JSON-відповідь + вихід. */
function search_respond(array $payload, int $status = 200): void
{
    http_response_code($status);
    echo json_encode($payload, JSON_UNESCAPED_UNICODE);
    exit;
}

if ($_SERVER['REQUEST_METHOD'] !== 'GET') {
    search_respond(['ok' => false, 'error' => 'method_not_allowed'], 405);
}

$query = mb_substr(trim((string) preg_replace('/\s+/u', ' ', (string) ($_GET['q'] ?? ''))), 0, SEARCH_MAX_QUERY);
if (mb_strlen($query) < 2) {
    search_respond(['ok' => false, 'error' => 'query_too_short'], 400);
}

// Журнал запитів і ліміт частоти: сесію лише читаємо (без блокування паралельних запитів під час набору).
if (session_status() === PHP_SESSION_NONE && isset($_COOKIE[session_name()])) {
    session_start(['read_and_close' => true]);
}
if (!search_rate_ok($pdo)) {
    search_respond(['ok' => false, 'error' => 'rate_limited'], 429);
}

$found = search_products($pdo, $query, 1, search_config()['suggest_limit']);
$results = [];
if ($found['ids'] !== []) {
    $byId = [];
    foreach ($pdo->query('SELECT id, name, logo_url FROM products WHERE id IN (' . implode(',', $found['ids']) . ")
                          AND status = 'published'") as $row) {
        $byId[(int) $row['id']] = $row;
    }
    foreach ($found['ids'] as $fid) {
        if (isset($byId[$fid])) {
            $results[] = $byId[$fid];
        }
    }
}

/** Ініціали для логотипа-заглушки (по словах / CamelCase) — як на product.php. */
function search_result_initials(string $name): string
{
    $parts = preg_split('/\s+|(?<=\p{Ll})(?=\p{Lu})/u', trim($name), -1, PREG_SPLIT_NO_EMPTY) ?: [];
    if (count($parts) >= 2) {
        return mb_strtoupper(mb_substr($parts[0], 0, 1) . mb_substr($parts[1], 0, 1));
    }

    return mb_strtoupper(mb_substr($name, 0, 2));
}

$productIds = array_map(static fn(array $r): int => (int) $r['id'], $results);
$categoryByProduct = [];
$subcategoryByProduct = [];

if ($productIds !== []) {
    $placeholders = implode(',', array_fill(0, count($productIds), '?'));

    $catStmt = $pdo->prepare(
        "SELECT pc.product_id, c.name, c.name_en
         FROM product_categories pc
         JOIN categories c ON c.id = pc.category_id
         WHERE pc.product_id IN ($placeholders)
         ORDER BY pc.product_id, c.id"
    );
    $catStmt->execute($productIds);
    foreach ($catStmt as $row) {
        $pid = (int) $row['product_id'];
        if (!isset($categoryByProduct[$pid])) {
            $categoryByProduct[$pid] = localized_name($row);
        }
    }

    $subStmt = $pdo->prepare(
        "SELECT ps.product_id, s.name, s.name_en
         FROM product_subcategories ps
         JOIN subcategories s ON s.id = ps.subcategory_id
         WHERE ps.product_id IN ($placeholders)
         ORDER BY ps.product_id, s.id"
    );
    $subStmt->execute($productIds);
    foreach ($subStmt as $row) {
        $pid = (int) $row['product_id'];
        if (!isset($subcategoryByProduct[$pid])) {
            $subcategoryByProduct[$pid] = localized_name($row);
        }
    }
}

$items = [];
foreach ($results as $row) {
    $pid = (int) $row['id'];
    $logo = (string) ($row['logo_url'] ?? '');
    $items[] = [
        'id' => $pid,
        'name' => (string) $row['name'],
        'logo_url' => $logo !== '' ? $logo : null,
        'initials' => search_result_initials((string) $row['name']),
        'category' => $categoryByProduct[$pid] ?? null,
        'subcategory' => $subcategoryByProduct[$pid] ?? null,
    ];
}

search_log_query($pdo, $query, 'header', count($items));

search_respond(['ok' => true, 'query' => $query, 'broad' => $found['status'] === 'broad', 'total' => (int) $found['total'], 'results' => $items]);
