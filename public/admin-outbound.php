<?php

declare(strict_types=1);

/**
 * AI LAB HUB — переходи з сайту на сайти продуктів (лише admin).
 *
 * ?days=7|30 — період; ?csv=1 — експорт топу продуктів у CSV. Дані — link_clicks (public/go.php)
 * після дедуплікації (app/outbound-stats.php). Без IP і без імен.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/outbound-stats.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

if (auth_role() !== 'admin') {
    header('Location: account.php');
    exit;
}
header('X-Robots-Tag: noindex, nofollow');

$days = outbound_days($_GET['days'] ?? 30);
$rows = outbound_rows($pdo, $days);
$totals = outbound_totals($rows);
$top = outbound_top($pdo, $rows, 20);
$weekly = outbound_weekly(outbound_rows($pdo, 56), 8);

if (isset($_GET['csv'])) {
    outbound_send_csv(
        'ailabhub-outbound-' . $days . 'd-' . site_stats_day() . '.csv',
        ['product_id', 'product', 'clicks_total', 'clicks_official', 'clicks_affiliate', 'unique_sessions', 'period_days'],
        array_map(static fn($r) => [$r['product_id'], $r['name'], $r['total'], $r['official'], $r['affiliate'], $r['sessions'], $days], $top)
    );
}

$e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
$n = static fn(int $v): string => number_format($v, 0, ',', ' ');
$weekMax = max(1, ...array_map(static fn($w) => $w['total'], $weekly));
?>
<!DOCTYPE html>
<html lang="<?= $e(current_lang()) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <title>AI LAB HUB — Переходи на сайти продуктів</title>
    <link rel="stylesheet" href="<?= '/assets/css/admin-report.css?v=' . (int) @filemtime(__DIR__ . '/assets/css/admin-report.css') ?>">
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <main class="rep">
        <a class="rep__back" href="admin-stats.php">← Статистика сайту</a>
        <h1 class="rep__title">Переходи на сайти продуктів</h1>
        <p class="rep__sub">Кліки «Перейти на сайт» (через go.php) за останні <?= $days ?> днів. Повторні кліки того самого сеансу по тому самому продукту протягом 30 хвилин рахуються один раз.</p>

        <div class="rep-bar">
            <?php foreach (OUTBOUND_PERIODS as $d): ?>
            <a class="rep-btn<?= $d === $days ? ' is-active' : '' ?>" href="admin-outbound.php?days=<?= $d ?>"><?= $d ?> днів</a>
            <?php endforeach; ?>
            <a class="rep-btn" href="admin-outbound.php?days=<?= $days ?>&amp;csv=1">Експорт CSV</a>
            <a class="rep-btn" href="admin-summary.php">Зведення для медіакіту</a>
        </div>

        <div class="rep-cards">
            <div class="rep-card"><p class="rep-card__label">Усього переходів</p><p class="rep-card__value"><?= $n($totals['total']) ?></p></div>
            <div class="rep-card"><p class="rep-card__label">Офіційні посилання</p><p class="rep-card__value"><?= $n($totals['official']) ?></p></div>
            <div class="rep-card"><p class="rep-card__label">Партнерські посилання</p><p class="rep-card__value"><?= $n($totals['affiliate']) ?></p></div>
            <div class="rep-card"><p class="rep-card__label">Унікальні сеанси, що клікнули</p><p class="rep-card__value"><?= $n($totals['sessions']) ?></p></div>
        </div>

        <h2 class="rep__h2">Тижневий тренд (8 тижнів, понеділок–неділя за Києвом)</h2>
        <div class="rep-table-wrap">
            <table class="rep-table">
                <thead><tr><th>Тиждень</th><th class="num">Переходи</th><th class="num">Сеанси</th><th></th></tr></thead>
                <tbody>
                <?php foreach ($weekly as $w): ?>
                <tr>
                    <td data-label="Тиждень"><?= $e($w['label']) ?></td>
                    <td data-label="Переходи" class="num"><?= $n($w['total']) ?></td>
                    <td data-label="Сеанси" class="num"><?= $n($w['sessions']) ?></td>
                    <td data-label="" style="width:40%"><div class="rep-bar-cell"><span class="rep-bar-cell__bar" style="width:<?= round($w['total'] * 100 / $weekMax) ?>%"></span></div></td>
                </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>

        <h2 class="rep__h2">Топ-20 продуктів за переходами</h2>
        <div class="rep-table-wrap">
            <table class="rep-table">
                <thead><tr><th>#</th><th>Продукт</th><th class="num">Усього</th><th class="num">Офіційні</th><th class="num">Партнерські</th><th class="num">Сеанси</th><th>Звіт</th></tr></thead>
                <tbody>
                <?php if ($top === []): ?>
                <tr><td class="rep-empty" colspan="7">За цей період переходів ще немає.</td></tr>
                <?php endif; ?>
                <?php foreach ($top as $i => $r): ?>
                <tr>
                    <td data-label="#"><?= $i + 1 ?></td>
                    <td data-label="Продукт"><a href="product.php?id=<?= (int) $r['product_id'] ?>"><?= $e($r['name']) ?></a></td>
                    <td data-label="Усього" class="num"><?= $n($r['total']) ?></td>
                    <td data-label="Офіційні" class="num"><?= $n($r['official']) ?></td>
                    <td data-label="Партнерські" class="num"><?= $n($r['affiliate']) ?></td>
                    <td data-label="Сеанси" class="num"><?= $n($r['sessions']) ?></td>
                    <td data-label="Звіт"><a href="admin-vendor-report.php?product_id=<?= (int) $r['product_id'] ?>&amp;days=30">для сервісу</a></td>
                </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>

        <h2 class="rep__h2">Як рахуються переходи</h2>
        <ul class="rep__note">
            <li>Перехід — натискання «Перейти на сайт» на сторінці продукту (редирект через go.php); партнерський — якщо в продукту задано партнерське посилання.</li>
            <li>Дедуплікація: кліки одного сеансу по тому самому продукту в одному 30-хвилинному вікні — один перехід (діє і для старих даних).</li>
            <li>З 16.10.2026 не записуються: відомі боти й сканери (за User-Agent), кліки співробітників (якщо в статистиці ввімкнено «Не рахувати перегляди адмінів») і повтори протягом 30 хвилин. До цієї дати ботів не відсіювали.</li>
            <li>Сеанс — анонімний хеш, без IP і без імен.</li>
        </ul>
    </main>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
