<?php
/**
 * ЄДИНЕ місце, яке залежить від реальної схеми MySQL сайту.
 *
 * Звірено з реальною схемою AI LAB HUB (database/schema.sql + міграції;
 * SHOW CREATE TABLE локальної ailabhub_db, 2026-09-20). Джерела форматів:
 * public/crm-add-product.php (як CRM зберігає продукт) і наявні дані.
 * Колонку, якої немає в БД, став null — вона пропуститься.
 */
return [
    'products' => [
        'table' => 'products',
        'id' => 'id',
        'cols' => [
            'name'         => 'name',
            'logo'         => 'logo_url',
            // Антидубль в SQL — за нормалізованим official_url (без схеми, www, кінцевого слеша).
            'website'      => 'official_url',
            'short'        => 'short_description',
            'full'         => 'full_description',
            // Колонки моделі монетизації в БД НЕМАЄ: «Безкоштовно/Freemium/Платно» сайт
            // виводить із pricing_plans (crm-list.php → pricing_summary). Тож null.
            'monetization' => null,
            'features'     => 'main_features',       // TEXT, по одному пункту на рядок
            'audience'     => 'target_audience',
            'platform'     => 'platform',            // SET('web','mobile','desktop'), значення через кому
            'skill'        => 'skill_level',         // ENUM('none','basic','course')
            'status'       => 'status',              // ENUM('none','in_progress','published')
            'partnership'  => 'partnership_status',  // ENUM('found','pending_registration','partner_connected','no_partnership')
            'internal_reg' => 'internal_registration_url',
            'created_at'   => 'created_at',
        ],
    ],

    // Як наші ключі перетворюються на значення в БД
    'values' => [
        // CRM ставить 'published', коли є назва, офіційний URL, короткий опис і категорія;
        // автонаповнення гарантує всі чотири (категорії обов'язкові для валідної картки).
        'status'       => 'published',
        'partnership'  => 'found',       // за замовчуванням у БД теж 'found'
        'features_sep' => "\n",          // main_features: пункти через перенос рядка ("По одному пункту на рядок")
        'platform_sep' => ',',           // SET: 'web,mobile'
        'monetization' => [],            // не використовується (колонки нема)
        // Ключі моделі → skill_level; у БД 'course' (у промпті інструмента — 'training').
        'skill' => ['none' => 'none', 'basic' => 'basic', 'training' => 'course'],
        // pricing_plans.period: ENUM('free','week','month','year','one_time').
        // 'custom' («ціна за запитом») → 'month' із price NULL: так уже збережено
        // 20 наявних планів (period=month, price NULL).
        'period' => [
            'free' => 'free', 'month' => 'month', 'year' => 'year', 'one_time' => 'one_time', 'week' => 'week',
            'custom' => 'month',
        ],
    ],

    // Категорії/підкатегорії шукаються за НАЗВОЮ (id знати не потрібно)
    'cats'    => ['table' => 'categories',    'id' => 'id', 'name' => 'name'],
    'subcats' => ['table' => 'subcategories', 'id' => 'id', 'name' => 'name', 'cat_id' => 'category_id'],
    // many-to-many: продукт ↔ підкатегорія
    'links'   => ['table' => 'product_subcategories', 'product' => 'product_id', 'subcat' => 'subcategory_id'],
    // many-to-many: продукт ↔ категорія. Сайт читає ОБИДВА зв'язки (catalog.php?category=…,
    // product.php), CRM пише обидва — тож автонаповнення теж мусить (Exporter виводить
    // категорію з обраних підкатегорій).
    'cat_links' => ['table' => 'product_categories', 'product' => 'product_id', 'cat' => 'category_id'],

    // Тарифні плани (необмежена кількість на продукт)
    'plans' => [
        'table' => 'pricing_plans',
        'product' => 'product_id', 'name' => 'plan_name', 'price' => 'price', 'period' => 'period', 'description' => 'description',
        // false: price = DECIMAL(10,2) (число; безкоштовний план = 0.00, як у наявних даних).
        // Валюта окремої колонки не має; ціни на сайті в USD ($), тож для не-USD валюти
        // Exporter дописує «Ціна в EUR.» в опис плану.
        'price_text' => false,
    ],

    // Логотипи: products.logo_url зберігає шлях відносно public/ («assets/images/logos/<файл>»),
    // так його пише CRM. Файли з *_logos.zip — у public/assets/images/logos/ на хостингу.
    'logo_prefix' => 'assets/images/logos/',
];
