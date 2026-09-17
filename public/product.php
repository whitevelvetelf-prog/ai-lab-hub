<?php

declare(strict_types=1);

/**
 * AI LAB HUB — картка AI-продукту.
 *
 * Дані конкретного продукту (?id=N) завантажуються з БД разом із
 * категоріями, підкатегоріями та тарифними планами.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$productId = (int) ($_GET['id'] ?? 0);

$stmt = $pdo->prepare(
    "SELECT id, name, logo_url, official_url,
            short_description, full_description, main_features, target_audience,
            platform, skill_level, status
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
        "SELECT c.name, c.name_en
         FROM product_categories pc
         JOIN categories c ON c.id = pc.category_id
         WHERE pc.product_id = :id
         ORDER BY c.name"
    );
    $catStmt->execute([':id' => $productId]);
    $categories = $catStmt->fetchAll();

    $subStmt = $pdo->prepare(
        "SELECT s.name, s.name_en
         FROM product_subcategories ps
         JOIN subcategories s ON s.id = ps.subcategory_id
         WHERE ps.product_id = :id
         ORDER BY s.name"
    );
    $subStmt->execute([':id' => $productId]);
    $subcategories = $subStmt->fetchAll();

    $planStmt = $pdo->prepare(
        "SELECT id, plan_name, price, period, description
         FROM pricing_plans
         WHERE product_id = :id
         ORDER BY price ASC, id ASC"
    );
    $planStmt->execute([':id' => $productId]);
    $plans = $planStmt->fetchAll();
}

/** Переклад поля картки продукту поточною мовою (кеш у product_translations). */
function localized_product_field(PDO $pdo, array $product, string $field): string
{
    return localized_field($pdo, 'product_translations', 'product_id', $product, $field);
}

/** Переклад поля тарифного плану поточною мовою (кеш у pricing_plan_translations). */
function localized_plan_field(PDO $pdo, array $plan, string $field): string
{
    return localized_field($pdo, 'pricing_plan_translations', 'plan_id', $plan, $field);
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
    $map = ['web' => t('platform_web'), 'mobile' => t('platform_mobile'), 'desktop' => t('platform_desktop')];
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
        'basic' => t('skill_basic'),
        'course' => t('skill_course'),
        default => t('skill_none'),
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
    $periods = [
        'week' => '/ ' . t('unit_week'),
        'month' => '/ ' . t('unit_month'),
        'year' => '/ ' . t('unit_year'),
        'one_time' => t('unit_one_time'),
    ];
    $suffix = $periods[$plan['period']] ?? '';
    return $suffix !== '' ? $price . ' <span>' . $suffix . '</span>' : $price;
}

$pageTitle = $product !== false ? $product['name'] : t('product_not_found');

?>
<!DOCTYPE html>
<html lang="<?= htmlspecialchars(current_lang(), ENT_QUOTES) ?>">
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
            max-width: 960px;
            margin: 0 auto;
            padding: 24px 24px 72px;
        }

        /* Стрілка повернення до чату з Елею (видима, лише якщо є активна
           розмова — розкривається скриптом, щоб не зʼявлятись у тих, хто
           потрапив на сторінку іншим шляхом). */
        .back-to-eli {
            display: none;
            align-items: center;
            gap: 8px;
            margin-bottom: 20px;
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--text-muted);
            text-decoration: none;
            transition: color 0.15s ease;
        }

        .back-to-eli:hover {
            color: #ffffff;
        }

        .back-to-eli svg {
            width: 18px;
            height: 18px;
            flex-shrink: 0;
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
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="/logo.png" alt="AI LAB HUB">
        </a>
        <nav class="site-nav" id="siteNav">
            <a class="site-nav__link" href="index.php"><?= htmlspecialchars(t('nav_home'), ENT_QUOTES) ?></a>
            <?php if (auth_check()): ?>
            <a class="site-nav__link" href="account.php"><?= htmlspecialchars(t('nav_account'), ENT_QUOTES) ?></a>
            <?php else: ?>
            <a class="site-nav__link" href="login.php"><?= htmlspecialchars(t('nav_login'), ENT_QUOTES) ?></a>
            <?php endif; ?>
        </nav>
        <a class="site-nav__link site-nav__link--cta site-header__cta" href="eli.php">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9.937 15.5A2 2 0 0 0 8.5 14.063l-6.135-1.582a.5.5 0 0 1 0-.962L8.5 9.936A2 2 0 0 0 9.937 8.5l1.582-6.135a.5.5 0 0 1 .962 0L14.063 8.5A2 2 0 0 0 15.5 9.937l6.135 1.581a.5.5 0 0 1 0 .964L15.5 14.063a2 2 0 0 0-1.437 1.437l-1.582 6.135a.5.5 0 0 1-.962 0z"/><path d="M20 3v4"/><path d="M22 5h-4"/><path d="M4 17v2"/><path d="M6 18H2"/></svg>
            <?= htmlspecialchars(t('nav_assistant'), ENT_QUOTES) ?>
        </a>
        <button class="site-nav__toggle" type="button" aria-label="<?= htmlspecialchars(t('nav_menu'), ENT_QUOTES) ?>" aria-expanded="false" aria-controls="siteNav">
            <span></span>
            <span></span>
            <span></span>
        </button>
    </header>

    <div class="page">
        <a href="eli.php" class="back-to-eli" id="backToEli">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M19 12H5"/><path d="M12 19l-7-7 7-7"/></svg>
            <?= htmlspecialchars(t('back_to_eli'), ENT_QUOTES) ?>
        </a>
<?php if ($product === false): ?>
        <div class="product-head">
            <h1 class="product-head__name"><?= htmlspecialchars(t('product_not_found'), ENT_QUOTES) ?></h1>
        </div>
        <div class="product-summary">
            <p><?= htmlspecialchars(t('product_not_found_text'), ENT_QUOTES) ?></p>
            <a class="btn btn--ghost" href="index.php"><?= htmlspecialchars(t('back_to_directions'), ENT_QUOTES) ?></a>
        </div>
<?php else: ?>
        <?php
        $shortDescription = localized_product_field($pdo, $product, 'short_description');
        $fullDescription = localized_product_field($pdo, $product, 'full_description');
        $summaryText = $fullDescription !== '' ? $fullDescription : $shortDescription;
        $targetAudience = localized_product_field($pdo, $product, 'target_audience');
        $features = array_values(array_filter(array_map(
            'trim',
            preg_split('/\r\n|\r|\n/', localized_product_field($pdo, $product, 'main_features')) ?: []
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
            <a class="btn btn--primary" href="<?= htmlspecialchars($product['official_url'] ?: '#', ENT_QUOTES) ?>"<?= $product['official_url'] ? ' target="_blank" rel="noopener"' : '' ?>><?= htmlspecialchars(t('product_visit_site'), ENT_QUOTES) ?></a>
        </div>

        <!-- 3. Короткий опис -->
        <div class="product-summary">
            <p><?= htmlspecialchars($summaryText, ENT_QUOTES) ?></p>
            <a class="btn btn--ghost" href="#"><?= htmlspecialchars(t('btn_details'), ENT_QUOTES) ?></a>
        </div>

        <!-- 4. Бейджі категорії та підкатегорії -->
        <div class="badges">
            <?php foreach ($categories as $categoryRow): ?>
                <span class="badge"><?= htmlspecialchars(localized_name($categoryRow), ENT_QUOTES) ?></span>
            <?php endforeach; ?>
            <?php foreach ($subcategories as $subcategoryRow): ?>
                <span class="badge badge--accent"><?= htmlspecialchars(localized_name($subcategoryRow), ENT_QUOTES) ?></span>
            <?php endforeach; ?>
        </div>

        <!-- 5. Основні функції -->
        <?php if ($features !== []): ?>
        <section class="section">
            <h2 class="section__title"><?= htmlspecialchars(t('product_features_title'), ENT_QUOTES) ?></h2>
            <ul class="feature-list">
                <?php foreach ($features as $feature): ?>
                    <li><?= htmlspecialchars($feature, ENT_QUOTES) ?></li>
                <?php endforeach; ?>
            </ul>
        </section>
        <?php endif; ?>

        <!-- 6. Для кого призначений -->
        <?php if ($targetAudience !== ''): ?>
        <section class="section">
            <h2 class="section__title"><?= htmlspecialchars(t('product_audience_title'), ENT_QUOTES) ?></h2>
            <p class="section__text"><?= htmlspecialchars($targetAudience, ENT_QUOTES) ?></p>
        </section>
        <?php endif; ?>

        <!-- 7. Тарифні плани -->
        <?php if ($planCount > 0): ?>
        <section class="section">
            <h2 class="section__title"><?= htmlspecialchars(t('product_plans_title'), ENT_QUOTES) ?></h2>
            <div class="plans">
                <?php foreach ($plans as $idx => $plan): ?>
                    <?php $featured = $planCount === 3 && $idx === 1; ?>
                    <div class="plan<?= $featured ? ' plan--featured' : '' ?>">
                        <h3 class="plan__name"><?= htmlspecialchars(localized_plan_field($pdo, $plan, 'plan_name'), ENT_QUOTES) ?></h3>
                        <p class="plan__price"><?= plan_price($plan) ?></p>
                        <p class="plan__desc"><?= htmlspecialchars(localized_plan_field($pdo, $plan, 'description'), ENT_QUOTES) ?></p>
                        <a class="btn <?= $featured ? 'btn--primary' : 'btn--ghost' ?> btn--block" href="#"><?= htmlspecialchars(t('product_plan_select'), ENT_QUOTES) ?></a>
                    </div>
                <?php endforeach; ?>
            </div>
        </section>
        <?php endif; ?>

        <!-- 8. Нижні бейджі: платформа і рівень навичок -->
        <div class="footer-badges">
            <div class="footer-badge">
                <span class="footer-badge__label"><?= htmlspecialchars(t('product_platform_label'), ENT_QUOTES) ?></span>
                <span class="footer-badge__value"><?= htmlspecialchars(platform_label($product['platform']), ENT_QUOTES) ?></span>
            </div>
            <div class="footer-badge">
                <span class="footer-badge__label"><?= htmlspecialchars(t('product_skill_label'), ENT_QUOTES) ?></span>
                <span class="footer-badge__value"><?= htmlspecialchars(skill_label((string) $product['skill_level']), ENT_QUOTES) ?></span>
            </div>
        </div>
<?php endif; ?>
    </div>
    <?php include __DIR__ . '/../app/footer.php'; ?>
    <script>
        (function () {
            try {
                if (sessionStorage.getItem('eliChatState')) {
                    var backLink = document.getElementById('backToEli');
                    if (backLink) {
                        backLink.style.display = 'inline-flex';
                    }
                }
            } catch (e) {}
        })();
    </script>
</body>
</html>
