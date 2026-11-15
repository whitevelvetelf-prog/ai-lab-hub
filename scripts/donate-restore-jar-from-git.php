<?php

declare(strict_types=1);

/**
 * AI LAB HUB — відновити посилання на банку monobank у ЛОКАЛЬНІЙ БД з історії git (лише CLI).
 *
 *   php scripts/donate-restore-jar-from-git.php [--enable]
 *
 * Джерело: старий public/donate.php у коміті bb1834d (до переходу на site_settings у ee211d3,
 * 2026-10-11), де посилання було зашите в коді. Значення в цьому файлі НЕМАЄ і скрипт його
 * НЕ друкує — лише «є / порожнє / відсутнє».
 *
 * Пише лише ключ donate_jar_url і лише якщо він порожній або відсутній (наявне значення
 * не перезаписується). --enable — також увімкнути сторінку (donate_enabled = 1).
 * Номер картки та інші реквізити не відновлюються й не читаються.
 *
 * На хостингу git немає: там посилання вставляє власниця в Кабінет → Донати.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once __DIR__ . '/../app/donations.php';

const DONATE_JAR_SOURCE = 'bb1834d:public/donate.php';

$root = dirname(__DIR__);
$src = shell_exec('git -C ' . escapeshellarg($root) . ' show ' . escapeshellarg(DONATE_JAR_SOURCE) . ' 2>' . (PHP_OS_FAMILY === 'Windows' ? 'NUL' : '/dev/null'));
$url = '';
if (is_string($src) && preg_match("#\\\$monobankUrl\s*=\s*'(https://[^']+)'#", $src, $m)) {
    $url = $m[1];
}
if (!donate_jar_url_ok($url)) {
    echo "Посилання в історії git (" . DONATE_JAR_SOURCE . "): відсутнє або некоректне. Нічого не змінено.\n";
    exit(1);
}
echo "Посилання в історії git: є (перевірку https + домен monobank пройдено).\n";

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$before = donate_status($pdo);
echo "Локальна БД до: посилання — {$before['jar']}, сторінку " . ($before['enabled'] ? 'ввімкнено' : 'вимкнено') . ".\n";

$values = [];
if ($before['jar'] !== 'є') {
    $values['donate_jar_url'] = $url;
}
if (in_array('--enable', $argv, true) && !$before['enabled']) {
    $values['donate_enabled'] = '1';
}
if ($values === []) {
    echo "Нічого не змінено (наявне значення не перезаписується).\n";
    exit(0);
}
site_settings_save($pdo, $values);
$after = donate_status($pdo);
echo "Локальна БД після: посилання — {$after['jar']}, сторінку " . ($after['enabled'] ? 'ввімкнено' : 'вимкнено')
    . ', донати ' . ($after['configured'] ? 'налаштовано' : 'не налаштовано') . ".\n";
