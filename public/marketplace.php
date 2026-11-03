<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: дошка оголошень (у стилі OLX; публікують користувачі) разом із Готовими AI-рішеннями
 * платформи (section='solution', автор — AI LAB HUB, безкоштовно).
 *
 * Оголошення — лише status='published' І expires_at > NOW(); рішення — status='published'. Розширений пошук
 * (етап 6, усе через GET і білі списки — app/mp-search.php): q, section, cat, price_type, price_min/price_max (USD),
 * country, place, radius, format, listing_lang, with_photos, verified, sort (new|price_asc|price_desc|distance), page.
 * Старі посилання (category, sub, min, max, city, remote, sort=cheap|expensive) працюють як синоніми.
 * Без параметрів місця підставляються налаштування відвідувача (mp-settings.php / cookie mp_loc). Пагінація по 12.
 * Поки config/marketplace.php → public_enabled = false — 404. Платформа в угодах не бере участі.
 * Колишні вітрини рішень marketplace-solutions.php / marketplace-category.php — 301 сюди.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/promo.php';
require_once __DIR__ . '/../app/mp-search.php';
require_once __DIR__ . '/../app/mp-geo-form.php';

mp_public_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$lang = current_lang();
$userId = auth_user_id();
// Розширений пошук (етап 6): усі параметри — за білими списками (app/mp-search.php); без міграцій — без географії.
$geoReady = mpg_ready($pdo);
$prefs = $geoReady ? mpg_prefs($pdo, $userId) : ['saved' => false, 'units' => 'km'];
$filters = mpb_search_filters($pdo, $_GET, $lang, $prefs);
$isSolutions = $filters['section'] === MPB_SOLUTIONS;
$categories = mpb_categories($pdo, $lang);
$solutionCats = $isSolutions ? mp_public_categories($pdo, $lang) : [];
$boardCat = $filters['section'] === 'board' ? $filters['cat'] : 0;
$page = $filters['page'];
$result = mpb_search($pdo, $lang, $filters, $page);
$hasFilters = mpb_search_has_filters($filters);
$place = $filters['geo']['place'];
$placeLabel = $place !== null ? (mpg_labels($pdo, [$place['id']], $lang)[$place['id']]['label'] ?? '') : '';
$countries = $geoReady ? mpg_countries($pdo, $lang) : [];

// Реклама й облік переглядів: пошук/фільтри → marketplace_search; категорія чи Готові рішення →
// marketplace_category (блок на початку списку); інакше стрічка (marketplace_feed) і на першій
// сторінці — головна маркетплейсу (marketplace_home, блок над списком).
$isSearch = $filters['q'] !== '' || $filters['price_type'] !== '' || $filters['price_min'] !== null || $filters['price_max'] !== null
    || $filters['country'] !== '' || $filters['format'] !== 'any' || $filters['listing_langs'] !== [] || $filters['with_photos'] || $filters['verified'];
$mpSections = $isSolutions ? ['solutions'] : ($boardCat !== 0 ? promo_mp_page_sections('board', $boardCat) : ['board', 'solutions']);
$mpMode = $isSearch ? 'search' : (($boardCat !== 0 || $isSolutions) ? 'category' : 'feed');
if ($mpMode === 'feed') {
    analytics_log_view($pdo, 'marketplace_home', null, $page > 1 ? 'p:' . $page : implode(',', $mpSections));
} else {
    analytics_log_view($pdo, 'marketplace_' . $mpMode, null, implode(',', $mpSections));
}

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
$subUrl = static fn(int $subId): string => $url(['section' => MPB_SOLUTIONS, 'cat' => $subId ?: null, 'page' => null]);

$priceLabels = ['none' => t('mpb_pt_none'), 'free' => t('mpb_pt_free'), 'fixed' => t('mpb_pt_fixed'), 'negotiable' => t('mpb_pt_negotiable'), 'exchange' => t('mpb_pt_exchange')];
$sortLabels = ['new' => t('mpb_sort_new'), 'price_asc' => t('mpb_sort_cheap'), 'price_desc' => t('mpb_sort_expensive')];
if ($place !== null) {
    $sortLabels['distance'] = t('mpg_sort_distance');
}
$unitLabel = t($filters['units'] === 'mi' ? 'mpg_unit_mi' : 'mpg_unit_km');

$heading = $isSolutions ? t('mp_nav_solutions') : t('mp_heading');
mpb_open($heading, false, $isSolutions ? 'solutions' : 'board');
?>
    <div class="mp-page">
        <h1 class="mp-title"><?= mp_e($heading) ?></h1>
        <p class="mp-subtitle"><?= mp_e(t($isSolutions ? 'mp_subtitle' : 'mpb_subtitle')) ?></p>
        <?php // Платформа не бере участі в угодах — завжди вгорі, до списку. ?>
        <p class="mp-note mp-note--box mp-note--disclaimer" role="note"><?= mp_e(t('mpb_disclaimer')) ?></p>

        <?php if ($solutionCats !== []): ?>
            <ul class="mp-cats">
                <li><a class="mp-chip<?= $filters['cat'] === 0 ? ' is-active' : '' ?>" href="<?= mp_e($subUrl(0)) ?>"><?= mp_e(t('mp_all_categories')) ?></a></li>
                <?php foreach ($solutionCats as $c): ?>
                    <?php if ($c['cnt'] > 0): ?>
                        <li>
                            <a class="mp-chip<?= $c['id'] === $filters['cat'] ? ' is-active' : '' ?>" href="<?= mp_e($subUrl($c['id'])) ?>">
                                <?= mp_e($c['name']) ?>
                                <span class="mp-chip__count"><?= (int) $c['cnt'] ?></span>
                            </a>
                        </li>
                    <?php endif; ?>
                <?php endforeach; ?>
            </ul>
        <?php endif; ?>

        <?= mpb_flash_html() ?>

        <form class="mp-filters" method="get" action="marketplace.php" role="search">
            <?php if ($isSolutions && $filters['cat'] > 0): ?>
                <input type="hidden" name="cat" value="<?= (int) $filters['cat'] ?>" data-mp-cat>
            <?php endif; ?>
            <div class="mp-field mp-field--grow">
                <label class="mp-label" for="f_q"><?= mp_e(t('mpb_f_search')) ?></label>
                <input class="mp-input" type="search" id="f_q" name="q" maxlength="100" value="<?= mp_e($filters['q']) ?>" placeholder="<?= mp_e(t('mp_search_placeholder')) ?>">
            </div>
            <div class="mp-field">
                <label class="mp-label" for="f_section"><?= mp_e(t('mpb_f_category')) ?></label>
                <?php // Одне поле: розділ «Готові рішення» або категорія дошки (section=board + cat=N через data-cat). ?>
                <select class="mp-input" id="f_section" name="section" data-mp-section>
                    <option value=""><?= mp_e(t('mp_all_categories')) ?></option>
                    <option value="<?= MPB_SOLUTIONS ?>"<?= $isSolutions ? ' selected' : '' ?>><?= mp_e(t('mp_nav_solutions')) ?></option>
                    <?php foreach ($categories as $c): ?>
                        <option value="board" data-cat="<?= (int) $c['id'] ?>"<?= $boardCat === $c['id'] ? ' selected' : '' ?>><?= mp_e($c['name']) ?></option>
                    <?php endforeach; ?>
                </select>
                <?php if ($boardCat > 0): ?><input type="hidden" name="cat" value="<?= (int) $boardCat ?>" data-mp-cat><?php endif; ?>
            </div>
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
            <script>
            // «Категорія»: data-cat вибраної категорії дошки → прихований cat.
            (function () {
                var sel = document.querySelector('[data-mp-section]');
                if (!sel) { return; }
                sel.addEventListener('change', function () {
                    var opt = sel.options[sel.selectedIndex];
                    sel.form.querySelectorAll('[data-mp-cat]').forEach(function (h) { h.remove(); });
                    if (opt.dataset.cat) {
                        var hid = document.createElement('input');
                        hid.type = 'hidden'; hid.name = 'cat'; hid.value = opt.dataset.cat; hid.setAttribute('data-mp-cat', '');
                        sel.parentNode.appendChild(hid);
                    }
                });
            }());
            </script>
            <script src="/assets/js/mp-geo.js" defer></script>
        <?php endif; ?>

        <?php
        // Реклама в маркетплейсі — лише коли marketplace_public = 1 і місце ввімкнене (promo_slot
        // інакше порожній; адмін із ?promo_preview=1 бачить блоки завжди). Чітко відмінна від оголошень.
        if ($mpMode === 'feed' && $page === 1 && $result['rows'] !== []) {
            echo promo_slot($pdo, 'marketplace_home', [], [], ['mp' => $mpSections]);
        }
        ?>
        <p class="mp-count"><?= mp_e(sprintf(t('mpb_found'), $result['total'])) ?></p>

        <?php if ($result['rows'] === []): ?>
            <p class="mp-empty"><?= mp_e($hasFilters ? t('mp_empty_search') : t('mpb_empty')) ?></p>
        <?php else: ?>
            <div class="mp-grid">
                <?php foreach ($result['rows'] as $i => $card): ?>
                    <?php include __DIR__ . '/../app/mpb-card.php'; ?>
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
<?php mpb_close(); ?>
