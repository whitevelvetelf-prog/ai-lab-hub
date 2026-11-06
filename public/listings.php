<?php

declare(strict_types=1);

/**
 * AI LAB HUB — розділ оголошень компаній одного типу (вакансії, курси, послуги).
 *
 *   listings.php?type=job|course|service                — головна розділу: пошук, блоки-категорії (іконка, назва,
 *                                                         кількість активних), «Нові оголошення» (LST_HUB_NEW шт.)
 *   …&focus=ID                                          — сторінка категорії: список по 20, пагінація, пошук, фільтри
 *   …&all=1                                             — «Усі вакансії/курси/послуги» з фільтром за категорією
 *   фільтри: q, olang, country, format=remote|onsite (стара адреса remote=1 теж працює), city, fresh=1|7|30,
 *            price=free|paid&max=N (курси), page=N
 * Порожні категорії не показуються ('show_empty_categories' у конфігу); усі порожні — запрошення подати оголошення.
 *
 * Поки marketplace_public = 0 — лише співробітникам (з noindex), решті — сторінка «Скоро» (mp_public_require()).
 * Для курсів, коли на сторінці ≥3 курси з повною розміткою, — ItemList (вимога Google для каруселі курсів).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/listing.php';
require_once __DIR__ . '/../app/promo.php';
require_once __DIR__ . '/../app/mp-flow-i18n.php';

mp_public_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$type = (string) ($_GET['type'] ?? 'job');
if (!lst_type_valid($type)) {
    $type = 'job';
}
$lang = current_lang();
$get = static fn(string $k): string => is_string($_GET[$k] ?? null) ? trim((string) $_GET[$k]) : '';
$max = $get('max');
$format = in_array($get('format'), ['remote', 'onsite'], true) ? $get('format') : ($get('remote') === '1' ? 'remote' : '');
$fresh = (int) $get('fresh');
$filters = [
    'q' => mb_substr($get('q'), 0, 100),
    'lang' => in_array($get('olang'), LST_LANGS, true) ? $get('olang') : '',
    'country' => isset(LST_COUNTRIES[strtoupper($get('country'))]) ? strtoupper($get('country')) : '',
    'format' => $format,
    'city' => mb_substr($get('city'), 0, 80),
    'fresh' => in_array($fresh, LST_FRESH_DAYS, true) ? $fresh : 0,
    'focus' => (int) $get('focus'),
    'price' => in_array($get('price'), ['free', 'paid'], true) ? $get('price') : '',
    'max' => $type === 'course' && preg_match('/^\d{1,9}$/', $max) === 1 ? (int) $max : null,
];
$focusTags = lst_focus_tags($pdo);
$focusCounts = lst_focus_counts($pdo, $type);
$showEmpty = !empty(mp_config()['show_empty_categories']);
$tiles = array_values(array_filter($focusTags, static fn(array $tg): bool => $showEmpty || ($focusCounts[$tg['id']] ?? 0) > 0));
$focusName = '';
foreach ($focusTags as $tg) {
    if ($tg['id'] === $filters['focus']) {
        $focusName = $tg['name'];
    }
}
if ($focusName === '') {
    $filters['focus'] = 0;   // неіснуюча категорія — як без неї
}
$hasFilters = $filters['q'] !== '' || $filters['lang'] !== '' || $filters['country'] !== '' || $filters['format'] !== '' || $filters['focus'] > 0
    || $filters['city'] !== '' || $filters['fresh'] > 0 || $filters['price'] !== '' || $filters['max'] !== null;
// Головна розділу (блоки + нові) — коли немає ні фільтрів, ні «Усі», ні номера сторінки.
$isHub = !$hasFilters && $get('all') !== '1' && (int) $get('page') <= 1;
$result = $isHub
    ? lst_search($pdo, $lang, $type, $filters, 1, LST_HUB_NEW)
    : lst_search($pdo, $lang, $type, $filters, max(1, (int) $get('page')));
// Реклама й облік переглядів: розділ без фільтрів — marketplace_category, з фільтрами — marketplace_search.
analytics_log_view($pdo, $hasFilters ? 'marketplace_search' : 'marketplace_category', null, $type);

$pageUrl = static function (int $p) use ($filters, $type): string {
    $q = array_filter([
        'type' => $type, 'all' => '1', 'q' => $filters['q'], 'olang' => $filters['lang'], 'country' => $filters['country'],
        'format' => $filters['format'], 'city' => $filters['city'], 'fresh' => $filters['fresh'] ?: null,
        'focus' => $filters['focus'] ?: null, 'price' => $filters['price'],
        'max' => $filters['max'], 'page' => $p > 1 ? $p : null,
    ], static fn($x): bool => $x !== null && $x !== '');

    return 'listings.php?' . http_build_query($q);
};

// ItemList для каруселі курсів — лише з курсів, що мають повну розмітку Course.
$itemList = null;
if ($type === 'course') {
    $items = [];
    foreach ($result['rows'] as $r) {
        if (lst_jsonld($r) !== null) {
            $items[] = ['@type' => 'ListItem', 'position' => count($items) + 1, 'url' => lst_site_url() . '/' . lst_url($r)];
        }
    }
    if (count($items) >= 3) {
        $itemList = ['@context' => 'https://schema.org', '@type' => 'ItemList', 'itemListElement' => $items];
    }
}

$heading = $focusName !== '' ? lst_tr('type_' . $type) . ': ' . $focusName : lst_tr('type_' . $type);
$freeLabel = lst_free_label($pdo);
// Поки розділ приховано, сторінку бачать лише співробітники — без індексації.
$head = '<link rel="canonical" href="' . lst_e(lst_site_url() . '/listings.php?type=' . $type) . '">';
if ($itemList !== null) {
    $head .= "
" . '<script type="application/ld+json">' . json_encode($itemList, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_HEX_TAG) . '</script>';
}
lst_open($heading, !mp_public_enabled(), $head, 'lst_' . $type);
?>
    <div class="mp-page">
        <h1 class="mp-title"><?= lst_e($heading) ?></h1>
        <p class="mp-subtitle"><?= lst_e(lst_tr('sub_' . $type)) ?></p>
        <?php // Платформа не є стороною відносин — завжди вгорі, до списку. ?>
        <p class="mp-note mp-note--box mp-note--disclaimer" role="note"><?= lst_e(lst_tr('disclaimer')) ?> <a href="terms.php"><?= lst_e(lst_tr('terms_link')) ?></a></p>
        <p class="mp-actions mp-actions--tight">
            <a class="mp-btn mp-btn--primary" href="listing-post.php?type=<?= $type ?>"><?= lst_e(lst_tr('post_' . $type)) ?></a>
            <?php if ($freeLabel !== ''): ?><span class="lst-free-inline"><?= lst_e($freeLabel) ?></span><?php endif; ?>
        </p>
        <?= mpb_flash_html() ?>

        <?php $allKey = 'cat_all_' . $type; ?>
        <?php if ($isHub): ?>
            <?php // Головна розділу: пошук угорі, блоки-категорії, «Нові оголошення», «Усі …» окремим посиланням ?>
            <form class="mpc-search" method="get" action="listings.php" role="search">
                <input type="hidden" name="type" value="<?= $type ?>">
                <input type="hidden" name="all" value="1">
                <label class="mp-visually-hidden" for="hub_q"><?= lst_e(lst_tr('flt_search')) ?></label>
                <input class="mp-input" type="search" id="hub_q" name="q" maxlength="100" placeholder="<?= lst_e(lst_tr('flt_search_ph')) ?>">
                <button class="mp-btn mp-btn--primary" type="submit"><?= lst_e(lst_tr('flt_search')) ?></button>
            </form>

            <?php if ($tiles === []): ?>
                <div class="mp-panel">
                    <p class="mp-text"><?= lst_e(mpf_tr('cat_empty_all')) ?></p>
                    <p class="mp-actions"><a class="mp-btn mp-btn--primary" href="listing-post.php?type=<?= $type ?>"><?= lst_e(lst_tr('post_' . $type)) ?></a></p>
                </div>
            <?php else: ?>
                <div class="mpc-head"><h2><?= lst_e(mpf_tr('cat_title')) ?></h2>
                    <a href="listings.php?type=<?= $type ?>&amp;all=1"><?= lst_e(mpf_tr($allKey)) ?> (<?= (int) $result['total'] ?>) →</a></div>
                <div class="mpc-grid">
                    <?php foreach ($tiles as $tg): $n = (int) ($focusCounts[$tg['id']] ?? 0); ?>
                        <a class="mpc-tile" href="listings.php?type=<?= $type ?>&amp;focus=<?= (int) $tg['id'] ?>">
                            <span class="mpc-tile__icon" aria-hidden="true"><i data-lucide="<?= lst_e(lst_focus_icon($tg['slug'])) ?>"></i></span>
                            <p class="mpc-tile__name"><?= lst_e($tg['name']) ?></p>
                            <p class="mpc-tile__count"><?= lst_e(mpf_count('cat_count', $n)) ?></p>
                        </a>
                    <?php endforeach; ?>
                </div>
            <?php endif; ?>

            <?php if ($result['rows'] !== []): ?>
                <div class="mpc-head"><h2><?= lst_e(mpf_tr('cat_new')) ?></h2>
                    <a href="listings.php?type=<?= $type ?>&amp;all=1"><?= lst_e(mpf_tr($allKey)) ?> →</a></div>
                <div class="mp-grid">
                    <?php foreach ($result['rows'] as $row) {
                        echo lst_card_html($row);
                    } ?>
                </div>
            <?php endif; ?>
        <?php else: ?>
            <p class="mp-actions mp-actions--tight"><a href="listings.php?type=<?= $type ?>"><?= lst_e(mpf_tr('cat_back')) ?></a></p>

            <form class="mp-filters" method="get" action="listings.php" role="search">
                <input type="hidden" name="type" value="<?= $type ?>">
                <input type="hidden" name="all" value="1">
                <div class="mp-field mp-field--grow">
                    <label class="mp-label" for="f_q"><?= lst_e(lst_tr('flt_search')) ?></label>
                    <input class="mp-input" type="search" id="f_q" name="q" maxlength="100" value="<?= lst_e($filters['q']) ?>" placeholder="<?= lst_e(lst_tr('flt_search_ph')) ?>">
                </div>
                <div class="mp-field">
                    <label class="mp-label" for="f_focus"><?= lst_e(mpf_tr('cat_title')) ?></label>
                    <select class="mp-input" id="f_focus" name="focus">
                        <option value=""><?= lst_e(lst_tr('flt_all')) ?></option>
                        <?php foreach ($focusTags as $tg): ?><option value="<?= (int) $tg['id'] ?>"<?= $filters['focus'] === $tg['id'] ? ' selected' : '' ?>><?= lst_e($tg['name']) ?> (<?= (int) ($focusCounts[$tg['id']] ?? 0) ?>)</option><?php endforeach; ?>
                    </select>
                </div>
                <div class="mp-field">
                    <label class="mp-label" for="f_format"><?= lst_e(mpf_tr('flt_format')) ?></label>
                    <select class="mp-input" id="f_format" name="format">
                        <option value=""><?= lst_e(lst_tr('flt_all')) ?></option>
                        <option value="remote"<?= $filters['format'] === 'remote' ? ' selected' : '' ?>><?= lst_e(mpf_tr('flt_format_remote')) ?></option>
                        <option value="onsite"<?= $filters['format'] === 'onsite' ? ' selected' : '' ?>><?= lst_e(mpf_tr('flt_format_onsite')) ?></option>
                    </select>
                </div>
                <div class="mp-field">
                    <label class="mp-label" for="f_city"><?= lst_e(mpf_tr('flt_city')) ?></label>
                    <input class="mp-input" type="text" id="f_city" name="city" maxlength="80" value="<?= lst_e($filters['city']) ?>">
                </div>
                <div class="mp-field">
                    <label class="mp-label" for="f_fresh"><?= lst_e(mpf_tr('flt_fresh')) ?></label>
                    <select class="mp-input" id="f_fresh" name="fresh">
                        <option value=""><?= lst_e(lst_tr('flt_all')) ?></option>
                        <?php foreach (LST_FRESH_DAYS as $d): ?><option value="<?= $d ?>"<?= $filters['fresh'] === $d ? ' selected' : '' ?>><?= lst_e(mpf_tr('flt_fresh_' . $d)) ?></option><?php endforeach; ?>
                    </select>
                </div>
                <div class="mp-field">
                    <label class="mp-label" for="f_lang"><?= lst_e(lst_tr('flt_lang')) ?></label>
                    <select class="mp-input" id="f_lang" name="olang">
                        <option value=""><?= lst_e(lst_tr('flt_all')) ?></option>
                        <?php foreach (LST_LANGS as $l): ?><option value="<?= $l ?>"<?= $filters['lang'] === $l ? ' selected' : '' ?>><?= lst_e(lst_tr('lang_' . $l)) ?></option><?php endforeach; ?>
                    </select>
                </div>
                <div class="mp-field">
                    <label class="mp-label" for="f_country"><?= lst_e(lst_tr('flt_country')) ?></label>
                    <select class="mp-input" id="f_country" name="country">
                        <option value=""><?= lst_e(lst_tr('flt_all')) ?></option>
                        <?php foreach (array_keys(LST_COUNTRIES) as $cc): ?><option value="<?= $cc ?>"<?= $filters['country'] === $cc ? ' selected' : '' ?>><?= lst_e(lst_country_name($cc)) ?></option><?php endforeach; ?>
                    </select>
                </div>
                <?php if ($type === 'course'): ?>
                <div class="mp-field">
                    <label class="mp-label" for="f_price"><?= lst_e(lst_tr('flt_price')) ?></label>
                    <select class="mp-input" id="f_price" name="price">
                        <option value=""><?= lst_e(lst_tr('flt_all')) ?></option>
                        <option value="free"<?= $filters['price'] === 'free' ? ' selected' : '' ?>><?= lst_e(lst_tr('flt_free')) ?></option>
                        <option value="paid"<?= $filters['price'] === 'paid' ? ' selected' : '' ?>><?= lst_e(lst_tr('flt_paid')) ?></option>
                    </select>
                </div>
                <div class="mp-field">
                    <label class="mp-label" for="f_max"><?= lst_e(lst_tr('flt_max')) ?></label>
                    <input class="mp-input mp-input--num" type="text" inputmode="numeric" id="f_max" name="max" maxlength="9" value="<?= $filters['max'] !== null ? (int) $filters['max'] : '' ?>">
                </div>
                <?php endif; ?>
                <div class="mp-actions mp-actions--tight">
                    <button class="mp-btn mp-btn--primary" type="submit"><?= lst_e(lst_tr('flt_apply')) ?></button>
                    <?php if ($hasFilters): ?><a class="mp-btn" href="listings.php?type=<?= $type ?>&amp;all=1"><?= lst_e(lst_tr('flt_reset')) ?></a><?php endif; ?>
                </div>
            </form>

            <p class="mp-count"><?= lst_e(lst_tr('list_found', $result['total'])) ?></p>
            <?php if ($result['rows'] === []): ?>
                <p class="mp-empty"><?= lst_e(lst_tr($hasFilters ? 'list_empty_search' : 'list_empty')) ?></p>
            <?php else: ?>
                <div class="mp-grid">
                    <?php foreach ($result['rows'] as $row) {
                        echo lst_card_html($row);
                    } ?>
                </div>
                <?php if ($result['pages'] > 1): ?>
                    <nav class="mp-pager" aria-label="<?= lst_e(lst_tr('pages')) ?>">
                        <?php for ($p = 1; $p <= $result['pages']; $p++): ?>
                            <?php if ($p === 1 || $p === $result['pages'] || abs($p - $result['page']) <= 2): ?>
                                <a class="mp-btn<?= $p === $result['page'] ? ' mp-btn--primary' : '' ?>" href="<?= lst_e($pageUrl($p)) ?>"<?= $p === $result['page'] ? ' aria-current="page"' : '' ?>><?= $p ?></a>
                            <?php elseif (abs($p - $result['page']) === 3): ?>
                                <span class="mp-pager__gap">…</span>
                            <?php endif; ?>
                        <?php endfor; ?>
                    </nav>
                <?php endif; ?>
            <?php endif; ?>
        <?php endif; ?>

        <?= lst_rules_html() ?>
    </div>
<script src="https://unpkg.com/lucide@latest"></script>
<script>if (window.lucide) { lucide.createIcons(); }</script>
<?php mpb_close(); ?>
