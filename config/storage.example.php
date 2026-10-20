<?php

declare(strict_types=1);

/**
 * AI LAB HUB — приватне сховище «Цифрових матеріалів» маркетплейсу (app/asset.php).
 *
 * Скопіюйте в config/storage.php (файл не в git) і задайте значення для сервера.
 *
 *   assets_original_dir — оригінали авторів. ОБОВ'ЯЗКОВО поза коренем сайту (www/public), щоб прямого URL
 *                         не існувало. На adm.tools: /home/gu621051/marketplace-files/assets-original
 *   assets_preview_dir  — згенеровані превʼю з водяним знаком (віддаються лише через asset-preview.php
 *                         з підписаною адресою). Теж поза коренем сайту:
 *                         /home/gu621051/marketplace-files/assets-preview
 *   secret              — випадковий рядок ≥ 32 символи для підпису адрес превʼю й токенів завантаження.
 *                         Згенерувати: php -r "echo bin2hex(random_bytes(32));"
 *
 * Без файлу: каталоги storage/assets/… у корені проєкту (локальна розробка) і секрет із config/promo.php
 * (якщо є) — адмінка покаже попередження.
 */

return [
    'assets_original_dir' => '/home/USER/marketplace-files/assets-original',
    'assets_preview_dir'  => '/home/USER/marketplace-files/assets-preview',
    'secret'              => '',
];
