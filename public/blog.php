<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Блог: список статей.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/blog.php';
require_once __DIR__ . '/../app/analytics.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

// Перегляд списку статей — для ємності місця реклами blog_list (page_slug 'blog').
analytics_log_view($pdo, 'other', null, 'blog');

// Фільтр за тематикою: ?cat={slug категорії}[&sub={slug підкатегорії}].
// Невідомі slug-и ігноруються — тоді показуються всі статті.
$taxonomy = blog_topic_taxonomy($pdo);
$cat = (string) ($_GET['cat'] ?? '');
if (!isset($taxonomy[$cat])) {
    $cat = '';
}
$sub = (string) ($_GET['sub'] ?? '');
if ($cat === '' || !isset($taxonomy[$cat]['subs'][$sub])) {
    $sub = '';
}

$allArticles = blog_list_articles(current_lang());
$articles = $cat === '' ? $allArticles : array_values(array_filter(
    $allArticles,
    static fn (array $a): bool => blog_article_has_topic($a['slug'], $cat, $sub)
));

/** Кількість статей у темі (для лічильників на кнопках фільтра). */
$topicCount = static fn (string $c, string $s = ''): int => count(array_filter(
    $allArticles,
    static fn (array $a): bool => blog_article_has_topic($a['slug'], $c, $s)
));

/** Підписи тем статті для картки: назва підкатегорії або, для теми-категорії, назва категорії. */
$topicLabels = static function (string $slug) use ($taxonomy): array {
    $labels = [];
    foreach (blog_article_topics($slug) as $topic) {
        $row = $topic['sub'] !== ''
            ? ($taxonomy[$topic['cat']]['subs'][$topic['sub']] ?? $taxonomy[$topic['cat']]['row'] ?? null)
            : ($taxonomy[$topic['cat']]['row'] ?? null);
        if ($row !== null) {
            $labels[localized_name($row)] = true;
        }
    }

    return array_keys($labels);
};

?>
<!DOCTYPE html>
<html lang="<?= htmlspecialchars(current_lang(), ENT_QUOTES) ?>">
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

        .blog-card__pending {
            margin: 10px 0 0;
            font-size: 0.85rem;
            color: var(--text-muted);
            font-style: italic;
        }

        .blog-empty {
            color: var(--text-muted);
        }

        .blog-topics {
            display: flex;
            flex-wrap: wrap;
            gap: 8px;
            margin: 0 0 14px;
        }

        .blog-topics--sub {
            margin-bottom: 28px;
            padding-left: 12px;
            border-left: 2px solid var(--card-border);
        }

        .blog-topics:last-of-type {
            margin-bottom: 28px;
        }

        .blog-topic {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border: 1px solid var(--card-border);
            border-radius: 999px;
            background: var(--card-bg);
            color: #ffffff;
            font-size: 0.92rem;
            text-decoration: none;
            transition: border-color 0.15s ease, background 0.15s ease;
        }

        .blog-topic:hover {
            border-color: rgba(255, 255, 255, 0.35);
        }

        .blog-topic.is-active {
            background: var(--accent);
            border-color: var(--accent);
        }

        .blog-topic__count {
            font-size: 0.8rem;
            color: var(--text-muted);
        }

        .blog-topic.is-active .blog-topic__count {
            color: #ffffff;
        }

        .blog-card__tags {
            display: flex;
            flex-wrap: wrap;
            gap: 6px;
            margin: 0 0 10px;
            padding: 0;
            list-style: none;
        }

        .blog-card__tag {
            padding: 2px 10px;
            border-radius: 999px;
            background: rgba(91, 140, 255, 0.18);
            color: #cfdcff;
            font-size: 0.78rem;
        }
    </style>
    <link rel="stylesheet" href="/assets/css/site-nav.css">
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/../app/site-header.php'; ?>

    <main class="page">
        <h1 class="stub__title"><?= htmlspecialchars(t('blog_heading'), ENT_QUOTES) ?></h1>
        <p class="stub__text"><?= htmlspecialchars(t('blog_subtitle'), ENT_QUOTES) ?></p>

        <?php if ($taxonomy !== []): ?>
            <nav class="blog-topics" aria-label="<?= htmlspecialchars(t('blog_topics_label'), ENT_QUOTES) ?>">
                <a class="blog-topic<?= $cat === '' ? ' is-active' : '' ?>" href="<?= htmlspecialchars(blog_topic_url(), ENT_QUOTES) ?>"<?= $cat === '' ? ' aria-current="page"' : '' ?>>
                    <?= htmlspecialchars(t('blog_topic_all'), ENT_QUOTES) ?>
                    <span class="blog-topic__count"><?= count($allArticles) ?></span>
                </a>
                <?php foreach ($taxonomy as $catSlug => $item): ?>
                    <?php $n = $topicCount($catSlug); if ($n === 0) { continue; } $active = $catSlug === $cat && $sub === ''; ?>
                    <a class="blog-topic<?= $catSlug === $cat ? ' is-active' : '' ?>" href="<?= htmlspecialchars(blog_topic_url($catSlug), ENT_QUOTES) ?>"<?= $active ? ' aria-current="page"' : '' ?>>
                        <?= htmlspecialchars(localized_name($item['row']), ENT_QUOTES) ?>
                        <span class="blog-topic__count"><?= $n ?></span>
                    </a>
                <?php endforeach; ?>
            </nav>

            <?php if ($cat !== '' && $taxonomy[$cat]['subs'] !== []): ?>
                <nav class="blog-topics blog-topics--sub" aria-label="<?= htmlspecialchars(localized_name($taxonomy[$cat]['row']), ENT_QUOTES) ?>">
                    <a class="blog-topic<?= $sub === '' ? ' is-active' : '' ?>" href="<?= htmlspecialchars(blog_topic_url($cat), ENT_QUOTES) ?>"<?= $sub === '' ? ' aria-current="page"' : '' ?>>
                        <?= htmlspecialchars(t('blog_topic_all_in_category'), ENT_QUOTES) ?>
                    </a>
                    <?php foreach ($taxonomy[$cat]['subs'] as $subSlug => $subRow): ?>
                        <a class="blog-topic<?= $subSlug === $sub ? ' is-active' : '' ?>" href="<?= htmlspecialchars(blog_topic_url($cat, $subSlug), ENT_QUOTES) ?>"<?= $subSlug === $sub ? ' aria-current="page"' : '' ?>>
                            <?= htmlspecialchars(localized_name($subRow), ENT_QUOTES) ?>
                            <span class="blog-topic__count"><?= $topicCount($cat, $subSlug) ?></span>
                        </a>
                    <?php endforeach; ?>
                </nav>
            <?php endif; ?>
        <?php endif; ?>

        <?php if ($articles === []): ?>
            <p class="blog-empty"><?= htmlspecialchars(t('blog_empty'), ENT_QUOTES) ?></p>
        <?php else: ?>
            <div class="blog-list">
                <?php foreach ($articles as $article): ?>
                    <a class="blog-card" href="<?= htmlspecialchars(blog_article_url($article['slug'], $article['lang']), ENT_QUOTES) ?>">
                        <?php $labels = $topicLabels($article['slug']); ?>
                        <?php if ($labels !== []): ?>
                            <ul class="blog-card__tags">
                                <?php foreach ($labels as $label): ?>
                                    <li class="blog-card__tag"><?= htmlspecialchars($label, ENT_QUOTES) ?></li>
                                <?php endforeach; ?>
                            </ul>
                        <?php endif; ?>
                        <h2 class="blog-card__title" lang="<?= htmlspecialchars($article['lang'], ENT_QUOTES) ?>"><?= htmlspecialchars($article['title'], ENT_QUOTES) ?></h2>
                        <p class="blog-card__text" lang="<?= htmlspecialchars($article['lang'], ENT_QUOTES) ?>"><?= htmlspecialchars($article['description'], ENT_QUOTES) ?></p>
                        <?php if ($article['lang'] !== current_lang()): ?>
                            <p class="blog-card__pending"><?= htmlspecialchars(t('blog_translation_pending'), ENT_QUOTES) ?></p>
                        <?php endif; ?>
                    </a>
                <?php endforeach; ?>
            </div>
        <?php endif; ?>
    </main>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
