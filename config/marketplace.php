<?php

declare(strict_types=1);

/**
 * AI LAB HUB — налаштування Marketplace (без секретів, можна комітити).
 * Значення за замовчуванням дублюються в app/marketplace.php → mp_config(),
 * тож файл можна не розгортати; тут їх змінюють.
 */
return [
    // Ліміт розміру завантажуваного файлу пропозиції (байти). За замовчуванням 10 МБ.
    // Реальний ліміт ще обмежують upload_max_filesize / post_max_size у php.ini.
    'max_upload_bytes' => 10 * 1024 * 1024,

    // Ліміт розміру обкладинки (байти). За замовчуванням 2 МБ.
    'max_cover_bytes' => 2 * 1024 * 1024,

    // Дозволені розширення файлів пропозицій (реальний MIME перевіряється окремо — app/marketplace.php).
    'allowed_extensions' => ['pdf', 'md', 'txt', 'json', 'csv', 'zip'],

    // Де зберігати файли пропозицій: ПОЗА webroot (public/), випадкове ім'я.
    'file_storage_dir' => dirname(__DIR__) . '/storage/marketplace/files',

    // Обкладинки мають бути доступні з веба (public/).
    'cover_dir' => dirname(__DIR__) . '/public/assets/images/marketplace/covers',

    // Перемикач публічної частини Marketplace. false → marketplace.php, marketplace-category.php,
    // offer.php, get.php віддають 404, пунктів меню/блоку на головній немає.
    // Для розробки НЕ змінюйте тут: створіть config/marketplace.local.php (у .gitignore) з
    //   <?php return ['public_enabled' => true];
    'public_enabled' => false,

    // --- Дошка оголошень (етап 4) ---

    // Фото оголошень: публічна тека (у ній .htaccess забороняє виконання PHP), URL і ліміти.
    'photo_dir'        => dirname(__DIR__) . '/public/uploads/marketplace',
    'photo_url'        => '/uploads/marketplace',
    'photo_max_count'  => 8,
    'photo_max_bytes'  => 5 * 1024 * 1024,   // на одне фото, до перекодування
    'photo_max_side'   => 1600,              // довша сторона збереженого фото, px
    'photo_thumb_side' => 400,               // довша сторона мініатюри, px

    // Термін життя оголошення (днів) — від схвалення й від кнопки «Продовжити».
    'listing_ttl_days' => 30,

    // Захист від спаму (не стосується employee/admin).
    'max_active_per_user'  => 5,    // pending + published
    'max_new_per_day'      => 10,   // нових оголошень за 24 год
    'max_links_in_desc'    => 2,    // посилань в описах
    'stop_words'           => [],   // напр. ['казино', 'ставки'] — без урахування регістру
    'reveals_per_day'      => 30,   // розкриттів контактів на користувача за 24 год
    'reports_threshold'    => 3,    // унікальних скарг → оголошення повертається в pending

    // Cron для mp-cron-expire.php: з CLI працює завжди; через HTTP лише якщо тут непорожній ключ
    // (виклик: mp-cron-expire.php?token=<ключ>). Порожній → HTTP-доступ вимкнено.
    'cron_token'       => '',
];
