<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: статистика оголошення (?id=N) — лише автору оголошення й admin (роль — за БД).
 *
 * За 7, 30 і 60 днів: перегляди (mp_listing_views_daily), відкриття контакту (mp_contact_reveals), додавання в обране
 * (mp_favorites за датою), переходи на сайт (вакансії / курси / послуги — mp_listing_stats_daily). Графік переглядів
 * за 60 днів — простий SVG (app/mp-stats.php). Перегляди власника й ботів (User-Agent) і HEAD-запити не рахуються.
 * Будь-хто інший (зокрема employee) — 404. Сторінка noindex.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/listing.php';
require_once __DIR__ . '/../app/mp-stats.php';

mp_public_or_staff_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';
header('Cache-Control: no-store');
header('X-Robots-Tag: noindex, nofollow');

$userId = mpb_require_login();
$id = is_string($_GET['id'] ?? null) && ctype_digit((string) $_GET['id']) ? (int) $_GET['id'] : 0;
$st = $pdo->prepare(
    "SELECT l.id, l.section, l.post_form, l.slug, l.status, s.user_id AS owner_id,
            COALESCE(NULLIF(tc.title, ''), ts.title) AS title
     FROM mp_listings l
     LEFT JOIN mp_sellers s ON s.id = l.seller_id
     LEFT JOIN mp_listing_translations tc ON tc.listing_id = l.id AND tc.lang = :lang
     LEFT JOIN mp_listing_translations ts ON ts.listing_id = l.id AND ts.lang = l.source_lang
     WHERE l.id = :id"
);
$st->execute([':id' => $id, ':lang' => current_lang()]);
$row = $st->fetch(PDO::FETCH_ASSOC);
$isOwner = $row !== false && $row['owner_id'] !== null && (int) $row['owner_id'] === $userId;
if ($row === false || (!$isOwner && mp_live_role() !== 'admin')) {
    mp_not_found();
}

$periods = mpst_periods($pdo, $id);
$series = mpst_series($pdo, $id, MPST_CHART_DAYS);
$isLst = mpt_is_lst($row);
$isAd = (string) $row['post_form'] === 'ad';
$metrics = ['views' => t('mpst_views')];
if ($isAd) {
    $metrics['reveals'] = t('mpst_reveals');
    $metrics['favorites'] = t('mpst_favorites');
}
if ($isLst) {
    $metrics['clicks'] = t('mpst_clicks');
}

mpb_open(sprintf(t('mpst_title'), (string) $row['title']), true, 'my');
?>
    <div class="mp-page mp-page--narrow">
        <p class="mp-hint"><a href="<?= mp_e($isLst ? 'account.php#acc-listings' : 'marketplace-my.php') ?>">← <?= mp_e(t('mpb_my_title')) ?></a></p>
        <h1 class="mp-title"><?= mp_e(t('mpst_heading')) ?></h1>
        <p class="mp-subtitle"><a href="<?= mp_e(mpt_listing_url($row)) ?>"><?= mp_e($row['title'] ?? ('#' . $id)) ?></a></p>

        <div class="mpst-table-wrap">
            <table class="mpst-table">
                <caption class="mp-visually-hidden"><?= mp_e(t('mpst_heading')) ?></caption>
                <thead><tr><th scope="col"></th><?php foreach (MPST_PERIODS as $d): ?><th scope="col" class="num"><?= mp_e(sprintf(t('mpst_days_n'), $d)) ?></th><?php endforeach; ?></tr></thead>
                <tbody>
                <?php foreach ($metrics as $k => $label): ?>
                    <tr><th scope="row"><?= mp_e($label) ?></th><?php foreach (MPST_PERIODS as $d): ?><td class="num"><?= (int) $periods[$d][$k] ?></td><?php endforeach; ?></tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>

        <h2 class="mp-section-title"><?= mp_e(sprintf(t('mpst_chart_title'), MPST_CHART_DAYS)) ?></h2>
        <?= mpst_chart_svg($series, sprintf(t('mpst_chart_title'), MPST_CHART_DAYS)) ?>
        <p class="mp-hint"><?= mp_e(t('mpst_note')) ?></p>
    </div>
<?php mpb_close(); ?>
