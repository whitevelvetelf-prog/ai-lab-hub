<?php

declare(strict_types=1);

/**
 * AI LAB HUB — каталог AI-інструментів.
 *
 * Список продуктів завантажується з БД (лише status = 'published').
 *
 * Параметри:
 *   ?category={id}    — продукти цієї категорії (через product_categories);
 *   ?subcategory={id} — продукти цієї підкатегорії (через product_subcategories);
 *   ?search={текст}   — повнотекстова видача пошуку з шапки (Enter без
 *                       вибору підказки веде саме сюди, api-search.php
 *                       живить сам випадаючий список під час вводу).
 *
 * Категорія/підкатегорія — звичайний перегляд розділу, заголовок дорівнює
 * його назві. Пошук — окрема гілка нижче, заголовок містить сам запит.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/paw-icon.php';
require_once __DIR__ . '/../app/search.php';
require_once __DIR__ . '/../app/analytics.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

analytics_log_view($pdo, 'other');

$subcategoryId = (int) ($_GET['subcategory'] ?? 0);
$categoryId    = (int) ($_GET['category'] ?? 0);
$searchQuery   = trim((string) ($_GET['search'] ?? ''));
$isSearch      = mb_strlen($searchQuery) >= 2;

$pageHeading = t('catalog_default_title');
$backLink    = null;

if ($isSearch) {
    $pageHeading = sprintf(t('search_results_heading'), $searchQuery);
    $products = search_products_by_name($pdo, $searchQuery, 'id, name, short_description');
} elseif ($subcategoryId > 0) {
    $subStmt = $pdo->prepare("SELECT id, name, name_en, category_id FROM subcategories WHERE id = :id");
    $subStmt->execute([':id' => $subcategoryId]);
    $subcategory = $subStmt->fetch();

    if ($subcategory === false) {
        $pageHeading = t('catalog_subcategory_not_found');
        $products = [];
    } else {
        $pageHeading = localized_name($subcategory);
        $backLink = ['href' => 'category.php?id=' . (int) $subcategory['category_id'], 'label' => t('back_to_direction')];

        $stmt = $pdo->prepare(
            "SELECT p.id, p.name, p.short_description
             FROM products p
             JOIN product_subcategories ps ON ps.product_id = p.id
             WHERE ps.subcategory_id = :id AND p.status = 'published'
             ORDER BY p.id"
        );
        $stmt->execute([':id' => $subcategoryId]);
        $products = $stmt->fetchAll();
    }
} elseif ($categoryId > 0) {
    $catStmt = $pdo->prepare("SELECT id, name, name_en FROM categories WHERE id = :id");
    $catStmt->execute([':id' => $categoryId]);
    $category = $catStmt->fetch();

    if ($category === false) {
        $pageHeading = t('category_not_found');
        $products = [];
    } else {
        $pageHeading = localized_name($category);
        $backLink = ['href' => 'category.php?id=' . (int) $category['id'], 'label' => t('back_to_direction')];

        $stmt = $pdo->prepare(
            "SELECT p.id, p.name, p.short_description
             FROM products p
             JOIN product_categories pc ON pc.product_id = p.id
             WHERE pc.category_id = :id AND p.status = 'published'
             ORDER BY p.id"
        );
        $stmt->execute([':id' => $categoryId]);
        $products = $stmt->fetchAll();
    }
} else {
    $products = $pdo->query(
        "SELECT id, name, short_description
         FROM products
         WHERE status = 'published'
         ORDER BY id"
    )->fetchAll();
}

// Тарифні плани — для бейджа ціни на картці.
$plansByProduct = [];
foreach ($pdo->query("SELECT product_id, price, period FROM pricing_plans ORDER BY price ASC") as $plan) {
    $plansByProduct[(int) $plan['product_id']][] = $plan;
}

// Які продукти вже в добірці поточного користувача — для стану кнопки-лапки.
$savedIds = [];
if (auth_check()) {
    $savedStmt = $pdo->prepare('SELECT product_id FROM saved_products WHERE user_id = :uid');
    $savedStmt->execute([':uid' => auth_user_id()]);
    $savedIds = array_map('intval', $savedStmt->fetchAll(PDO::FETCH_COLUMN));
}

/** Бейдж ціни: [текст, чи безкоштовний]. */
function price_badge(array $plans): array
{
    $paid = array_filter($plans, static fn($p) => $p['period'] !== 'free' && (float) $p['price'] > 0);
    if ($paid === []) {
        return [t('price_free'), true];
    }
    usort($paid, static fn($a, $b) => (float) $a['price'] <=> (float) $b['price']);
    $cheapest = $paid[0];
    $periods = [
        'week' => '/' . t('unit_week'),
        'month' => '/' . t('unit_month'),
        'year' => '/' . t('unit_year'),
        'one_time' => ' ' . t('unit_one_time'),
    ];
    $price = rtrim(rtrim(number_format((float) $cheapest['price'], 2, '.', ''), '0'), '.');
    return [t('price_from') . ' $' . $price . ($periods[$cheapest['period']] ?? ''), false];
}

// Палітра квадратів-заглушок замість логотипів (за порядком продуктів).
// Тимчасово: просто колір, без тексту — поки продукт не отримає реальний
// логотип при доданні через CRM.
$cardColors = [
    'linear-gradient(135deg, #2116ad, #5b8cff)',
    'linear-gradient(135deg, #0f9d58, #34d399)',
    'linear-gradient(135deg, #db2777, #f472b6)',
    'linear-gradient(135deg, #d97706, #fbbf24)',
    'linear-gradient(135deg, #4f46e5, #818cf8)',
    'linear-gradient(135deg, #0891b2, #22d3ee)',
];

?>
<!DOCTYPE html>
<html lang="<?= htmlspecialchars(current_lang(), ENT_QUOTES) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — <?= htmlspecialchars($pageHeading, ENT_QUOTES) ?></title>
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

        .site-nav {
            margin-left: auto;
            display: flex;
            align-items: center;
            gap: 8px;
            flex-wrap: wrap;
        }

        .site-nav__link {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 9px 16px;
            border-radius: 999px;
            font-size: 0.9rem;
            font-weight: 600;
            text-decoration: none;
            color: var(--text-muted);
            transition: color 0.15s ease, background 0.15s ease;
        }

        .site-nav__link:hover {
            color: #ffffff;
            background: rgba(255, 255, 255, 0.08);
        }

        /* Заклик до дії — виділений пункт меню «Викликати Асистента» */
        .site-nav__link--cta {
            color: #00032c;
            background: linear-gradient(135deg, #5b8cff, #a5c0ff);
            box-shadow: 0 6px 18px rgba(91, 140, 255, 0.4);
        }

        .site-nav__link--cta:hover {
            color: #00032c;
            background: linear-gradient(135deg, #6f9bff, #b8ceff);
        }

        .site-nav__link--cta svg {
            width: 16px;
            height: 16px;
        }

        .page {
            max-width: 1080px;
            margin: 0 auto;
            padding: 24px 24px 72px;
        }

        .back-link {
            display: inline-block;
            margin: 0 0 20px;
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--text-muted);
            text-decoration: none;
        }

        .back-link:hover {
            color: #ffffff;
        }

        .catalog__title {
            margin: 0 0 32px;
            font-size: clamp(1.8rem, 5vw, 2.6rem);
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .catalog__empty {
            color: var(--text-muted);
        }

        .catalog__empty a {
            color: #bcd0ff;
        }

        /* Сітка: 3 / 2 / 1 колонки */
        .catalog-grid {
            display: grid;
            gap: 20px;
            grid-template-columns: repeat(3, 1fr);
        }

        @media (max-width: 900px) {
            .catalog-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 560px) {
            .catalog-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Картка продукту */
        .product-card {
            display: flex;
            flex-direction: column;
            padding: 22px;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            transition: transform 0.15s ease, border-color 0.15s ease;
        }

        .product-card:hover {
            transform: translateY(-3px);
            border-color: rgba(91, 140, 255, 0.5);
        }

        /* Тимчасовий квадрат-заглушка замість логотипа продукту */
        .product-card__logo {
            width: 52px;
            height: 52px;
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.35);
        }

        .product-card__name {
            margin: 16px 0 8px;
            font-size: 1.2rem;
            font-weight: 700;
        }

        .product-card__desc {
            margin: 0 0 18px;
            font-size: 0.95rem;
            color: var(--text-muted);
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .product-card__footer {
            margin-top: auto;
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 12px;
            flex-wrap: wrap;
        }

        .price-badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 999px;
            font-size: 0.82rem;
            font-weight: 600;
            letter-spacing: 0.02em;
            background: rgba(91, 140, 255, 0.2);
            border: 1px solid rgba(91, 140, 255, 0.5);
            white-space: nowrap;
        }

        .price-badge--free {
            background: rgba(52, 211, 153, 0.18);
            border-color: rgba(52, 211, 153, 0.5);
        }

        .btn {
            display: inline-block;
            padding: 9px 18px;
            border-radius: 999px;
            font-size: 0.9rem;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            border: 1px solid rgba(255, 255, 255, 0.4);
            color: #ffffff;
            background: transparent;
            white-space: nowrap;
            transition: background 0.15s ease;
        }

        .btn:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        @media (max-width: 600px) {
            .site-header {
                justify-content: center;
                padding: 16px;
                flex-wrap: wrap;
                gap: 12px;
            }
        }
    </style>
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/../app/site-header.php'; ?>

    <div class="page">
        <?php if ($backLink !== null): ?>
        <a class="back-link" href="<?= htmlspecialchars($backLink['href'], ENT_QUOTES) ?>"><?= htmlspecialchars($backLink['label'], ENT_QUOTES) ?></a>
        <?php endif; ?>

        <h1 class="catalog__title"><?= htmlspecialchars($pageHeading, ENT_QUOTES) ?></h1>

        <?php
        // Реклама лише на сторінці підкатегорії (не пошук, не «всі продукти»).
        if (!$isSearch && !empty($subcategory)) {
            $zoneId = 2; /* «Сторінка підкатегорії - верх» */
            $categoryId = (int) $subcategory['category_id'];
            $subcategoryId = (int) $subcategory['id'];
            include __DIR__ . '/../app/ad-banner.php';
        }
        ?>

        <?php if ($products === [] && $isSearch): ?>
        <p class="catalog__empty">
            <?= htmlspecialchars(t('search_no_results'), ENT_QUOTES) ?><br>
            <?= htmlspecialchars(t('search_no_results_hint'), ENT_QUOTES) ?>
            <a href="eli.php"><?= htmlspecialchars(t('search_ask_eli_link'), ENT_QUOTES) ?></a>.
        </p>
        <?php elseif ($products === []): ?>
        <p class="catalog__empty"><?= htmlspecialchars(t('catalog_empty'), ENT_QUOTES) ?></p>
        <?php else: ?>
        <div class="catalog-grid">
            <?php foreach ($products as $i => $product): ?>
                <?php
                $pid = (int) $product['id'];
                [$priceText, $isFree] = price_badge($plansByProduct[$pid] ?? []);
                $color = $cardColors[$i % count($cardColors)];
                $isSaved = in_array($pid, $savedIds, true);
                $saveLabel = $isSaved ? t('saved_btn_unsave') : t('saved_btn_save');
                ?>
                <article class="product-card">
                    <button type="button"
                            class="save-btn<?= $isSaved ? ' is-saved' : '' ?>"
                            data-product-id="<?= $pid ?>"
                            data-saved="<?= $isSaved ? '1' : '0' ?>"
                            aria-pressed="<?= $isSaved ? 'true' : 'false' ?>"
                            aria-label="<?= htmlspecialchars($saveLabel, ENT_QUOTES) ?>"
                            title="<?= htmlspecialchars($saveLabel, ENT_QUOTES) ?>"><?= paw_icon_use() ?></button>
                    <div class="product-card__logo" style="background: <?= htmlspecialchars($color, ENT_QUOTES) ?>;"></div>
                    <h2 class="product-card__name"><?= htmlspecialchars($product['name'], ENT_QUOTES) ?></h2>
                    <p class="product-card__desc"><?= htmlspecialchars((string) $product['short_description'], ENT_QUOTES) ?></p>
                    <div class="product-card__footer">
                        <span class="price-badge<?= $isFree ? ' price-badge--free' : '' ?>">
                            <?= htmlspecialchars($priceText, ENT_QUOTES) ?>
                        </span>
                        <a class="btn" href="product.php?id=<?= $pid ?>"><?= htmlspecialchars(t('btn_details'), ENT_QUOTES) ?></a>
                    </div>
                </article>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>
    </div>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
