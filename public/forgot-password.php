<?php

declare(strict_types=1);

/**
 * AI LAB HUB — «Забули пароль?»: вхід без пароля через одноразове
 * посилання на email (замість «скинути пароль на новий»).
 *
 * Незалежно від того, існує введений email у базі чи ні, користувач
 * бачить ОДНАКОВЕ повідомлення про успіх — інакше форма стає способом
 * перевірити, які email зареєстровані на сайті.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/mailer.php';

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

const TOKEN_TTL_MINUTES = 15;
const RATE_LIMIT_WINDOW_MINUTES = 15;
const RATE_LIMIT_MAX_REQUESTS = 3;

$submitted = false;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $submitted = true;
    $email = trim((string) ($_POST['email'] ?? ''));

    if ($email !== '' && filter_var($email, FILTER_VALIDATE_EMAIL)) {
        $stmt = $pdo->prepare('SELECT id, name, email FROM users WHERE email = :email');
        $stmt->execute([':email' => $email]);
        $user = $stmt->fetch();

        if ($user !== false) {
            $userId = (int) $user['id'];

            $countStmt = $pdo->prepare(
                'SELECT COUNT(*) FROM login_tokens
                 WHERE user_id = :uid AND created_at > (NOW() - INTERVAL :window MINUTE)'
            );
            $countStmt->bindValue(':uid', $userId, PDO::PARAM_INT);
            $countStmt->bindValue(':window', RATE_LIMIT_WINDOW_MINUTES, PDO::PARAM_INT);
            $countStmt->execute();
            $recentCount = (int) $countStmt->fetchColumn();

            if ($recentCount < RATE_LIMIT_MAX_REQUESTS) {
                // Анулюємо попередні невикористані токени — чинним лишається
                // лише останній надісланий лист.
                $invalidate = $pdo->prepare(
                    'UPDATE login_tokens SET used_at = NOW() WHERE user_id = :uid AND used_at IS NULL'
                );
                $invalidate->execute([':uid' => $userId]);

                $token = bin2hex(random_bytes(32));
                $insert = $pdo->prepare(
                    'INSERT INTO login_tokens (user_id, token, expires_at)
                     VALUES (:uid, :token, DATE_ADD(NOW(), INTERVAL :ttl MINUTE))'
                );
                $insert->bindValue(':uid', $userId, PDO::PARAM_INT);
                $insert->bindValue(':token', $token);
                $insert->bindValue(':ttl', TOKEN_TTL_MINUTES, PDO::PARAM_INT);
                $insert->execute();

                // Домен — лише з конфігурації (не з заголовка Host): див. mail_site_url().
                $link = mail_site_url() . '/login-via-token.php?token=' . $token;

                send_mail(
                    (string) $user['email'],
                    t('mail_login_subject'),
                    render_login_email_html((string) $user['name'], $link, TOKEN_TTL_MINUTES),
                    sprintf(t('mail_login_greeting'), (string) $user['name']) . "\n\n"
                        . t('mail_login_intro') . "\n" . $link . "\n\n"
                        . sprintf(t('mail_login_expiry'), TOKEN_TTL_MINUTES)
                );
            }
            // Ліміт вичерпано — мовчки нічого не робимо, відповідь однакова.
        }
        // Email не знайдено — мовчки нічого не робимо, відповідь однакова.
    }
    // Порожній/некоректний email — так само однакова відповідь, без винятків.
}

?>
<!DOCTYPE html>
<html lang="<?= htmlspecialchars(current_lang(), ENT_QUOTES) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= htmlspecialchars(t('title_forgot_password'), ENT_QUOTES) ?></title>
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
            border: 1px solid rgba(165, 214, 167, 0.6);
            background: rgba(165, 214, 167, 0.12);
        }

        .notice__hint {
            margin: 6px 0 0;
            font-size: 0.85rem;
            color: var(--text-muted);
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
            <h1 class="auth-card__title"><?= htmlspecialchars(t('forgot_heading'), ENT_QUOTES) ?></h1>

            <?php if ($submitted): ?>
                <div class="notice">
                    <?= e(t('forgot_success')) ?>
                    <p class="notice__hint"><?= e(t('forgot_success_hint')) ?></p>
                </div>
            <?php else: ?>
                <p class="auth-card__sub"><?= htmlspecialchars(t('forgot_subtitle'), ENT_QUOTES) ?></p>

                <form method="post" action="forgot-password.php" novalidate>
                    <div class="field">
                        <label class="field__label" for="email">Email</label>
                        <input class="input" type="email" id="email" name="email" required autofocus>
                    </div>
                    <button type="submit" class="btn btn--primary btn--block"><?= htmlspecialchars(t('forgot_submit'), ENT_QUOTES) ?></button>
                </form>
            <?php endif; ?>

            <p class="auth-card__foot"><a href="login.php"><?= htmlspecialchars(t('forgot_back_login'), ENT_QUOTES) ?></a></p>
        </section>
    </div>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
