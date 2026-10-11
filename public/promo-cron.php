<?php

declare(strict_types=1);

/**
 * AI LAB HUB — обслуговування відеореклами (app/promo.php → promo_maintenance):
 * завершує кампанії з минулою датою завершення й видаляє сирі події ad_events,
 * старші за 30 днів (агрегати ad_stats_daily лишаються).
 *
 * Запуск:
 *   CLI / cron:  php /шлях/до/проєкту/public/promo-cron.php        (рекомендовано, раз на добу)
 *   HTTP:        promo-cron.php?key=<cron_key з config/promo.php>
 *                — лише якщо cron_key непорожній; інакше 404.
 */

require_once __DIR__ . '/../app/promo.php';

if (PHP_SAPI !== 'cli') {
    $key = promo_config()['cron_key'];
    $given = is_string($_GET['key'] ?? null) ? $_GET['key'] : '';
    if ($key === '' || !hash_equals($key, $given)) {
        http_response_code(404);
        exit;
    }
    header('Content-Type: text/plain; charset=utf-8');
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$r = promo_maintenance($pdo);
echo date('Y-m-d H:i:s') . ' completed: ' . $r['completed'] . ' events_purged: ' . $r['purged'] . "\n";
