<?php

declare(strict_types=1);

/**
 * AI LAB HUB — вхід у акаунт.
 */

require_once __DIR__ . '/../app/auth.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

if (auth_check()) {
    header('Location: account.php');
    exit;
}

function e(mixed $value): string
{
    return htmlspecialchars((string) $value, ENT_QUOTES);
}

$error = null;
$old = ['email' => ''];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $old['email'] = trim((string) ($_POST['email'] ?? ''));
    $password = (string) ($_POST['password'] ?? '');

    $stmt = $pdo->prepare('SELECT id, password_hash, role FROM users WHERE email = :email');
    $stmt->execute([':email' => $old['email']]);
    $user = $stmt->fetch();

    if ($user !== false && password_verify($password, (string) $user['password_hash'])) {
        auth_login(['id' => (int) $user['id'], 'role' => $user['role']]);

        header('Location: account.php');
        exit;
    }

    $error = 'Невірний email або пароль';
}

?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — Вхід</title>
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

        .site-header__name {
            font-size: clamp(0.95rem, 3.5vw, 1.15rem);
            font-weight: 800;
            letter-spacing: 0.04em;
            line-height: 1;
            white-space: nowrap;
            color: #ffffff;
        }

        .page {
            max-width: 440px;
            margin: 0 auto;
            padding: 24px 24px 72px;
        }

        .auth-card {
            padding: 32px;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .auth-card__title {
            margin: 0 0 6px;
            font-size: clamp(1.5rem, 4vw, 2rem);
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .auth-card__sub {
            margin: 0 0 24px;
            color: var(--text-muted);
            font-size: 0.95rem;
        }

        .field {
            margin-bottom: 18px;
        }

        .field__label {
            display: block;
            margin-bottom: 7px;
            font-size: 0.9rem;
            font-weight: 700;
        }

        .input {
            width: 100%;
            padding: 12px 14px;
            border-radius: 10px;
            border: 1px solid rgba(255, 255, 255, 0.3);
            background: rgba(255, 255, 255, 0.08);
            color: #ffffff;
            font-size: 1rem;
            font-family: inherit;
        }

        .input:focus {
            outline: none;
            border-color: var(--accent);
            background: rgba(255, 255, 255, 0.12);
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            border-radius: 999px;
            font-size: 1rem;
            font-weight: 600;
            font-family: inherit;
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

        .btn--block {
            display: block;
            width: 100%;
            text-align: center;
        }

        .auth-card__foot {
            margin: 20px 0 0;
            font-size: 0.9rem;
            color: var(--text-muted);
            text-align: center;
        }

        .auth-card__foot a {
            color: #bcd0ff;
        }

        .notice {
            margin-bottom: 20px;
            padding: 14px 16px;
            border-radius: 12px;
            border: 1px solid rgba(252, 165, 165, 0.6);
            background: rgba(252, 165, 165, 0.12);
        }

        @media (max-width: 600px) {
            .site-header {
                justify-content: center;
                padding: 16px;
            }

            .auth-card {
                padding: 24px;
            }
        }
    </style>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="assets/images/logo.png" alt="AI LAB HUB">
            <span class="site-header__name">AI LAB HUB</span>
        </a>
    </header>

    <div class="page">
        <section class="auth-card">
            <h1 class="auth-card__title">Вхід</h1>
            <p class="auth-card__sub">Увійдіть, щоб перейти до свого кабінету.</p>

            <?php if ($error !== null): ?>
                <div class="notice"><?= e($error) ?></div>
            <?php endif; ?>

            <form method="post" action="login.php" novalidate>
                <div class="field">
                    <label class="field__label" for="email">Email</label>
                    <input class="input" type="email" id="email" name="email" value="<?= e($old['email']) ?>" required autofocus>
                </div>
                <div class="field">
                    <label class="field__label" for="password">Пароль</label>
                    <input class="input" type="password" id="password" name="password" required>
                </div>
                <button type="submit" class="btn btn--primary btn--block">Увійти</button>
            </form>

            <p class="auth-card__foot">Немає акаунта? <a href="register.php">Зареєструватися</a></p>
        </section>
    </div>
</body>
</html>
