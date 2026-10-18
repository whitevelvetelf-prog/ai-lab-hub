<?php

declare(strict_types=1);

/**
 * AI LAB HUB — виключення реклами (блок H).
 *
 *   * no_promo: прапорець «без реклами» на categories, subcategories, products і
 *     статтях блогу (promo_blog_flags за slug). Якщо прапорець має сама сторінка
 *     або будь-яка її категорія/підкатегорія — на сторінці немає жодного рекламного
 *     блоку (promo_slot нічого не виводить, promo-serve.php віддає 204, старі
 *     банери app/ads.php теж не показуються).
 *   * Категорія реклами (ad_campaigns.advertiser_category) і правила
 *     promo_category_rules: категорія, заборонена на сторінці, не показується.
 *
 * Підключається з app/promo.php.
 */

/** Категорії реклами (ключ → [UA, EN]), список для майстра й модерації. */
const PROMO_ADVERTISER_CATEGORIES = [
    'ai_tools' => ['AI-інструменти й сервіси', 'AI tools and services'],
    'education' => ['Освіта', 'Education'],
    'dev_it' => ['Розробка й IT', 'Development and IT'],
    'business_marketing' => ['Бізнес і маркетинг', 'Business and marketing'],
    'finance' => ['Фінанси', 'Finance'],
    'health_wellness' => ['Здоров’я й добробут', 'Health and wellness'],
    'food_nutrition' => ['Їжа й харчування', 'Food and nutrition'],
    'gambling' => ['Ставки й азартні ігри', 'Betting and gambling'],
    'adult' => ['Дорослий контент', 'Adult content'],
    'other' => ['Інше', 'Other'],
];

function promo_advertiser_category_label(?string $key, string $lang = 'uk'): string
{
    if ($key === null || !isset(PROMO_ADVERTISER_CATEGORIES[$key])) {
        return '—';
    }

    return PROMO_ADVERTISER_CATEGORIES[$key][$lang === 'en' ? 1 : 0];
}

/** @param list<int> $ids */
function promo_in_ints(array $ids): string
{
    $ids = array_values(array_unique(array_filter(array_map('intval', $ids), static fn($i) => $i > 0)));

    return $ids === [] ? '0' : implode(',', $ids);
}

/**
 * Категорії й підкатегорії продукту.
 *
 * @return array{0:list<int>,1:list<int>}
 */
function promo_product_taxonomy(PDO $pdo, int $productId): array
{
    $c = $pdo->prepare('SELECT category_id FROM product_categories WHERE product_id = :p');
    $c->execute([':p' => $productId]);
    $s = $pdo->prepare('SELECT subcategory_id FROM product_subcategories WHERE product_id = :p');
    $s->execute([':p' => $productId]);

    return [array_map('intval', $c->fetchAll(PDO::FETCH_COLUMN)), array_map('intval', $s->fetchAll(PDO::FETCH_COLUMN))];
}

/**
 * Чому на сторінці не можна показувати рекламу (null — можна).
 *
 * @param list<int> $categoryIds
 * @param list<int> $subcategoryIds
 * @param array{product?:int,article?:string} $page
 */
function promo_page_excluded(PDO $pdo, array $categoryIds, array $subcategoryIds, array $page = []): ?string
{
    static $cache = [];
    $productId = (int) ($page['product'] ?? 0);
    $article = (string) ($page['article'] ?? '');
    $key = promo_in_ints($categoryIds) . '|' . promo_in_ints($subcategoryIds) . '|' . $productId . '|' . $article;
    if (array_key_exists($key, $cache)) {
        return $cache[$key];
    }

    try {
        if ($productId > 0) {
            $st = $pdo->prepare('SELECT no_promo FROM products WHERE id = :p');
            $st->execute([':p' => $productId]);
            if ((int) $st->fetchColumn() === 1) {
                return $cache[$key] = 'продукт #' . $productId . ' позначено «без реклами»';
            }
            [$pc, $ps] = promo_product_taxonomy($pdo, $productId);
            $categoryIds = array_merge($categoryIds, $pc);
            $subcategoryIds = array_merge($subcategoryIds, $ps);
        }
        if ($article !== '') {
            $st = $pdo->prepare('SELECT no_promo FROM promo_blog_flags WHERE slug = :s');
            $st->execute([':s' => $article]);
            if ((int) $st->fetchColumn() === 1) {
                return $cache[$key] = 'статтю «' . $article . '» позначено «без реклами»';
            }
        }
        // Підкатегорія успадковує прапорець своєї категорії.
        $subs = promo_in_ints($subcategoryIds);
        $parentCats = $subs !== '0' ? array_map('intval', $pdo->query("SELECT category_id FROM subcategories WHERE id IN ({$subs})")->fetchAll(PDO::FETCH_COLUMN)) : [];
        $cats = promo_in_ints(array_merge($categoryIds, $parentCats));
        if ($cats !== '0') {
            $name = $pdo->query("SELECT name FROM categories WHERE id IN ({$cats}) AND no_promo = 1 LIMIT 1")->fetchColumn();
            if ($name !== false) {
                return $cache[$key] = 'категорію «' . $name . '» позначено «без реклами»';
            }
        }
        if ($subs !== '0') {
            $name = $pdo->query("SELECT name FROM subcategories WHERE id IN ({$subs}) AND no_promo = 1 LIMIT 1")->fetchColumn();
            if ($name !== false) {
                return $cache[$key] = 'підкатегорію «' . $name . '» позначено «без реклами»';
            }
        }
    } catch (Throwable $e) {
        // Міграцію блоку H ще не застосовано — виключень немає.
        error_log('[promo] exclusions: ' . $e->getMessage());
    }

    return $cache[$key] = null;
}

/**
 * Категорії реклами, заборонені на сторінці з такими категоріями/підкатегоріями.
 *
 * @param list<int> $categoryIds
 * @param list<int> $subcategoryIds
 * @return array<string,string> advertiser_category => опис правила
 */
function promo_blocked_advertiser_categories(PDO $pdo, array $categoryIds, array $subcategoryIds): array
{
    $subs = promo_in_ints($subcategoryIds);
    $parentCats = $subs !== '0' ? array_map('intval', $pdo->query("SELECT category_id FROM subcategories WHERE id IN ({$subs})")->fetchAll(PDO::FETCH_COLUMN)) : [];
    $cats = promo_in_ints(array_merge($categoryIds, $parentCats));
    $out = [];
    foreach ($pdo->query(
        "SELECT advertiser_category, scope_type, scope_id, note FROM promo_category_rules
         WHERE rule = 'block' AND (scope_type = 'all'
            OR (scope_type = 'category' AND scope_id IN ({$cats}))
            OR (scope_type = 'subcategory' AND scope_id IN ({$subs})))"
    ) as $r) {
        $out[(string) $r['advertiser_category']] = $r['scope_type'] === 'all' ? 'всюди' : ($r['scope_type'] . ' #' . $r['scope_id']);
    }

    return $out;
}

/**
 * Умова SQL для promo_pick: кампанія не належить до категорії, забороненої на сторінці.
 * Без категорії (власна реклама, старі кампанії) — не обмежується.
 *
 * @param list<int> $categoryIds
 * @param list<int> $subcategoryIds
 */
function promo_rules_sql(array $categoryIds, array $subcategoryIds, string $alias = 'c'): string
{
    $subs = promo_in_ints($subcategoryIds);
    // Батьківські категорії підкатегорій — через підзапит (одним SQL без зайвих запитів).
    $cats = promo_in_ints($categoryIds);

    return "NOT EXISTS (SELECT 1 FROM promo_category_rules r
                WHERE r.rule = 'block' AND r.advertiser_category = {$alias}.advertiser_category
                  AND (r.scope_type = 'all'
                       OR (r.scope_type = 'category' AND (r.scope_id IN ({$cats})
                           OR r.scope_id IN (SELECT sc.category_id FROM subcategories sc WHERE sc.id IN ({$subs}))))
                       OR (r.scope_type = 'subcategory' AND r.scope_id IN ({$subs}))))";
}

/** Категорія реклами заборонена всюди (правило scope all) — такий креатив не схвалюється. */
function promo_category_blocked_everywhere(PDO $pdo, ?string $category): bool
{
    if ($category === null || $category === '') {
        return false;
    }
    try {
        $st = $pdo->prepare("SELECT COUNT(*) FROM promo_category_rules WHERE rule = 'block' AND scope_type = 'all' AND advertiser_category = :c");
        $st->execute([':c' => $category]);

        return (int) $st->fetchColumn() > 0;
    } catch (Throwable $e) {
        return false;
    }
}

// --- Адмінка: прапорці й правила -------------------------------------------

/** Усі сторінки з no_promo=1 (для перегляду й зняття). */
function promo_no_promo_list(PDO $pdo): array
{
    $out = ['categories' => [], 'subcategories' => [], 'products' => [], 'articles' => []];
    try {
        $out['categories'] = $pdo->query('SELECT id, name FROM categories WHERE no_promo = 1 ORDER BY name')->fetchAll();
        $out['subcategories'] = $pdo->query(
            'SELECT s.id, s.name, c.name AS category FROM subcategories s JOIN categories c ON c.id = s.category_id
             WHERE s.no_promo = 1 ORDER BY c.name, s.name'
        )->fetchAll();
        $out['products'] = $pdo->query('SELECT id, name FROM products WHERE no_promo = 1 ORDER BY name')->fetchAll();
        $out['articles'] = $pdo->query('SELECT slug FROM promo_blog_flags WHERE no_promo = 1 ORDER BY slug')->fetchAll(PDO::FETCH_COLUMN);
    } catch (Throwable $e) {
        error_log('[promo] no_promo list: ' . $e->getMessage());
    }

    return $out;
}

/** Змінити прапорець. $type: category | subcategory | product | article. */
function promo_set_no_promo(PDO $pdo, string $type, string $id, bool $on): array
{
    $flag = $on ? 1 : 0;
    if ($type === 'article') {
        $slug = trim($id);
        if (!function_exists('blog_article_files') && is_file(__DIR__ . '/blog.php')) {
            require_once __DIR__ . '/blog.php';
        }
        if (!defined('BLOG_ARTICLES') || !isset(BLOG_ARTICLES[$slug])) {
            return [false, 'Статтю «' . $slug . '» не знайдено.'];
        }
        $pdo->prepare(
            'INSERT INTO promo_blog_flags (slug, no_promo, updated_at) VALUES (:s, :f, :t)
             ON DUPLICATE KEY UPDATE no_promo = VALUES(no_promo), updated_at = VALUES(updated_at)'
        )->execute([':s' => $slug, ':f' => $flag, ':t' => gmdate('Y-m-d H:i:s')]);

        return [true, 'Стаття «' . $slug . '»: ' . ($on ? 'без реклами.' : 'реклама дозволена.')];
    }
    $table = ['category' => 'categories', 'subcategory' => 'subcategories', 'product' => 'products'][$type] ?? null;
    if ($table === null || (int) $id <= 0) {
        return [false, 'Некоректний запит.'];
    }
    $st = $pdo->prepare("UPDATE {$table} SET no_promo = :f WHERE id = :id");
    $st->execute([':f' => $flag, ':id' => (int) $id]);
    $exists = $pdo->prepare("SELECT name FROM {$table} WHERE id = :id");
    $exists->execute([':id' => (int) $id]);
    $name = $exists->fetchColumn();
    if ($name === false) {
        return [false, 'Запис #' . (int) $id . ' не знайдено.'];
    }

    return [true, '«' . $name . '» (#' . (int) $id . '): ' . ($on ? 'без реклами.' : 'реклама дозволена.')];
}

/** Правила з людськими назвами областей. */
function promo_rules_list(PDO $pdo): array
{
    try {
        return $pdo->query(
            "SELECT r.*, CASE r.scope_type
                    WHEN 'category' THEN (SELECT name FROM categories WHERE id = r.scope_id)
                    WHEN 'subcategory' THEN (SELECT CONCAT(c.name, ' → ', s.name) FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE s.id = r.scope_id)
                    ELSE 'усі сторінки' END AS scope_name
             FROM promo_category_rules r ORDER BY r.scope_type, r.advertiser_category"
        )->fetchAll();
    } catch (Throwable $e) {
        return [];
    }
}

function promo_rule_add(PDO $pdo, string $scopeType, int $scopeId, string $category, string $note): array
{
    if (!in_array($scopeType, ['all', 'category', 'subcategory'], true) || !isset(PROMO_ADVERTISER_CATEGORIES[$category])) {
        return [false, 'Некоректне правило.'];
    }
    if ($scopeType === 'all') {
        $scopeId = 0;
    } else {
        $table = $scopeType === 'category' ? 'categories' : 'subcategories';
        $st = $pdo->prepare("SELECT COUNT(*) FROM {$table} WHERE id = :id");
        $st->execute([':id' => $scopeId]);
        if ((int) $st->fetchColumn() === 0) {
            return [false, 'Оберіть категорію чи підкатегорію.'];
        }
    }
    $dup = $pdo->prepare('SELECT COUNT(*) FROM promo_category_rules WHERE scope_type = :t AND COALESCE(scope_id, 0) = :id AND advertiser_category = :c');
    $dup->execute([':t' => $scopeType, ':id' => $scopeId, ':c' => $category]);
    if ((int) $dup->fetchColumn() > 0) {
        return [false, 'Таке правило вже є.'];
    }
    $pdo->prepare(
        "INSERT INTO promo_category_rules (scope_type, scope_id, advertiser_category, rule, note, created_at)
         VALUES (:t, :id, :c, 'block', :n, :at)"
    )->execute([':t' => $scopeType, ':id' => $scopeType === 'all' ? null : $scopeId, ':c' => $category,
        ':n' => mb_substr(trim(strip_tags($note)), 0, 255) ?: null, ':at' => gmdate('Y-m-d H:i:s')]);

    return [true, 'Правило додано.'];
}

function promo_rule_delete(PDO $pdo, int $id): array
{
    $st = $pdo->prepare('DELETE FROM promo_category_rules WHERE id = :id');
    $st->execute([':id' => $id]);

    return $st->rowCount() > 0 ? [true, 'Правило видалено.'] : [false, 'Правило не знайдено.'];
}

/**
 * «Перевірити сторінку»: чи покаже система рекламу за цією адресою і чому ні.
 *
 * @return list<array{0:bool,1:string}> [ок?, рядок пояснення]
 */
function promo_page_diagnose(PDO $pdo, string $url): array
{
    $out = [];
    $p = parse_url(trim($url));
    $path = basename((string) ($p['path'] ?? ''));
    parse_str((string) ($p['query'] ?? ''), $q);
    $cats = [];
    $subs = [];
    $page = [];
    $placement = null;

    switch ($path) {
        case 'product.php':
            $placement = 'product_page';
            $page['product'] = (int) ($q['id'] ?? 0);
            $st = $pdo->prepare("SELECT name, status FROM products WHERE id = :id");
            $st->execute([':id' => $page['product']]);
            $prod = $st->fetch();
            if ($prod === false) {
                return [[false, 'Продукт #' . $page['product'] . ' не знайдено.']];
            }
            $out[] = [true, 'Сторінка продукту «' . $prod['name'] . '» (розміщення product_page).'];
            [$cats, $subs] = promo_product_taxonomy($pdo, $page['product']);
            break;
        case 'catalog.php':
            $placement = 'search_results';
            if (!empty($q['search'])) {
                $out[] = [true, 'Пошук (search_results): реклама без категорійного таргетингу.'];
            }
            if ((int) ($q['subcategory'] ?? 0) > 0 && empty($q['search'])) {
                $placement = 'subcategory_list';
                $subs = [(int) $q['subcategory']];
                $cats = array_map('intval', $pdo->query('SELECT category_id FROM subcategories WHERE id = ' . (int) $q['subcategory'])->fetchAll(PDO::FETCH_COLUMN));
            } elseif ((int) ($q['category'] ?? 0) > 0 && empty($q['search'])) {
                $cats = [(int) $q['category']];
            }
            $out[] = [true, 'Каталог (місце ' . $placement . ').'];
            break;
        case 'blog-post.php':
            $placement = 'blog_article';
            $page['article'] = (string) ($q['slug'] ?? '');
            if (!function_exists('blog_article_topics')) {
                require_once __DIR__ . '/blog.php';
            }
            if (!isset(BLOG_ARTICLES[$page['article']])) {
                return [[false, 'Статтю «' . $page['article'] . '» не знайдено.']];
            }
            [$cats, $subs] = promo_blog_article_taxonomy($pdo, $page['article']);
            $out[] = [true, 'Стаття блогу «' . $page['article'] . '» (місце blog_article)' . ($cats === [] ? ', категорій немає — лише реклама для «усіх категорій»' : '') . '.'];
            break;
        case 'blog.php':
            $placement = 'blog_list';
            $out[] = [true, 'Список статей блогу (місце blog_list): реклама без категорійного таргетингу.'];
            break;
        case 'category.php':
            $placement = 'category_page';
            $cats = [(int) ($q['id'] ?? 0)];
            $out[] = [true, 'Сторінка категорії (місце category_page).'];
            break;
        default:
            return [[false, 'На цій сторінці рекламних слотів немає (відеореклама: category.php, catalog.php, product.php, blog.php, blog-post.php).']];
    }

    if ($placement !== null) {
        $reason = promo_placement_block_reason($pdo, $placement);
        $out[] = [$reason === null, $reason === null ? 'Місце «' . promo_placement_title($pdo, $placement) . '» увімкнене.'
            : 'Місце «' . promo_placement_title($pdo, $placement) . '» недоступне (' . ['disabled' => 'вимкнене в адмінці', 'setting' => 'вимкнене налаштування сайту', 'feature' => 'ще не зроблено потрібну можливість'][$reason] . ').'];
    }

    $out[] = [promo_enabled($pdo), promo_enabled($pdo) ? 'Систему реклами ввімкнено.' : 'Систему реклами ВИМКНЕНО — реклами немає ніде.'];
    $out[] = [strlen(promo_config()['secret']) >= 32, strlen(promo_config()['secret']) >= 32 ? 'Секрет токенів задано.' : 'Немає секрету в config/promo.php — відеореклама не показується.'];

    $excluded = promo_page_excluded($pdo, $cats, $subs, $page);
    $out[] = [$excluded === null, $excluded === null ? 'Сторінку не виключено (no_promo немає).' : 'Реклами не буде: ' . $excluded . '.'];

    $blocked = promo_blocked_advertiser_categories($pdo, $cats, $subs);
    if ($blocked !== []) {
        $labels = [];
        foreach ($blocked as $k => $where) {
            $labels[] = promo_advertiser_category_label($k) . ' (' . $where . ')';
        }
        $out[] = [true, 'Заборонені тут категорії реклами: ' . implode(', ', $labels) . '.'];
    }

    if ($placement !== null && $excluded === null) {
        $n = promo_eligible_count($pdo, $placement, $cats, $subs);
        $out[] = [$n > 0, $n > 0 ? 'Кампаній, що можуть показатися тут зараз: ' . $n . ' (без урахування ліміту показів на сеанс, мови й пристрою).' : 'Зараз немає жодної кампанії, яка могла б показатися тут.'];
    }

    return $out;
}

/** Скільки активних кампаній пройшли б відбір для сторінки (без частоти, мови й пристрою). */
function promo_eligible_count(PDO $pdo, string $placement, array $cats, array $subs): int
{
    $today = function_exists('promo_today') ? promo_today() : date('Y-m-d');
    $catIn = promo_in_ints($cats);
    $subIn = promo_in_ints($subs);
    $plIn = implode(',', array_map(static fn($k) => $pdo->quote($k), promo_placement_match_keys($placement)));
    $st = $pdo->prepare(
        "SELECT COUNT(DISTINCT c.id) FROM ad_campaigns c
         JOIN ad_creatives cr ON cr.campaign_id = c.id AND cr.status = 'approved'
         LEFT JOIN ad_balances b ON b.user_id = c.user_id
         WHERE c.format = 'video' AND c.status = 'active'
           AND (c.start_date IS NULL OR c.start_date <= :d1) AND (c.end_date IS NULL OR c.end_date >= :d2)
           AND (c.campaign_type = 'internal' OR COALESCE(b.balance, 0) > 0)
           AND EXISTS (SELECT 1 FROM ad_targets t WHERE t.campaign_id = c.id AND t.placement IN ({$plIn})
                       AND (t.category_id IS NULL OR t.category_id IN ({$catIn}))
                       AND (t.subcategory_id IS NULL OR t.subcategory_id IN ({$subIn})))
           AND " . promo_rules_sql($cats, $subs)
    );
    $st->execute([':d1' => $today, ':d2' => $today]);

    return (int) $st->fetchColumn();
}
