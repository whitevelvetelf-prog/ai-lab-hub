<?php

declare(strict_types=1);

/**
 * AI LAB HUB — відписка від листів аутрічу: unsubscribe.php?t=TOKEN.
 *
 *   GET  — сторінка з однією кнопкою «Відписатися» (GET нічого не змінює: поштові сканери посилань не відписують);
 *   POST — відписка (кнопка на сторінці або List-Unsubscribe-Post: One-Click від поштового клієнта, RFC 8058).
 * Токен одноразовий і з терміном дії; адреса й домен потрапляють у список заборон, лід — «Відписались».
 * Сторінка не розкриває, кому належить токен. Мова — з інтерфейсу (?lang=en / сесія), за замовчуванням українська.
 */

require_once __DIR__ . '/../app/auth.php';
require_once __DIR__ . '/../app/translations.php';
require_once __DIR__ . '/../app/outreach-mail.php';

/** @var PDO $pdo */
$pdo = require __DIR__ . '/../config/database.php';

header('X-Robots-Tag: noindex, nofollow');
header('Referrer-Policy: no-referrer');
$raw = is_string($_GET['t'] ?? null) ? (string) $_GET['t'] : (is_string($_POST['t'] ?? null) ? (string) $_POST['t'] : '');
$en = current_lang() === 'en';
$tx = static fn(string $uk, string $enText): string => htmlspecialchars($en ? $enText : $uk, ENT_QUOTES);
$state = 'form';
if (($_SERVER['REQUEST_METHOD'] ?? '') === 'POST') {
    $state = omail_unsubscribe($pdo, $raw);
    if (stripos((string) ($_SERVER['CONTENT_TYPE'] ?? ''), 'application/x-www-form-urlencoded') !== false && ($_POST['List-Unsubscribe'] ?? '') === 'One-Click') {
        http_response_code(in_array($state, ['ok', 'already'], true) ? 200 : 400);   // відповідь поштовому клієнту
        exit;
    }
} else {
    $t = omail_token_find($pdo, $raw, 'unsub');
    if ($t === null) {
        $state = 'invalid';
    } elseif ($t['used_at'] !== null) {
        $state = 'already';
    } elseif (strtotime($t['expires_at'] . ' UTC') < time()) {
        $state = 'expired';
    }
}
$contact = 'partners@ailabhub-directory.com';
?>
<!DOCTYPE html>
<html lang="<?= $en ? 'en' : 'uk' ?>">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="robots" content="noindex, nofollow">
    <title><?= $tx('Відписка', 'Unsubscribe') ?> — AI LAB HUB</title>
    <style>
        *, *::before, *::after { box-sizing: border-box; }
        body { margin: 0; min-height: 100vh; font-family: "Segoe UI", Roboto, Arial, sans-serif; color: #fff; line-height: 1.6;
               background: linear-gradient(160deg, #00032c 0%, #2116ad 100%); background-attachment: fixed; }
        main { max-width: 560px; margin: 0 auto; padding: 72px 16px; text-align: center; }
        h1 { font-size: clamp(1.4rem, 5vw, 2rem); margin: 0 0 14px; }
        p { color: rgba(255, 255, 255, 0.8); }
        a { color: #bcd0ff; overflow-wrap: anywhere; }
        button { margin-top: 12px; padding: 12px 28px; border: 0; border-radius: 999px; font-size: 1rem; font-weight: 700; cursor: pointer;
                 background: #5b8cff; color: #fff; }
        button:hover, button:focus-visible { background: #7aa2ff; }
    </style>
</head>
<body>
<main>
    <?php if ($state === 'form'): ?>
        <h1><?= $tx('Відписатися від листів AI LAB HUB', 'Unsubscribe from AI LAB HUB emails') ?></h1>
        <p><?= $tx('Натисніть кнопку — і ми більше не писатимемо на цю адресу й домен вашої компанії.', 'Click the button and we will not email this address or your company’s domain again.') ?></p>
        <form method="post" action="unsubscribe.php">
            <input type="hidden" name="t" value="<?= htmlspecialchars($raw, ENT_QUOTES) ?>">
            <button type="submit"><?= $tx('Відписатися', 'Unsubscribe') ?></button>
        </form>
    <?php elseif ($state === 'ok' || $state === 'already'): ?>
        <h1><?= $tx('Ви відписалися', 'You have been unsubscribed') ?></h1>
        <p><?= $tx('Ми більше не надсилатимемо листів на цю адресу. Вибачте за турботу.', 'We will not send any more emails to this address. Sorry for the bother.') ?></p>
    <?php elseif ($state === 'expired'): ?>
        <h1><?= $tx('Посилання застаріло', 'This link has expired') ?></h1>
        <p><?= $tx('Напишіть нам на', 'Please write to us at') ?> <a href="mailto:<?= $contact ?>?subject=unsubscribe"><?= $contact ?></a> <?= $tx('— і ми приберемо вашу адресу зі списку.', '— and we will remove your address.') ?></p>
    <?php else: ?>
        <h1><?= $tx('Посилання недійсне', 'Invalid link') ?></h1>
        <p><?= $tx('Щоб відписатися, напишіть нам на', 'To unsubscribe, write to us at') ?> <a href="mailto:<?= $contact ?>?subject=unsubscribe"><?= $contact ?></a>.</p>
    <?php endif; ?>
    <p><a href="index.php">AI LAB HUB</a></p>
</main>
</body>
</html>
