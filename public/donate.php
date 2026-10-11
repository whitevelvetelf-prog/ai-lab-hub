<?php

declare(strict_types=1);

/**
 * AI LAB HUB — сторінка донатів.
 *
 * Реквізити НЕ в коді: їх вводить адмін у кабінеті (розділ «Донати»), вони
 * зберігаються в site_settings (app/donations.php). Показуються лише заповнені
 * поля; поки сторінку вимкнено або нічого не заповнено — нейтральний текст.
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

$purpose = $cfg['donate_purpose'] !== '' ? $cfg['donate_purpose'] : t('donate_purpose_default');
$extraText = $lang === 'en' ? $cfg['donate_text_en'] : $cfg['donate_text_uk'];

// Рядки реквізитів: [ключ підпису, значення для показу, значення для копіювання].
$uaRows = [];
if ($cfg['donate_card_number'] !== '') {
    $uaRows[] = ['donate_card', $cfg['donate_card_number'], donate_digits($cfg['donate_card_number'])];
}
if ($cfg['donate_iban_uah'] !== '') {
    $uaRows[] = ['donate_iban_uah', donate_group4($cfg['donate_iban_uah']), $cfg['donate_iban_uah']];
}
$intlRows = [];
foreach (['donate_iban_usd' => 'donate_iban_usd', 'donate_iban_eur' => 'donate_iban_eur'] as $key => $label) {
    if ($cfg[$key] !== '') {
        $intlRows[] = [$label, donate_group4($cfg[$key]), $cfg[$key]];
    }
}
if ($cfg['donate_swift'] !== '') {
    $intlRows[] = ['donate_swift', $cfg['donate_swift'], $cfg['donate_swift']];
}
if ($cfg['donate_bank_name'] !== '') {
    $intlRows[] = ['donate_bank', $cfg['donate_bank_name'], $cfg['donate_bank_name']];
}
$jarUrl = $cfg['donate_jar_url'];
$hasUa = $jarUrl !== '' || $uaRows !== [];
$hasIntl = $intlRows !== [];
$showPage = $enabled && ($hasUa || $hasIntl);
$holder = $cfg['donate_card_holder'];
$showQr = $cfg['donate_show_qr'] === '1' && $jarUrl !== '';

$e = static fn(mixed $v): string => htmlspecialchars((string) $v, ENT_QUOTES);
$copyBtn = static function (string $value) use ($e): string {
    return '<button type="button" class="donate-copy" data-copy="' . $e($value) . '">'
        . '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect width="14" height="14" x="8" y="8" rx="2" ry="2"/><path d="M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2"/></svg>'
        . '<span>' . $e(t('donate_copy')) . '</span></button>';
};
$row = static function (string $labelKey, string $shown, string $copy) use ($e, $copyBtn): string {
    return '<div class="donate-row"><dt>' . $e(t($labelKey)) . '</dt><dd><span class="donate-value">' . $e($shown) . '</span>' . $copyBtn($copy) . '</dd></div>';
};
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

        .donate-list {
            margin: 0;
        }

        .donate-row {
            padding: 12px 0;
            border-top: 1px solid var(--card-border);
        }

        .donate-row:first-child {
            border-top: 0;
            padding-top: 0;
        }

        .donate-row dt {
            margin-bottom: 4px;
            font-size: 0.85rem;
            color: var(--text-muted);
        }

        .donate-row dd {
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 8px 12px;
            margin: 0;
        }

        .donate-value {
            min-width: 0;
            font-size: 1.08rem;
            font-weight: 700;
            letter-spacing: 0.03em;
            font-variant-numeric: tabular-nums;
            overflow-wrap: anywhere;
        }

        .donate-copy {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            padding: 6px 14px;
            border-radius: 999px;
            border: 1px solid rgba(255, 255, 255, 0.35);
            background: transparent;
            color: #ffffff;
            font: inherit;
            font-size: 0.85rem;
            font-weight: 600;
            cursor: pointer;
            -webkit-tap-highlight-color: transparent;
        }

        .donate-copy:hover {
            background: rgba(255, 255, 255, 0.12);
        }

        .donate-copy:focus-visible,
        .page a:focus-visible {
            outline: 2px solid #9fb8ff;
            outline-offset: 2px;
        }

        .donate-copy.is-copied {
            background: rgba(91, 140, 255, 0.3);
            border-color: #5b8cff;
        }

        .donate-copy svg {
            width: 15px;
            height: 15px;
        }

        .donate-note {
            margin: 16px 0 0;
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

        <?php if ($hasUa): ?>
        <section class="donate-card" aria-labelledby="donate-ua">
            <h2 class="donate-card__title" id="donate-ua"><?= $e(t('donate_ua_title')) ?></h2>
            <?php if ($jarUrl !== ''): ?>
            <div class="donate-jar">
                <a class="donate-btn" href="<?= $e($jarUrl) ?>" target="_blank" rel="noopener noreferrer"><?= $e(t('donate_jar_btn')) ?></a>
                <?php if ($showQr): ?>
                <div class="donate-qr">
                    <a class="donate-qr__box" href="<?= $e($jarUrl) ?>" target="_blank" rel="noopener noreferrer" data-qr="<?= $e($jarUrl) ?>" aria-label="QR: <?= $e(t('donate_jar_btn')) ?>"></a>
                    <p class="donate-qr__hint"><?= $e(t('donate_qr_hint')) ?></p>
                </div>
                <?php endif; ?>
            </div>
            <?php endif; ?>
            <?php if ($uaRows !== []): ?>
            <dl class="donate-list">
                <?php foreach ($uaRows as [$label, $shown, $copy]): ?>
                <?= $row($label, $shown, $copy) ?>
                <?php endforeach; ?>
                <?php if ($holder !== ''): ?><?= $row('donate_recipient', $holder, $holder) ?><?php endif; ?>
                <?php if ($cfg['donate_iban_uah'] !== ''): ?><?= $row('donate_purpose', $purpose, $purpose) ?><?php endif; ?>
            </dl>
            <?php endif; ?>
        </section>
        <?php endif; ?>

        <?php if ($hasIntl): ?>
        <section class="donate-card" aria-labelledby="donate-intl">
            <h2 class="donate-card__title" id="donate-intl"><?= $e(t('donate_intl_title')) ?></h2>
            <dl class="donate-list">
                <?php if ($holder !== ''): ?><?= $row('donate_recipient', $holder, $holder) ?><?php endif; ?>
                <?php foreach ($intlRows as [$label, $shown, $copy]): ?>
                <?= $row($label, $shown, $copy) ?>
                <?php endforeach; ?>
                <?= $row('donate_purpose', $purpose, $purpose) ?>
            </dl>
            <p class="donate-note"><?= $e(t('donate_intl_note')) ?></p>
        </section>
        <?php endif; ?>

        <p class="stub__text" style="margin-top: 24px;"><?= $e(t('donate_thanks')) ?></p>
        <p class="donate-legal"><?= $e(t('donate_legal_note')) ?> <a href="terms.php#donations"><?= $e(t('donate_terms_link')) ?></a></p>
        <?php endif; ?>
    </main>

    <?php include __DIR__ . '/../app/footer.php'; ?>
    <?php if ($showPage): ?>
    <script>
        window.DONATE_I18N = <?= json_encode(['copied' => t('donate_copied'), 'failed' => t('donate_copy_failed')], JSON_UNESCAPED_UNICODE | JSON_HEX_TAG | JSON_HEX_AMP | JSON_HEX_APOS | JSON_HEX_QUOT) ?>;
    </script>
    <?php if ($showQr): ?>
    <script src="/assets/js/vendor/qrcode-generator-1.4.4.js?v=<?= $v('js/vendor/qrcode-generator-1.4.4.js') ?>" defer></script>
    <?php endif; ?>
    <script src="/assets/js/donate.js?v=<?= $v('js/donate.js') ?>" defer></script>
    <?php endif; ?>
</body>
</html>
