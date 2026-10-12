<?php

declare(strict_types=1);

/**
 * AI LAB HUB — відправка черги листів (mail_queue). Запуск кожні 5 хвилин:
 *   php /home/gu621051/ailabhub-directory.com/www/cron/promo-mail.php
 * Лише CLI (з веба — 404). Див. docs/PROMO_OPERATIONS.md.
 */

require __DIR__ . '/_bootstrap.php';
require_once __DIR__ . '/../app/promo-mail.php';

exit(promo_cron_run('promo-mail', 240, static function (PDO $pdo): string {
    $r = promo_mail_send_pending($pdo, 50);

    return 'sent=' . $r['sent'] . ' retry=' . $r['retry'] . ' failed=' . $r['failed'] . ' transport=' . promo_mail_config()['transport'];
}));
