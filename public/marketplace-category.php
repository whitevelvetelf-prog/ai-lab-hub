<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: сторінка блока або підкатегорії (?id=N — id з mp_categories, як у каталозі).
 *
 *   Блок з підкатегоріями: хлібні крихти «Marketplace › Блок», плитки підкатегорій (назва, іконка, кількість; порожні —
 *     лише при show_empty_categories), пошук і «Свіже» в межах блока. Порожній блок зі списку always_visible_blocks —
 *     «Оголошень поки немає. Станьте першим» і «Подати оголошення».
 *   Підкатегорія (і блок без підкатегорій, як «Інше»): «Marketplace › Блок › Підкатегорія», список по MPT_PER_PAGE
 *     з пагінацією, пошук, сортування (новизна, ціна), фільтри формат / місто / ціна (USD).
 *   У вакансіях, курсах і послугах — згорнутий додатковий фільтр «AI-спрямування» (тематичні категорії section='focus').
 * Оголошення з обох джерел (app/mp-tree.php → mpt_search): користувачів, компаній, матеріали платформи; фільтр не
 * залежить від мови інтерфейсу. Колишні адреси цієї сторінки (?id=N категорії Готових рішень) лишаються чинними:
 * ті самі id тепер підкатегорії блока «Готові рішення». Поки public_enabled = false — 404.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace-board.php';
require_once __DIR__ . '/../app/listing.php';
require_once __DIR__ . '/../app/promo.php';   // analytics_log_view()

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

// Фільтри (білі списки)
$s = static fn(string $k, int $max = 100): string => is_string($_GET[$k] ?? null) ? mb_substr(trim((string) $_GET[$k]), 0, $max) : '';
$num = static function (string $k) use ($s): ?float {
    $raw = str_replace([' ', ','], ['', '.'], $s($k, 14));

    return preg_match('/^\d{1,9}(\.\d{1,2})?$/', $raw) === 1 ? (float) $raw : null;
};
$focusTags = in_array($section, MPT_LST_SECTIONS, true) ? lst_focus_tags($pdo) : [];
$focus = (int) $s('focus', 10);
$focus = in_array($focus, array_column($focusTags, 'id'), true) ? $focus : 0;
$f = [
    'section' => $section, 'cat' => $sub['id'] ?? 0, 'focus' => $focus,
    'q' => $s('q'), 'sort' => in_array($s('sort', 12), MPT_SORTS, true) ? $s('sort', 12) : 'new',
    'format' => in_array($s('format', 10), MPT_FORMATS, true) ? $s('format', 10) : '',
    'city' => $s('city', 80), 'price_min' => $num('price_min'), 'price_max' => $num('price_max'),
];
$page = max(1, min(10000, (int) $s('page', 6)));
$params = array_filter([
    'q' => $f['q'], 'sort' => $f['sort'] !== 'new' ? $f['sort'] : '', 'format' => $f['format'], 'city' => $f['city'],
    'price_min' => $f['price_min'], 'price_max' => $f['price_max'], 'focus' => $focus ?: '',
], static fn($v): bool => $v !== null && $v !== '');
$filtered = $params !== [];
$pageUrl = static fn(int $p): string => mpt_url($id, $params + ($p > 1 ? ['page' => $p] : []));

// Блок без підкатегорій-пошуку: свіже; з пошуком у блоці — список результатів.
$showList = $isList || $filtered;
$result = $showList ? mpt_search($pdo, $lang, $f, $page, MPT_PER_PAGE) : mpt_search($pdo, $lang, $f, 1, MPT_FRESH);
$blockCount = (int) ($counts['blocks'][$section] ?? 0);
$here = $sub ?? $block;
$hereCount = $sub !== null ? (int) ($counts['cats'][$sub['id']] ?? 0) : $blockCount;

analytics_log_view($pdo, 'marketplace_category', null, $section . ($sub !== null ? ':' . $sub['id'] : ''));

$crumbs = [[t('mp_heading'), 'marketplace.php'], [$block['name'], mpt_url($block['id'])]];
if ($sub !== null) {
    $crumbs[] = [$sub['name'], null];
}
$title = ($sub !== null ? $sub['name'] . ' — ' . $block['name'] : $block['name']) . ' — ' . t('title_marketplace')
    . ($showList && $result['page'] > 1 ? ' · ' . sprintf(t('mpt_page_n'), $result['page']) : '');
$desc = sprintf(t($sub !== null ? 'mpt_sub_desc' : 'mpt_block_desc'), $here['name'], $hereCount, $block['name']);
$canonical = mpt_url($id, $showList && $result['page'] > 1 && !$filtered ? ['page' => $result['page']] : []);
mpt_open($title, $desc, $canonical, $filtered || ($hereCount === 0), 'home');
$visibleSubs = mpt_visible_children($block, $counts);
$alwaysVisible = in_array($section, mpt_visibility()['always'], true);
?>
    <div class="mp-page">
        <?= mpt_crumbs($crumbs) ?>
        <h1 class="mp-title"><?= mp_e($here['name']) ?></h1>
        <p class="mp-subtitle"><?= mp_e(mpt_count_label($hereCount)) ?></p>

        <?= mpt_search_form('marketplace-category.php', $f['q'], ['id' => $id] + array_diff_key($params, ['q' => 1]), sprintf(t('mpt_search_in'), $here['name'])) ?>

        <?php if (!$isList && $visibleSubs !== []): ?>
            <h2 class="mp-section-title"><?= mp_e(t('mpt_subcategories')) ?></h2>
            <?= mpt_tiles(array_map(static fn(array $c): array => [$c['name'], $c['icon'], mpt_url($c['id']), $counts['cats'][$c['id']] ?? 0], $visibleSubs), t('mpt_subcategories')) ?>
        <?php endif; ?>

        <?php if ($blockCount === 0 && !$filtered): ?>
            <?= $alwaysVisible || $sub === null ? mpt_empty_invite($section) : '<p class="mp-empty">' . mp_e(t('mpt_empty_sub')) . '</p>' ?>
        <?php endif; ?>

        <?php if ($showList): ?>
            <form class="mp-filters mpt-filters" method="get" action="marketplace-category.php">
                <input type="hidden" name="id" value="<?= (int) $id ?>">
                <?php if ($f['q'] !== ''): ?><input type="hidden" name="q" value="<?= mp_e($f['q']) ?>"><?php endif; ?>
                <div class="mp-field">
                    <label class="mp-label" for="f_sort"><?= mp_e(t('mpb_f_sort')) ?></label>
                    <select class="mp-input" id="f_sort" name="sort">
                        <?php foreach (['new' => t('mpb_sort_new'), 'price_asc' => t('mpb_sort_cheap'), 'price_desc' => t('mpb_sort_expensive')] as $k => $label): ?>
                            <option value="<?= $k ?>"<?= $f['sort'] === $k ? ' selected' : '' ?>><?= mp_e($label) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="mp-field">
                    <label class="mp-label" for="f_format"><?= mp_e(t('mpg_f_format')) ?></label>
                    <select class="mp-input" id="f_format" name="format">
                        <option value=""><?= mp_e(t('mpg_fmt_any')) ?></option>
                        <?php foreach (MPT_FORMATS as $fm): ?>
                            <option value="<?= $fm ?>"<?= $f['format'] === $fm ? ' selected' : '' ?>><?= mp_e(t('mpt_fmt_' . $fm)) ?></option>
                        <?php endforeach; ?>
                    </select>
                </div>
                <div class="mp-field">
                    <label class="mp-label" for="f_city"><?= mp_e(t('mpb_f_city')) ?></label>
                    <input class="mp-input" type="text" id="f_city" name="city" maxlength="80" value="<?= mp_e($f['city']) ?>">
                </div>
                <div class="mp-field">
                    <label class="mp-label" for="f_min"><?= mp_e(t('mpg_f_price_usd')) ?></label>
                    <div class="mp-inline">
                        <input class="mp-input mp-input--num" type="text" inputmode="decimal" id="f_min" name="price_min" maxlength="12" value="<?= $f['price_min'] !== null ? mp_e($f['price_min']) : '' ?>" placeholder="<?= mp_e(t('mpb_from')) ?>" aria-label="<?= mp_e(t('mpb_from')) ?>">
                        <input class="mp-input mp-input--num" type="text" inputmode="decimal" name="price_max" maxlength="12" value="<?= $f['price_max'] !== null ? mp_e($f['price_max']) : '' ?>" placeholder="<?= mp_e(t('mpb_to')) ?>" aria-label="<?= mp_e(t('mpb_to')) ?>">
                    </div>
                </div>
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
                <div class="mp-actions mp-actions--tight">
                    <button class="mp-btn mp-btn--primary" type="submit"><?= mp_e(t('mp_search_btn')) ?></button>
                    <?php if ($filtered): ?><a class="mp-btn" href="<?= mp_e(mpt_url($id)) ?>"><?= mp_e(t('mp_search_reset')) ?></a><?php endif; ?>
                </div>
            </form>
            <p class="mp-count"><?= mp_e(sprintf(t('mpb_found'), $result['total'])) ?></p>
        <?php elseif ($result['rows'] !== []): ?>
            <h2 class="mp-section-title"><?= mp_e(t('mpt_fresh')) ?></h2>
        <?php endif; ?>

        <?php if ($result['rows'] !== []): ?>
            <div class="mp-grid">
                <?php foreach ($result['rows'] as $card): ?><?= mpt_card_html($pdo, $card) ?><?php endforeach; ?>
            </div>
            <?= $showList ? mpt_pager($result, $pageUrl) : '' ?>
        <?php elseif ($showList && ($filtered || $blockCount > 0)): ?>
            <p class="mp-empty"><?= mp_e($filtered ? t('mp_empty_search') : t('mpt_empty_sub')) ?></p>
        <?php endif; ?>

        <p class="mp-note mp-note--box mp-note--disclaimer" role="note"><?= mp_e(t('mpb_disclaimer')) ?></p>
    </div>
<?php mpt_close(); ?>
