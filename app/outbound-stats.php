<?php

declare(strict_types=1);

/**
 * AI LAB HUB — зведення переходів на сайти продуктів (link_clicks, public/go.php) і агрегати
 * для медіакіту. Використовують admin-outbound.php, admin-vendor-report.php, admin-summary.php
 * (лише admin). Тільки агрегати: без IP, без імен; session_hash — анонімний (app/analytics.php).
 *
 * Перехід = один рядок link_clicks після дедуплікації: кліки того самого сеансу по тому самому
 * продукту й типу посилання в одному 30-хвилинному вікні рахуються один раз. Це діє й для старих
 * даних (до 2026-10-16 go.php писав кожен клік і не відсіював ботів). Відтоді
 * analytics_log_click() ще й не пише ботів, співробітників і повтори протягом 30 хв.
 */

require_once __DIR__ . '/site-stats.php';
require_once __DIR__ . '/analytics.php';

const OUTBOUND_PERIODS = [7, 30];

/** Період у днях з GET (?days=7|30), інакше $default. */
function outbound_days(mixed $raw, int $default = 30): int
{
    $d = (int) $raw;

    return in_array($d, OUTBOUND_PERIODS, true) ? $d : $default;
}

/**
 * Дедупліковані переходи за останні $days днів (опційно — одного продукту).
 *
 * @return list<array{product_id:int, link_type:string, session_hash:string, lang:?string, clicked_at:string}>
 *   clicked_at — UTC
 */
function outbound_rows(PDO $pdo, int $days, ?int $productId = null): array
{
    $hasLang = outbound_has_lang($pdo);
    $langSel = $hasLang ? 'MAX(lang)' : 'NULL';
    $sql = "SELECT product_id, link_type, session_hash, {$langSel} AS lang, MIN(clicked_at) AS clicked_at
              FROM link_clicks
             WHERE clicked_at >= :from" . ($productId !== null ? ' AND product_id = :pid' : '') . "
             GROUP BY product_id, link_type, session_hash, FLOOR(UNIX_TIMESTAMP(clicked_at) / 1800)";

    return site_stats_in_utc($pdo, static function () use ($pdo, $sql, $days, $productId): array {
        $st = $pdo->prepare($sql);
        $from = gmdate('Y-m-d H:i:s', time() - $days * 86400);
        $st->bindValue(':from', $from);
        if ($productId !== null) {
            $st->bindValue(':pid', $productId, PDO::PARAM_INT);
        }
        $st->execute();

        return array_map(static fn(array $r): array => [
            'product_id' => (int) $r['product_id'],
            'link_type' => (string) $r['link_type'],
            'session_hash' => (string) $r['session_hash'],
            'lang' => $r['lang'] !== null ? (string) $r['lang'] : null,
            'clicked_at' => (string) $r['clicked_at'],
        ], $st->fetchAll());
    });
}

function outbound_has_lang(PDO $pdo): bool
{
    static $has = null;
    if ($has === null) {
        try {
            $has = $pdo->query("SHOW COLUMNS FROM link_clicks LIKE 'lang'")->fetch() !== false;
        } catch (Throwable $e) {
            $has = false;
        }
    }

    return $has;
}

/** @return array{total:int, official:int, affiliate:int, sessions:int} */
function outbound_totals(array $rows): array
{
    $out = ['total' => count($rows), 'official' => 0, 'affiliate' => 0, 'sessions' => 0];
    $s = [];
    foreach ($rows as $r) {
        $out[$r['link_type'] === 'affiliate' ? 'affiliate' : 'official']++;
        $s[$r['session_hash']] = true;
    }
    $out['sessions'] = count($s);

    return $out;
}

/**
 * Топ продуктів за переходами з назвами.
 *
 * @return list<array{product_id:int, name:string, total:int, official:int, affiliate:int, sessions:int}>
 */
function outbound_top(PDO $pdo, array $rows, int $limit = 20): array
{
    $by = [];
    foreach ($rows as $r) {
        $pid = $r['product_id'];
        $by[$pid] ??= ['product_id' => $pid, 'name' => '', 'total' => 0, 'official' => 0, 'affiliate' => 0, 's' => []];
        $by[$pid]['total']++;
        $by[$pid][$r['link_type'] === 'affiliate' ? 'affiliate' : 'official']++;
        $by[$pid]['s'][$r['session_hash']] = true;
    }
    uasort($by, static fn($a, $b) => [$b['total'], count($b['s'])] <=> [$a['total'], count($a['s'])]);
    $by = array_slice($by, 0, $limit, true);
    $names = outbound_product_names($pdo, array_keys($by));
    $out = [];
    foreach ($by as $pid => $row) {
        $row['sessions'] = count($row['s']);
        unset($row['s']);
        $row['name'] = $names[$pid] ?? ('#' . $pid);
        $out[] = $row;
    }

    return $out;
}

/** @param list<int> $ids @return array<int,string> */
function outbound_product_names(PDO $pdo, array $ids): array
{
    if ($ids === []) {
        return [];
    }
    $st = $pdo->prepare('SELECT id, name FROM products WHERE id IN (' . implode(',', array_fill(0, count($ids), '?')) . ')');
    $st->execute(array_values($ids));

    return array_map('strval', $st->fetchAll(PDO::FETCH_KEY_PAIR));
}

/**
 * Розподіл по тижнях (понеділок–неділя за Києвом) за останні $weeks тижнів, від старого до нового.
 *
 * @return list<array{week:string, label:string, total:int, sessions:int}>
 */
function outbound_weekly(array $rows, int $weeks): array
{
    $tz = site_stats_tz();
    $mondayOf = static fn(DateTimeImmutable $d): DateTimeImmutable => $d->setTime(0, 0)->modify('-' . ((int) $d->format('N') - 1) . ' days');
    $monday = $mondayOf(new DateTimeImmutable('now', $tz));
    $buckets = [];
    for ($i = $weeks - 1; $i >= 0; $i--) {
        $start = $monday->modify('-' . $i . ' weeks');
        $buckets[$start->format('Y-m-d')] = ['week' => $start->format('Y-m-d'),
            'label' => $start->format('d.m') . '–' . $start->modify('+6 days')->format('d.m'), 'total' => 0, 's' => []];
    }
    foreach ($rows as $r) {
        $d = (new DateTimeImmutable($r['clicked_at'], new DateTimeZone('UTC')))->setTimezone($tz);
        $key = $mondayOf($d)->format('Y-m-d');
        if (isset($buckets[$key])) {
            $buckets[$key]['total']++;
            $buckets[$key]['s'][$r['session_hash']] = true;
        }
    }

    return array_values(array_map(static function (array $b): array {
        $b['sessions'] = count($b['s']);
        unset($b['s']);

        return $b;
    }, $buckets));
}

/** Частка мов (лише рядки з відомою мовою). @return array{known:int, shares:array<string,float>} */
function outbound_lang_shares(array $rows): array
{
    $c = [];
    foreach ($rows as $r) {
        if ($r['lang'] !== null && $r['lang'] !== '') {
            $c[$r['lang']] = ($c[$r['lang']] ?? 0) + 1;
        }
    }
    arsort($c);
    $known = array_sum($c);

    return ['known' => $known, 'shares' => array_map(static fn(int $n) => round($n * 100 / max(1, $known), 1), $c)];
}

/** CSV-відповідь (UTF-8 з BOM, щоб Excel показав кирилицю) і вихід. */
function outbound_send_csv(string $filename, array $header, array $rows): never
{
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="' . preg_replace('/[^A-Za-z0-9._-]/', '_', $filename) . '"');
    header('X-Robots-Tag: noindex');
    $out = fopen('php://output', 'w');
    fwrite($out, "\xEF\xBB\xBF");
    fputcsv($out, $header);
    foreach ($rows as $r) {
        fputcsv($out, $r);
    }
    fclose($out);
    exit;
}

// ---------------------------------------------------------------------------
// Зведення для медіакіту (admin-summary.php)
// ---------------------------------------------------------------------------

/**
 * Агрегати сайту за $days днів. Перегляди — page_views; рядки з device_class = 'bot'
 * рахуються окремо (класифікація пристрою пишеться з 2026-10-12, старіші рядки — «невідомо»).
 *
 * @return array<string,mixed>
 */
function outbound_site_summary(PDO $pdo, int $days = 30): array
{
    $from = gmdate('Y-m-d H:i:s', time() - $days * 86400);
    $q = static function (string $sql, array $p = []) use ($pdo): array {
        return site_stats_in_utc($pdo, static function () use ($pdo, $sql, $p): array {
            $st = $pdo->prepare($sql);
            $st->execute($p);

            return $st->fetchAll();
        });
    };

    $views = $q('SELECT COUNT(*) AS v, COUNT(DISTINCT session_hash) AS s,
                        SUM(device_class = \'bot\') AS bot_v,
                        COUNT(DISTINCT CASE WHEN device_class = \'bot\' THEN session_hash END) AS bot_s,
                        SUM(device_class IS NULL) AS unknown_v
                   FROM page_views WHERE viewed_at >= :f', [':f' => $from])[0];
    $humanSql = "viewed_at >= :f AND (device_class IS NULL OR device_class <> 'bot')";
    $human = $q("SELECT COUNT(*) AS v, COUNT(DISTINCT session_hash) AS s FROM page_views WHERE {$humanSql}", [':f' => $from])[0];

    $langs = $q("SELECT lang, COUNT(*) AS n FROM page_views WHERE {$humanSql} AND lang IS NOT NULL AND lang <> '' GROUP BY lang ORDER BY n DESC LIMIT 5", [':f' => $from]);
    $pages = $q("SELECT page_type, page_id, page_slug, COUNT(*) AS n FROM page_views WHERE {$humanSql}
                 GROUP BY page_type, page_id, page_slug ORDER BY n DESC LIMIT 10", [':f' => $from]);

    $prodNames = outbound_product_names($pdo, array_values(array_unique(array_map(
        static fn($r) => (int) $r['page_id'],
        array_filter($pages, static fn($r) => $r['page_type'] === 'product' && $r['page_id'] !== null)
    ))));
    $catNames = [];
    $catIds = array_values(array_unique(array_map(static fn($r) => (int) $r['page_id'], array_filter($pages, static fn($r) => $r['page_type'] === 'category' && $r['page_id'] !== null))));
    if ($catIds !== []) {
        $catNames = $pdo->query('SELECT id, name FROM categories WHERE id IN (' . implode(',', $catIds) . ')')->fetchAll(PDO::FETCH_KEY_PAIR);
    }
    $pageLabel = static function (array $r) use ($prodNames, $catNames): string {
        $id = $r['page_id'] !== null ? (int) $r['page_id'] : null;

        return match ($r['page_type']) {
            'home' => 'Головна',
            'product' => 'Продукт: ' . ($prodNames[$id] ?? ('#' . $id)),
            'category' => 'Категорія: ' . ($catNames[$id] ?? ('#' . $id)),
            'article' => ($r['page_slug'] ?? '') !== '' ? 'Стаття блогу: ' . $r['page_slug'] : 'Статті блогу (записи до 27.09.2026, без адреси статті)',
            default => 'Інша сторінка' . ($r['page_slug'] ? ': ' . $r['page_slug'] : ($id !== null ? ' #' . $id : ' (каталог, пошук тощо)')),
        };
    };

    $clicks = outbound_totals(outbound_rows($pdo, $days));
    require_once __DIR__ . '/eli.php';
    $eli = eli_stats($pdo);

    $blogCount = 0;
    if (function_exists('blog_list_articles') || is_file(__DIR__ . '/blog.php')) {
        require_once __DIR__ . '/blog.php';
        $blogCount = count(blog_list_articles(BLOG_DEFAULT_LANG));
    }

    return [
        'days' => $days,
        'views' => (int) $views['v'],
        'sessions' => (int) $views['s'],
        'bot_views' => (int) $views['bot_v'],
        'unknown_views' => (int) $views['unknown_v'],
        'human_views' => (int) $human['v'],
        'human_sessions' => (int) $human['s'],
        'langs' => array_map(static fn($r) => [(string) $r['lang'], (int) $r['n']], $langs),
        'pages' => array_map(static fn($r) => [$pageLabel($r), (int) $r['n']], $pages),
        'clicks' => $clicks,
        'eli' => $eli['30d'] ?? null,
        'products' => (int) $pdo->query("SELECT COUNT(*) FROM products WHERE status = 'published'")->fetchColumn(),
        'subcategories' => (int) $pdo->query(
            "SELECT COUNT(DISTINCT ps.subcategory_id) FROM product_subcategories ps JOIN products p ON p.id = ps.product_id WHERE p.status = 'published'"
        )->fetchColumn(),
        'blog' => $blogCount,
    ];
}

/** Звичайний текст зведення для вставки в чат. */
function outbound_summary_text(array $s): string
{
    $n = static fn(int|float $v): string => number_format((float) $v, 0, ',', ' ');
    $lines = [];
    $lines[] = 'AI LAB HUB — зведення за останні ' . $s['days'] . ' днів (станом на ' . site_stats_day() . ', лише агрегати, без персональних даних)';
    $lines[] = '';
    $lines[] = 'Перегляди сторінок: ' . $n($s['views']) . ', унікальні сеанси: ' . $n($s['sessions']);
    $lines[] = '  з них позначено як боти: ' . $n($s['bot_views']) . '; без ботів: ' . $n($s['human_views']) . ' переглядів, ' . $n($s['human_sessions']) . ' сеансів'
        . ($s['unknown_views'] > 0 ? ' (ще ' . $n($s['unknown_views']) . ' переглядів без класифікації пристрою — записані до 12.10.2026)' : '');
    $lines[] = '';
    $lines[] = 'Топ-5 мов інтерфейсу (перегляди без ботів):';
    if ($s['langs'] === []) {
        $lines[] = '  немає даних';
    }
    $langNames = ['uk' => 'UA (українська)', 'en' => 'EN (англійська)'];
    $langTotal = array_sum(array_map(static fn($x) => $x[1], $s['langs']));
    foreach ($s['langs'] as [$l, $c]) {
        $lines[] = '  ' . ($langNames[$l] ?? strtoupper($l)) . ': ' . $n($c) . ' (' . round($c * 100 / max(1, $langTotal)) . '%)';
    }
    if ($s['langs'] !== []) {
        $lines[] = '  (мова записується з 12.10.2026; враховано ' . $n($langTotal) . ' переглядів)';
    }
    $lines[] = 'Топ-5 країн: немає даних (геолокація не збирається)';
    $lines[] = '';
    $lines[] = 'Топ-10 сторінок за переглядами (без ботів):';
    if ($s['pages'] === []) {
        $lines[] = '  немає даних';
    }
    foreach ($s['pages'] as $i => [$label, $c]) {
        $lines[] = '  ' . ($i + 1) . '. ' . $label . ' — ' . $n($c);
    }
    $lines[] = '';
    $c = $s['clicks'];
    $lines[] = 'Переходи на сайти продуктів: ' . $n($c['total']) . ' (офіційні посилання: ' . $n($c['official']) . ', партнерські: ' . $n($c['affiliate']) . '), унікальних сеансів: ' . $n($c['sessions']);
    $e = $s['eli'];
    if ($e === null) {
        $lines[] = 'Запити до асистентки Елі: немає даних';
    } else {
        $lines[] = 'Запити до асистентки Елі: ' . $n($e['answered']) . ', відповідь AI: ' . str_replace('.', ',', (string) $e['ai_pct']) . '%'
            . ', запасна добірка з бази: ' . str_replace('.', ',', (string) $e['fallback_pct']) . '%';
    }
    $lines[] = '';
    $lines[] = 'Каталог: ' . $n($s['products']) . ' опублікованих продуктів, ' . $n($s['subcategories']) . ' підкатегорій з продуктами, ' . $n($s['blog']) . ' статей блогу';

    return implode("\n", $lines);
}
