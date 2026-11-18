<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: строк зберігання повідомлень (config 'messages_retention_days', 365).
 *
 * Розмови без нових повідомлень довше за строк видаляються разом із повідомленнями, станами учасників, обліком листів
 * і знімками ЗАКРИТИХ скарг (msg_retention_cleanup, app/mp-messages.php). Розмови з відкритою скаргою чекають розгляду.
 * Працює й коли функцію вимкнено (якщо міграцію застосовано): дані не мають лежати довше за строк.
 *
 * Запуск:
 *   CLI / cron:  php /шлях/до/проєкту/public/mp-cron-messages.php          (раз на добу)
 *   HTTP:        mp-cron-messages.php?token=<cron_token з config/marketplace.php> — лише якщо cron_token непорожній.
 * Вивід — лише кількості (без тексту повідомлень).
 */

require_once __DIR__ . '/../app/marketplace.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/mp-messages.php';

$isCli = PHP_SAPI === 'cli';
if (!$isCli) {
    $token = (string) (mp_config()['cron_token'] ?? '');
    $given = is_string($_GET['token'] ?? null) ? (string) $_GET['token'] : '';
    if ($token === '' || !hash_equals($token, $given)) {
        mp_not_found();
    }
    header('Content-Type: text/plain; charset=utf-8');
    header('Cache-Control: no-store');
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
if (!msg_ready($pdo)) {
    echo date('Y-m-d H:i:s') . " messages: migration not applied\n";
    exit;
}
$r = msg_retention_cleanup($pdo);
echo date('Y-m-d H:i:s') . ' retention_days: ' . (int) msg_cfg('messages_retention_days') . ' conversations_deleted: ' . $r['conversations'] . ' messages_deleted: ' . $r['messages'] . "\n";
