<?php

declare(strict_types=1);

/**
 * AI LAB HUB — дії власника «Цифрового матеріалу» (POST + CSRF): remove (зняти), extend (продовжити).
 * Повертає в кабінет account.php#acc-assets.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/asset.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
$userId = mpb_require_login();
if (($_SERVER['REQUEST_METHOD'] ?? '') !== 'POST' || !mp_csrf_verify()) {
    header('Location: account.php#acc-assets', true, 303);
    exit;
}
$id = (int) ($_POST['id'] ?? 0);
$own = ast_own($pdo, $id, $userId);
if ($own === null) {
    mp_not_found();
}
$action = (string) ($_POST['action'] ?? '');
if ($action === 'remove' && ast_remove($pdo, $id, $userId, 'знято автором')) {
    mpb_flash('ok', ast_tr('removed_ok'));
} elseif ($action === 'extend' && ast_extend($pdo, $id, $userId)) {
    mpb_flash('ok', ast_tr('extended_ok'));
} else {
    mpb_flash('error', ast_tr('err_save'));
}
header('Location: account.php#acc-assets', true, 303);
exit;
