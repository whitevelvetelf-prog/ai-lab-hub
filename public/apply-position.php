<?php

declare(strict_types=1);

/**
 * AI LAB HUB — універсальна заявка на посаду (?token=...).
 *
 * Приватне посилання, яке власниця створює в кабінеті (public/account.php,
 * дія create_position_application) і надсилає кандидату особисто —
 * сторінки немає в навігації, meta robots заборонений нижче.
 *
 * Кандидат заповнює контакти. Email з форми НЕ обов'язково збігається з
 * будь-якою активною сесією (кандидат може взагалі не бути залогінений),
 * але акаунт з таким email має вже існувати — новий акаунт тут не
 * створюється (рішення власниці: спершу реєстрація на сайті). Якщо
 * акаунта нема — форма показує помилку й посилання на register.php,
 * заявку можна дозаповнити повторно за тим самим токеном.
 *
 * Підтверджує заявку (видає роль admin) чинний адміністратор у своєму
 * кабінеті — не ця сторінка.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

function e(mixed $value): string
{
    return htmlspecialchars((string) $value, ENT_QUOTES);
}

$token = (string) ($_GET['token'] ?? $_POST['token'] ?? '');
$app = null;

if (preg_match('/^[0-9a-f]{64}$/', $token) === 1) {
    $stmt = $pdo->prepare(
        "SELECT id, position_title, status FROM position_applications WHERE token = :token"
    );
    $stmt->execute([':token' => $token]);
    $app = $stmt->fetch() ?: null;
}

$invalid = ($app === null || $app['status'] !== 'pending');
$submitted = false;
$errors = [];
$noAccountEmail = null;
$old = ['last_name' => '', 'first_name' => '', 'email' => '', 'phone' => ''];

if (!$invalid && $_SERVER['REQUEST_METHOD'] === 'POST') {
    $old['last_name'] = trim((string) ($_POST['last_name'] ?? ''));
    $old['first_name'] = trim((string) ($_POST['first_name'] ?? ''));
    $old['email'] = trim((string) ($_POST['email'] ?? ''));
    $old['phone'] = trim((string) ($_POST['phone'] ?? ''));

    if ($old['last_name'] === '' || $old['first_name'] === '' || $old['email'] === '' || $old['phone'] === '') {
        $errors[] = t('apply_director_err_required');
    } elseif (!filter_var($old['email'], FILTER_VALIDATE_EMAIL)) {
        $errors[] = t('apply_director_err_email_invalid');
    } elseif (mb_strlen($old['last_name']) > 255 || mb_strlen($old['first_name']) > 255 || mb_strlen($old['phone']) > 32) {
        $errors[] = t('apply_director_err_too_long');
    }

    if ($errors === []) {
        $userCheck = $pdo->prepare('SELECT id FROM users WHERE email = :email');
        $userCheck->execute([':email' => $old['email']]);
        if ($userCheck->fetch() === false) {
            $noAccountEmail = $old['email'];
        }
    }

    if ($errors === [] && $noAccountEmail === null) {
        try {
            $upd = $pdo->prepare(
                "UPDATE position_applications
                    SET last_name = :ln, first_name = :fn, email = :em, phone = :ph,
                        status = 'submitted', submitted_at = NOW()
                  WHERE id = :id AND status = 'pending'"
            );
            $upd->execute([
                ':ln' => $old['last_name'],
                ':fn' => $old['first_name'],
                ':em' => $old['email'],
                ':ph' => $old['phone'],
                ':id' => (int) $app['id'],
            ]);

            if ($upd->rowCount() === 1) {
                $submitted = true;
            } else {
                // Хтось інший встиг заповнити цю саму заявку паралельно.
                $invalid = true;
            }
        } catch (PDOException $ex) {
            $errors[] = t('saved_error');
        }
    }
}

?>
<!DOCTYPE html>
<html lang="<?= htmlspecialchars(current_lang(), ENT_QUOTES) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="robots" content="noindex, nofollow">
    <title><?= htmlspecialchars(t('title_apply_position'), ENT_QUOTES) ?></title>
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
            max-width: 480px;
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

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 16px;
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
            transition: transform 0.15s ease, background 0.15s ease;
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

        .notice {
            margin-bottom: 20px;
            padding: 14px 16px;
            border-radius: 12px;
            border: 1px solid rgba(252, 165, 165, 0.6);
            background: rgba(252, 165, 165, 0.12);
        }

        .notice--ok {
            border-color: rgba(165, 214, 167, 0.6);
            background: rgba(165, 214, 167, 0.12);
        }

        .notice a {
            color: #bcd0ff;
        }

        .notice ul {
            margin: 0;
            padding-left: 18px;
        }

        @media (max-width: 600px) {
            .site-header {
                justify-content: center;
                padding: 16px;
            }

            .auth-card {
                padding: 24px;
            }

            .form-row {
                grid-template-columns: 1fr;
                gap: 0;
            }
        }
    </style>
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="/logo.png" alt="AI LAB HUB">
        </a>
    </header>

    <div class="page">
        <section class="auth-card">
            <?php if ($invalid): ?>
                <h1 class="auth-card__title"><?= htmlspecialchars(t('token_invalid_title'), ENT_QUOTES) ?></h1>
                <p class="auth-card__sub"><?= htmlspecialchars(t('token_invalid_text'), ENT_QUOTES) ?></p>
            <?php elseif ($submitted): ?>
                <h1 class="auth-card__title"><?= htmlspecialchars(t('apply_position_thanks_title'), ENT_QUOTES) ?></h1>
                <p class="auth-card__sub"><?= htmlspecialchars(t('apply_position_thanks_text'), ENT_QUOTES) ?></p>
            <?php else: ?>
                <h1 class="auth-card__title"><?= e($app['position_title']) ?></h1>
                <p class="auth-card__sub"><?= htmlspecialchars(t('apply_position_intro'), ENT_QUOTES) ?></p>

                <?php if ($errors !== []): ?>
                    <div class="notice">
                        <ul>
                            <?php foreach ($errors as $err): ?>
                                <li><?= e($err) ?></li>
                            <?php endforeach; ?>
                        </ul>
                    </div>
                <?php elseif ($noAccountEmail !== null): ?>
                    <div class="notice">
                        <?= htmlspecialchars(t('apply_position_no_account_error'), ENT_QUOTES) ?>
                        <a href="register.php"><?= htmlspecialchars(t('action_register'), ENT_QUOTES) ?></a>
                    </div>
                <?php endif; ?>

                <form method="post" action="apply-position.php" novalidate>
                    <input type="hidden" name="token" value="<?= e($token) ?>">
                    <div class="form-row">
                        <div class="field">
                            <label class="field__label" for="last_name"><?= htmlspecialchars(t('apply_director_last_name'), ENT_QUOTES) ?></label>
                            <input class="input" type="text" id="last_name" name="last_name" value="<?= e($old['last_name']) ?>" maxlength="255" required>
                        </div>
                        <div class="field">
                            <label class="field__label" for="first_name"><?= htmlspecialchars(t('apply_director_first_name'), ENT_QUOTES) ?></label>
                            <input class="input" type="text" id="first_name" name="first_name" value="<?= e($old['first_name']) ?>" maxlength="255" required>
                        </div>
                    </div>
                    <div class="field">
                        <label class="field__label" for="email"><?= htmlspecialchars(t('apply_director_email'), ENT_QUOTES) ?></label>
                        <input class="input" type="email" id="email" name="email" value="<?= e($old['email']) ?>" required>
                    </div>
                    <div class="field">
                        <label class="field__label" for="phone"><?= htmlspecialchars(t('apply_director_phone'), ENT_QUOTES) ?></label>
                        <input class="input" type="tel" id="phone" name="phone" value="<?= e($old['phone']) ?>" maxlength="32" required>
                    </div>
                    <button type="submit" class="btn btn--primary btn--block"><?= htmlspecialchars(t('apply_position_submit'), ENT_QUOTES) ?></button>
                </form>
            <?php endif; ?>
        </section>
    </div>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
