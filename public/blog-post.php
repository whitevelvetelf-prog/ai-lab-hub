<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Блог: стаття.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/blog.php';

$slug = (string) ($_GET['slug'] ?? '');

// Мова статті — з URL (&hl=), не із сесії: кожна мовна версія має власну адресу.
$articleLang = blog_article_lang($slug, (string) ($_GET['hl'] ?? BLOG_DEFAULT_LANG));
$article = $slug !== '' ? blog_load_article($slug, $articleLang) : null;

$pageLang = current_lang();
if ($article !== null) {
    // Інтерфейс сайту (шапка, підвал, «До блогу») — тією ж мовою, що й стаття.
    set_lang($articleLang);
    $pageLang = $articleLang;
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
        <link rel="canonical" href="<?= htmlspecialchars(blog_article_url($slug, $articleLang, true), ENT_QUOTES) ?>">
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

        .lang-switch {
            display: inline-block;
            margin: 0 0 20px 16px;
            padding: 4px 12px;
            font-size: 0.9rem;
            font-weight: 600;
            color: #bcd0ff;
            text-decoration: none;
            border: 1px solid var(--card-border);
            border-radius: 999px;
        }

        .lang-switch:hover {
            color: #ffffff;
            border-color: #bcd0ff;
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
            <?php foreach (BLOG_LANG_SWITCH_LABELS[$articleLang] ?? [] as $targetLang => $label): ?>
                <?php if (in_array($targetLang, blog_article_langs($slug), true)): ?>
                    <a class="lang-switch" href="<?= htmlspecialchars(blog_article_url($slug, $targetLang), ENT_QUOTES) ?>" hreflang="<?= htmlspecialchars($targetLang, ENT_QUOTES) ?>" lang="<?= htmlspecialchars($targetLang, ENT_QUOTES) ?>"><?= htmlspecialchars($label, ENT_QUOTES) ?></a>
                <?php endif; ?>
            <?php endforeach; ?>
            <h1 class="stub__title"><?= htmlspecialchars($article['title'], ENT_QUOTES) ?></h1>
            <div class="article"><?= $article['html'] ?></div>
        <?php endif; ?>
    </main>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
