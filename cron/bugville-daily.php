<?php

declare(strict_types=1);

/**
 * AI LAB HUB — щоденне обслуговування гри «Багвіль»: видаляє гостьові незараховані спроби, старші за 24 год
 * (єдиний DELETE гри, app/bugville/bv-attempts.php → bv_cleanup_guest_attempts). Журнал — cron_runs.
 *   php /home/gu621051/ailabhub-directory.com/www/cron/bugville-daily.php
 * Лише CLI. На хостинг і в розклад — лише після погодження власника.
 */

require __DIR__ . '/_bootstrap.php';
require_once __DIR__ . '/../app/bugville/bv-attempts.php';

exit(promo_cron_run('bugville-daily', 120, static function (PDO $pdo): string {
    return 'guest attempts deleted: ' . bv_cleanup_guest_attempts($pdo);
}));
