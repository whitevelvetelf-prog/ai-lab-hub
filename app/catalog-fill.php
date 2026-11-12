<?php

declare(strict_types=1);

/**
 * AI LAB HUB — звіт «Наповнення каталогу» (public/crm-catalog-fill.php). Лише читання, таблиці каталогу не змінюються.
 *
 *   • Підкатегорії з кількістю ОПУБЛІКОВАНИХ продуктів (products.status = 'published'); продукт у кількох
 *     підкатегоріях рахується в кожній. Підкатегорії без продуктів теж у звіті (0).
 *     Індекси: subcategories.idx_subcategories_category, product_subcategories.idx_psc_subcategory,
 *     products PRIMARY (+ idx_products_status).
 *   • «Попит»: до CATALOG_FILL_DEMAND_LIMIT найчастіших запитів без результатів із search_log за
 *     zero_result_retention_days днів (індекс idx_search_log_created). Текст у журналі вже замаскований
 *     під час запису; для певності маскується ще раз (search_mask_personal).
 *   • Обидва набори кешуються разом у storage/cache/catalog-fill.json на CATALOG_FILL_CACHE_TTL секунд.
 */

require_once __DIR__ . '/search.php';   // search_mask_personal(), search_config()

const CATALOG_FILL_CACHE_TTL = 300;
const CATALOG_FILL_DEMAND_LIMIT = 20;

/** Мета з config/catalog.php ('catalog_min_per_subcategory'), щонайменше 1. */
function catalog_fill_min(): int
{
    static $min = null;
    if ($min === null) {
        $path = __DIR__ . '/../config/catalog.php';
        $raw = is_file($path) ? (array) (require $path) : [];
        $min = max(1, (int) ($raw['catalog_min_per_subcategory'] ?? 10));
    }

    return $min;
}

function catalog_fill_cache_file(): string
{
    return dirname(__DIR__) . '/storage/cache/catalog-fill.json';
}

function catalog_fill_cache_reset(): void
{
    $f = catalog_fill_cache_file();
    if (is_file($f)) {
        @unlink($f);
    }
}

/**
 * Рядки підкатегорій без урахування мети (мета застосовується в catalog_fill_rows, щоб зміна конфігу діяла одразу).
 *
 * @return list<array{cat_id:int,cat_name:string,sub_id:int,sub_name:string,published:int}>
 */
function catalog_fill_query_rows(PDO $pdo): array
{
    $st = $pdo->query(
        "SELECT c.id AS cat_id, c.name AS cat_name, s.id AS sub_id, s.name AS sub_name, COUNT(p.id) AS published
         FROM subcategories s
         JOIN categories c ON c.id = s.category_id
         LEFT JOIN product_subcategories ps ON ps.subcategory_id = s.id
         LEFT JOIN products p ON p.id = ps.product_id AND p.status = 'published'
         GROUP BY s.id, c.id, c.name, s.name"
    );
    $rows = [];
    foreach ($st->fetchAll(PDO::FETCH_ASSOC) as $r) {
        $rows[] = [
            'cat_id' => (int) $r['cat_id'], 'cat_name' => (string) $r['cat_name'],
            'sub_id' => (int) $r['sub_id'], 'sub_name' => (string) $r['sub_name'],
            'published' => (int) $r['published'],
        ];
    }

    return $rows;
}

/**
 * Найчастіші запити без результатів. Порожній список, якщо таблиці search_log ще немає.
 *
 * @return list<array{q:string,cnt:int,last_at:string}>
 */
function catalog_fill_query_demand(PDO $pdo, int $limit = CATALOG_FILL_DEMAND_LIMIT): array
{
    $days = (int) search_config()['zero_result_retention_days'];
    try {
        $st = $pdo->prepare(
            'SELECT LOWER(query) AS q, COUNT(*) AS cnt, MAX(created_at) AS last_at
             FROM search_log WHERE created_at >= NOW() - INTERVAL ' . $days . ' DAY
             GROUP BY LOWER(query) ORDER BY cnt DESC, last_at DESC LIMIT ' . max(1, $limit)
        );
        $st->execute();
        $rows = $st->fetchAll(PDO::FETCH_ASSOC);
    } catch (PDOException $e) {
        return [];
    }
    $out = [];
    foreach ($rows as $r) {
        $q = trim(search_mask_personal((string) $r['q']));
        if ($q !== '') {
            $out[] = ['q' => $q, 'cnt' => (int) $r['cnt'], 'last_at' => (string) $r['last_at']];
        }
    }

    return $out;
}

/**
 * Дані звіту з кешу (або свіжі, якщо кеш застарів / $fresh).
 *
 * @return array{rows:list<array{cat_id:int,cat_name:string,sub_id:int,sub_name:string,published:int}>,demand:list<array{q:string,cnt:int,last_at:string}>,built_at:int}
 */
function catalog_fill_data(PDO $pdo, bool $fresh = false): array
{
    $file = catalog_fill_cache_file();
    if (!$fresh && is_file($file)) {
        $data = json_decode((string) @file_get_contents($file), true);
        if (is_array($data) && (int) ($data['until'] ?? 0) > time() && is_array($data['rows'] ?? null) && is_array($data['demand'] ?? null)) {
            return ['rows' => $data['rows'], 'demand' => $data['demand'], 'built_at' => (int) ($data['built_at'] ?? 0)];
        }
    }
    $data = ['rows' => catalog_fill_query_rows($pdo), 'demand' => catalog_fill_query_demand($pdo), 'built_at' => time()];
    $dir = dirname($file);
    if (is_dir($dir) || @mkdir($dir, 0775, true)) {
        @file_put_contents($file, json_encode($data + ['until' => time() + CATALOG_FILL_CACHE_TTL], JSON_UNESCAPED_UNICODE), LOCK_EX);
    }

    return $data;
}

/** 'zero' (0), 'low' (1…мета−1), 'ok' (≥ мета). */
function catalog_fill_level(int $published, int $min): string
{
    return $published <= 0 ? 'zero' : ($published < $min ? 'low' : 'ok');
}

/**
 * Додає «Не вистачає» й рівень, фільтрує за категорією (0 — усі), сортує:
 * «Не вистачає» (desc за замовчуванням), далі категорія й підкатегорія за абеткою.
 *
 * @param list<array{cat_id:int,cat_name:string,sub_id:int,sub_name:string,published:int}> $rows
 * @return list<array{cat_id:int,cat_name:string,sub_id:int,sub_name:string,published:int,missing:int,level:string}>
 */
function catalog_fill_rows(array $rows, int $min, int $catId = 0, string $dir = 'desc'): array
{
    $out = [];
    foreach ($rows as $r) {
        if ($catId > 0 && (int) $r['cat_id'] !== $catId) {
            continue;
        }
        $p = (int) $r['published'];
        $out[] = $r + ['missing' => max(0, $min - $p), 'level' => catalog_fill_level($p, $min)];
    }
    $sign = $dir === 'asc' ? 1 : -1;
    usort($out, static fn(array $a, array $b): int => $sign * ($a['missing'] <=> $b['missing'])
        ?: strcmp(mb_strtolower($a['cat_name']), mb_strtolower($b['cat_name']))
        ?: strcmp(mb_strtolower($a['sub_name']), mb_strtolower($b['sub_name']))
        ?: $a['sub_id'] <=> $b['sub_id']);

    return $out;
}

/**
 * @param list<array{published:int,missing:int}> $rows рядки після catalog_fill_rows
 * @return array{total:int,zero:int,below:int,needed:int}  below — менше мети, включно з нулем
 */
function catalog_fill_summary(array $rows): array
{
    $s = ['total' => 0, 'zero' => 0, 'below' => 0, 'needed' => 0];
    foreach ($rows as $r) {
        $s['total']++;
        $s['zero'] += (int) $r['published'] === 0 ? 1 : 0;
        $s['below'] += (int) $r['missing'] > 0 ? 1 : 0;
        $s['needed'] += (int) $r['missing'];
    }

    return $s;
}

/** Категорії для фільтра: id => назва, за абеткою. @return array<int,string> */
function catalog_fill_categories(array $rows): array
{
    $cats = [];
    foreach ($rows as $r) {
        $cats[(int) $r['cat_id']] = (string) $r['cat_name'];
    }
    uasort($cats, static fn(string $a, string $b): int => strcmp(mb_strtolower($a), mb_strtolower($b)));

    return $cats;
}

/** Клітинка CSV без формул Excel (=, +, -, @ на початку). */
function catalog_fill_csv_cell(string|int $v): string|int
{
    if (is_int($v)) {
        return $v;
    }

    return preg_match('/^[=+\-@\t\r]/', $v) ? "'" . $v : $v;
}

/** CSV (UTF-8 з BOM, кома) з уже відфільтрованих / відсортованих рядків. */
function catalog_fill_csv(array $rows, int $min): string
{
    $h = fopen('php://temp', 'r+');
    fputcsv($h, ['Категорія', 'Підкатегорія', 'ID підкатегорії', 'Опубліковано', 'Мета', 'Не вистачає'], ',', '"', '');
    foreach ($rows as $r) {
        fputcsv($h, [catalog_fill_csv_cell($r['cat_name']), catalog_fill_csv_cell($r['sub_name']), (int) $r['sub_id'],
            (int) $r['published'], $min, (int) $r['missing']], ',', '"', '');
    }
    rewind($h);
    $csv = (string) stream_get_contents($h);
    fclose($h);

    return "\xEF\xBB\xBF" . $csv;
}
