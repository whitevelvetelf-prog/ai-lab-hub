<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: головна розділу і розширений пошук.
 *
 * Без параметрів пошуку — головна, як головна каталогу: пошук, кнопки «Подати оголошення» і «Безкоштовні рішення»,
 * сітка блоків-категорій (app/mp-tree.php; лічильник — живі оголошення блока) і «Свіжі оголошення» (до MPT_FRESH).
 * Блок → marketplace-category.php?id=N (підкатегорії) → підкатегорія (список по 20) → оголошення.
 * З параметрами (q, section — блок, cat — підкатегорія, price_type, price_min/price_max у USD, country, place, radius,
 * format, listing_lang, with_photos, verified, sort, page; app/mp-search.php) — результати з усіх джерел:
 * оголошення користувачів, вакансії/курси/послуги компаній, матеріали платформи. Пагінація по 12.
 * Старі адреси (category=solutions|N, sub, section=board|solutions) — 301 на сторінку блока чи підкатегорії.
 * Поки config/marketplace.php → public_enabled = false — 404. Платформа в угодах не бере участі.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/listing.php';
require_once __DIR__ . '/../app/promo.php';
require_once __DIR__ . '/../app/mp-search.php';
require_once __DIR__ . '/../app/mp-geo-form.php';
require_once __DIR__ . '/../app/mp-legacy-redirect.php';

mp_public_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$lang = current_lang();
$userId = auth_user_id();
$tree = mpt_tree($pdo, $lang);

// Старі адреси → сторінка блока / підкатегорії (301).
$g = static fn(string $k): string => is_string($_GET[$k] ?? null) ? (string) $_GET[$k] : '';
$legacyId = 0;
if ($g('category') === 'solutions' || $g('section') === 'solutions') {
    $legacyId = (int) ($g('sub') ?: $g('cat')) ?: (int) (mpt_block($tree, 'solution')['id'] ?? 0);
} elseif ($g('section') === 'board' || ctype_digit($g('category'))) {
    $legacyId = (int) ($g('cat') ?: $g('category'));
    $legacyId = $legacyId ?: -1;
}
if ($legacyId !== 0) {
    $keep = array_intersect_key($_GET, array_flip(['q', 'sort']));
    if ($legacyId > 0 && mpt_node($tree, $legacyId) !== null) {
        mp_legacy_redirect('marketplace-category.php', ['id' => $legacyId] + $keep, array_keys($_GET));
    }
    mp_legacy_redirect('marketplace.php', $keep, array_keys($_GET));
}

$isHub = array_intersect(array_keys($_GET), MPB_SEARCH_KEYS) === [];

if ($isHub) {
    // ===== Головна Marketplace =====
    $counts = mpt_counts($pdo);
    $fresh = mpt_search($pdo, $lang, [], 1, MPT_FRESH);
    analytics_log_view($pdo, 'marketplace_home', null, 'hub');
    mpt_open(t('mpt_home_title'), t('mpt_home_desc'), 'marketplace.php', false, 'home');
    ?>
    <div class="mp-page">
        <h1 class="mp-title"><?= mp_e(t('mp_heading')) ?></h1>
        <p class="mp-subtitle"><?= mp_e(t('mpt_home_subtitle')) ?></p>
        <?= mpt_search_form('marketplace.php', '') ?>
        <?= mpt_cta_html($tree) ?>
        <?= mpb_flash_html() ?>
        <h2 class="mp-section-title"><?= mp_e(t('mpt_blocks_title')) ?></h2>
        <?= mpt_tiles(mpt_home_tiles($tree, $counts), t('mpt_blocks_title')) ?>
        <?php if ($fresh['rows'] !== []): ?>
            <h2 class="mp-section-title"><?= mp_e(t('mpt_fresh')) ?></h2>
            <div class="mp-grid">
                <?php foreach ($fresh['rows'] as $card): ?><?= mpt_card_html($pdo, $card) ?><?php endforeach; ?>
            </div>
        <?php endif; ?>
        <p class="mp-note mp-note--box mp-note--disclaimer" role="note"><?= mp_e(t('mpb_disclaimer')) ?></p>
    </div>
    <?php
    mpt_close();
    exit;
}

// ===== Розширений пошук =====
$geoReady = mpg_ready($pdo);
$prefs = $geoReady ? mpg_prefs($pdo, $userId) : ['saved' => false, 'units' => 'km'];
$filters = mpb_search_filters($pdo, $_GET, $lang, $prefs);
$page = $filters['page'];
$result = mpb_search($pdo, $lang, $filters, $page);
$hasFilters = mpb_search_has_filters($filters);
$place = $filters['geo']['place'];
$placeLabel = $place !== null ? (mpg_labels($pdo, [$place['id']], $lang)[$place['id']]['label'] ?? '') : '';
$countries = $geoReady ? mpg_countries($pdo, $lang) : [];
$selBlock = $filters['section'] !== '' ? mpt_block($tree, $filters['section']) : null;
$selSubs = $selBlock['children'] ?? [];

// Облік переглядів і реклама: пошук → marketplace_search.
$mpSections = $filters['section'] !== '' ? [$filters['section'] === 'solution' ? 'solutions' : $filters['section']] : ['board', 'solutions'];
analytics_log_view($pdo, 'marketplace_search', null, implode(',', $mpSections));

/** Посилання зі збереженням фільтрів ($over — замінити параметри; null / '' / 0 — прибрати). */
$url = static function (array $over = []) use ($filters): string {
    $q = $filters['url'];
    foreach ($over as $k => $val) {
        if ($val === null || $val === '' || $val === 0) {
            unset($q[$k]);
        } else {
            $q[$k] = $val;
        }
    }
    // Явне «будь-де» має пережити перехід, інакше знову підставиться збережене місце.
    if (!isset($q['country']) && !isset($q['place']) && !isset($q['format'])) {
        $q['country'] = '';
    }

    return 'marketplace.php?' . http_build_query($q);
};
$pageUrl = static fn(int $p): string => $url(['page' => $p > 1 ? $p : null]);

$priceLabels = ['none' => t('mpb_pt_none'), 'free' => t('mpb_pt_free'), 'fixed' => t('mpb_pt_fixed'), 'negotiable' => t('mpb_pt_negotiable'), 'exchange' => t('mpb_pt_exchange')];
$sortLabels = ['new' => t('mpb_sort_new'), 'price_asc' => t('mpb_sort_cheap'), 'price_desc' => t('mpb_sort_expensive')];
if ($place !== null) {
    $sortLabels['distance'] = t('mpg_sort_distance');
}
$unitLabel = t($filters['units'] === 'mi' ? 'mpg_unit_mi' : 'mpg_unit_km');

$heading = $filters['q'] !== '' ? sprintf(t('mpt_search_title_q'), $filters['q']) : t('mpt_search_title');
mpt_open($heading . ' — ' . t('title_marketplace'), t('mpt_home_desc'), 'marketplace.php', true, 'home');
?>
    <div class="mp-page">
        <?= mpt_crumbs([[t('mp_heading'), 'marketplace.php'], [t('mpt_search_title'), null]]) ?>
        <h1 class="mp-title"><?= mp_e($heading) ?></h1>
        <?php // Платформа не бере участі в угодах — завжди вгорі, до списку. ?>
        <p class="mp-note mp-note--box mp-note--disclaimer" role="note"><?= mp_e(t('mpb_disclaimer')) ?></p>

        <?= mpb_flash_html() ?>

        <form class="mp-filters" method="get" action="marketplace.php" role="search">
            <div class="mp-field mp-field--grow">
                <label class="mp-label" for="f_q"><?= mp_e(t('mpb_f_search')) ?></label>
                <input class="mp-input" type="search" id="f_q" name="q" maxlength="100" value="<?= mp_e($filters['q']) ?>" placeholder="<?= mp_e(t('mp_search_placeholder')) ?>">
            </div>
            <div class="mp-field">
                <label class="mp-label" for="f_section"><?= mp_e(t('mpb_f_category')) ?></label>
                <select class="mp-input" id="f_section" name="section">
                    <option value=""><?= mp_e(t('mp_all_categories')) ?></option>
                    <?php foreach ($tree as $b): ?>
                        <option value="<?= mp_e($b['section']) ?>"<?= $filters['section'] === $b['section'] ? ' selected' : '' ?>><?= mp_e($b['name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <?php if ($selSubs !== []): ?>
            <div class="mp-field">
                <label class="mp-label" for="f_cat"><?= mp_e(t('mpt_subcategory')) ?></label>
                <select class="mp-input" id="f_cat" name="cat">
                    <option value=""><?= mp_e(t('mpt_all_subcategories')) ?></option>
                    <?php foreach ($selSubs as $c): ?>
                        <option value="<?= (int) $c['id'] ?>"<?= $filters['cat'] === $c['id'] ? ' selected' : '' ?>><?= mp_e($c['name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <?php endif; ?>
            <?php if ($geoReady): ?>
            <div class="mp-field mp-field--grow">
                <label class="mp-label" for="f_place"><?= mp_e(t('mpg_f_place')) ?></label>
                <div class="mp-geo-loc" id="f_place_wrap">
                    <?= mpg_picker_html('place', $place !== null ? (string) $place['id'] : '', $placeLabel, 'city', $lang, 'f_place', t('mpg_f_place')) ?>
                    <button class="mp-btn" type="button" data-geo-near="f_place_wrap" data-csrf="<?= mp_e(mp_csrf_token()) ?>"
                            data-msg-wait="<?= mp_e(t('mpg_near_wait')) ?>" data-msg-fail="<?= mp_e(t('mpg_near_fail')) ?>" data-msg-denied="<?= mp_e(t('mpg_near_denied')) ?>"><?= mp_e(t('mpg_near_btn')) ?></button>
                    <span class="mp-geo-status" data-geo-status aria-live="polite"></span>
                </div>
            </div>
            <div class="mp-field">
                <label class="mp-label" for="f_radius"><?= mp_e(t('mpg_f_radius')) ?></label>
                <select class="mp-input mp-input--short" id="f_radius" name="radius">
                    <?php foreach (MPG_RADII as $r): ?>
                        <option value="<?= $r ?>"<?= $filters['radius'] === $r ? ' selected' : '' ?>><?= $r ?> <?= mp_e($unitLabel) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="mp-field">
                <label class="mp-label" for="f_country"><?= mp_e(t('mpg_f_country')) ?></label>
                <select class="mp-input" id="f_country" name="country">
                    <option value=""><?= mp_e(t('mpg_anywhere')) ?></option>
                    <?php foreach ($countries as $code => $name): ?>
                        <option value="<?= mp_e($code) ?>"<?= $filters['country'] === $code ? ' selected' : '' ?>><?= mp_e($name) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="mp-field">
                <label class="mp-label" for="f_format"><?= mp_e(t('mpg_f_format')) ?></label>
                <select class="mp-input" id="f_format" name="format">
                    <option value="any"><?= mp_e(t('mpg_fmt_any')) ?></option>
                    <?php foreach (MPG_FORMATS as $fm): ?>
                        <option value="<?= $fm ?>"<?= $filters['format'] === $fm ? ' selected' : '' ?>><?= mp_e(t('mpg_only_' . $fm)) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <?php endif; ?>
            <div class="mp-field">
                <label class="mp-label" for="f_sort"><?= mp_e(t('mpb_f_sort')) ?></label>
                <select class="mp-input" id="f_sort" name="sort">
                    <?php foreach ($sortLabels as $k => $label): ?>
                        <option value="<?= mp_e($k) ?>"<?= $filters['sort'] === $k ? ' selected' : '' ?>><?= mp_e($label) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <details class="mp-filters__more"<?= ($filters['price_type'] !== '' || $filters['price_min'] !== null || $filters['price_max'] !== null || $filters['listing_lang'] !== '' || $filters['with_photos'] || $filters['verified']) ? ' open' : '' ?>>
                <summary><?= mp_e(t('mpg_more_filters')) ?></summary>
                <div class="mp-filters__grid">
                    <div class="mp-field">
                        <label class="mp-label" for="f_pt"><?= mp_e(t('mpb_f_price_type')) ?></label>
                        <select class="mp-input" id="f_pt" name="price_type">
                            <option value=""><?= mp_e(t('mp_all_categories')) ?></option>
                            <?php foreach ($priceLabels as $k => $label): ?>
                                <option value="<?= mp_e($k) ?>"<?= $filters['price_type'] === $k ? ' selected' : '' ?>><?= mp_e($label) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="mp-field">
                        <label class="mp-label" for="f_min"><?= mp_e(t($geoReady ? 'mpg_f_price_usd' : 'mpb_f_price_range')) ?></label>
                        <div class="mp-inline">
                            <input class="mp-input mp-input--num" type="text" inputmode="decimal" id="f_min" name="price_min" maxlength="12" value="<?= $filters['price_min'] !== null ? mp_e($filters['price_min']) : '' ?>" placeholder="<?= mp_e(t('mpb_from')) ?>" aria-label="<?= mp_e(t('mpb_from')) ?>">
                            <input class="mp-input mp-input--num" type="text" inputmode="decimal" name="price_max" maxlength="12" value="<?= $filters['price_max'] !== null ? mp_e($filters['price_max']) : '' ?>" placeholder="<?= mp_e(t('mpb_to')) ?>" aria-label="<?= mp_e(t('mpb_to')) ?>">
                        </div>
                    </div>
                    <div class="mp-field">
                        <label class="mp-label" for="f_ll"><?= mp_e(t('mpg_f_listing_lang')) ?></label>
                        <select class="mp-input" id="f_ll" name="listing_lang">
                            <option value=""><?= mp_e(t('mpg_any_lang')) ?></option>
                            <?php foreach (MPG_LISTING_LANGS as $ll): ?>
                                <option value="<?= $ll ?>"<?= $filters['listing_lang'] === $ll ? ' selected' : '' ?>><?= mp_e(t('mpg_lang_' . $ll)) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <div class="mp-field mp-field--check">
                        <label class="mp-check"><input type="checkbox" name="with_photos" value="1"<?= $filters['with_photos'] ? ' checked' : '' ?>> <span><?= mp_e(t('mpg_f_with_photos')) ?></span></label>
                        <label class="mp-check"><input type="checkbox" name="verified" value="1"<?= $filters['verified'] ? ' checked' : '' ?>> <span><?= mp_e(t('mpg_f_verified')) ?></span></label>
                    </div>
                </div>
            </details>
            <div class="mp-actions mp-actions--tight">
                <button class="mp-btn mp-btn--primary" type="submit"><?= mp_e(t('mp_search_btn')) ?></button>
                <?php if ($hasFilters || $filters['sort'] !== 'new'): ?>
                    <a class="mp-btn" href="marketplace.php?country="><?= mp_e(t('mp_search_reset')) ?></a>
                <?php endif; ?>
            </div>
        </form>
        <?php if ($geoReady): ?>
            <div class="mp-geo-remember">
                <?php if ($filters['from_prefs'] && $place !== null): ?>
                    <p class="mp-hint"><?= mp_e(sprintf(t('mpg_using_saved'), $placeLabel)) ?> <a href="marketplace.php?country="><?= mp_e(t('mpg_anywhere')) ?></a> · <a href="mp-settings.php"><?= mp_e(t('mpg_settings_link')) ?></a></p>
                <?php elseif ($place !== null && (int) ($prefs['place_id'] ?? 0) !== $place['id']): ?>
                    <form method="post" action="mp-settings.php" class="mp-inline">
                        <?= mp_csrf_field() ?>
                        <input type="hidden" name="action" value="remember">
                        <input type="hidden" name="place_id" value="<?= (int) $place['id'] ?>">
                        <input type="hidden" name="radius_km" value="<?= (int) $filters['radius'] ?>">
                        <input type="hidden" name="back" value="<?= mp_e($url()) ?>">
                        <button class="mp-btn" type="submit"><?= mp_e(sprintf(t('mpg_remember_btn'), $placeLabel)) ?></button>
                    </form>
                <?php else: ?>
                    <p class="mp-hint"><a href="mp-settings.php"><?= mp_e(t('mpg_settings_link')) ?></a></p>
                <?php endif; ?>
            </div>
            <script src="/assets/js/mp-geo.js?v=<?= (int) @filemtime(__DIR__ . '/assets/js/mp-geo.js') ?>" defer></script>
        <?php endif; ?>

        <?php
        // Реклама в маркетплейсі — лише коли marketplace_public = 1 і місце ввімкнене (promo_slot
        // інакше порожній; адмін із ?promo_preview=1 бачить блоки завжди). Чітко відмінна від оголошень.
        ?>
        <p class="mp-count"><?= mp_e(sprintf(t('mpb_found'), $result['total'])) ?></p>

        <?php if ($result['rows'] === []): ?>
            <p class="mp-empty"><?= mp_e($hasFilters ? t('mp_empty_search') : t('mpb_empty')) ?></p>
        <?php else: ?>
            <div class="mp-grid">
                <?php foreach ($result['rows'] as $card): ?>
                    <?php if (($card['kind'] ?? '') === 'lst'): ?><?= lst_card_html($card) ?><?php else: ?><?php include __DIR__ . '/../app/mpb-card.php'; ?><?php endif; ?>
                <?php endforeach; ?>
            </div>

            <?php if ($result['pages'] > 1): ?>
                <nav class="mp-pager" aria-label="<?= mp_e(t('mpb_pages')) ?>">
                    <?php if ($result['page'] > 1): ?><a class="mp-btn" href="<?= mp_e($pageUrl($result['page'] - 1)) ?>" rel="prev">←</a><?php endif; ?>
                    <?php for ($p = 1; $p <= $result['pages']; $p++): ?>
                        <?php if ($p === 1 || $p === $result['pages'] || abs($p - $result['page']) <= 2): ?>
                            <a class="mp-btn<?= $p === $result['page'] ? ' mp-btn--primary' : '' ?>" href="<?= mp_e($pageUrl($p)) ?>"<?= $p === $result['page'] ? ' aria-current="page"' : '' ?>><?= $p ?></a>
                        <?php elseif (abs($p - $result['page']) === 3): ?>
                            <span class="mp-pager__gap">…</span>
                        <?php endif; ?>
                    <?php endfor; ?>
                    <?php if ($result['page'] < $result['pages']): ?><a class="mp-btn" href="<?= mp_e($pageUrl($result['page'] + 1)) ?>" rel="next">→</a><?php endif; ?>
                </nav>
            <?php endif; ?>
        <?php endif; ?>

        <?= $geoReady ? mpg_attribution_html() : '' ?>
    </div>
<?php mpt_close(); ?>
