<?php

declare(strict_types=1);

/**
 * AI LAB HUB — CRM: список усіх AI-продуктів.
 *
 * Доступ лише для ролей employee / admin (гість і звичайний user
 * перенаправляються в кабінет).
 *
 * Порядок стовпців зліва направо:
 *   1. Статус (бейдж + тултип-пояснення)
 *   2–14. Поля картки продукту в тому ж порядку, що й у формі
 *         crm-add-product.php: назва, логотип, офіційний сайт,
 *         короткий опис, категорія, підкатегорія, модель монетизації,
 *         повний опис, основні функції, для кого призначений,
 *         ціна / тарифні плани, платформа, рівень навичок
 *   15. Статус партнерства (лише admin)
 *   16. Хто додав
 *   17. Оновлено
 *   18. Кнопка «Редагувати» (завжди остання)
 *
 * Довгі тексти скорочені до ~50 символів, повний текст — у title при
 * наведенні. Багато стовпців → таблиця з горизонтальною прокруткою
 * (.table-wrap). Форму редагування буде додано окремо (crm-edit-product.php).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';

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

/** Пояснення статусу — показуємо в title бейджа при наведенні. */
$statusHints = [
    'none'        => '«Ніякий» — продукт не опубліковано і не в роботі',
    'in_progress' => 'Продукт у підготовці, ще не опублікований',
    'published'   => 'Продукт опубліковано, він видимий користувачам',
];

$partnershipLabels = [
    'found'                => 'Знайдено',
    'pending_registration' => 'Очікує реєстрації',
    'partner_connected'    => 'Партнерку підключено',
    'no_partnership'       => 'Без партнерки',
];

$platformLabels = ['web' => 'Веб', 'mobile' => 'Мобільний', 'desktop' => 'Десктоп'];

$skillLabels = [
    'none'   => 'Без навичок',
    'basic'  => 'Базові знання',
    'course' => 'Спеціальне навчання',
];

/**
 * Готує довгий текст до показу в комірці: прибирає переноси рядків і
 * зайві пробіли, ріже до $limit символів.
 *
 * @return array{0:string,1:string,2:bool} [превʼю, повний текст, чи скорочено]
 */
function short_text(?string $text, int $limit = 50): array
{
    $full = trim((string) preg_replace('/\s+/u', ' ', (string) $text));
    if ($full === '') {
        return ['—', '', false];
    }
    if (mb_strlen($full) <= $limit) {
        return [$full, $full, false];
    }
    return [mb_substr($full, 0, $limit) . '…', $full, true];
}

/** HTML комірки зі скороченим текстом; повний текст — у title при наведенні. */
function text_cell(?string $text, int $limit = 50): string
{
    [$preview, $full, $cut] = short_text($text, $limit);
    if ($full === '') {
        return '<span class="table__muted">—</span>';
    }
    if ($cut) {
        return '<span class="table__clip" title="' . e($full) . '">' . e($preview) . '</span>';
    }
    return e($preview);
}

/** Українська форма множини: 1 план / 2 плани / 5 планів. */
function plural_uk(int $n, string $one, string $few, string $many): string
{
    $mod10 = $n % 10;
    $mod100 = $n % 100;
    if ($mod10 === 1 && $mod100 !== 11) {
        return $one;
    }
    if ($mod10 >= 2 && $mod10 <= 4 && ($mod100 < 12 || $mod100 > 14)) {
        return $few;
    }
    return $many;
}

/**
 * Модель монетизації та короткий підсумок тарифів за списком планів.
 *
 * @param list<array{price:mixed,period:string}> $plans
 * @return array{model:string,plans:string}
 */
function pricing_summary(array $plans): array
{
    if ($plans === []) {
        return ['model' => '—', 'plans' => '—'];
    }

    $paid = array_values(array_filter(
        $plans,
        static fn(array $p): bool => $p['period'] !== 'free' && (float) $p['price'] > 0
    ));
    $hasFree = count($paid) < count($plans);

    if ($paid === []) {
        $model = 'Безкоштовно';
    } elseif ($hasFree) {
        $model = 'Freemium';
    } else {
        $model = 'Платно';
    }

    $n = count($plans);
    $summary = $n . ' ' . plural_uk($n, 'план', 'плани', 'планів');

    if ($paid !== []) {
        usort($paid, static fn(array $a, array $b): int => (float) $a['price'] <=> (float) $b['price']);
        $periods = ['week' => '/тиж', 'month' => '/міс', 'year' => '/рік', 'one_time' => ' разово'];
        $cheap = $paid[0];
        $price = rtrim(rtrim(number_format((float) $cheap['price'], 2, '.', ''), '0'), '.');
        $summary .= ' · від $' . $price . ($periods[$cheap['period']] ?? '');
    } else {
        $summary .= ' · безкоштовно';
    }

    return ['model' => $model, 'plans' => $summary];
}

/** Людський підпис платформ (SET web,mobile,desktop). */
function platform_text(?string $platform, array $map): string
{
    $platform = trim((string) $platform);
    if ($platform === '') {
        return '—';
    }
    $out = [];
    foreach (explode(',', $platform) as $p) {
        $p = trim($p);
        if ($p !== '') {
            $out[] = $map[$p] ?? $p;
        }
    }
    return $out === [] ? '—' : implode(' / ', $out);
}

/** Абсолютне посилання на офіційний сайт (додає https:// за потреби). */
function external_href(?string $url): string
{
    $url = trim((string) $url);
    if ($url === '') {
        return '';
    }
    return preg_match('~^https?://~i', $url) === 1 ? $url : 'https://' . $url;
}

/**
 * HTML комірки «Хто додав».
 *   - є employee_number   → «Працівник №N», у title повне «Прізвище Ім'я»;
 *   - інакше є імʼя автора → імʼя як є (напр. admin без номера);
 *   - автора немає         → «—».
 */
function created_by_cell(array $row): string
{
    if ($row['created_by_name'] === null) {
        return '<span class="table__muted">—</span>';
    }

    $number = $row['created_by_employee_number'];
    if ($number !== null && $number !== '') {
        $fullName = trim(
            (string) ($row['created_by_last_name'] ?? '') . ' '
            . (string) ($row['created_by_first_name'] ?? '')
        );
        $title = $fullName !== '' ? $fullName : (string) $row['created_by_name'];
        return '<span class="table__clip" title="' . e($title) . '">Працівник №'
            . (int) $number . '</span>';
    }

    return e($row['created_by_name']);
}

$products = $pdo->query(
    "SELECT
        p.id,
        p.name,
        p.logo_url,
        p.official_url,
        p.short_description,
        p.full_description,
        p.main_features,
        p.target_audience,
        p.platform,
        p.skill_level,
        p.status,
        p.partnership_status,
        p.created_at,
        p.updated_at,
        u.name AS created_by_name,
        u.employee_number AS created_by_employee_number,
        u.first_name AS created_by_first_name,
        u.last_name AS created_by_last_name,
        (SELECT GROUP_CONCAT(c.name ORDER BY c.id SEPARATOR ', ')
           FROM product_categories pc
           JOIN categories c ON c.id = pc.category_id
          WHERE pc.product_id = p.id) AS categories_list,
        (SELECT GROUP_CONCAT(s.name ORDER BY s.id SEPARATOR ', ')
           FROM product_subcategories ps
           JOIN subcategories s ON s.id = ps.subcategory_id
          WHERE ps.product_id = p.id) AS subcategories_list
     FROM products p
     LEFT JOIN users u ON u.id = p.created_by
     ORDER BY p.updated_at DESC, p.id DESC"
)->fetchAll();

// Тарифні плани всіх продуктів — одним запитом, згруповані за product_id.
$plansByProduct = [];
foreach ($pdo->query("SELECT product_id, price, period FROM pricing_plans")->fetchAll() as $pl) {
    $plansByProduct[(int) $pl['product_id']][] = $pl;
}

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
            max-width: 1400px;
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

        /* Таблиця. Стовпців багато — контейнер прокручується по горизонталі
           на вужчих екранах; min-width не дає колонкам сплюснутись. */
        .table-wrap {
            overflow-x: auto;
            -webkit-overflow-scrolling: touch;
            border: 1px solid var(--card-border);
            border-radius: 16px;
            background: var(--card-bg);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .table {
            width: 100%;
            min-width: 1700px;
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

        .badge[title] {
            cursor: help;
        }

        /* Мініатюра логотипа продукту */
        .table__logo {
            width: 40px;
            height: 40px;
            object-fit: contain;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.06);
            display: block;
        }

        .table__logo--empty {
            display: flex;
            align-items: center;
            justify-content: center;
            color: rgba(255, 255, 255, 0.4);
        }

        .table__link {
            color: #bcd0ff;
            text-decoration: none;
            white-space: nowrap;
        }

        .table__link:hover {
            text-decoration: underline;
        }

        /* Скорочений довгий текст: пунктирне підкреслення + повний текст у title */
        .table__clip {
            border-bottom: 1px dotted rgba(255, 255, 255, 0.45);
            cursor: help;
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
                        <th>Статус</th>
                        <th>Назва продукту</th>
                        <th>Логотип</th>
                        <th>Офіційний сайт</th>
                        <th>Короткий опис</th>
                        <th>Категорія</th>
                        <th>Підкатегорія</th>
                        <th>Модель монетизації</th>
                        <th>Повний опис</th>
                        <th>Основні функції</th>
                        <th>Для кого призначений</th>
                        <th>Ціна / тарифні плани</th>
                        <th>Платформа</th>
                        <th>Рівень навичок</th>
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
                            <td class="empty-state" colspan="<?= $isAdmin ? 18 : 17 ?>">
                                Ще немає жодного продукту.
                                <a href="crm-add-product.php">Додати перший</a>.
                            </td>
                        </tr>
                    <?php else: ?>
                        <?php foreach ($products as $row): ?>
                            <?php
                            $pid = (int) $row['id'];
                            $status = (string) $row['status'];
                            $statusLabel = $statusLabels[$status] ?? $status;
                            $statusHint = $statusHints[$status] ?? '';
                            $pricing = pricing_summary($plansByProduct[$pid] ?? []);
                            $officialHref = external_href($row['official_url']);
                            $updated = strtotime((string) $row['updated_at']);
                            ?>
                            <tr>
                                <td>
                                    <span class="badge badge--<?= e($status) ?>"<?= $statusHint !== '' ? ' title="' . e($statusHint) . '"' : '' ?>><?= e($statusLabel) ?></span>
                                </td>
                                <td class="table__nowrap">
                                    <a class="table__name" href="crm-edit-product.php?id=<?= $pid ?>"><?= e($row['name']) ?></a>
                                    <span class="table__id">#<?= $pid ?></span>
                                </td>
                                <td>
                                    <?php if ((string) $row['logo_url'] !== ''): ?>
                                        <img class="table__logo" src="<?= e($row['logo_url']) ?>" alt="" loading="lazy">
                                    <?php else: ?>
                                        <span class="table__logo table__logo--empty">—</span>
                                    <?php endif; ?>
                                </td>
                                <td>
                                    <?php if ($officialHref !== ''): ?>
                                        <a class="table__link" href="<?= e($officialHref) ?>" target="_blank" rel="noopener noreferrer" title="<?= e($row['official_url']) ?>">Відкрити ↗</a>
                                    <?php else: ?>
                                        <span class="table__muted">—</span>
                                    <?php endif; ?>
                                </td>
                                <td><?= text_cell($row['short_description']) ?></td>
                                <td><?= text_cell($row['categories_list'], 40) ?></td>
                                <td><?= text_cell($row['subcategories_list'], 40) ?></td>
                                <td class="table__nowrap"><?= e($pricing['model']) ?></td>
                                <td><?= text_cell($row['full_description']) ?></td>
                                <td><?= text_cell($row['main_features']) ?></td>
                                <td><?= text_cell($row['target_audience']) ?></td>
                                <td class="table__nowrap"><?= e($pricing['plans']) ?></td>
                                <td class="table__nowrap"><?= e(platform_text($row['platform'], $platformLabels)) ?></td>
                                <td class="table__nowrap"><?= e($skillLabels[$row['skill_level']] ?? $row['skill_level']) ?></td>
                                <?php if ($isAdmin): ?>
                                <td class="table__muted table__nowrap">
                                    <?= e($partnershipLabels[$row['partnership_status']] ?? $row['partnership_status']) ?>
                                </td>
                                <?php endif; ?>
                                <td class="table__nowrap"><?= created_by_cell($row) ?></td>
                                <td class="table__muted table__nowrap">
                                    <?= $updated ? e(date('d.m.Y H:i', $updated)) : '—' ?>
                                </td>
                                <td class="table__nowrap">
                                    <a class="btn btn--ghost btn--sm" href="crm-edit-product.php?id=<?= $pid ?>">Редагувати</a>
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
