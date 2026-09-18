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

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

if (auth_role() !== 'admin') {
    header('Location: account.php');
    exit;
}

/** Екранування для HTML. */
function e(mixed $value): string
{
    return htmlspecialchars((string) $value, ENT_QUOTES);
}

/** Перегляди й унікальні сесії за період (від $since до тепер). */
function stats_period_totals(PDO $pdo, string $since): array
{
    $stmt = $pdo->prepare(
        'SELECT COUNT(*) AS views, COUNT(DISTINCT session_hash) AS unique_sessions
         FROM page_views
         WHERE viewed_at >= :since'
    );
    $stmt->execute([':since' => $since]);
    $row = $stmt->fetch();

    return [
        'views' => (int) ($row['views'] ?? 0),
        'unique_sessions' => (int) ($row['unique_sessions'] ?? 0),
    ];
}

$today = stats_period_totals($pdo, date('Y-m-d 00:00:00'));
$last7 = stats_period_totals($pdo, date('Y-m-d H:i:s', strtotime('-7 days')));
$last30 = stats_period_totals($pdo, date('Y-m-d H:i:s', strtotime('-30 days')));

$topViewed = $pdo->query(
    "SELECT pv.page_id AS product_id, p.name, COUNT(*) AS views
     FROM page_views pv
     JOIN products p ON p.id = pv.page_id
     WHERE pv.page_type = 'product'
     GROUP BY pv.page_id, p.name
     ORDER BY views DESC
     LIMIT 10"
)->fetchAll();

$topClicked = $pdo->query(
    "SELECT lc.product_id, p.name,
            SUM(CASE WHEN lc.link_type = 'official' THEN 1 ELSE 0 END) AS official_clicks,
            SUM(CASE WHEN lc.link_type = 'affiliate' THEN 1 ELSE 0 END) AS affiliate_clicks,
            COUNT(*) AS total_clicks
     FROM link_clicks lc
     JOIN products p ON p.id = lc.product_id
     GROUP BY lc.product_id, p.name
     ORDER BY total_clicks DESC
     LIMIT 10"
)->fetchAll();

?>
<!DOCTYPE html>
<html lang="uk">
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
            margin: 0 0 16px;
            font-size: 1.3rem;
            font-weight: 700;
        }

        .section {
            margin-bottom: 40px;
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

        <div class="stat-cards">
            <div class="stat-card">
                <p class="stat-card__label">Сьогодні</p>
                <p class="stat-card__value"><?= (int) $today['views'] ?></p>
                <p class="stat-card__sub"><?= (int) $today['unique_sessions'] ?> унікальних сесій</p>
            </div>
            <div class="stat-card">
                <p class="stat-card__label">Останні 7 днів</p>
                <p class="stat-card__value"><?= (int) $last7['views'] ?></p>
                <p class="stat-card__sub"><?= (int) $last7['unique_sessions'] ?> унікальних сесій</p>
            </div>
            <div class="stat-card">
                <p class="stat-card__label">Останні 30 днів</p>
                <p class="stat-card__value"><?= (int) $last30['views'] ?></p>
                <p class="stat-card__sub"><?= (int) $last30['unique_sessions'] ?> унікальних сесій</p>
            </div>
        </div>

        <section class="section">
            <h2 class="section__title">Топ-10 продуктів за переглядами картки</h2>
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
    </div>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
