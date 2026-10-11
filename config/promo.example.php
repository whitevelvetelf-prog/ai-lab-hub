<?php

/**
 * AI LAB HUB — секрети системи відеореклами (app/promo.php).
 *
 * Скопіюйте цей файл як config/promo.php (на хостингу — www/config/promo.php)
 * і заповніть. config/promo.php не потрапляє в git і в архів деплою.
 *
 *   secret    — ключ HMAC для підпису токенів показу/кліку. Довгий випадковий
 *               рядок, напр. результат: php -r "echo bin2hex(random_bytes(32));"
 *               Порожній або відсутній → відеореклама не показується (fail closed).
 *   cron_key  — ключ для HTTP-запуску public/promo-cron.php?key=... (агрегація й
 *               очищення сирих подій). Порожній → лише CLI-запуск.
 */

return [
    'secret'   => '',
    'cron_key' => '',
];
