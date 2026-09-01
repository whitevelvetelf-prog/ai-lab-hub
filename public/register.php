<?php

declare(strict_types=1);

/**
 * AI LAB HUB — реєстрація нового користувача.
 *
 * Роль за замовчуванням — 'user'. Після успіху одразу входимо в акаунт
 * і перенаправляємо на account.php.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';

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

$errors = [];
$old = ['name' => '', 'email' => ''];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $old['name'] = trim((string) ($_POST['name'] ?? ''));
    $old['email'] = trim((string) ($_POST['email'] ?? ''));
    $password = (string) ($_POST['password'] ?? '');
    $passwordConfirm = (string) ($_POST['password_confirm'] ?? '');

    if ($old['name'] === '') {
        $errors[] = 'Вкажіть ім’я.';
    } elseif (mb_strlen($old['name']) > 255) {
        $errors[] = 'Ім’я задовге (максимум 255 символів).';
    }

    if ($old['email'] === '') {
        $errors[] = 'Вкажіть email.';
    } elseif (!filter_var($old['email'], FILTER_VALIDATE_EMAIL) || mb_strlen($old['email']) > 255) {
        $errors[] = 'Некоректний email.';
    }

    if (mb_strlen($password) < 8) {
        $errors[] = 'Пароль має містити щонайменше 8 символів.';
    }
    if ($password !== $passwordConfirm) {
        $errors[] = 'Паролі не збігаються.';
    }

    if ($errors === []) {
        $check = $pdo->prepare('SELECT id FROM users WHERE email = :email');
        $check->execute([':email' => $old['email']]);
        if ($check->fetch() !== false) {
            $errors[] = 'Користувач із таким email уже зареєстрований.';
        }
    }

    if ($errors === []) {
        try {
            $insert = $pdo->prepare(
                'INSERT INTO users (name, email, password_hash, role)
                 VALUES (:name, :email, :hash, :role)'
            );
            $insert->execute([
                ':name' => $old['name'],
                ':email' => $old['email'],
                ':hash' => password_hash($password, PASSWORD_DEFAULT),
                ':role' => 'user',
            ]);

            auth_login(['id' => (int) $pdo->lastInsertId(), 'role' => 'user']);

            header('Location: account.php');
            exit;
        } catch (PDOException $ex) {
            $errors[] = $ex->getCode() === '23000'
                ? 'Користувач із таким email уже зареєстрований.'
                : 'Не вдалося створити акаунт. Спробуйте ще раз.';
        }
    }
}

?>
<!DOCTYPE html>
<html lang="uk">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — Реєстрація</title>
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

        /* Поле пароля з кнопкою «Показати» */
        .pw-field {
            position: relative;
        }

        .pw-field .input {
            padding-right: 92px;
        }

        .pw-toggle {
            position: absolute;
            top: 50%;
            right: 8px;
            transform: translateY(-50%);
            padding: 6px 12px;
            border: 1px solid rgba(0, 0, 0, 0.25);
            border-radius: 8px;
            /* Світлий контрастний чип: помітний і на темному полі,
               і на світлому (автозаповнення) фоні незалежно від стану. */
            background: #dbe4ff;
            color: #00032c;
            font-family: inherit;
            font-size: 0.8rem;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.25);
            transition: background 0.15s ease, border-color 0.15s ease;
        }

        .pw-toggle:hover {
            background: #eaf0ff;
            border-color: var(--accent);
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

        .notice ul {
            margin: 0;
            padding-left: 20px;
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
        </a>
    </header>

    <div class="page">
        <section class="auth-card">
            <h1 class="auth-card__title">Реєстрація</h1>
            <p class="auth-card__sub">Створіть акаунт, щоб зберігати продукти та отримувати рекомендації від Елі.</p>

            <?php if ($errors !== []): ?>
                <div class="notice">
                    <ul>
                        <?php foreach ($errors as $error): ?>
                            <li><?= e($error) ?></li>
                        <?php endforeach; ?>
                    </ul>
                </div>
            <?php endif; ?>

            <form method="post" action="register.php" novalidate>
                <div class="field">
                    <label class="field__label" for="name">Ім’я</label>
                    <input class="input" type="text" id="name" name="name" value="<?= e($old['name']) ?>" required autofocus>
                </div>
                <div class="field">
                    <label class="field__label" for="email">Email</label>
                    <input class="input" type="email" id="email" name="email" value="<?= e($old['email']) ?>" required>
                </div>
                <div class="field">
                    <label class="field__label" for="password">Пароль</label>
                    <div class="pw-field">
                        <input class="input" type="password" id="password" name="password" minlength="8" required>
                        <button type="button" class="pw-toggle" data-pw-toggle="password" aria-label="Показати пароль">Показати</button>
                    </div>
                </div>
                <div class="field">
                    <label class="field__label" for="password_confirm">Підтвердження пароля</label>
                    <div class="pw-field">
                        <input class="input" type="password" id="password_confirm" name="password_confirm" minlength="8" required>
                        <button type="button" class="pw-toggle" data-pw-toggle="password_confirm" aria-label="Показати пароль">Показати</button>
                    </div>
                </div>
                <button type="submit" class="btn btn--primary btn--block">Зареєструватися</button>
            </form>

            <p class="auth-card__foot">Уже маєте акаунт? <a href="login.php">Увійти</a></p>
        </section>
    </div>

    <script>
        document.querySelectorAll('[data-pw-toggle]').forEach(function (btn) {
            btn.addEventListener('click', function () {
                var input = document.getElementById(btn.getAttribute('data-pw-toggle'));
                if (!input) {
                    return;
                }
                var reveal = input.type === 'password';
                input.type = reveal ? 'text' : 'password';
                btn.textContent = reveal ? 'Сховати' : 'Показати';
                btn.setAttribute('aria-label', (reveal ? 'Сховати' : 'Показати') + ' пароль');
            });
        });
    </script>
    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
