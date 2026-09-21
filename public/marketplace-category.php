<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: пропозиції однієї категорії (?id=N), лише status='published'.
 * Неіснуюча/вимкнена категорія → 404; поки public_enabled = false — теж 404.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace.php';

mp_public_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$lang = current_lang();
$categoryId = (int) ($_GET['id'] ?? 0);

$category = null;
$categories = mp_public_categories($pdo, $lang);
foreach ($categories as $c) {
    if ($c['id'] === $categoryId) {
        $category = $c;
        break;
    }
}
if ($category === null) {
    mp_not_found();
}

$offers = mp_public_listings($pdo, $lang, ['category_id' => $categoryId, 'limit' => 100]);

?>
<!DOCTYPE html>
<html lang="<?= mp_e($lang) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= mp_e($category['name']) ?> — <?= mp_e(t('title_marketplace')) ?></title>
    <?php include __DIR__ . '/../app/header.php'; ?>
    <link rel="stylesheet" href="/assets/css/site-nav.css">
    <link rel="stylesheet" href="<?= css_asset('mp-public.css') ?>">
</head>
<body class="mp-body">
    <?php include __DIR__ . '/../app/site-header.php'; ?>

    <div class="mp-page">
        <a class="mp-back" href="marketplace-solutions.php"><?= mp_e(t('mp_back')) ?></a>

        <h1 class="mp-title"><?= mp_e($category['name']) ?></h1>

        <ul class="mp-cats">
            <li><a class="mp-chip" href="marketplace-solutions.php"><?= mp_e(t('mp_all_categories')) ?></a></li>
            <?php foreach ($categories as $c): ?>
                <li>
                    <a class="mp-chip<?= $c['id'] === $categoryId ? ' is-active' : '' ?>" href="marketplace-category.php?id=<?= (int) $c['id'] ?>">
                        <?= mp_e($c['name']) ?>
                        <span class="mp-chip__count"><?= (int) $c['cnt'] ?></span>
                    </a>
                </li>
            <?php endforeach; ?>
        </ul>

        <?php if ($offers === []): ?>
            <p class="mp-empty"><?= mp_e(t('mp_empty_category')) ?></p>
        <?php else: ?>
            <div class="mp-grid">
                <?php foreach ($offers as $card): ?>
                    <?php include __DIR__ . '/../app/mp-card.php'; ?>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </div>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
