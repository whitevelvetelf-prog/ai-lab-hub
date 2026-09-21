<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: додати/прибрати з вибраного (POST + CSRF, лише залогінені).
 * back=fav → повернення на mp-favorites.php, інакше на offer.php?id=N.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';

mp_public_require();
mpb_require_post();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$userId = mpb_require_login();
$id = (int) ($_POST['id'] ?? 0);
$back = ($_POST['back'] ?? '') === 'fav' ? 'mp-favorites.php' : 'offer.php?id=' . $id;

$state = $id > 0 ? mpb_toggle_favorite($pdo, $userId, $id) : null;
if ($state === null) {
    mpb_flash('error', t('mpb_fav_unavailable'));
    mpb_redirect('mp-favorites.php');
}
mpb_flash('ok', t($state ? 'mpb_fav_added' : 'mpb_fav_removed'));
mpb_redirect($back);
