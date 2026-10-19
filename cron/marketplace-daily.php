<?php

declare(strict_types=1);

/**
 * AI LAB HUB — щоденне обслуговування оголошень компаній (вакансії, курси, послуги), блок M1:
 *   * опубліковані з минулим терміном → expired (зникають із видачі й sitemap);
 *   * лист «скоро спливає термін» (за 3 дні, один раз);
 *   * звіт власнику через 30 днів після публікації (перегляди й переходи, один раз).
 * Листи стають у mail_queue — відправляє cron/promo-mail.php. Журнал — cron_runs (вкладка «Стан»).
 *   php /home/gu621051/ailabhub-directory.com/www/cron/marketplace-daily.php
 * Лише CLI.
 */

require __DIR__ . '/_bootstrap.php';
require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/listing.php';

exit(promo_cron_run('marketplace-daily', 600, static function (PDO $pdo): string {
    return lst_daily($pdo);
}));
