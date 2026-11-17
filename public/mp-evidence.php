<?php

declare(strict_types=1);

/**
 * AI LAB HUB — файл доказів зі скарги правовласника (?id=<№ скарги>). Лише employee/admin.
 * Файли лежать поза webroot (поруч із фото оголошень, тека evidence/); ім'я — лише з mp_complaints.evidence_file.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

mp_require_staff();

$st = $pdo->prepare('SELECT evidence_file FROM mp_complaints WHERE id = :id');
$st->execute([':id' => (int) ($_GET['id'] ?? 0)]);
$name = (string) $st->fetchColumn();
if (preg_match('/^[a-f0-9]{32}\.(pdf|jpg|png)$/', $name, $m) !== 1) {
    mp_not_found();
}
$path = mpl_evidence_dir() . '/' . $name;
if (!is_file($path)) {
    mp_not_found();
}
header('X-Content-Type-Options: nosniff');
header("Content-Security-Policy: default-src 'none'");
header('Cache-Control: private, no-store');
header('X-Robots-Tag: noindex, nofollow');
header('Content-Type: ' . ['pdf' => 'application/pdf', 'jpg' => 'image/jpeg', 'png' => 'image/png'][$m[1]]);
header('Content-Disposition: inline; filename="evidence-' . (int) $_GET['id'] . '.' . $m[1] . '"');
header('Content-Length: ' . filesize($path));
readfile($path);
