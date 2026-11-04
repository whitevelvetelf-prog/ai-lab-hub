SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-04: «Розробка та IT» (slug development-it) → підкатегорія «Тестування» (slug testing).
-- Партія 2: 13 нових продуктів — фреймворки автоматизації, контрактні тести, CI (для статті про автоматизацію тестування).
-- Тексти UA/EN написано за офіційними сторінками, звірено 2026-11-04. Якщо продукт з такою адресою чи назвою вже є — лише прив’язка.
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою. Повторний запуск безпечний.
--   Puppeteer
--   Jest
--   Vitest
--   pytest
--   JUnit
--   TestNG
--   Nightwatch.js
--   CodeceptJS
--   Artillery
--   Pact
--   Testcontainers
--   GitHub Actions
--   Jenkins
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'development-it' LIMIT 1);

-- Puppeteer — Тестування
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pptr.dev' OR LOWER(`name`) = 'puppeteer')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Puppeteer', NULL, 'https://pptr.dev', NULL, NULL, 'Бібліотека Node.js від команди Chrome для керування браузером: автотести, скриншоти, PDF, збір даних.', 'Node.js library from the Chrome team for controlling the browser: tests, screenshots, PDFs, scraping.', 'Puppeteer керує Chrome і Firefox через DevTools Protocol і WebDriver BiDi: відкриває сторінки, клацає, заповнює форми, перехоплює мережеві запити, робить скриншоти й PDF. Його часто використовують для наскрізних тестів, перевірки продуктивності та як рушій інших інструментів (наприклад, BackstopJS). Відкритий код.', 'Puppeteer drives Chrome and Firefox via the DevTools Protocol and WebDriver BiDi: it opens pages, clicks, fills forms, intercepts network requests and takes screenshots and PDFs. It is often used for end-to-end tests, performance checks and as the engine behind other tools (such as BackstopJS). Open source.', 'Керування Chrome і Firefox
Перехоплення мережевих запитів
Скриншоти й PDF
Відкритий код', 'Chrome and Firefox control
Network request interception
Screenshots and PDFs
Open source', 'QA-інженери з автоматизації та розробники, що пишуть автотести', 'Test automation engineers and developers writing automated tests', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pptr.dev' OR LOWER(`name`) = 'puppeteer') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Node.js library from the Chrome team for controlling the browser: tests, screenshots, PDFs, scraping.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Puppeteer drives Chrome and Firefox via the DevTools Protocol and WebDriver BiDi: it opens pages, clicks, fills forms, intercepts network requests and takes screenshots and PDFs. It is often used for end-to-end tests, performance checks and as the engine behind other tools (such as BackstopJS). Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Chrome and Firefox control
Network request interception
Screenshots and PDFs
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

-- Jest — Тестування
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jestjs.io' OR LOWER(`name`) = 'jest')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Jest', NULL, 'https://jestjs.io', NULL, NULL, 'Популярний фреймворк модульного тестування JavaScript і TypeScript із моками та снепшот-тестами.', 'Popular unit testing framework for JavaScript and TypeScript with mocks and snapshot tests.', 'Jest працює «з коробки» для більшості JavaScript-проєктів: запускає тести паралельно, має вбудовані перевірки, моки модулів і таймерів, снепшот-тести й звіт покриття коду. Широко використовується з React, Node.js і TypeScript. Відкритий код.', 'Jest works out of the box for most JavaScript projects: it runs tests in parallel and has built-in assertions, module and timer mocks, snapshot tests and code coverage reports. Widely used with React, Node.js and TypeScript. Open source.', 'Паралельний запуск тестів
Моки модулів і таймерів
Снепшот-тести
Звіт покриття коду', 'Parallel test runs
Module and timer mocks
Snapshot tests
Code coverage report', 'QA-інженери з автоматизації та розробники, що пишуть автотести', 'Test automation engineers and developers writing automated tests', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jestjs.io' OR LOWER(`name`) = 'jest') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Popular unit testing framework for JavaScript and TypeScript with mocks and snapshot tests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Jest works out of the box for most JavaScript projects: it runs tests in parallel and has built-in assertions, module and timer mocks, snapshot tests and code coverage reports. Widely used with React, Node.js and TypeScript. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Parallel test runs
Module and timer mocks
Snapshot tests
Code coverage report', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Test automation engineers and developers writing automated tests', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Vitest — Тестування
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vitest.dev' OR LOWER(`name`) = 'vitest')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Vitest', NULL, 'https://vitest.dev', NULL, NULL, 'Швидкий фреймворк тестування на базі Vite, сумісний з API Jest, з браузерним режимом.', 'Fast Vite-powered testing framework compatible with the Jest API, with a browser mode.', 'Vitest використовує конфігурацію Vite, тож тести запускаються миттєво й перезапускаються при змінах. API сумісне з Jest, є моки, снепшоти, покриття коду, вбудований вебінтерфейс і режим запуску тестів компонентів у справжньому браузері. Відкритий код.', 'Vitest reuses the Vite config, so tests start instantly and rerun on changes. The API is Jest-compatible, with mocks, snapshots, coverage, a built-in web UI and a mode for running component tests in a real browser. Open source.', 'Сумісність з API Jest
Миттєвий перезапуск
Браузерний режим
Вебінтерфейс і покриття', 'Jest-compatible API
Instant reruns
Browser mode
Web UI and coverage', 'QA-інженери з автоматизації та розробники, що пишуть автотести', 'Test automation engineers and developers writing automated tests', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vitest.dev' OR LOWER(`name`) = 'vitest') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fast Vite-powered testing framework compatible with the Jest API, with a browser mode.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Vitest reuses the Vite config, so tests start instantly and rerun on changes. The API is Jest-compatible, with mocks, snapshots, coverage, a built-in web UI and a mode for running component tests in a real browser. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Jest-compatible API
Instant reruns
Browser mode
Web UI and coverage', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Test automation engineers and developers writing automated tests', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- pytest — Тестування
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'docs.pytest.org' OR LOWER(`name`) = 'pytest')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'pytest', NULL, 'https://docs.pytest.org', NULL, NULL, 'Найпопулярніший фреймворк тестування на Python: прості тести, фікстури й сотні плагінів.', 'The most popular Python testing framework: simple tests, fixtures and hundreds of plugins.', 'pytest дозволяє писати тести звичайними функціями з assert, а фікстури зручно готують дані й середовище. Параметризація, маркери, паралельний запуск (pytest-xdist) і плагіни для Playwright, Selenium, API та звітів Allure роблять його основою багатьох фреймворків автоматизації на Python. Відкритий код.', 'pytest lets you write tests as plain functions with assert, and fixtures conveniently prepare data and environments. Parametrisation, markers, parallel runs (pytest-xdist) and plugins for Playwright, Selenium, APIs and Allure reports make it the base of many Python automation frameworks. Open source.', 'Тести з простим assert
Фікстури й параметризація
Сотні плагінів
Відкритий код', 'Tests with plain assert
Fixtures and parametrisation
Hundreds of plugins
Open source', 'QA-інженери з автоматизації та розробники, що пишуть автотести', 'Test automation engineers and developers writing automated tests', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'docs.pytest.org' OR LOWER(`name`) = 'pytest') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The most popular Python testing framework: simple tests, fixtures and hundreds of plugins.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'pytest lets you write tests as plain functions with assert, and fixtures conveniently prepare data and environments. Parametrisation, markers, parallel runs (pytest-xdist) and plugins for Playwright, Selenium, APIs and Allure reports make it the base of many Python automation frameworks. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tests with plain assert
Fixtures and parametrisation
Hundreds of plugins
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

-- JUnit — Тестування
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'junit.org' OR LOWER(`name`) = 'junit')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'JUnit', NULL, 'https://junit.org', NULL, NULL, 'Стандартний фреймворк тестування для Java і JVM-мов, основа для Selenium-, REST Assured- і Spring-тестів.', 'The standard testing framework for Java and JVM languages, the base for Selenium, REST Assured and Spring tests.', 'JUnit (поточна гілка — JUnit 5/Jupiter) дає анотації для тестів і життєвого циклу, параметризовані й динамічні тести, теги, розширення та паралельний запуск. Підтримується всіма IDE й системами збирання (Maven, Gradle) і є основою більшості Java-фреймворків автоматизації. Відкритий код.', 'JUnit (current line JUnit 5/Jupiter) provides annotations for tests and lifecycle, parameterised and dynamic tests, tags, extensions and parallel execution. Supported by every IDE and build tool (Maven, Gradle), it underpins most Java automation frameworks. Open source.', 'Анотації тестів і життєвого циклу
Параметризовані тести
Розширення й теги
Maven, Gradle, усі IDE', 'Test and lifecycle annotations
Parameterised tests
Extensions and tags
Maven, Gradle, every IDE', 'QA-інженери з автоматизації та розробники, що пишуть автотести', 'Test automation engineers and developers writing automated tests', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'junit.org' OR LOWER(`name`) = 'junit') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The standard testing framework for Java and JVM languages, the base for Selenium, REST Assured and Spring tests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'JUnit (current line JUnit 5/Jupiter) provides annotations for tests and lifecycle, parameterised and dynamic tests, tags, extensions and parallel execution. Supported by every IDE and build tool (Maven, Gradle), it underpins most Java automation frameworks. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Test and lifecycle annotations
Parameterised tests
Extensions and tags
Maven, Gradle, every IDE', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Test automation engineers and developers writing automated tests', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TestNG — Тестування
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'testng.org' OR LOWER(`name`) = 'testng')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TestNG', NULL, 'https://testng.org', NULL, NULL, 'Java-фреймворк тестування з групами, залежностями й гнучким паралельним запуском — популярний в автоматизації UI.', 'Java testing framework with groups, dependencies and flexible parallel runs — popular in UI automation.', 'TestNG описує набори тестів у XML, підтримує групи, залежності між тестами, провайдери даних (data-driven тести), паралельний запуск методів і класів та слухачі для власних звітів. Часто трапляється у вакансіях Java-автоматизаторів разом із Selenium. Відкритий код.', 'TestNG defines suites in XML and supports groups, test dependencies, data providers (data-driven tests), parallel method and class execution and listeners for custom reports. It often appears in Java automation job posts alongside Selenium. Open source.', 'Групи й залежності тестів
Data-driven тести
Паралельний запуск
Слухачі й звіти', 'Test groups and dependencies
Data-driven tests
Parallel runs
Listeners and reports', 'QA-інженери з автоматизації та розробники, що пишуть автотести', 'Test automation engineers and developers writing automated tests', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'testng.org' OR LOWER(`name`) = 'testng') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Java testing framework with groups, dependencies and flexible parallel runs — popular in UI automation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TestNG defines suites in XML and supports groups, test dependencies, data providers (data-driven tests), parallel method and class execution and listeners for custom reports. It often appears in Java automation job posts alongside Selenium. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Test groups and dependencies
Data-driven tests
Parallel runs
Listeners and reports', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Test automation engineers and developers writing automated tests', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Nightwatch.js — Тестування
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nightwatchjs.org' OR LOWER(`name`) = 'nightwatch.js')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nightwatch.js', NULL, 'https://nightwatchjs.org', NULL, NULL, 'Фреймворк наскрізного тестування на Node.js поверх W3C WebDriver: веб, мобільні й тести компонентів.', 'Node.js end-to-end testing framework on W3C WebDriver: web, mobile and component tests.', 'Nightwatch запускає тести в усіх основних браузерах через WebDriver, а також мобільні тести через Appium, тести компонентів React і Vue та візуальні перевірки. Має вбудовані перевірки, page objects і HTML-звіти. Відкритий код, підтримується BrowserStack.', 'Nightwatch runs tests in all major browsers via WebDriver, plus mobile tests via Appium, React and Vue component tests and visual checks. It has built-in assertions, page objects and HTML reports. Open source, maintained by BrowserStack.', 'W3C WebDriver
Мобільні тести через Appium
Тести компонентів
HTML-звіти', 'W3C WebDriver
Mobile tests via Appium
Component tests
HTML reports', 'QA-інженери з автоматизації та розробники, що пишуть автотести', 'Test automation engineers and developers writing automated tests', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nightwatchjs.org' OR LOWER(`name`) = 'nightwatch.js') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Node.js end-to-end testing framework on W3C WebDriver: web, mobile and component tests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Nightwatch runs tests in all major browsers via WebDriver, plus mobile tests via Appium, React and Vue component tests and visual checks. It has built-in assertions, page objects and HTML reports. Open source, maintained by BrowserStack.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'W3C WebDriver
Mobile tests via Appium
Component tests
HTML reports', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Test automation engineers and developers writing automated tests', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- CodeceptJS — Тестування
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'codecept.io' OR LOWER(`name`) = 'codeceptjs')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CodeceptJS', NULL, 'https://codecept.io', NULL, NULL, 'Фреймворк наскрізного тестування з читабельним синтаксисом «I.click», що працює поверх Playwright, WebDriver, Puppeteer чи Appium.', 'End-to-end framework with readable “I.click” syntax running on Playwright, WebDriver, Puppeteer or Appium.', 'CodeceptJS описує сценарії з погляду користувача (I.amOnPage, I.fillField, I.see), а рушій можна змінювати: Playwright, WebDriver, Puppeteer, Appium. Підтримує BDD-сценарії Gherkin, page objects, паралельний запуск і АІ-функції для самовідновлення тестів. Відкритий код.', 'CodeceptJS describes scenarios from the user’s point of view (I.amOnPage, I.fillField, I.see), and the engine can be swapped: Playwright, WebDriver, Puppeteer, Appium. It supports Gherkin BDD scenarios, page objects, parallel runs and AI features for self-healing tests. Open source.', 'Читабельний синтаксис «I.»
Рушії Playwright, WebDriver, Appium
BDD і page objects
АІ-самовідновлення', 'Readable “I.” syntax
Playwright, WebDriver, Appium engines
BDD and page objects
AI self-healing', 'QA-інженери з автоматизації та розробники, що пишуть автотести', 'Test automation engineers and developers writing automated tests', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'codecept.io' OR LOWER(`name`) = 'codeceptjs') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'End-to-end framework with readable “I.click” syntax running on Playwright, WebDriver, Puppeteer or Appium.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'CodeceptJS describes scenarios from the user’s point of view (I.amOnPage, I.fillField, I.see), and the engine can be swapped: Playwright, WebDriver, Puppeteer, Appium. It supports Gherkin BDD scenarios, page objects, parallel runs and AI features for self-healing tests. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Readable “I.” syntax
Playwright, WebDriver, Appium engines
BDD and page objects
AI self-healing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Test automation engineers and developers writing automated tests', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Artillery — Тестування
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'artillery.io' OR LOWER(`name`) = 'artillery')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Artillery', NULL, 'https://www.artillery.io', NULL, NULL, 'Інструмент навантажувального тестування: сценарії в YAML або JavaScript, HTTP, WebSocket і браузерні тести з Playwright.', 'Load testing tool: YAML or JavaScript scenarios, HTTP, WebSocket and Playwright browser tests.', 'Artillery описує навантаження в YAML чи JavaScript, тестує HTTP API, WebSocket, Socket.IO і навіть реальні браузерні сценарії через Playwright, а розподілений запуск можна робити у власних хмарах AWS чи Azure. Ядро відкрите, хмарна панель — платна з безкоштовним рівнем.', 'Artillery defines load in YAML or JavaScript and tests HTTP APIs, WebSocket, Socket.IO and even real browser flows via Playwright, with distributed runs in your own AWS or Azure. The core is open source; the cloud dashboard is paid with a free tier.', 'Сценарії YAML або JS
HTTP, WebSocket, Socket.IO
Браузерне навантаження з Playwright
Запуск у власних AWS/Azure', 'YAML or JS scenarios
HTTP, WebSocket, Socket.IO
Browser load with Playwright
Runs in your own AWS/Azure', 'QA-інженери з автоматизації та розробники, що пишуть автотести', 'Test automation engineers and developers writing automated tests', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'artillery.io' OR LOWER(`name`) = 'artillery') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Load testing tool: YAML or JavaScript scenarios, HTTP, WebSocket and Playwright browser tests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Artillery defines load in YAML or JavaScript and tests HTTP APIs, WebSocket, Socket.IO and even real browser flows via Playwright, with distributed runs in your own AWS or Azure. The core is open source; the cloud dashboard is paid with a free tier.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'YAML or JS scenarios
HTTP, WebSocket, Socket.IO
Browser load with Playwright
Runs in your own AWS/Azure', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Test automation engineers and developers writing automated tests', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовний тариф або версія з обмеженнями.', 'A free plan or limited free version is available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free plan or limited free version is available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Pact — Тестування
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pact.io' OR LOWER(`name`) = 'pact')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Pact', NULL, 'https://pact.io', NULL, NULL, 'Контрактне тестування мікросервісів і API: перевіряє, що споживач і постачальник API розуміють одне одного.', 'Contract testing for microservices and APIs: checks that API consumer and provider agree.', 'Pact записує очікування клієнта щодо API у вигляді контракту, а потім перевіряє, що сервіс-постачальник цей контракт виконує. Так інтеграційні помилки ловляться без розгортання всієї системи. Є бібліотеки для JavaScript, Java, Python, Go, .NET та інших мов і сервер Pact Broker. Відкритий код.', 'Pact records the client’s expectations of an API as a contract and then verifies that the provider service fulfils it. Integration bugs are caught without deploying the whole system. Libraries exist for JavaScript, Java, Python, Go, .NET and more, plus the Pact Broker server. Open source.', 'Контракти споживача й постачальника
Без розгортання всієї системи
Бібліотеки для багатьох мов
Pact Broker', 'Consumer and provider contracts
No full-system deployment
Libraries for many languages
Pact Broker', 'QA-інженери з автоматизації та розробники, що пишуть автотести', 'Test automation engineers and developers writing automated tests', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pact.io' OR LOWER(`name`) = 'pact') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Contract testing for microservices and APIs: checks that API consumer and provider agree.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Pact records the client’s expectations of an API as a contract and then verifies that the provider service fulfils it. Integration bugs are caught without deploying the whole system. Libraries exist for JavaScript, Java, Python, Go, .NET and more, plus the Pact Broker server. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Consumer and provider contracts
No full-system deployment
Libraries for many languages
Pact Broker', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Test automation engineers and developers writing automated tests', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Testcontainers — Тестування
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'testcontainers.com' OR LOWER(`name`) = 'testcontainers')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Testcontainers', NULL, 'https://testcontainers.com', NULL, NULL, 'Бібліотека, що піднімає справжні бази даних, брокери й браузери в Docker на час тесту.', 'Library that spins up real databases, brokers and browsers in Docker for the duration of a test.', 'Testcontainers запускає одноразові контейнери PostgreSQL, MySQL, Kafka, Redis, Selenium-браузерів тощо прямо з коду тесту й видаляє їх після завершення. Інтеграційні тести працюють із реальними залежностями, а не моками. Є версії для Java, Go, .NET, Python, Node.js та інших мов. Відкритий код.', 'Testcontainers starts throwaway PostgreSQL, MySQL, Kafka, Redis, Selenium browser containers and more right from test code and removes them afterwards. Integration tests run against real dependencies instead of mocks. Available for Java, Go, .NET, Python, Node.js and more. Open source.', 'Одноразові контейнери в тестах
Бази, брокери, браузери
Java, Go, .NET, Python, Node.js
Відкритий код', 'Throwaway containers in tests
Databases, brokers, browsers
Java, Go, .NET, Python, Node.js
Open source', 'QA-інженери з автоматизації та розробники, що пишуть автотести', 'Test automation engineers and developers writing automated tests', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'testcontainers.com' OR LOWER(`name`) = 'testcontainers') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Library that spins up real databases, brokers and browsers in Docker for the duration of a test.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Testcontainers starts throwaway PostgreSQL, MySQL, Kafka, Redis, Selenium browser containers and more right from test code and removes them afterwards. Integration tests run against real dependencies instead of mocks. Available for Java, Go, .NET, Python, Node.js and more. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Throwaway containers in tests
Databases, brokers, browsers
Java, Go, .NET, Python, Node.js
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

-- GitHub Actions — Тестування
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/features/actions' OR LOWER(`name`) = 'github actions')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GitHub Actions', NULL, 'https://github.com/features/actions', NULL, NULL, 'CI/CD у GitHub: автотести запускаються на кожен push і pull request, результати — прямо в репозиторії.', 'CI/CD in GitHub: automated tests run on every push and pull request, with results in the repository.', 'GitHub Actions виконує робочі процеси з YAML-файлів у репозиторії: збирання, запуск автотестів у кількох операційних системах і версіях, публікацію звітів і розгортання. Тисячі готових дій у Marketplace, матриці запусків і кешування. Для публічних репозиторіїв безкоштовно, для приватних — безкоштовні хвилини щомісяця.', 'GitHub Actions runs workflows from YAML files in the repo: builds, automated tests across multiple OSes and versions, report publishing and deployment. Thousands of ready actions on the Marketplace, run matrices and caching. Free for public repositories; private repos get free monthly minutes.', 'Робочі процеси в YAML
Матриці ОС і версій
Тисячі готових дій
Безкоштовні хвилини', 'YAML workflows
OS and version matrices
Thousands of ready actions
Free minutes', 'QA-інженери з автоматизації та розробники, що пишуть автотести', 'Test automation engineers and developers writing automated tests', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/features/actions' OR LOWER(`name`) = 'github actions') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'CI/CD in GitHub: automated tests run on every push and pull request, with results in the repository.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'GitHub Actions runs workflows from YAML files in the repo: builds, automated tests across multiple OSes and versions, report publishing and deployment. Thousands of ready actions on the Marketplace, run matrices and caching. Free for public repositories; private repos get free monthly minutes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'YAML workflows
OS and version matrices
Thousands of ready actions
Free minutes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Test automation engineers and developers writing automated tests', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовний тариф або версія з обмеженнями.', 'A free plan or limited free version is available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free plan or limited free version is available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Jenkins — Тестування
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jenkins.io' OR LOWER(`name`) = 'jenkins')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Jenkins', NULL, 'https://www.jenkins.io', NULL, NULL, 'Відкритий сервер автоматизації: збирання, запуск автотестів і розгортання з тисячами плагінів.', 'Open-source automation server: builds, automated test runs and deployment with thousands of plugins.', 'Jenkins запускає конвеєри, описані в Jenkinsfile, на власних серверах: збирання, автотести, публікацію звітів JUnit і Allure, розгортання. Понад тисячу плагінів інтегрують його з Git, Docker, Kubernetes і хмарами. Досі один із найпоширеніших CI-серверів у компаніях. Відкритий код.', 'Jenkins runs pipelines defined in a Jenkinsfile on your own servers: builds, automated tests, JUnit and Allure report publishing and deployment. Over a thousand plugins integrate it with Git, Docker, Kubernetes and clouds. Still one of the most common CI servers in companies. Open source.', 'Конвеєри в Jenkinsfile
Звіти JUnit і Allure
Понад тисячу плагінів
Власні сервери, відкритий код', 'Jenkinsfile pipelines
JUnit and Allure reports
1,000+ plugins
Self-hosted, open source', 'QA-інженери з автоматизації та розробники, що пишуть автотести', 'Test automation engineers and developers writing automated tests', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jenkins.io' OR LOWER(`name`) = 'jenkins') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source automation server: builds, automated test runs and deployment with thousands of plugins.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Jenkins runs pipelines defined in a Jenkinsfile on your own servers: builds, automated tests, JUnit and Allure report publishing and deployment. Over a thousand plugins integrate it with Git, Docker, Kubernetes and clouds. Still one of the most common CI servers in companies. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Jenkinsfile pipelines
JUnit and Allure reports
1,000+ plugins
Self-hosted, open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Test automation engineers and developers writing automated tests', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;


