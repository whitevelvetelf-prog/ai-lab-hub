<?php

declare(strict_types=1);

/**
 * AI LAB HUB — колишня вітрина «Готові рішення»: 301 на сторінку блока «Готові рішення» (marketplace-category.php?id=N).
 * Пошук ?q= зберігається.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/mp-legacy-redirect.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$block = mpt_block(mpt_tree($pdo, 'uk'), 'solution');
$q = is_string($_GET['q'] ?? null) ? mb_substr(trim((string) $_GET['q']), 0, 100) : '';
mp_legacy_redirect($block !== null ? 'marketplace-category.php' : 'marketplace.php',
    array_filter(['id' => $block['id'] ?? '', 'q' => $q], static fn($v): bool => $v !== ''), array_keys($_GET));
