<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Блог: список статей.
 */

require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/blog.php';

$articles = blog_list_articles(current_lang());

?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= htmlspecialchars(t('title_blog'), ENT_QUOTES) ?></title>
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
            margin: 0 0 32px;
            font-size: 1.05rem;
            color: var(--text-muted);
        }

        .blog-list {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        .blog-card {
            display: block;
            padding: 24px;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 16px;
            text-decoration: none;
            color: #ffffff;
            transition: border-color 0.15s ease, background 0.15s ease;
        }

        .blog-card:hover {
            border-color: rgba(255, 255, 255, 0.3);
            background: rgba(255, 255, 255, 0.08);
        }

        .blog-card__title {
            margin: 0 0 8px;
            font-size: 1.2rem;
            font-weight: 700;
        }

        .blog-card__text {
            margin: 0;
            font-size: 0.98rem;
            color: var(--text-muted);
        }

        .blog-empty {
            color: var(--text-muted);
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
        <h1 class="stub__title"><?= htmlspecialchars(t('blog_heading'), ENT_QUOTES) ?></h1>
        <p class="stub__text"><?= htmlspecialchars(t('blog_subtitle'), ENT_QUOTES) ?></p>

        <?php if ($articles === []): ?>
            <p class="blog-empty"><?= htmlspecialchars(t('blog_empty'), ENT_QUOTES) ?></p>
        <?php else: ?>
            <div class="blog-list">
                <?php foreach ($articles as $article): ?>
                    <a class="blog-card" href="blog-post.php?slug=<?= urlencode($article['slug']) ?>">
                        <h2 class="blog-card__title"><?= htmlspecialchars($article['title'], ENT_QUOTES) ?></h2>
                        <p class="blog-card__text"><?= htmlspecialchars($article['description'], ENT_QUOTES) ?></p>
                    </a>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </main>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
