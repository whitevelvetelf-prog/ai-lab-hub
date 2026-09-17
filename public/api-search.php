<?php

declare(strict_types=1);

/**
 * AI LAB HUB — живий пошук продуктів для поля в шапці.
 *
 * GET ?q=... (мінімум 2 символи після trim, інакше 400).
 * Шукає лише серед status = 'published' за products.name (LIKE
 * '%query%' — при поточному обсязі ~165+ рядків це швидше й простіше за
 * FULLTEXT, який до того ж не шукає підрядки й ігнорує короткі слова).
 *
 * Бренднейми продуктів — латиницею в обох мовах інтерфейсу, тож пошук
 * однаково працює в UA/EN. Розкладку клавіатури (укр./лат.) вирівнює
 * app/search.php — див. його докблок.
 *
 * Повертає JSON: { ok, query, results: [{ id, name, logo_url, initials,
 * category, subcategory }] }, максимум 10 рядків.
 */

require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/search.php';

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

$query = trim((string) ($_GET['q'] ?? ''));
if (mb_strlen($query) < 2) {
    search_respond(['ok' => false, 'error' => 'query_too_short'], 400);
}

$results = search_products_by_name($pdo, $query, 'id, name, logo_url', 10);

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

search_respond(['ok' => true, 'query' => $query, 'results' => $items]);
