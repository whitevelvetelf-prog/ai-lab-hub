<?php

declare(strict_types=1);

/**
 * AI LAB HUB — сторінка однієї категорії (?id={category_id}).
 *
 * Показує назву категорії та список її підкатегорій як картки-кнопки.
 * Кожна картка веде на перегляд продуктів підкатегорії
 * (catalog.php?subcategory={id}).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$categoryId = (int) ($_GET['id'] ?? 0);

$catStmt = $pdo->prepare("SELECT id, name, slug FROM categories WHERE id = :id");
$catStmt->execute([':id' => $categoryId]);
$category = $catStmt->fetch();

$subcategories = [];
if ($category !== false) {
    $subStmt = $pdo->prepare(
        "SELECT id, name, slug
         FROM subcategories
         WHERE category_id = :id
         ORDER BY id"
    );
    $subStmt->execute([':id' => $categoryId]);
    $subcategories = $subStmt->fetchAll();
}

/**
 * Тематичні піктограми Lucide (за slug). Перелік: https://lucide.dev/icons/
 * $categoryIcons — запасний варіант для підкатегорії без власної іконки.
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

$subcategoryIcons = [
    // Мультимедіа
    'video-generation'   => 'video',
    'image-generation'   => 'image',
    'voiceover'          => 'mic',
    'audio'              => 'volume-2',
    'photography'        => 'camera',
    'video-editing'      => 'clapperboard',
    'music'              => 'music',
    '3d-animation'       => 'box',
    // Текст та Чат-боти
    'notes'              => 'sticky-note',
    'chatbots'           => 'bot',
    'copywriting'        => 'pen-tool',
    'publications'       => 'newspaper',
    // Розробка та IT
    'code-assistants'    => 'terminal',
    'refactoring'        => 'git-branch',
    'code-autocomplete'  => 'braces',
    'web-development'     => 'globe',
    'mobile-development'  => 'smartphone',
    'databases'          => 'database',
    'cloud-services'     => 'cloud',
    'testing'            => 'bug',
    'api'                => 'webhook',
    // Бізнес та маркетинг
    'advertising'        => 'megaphone',
    'meeting-summaries'  => 'clipboard-list',
    'smm'                => 'share-2',
    'analytics'          => 'line-chart',
    'lead-generation'    => 'user-plus',
    'email-marketing'    => 'mail',
    'e-commerce'         => 'shopping-cart',
    'crm'                => 'users',
    // Дані та аналітика
    'sql-queries'        => 'table',
    'data-visualization' => 'pie-chart',
    'reports'            => 'file-text',
    // Продуктивність
    'planning'           => 'list-todo',
    'goal-management'    => 'target',
    'storage'            => 'hard-drive',
    'calendar'           => 'calendar',
    'time-management'    => 'clock',
    // SEO та контент
    'seo'                => 'search',
    'hashtags'           => 'hash',
    'link-building'      => 'link',
    'trends'             => 'trending-up',
    // Дизайн та креатив
    'graphic-design'     => 'palette',
    'ui-ux'              => 'layout-dashboard',
    'typography'         => 'type',
    'colors'             => 'droplet',
    'data-analysis'      => 'bar-chart-3',
    // Освіта та знання
    'courses'            => 'book-open',
    'certificates'       => 'award',
    'mentorship'         => 'user-check',
    'library'            => 'library',
    'tests'              => 'clipboard-check',
    // Переклад та мови
    'translation'        => 'languages',
    'dictionary'         => 'book',
    'speech-recognition' => 'mic',
    'subtitles'          => 'captions',
    // Фінанси та юридичні
    'finance'            => 'wallet',
    'investments'        => 'trending-up',
    'payments'           => 'credit-card',
    'legal-services'     => 'scale',
    'documents'          => 'file-text',
    'data-security'      => 'shield',
    // Здоровʼя та краса
    'medicine'           => 'stethoscope',
    'beauty-style'       => 'sparkles',
    'sports-fitness'     => 'dumbbell',
    // Інструменти та автоматизація
    'plugins'            => 'puzzle',
    'automation'         => 'zap',
    'integrations'       => 'plug',
    'navigation'         => 'compass',
];

$pageTitle = $category !== false ? (string) $category['name'] : t('category_not_found');

?>
<!DOCTYPE html>
<html lang="<?= htmlspecialchars(current_lang(), ENT_QUOTES) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — <?= htmlspecialchars($pageTitle, ENT_QUOTES) ?></title>
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

        .page {
            max-width: 1080px;
            margin: 0 auto;
            padding: 24px 24px 72px;
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

        .category__title {
            margin: 0 0 32px;
            font-size: clamp(1.8rem, 5vw, 2.6rem);
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .category__empty {
            color: var(--text-muted);
        }

        /* Сітка карток підкатегорій: 3 / 2 / 1 колонки */
        .subcategory-grid {
            display: grid;
            gap: 20px;
            grid-template-columns: repeat(3, 1fr);
        }

        @media (max-width: 900px) {
            .subcategory-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 560px) {
            .subcategory-grid {
                grid-template-columns: 1fr;
            }
        }

        /* Картка-кнопка підкатегорії — той самий стиль, що й напрямки на головній */
        .subcategory-card {
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

        .subcategory-card:hover {
            transform: translateY(-3px);
            border-color: rgba(91, 140, 255, 0.5);
        }

        .subcategory-card__icon {
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

        .subcategory-card__icon svg {
            width: 26px;
            height: 26px;
        }

        .subcategory-card__name {
            margin: 0;
            font-size: 1.2rem;
            font-weight: 700;
        }

        @media (max-width: 600px) {
            .site-header {
                justify-content: center;
                padding: 16px;
                flex-wrap: wrap;
                gap: 12px;
            }
        }
    </style>
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="assets/images/logo.png" alt="AI LAB HUB">
        </a>
        <nav class="site-nav" id="siteNav">
            <a class="site-nav__link" href="index.php"><?= htmlspecialchars(t('nav_home'), ENT_QUOTES) ?></a>
            <?php if (auth_check()): ?>
            <a class="site-nav__link" href="account.php"><?= htmlspecialchars(t('nav_account'), ENT_QUOTES) ?></a>
            <?php else: ?>
            <a class="site-nav__link" href="login.php"><?= htmlspecialchars(t('nav_login'), ENT_QUOTES) ?></a>
            <?php endif; ?>
        </nav>
        <a class="site-nav__link site-nav__link--cta site-header__cta" href="eli.php">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9.937 15.5A2 2 0 0 0 8.5 14.063l-6.135-1.582a.5.5 0 0 1 0-.962L8.5 9.936A2 2 0 0 0 9.937 8.5l1.582-6.135a.5.5 0 0 1 .962 0L14.063 8.5A2 2 0 0 0 15.5 9.937l6.135 1.581a.5.5 0 0 1 0 .964L15.5 14.063a2 2 0 0 0-1.437 1.437l-1.582 6.135a.5.5 0 0 1-.962 0z"/><path d="M20 3v4"/><path d="M22 5h-4"/><path d="M4 17v2"/><path d="M6 18H2"/></svg>
            <?= htmlspecialchars(t('nav_assistant'), ENT_QUOTES) ?>
        </a>
        <button class="site-nav__toggle" type="button" aria-label="<?= htmlspecialchars(t('nav_menu'), ENT_QUOTES) ?>" aria-expanded="false" aria-controls="siteNav">
            <span></span>
            <span></span>
            <span></span>
        </button>
    </header>

    <div class="page">
        <a class="back-link" href="index.php"><?= htmlspecialchars(t('back_to_all_directions'), ENT_QUOTES) ?></a>

<?php if ($category === false): ?>
        <h1 class="category__title"><?= htmlspecialchars(t('category_not_found'), ENT_QUOTES) ?></h1>
        <p class="category__empty"><?= htmlspecialchars(t('category_not_found_text'), ENT_QUOTES) ?></p>
<?php else: ?>
        <h1 class="category__title"><?= htmlspecialchars((string) $category['name'], ENT_QUOTES) ?></h1>

        <?php if ($subcategories === []): ?>
        <p class="category__empty"><?= htmlspecialchars(t('category_empty'), ENT_QUOTES) ?></p>
        <?php else: ?>
        <div class="subcategory-grid">
            <?php foreach ($subcategories as $subcategory): ?>
                <?php
                $sid = (int) $subcategory['id'];
                $icon = $subcategoryIcons[$subcategory['slug']]
                    ?? $categoryIcons[$category['slug']]
                    ?? 'shapes';
                ?>
                <a class="subcategory-card" href="catalog.php?subcategory=<?= $sid ?>">
                    <span class="subcategory-card__icon">
                        <i data-lucide="<?= htmlspecialchars($icon, ENT_QUOTES) ?>"></i>
                    </span>
                    <h2 class="subcategory-card__name"><?= htmlspecialchars((string) $subcategory['name'], ENT_QUOTES) ?></h2>
                </a>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>
<?php endif; ?>
    </div>

    <script src="https://unpkg.com/lucide@latest"></script>
    <script>lucide.createIcons();</script>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
