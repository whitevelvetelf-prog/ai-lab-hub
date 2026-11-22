<?php

declare(strict_types=1);

/**
 * AI LAB HUB — Політика конфіденційності (заглушка).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';

?>
<!DOCTYPE html>
<html lang="<?= htmlspecialchars(current_lang(), ENT_QUOTES) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>AI LAB HUB — <?= htmlspecialchars(t('legal_privacy_title'), ENT_QUOTES) ?></title>
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
            display: flex;
            flex-direction: column;
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
            flex: 1;
            width: 100%;
            max-width: 760px;
            margin: 0 auto;
            padding: 48px 24px 64px;
        }

        .stub__title {
            margin: 0 0 12px;
            font-size: clamp(1.8rem, 5vw, 2.6rem);
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .stub__text {
            margin: 0;
            font-size: 1.05rem;
            color: var(--text-muted);
        }

        .legal-heading {
            margin: 32px 0 12px;
            font-size: 1.25rem;
            font-weight: 700;
        }

        .legal-updated {
            margin-top: 32px;
            font-size: 0.85rem;
            color: var(--text-muted);
        }
    </style>
    <link rel="stylesheet" href="/assets/css/site-nav.css">
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/../app/site-header.php'; ?>

    <main class="page">
        <h1 class="stub__title"><?= htmlspecialchars(t('legal_privacy_title'), ENT_QUOTES) ?></h1>
        <p class="stub__text"><?= htmlspecialchars(t('legal_stub_note'), ENT_QUOTES) ?></p>

        <h2 class="legal-heading"><?= htmlspecialchars(t('legal_privacy_market_h'), ENT_QUOTES) ?></h2>
        <p class="stub__text"><?= htmlspecialchars(t('legal_privacy_market_text'), ENT_QUOTES) ?></p>

        <?php /* ЧЕРНЕТКА: пункт про донати потребує перевірки юристом перед остаточною публікацією. */ ?>
        <h2 class="legal-heading"><?= htmlspecialchars(t('legal_privacy_donate_h'), ENT_QUOTES) ?></h2>
        <p class="stub__text"><?= htmlspecialchars(t('legal_privacy_donate_text'), ENT_QUOTES) ?></p>

        <?php /* ЧЕРНЕТКА: пункт про вимірювання реклами потребує перевірки юристом перед запуском реклами. */ ?>
        <?php // Текст — у системі перекладу (app/translations.php + ui_translations EN), а не в шаблоні. ?>
        <h2 class="legal-heading"><?= htmlspecialchars(t('legal_privacy_ads_title'), ENT_QUOTES) ?></h2>
        <p class="stub__text"><?= htmlspecialchars(t('legal_privacy_ads_counts'), ENT_QUOTES) ?></p>
        <p class="stub__text"><?= htmlspecialchars(t('legal_privacy_ads_session'), ENT_QUOTES) ?></p>
        <p class="stub__text"><?= htmlspecialchars(t('legal_privacy_ads_targeting'), ENT_QUOTES) ?></p>

        <?php /* ЧЕРНЕТКА: пункт про цифрові матеріали потребує перевірки юристом. */ ?>
        <h2 class="legal-heading" id="assets"><?= htmlspecialchars(t('legal_privacy_assets_h'), ENT_QUOTES) ?></h2>
        <p class="stub__text"><?= htmlspecialchars(t('legal_privacy_assets_store'), ENT_QUOTES) ?></p>
        <p class="stub__text"><?= htmlspecialchars(t('legal_privacy_assets_log'), ENT_QUOTES) ?></p>
        <p class="stub__text"><?= htmlspecialchars(t('legal_privacy_assets_complaints'), ENT_QUOTES) ?></p>

        <?php /* ЧЕРНЕТКА: пункт про cookie потребує перевірки юристом. Текст — у системі перекладу (cc/legal_privacy_cookies_*). */ ?>
        <h2 class="legal-heading" id="cookies"><?= htmlspecialchars(t('legal_privacy_cookies_title'), ENT_QUOTES) ?></h2>
        <p class="stub__text"><?= htmlspecialchars(t('legal_privacy_cookies_necessary'), ENT_QUOTES) ?></p>
        <p class="stub__text"><?= htmlspecialchars(t('legal_privacy_cookies_geo'), ENT_QUOTES) ?></p>
        <p class="stub__text"><?= htmlspecialchars(t('legal_privacy_cookies_youtube'), ENT_QUOTES) ?></p>
        <p class="stub__text"><?= htmlspecialchars(t('legal_privacy_cookies_none'), ENT_QUOTES) ?> <a href="privacy.php#cookies" data-cc-open><?= htmlspecialchars(t('cc_settings'), ENT_QUOTES) ?></a></p>

        <?php /* ЧЕРНЕТКА: пункт про повідомлення між користувачами потребує перевірки юристом. Текст — legal_privacy_msg_* (переклад UA/EN). */ ?>
        <h2 class="legal-heading" id="messages"><?= htmlspecialchars(t('legal_privacy_msg_h'), ENT_QUOTES) ?></h2>
        <p class="stub__text"><?= htmlspecialchars(t('legal_privacy_msg_store'), ENT_QUOTES) ?></p>
        <p class="stub__text"><?= htmlspecialchars(t('legal_privacy_msg_access'), ENT_QUOTES) ?></p>
        <p class="stub__text"><?= htmlspecialchars(t('legal_privacy_msg_email'), ENT_QUOTES) ?></p>
        <p class="stub__text"><?= htmlspecialchars(t('legal_privacy_msg_delete'), ENT_QUOTES) ?></p>

        <p class="stub__text legal-updated"><?= htmlspecialchars(t('legal_privacy_updated'), ENT_QUOTES) ?></p>
    </main>

    <?php include __DIR__ . '/../app/footer.php'; ?>
</body>
</html>
