<?php

declare(strict_types=1);

/**
 * AI LAB HUB — проміжний редирект «Перейти на сайт» (облік кліків).
 *
 * GET ?product_id=N — визначає link_type (affiliate, якщо в продукту
 * заповнене affiliate_url, інакше official), записує клік у link_clicks
 * (app/analytics.php) і одразу редиректить (302) на реальний URL.
 * Нічого не рендерить.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/analytics.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$productId = (int) ($_GET['product_id'] ?? 0);

if ($productId <= 0) {
    header('Location: catalog.php');
    exit;
}

$stmt = $pdo->prepare('SELECT official_url, affiliate_url FROM products WHERE id = :id');
$stmt->execute([':id' => $productId]);
$product = $stmt->fetch();

if ($product === false) {
    header('Location: catalog.php');
    exit;
}

$isAffiliate = !empty($product['affiliate_url']);
$target = $isAffiliate ? (string) $product['affiliate_url'] : (string) $product['official_url'];
$target = str_replace(["\r", "\n"], '', $target);

if ($target === '') {
    header('Location: catalog.php');
    exit;
}

analytics_log_click($pdo, $productId, $isAffiliate ? 'affiliate' : 'official');

header('Location: ' . $target, true, 302);
exit;
