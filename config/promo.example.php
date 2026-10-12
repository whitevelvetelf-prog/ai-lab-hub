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
 *   safe_browsing — перевірка адрес переходу на шкідливі сторінки (app/promo-linkcheck.php):
 *       provider — 'off' (вимкнено), 'safe_browsing' (Google Safe Browsing Lookup API v4)
 *                  або 'web_risk' (Google Web Risk API);
 *       api_key  — ключ API з Google Cloud Console. Порожній → перевірка «skipped»,
 *                  модератор бачить попередження.
 *     Увага: Safe Browsing API призначений для НЕкомерційного використання; для
 *     комерційного Google пропонує Web Risk. Умови й ціни перевірте на сайті Google.
 */

return [
    'secret'   => '',
    'cron_key' => '',
    'safe_browsing' => [
        'provider' => 'off',
        'api_key'  => '',
    ],
];
