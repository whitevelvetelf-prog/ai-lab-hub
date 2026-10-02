<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Моя добірка»: збережені користувачем продукти.
 *
 * Лише для залогінених (гість → login.php). Той самий формат карток, що
 * й у каталозі; кнопка-лапка знімає продукт із добірки прямо звідси
 * (той самий toggle-ендпоінт, картка зникає без перезавантаження).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/paw-icon.php';

if (!auth_check()) {
    header('Location: login.php');
    exit;
}

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$stmt = $pdo->prepare(
    "SELECT p.id, p.name, p.short_description
       FROM saved_products sp
       JOIN products p ON p.id = sp.product_id
      WHERE sp.user_id = :uid AND p.status = 'published'
      ORDER BY sp.created_at DESC, sp.id DESC"
);
$stmt->execute([':uid' => auth_user_id()]);
$products = $stmt->fetchAll();

$plansByProduct = [];
foreach ($pdo->query("SELECT product_id, price, period FROM pricing_plans ORDER BY price ASC") as $plan) {
    $plansByProduct[(int) $plan['product_id']][] = $plan;
}

/** Бейдж ціни: [текст, чи безкоштовний]. */
function price_badge(array $plans): array
{
    // Тарифів немає зовсім — ціна невідома, а не «безкоштовно».
    if ($plans === []) {
        return [t('price_not_specified'), false];
    }
    $paid = array_filter($plans, static fn($p) => $p['period'] !== 'free' && (float) $p['price'] > 0);
    if ($paid === []) {
        // Тариф без ціни (price NULL, не 'free') — «за запитом», а не безкоштовний.
        $onRequest = array_filter($plans, static fn($p) => $p['period'] !== 'free' && $p['price'] === null);
        return $onRequest !== [] ? [t('price_on_request'), false] : [t('price_free'), true];
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
    <title><?= htmlspecialchars(t('title_saved'), ENT_QUOTES) ?></title>
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

        .catalog__title {
            margin: 0 0 32px;
            font-size: clamp(1.8rem, 5vw, 2.6rem);
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .empty-state {
            padding: 20px;
            border: 1px dashed var(--card-border);
            border-radius: 12px;
            color: var(--text-muted);
            font-size: 0.98rem;
        }

        .empty-state a {
            color: #ffffff;
            font-weight: 600;
        }

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
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="/logo.png" alt="AI LAB HUB">
        </a>
        <nav class="site-nav" id="siteNav">
            <a class="site-nav__link" href="index.php"><?= htmlspecialchars(t('nav_home'), ENT_QUOTES) ?></a>
            <a class="site-nav__link" href="account.php"><?= htmlspecialchars(t('nav_account'), ENT_QUOTES) ?></a>
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
        <h1 class="catalog__title"><?= htmlspecialchars(t('saved_page_title'), ENT_QUOTES) ?></h1>

        <?php if ($products === []): ?>
        <p class="empty-state">
            <?= htmlspecialchars(t('saved_empty_text'), ENT_QUOTES) ?>
            <a href="catalog.php"><?= htmlspecialchars(t('saved_empty_link'), ENT_QUOTES) ?></a>.
        </p>
        <?php else: ?>
        <div class="catalog-grid" data-saved-list>
            <?php foreach ($products as $i => $product): ?>
                <?php
                $pid = (int) $product['id'];
                [$priceText, $isFree] = price_badge($plansByProduct[$pid] ?? []);
                $color = $cardColors[$i % count($cardColors)];
                $unsaveLabel = t('saved_btn_unsave');
                ?>
                <article class="product-card">
                    <button type="button"
                            class="save-btn is-saved"
                            data-product-id="<?= $pid ?>"
                            data-saved="1"
                            aria-pressed="true"
                            aria-label="<?= htmlspecialchars($unsaveLabel, ENT_QUOTES) ?>"
                            title="<?= htmlspecialchars($unsaveLabel, ENT_QUOTES) ?>"><?= paw_icon_use() ?></button>
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
