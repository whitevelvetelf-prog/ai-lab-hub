<?php

/**
 * Шаблон локального/серверного перевизначення config/marketplace.php.
 *
 * Скопіюйте у config/marketplace.local.php (файл у .gitignore, у збірку для хостингу не потрапляє)
 * і залиште лише ті ключі, які треба змінити. Усі секрети тут порожні — заповнюються лише на місці.
 */

return [
    // 'public_enabled'          => false,   // розділ видно відвідувачам (разом із перемикачем у кабінеті)
    // 'posting_enabled'         => false,   // подача оголошень для всіх (false — лише employee/admin)
    // 'messaging_enabled'       => false,   // внутрішні повідомлення
    // 'messaging_email_enabled' => false,   // листи про нові повідомлення (потрібен messaging_secret)
    // 'saved_search_email_enabled' => false, // листи збережених пошуків (потрібен saved_search_secret)
    'site_url'            => '',   // напр. https://ailabhub-directory.com (без / в кінці)
    'mail_transport'      => '',   // 'mail' або 'log' (локально)
    'cron_token'          => '',   // php scripts/gen-token.php
    'rate_limit_salt'     => '',   // php scripts/gen-token.php
    'saved_search_secret' => '',   // php scripts/gen-token.php
    'messaging_secret'    => '',   // php scripts/gen-token.php
];
