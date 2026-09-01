<?php

declare(strict_types=1);

/**
 * AI LAB HUB — кабінет користувача.
 *
 * Гість (немає сесії)  -> запрошення увійти / зареєструватися.
 * Авторизований        -> дані акаунта з таблиці users + вихід.
 */

require_once __DIR__ . '/../app/auth.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$user = auth_current_user($pdo);

function e(mixed $value): string
{
    return htmlspecialchars((string) $value, ENT_QUOTES);
}

/** Ініціали з імені для аватарки. */
function user_initials(string $name): string
{
    $parts = preg_split('/\s+/u', trim($name), -1, PREG_SPLIT_NO_EMPTY) ?: [];
    if (count($parts) >= 2) {
        return mb_strtoupper(mb_substr($parts[0], 0, 1) . mb_substr($parts[1], 0, 1));
    }

    return mb_strtoupper(mb_substr($name, 0, 2));
}

$roleLabels = [
    'user' => 'Користувач',
    'employee' => 'Співробітник',
    'admin' => 'Адміністратор',
];

?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — Кабінет</title>
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
            max-width: 720px;
            margin: 0 auto;
            padding: 24px 24px 72px;
        }

        .account-panel {
            padding: 32px;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .account-panel__title {
            margin: 0 0 12px;
            font-size: clamp(1.5rem, 4vw, 2rem);
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .account-panel__text {
            margin: 0 0 24px;
            font-size: 1.02rem;
            color: var(--text-muted);
            max-width: 46ch;
        }

        .btn-row {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 999px;
            font-size: 1rem;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            border: 1px solid transparent;
            transition: transform 0.15s ease, background 0.15s ease, border-color 0.15s ease;
        }

        .btn:active {
            transform: translateY(1px);
        }

        .btn--primary {
            background: #ffffff;
            color: #00032c;
        }

        .btn--primary:hover {
            background: rgba(255, 255, 255, 0.88);
        }

        .btn--ghost {
            background: transparent;
            color: #ffffff;
            border-color: rgba(255, 255, 255, 0.4);
        }

        .btn--ghost:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        /* Шапка авторизованого користувача */
        .account-user {
            display: flex;
            align-items: center;
            gap: 18px;
            margin-bottom: 24px;
        }

        .account-user__avatar {
            width: 64px;
            height: 64px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.35rem;
            font-weight: 800;
            letter-spacing: 0.02em;
            background: linear-gradient(135deg, #d97706, #fbbf24);
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.35);
            flex-shrink: 0;
        }

        .account-user__title {
            margin: 0 0 4px;
            font-size: clamp(1.4rem, 4vw, 1.9rem);
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .account-user__meta {
            margin: 0;
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .role-badge {
            display: inline-block;
            margin-left: 8px;
            padding: 2px 10px;
            border-radius: 999px;
            font-size: 0.72rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.06em;
            background: rgba(91, 140, 255, 0.2);
            border: 1px solid rgba(91, 140, 255, 0.5);
            vertical-align: middle;
        }

        .section {
            margin: 28px 0;
        }

        .section__title {
            margin: 0 0 12px;
            font-size: 1.15rem;
            font-weight: 700;
        }

        .empty-state {
            padding: 20px;
            border: 1px dashed var(--card-border);
            border-radius: 12px;
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        .empty-state a {
            color: #bcd0ff;
        }

        .staff-note {
            margin: 28px 0;
            padding: 16px 18px;
            border-radius: 12px;
            border: 1px solid rgba(52, 211, 153, 0.5);
            background: rgba(52, 211, 153, 0.12);
            font-size: 0.95rem;
        }

        .staff-note a {
            color: #bbf7d0;
            font-weight: 600;
        }

        @media (max-width: 600px) {
            .site-header {
                justify-content: center;
                padding: 16px;
                flex-wrap: wrap;
                gap: 12px;
            }

            .account-panel {
                padding: 24px;
            }
        }
    </style>
</head>
<body>
    <header class="site-header">
        <a href="index.php"><img class="site-header__logo" src="assets/images/logo.png" alt="AI LAB HUB"></a>
        <nav class="site-nav">
            <a class="site-nav__link" href="index.php">Головна</a>
            <?php if (auth_check()): ?>
            <a class="site-nav__link" href="account.php">Кабінет</a>
            <?php else: ?>
            <a class="site-nav__link" href="login.php">Увійти</a>
            <?php endif; ?>
            <a class="site-nav__link site-nav__link--cta" href="eli.php">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9.937 15.5A2 2 0 0 0 8.5 14.063l-6.135-1.582a.5.5 0 0 1 0-.962L8.5 9.936A2 2 0 0 0 9.937 8.5l1.582-6.135a.5.5 0 0 1 .962 0L14.063 8.5A2 2 0 0 0 15.5 9.937l6.135 1.581a.5.5 0 0 1 0 .964L15.5 14.063a2 2 0 0 0-1.437 1.437l-1.582 6.135a.5.5 0 0 1-.962 0z"/><path d="M20 3v4"/><path d="M22 5h-4"/><path d="M4 17v2"/><path d="M6 18H2"/></svg>
                Викликати Асистента
            </a>
        </nav>
    </header>

    <div class="page">
<?php if ($user === null): ?>
        <section class="account-panel">
            <h1 class="account-panel__title">Ваш кабінет</h1>
            <p class="account-panel__text">
                Увійдіть, щоб зберігати обрані продукти та отримати персональні
                рекомендації від Елі.
            </p>
            <div class="btn-row">
                <a class="btn btn--primary" href="login.php">Увійти</a>
                <a class="btn btn--ghost" href="register.php">Створити акаунт</a>
            </div>
        </section>
<?php else: ?>
        <section class="account-panel">
            <div class="account-user">
                <div class="account-user__avatar"><?= e(user_initials((string) $user['name'])) ?></div>
                <div>
                    <h1 class="account-user__title">
                        Вітаємо, <?= e($user['name']) ?><span class="role-badge"><?= e($roleLabels[$user['role']] ?? $user['role']) ?></span>
                    </h1>
                    <p class="account-user__meta"><?= e($user['email']) ?></p>
                </div>
            </div>

            <div class="section">
                <h2 class="section__title">Збережені продукти</h2>
                <div class="empty-state">
                    Ще немає збережених продуктів. Перегляньте <a href="catalog.php">каталог AI-інструментів</a>.
                </div>
            </div>

            <?php if (auth_has_role('employee', 'admin')): ?>
                <div class="staff-note">
                    Доступ до CRM: <a href="crm-add-product.php">додати новий AI-продукт</a>.
                </div>
            <?php endif; ?>

            <div class="btn-row">
                <a class="btn btn--ghost" href="logout.php">Вийти з акаунту</a>
            </div>
        </section>
<?php endif; ?>
    </div>
</body>
</html>
