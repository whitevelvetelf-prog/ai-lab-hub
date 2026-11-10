<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Marketplace: єдине дерево категорій (блоки → підкатегорії), лічильники з кешем, пошук у блоці.
 *
 * Дерево — mp_categories (міграція database/migration-2026-11-06-marketplace-category-tree.sql, № 18):
 *   блок = рядок з parent_id NULL і section ∈ MPT_SECTIONS; підкатегорія = рядок з parent_id блока й тим самим section.
 *   Назви — mp_category_translations мовою інтерфейсу, запасний варіант англійська, потім українська, потім slug.
 *   section='focus' (8 тематичних категорій) — не блок, а додатковий фільтр у вакансіях/курсах/послугах.
 * Оголошення: mp_listings.section = section блока. post_form = 'ad' — оголошення користувача (форма marketplace-post.php),
 *   '' — вакансії/курси/послуги компаній (listing-post.php) і матеріали платформи (section='solution', видача get.php).
 *   До 3 підкатегорій одного блока (mp_listing_categories); у блоці оголошення рахується один раз.
 * «Цифрові матеріали» (section='asset') — не частина дерева: блок-посилання на assets.php з лічильником.
 * Живі оголошення: status='published' І expires_at > NOW() (матеріали платформи — без терміну).
 * Лічильники кешуються на MPT_CACHE_TTL с (storage/cache) і скидаються mpt_cache_reset() при схваленні, відхиленні,
 * архівації, завершенні терміну, редагуванні й змінах категорій; кеш також не живе довше найближчого expires_at.
 */

require_once __DIR__ . '/marketplace.php';

const MPT_SECTIONS = ['job', 'course', 'service', 'solution', 'goods', 'other'];
const MPT_LST_SECTIONS = ['job', 'course', 'service'];      // форма listing-post.php
const MPT_AD_SECTIONS = ['solution', 'goods', 'other'];      // форма marketplace-post.php
const MPT_MAX_CATS = 3;
const MPT_PER_PAGE = 20;
const MPT_FRESH = 8;
const MPT_CACHE_TTL = 300;
const MPT_SORTS = ['new', 'price_asc', 'price_desc'];
const MPT_FORMATS = ['online', 'offline'];
/** Набір піктограм Lucide для вибору в mp-categories.php (https://lucide.dev/icons/). */
const MPT_ICONS = [
    'briefcase', 'graduation-cap', 'handshake', 'sparkles', 'monitor', 'shapes', 'images', 'brain', 'code', 'bug', 'palette',
    'megaphone', 'headphones', 'clipboard-list', 'timer', 'sprout', 'message-square-text', 'clapperboard', 'trending-up',
    'languages', 'smile', 'users', 'calendar', 'lightbulb', 'bot', 'image', 'workflow', 'book-open', 'database', 'cpu',
    'keyboard', 'smartphone', 'house', 'package', 'layers', 'wrench', 'shield-check', 'chart-line', 'camera', 'music',
    'heart-pulse', 'globe', 'store', 'truck', 'gift', 'gamepad-2', 'pen-tool', 'file-text', 'scan-eye', 'cloud',
];

// =========================================================================
// Дерево
// =========================================================================

/**
 * Дерево категорій. $all = true — разом із неактивними (сторінка керування).
 *
 * @return list<array{id:int,section:string,slug:string,icon:string,sort:int,active:bool,draft:bool,name:string,name_uk:string,name_en:string,children:list<array<string,mixed>>}>
 */
function mpt_tree(PDO $pdo, ?string $lang = null, bool $all = false): array
{
    static $cache = [];
    $lang = $lang ?? current_lang();
    $key = $lang . ($all ? ':all' : '');
    if (isset($cache[$key])) {
        return $cache[$key];
    }
    $in = "'" . implode("', '", MPT_SECTIONS) . "'";
    $st = $pdo->prepare(
        "SELECT c.id, c.section, c.parent_id, c.slug, c.icon, c.sort_order, c.is_active, c.is_draft,
                tl.name AS n_lang, te.name AS n_en, tu.name AS n_uk
         FROM mp_categories c
         LEFT JOIN mp_category_translations tl ON tl.category_id = c.id AND tl.lang = :lang
         LEFT JOIN mp_category_translations te ON te.category_id = c.id AND te.lang = 'en'
         LEFT JOIN mp_category_translations tu ON tu.category_id = c.id AND tu.lang = 'uk'
         WHERE c.section IN ($in)" . ($all ? '' : ' AND c.is_active = 1') . '
         ORDER BY c.parent_id IS NOT NULL, c.sort_order, c.id'
    );
    $st->execute([':lang' => $lang]);
    $blocks = [];
    $subs = [];
    foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $r) {
        $name = '';
        foreach (['n_lang', 'n_en', 'n_uk'] as $k) {
            if (trim((string) $r[$k]) !== '') {
                $name = (string) $r[$k];
                break;
            }
        }
        $node = [
            'id' => (int) $r['id'], 'section' => (string) $r['section'], 'slug' => (string) $r['slug'],
            'icon' => (string) ($r['icon'] ?? '') !== '' ? (string) $r['icon'] : 'shapes', 'sort' => (int) $r['sort_order'],
            'active' => (int) $r['is_active'] === 1, 'draft' => (int) $r['is_draft'] === 1,
            'name' => $name !== '' ? $name : (string) $r['slug'],
            'name_uk' => (string) ($r['n_uk'] ?? ''), 'name_en' => (string) ($r['n_en'] ?? ''), 'children' => [],
        ];
        if ($r['parent_id'] === null) {
            $blocks[$node['section']] ??= $node;   // один блок на section (перший за порядком)
        } else {
            $node['parent_id'] = (int) $r['parent_id'];
            $subs[] = $node;
        }
    }
    foreach ($subs as $s) {
        $b = $blocks[$s['section']] ?? null;
        if ($b !== null && $b['id'] === $s['parent_id']) {
            $blocks[$s['section']]['children'][] = $s;
        }
    }
    $list = array_values($blocks);
    usort($list, static fn(array $a, array $b): int => [$a['sort'], $a['id']] <=> [$b['sort'], $b['id']]);

    return $cache[$key] = $list;
}

/** Блок за section або null. */
function mpt_block(array $tree, string $section): ?array
{
    foreach ($tree as $b) {
        if ($b['section'] === $section) {
            return $b;
        }
    }

    return null;
}

/** Вузол за id: ['block' => …, 'sub' => …|null] або null. */
function mpt_node(array $tree, int $id): ?array
{
    foreach ($tree as $b) {
        if ($b['id'] === $id) {
            return ['block' => $b, 'sub' => null];
        }
        foreach ($b['children'] as $s) {
            if ($s['id'] === $id) {
                return ['block' => $b, 'sub' => $s];
            }
        }
    }

    return null;
}

/** id категорій, які можна вибрати для оголошення блока (підкатегорії; блок без підкатегорій — сам блок). @return list<int> */
function mpt_selectable_ids(array $block): array
{
    return $block['children'] !== [] ? array_column($block['children'], 'id') : [$block['id']];
}

/** Нормалізація вибраних категорій для блока: лише свої, без повторів. @return list<int> */
function mpt_pick_cats(array $block, mixed $raw): array
{
    $ids = array_map('intval', is_array($raw) ? $raw : []);

    return array_values(array_unique(array_intersect($ids, mpt_selectable_ids($block))));
}

function mpt_url(int $id, array $params = []): string
{
    return 'marketplace-category.php?' . http_build_query(['id' => $id] + $params);
}

/** Адреса форми подачі для блока. */
function mpt_post_url(string $section): string
{
    if (in_array($section, MPT_LST_SECTIONS, true)) {
        return 'listing-post.php?type=' . $section;
    }

    return $section === 'asset' ? 'asset-post.php' : 'marketplace-post.php?block=' . rawurlencode($section);
}

/** Чи рядок — вакансія/курс/послуга компанії (модуль app/listing.php). */
function mpt_is_lst(array $row): bool
{
    return in_array((string) ($row['section'] ?? ''), MPT_LST_SECTIONS, true) && (string) ($row['post_form'] ?? '') !== 'ad';
}

/** Чи рядок — матеріал платформи (Готові рішення від AI LAB HUB, видача get.php). */
function mpt_is_platform_solution(array $row): bool
{
    return (string) ($row['section'] ?? '') === 'solution' && (string) ($row['post_form'] ?? '') !== 'ad';
}

/** Адреса сторінки оголошення будь-якого виду. */
function mpt_listing_url(array $row): string
{
    if (mpt_is_lst($row) && function_exists('lst_url')) {
        return lst_url($row);
    }

    return 'marketplace-offer.php?id=' . (int) $row['id'];
}

/** Перша підкатегорія оголошення в його блоці (для хлібних крихт) або null. */
function mpt_listing_crumb(PDO $pdo, array $tree, int $listingId, string $section): ?array
{
    $block = mpt_block($tree, $section);
    if ($block === null) {
        return null;
    }
    $st = $pdo->prepare('SELECT category_id FROM mp_listing_categories WHERE listing_id = :id');
    $st->execute([':id' => $listingId]);
    $sub = null;
    $ids = array_map('intval', $st->fetchAll(PDO::FETCH_COLUMN));
    foreach ($block['children'] as $s) {
        if (in_array($s['id'], $ids, true)) {
            $sub = $s;
            break;
        }
    }
    return ['block' => $block, 'sub' => $sub];
}

/** Хлібні крихти сторінки оголошення: Marketplace › Блок › Підкатегорія › Назва. */
function mpt_offer_crumbs(PDO $pdo, int $listingId, string $section, string $title): array
{
    $items = [[t('mp_heading'), 'marketplace.php']];
    $c = mpt_listing_crumb($pdo, mpt_tree($pdo), $listingId, $section);
    if ($c !== null) {
        $items[] = [$c['block']['name'], mpt_url($c['block']['id'])];
        if ($c['sub'] !== null) {
            $items[] = [$c['sub']['name'], mpt_url($c['sub']['id'])];
        }
    }
    $items[] = [mb_strimwidth($title, 0, 60, '…'), null];

    return $items;
}

// =========================================================================
// Видимість і лічильники
// =========================================================================

/** Умова «живе оголошення дерева» (alias $a). */
function mpt_live_sql(string $a = 'l'): string
{
    $in = "'" . implode("', '", MPT_SECTIONS) . "'";

    return "$a.status = 'published' AND $a.section IN ($in)"
        . " AND ($a.expires_at > NOW() OR ($a.section = 'solution' AND $a.post_form = '' AND $a.expires_at IS NULL))";
}

function mpt_cache_file(): string
{
    return dirname(__DIR__) . '/storage/cache/mp-tree-counts.json';
}

/** Скинути кеш лічильників (схвалення, відхилення, архівація, завершення терміну, редагування, зміни категорій). */
function mpt_cache_reset(): void
{
    $f = mpt_cache_file();
    if (is_file($f)) {
        @unlink($f);
    }
}

/**
 * Лічильники живих оголошень: за категоріями (оголошення рахується в кожній своїй підкатегорії свого блока),
 * за блоками (оголошення — один раз) і «Цифрові матеріали».
 *
 * @return array{cats:array<int,int>,blocks:array<string,int>,assets:int}
 */
function mpt_counts(PDO $pdo): array
{
    $file = mpt_cache_file();
    $raw = is_file($file) ? @file_get_contents($file) : false;
    $data = is_string($raw) ? json_decode($raw, true) : null;
    if (is_array($data) && (int) ($data['until'] ?? 0) > time()) {
        return ['cats' => array_map('intval', (array) $data['cats']), 'blocks' => array_map('intval', (array) $data['blocks']), 'assets' => (int) $data['assets']];
    }

    $cats = [];
    $st = $pdo->query(
        'SELECT lc.category_id, COUNT(DISTINCT l.id) FROM mp_listings l
         JOIN mp_listing_categories lc ON lc.listing_id = l.id
         JOIN mp_categories c ON c.id = lc.category_id AND c.section = l.section
         WHERE ' . mpt_live_sql() . ' GROUP BY lc.category_id'
    );
    foreach ($st->fetchAll(PDO::FETCH_NUM) as [$cid, $n]) {
        $cats[(int) $cid] = (int) $n;
    }
    $blocks = array_map('intval', $pdo->query('SELECT l.section, COUNT(*) FROM mp_listings l WHERE ' . mpt_live_sql() . ' GROUP BY l.section')->fetchAll(PDO::FETCH_KEY_PAIR));
    $assets = 0;
    try {
        $assets = (int) $pdo->query("SELECT COUNT(*) FROM mp_listings l WHERE l.section = 'asset' AND l.status = 'published' AND (l.expires_at IS NULL OR l.expires_at > NOW())")->fetchColumn();
    } catch (Throwable $e) {
        $assets = 0;
    }
    // Кеш не живе довше за найближче завершення терміну.
    $next = $pdo->query("SELECT TIMESTAMPDIFF(SECOND, NOW(), MIN(l.expires_at)) FROM mp_listings l WHERE l.status = 'published' AND l.expires_at > NOW()")->fetchColumn();
    $ttl = MPT_CACHE_TTL;
    if ($next !== null && $next !== false) {
        $ttl = max(1, min($ttl, (int) $next));
    }
    $out = ['cats' => $cats, 'blocks' => $blocks, 'assets' => $assets];
    $dir = dirname($file);
    if (is_dir($dir) || @mkdir($dir, 0775, true)) {
        @file_put_contents($file, json_encode($out + ['until' => time() + $ttl]), LOCK_EX);
    }

    return $out;
}

/** Налаштування показу: show_empty_categories, always_visible_blocks. */
function mpt_visibility(): array
{
    $c = mp_config();
    $always = $c['always_visible_blocks'] ?? ['job', 'course', 'service', 'solution'];

    return ['show_empty' => !empty($c['show_empty_categories']), 'always' => is_array($always) ? array_map('strval', $always) : []];
}

/** Чи показувати блок на головній. */
function mpt_block_visible(array $block, array $counts): bool
{
    $v = mpt_visibility();

    return $v['show_empty'] || ($counts['blocks'][$block['section']] ?? 0) > 0 || in_array($block['section'], $v['always'], true);
}

/** Підкатегорії блока, які показувати (порожні — лише при show_empty_categories). */
function mpt_visible_children(array $block, array $counts): array
{
    $show = mpt_visibility()['show_empty'];

    return array_values(array_filter($block['children'], static fn(array $s): bool => $show || ($counts['cats'][$s['id']] ?? 0) > 0));
}

// =========================================================================
// Пошук у блоці / підкатегорії (обидва джерела: оголошення користувачів і компаній, матеріали платформи)
// =========================================================================

/** Ціна в USD для фільтра й сортування (alias l): оголошення — price_usd; вакансії/курси/послуги — з details за курсом. */
function mpt_price_usd_sql(PDO $pdo): string
{
    $rates = [];
    foreach (['USD', 'EUR', 'UAH', 'GBP', 'PLN'] as $cur) {
        $r = function_exists('mpg_usd_rate') ? mpg_usd_rate($pdo, $cur) : ($cur === 'USD' ? '1' : null);
        if ($r !== null && is_numeric($r) && (float) $r > 0) {
            $rates[$cur] = (float) $r;
        }
    }
    $rateCase = static function (string $curExpr) use ($rates): string {
        if ($rates === []) {
            return 'NULL';
        }
        $sql = "(CASE $curExpr";
        foreach ($rates as $cur => $r) {
            $sql .= " WHEN '$cur' THEN " . rtrim(rtrim(sprintf('%.6F', $r), '0'), '.');
        }

        return $sql . ' ELSE NULL END)';
    };
    $j = static fn(string $k): string => "JSON_UNQUOTE(JSON_EXTRACT(l.details, '$.$k'))";
    $num = static fn(string $k) => 'CAST(NULLIF(' . $j($k) . ", '') AS DECIMAL(14,2))";
    $lst = "(CASE l.section
               WHEN 'job' THEN {$num('salary_min')} / " . $rateCase($j('salary_currency')) . "
               WHEN 'course' THEN IF(" . $j('is_free') . " = '1', 0, {$num('price')} / " . $rateCase($j('currency')) . ")
               WHEN 'service' THEN {$num('price_from')} / " . $rateCase($j('currency')) . '
               ELSE NULL END)';
    $ad = "(CASE l.price_type WHEN 'free' THEN 0 WHEN 'fixed' THEN l.price_usd ELSE NULL END)";

    return "(CASE WHEN l.post_form = '' AND l.section IN ('job', 'course', 'service') THEN $lst ELSE $ad END)";
}

/**
 * Список оголошень блока (або підкатегорії). $f: section (обов'язково), cat (id підкатегорії; 0 — увесь блок),
 * focus (id тематичної категорії), q, sort (new|price_asc|price_desc), format (online|offline), city, price_min, price_max (USD).
 *
 * @return array{rows:list<array<string,mixed>>,total:int,pages:int,page:int}
 */
function mpt_search(PDO $pdo, string $lang, array $f, int $page = 1, int $perPage = MPT_PER_PAGE): array
{
    $where = [mpt_live_sql()];
    $params = [];
    $notes = [];
    $section = (string) ($f['section'] ?? '');
    if (in_array($section, MPT_SECTIONS, true)) {
        $where[] = 'l.section = :sec';
        $params[':sec'] = $section;
    }
    // Фільтри блока (вакансії / курси / послуги, область) і «опубліковано після» — app/mp-jobs.php.
    if (function_exists('mpj_where')) {
        $where = array_merge($where, mpj_where($pdo, ['section' => $section] + (array) ($f['jf'] ?? []) + ['after' => $f['after'] ?? null], $params, $notes));
    }
    foreach (['cat' => 'c1', 'focus' => 'c2'] as $k => $ph) {
        if ((int) ($f[$k] ?? 0) > 0) {
            $where[] = "EXISTS (SELECT 1 FROM mp_listing_categories x$ph WHERE x$ph.listing_id = l.id AND x$ph.category_id = :$ph)";
            $params[":$ph"] = (int) $f[$k];
        }
    }
    $isLst = "(l.post_form = '' AND l.section IN ('job', 'course', 'service'))";
    $format = (string) ($f['format'] ?? '');
    if ($format === 'online') {
        $where[] = "IF($isLst, l.is_remote = 1, l.work_format IN ('online', 'hybrid') OR (l.work_format IS NULL AND l.is_remote = 1))";
    } elseif ($format === 'offline') {
        $where[] = "IF($isLst, l.is_remote = 0, l.work_format IN ('offline', 'hybrid') OR (l.work_format IS NULL AND l.is_remote = 0))";
    }
    $city = trim((string) ($f['city'] ?? ''));
    if ($city !== '') {
        $like = '%' . addcslashes(mb_substr($city, 0, 80), '%_\\') . '%';
        $where[] = "(l.city LIKE :city1 ESCAPE '\\\\' OR JSON_UNQUOTE(JSON_EXTRACT(l.details, '$.city')) LIKE :city2 ESCAPE '\\\\'"
            . ' OR EXISTS (SELECT 1 FROM geo_place_names gn WHERE gn.place_id = l.primary_place_id AND gn.name LIKE :city3 ESCAPE \'\\\\\'))';
        $params[':city1'] = $like;
        $params[':city2'] = $like;
        $params[':city3'] = $like;
        if (!mpt_table_exists($pdo, 'geo_place_names')) {
            array_pop($where);
            unset($params[':city3']);
            $where[] = "(l.city LIKE :city1 ESCAPE '\\\\' OR JSON_UNQUOTE(JSON_EXTRACT(l.details, '$.city')) LIKE :city2 ESCAPE '\\\\')";
        }
    }
    $sort = in_array((string) ($f['sort'] ?? ''), array_merge(MPT_SORTS, ['salary_desc', 'salary_asc']), true) ? (string) $f['sort'] : 'new';
    $jobOrder = function_exists('mpj_order') ? mpj_order($pdo, $sort, (array) ($f['jf'] ?? [])) : null;
    if ($jobOrder === null && !in_array($sort, MPT_SORTS, true)) {
        $sort = 'new';
    }
    $eff = null;
    if ($sort !== 'new' || ($f['price_min'] ?? null) !== null || ($f['price_max'] ?? null) !== null) {
        $eff = mpt_price_usd_sql($pdo);
        if (($f['price_min'] ?? null) !== null) {
            $where[] = "$eff >= :pmin";
            $params[':pmin'] = (float) $f['price_min'];
        }
        if (($f['price_max'] ?? null) !== null) {
            $where[] = "$eff <= :pmax";
            $params[':pmax'] = (float) $f['price_max'];
        }
    }
    $q = trim((string) ($f['q'] ?? ''));
    if ($q !== '') {
        $like = '%' . addcslashes(mb_substr($q, 0, 100), '%_\\') . '%';
        $where[] = "(tc.title LIKE :q1 ESCAPE '\\\\' OR ts.title LIKE :q2 ESCAPE '\\\\' OR l.company_name LIKE :q3 ESCAPE '\\\\')";
        $params[':q1'] = $like;
        $params[':q2'] = $like;
        $params[':q3'] = $like;
    }
    $order = $jobOrder ?? match ($sort) {
        'price_asc'  => "($eff IS NULL) ASC, $eff ASC, l.published_at DESC, l.id DESC",
        'price_desc' => "($eff IS NULL) ASC, $eff DESC, l.published_at DESC, l.id DESC",
        default      => 'l.published_at DESC, l.id DESC',
    };
    $from = "FROM mp_listings l
             LEFT JOIN mp_listing_translations tc ON tc.listing_id = l.id AND tc.lang = :lang
             LEFT JOIN mp_listing_translations ts ON ts.listing_id = l.id AND ts.lang = l.source_lang
             WHERE " . implode(' AND ', $where) . " AND COALESCE(NULLIF(tc.title, ''), ts.title) IS NOT NULL";
    $params[':lang'] = $lang;
    $cnt = $pdo->prepare("SELECT COUNT(*) $from");
    $cnt->execute($params);
    $total = (int) $cnt->fetchColumn();
    $perPage = max(1, min(100, $perPage));
    $pages = max(1, (int) ceil($total / $perPage));
    $page = max(1, min($page, $pages));
    $ids = $pdo->prepare("SELECT l.id $from ORDER BY $order LIMIT $perPage OFFSET " . (($page - 1) * $perPage));
    $ids->execute($params);

    return ['rows' => mpt_rows($pdo, $lang, array_map('intval', $ids->fetchAll(PDO::FETCH_COLUMN))), 'total' => $total, 'pages' => $pages, 'page' => $page, 'notes' => $notes];
}

function mpt_table_exists(PDO $pdo, string $table): bool
{
    static $cache = [];
    if (!isset($cache[$table])) {
        try {
            $st = $pdo->prepare('SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = :t');
            $st->execute([':t' => $table]);
            $cache[$table] = (int) $st->fetchColumn() > 0;
        } catch (Throwable $e) {
            $cache[$table] = false;
        }
    }

    return $cache[$table];
}

/**
 * Рядки для карток у заданому порядку id: вакансії/курси/послуги — через app/listing.php (lst_*),
 * оголошення користувачів і матеріали платформи — через app/marketplace-board.php (mpb_*).
 *
 * @param list<int> $ids
 * @return list<array<string,mixed>>
 */
function mpt_rows(PDO $pdo, string $lang, array $ids): array
{
    if ($ids === []) {
        return [];
    }
    require_once __DIR__ . '/listing.php';
    $in = implode(',', array_fill(0, count($ids), '?'));
    $kind = $pdo->prepare("SELECT id, section, post_form FROM mp_listings WHERE id IN ($in)");
    $kind->execute($ids);
    $lstIds = [];
    $adIds = [];
    foreach ($kind->fetchAll(PDO::FETCH_ASSOC) as $k) {
        if (mpt_is_lst($k)) {
            $lstIds[] = (int) $k['id'];
        } else {
            $adIds[] = (int) $k['id'];
        }
    }
    $byId = [];
    $fetch = static function (string $selectSql, array $sub) use ($pdo, $lang): array {
        if ($sub === []) {
            return [];
        }
        $named = [];
        $params = [':lang' => $lang];
        foreach ($sub as $i => $id) {
            $named[] = ':i' . $i;
            $params[':i' . $i] = $id;
        }
        $st = $pdo->prepare($selectSql . ' WHERE l.id IN (' . implode(',', $named) . ')');
        $st->execute($params);

        return $st->fetchAll(PDO::FETCH_ASSOC);
    };
    foreach (lst_hydrate($pdo, $fetch(str_replace('SELECT l.id,', 'SELECT l.id, l.post_form,', lst_select_sql()), $lstIds), $lang) as $r) {
        $r['kind'] = 'lst';
        $byId[(int) $r['id']] = $r;
    }
    $adRows = $fetch(mpb_select_sql($pdo), $adIds);
    foreach (mp_attach_categories($pdo, mpb_auto_translate($pdo, $adRows, $lang), $lang) as $r) {
        $r['kind'] = mpt_is_platform_solution($r) ? 'platform' : 'ad';
        $byId[(int) $r['id']] = $r;
    }
    $out = [];
    foreach ($ids as $id) {
        if (isset($byId[$id])) {
            $out[] = $byId[$id];
        }
    }

    return $out;
}

/** Картка будь-якого виду (той самий вигляд, що в списках розділу). */
function mpt_card_html(PDO $pdo, array $card): string
{
    if (($card['kind'] ?? '') === 'lst') {
        return lst_card_html($card);
    }
    $filters = ['units' => 'km'];
    ob_start();
    include __DIR__ . '/mpb-card.php';

    return (string) ob_get_clean();
}

// =========================================================================
// Вивід: сторінка, хлібні крихти, плитки (ті самі класи, що на головній каталогу й сторінці категорії)
// =========================================================================

/** Початок сторінки з унікальними title/description і канонічною адресою. Закривати mpt_close(). */
function mpt_open(string $title, string $description, string $canonical, bool $noindex = false, string $nav = 'home'): void
{
    $lang = current_lang();
    $base = function_exists('app_canonical_base') ? app_canonical_base() : null;
    $abs = $base !== null ? $base['scheme'] . '://' . $base['host'] . $base['port'] . '/' . ltrim($canonical, '/') : '/' . ltrim($canonical, '/');
    echo "<!DOCTYPE html>\n<html lang=\"" . mp_e($lang) . "\">\n<head>\n<meta charset=\"utf-8\">\n"
        . "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n"
        . ($noindex ? "<meta name=\"robots\" content=\"noindex, follow\">\n" : '')
        . '<title>' . mp_e($title) . "</title>\n"
        . '<meta name="description" content="' . mp_e(mb_substr($description, 0, 300)) . "\">\n"
        . '<link rel="canonical" href="' . mp_e($abs) . "\">\n"
        . '<meta property="og:title" content="' . mp_e($title) . "\">\n"
        . '<meta property="og:description" content="' . mp_e(mb_substr($description, 0, 300)) . "\">\n";
    include __DIR__ . '/header.php';
    echo "\n<link rel=\"stylesheet\" href=\"/assets/css/site-nav.css\">\n"
        . '<link rel="stylesheet" href="' . css_asset('mp-public.css') . "\">\n</head>\n<body class=\"mp-body\">\n";
    include __DIR__ . '/site-header.php';
    if ($nav !== '') {
        echo mp_section_nav($nav);
    }
}

function mpt_close(): void
{
    echo '<script src="/assets/js/vendor/lucide-1.71.0.min.js"></script>' . "\n"
        . '<script>if (window.lucide) { lucide.createIcons(); }</script>' . "\n";
    mpb_close();
}

/** Хлібні крихти: list<[назва, адреса|null]> (остання — поточна сторінка). */
function mpt_crumbs(array $items): string
{
    $html = '<nav class="mpt-crumbs" aria-label="' . mp_e(t('mpt_crumbs')) . '"><ol>';
    $last = count($items) - 1;
    foreach ($items as $i => [$label, $href]) {
        $html .= '<li>' . ($href !== null && $i !== $last
            ? '<a href="' . mp_e($href) . '">' . mp_e($label) . '</a>'
            : '<span aria-current="page">' . mp_e($label) . '</span>') . '</li>';
    }

    return $html . '</ol></nav>';
}

/**
 * Сітка плиток (блоки на головній або підкатегорії на сторінці блока) — класи .direction-grid / .direction-card,
 * як на головній каталогу. $items: list<[назва, піктограма, адреса, кількість|null]>.
 */
function mpt_tiles(array $items, string $label): string
{
    $html = '<div class="direction-grid mpt-grid" role="list" aria-label="' . mp_e($label) . '">';
    foreach ($items as [$name, $icon, $href, $count]) {
        $html .= '<a class="direction-card" role="listitem" href="' . mp_e($href) . '">'
            . '<span class="direction-card__icon" aria-hidden="true"><i data-lucide="' . mp_e($icon) . '"></i></span>'
            . '<span class="direction-card__body"><span class="direction-card__name">' . mp_e($name) . '</span>'
            . ($count !== null ? '<span class="direction-card__count">' . mp_e(mpt_count_label((int) $count)) . '</span>' : '')
            . '</span></a>';
    }

    return $html . '</div>';
}

/** «N оголошень» з відмінюванням (uk) / «N listings» (en). */
function mpt_count_label(int $n): string
{
    if (current_lang() === 'en') {
        return $n === 1 ? '1 listing' : $n . ' listings';
    }
    $m10 = $n % 10;
    $m100 = $n % 100;
    $form = $m10 === 1 && $m100 !== 11 ? 'оголошення' : ($m10 >= 2 && $m10 <= 4 && ($m100 < 12 || $m100 > 14) ? 'оголошення' : 'оголошень');

    return $n . ' ' . $form;
}

/** Блоки для головної: list<[назва, піктограма, адреса, кількість]> з урахуванням правил показу + «Цифрові матеріали». */
function mpt_home_tiles(array $tree, array $counts): array
{
    $items = [];
    foreach ($tree as $b) {
        if (!mpt_block_visible($b, $counts)) {
            continue;
        }
        if ($b['section'] === 'other') {
            $items[] = 'ASSETS';   // «Цифрові матеріали» — перед «Іншим»
        }
        $items[] = [$b['name'], $b['icon'], mpt_url($b['id']), $counts['blocks'][$b['section']] ?? 0];
    }
    $assets = mpt_assets_tile($counts);
    $pos = array_search('ASSETS', $items, true);
    if ($pos === false) {
        if ($assets !== null) {
            $items[] = $assets;
        }
    } elseif ($assets !== null) {
        $items[$pos] = $assets;
    } else {
        unset($items[$pos]);
    }

    return array_values($items);
}

/** Блок-посилання «Цифрові матеріали» (наявний розділ assets.php) або null, якщо розділу немає. */
function mpt_assets_tile(array $counts): ?array
{
    if (!is_file(dirname(__DIR__) . '/public/assets.php') || !is_file(__DIR__ . '/asset-i18n.php')) {
        return null;
    }
    require_once __DIR__ . '/asset-i18n.php';
    $v = mpt_visibility();
    if (!$v['show_empty'] && $counts['assets'] <= 0 && !in_array('asset', $v['always'], true)) {
        return null;
    }

    return [ast_tr('nav'), 'images', 'assets.php', $counts['assets']];
}

/** Дві помітні кнопки: «Подати оголошення» і «Безкоштовні рішення». */
function mpt_cta_html(array $tree): string
{
    $sol = mpt_block($tree, 'solution');
    $html = '<div class="mpt-cta">';
    if (mp_posting_enabled() || mp_is_staff()) {
        $html .= '<a class="mpt-cta__btn mpt-cta__btn--post" href="marketplace-post.php"><i data-lucide="plus" aria-hidden="true"></i><span>' . mp_e(t('mpb_post_btn')) . '</span></a>';
    }
    if ($sol !== null) {
        $html .= '<a class="mpt-cta__btn mpt-cta__btn--free" href="' . mp_e(mpt_url($sol['id'])) . '"><i data-lucide="gift" aria-hidden="true"></i><span>' . mp_e(t('mpt_free_solutions')) . '</span></a>';
    }

    return $html . '</div>';
}

/** Форма пошуку ($action — адреса; $hidden — приховані поля). */
function mpt_search_form(string $action, string $q, array $hidden = [], string $placeholder = ''): string
{
    $html = '<form class="mpt-search" method="get" action="' . mp_e($action) . '" role="search">';
    foreach ($hidden as $k => $v) {
        $html .= '<input type="hidden" name="' . mp_e($k) . '" value="' . mp_e((string) $v) . '">';
    }

    return $html . '<label class="mp-visually-hidden" for="mpt_q">' . mp_e(t('mpb_f_search')) . '</label>'
        . '<input class="mp-input" type="search" id="mpt_q" name="q" maxlength="100" value="' . mp_e($q) . '" placeholder="'
        . mp_e($placeholder !== '' ? $placeholder : t('mp_search_placeholder')) . '">'
        . '<button class="mp-btn mp-btn--primary" type="submit">' . mp_e(t('mp_search_btn')) . '</button></form>';
}

/** Пагінація. $url — fn(int $page): string. */
function mpt_pager(array $result, callable $url): string
{
    if ($result['pages'] <= 1) {
        return '';
    }
    $p0 = $result['page'];
    $html = '<nav class="mp-pager" aria-label="' . mp_e(t('mpb_pages')) . '">';
    if ($p0 > 1) {
        $html .= '<a class="mp-btn" href="' . mp_e($url($p0 - 1)) . '" rel="prev">←</a>';
    }
    for ($p = 1; $p <= $result['pages']; $p++) {
        if ($p === 1 || $p === $result['pages'] || abs($p - $p0) <= 2) {
            $html .= '<a class="mp-btn' . ($p === $p0 ? ' mp-btn--primary' : '') . '" href="' . mp_e($url($p)) . '"' . ($p === $p0 ? ' aria-current="page"' : '') . '>' . $p . '</a>';
        } elseif (abs($p - $p0) === 3) {
            $html .= '<span class="mp-pager__gap">…</span>';
        }
    }
    if ($p0 < $result['pages']) {
        $html .= '<a class="mp-btn" href="' . mp_e($url($p0 + 1)) . '" rel="next">→</a>';
    }

    return $html . '</nav>';
}

/** Порожній блок зі списку always_visible_blocks: напис і кнопка «Подати оголошення». */
function mpt_empty_invite(string $section): string
{
    $html = '<div class="mpt-empty"><p>' . mp_e(t('mpt_empty_block')) . '</p>';
    if (mp_posting_enabled() || mp_is_staff()) {
        $html .= '<a class="mpt-cta__btn mpt-cta__btn--post" href="' . mp_e(mpt_post_url($section)) . '"><span>' . mp_e(t('mpb_post_btn')) . '</span></a>';
    }

    return $html . '</div>';
}
