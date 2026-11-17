<?php

declare(strict_types=1);

/**
 * AI LAB HUB — налаштування Marketplace (без секретів, можна комітити).
 * Значення за замовчуванням дублюються в app/marketplace.php → mp_config(),
 * тож файл можна не розгортати; тут їх змінюють.
 */

// --- Правила Marketplace і юридичні механізми (2026-11-17) ---
// Ці числа підставляються в текст Правил (marketplace-rules.php), тож строки в Правилах і в коді завжди однакові.
// Ті самі значення за замовчуванням є в app/mp-legal.php (на проді цей файл серверний і може їх не містити).
// Пункти Правил — у коментарях. Змінюєте строк → оновіть MP_RULES_VERSION (п. 13.3: про суттєві зміни — за 7 днів).
defined('MP_RULES_VERSION') || define('MP_RULES_VERSION', '2026-11-17');                       // 1.5, 13.3 — дата редакції
defined('MP_ABUSE_EMAIL') || define('MP_ABUSE_EMAIL', 'abuse@ailabhub-directory.com');         // 7.5, 10.1, 11.1
defined('MP_MODERATION_DAYS') || define('MP_MODERATION_DAYS', 3);                              // 7.1 — робочих днів
defined('MP_APPEAL_WINDOW_DAYS') || define('MP_APPEAL_WINDOW_DAYS', 14);                       // 7.5 — днів на оскарження
defined('MP_APPEAL_ANSWER_DAYS') || define('MP_APPEAL_ANSWER_DAYS', 10);                       // 7.5 — робочих днів на відповідь
defined('MP_IP_REVIEW_DAYS') || define('MP_IP_REVIEW_DAYS', 3);                                // 10.2 — розгляд заяви правовласника
defined('MP_COUNTER_NOTICE_DAYS') || define('MP_COUNTER_NOTICE_DAYS', 10);                     // 10.3 — строк на заперечення
defined('MP_LISTING_LIFETIME_DAYS') || define('MP_LISTING_LIFETIME_DAYS', 90);                 // 7.6 — строк публікації
defined('MP_RULES_CHANGE_NOTICE_DAYS') || define('MP_RULES_CHANGE_NOTICE_DAYS', 7);            // 13.3
defined('MP_CONTACT_VIEWS_PER_DAY') || define('MP_CONTACT_VIEWS_PER_DAY', 50);                 // 12.3 — переглядів контактів на акаунт за добу

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

    // Фото оголошень: тека ПОЗА webroot (public/), PHP має вміти писати; створюється автоматично.
    // Віддає фото public/mp-photo.php з перевіркою прав (.htaccess у публічній теці на adm.tools не працює). Ліміти.
    'photo_dir'        => dirname(__DIR__) . '/storage/marketplace/photos',
    'photo_max_count'  => 8,
    'photo_max_bytes'  => 5 * 1024 * 1024,   // на одне фото, до перекодування
    'photo_max_side'   => 1600,              // довша сторона збереженого фото, px
    'photo_thumb_side' => 400,               // довша сторона мініатюри, px

    // Термін життя оголошення (днів) — від схвалення й від кнопки «Продовжити». Значення береться з MP_LISTING_LIFETIME_DAYS.
    'listing_ttl_days' => MP_LISTING_LIFETIME_DAYS,

    // Захист від спаму (не стосується employee/admin).
    'max_active_per_user'  => 5,    // pending + published
    'max_new_per_day'      => 10,   // нових оголошень за 24 год
    'max_links_in_desc'    => 2,    // посилань в описах
    'stop_words'           => [],   // напр. ['казино', 'ставки'] — без урахування регістру
    'reveals_per_day'      => MP_CONTACT_VIEWS_PER_DAY,   // розкриттів контактів на користувача за 24 год (п. 12.3)
    'reports_threshold'    => 3,    // унікальних скарг → оголошення повертається в pending

    // Cron для mp-cron-expire.php: з CLI працює завжди; через HTTP лише якщо тут непорожній ключ
    // (виклик: mp-cron-expire.php?token=<ключ>). Порожній → HTTP-доступ вимкнено.
    'cron_token'       => '',

    // --- Підтвердження email (етап 5) ---
    // Як надсилати листи підтвердження: 'mail' — app/mailer.php (PHP mail(), як і решта листів сайту);
    // 'log' — лист (із посиланням) пишеться у storage/marketplace-mail.log, нічого не надсилається (розробка).
    // SMTP у проєкті немає, тож інших значень не існує.
    'mail_transport'      => 'mail',
    // Абсолютна адреса сайту для посилання в листі, напр. 'https://example.com'. Посилання будуються ЛИШЕ з неї
    // (Host не використовується). Порожньо + mail_transport не 'log' → лист не надсилається, помилка йде в error log.
    'site_url'            => '',
    'verify_ttl_hours'    => 24,   // термін дії токена
    'verify_resend_min'   => 2,    // не частіше 1 листа на N хвилин
    'verify_max_per_day'  => 5,    // не більше N листів на добу
    'report_min_verified_hours' => 24,   // скарги рахуються для автозняття, лише якщо email підтверджено давніше

    // --- Правила розміщення оголошень ---
    // Дата редакції Правил (YYYY-MM-DD): показується на mp-rules.php. Оновлюйте при кожній зміні
    // docs/marketplace_rules_uk.md. Лише показ — у БД (rules_accepted_at) версія не записується.
    'rules_version'       => MP_RULES_VERSION,

    // --- IP-ліміти (другий шар захисту; основні ліміти — на акаунт) ---
    // Сіль для хешування IP (IP у відкритому вигляді не зберігається). ЗАДАЙТЕ на сервері довгий випадковий рядок.
    'rate_limit_salt'      => '',
    // Заголовок проксі з реальним IP клієнта (напр. 'X-Forwarded-For'). Порожньо (за замовчуванням) → лише REMOTE_ADDR.
    // Якщо задано — береться ОСТАННІЙ елемент заголовка (його додає довірений проксі). Задавайте, лише якщо сайт справді за проксі.
    'trusted_proxy_header' => '',
    // Ліміти на добу з одного IP (щедрі: мобільні оператори віддають один IP багатьом користувачам).
    'ip_limit_reveal'      => 100,   // розкриття контактів
    'ip_limit_report'      => 20,    // скарги
    'ip_limit_post'        => 15,    // нові оголошення
    'ip_limit_mail'        => 20,    // листи підтвердження email

    // --- Поетапний запуск ---
    // Подача й редагування оголошень користувачами. false (за замовчуванням, у т.ч. в marketplace.dist.php):
    // створювати/редагувати оголошення можуть ЛИШЕ employee/admin (перевіряється на сервері), звичайні користувачі
    // бачать «Подача оголошень відкриється згодом», кнопка «Подати оголошення» і сторінка Правил для публіки
    // (mp-rules.php → 404, посилання в підвалі) приховані. Вибране, перегляд, розкриття контактів і скарги працюють.
    // true — відкрити подачу всім (лише після юриста, підстановки даних і фіналізації Правил; збірка з true
    // перевіряє, що в docs/marketplace_rules_uk.md немає маркерів і «ЧЕРНЕТКА»).
    'posting_enabled'     => true,
    // Дерево категорій Marketplace: показувати порожні підкатегорії (за замовчуванням — ні, як у каталозі).
    'show_empty_categories' => false,
    // Блоки на головній Marketplace, що видно навіть порожніми (section блока); інші порожні блоки приховано.
    'always_visible_blocks' => ['job', 'course', 'service', 'solution'],

    // --- Хвиля 1 (2026-11-09): фільтри вакансій, популярні запити, збережені пошуки ---
    // Нейтральні позначки «Підходить» для вакансій (mp_listing_tags). ЛИШЕ такі значення; жодних вікових діапазонів
    // чи ознак на кшталт «старше N років» (код відкидає значення з цифрами й «вік/age»). Розширення — лише після юриста.
    'suitable_for'         => ['students', 'no_experience', 'career_switch', 'junior'],
    // Популярні запити: автоматичний чип — запит із щонайменше N пошуками за 30 днів (закріплені адміном — завжди).
    'popular_min_hits'     => 10,
    // Чипи популярних запитів на головній каталогу: вимкнено (структура scope 'catalog' закладена, запис не ведеться).
    'popular_queries_catalog' => false,
    // Збережені пошуки: не більше N активних на користувача.
    'saved_search_max'     => 10,
    // Листи «нові оголошення за збереженим пошуком» (public/mp-cron-saved-searches.php). false — не надсилаються.
    'saved_search_email_enabled' => false,
    // Секрет для підпису посилань відписки (HMAC). ЗАДАЙТЕ на сервері довгий випадковий рядок; порожньо — листи не йдуть.
    'saved_search_secret'  => '',
    // Не більше N листів за один запуск скрипта.
    'saved_search_mail_batch' => 50,
    // IP-ліміти на добу: лічильник «Показати N результатів» і збереження пошуків.
    'ip_limit_count'       => 1500,
    'ip_limit_saved'       => 60,
];
