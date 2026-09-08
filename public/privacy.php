<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Політика конфіденційності (заглушка).
 */

require_once __DIR__ . '/../app/translations.php';

?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — Політика конфіденційності</title>
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
            margin: 0;
            font-size: 1.05rem;
            color: var(--text-muted);
        }

        .legal-heading {
            margin: 32px 0 12px;
            font-size: 1.25rem;
            font-weight: 700;
        }

        .legal-updated {
            margin-top: 32px;
            font-size: 0.85rem;
            color: var(--text-muted);
        }
    </style>
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="assets/images/logo.png" alt="AI LAB HUB">
        </a>
    </header>

    <main class="page">
        <h1 class="stub__title">Політика конфіденційності</h1>
        <p class="stub__text">Документ буде додано найближчим часом</p>

        <h2 class="legal-heading">3.1. Дані в розділах Marketplace, курсів і вакансій</h2>
        <p class="stub__text">Якщо ви публікуєте товар у Marketplace, курс, чи вакансію як роботодавець, ми можемо збирати додаткові дані: назву компанії, контактні дані для зв'язку з кандидатами чи покупцями, платіжні реквізити для отримання виплат (де застосовно). Ці дані використовуються виключно для функціонування відповідного розділу платформи й не передаються третім особам, окрім випадків, прямо необхідних для виконання транзакції (наприклад платіжному провайдеру).</p>

        <p class="stub__text legal-updated">Останнє оновлення: 6 вересня 2026 р.</p>
    </main>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
