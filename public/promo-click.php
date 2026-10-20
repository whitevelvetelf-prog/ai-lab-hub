<?php

declare(strict_types=1);

/**
 * AI LAB HUB — перехід за відеорекламою.
 *
 * GET t=<токен з promo-serve.php>.
 *   * Підпис невірний (підробка) → 400, без редиректу й без обліку.
 *   * Адреса призначення береться з БД (ad_creatives.destination_url), а не з
 *     параметра — відкритого редиректу немає. Лише https.
 *   * Клік зараховується (і списується для cpc), лише якщо токен свіжий, виданий
 *     цьому сеансу, запит не від бота і система ввімкнена; повтор того ж
 *     сеансу протягом PROMO_CLICK_DEDUP_SEC не рахується. В інших випадках —
 *     просто перехід без обліку.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/promo.php';

header('Cache-Control: no-store');
header('X-Robots-Tag: noindex');
header('Referrer-Policy: no-referrer');

$token = is_string($_GET['t'] ?? null) ? $_GET['t'] : '';
$data = promo_token_read($token);

if ($data === null) {
    http_response_code(400);
    header('Content-Type: text/plain; charset=utf-8');
    echo 'Bad request';
    exit;
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
promo_db_utc($pdo);

$stmt = $pdo->prepare('SELECT destination_url FROM ad_creatives WHERE id = :id AND campaign_id = :c');
$stmt->execute([':id' => $data['c'], ':c' => $data['k']]);
$target = str_replace(["\r", "\n"], '', (string) ($stmt->fetchColumn() ?: ''));

// Власна реклама сайту може вести на свою сторінку відносною адресою (/advertise.php?ref=house-A1).
$internal = false;
if (preg_match('#^/(?!/)[A-Za-z0-9._~/?=&%-]*$#', $target) === 1) {
    $st = $pdo->prepare("SELECT campaign_type FROM ad_campaigns WHERE id = :c");
    $st->execute([':c' => $data['k']]);
    $internal = $st->fetchColumn() === 'internal';
}
if ($target === '' || (!$internal && !preg_match('~^https://[^\s/?#]+~i', $target))) {
    header('Location: /index.php', true, 302);
    exit;
}

// Адмін-перегляд (preview) — перехід без обліку.
if ($data['fresh'] && $data['own'] && !$data['preview'] && !promo_is_bot() && promo_video_ready($pdo)) {
    try {
        promo_record_event($pdo, $data['c'], 'click', $data['p'], analytics_session_hash());
    } catch (Throwable $e) {
        error_log('[promo] click: ' . $e->getMessage());
    }
}

header('Location: ' . $target, true, 302);
exit;
