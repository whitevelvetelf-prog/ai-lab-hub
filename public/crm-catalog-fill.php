<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CRM: «Наповнення каталогу» (admin і employee, роль перевіряється за БД). Лише читання.
 *
 *   • Категорія → підкатегорія: опубліковано продуктів, мета (config/catalog.php), «Не вистачає».
 *     0 — червоним, 1…мета−1 — жовтим, ≥ мета — зеленим. Підсумок над таблицею.
 *   • GET: cat — фільтр за категорією, dir=asc|desc — сортування за «Не вистачає», export=csv — CSV (UTF-8 з BOM).
 *   • «Попит»: до 20 найчастіших запитів без результатів за 30 днів (search_log, замасковані).
 *     Повний список, синоніми й індекс — наявна admin-сторінка crm-search.php (лише посилання, без дублювання).
 *   • Дані — з кешу на 5 хвилин (app/catalog-fill.php).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/catalog-fill.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$uid = auth_user_id();
$roleSt = $pdo->prepare('SELECT role FROM users WHERE id = :u');
$roleSt->execute([':u' => (int) $uid]);
$role = $uid === null ? false : $roleSt->fetchColumn();
if (!in_array($role, ['admin', 'employee'], true)) {
    header('Location: account.php');
    exit;
}
header('X-Robots-Tag: noindex, nofollow');
header('Cache-Control: no-store');
$isAdmin = $role === 'admin';

$min = catalog_fill_min();
$data = catalog_fill_data($pdo);
$cats = catalog_fill_categories($data['rows']);
$catId = (int) ($_GET['cat'] ?? 0);
if (!isset($cats[$catId])) {
    $catId = 0;
}
$dir = ($_GET['dir'] ?? '') === 'asc' ? 'asc' : 'desc';
$rows = catalog_fill_rows($data['rows'], $min, $catId, $dir);
$sum = catalog_fill_summary($rows);

if (($_GET['export'] ?? '') === 'csv') {
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="catalog-fill-' . date('Y-m-d') . ($catId > 0 ? '-cat' . $catId : '') . '.csv"');
    echo catalog_fill_csv($rows, $min);
    exit;
}

$e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
$url = static function (array $over) use ($catId, $dir): string {
    $q = array_filter(array_merge(['cat' => $catId ?: null, 'dir' => $dir === 'asc' ? 'asc' : null], $over), static fn($v) => $v !== null);

    return 'crm-catalog-fill.php' . ($q === [] ? '' : '?' . http_build_query($q));
};
$levelLabel = ['zero' => 'немає', 'low' => 'мало', 'ok' => 'досить'];
?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <title>AI LAB HUB — Наповнення каталогу (CRM)</title>
    <link rel="stylesheet" href="<?= '/assets/css/admin-report.css?v=' . (int) @filemtime(__DIR__ . '/assets/css/admin-report.css') ?>">
    <style>
        .cf-bar { display: flex; flex-wrap: wrap; gap: 8px; align-items: flex-end; margin: 0 0 16px; }
        .cf-bar label { display: flex; flex-direction: column; gap: 4px; font-size: 0.85rem; font-weight: 600; flex: 1 1 220px; min-width: 0; }
        .cf-bar select { box-sizing: border-box; width: 100%; min-height: 44px; padding: 8px 10px; border-radius: 10px; border: 1px solid rgba(255, 255, 255, 0.25); background: #11163f; color: #fff; font: inherit; font-size: 0.92rem; }
        .cf-bar .rep-btn { min-height: 44px; box-sizing: border-box; display: inline-flex; align-items: center; }
        .cf-n { display: inline-block; min-width: 2.2em; padding: 2px 8px; border-radius: 999px; font-weight: 700; text-align: center; }
        .cf-n--zero { background: rgba(248, 113, 113, 0.22); color: #fecaca; border: 1px solid rgba(248, 113, 113, 0.6); }
        .cf-n--low { background: rgba(250, 204, 21, 0.18); color: #fef08a; border: 1px solid rgba(250, 204, 21, 0.55); }
        .cf-n--ok { background: rgba(52, 211, 153, 0.18); color: #bbf7d0; border: 1px solid rgba(52, 211, 153, 0.55); }
        .rep-card--zero .rep-card__value { color: #fca5a5; }
        .rep-card--low .rep-card__value { color: #fde047; }
        .cf-th-sort { color: inherit !important; text-decoration: none; white-space: nowrap; }
        .cf-cat-m { display: none; }
        .cf-sr { position: absolute; width: 1px; height: 1px; overflow: hidden; clip: rect(0 0 0 0); white-space: nowrap; }
        @media (max-width: 600px) {
            .rep { padding-top: 20px; }
            .rep-cards { grid-template-columns: repeat(2, minmax(0, 1fr)); gap: 8px; }
            .rep-card { padding: 10px 12px; }
            .rep-card__value { font-size: 1.3rem; }
            .rep-table { font-size: 0.86rem; }
            .rep-table th, .rep-table td { padding: 6px 7px; }
            .cf-col-cat, .cf-col-min { display: none; }
            .cf-cat-m { display: block; font-size: 0.78rem; color: var(--text-muted); }
        }
    </style>
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <main class="rep">
        <a class="rep__back" href="account.php#acc-crm">← Кабінет</a>
        <h1 class="rep__title">Наповнення каталогу</h1>
        <p class="rep__sub">Опубліковані продукти в кожній підкатегорії; продукт у кількох підкатегоріях рахується в кожній. Мета — <?= $min ?> на підкатегорію. Дані оновлюються раз на 5 хвилин (зараз — станом на <?= $e(date('H:i', $data['built_at'] ?: time())) ?>).</p>

        <div class="rep-cards">
            <div class="rep-card"><p class="rep-card__label">Підкатегорій</p><p class="rep-card__value"><?= $sum['total'] ?></p></div>
            <div class="rep-card rep-card--zero"><p class="rep-card__label">Без продуктів</p><p class="rep-card__value"><?= $sum['zero'] ?></p></div>
            <div class="rep-card rep-card--low"><p class="rep-card__label">Менше <?= $min ?></p><p class="rep-card__value"><?= $sum['below'] ?></p></div>
            <div class="rep-card"><p class="rep-card__label">Ще потрібно продуктів</p><p class="rep-card__value"><?= number_format($sum['needed'], 0, ',', ' ') ?></p></div>
        </div>
        <p class="rep__note">«Менше <?= $min ?>» включає підкатегорії без продуктів.<?= $catId > 0 ? ' Підсумок — лише для вибраної категорії.' : '' ?></p>

        <form class="cf-bar" method="get" action="crm-catalog-fill.php">
            <label>Категорія
                <select name="cat" onchange="this.form.submit()">
                    <option value="0">Усі категорії</option>
                    <?php foreach ($cats as $id => $name): ?>
                    <option value="<?= (int) $id ?>"<?= $id === $catId ? ' selected' : '' ?>><?= $e($name) ?></option>
                    <?php endforeach; ?>
                </select>
            </label>
            <?php if ($dir === 'asc'): ?><input type="hidden" name="dir" value="asc"><?php endif; ?>
            <noscript><button type="submit" class="rep-btn">Показати</button></noscript>
            <a class="rep-btn" href="<?= $e($url(['export' => 'csv'])) ?>">Експорт CSV</a>
        </form>

        <div class="rep-table-wrap">
            <table class="rep-table">
                <thead><tr>
                    <th class="cf-col-cat">Категорія</th>
                    <th>Підкатегорія</th>
                    <th class="num">Опубл.</th>
                    <th class="num cf-col-min">Мета</th>
                    <th class="num" aria-sort="<?= $dir === 'asc' ? 'ascending' : 'descending' ?>"><a class="cf-th-sort" href="<?= $e($url(['dir' => $dir === 'asc' ? null : 'asc'])) ?>" title="Змінити напрям сортування">Не вистачає <?= $dir === 'asc' ? '▲' : '▼' ?></a></th>
                </tr></thead>
                <tbody>
                <?php if ($rows === []): ?><tr><td class="rep-empty" colspan="5">Підкатегорій немає.</td></tr><?php endif; ?>
                <?php foreach ($rows as $r): ?>
                <tr>
                    <td class="cf-col-cat"><a href="category.php?id=<?= (int) $r['cat_id'] ?>" target="_blank" rel="noopener"><?= $e($r['cat_name']) ?></a></td>
                    <td><a href="catalog.php?subcategory=<?= (int) $r['sub_id'] ?>" target="_blank" rel="noopener"><?= $e($r['sub_name']) ?></a><span class="cf-cat-m"><?= $e($r['cat_name']) ?></span></td>
                    <td class="num"><span class="cf-n cf-n--<?= $r['level'] ?>"><?= (int) $r['published'] ?><span class="cf-sr"> — <?= $levelLabel[$r['level']] ?></span></span></td>
                    <td class="num cf-col-min"><?= $min ?></td>
                    <td class="num"><?= $r['missing'] > 0 ? (int) $r['missing'] : '—' ?></td>
                </tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>

        <h2 class="rep__h2">Попит: шукали, але не знайшли</h2>
        <p class="rep__sub">До <?= CATALOG_FILL_DEMAND_LIMIT ?> найчастіших запитів зі сторінки результатів пошуку, що нічого не знайшли, за <?= (int) search_config()['zero_result_retention_days'] ?> днів. Без IP і користувачів; пошта, телефони, номери й посилання замасковані.<?php if ($isAdmin): ?> Повний список, синоніми й індекс — <a href="crm-search.php">«Пошук продуктів»</a>.<?php endif; ?></p>
        <div class="rep-table-wrap">
            <table class="rep-table">
                <thead><tr><th>Запит</th><th class="num">Разів</th><th class="num">Останній</th></tr></thead>
                <tbody>
                <?php if ($data['demand'] === []): ?><tr><td class="rep-empty" colspan="3">Поки немає.</td></tr><?php endif; ?>
                <?php foreach ($data['demand'] as $d): ?>
                <tr><td><?= $e($d['q']) ?></td><td class="num"><?= (int) $d['cnt'] ?></td><td class="num"><?= $e(date('d.m H:i', (int) strtotime($d['last_at']))) ?></td></tr>
                <?php endforeach; ?>
                </tbody>
            </table>
        </div>
    </main>
</body>
</html>
