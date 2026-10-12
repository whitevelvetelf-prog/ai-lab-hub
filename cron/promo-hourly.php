<?php

declare(strict_types=1);

/**
 * AI LAB HUB — щогодинні дії реклами: перевірка посилань нових креативів, пауза за
 * вичерпанням балансу, завершення за бюджетом і датою, листи «кампанія стартувала» й
 * «низький баланс» (не частіше разу на добу). Запуск щогодини:
 *   php /home/gu621051/ailabhub-directory.com/www/cron/promo-hourly.php
 * Лише CLI. Денний бюджет окремо не «скидається»: витрати рахуються за поточну
 * київську добу з ad_stats_daily.
 */

require __DIR__ . '/_bootstrap.php';
require_once __DIR__ . '/../app/promo-mail.php';
require_once __DIR__ . '/../app/promo-linkcheck.php';

exit(promo_cron_run('promo-hourly', 600, static function (PDO $pdo): string {
    $r = promo_hourly($pdo);
    $parts = [];
    foreach ($r as $k => $v) {
        $parts[] = $k . '=' . $v;
    }

    return implode(' ', $parts);
}));
