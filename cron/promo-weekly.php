<?php

declare(strict_types=1);

/**
 * AI LAB HUB — щотижневе обслуговування реклами:
 *   * повторні перевірки посилань неактивних креативів (пауза, модерація);
 *   * очищення журналів: ad_link_checks старші 180 днів, promo_event_log старші
 *     365 днів, надіслані листи mail_queue старші 90 днів, cron_runs старші 90 днів.
 *   php /home/gu621051/ailabhub-directory.com/www/cron/promo-weekly.php
 * Лише CLI.
 */

require __DIR__ . '/_bootstrap.php';
require_once __DIR__ . '/../app/promo-mail.php';
require_once __DIR__ . '/../app/promo-linkcheck.php';

exit(promo_cron_run('promo-weekly', 1500, static function (PDO $pdo): string {
    $links = promo_linkcheck_due($pdo, 'other', 500);
    $purge = static function (string $sql, int $days) use ($pdo): int {
        $st = $pdo->prepare($sql);
        $st->execute([':t' => gmdate('Y-m-d H:i:s', time() - $days * 86400)]);

        return $st->rowCount();
    };
    $checks = $purge('DELETE FROM ad_link_checks WHERE checked_at < :t', 180);
    $events = $purge('DELETE FROM promo_event_log WHERE created_at < :t', 365);
    $mails = $purge("DELETE FROM mail_queue WHERE status = 'sent' AND sent_at < :t", 90);
    $runs = $purge('DELETE FROM cron_runs WHERE started_at < :t', 90);

    return 'links_checked=' . $links['checked'] . ' links_paused=' . $links['paused']
        . ' purged: checks=' . $checks . ' events=' . $events . ' mails=' . $mails . ' runs=' . $runs;
}));
