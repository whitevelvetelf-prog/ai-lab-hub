<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: листи «нові оголошення за збереженим пошуком» (Хвиля 1, app/mp-saved.php).
 *
 *   Працює, лише коли в config/marketplace.php 'saved_search_email_enabled' => true, задано 'saved_search_secret'
 *   (≥ 16 символів) і 'site_url'. Інакше нічого не надсилає й пише «disabled».
 *   Для пошуків з notify_email = 1: оголошення, опубліковані після last_notified_at; не частіше 1 листа на добу на
 *   користувача; до 5 назв і лічильник на пошук, посилання на пошук і на відписку; без контактів авторів.
 *   Не більше saved_search_mail_batch листів за запуск. Локально mail_transport = 'log' → storage/marketplace-mail.log.
 *
 * Запуск (на хостингу cron НЕ ввімкнено — див. database/MARKETPLACE_HOSTING.md):
 *   CLI:  php /шлях/до/проєкту/public/mp-cron-saved-searches.php        (раз на день)
 *   HTTP: mp-cron-saved-searches.php?token=<cron_token>                (лише якщо cron_token непорожній; інакше 404)
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/listing.php';
require_once __DIR__ . '/../app/mp-saved.php';

$isCli = PHP_SAPI === 'cli';
if (!$isCli) {
    $token = (string) (mp_config()['cron_token'] ?? '');
    $given = is_string($_GET['token'] ?? null) ? (string) $_GET['token'] : '';
    if ($token === '' || !hash_equals($token, $given)) {
        mp_not_found();
    }
    header('Content-Type: text/plain; charset=utf-8');
    header('X-Robots-Tag: noindex, nofollow');
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

@set_time_limit(300);
$batch = max(1, min(500, (int) (mp_config()['saved_search_mail_batch'] ?? 50)));
$r = mpss_notify_run($pdo, $batch, 'uk');
echo date('Y-m-d H:i:s') . ($r['disabled'] ? ' saved-search mail: disabled' : sprintf(' saved-search mail: users %d, sent %d, skipped %d, failed %d', $r['users'], $r['sent'], $r['skipped'], $r['failed'])) . "\n";
