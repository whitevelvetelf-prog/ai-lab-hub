<?php

declare(strict_types=1);

/**
 * AI LAB HUB — головна сторінка.
 *
 * Герой + секція «Напрямки AI»: картки категорій, кожна веде на
 * сторінку категорії (category.php?id={id}).
 */

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$categories = $pdo->query(
    "SELECT id, name
     FROM categories
     ORDER BY id"
)->fetchAll();

// Палітра для карток напрямків (за порядком категорій).
$cardColors = [
    'linear-gradient(135deg, #2116ad, #5b8cff)',
    'linear-gradient(135deg, #0f9d58, #34d399)',
    'linear-gradient(135deg, #db2777, #f472b6)',
    'linear-gradient(135deg, #d97706, #fbbf24)',
    'linear-gradient(135deg, #0891b2, #22d3ee)',
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

        .site-header__logo {
            height: 50px;
            width: auto;
            display: block;
        }

        .main {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 24px 24px 72px;
        }

        .hero {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            padding: 32px 0 56px;
        }

        .hero__image {
            width: 100%;
            max-width: 420px;
            height: auto;
            display: block;
            margin: 0 auto 32px;
        }

        .hero__title {
            margin: 0 0 16px;
            font-size: clamp(2.5rem, 8vw, 4.5rem);
            font-weight: 800;
            letter-spacing: 0.04em;
            line-height: 1.05;
        }

        .hero__subtitle {
            margin: 0 auto;
            max-width: 32ch;
            font-size: clamp(1rem, 3.2vw, 1.35rem);
            font-weight: 400;
            color: var(--text-muted);
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
            font-size: 1.15rem;
            font-weight: 800;
            letter-spacing: 0.02em;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.35);
        }

        .direction-card__name {
            margin: 0;
            font-size: 1.2rem;
            font-weight: 700;
        }

        @media (max-width: 600px) {
            .site-header {
                justify-content: center;
                padding: 16px;
            }
        }
    </style>
</head>
<body>
    <header class="site-header">
        <img class="site-header__logo" src="assets/images/logo.png" alt="AI LAB HUB">
    </header>

    <main class="main">
        <section class="hero">
            <img class="hero__image" src="assets/images/hero.png" alt="Колба — AI LAB HUB">
            <h1 class="hero__title">AI LAB HUB</h1>
            <p class="hero__subtitle">Знайдіть AI-інструмент для будь-якого завдання</p>
        </section>

        <section class="directions">
            <h2 class="directions__title">Напрямки AI</h2>
            <div class="direction-grid">
                <?php foreach ($categories as $i => $category): ?>
                    <?php
                    $cid = (int) $category['id'];
                    $color = $cardColors[$i % count($cardColors)];
                    ?>
                    <a class="direction-card" href="category.php?id=<?= $cid ?>">
                        <span class="direction-card__icon" style="background: <?= htmlspecialchars($color, ENT_QUOTES) ?>;">
                            <?= htmlspecialchars(mb_strtoupper(mb_substr((string) $category['name'], 0, 2)), ENT_QUOTES) ?>
                        </span>
                        <h3 class="direction-card__name"><?= htmlspecialchars((string) $category['name'], ENT_QUOTES) ?></h3>
                    </a>
                <?php endforeach; ?>
            </div>
        </section>
    </main>
</body>
</html>
