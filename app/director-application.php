<?php

declare(strict_types=1);

/**
 * AI LAB HUB — приватна заявка на посаду директора (спільний шаблон).
 *
 * Підключають дві тонкі сторінки, кожна лише задає посаду:
 *   public/apply-ceo.php            -> $directorPositionKey = 'ceo';
 *   public/apply-exec-director.php  -> $directorPositionKey = 'exec_director';
 *
 * Доступ лише за прямим посиланням (ніде на сайті не рекламується) і лише
 * авторизованим користувачам (гість -> login.php). Поля: Ім'я, Прізвище,
 * Телефон, Email. Email обов'язково має збігатися з email акаунта.
 * Створює запис у admin_requests зі статусом pending; підтверджує лише
 * власниця проєкту в кабінеті (account.php).
 *
 * @var string $directorPositionKey  Ключ посади ('ceo' | 'exec_director').
 */

require_once __DIR__ . '/auth.php';
require_once __DIR__ . '/translations.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

if (!auth_check()) {
    header('Location: login.php');
    exit;
}

$user = auth_current_user($pdo);
if ($user === null) {
    header('Location: login.php');
    exit;
}

$positionKey = $directorPositionKey ?? '';
$positionLabel = director_position_label($positionKey);
if ($positionLabel === null) {
    // Некоректне підключення шаблону — не показуємо форму.
    http_response_code(500);
    exit('Unknown position');
}

$selfUrl = basename((string) ($_SERVER['SCRIPT_NAME'] ?? 'account.php'));

if (!function_exists('e')) {
    function e(mixed $value): string
    {
        return htmlspecialchars((string) $value, ENT_QUOTES);
    }
}

$errors = [];
$old = ['first_name' => '', 'last_name' => '', 'phone' => '', 'email' => ''];

if (
    $_SERVER['REQUEST_METHOD'] === 'POST'
    && ($_POST['action'] ?? '') === 'submit_director_request'
    && $user['role'] !== 'admin'
) {
    $old['first_name'] = trim((string) ($_POST['first_name'] ?? ''));
    $old['last_name']  = trim((string) ($_POST['last_name'] ?? ''));
    $old['phone']      = trim((string) ($_POST['phone'] ?? ''));
    $old['email']      = trim((string) ($_POST['email'] ?? ''));

    if ($old['first_name'] === '' || $old['last_name'] === '' || $old['phone'] === '' || $old['email'] === '') {
        $errors[] = t('apply_director_err_required');
    }
    if (
        mb_strlen($old['first_name']) > 255 || mb_strlen($old['last_name']) > 255
        || mb_strlen($old['phone']) > 32 || mb_strlen($old['email']) > 255
    ) {
        $errors[] = t('apply_director_err_too_long');
    }
    if ($old['email'] !== '' && filter_var($old['email'], FILTER_VALIDATE_EMAIL) === false) {
        $errors[] = t('apply_director_err_email_invalid');
    } elseif ($old['email'] !== '' && strcasecmp($old['email'], (string) $user['email']) !== 0) {
        $errors[] = t('apply_director_err_email_match');
    }

    if ($errors === []) {
        $dup = $pdo->prepare(
            "SELECT id FROM admin_requests
              WHERE user_id = :uid AND `position` = :pos AND status IN ('pending', 'approved')
              LIMIT 1"
        );
        $dup->execute([':uid' => $user['id'], ':pos' => $positionKey]);

        if ($dup->fetch() === false) {
            $ins = $pdo->prepare(
                "INSERT INTO admin_requests (user_id, `position`, first_name, last_name, phone, email)
                 VALUES (:uid, :pos, :first, :last, :phone, :email)"
            );
            $ins->execute([
                ':uid'   => $user['id'],
                ':pos'   => $positionKey,
                ':first' => $old['first_name'],
                ':last'  => $old['last_name'],
                ':phone' => $old['phone'],
                ':email' => $old['email'],
            ]);
        }

        // PRG — уникаємо повторної подачі при оновленні сторінки.
        header('Location: ' . $selfUrl);
        exit;
    }
}

// Стан заявки цього користувача саме на цю посаду: pending / approved
// блокують повторну подачу (rejected — можна подати ще раз).
$blockingRequest = null;
if ($user['role'] !== 'admin') {
    $stmt = $pdo->prepare(
        "SELECT status, requested_at
           FROM admin_requests
          WHERE user_id = :uid AND `position` = :pos AND status IN ('pending', 'approved')
          ORDER BY id DESC
          LIMIT 1"
    );
    $stmt->execute([':uid' => $user['id'], ':pos' => $positionKey]);
    $blockingRequest = $stmt->fetch() ?: null;
}

$pageTitle = $positionKey === 'ceo' ? t('title_apply_ceo') : t('title_apply_exec');
$heading   = $positionKey === 'ceo' ? t('apply_ceo_heading') : t('apply_exec_heading');

?>
<!DOCTYPE html>
<html lang="<?= htmlspecialchars(current_lang(), ENT_QUOTES) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= e($pageTitle) ?></title>
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
            max-width: 560px;
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

        .field {
            margin-bottom: 18px;
        }

        .field__label {
            display: block;
            margin-bottom: 6px;
            font-weight: 600;
        }

        .field__hint {
            margin: 6px 0 0;
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        .input {
            width: 100%;
            padding: 12px 14px;
            background: rgba(255, 255, 255, 0.06);
            border: 1px solid var(--card-border);
            border-radius: 12px;
            color: #ffffff;
            font: inherit;
            font-size: 1rem;
        }

        .input:focus {
            outline: none;
            border-color: var(--accent);
        }

        .notice {
            padding: 12px 16px;
            margin-bottom: 20px;
            border-radius: 12px;
            background: rgba(255, 90, 90, 0.12);
            border: 1px solid rgba(255, 120, 120, 0.4);
            font-size: 0.95rem;
        }

        .notice ul {
            margin: 0;
            padding-left: 20px;
        }

        .btn-row {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 24px;
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

        .btn--ghost {
            background: transparent;
            color: #ffffff;
            border-color: rgba(255, 255, 255, 0.4);
        }

        .btn--ghost:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .empty-state {
            padding: 20px;
            border: 1px dashed var(--card-border);
            border-radius: 12px;
            color: var(--text-muted);
            font-size: 0.95rem;
            margin-bottom: 24px;
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
    <?php include __DIR__ . '/header.php'; ?>
</head>
<body>
    <header class="site-header">
        <a class="site-header__brand" href="index.php">
            <img class="site-header__logo" src="/logo.png" alt="AI LAB HUB">
        </a>
        <nav class="site-nav" id="siteNav">
            <a class="site-nav__link" href="index.php"><?= htmlspecialchars(t('nav_home'), ENT_QUOTES) ?></a>
            <a class="site-nav__link" href="account.php"><?= htmlspecialchars(t('nav_account'), ENT_QUOTES) ?></a>
        </nav>
        <a class="site-nav__link site-nav__link--cta site-header__cta" href="eli.php">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9.937 15.5A2 2 0 0 0 8.5 14.063l-6.135-1.582a.5.5 0 0 1 0-.962L8.5 9.936A2 2 0 0 0 9.937 8.5l1.582-6.135a.5.5 0 0 1 .962 0L14.063 8.5A2 2 0 0 0 15.5 9.937l6.135 1.581a.5.5 0 0 1 0 .964L15.5 14.063a2 2 0 0 0-1.437 1.437l-1.582 6.135a.5.5 0 0 1-.962 0z"/><path d="M20 3v4"/><path d="M22 5h-4"/><path d="M4 17v2"/><path d="M6 18H2"/></svg>
            <?= htmlspecialchars(t('nav_assistant'), ENT_QUOTES) ?>
        </a>
        <button class="site-nav__toggle" type="button" aria-expanded="false" aria-controls="siteNav">
            <?= htmlspecialchars(t('nav_menu_toggle'), ENT_QUOTES) ?>
        </button>
    </header>

    <div class="page">
        <section class="account-panel">
            <h1 class="account-panel__title"><?= e($heading) ?></h1>

            <?php if ($user['role'] === 'admin'): ?>
                <div class="empty-state"><?= htmlspecialchars(t('apply_admin_already_admin'), ENT_QUOTES) ?></div>
                <div class="btn-row">
                    <a class="btn btn--ghost" href="account.php"><?= htmlspecialchars(t('apply_director_back_account'), ENT_QUOTES) ?></a>
                </div>
            <?php elseif ($blockingRequest !== null && $blockingRequest['status'] === 'pending'): ?>
                <div class="empty-state"><?= htmlspecialchars(t('apply_director_pending'), ENT_QUOTES) ?></div>
                <div class="btn-row">
                    <a class="btn btn--ghost" href="account.php"><?= htmlspecialchars(t('apply_director_back_account'), ENT_QUOTES) ?></a>
                </div>
            <?php elseif ($blockingRequest !== null && $blockingRequest['status'] === 'approved'): ?>
                <div class="empty-state"><?= htmlspecialchars(t('apply_director_approved'), ENT_QUOTES) ?></div>
                <div class="btn-row">
                    <a class="btn btn--ghost" href="account.php"><?= htmlspecialchars(t('apply_director_back_account'), ENT_QUOTES) ?></a>
                </div>
            <?php else: ?>
                <p class="account-panel__text"><?= htmlspecialchars(t('apply_director_intro'), ENT_QUOTES) ?></p>

                <?php if ($errors !== []): ?>
                    <div class="notice">
                        <ul>
                            <?php foreach ($errors as $err): ?>
                                <li><?= e($err) ?></li>
                            <?php endforeach; ?>
                        </ul>
                    </div>
                <?php endif; ?>

                <form method="post" action="<?= e($selfUrl) ?>" novalidate>
                    <input type="hidden" name="action" value="submit_director_request">
                    <div class="field">
                        <label class="field__label" for="first_name"><?= htmlspecialchars(t('apply_director_first_name'), ENT_QUOTES) ?></label>
                        <input class="input" type="text" id="first_name" name="first_name" value="<?= e($old['first_name']) ?>" maxlength="255" required>
                    </div>
                    <div class="field">
                        <label class="field__label" for="last_name"><?= htmlspecialchars(t('apply_director_last_name'), ENT_QUOTES) ?></label>
                        <input class="input" type="text" id="last_name" name="last_name" value="<?= e($old['last_name']) ?>" maxlength="255" required>
                    </div>
                    <div class="field">
                        <label class="field__label" for="phone"><?= htmlspecialchars(t('apply_director_phone'), ENT_QUOTES) ?></label>
                        <input class="input" type="tel" id="phone" name="phone" value="<?= e($old['phone']) ?>" maxlength="32" required>
                    </div>
                    <div class="field">
                        <label class="field__label" for="email"><?= htmlspecialchars(t('apply_director_email'), ENT_QUOTES) ?></label>
                        <input class="input" type="email" id="email" name="email" value="<?= e($old['email'] !== '' ? $old['email'] : (string) $user['email']) ?>" maxlength="255" required>
                        <p class="field__hint"><?= htmlspecialchars(t('apply_director_email_hint'), ENT_QUOTES) ?></p>
                    </div>
                    <div class="btn-row">
                        <button type="submit" class="btn btn--primary"><?= htmlspecialchars(t('apply_director_submit'), ENT_QUOTES) ?></button>
                        <a class="btn btn--ghost" href="account.php"><?= htmlspecialchars(t('apply_director_back_account'), ENT_QUOTES) ?></a>
                    </div>
                </form>
            <?php endif; ?>
        </section>
    </div>
    <?php include __DIR__ . '/footer.php'; ?>
</body>
</html>
