<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CRM Marketplace: список пропозицій («Готові рішення»).
 *
 * Лише employee / admin. Колонки: Статус (першим), Назва, Категорії, Тип видачі, Продавець,
 * Отримано (claims_count), Хто додав, Оновлено, Редагувати. Фільтри: статус, категорія, пошук за назвою.
 * Створення/редагування — mp-add-offer.php. Публічної частини поки немає.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/marketplace.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

mp_require_staff();

const MP_LIST_LIMIT = 300;

$categories = mp_categories($pdo);
$catIds = array_column($categories, 'id');
$statusLabels = mp_status_labels();

$fStatus = is_string($_GET['status'] ?? null) ? (string) $_GET['status'] : '';
$fCat = (int) ($_GET['category'] ?? 0);
$fQ = is_string($_GET['q'] ?? null) ? trim((string) $_GET['q']) : '';
if (!isset($statusLabels[$fStatus])) {
    $fStatus = '';
}
if (!in_array($fCat, $catIds, true)) {
    $fCat = 0;
}

$where = ["l.section = 'solution'"];
$params = [];
if ($fStatus !== '') {
    $where[] = 'l.status = :status';
    $params[':status'] = $fStatus;
}
if ($fCat > 0) {
    $where[] = 'EXISTS (SELECT 1 FROM mp_listing_categories x WHERE x.listing_id = l.id AND x.category_id = :cat)';
    $params[':cat'] = $fCat;
}
if ($fQ !== '') {
    // % і _ у пошуку — звичайні символи, не шаблони
    $where[] = "t.title LIKE :q ESCAPE '\\\\'";
    $params[':q'] = '%' . addcslashes($fQ, '%_\\') . '%';
}
$whereSql = implode(' AND ', $where);

$stmt = $pdo->prepare(
    "SELECT l.id, l.status, l.delivery_type, l.claims_count, l.updated_at,
            t.title,
            s.display_name AS seller_name,
            u.name AS creator_name, u.employee_number AS creator_number,
            (SELECT GROUP_CONCAT(COALESCE(ct.name, c.slug) ORDER BY c.sort_order, c.id SEPARATOR ', ')
               FROM mp_listing_categories lc
               JOIN mp_categories c ON c.id = lc.category_id
               LEFT JOIN mp_category_translations ct ON ct.category_id = c.id AND ct.lang = 'uk'
              WHERE lc.listing_id = l.id) AS categories_list
     FROM mp_listings l
     LEFT JOIN mp_listing_translations t ON t.listing_id = l.id AND t.lang = 'uk'
     LEFT JOIN mp_sellers s ON s.id = l.seller_id
     LEFT JOIN users u ON u.id = l.created_by
     WHERE $whereSql
     ORDER BY l.updated_at DESC, l.id DESC
     LIMIT " . (MP_LIST_LIMIT + 1)
);
$stmt->execute($params);
$rows = $stmt->fetchAll(PDO::FETCH_ASSOC);
$truncated = count($rows) > MP_LIST_LIMIT;
$rows = array_slice($rows, 0, MP_LIST_LIMIT);

// Підсумок за статусами (без фільтрів — загальна картина)
$counts = array_fill_keys(array_keys($statusLabels), 0);
foreach ($pdo->query("SELECT status, COUNT(*) c FROM mp_listings WHERE section = 'solution' GROUP BY status")->fetchAll(PDO::FETCH_ASSOC) as $r) {
    $counts[(string) $r['status']] = (int) $r['c'];
}
$total = array_sum($counts);
$deliveryLabels = mp_delivery_labels();
?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — Marketplace: пропозиції</title>
    <link rel="stylesheet" href="/assets/css/crm-ads.css">
    <link rel="stylesheet" href="/assets/css/mp-crm.css">
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="/logo.png" alt="AI LAB HUB">
        </a>
    </header>

    <div class="page page--wide">
        <a class="back-link" href="account.php">← До кабінету</a>

        <h1 class="page__title">Marketplace — пропозиції</h1>
        <p class="page__subtitle">Безкоштовні «Готові рішення». Внутрішня CRM, публічної частини ще немає.</p>

        <div class="toolbar">
            <a class="btn btn--primary btn--sm" href="mp-add-offer.php">+ Нова пропозиція</a>
        </div>

        <div class="summary">
            <span>Всього: <strong><?= (int) $total ?></strong></span>
            <?php foreach ($statusLabels as $key => $label): ?>
                <?php if ($counts[$key] > 0 || in_array($key, ['draft', 'published', 'archived'], true)): ?>
                    <span><?= mp_e($label) ?>: <strong><?= (int) $counts[$key] ?></strong></span>
                <?php endif; ?>
            <?php endforeach; ?>
        </div>

        <form class="filters" method="get" action="mp-list.php">
            <div class="field">
                <label class="field__label" for="f_status">Статус</label>
                <select class="select" id="f_status" name="status">
                    <option value="">Усі</option>
                    <?php foreach ($statusLabels as $key => $label): ?>
                        <option value="<?= mp_e($key) ?>"<?= $fStatus === $key ? ' selected' : '' ?>><?= mp_e($label) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="field">
                <label class="field__label" for="f_cat">Категорія</label>
                <select class="select" id="f_cat" name="category">
                    <option value="0">Усі</option>
                    <?php foreach ($categories as $c): ?>
                        <option value="<?= (int) $c['id'] ?>"<?= $fCat === $c['id'] ? ' selected' : '' ?>><?= mp_e($c['name']) ?></option>
                    <?php endforeach; ?>
                </select>
            </div>
            <div class="field field--grow">
                <label class="field__label" for="f_q">Пошук за назвою</label>
                <input class="input" type="search" id="f_q" name="q" value="<?= mp_e($fQ) ?>" placeholder="Назва пропозиції…">
            </div>
            <div class="form-actions" style="margin:0;">
                <button type="submit" class="btn btn--primary btn--sm">Застосувати</button>
                <?php if ($fStatus !== '' || $fCat > 0 || $fQ !== ''): ?>
                    <a class="btn btn--ghost btn--sm" href="mp-list.php">Скинути</a>
                <?php endif; ?>
            </div>
        </form>

        <div class="table-wrap">
            <table class="table table--mp">
                <thead>
                    <tr>
                        <th>Статус</th>
                        <th>Назва</th>
                        <th>Категорії</th>
                        <th>Тип видачі</th>
                        <th>Продавець</th>
                        <th class="table__num">Отримано</th>
                        <th>Хто додав</th>
                        <th>Оновлено</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <?php if ($rows === []): ?>
                        <tr>
                            <td class="empty-state" colspan="9">
                                <?= ($fStatus !== '' || $fCat > 0 || $fQ !== '') ? 'За цими фільтрами нічого не знайдено.' : 'Ще немає жодної пропозиції.' ?>
                                <a href="mp-add-offer.php">Створити пропозицію</a>.
                            </td>
                        </tr>
                    <?php else: ?>
                        <?php foreach ($rows as $r): ?>
                            <?php
                            $id = (int) $r['id'];
                            $status = (string) $r['status'];
                            $updated = strtotime((string) $r['updated_at']);
                            ?>
                            <tr>
                                <td><span class="badge badge--<?= mp_e($status) ?>"><?= mp_e($statusLabels[$status] ?? $status) ?></span></td>
                                <td class="table__nowrap">
                                    <a class="table__name" href="mp-add-offer.php?id=<?= $id ?>"><?= mp_e($r['title'] ?? '(без назви)') ?></a>
                                    <span class="table__id">#<?= $id ?></span>
                                </td>
                                <td class="cell-clip"><?= $r['categories_list'] !== null && $r['categories_list'] !== '' ? mp_e($r['categories_list']) : '<span class="table__muted">—</span>' ?></td>
                                <td class="table__nowrap"><?= mp_e($deliveryLabels[$r['delivery_type']] ?? $r['delivery_type']) ?></td>
                                <td class="table__nowrap"><?= mp_e($r['seller_name'] ?? '—') ?></td>
                                <td class="table__num"><?= (int) $r['claims_count'] ?></td>
                                <td class="table__nowrap"><?= mp_e(mp_user_label($r['creator_name'], $r['creator_number'])) ?></td>
                                <td class="table__nowrap table__muted"><?= $updated ? mp_e(date('d.m.Y H:i', $updated)) : '—' ?></td>
                                <td class="table__nowrap">
                                    <a class="btn btn--ghost btn--sm" href="mp-add-offer.php?id=<?= $id ?>">Редагувати</a>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
        <?php if ($truncated): ?>
            <p class="field__hint" style="margin-top:12px;">Показано перші <?= MP_LIST_LIMIT ?> записів — уточніть фільтри.</p>
        <?php endif; ?>
    </div>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
