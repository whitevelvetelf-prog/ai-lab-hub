<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Блог: стаття.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/blog.php';
require_once __DIR__ . '/../app/analytics.php';

$slug = (string) ($_GET['slug'] ?? '');

// Мова статті = мова сайту (глобальний перемикач UA/EN у шапці).
// &hl= — адреса мовної версії для пошуковиків (hreflang/sitemap): відкриття
// такої адреси вмикає цю мову для всього сайту; перемикач у шапці прибирає hl.
if (isset($_GET['hl'])) {
    set_lang((string) $_GET['hl']);
}

$pageLang = current_lang();
$article = $slug !== '' ? blog_load_article($slug, $pageLang) : null;
// Перекладу цією мовою ще немає — показуємо оригінал із позначкою.
$translationPending = $article !== null && $article['lang'] !== $pageLang;

if ($article !== null) {
    // Перегляд статті — у спільну аналітику (page_views, тип 'article').
    // Статті живуть у файлах, а не в БД, тож замість page_id — slug:
    // admin-stats.php рахує загальну суму й топ статей (усі мовні версії разом).
    /** @var PDO $pdo */
    $pdo = require __DIR__ . '/../config/database.php';
    analytics_log_view($pdo, 'article', null, $slug);
}

?>
<!DOCTYPE html>
<html lang="<?= htmlspecialchars($pageLang, ENT_QUOTES) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <?php if ($article !== null): ?>
        <title><?= htmlspecialchars($article['title'], ENT_QUOTES) ?> — AI LAB HUB</title>
        <meta name="description" content="<?= htmlspecialchars($article['description'], ENT_QUOTES) ?>">
        <link rel="canonical" href="<?= htmlspecialchars(blog_article_url($slug, $article['lang'], true), ENT_QUOTES) ?>">
        <?php foreach (blog_article_langs($slug) as $altLang): ?>
            <link rel="alternate" hreflang="<?= htmlspecialchars($altLang, ENT_QUOTES) ?>" href="<?= htmlspecialchars(blog_article_url($slug, $altLang, true), ENT_QUOTES) ?>">
        <?php endforeach; ?>
        <link rel="alternate" hreflang="x-default" href="<?= htmlspecialchars(blog_article_url($slug, BLOG_DEFAULT_LANG, true), ENT_QUOTES) ?>">
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

        .back-link {
            display: inline-block;
            margin: 0 0 20px;
            font-size: 0.95rem;
            font-weight: 600;
            color: var(--text-muted);
            text-decoration: none;
        }

        .back-link:hover {
            color: #ffffff;
        }

        .translation-pending {
            margin: 0 0 20px;
            padding: 10px 14px;
            font-size: 0.95rem;
            color: var(--text-muted);
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 10px;
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

        .article hr {
            margin: 32px 0 24px;
            border: 0;
            border-top: 1px solid var(--card-border);
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
            <?php if ($translationPending): ?>
                <p class="translation-pending"><?= htmlspecialchars(t('blog_translation_pending'), ENT_QUOTES) ?></p>
            <?php endif; ?>
            <h1 class="stub__title" lang="<?= htmlspecialchars($article['lang'], ENT_QUOTES) ?>"><?= htmlspecialchars($article['title'], ENT_QUOTES) ?></h1>
            <div class="article" lang="<?= htmlspecialchars($article['lang'], ENT_QUOTES) ?>"><?= $article['html'] ?></div>
        <?php endif; ?>
    </main>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
