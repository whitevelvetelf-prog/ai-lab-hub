<?php

declare(strict_types=1);

/**
 * AI LAB HUB — картка AI-продукту.
 *
 * Дані конкретного продукту (?id=N) завантажуються з БД разом із
 * категоріями, підкатегоріями та тарифними планами.
 */

require_once __DIR__ . '/../app/auth.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$productId = (int) ($_GET['id'] ?? 0);

$stmt = $pdo->prepare(
    "SELECT id, name, logo_url, official_url, short_description, full_description,
            main_features, target_audience, platform, skill_level, status
     FROM products
     WHERE id = :id"
);
$stmt->execute([':id' => $productId]);
$product = $stmt->fetch();

$categories = [];
$subcategories = [];
$plans = [];

if ($product !== false) {
    $catStmt = $pdo->prepare(
        "SELECT c.name
         FROM product_categories pc
         JOIN categories c ON c.id = pc.category_id
         WHERE pc.product_id = :id
         ORDER BY c.name"
    );
    $catStmt->execute([':id' => $productId]);
    $categories = $catStmt->fetchAll(PDO::FETCH_COLUMN);

    $subStmt = $pdo->prepare(
        "SELECT s.name
         FROM product_subcategories ps
         JOIN subcategories s ON s.id = ps.subcategory_id
         WHERE ps.product_id = :id
         ORDER BY s.name"
    );
    $subStmt->execute([':id' => $productId]);
    $subcategories = $subStmt->fetchAll(PDO::FETCH_COLUMN);

    $planStmt = $pdo->prepare(
        "SELECT plan_name, price, period, description
         FROM pricing_plans
         WHERE product_id = :id
         ORDER BY price ASC, id ASC"
    );
    $planStmt->execute([':id' => $productId]);
    $plans = $planStmt->fetchAll();
}

/** Ініціали для логотипа-заглушки (по словах / CamelCase). */
function product_initials(string $name): string
{
    $parts = preg_split('/\s+|(?<=\p{Ll})(?=\p{Lu})/u', trim($name), -1, PREG_SPLIT_NO_EMPTY) ?: [];
    if (count($parts) >= 2) {
        return mb_strtoupper(mb_substr($parts[0], 0, 1) . mb_substr($parts[1], 0, 1));
    }
    return mb_strtoupper(mb_substr($name, 0, 2));
}

/** Людські назви платформ ("web,mobile" -> "Веб / Мобільний"). */
function platform_label(?string $platform): string
{
    if ($platform === null || $platform === '') {
        return '—';
    }
    $map = ['web' => 'Веб', 'mobile' => 'Мобільний', 'desktop' => 'Десктоп'];
    $out = [];
    foreach (explode(',', $platform) as $p) {
        $out[] = $map[$p] ?? $p;
    }
    return implode(' / ', $out);
}

/** Людський опис рівня навичок. */
function skill_label(string $level): string
{
    return match ($level) {
        'basic' => 'Потрібні базові знання',
        'course' => 'Потрібне окреме навчання (курс)',
        default => 'Не потребує спеціальних знань',
    };
}

/** HTML ціни тарифу для блоку планів (напр. '$9 <span>/ міс</span>'). */
function plan_price(array $plan): string
{
    $amount = (float) $plan['price'];
    $price = '$' . rtrim(rtrim(number_format($amount, 2, '.', ''), '0'), '.');
    if ($plan['period'] === 'free' || $amount <= 0) {
        return $price;
    }
    $periods = ['week' => '/ тиж', 'month' => '/ міс', 'year' => '/ рік', 'one_time' => 'разово'];
    $suffix = $periods[$plan['period']] ?? '';
    return $suffix !== '' ? $price . ' <span>' . $suffix . '</span>' : $price;
}

$pageTitle = $product !== false ? $product['name'] : 'Продукт не знайдено';

?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — <?= htmlspecialchars($pageTitle, ENT_QUOTES) ?></title>
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

        .site-header__logo {
            height: 42px;
            width: auto;
            display: block;
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
            max-width: 960px;
            margin: 0 auto;
            padding: 24px 24px 72px;
        }

        /* 1. Логотип + назва продукту */
        .product-head {
            display: flex;
            align-items: center;
            gap: 18px;
            flex-wrap: wrap;
        }

        .product-head__logo {
            width: 64px;
            height: 64px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.6rem;
            font-weight: 800;
            background: linear-gradient(135deg, #2116ad, #5b8cff);
            box-shadow: 0 8px 24px rgba(0, 0, 0, 0.35);
        }

        .product-head__name {
            margin: 0;
            font-size: clamp(1.8rem, 5vw, 2.6rem);
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        /* Кнопки */
        .btn {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 999px;
            font-size: 1rem;
            font-weight: 600;
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

        .btn--block {
            display: block;
            width: 100%;
            text-align: center;
        }

        .product-cta {
            margin-top: 24px;
        }

        /* 3. Короткий опис */
        .product-summary {
            margin-top: 32px;
        }

        .product-summary p {
            margin: 0 0 16px;
            font-size: 1.08rem;
            color: var(--text-muted);
            max-width: 62ch;
        }

        /* 4. Бейджі */
        .badges {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 28px;
        }

        .badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 999px;
            font-size: 0.85rem;
            font-weight: 600;
            letter-spacing: 0.02em;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
        }

        .badge--accent {
            background: rgba(91, 140, 255, 0.2);
            border-color: rgba(91, 140, 255, 0.5);
        }

        /* Секції */
        .section {
            margin-top: 48px;
        }

        .section__title {
            margin: 0 0 18px;
            font-size: 1.4rem;
            font-weight: 700;
        }

        .feature-list {
            margin: 0;
            padding: 0;
            list-style: none;
            display: grid;
            gap: 12px;
        }

        .feature-list li {
            position: relative;
            padding: 14px 18px 14px 46px;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 12px;
            color: var(--text-muted);
        }

        .feature-list li::before {
            content: "";
            position: absolute;
            left: 18px;
            top: 50%;
            width: 10px;
            height: 10px;
            margin-top: -5px;
            border-radius: 50%;
            background: var(--accent);
            box-shadow: 0 0 0 4px rgba(91, 140, 255, 0.25);
        }

        .section__text {
            margin: 0;
            font-size: 1.05rem;
            color: var(--text-muted);
            max-width: 62ch;
        }

        /* 7. Тарифні плани */
        .plans {
            display: grid;
            gap: 18px;
            grid-template-columns: 1fr;
        }

        .plan {
            display: flex;
            flex-direction: column;
            padding: 24px;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 16px;
        }

        .plan--featured {
            border-color: rgba(91, 140, 255, 0.6);
            background: rgba(91, 140, 255, 0.12);
        }

        .plan__name {
            margin: 0 0 6px;
            font-size: 1.15rem;
            font-weight: 700;
        }

        .plan__price {
            margin: 0 0 14px;
            font-size: 1.9rem;
            font-weight: 800;
        }

        .plan__price span {
            font-size: 0.95rem;
            font-weight: 500;
            color: var(--text-muted);
        }

        .plan__desc {
            margin: 0 0 20px;
            font-size: 0.98rem;
            color: var(--text-muted);
            flex: 1;
        }

        /* Порівняльна таблиця планів — від 768px */
        @media (min-width: 768px) {
            .plans {
                grid-template-columns: repeat(3, 1fr);
                align-items: stretch;
            }
        }

        /* 8. Нижні бейджі */
        .footer-badges {
            margin-top: 56px;
            padding-top: 28px;
            border-top: 1px solid var(--card-border);
            display: flex;
            flex-wrap: wrap;
            gap: 24px;
        }

        .footer-badge {
            display: flex;
            flex-direction: column;
            gap: 6px;
        }

        .footer-badge__label {
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.08em;
            color: rgba(255, 255, 255, 0.55);
        }

        .footer-badge__value {
            font-size: 1rem;
            font-weight: 600;
        }

        @media (max-width: 600px) {
            .site-header {
                justify-content: center;
                padding: 16px;
                flex-wrap: wrap;
                gap: 12px;
            }

            .product-head {
                justify-content: center;
                text-align: center;
            }
        }
    </style>
</head>
<body>
    <header class="site-header">
        <a href="index.php"><img class="site-header__logo" src="assets/images/logo.png" alt="AI LAB HUB"></a>
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
<?php if ($product === false): ?>
        <div class="product-head">
            <h1 class="product-head__name">Продукт не знайдено</h1>
        </div>
        <div class="product-summary">
            <p>Продукт із таким ідентифікатором відсутній або ще не опублікований.</p>
            <a class="btn btn--ghost" href="catalog.php">До каталогу</a>
        </div>
<?php else: ?>
        <?php
        $features = array_values(array_filter(array_map(
            'trim',
            preg_split('/\r\n|\r|\n/', (string) $product['main_features']) ?: []
        ), static fn($f) => $f !== ''));
        $planCount = count($plans);
        ?>
        <!-- 1. Логотип + назва продукту -->
        <div class="product-head">
            <div class="product-head__logo"><?= htmlspecialchars(product_initials($product['name']), ENT_QUOTES) ?></div>
            <h1 class="product-head__name"><?= htmlspecialchars($product['name'], ENT_QUOTES) ?></h1>
        </div>

        <!-- 2. Кнопка переходу на сайт -->
        <div class="product-cta">
            <a class="btn btn--primary" href="<?= htmlspecialchars($product['official_url'] ?: '#', ENT_QUOTES) ?>"<?= $product['official_url'] ? ' target="_blank" rel="noopener"' : '' ?>>Перейти на сайт</a>
        </div>

        <!-- 3. Короткий опис -->
        <div class="product-summary">
            <p><?= htmlspecialchars((string) ($product['full_description'] ?: $product['short_description']), ENT_QUOTES) ?></p>
            <a class="btn btn--ghost" href="#">Докладніше</a>
        </div>

        <!-- 4. Бейджі категорії та підкатегорії -->
        <div class="badges">
            <?php foreach ($categories as $categoryName): ?>
                <span class="badge"><?= htmlspecialchars((string) $categoryName, ENT_QUOTES) ?></span>
            <?php endforeach; ?>
            <?php foreach ($subcategories as $subcategoryName): ?>
                <span class="badge badge--accent"><?= htmlspecialchars((string) $subcategoryName, ENT_QUOTES) ?></span>
            <?php endforeach; ?>
        </div>

        <!-- 5. Основні функції -->
        <?php if ($features !== []): ?>
        <section class="section">
            <h2 class="section__title">Основні функції</h2>
            <ul class="feature-list">
                <?php foreach ($features as $feature): ?>
                    <li><?= htmlspecialchars($feature, ENT_QUOTES) ?></li>
                <?php endforeach; ?>
            </ul>
        </section>
        <?php endif; ?>

        <!-- 6. Для кого призначений -->
        <?php if (!empty($product['target_audience'])): ?>
        <section class="section">
            <h2 class="section__title">Для кого призначений</h2>
            <p class="section__text"><?= htmlspecialchars((string) $product['target_audience'], ENT_QUOTES) ?></p>
        </section>
        <?php endif; ?>

        <!-- 7. Тарифні плани -->
        <?php if ($planCount > 0): ?>
        <section class="section">
            <h2 class="section__title">Тарифні плани</h2>
            <div class="plans">
                <?php foreach ($plans as $idx => $plan): ?>
                    <?php $featured = $planCount === 3 && $idx === 1; ?>
                    <div class="plan<?= $featured ? ' plan--featured' : '' ?>">
                        <h3 class="plan__name"><?= htmlspecialchars($plan['plan_name'], ENT_QUOTES) ?></h3>
                        <p class="plan__price"><?= plan_price($plan) ?></p>
                        <p class="plan__desc"><?= htmlspecialchars((string) $plan['description'], ENT_QUOTES) ?></p>
                        <a class="btn <?= $featured ? 'btn--primary' : 'btn--ghost' ?> btn--block" href="#">Обрати</a>
                    </div>
                <?php endforeach; ?>
            </div>
        </section>
        <?php endif; ?>

        <!-- 8. Нижні бейджі: платформа і рівень навичок -->
        <div class="footer-badges">
            <div class="footer-badge">
                <span class="footer-badge__label">Платформа</span>
                <span class="footer-badge__value"><?= htmlspecialchars(platform_label($product['platform']), ENT_QUOTES) ?></span>
            </div>
            <div class="footer-badge">
                <span class="footer-badge__label">Рівень навичок</span>
                <span class="footer-badge__value"><?= htmlspecialchars(skill_label((string) $product['skill_level']), ENT_QUOTES) ?></span>
            </div>
        </div>
<?php endif; ?>
    </div>
</body>
</html>
