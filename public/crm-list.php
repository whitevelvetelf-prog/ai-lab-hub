<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CRM: список усіх AI-продуктів.
 *
 * Доступ лише для ролей employee / admin (гість і звичайний user
 * перенаправляються в кабінет).
 *
 * Стовпці: назва, перша прив'язана категорія, статус (кольоровий бейдж),
 * статус партнерства (лише для admin), хто додав (users.name за
 * products.created_by), дата оновлення, посилання «Редагувати».
 * Форму редагування буде додано окремо (crm-edit-product.php).
 */

require_once __DIR__ . '/../app/auth.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

if (!auth_has_role('employee', 'admin')) {
    header('Location: account.php');
    exit;
}

/** Статус партнерства бачить лише admin. */
$isAdmin = auth_role() === 'admin';

/** Екранування для HTML. */
function e(mixed $value): string
{
    return htmlspecialchars((string) $value, ENT_QUOTES);
}

$statusLabels = [
    'none'        => 'Ніякий',
    'in_progress' => 'В роботі',
    'published'   => 'Опубліковано',
];

$partnershipLabels = [
    'found'                => 'Знайдено',
    'pending_registration' => 'Очікує реєстрації',
    'partner_connected'    => 'Партнерку підключено',
    'no_partnership'       => 'Без партнерки',
];

$products = $pdo->query(
    "SELECT
        p.id,
        p.name,
        p.status,
        p.partnership_status,
        p.updated_at,
        u.name AS created_by_name,
        (SELECT c.name
           FROM product_categories pc
           JOIN categories c ON c.id = pc.category_id
          WHERE pc.product_id = p.id
          ORDER BY c.id
          LIMIT 1) AS category_name
     FROM products p
     LEFT JOIN users u ON u.id = p.created_by
     ORDER BY p.updated_at DESC, p.id DESC"
)->fetchAll();

// --- Підсумок за статусами -------------------------------------------------
$counts = ['none' => 0, 'in_progress' => 0, 'published' => 0];
foreach ($products as $row) {
    $st = (string) $row['status'];
    if (array_key_exists($st, $counts)) {
        $counts[$st]++;
    }
}
$total = count($products);

?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — CRM: список продуктів</title>
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
            margin: 0 0 24px;
            color: var(--text-muted);
        }

        /* Підсумок за статусами */
        .summary {
            display: flex;
            flex-wrap: wrap;
            gap: 8px 22px;
            margin: 0 0 24px;
            padding: 14px 18px;
            border: 1px solid var(--card-border);
            border-radius: 12px;
            background: var(--card-bg);
            font-size: 0.95rem;
        }

        .summary strong {
            font-weight: 800;
        }

        /* Таблиця */
        .table-wrap {
            overflow-x: auto;
            border: 1px solid var(--card-border);
            border-radius: 16px;
            background: var(--card-bg);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.92rem;
        }

        .table th,
        .table td {
            padding: 12px 16px;
            text-align: left;
            border-bottom: 1px solid var(--card-border);
            vertical-align: middle;
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

        .table__id {
            color: rgba(255, 255, 255, 0.4);
            font-size: 0.82rem;
        }

        .table__muted {
            color: var(--text-muted);
        }

        .table__nowrap {
            white-space: nowrap;
        }

        /* Кольорові бейджі статусу */
        .badge {
            display: inline-block;
            padding: 3px 10px;
            border-radius: 999px;
            font-size: 0.74rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.04em;
            white-space: nowrap;
        }

        .badge--none {
            color: #d7dced;
            background: rgba(255, 255, 255, 0.12);
            border: 1px solid rgba(255, 255, 255, 0.25);
        }

        .badge--in_progress {
            color: #fcd34d;
            background: rgba(251, 191, 36, 0.15);
            border: 1px solid rgba(251, 191, 36, 0.5);
        }

        .badge--published {
            color: #6ee7b7;
            background: rgba(52, 211, 153, 0.16);
            border: 1px solid rgba(52, 211, 153, 0.5);
        }

        .empty-state {
            padding: 28px;
            text-align: center;
            color: var(--text-muted);
        }

        /* Кнопки */
        .btn {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 999px;
            font-size: 1rem;
            font-weight: 600;
            font-family: inherit;
            text-decoration: none;
            cursor: pointer;
            border: 1px solid transparent;
            transition: transform 0.15s ease, background 0.15s ease, border-color 0.15s ease;
        }

        .btn:active {
            transform: translateY(1px);
        }

        .btn--primary {
            background: #ffffff;
            color: #00032c;
        }

        .btn--primary:hover {
            background: rgba(255, 255, 255, 0.88);
        }

        .btn--ghost {
            background: transparent;
            color: #ffffff;
            border-color: rgba(255, 255, 255, 0.4);
        }

        .btn--ghost:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .btn--sm {
            padding: 9px 18px;
            font-size: 0.9rem;
        }

        .toolbar {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-bottom: 24px;
        }
    </style>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="assets/images/logo.png" alt="AI LAB HUB">
        </a>
    </header>

    <div class="page">
        <a class="back-link" href="account.php">← До кабінету</a>

        <h1 class="page__title">CRM — усі продукти</h1>
        <p class="page__subtitle">Список усіх AI-продуктів у базі.</p>

        <div class="toolbar">
            <a class="btn btn--primary btn--sm" href="crm-add-product.php">+ Додати продукт</a>
        </div>

        <div class="summary">
            <span>Всього: <strong><?= (int) $total ?></strong></span>
            <span>Опубліковано: <strong><?= (int) $counts['published'] ?></strong></span>
            <span>В роботі: <strong><?= (int) $counts['in_progress'] ?></strong></span>
            <span>Ніякий: <strong><?= (int) $counts['none'] ?></strong></span>
        </div>

        <div class="table-wrap">
            <table class="table">
                <thead>
                    <tr>
                        <th>Назва продукту</th>
                        <th>Категорія</th>
                        <th>Статус</th>
                        <?php if ($isAdmin): ?>
                        <th>Статус партнерства</th>
                        <?php endif; ?>
                        <th>Хто додав</th>
                        <th>Оновлено</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <?php if ($products === []): ?>
                        <tr>
                            <td class="empty-state" colspan="<?= $isAdmin ? 7 : 6 ?>">
                                Ще немає жодного продукту.
                                <a href="crm-add-product.php">Додати перший</a>.
                            </td>
                        </tr>
                    <?php else: ?>
                        <?php foreach ($products as $row): ?>
                            <?php
                            $status = (string) $row['status'];
                            $statusLabel = $statusLabels[$status] ?? $status;
                            $updated = strtotime((string) $row['updated_at']);
                            ?>
                            <tr>
                                <td>
                                    <a class="table__name" href="crm-edit-product.php?id=<?= (int) $row['id'] ?>">
                                        <?= e($row['name']) ?>
                                    </a>
                                    <span class="table__id">#<?= (int) $row['id'] ?></span>
                                </td>
                                <td class="<?= $row['category_name'] === null ? 'table__muted' : '' ?>">
                                    <?= $row['category_name'] !== null ? e($row['category_name']) : '—' ?>
                                </td>
                                <td>
                                    <span class="badge badge--<?= e($status) ?>"><?= e($statusLabel) ?></span>
                                </td>
                                <?php if ($isAdmin): ?>
                                <td class="table__muted">
                                    <?= e($partnershipLabels[$row['partnership_status']] ?? $row['partnership_status']) ?>
                                </td>
                                <?php endif; ?>
                                <td class="<?= $row['created_by_name'] === null ? 'table__muted' : '' ?>">
                                    <?= $row['created_by_name'] !== null ? e($row['created_by_name']) : '—' ?>
                                </td>
                                <td class="table__muted table__nowrap">
                                    <?= $updated ? e(date('d.m.Y H:i', $updated)) : '—' ?>
                                </td>
                                <td class="table__nowrap">
                                    <a class="btn btn--ghost btn--sm" href="crm-edit-product.php?id=<?= (int) $row['id'] ?>">Редагувати</a>
                                </td>
                            </tr>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
