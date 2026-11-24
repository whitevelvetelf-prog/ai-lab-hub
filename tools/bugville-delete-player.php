<?php

declare(strict_types=1);

/**
 * AI LAB HUB — видалення ігрових даних «Багвіля» одного акаунта на запит гравця (CLI):
 *   php tools/bugville-delete-player.php <user_id>          — лише показати, скільки рядків буде видалено
 *   php tools/bugville-delete-player.php <user_id> --yes    — видалити (одна транзакція)
 * Акаунт сайту (users) не видаляється. Логіка — bv_delete_player_data() у app/bugville/bv-player.php.
 * Перед видаленням на хостингу — резервна копія таблиць bv_*.
 */

if (PHP_SAPI !== 'cli') {
    http_response_code(404);
    exit;
}

require_once __DIR__ . '/../app/bugville/bv-player.php';

$userId = filter_var($argv[1] ?? null, FILTER_VALIDATE_INT, ['options' => ['min_range' => 1]]);
if ($userId === false) {
    fwrite(STDERR, "Використання: php tools/bugville-delete-player.php <user_id> [--yes]\n");
    exit(2);
}
$apply = in_array('--yes', array_slice($argv, 2), true);

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$rows = bv_delete_player_data($pdo, (int) $userId, !$apply);
echo ($apply ? 'Видалено' : 'Буде видалено (перевірка, нічого не змінено)') . " для user_id $userId:\n";
$sum = 0;
foreach ($rows as $table => $n) {
    printf("  %-18s %s\n", $table, $n === null ? '— (таблиці ще немає)' : (string) $n);
    $sum += (int) $n;
}
echo "  разом: $sum\n";
if (!$apply) {
    echo "Щоб видалити, повторіть із --yes.\n";
}
