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
];
