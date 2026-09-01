<?php

declare(strict_types=1);

/**
 * AI LAB HUB — головна сторінка.
 *
 * Герой + секція «Напрямки AI»: картки категорій, кожна веде на
 * сторінку категорії (category.php?id={id}).
 */

require_once __DIR__ . '/../app/auth.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$categories = $pdo->query(
    "SELECT id, name, slug
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
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — Головна</title>
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

        /* Логотип зафіксований у лівому верхньому куті екрана —
           не зміщується вбік чи вниз при адаптації під планшет/мобільний. */
        .site-header > a {
            position: fixed;
            top: 16px;
            left: 20px;
            z-index: 100;
            display: block;
            line-height: 0;
        }

        .site-header__logo {
            height: 50px;
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

        .main {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 24px 24px 72px;
        }

        /* Hero: картинка зліва (ближче до краю контейнера), заголовок і
           підзаголовок праворуч, вирівняні по вертикальному центру. */
        .hero {
            width: 100%;
            max-width: 1080px;
            display: flex;
            flex-direction: row;
            align-items: center;
            gap: 48px;
            text-align: left;
            padding: 48px 0 64px;
        }

        .hero__image {
            width: 100%;
            max-width: 520px;
            height: auto;
            display: block;
            flex-shrink: 0;
            margin: 0;
        }

        .hero__text {
            display: flex;
            flex-direction: column;
        }

        .hero__title {
            margin: 0 0 16px;
            font-size: clamp(2.5rem, 8vw, 4.5rem);
            font-weight: 800;
            letter-spacing: 0.04em;
            line-height: 1.05;
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
                margin: 0 auto;
            }

            .hero__text {
                align-items: center;
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

    <main class="main">
        <section class="hero">
            <img class="hero__image" src="assets/images/hero.png" alt="Колба — AI LAB HUB">
            <div class="hero__text">
                <h1 class="hero__title">AI LAB HUB</h1>
                <p class="hero__subtitle">Знайдіть AI-інструмент для будь-якого завдання</p>
            </div>
        </section>

        <section class="directions">
            <h2 class="directions__title">Напрямки AI</h2>
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
                        <h3 class="direction-card__name"><?= htmlspecialchars((string) $category['name'], ENT_QUOTES) ?></h3>
                    </a>
                <?php endforeach; ?>
            </div>
        </section>
    </main>

    <script src="https://unpkg.com/lucide@latest"></script>
    <script>lucide.createIcons();</script>
</body>
</html>
