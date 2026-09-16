<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Про проєкт.
 */

require_once __DIR__ . '/../app/translations.php';

?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — Про проєкт</title>
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
            flex: 1;
            width: 100%;
            max-width: 760px;
            margin: 0 auto;
            padding: 48px 24px 64px;
        }

        .stub__title {
            margin: 0 0 12px;
            font-size: clamp(1.8rem, 5vw, 2.6rem);
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .stub__text {
            margin: 0 0 18px;
            font-size: 1.05rem;
            color: var(--text-muted);
        }

        .about-heading {
            margin: 36px 0 14px;
            font-size: 1.25rem;
            font-weight: 700;
            color: #ffffff;
        }

        .about-list {
            margin: 0 0 18px;
            padding: 0;
            list-style: none;
        }

        .about-list li {
            position: relative;
            margin: 0 0 14px;
            padding-left: 20px;
            font-size: 1.05rem;
            color: var(--text-muted);
        }

        .about-list li::before {
            content: "—";
            position: absolute;
            left: 0;
            color: var(--accent);
        }
    </style>
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="/logo.png" alt="AI LAB HUB">
        </a>
    </header>

    <main class="page">
        <h1 class="stub__title">Про проєкт</h1>

        <p class="stub__text">AI LAB HUB — це каталог AI-інструментів, створений, щоб допомогти кожному швидко знайти правильне рішення для своєї задачі, не гублячись у сотнях схожих сервісів.</p>

        <p class="stub__text">Наша місія проста: зібрати AI-інструменти з усього світу в одному місці, розподілити їх за зрозумілими напрямками, і дати змогу знайти потрібне рішення за лічені хвилини — незалежно від того, чи це разова безкоштовна задача, чи професійний інструмент для щоденної роботи.</p>

        <h2 class="about-heading">Що робить AI LAB HUB особливим:</h2>

        <ul class="about-list">
            <li>Еля, наша AI-асистентка, допомагає підібрати саме те, що потрібно, розуміючи вашу задачу і бюджет — а не просто показує список фільтрів.</li>
            <li>Ми не показуємо рейтинги чи «накручені» оцінки — тільки чесний опис того, що робить кожен інструмент.</li>
            <li>Каталог поповнюється й перевіряється регулярно, щоб інформація залишалась актуальною.</li>
        </ul>

        <p class="stub__text">Платформа безкоштовна для користувачів і завжди такою залишиться. Ми можемо отримувати партнерську комісію від деяких сервісів, представлених у каталозі — це не впливає на те, які інструменти потрапляють до каталогу чи як їх описано.</p>

        <p class="stub__text">Якщо у вас є пропозиція, зауваження чи ви хочете розповісти про свій AI-продукт — напишіть нам, контакти на сторінці «Контакти».</p>
    </main>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
