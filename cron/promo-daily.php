<?php

declare(strict_types=1);

/**
 * AI LAB HUB — щоденне обслуговування реклами (о 03:10 за Києвом):
 *   * звірка лічильників ad_stats_daily із сирими подіями за вчорашню київську добу;
 *   * агрегати аудиторії для медіакіту (promo_audience_stats);
 *   * завершення кампаній із минулою датою, очищення ad_events старших за 30 днів;
 *   * добові повторні перевірки посилань активних креативів (з автопаузою);
 *   * закриття вчорашнього дня в page_views_daily (app/site-stats.php);
 *   * очищення журналу Елі (eli_api_log) старшого за 90 днів і застарілого кешу eli_cache.
 *   php /home/gu621051/ailabhub-directory.com/www/cron/promo-daily.php
 * Лише CLI.
 */

require __DIR__ . '/_bootstrap.php';
require_once __DIR__ . '/../app/promo-mail.php';
require_once __DIR__ . '/../app/promo-linkcheck.php';
require_once __DIR__ . '/../app/promo-audience.php';
require_once __DIR__ . '/../app/site-stats.php';
require_once __DIR__ . '/../app/eli.php';

exit(promo_cron_run('promo-daily', 1500, static function (PDO $pdo): string {
    $reconciled = promo_reconcile_stats($pdo, promo_today(-1));
    $audience = promo_audience_compute($pdo);
    $m = promo_maintenance($pdo);
    $links = promo_linkcheck_due($pdo, 'active', 300);
    $statsDays = site_stats_try_sync($pdo) ? 'ok' : 'fail';
    $eliPurged = eli_maintenance($pdo);

    return 'stats_rows=' . $reconciled . ' audience_views=' . $audience['page_views']
        . ' completed=' . $m['completed'] . ' events_purged=' . $m['purged']
        . ' links_checked=' . $links['checked'] . ' links_paused=' . $links['paused'] . ' views_daily=' . $statsDays . ' eli_purged=' . $eliPurged;
}));
