<?php

declare(strict_types=1);

/**
 * AI LAB HUB — оригінал «Цифрового матеріалу» ЛИШЕ для модератора (employee/admin; роль із БД).
 * Без змін і без кешування; для перевірки метаданих, якості й схожості. Кожен перегляд пишеться в журнал.
 *
 *   asset-original.php?id=N
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/asset.php';

if (!mp_is_staff()) {
    mp_not_found();
}
/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$id = (int) ($_GET['id'] ?? 0);
$row = $id > 0 ? ast_listing($pdo, $id, 'uk') : null;
$path = $row !== null ? ast_path('original', (string) $row['orig_name']) : null;
if ($path === null) {
    mp_not_found();
}
mp_log($pdo, $id, auth_user_id(), 'original_viewed', 'модерація');
header('Content-Type: ' . (string) $row['orig_mime']);
header('Content-Length: ' . (string) filesize($path));
header('Content-Disposition: inline; filename="original-' . $id . '.' . AST_MIME_EXT[(string) $row['orig_mime']] . '"');
header('Cache-Control: no-store, private');
header('X-Content-Type-Options: nosniff');
header('X-Robots-Tag: noindex, noai, noimageai');
readfile($path);
