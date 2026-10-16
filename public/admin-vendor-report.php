<?php

declare(strict_types=1);

/**
 * AI LAB HUB — звіт про переходи для сервісу (лише admin): для друку (print CSS) і CSV.
 *
 * ?product_id=N&days=7|30 [&csv=1]. Назва продукту, період, переходи, унікальні сеанси,
 * розподіл по тижнях, частка мов інтерфейсу UA/EN (якщо дані є). Без IP і без імен.
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
$productId = (int) ($_GET['product_id'] ?? 0);
$product = null;
if ($productId > 0) {
    $st = $pdo->prepare('SELECT id, name, official_url FROM products WHERE id = :id');
    $st->execute([':id' => $productId]);
    $product = $st->fetch() ?: null;
}

$e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
$n = static fn(int $v): string => number_format($v, 0, ',', ' ');
$tz = site_stats_tz();
$periodTo = new DateTimeImmutable('now', $tz);
$periodFrom = $periodTo->modify('-' . $days . ' days');
$periodText = $periodFrom->format('d.m.Y') . ' — ' . $periodTo->format('d.m.Y');
$langNames = ['uk' => 'українська (UA)', 'en' => 'англійська (EN)'];
$note = 'Дані з аналітики AI LAB HUB, без персональних даних.';

if ($product !== null) {
    $rows = outbound_rows($pdo, $days, $productId);
    $totals = outbound_totals($rows);
    // Тижні від того, у який потрапляє початок періоду, до поточного.
    $mon = static fn(DateTimeImmutable $d): DateTimeImmutable => $d->setTime(0, 0)->modify('-' . ((int) $d->format('N') - 1) . ' days');
    $weekly = outbound_weekly($rows, intdiv((int) $mon($periodFrom)->diff($mon($periodTo))->days, 7) + 1);
    $langs = outbound_lang_shares($rows);

    if (isset($_GET['csv'])) {
        $csv = [
            ['Продукт', $product['name']],
            ['Період', $periodText],
            ['Переходи', $totals['total']],
            ['з них за офіційним посиланням', $totals['official']],
            ['з них за партнерським посиланням', $totals['affiliate']],
            ['Унікальні сеанси', $totals['sessions']],
            [],
            ['Тиждень', 'Переходи', 'Сеанси'],
        ];
        foreach ($weekly as $w) {
            $csv[] = [$w['label'], $w['total'], $w['sessions']];
        }
        $csv[] = [];
        $csv[] = ['Мова інтерфейсу', 'Частка, %'];
        if ($langs['known'] === 0) {
            $csv[] = ['немає даних', ''];
        }
        foreach ($langs['shares'] as $l => $pct) {
            $csv[] = [$langNames[$l] ?? $l, $pct];
        }
        $csv[] = [];
        $csv[] = [$note];
        outbound_send_csv('ailabhub-report-product-' . $productId . '-' . $days . 'd.csv', ['Звіт про переходи — AI LAB HUB'], $csv);
    }
}
?>
<!DOCTYPE html>
<html lang="<?= $e(current_lang()) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <title>AI LAB HUB — Звіт про переходи<?= $product ? ' — ' . $e($product['name']) : '' ?></title>
    <link rel="stylesheet" href="<?= '/assets/css/admin-report.css?v=' . (int) @filemtime(__DIR__ . '/assets/css/admin-report.css') ?>">
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <main class="rep">
        <a class="rep__back" href="admin-outbound.php?days=<?= $days ?>">← Переходи на сайти продуктів</a>

        <form class="rep-form" method="get" action="admin-vendor-report.php">
            <label>ID продукту <input type="number" name="product_id" min="1" value="<?= $productId > 0 ? $productId : '' ?>" required style="width:120px"></label>
            <input type="hidden" name="days" value="<?= $days ?>">
            <button class="rep-btn" type="submit">Показати</button>
        </form>

        <?php if ($product === null): ?>
        <h1 class="rep__title">Звіт про переходи для сервісу</h1>
        <p class="rep__sub"><?= $productId > 0 ? 'Продукт #' . $productId . ' не знайдено.' : 'Вкажіть ID продукту або відкрийте звіт із таблиці на сторінці переходів.' ?></p>
        <?php else: ?>
        <div class="rep-bar">
            <?php foreach (OUTBOUND_PERIODS as $d): ?>
            <a class="rep-btn<?= $d === $days ? ' is-active' : '' ?>" href="admin-vendor-report.php?product_id=<?= $productId ?>&amp;days=<?= $d ?>"><?= $d ?> днів</a>
            <?php endforeach; ?>
            <button class="rep-btn" type="button" onclick="window.print()">Друк / PDF</button>
            <a class="rep-btn" href="admin-vendor-report.php?product_id=<?= $productId ?>&amp;days=<?= $days ?>&amp;csv=1">Експорт CSV</a>
        </div>

        <h1 class="rep__title">Звіт про переходи: <?= $e($product['name']) ?></h1>
        <p class="rep__sub">AI LAB HUB · каталог AI-інструментів · період <?= $e($periodText) ?> (<?= $days ?> днів)</p>

        <div class="rep-cards">
            <div class="rep-card"><p class="rep-card__label">Переходи на сайт продукту</p><p class="rep-card__value"><?= $n($totals['total']) ?></p></div>
            <div class="rep-card"><p class="rep-card__label">Унікальні сеанси</p><p class="rep-card__value"><?= $n($totals['sessions']) ?></p></div>
            <div class="rep-card"><p class="rep-card__label">Офіційне / партнерське посилання</p><p class="rep-card__value"><?= $n($totals['official']) ?> / <?= $n($totals['affiliate']) ?></p></div>
        </div>

        <h2 class="rep__h2">Розподіл по тижнях</h2>
        <div class="rep-table-wrap">
            <table class="rep-table">
                <thead><tr><th>Тиждень (пн–нд)</th><th class="num">Переходи</th><th class="num">Сеанси</th></tr></thead>
                <tbody>
                <?php foreach ($weekly as $w): ?>
                <tr><td data-label="Тиждень"><?= $e($w['label']) ?></td><td data-label="Переходи" class="num"><?= $n($w['total']) ?></td><td data-label="Сеанси" class="num"><?= $n($w['sessions']) ?></td></tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
        <p class="rep__note">Перший і останній тижні можуть бути неповними — межі періоду не збігаються з межами тижня.</p>

        <h2 class="rep__h2">Мова інтерфейсу відвідувачів</h2>
        <?php if ($langs['known'] === 0): ?>
        <p class="rep__note">Немає даних (мова кліку записується з 16.10.2026).</p>
        <?php else: ?>
        <div class="rep-table-wrap">
            <table class="rep-table">
                <thead><tr><th>Мова</th><th class="num">Частка</th></tr></thead>
                <tbody>
                <?php foreach ($langs['shares'] as $l => $pct): ?>
                <tr><td data-label="Мова"><?= $e($langNames[$l] ?? $l) ?></td><td data-label="Частка" class="num"><?= $e(str_replace('.', ',', (string) $pct)) ?>%</td></tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
        <?php if ($langs['known'] < $totals['total']): ?>
        <p class="rep__note">Частка від <?= $n($langs['known']) ?> із <?= $n($totals['total']) ?> переходів, для яких мова відома.</p>
        <?php endif; ?>
        <?php endif; ?>

        <h2 class="rep__h2">Методика</h2>
        <p class="rep__note">Перехід — натискання «Перейти на сайт» на сторінці продукту в каталозі AI LAB HUB. Повторні кліки того самого відвідувача протягом 30 хвилин рахуються один раз; відомі боти й кліки співробітників сайту не враховуються (з 16.10.2026). Сеанс — анонімний ідентифікатор відвідування.</p>
        <p class="rep__note"><strong><?= $e($note) ?></strong> Сформовано <?= $e($periodTo->format('d.m.Y H:i')) ?> (Київ).</p>
        <?php endif; ?>
    </main>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
