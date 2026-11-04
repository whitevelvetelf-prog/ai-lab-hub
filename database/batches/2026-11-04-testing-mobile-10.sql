SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-04: «Розробка та IT» (slug development-it) → підкатегорія «Тестування» (slug testing).
-- Партія 5: 10 нових продуктів — тестування мобільних застосунків (для статті про мобільне тестування); Android Studio і Xcode → «Тестування».
-- Тексти UA/EN написано за офіційними сторінками, звірено 2026-11-04. Якщо продукт з такою адресою чи назвою вже є — лише прив’язка.
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою. Повторний запуск безпечний.
--   Firebase Test Lab
--   Firebase Crashlytics
--   AWS Device Farm
--   Appetize.io
--   HeadSpin
--   Patrol
--   Perfetto
--   MobSF
--   Frida
--   Bugsnag
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'development-it' LIMIT 1);

-- Firebase Test Lab — Тестування, Мобільна розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'firebase.google.com/docs/test-lab' OR LOWER(`name`) = 'firebase test lab')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Firebase Test Lab', NULL, 'https://firebase.google.com/docs/test-lab', NULL, NULL, 'Хмарна інфраструктура Google для запуску тестів Android та iOS на реальних і віртуальних пристроях.', 'Google cloud infrastructure for running Android and iOS tests on real and virtual devices.', 'Firebase Test Lab запускає інструментальні тести (Espresso, UI Automator, XCTest) на пристроях у дата-центрах Google, а для Android ще й Robo-тест, який сам «проклацує» застосунок без жодного написаного тесту. Результати містять відео, скриншоти, логи й дані про продуктивність. Квоти на тести входять у безкоштовний тариф Spark і платний Blaze.', 'Firebase Test Lab runs instrumentation tests (Espresso, UI Automator, XCTest) on devices in Google data centres, and for Android also offers a Robo test that crawls the app by itself with no tests written. Results include videos, screenshots, logs and performance data. Testing quotas come with the free Spark plan and the paid Blaze plan.', 'Реальні й віртуальні пристрої Google
Robo-тест без написання тестів
Espresso, UI Automator, XCTest
Відео, скриншоти, логи', 'Real and virtual Google-hosted devices
Robo test with no code
Espresso, UI Automator, XCTest
Videos, screenshots, logs', 'Мобільні QA-інженери, тестувальники й розробники застосунків для Android та iOS', 'Mobile QA engineers, testers and Android and iOS app developers', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'firebase.google.com/docs/test-lab' OR LOWER(`name`) = 'firebase test lab') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'mobile-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Google cloud infrastructure for running Android and iOS tests on real and virtual devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Firebase Test Lab runs instrumentation tests (Espresso, UI Automator, XCTest) on devices in Google data centres, and for Android also offers a Robo test that crawls the app by itself with no tests written. Results include videos, screenshots, logs and performance data. Testing quotas come with the free Spark plan and the paid Blaze plan.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real and virtual Google-hosted devices
Robo test with no code
Espresso, UI Automator, XCTest
Videos, screenshots, logs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Mobile QA engineers, testers and Android and iOS app developers', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовний тариф або версія з обмеженнями.', 'A free plan or limited free version is available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free plan or limited free version is available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Firebase Crashlytics — Тестування, Мобільна розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'firebase.google.com/products/crashlytics' OR LOWER(`name`) = 'firebase crashlytics')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Firebase Crashlytics', NULL, 'https://firebase.google.com/products/crashlytics', NULL, NULL, 'Безкоштовні звіти про збої в реальному часі для застосунків на iOS, Android, Flutter і Unity.', 'Free real-time crash reporting for iOS, Android, Flutter and Unity apps.', 'Crashlytics збирає збої та нефатальні помилки з пристроїв користувачів і тестувальників, групує їх, показує стек викликів, модель пристрою, версію ОС і кроки до збою. Допомагає зрозуміти, які падіння зачіпають найбільше людей, і перевірити, чи зник збій після виправлення. Частина Firebase від Google.', 'Crashlytics collects crashes and non-fatal errors from users'' and testers'' devices, groups them and shows the stack trace, device model, OS version and the steps leading to the crash. It helps you see which crashes affect the most people and confirm that a crash is gone after a fix. Part of Google Firebase.', 'Збої й нефатальні помилки в реальному часі
Групування й пріоритети
iOS, Android, Flutter, Unity
Безкоштовно', 'Real-time crashes and non-fatal errors
Grouping and prioritisation
iOS, Android, Flutter, Unity
Free', 'Мобільні QA-інженери, тестувальники й розробники застосунків для Android та iOS', 'Mobile QA engineers, testers and Android and iOS app developers', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'firebase.google.com/products/crashlytics' OR LOWER(`name`) = 'firebase crashlytics') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'mobile-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free real-time crash reporting for iOS, Android, Flutter and Unity apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Crashlytics collects crashes and non-fatal errors from users'' and testers'' devices, groups them and shows the stack trace, device model, OS version and the steps leading to the crash. It helps you see which crashes affect the most people and confirm that a crash is gone after a fix. Part of Google Firebase.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time crashes and non-fatal errors
Grouping and prioritisation
iOS, Android, Flutter, Unity
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Mobile QA engineers, testers and Android and iOS app developers', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AWS Device Farm — Тестування, Мобільна розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aws.amazon.com/device-farm' OR LOWER(`name`) = 'aws device farm')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AWS Device Farm', NULL, 'https://aws.amazon.com/device-farm/', NULL, NULL, 'Сервіс Amazon для тестування застосунків iOS, Android і вебу на реальних смартфонах, планшетах і браузерах.', 'Amazon service for testing iOS, Android and web apps on real smartphones, tablets and desktop browsers.', 'AWS Device Farm запускає автотести (Appium, Espresso, XCUITest та інші) паралельно на реальних пристроях у хмарі Amazon і дає змогу вручну керувати пристроєм із браузера. Звіти містять відео, логи й дані про продуктивність. Оплата — за хвилини використання пристроїв або фіксована щомісячна плата за виділені пристрої.', 'AWS Device Farm runs automated tests (Appium, Espresso, XCUITest and others) in parallel on real devices in the Amazon cloud and lets you control a device manually from the browser. Reports include videos, logs and performance data. You pay per device minute or a flat monthly fee for dedicated devices.', 'Реальні пристрої iOS і Android
Appium, Espresso, XCUITest
Ручне керування з браузера
Відео й логи прогонів', 'Real iOS and Android devices
Appium, Espresso, XCUITest
Manual remote access in the browser
Run videos and logs', 'Мобільні QA-інженери, тестувальники й розробники застосунків для Android та iOS', 'Mobile QA engineers, testers and Android and iOS app developers', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aws.amazon.com/device-farm' OR LOWER(`name`) = 'aws device farm') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'mobile-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Amazon service for testing iOS, Android and web apps on real smartphones, tablets and desktop browsers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'AWS Device Farm runs automated tests (Appium, Espresso, XCUITest and others) in parallel on real devices in the Amazon cloud and lets you control a device manually from the browser. Reports include videos, logs and performance data. You pay per device minute or a flat monthly fee for dedicated devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real iOS and Android devices
Appium, Espresso, XCUITest
Manual remote access in the browser
Run videos and logs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Mobile QA engineers, testers and Android and iOS app developers', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Appetize.io — Тестування, Мобільна розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'appetize.io' OR LOWER(`name`) = 'appetize.io')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Appetize.io', NULL, 'https://appetize.io', NULL, NULL, 'Хмарні симулятори iOS і емулятори Android просто в браузері: показати, протестувати чи налагодити застосунок.', 'Cloud iOS simulators and Android emulators right in the browser to demo, test or debug an app.', 'Appetize.io запускає завантажену збірку застосунку в хмарному симуляторі чи емуляторі, який відкривається в браузері, — без Mac, Android Studio й фізичних пристроїв. Посилання можна надіслати колегам чи замовнику; є автотести через Playwright і доступ для АІ-агентів. Безкоштовний тариф — 30 хвилин на місяць.', 'Appetize.io runs an uploaded app build in a cloud simulator or emulator that opens in the browser, with no Mac, Android Studio or physical devices. You can share a link with colleagues or clients; it also supports automated tests via Playwright and access for AI agents. The free plan includes 30 minutes a month.', 'Симулятори й емулятори в браузері
Посилання на збірку для команди
Автотести через Playwright
Безкоштовні 30 хвилин на місяць', 'Simulators and emulators in the browser
Shareable build links
Automated tests via Playwright
Free 30 minutes a month', 'Мобільні QA-інженери, тестувальники й розробники застосунків для Android та iOS', 'Mobile QA engineers, testers and Android and iOS app developers', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'appetize.io' OR LOWER(`name`) = 'appetize.io') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'mobile-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Cloud iOS simulators and Android emulators right in the browser to demo, test or debug an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Appetize.io runs an uploaded app build in a cloud simulator or emulator that opens in the browser, with no Mac, Android Studio or physical devices. You can share a link with colleagues or clients; it also supports automated tests via Playwright and access for AI agents. The free plan includes 30 minutes a month.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Simulators and emulators in the browser
Shareable build links
Automated tests via Playwright
Free 30 minutes a month', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Mobile QA engineers, testers and Android and iOS app developers', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовний тариф або версія з обмеженнями.', 'A free plan or limited free version is available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free plan or limited free version is available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- HeadSpin — Тестування, Мобільна розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'headspin.io' OR LOWER(`name`) = 'headspin')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HeadSpin', NULL, 'https://www.headspin.io', NULL, NULL, 'Платформа тестування на реальних пристроях у 50+ локаціях з аналітикою продуктивності й мережі.', 'Real device testing platform in 50+ locations with performance and network analytics.', 'HeadSpin дає доступ до реальних смартфонів, браузерів і медіапристроїв (Smart TV, OTT) у різних країнах і мережах операторів. Окрім ручних і автоматизованих тестів, вимірює показники продуктивності й якості відео, порівнює їх між релізами та підсвічує проблеми з АІ-аналізом. Корпоративний продукт, ціни — за запитом.', 'HeadSpin provides access to real smartphones, browsers and media devices (Smart TV, OTT) in different countries and carrier networks. Beyond manual and automated tests, it measures performance and video quality KPIs, compares them across releases and highlights issues with AI analysis. An enterprise product; pricing on request.', 'Реальні пристрої в 50+ локаціях
Мережі мобільних операторів
Метрики продуктивності й відео
АІ-аналіз проблем', 'Real devices in 50+ locations
Mobile carrier networks
Performance and video KPIs
AI issue analysis', 'Мобільні QA-інженери, тестувальники й розробники застосунків для Android та iOS', 'Mobile QA engineers, testers and Android and iOS app developers', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'headspin.io' OR LOWER(`name`) = 'headspin') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'mobile-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Real device testing platform in 50+ locations with performance and network analytics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'HeadSpin provides access to real smartphones, browsers and media devices (Smart TV, OTT) in different countries and carrier networks. Beyond manual and automated tests, it measures performance and video quality KPIs, compares them across releases and highlights issues with AI analysis. An enterprise product; pricing on request.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real devices in 50+ locations
Mobile carrier networks
Performance and video KPIs
AI issue analysis', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Mobile QA engineers, testers and Android and iOS app developers', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Patrol — Тестування, Мобільна розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'patrol.leancode.co' OR LOWER(`name`) = 'patrol')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Patrol', NULL, 'https://patrol.leancode.co', NULL, NULL, 'Відкритий фреймворк наскрізних UI-тестів для Flutter, що вміє працювати з нативними діалогами й налаштуваннями.', 'Open-source end-to-end UI testing framework for Flutter that can handle native dialogs and settings.', 'Patrol розширює стандартний integration_test у Flutter: тести на Dart можуть натискати системні діалоги дозволів, працювати зі сповіщеннями й WebView, вмикати й вимикати Wi-Fi та змінювати налаштування пристрою. Має коротший синтаксис пошуку елементів і CLI для запуску на Android та iOS. Розробляє LeanCode, відкритий код.', 'Patrol extends Flutter''s standard integration_test: Dart tests can tap system permission dialogs, work with notifications and WebViews, toggle Wi-Fi and change device settings. It has a shorter finder syntax and a CLI for running on Android and iOS. Developed by LeanCode, open source.', 'Нативні діалоги, сповіщення, WebView
Керування налаштуваннями пристрою
Короткий синтаксис пошуку елементів
Відкритий код', 'Native dialogs, notifications, WebViews
Device settings control
Short finder syntax
Open source', 'QA-інженери з автоматизації та розробники, що пишуть автотести', 'Test automation engineers and developers writing automated tests', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'patrol.leancode.co' OR LOWER(`name`) = 'patrol') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'mobile-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source end-to-end UI testing framework for Flutter that can handle native dialogs and settings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Patrol extends Flutter''s standard integration_test: Dart tests can tap system permission dialogs, work with notifications and WebViews, toggle Wi-Fi and change device settings. It has a shorter finder syntax and a CLI for running on Android and iOS. Developed by LeanCode, open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Native dialogs, notifications, WebViews
Device settings control
Short finder syntax
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Test automation engineers and developers writing automated tests', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Perfetto — Тестування, Мобільна розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'perfetto.dev' OR LOWER(`name`) = 'perfetto')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Perfetto', NULL, 'https://perfetto.dev', NULL, NULL, 'Відкритий інструмент Google для профілювання й трасування Android і Linux з переглядачем у браузері.', 'Open-source Google tool for profiling and tracing Android and Linux, with an in-browser viewer.', 'Perfetto записує трасу роботи системи й застосунку: завантаження процесора, планування потоків, пам’ять, рендеринг кадрів. Вбудований в Android з версії 9, а Perfetto UI відкриває траси прямо в браузері без сервера. Допомагає з’ясувати, чому застосунок «гальмує», пропускає кадри чи довго запускається. Відкритий код.', 'Perfetto records a trace of system and app activity: CPU usage, thread scheduling, memory and frame rendering. It is built into Android since version 9, and Perfetto UI opens traces right in the browser with no server. It helps find out why an app stutters, drops frames or starts slowly. Open source.', 'Трасування Android і Linux
Процесор, пам’ять, кадри
Переглядач у браузері
Відкритий код', 'Android and Linux tracing
CPU, memory, frames
In-browser trace viewer
Open source', 'Мобільні QA-інженери, тестувальники й розробники застосунків для Android та iOS', 'Mobile QA engineers, testers and Android and iOS app developers', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'perfetto.dev' OR LOWER(`name`) = 'perfetto') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'mobile-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source Google tool for profiling and tracing Android and Linux, with an in-browser viewer.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Perfetto records a trace of system and app activity: CPU usage, thread scheduling, memory and frame rendering. It is built into Android since version 9, and Perfetto UI opens traces right in the browser with no server. It helps find out why an app stutters, drops frames or starts slowly. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Android and Linux tracing
CPU, memory, frames
In-browser trace viewer
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Mobile QA engineers, testers and Android and iOS app developers', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MobSF — Тестування
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/mobsf/mobile-security-framework-mobsf' OR LOWER(`name`) = 'mobsf')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MobSF', NULL, 'https://github.com/MobSF/Mobile-Security-Framework-MobSF', NULL, NULL, 'Відкритий фреймворк автоматичного аналізу безпеки застосунків Android та iOS: статичний і динамічний.', 'Open-source framework for automated static and dynamic security analysis of Android and iOS apps.', 'Mobile Security Framework (MobSF) приймає файл APK, AAB чи IPA й автоматично перевіряє його: небезпечні дозволи, жорстко прописані ключі й паролі, слабку криптографію, незахищені мережеві налаштування. Динамічний аналіз запускає застосунок на емуляторі й стежить за його поведінкою. Звіт допомагає тестувальнику знайти типові вразливості без глибоких знань безпеки. Відкритий код.', 'Mobile Security Framework (MobSF) takes an APK, AAB or IPA file and checks it automatically: dangerous permissions, hard-coded keys and passwords, weak cryptography and insecure network settings. Dynamic analysis runs the app on an emulator and watches its behaviour. The report helps a tester find common vulnerabilities without deep security expertise. Open source.', 'Статичний аналіз APK, AAB, IPA
Динамічний аналіз на емуляторі
Пошук ключів і небезпечних дозволів
Відкритий код', 'Static analysis of APK, AAB, IPA
Dynamic analysis on an emulator
Finds secrets and risky permissions
Open source', 'Тестувальники безпеки, пентестери й розробники, що перевіряють захищеність мобільних застосунків', 'Security testers, pentesters and developers checking the security of mobile apps', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/mobsf/mobile-security-framework-mobsf' OR LOWER(`name`) = 'mobsf') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source framework for automated static and dynamic security analysis of Android and iOS apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mobile Security Framework (MobSF) takes an APK, AAB or IPA file and checks it automatically: dangerous permissions, hard-coded keys and passwords, weak cryptography and insecure network settings. Dynamic analysis runs the app on an emulator and watches its behaviour. The report helps a tester find common vulnerabilities without deep security expertise. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Static analysis of APK, AAB, IPA
Dynamic analysis on an emulator
Finds secrets and risky permissions
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Security testers, pentesters and developers checking the security of mobile apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Frida — Тестування
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'frida.re' OR LOWER(`name`) = 'frida')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Frida', NULL, 'https://frida.re', NULL, NULL, 'Відкритий інструментарій динамічної інструментації: спостерігати й змінювати роботу застосунку під час виконання.', 'Open-source dynamic instrumentation toolkit to observe and modify an app while it runs.', 'Frida вбудовує JavaScript у запущений процес на Android, iOS, Windows, macOS чи Linux і дає змогу перехоплювати виклики функцій, дивитися й підміняти дані. У тестуванні безпеки мобільних застосунків її використовують, щоб обійти SSL pinning, перевірити захист від root/jailbreak і зрозуміти, що застосунок робить «під капотом». Відкритий код.', 'Frida injects JavaScript into a running process on Android, iOS, Windows, macOS or Linux and lets you hook function calls and inspect or change data. In mobile security testing it is used to bypass SSL pinning, check root/jailbreak detection and understand what an app does under the hood. Open source.', 'Перехоплення викликів функцій
Android, iOS, десктоп
Обхід SSL pinning для тестів
Відкритий код', 'Function call hooking
Android, iOS, desktop
SSL pinning bypass for testing
Open source', 'Тестувальники безпеки, пентестери й розробники, що перевіряють захищеність мобільних застосунків', 'Security testers, pentesters and developers checking the security of mobile apps', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'frida.re' OR LOWER(`name`) = 'frida') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source dynamic instrumentation toolkit to observe and modify an app while it runs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Frida injects JavaScript into a running process on Android, iOS, Windows, macOS or Linux and lets you hook function calls and inspect or change data. In mobile security testing it is used to bypass SSL pinning, check root/jailbreak detection and understand what an app does under the hood. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Function call hooking
Android, iOS, desktop
SSL pinning bypass for testing
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Security testers, pentesters and developers checking the security of mobile apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bugsnag — Тестування, Мобільна розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bugsnag.com' OR LOWER(`name`) = 'bugsnag')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bugsnag', NULL, 'https://www.bugsnag.com', NULL, NULL, 'Моніторинг помилок і продуктивності мобільних, веб- і серверних застосунків зі стабільністю релізів.', 'Error and performance monitoring for mobile, web and back-end apps with release stability scores.', 'Bugsnag збирає збої й помилки з застосунків на Android, iOS, React Native, Flutter, Unity та вебі, групує їх і показує, скільки користувачів зачеплено. Показник стабільності для кожного релізу допомагає вирішити, чи можна розширювати викатку нової версії. Є моніторинг продуктивності й розподілене трасування. Є безкоштовний тариф для одного користувача.', 'Bugsnag collects crashes and errors from Android, iOS, React Native, Flutter, Unity and web apps, groups them and shows how many users are affected. A stability score for each release helps decide whether to widen the rollout of a new version. It also offers performance monitoring and distributed tracing. A free plan for a single user is available.', 'Збої мобільних і вебзастосунків
Стабільність кожного релізу
Моніторинг продуктивності
Безкоштовний тариф', 'Mobile and web crash reporting
Per-release stability score
Performance monitoring
Free plan', 'Мобільні QA-інженери, тестувальники й розробники застосунків для Android та iOS', 'Mobile QA engineers, testers and Android and iOS app developers', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bugsnag.com' OR LOWER(`name`) = 'bugsnag') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'mobile-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Error and performance monitoring for mobile, web and back-end apps with release stability scores.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Bugsnag collects crashes and errors from Android, iOS, React Native, Flutter, Unity and web apps, groups them and shows how many users are affected. A stability score for each release helps decide whether to widen the rollout of a new version. It also offers performance monitoring and distributed tracing. A free plan for a single user is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Mobile and web crash reporting
Per-release stability score
Performance monitoring
Free plan', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Mobile QA engineers, testers and Android and iOS app developers', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовний тариф або версія з обмеженнями.', 'A free plan or limited free version is available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free plan or limited free version is available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Наявні продукти → «Тестування»
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'Android Studio' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'Xcode' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

