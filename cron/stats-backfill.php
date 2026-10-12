<?php

declare(strict_types=1);

/**
 * AI LAB HUB — заповнення page_views_daily з page_views (одноразово; повторний запуск безпечний).
 *   php /home/gu621051/ailabhub-directory.com/www/cron/stats-backfill.php          — лише відсутні й незакриті дні
 *   php /home/gu621051/ailabhub-directory.com/www/cron/stats-backfill.php --force  — перерахувати всі дні, для яких є сирі дані
 * Лише CLI (з веба — 404). Те саме робить і SQL-backfill у database/migration-2026-10-12-site-stats.sql,
 * а сьогоднішній день дораховується сам при відкритті admin-stats.php.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once __DIR__ . '/../app/site-stats.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

try {
    $n = site_stats_sync($pdo, in_array('--force', $argv, true));
    $row = $pdo->query('SELECT COUNT(*), MIN(day), MAX(day), SUM(views) FROM page_views_daily')->fetch(PDO::FETCH_NUM);
    echo 'stats-backfill: days_recomputed=' . $n . ' days_total=' . $row[0] . ' range=' . $row[1] . '..' . $row[2]
        . ' views_total=' . $row[3] . "\n";
    exit(0);
} catch (Throwable $e) {
    fwrite(STDERR, 'stats-backfill: ' . $e->getMessage() . "\n");
    exit(1);
}
