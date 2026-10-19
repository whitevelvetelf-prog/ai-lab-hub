<?php

declare(strict_types=1);

/**
 * AI LAB HUB — щоденний збір лідів (блок M2): усі ввімкнені джерела (не частіше їхнього інтервалу, з ETag),
 * потім пошук публічних контактів для до 10 схвалених лідів без контактів (1 запит/с, robots.txt).
 * Нічого не надсилає. Журнал — cron_runs (вкладка «Стан»).
 *   php /home/gu621051/ailabhub-directory.com/www/cron/outreach-daily.php
 * Лише CLI.
 */

require __DIR__ . '/_bootstrap.php';
require_once __DIR__ . '/../app/outreach.php';

exit(promo_cron_run('outreach-daily', 1500, static function (PDO $pdo): string {
    try {
        $pdo->exec('SET time_zone = @@global.time_zone');
    } catch (Throwable) {
    }
    $sources = outreach_run_all($pdo);
    $ids = $pdo->query(
        "SELECT id FROM outreach_leads WHERE status = 'approved' AND company_website IS NOT NULL AND contacts_checked_at IS NULL ORDER BY id LIMIT 10"
    )->fetchAll(PDO::FETCH_COLUMN);
    $found = 0;
    foreach ($ids as $id) {
        $found += (int) outreach_find_contacts($pdo, (int) $id)['ok'];
    }

    return mb_substr($sources, 0, 700) . ' | контакти: перевірено ' . count($ids) . ', знайдено ' . $found;
}));
