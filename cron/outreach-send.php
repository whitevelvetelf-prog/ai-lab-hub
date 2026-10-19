<?php

declare(strict_types=1);

/**
 * AI LAB HUB — аутріч (блок M3), запуск кожні 5–10 хвилин:
 *   * відскоки: листи, які mail_queue остаточно не відправила → лід «Відскок», адреса в список заборон;
 *   * чернетки нагадувань (одне на лід, через N днів без відповіді) — їх ЗАТВЕРДЖУЄ людина;
 *   * диспетчер: щонайбільше ОДИН схвалений лист за запуск у mail_queue — лише якщо аутріч увімкнено й налаштовано,
 *     у вікні відправки, у межах денного ліміту, після випадкової паузи, і адреса не в списку заборон.
 * Самі листи відправляє cron/promo-mail.php. Без схвалення людиною нічого не надсилається.
 *   php /home/gu621051/ailabhub-directory.com/www/cron/outreach-send.php
 * Лише CLI.
 */

require __DIR__ . '/_bootstrap.php';
require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/outreach-mail.php';

exit(promo_cron_run('outreach-send', 240, static function (PDO $pdo): string {
    $bounced = omail_sync_queue($pdo);
    $followups = omail_followup_drafts($pdo);

    return 'відскоків=' . $bounced . ' нагадувань-чернеток=' . $followups . ' | ' . omail_dispatch($pdo);
}));
