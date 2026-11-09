<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: публічна сторінка продавця (?id=N), app/mp-seller.php.
 *
 * Назва, логотип, короткий опис, мітка «перевірений», «на платформі з …», сайт (лише перевірені), усі живі оголошення
 * продавця за блоками. Без контактів і без оцінок. Сторінка прихована продавцем (page_public = 0), неактивний продавець,
 * невідомий id або вимкнений Marketplace → 404. Унікальні title і description.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/listing.php';
require_once __DIR__ . '/../app/mp-seller.php';
require_once __DIR__ . '/../app/promo.php';

mp_public_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$lang = current_lang();
$id = is_string($_GET['id'] ?? null) && ctype_digit((string) $_GET['id']) ? (int) $_GET['id'] : 0;
$seller = mpsl_get($pdo, $id);
if ($seller === null || !mpsl_is_public($seller)) {
    mp_not_found();
}
$groups = mpsl_listings_by_block($pdo, $id, $lang);
$total = array_sum(array_map(static fn(array $g): int => count($g['rows']), $groups));
$name = (string) $seller['display_name'];
$verified = (int) $seller['is_verified'] === 1 || (int) $seller['is_platform'] === 1;
$logo = mpsl_logo_url($seller['logo'] ?? null);
$bio = trim((string) ($seller['bio'] ?? ''));
$since = mpsl_since((string) $seller['created_at'], $lang);
analytics_log_view($pdo, 'marketplace_category', null, 'seller:' . $id);

$title = sprintf(t('mpsl_title'), $name);
$desc = $bio !== '' ? mb_substr((string) preg_replace('/\s+/u', ' ', $bio), 0, 280) : sprintf(t('mpsl_desc'), $name, $total);
mpt_open($title, $desc, 'mp-seller.php?id=' . $id, $total === 0, 'home');
?>
    <div class="mp-page">
        <?= mpt_crumbs([[t('mp_heading'), 'marketplace.php'], [$name, null]]) ?>
        <section class="mpsl-head">
            <?php if ($logo !== null): ?>
                <img class="mpsl-head__logo" src="<?= mp_e($logo) ?>" alt="<?= mp_e(sprintf(t('mpsl_logo_alt'), $name)) ?>" width="96" height="96">
            <?php else: ?>
                <span class="mpsl-head__logo mpsl-head__logo--empty" aria-hidden="true"><?= mp_e(mb_strtoupper(mb_substr($name, 0, 1))) ?></span>
            <?php endif; ?>
            <div class="mpsl-head__body">
                <h1 class="mp-title mpsl-head__name"><?= mp_e($name) ?></h1>
                <p class="mpsl-head__meta">
                    <?php if ($verified): ?><span class="mp-badge mpsl-verified"><?= mp_e(t('mpsl_verified')) ?></span><?php endif; ?>
                    <span><?= mp_e($since) ?></span>
                    <span><?= mp_e(mpt_count_label($total)) ?></span>
                </p>
                <?php if (mpsl_show_website($seller)): ?>
                    <p class="mpsl-head__site"><a href="<?= mp_e($seller['website_url']) ?>" rel="nofollow noopener ugc" target="_blank"><?= mp_e(parse_url((string) $seller['website_url'], PHP_URL_HOST) ?: $seller['website_url']) ?></a></p>
                <?php endif; ?>
            </div>
        </section>
        <?php if ($bio !== ''): ?>
            <p class="mp-text mp-text--pre mpsl-bio"><?= mp_e($bio) ?></p>
        <?php endif; ?>
        <p class="mp-note mp-note--box mp-note--disclaimer" role="note"><?= mp_e(t('mpsl_no_contacts_note')) ?></p>

        <?php if ($groups === []): ?>
            <p class="mp-empty"><?= mp_e(t('mpsl_empty')) ?></p>
        <?php endif; ?>
        <?php foreach ($groups as $g): ?>
            <h2 class="mp-section-title"><?= mp_e($g['block']['name']) ?> <span class="mp-chip__count"><?= count($g['rows']) ?></span></h2>
            <div class="mp-grid">
                <?php foreach ($g['rows'] as $card): ?><?= mpt_card_html($pdo, $card) ?><?php endforeach; ?>
            </div>
        <?php endforeach; ?>
    </div>
<?php mpt_close(); ?>
