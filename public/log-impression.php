<?php

declare(strict_types=1);

/**
 * AI LAB HUB — облік показу оголошення (ad server).
 *
 * POST ad_id=N — пише рядок у ad_impressions. Викликається асинхронно
 * з app/ad-banner.php; нічого не рендерить, завжди відповідає 204.
 * session_id — анонімний хеш поточної сесії (app/analytics.php).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/analytics.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$adId = (int) ($_POST['ad_id'] ?? 0);

if ($_SERVER['REQUEST_METHOD'] === 'POST' && $adId > 0) {
    try {
        $stmt = $pdo->prepare(
            "INSERT INTO ad_impressions (ad_id, session_id)
             SELECT id, :sid FROM ads WHERE id = :id AND status = 'active'"
        );
        $stmt->execute([':sid' => analytics_session_hash(), ':id' => $adId]);
    } catch (Throwable $e) {
        error_log('[ads] ' . $e->getMessage());
    }
}

http_response_code(204);
