<?php

declare(strict_types=1);

/**
 * AI LAB HUB — панель статистики сайту (лише admin).
 *
 * Власна аналітика (app/analytics.php): перегляди сторінок (page_views)
 * і кліки на «Перейти на сайт» (link_clicks, через public/go.php).
 * Ніяких персональних даних — лише анонімний session_hash.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/blog.php';
require_once __DIR__ . '/../app/site-stats.php';
require_once __DIR__ . '/../app/eli-diagnostics.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

if (auth_role() !== 'admin') {
    header('Location: account.php');
    exit;
}

if (empty($_SESSION['stats_csrf']) || !is_string($_SESSION['stats_csrf'])) {
    $_SESSION['stats_csrf'] = bin2hex(random_bytes(32));
}

/** Перемикач «Не рахувати перегляди адмінів» (site_settings.stats_exclude_staff). */
if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    $ok = false;
    $sent = $_POST['csrf'] ?? '';
    if (is_string($sent) && hash_equals($_SESSION['stats_csrf'], $sent)) {
        try {
            site_settings_save($pdo, ['stats_exclude_staff' => isset($_POST['exclude_staff']) ? '1' : '0']);
            $ok = true;
        } catch (Throwable $e) {
            error_log('[admin-stats] settings: ' . $e->getMessage());
        }
    }
    $_SESSION['stats_flash'] = $ok;
    header('Location: admin-stats.php#pv-settings', true, 303);
    exit;
}
$statsFlash = $_SESSION['stats_flash'] ?? null;
unset($_SESSION['stats_flash']);
$excludeStaff = site_setting($pdo, 'stats_exclude_staff', '1') === '1';

/** Блок «Перегляди сайту»: спершу дорахувати незакриті дні в page_views_daily. */
$pv = site_stats_try_sync($pdo) ? site_stats_summary($pdo) : null;

/** Екранування для HTML. */
function e(mixed $value): string
{
    return htmlspecialchars((string) $value, ENT_QUOTES);
}

/** Усі акаунти, незалежно від ролі. */
$usersTotal = (int) $pdo->query('SELECT COUNT(*) FROM users')->fetchColumn();

/** Перегляди статей блогу (public/blog-post.php пише їх у page_views з типом 'article'). */
$blogViews = $pdo->query(
    "SELECT COUNT(*) AS views,
            SUM(viewed_at >= NOW() - INTERVAL 30 DAY) AS views_30d
     FROM page_views
     WHERE page_type = 'article'"
)->fetch();

/**
 * Фільтр періоду для топ-10 таблиць нижче — окремий від блоку «Перегляди сайту»
 * вище (ті картки фіксовані: київська доба, 7 і 30 днів).
 */
$periodLabels = [
    'today' => 'Сьогодні',
    '7d'    => '7 днів',
    '30d'   => '30 днів',
    'all'   => 'Увесь час',
];
$period = (string) ($_GET['period'] ?? 'all');
if (!array_key_exists($period, $periodLabels)) {
    $period = 'all';
}
$periodSince = match ($period) {
    'today' => date('Y-m-d 00:00:00'),
    '7d'    => date('Y-m-d H:i:s', strtotime('-7 days')),
    '30d'   => date('Y-m-d H:i:s', strtotime('-30 days')),
    default => null,
};

$topViewed = $pdo->prepare(
    "SELECT pv.page_id AS product_id, p.name, COUNT(*) AS views
     FROM page_views pv
     JOIN products p ON p.id = pv.page_id
     WHERE pv.page_type = 'product'
       AND (:since1 IS NULL OR pv.viewed_at >= :since2)
     GROUP BY pv.page_id, p.name
     ORDER BY views DESC
     LIMIT 10"
);
$topViewed->execute([':since1' => $periodSince, ':since2' => $periodSince]);
$topViewed = $topViewed->fetchAll();

$topClicked = $pdo->prepare(
    "SELECT lc.product_id, p.name,
            SUM(CASE WHEN lc.link_type = 'official' THEN 1 ELSE 0 END) AS official_clicks,
            SUM(CASE WHEN lc.link_type = 'affiliate' THEN 1 ELSE 0 END) AS affiliate_clicks,
            COUNT(*) AS total_clicks
     FROM link_clicks lc
     JOIN products p ON p.id = lc.product_id
     WHERE (:since1 IS NULL OR lc.clicked_at >= :since2)
     GROUP BY lc.product_id, p.name
     ORDER BY total_clicks DESC
     LIMIT 10"
);
$topClicked->execute([':since1' => $periodSince, ':since2' => $periodSince]);
$topClicked = $topClicked->fetchAll();

/**
 * Пошукові запити (search_queries, міграція 2026-10-25): що шукають у шапці, на сторінці результатів
 * і в Елі. Групування за нормалізованим текстом, рахуються різні сеанси. «Без результатів» —
 * запити, на які пошук сайту не знайшов жодного продукту: кандидати на поповнення каталогу.
 * Без міграції — null і підказка замість таблиць.
 */
$topQueries = null;
$zeroQueries = null;
try {
    $stmt = $pdo->prepare(
        "SELECT query_norm, MAX(query_text) AS sample, COUNT(DISTINCT session_hash) AS sessions,
                GROUP_CONCAT(DISTINCT source ORDER BY source SEPARATOR ', ') AS sources,
                MAX(results_count) AS max_results
         FROM search_queries
         WHERE (:since1 IS NULL OR created_at >= :since2)
         GROUP BY query_norm
         ORDER BY sessions DESC, MAX(created_at) DESC
         LIMIT 30"
    );
    $stmt->execute([':since1' => $periodSince, ':since2' => $periodSince]);
    $topQueries = $stmt->fetchAll();

    $stmt = $pdo->prepare(
        "SELECT query_norm, MAX(query_text) AS sample, COUNT(DISTINCT session_hash) AS sessions,
                GROUP_CONCAT(DISTINCT source ORDER BY source SEPARATOR ', ') AS sources
         FROM search_queries
         WHERE source <> 'eli' AND (:since1 IS NULL OR created_at >= :since2)
         GROUP BY query_norm
         HAVING MAX(results_count) = 0
         ORDER BY sessions DESC, MAX(created_at) DESC
         LIMIT 20"
    );
    $stmt->execute([':since1' => $periodSince, ':since2' => $periodSince]);
    $zeroQueries = $stmt->fetchAll();
} catch (Throwable $e) {
    $topQueries = null;
    $zeroQueries = null;
}

/**
 * Топ статей блогу: page_slug з міграції 2026-09-27 (усі мовні версії статті
 * разом). Без міграції — null і підказка замість таблиці.
 */
$topArticles = null;
try {
    $stmt = $pdo->prepare(
        "SELECT page_slug, COUNT(*) AS views
         FROM page_views
         WHERE page_type = 'article'
           AND page_slug IS NOT NULL
           AND (:since1 IS NULL OR viewed_at >= :since2)
         GROUP BY page_slug
         ORDER BY views DESC
         LIMIT 10"
    );
    $stmt->execute([':since1' => $periodSince, ':since2' => $periodSince]);
    $topArticles = $stmt->fetchAll();
} catch (PDOException $e) {
    error_log('[admin-stats] top articles: ' . $e->getMessage());
}

?>
<!DOCTYPE html>
<html lang="<?= e(current_lang()) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — Статистика сайту</title>
    <style>
        *,
        *::before,
        *::after {
            box-sizing: border-box;
        }

        :root {
            --bg-start: #00032c;
            --bg-end: #2116ad;
            --card-bg: rgba(255, 255, 255, 0.05);
            --card-border: rgba(255, 255, 255, 0.14);
            --text-muted: rgba(255, 255, 255, 0.75);
            --accent: #5b8cff;
        }

        html,
        body {
            margin: 0;
            padding: 0;
        }

        body {
            min-height: 100vh;
            font-family: "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            color: #ffffff;
            background: linear-gradient(160deg, var(--bg-start) 0%, var(--bg-end) 100%);
            background-attachment: fixed;
            line-height: 1.6;
        }

        .site-header {
            display: flex;
            align-items: center;
            padding: 20px 32px;
        }

        .site-header__brand {
            display: flex;
            align-items: center;
            gap: 12px;
            text-decoration: none;
            color: #ffffff;
        }

        .site-header__logo {
            height: 42px;
            width: auto;
            display: block;
            border-radius: 10px;
        }

        .page {
            max-width: 1100px;
            margin: 0 auto;
            padding: 24px 24px 72px;
        }

        .back-link {
            display: inline-block;
            margin-bottom: 16px;
            font-size: 0.9rem;
            color: #bcd0ff;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .page__title {
            margin: 0 0 8px;
            font-size: clamp(1.6rem, 4.5vw, 2.2rem);
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .page__subtitle {
            margin: 0 0 28px;
            color: var(--text-muted);
        }

        .stat-cards {
            display: grid;
            gap: 16px;
            grid-template-columns: repeat(3, 1fr);
            margin-bottom: 40px;
        }

        @media (max-width: 720px) {
            .stat-cards {
                grid-template-columns: 1fr;
            }
        }

        .stat-card {
            padding: 20px;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 16px;
        }

        .stat-card__label {
            margin: 0 0 8px;
            font-size: 0.82rem;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            color: var(--text-muted);
        }

        .stat-card__value {
            margin: 0;
            font-size: 2.1rem;
            font-weight: 800;
        }

        .stat-card__sub {
            margin: 4px 0 0;
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        .section__title {
            margin: 0 0 4px;
            font-size: 1.3rem;
            font-weight: 700;
        }

        .section {
            margin-bottom: 40px;
        }

        .period-switch {
            display: inline-flex;
            gap: 4px;
            padding: 3px;
            margin-bottom: 20px;
            border-radius: 999px;
            border: 1px solid var(--card-border);
            background: var(--card-bg);
        }

        .period-switch__btn {
            padding: 7px 16px;
            border-radius: 999px;
            font-size: 0.85rem;
            font-weight: 600;
            text-decoration: none;
            color: var(--text-muted);
            transition: color 0.15s ease, background 0.15s ease;
        }

        .period-switch__btn:hover {
            color: #ffffff;
        }

        .period-switch__btn.is-active {
            color: #00032c;
            background: linear-gradient(135deg, #5b8cff, #a5c0ff);
        }

        .table-wrap {
            overflow-x: auto;
            border: 1px solid var(--card-border);
            border-radius: 16px;
            background: var(--card-bg);
        }

        .table {
            width: 100%;
            min-width: 480px;
            border-collapse: collapse;
            font-size: 0.92rem;
        }

        .table th,
        .table td {
            padding: 12px 16px;
            text-align: left;
            border-bottom: 1px solid var(--card-border);
        }

        .table th {
            font-size: 0.76rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            color: var(--text-muted);
            white-space: nowrap;
        }

        .table tbody tr:last-child td {
            border-bottom: none;
        }

        .table tbody tr:hover {
            background: rgba(255, 255, 255, 0.04);
        }

        .table__name {
            font-weight: 700;
            color: #ffffff;
            text-decoration: none;
        }

        .table__name:hover {
            color: #bcd0ff;
        }

        .table__num {
            font-variant-numeric: tabular-nums;
            white-space: nowrap;
        }

        .table__muted {
            color: var(--text-muted);
        }

        .empty-state {
            padding: 28px;
            text-align: center;
            color: var(--text-muted);
        }
    </style>
    <link rel="stylesheet" href="assets/css/site-stats.css?v=<?= (int) @filemtime(__DIR__ . '/assets/css/site-stats.css') ?>">
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="/logo.png" alt="AI LAB HUB">
        </a>
    </header>

    <div class="page">
        <a class="back-link" href="account.php">← До кабінету</a>

        <h1 class="page__title">Статистика сайту</h1>
        <p class="page__subtitle">Власна аналітика: перегляди сторінок і кліки на «Перейти на сайт». Без персональних даних — лише анонімні сесії.</p>
        <p class="page__subtitle"><a class="table__name" href="admin-outbound.php">Переходи на сайти продуктів →</a> · <a class="table__name" href="admin-summary.php">Зведення для медіакіту →</a></p>

        <?php include __DIR__ . '/../app/site-stats-block.php'; ?>

        <div class="stat-cards">
            <div class="stat-card">
                <p class="stat-card__label">Зареєстровані користувачі</p>
                <p class="stat-card__value"><?= $usersTotal ?></p>
                <p class="stat-card__sub">усі акаунти, незалежно від ролі</p>
            </div>
            <div class="stat-card">
                <p class="stat-card__label">Перегляди статей блогу</p>
                <p class="stat-card__value"><?= (int) $blogViews['views'] ?></p>
                <p class="stat-card__sub"><?= (int) $blogViews['views_30d'] ?> за останні 30 днів</p>
            </div>
        </div>

        <section class="section" id="eli-stats">
            <h2 class="section__title">Еля: надійність відповідей</h2>
            <?= eli_stats_css() ?>
            <?= eli_stats_html($pdo) ?>
            <?php
            $eliDiag = is_array($_SESSION['eli_diag_result'] ?? null) ? $_SESSION['eli_diag_result'] : null;
            $eliDiagFlash = is_string($_SESSION['eli_diag_flash'] ?? null) ? $_SESSION['eli_diag_flash'] : null;
            unset($_SESSION['eli_diag_flash']);
            ?>
            <?= eli_diag_html($pdo, $eliDiag, $_SESSION['stats_csrf'], $eliDiagFlash) ?>
        </section>

        <div class="period-switch">
            <?php foreach ($periodLabels as $key => $label): ?>
                <a class="period-switch__btn<?= $key === $period ? ' is-active' : '' ?>" href="admin-stats.php?period=<?= e($key) ?>"><?= e($label) ?></a>
            <?php endforeach; ?>
        </div>

        <section class="section">
            <h2 class="section__title">Топ-10 продуктів за переглядами картки</h2>
            <p class="stat-card__sub" style="margin-bottom: 16px;">Період: <?= e($periodLabels[$period]) ?></p>
            <div class="table-wrap">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Продукт</th>
                            <th>Переглядів</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if ($topViewed === []): ?>
                            <tr><td class="empty-state" colspan="2">Переглядів ще немає.</td></tr>
                        <?php else: ?>
                            <?php foreach ($topViewed as $row): ?>
                                <tr>
                                    <td><a class="table__name" href="product.php?id=<?= (int) $row['product_id'] ?>"><?= e($row['name']) ?></a></td>
                                    <td class="table__num"><?= (int) $row['views'] ?></td>
                                </tr>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </section>

        <section class="section">
            <h2 class="section__title">Топ-10 продуктів за кліками «Перейти на сайт»</h2>
            <p class="stat-card__sub" style="margin-bottom: 16px;">Період: <?= e($periodLabels[$period]) ?></p>
            <div class="table-wrap">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Продукт</th>
                            <th>Офіційні кліки</th>
                            <th>Партнерські кліки</th>
                            <th>Разом</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if ($topClicked === []): ?>
                            <tr><td class="empty-state" colspan="4">Кліків ще немає.</td></tr>
                        <?php else: ?>
                            <?php foreach ($topClicked as $row): ?>
                                <tr>
                                    <td><a class="table__name" href="product.php?id=<?= (int) $row['product_id'] ?>"><?= e($row['name']) ?></a></td>
                                    <td class="table__num table__muted"><?= (int) $row['official_clicks'] ?></td>
                                    <td class="table__num table__muted"><?= (int) $row['affiliate_clicks'] ?></td>
                                    <td class="table__num"><?= (int) $row['total_clicks'] ?></td>
                                </tr>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </section>

        <section class="section" id="search-queries">
            <h2 class="section__title">Пошукові запити</h2>
            <p class="stat-card__sub" style="margin-bottom: 16px;">Період: <?= e($periodLabels[$period]) ?> · шапка (header), сторінка результатів (catalog) і Еля (eli) · без ботів і співробітників · рахуються різні сеанси</p>
            <div class="table-wrap">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Запит</th>
                            <th>Сеансів</th>
                            <th>Де</th>
                            <th>Знайдено продуктів</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if ($topQueries === null): ?>
                            <tr><td class="empty-state" colspan="4">Застосуйте міграцію database/migration-2026-10-25-search-queries.sql.</td></tr>
                        <?php elseif ($topQueries === []): ?>
                            <tr><td class="empty-state" colspan="4">Запитів ще немає.</td></tr>
                        <?php else: ?>
                            <?php foreach ($topQueries as $row): ?>
                                <tr>
                                    <td><?= e($row['sample']) ?></td>
                                    <td class="table__num"><?= (int) $row['sessions'] ?></td>
                                    <td class="table__muted"><?= e($row['sources']) ?></td>
                                    <td class="table__num table__muted"><?= (int) $row['max_results'] ?></td>
                                </tr>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>

            <h3 class="section__title" style="font-size: 1.05rem; margin-top: 24px;">Запити без результатів — чого бракує в каталозі</h3>
            <div class="table-wrap">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Запит</th>
                            <th>Сеансів</th>
                            <th>Де</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if ($zeroQueries === null): ?>
                            <tr><td class="empty-state" colspan="3">Застосуйте міграцію database/migration-2026-10-25-search-queries.sql.</td></tr>
                        <?php elseif ($zeroQueries === []): ?>
                            <tr><td class="empty-state" colspan="3">Усі запити знаходили продукти.</td></tr>
                        <?php else: ?>
                            <?php foreach ($zeroQueries as $row): ?>
                                <tr>
                                    <td><?= e($row['sample']) ?></td>
                                    <td class="table__num"><?= (int) $row['sessions'] ?></td>
                                    <td class="table__muted"><?= e($row['sources']) ?></td>
                                </tr>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </section>

        <section class="section">
            <h2 class="section__title">Топ-10 статей блогу за переглядами</h2>
            <p class="stat-card__sub" style="margin-bottom: 16px;">Період: <?= e($periodLabels[$period]) ?> · усі мовні версії статті разом</p>
            <div class="table-wrap">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Стаття</th>
                            <th>Переглядів</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php if ($topArticles === null): ?>
                            <tr><td class="empty-state" colspan="2">Застосуйте міграцію database/migration-2026-09-27-page-views-slug.sql.</td></tr>
                        <?php elseif ($topArticles === []): ?>
                            <tr><td class="empty-state" colspan="2">Переглядів статей ще немає.</td></tr>
                        <?php else: ?>
                            <?php foreach ($topArticles as $row): ?>
                                <?php $article = blog_load_article((string) $row['page_slug'], BLOG_DEFAULT_LANG); ?>
                                <tr>
                                    <td><a class="table__name" href="<?= e(blog_article_url((string) $row['page_slug'], BLOG_DEFAULT_LANG)) ?>"><?= e($article['title'] ?? $row['page_slug']) ?></a></td>
                                    <td class="table__num"><?= (int) $row['views'] ?></td>
                                </tr>
                            <?php endforeach; ?>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </section>
    </div>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
