<?php

declare(strict_types=1);

/**
 * AI LAB HUB — сторінка однієї категорії (?id={category_id}).
 *
 * Показує назву категорії та список її підкатегорій як картки-кнопки.
 * Кожна картка веде на перегляд продуктів підкатегорії
 * (catalog.php?subcategory={id}).
 */

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$categoryId = (int) ($_GET['id'] ?? 0);

$catStmt = $pdo->prepare("SELECT id, name FROM categories WHERE id = :id");
$catStmt->execute([':id' => $categoryId]);
$category = $catStmt->fetch();

$subcategories = [];
if ($category !== false) {
    $subStmt = $pdo->prepare(
        "SELECT id, name
         FROM subcategories
         WHERE category_id = :id
         ORDER BY id"
    );
    $subStmt->execute([':id' => $categoryId]);
    $subcategories = $subStmt->fetchAll();
}

// Палітра для карток підкатегорій (той самий стиль, що й напрямки на головній).
$cardColors = [
    'linear-gradient(135deg, #2116ad, #5b8cff)',
    'linear-gradient(135deg, #0f9d58, #34d399)',
    'linear-gradient(135deg, #db2777, #f472b6)',
    'linear-gradient(135deg, #d97706, #fbbf24)',
    'linear-gradient(135deg, #0891b2, #22d3ee)',
];

$pageTitle = $category !== false ? (string) $category['name'] : 'Категорію не знайдено';

?>
<!DOCTYPE html>
<html lang="uk">
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

        .site-header__logo {
            height: 42px;
            width: auto;
            display: block;
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
            font-size: 1.15rem;
            font-weight: 800;
            letter-spacing: 0.02em;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.35);
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
            }
        }
    </style>
</head>
<body>
    <header class="site-header">
        <a href="index.php"><img class="site-header__logo" src="assets/images/logo.png" alt="AI LAB HUB"></a>
    </header>

    <div class="page">
        <a class="back-link" href="index.php">← Усі напрямки</a>

<?php if ($category === false): ?>
        <h1 class="category__title">Категорію не знайдено</h1>
        <p class="category__empty">Напрямок із таким ідентифікатором відсутній.</p>
<?php else: ?>
        <h1 class="category__title"><?= htmlspecialchars((string) $category['name'], ENT_QUOTES) ?></h1>

        <?php if ($subcategories === []): ?>
        <p class="category__empty">У цьому напрямку поки немає підкатегорій.</p>
        <?php else: ?>
        <div class="subcategory-grid">
            <?php foreach ($subcategories as $i => $subcategory): ?>
                <?php
                $sid = (int) $subcategory['id'];
                $color = $cardColors[$i % count($cardColors)];
                ?>
                <a class="subcategory-card" href="catalog.php?subcategory=<?= $sid ?>">
                    <span class="subcategory-card__icon" style="background: <?= htmlspecialchars($color, ENT_QUOTES) ?>;">
                        <?= htmlspecialchars(mb_strtoupper(mb_substr((string) $subcategory['name'], 0, 2)), ENT_QUOTES) ?>
                    </span>
                    <h2 class="subcategory-card__name"><?= htmlspecialchars((string) $subcategory['name'], ENT_QUOTES) ?></h2>
                </a>
            <?php endforeach; ?>
        </div>
        <?php endif; ?>
<?php endif; ?>
    </div>
</body>
</html>
