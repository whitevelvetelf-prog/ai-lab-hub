<?php

/**
 * AI LAB HUB — спільні теги <head> для PWA.
 *
 * Підключати перед </head> на кожній HTML-сторінці:
 *   include __DIR__ . '/../app/header.php';
 *
 * Тут: маніфест, іконки, theme-color, мета для iOS «на початковий екран»,
 * стилі банера встановлення (pwa-install.css) та кнопки «зберегти в
 * добірку» (saved-products.css). Файли фізично лежать у public/
 * (веб-корінь), тому шляхи абсолютні від /.
 */

?>
<link rel="icon" type="image/x-icon" href="/favicon.ico">
<link rel="manifest" href="/manifest.json">
<meta name="theme-color" content="#2116ad">
<link rel="apple-touch-icon" href="/icons/icon-180.png">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
<meta name="apple-mobile-web-app-title" content="AI LAB HUB">
<link rel="stylesheet" href="/assets/css/pwa-install.css">
<link rel="stylesheet" href="/assets/css/saved-products.css">
