<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: вітрина розділу «Готові рішення» (безкоштовні пропозиції платформи).
 * (Раніше — marketplace.php; тепер marketplace.php — дошка оголошень користувачів.)
 *
 * Категорії розділу 'solution', опубліковані пропозиції (status='published'), пошук за назвою (?q=).
 * Поки config/marketplace.php → public_enabled = false, сторінка віддає 404.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace.php';

mp_public_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$lang = current_lang();
$q = is_string($_GET['q'] ?? null) ? mb_substr(trim((string) $_GET['q']), 0, 100) : '';

$categories = mp_public_categories($pdo, $lang);
$offers = mp_public_listings($pdo, $lang, ['q' => $q, 'limit' => 60]);

?>
<!DOCTYPE html>
<html lang="<?= mp_e($lang) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= mp_e(t('title_marketplace')) ?></title>
    <?php include __DIR__ . '/../app/header.php'; ?>
    <link rel="stylesheet" href="/assets/css/site-nav.css">
    <link rel="stylesheet" href="<?= css_asset('mp-public.css') ?>">
</head>
<body class="mp-body">
    <?php include __DIR__ . '/../app/site-header.php'; ?>

    <div class="mp-page">
        <h1 class="mp-title"><?= mp_e(t('mpb_solutions_title')) ?></h1>
        <p class="mp-subtitle"><?= mp_e(t('mp_subtitle')) ?></p>

        <form class="mp-search" method="get" action="marketplace-solutions.php" role="search">
            <input class="mp-search__input" type="search" name="q" maxlength="100" value="<?= mp_e($q) ?>"
                   placeholder="<?= mp_e(t('mp_search_placeholder')) ?>" aria-label="<?= mp_e(t('mp_search_placeholder')) ?>">
            <button class="mp-btn mp-btn--primary" type="submit"><?= mp_e(t('mp_search_btn')) ?></button>
            <?php if ($q !== ''): ?>
                <a class="mp-btn" href="marketplace-solutions.php"><?= mp_e(t('mp_search_reset')) ?></a>
            <?php endif; ?>
        </form>

        <?php if ($categories !== []): ?>
            <h2 class="mp-section-title"><?= mp_e(t('mp_categories_title')) ?></h2>
            <ul class="mp-cats">
                <?php foreach ($categories as $c): ?>
                    <li>
                        <a class="mp-chip" href="marketplace-category.php?id=<?= (int) $c['id'] ?>">
                            <?= mp_e($c['name']) ?>
                            <span class="mp-chip__count"><?= (int) $c['cnt'] ?></span>
                        </a>
                    </li>
                <?php endforeach; ?>
            </ul>
        <?php endif; ?>

        <h2 class="mp-section-title"><?= mp_e(t('mp_offers_title')) ?></h2>
        <?php if ($offers === []): ?>
            <p class="mp-empty"><?= mp_e($q !== '' ? t('mp_empty_search') : t('mp_empty')) ?></p>
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
