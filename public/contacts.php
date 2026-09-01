<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Контакти.
 */

?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — Контакти</title>
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

        .contact-grid {
            margin-top: 32px;
            display: grid;
            gap: 20px;
            grid-template-columns: repeat(2, 1fr);
        }

        @media (max-width: 620px) {
            .contact-grid {
                grid-template-columns: 1fr;
            }
        }

        .contact-card {
            padding: 24px;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .contact-card__title {
            margin: 0 0 8px;
            font-size: 1.2rem;
            font-weight: 700;
        }

        .contact-card__text {
            margin: 0 0 16px;
            font-size: 0.98rem;
            color: var(--text-muted);
        }

        .contact-card__mail {
            display: inline-block;
            font-size: 1rem;
            font-weight: 600;
            color: #bcd0ff;
            text-decoration: none;
            word-break: break-all;
        }

        .contact-card__mail:hover {
            color: #ffffff;
        }
    </style>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="assets/images/logo.png" alt="AI LAB HUB">
        </a>
    </header>

    <main class="page">
        <h1 class="stub__title">Контакти</h1>
        <p class="stub__text">Оберіть, куди написати — і ми відповімо.</p>

        <div class="contact-grid">
            <section class="contact-card">
                <h2 class="contact-card__title">Для користувачів</h2>
                <p class="contact-card__text">
                    Питання щодо роботи платформи, пропозиції, повідомлення про проблему.
                </p>
                <a class="contact-card__mail" href="mailto:hello@ailabhub-directory.com">hello@ailabhub-directory.com</a>
            </section>

            <section class="contact-card">
                <h2 class="contact-card__title">Для партнерів</h2>
                <p class="contact-card__text">
                    Співпраця, розміщення AI-продукту, партнерські програми.
                </p>
                <a class="contact-card__mail" href="mailto:partners@ailabhub-directory.com">partners@ailabhub-directory.com</a>
            </section>
        </div>
    </main>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
