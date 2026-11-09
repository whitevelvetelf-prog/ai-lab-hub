<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: сторінка блока або підкатегорії (?id=N — id з mp_categories, як у каталозі).
 *
 *   Блок з підкатегоріями: хлібні крихти «Marketplace › Блок», плитки підкатегорій (назва, іконка, кількість; порожні —
 *     лише при show_empty_categories), пошук і «Свіже» в межах блока. Порожній блок зі списку always_visible_blocks —
 *     «Оголошень поки немає. Станьте першим» і «Подати оголошення».
 *   Підкатегорія (і блок без підкатегорій, як «Інше»): «Marketplace › Блок › Підкатегорія», список по MPT_PER_PAGE
 *     з пагінацією, пошук, сортування, фільтри.
 *   Хвиля 1 (2026-11-09): фільтри вакансій (тип зайнятості, графік, зарплата «від» з валютою й періодом, досвід, формат,
 *     «Підходить», сортування за зарплатою), курсів (формат, безкоштовні / платні, ціна) і послуг (тип, ціна) — app/mp-jobs.php;
 *     на мобільному — згортна панель із кнопкою «Показати N результатів» (public/mp-count.php), активні фільтри чипами
 *     з ✕ і «Скинути все»; «Вакансії за областями»; популярні запити під пошуком; «Зберегти пошук».
 *   Усе через GET (посилання можна надіслати). Адреси з параметрами й сторінки пагінації від 2 — noindex,follow;
 *   канонічна адреса — сторінка категорії без фільтрів.
 * Оголошення з обох джерел (app/mp-tree.php → mpt_search). Поки public_enabled = false — 404.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/listing.php';
require_once __DIR__ . '/../app/promo.php';   // analytics_log_view()
require_once __DIR__ . '/../app/mp-popular.php';
require_once __DIR__ . '/../app/mp-saved.php';

mp_public_require();

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$lang = current_lang();
$tree = mpt_tree($pdo, $lang);
$id = is_string($_GET['id'] ?? null) && ctype_digit($_GET['id']) ? (int) $_GET['id'] : 0;
$node = $id > 0 ? mpt_node($tree, $id) : null;
if ($node === null) {
    mp_not_found();
}
$block = $node['block'];
$sub = $node['sub'];
$section = $block['section'];
$isList = $sub !== null || $block['children'] === [];
$counts = mpt_counts($pdo);

// Фільтри (білі списки) — спільний розбір app/mp-jobs.php (той самий для лічильника й збережених пошуків).
$bf = mpj_block_filters($pdo, $block, $sub, $_GET);
$f = $bf['f'];
$jf = $f['jf'];
$params = $bf['params'];
$focusTags = $bf['focusTags'];
$focus = (int) $f['focus'];
$page = $bf['page'];
$filtered = $bf['filtered'];
$isJob = $section === 'job';
$pageUrl = static fn(int $p): string => mpt_url($id, $params + ($p > 1 ? ['page' => $p] : []));

// Блок без підкатегорій-пошуку: свіже; з пошуком / фільтром у блоці — список результатів.
$showList = $isList || $params !== [];
$result = $showList ? mpt_search($pdo, $lang, $f, $page, MPT_PER_PAGE) : mpt_search($pdo, $lang, $f, 1, MPT_FRESH);
$blockCount = (int) ($counts['blocks'][$section] ?? 0);
$here = $sub ?? $block;
$hereCount = $sub !== null ? (int) ($counts['cats'][$sub['id']] ?? 0) : $blockCount;

analytics_log_view($pdo, 'marketplace_category', null, $section . ($sub !== null ? ':' . $sub['id'] : ''));
if ($f['q'] !== '' && $result['page'] === 1) {
    mpq_record($pdo, 'marketplace', $f['q'], $result['total']);
}

$crumbs = [[t('mp_heading'), 'marketplace.php'], [$block['name'], mpt_url($block['id'])]];
if ($sub !== null) {
    $crumbs[] = [$sub['name'], null];
}
$title = ($sub !== null ? $sub['name'] . ' — ' . $block['name'] : $block['name']) . ' — ' . t('title_marketplace')
    . ($showList && $result['page'] > 1 ? ' · ' . sprintf(t('mpt_page_n'), $result['page']) : '');
$desc = sprintf(t($sub !== null ? 'mpt_sub_desc' : 'mpt_block_desc'), $here['name'], $hereCount, $block['name']);
// Будь-які параметри (фільтри, сортування) і сторінки від 2 — noindex,follow; канонічна — категорія без фільтрів.
$noindex = $params !== [] || $page > 1 || $hereCount === 0;
mpt_open($title, $desc, mpt_url($id), $noindex, 'home');
$visibleSubs = mpt_visible_children($block, $counts);
$alwaysVisible = in_array($section, mpt_visibility()['always'], true);

// Чипи активних фільтрів (кожен — посилання без цього значення) і «Скинути все».
$chips = [];
foreach (mpj_chips($jf, $params) as [$label, $p]) {
    $chips[] = [$label, mpt_url($id, $p)];
}
if ((int) ($jf['region'] ?? 0) > 0) {
    $chips[] = [mpj_region_name($pdo, (int) $jf['region'], $lang) ?: t('mpj_region'), mpt_url($id, array_diff_key($params, ['region' => 1, 'page' => 1]))];
}
foreach (['format' => static fn($v) => t('mpt_fmt_' . $v), 'city' => static fn($v) => $v, 'price_min' => static fn($v) => t('mpb_from') . ' $' . $v,
    'price_max' => static fn($v) => t('mpb_to') . ' $' . $v] as $k => $lbl) {
    if (isset($params[$k])) {
        $chips[] = [$lbl((string) $params[$k]), mpt_url($id, array_diff_key($params, [$k => 1]))];
    }
}
if ($focus > 0) {
    foreach ($focusTags as $tg) {
        if ($tg['id'] === $focus) {
            $chips[] = [$tg['name'], mpt_url($id, array_diff_key($params, ['focus' => 1]))];
        }
    }
}
$resetUrl = mpt_url($id, $f['q'] !== '' ? ['q' => $f['q']] : []);
$activeCount = count($chips);
$sortLabels = $isJob
    ? ['new' => t('mpb_sort_new'), 'salary_desc' => t('mpj_sort_salary_desc'), 'salary_asc' => t('mpj_sort_salary_asc')]
    : ['new' => t('mpb_sort_new'), 'price_asc' => t('mpb_sort_cheap'), 'price_desc' => t('mpb_sort_expensive')];
$popular = mpq_chips($pdo, 'marketplace', $lang);
$regions = $isJob && !$isList ? mpj_region_counts($pdo, $section, $lang) : [];
$currentUrl = $pageUrl(1);
?>
    <div class="mp-page">
        <?= mpt_crumbs($crumbs) ?>
        <h1 class="mp-title"><?= mp_e($here['name']) ?></h1>
        <p class="mp-subtitle"><?= mp_e(mpt_count_label($hereCount)) ?></p>
        <?= mpb_flash_html() ?>

        <?= mpt_search_form('marketplace-category.php', $f['q'], ['id' => $id] + array_diff_key($params, ['q' => 1]), sprintf(t('mpt_search_in'), $here['name'])) ?>
        <?= mpq_chips_html($popular, static fn(string $q): string => mpt_url($id, ['q' => $q])) ?>

        <?php if (!$isList && $visibleSubs !== []): ?>
            <h2 class="mp-section-title"><?= mp_e(t('mpt_subcategories')) ?></h2>
            <?= mpt_tiles(array_map(static fn(array $c): array => [$c['name'], $c['icon'], mpt_url($c['id']), $counts['cats'][$c['id']] ?? 0], $visibleSubs), t('mpt_subcategories')) ?>
        <?php endif; ?>

        <?php if ($regions !== [] && $params === []): ?>
            <h2 class="mp-section-title"><?= mp_e(t('mpj_regions_title')) ?></h2>
            <nav class="mpj-regions" aria-label="<?= mp_e(t('mpj_regions_title')) ?>">
                <?php foreach ($regions as $r): ?>
                    <a class="mpq-chip" href="<?= mp_e(mpt_url($id, ['region' => $r['id']])) ?>"><?= mp_e($r['name']) ?> <span class="mp-chip__count"><?= (int) $r['count'] ?></span></a>
                <?php endforeach; ?>
            </nav>
        <?php endif; ?>

        <?php if ($blockCount === 0 && $params === []): ?>
            <?= $alwaysVisible || $sub === null ? mpt_empty_invite($section) : '<p class="mp-empty">' . mp_e(t('mpt_empty_sub')) . '</p>' ?>
        <?php endif; ?>

        <?php if ($showList): ?>
            <details class="mpf-panel" data-mpf-panel open>
                <summary class="mpf-panel__toggle mp-btn"><span><?= mp_e(t('mpj_filters')) ?></span><?php if ($activeCount > 0): ?> <span class="mp-chip__count"><?= $activeCount ?></span><?php endif; ?></summary>
                <form class="mp-filters mpt-filters mpf-form" method="get" action="marketplace-category.php"
                      data-count-url="mp-count.php" data-count-page="cat" data-count-label="<?= mp_e(t('mpj_show_n')) ?>">
                    <input type="hidden" name="id" value="<?= (int) $id ?>">
                    <?php if ($f['q'] !== ''): ?><input type="hidden" name="q" value="<?= mp_e($f['q']) ?>"><?php endif; ?>
                    <div class="mp-field">
                        <label class="mp-label" for="f_sort"><?= mp_e(t('mpb_f_sort')) ?></label>
                        <select class="mp-input" id="f_sort" name="sort">
                            <?php foreach ($sortLabels as $k => $label): ?>
                                <option value="<?= $k ?>"<?= $f['sort'] === $k ? ' selected' : '' ?>><?= mp_e($label) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <?= mpj_fields_html($jf) ?>
                    <?php if (!$isJob && $section !== 'course'): ?>
                    <div class="mp-field">
                        <label class="mp-label" for="f_format"><?= mp_e(t('mpg_f_format')) ?></label>
                        <select class="mp-input" id="f_format" name="format">
                            <option value=""><?= mp_e(t('mpg_fmt_any')) ?></option>
                            <?php foreach (MPT_FORMATS as $fm): ?>
                                <option value="<?= $fm ?>"<?= $f['format'] === $fm ? ' selected' : '' ?>><?= mp_e(t('mpt_fmt_' . $fm)) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                    <?php endif; ?>
                    <div class="mp-field">
                        <label class="mp-label" for="f_city"><?= mp_e(t('mpb_f_city')) ?></label>
                        <input class="mp-input" type="text" id="f_city" name="city" maxlength="80" value="<?= mp_e($f['city']) ?>">
                    </div>
                    <?php if (!$isJob): ?>
                    <div class="mp-field">
                        <label class="mp-label" for="f_min"><?= mp_e(t('mpg_f_price_usd')) ?></label>
                        <div class="mp-inline">
                            <input class="mp-input mp-input--num" type="text" inputmode="decimal" id="f_min" name="price_min" maxlength="12" value="<?= $f['price_min'] !== null ? mp_e($f['price_min']) : '' ?>" placeholder="<?= mp_e(t('mpb_from')) ?>" aria-label="<?= mp_e(t('mpb_from')) ?>">
                            <input class="mp-input mp-input--num" type="text" inputmode="decimal" name="price_max" maxlength="12" value="<?= $f['price_max'] !== null ? mp_e($f['price_max']) : '' ?>" placeholder="<?= mp_e(t('mpb_to')) ?>" aria-label="<?= mp_e(t('mpb_to')) ?>">
                        </div>
                    </div>
                    <?php endif; ?>
                    <?php if ($focusTags !== []): ?>
                        <details class="mp-filters__more mpt-focus"<?= $focus > 0 ? ' open' : '' ?>>
                            <summary><?= mp_e(lst_tr('f_focus')) ?></summary>
                            <div class="mp-field">
                                <select class="mp-input" name="focus" aria-label="<?= mp_e(lst_tr('f_focus')) ?>">
                                    <option value=""><?= mp_e(t('mp_all_categories')) ?></option>
                                    <?php foreach ($focusTags as $tg): ?>
                                        <option value="<?= (int) $tg['id'] ?>"<?= $focus === $tg['id'] ? ' selected' : '' ?>><?= mp_e($tg['name']) ?></option>
                                    <?php endforeach; ?>
                                </select>
                            </div>
                        </details>
                    <?php endif; ?>
                    <div class="mp-actions mp-actions--tight mpf-actions">
                        <button class="mp-btn mp-btn--primary mpf-submit" type="submit" data-mpf-submit><?= mp_e(sprintf(t('mpj_show_n'), $result['total'])) ?></button>
                        <?php if ($params !== []): ?><a class="mp-btn" href="<?= mp_e(mpt_url($id)) ?>"><?= mp_e(t('mpj_reset_all')) ?></a><?php endif; ?>
                    </div>
                </form>
            </details>
            <?= mpj_chips_html($chips, $resetUrl) ?>
            <div class="mpf-bar">
                <p class="mp-count" aria-live="polite"><?= mp_e(sprintf(t('mpb_found'), $result['total'])) ?></p>
                <?php if ($filtered): ?><?= mpss_button_html($currentUrl) ?><?php endif; ?>
            </div>
            <?php if (!empty($result['notes']['sal_unavailable'])): ?>
                <p class="mp-alert"><?= mp_e(t('mpj_salary_no_rate')) ?></p>
            <?php endif; ?>
        <?php elseif ($result['rows'] !== []): ?>
            <h2 class="mp-section-title"><?= mp_e(t('mpt_fresh')) ?></h2>
        <?php endif; ?>

        <?php if ($result['rows'] !== []): ?>
            <div class="mp-grid">
                <?php foreach ($result['rows'] as $card): ?><?= mpt_card_html($pdo, $card) ?><?php endforeach; ?>
            </div>
            <?= $showList ? mpt_pager($result, $pageUrl) : '' ?>
        <?php elseif ($showList && ($params !== [] || $blockCount > 0)): ?>
            <p class="mp-empty"><?= mp_e($params !== [] ? t('mp_empty_search') : t('mpt_empty_sub')) ?></p>
        <?php endif; ?>

        <p class="mp-note mp-note--box mp-note--disclaimer" role="note"><?= mp_e(t('mpb_disclaimer')) ?></p>
    </div>
    <script src="/assets/js/mp-filters.js?v=<?= (int) @filemtime(__DIR__ . '/assets/js/mp-filters.js') ?>" defer></script>
<?php mpt_close(); ?>
