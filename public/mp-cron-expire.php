<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: переводить оголошення з терміном, що минув, у status='expired'.
 *
 *   published + expires_at <= NOW()  →  expired  (запис 'expired' у mp_moderation_log)
 *
 * Також чистить mp_rate_limits (рядки старші за 3 доби), а з Хвилі 1 (2026-11-09) — агрегати популярних запитів
 * search_query_stats і перегляди mp_listing_views_daily старші за 90 днів, а з 2026-11-11 — запити каталогу
 * без результатів search_log старші за zero_result_retention_days (config/search.php, 30). Інших DELETE у скрипті немає.
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
require_once __DIR__ . '/../app/mp-popular.php';
require_once __DIR__ . '/../app/mp-stats.php';
require_once __DIR__ . '/../app/search.php';

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
$r = mpb_rate_cleanup($pdo);   // лічильники IP-лімітів старші за 3 доби
$q = mpq_cleanup($pdo);         // популярні запити старші за 90 днів
$v = mpst_cleanup($pdo);        // перегляди по днях старші за 90 днів
$z = search_log_zero_cleanup($pdo); // запити каталогу без результатів старші за zero_result_retention_days (30)
echo date('Y-m-d H:i:s') . ' expired: ' . $n . ' rate_limit_rows_deleted: ' . $r . ' query_stats_deleted: ' . $q . ' views_daily_deleted: ' . $v . ' zero_search_deleted: ' . $z . "\n";
