<?php

declare(strict_types=1);

/**
 * AI LAB HUB — сторінка донатів.
 *
 * Публікується ЛИШЕ посилання на банку monobank (кнопка + необов'язковий QR того ж
 * посилання). Номер картки, IBAN, ПІБ тощо на сторінці НЕ показуються (рішення
 * власниці, 2026-11-15). Значення — у site_settings (app/donations.php), їх вводить
 * адмін у кабінеті (розділ «Донати»). Поки сторінку вимкнено або посилання немає
 * чи воно некоректне — кнопки немає, лише нейтральний текст «Скоро».
 * Без сторонніх скриптів і шрифтів: QR будується локально
 * (public/assets/js/vendor/qrcode-generator-1.4.4.js, MIT).
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/donations.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

$cfg = donate_config($pdo);
$lang = current_lang();
$enabled = $cfg['donate_enabled'] === '1';
$extraText = $lang === 'en' ? $cfg['donate_text_en'] : $cfg['donate_text_uk'];

$jarUrl = trim($cfg['donate_jar_url']);
if (!donate_jar_url_ok($jarUrl)) {
    $jarUrl = '';   // некоректне значення в БД не публікуємо
}
$showPage = $enabled && $jarUrl !== '';
$showQr = $showPage && $cfg['donate_show_qr'] === '1';

$e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
$v = static fn(string $f): int => (int) @filemtime(__DIR__ . '/assets/' . $f);
?>
<!DOCTYPE html>
<html lang="<?= $e($lang) ?>">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title><?= $e(t('donate_page_title')) ?> — AI LAB HUB</title>
    <meta name="description" content="<?= $e(t('donate_intro')) ?>">
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
            --text-muted: rgba(255, 255, 255, 0.78);
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
            max-width: 720px;
            margin: 0 auto;
            padding: 32px 16px 120px;
        }

        .page a {
            color: #bcd0ff;
        }

        .page a:hover {
            color: #ffffff;
        }

        .stub__title {
            margin: 0 0 12px;
            font-size: clamp(1.7rem, 5vw, 2.4rem);
            font-weight: 800;
            letter-spacing: 0.02em;
        }

        .stub__text {
            margin: 0 0 16px;
            font-size: 1.05rem;
            color: var(--text-muted);
        }

        .donate-extra {
            white-space: pre-line;
        }

        .donate-card {
            margin-top: 24px;
            padding: 24px;
            background: var(--card-bg);
            border: 1px solid var(--card-border);
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .donate-card__title {
            margin: 0 0 16px;
            font-size: 1.2rem;
        }

        .donate-jar {
            display: flex;
            flex-wrap: wrap;
            gap: 18px;
            align-items: center;
            margin-bottom: 18px;
        }

        .page a.donate-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            flex: 1 1 240px;
            padding: 15px 24px;
            border-radius: 999px;
            font-size: 1.05rem;
            font-weight: 700;
            text-decoration: none;
            text-align: center;
            color: #00032c;
            background: linear-gradient(135deg, #5b8cff, #a5c0ff);
            box-shadow: 0 6px 18px rgba(91, 140, 255, 0.4);
        }

        .page a.donate-btn:hover {
            color: #00032c;
            background: linear-gradient(135deg, #7aa2ff, #c2d4ff);
        }

        .donate-qr {
            flex: 0 0 auto;
            text-align: center;
        }

        .donate-qr__box {
            display: block;
            width: 168px;
            height: 168px;
            padding: 8px;
            border-radius: 12px;
            background: #ffffff;
        }

        .donate-qr__box svg {
            display: block;
            width: 100%;
            height: 100%;
        }

        .donate-qr__hint {
            margin: 8px 0 0;
            max-width: 168px;
            font-size: 0.8rem;
            color: var(--text-muted);
        }

        .donate-card__note {
            margin: 0;
            font-size: 0.9rem;
            color: var(--text-muted);
        }

        .donate-legal {
            margin-top: 28px;
            font-size: 0.9rem;
            color: var(--text-muted);
        }
    </style>
    <link rel="stylesheet" href="/assets/css/site-nav.css">
    <?php include __DIR__ . '/../app/header.php'; ?>
</head>
<body>
    <?php include __DIR__ . '/../app/site-header.php'; ?>

    <main class="page">
        <h1 class="stub__title"><?= $e(t('donate_page_title')) ?></h1>

        <?php if (!$showPage): ?>
        <p class="stub__text"><?= $e(t('donate_soon')) ?></p>
        <?php else: ?>
        <p class="stub__text"><?= $e(t('donate_intro')) ?></p>
        <?php if (trim($extraText) !== ''): ?>
        <p class="stub__text donate-extra"><?= $e($extraText) ?></p>
        <?php endif; ?>

        <section class="donate-card" aria-labelledby="donate-jar-title">
            <h2 class="donate-card__title" id="donate-jar-title"><?= $e(t('donate_jar_title')) ?></h2>
            <div class="donate-jar">
                <a class="donate-btn" href="<?= $e($jarUrl) ?>" target="_blank" rel="noopener noreferrer" data-donate-jar><?= $e(t('donate_jar_btn')) ?></a>
                <?php if ($showQr): ?>
                <div class="donate-qr">
                    <a class="donate-qr__box" href="<?= $e($jarUrl) ?>" target="_blank" rel="noopener noreferrer" data-qr="<?= $e($jarUrl) ?>" aria-label="QR: <?= $e(t('donate_jar_btn')) ?>"></a>
                    <p class="donate-qr__hint"><?= $e(t('donate_qr_hint')) ?></p>
                </div>
                <?php endif; ?>
            </div>
            <p class="donate-card__note"><?= $e(t('donate_jar_note')) ?></p>
        </section>

        <p class="stub__text" style="margin-top: 24px;"><?= $e(t('donate_thanks')) ?></p>
        <p class="donate-legal"><?= $e(t('donate_legal_note')) ?> <a href="terms.php#donations"><?= $e(t('donate_terms_link')) ?></a></p>
        <?php endif; ?>
    </main>

    <?php include __DIR__ . '/../app/footer.php'; ?>
    <?php if ($showQr): ?>
    <script src="/assets/js/vendor/qrcode-generator-1.4.4.js?v=<?= $v('js/vendor/qrcode-generator-1.4.4.js') ?>" defer></script>
    <script src="/assets/js/donate.js?v=<?= $v('js/donate.js') ?>" defer></script>
    <?php endif; ?>
</body>
</html>
