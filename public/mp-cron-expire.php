<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: переводить оголошення з терміном, що минув, у status='expired'.
 *
 *   published + expires_at <= NOW()  →  expired  (запис 'expired' у mp_moderation_log)
 *
 * Це лише «прибирання» статусу: публічні сторінки в будь-якому разі перевіряють expires_at > NOW(),
 * тож коректність сайту від cron НЕ залежить.
 *
 * Запуск:
 *   CLI / cron:  php /шлях/до/проєкту/public/mp-cron-expire.php          (рекомендовано, раз на годину)
 *   HTTP:        mp-cron-expire.php?token=<cron_token з config/marketplace.php>
 *                — працює лише якщо cron_token непорожній; інакше HTTP-запит дає 404.
 * Налаштування на хостингу — database/MARKETPLACE_HOSTING.md, розділ «Cron».
 */

require_once __DIR__ . '/../app/marketplace.php';
require_once __DIR__ . '/../app/marketplace-board.php';

$isCli = PHP_SAPI === 'cli';
if (!$isCli) {
    $token = (string) (mp_config()['cron_token'] ?? '');
    $given = is_string($_GET['token'] ?? null) ? (string) $_GET['token'] : '';
    if ($token === '' || !hash_equals($token, $given)) {
        mp_not_found();
    }
    header('Content-Type: text/plain; charset=utf-8');
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$n = mpb_expire_due($pdo);
echo date('Y-m-d H:i:s') . ' expired: ' . $n . "\n";
