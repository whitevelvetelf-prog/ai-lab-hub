SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-01: «Розробка та IT» (slug development-it) → нова підкатегорія
--   «Тренажери для тестувальників» / «Practice Sites for Testers» (slug qa-practice) — сайти-тренажери для тестувальників.
-- 47 нових продуктів (якщо продукт із такою адресою чи назвою вже є — лише прив'язка).
-- Тексти UA/EN написано за офіційними сторінками сайтів, звірено 2026-11-01.
-- Плани: «Ціна: див. сайт» (0, one_time) + Free (безкоштовний доступ; у ReqRes і Ministry of Testing є й платні тарифи).
-- Пропущено: qaplayground.dev (домен не відповідає), magento.softwaretestingboard.com (помилка 526), testingworld.in (немає DNS),
--   UltimateQA (сайт тепер про студію розробки), CosmoCode (практичну сторінку прибрано), DVWA і nopCommerce demo (403),
--   LambdaTest Selenium Playground (уже є продукт TestMu AI), Postman Echo (веде на документацію Postman).
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   The Internet (Herokuapp)
--   Sauce Demo (Swag Labs)
--   DemoQA
--   UI Test Automation Playground
--   Automation Exercise
--   ParaBank
--   Practice Test Automation
--   Expand Testing Practice
--   LetCode
--   Restful-Booker
--   ReqRes
--   JSONPlaceholder
--   Swagger Petstore
--   OWASP Juice Shop
--   Rahul Shetty Academy Practice Page
--   Guru99 Demo Sites
--   OrangeHRM Demo
--   Conduit (RealWorld)
--   Buggy Cars Rating
--   Practice Software Testing (Toolshop)
--   Test Pages (EvilTester)
--   TodoMVC
--   Weather Shopper
--   WebDriverUniversity
--   httpbin
--   GoRest
--   Fake Store API
--   DummyJSON
--   PortSwigger Web Security Academy
--   Test Automation University
--   Ministry of Testing
--   Testing Playground
--   CSS Diner
--   uTest
--   BugMagnet
--   GlobalSQA Demo Site
--   TestSheepNZ
--   BlazeDemo
--   Demoblaze (Product Store)
--   AcademyBugs
--   XPather
--   Contact List App
--   Bondar Academy Playground
--   TestKru
--   StackDemo (BrowserStack)
--   QA Practice
--   Sauce Labs My Demo App
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'development-it' LIMIT 1);
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Тренажери для тестувальників', 'Practice Sites for Testers', 'qa-practice' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice');

-- The Internet (Herokuapp) — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'the-internet.herokuapp.com' OR LOWER(`name`) = 'the internet (herokuapp)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Internet (Herokuapp)', NULL, 'https://the-internet.herokuapp.com', NULL, NULL, 'Класичний набір сторінок для тренування автотестів: понад 40 типових «складних» елементів.', 'A classic set of practice pages for test automation with 40+ tricky web elements.', 'The Internet — безкоштовний навчальний сайт із десятками окремих прикладів: A/B-тест, базова авторизація, динамічний вміст, перетягування, фрейми, JavaScript-алерти, завантаження файлів, нескінченна прокрутка, повідомлення, що зникають, тощо. Кожна сторінка відтворює одну типову проблему автоматизації, тож на ній зручно відпрацювати локатори, очікування й роботу з вікнами в Selenium, Playwright чи Cypress.', 'The Internet is a free practice site with dozens of separate examples: A/B testing, basic auth, dynamic content, drag and drop, frames, JavaScript alerts, file upload and download, infinite scroll, disappearing elements and more. Each page reproduces one common automation problem, so it is handy for practising locators, waits and window handling in Selenium, Playwright or Cypress.', 'Понад 40 окремих прикладів елементів і сценаріїв
Динамічні елементи, фрейми, алерти, вікна
Форми входу з тестовими даними
Без реєстрації', '40+ separate element and scenario examples
Dynamic elements, frames, alerts, windows
Login forms with test credentials
No signup', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'the-internet.herokuapp.com' OR LOWER(`name`) = 'the internet (herokuapp)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A classic set of practice pages for test automation with 40+ tricky web elements.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Internet is a free practice site with dozens of separate examples: A/B testing, basic auth, dynamic content, drag and drop, frames, JavaScript alerts, file upload and download, infinite scroll, disappearing elements and more. Each page reproduces one common automation problem, so it is handy for practising locators, waits and window handling in Selenium, Playwright or Cypress.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '40+ separate element and scenario examples
Dynamic elements, frames, alerts, windows
Login forms with test credentials
No signup', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sauce Demo (Swag Labs) — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'saucedemo.com' OR LOWER(`name`) = 'sauce demo (swag labs)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sauce Demo (Swag Labs)', NULL, 'https://www.saucedemo.com', NULL, NULL, 'Демо-інтернет-магазин від Sauce Labs для тренування наскрізних тестів: вхід, кошик, оформлення.', 'Sauce Labs demo web shop for practising end-to-end tests: login, cart and checkout.', 'Swag Labs — навчальний магазин від Sauce Labs: вхід, каталог із сортуванням, кошик і оформлення замовлення. Сайт пропонує кілька тестових користувачів із різною поведінкою (заблокований, із «зламаним» інтерфейсом, з повільною відповіддю, з візуальними помилками), тож на одному застосунку можна тренувати позитивні й негативні сценарії та візуальне тестування.', 'Swag Labs is a practice shop by Sauce Labs: login, a sortable catalogue, cart and checkout. The site offers several test users with different behaviour (locked out, broken UI, slow responses, visual glitches), so one app covers positive and negative scenarios as well as visual testing.', 'Повний сценарій покупки: вхід → кошик → оформлення
Тестові користувачі з різними вадами
Підходить для Selenium, Playwright, Cypress
Безкоштовно, без реєстрації', 'Full purchase flow: login → cart → checkout
Test users with different defects
Works with Selenium, Playwright, Cypress
Free, no signup', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'saucedemo.com' OR LOWER(`name`) = 'sauce demo (swag labs)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sauce Labs demo web shop for practising end-to-end tests: login, cart and checkout.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Swag Labs is a practice shop by Sauce Labs: login, a sortable catalogue, cart and checkout. The site offers several test users with different behaviour (locked out, broken UI, slow responses, visual glitches), so one app covers positive and negative scenarios as well as visual testing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Full purchase flow: login → cart → checkout
Test users with different defects
Works with Selenium, Playwright, Cypress
Free, no signup', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- DemoQA — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'demoqa.com' OR LOWER(`name`) = 'demoqa')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DemoQA', NULL, 'https://demoqa.com', NULL, NULL, 'Тренажер від ToolsQA з формами, віджетами, перетягуванням, вікнами й книжковим магазином з API.', 'ToolsQA practice site with forms, widgets, drag and drop, windows and a book store with an API.', 'DemoQA — навчальний сайт від ToolsQA, поділений на розділи: елементи (поля, чекбокси, таблиці, кнопки, посилання, завантаження), форми, вікна й алерти, віджети (календарі, слайдери, підказки, меню), взаємодії (перетягування, сортування, зміна розміру) та застосунок «Book Store» зі своїм REST API для тренування API- і UI-тестів разом.', 'DemoQA is a practice site by ToolsQA split into sections: elements (inputs, checkboxes, tables, buttons, links, upload), forms, windows and alerts, widgets (date pickers, sliders, tooltips, menus), interactions (drag and drop, sorting, resizing) and a Book Store app with its own REST API for combined UI and API practice.', 'Елементи, форми, віджети та взаємодії
Вікна, вкладки, фрейми й алерти
Book Store з REST API
Безкоштовно', 'Elements, forms, widgets and interactions
Windows, tabs, frames and alerts
Book Store with a REST API
Free', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'demoqa.com' OR LOWER(`name`) = 'demoqa') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ToolsQA practice site with forms, widgets, drag and drop, windows and a book store with an API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'DemoQA is a practice site by ToolsQA split into sections: elements (inputs, checkboxes, tables, buttons, links, upload), forms, windows and alerts, widgets (date pickers, sliders, tooltips, menus), interactions (drag and drop, sorting, resizing) and a Book Store app with its own REST API for combined UI and API practice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Elements, forms, widgets and interactions
Windows, tabs, frames and alerts
Book Store with a REST API
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- UI Test Automation Playground — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'uitestingplayground.com' OR LOWER(`name`) = 'ui test automation playground')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'UI Test Automation Playground', NULL, 'http://uitestingplayground.com', NULL, NULL, 'Сторінки з типовими пастками UI-автоматизації: динамічні ID, приховані шари, затримки AJAX.', 'Pages that emulate common UI automation pitfalls: dynamic IDs, hidden layers, AJAX delays.', 'UI Test Automation Playground (UITAP) збирає окремі сторінки, кожна з яких моделює одну пастку сучасних вебзастосунків: динамічні ID, складні атрибути class, елементи, перекриті іншими шарами, затримки завантаження й AJAX, клік, що не спрацьовує, поля з текстом, що змінюється, прокрутку, прогрес-бар, Shadow DOM тощо. На кожній сторінці описано, що саме має перевірити тест.', 'UI Test Automation Playground (UITAP) collects separate pages, each emulating one pitfall of modern web apps: dynamic IDs, tricky class attributes, elements covered by other layers, load and AJAX delays, clicks that do not register, changing text inputs, scrolling, progress bars, Shadow DOM and more. Each page explains what the test should verify.', 'Понад 20 сценаріїв-пасток для автотестів
Опис завдання на кожній сторінці
Підходить для будь-якого інструмента
Без реєстрації', '20+ automation pitfall scenarios
Task description on every page
Works with any automation tool
No signup', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'uitestingplayground.com' OR LOWER(`name`) = 'ui test automation playground') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Pages that emulate common UI automation pitfalls: dynamic IDs, hidden layers, AJAX delays.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'UI Test Automation Playground (UITAP) collects separate pages, each emulating one pitfall of modern web apps: dynamic IDs, tricky class attributes, elements covered by other layers, load and AJAX delays, clicks that do not register, changing text inputs, scrolling, progress bars, Shadow DOM and more. Each page explains what the test should verify.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '20+ automation pitfall scenarios
Task description on every page
Works with any automation tool
No signup', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Automation Exercise — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'automationexercise.com' OR LOWER(`name`) = 'automation exercise')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Automation Exercise', NULL, 'https://automationexercise.com', NULL, NULL, 'Повноцінний навчальний інтернет-магазин із готовими тест-кейсами та списком API для практики.', 'A full practice web shop with ready-made test cases and a list of APIs to practise on.', 'Automation Exercise — навчальний магазин одягу з реєстрацією, входом, каталогом, пошуком, кошиком, оформленням замовлення й формою зворотного зв''язку. На сайті є окремий розділ із понад 20 готовими тест-кейсами для UI та список API-запитів (продукти, бренди, пошук, акаунт) з очікуваними відповідями — зручно, щоб написати перші автотести за готовим сценарієм.', 'Automation Exercise is a practice clothing shop with signup, login, catalogue, search, cart, checkout and a contact form. It has a section with 20+ ready-made UI test cases and a list of API requests (products, brands, search, account) with expected responses, which makes it easy to write your first automated tests from a given scenario.', 'Готові тест-кейси для UI
Список API з очікуваними відповідями
Реєстрація, кошик, оформлення замовлення
Безкоштовно', 'Ready-made UI test cases
API list with expected responses
Signup, cart, checkout
Free', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'automationexercise.com' OR LOWER(`name`) = 'automation exercise') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A full practice web shop with ready-made test cases and a list of APIs to practise on.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Automation Exercise is a practice clothing shop with signup, login, catalogue, search, cart, checkout and a contact form. It has a section with 20+ ready-made UI test cases and a list of API requests (products, brands, search, account) with expected responses, which makes it easy to write your first automated tests from a given scenario.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Ready-made UI test cases
API list with expected responses
Signup, cart, checkout
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ParaBank — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'parabank.parasoft.com/parabank/index.htm' OR LOWER(`name`) = 'parabank')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ParaBank', NULL, 'https://parabank.parasoft.com/parabank/index.htm', NULL, NULL, 'Демо-онлайн-банк від Parasoft: рахунки, перекази, оплата рахунків — для UI-, API- і навантажувальних тестів.', 'Parasoft demo online bank: accounts, transfers, bill pay — for UI, API and load testing practice.', 'ParaBank — реалістичний навчальний онлайн-банк від Parasoft. Можна зареєструватися, відкрити рахунки, переказувати кошти, оплачувати рахунки, переглядати історію операцій і подавати заявку на кредит. Застосунок має також REST/SOAP-сервіси, тож його використовують для тренування API-тестів, наскрізних сценаріїв і навантажувального тестування.', 'ParaBank is a realistic practice online bank by Parasoft. You can register, open accounts, transfer funds, pay bills, view transaction history and request a loan. The app also exposes REST/SOAP services, so it is used for API tests, end-to-end scenarios and load testing practice.', 'Банківські сценарії: рахунки, перекази, платежі
REST і SOAP-сервіси
Реєстрація тестових клієнтів
Безкоштовно', 'Banking flows: accounts, transfers, payments
REST and SOAP services
Register test customers
Free', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'parabank.parasoft.com/parabank/index.htm' OR LOWER(`name`) = 'parabank') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Parasoft demo online bank: accounts, transfers, bill pay — for UI, API and load testing practice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ParaBank is a realistic practice online bank by Parasoft. You can register, open accounts, transfer funds, pay bills, view transaction history and request a loan. The app also exposes REST/SOAP services, so it is used for API tests, end-to-end scenarios and load testing practice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Banking flows: accounts, transfers, payments
REST and SOAP services
Register test customers
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Practice Test Automation — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'practicetestautomation.com/practice' OR LOWER(`name`) = 'practice test automation')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Practice Test Automation', NULL, 'https://practicetestautomation.com/practice/', NULL, NULL, 'Прості сторінки для першої практики: вхід, винятки Selenium, таблиці з фільтрами.', 'Simple pages for first practice: login, Selenium exceptions and tables with filters.', 'Practice Test Automation пропонує кілька сторінок для старту: форму входу для позитивних і негативних тест-кейсів, сторінку, на якій відтворюються найпоширеніші винятки Selenium (NoSuchElement, ElementNotInteractable, StaleElementReference, Timeout), і динамічну таблицю з фільтрами та сортуванням. Автор сайту також веде курси й блог про автоматизацію.', 'Practice Test Automation offers a few starter pages: a login form for positive and negative test cases, a page that reproduces the most common Selenium exceptions (NoSuchElement, ElementNotInteractable, StaleElementReference, Timeout) and a dynamic table with filters and sorting. The author also runs courses and a blog about automation.', 'Форма входу для перших тест-кейсів
Відтворення типових винятків Selenium
Динамічна таблиця з фільтрами
Безкоштовно', 'Login form for first test cases
Reproduces common Selenium exceptions
Dynamic table with filters
Free', 'Початківці в автоматизації тестування', 'Beginners in test automation', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'practicetestautomation.com/practice' OR LOWER(`name`) = 'practice test automation') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Simple pages for first practice: login, Selenium exceptions and tables with filters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Practice Test Automation offers a few starter pages: a login form for positive and negative test cases, a page that reproduces the most common Selenium exceptions (NoSuchElement, ElementNotInteractable, StaleElementReference, Timeout) and a dynamic table with filters and sorting. The author also runs courses and a blog about automation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Login form for first test cases
Reproduces common Selenium exceptions
Dynamic table with filters
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginners in test automation', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Expand Testing Practice — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'practice.expandtesting.com' OR LOWER(`name`) = 'expand testing practice')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Expand Testing Practice', NULL, 'https://practice.expandtesting.com', NULL, NULL, 'Великий тренажер для UI- і API-тестів: десятки прикладів, демо-застосунки, Notes API, тест-кейси.', 'A large UI and API practice site: dozens of examples, demo apps, a Notes API and test cases.', 'Expand Testing — безкоштовний сайт для практики Selenium, Playwright, Cypress, WebdriverIO і Postman. Тут є десятки прикладів вебелементів, демо-застосунки (інтернет-магазин, книжковий магазин, нотатки на React), Notes REST API з документацією Swagger, готові тест-кейси, інструмент перевірки XPath/CSS і пробні тести ISTQB.', 'Expand Testing is a free site for practising Selenium, Playwright, Cypress, WebdriverIO and Postman. It has dozens of web element examples, demo apps (web shop, book store, React notes app), a Notes REST API with Swagger docs, ready-made test cases, an XPath/CSS checker and ISTQB mock exams.', 'Десятки прикладів вебелементів
Демо-застосунки та Notes REST API
Готові тест-кейси й інструмент XPath/CSS
Пробні тести ISTQB', 'Dozens of web element examples
Demo apps and a Notes REST API
Ready-made test cases and an XPath/CSS tool
ISTQB mock exams', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'practice.expandtesting.com' OR LOWER(`name`) = 'expand testing practice') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A large UI and API practice site: dozens of examples, demo apps, a Notes API and test cases.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Expand Testing is a free site for practising Selenium, Playwright, Cypress, WebdriverIO and Postman. It has dozens of web element examples, demo apps (web shop, book store, React notes app), a Notes REST API with Swagger docs, ready-made test cases, an XPath/CSS checker and ISTQB mock exams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Dozens of web element examples
Demo apps and a Notes REST API
Ready-made test cases and an XPath/CSS tool
ISTQB mock exams', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- LetCode — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'letcode.in/test' OR LOWER(`name`) = 'letcode')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LetCode', NULL, 'https://letcode.in/test', NULL, NULL, 'Навчальна платформа з практичними сторінками для Selenium і Playwright, вікторинами й підготовкою до співбесід.', 'A learning platform with practice pages for Selenium and Playwright, quizzes and interview prep.', 'LetCode with Koushik — освітній проєкт про автоматизацію тестування. У розділі Test зібрано практичні сторінки: поля вводу, кнопки, випадні списки, алерти, фрейми, вікна, перетягування, таблиці, календар, завантаження файлів, Shadow DOM. Поруч — відеоуроки, вікторини й матеріали для підготовки до співбесід на посаду QA-автоматизатора.', 'LetCode with Koushik is an education project about test automation. Its Test section has practice pages: inputs, buttons, dropdowns, alerts, frames, windows, drag and drop, tables, a calendar, file upload and Shadow DOM. Alongside are video lessons, quizzes and interview preparation for QA automation roles.', 'Практичні сторінки з типовими елементами
Shadow DOM, фрейми, вікна
Вікторини та підготовка до співбесід
Відеоуроки', 'Practice pages with common elements
Shadow DOM, frames, windows
Quizzes and interview prep
Video lessons', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'letcode.in/test' OR LOWER(`name`) = 'letcode') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A learning platform with practice pages for Selenium and Playwright, quizzes and interview prep.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LetCode with Koushik is an education project about test automation. Its Test section has practice pages: inputs, buttons, dropdowns, alerts, frames, windows, drag and drop, tables, a calendar, file upload and Shadow DOM. Alongside are video lessons, quizzes and interview preparation for QA automation roles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Practice pages with common elements
Shadow DOM, frames, windows
Quizzes and interview prep
Video lessons', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Restful-Booker — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'restful-booker.herokuapp.com' OR LOWER(`name`) = 'restful-booker')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Restful-Booker', NULL, 'https://restful-booker.herokuapp.com', NULL, NULL, 'CRUD API для тренування API-тестів з авторизацією та навмисними помилками; дані скидаються кожні 10 хвилин.', 'A CRUD API for API testing practice with auth and deliberate bugs; data resets every 10 minutes.', 'Restful-Booker — API-тренажер, створений Марком Вінтерінгемом. Це сервіс бронювань із повним набором CRUD-операцій, токен-авторизацією та документацією. У нього навмисно закладено помилки, які можна шукати, а дані автоматично повертаються до 10 початкових записів кожні 10 хвилин, тож експериментувати можна безпечно.', 'Restful-Booker is an API playground created by Mark Winteringham. It is a booking service with full CRUD operations, token auth and documentation. It deliberately contains bugs to find, and data automatically resets to 10 default records every 10 minutes, so experimenting is safe.', 'Повний CRUD для бронювань
Токен-авторизація
Навмисні помилки для пошуку
Скидання даних кожні 10 хвилин', 'Full CRUD for bookings
Token authentication
Deliberate bugs to find
Data resets every 10 minutes', 'Тестувальники й розробники, що вчаться тестувати API (Postman, REST Assured, Playwright тощо)', 'Testers and developers learning API testing (Postman, REST Assured, Playwright and more)', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'restful-booker.herokuapp.com' OR LOWER(`name`) = 'restful-booker') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A CRUD API for API testing practice with auth and deliberate bugs; data resets every 10 minutes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Restful-Booker is an API playground created by Mark Winteringham. It is a booking service with full CRUD operations, token auth and documentation. It deliberately contains bugs to find, and data automatically resets to 10 default records every 10 minutes, so experimenting is safe.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Full CRUD for bookings
Token authentication
Deliberate bugs to find
Data resets every 10 minutes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers and developers learning API testing (Postman, REST Assured, Playwright and more)', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ReqRes — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'reqres.in' OR LOWER(`name`) = 'reqres')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ReqRes', NULL, 'https://reqres.in', NULL, NULL, 'Безкоштовний тестовий REST API з реальними відповідями для QA-автоматизації — без реєстрації.', 'A free test REST API with real responses for QA automation — no signup needed.', 'ReqRes — тестовий REST API зі стабільними ендпоінтами для списків користувачів, реєстрації, входу й CRUD-операцій, а також для перевірки затримок і помилок. Ним користуються в навчальних курсах і тестових наборах. Для власного бекенду (колекції, авторизація, журнали) є платні тарифи на app.reqres.in.', 'ReqRes is a test REST API with stable endpoints for user lists, registration, login and CRUD operations, plus delayed and error responses. It is used in courses and test suites. Paid plans at app.reqres.in add your own backend (collections, auth, logs).', 'Стабільні ендпоінти для CRUD, входу й реєстрації
Затримки й помилки для негативних тестів
Без реєстрації для базового API
Платні тарифи з власним бекендом', 'Stable endpoints for CRUD, login and signup
Delays and errors for negative tests
No signup for the basic API
Paid plans with your own backend', 'Тестувальники й розробники, що вчаться тестувати API (Postman, REST Assured, Playwright тощо)', 'Testers and developers learning API testing (Postman, REST Assured, Playwright and more)', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'reqres.in' OR LOWER(`name`) = 'reqres') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free test REST API with real responses for QA automation — no signup needed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ReqRes is a test REST API with stable endpoints for user lists, registration, login and CRUD operations, plus delayed and error responses. It is used in courses and test suites. Paid plans at app.reqres.in add your own backend (collections, auth, logs).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Stable endpoints for CRUD, login and signup
Delays and errors for negative tests
No signup for the basic API
Paid plans with your own backend', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers and developers learning API testing (Postman, REST Assured, Playwright and more)', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- JSONPlaceholder — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jsonplaceholder.typicode.com' OR LOWER(`name`) = 'jsonplaceholder')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'JSONPlaceholder', NULL, 'https://jsonplaceholder.typicode.com', NULL, NULL, 'Безкоштовний фейковий REST API: шість ресурсів, усі HTTP-методи, без реєстрації й ключа.', 'A free fake REST API: six resources, all HTTP methods, no signup or key.', 'JSONPlaceholder працює з 2013 року і надає шість пов''язаних ресурсів (posts, comments, albums, photos, todos, users) з підтримкою GET, POST, PUT, PATCH і DELETE. Відповіді стабільні, а зміни лише імітуються, тож сервіс зручний для перших API-тестів, прикладів у навчанні й прототипів.', 'JSONPlaceholder has run since 2013 and offers six related resources (posts, comments, albums, photos, todos, users) supporting GET, POST, PUT, PATCH and DELETE. Responses are stable and writes are only simulated, which makes it handy for first API tests, tutorials and prototypes.', 'Шість пов''язаних ресурсів
Усі HTTP-методи
Стабільні відповіді
Без реєстрації й API-ключа', 'Six related resources
All HTTP methods
Stable responses
No signup or API key', 'Тестувальники й розробники, що вчаться тестувати API (Postman, REST Assured, Playwright тощо)', 'Testers and developers learning API testing (Postman, REST Assured, Playwright and more)', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jsonplaceholder.typicode.com' OR LOWER(`name`) = 'jsonplaceholder') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free fake REST API: six resources, all HTTP methods, no signup or key.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'JSONPlaceholder has run since 2013 and offers six related resources (posts, comments, albums, photos, todos, users) supporting GET, POST, PUT, PATCH and DELETE. Responses are stable and writes are only simulated, which makes it handy for first API tests, tutorials and prototypes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Six related resources
All HTTP methods
Stable responses
No signup or API key', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers and developers learning API testing (Postman, REST Assured, Playwright and more)', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Swagger Petstore — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petstore.swagger.io' OR LOWER(`name`) = 'swagger petstore')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Swagger Petstore', NULL, 'https://petstore.swagger.io', NULL, NULL, 'Демо-API зоомагазину з документацією Swagger UI: можна надсилати запити прямо з браузера.', 'A pet store demo API with Swagger UI docs: send requests straight from the browser.', 'Swagger Petstore — зразковий API на специфікації OpenAPI з ресурсами pet, store і user. Документація Swagger UI дозволяє виконувати запити просто на сторінці, бачити схеми й коди відповідей. Його часто використовують, щоб навчитися читати специфікацію API та писати перші тести в Postman чи коді.', 'Swagger Petstore is a sample OpenAPI-based API with pet, store and user resources. Its Swagger UI docs let you run requests right on the page and see schemas and response codes. It is often used to learn reading API specs and writing first tests in Postman or code.', 'Інтерактивна документація Swagger UI
Ресурси pet, store, user
Специфікація OpenAPI
Безкоштовно', 'Interactive Swagger UI docs
pet, store and user resources
OpenAPI specification
Free', 'Тестувальники й розробники, що вчаться тестувати API (Postman, REST Assured, Playwright тощо)', 'Testers and developers learning API testing (Postman, REST Assured, Playwright and more)', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petstore.swagger.io' OR LOWER(`name`) = 'swagger petstore') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A pet store demo API with Swagger UI docs: send requests straight from the browser.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Swagger Petstore is a sample OpenAPI-based API with pet, store and user resources. Its Swagger UI docs let you run requests right on the page and see schemas and response codes. It is often used to learn reading API specs and writing first tests in Postman or code.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Interactive Swagger UI docs
pet, store and user resources
OpenAPI specification
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers and developers learning API testing (Postman, REST Assured, Playwright and more)', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- OWASP Juice Shop — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'owasp.org/www-project-juice-shop' OR LOWER(`name`) = 'owasp juice shop')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OWASP Juice Shop', NULL, 'https://owasp.org/www-project-juice-shop/', NULL, NULL, 'Навмисно вразливий інтернет-магазин від OWASP для навчання тестуванню безпеки.', 'A deliberately insecure web shop by OWASP for security testing training.', 'OWASP Juice Shop — флагманський проєкт OWASP: сучасний вебзастосунок-магазин, у який закладено вразливості з усього OWASP Top 10 та багато інших. Його запускають локально (Docker, Node.js) або в хмарі й використовують для тренувань із безпеки, CTF, демонстрацій і перевірки сканерів. Вбудована дошка завдань показує знайдені вразливості.', 'OWASP Juice Shop is an OWASP flagship project: a modern web shop that contains vulnerabilities from the whole OWASP Top 10 and beyond. It runs locally (Docker, Node.js) or in the cloud and is used for security training, CTFs, demos and testing scanners. A built-in score board tracks the vulnerabilities you find.', 'Вразливості з OWASP Top 10 і не тільки
Дошка завдань із рівнями складності
Запуск через Docker чи Node.js
Відкритий код, безкоштовно', 'Vulnerabilities from the OWASP Top 10 and more
Score board with difficulty levels
Runs via Docker or Node.js
Open source, free', 'Тестувальники, що опановують тестування безпеки, і студенти з кібербезпеки', 'Testers learning security testing and cybersecurity students', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'owasp.org/www-project-juice-shop' OR LOWER(`name`) = 'owasp juice shop') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A deliberately insecure web shop by OWASP for security testing training.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'OWASP Juice Shop is an OWASP flagship project: a modern web shop that contains vulnerabilities from the whole OWASP Top 10 and beyond. It runs locally (Docker, Node.js) or in the cloud and is used for security training, CTFs, demos and testing scanners. A built-in score board tracks the vulnerabilities you find.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Vulnerabilities from the OWASP Top 10 and more
Score board with difficulty levels
Runs via Docker or Node.js
Open source, free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers learning security testing and cybersecurity students', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Rahul Shetty Academy Practice Page — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rahulshettyacademy.com/automationpractice' OR LOWER(`name`) = 'rahul shetty academy practice page')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Rahul Shetty Academy Practice Page', NULL, 'https://rahulshettyacademy.com/AutomationPractice/', NULL, NULL, 'Одна сторінка з основними елементами для тренування Selenium: перемикачі, списки, вікна, таблиці.', 'A single page with core elements for Selenium practice: radios, dropdowns, windows, tables.', 'Практична сторінка Rahul Shetty Academy зібрала на одному екрані перемикачі, автодоповнення, випадний список, чекбокси, перемикання вікон і вкладок, алерти, вебтаблиці, приховування елементів, наведення миші й фрейм. На ній тренуються слухачі курсів академії з Selenium, Playwright і Cypress, але сторінка відкрита для всіх.', 'The Rahul Shetty Academy practice page puts radio buttons, autocomplete, a dropdown, checkboxes, window and tab switching, alerts, web tables, hide/show elements, mouse hover and an iframe on one screen. Students of the academy''s Selenium, Playwright and Cypress courses practise on it, but it is open to everyone.', 'Основні елементи на одній сторінці
Вікна, вкладки, алерти, фрейм
Вебтаблиці й наведення миші
Безкоштовно', 'Core elements on one page
Windows, tabs, alerts, iframe
Web tables and mouse hover
Free', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rahulshettyacademy.com/automationpractice' OR LOWER(`name`) = 'rahul shetty academy practice page') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A single page with core elements for Selenium practice: radios, dropdowns, windows, tables.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Rahul Shetty Academy practice page puts radio buttons, autocomplete, a dropdown, checkboxes, window and tab switching, alerts, web tables, hide/show elements, mouse hover and an iframe on one screen. Students of the academy''s Selenium, Playwright and Cypress courses practise on it, but it is open to everyone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Core elements on one page
Windows, tabs, alerts, iframe
Web tables and mouse hover
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Guru99 Demo Sites — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'demo.guru99.com' OR LOWER(`name`) = 'guru99 demo sites')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Guru99 Demo Sites', NULL, 'https://demo.guru99.com', NULL, NULL, 'Набір демо-проєктів Guru99: банк, страхування, телеком, платіжний шлюз і сторінки з елементами.', 'Guru99 demo projects: bank, insurance, telecom, payment gateway and element pages.', 'Guru99 Demo Sites — колекція навчальних застосунків для ручного й автоматизованого тестування: банківський проєкт, страховий, телеком, платіжний шлюз, туристичний New Tours, а також сторінки для Selenium (таблиці, перетягування, cookies, вибір дати, завантаження файлів). Доступ до демо-банку видається на вказаний email.', 'Guru99 Demo Sites is a collection of practice apps for manual and automated testing: a bank project, insurance, telecom, a payment gateway, the New Tours travel site and Selenium pages (tables, drag and drop, cookies, date pickers, file upload). Demo bank access is sent to the email you provide.', 'Кілька доменних проєктів (банк, страхування, телеком)
Сторінки з елементами для Selenium
Підходить для написання тест-кейсів
Безкоштовно', 'Several domain projects (bank, insurance, telecom)
Element pages for Selenium
Good for writing test cases
Free', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'demo.guru99.com' OR LOWER(`name`) = 'guru99 demo sites') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Guru99 demo projects: bank, insurance, telecom, payment gateway and element pages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Guru99 Demo Sites is a collection of practice apps for manual and automated testing: a bank project, insurance, telecom, a payment gateway, the New Tours travel site and Selenium pages (tables, drag and drop, cookies, date pickers, file upload). Demo bank access is sent to the email you provide.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Several domain projects (bank, insurance, telecom)
Element pages for Selenium
Good for writing test cases
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- OrangeHRM Demo — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'opensource-demo.orangehrmlive.com' OR LOWER(`name`) = 'orangehrm demo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OrangeHRM Demo', NULL, 'https://opensource-demo.orangehrmlive.com', NULL, NULL, 'Публічне демо HR-системи OrangeHRM — реалістичний бізнес-застосунок для тренування тестування.', 'Public demo of the OrangeHRM HR system — a realistic business app for testing practice.', 'OrangeHRM — відкрита HR-система, а її публічне демо стало популярним полігоном для тестувальників: модулі співробітників, відпусток, обліку часу, рекрутингу, продуктивності, каталогу та адміністрування. Тестові облікові дані показано на сторінці входу. Це складний реальний застосунок із таблицями, фільтрами, формами й ролями.', 'OrangeHRM is an open-source HR system, and its public demo is a popular testing ground: employee, leave, time, recruitment, performance, directory and admin modules. Test credentials are shown on the login page. It is a complex real app with tables, filters, forms and roles.', 'Реальний бізнес-застосунок із багатьма модулями
Тестові облікові дані на сторінці входу
Таблиці, фільтри, форми, ролі
Безкоштовне демо', 'Real business app with many modules
Test credentials on the login page
Tables, filters, forms, roles
Free demo', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'opensource-demo.orangehrmlive.com' OR LOWER(`name`) = 'orangehrm demo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Public demo of the OrangeHRM HR system — a realistic business app for testing practice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'OrangeHRM is an open-source HR system, and its public demo is a popular testing ground: employee, leave, time, recruitment, performance, directory and admin modules. Test credentials are shown on the login page. It is a complex real app with tables, filters, forms and roles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real business app with many modules
Test credentials on the login page
Tables, filters, forms, roles
Free demo', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Conduit (RealWorld) — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'demo.realworld.show' OR LOWER(`name`) = 'conduit (realworld)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Conduit (RealWorld)', NULL, 'https://demo.realworld.show', NULL, NULL, 'Демо-блог-платформа на кшталт Medium із проєкту RealWorld — для наскрізних і API-тестів.', 'A Medium-like demo blogging platform from the RealWorld project — for end-to-end and API tests.', 'Conduit — демо-застосунок відкритого проєкту RealWorld: соціальна блог-платформа з реєстрацією, статтями, тегами, коментарями, підписками й улюбленими записами. Фронтенд і бекенд мають спільну специфікацію API, тож на Conduit зручно тренувати наскрізні сценарії, API-тести та перевірку зв''язку інтерфейсу з сервером.', 'Conduit is the demo app of the open-source RealWorld project: a social blogging platform with signup, articles, tags, comments, follows and favourites. Frontends and backends share one API spec, so Conduit is handy for end-to-end scenarios, API tests and checking UI-server integration.', 'Реєстрація, статті, коментарі, теги
Спільна специфікація API
Наскрізні сценарії користувача
Відкритий код', 'Signup, articles, comments, tags
Shared API specification
End-to-end user scenarios
Open source', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'demo.realworld.show' OR LOWER(`name`) = 'conduit (realworld)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Medium-like demo blogging platform from the RealWorld project — for end-to-end and API tests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Conduit is the demo app of the open-source RealWorld project: a social blogging platform with signup, articles, tags, comments, follows and favourites. Frontends and backends share one API spec, so Conduit is handy for end-to-end scenarios, API tests and checking UI-server integration.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Signup, articles, comments, tags
Shared API specification
End-to-end user scenarios
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Buggy Cars Rating — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'buggy.justtestit.org' OR LOWER(`name`) = 'buggy cars rating')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Buggy Cars Rating', NULL, 'https://buggy.justtestit.org', NULL, NULL, 'Навчальний сайт рейтингу автомобілів із навмисними помилками — для пошуку й опису багів.', 'A practice car voting site with deliberate bugs — for finding and reporting defects.', 'Buggy Cars Rating — вебзастосунок, де користувачі реєструються, переглядають марки й моделі авто, голосують і коментують. У сайт навмисно закладено помилки, тож його використовують для дослідницького тестування, складання баг-репортів і тестових завдань на співбесідах.', 'Buggy Cars Rating is a web app where users register, browse car makes and models, vote and comment. It deliberately contains bugs, so it is used for exploratory testing, writing bug reports and interview test tasks.', 'Навмисні помилки для пошуку
Реєстрація, профіль, голосування
Підходить для дослідницького тестування
Безкоштовно', 'Deliberate bugs to find
Signup, profile, voting
Good for exploratory testing
Free', 'Початківці в ручному тестуванні та ті, хто готується до тестових завдань', 'Beginners in manual testing and candidates preparing for test tasks', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'buggy.justtestit.org' OR LOWER(`name`) = 'buggy cars rating') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A practice car voting site with deliberate bugs — for finding and reporting defects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Buggy Cars Rating is a web app where users register, browse car makes and models, vote and comment. It deliberately contains bugs, so it is used for exploratory testing, writing bug reports and interview test tasks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Deliberate bugs to find
Signup, profile, voting
Good for exploratory testing
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginners in manual testing and candidates preparing for test tasks', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Practice Software Testing (Toolshop) — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'practicesoftwaretesting.com' OR LOWER(`name`) = 'practice software testing (toolshop)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Practice Software Testing (Toolshop)', NULL, 'https://practicesoftwaretesting.com', NULL, NULL, 'Сучасний навчальний магазин інструментів із REST API й версіями з навмисними багами.', 'A modern practice tool shop with a REST API and versions with deliberate bugs.', 'Practice Software Testing (Toolshop) — безкоштовний сучасний вебзастосунок для навчання тестуванню й автоматизації: каталог із фільтрами, кошик, оформлення, кабінет користувача й адміністратора, рахунки. Є документований REST API і кілька версій застосунку, зокрема з навмисними помилками, а код відкритий — можна запустити локально.', 'Practice Software Testing (Toolshop) is a free modern web app for learning testing and automation: a filtered catalogue, cart, checkout, user and admin areas and invoices. It has a documented REST API and several app versions, including ones with deliberate bugs; the code is open, so you can run it locally.', 'Повний магазин: каталог, кошик, кабінети
Документований REST API
Версії з навмисними помилками
Відкритий код, локальний запуск', 'Full shop: catalogue, cart, user areas
Documented REST API
Versions with deliberate bugs
Open source, run locally', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'practicesoftwaretesting.com' OR LOWER(`name`) = 'practice software testing (toolshop)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A modern practice tool shop with a REST API and versions with deliberate bugs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Practice Software Testing (Toolshop) is a free modern web app for learning testing and automation: a filtered catalogue, cart, checkout, user and admin areas and invoices. It has a documented REST API and several app versions, including ones with deliberate bugs; the code is open, so you can run it locally.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Full shop: catalogue, cart, user areas
Documented REST API
Versions with deliberate bugs
Open source, run locally', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Test Pages (EvilTester) — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'testpages.eviltester.com' OR LOWER(`name`) = 'test pages (eviltester)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Test Pages (EvilTester)', NULL, 'https://testpages.eviltester.com', NULL, NULL, 'Колекція сторінок, застосунків і челенджів для практики тестування від Алана Річардсона.', 'A collection of pages, apps and challenges for testing practice by Alan Richardson.', 'Test Pages від Алана Річардсона (EvilTester) — набір практичних сторінок (базові елементи, локатори, алерти, таблиці, поля вводу, натискання клавіш), невеликих застосунків, ігор і челенджів для тестування й автоматизації. До кожної сторінки є інструкції, що саме тренувати.', 'Test Pages by Alan Richardson (EvilTester) is a set of practice pages (basic elements, locators, alerts, tables, inputs, key presses), small apps, games and challenges for testing and automation. Every page comes with instructions on what to practise.', 'Практичні сторінки з інструкціями
Невеликі застосунки й ігри
Челенджі для тестувальників
Безкоштовно (є підтримка через Patreon)', 'Practice pages with instructions
Small apps and games
Challenges for testers
Free (Patreon support available)', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'testpages.eviltester.com' OR LOWER(`name`) = 'test pages (eviltester)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A collection of pages, apps and challenges for testing practice by Alan Richardson.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Test Pages by Alan Richardson (EvilTester) is a set of practice pages (basic elements, locators, alerts, tables, inputs, key presses), small apps, games and challenges for testing and automation. Every page comes with instructions on what to practise.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Practice pages with instructions
Small apps and games
Challenges for testers
Free (Patreon support available)', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TodoMVC — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'todomvc.com' OR LOWER(`name`) = 'todomvc')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TodoMVC', NULL, 'https://todomvc.com', NULL, NULL, 'Один і той самий список справ на React, Vue, Angular та інших фреймворках — популярний полігон для автотестів.', 'The same to-do app built in React, Vue, Angular and more — a popular target for automated tests.', 'TodoMVC реалізує однаковий застосунок списку справ на багатьох JavaScript-фреймворках (React, Vue, Svelte, Angular, Lit, Preact тощо). Через однакову поведінку й специфікацію його часто беруть для перших тестів у Playwright і Cypress та для порівняння, як автотест поводиться з різними фреймворками.', 'TodoMVC implements the same to-do app in many JavaScript frameworks (React, Vue, Svelte, Angular, Lit, Preact and others). Because behaviour and spec are identical, it is a common target for first Playwright and Cypress tests and for comparing how tests behave across frameworks.', 'Однаковий застосунок на багатьох фреймворках
Специфікація поведінки
Простий сценарій для перших автотестів
Відкритий код', 'Same app in many frameworks
Behaviour specification
Simple flow for first automated tests
Open source', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'todomvc.com' OR LOWER(`name`) = 'todomvc') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The same to-do app built in React, Vue, Angular and more — a popular target for automated tests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TodoMVC implements the same to-do app in many JavaScript frameworks (React, Vue, Svelte, Angular, Lit, Preact and others). Because behaviour and spec are identical, it is a common target for first Playwright and Cypress tests and for comparing how tests behave across frameworks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Same app in many frameworks
Behaviour specification
Simple flow for first automated tests
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Weather Shopper — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'weathershopper.pythonanywhere.com' OR LOWER(`name`) = 'weather shopper')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Weather Shopper', NULL, 'https://weathershopper.pythonanywhere.com', NULL, NULL, 'Тренажер від Qxf2: обери крем залежно від температури й пройди оформлення та оплату.', 'A Qxf2 practice app: pick creams based on temperature, then go through checkout and payment.', 'Weather Shopper від Qxf2 Services — невеликий застосунок-завдання для автоматизації: показує температуру, і тест має вирішити, купувати зволожувальний чи сонцезахисний крем, обрати товари за правилами, додати в кошик і пройти тестову оплату. Добре тренує логіку в тестах і роботу з платіжною формою.', 'Weather Shopper by Qxf2 Services is a small automation exercise: it shows a temperature, and the test must decide whether to buy moisturiser or sunscreen, pick products by rules, add them to the cart and complete a test payment. It trains logic in tests and handling a payment form.', 'Завдання з логікою вибору товарів
Кошик і тестова оплата
Підходить для перших проєктів автоматизації
Безкоштовно', 'Task with product selection logic
Cart and test payment
Good for first automation projects
Free', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'weathershopper.pythonanywhere.com' OR LOWER(`name`) = 'weather shopper') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Qxf2 practice app: pick creams based on temperature, then go through checkout and payment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Weather Shopper by Qxf2 Services is a small automation exercise: it shows a temperature, and the test must decide whether to buy moisturiser or sunscreen, pick products by rules, add them to the cart and complete a test payment. It trains logic in tests and handling a payment form.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Task with product selection logic
Cart and test payment
Good for first automation projects
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- WebDriverUniversity — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'webdriveruniversity.com' OR LOWER(`name`) = 'webdriveruniversity')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'WebDriverUniversity', NULL, 'https://webdriveruniversity.com', NULL, NULL, 'Безкоштовний полігон для Selenium, Playwright і Cypress із челенджами та прикладами для AI-тестування.', 'A free playground for Selenium, Playwright and Cypress with challenges and AI-assisted testing examples.', 'WebDriverUniversity — безкоштовний практичний сайт від автора курсів з автоматизації: форми, випадні списки, вікна, перетягування, iframes, автодоповнення, дати, завантаження, сторінки з затримками, а також практичні завдання з BDD (Cucumber) і AI-інструментами. Автор продає курси, але сам тренажер безкоштовний.', 'WebDriverUniversity is a free practice site by an automation course author: forms, dropdowns, windows, drag and drop, iframes, autocomplete, dates, upload, delayed pages, plus exercises with BDD (Cucumber) and AI tools. The author sells courses, but the playground itself is free.', 'Сторінки з типовими елементами й затримками
Челенджі для Selenium, Playwright, Cypress
Завдання з BDD і AI-інструментами
Безкоштовний тренажер', 'Pages with common elements and delays
Challenges for Selenium, Playwright, Cypress
BDD and AI tool exercises
Free playground', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'webdriveruniversity.com' OR LOWER(`name`) = 'webdriveruniversity') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free playground for Selenium, Playwright and Cypress with challenges and AI-assisted testing examples.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'WebDriverUniversity is a free practice site by an automation course author: forms, dropdowns, windows, drag and drop, iframes, autocomplete, dates, upload, delayed pages, plus exercises with BDD (Cucumber) and AI tools. The author sells courses, but the playground itself is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Pages with common elements and delays
Challenges for Selenium, Playwright, Cypress
BDD and AI tool exercises
Free playground', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- httpbin — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'httpbin.org' OR LOWER(`name`) = 'httpbin')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'httpbin', NULL, 'https://httpbin.org', NULL, NULL, 'Простий сервіс «запит — відповідь» для перевірки HTTP-клієнтів: методи, заголовки, коди, затримки.', 'A simple HTTP request and response service for testing clients: methods, headers, status codes, delays.', 'httpbin повертає інформацію про ваш запит і дозволяє отримати потрібну відповідь: будь-який код статусу, затримку, редирект, cookies, стиснення, базову авторизацію, дані форми. Його зручно використовувати, щоб розібратися з HTTP, перевірити налаштування Postman чи тестового фреймворку. На httpbin.org діють ліміти запитів.', 'httpbin echoes information about your request and lets you get the response you need: any status code, delay, redirect, cookies, compression, basic auth or form data. It is handy for learning HTTP and checking Postman or test framework setups. httpbin.org has request rate limits.', 'Будь-які коди статусу й затримки
Заголовки, cookies, редиректи
Базова авторизація
Безкоштовно, з лімітами запитів', 'Any status code and delay
Headers, cookies, redirects
Basic auth
Free, with rate limits', 'Тестувальники й розробники, що вчаться тестувати API (Postman, REST Assured, Playwright тощо)', 'Testers and developers learning API testing (Postman, REST Assured, Playwright and more)', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'httpbin.org' OR LOWER(`name`) = 'httpbin') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A simple HTTP request and response service for testing clients: methods, headers, status codes, delays.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'httpbin echoes information about your request and lets you get the response you need: any status code, delay, redirect, cookies, compression, basic auth or form data. It is handy for learning HTTP and checking Postman or test framework setups. httpbin.org has request rate limits.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Any status code and delay
Headers, cookies, redirects
Basic auth
Free, with rate limits', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers and developers learning API testing (Postman, REST Assured, Playwright and more)', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- GoRest — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gorest.co.in' OR LOWER(`name`) = 'gorest')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GoRest', NULL, 'https://gorest.co.in', NULL, NULL, 'Публічний REST API з реалістичними даними, токенами, пагінацією й специфікацією OpenAPI.', 'A public REST API with realistic data, tokens, paging and an OpenAPI spec.', 'GoRest — безкоштовний REST API з користувачами, постами, коментарями, завданнями й невеликим магазином. Записи пов''язані, як у справжньому застосунку, є Bearer-токени, курсорна пагінація, специфікація OpenAPI 3.1, консоль для запитів і налаштовувані ліміти. Добре підходить, щоб тренувати авторизовані API-тести.', 'GoRest is a free REST API with users, posts, comments, tasks and a small shop. Records are linked as in a real app, with Bearer tokens, cursor paging, an OpenAPI 3.1 spec, a request console and configurable rate limits. Good for practising authorised API tests.', 'Пов''язані ресурси, як у реальному застосунку
Bearer-токени та пагінація
Специфікація OpenAPI 3.1
Безкоштовно', 'Linked resources like a real app
Bearer tokens and paging
OpenAPI 3.1 spec
Free', 'Тестувальники й розробники, що вчаться тестувати API (Postman, REST Assured, Playwright тощо)', 'Testers and developers learning API testing (Postman, REST Assured, Playwright and more)', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gorest.co.in' OR LOWER(`name`) = 'gorest') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A public REST API with realistic data, tokens, paging and an OpenAPI spec.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'GoRest is a free REST API with users, posts, comments, tasks and a small shop. Records are linked as in a real app, with Bearer tokens, cursor paging, an OpenAPI 3.1 spec, a request console and configurable rate limits. Good for practising authorised API tests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Linked resources like a real app
Bearer tokens and paging
OpenAPI 3.1 spec
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers and developers learning API testing (Postman, REST Assured, Playwright and more)', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Fake Store API — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fakestoreapi.com' OR LOWER(`name`) = 'fake store api')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fake Store API', NULL, 'https://fakestoreapi.com', NULL, NULL, 'Безкоштовний REST API з даними інтернет-магазину: товари, кошики, користувачі, вхід.', 'A free REST API with e-commerce data: products, carts, users and login.', 'Fake Store API надає реалістичні дані інтернет-магазину: 20 товарів із категоріями, цінами й зображеннями, кошики, користувачів і авторизацію. Його використовують для прототипів, навчання й тренування API-тестів на знайомому сценарії покупок.', 'Fake Store API provides realistic e-commerce data: 20 products with categories, prices and images, carts, users and authentication. It is used for prototypes, teaching and practising API tests on a familiar shopping scenario.', 'Товари, кошики, користувачі
Авторизація
Документація з прикладами
Безкоштовно', 'Products, carts, users
Authentication
Docs with examples
Free', 'Тестувальники й розробники, що вчаться тестувати API (Postman, REST Assured, Playwright тощо)', 'Testers and developers learning API testing (Postman, REST Assured, Playwright and more)', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fakestoreapi.com' OR LOWER(`name`) = 'fake store api') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free REST API with e-commerce data: products, carts, users and login.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Fake Store API provides realistic e-commerce data: 20 products with categories, prices and images, carts, users and authentication. It is used for prototypes, teaching and practising API tests on a familiar shopping scenario.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Products, carts, users
Authentication
Docs with examples
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers and developers learning API testing (Postman, REST Assured, Playwright and more)', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- DummyJSON — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dummyjson.com' OR LOWER(`name`) = 'dummyjson')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DummyJSON', NULL, 'https://dummyjson.com', NULL, NULL, 'Фейковий REST API з багатьма наборами даних, авторизацією, пошуком і пагінацією.', 'A fake REST API with many datasets, auth, search and paging.', 'DummyJSON пропонує готові ресурси (товари, кошики, користувачі, пости, коментарі, рецепти, цитати, завдання тощо) з пошуком, пагінацією, сортуванням, вибором полів і JWT-авторизацією. Підходить, щоб тренувати складніші API-тести й підставляти реалістичні дані у фронтенд без бекенду. Код відкритий.', 'DummyJSON offers ready resources (products, carts, users, posts, comments, recipes, quotes, todos and more) with search, paging, sorting, field selection and JWT auth. It suits more advanced API tests and feeding realistic data to a frontend without a backend. The code is open source.', 'Багато наборів даних
Пошук, пагінація, сортування
JWT-авторизація
Відкритий код, безкоштовно', 'Many datasets
Search, paging, sorting
JWT authentication
Open source, free', 'Тестувальники й розробники, що вчаться тестувати API (Postman, REST Assured, Playwright тощо)', 'Testers and developers learning API testing (Postman, REST Assured, Playwright and more)', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dummyjson.com' OR LOWER(`name`) = 'dummyjson') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A fake REST API with many datasets, auth, search and paging.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'DummyJSON offers ready resources (products, carts, users, posts, comments, recipes, quotes, todos and more) with search, paging, sorting, field selection and JWT auth. It suits more advanced API tests and feeding realistic data to a frontend without a backend. The code is open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Many datasets
Search, paging, sorting
JWT authentication
Open source, free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers and developers learning API testing (Postman, REST Assured, Playwright and more)', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PortSwigger Web Security Academy — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'portswigger.net/web-security' OR LOWER(`name`) = 'portswigger web security academy')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PortSwigger Web Security Academy', NULL, 'https://portswigger.net/web-security', NULL, NULL, 'Безкоштовний онлайн-курс безпеки вебзастосунків від творців Burp Suite з інтерактивними лабораторіями.', 'Free online web security training from the makers of Burp Suite, with interactive labs.', 'Web Security Academy від PortSwigger — безкоштовний навчальний центр із безпеки вебзастосунків: теми SQL-ін''єкцій, XSS, CSRF, SSRF, автентифікації, контролю доступу, API та інших. До кожної теми є інтерактивні лабораторії від початкового до експертного рівня, які розв''язують у браузері з Burp Suite. Потрібен безкоштовний обліковий запис.', 'PortSwigger Web Security Academy is a free web application security training centre: SQL injection, XSS, CSRF, SSRF, authentication, access control, APIs and more. Every topic has interactive labs from apprentice to expert level, solved in the browser with Burp Suite. A free account is required.', 'Теми з усіх основних вебвразливостей
Інтерактивні лабораторії різних рівнів
Робота з Burp Suite
Безкоштовно, потрібна реєстрація', 'Topics covering major web vulnerabilities
Interactive labs at several levels
Hands-on with Burp Suite
Free, account required', 'Тестувальники, що опановують тестування безпеки, і майбутні пентестери', 'Testers learning security testing and aspiring penetration testers', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'portswigger.net/web-security' OR LOWER(`name`) = 'portswigger web security academy') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free online web security training from the makers of Burp Suite, with interactive labs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PortSwigger Web Security Academy is a free web application security training centre: SQL injection, XSS, CSRF, SSRF, authentication, access control, APIs and more. Every topic has interactive labs from apprentice to expert level, solved in the browser with Burp Suite. A free account is required.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Topics covering major web vulnerabilities
Interactive labs at several levels
Hands-on with Burp Suite
Free, account required', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers learning security testing and aspiring penetration testers', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Test Automation University — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'testautomationu.applitools.com' OR LOWER(`name`) = 'test automation university')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Test Automation University', NULL, 'https://testautomationu.applitools.com', NULL, NULL, 'Безкоштовні онлайн-курси з автоматизації тестування від Applitools із сертифікатами.', 'Free online test automation courses by Applitools, with certificates.', 'Test Automation University від Applitools — безкоштовна платформа з курсами від практиків галузі: Selenium, Playwright, Cypress, API-тестування, мобільна автоматизація, мови програмування для тестувальників, CI/CD, візуальне тестування. Курси згруповано в навчальні шляхи, за проходження видаються сертифікати, є спільнота в Slack.', 'Test Automation University by Applitools is a free platform with courses from industry practitioners: Selenium, Playwright, Cypress, API testing, mobile automation, programming languages for testers, CI/CD and visual testing. Courses are grouped into learning paths, completion earns certificates, and there is a Slack community.', 'Курси від практиків галузі
Навчальні шляхи
Сертифікати за проходження
Безкоштовно', 'Courses by industry practitioners
Learning paths
Completion certificates
Free', 'Тестувальники, що переходять до автоматизації або підвищують кваліфікацію', 'Testers moving into automation or upskilling', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'testautomationu.applitools.com' OR LOWER(`name`) = 'test automation university') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free online test automation courses by Applitools, with certificates.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Test Automation University by Applitools is a free platform with courses from industry practitioners: Selenium, Playwright, Cypress, API testing, mobile automation, programming languages for testers, CI/CD and visual testing. Courses are grouped into learning paths, completion earns certificates, and there is a Slack community.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Courses by industry practitioners
Learning paths
Completion certificates
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers moving into automation or upskilling', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ministry of Testing — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ministryoftesting.com' OR LOWER(`name`) = 'ministry of testing')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ministry of Testing', NULL, 'https://www.ministryoftesting.com', NULL, NULL, 'Міжнародна спільнота тестувальників: навчання, події, сертифікації та обмін досвідом.', 'An international software testing community: learning, events, certifications and knowledge sharing.', 'Ministry of Testing понад 15 років об''єднує тестувальників і QA-інженерів: статті, онлайн-сесії, курси й сертифікації, локальні осередки й конференції TestBash/MoTaCon, вакансії та обговорення. Частина матеріалів доступна безкоштовно, повний доступ — за платним членством.', 'Ministry of Testing has connected testers and QA engineers for over 15 years: articles, online sessions, courses and certifications, local chapters and TestBash/MoTaCon conferences, jobs and discussions. Some content is free; full access requires a paid membership.', 'Статті й онлайн-сесії
Курси та сертифікації
Локальні осередки й конференції
Безкоштовна частина та платне членство', 'Articles and online sessions
Courses and certifications
Local chapters and conferences
Free tier and paid membership', 'Тестувальники будь-якого рівня, що хочуть розвиватися й спілкуватися з колегами', 'Testers at any level who want to grow and connect with peers', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ministryoftesting.com' OR LOWER(`name`) = 'ministry of testing') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An international software testing community: learning, events, certifications and knowledge sharing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ministry of Testing has connected testers and QA engineers for over 15 years: articles, online sessions, courses and certifications, local chapters and TestBash/MoTaCon conferences, jobs and discussions. Some content is free; full access requires a paid membership.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Articles and online sessions
Courses and certifications
Local chapters and conferences
Free tier and paid membership', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers at any level who want to grow and connect with peers', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Testing Playground — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'testing-playground.com' OR LOWER(`name`) = 'testing playground')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Testing Playground', NULL, 'https://testing-playground.com', NULL, NULL, 'Пісочниця для вибору правильних запитів Testing Library з урахуванням доступності (ARIA).', 'A sandbox for choosing the right Testing Library queries with accessibility (ARIA) in mind.', 'Testing Playground допомагає тим, хто пише тести з Testing Library: вставляєте HTML — і бачите, яким запитом (getByRole, getByLabelText тощо) найкраще знайти елемент і чому елемент не знаходиться. Сервіс наочно показує вплив ролей, підписів і ARIA-атрибутів, тож заодно вчить доступності. Є розширення для Chrome.', 'Testing Playground helps those writing tests with Testing Library: paste HTML and see which query (getByRole, getByLabelText and so on) best finds an element and why an element is not matched. It visualises the effect of roles, labels and ARIA attributes, teaching accessibility along the way. A Chrome extension is available.', 'Підказка найкращого запиту для елемента
Наочний вплив ARIA-атрибутів
Розширення для Chrome
Відкритий код', 'Suggests the best query for an element
Shows the effect of ARIA attributes
Chrome extension
Open source', 'Розробники й тестувальники, що пишуть тести з Testing Library', 'Developers and testers writing tests with Testing Library', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'testing-playground.com' OR LOWER(`name`) = 'testing playground') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A sandbox for choosing the right Testing Library queries with accessibility (ARIA) in mind.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Testing Playground helps those writing tests with Testing Library: paste HTML and see which query (getByRole, getByLabelText and so on) best finds an element and why an element is not matched. It visualises the effect of roles, labels and ARIA attributes, teaching accessibility along the way. A Chrome extension is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Suggests the best query for an element
Shows the effect of ARIA attributes
Chrome extension
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and testers writing tests with Testing Library', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- CSS Diner — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'flukeout.github.io' OR LOWER(`name`) = 'css diner')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CSS Diner', NULL, 'https://flukeout.github.io', NULL, NULL, 'Гра з 32 рівнями для вивчення CSS-селекторів — основи локаторів в автотестах.', 'A 32-level game for learning CSS selectors — the basis of locators in automated tests.', 'CSS Diner — безкоштовна браузерна гра: на кожному рівні потрібно написати CSS-селектор, який вибере потрібні «страви» на столі. Рівні поступово ускладнюються від селекторів за тегом і класом до комбінаторів і псевдокласів. Для тестувальника це швидкий спосіб навчитися писати точні CSS-локатори.', 'CSS Diner is a free browser game: on each level you write a CSS selector that picks the right "dishes" on the table. Levels progress from tag and class selectors to combinators and pseudo-classes. For testers it is a quick way to learn writing precise CSS locators.', '32 рівні зростаючої складності
Підказки до кожного селектора
Працює в браузері
Безкоштовно', '32 levels of rising difficulty
Hints for every selector
Runs in the browser
Free', 'Початківці в автоматизації, що вчаться писати локатори', 'Automation beginners learning to write locators', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'flukeout.github.io' OR LOWER(`name`) = 'css diner') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A 32-level game for learning CSS selectors — the basis of locators in automated tests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'CSS Diner is a free browser game: on each level you write a CSS selector that picks the right "dishes" on the table. Levels progress from tag and class selectors to combinators and pseudo-classes. For testers it is a quick way to learn writing precise CSS locators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '32 levels of rising difficulty
Hints for every selector
Runs in the browser
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Automation beginners learning to write locators', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- uTest — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'utest.com' OR LOWER(`name`) = 'utest')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'uTest', NULL, 'https://www.utest.com', NULL, NULL, 'Спільнота краудтестувальників від Applause: навчання в uTest Academy і участь у реальних оплачуваних проєктах.', 'Applause''s crowdtesting community: learning in uTest Academy and real paid testing projects.', 'uTest — спільнота незалежних тестувальників, яку підтримує компанія Applause. Після безкоштовної реєстрації можна проходити курси uTest Academy, читати статті й форум, а потім брати участь у тестових циклах реальних продуктів клієнтів Applause за оплату. Це спосіб здобути практичний досвід і перші кейси для резюме.', 'uTest is a community of freelance testers backed by Applause. After free signup you can take uTest Academy courses, read articles and the forum, then join test cycles of real products for Applause clients for pay. It is a way to gain hands-on experience and first cases for your CV.', 'Безкоштовна реєстрація
Курси uTest Academy
Оплачувані тестові цикли реальних продуктів
Форум і статті спільноти', 'Free signup
uTest Academy courses
Paid test cycles of real products
Community forum and articles', 'Тестувальники-початківці, що шукають практику, і фрилансери', 'Beginner testers seeking practice and freelancers', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'utest.com' OR LOWER(`name`) = 'utest') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Applause''s crowdtesting community: learning in uTest Academy and real paid testing projects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'uTest is a community of freelance testers backed by Applause. After free signup you can take uTest Academy courses, read articles and the forum, then join test cycles of real products for Applause clients for pay. It is a way to gain hands-on experience and first cases for your CV.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free signup
uTest Academy courses
Paid test cycles of real products
Community forum and articles', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner testers seeking practice and freelancers', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- BugMagnet — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bugmagnet.org' OR LOWER(`name`) = 'bugmagnet')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BugMagnet', NULL, 'https://www.bugmagnet.org', NULL, NULL, 'Розширення для Chrome і Firefox з граничними значеннями в контекстному меню для дослідницького тестування.', 'A Chrome and Firefox extension with edge-case values in the context menu for exploratory testing.', 'BugMagnet додає в контекстне меню будь-якого поля вводу набір проблемних значень: дуже довгі рядки, Юнікод, спецсимволи, граничні числа, некоректні email і дати тощо, а також нагадує евристики дослідницького тестування. Є версія для AI-агентів програмування (Claude Code, Cursor). Відкритий код.', 'BugMagnet adds a set of problematic values to the context menu of any input: very long strings, Unicode, special characters, boundary numbers, invalid emails and dates and more, and reminds you of exploratory testing heuristics. There is also a version for AI coding agents (Claude Code, Cursor). Open source.', 'Граничні значення в контекстному меню
Нагадування евристик тестування
Chrome і Firefox
Відкритий код, безкоштовно', 'Edge-case values in the context menu
Testing heuristics reminders
Chrome and Firefox
Open source, free', 'Тестувальники, що практикують дослідницьке тестування', 'Testers practising exploratory testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bugmagnet.org' OR LOWER(`name`) = 'bugmagnet') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Chrome and Firefox extension with edge-case values in the context menu for exploratory testing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'BugMagnet adds a set of problematic values to the context menu of any input: very long strings, Unicode, special characters, boundary numbers, invalid emails and dates and more, and reminds you of exploratory testing heuristics. There is also a version for AI coding agents (Claude Code, Cursor). Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Edge-case values in the context menu
Testing heuristics reminders
Chrome and Firefox
Open source, free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers practising exploratory testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- GlobalSQA Demo Site — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'globalsqa.com/demo-site' OR LOWER(`name`) = 'globalsqa demo site')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GlobalSQA Demo Site', NULL, 'https://www.globalsqa.com/demo-site/', NULL, NULL, 'Демо-сторінки з віджетами jQuery UI, банківським проєктом на AngularJS і формами для автоматизації.', 'Demo pages with jQuery UI widgets, an AngularJS banking project and forms for automation.', 'GlobalSQA Demo Site зібрав приклади віджетів (підказки, діалоги, вибір дати, прогрес-бар, перетягування, автодоповнення, акордеон і вкладки, фрейми й вікна) і окремий сайт для практики Protractor/AngularJS з банківським проєктом, вебтаблицею, формою реєстрації та калькуляторами.', 'GlobalSQA Demo Site collects widget examples (tooltips, dialogs, date pickers, progress bars, drag and drop, autocomplete, accordion and tabs, frames and windows) and a separate Protractor/AngularJS practice site with a banking project, web table, registration form and calculators.', 'Віджети jQuery UI
Банківський проєкт на AngularJS
Фрейми, вікна, вебтаблиці
Безкоштовно', 'jQuery UI widgets
AngularJS banking project
Frames, windows, web tables
Free', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'globalsqa.com/demo-site' OR LOWER(`name`) = 'globalsqa demo site') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Demo pages with jQuery UI widgets, an AngularJS banking project and forms for automation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'GlobalSQA Demo Site collects widget examples (tooltips, dialogs, date pickers, progress bars, drag and drop, autocomplete, accordion and tabs, frames and windows) and a separate Protractor/AngularJS practice site with a banking project, web table, registration form and calculators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'jQuery UI widgets
AngularJS banking project
Frames, windows, web tables
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TestSheepNZ — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'testsheepnz.github.io' OR LOWER(`name`) = 'testsheepnz')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TestSheepNZ', NULL, 'https://testsheepnz.github.io', NULL, NULL, 'Вправи на спостережливість і дослідницьке тестування: гра-вгадайка, ката з автоматизації, проєкти.', 'Exercises in observation and exploratory testing: a guessing game, automation katas and projects.', 'TestSheepNZ — ресурс новозеландського тестувальника Майка Телвелла з навчальними вправами: гра «вгадай число» для дослідницького тестування з журналом знахідок, ката з автоматизації для застосунку Panther ODM, нестандартні проєкти на кшталт «врятуй астронавтів» і матеріали воркшопів.', 'TestSheepNZ is a resource by New Zealand tester Mike Talks with practice exercises: a number guessing game for exploratory testing with a findings log, automation katas for the Panther ODM app, unusual projects like saving stranded astronauts and workshop materials.', 'Гра для дослідницького тестування
Ката з автоматизації
Нестандартні навчальні проєкти
Безкоштовно', 'Exploratory testing game
Automation katas
Unusual practice projects
Free', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'testsheepnz.github.io' OR LOWER(`name`) = 'testsheepnz') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Exercises in observation and exploratory testing: a guessing game, automation katas and projects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TestSheepNZ is a resource by New Zealand tester Mike Talks with practice exercises: a number guessing game for exploratory testing with a findings log, automation katas for the Panther ODM app, unusual projects like saving stranded astronauts and workshop materials.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Exploratory testing game
Automation katas
Unusual practice projects
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- BlazeDemo — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'blazedemo.com' OR LOWER(`name`) = 'blazedemo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BlazeDemo', NULL, 'https://www.blazedemo.com', NULL, NULL, 'Демо-сайт туристичного агентства від BlazeMeter для функціонального й навантажувального тестування.', 'BlazeMeter''s demo travel agency site for functional and load testing.', 'BlazeDemo — простий сайт продажу авіаквитків від BlazeMeter: вибір міст відправлення й призначення, список рейсів, бронювання й підтвердження покупки. Короткий передбачуваний сценарій робить його зручним для перших функціональних автотестів і для практики навантажувального тестування в JMeter чи BlazeMeter.', 'BlazeDemo is a simple flight booking site by BlazeMeter: choose departure and destination cities, see flights, book and confirm a purchase. Its short predictable flow makes it convenient for first functional automated tests and for load testing practice in JMeter or BlazeMeter.', 'Короткий сценарій бронювання
Підходить для JMeter і BlazeMeter
Прості форми для автотестів
Безкоштовно', 'Short booking flow
Suits JMeter and BlazeMeter
Simple forms for automated tests
Free', 'Тестувальники, що тренують функціональне й навантажувальне тестування', 'Testers practising functional and load testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'blazedemo.com' OR LOWER(`name`) = 'blazedemo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'BlazeMeter''s demo travel agency site for functional and load testing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'BlazeDemo is a simple flight booking site by BlazeMeter: choose departure and destination cities, see flights, book and confirm a purchase. Its short predictable flow makes it convenient for first functional automated tests and for load testing practice in JMeter or BlazeMeter.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Short booking flow
Suits JMeter and BlazeMeter
Simple forms for automated tests
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers practising functional and load testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Demoblaze (Product Store) — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'demoblaze.com' OR LOWER(`name`) = 'demoblaze (product store)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Demoblaze (Product Store)', NULL, 'https://www.demoblaze.com', NULL, NULL, 'Демо-магазин телефонів і ноутбуків для тренування наскрізних тестів: реєстрація, кошик, замовлення.', 'A demo store for phones and laptops for practising end-to-end tests: signup, cart, order.', 'Demoblaze (Product Store) — навчальний інтернет-магазин із категоріями телефонів, ноутбуків і моніторів, реєстрацією та входом у модальних вікнах, кошиком і формою замовлення. Модальні вікна, алерти й асинхронне завантаження роблять його гарною практикою для очікувань в автотестах.', 'Demoblaze (Product Store) is a practice web shop with phone, laptop and monitor categories, signup and login in modal windows, a cart and an order form. Modals, alerts and async loading make it good practice for waits in automated tests.', 'Категорії товарів і кошик
Модальні вікна й алерти
Асинхронне завантаження
Безкоштовно', 'Product categories and cart
Modal windows and alerts
Async loading
Free', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'demoblaze.com' OR LOWER(`name`) = 'demoblaze (product store)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A demo store for phones and laptops for practising end-to-end tests: signup, cart, order.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Demoblaze (Product Store) is a practice web shop with phone, laptop and monitor categories, signup and login in modal windows, a cart and an order form. Modals, alerts and async loading make it good practice for waits in automated tests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Product categories and cart
Modal windows and alerts
Async loading
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AcademyBugs — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'academybugs.com' OR LOWER(`name`) = 'academybugs')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AcademyBugs', NULL, 'https://academybugs.com', NULL, NULL, 'Навчальний магазин із навмисними багами: знайди їх і навчися складати баг-репорти.', 'A practice shop with deliberate bugs: find them and learn to write bug reports.', 'AcademyBugs — сайт-тренажер для ручного тестування: інтернет-магазин, у який навмисно додано помилки різних типів (кнопки, що не працюють, сторінки з помилкою, некоректні ціни, зламаний відеоплеєр тощо). Сайт пояснює типи багів, пропонує знайти їх самостійно й показує, як правильно оформити баг-репорт.', 'AcademyBugs is a manual testing practice site: a web shop with deliberately added bugs of different types (broken buttons, error pages, wrong prices, a broken video player and more). It explains bug types, invites you to find them yourself and shows how to write a proper bug report.', 'Навмисні баги різних типів
Пояснення типів помилок
Навчання баг-репортам
Безкоштовно', 'Deliberate bugs of different types
Explains bug types
Bug report training
Free', 'Початківці в ручному тестуванні', 'Beginners in manual testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'academybugs.com' OR LOWER(`name`) = 'academybugs') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A practice shop with deliberate bugs: find them and learn to write bug reports.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'AcademyBugs is a manual testing practice site: a web shop with deliberately added bugs of different types (broken buttons, error pages, wrong prices, a broken video player and more). It explains bug types, invites you to find them yourself and shows how to write a proper bug report.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Deliberate bugs of different types
Explains bug types
Bug report training
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginners in manual testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- XPather — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'xpather.com' OR LOWER(`name`) = 'xpather')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'XPather', NULL, 'https://xpather.com', NULL, NULL, 'Онлайн-тестер XPath 2.0 у реальному часі для XML і HTML — тренування локаторів.', 'A real-time online XPath 2.0 tester for XML and HTML — for practising locators.', 'XPather дає змогу вставити XML або HTML-документ і одразу бачити, які вузли вибирає ваш вираз XPath 2.0. Сервіс також генерує запити для вибраних елементів. Для тестувальника це зручний спосіб перевірити й відточити XPath-локатори перед тим, як вставляти їх в автотест.', 'XPather lets you paste an XML or HTML document and instantly see which nodes your XPath 2.0 expression selects. It can also generate queries for selected elements. For testers it is a convenient way to check and refine XPath locators before putting them into an automated test.', 'Перевірка XPath у реальному часі
Режими XML і HTML
Генерація запитів
Безкоштовно', 'Real-time XPath evaluation
XML and HTML modes
Query generation
Free', 'Тестувальники, що вчаться писати XPath-локатори', 'Testers learning to write XPath locators', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'xpather.com' OR LOWER(`name`) = 'xpather') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A real-time online XPath 2.0 tester for XML and HTML — for practising locators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'XPather lets you paste an XML or HTML document and instantly see which nodes your XPath 2.0 expression selects. It can also generate queries for selected elements. For testers it is a convenient way to check and refine XPath locators before putting them into an automated test.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time XPath evaluation
XML and HTML modes
Query generation
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers learning to write XPath locators', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Contact List App — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thinking-tester-contact-list.herokuapp.com' OR LOWER(`name`) = 'contact list app')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Contact List App', NULL, 'https://thinking-tester-contact-list.herokuapp.com', NULL, NULL, 'Навчальний застосунок «список контактів» з UI та документованим API від Крістін Джеквоні.', 'A practice contact list app with a UI and documented API by Kristin Jackvony.', 'Contact List App створила тестувальниця й авторка книжок про тестування Крістін Джеквоні (The Thinking Tester). Можна зареєструватися, додавати, редагувати й видаляти контакти через інтерфейс або REST API з токен-авторизацією. Один застосунок дозволяє тренувати і UI-, і API-тести та порівнювати їх. Базу періодично очищують.', 'Contact List App was created by tester and testing author Kristin Jackvony (The Thinking Tester). You can sign up and add, edit and delete contacts via the UI or a REST API with token auth. One app lets you practise both UI and API tests and compare them. The database is purged periodically.', 'Інтерфейс і REST API в одному застосунку
Токен-авторизація
Документація API
Безкоштовно', 'UI and REST API in one app
Token authentication
API documentation
Free', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thinking-tester-contact-list.herokuapp.com' OR LOWER(`name`) = 'contact list app') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A practice contact list app with a UI and documented API by Kristin Jackvony.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Contact List App was created by tester and testing author Kristin Jackvony (The Thinking Tester). You can sign up and add, edit and delete contacts via the UI or a REST API with token auth. One app lets you practise both UI and API tests and compare them. The database is purged periodically.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'UI and REST API in one app
Token authentication
API documentation
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bondar Academy Playground — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'playground.bondaracademy.com' OR LOWER(`name`) = 'bondar academy playground')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bondar Academy Playground', NULL, 'https://playground.bondaracademy.com', NULL, NULL, 'UI-полігон Bondar Academy з формами, таблицями, модальними вікнами й графіками для Playwright і Cypress.', 'Bondar Academy UI playground with forms, tables, modals and charts for Playwright and Cypress.', 'Bondar Academy — школа автоматизації тестування Артема Бондаря. Її навчальний застосунок на Angular містить форми, календарі, таблиці з редагуванням, модальні вікна, підказки, перетягування й графіки — типові елементи сучасних адмін-панелей. Поруч академія тримає клон Conduit (conduit.bondaracademy.com) для наскрізних і API-тестів.', 'Bondar Academy is Artem Bondar''s test automation school. Its Angular practice app has forms, date pickers, editable tables, modals, tooltips, drag and drop and charts — typical elements of modern admin panels. The academy also hosts a Conduit clone (conduit.bondaracademy.com) for end-to-end and API tests.', 'Елементи сучасних адмін-панелей
Таблиці з редагуванням і графіки
Клон Conduit для E2E та API
Безкоштовно', 'Modern admin panel elements
Editable tables and charts
Conduit clone for E2E and API
Free', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'playground.bondaracademy.com' OR LOWER(`name`) = 'bondar academy playground') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Bondar Academy UI playground with forms, tables, modals and charts for Playwright and Cypress.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Bondar Academy is Artem Bondar''s test automation school. Its Angular practice app has forms, date pickers, editable tables, modals, tooltips, drag and drop and charts — typical elements of modern admin panels. The academy also hosts a Conduit clone (conduit.bondaracademy.com) for end-to-end and API tests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Modern admin panel elements
Editable tables and charts
Conduit clone for E2E and API
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TestKru — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'testkru.com' OR LOWER(`name`) = 'testkru')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TestKru', NULL, 'https://testkru.com', NULL, NULL, 'Полігон від Codekru з окремими сторінками для кожного типу елементів і взаємодій.', 'A Codekru playground with separate pages for each element and interaction type.', 'TestKru — практичний сайт від Codekru: окремі сторінки для текстових полів, перемикачів, чекбоксів, кнопок, завантаження й вивантаження файлів, SVG, випадних списків, таблиць, динамічних компонентів, перетягування, фреймів, алертів, клавіатурних дій і елементів, що з''являються чи зникають.', 'TestKru is a practice site by Codekru: separate pages for text fields, radio buttons, checkboxes, buttons, file upload and download, SVG, dropdowns, tables, dynamic components, drag and drop, frames, alerts, keyboard actions and appearing or disappearing elements.', 'Окрема сторінка для кожного типу елемента
SVG і динамічні компоненти
Фрейми, алерти, клавіатура
Безкоштовно', 'A page for each element type
SVG and dynamic components
Frames, alerts, keyboard
Free', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'testkru.com' OR LOWER(`name`) = 'testkru') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Codekru playground with separate pages for each element and interaction type.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TestKru is a practice site by Codekru: separate pages for text fields, radio buttons, checkboxes, buttons, file upload and download, SVG, dropdowns, tables, dynamic components, drag and drop, frames, alerts, keyboard actions and appearing or disappearing elements.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'A page for each element type
SVG and dynamic components
Frames, alerts, keyboard
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- StackDemo (BrowserStack) — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bstackdemo.com' OR LOWER(`name`) = 'stackdemo (browserstack)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'StackDemo (BrowserStack)', NULL, 'https://bstackdemo.com', NULL, NULL, 'Демо-магазин смартфонів від BrowserStack для кросбраузерних і наскрізних тестів.', 'BrowserStack''s demo smartphone store for cross-browser and end-to-end tests.', 'StackDemo — навчальний інтернет-магазин смартфонів від BrowserStack: вхід тестовими користувачами, фільтр за брендами, сортування, кошик, оформлення й історія замовлень. Його використовують у прикладах BrowserStack і для тренування наскрізних і кросбраузерних тестів.', 'StackDemo is BrowserStack''s practice smartphone store: login with test users, brand filters, sorting, cart, checkout and order history. It is used in BrowserStack samples and for practising end-to-end and cross-browser tests.', 'Тестові користувачі
Фільтри, кошик, оформлення
Історія замовлень
Безкоштовно', 'Test users
Filters, cart, checkout
Order history
Free', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bstackdemo.com' OR LOWER(`name`) = 'stackdemo (browserstack)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'BrowserStack''s demo smartphone store for cross-browser and end-to-end tests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'StackDemo is BrowserStack''s practice smartphone store: login with test users, brand filters, sorting, cart, checkout and order history. It is used in BrowserStack samples and for practising end-to-end and cross-browser tests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Test users
Filters, cart, checkout
Order history
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- QA Practice — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'qa-practice.razvanvancea.ro' OR LOWER(`name`) = 'qa practice')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'QA Practice', NULL, 'https://qa-practice.razvanvancea.ro', NULL, NULL, 'Тренажер із вебелементами, «знайди баги», інтернет-магазином, REST API і GraphQL.', 'A practice app with web elements, a spot-the-bugs challenge, an e-shop, REST API and GraphQL.', 'QA Practice від Развана Ванчі — тренажер для ручного й автоматизованого тестування: форми входу й реєстрації, кнопки, чекбокси, вкладки й вікна, таблиці, випадні списки, фрейми, алерти, календарі, пагінація, челендж «знайди баги», наскрізний сценарій інтернет-магазину, перехоплення API-запитів, візуальне тестування, а також REST і GraphQL API.', 'QA Practice by Razvan Vancea is a playground for manual and automated testing: login and registration forms, buttons, checkboxes, tabs and windows, tables, dropdowns, iframes, alerts, date pickers, pagination, a spot-the-bugs challenge, an e-shop end-to-end flow, API interception, visual testing plus REST and GraphQL APIs.', 'Челендж «знайди баги»
Наскрізний сценарій магазину
REST і GraphQL API
Безкоштовно', 'Spot-the-bugs challenge
E-shop end-to-end flow
REST and GraphQL APIs
Free', 'Початківці й досвідчені QA-інженери, що тренують ручне та автоматизоване тестування', 'Beginner and experienced QA engineers practising manual and automated testing', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'qa-practice.razvanvancea.ro' OR LOWER(`name`) = 'qa practice') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A practice app with web elements, a spot-the-bugs challenge, an e-shop, REST API and GraphQL.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'QA Practice by Razvan Vancea is a playground for manual and automated testing: login and registration forms, buttons, checkboxes, tabs and windows, tables, dropdowns, iframes, alerts, date pickers, pagination, a spot-the-bugs challenge, an e-shop end-to-end flow, API interception, visual testing plus REST and GraphQL APIs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Spot-the-bugs challenge
E-shop end-to-end flow
REST and GraphQL APIs
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced QA engineers practising manual and automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sauce Labs My Demo App — Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/saucelabs/my-demo-app-android' OR LOWER(`name`) = 'sauce labs my demo app')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sauce Labs My Demo App', NULL, 'https://github.com/saucelabs/my-demo-app-android', NULL, NULL, 'Демо-застосунок магазину від Sauce Labs для тренування мобільної автоматизації (Android, є версія iOS).', 'Sauce Labs demo shop app for practising mobile automation (Android, with an iOS version).', 'My Demo App — навчальний мобільний застосунок магазину від Sauce Labs з каталогом, кошиком, входом, оформленням замовлення, біометрією й іншими типовими екранами. APK і вихідний код доступні на GitHub (є окремий репозиторій для iOS), тож на ньому тренують Appium, Espresso й мобільне тестування в хмарі.', 'My Demo App is a practice mobile shop app by Sauce Labs with a catalogue, cart, login, checkout, biometrics and other typical screens. The APK and source code are on GitHub (with a separate iOS repository), so it is used to practise Appium, Espresso and cloud mobile testing.', 'Типові екрани мобільного магазину
APK і код на GitHub
Підходить для Appium і Espresso
Відкритий код', 'Typical mobile shop screens
APK and code on GitHub
Suits Appium and Espresso
Open source', 'Тестувальники, що опановують мобільну автоматизацію', 'Testers learning mobile automation', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-01 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/saucelabs/my-demo-app-android' OR LOWER(`name`) = 'sauce labs my demo app') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sauce Labs demo shop app for practising mobile automation (Android, with an iOS version).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'My Demo App is a practice mobile shop app by Sauce Labs with a catalogue, cart, login, checkout, biometrics and other typical screens. The APK and source code are on GitHub (with a separate iOS repository), so it is used to practise Appium, Espresso and cloud mobile testing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Typical mobile shop screens
APK and code on GitHub
Suits Appium and Espresso
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers learning mobile automation', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до тренажера.', 'Free access to the practice resource.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the practice resource.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

