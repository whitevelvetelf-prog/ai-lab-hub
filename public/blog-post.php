<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Блог: стаття.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/blog.php';

$slug = (string) ($_GET['slug'] ?? '');
$article = $slug !== '' ? blog_load_article($slug, current_lang()) : null;

?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <?php if ($article !== null): ?>
        <title><?= htmlspecialchars($article['title'], ENT_QUOTES) ?> — AI LAB HUB</title>
        <meta name="description" content="<?= htmlspecialchars($article['description'], ENT_QUOTES) ?>">
    <?php else: ?>
        <title><?= htmlspecialchars(t('blog_not_found'), ENT_QUOTES) ?> — AI LAB HUB</title>
    <?php endif; ?>
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

        /* Закріплена стрілка «назад»: лишається під закріпленою шапкою при
           прокрутці. --header-h (висота шапки) кладе app/footer.php; z-index
           нижчий за шапку/підвал (100), щоб не перекривати їх. */
        .back-link {
            position: sticky;
            top: calc(var(--header-h, 84px) + 8px);
            z-index: 90;
            display: inline-block;
            margin: 0 0 20px;
            padding: 6px 14px;
            border-radius: 999px;
            background: rgba(0, 3, 44, 0.85);
            border: 1px solid rgba(255, 255, 255, 0.14);
            -webkit-backdrop-filter: blur(10px);
            backdrop-filter: blur(10px);
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--text-muted);
            text-decoration: none;
        }

        .back-link:hover {
            color: #ffffff;
        }

        .stub__title {
            margin: 0 0 28px;
            font-size: clamp(1.8rem, 5vw, 2.6rem);
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .article h2 {
            margin: 36px 0 14px;
            font-size: 1.4rem;
            font-weight: 800;
        }

        .article h3 {
            margin: 28px 0 10px;
            font-size: 1.15rem;
            font-weight: 700;
        }

        .article p {
            margin: 0 0 16px;
            font-size: 1.02rem;
            color: var(--text-muted);
        }

        .article a {
            color: #bcd0ff;
            font-weight: 600;
        }

        .article a:hover {
            color: #ffffff;
        }

        .article strong {
            color: #ffffff;
        }

        .article ul {
            margin: 0 0 16px;
            padding-left: 20px;
            color: var(--text-muted);
        }

        .article li {
            margin-bottom: 8px;
        }

        .blog-table-wrap {
            overflow-x: auto;
            margin: 0 0 24px;
            border: 1px solid var(--card-border);
            border-radius: 12px;
        }

        .article table {
            width: 100%;
            border-collapse: collapse;
            font-size: 0.95rem;
        }

        .article th,
        .article td {
            padding: 12px 14px;
            text-align: left;
            border-bottom: 1px solid var(--card-border);
            white-space: nowrap;
        }

        .article thead th {
            background: rgba(255, 255, 255, 0.06);
            font-weight: 700;
        }

        .article tbody tr:last-child td {
            border-bottom: none;
        }

        .blog-not-found {
            color: var(--text-muted);
        }
    </style>
    <link rel="stylesheet" href="/assets/css/site-nav.css">
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/../app/site-header.php'; ?>

    <main class="page">
        <a class="back-link" href="blog.php"><?= htmlspecialchars(t('blog_back'), ENT_QUOTES) ?></a>

        <?php if ($article === null): ?>
            <h1 class="stub__title"><?= htmlspecialchars(t('blog_not_found'), ENT_QUOTES) ?></h1>
            <p class="blog-not-found"><?= htmlspecialchars(t('blog_not_found_text'), ENT_QUOTES) ?></p>
        <?php else: ?>
            <h1 class="stub__title"><?= htmlspecialchars($article['title'], ENT_QUOTES) ?></h1>
            <div class="article"><?= $article['html'] ?></div>
        <?php endif; ?>
    </main>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
