<?php

declare(strict_types=1);

/**
 * AI LAB HUB — облік показу оголошення (ad server).
 *
 * POST ad_id=N — +1 показ у денному агрегаті ad_zone_stats_daily (INSERT … ON DUPLICATE
 * KEY UPDATE; сирі рядки в ad_impressions з 2026-10-21 не пишуться). Відомі боти не
 * рахуються. Викликається асинхронно з app/ad-banner.php; завжди відповідає 204.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/analytics.php';
require_once __DIR__ . '/../app/promo.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$adId = (int) ($_POST['ad_id'] ?? 0);

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $adId > 0 && !promo_is_bot()) {
    try {
        $stmt = $pdo->prepare(
            "INSERT INTO ad_zone_stats_daily (ad_id, stat_date, impressions)
             SELECT id, CURDATE(), 1 FROM ads WHERE id = :id AND status = 'active'
             ON DUPLICATE KEY UPDATE impressions = impressions + 1"
        );
        $stmt->execute([':id' => $adId]);
    } catch (Throwable $e) {
        error_log('[ads] ' . $e->getMessage());
    }
}

http_response_code(204);
