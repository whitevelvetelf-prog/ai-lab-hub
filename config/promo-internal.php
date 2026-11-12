<?php

/**
 * AI LAB HUB — внутрішні адреси реклами (app/promo-internal.php). Файл у git, без секретів;
 * на хостингу заливається разом із кодом (на відміну від config/promo.php, де ключі).
 *
 * promo_internal_paths — сторінки сайту, на які може вести власна (internal) реклама або посилання
 *   на наш домен. Шлях порівнюється ТОЧНО (без параметрів): «/register.php», «/catalog.php» тощо.
 *   Такі адреси перевіряються без HTTP-запиту, тож сторінку, якої тут немає, додайте до списку.
 * promo_own_hosts — домени сайту: https://<домен>/<шлях> вважається внутрішньою адресою.
 *   Хост із site_url (config/marketplace*.php) додається автоматично.
 */

return [
    'promo_internal_paths' => [
        '/', '/index.php',
        '/register.php', '/login.php',
        '/catalog.php', '/category.php', '/product.php', '/saved.php', '/eli.php',
        '/marketplace.php', '/marketplace-solutions.php', '/marketplace-category.php', '/marketplace-post.php',
        '/marketplace-join.php', '/marketplace-rules.php', '/listings.php', '/listing-post.php', '/assets.php', '/asset-post.php',
        '/donate.php',
        '/advertise.php', '/advertise-guide.php', '/promo-rules.php',
        '/blog.php', '/blog-post.php', '/about.php', '/contacts.php', '/ai-statement.php',
    ],
    'promo_own_hosts' => ['ailabhub-directory.com', 'www.ailabhub-directory.com'],
];
