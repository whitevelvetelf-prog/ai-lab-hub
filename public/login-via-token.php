<?php

declare(strict_types=1);

/**
 * AI LAB HUB — вхід за одноразовим посиланням (magic link) із листа
 * «Забули пароль?» (public/forgot-password.php).
 *
 * ?token=... — 64 hex-символи (bin2hex(random_bytes(32))). «Забирає»
 * токен атомарним UPDATE ... WHERE used_at IS NULL AND expires_at > NOW()
 * замість SELECT-потім-UPDATE: без цього паралельний повторний запит
 * (подвійний клік, поштовий сканер, що йде за посиланням наперед) міг би
 * встигнути залогінитись обома запитами одним і тим самим токеном.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

if (auth_check()) {
    header('Location: account.php');
    exit;
}

$token = (string) ($_GET['token'] ?? '');

if (preg_match('/^[0-9a-f]{64}$/', $token) === 1) {
    $claim = $pdo->prepare(
        'UPDATE login_tokens
         SET used_at = NOW()
         WHERE token = :token AND used_at IS NULL AND expires_at > NOW()'
    );
    $claim->execute([':token' => $token]);

    if ($claim->rowCount() === 1) {
        $userStmt = $pdo->prepare(
            'SELECT lt.user_id, u.role
             FROM login_tokens lt
             JOIN users u ON u.id = lt.user_id
             WHERE lt.token = :token'
        );
        $userStmt->execute([':token' => $token]);
        $row = $userStmt->fetch();

        if ($row !== false) {
            auth_login(['id' => (int) $row['user_id'], 'role' => $row['role']]);

            header('Location: account.php');
            exit;
        }
    }
}

?>
<!DOCTYPE html>
<html lang="<?= htmlspecialchars(current_lang(), ENT_QUOTES) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= htmlspecialchars(t('token_invalid_title'), ENT_QUOTES) ?></title>
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
            text-align: center;
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
            <h1 class="auth-card__title"><?= htmlspecialchars(t('token_invalid_title'), ENT_QUOTES) ?></h1>
            <p class="auth-card__sub"><?= htmlspecialchars(t('token_invalid_text'), ENT_QUOTES) ?></p>
            <a class="btn btn--primary" href="forgot-password.php"><?= htmlspecialchars(t('token_invalid_retry'), ENT_QUOTES) ?></a>
        </section>
    </div>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
