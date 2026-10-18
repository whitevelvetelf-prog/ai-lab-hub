<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: дошка оголошень (у стилі OLX; публікують користувачі) разом із Готовими AI-рішеннями
 * платформи (section='solution', автор — AI LAB HUB, безкоштовно).
 *
 * Оголошення — лише status='published' І expires_at > NOW(); рішення — status='published'. Фільтри: категорія
 * (category=solutions — лише Готові AI-рішення, тоді ще sub=<категорія рішень>), тип і діапазон ціни,
 * місто / «дистанційно», пошук за назвою; сортування: нові / дешевші / дорожчі; пагінація по 12.
 * Поки config/marketplace.php → public_enabled = false — 404. Платформа в угодах не бере участі.
 * Колишні вітрини рішень marketplace-solutions.php / marketplace-category.php — 301 сюди.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/promo.php';

mp_public_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$lang = current_lang();
$get = static fn(string $k, int $max = 100): string => is_string($_GET[$k] ?? null) ? mb_substr(trim((string) $_GET[$k]), 0, $max) : '';
$num = static function (string $k) use ($get): ?float {
    $raw = str_replace([' ', ','], ['', '.'], $get($k, 14));

    return preg_match('/^\d{1,9}(\.\d{1,2})?$/', $raw) === 1 ? (float) $raw : null;
};

$categories = mpb_categories($pdo, $lang);
$catIds = array_column($categories, 'id');
$isSolutions = $get('category', 20) === MPB_SOLUTIONS;
$solutionCats = $isSolutions ? mp_public_categories($pdo, $lang) : [];
$sub = (int) ($_GET['sub'] ?? 0);
$filters = [
    'q'          => $get('q'),
    'category'   => $isSolutions ? MPB_SOLUTIONS : (in_array((int) ($_GET['category'] ?? 0), $catIds, true) ? (int) $_GET['category'] : 0),
    'sub'        => in_array($sub, array_column($solutionCats, 'id'), true) ? $sub : 0,
    'price_type' => in_array($get('price_type', 20), MPB_PRICE_TYPES, true) ? $get('price_type', 20) : '',
    'min'        => $num('min'),
    'max'        => $num('max'),
    'city'       => $get('city', 120),
    'remote'     => ($_GET['remote'] ?? '') === '1',
    'sort'       => in_array($get('sort', 10), ['new', 'cheap', 'expensive'], true) ? $get('sort', 10) : 'new',
];
$page = max(1, (int) ($_GET['page'] ?? 1));
$result = mpb_search($pdo, $lang, $filters, $page);

$hasFilters = $filters['q'] !== '' || $filters['category'] !== 0 || $filters['price_type'] !== '' || $filters['min'] !== null
    || $filters['max'] !== null || $filters['city'] !== '' || $filters['remote'];

/** Посилання на сторінку пагінації із збереженням фільтрів. */
$pageUrl = static function (int $p) use ($filters): string {
    $q = array_filter([
        'q' => $filters['q'], 'category' => $filters['category'] ?: null, 'sub' => $filters['sub'] ?: null, 'price_type' => $filters['price_type'] ?: null,
        'min' => $filters['min'], 'max' => $filters['max'], 'city' => $filters['city'],
        'remote' => $filters['remote'] ? '1' : null, 'sort' => $filters['sort'] !== 'new' ? $filters['sort'] : null,
        'page' => $p > 1 ? $p : null,
    ], static fn($x): bool => $x !== null && $x !== '');

    return 'marketplace.php' . ($q !== [] ? '?' . http_build_query($q) : '');
};

$priceLabels = ['none' => t('mpb_pt_none'), 'free' => t('mpb_pt_free'), 'fixed' => t('mpb_pt_fixed'), 'negotiable' => t('mpb_pt_negotiable'), 'exchange' => t('mpb_pt_exchange')];
$sortLabels = ['new' => t('mpb_sort_new'), 'cheap' => t('mpb_sort_cheap'), 'expensive' => t('mpb_sort_expensive')];

/** Посилання на категорію Готових AI-рішень ($subId = 0 — усі) зі збереженням інших фільтрів. */
$subUrl = static function (int $subId) use ($filters): string {
    $q = array_filter([
        'category' => MPB_SOLUTIONS, 'sub' => $subId ?: null, 'q' => $filters['q'], 'price_type' => $filters['price_type'] ?: null,
        'sort' => $filters['sort'] !== 'new' ? $filters['sort'] : null,
    ], static fn($x): bool => $x !== null && $x !== '');

    return 'marketplace.php?' . http_build_query($q);
};

$heading = $isSolutions ? t('mp_nav_solutions') : t('mp_heading');
mpb_open($heading, false, $isSolutions ? 'solutions' : 'board');
?>
    <div class="mp-page">
        <h1 class="mp-title"><?= mp_e($heading) ?></h1>
        <p class="mp-subtitle"><?= mp_e(t($isSolutions ? 'mp_subtitle' : 'mpb_subtitle')) ?></p>

        <?php if ($solutionCats !== []): ?>
            <ul class="mp-cats">
                <li><a class="mp-chip<?= $filters['sub'] === 0 ? ' is-active' : '' ?>" href="<?= mp_e($subUrl(0)) ?>"><?= mp_e(t('mp_all_categories')) ?></a></li>
                <?php foreach ($solutionCats as $c): ?>
                    <?php if ($c['cnt'] > 0): ?>
                        <li>
                            <a class="mp-chip<?= $c['id'] === $filters['sub'] ? ' is-active' : '' ?>" href="<?= mp_e($subUrl($c['id'])) ?>">
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
            <?php if ($filters['sub'] > 0): ?>
                <input type="hidden" name="sub" value="<?= (int) $filters['sub'] ?>">
            <?php endif; ?>
            <div class="mp-field mp-field--grow">
                <label class="mp-label" for="f_q"><?= mp_e(t('mpb_f_search')) ?></label>
                <input class="mp-input" type="search" id="f_q" name="q" maxlength="100" value="<?= mp_e($filters['q']) ?>" placeholder="<?= mp_e(t('mp_search_placeholder')) ?>">
            </div>
            <div class="mp-field">
                <label class="mp-label" for="f_cat"><?= mp_e(t('mpb_f_category')) ?></label>
                <select class="mp-input" id="f_cat" name="category">
                    <option value="0"><?= mp_e(t('mp_all_categories')) ?></option>
                    <option value="<?= MPB_SOLUTIONS ?>"<?= $isSolutions ? ' selected' : '' ?>><?= mp_e(t('mp_nav_solutions')) ?></option>
                    <?php foreach ($categories as $c): ?>
                        <option value="<?= (int) $c['id'] ?>"<?= $filters['category'] === $c['id'] ? ' selected' : '' ?>><?= mp_e($c['name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
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
                <label class="mp-label" for="f_min"><?= mp_e(t('mpb_f_price_range')) ?></label>
                <div class="mp-inline">
                    <input class="mp-input mp-input--num" type="text" inputmode="decimal" id="f_min" name="min" maxlength="12" value="<?= $filters['min'] !== null ? mp_e($filters['min']) : '' ?>" placeholder="<?= mp_e(t('mpb_from')) ?>" aria-label="<?= mp_e(t('mpb_from')) ?>">
                    <input class="mp-input mp-input--num" type="text" inputmode="decimal" name="max" maxlength="12" value="<?= $filters['max'] !== null ? mp_e($filters['max']) : '' ?>" placeholder="<?= mp_e(t('mpb_to')) ?>" aria-label="<?= mp_e(t('mpb_to')) ?>">
                </div>
            </div>
            <div class="mp-field">
                <label class="mp-label" for="f_city"><?= mp_e(t('mpb_f_city')) ?></label>
                <input class="mp-input" type="text" id="f_city" name="city" maxlength="120" value="<?= mp_e($filters['city']) ?>">
            </div>
            <div class="mp-field mp-field--check">
                <label class="mp-check"><input type="checkbox" name="remote" value="1"<?= $filters['remote'] ? ' checked' : '' ?>> <span><?= mp_e(t('mpb_f_remote')) ?></span></label>
            </div>
            <div class="mp-field">
                <label class="mp-label" for="f_sort"><?= mp_e(t('mpb_f_sort')) ?></label>
                <select class="mp-input" id="f_sort" name="sort">
                    <?php foreach ($sortLabels as $k => $label): ?>
                        <option value="<?= mp_e($k) ?>"<?= $filters['sort'] === $k ? ' selected' : '' ?>><?= mp_e($label) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="mp-actions mp-actions--tight">
                <button class="mp-btn mp-btn--primary" type="submit"><?= mp_e(t('mp_search_btn')) ?></button>
                <?php if ($hasFilters || $filters['sort'] !== 'new'): ?>
                    <a class="mp-btn" href="marketplace.php"><?= mp_e(t('mp_search_reset')) ?></a>
                <?php endif; ?>
            </div>
        </form>

        <p class="mp-count"><?= mp_e(sprintf(t('mpb_found'), $result['total'])) ?></p>

        <?php if ($result['rows'] === []): ?>
            <p class="mp-empty"><?= mp_e($hasFilters ? t('mp_empty_search') : t('mpb_empty')) ?></p>
        <?php else: ?>
            <?php
            // Реклама (місце marketplace_listing): лише коли місце дозволене — маркетплейс
            // відкритий (marketplace_public) і зроблено позначку «Просунуте»; доти promo_slot порожній.
            $promoSlotHtml = promo_slot($pdo, 'marketplace_listing');
            $promoSlotAt = min(promo_placement_rule_int($pdo, 'marketplace_listing', 'position', 3) - 1, count($result['rows']));
            ?>
            <div class="mp-grid">
                <?php foreach ($result['rows'] as $i => $card): ?>
                    <?php if ($i === $promoSlotAt) { echo $promoSlotHtml; } ?>
                    <?php include __DIR__ . '/../app/mpb-card.php'; ?>
                <?php endforeach; ?>
                <?php if ($promoSlotAt === count($result['rows'])) { echo $promoSlotHtml; } ?>
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

        <p class="mp-note"><?= mp_e(t('mpb_disclaimer')) ?></p>
    </div>
<?php mpb_close(); ?>
