<?php

/**
 * AI LAB HUB — шаблон серверного config/marketplace.local.php, ЕТАП B релізу Marketplace (docs/RELEASE_STAGE_B.md).
 *
 * ⚠ УВАГА (стан на 2026-11-22): на живому сайті Marketplace УЖЕ публічний, подача відкрита всім (з 2026-09-28),
 *   повідомлення ввімкнені (з 2026-11-18). Цей шаблон ставить posting_enabled = true, messaging_enabled = false —
 *   якщо його залити як є, він ВИМКНЕ на живому сайті повідомлення.
 *   Для живого сайту НЕ замінюйте наявний файл: відкрийте config/marketplace.local.php на хостингу й змінюйте лише ті
 *   прапори, які справді хочете змінити. Шаблон — для нового розгортання або свідомого повернення до етапу B.
 *
 * На живому сайті є ДВА серверні файли: www/config/marketplace.php (основний, архіви коду його не перезаписують;
 *   там posting_enabled = true) і www/config/marketplace.local.php (там messaging_enabled = true). Пізніший (local) перемагає.
 *
 * Як працює: app/marketplace.php → mp_config() зливає config/marketplace.php і цей файл (array_merge), тож КОЖЕН
 * ключ тут перевизначає серверний. Порожній рядок теж перевизначає: тому поля власника нижче ЗАКОМЕНТОВАНО —
 * розкоментуйте рядок лише разом зі справжнім значенням. Значення не друкуйте й не надсилайте в чати.
 * Перевірка без значень: php scripts/config-check.php або Кабінет → «Стан сайту».
 * Файл у збірку коду не входить (scripts/build-deploy.ps1, scripts/release-manifest.ps1) — заливається вручну.
 */

return [
    // --- Прапори етапу B ---
    'public_enabled'             => true,    // розділ видно відвідувачам (+ перемикач Кабінет → Marketplace → «Показувати»)
    'posting_enabled'            => true,    // подача оголошень для всіх (лише після умов docs/RELEASE_STAGE_B.md)
    'messaging_enabled'          => false,   // внутрішні повідомлення вимкнено
    'saved_search_email_enabled' => false,   // листи збережених пошуків не надсилаються
    'messaging_email_enabled'    => false,   // листи про повідомлення не надсилаються
    // geo_ip_enabled (країна за IP) читається НЕ звідси, а з config/geo.php. На живому сайті ввімкнено з 2026-11-19.
    // Для етапу B за планом релізу = false: якщо вирішите вимкнути — у config/geo.php поставте 'geo_ip_enabled' => false.

    // --- ЗАПОВНЮЄ ВЛАСНИК (розкоментуйте рядок і впишіть значення на хостингу) ---
    // 'site_url'         => 'https://ailabhub-directory.com',   // ЗАПОВНЮЄ ВЛАСНИК: адреса сайту без / в кінці (посилання в листах)
    // 'mail_transport'   => 'mail',                             // ЗАПОВНЮЄ ВЛАСНИК: на хостингу 'mail'
    // 'cron_token'       => '',   // ЗАПОВНЮЄ ВЛАСНИК: php scripts/gen-token.php (токен для mp-cron-*.php?token=…)
    // 'rate_limit_salt'  => '',   // ЗАПОВНЮЄ ВЛАСНИК: php scripts/gen-token.php (сіль для хешів IP; не міняти після запуску)
    // 'file_storage_dir' => '/home/gu621051/marketplace-files',  // ЗАПОВНЮЄ ВЛАСНИК: тека ПОЗА www (так на живому сайті з 2026-09-24)
    // 'photo_dir'        => '/home/gu621051/marketplace-files/photos', // ЗАПОВНЮЄ ВЛАСНИК: тека ПОЗА www (так на живому сайті)
    // 'saved_search_secret' => '',   // ЗАПОВНЮЄ ВЛАСНИК: лише коли вмикатимете листи збережених пошуків
    // 'messaging_secret'    => '',   // ЗАПОВНЮЄ ВЛАСНИК: лише коли вмикатимете листи про повідомлення
];
