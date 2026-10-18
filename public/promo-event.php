<?php

declare(strict_types=1);

/**
 * AI LAB HUB — облік показу / перегляду відеореклами (sendBeacon з sponsored.js).
 *
 * POST t=<токен з promo-serve.php>  type=impression|view
 * Токен має бути справжнім (HMAC), не простроченим і виданим цьому ж сеансу.
 * Боти не рахуються. Дублі й частоту відсікає promo_record_event. Завжди 204.
 * Кліки сюди не приймаються — лише через promo-click.php.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/promo.php';

http_response_code(204);
header('Cache-Control: no-store');

if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST' || promo_is_bot()) {
    exit;
}

$type = is_string($_POST['type'] ?? null) ? $_POST['type'] : '';
$token = is_string($_POST['t'] ?? null) ? $_POST['t'] : '';
if (!in_array($type, ['impression', 'view'], true)) {
    exit;
}

$data = promo_token_read($token);
if ($data === null || !$data['fresh'] || !$data['own'] || $data['preview']) {
    exit;
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
promo_db_utc($pdo);

if (!promo_video_ready($pdo)) {
    exit;
}

try {
    promo_record_event($pdo, $data['c'], $type, $data['p'], analytics_session_hash());
} catch (Throwable $e) {
    error_log('[promo] event: ' . $e->getMessage());
}
