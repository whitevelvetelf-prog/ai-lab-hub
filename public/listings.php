<?php

declare(strict_types=1);

/**
 * AI LAB HUB — публічний список оголошень компаній одного типу (блок M1).
 *
 *   listings.php?type=job|course|service [&q=&olang=&country=&remote=1&focus=ID] [&price=free|paid&max=N — курси] [&page=N]
 *
 * Поки marketplace_public = 0 — лише співробітникам (з noindex), решті — сторінка «Скоро» (mp_public_require()).
 * Для курсів, коли на сторінці ≥3 курси з повною розміткою, — ItemList (вимога Google для каруселі курсів).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/listing.php';
require_once __DIR__ . '/../app/promo.php';

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
$filters = [
    'q' => mb_substr($get('q'), 0, 100),
    'lang' => in_array($get('olang'), LST_LANGS, true) ? $get('olang') : '',
    'country' => isset(LST_COUNTRIES[strtoupper($get('country'))]) ? strtoupper($get('country')) : '',
    'remote' => $get('remote') === '1',
    'focus' => (int) $get('focus'),
    'price' => in_array($get('price'), ['free', 'paid'], true) ? $get('price') : '',
    'max' => $type === 'course' && preg_match('/^\d{1,9}$/', $max) === 1 ? (int) $max : null,
];
$result = lst_search($pdo, $lang, $type, $filters, max(1, (int) $get('page')));
$focusTags = lst_focus_tags($pdo);
$hasFilters = $filters['q'] !== '' || $filters['lang'] !== '' || $filters['country'] !== '' || $filters['remote'] || $filters['focus'] > 0
    || $filters['price'] !== '' || $filters['max'] !== null;
// Реклама й облік переглядів: розділ без фільтрів — marketplace_category, з фільтрами — marketplace_search.
analytics_log_view($pdo, $hasFilters ? 'marketplace_search' : 'marketplace_category', null, $type);

$pageUrl = static function (int $p) use ($filters, $type): string {
    $q = array_filter([
        'type' => $type, 'q' => $filters['q'], 'olang' => $filters['lang'], 'country' => $filters['country'],
        'remote' => $filters['remote'] ? '1' : null, 'focus' => $filters['focus'] ?: null, 'price' => $filters['price'],
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

$heading = lst_tr('type_' . $type);
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

        <form class="mp-filters" method="get" action="listings.php" role="search">
            <input type="hidden" name="type" value="<?= $type ?>">
            <div class="mp-field mp-field--grow">
                <label class="mp-label" for="f_q"><?= lst_e(lst_tr('flt_search')) ?></label>
                <input class="mp-input" type="search" id="f_q" name="q" maxlength="100" value="<?= lst_e($filters['q']) ?>" placeholder="<?= lst_e(lst_tr('flt_search_ph')) ?>">
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
            <div class="mp-field">
                <label class="mp-label" for="f_focus"><?= lst_e(lst_tr('flt_focus')) ?></label>
                <select class="mp-input" id="f_focus" name="focus">
                    <option value=""><?= lst_e(lst_tr('flt_all')) ?></option>
                    <?php foreach ($focusTags as $tg): ?><option value="<?= (int) $tg['id'] ?>"<?= $filters['focus'] === $tg['id'] ? ' selected' : '' ?>><?= lst_e($tg['name']) ?></option><?php endforeach; ?>
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
            <div class="mp-field mp-field--check">
                <label class="mp-check"><input type="checkbox" name="remote" value="1"<?= $filters['remote'] ? ' checked' : '' ?>> <span><?= lst_e(lst_tr('flt_remote')) ?></span></label>
            </div>
            <div class="mp-actions mp-actions--tight">
                <button class="mp-btn mp-btn--primary" type="submit"><?= lst_e(lst_tr('flt_apply')) ?></button>
                <?php if ($hasFilters): ?><a class="mp-btn" href="listings.php?type=<?= $type ?>"><?= lst_e(lst_tr('flt_reset')) ?></a><?php endif; ?>
            </div>
        </form>

        <p class="mp-count"><?= lst_e(lst_tr('list_found', $result['total'])) ?></p>
        <?php if ($result['rows'] === []): ?>
            <p class="mp-empty"><?= lst_e(lst_tr($hasFilters ? 'list_empty_search' : 'list_empty')) ?></p>
        <?php else: ?>
            <?php
            if (!$hasFilters) {
                echo promo_slot($pdo, 'marketplace_category', [], [], ['mp' => [$type]]);
            }
            $promoAt = $hasFilters ? promo_placement_positions($pdo, 'marketplace_search', count($result['rows'])) : [];
            ?>
            <div class="mp-grid">
                <?php foreach ($result['rows'] as $i => $row) {
                    if (in_array($i, $promoAt, true)) {
                        echo promo_slot($pdo, 'marketplace_search', [], [], ['mp' => [$type]]);
                    }
                    echo lst_card_html($row);
                } ?>
                <?php if (in_array(count($result['rows']), $promoAt, true)) { echo promo_slot($pdo, 'marketplace_search', [], [], ['mp' => [$type]]); } ?>
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

        <?= lst_rules_html() ?>
    </div>
<?php mpb_close(); ?>
