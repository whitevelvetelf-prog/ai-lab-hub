<?php

declare(strict_types=1);

/**
 * AI LAB HUB — каталог AI-інструментів.
 *
 * Список продуктів завантажується з БД (лише status = 'published').
 *
 * Параметри:
 *   ?category={id}    — продукти цієї категорії (через product_categories);
 *   ?subcategory={id} — продукти цієї підкатегорії (через product_subcategories).
 *
 * Це не пошук і не фільтрація за запитом користувача — це звичайний
 * перегляд списку продуктів конкретного розділу, тож заголовок сторінки
 * дорівнює назві категорії / підкатегорії.
 */

require_once __DIR__ . '/../app/auth.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$subcategoryId = (int) ($_GET['subcategory'] ?? 0);
$categoryId    = (int) ($_GET['category'] ?? 0);

$pageHeading = 'Каталог AI-інструментів';
$backLink    = null;

if ($subcategoryId > 0) {
    $subStmt = $pdo->prepare("SELECT id, name, category_id FROM subcategories WHERE id = :id");
    $subStmt->execute([':id' => $subcategoryId]);
    $subcategory = $subStmt->fetch();

    if ($subcategory === false) {
        $pageHeading = 'Підкатегорію не знайдено';
        $products = [];
    } else {
        $pageHeading = (string) $subcategory['name'];
        $backLink = ['href' => 'category.php?id=' . (int) $subcategory['category_id'], 'label' => '← До напряму'];

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
    $catStmt = $pdo->prepare("SELECT id, name FROM categories WHERE id = :id");
    $catStmt->execute([':id' => $categoryId]);
    $category = $catStmt->fetch();

    if ($category === false) {
        $pageHeading = 'Категорію не знайдено';
        $products = [];
    } else {
        $pageHeading = (string) $category['name'];
        $backLink = ['href' => 'category.php?id=' . (int) $category['id'], 'label' => '← До напряму'];

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

/** Бейдж ціни: [текст, чи безкоштовний]. */
function price_badge(array $plans): array
{
    $paid = array_filter($plans, static fn($p) => $p['period'] !== 'free' && (float) $p['price'] > 0);
    if ($paid === []) {
        return ['Безкоштовно', true];
    }
    usort($paid, static fn($a, $b) => (float) $a['price'] <=> (float) $b['price']);
    $cheapest = $paid[0];
    $periods = ['week' => '/тиж', 'month' => '/міс', 'year' => '/рік', 'one_time' => ' разово'];
    $price = rtrim(rtrim(number_format((float) $cheapest['price'], 2, '.', ''), '0'), '.');
    return ['Від $' . $price . ($periods[$cheapest['period']] ?? ''), false];
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
<html lang="uk">
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

        .site-header__name {
            font-size: clamp(0.95rem, 3.5vw, 1.15rem);
            font-weight: 800;
            letter-spacing: 0.04em;
            line-height: 1;
            white-space: nowrap;
            color: #ffffff;
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
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="assets/images/logo.png" alt="AI LAB HUB">
            <span class="site-header__name">AI LAB HUB</span>
        </a>
        <nav class="site-nav">
            <a class="site-nav__link" href="index.php">Головна</a>
            <?php if (auth_check()): ?>
            <a class="site-nav__link" href="account.php">Кабінет</a>
            <?php else: ?>
            <a class="site-nav__link" href="login.php">Увійти</a>
            <?php endif; ?>
            <a class="site-nav__link site-nav__link--cta" href="eli.php">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9.937 15.5A2 2 0 0 0 8.5 14.063l-6.135-1.582a.5.5 0 0 1 0-.962L8.5 9.936A2 2 0 0 0 9.937 8.5l1.582-6.135a.5.5 0 0 1 .962 0L14.063 8.5A2 2 0 0 0 15.5 9.937l6.135 1.581a.5.5 0 0 1 0 .964L15.5 14.063a2 2 0 0 0-1.437 1.437l-1.582 6.135a.5.5 0 0 1-.962 0z"/><path d="M20 3v4"/><path d="M22 5h-4"/><path d="M4 17v2"/><path d="M6 18H2"/></svg>
                Викликати Асистента
            </a>
        </nav>
    </header>

    <div class="page">
        <?php if ($backLink !== null): ?>
        <a class="back-link" href="<?= htmlspecialchars($backLink['href'], ENT_QUOTES) ?>"><?= htmlspecialchars($backLink['label'], ENT_QUOTES) ?></a>
        <?php endif; ?>

        <h1 class="catalog__title"><?= htmlspecialchars($pageHeading, ENT_QUOTES) ?></h1>

        <?php if ($products === []): ?>
        <p class="catalog__empty">У цьому розділі поки немає опублікованих продуктів.</p>
        <?php else: ?>
        <div class="catalog-grid">
            <?php foreach ($products as $i => $product): ?>
                <?php
                $pid = (int) $product['id'];
                [$priceText, $isFree] = price_badge($plansByProduct[$pid] ?? []);
                $color = $cardColors[$i % count($cardColors)];
                ?>
                <article class="product-card">
                    <div class="product-card__logo" style="background: <?= htmlspecialchars($color, ENT_QUOTES) ?>;"></div>
                    <h2 class="product-card__name"><?= htmlspecialchars($product['name'], ENT_QUOTES) ?></h2>
                    <p class="product-card__desc"><?= htmlspecialchars((string) $product['short_description'], ENT_QUOTES) ?></p>
                    <div class="product-card__footer">
                        <span class="price-badge<?= $isFree ? ' price-badge--free' : '' ?>">
                            <?= htmlspecialchars($priceText, ENT_QUOTES) ?>
                        </span>
                        <a class="btn" href="product.php?id=<?= $pid ?>">Докладніше</a>
                    </div>
                </article>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>
    </div>
</body>
</html>
