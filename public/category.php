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
require_once __DIR__ . '/../app/analytics.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$categoryId = (int) ($_GET['id'] ?? 0);

$catStmt = $pdo->prepare("SELECT id, name, name_en, slug FROM categories WHERE id = :id");
$catStmt->execute([':id' => $categoryId]);
$category = $catStmt->fetch();

$subcategories = [];
$otherCategories = [];
if ($category !== false) {
    analytics_log_view($pdo, 'category', (int) $category['id']);

    $subStmt = $pdo->prepare(
        "SELECT id, name, name_en, slug
         FROM subcategories
         WHERE category_id = :id
         ORDER BY id"
    );
    $subStmt->execute([':id' => $categoryId]);
    $subcategories = $subStmt->fetchAll();

    // «Інші категорії» під списком підкатегорій — щоб сторінка не
    // закінчувалась одразу після кількох карток. Порядок — як на головній.
    $otherStmt = $pdo->prepare(
        "SELECT id, name, name_en, slug
         FROM categories
         WHERE id <> :id
         ORDER BY id"
    );
    $otherStmt->execute([':id' => $categoryId]);
    $otherCategories = $otherStmt->fetchAll();
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

$pageTitle = $category !== false ? localized_name($category) : t('category_not_found');

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

        /* «Інші категорії» — компактні «пігулки» з іконкою, що переносяться
           в рядки: не розтягують сторінку так, як великі картки. */
        .other-categories {
            margin-top: 48px;
        }

        .other-categories__title {
            margin: 0 0 16px;
            font-size: 1.3rem;
            font-weight: 800;
        }

        .other-categories__list {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin: 0;
            padding: 0;
            list-style: none;
        }

        .other-categories__link {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 9px 16px;
            border-radius: 999px;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            color: #ffffff;
            font-size: 0.92rem;
            font-weight: 600;
            text-decoration: none;
            transition: border-color 0.15s ease, background 0.15s ease;
        }

        .other-categories__link:hover {
            border-color: rgba(91, 140, 255, 0.5);
            background: rgba(91, 140, 255, 0.12);
        }

        .other-categories__link svg {
            width: 16px;
            height: 16px;
            color: var(--accent);
            flex-shrink: 0;
        }

        /* Мобільний: дві рівні колонки — у ряд по одній «пігулці» (~180px
           на 316px) блок розтягувався до ~700px. Довга назва переноситься. */
        @media (max-width: 560px) {
            .other-categories {
                margin-top: 36px;
            }

            .other-categories__list {
                display: grid;
                grid-template-columns: repeat(2, minmax(0, 1fr));
                gap: 8px;
            }

            .other-categories__link {
                display: flex;
                height: 100%;
                padding: 8px 12px;
                border-radius: 14px;
                font-size: 0.85rem;
                line-height: 1.3;
            }
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
    <?php include __DIR__ . '/../app/site-header.php'; ?>

    <div class="page">
        <a class="back-link" href="index.php"><?= htmlspecialchars(t('back_to_all_directions'), ENT_QUOTES) ?></a>

<?php if ($category === false): ?>
        <h1 class="category__title"><?= htmlspecialchars(t('category_not_found'), ENT_QUOTES) ?></h1>
        <p class="category__empty"><?= htmlspecialchars(t('category_not_found_text'), ENT_QUOTES) ?></p>
<?php else: ?>
        <h1 class="category__title"><?= htmlspecialchars(localized_name($category), ENT_QUOTES) ?></h1>

        <?php $zoneId = 1; /* «Сторінка категорії - верх» */ include __DIR__ . '/../app/ad-banner.php'; ?>

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
                    <h2 class="subcategory-card__name"><?= htmlspecialchars(localized_name($subcategory), ENT_QUOTES) ?></h2>
                </a>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>

        <?php if ($otherCategories !== []): ?>
        <nav class="other-categories" aria-labelledby="otherCategoriesTitle">
            <h2 class="other-categories__title" id="otherCategoriesTitle"><?= htmlspecialchars(t('category_others'), ENT_QUOTES) ?></h2>
            <ul class="other-categories__list">
                <?php foreach ($otherCategories as $other): ?>
                <li>
                    <a class="other-categories__link" href="category.php?id=<?= (int) $other['id'] ?>">
                        <i data-lucide="<?= htmlspecialchars($categoryIcons[$other['slug']] ?? 'shapes', ENT_QUOTES) ?>"></i>
                        <?= htmlspecialchars(localized_name($other), ENT_QUOTES) ?>
                    </a>
                </li>
                <?php endforeach; ?>
            </ul>
        </nav>
        <?php endif; ?>
<?php endif; ?>
    </div>

    <script src="https://unpkg.com/lucide@latest"></script>
    <script>lucide.createIcons();</script>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
