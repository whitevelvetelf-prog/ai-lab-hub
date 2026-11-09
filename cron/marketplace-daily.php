<?php

declare(strict_types=1);

/**
 * AI LAB HUB — щоденне обслуговування оголошень компаній (вакансії, курси, послуги), блок M1:
 *   * опубліковані з минулим терміном → expired (зникають із видачі й sitemap);
 *   * лист «скоро спливає термін» (за 3 дні, один раз);
 *   * звіт власнику через 30 днів після публікації (перегляди й переходи, один раз);
 *   * етап 6: перерахунок mp_listings.price_usd за поточним курсом НБУ (app/mp-geo.php → mpg_refresh_price_usd);
 *   * Хвиля 1: salary_min_usd / salary_max_usd вакансій і місто з геодовідника (app/mp-jobs.php → mpj_refresh).
 * Листи стають у mail_queue — відправляє cron/promo-mail.php. Журнал — cron_runs (вкладка «Стан»).
 *   php /home/gu621051/ailabhub-directory.com/www/cron/marketplace-daily.php
 * Лише CLI.
 */

require __DIR__ . '/_bootstrap.php';
require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/listing.php';
require_once __DIR__ . '/../app/marketplace-board.php';   // підключає app/mp-geo.php

exit(promo_cron_run('marketplace-daily', 600, static function (PDO $pdo): string {
    $out = lst_daily($pdo);
    $n = mpg_refresh_price_usd($pdo);
    $j = mpj_refresh($pdo);   // Хвиля 1: зарплата вакансій у USD і місто з геодовідника

    return $out . ($n > 0 ? "; price_usd: $n" : '') . ($j > 0 ? "; salary_usd/place: $j" : '');
}));
