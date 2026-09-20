<?php
// Скопіюй у config.php і заповни. config.php НЕ комітити в Git (додай у .gitignore).
return [
    'anthropic_key'     => getenv('ANTHROPIC_API_KEY') ?: '',
    'model_enrich'      => 'claude-haiku-4-5-20251001',   // дешева модель для масових карток
    'model_discover'    => 'claude-sonnet-5',             // розумніша — для пошуку кандидатів по підкатегоріях

    'producthunt_token' => getenv('PH_TOKEN') ?: '',      // опційно (developer token Product Hunt)
    'github_token'      => getenv('GITHUB_TOKEN') ?: '',  // опційно, збільшує ліміти

    'user_agent'        => 'AILabHubBot/1.0 (+https://ailabhub-directory.com; hello@ailabhub-directory.com)',
    'ca_bundle'         => '',   // Laragon/Windows: якщо "SSL certificate problem" — вкажи шлях до cacert.pem

    'fetch_delay_ms'    => 1500,      // пауза між запитами до сайтів
    'max_html_bytes'    => 2000000,
    'text_chars_home'   => 7000,      // скільки символів тексту головної віддавати моделі
    'text_chars_pricing'=> 5000,

    'min_confidence'    => 0.6,       // нижче — картка йде у review
    'min_per_subcategory' => 10,      // ваша вимога: мінімум 10 продуктів у підкатегорії

    // Ціни за 1 млн токенів (ПЕРЕВІР актуальні на сторінці pricing Anthropic) — лише для оцінки витрат
    'price_in_per_mtok' => 1.0,
    'price_out_per_mtok'=> 5.0,
    'max_run_usd'       => 5.0,       // запобіжник: зупинитись, якщо один запуск enrich витратив більше

    'export_batch_size' => 100,       // продуктів в одному SQL-файлі (щоб влізти в ліміти phpMyAdmin)

    // Ключі моделей монетизації (значення в БД задаються в schema_map.php)
    'monetization_models' => ['free', 'freemium', 'paid', 'subscription', 'one_time', 'open_source', 'usage_based'],

    // Гібридний режим без API-ключа (enrich:export / enrich:import): розміри пакета й тексту сторінок
    'pack_size'               => 10,     // скільки сайтів у одному пакеті
    'pack_text_chars_home'    => 4000,   // символів тексту головної в пакеті
    'pack_text_chars_pricing' => 2500,   // символів тексту сторінки цін

    'paths' => [
        'data'   => __DIR__ . '/data',
        'export' => __DIR__ . '/export',
    ],
];
