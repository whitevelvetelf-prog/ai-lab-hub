<?php

declare(strict_types=1);

/**
 * AI LAB HUB — перевірка налаштувань (CLI): «налаштовано / не налаштовано / вимкнено», БЕЗ значень.
 *
 *   php scripts/config-check.php            — таблиця в консоль
 *   php scripts/config-check.php --strict   — код виходу 1, якщо є хоч одне «не налаштовано»
 *
 * Те саме показує кабінет адміністратора → «Стан сайту». Логіка — app/config-status.php.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

$root = dirname(__DIR__);
require_once $root . '/app/config-status.php';

$pdo = null;
try {
    $pdo = is_file($root . '/config/database.php') ? (require $root . '/config/database.php') : null;
} catch (Throwable $e) {
    $pdo = null;
}

$rows = config_status($pdo instanceof PDO ? $pdo : null);
$missing = 0;
$group = '';
foreach ($rows as $r) {
    if ($r['group'] !== $group) {
        $group = $r['group'];
        fwrite(STDOUT, "\n{$group}\n");
    }
    if ($r['state'] === 'missing') {
        $missing++;
    }
    $mark = ['ok' => '[OK]  ', 'missing' => '[--]  ', 'off' => '[off] '][$r['state']] ?? '      ';
    $name = function_exists('mb_str_pad') ? mb_str_pad($r['name'], 52) : str_pad($r['name'], 52);
    fwrite(STDOUT, sprintf("  %s%s %s%s\n", $mark, $name,config_status_label($r['state']), $r['hint'] !== '' ? ' (' . $r['hint'] . ')' : ''));
}
fwrite(STDOUT, "\nНе налаштовано: {$missing}. Значення не друкуються.\n");
exit(in_array('--strict', $argv, true) && $missing > 0 ? 1 : 0);
