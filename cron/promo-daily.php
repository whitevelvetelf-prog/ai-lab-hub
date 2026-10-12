<?php

declare(strict_types=1);

/**
 * AI LAB HUB — щоденне обслуговування реклами (о 03:10 за Києвом):
 *   * звірка лічильників ad_stats_daily із сирими подіями за вчорашню київську добу;
 *   * агрегати аудиторії для медіакіту (promo_audience_stats);
 *   * завершення кампаній із минулою датою, очищення ad_events старших за 30 днів;
 *   * добові повторні перевірки посилань активних креативів (з автопаузою).
 *   php /home/gu621051/ailabhub-directory.com/www/cron/promo-daily.php
 * Лише CLI.
 */

require __DIR__ . '/_bootstrap.php';
require_once __DIR__ . '/../app/promo-mail.php';
require_once __DIR__ . '/../app/promo-linkcheck.php';
require_once __DIR__ . '/../app/promo-audience.php';

exit(promo_cron_run('promo-daily', 1500, static function (PDO $pdo): string {
    $reconciled = promo_reconcile_stats($pdo, promo_today(-1));
    $audience = promo_audience_compute($pdo);
    $m = promo_maintenance($pdo);
    $links = promo_linkcheck_due($pdo, 'active', 300);

    return 'stats_rows=' . $reconciled . ' audience_views=' . $audience['page_views']
        . ' completed=' . $m['completed'] . ' events_purged=' . $m['purged']
        . ' links_checked=' . $links['checked'] . ' links_paused=' . $links['paused'];
}));
