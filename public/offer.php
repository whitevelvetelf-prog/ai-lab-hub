<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: сторінка пропозиції (?id=N).
 *
 * Розділ 'board' (оголошення користувачів) — app/mpb-offer.php. Розділ 'solution' нижче:
 * показує лише status='published'; чернетки, архів, невідомий id і вимкнений перемикач → 404.
 * Кнопка «Отримати» веде на get.php — єдину точку видачі (посилання/файл/контакт). Прямий URL
 * посилання, контакт і файл тут не виводяться. Рейтингів і відгуків немає.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';   // підключає app/marketplace.php

mp_public_or_staff_require();   // при public_enabled=false — лише employee/admin (публіка: 404)

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$lang = current_lang();
$id = (int) ($_GET['id'] ?? 0);

// Дошка оголошень (section='board'): окремий шаблон, контакти — лише через mp-contact.php.
$board = $id > 0 ? mpb_listing($pdo, $id, $lang) : null;
if ($board !== null) {
    include __DIR__ . '/../app/mpb-offer.php';
    exit;
}

$offer = $id > 0 ? mp_public_listing($pdo, $id, $lang) : null;
if ($offer === null) {
    mp_not_found();
}

$cover = mp_cover_url($offer['cover_image'] ?? null);
$skill = mp_skill_text($offer['skill_level'] ?? null);
$fallbackLang = (string) $offer['text_lang'] !== $lang ? (string) $offer['text_lang'] : null;
$langNames = active_languages();

$facts = [];
if (!empty($offer['platform'])) {
    $facts[] = [t('product_platform_label'), (string) $offer['platform']];
}
if ($skill !== null) {
    $facts[] = [t('product_skill_label'), $skill];
}
if (!empty($offer['license'])) {
    $facts[] = [t('mp_license_label'), (string) $offer['license']];
}
if ($offer['categories'] !== []) {
    $facts[] = [t('mp_categories_label'), implode(', ', array_column($offer['categories'], 'name'))];
}
if (!empty($offer['seller_name'])) {
    $facts[] = [t('mp_seller_label'), (string) $offer['seller_name']];
}

$blocks = [
    [t('product_features_title'), (string) ($offer['features'] ?? '')],
    [t('product_audience_title'), (string) ($offer['for_whom'] ?? '')],
];

?>
<!DOCTYPE html>
<html lang="<?= mp_e($lang) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= mp_e($offer['title']) ?> — <?= mp_e(t('title_marketplace')) ?></title>
    <?php if (!empty($offer['short_desc'])): ?>
        <meta name="description" content="<?= mp_e($offer['short_desc']) ?>">
    <?php endif; ?>
    <?php include __DIR__ . '/../app/header.php'; ?>
    <link rel="stylesheet" href="/assets/css/site-nav.css">
    <link rel="stylesheet" href="<?= css_asset('mp-public.css') ?>">
</head>
<body class="mp-body">
    <?php include __DIR__ . '/../app/site-header.php'; ?>

    <div class="mp-page mp-page--narrow">
        <h1 class="mp-title"><?= mp_e($offer['title']) ?></h1>

        <?php if ($fallbackLang !== null): ?>
            <p class="mp-note"><?= mp_e(sprintf(t('mp_original_lang'), $langNames[$fallbackLang] ?? strtoupper($fallbackLang))) ?></p>
        <?php endif; ?>

        <?php if ($cover !== null): ?>
            <img class="mp-offer__cover" src="<?= mp_e($cover) ?>" alt="<?= mp_e($offer['title']) ?>">
        <?php endif; ?>

        <?php if (!empty($offer['short_desc'])): ?>
            <p class="mp-offer__lead"><?= mp_e($offer['short_desc']) ?></p>
        <?php endif; ?>

        <div class="mp-offer__actions">
            <a class="mp-btn mp-btn--primary mp-btn--lg" href="get.php?id=<?= (int) $offer['id'] ?>" rel="nofollow"><?= mp_e(t('mp_get')) ?></a>
            <span class="mp-badge"><?= mp_e(t('price_free')) ?></span>
            <?php if ($offer['delivery_type'] === 'file'): ?>
                <p class="mp-offer__hint"><?= mp_e(t('mp_get_hint_file')) ?></p>
            <?php endif; ?>
        </div>

        <?php if ($facts !== []): ?>
            <div class="mp-facts">
                <?php foreach ($facts as [$label, $value]): ?>
                    <div class="mp-fact">
                        <p class="mp-fact__label"><?= mp_e($label) ?></p>
                        <p class="mp-fact__value"><?= mp_e($value) ?></p>
                    </div>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>

        <?php if (!empty($offer['full_desc'])): ?>
            <section class="mp-block">
                <p class="mp-text"><?= mp_e($offer['full_desc']) ?></p>
            </section>
        <?php endif; ?>

        <?php foreach ($blocks as [$heading, $text]): ?>
            <?php if (trim($text) !== ''): ?>
                <section class="mp-block">
                    <h2 class="mp-block__title"><?= mp_e($heading) ?></h2>
                    <p class="mp-text"><?= mp_e($text) ?></p>
                </section>
            <?php endif; ?>
        <?php endforeach; ?>
    </div>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
