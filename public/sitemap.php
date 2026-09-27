<?php

declare(strict_types=1);

/**
 * AI LAB HUB — динамічна карта сайту для пошуковиків (sitemaps.org 0.9).
 *
 * Доступна як /sitemap.xml: public/.htaccess переписує той URL сюди.
 * Статичного public/sitemap.xml бути не повинно — інакше nginx на хостингу
 * віддасть файл сам, не доходячи до Apache/.htaccess.
 *
 * Генерується при кожному запиті з БД: головна, eli.php, усі категорії,
 * усі опубліковані продукти (lastmod = products.updated_at), статичні
 * сторінки, блог і його мовні версії (реєстр BLOG_ARTICLES, hreflang-пари).
 * Домен — канонічний BLOG_SITE_URL, той самий, що в canonical/hreflang.
 */

require_once __DIR__ . '/../app/blog.php';

const SITEMAP_BASE_URL = BLOG_SITE_URL;

try {
    /** @var PDO $pdo */
    $pdo = require __DIR__ . '/../config/database.php';

    $categories = $pdo->query(
        "SELECT c.id, MAX(p.updated_at) AS lastmod
         FROM categories c
         LEFT JOIN product_categories pc ON pc.category_id = c.id
         LEFT JOIN products p ON p.id = pc.product_id AND p.status = 'published'
         GROUP BY c.id
         ORDER BY c.id"
    )->fetchAll();

    $products = $pdo->query(
        "SELECT id, updated_at FROM products WHERE status = 'published' ORDER BY id"
    )->fetchAll();
} catch (Throwable $e) {
    error_log('sitemap.php: ' . $e->getMessage());
    http_response_code(503);
    header('Retry-After: 3600');
    exit;
}

$today = date('Y-m-d');

/** Дата у форматі W3C (YYYY-MM-DD) з рядка БД, або сьогодні, якщо дати немає. */
function sitemap_date(?string $value, string $fallback): string
{
    $ts = $value !== null ? strtotime($value) : false;

    return $ts !== false ? date('Y-m-d', $ts) : $fallback;
}

/**
 * Записи карти: loc (відносний шлях), lastmod, priority, alternates (мова => шлях).
 * @var list<array{loc: string, lastmod: string, priority: string, alternates?: array<string, string>}> $urls
 */
$urls = [
    ['loc' => '', 'lastmod' => $today, 'priority' => '1.0'],
    ['loc' => 'eli.php', 'lastmod' => $today, 'priority' => '0.9'],
];

foreach ($categories as $row) {
    $urls[] = [
        'loc'      => 'category.php?id=' . (int) $row['id'],
        'lastmod'  => sitemap_date($row['lastmod'], $today),
        'priority' => '0.8',
    ];
}

foreach ($products as $row) {
    $urls[] = [
        'loc'      => 'product.php?id=' . (int) $row['id'],
        'lastmod'  => sitemap_date($row['updated_at'], $today),
        'priority' => '0.7',
    ];
}

foreach (['about.php', 'contacts.php', 'terms.php', 'privacy.php'] as $page) {
    $urls[] = ['loc' => $page, 'lastmod' => $today, 'priority' => '0.5'];
}

$urls[] = ['loc' => 'blog.php', 'lastmod' => $today, 'priority' => '0.6'];

foreach (BLOG_ARTICLES as $slug => $files) {
    $alternates = [];
    foreach (array_keys($files) as $lang) {
        $alternates[$lang] = blog_article_url($slug, $lang);
    }
    $alternates['x-default'] = blog_article_url($slug, BLOG_DEFAULT_LANG);

    foreach ($files as $lang => $file) {
        $mtime = @filemtime(BLOG_CONTENT_DIR . '/' . $file);
        $urls[] = [
            'loc'        => blog_article_url($slug, $lang),
            'lastmod'    => $mtime !== false ? date('Y-m-d', $mtime) : $today,
            'priority'   => '0.6',
            'alternates' => $alternates,
        ];
    }
}

/** Абсолютний URL, екранований для XML (&amp; у query-рядку). */
function sitemap_loc(string $path): string
{
    return htmlspecialchars(SITEMAP_BASE_URL . '/' . $path, ENT_XML1 | ENT_QUOTES, 'UTF-8');
}

header('Content-Type: application/xml; charset=utf-8');

echo '<?xml version="1.0" encoding="UTF-8"?>', "\n";
echo '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9"', "\n";
echo '        xmlns:xhtml="http://www.w3.org/1999/xhtml">', "\n";

foreach ($urls as $url) {
    echo "  <url>\n";
    echo '    <loc>', sitemap_loc($url['loc']), "</loc>\n";
    echo '    <lastmod>', $url['lastmod'], "</lastmod>\n";
    echo '    <priority>', $url['priority'], "</priority>\n";
    // Елементи інших просторів імен — після priority (порядок зі sitemap.xsd).
    foreach ($url['alternates'] ?? [] as $hreflang => $href) {
        echo '    <xhtml:link rel="alternate" hreflang="', $hreflang, '" href="', sitemap_loc($href), "\"/>\n";
    }
    echo "  </url>\n";
}

echo "</urlset>\n";
