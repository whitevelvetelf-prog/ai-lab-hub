<?php

/**
 * AI LAB HUB — налаштування відправки листів реклами (app/promo-mail.php).
 *
 * Скопіюйте як config/mail.php (на хостингу — www/config/mail.php) і заповніть.
 * config/mail.php НЕ потрапляє в git і в архів деплою (у .gitignore).
 * Покрокова інструкція (скринька hello@, SPF/DKIM/DMARC) — docs/PROMO_OPERATIONS.md.
 *
 *   transport  — 'smtp' (рекомендовано), 'mail' (PHP mail(), запасний варіант) або
 *                'log' — тестовий режим БЕЗ реальної відправки: листи пишуться в
 *                storage/logs/mail-dryrun.log і позначаються в черзі як надіслані.
 *                Якщо файлу немає або host порожній — використовується mail().
 *   host       — SMTP-сервер (напр. mail.adm.tools — звірте з панеллю хостингу)
 *   port       — 465 (ssl) або 587 (tls)
 *   encryption — 'ssl', 'tls' або '' (без шифрування — не рекомендовано)
 *   username   — логін скриньки (зазвичай повна адреса hello@ailabhub-directory.com)
 *   password   — пароль скриньки
 *   from_email — адреса відправника
 *   from_name  — ім'я відправника
 *   reply_to   — адреса для відповідей
 *   admin_emails — куди слати сповіщення адміну (порожньо — усім користувачам з роллю admin)
 */

return [
    'transport'    => 'smtp',
    'host'         => '',
    'port'         => 465,
    'encryption'   => 'ssl',
    'username'     => '',
    'password'     => '',
    'from_email'   => 'hello@ailabhub-directory.com',
    'from_name'    => 'AI LAB HUB',
    'reply_to'     => 'partners@ailabhub-directory.com',
    'admin_emails' => [],
];
