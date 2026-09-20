<?php

declare(strict_types=1);

/**
 * AI LAB HUB — головна сторінка.
 *
 * Герой + секція «Напрямки AI»: картки категорій, кожна веде на
 * сторінку категорії (category.php?id={id}).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/ads.php';
require_once __DIR__ . '/../app/analytics.php';
require_once __DIR__ . '/../app/marketplace.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

analytics_log_view($pdo, 'home');

$homepageBanner = ads_pick_campaign($pdo, 'homepage_banner');

// Блок Marketplace під hero: лише коли public_enabled = true і є опубліковані пропозиції.
$mpHomeOffers = [];
if (mp_public_nav_visible()) {
    try {
        $mpHomeOffers = mp_public_listings($pdo, current_lang(), ['limit' => 3]);
    } catch (Throwable $e) {
        $mpHomeOffers = [];
    }
}

$categories = $pdo->query(
    "SELECT id, name, name_en, slug
     FROM categories
     ORDER BY id"
)->fetchAll();

/**
 * Тематична піктограма Lucide для кожного напряму (за slug).
 * Повний перелік назв: https://lucide.dev/icons/
 */
$categoryIcons = [
    'multimedia'            => 'film',
    'text-chatbots'         => 'message-circle',
    'development-it'        => 'code',
    'business-marketing'    => 'trending-up',
    'data-analytics'        => 'bar-chart-3',
    'productivity'          => 'target',
    'seo-content'           => 'search',
    'design-creative'       => 'palette',
    'education-knowledge'   => 'graduation-cap',
    'translation-languages' => 'languages',
    'finance-legal'         => 'scale',
    'health-beauty'         => 'heart-pulse',
    'tools-automation'      => 'settings',
];

?>
<!DOCTYPE html>
<html lang="<?= htmlspecialchars(current_lang(), ENT_QUOTES) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= htmlspecialchars(t('title_home'), ENT_QUOTES) ?></title>
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
            display: flex;
            flex-direction: column;
            font-family: "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
            color: #ffffff;
            background: linear-gradient(160deg, var(--bg-start) 0%, var(--bg-end) 100%);
            background-attachment: fixed;
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
            height: 50px;
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

        .main {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 24px 24px 72px;
        }

        /* Hero: заголовок і підзаголовок зліва (по вертикальному центру),
           картинка справа, ближче до краю контейнера. */
        .hero {
            width: 100%;
            max-width: 1080px;
            display: flex;
            flex-direction: row-reverse;
            align-items: center;
            gap: 48px;
            text-align: left;
            padding: 48px 0 64px;
        }

        .hero__image {
            width: 100%;
            max-width: 580px;
            min-width: 240px;
            height: auto;
            display: block;
            margin: 0;
        }

        .hero__text {
            display: flex;
            flex-direction: column;
        }

        /* Заголовок завжди в один рядок; шрифт адаптується під ширину
           текстової колонки, щоб не наїжджати на картинку. */
        .hero__title {
            margin: 0 0 16px;
            font-size: clamp(1.9rem, 4.4vw, 3rem);
            font-weight: 800;
            letter-spacing: 0.04em;
            line-height: 1.05;
            white-space: nowrap;
        }

        .hero__subtitle {
            margin: 0;
            max-width: 32ch;
            font-size: clamp(1rem, 3.2vw, 1.35rem);
            font-weight: 400;
            color: var(--text-muted);
        }

        /* Вузькі екрани (<768px): hero повертається до вертикального стеку —
           картинка згори, текст під нею. */
        @media (max-width: 768px) {
            .hero {
                flex-direction: column;
                align-items: center;
                text-align: center;
                gap: 24px;
                padding: 24px 0 48px;
            }

            .hero__image {
                max-width: 420px;
                min-width: 0;
                margin: 0 auto;
            }

            .hero__text {
                align-items: center;
            }

            /* Ще менший шрифт на вузьких екранах — заголовок лишається
               в один рядок (white-space: nowrap успадковується). */
            .hero__title {
                font-size: clamp(1.6rem, 7vw, 2.6rem);
            }

            .hero__subtitle {
                margin: 0 auto;
            }
        }

        .directions {
            width: 100%;
            max-width: 1080px;
        }

        .directions__title {
            margin: 0 0 24px;
            font-size: clamp(1.5rem, 4vw, 2.1rem);
            font-weight: 800;
            letter-spacing: 0.02em;
            text-align: center;
        }

        /* Сітка карток напрямків: 3 / 2 / 1 колонки */
        .direction-grid {
            display: grid;
            gap: 20px;
            grid-template-columns: repeat(3, 1fr);
        }

        @media (max-width: 900px) {
            .direction-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 560px) {
            .direction-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Картка-кнопка напряму */
        .direction-card {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            gap: 16px;
            padding: 22px;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            color: #ffffff;
            text-decoration: none;
            transition: transform 0.15s ease, border-color 0.15s ease;
        }

        .direction-card:hover {
            transform: translateY(-3px);
            border-color: rgba(91, 140, 255, 0.5);
        }

        .direction-card__icon {
            width: 52px;
            height: 52px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--accent);
            background: rgba(91, 140, 255, 0.12);
            border: 1px solid rgba(91, 140, 255, 0.25);
        }

        .direction-card__icon svg {
            width: 26px;
            height: 26px;
        }

        .direction-card__name {
            margin: 0;
            font-size: 1.2rem;
            font-weight: 700;
        }

        .home-ad {
            width: 100%;
            max-width: 1080px;
            margin-top: 40px;
        }

        @media (max-width: 600px) {
            .site-header {
                justify-content: flex-end;
                padding: 16px;
                flex-wrap: wrap;
                gap: 12px;
            }

            /* Трохи менший логотип, щоб не перетинався з навігацією */
            .site-header__logo {
                height: 40px;
            }
        }
    </style>
    <?php include __DIR__ . '/../app/header.php'; ?>
    <?php if ($mpHomeOffers !== []): ?>
    <link rel="stylesheet" href="<?= css_asset('mp-public.css') ?>">
    <?php endif; ?>
</head>
<body>
    <?php include __DIR__ . '/../app/site-header.php'; ?>

    <main class="main">
        <section class="hero">
            <img class="hero__image" src="assets/images/hero.png" alt="<?= htmlspecialchars(t('hero_image_alt'), ENT_QUOTES) ?>">
            <div class="hero__text">
                <h1 class="hero__title"><?= htmlspecialchars(t('hero_title'), ENT_QUOTES) ?></h1>
                <p class="hero__subtitle"><?= htmlspecialchars(t('hero_subtitle'), ENT_QUOTES) ?></p>
            </div>
        </section>

        <?php if ($mpHomeOffers !== []): ?>
        <section class="mp-home">
            <div class="mp-home__head">
                <div>
                    <h2 class="mp-home__title"><?= htmlspecialchars(t('mp_home_title'), ENT_QUOTES) ?></h2>
                    <p class="mp-home__text"><?= htmlspecialchars(t('mp_home_text'), ENT_QUOTES) ?></p>
                </div>
                <a class="mp-btn" href="marketplace.php"><?= htmlspecialchars(t('mp_home_all'), ENT_QUOTES) ?></a>
            </div>
            <div class="mp-grid">
                <?php foreach ($mpHomeOffers as $card): ?>
                    <?php include __DIR__ . '/../app/mp-card.php'; ?>
                <?php endforeach; ?>
            </div>
        </section>
        <?php endif; ?>

        <section class="directions">
            <h2 class="directions__title"><?= htmlspecialchars(t('directions_title'), ENT_QUOTES) ?></h2>
            <div class="direction-grid">
                <?php foreach ($categories as $category): ?>
                    <?php
                    $cid = (int) $category['id'];
                    $icon = $categoryIcons[$category['slug']] ?? 'shapes';
                    ?>
                    <a class="direction-card" href="category.php?id=<?= $cid ?>">
                        <span class="direction-card__icon">
                            <i data-lucide="<?= htmlspecialchars($icon, ENT_QUOTES) ?>"></i>
                        </span>
                        <h3 class="direction-card__name"><?= htmlspecialchars(localized_name($category), ENT_QUOTES) ?></h3>
                    </a>
                <?php endforeach; ?>
            </div>
        </section>

        <?php if ($homepageBanner !== null): ?>
        <section class="home-ad">
            <?php $campaign = $homepageBanner; require __DIR__ . '/../app/ad-banner.php'; ?>
        </section>
        <?php endif; ?>
    </main>

    <script src="https://unpkg.com/lucide@latest"></script>
    <script>lucide.createIcons();</script>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
