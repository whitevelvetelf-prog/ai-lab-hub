<?php

declare(strict_types=1);

/**
 * AI LAB HUB — проміжний редирект кліку по оголошенню (ad server).
 *
 * GET ?id=N — записує клік у ad_clicks і редиректить (302) на target_url
 * оголошення. Нічого не рендерить.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/analytics.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$adId = (int) ($_GET['id'] ?? 0);

$stmt = $pdo->prepare('SELECT target_url FROM ads WHERE id = :id');
$stmt->execute([':id' => $adId]);
$target = $adId > 0 ? $stmt->fetchColumn() : false;

$target = $target === false ? '' : str_replace(["\r", "\n"], '', (string) $target);

// Лише http(s) або відносні шляхи — жодних javascript:/data: схем.
if ($target === '' || preg_match('#^[a-z][a-z0-9+.-]*:#i', $target) && !preg_match('#^https?://#i', $target)) {
    header('Location: /index.php');
    exit;
}

try {
    $log = $pdo->prepare('INSERT INTO ad_clicks (ad_id, session_id) VALUES (:id, :sid)');
    $log->execute([':id' => $adId, ':sid' => analytics_session_hash()]);
} catch (Throwable $e) {
    error_log('[ads] ' . $e->getMessage());
}

header('Location: ' . $target, true, 302);
exit;
