<?php

declare(strict_types=1);

/**
 * AI LAB HUB — облік показів / переглядів реклами (sendBeacon з sponsored.js).
 *
 * POST events=[{"t":"<токен>","type":"impression|view|skip"}, …] (skip — «Пропустити» у спливаючому вікні;
 *      close — вікно без відео закрилось саме: лише час закриття в сесії, без статистики) — пакет подій сторінки
 *      (до PROMO_EVENT_BATCH_MAX), один запит замість окремого на кожну картку;
 * POST t=<токен>  type=impression|view — одна подія (старий формат).
 *
 * Токен має бути справжнім (HMAC), не простроченим і виданим цьому ж сеансу.
 * Відомі боти (User-Agent) не рахуються. Дублі й частоту відсікає promo_record_event
 * (стан сеансу); у БД — лише агрегат ad_stats_daily. Завжди 204.
 * Кліки сюди не приймаються — лише через promo-click.php.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/promo.php';
require_once __DIR__ . '/../app/ad-popup.php';

const PROMO_EVENT_BATCH_MAX = 20;

http_response_code(204);
header('Cache-Control: no-store');

if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST' || promo_is_bot()) {
    exit;
}

$events = [];
if (is_string($_POST['events'] ?? null)) {
    $decoded = json_decode($_POST['events'], true);
    foreach (is_array($decoded) ? array_slice($decoded, 0, PROMO_EVENT_BATCH_MAX) : [] as $ev) {
        if (is_array($ev) && is_string($ev['t'] ?? null) && is_string($ev['type'] ?? null)) {
            $events[] = [$ev['t'], $ev['type']];
        }
    }
} elseif (is_string($_POST['t'] ?? null) && is_string($_POST['type'] ?? null)) {
    $events[] = [$_POST['t'], $_POST['type']];
}
if ($events === []) {
    exit;
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
promo_db_utc($pdo);

if (!promo_video_ready($pdo)) {
    exit;
}

$session = analytics_session_hash();
foreach ($events as [$token, $type]) {
    if (!in_array($type, ['impression', 'view', 'skip', 'close'], true)) {
        continue;
    }
    if ($type === 'skip' || $type === 'close') {
        ad_popup_mark_closed();   // проміжок до наступного вікна — від закриття
    }
    $data = promo_token_read($token);
    if ($data === null || !$data['fresh'] || !$data['own'] || $data['preview'] || $type === 'close') {
        continue;   // close — вікно закрилось само (час показу минув): лише фіксуємо закриття, без статистики
    }
    try {
        promo_record_event($pdo, $data['c'], $type, $data['p'], $session);
    } catch (Throwable $e) {
        error_log('[promo] event: ' . $e->getMessage());
    }
}
