<?php

declare(strict_types=1);

/**
 * AI LAB HUB — відправка листів.
 *
 * На сайті раніше не було жодної відправки email (схвалення заявок
 * тощо показує результат лише як flash-повідомлення в кабінеті, листа
 * ніхто не отримує). Стартовий варіант тут — вбудований PHP mail():
 * працює на більшості shared-хостингів без додаткових бібліотек чи
 * ключів. Якщо листи почнуть потрапляти в спам — замінити тіло
 * send_mail() на виклик SMTP-провайдера (Brevo/SendGrid тощо); решта
 * коду (forgot-password.php, login-via-token.php) не зміниться,
 * сигнатура функції лишається тією самою.
 *
 * Локально (Laragon без налаштованого MTA) mail() майже завжди
 * повертає false — у цьому разі лист додатково пишеться в
 * storage/mail-debug.log (поза public/, не веб-доступний, у .gitignore)
 * для перевірки вмісту без реальної відправки.
 *
 * render_login_email_html() викликає t() — підключати після
 * app/translations.php:
 *   require_once __DIR__ . '/../app/translations.php';
 *   require_once __DIR__ . '/../app/mailer.php';
 */

const MAIL_FROM_ADDRESS = 'hello@ailabhub-directory.com';
const MAIL_FROM_NAME = 'AI LAB HUB';

/**
 * Базова адреса сайту для посилань у листах (без слеша в кінці). НІКОЛИ не бере домен із заголовка Host
 * запиту, який контролює клієнт (інакше атакуючий підмінить Host і лист із токеном входу поведе жертву
 * на його домен — «password reset poisoning»). Порядок:
 *   1) 'site_url' із config/marketplace.local.php або config/marketplace.php (http/https-адреса);
 *   2) локальна розробка: Host, але лише localhost / 127.0.0.1 / *.test;
 *   3) інакше — канонічний продакшн-домен.
 */
function mail_site_url(): string
{
    foreach (['marketplace.local.php', 'marketplace.php'] as $name) {
        $file = __DIR__ . '/../config/' . $name;
        $cfg = is_file($file) ? require $file : [];
        $url = is_array($cfg) ? rtrim(trim((string) ($cfg['site_url'] ?? '')), '/') : '';
        if ($url !== '' && preg_match('#^https?://[A-Za-z0-9.\-]+(?::\d{1,5})?$#', $url) === 1) {
            return $url;
        }
    }
    $host = strtolower((string) ($_SERVER['HTTP_HOST'] ?? ''));
    if (preg_match('/^(?:localhost|127\.0\.0\.1|[a-z0-9-]+(?:\.[a-z0-9-]+)*\.test)(?::\d{1,5})?$/', $host) === 1) {
        $scheme = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') ? 'https' : 'http';

        return $scheme . '://' . $host;
    }

    return 'https://ailabhub-directory.com';
}

/** Прибирає CR, LF і NUL зі значення, що потрапляє в заголовок листа (захист від header injection). */
function mail_header_clean(string $value): string
{
    return str_replace(["\r", "\n", "\0"], '', $value);
}

/** Надсилає HTML+text лист; true — якщо mail() підтвердив прийняття до відправки. */
function send_mail(string $to, string $subject, string $htmlBody, string $textBody): bool
{
    // Усе, що йде в заголовки (to, subject, from, reply-to), — без CR/LF/NUL. Адресу, яка після очищення змінилась
    // (тобто містила розрив рядка), відхиляємо цілком — а не «лагодимо» мовчки.
    $toClean = mail_header_clean($to);
    if ($toClean === '' || $toClean !== $to) {
        error_log('[mail] recipient rejected: empty or contains CR/LF/NUL');

        return false;
    }
    $to = $toClean;
    $subject = mail_header_clean($subject);
    $fromName = mail_header_clean(MAIL_FROM_NAME);
    $fromAddress = mail_header_clean(MAIL_FROM_ADDRESS);

    $boundary = bin2hex(random_bytes(16));
    $headers = implode("\r\n", [
        'MIME-Version: 1.0',
        'Content-Type: multipart/alternative; boundary="' . $boundary . '"',
        'From: ' . $fromName . ' <' . $fromAddress . '>',
        'Reply-To: ' . $fromAddress,
    ]);

    $body = "--{$boundary}\r\n"
        . "Content-Type: text/plain; charset=UTF-8\r\n\r\n"
        . $textBody . "\r\n\r\n"
        . "--{$boundary}\r\n"
        . "Content-Type: text/html; charset=UTF-8\r\n\r\n"
        . $htmlBody . "\r\n\r\n"
        . "--{$boundary}--";

    // Кодування теми для нелатинських символів (RFC 2047).
    $encodedSubject = '=?UTF-8?B?' . base64_encode($subject) . '?=';

    $sent = @mail($to, $encodedSubject, $body, $headers);

    if (!$sent) {
        mail_debug_log($to, $subject, $textBody);
    }

    return $sent;
}

/**
 * Локальний фолбек для розробки: коли mail() недоступний (типово для
 * Laragon без налаштованого MTA), дублює лист у файл — щоб перевірити
 * вміст без реальної відправки. Ніколи не тримати токени в цьому файлі
 * довго на бойовому сервері — там mail() зазвичай працює, і цей шлях
 * не спрацьовує.
 */
function mail_debug_log(string $to, string $subject, string $textBody): void
{
    $dir = __DIR__ . '/../storage';
    if (!is_dir($dir)) {
        @mkdir($dir, 0775, true);
    }

    $entry = sprintf(
        "[%s] To: %s | Subject: %s\n%s\n%s\n\n",
        date('Y-m-d H:i:s'),
        $to,
        $subject,
        str_repeat('-', 70),
        $textBody
    );

    @file_put_contents($dir . '/mail-debug.log', $entry, FILE_APPEND | LOCK_EX);
}

/**
 * HTML-розмітка листа «Вхід в AI LAB HUB» (кнопка з посиланням-токеном).
 * Тексти — з app/translations.php (mail_login_*), під поточну мову сесії.
 */
function render_login_email_html(string $name, string $link, int $ttlMinutes): string
{
    $safeLink = htmlspecialchars($link, ENT_QUOTES);
    $greeting = htmlspecialchars(sprintf(t('mail_login_greeting'), $name), ENT_QUOTES);
    $intro = htmlspecialchars(t('mail_login_intro'), ENT_QUOTES);
    $button = htmlspecialchars(t('mail_login_button'), ENT_QUOTES);
    $fallback = htmlspecialchars(t('mail_login_fallback'), ENT_QUOTES);
    $expiry = htmlspecialchars(sprintf(t('mail_login_expiry'), $ttlMinutes), ENT_QUOTES);

    return <<<HTML
    <!doctype html>
    <html>
    <body style="margin:0;padding:0;background:#00032c;font-family:'Segoe UI',Roboto,Arial,sans-serif;">
        <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#00032c;padding:32px 16px;">
            <tr>
                <td align="center">
                    <table role="presentation" width="480" cellpadding="0" cellspacing="0" style="max-width:480px;background:rgba(255,255,255,0.04);border:1px solid rgba(255,255,255,0.14);border-radius:20px;padding:32px;">
                        <tr>
                            <td style="color:#ffffff;">
                                <h1 style="margin:0 0 16px;font-size:1.4rem;">AI LAB HUB</h1>
                                <p style="margin:0 0 16px;font-size:1rem;line-height:1.6;">{$greeting}</p>
                                <p style="margin:0 0 24px;font-size:0.95rem;line-height:1.6;color:rgba(255,255,255,0.8);">{$intro}</p>
                                <p style="margin:0 0 24px;text-align:center;">
                                    <a href="{$safeLink}" style="display:inline-block;padding:14px 28px;border-radius:999px;background:#ffffff;color:#00032c;font-weight:700;text-decoration:none;">{$button}</a>
                                </p>
                                <p style="margin:0 0 8px;font-size:0.85rem;line-height:1.5;color:rgba(255,255,255,0.6);">{$fallback}</p>
                                <p style="margin:0 0 24px;font-size:0.8rem;word-break:break-all;color:#a5c0ff;">{$safeLink}</p>
                                <p style="margin:0;font-size:0.82rem;line-height:1.5;color:rgba(255,255,255,0.55);">{$expiry}</p>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </body>
    </html>
    HTML;
}
