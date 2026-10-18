<?php

declare(strict_types=1);

/**
 * AI LAB HUB — місця показу реклами (ad_placements, міграція 2026-10-18).
 *
 * Кожне місце — ключ (category_page, subcategory_list, search_results, product_page,
 * blog_list, blog_article, marketplace_listing), назва й опис UA/EN, група, перемикач
 * адміна, ліміт блоків на сторінку, правило позиції (JSON) і залежність від
 * налаштування сайту (requires_setting, напр. marketplace_public).
 *
 * Старі ключі (до 2026-10-18) працюють і далі: catalog_card = subcategory_list +
 * search_results, blog_inline = blog_article. Рядок ad_targets зі старим ключем
 * підходить для нового місця (promo_placement_match_keys), тож кампанії, створені до
 * міграції, показуються там само, як і раніше.
 *
 * Без таблиці (міграцію ще не застосовано) — значення за замовчуванням нижче.
 */

require_once __DIR__ . '/site-settings.php';

/** Старий ключ → нові місця, які він покриває. */
const PROMO_LEGACY_PLACEMENTS = [
    'catalog_card' => ['subcategory_list', 'search_results'],
    'blog_inline'  => ['blog_article'],
];

const PROMO_PLACEMENT_GROUPS = ['catalog', 'blog', 'marketplace'];

/** Менше людських переглядів за 30 днів — «даних поки замало», а не слабка цифра. */
const PROMO_CAPACITY_MIN_VIEWS = 100;
const PROMO_CAPACITY_DAYS = 30;

/** Значення за замовчуванням (= рядки міграції), якщо таблиці ad_placements ще немає. */
const PROMO_PLACEMENT_DEFAULTS = [
    'category_page' => ['Сторінка категорії', 'Category page', 'Один блок після вступу, перед сіткою підкатегорій.', 'One block after the intro, before the grid of subcategories.', 'catalog', 1, 1, '{"after":"intro"}', null, 10],
    'subcategory_list' => ['Список продуктів підкатегорії', 'Subcategory product list', 'Картка на 3-й позиції серед продуктів, одна на сторінку.', 'A card in 3rd position among the products, one per page.', 'catalog', 1, 1, '{"position":3}', null, 20],
    'search_results' => ['Результати пошуку й добірки', 'Search results and collections', 'Картка на 3-й позиції в результатах пошуку й добірках каталогу.', 'A card in 3rd position in search results and catalog collections.', 'catalog', 1, 1, '{"position":3}', null, 30],
    'product_page' => ['Сторінка продукту', 'Product page', 'Один блок під описом продукту.', 'One block below the product description.', 'catalog', 1, 1, '{"after":"description"}', null, 40],
    'blog_list' => ['Список статей блогу', 'Blog article list', 'Один блок після 3-ї статті у списку.', 'One block after the 3rd article in the list.', 'blog', 1, 1, '{"after_item":3}', null, 50],
    'blog_article' => ['Усередині статті', 'Inside an article', 'Один блок після першого розділу з достатньою кількістю тексту — не на початку й не в кінці.', 'One block after the first section with enough text — not at the very start or end.', 'blog', 1, 1, '{"min_chars_before":600,"min_chars_after":400}', null, 60],
    'marketplace_listing' => ['Оголошення маркетплейсу', 'Marketplace listings', 'Просунуте оголошення серед оголошень маркетплейсу.', 'A promoted listing among marketplace listings.', 'marketplace', 0, 1, '{"position":3,"requires_feature":"featured_listings"}', 'marketplace_public', 70],
];

/** Можливості сайту, від яких залежать місця (position_rule.requires_feature). Ще не зроблені — false. */
const PROMO_PLACEMENT_FEATURES = [
    'featured_listings' => false, // позначка «Просунуте» для оголошень маркетплейсу
];

/**
 * Усі місця за sort_order: key => [key, title_uk, title_en, description_uk, description_en,
 * group_key, enabled, slots_per_page, rule (масив), requires_setting, sort_order].
 *
 * @return array<string,array<string,mixed>>
 */
function promo_placements(PDO $pdo, bool $refresh = false): array
{
    static $cache = null;
    if ($cache !== null && !$refresh) {
        return $cache;
    }
    $rows = [];
    try {
        $rows = $pdo->query('SELECT * FROM ad_placements ORDER BY sort_order, placement_key')->fetchAll();
    } catch (Throwable $e) {
        // Міграцію 2026-10-18 ще не застосовано.
    }
    if ($rows === []) {
        foreach (PROMO_PLACEMENT_DEFAULTS as $k => $d) {
            $rows[] = ['placement_key' => $k, 'title_uk' => $d[0], 'title_en' => $d[1], 'description_uk' => $d[2], 'description_en' => $d[3],
                'group_key' => $d[4], 'enabled' => $d[5], 'slots_per_page' => $d[6], 'position_rule' => $d[7], 'requires_setting' => $d[8], 'sort_order' => $d[9]];
        }
    }
    $cache = [];
    foreach ($rows as $r) {
        $k = (string) $r['placement_key'];
        if (!in_array($k, PROMO_PLACEMENTS, true)) {
            continue;
        }
        $rule = json_decode((string) ($r['position_rule'] ?? ''), true);
        $cache[$k] = [
            'key' => $k,
            'title_uk' => (string) $r['title_uk'],
            'title_en' => (string) $r['title_en'],
            'description_uk' => (string) $r['description_uk'],
            'description_en' => (string) $r['description_en'],
            'group_key' => (string) $r['group_key'],
            'enabled' => (int) $r['enabled'] === 1,
            'slots_per_page' => max(1, (int) $r['slots_per_page']),
            'rule' => is_array($rule) ? $rule : [],
            'requires_setting' => $r['requires_setting'] !== null && $r['requires_setting'] !== '' ? (string) $r['requires_setting'] : null,
            'sort_order' => (int) $r['sort_order'],
        ];
    }

    return $cache;
}

/** Ключ, який приймають токени, події й статистика: нове місце або старий ключ. */
function promo_placement_valid(string $key): bool
{
    return in_array($key, PROMO_PLACEMENTS, true) || isset(PROMO_LEGACY_PLACEMENTS[$key]);
}

/**
 * Значення ad_targets.placement, що підходять для місця: саме місце й старі ключі,
 * які його покривають.
 *
 * @return list<string>
 */
function promo_placement_match_keys(string $key): array
{
    $keys = [$key];
    foreach (PROMO_LEGACY_PLACEMENTS as $old => $new) {
        if (in_array($key, $new, true)) {
            $keys[] = $old;
        }
    }

    return $keys;
}

/**
 * Старі ключі → нові (для показу таргетингу кампанії в майстрі).
 *
 * @param list<string> $keys
 * @return list<string>
 */
function promo_placements_normalize(array $keys): array
{
    $out = [];
    foreach ($keys as $k) {
        foreach (PROMO_LEGACY_PLACEMENTS[$k] ?? [$k] as $n) {
            if (in_array($n, PROMO_PLACEMENTS, true)) {
                $out[] = $n;
            }
        }
    }

    return array_values(array_unique($out));
}

/** Назва місця мовою (uk|en); старі ключі — назва зі словника кабінету. */
function promo_placement_title(PDO $pdo, string $key, string $lang = 'uk'): string
{
    $p = promo_placements($pdo)[$key] ?? null;
    if ($p !== null) {
        return $lang === 'en' ? $p['title_en'] : $p['title_uk'];
    }
    if (defined('PROMO_I18N') && isset(PROMO_I18N['placement_' . $key])) {
        return PROMO_I18N['placement_' . $key][$lang === 'en' ? 1 : 0];
    }

    return $key;
}

function promo_placement_description(PDO $pdo, string $key, string $lang = 'uk'): string
{
    $p = promo_placements($pdo)[$key] ?? null;

    return $p === null ? '' : ($lang === 'en' ? $p['description_en'] : $p['description_uk']);
}

/**
 * Чому місце зараз недоступне (без урахування ціни): 'disabled' — вимкнене адміном,
 * 'setting' — вимкнене налаштування сайту (requires_setting), 'feature' — потрібна
 * можливість сайту ще не зроблена; null — доступне.
 */
function promo_placement_block_reason(PDO $pdo, string $key): ?string
{
    $p = promo_placements($pdo)[$key] ?? null;
    if ($p === null || !$p['enabled']) {
        return 'disabled';
    }
    if ($p['requires_setting'] !== null && site_setting($pdo, $p['requires_setting'], '0') !== '1') {
        return 'setting';
    }
    $feature = (string) ($p['rule']['requires_feature'] ?? '');
    if ($feature !== '' && empty(PROMO_PLACEMENT_FEATURES[$feature])) {
        return 'feature';
    }

    return null;
}

function promo_placement_available(PDO $pdo, string $key): bool
{
    return promo_placement_block_reason($pdo, $key) === null;
}

/**
 * Доступні зараз місця (увімкнені, без вимкнених залежностей) — для медіакіту й довідника.
 *
 * @return list<string>
 */
function promo_placements_public(PDO $pdo): array
{
    return array_values(array_filter(array_keys(promo_placements($pdo)), static fn($k) => promo_placement_available($pdo, $k)));
}

/** Ліміт блоків цього місця на одній сторінці. */
function promo_placement_slots(PDO $pdo, string $key): int
{
    return (int) (promo_placements($pdo)[$key]['slots_per_page'] ?? 1);
}

/** Число з правила позиції (position, after_item, min_chars_before…) або $default. */
function promo_placement_rule_int(PDO $pdo, string $key, string $field, int $default): int
{
    $v = promo_placements($pdo)[$key]['rule'][$field] ?? null;

    return is_numeric($v) && (int) $v > 0 ? (int) $v : $default;
}

// --- Категорії статей блогу ------------------------------------------------

/**
 * Категорії й підкатегорії статті: теми з коду (BLOG_ARTICLE_TOPICS) + призначені
 * в адмінці (blog_post_categories). Стаття без категорій — порожні списки
 * (показується лише реклама для «усіх категорій»).
 *
 * @return array{0:list<int>,1:list<int>}
 */
function promo_blog_article_taxonomy(PDO $pdo, string $slug): array
{
    require_once __DIR__ . '/blog.php';
    $cats = [];
    $subs = [];
    try {
        foreach (blog_article_topics($slug) as $topic) {
            $q = $pdo->prepare('SELECT id FROM categories WHERE slug = :s');
            $q->execute([':s' => $topic['cat']]);
            $catId = (int) $q->fetchColumn();
            if ($catId <= 0) {
                continue;
            }
            $cats[] = $catId;
            if ($topic['sub'] !== '') {
                $q = $pdo->prepare('SELECT id FROM subcategories WHERE slug = :s AND category_id = :c');
                $q->execute([':s' => $topic['sub'], ':c' => $catId]);
                $subId = (int) $q->fetchColumn();
                if ($subId > 0) {
                    $subs[] = $subId;
                }
            }
        }
    } catch (Throwable $e) {
        error_log('[promo] blog topics: ' . $e->getMessage());
    }
    foreach (promo_blog_assigned($pdo, $slug) as [$cid, $sid]) {
        $cats[] = $cid;
        if ($sid > 0) {
            $subs[] = $sid;
        }
    }

    return [array_values(array_unique($cats)), array_values(array_unique($subs))];
}

/**
 * Категорії статті, призначені в адмінці: list of [category_id, subcategory_id (0 — уся категорія)].
 *
 * @return list<array{0:int,1:int}>
 */
function promo_blog_assigned(PDO $pdo, string $slug): array
{
    try {
        $st = $pdo->prepare('SELECT category_id, subcategory_id FROM blog_post_categories WHERE slug = :s');
        $st->execute([':s' => $slug]);

        return array_map(static fn($r) => [(int) $r['category_id'], (int) $r['subcategory_id']], $st->fetchAll());
    } catch (Throwable $e) {
        return []; // міграцію 2026-10-18 ще не застосовано
    }
}

/**
 * Замінити категорії статті, призначені в адмінці. $pairs — ['5' або '5:12', …]
 * (категорія або категорія:підкатегорія). Повертає кількість збережених.
 */
function promo_blog_assign(PDO $pdo, string $slug, array $pairs): int
{
    $subParent = [];
    foreach ($pdo->query('SELECT id, category_id FROM subcategories') as $s) {
        $subParent[(int) $s['id']] = (int) $s['category_id'];
    }
    $catIds = array_map('intval', $pdo->query('SELECT id FROM categories')->fetchAll(PDO::FETCH_COLUMN));
    $rows = [];
    foreach ($pairs as $pair) {
        [$c, $s] = array_pad(array_map('intval', explode(':', (string) $pair, 2)), 2, 0);
        if ($s > 0 && ($subParent[$s] ?? 0) === $c) {
            $rows[$c . ':' . $s] = [$c, $s];
        } elseif ($s === 0 && in_array($c, $catIds, true)) {
            $rows[$c . ':0'] = [$c, 0];
        }
    }
    $pdo->beginTransaction();
    try {
        $pdo->prepare('DELETE FROM blog_post_categories WHERE slug = :s')->execute([':s' => $slug]);
        $ins = $pdo->prepare('INSERT INTO blog_post_categories (slug, category_id, subcategory_id, created_at) VALUES (:s, :c, :sub, UTC_TIMESTAMP())');
        foreach ($rows as [$c, $s]) {
            $ins->execute([':s' => $slug, ':c' => $c, ':sub' => $s]);
        }
        $pdo->commit();
    } catch (Throwable $e) {
        $pdo->rollBack();
        throw $e;
    }

    return count($rows);
}

/**
 * Статті блогу з категоріями (з коду й з адмінки): slug => [cats, subs].
 *
 * @return array<string,array{0:list<int>,1:list<int>}>
 */
function promo_blog_taxonomy_map(PDO $pdo): array
{
    require_once __DIR__ . '/blog.php';
    $slugs = array_keys(BLOG_ARTICLE_TOPICS);
    try {
        $slugs = array_merge($slugs, $pdo->query('SELECT DISTINCT slug FROM blog_post_categories')->fetchAll(PDO::FETCH_COLUMN));
    } catch (Throwable $e) {
        // без таблиці — лише теми з коду
    }
    $out = [];
    foreach (array_unique($slugs) as $slug) {
        $out[(string) $slug] = promo_blog_article_taxonomy($pdo, (string) $slug);
    }

    return $out;
}

// --- Орієнтовна ємність ----------------------------------------------------

/**
 * Перегляди сторінок місця за останні PROMO_CAPACITY_DAYS повних київських діб у межах
 * таргетингу. Лише люди (device_class відомий і не bot — клас пишеться з 2026-10-12),
 * без сторінок no_promo. null — для місця немає даних (сторінка не пишеться в аналітику).
 *
 * Збіг таргетингу — як у promo_pick: «усі категорії» ($cats і $subs порожні) — усі
 * сторінки місця; інакше сторінка, чия категорія є в $cats або підкатегорія в $subs.
 * Пошук, список статей і статті без категорій збігаються лише з «усіма категоріями».
 *
 * @param list<int> $cats
 * @param list<int> $subs
 */
function promo_placement_capacity(PDO $pdo, string $key, array $cats, array $subs, ?string $lang, ?string $device): ?int
{
    if (!in_array($key, ['category_page', 'subcategory_list', 'search_results', 'product_page', 'blog_list', 'blog_article'], true)) {
        return null;
    }
    $all = $cats === [] && $subs === [];
    $catIn = promo_in_ints($cats);
    $subIn = promo_in_ints($subs);

    $to = promo_today(-1);
    $from = promo_today(-PROMO_CAPACITY_DAYS);
    [$fromUtc] = promo_day_bounds_utc($from);
    [, $toUtc] = promo_day_bounds_utc($to);
    $where = "v.viewed_at >= :f AND v.viewed_at < :t AND v.device_class IS NOT NULL AND v.device_class <> 'bot'";
    $params = [':f' => $fromUtc, ':t' => $toUtc];
    if ($lang === 'uk' || $lang === 'en') {
        $where .= ' AND v.lang = :lang';
        $params[':lang'] = $lang;
    }
    if ($device === 'desktop') {
        $where .= " AND v.device_class = 'desktop'";
    } elseif ($device === 'mobile') {
        $where .= " AND v.device_class IN ('mobile', 'tablet')";
    }

    switch ($key) {
        case 'category_page':
            $sql = "SELECT COUNT(*) FROM page_views v JOIN categories c ON c.id = v.page_id
                    WHERE {$where} AND v.page_type = 'category' AND c.no_promo = 0"
                . ($all ? '' : " AND c.id IN ({$catIn})");
            break;
        case 'product_page':
            $sql = "SELECT COUNT(*) FROM page_views v JOIN products p ON p.id = v.page_id
                    WHERE {$where} AND v.page_type = 'product' AND p.no_promo = 0
                      AND NOT EXISTS (SELECT 1 FROM product_categories pc JOIN categories c ON c.id = pc.category_id
                                      WHERE pc.product_id = p.id AND c.no_promo = 1)
                      AND NOT EXISTS (SELECT 1 FROM product_subcategories ps JOIN subcategories s ON s.id = ps.subcategory_id
                                      WHERE ps.product_id = p.id AND s.no_promo = 1)"
                . ($all ? '' : " AND (EXISTS (SELECT 1 FROM product_categories pc WHERE pc.product_id = p.id AND pc.category_id IN ({$catIn}))
                                   OR EXISTS (SELECT 1 FROM product_subcategories ps WHERE ps.product_id = p.id AND ps.subcategory_id IN ({$subIn})))");
            break;
        case 'subcategory_list':
            // catalog.php пише page_type 'other', page_slug 'sub:<id>' (з 2026-10-18).
            $sql = "SELECT COUNT(*) FROM page_views v
                    JOIN subcategories s ON s.id = CAST(SUBSTRING(v.page_slug, 5) AS UNSIGNED)
                    JOIN categories c ON c.id = s.category_id
                    WHERE {$where} AND v.page_type = 'other' AND v.page_slug LIKE 'sub:%' AND s.no_promo = 0 AND c.no_promo = 0"
                . ($all ? '' : " AND (s.category_id IN ({$catIn}) OR s.id IN ({$subIn}))");
            break;
        case 'search_results':
            // 'search' — пошук, 'all' — усі продукти, 'cat:<id>' — усі продукти категорії.
            $sql = "SELECT COUNT(*) FROM page_views v
                    LEFT JOIN categories c ON v.page_slug LIKE 'cat:%' AND c.id = CAST(SUBSTRING(v.page_slug, 5) AS UNSIGNED)
                    WHERE {$where} AND v.page_type = 'other'
                      AND (v.page_slug IN ('search', 'all') OR (v.page_slug LIKE 'cat:%' AND c.no_promo = 0))"
                . ($all ? '' : " AND c.id IN ({$catIn})");
            break;
        case 'blog_list':
            if (!$all) {
                return 0;
            }
            $sql = "SELECT COUNT(*) FROM page_views v WHERE {$where} AND v.page_type = 'other' AND v.page_slug = 'blog'";
            break;
        default: // blog_article
            $slugs = null;
            if (!$all) {
                $slugs = [];
                foreach (promo_blog_taxonomy_map($pdo) as $slug => [$ac, $as]) {
                    if (array_intersect($ac, $cats) || array_intersect($as, $subs)) {
                        $slugs[] = $slug;
                    }
                }
                if ($slugs === []) {
                    return 0;
                }
            }
            $sql = "SELECT COUNT(*) FROM page_views v
                    LEFT JOIN promo_blog_flags f ON f.slug = v.page_slug
                    WHERE {$where} AND v.page_type = 'article' AND COALESCE(f.no_promo, 0) = 0";
            if ($slugs !== null) {
                $names = [];
                foreach (array_values($slugs) as $i => $s) {
                    $names[] = ':s' . $i;
                    $params[':s' . $i] = $s;
                }
                $sql .= ' AND v.page_slug IN (' . implode(',', $names) . ')';
            }
    }

    // viewed_at — TIMESTAMP: порівнюємо в UTC, потім повертаємо часовий пояс сесії.
    $prevTz = (string) $pdo->query('SELECT @@session.time_zone')->fetchColumn();
    $pdo->exec("SET time_zone = '+00:00'");
    try {
        $st = $pdo->prepare($sql);
        $st->execute($params);

        return (int) $st->fetchColumn();
    } catch (Throwable $e) {
        error_log('[promo] capacity ' . $key . ': ' . $e->getMessage());

        return null;
    } finally {
        $pdo->prepare('SET time_zone = :tz')->execute([':tz' => $prevTz]);
    }
}
