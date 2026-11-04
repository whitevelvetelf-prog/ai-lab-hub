SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-04: «Розробка та IT» → «Тестування» і «Веб-розробка».
-- Партія 8: 21 нових продуктів — тестування продуктивності фронтенду (для статті про продуктивність фронтенду).
-- Тексти UA/EN написано за офіційними сторінками, звірено 2026-11-04. Якщо продукт з такою адресою чи назвою вже є — лише прив’язка.
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою. Повторний запуск безпечний.
--   PageSpeed Insights
--   WebPageTest
--   DebugBear
--   SpeedCurve
--   Calibre
--   Treo
--   Unlighthouse
--   Lighthouse CI
--   web-vitals
--   Chrome UX Report
--   Firefox Profiler
--   RUMvision
--   Request Metrics
--   Yellow Lab Tools
--   Bundlephobia
--   webpack-bundle-analyzer
--   Size Limit
--   Statoscope
--   Squoosh
--   React Developer Tools
--   Vue DevTools
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'development-it' LIMIT 1);

-- PageSpeed Insights — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pagespeed.web.dev' OR LOWER(`name`) = 'pagespeed insights')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PageSpeed Insights', NULL, 'https://pagespeed.web.dev', NULL, NULL, 'Безкоштовний сервіс Google: Core Web Vitals реальних користувачів із CrUX плюс лабораторний звіт Lighthouse для будь-якої сторінки.', 'Free Google service: real-user Core Web Vitals from CrUX plus a Lighthouse lab report for any page.', 'PageSpeed Insights показує два види даних. Угорі — польові дані з Chrome UX Report: LCP, INP і CLS реальних відвідувачів за останні 28 днів на 75-му перцентилі, окремо для мобільних і десктопу, для сторінки й усього сайту. Нижче — лабораторний прогін Lighthouse з оцінкою продуктивності та порадами, що саме гальмує сторінку. Є безкоштовний API для автоматизації.', 'PageSpeed Insights shows two kinds of data. At the top is field data from the Chrome UX Report: LCP, INP and CLS of real visitors over the last 28 days at the 75th percentile, separately for mobile and desktop, for the page and the whole origin. Below is a Lighthouse lab run with a performance score and advice on what exactly slows the page down. A free API is available for automation.', 'Польові Core Web Vitals з CrUX за 28 днів
Лабораторний звіт Lighthouse
Окремо мобільні й десктоп
Безкоштовний PageSpeed Insights API', 'Field Core Web Vitals from CrUX over 28 days
Lighthouse lab report
Mobile and desktop separately
Free PageSpeed Insights API', 'QA-інженери, фронтенд-розробники й SEO-фахівці, що вимірюють і покращують швидкість сайтів та Core Web Vitals', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pagespeed.web.dev' OR LOWER(`name`) = 'pagespeed insights') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free Google service: real-user Core Web Vitals from CrUX plus a Lighthouse lab report for any page.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PageSpeed Insights shows two kinds of data. At the top is field data from the Chrome UX Report: LCP, INP and CLS of real visitors over the last 28 days at the 75th percentile, separately for mobile and desktop, for the page and the whole origin. Below is a Lighthouse lab run with a performance score and advice on what exactly slows the page down. A free API is available for automation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Field Core Web Vitals from CrUX over 28 days
Lighthouse lab report
Mobile and desktop separately
Free PageSpeed Insights API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- WebPageTest — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'webpagetest.org' OR LOWER(`name`) = 'webpagetest')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'WebPageTest', NULL, 'https://www.webpagetest.org', NULL, NULL, 'Глибоке тестування швидкості сторінок з реальних браузерів у різних містах: водоспад запитів, фільмстрип, порівняння.', 'In-depth page speed testing from real browsers in many locations: request waterfall, filmstrip, comparisons.', 'WebPageTest (зараз належить Catchpoint) завантажує сторінку в реальному браузері з обраної локації, пристрою й типу з’єднання і показує детальний водоспад запитів, фільмстрип і відео завантаження, Core Web Vitals, роботу головного потоку. Можна порівнювати кілька прогонів, повторні відвідини з кешем і тестувати гіпотези оптимізації без зміни коду. Базові тести безкоштовні після реєстрації, API й розширені можливості — у платних планах.', 'WebPageTest (now owned by Catchpoint) loads a page in a real browser from a chosen location, device and connection type and shows a detailed request waterfall, filmstrip and video, Core Web Vitals and main-thread activity. You can compare runs, repeat views with a warm cache and test optimisation ideas without changing code. Basic tests are free with an account; the API and advanced features are in paid plans.', 'Тести з реальних браузерів у різних локаціях
Водоспад запитів, фільмстрип і відео
Порівняння прогонів і повторні відвідини
Сценарії, API та інтеграції в платних планах', 'Tests from real browsers in many locations
Request waterfall, filmstrip and video
Run comparisons and repeat views
Scripts, API and integrations in paid plans', 'QA-інженери, фронтенд-розробники й SEO-фахівці, що вимірюють і покращують швидкість сайтів та Core Web Vitals', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'webpagetest.org' OR LOWER(`name`) = 'webpagetest') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'In-depth page speed testing from real browsers in many locations: request waterfall, filmstrip, comparisons.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'WebPageTest (now owned by Catchpoint) loads a page in a real browser from a chosen location, device and connection type and shows a detailed request waterfall, filmstrip and video, Core Web Vitals and main-thread activity. You can compare runs, repeat views with a warm cache and test optimisation ideas without changing code. Basic tests are free with an account; the API and advanced features are in paid plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tests from real browsers in many locations
Request waterfall, filmstrip and video
Run comparisons and repeat views
Scripts, API and integrations in paid plans', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовний тариф або версія з обмеженнями.', 'A free plan or limited free version is available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free plan or limited free version is available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- DebugBear — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'debugbear.com' OR LOWER(`name`) = 'debugbear')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DebugBear', NULL, 'https://www.debugbear.com', NULL, NULL, 'Моніторинг швидкості сайту: регулярні лабораторні тести, дані CrUX і RUM реальних користувачів з розбором Core Web Vitals.', 'Website speed monitoring: scheduled lab tests, CrUX data and real-user RUM with Core Web Vitals breakdowns.', 'DebugBear поєднує три джерела: заплановані лабораторні тести сторінок, польові дані Google CrUX і власний RUM-скрипт, що збирає LCP, INP та CLS реальних відвідувачів з поясненням, які елементи й скрипти винні. Сервіс показує зміни після кожного релізу, надсилає сповіщення про регресії й має безкоштовні інструменти: тест швидкості, INP Debugger та інші.', 'DebugBear combines three sources: scheduled lab tests, Google CrUX field data and its own RUM script that collects LCP, INP and CLS from real visitors and explains which elements and scripts are to blame. It shows changes after each release, alerts on regressions and offers free tools such as a speed test and an INP Debugger.', 'Заплановані лабораторні тести сторінок
RUM: LCP, INP, CLS реальних користувачів з атрибуцією
Дані CrUX і порівняння з конкурентами
Безкоштовний тест швидкості й INP Debugger', 'Scheduled lab page tests
RUM: real-user LCP, INP, CLS with attribution
CrUX data and competitor comparisons
Free speed test and INP Debugger', 'QA-інженери, фронтенд-розробники й SEO-фахівці, що вимірюють і покращують швидкість сайтів та Core Web Vitals', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'debugbear.com' OR LOWER(`name`) = 'debugbear') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Website speed monitoring: scheduled lab tests, CrUX data and real-user RUM with Core Web Vitals breakdowns.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'DebugBear combines three sources: scheduled lab tests, Google CrUX field data and its own RUM script that collects LCP, INP and CLS from real visitors and explains which elements and scripts are to blame. It shows changes after each release, alerts on regressions and offers free tools such as a speed test and an INP Debugger.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Scheduled lab page tests
RUM: real-user LCP, INP, CLS with attribution
CrUX data and competitor comparisons
Free speed test and INP Debugger', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовний тариф або версія з обмеженнями.', 'A free plan or limited free version is available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free plan or limited free version is available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SpeedCurve — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'speedcurve.com' OR LOWER(`name`) = 'speedcurve')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SpeedCurve', NULL, 'https://www.speedcurve.com', NULL, NULL, 'Платформа моніторингу продуктивності фронтенду: синтетичні тести й RUM, бюджети продуктивності, порівняння з конкурентами.', 'Front-end performance monitoring platform: synthetic tests and RUM, performance budgets, competitor benchmarks.', 'SpeedCurve регулярно тестує сторінки синтетично й збирає RUM-дані реальних відвідувачів, зіставляючи швидкість із бізнес-метриками — відмовами й конверсіями. Команди задають бюджети продуктивності й отримують сповіщення, коли реліз їх порушує. Публічні бенчмарки показують, як сайти галузі виглядають за Core Web Vitals.', 'SpeedCurve runs scheduled synthetic tests and collects RUM data from real visitors, correlating speed with business metrics such as bounce rate and conversions. Teams set performance budgets and get alerts when a release breaks them. Public benchmarks show how sites in an industry compare on Core Web Vitals.', 'Синтетичний моніторинг і RUM в одному місці
Бюджети продуктивності й сповіщення
Зв’язок швидкості з конверсіями й відмовами
Галузеві бенчмарки', 'Synthetic monitoring and RUM in one place
Performance budgets and alerts
Speed correlated with conversions and bounce
Industry benchmarks', 'QA-інженери, фронтенд-розробники й SEO-фахівці, що вимірюють і покращують швидкість сайтів та Core Web Vitals', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'speedcurve.com' OR LOWER(`name`) = 'speedcurve') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Front-end performance monitoring platform: synthetic tests and RUM, performance budgets, competitor benchmarks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SpeedCurve runs scheduled synthetic tests and collects RUM data from real visitors, correlating speed with business metrics such as bounce rate and conversions. Teams set performance budgets and get alerts when a release breaks them. Public benchmarks show how sites in an industry compare on Core Web Vitals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Synthetic monitoring and RUM in one place
Performance budgets and alerts
Speed correlated with conversions and bounce
Industry benchmarks', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Calibre — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'calibreapp.com' OR LOWER(`name`) = 'calibre')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Calibre', NULL, 'https://calibreapp.com', NULL, NULL, 'Сервіс моніторингу швидкості сайтів для команд: регулярні тести, бюджети, Core Web Vitals і звіти про кожен деплой.', 'Website speed monitoring service for teams: scheduled tests, budgets, Core Web Vitals and per-deploy reports.', 'Calibre регулярно тестує обрані сторінки з різних локацій і пристроїв, відстежує Core Web Vitals, вагу JavaScript і сторонні скрипти, а також порівнює результати до й після деплою. Бюджети продуктивності й сповіщення в Slack допомагають ловити регресії, а перевірки в pull request показують вплив змін ще до релізу.', 'Calibre tests selected pages on a schedule from various locations and devices, tracks Core Web Vitals, JavaScript weight and third-party scripts, and compares results before and after a deploy. Performance budgets and Slack alerts help catch regressions, and pull request checks show the impact of changes before release.', 'Регулярні тести з різних локацій і пристроїв
Core Web Vitals, вага JS і сторонні скрипти
Порівняння до й після деплою
Бюджети, сповіщення й перевірки в pull request', 'Scheduled tests from various locations and devices
Core Web Vitals, JS weight and third-party scripts
Before/after deploy comparisons
Budgets, alerts and pull request checks', 'QA-інженери, фронтенд-розробники й SEO-фахівці, що вимірюють і покращують швидкість сайтів та Core Web Vitals', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'calibreapp.com' OR LOWER(`name`) = 'calibre') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Website speed monitoring service for teams: scheduled tests, budgets, Core Web Vitals and per-deploy reports.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Calibre tests selected pages on a schedule from various locations and devices, tracks Core Web Vitals, JavaScript weight and third-party scripts, and compares results before and after a deploy. Performance budgets and Slack alerts help catch regressions, and pull request checks show the impact of changes before release.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Scheduled tests from various locations and devices
Core Web Vitals, JS weight and third-party scripts
Before/after deploy comparisons
Budgets, alerts and pull request checks', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Treo — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'treo.sh' OR LOWER(`name`) = 'treo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Treo', NULL, 'https://treo.sh', NULL, NULL, 'Моніторинг швидкості на даних CrUX і Lighthouse; безкоштовний Site Speed показує Core Web Vitals будь-якого домену за історією.', 'Speed monitoring based on CrUX and Lighthouse data; the free Site Speed tool shows any domain’s Core Web Vitals history.', 'Безкоштовний інструмент Treo Site Speed без реєстрації показує Core Web Vitals домену з Chrome UX Report: розподіл по країнах і пристроях та динаміку за місяці. Платні плани додають регулярні тести Lighthouse, моніторинг багатьох сторінок, сповіщення й звіти для команд і агенцій.', 'The free Treo Site Speed tool needs no sign-up and shows a domain’s Core Web Vitals from the Chrome UX Report, split by country and device, with month-by-month history. Paid plans add scheduled Lighthouse tests, multi-page monitoring, alerts and reports for teams and agencies.', 'Безкоштовний Site Speed: CrUX будь-якого домену
Розподіл по країнах і пристроях, історія
Регулярні тести Lighthouse у платних планах
Сповіщення й звіти для команд', 'Free Site Speed: CrUX for any domain
Country and device breakdowns, history
Scheduled Lighthouse tests in paid plans
Alerts and team reports', 'QA-інженери, фронтенд-розробники й SEO-фахівці, що вимірюють і покращують швидкість сайтів та Core Web Vitals', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'treo.sh' OR LOWER(`name`) = 'treo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Speed monitoring based on CrUX and Lighthouse data; the free Site Speed tool shows any domain’s Core Web Vitals history.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The free Treo Site Speed tool needs no sign-up and shows a domain’s Core Web Vitals from the Chrome UX Report, split by country and device, with month-by-month history. Paid plans add scheduled Lighthouse tests, multi-page monitoring, alerts and reports for teams and agencies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free Site Speed: CrUX for any domain
Country and device breakdowns, history
Scheduled Lighthouse tests in paid plans
Alerts and team reports', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовний тариф або версія з обмеженнями.', 'A free plan or limited free version is available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free plan or limited free version is available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Unlighthouse — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'unlighthouse.dev' OR LOWER(`name`) = 'unlighthouse')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Unlighthouse', NULL, 'https://unlighthouse.dev', NULL, NULL, 'Відкритий інструмент, що сам обходить сайт і проганяє Lighthouse по всіх сторінках, показуючи результати в одному інтерфейсі.', 'Open-source tool that crawls a site and runs Lighthouse on every page, showing results in a single UI.', 'Unlighthouse запускається однією командою (npx unlighthouse --site …), знаходить сторінки через карту сайту й посилання і паралельно перевіряє кожну Lighthouse. Результати — продуктивність, доступність, SEO, найкращі практики — видно в локальному веб-інтерфейсі з сортуванням і фільтрами. Є режим CI з порогами та онлайн-версія для швидкої перевірки.', 'Unlighthouse starts with one command (npx unlighthouse --site …), discovers pages through the sitemap and links, and checks each one with Lighthouse in parallel. Results for performance, accessibility, SEO and best practices appear in a local web UI with sorting and filters. There is a CI mode with thresholds and an online version for quick checks.', 'Lighthouse по всьому сайту однією командою
Автоматичний обхід сторінок
Локальний інтерфейс із сортуванням
Режим CI з порогами', 'Site-wide Lighthouse with one command
Automatic page crawling
Local UI with sorting
CI mode with thresholds', 'QA-інженери, фронтенд-розробники й SEO-фахівці, що вимірюють і покращують швидкість сайтів та Core Web Vitals', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'unlighthouse.dev' OR LOWER(`name`) = 'unlighthouse') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source tool that crawls a site and runs Lighthouse on every page, showing results in a single UI.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Unlighthouse starts with one command (npx unlighthouse --site …), discovers pages through the sitemap and links, and checks each one with Lighthouse in parallel. Results for performance, accessibility, SEO and best practices appear in a local web UI with sorting and filters. There is a CI mode with thresholds and an online version for quick checks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Site-wide Lighthouse with one command
Automatic page crawling
Local UI with sorting
CI mode with thresholds', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Lighthouse CI — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/googlechrome/lighthouse-ci' OR LOWER(`name`) = 'lighthouse ci')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lighthouse CI', NULL, 'https://github.com/GoogleChrome/lighthouse-ci', NULL, NULL, 'Набір інструментів Google для запуску Lighthouse у CI: перевірки бюджетів на кожен коміт і порівняння звітів.', 'Google’s toolkit for running Lighthouse in CI: budget assertions on every commit and report comparisons.', 'Lighthouse CI (lhci) проганяє Lighthouse кілька разів для кожної збірки, перевіряє результати за заданими правилами — оцінкою, метриками, розміром ресурсів — і може впасти, якщо зміни погіршили продуктивність. Звіти зберігаються у тимчасовому публічному сховищі або на власному LHCI-сервері з історією й порівнянням комітів. Працює з GitHub Actions, GitLab CI, Jenkins та іншими.', 'Lighthouse CI (lhci) runs Lighthouse several times for each build, checks results against assertions on score, metrics and resource sizes, and can fail the build when a change makes performance worse. Reports go to temporary public storage or your own LHCI server with history and commit comparisons. Works with GitHub Actions, GitLab CI, Jenkins and others.', 'Кілька прогонів Lighthouse на кожну збірку
Правила й бюджети, що валять збірку
Власний сервер з історією й порівняннями
Інтеграція з GitHub Actions, GitLab CI, Jenkins', 'Multiple Lighthouse runs per build
Assertions and budgets that fail the build
Self-hosted server with history and diffs
Integrates with GitHub Actions, GitLab CI, Jenkins', 'QA-інженери, фронтенд-розробники й SEO-фахівці, що вимірюють і покращують швидкість сайтів та Core Web Vitals', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/googlechrome/lighthouse-ci' OR LOWER(`name`) = 'lighthouse ci') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Google’s toolkit for running Lighthouse in CI: budget assertions on every commit and report comparisons.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Lighthouse CI (lhci) runs Lighthouse several times for each build, checks results against assertions on score, metrics and resource sizes, and can fail the build when a change makes performance worse. Reports go to temporary public storage or your own LHCI server with history and commit comparisons. Works with GitHub Actions, GitLab CI, Jenkins and others.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Multiple Lighthouse runs per build
Assertions and budgets that fail the build
Self-hosted server with history and diffs
Integrates with GitHub Actions, GitLab CI, Jenkins', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- web-vitals — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/googlechrome/web-vitals' OR LOWER(`name`) = 'web-vitals')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'web-vitals', NULL, 'https://github.com/GoogleChrome/web-vitals', NULL, NULL, 'Крихітна JavaScript-бібліотека Google для вимірювання LCP, INP, CLS, FCP і TTFB у реальних користувачів.', 'Tiny Google JavaScript library for measuring LCP, INP, CLS, FCP and TTFB in real users.', 'Бібліотека web-vitals вимірює метрики так само, як їх рахує Chrome і CrUX, і передає значення у вашу аналітику чи власний бекенд. Збірка attribution додає діагностику: який елемент був LCP, яка взаємодія дала поганий INP і що її затримало, які елементи зсунулися. Це найпростіший спосіб почати власний RUM.', 'The web-vitals library measures metrics the same way Chrome and CrUX do and sends the values to your analytics or backend. The attribution build adds diagnostics: which element was the LCP, which interaction caused a poor INP and what delayed it, which elements shifted. It is the simplest way to start your own RUM.', 'LCP, INP, CLS, FCP, TTFB як у Chrome і CrUX
Збірка attribution з діагностикою причин
Відправка в аналітику чи власний бекенд
Мінімальний розмір', 'LCP, INP, CLS, FCP, TTFB the same way as Chrome and CrUX
Attribution build with root-cause diagnostics
Send to analytics or your own backend
Tiny footprint', 'Фронтенд-розробники й тестувальники, що контролюють розмір JavaScript-бандлів і швидкодію інтерфейсу', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/googlechrome/web-vitals' OR LOWER(`name`) = 'web-vitals') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tiny Google JavaScript library for measuring LCP, INP, CLS, FCP and TTFB in real users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The web-vitals library measures metrics the same way Chrome and CrUX do and sends the values to your analytics or backend. The attribution build adds diagnostics: which element was the LCP, which interaction caused a poor INP and what delayed it, which elements shifted. It is the simplest way to start your own RUM.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'LCP, INP, CLS, FCP, TTFB the same way as Chrome and CrUX
Attribution build with root-cause diagnostics
Send to analytics or your own backend
Tiny footprint', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Chrome UX Report — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'developer.chrome.com/docs/crux' OR LOWER(`name`) = 'chrome ux report')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Chrome UX Report', NULL, 'https://developer.chrome.com/docs/crux', NULL, NULL, 'Публічний набір даних Google про швидкість сайтів у реальних користувачів Chrome: API, History API, BigQuery і CrUX Vis.', 'Google’s public dataset of real Chrome users’ site speed: API, History API, BigQuery and CrUX Vis.', 'Chrome UX Report збирає анонімні Core Web Vitals та інші метрики від користувачів Chrome, які на це погодилися, для мільйонів сайтів. Дані доступні через CrUX API (останні 28 днів), CrUX History API (тижнева динаміка), щомісячний набір у BigQuery та візуалізацію CrUX Vis, що замінила старий CrUX Dashboard. Саме ці дані бачать PageSpeed Insights і Search Console.', 'The Chrome UX Report collects anonymous Core Web Vitals and other metrics from opted-in Chrome users for millions of sites. The data is available via the CrUX API (last 28 days), the CrUX History API (weekly trends), a monthly BigQuery dataset and the CrUX Vis visualisation that replaced the old CrUX Dashboard. This is the data PageSpeed Insights and Search Console show.', 'Польові дані реальних користувачів Chrome
CrUX API та History API
Щомісячний набір у BigQuery
Візуалізація CrUX Vis', 'Field data from real Chrome users
CrUX API and History API
Monthly BigQuery dataset
CrUX Vis visualisation', 'QA-інженери, фронтенд-розробники й SEO-фахівці, що вимірюють і покращують швидкість сайтів та Core Web Vitals', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'developer.chrome.com/docs/crux' OR LOWER(`name`) = 'chrome ux report') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Google’s public dataset of real Chrome users’ site speed: API, History API, BigQuery and CrUX Vis.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Chrome UX Report collects anonymous Core Web Vitals and other metrics from opted-in Chrome users for millions of sites. The data is available via the CrUX API (last 28 days), the CrUX History API (weekly trends), a monthly BigQuery dataset and the CrUX Vis visualisation that replaced the old CrUX Dashboard. This is the data PageSpeed Insights and Search Console show.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Field data from real Chrome users
CrUX API and History API
Monthly BigQuery dataset
CrUX Vis visualisation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Firefox Profiler — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'profiler.firefox.com' OR LOWER(`name`) = 'firefox profiler')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Firefox Profiler', NULL, 'https://profiler.firefox.com', NULL, NULL, 'Відкритий профайлер продуктивності Mozilla для Firefox: запис роботи JS, рендерингу й мережі та поширення профілю посиланням.', 'Mozilla’s open-source performance profiler for Firefox: records JS, rendering and network activity and shares profiles via link.', 'Firefox Profiler записує, що відбувається в браузері: виклики JavaScript, стилі й розкладку, малювання, мережеві запити, роботу потоків. Профіль відкривається у вебінтерфейсі з графіком полум’я, деревом викликів і маркерами, а поділитися ним можна посиланням. Він також відкриває профілі Chrome, Linux perf та інших форматів, тож корисний і для порівняння браузерів.', 'Firefox Profiler records what happens in the browser: JavaScript calls, style and layout, painting, network requests and thread activity. The profile opens in a web UI with a flame graph, call tree and markers, and can be shared via a link. It also opens Chrome, Linux perf and other profile formats, which makes it handy for cross-browser comparisons.', 'Запис JS, рендерингу й мережі у Firefox
Графік полум’я, дерево викликів, маркери
Поширення профілю посиланням
Імпорт профілів Chrome та інших форматів', 'Records JS, rendering and network in Firefox
Flame graph, call tree, markers
Share profiles via link
Imports Chrome and other profile formats', 'Фронтенд-розробники й тестувальники, що контролюють розмір JavaScript-бандлів і швидкодію інтерфейсу', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'profiler.firefox.com' OR LOWER(`name`) = 'firefox profiler') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mozilla’s open-source performance profiler for Firefox: records JS, rendering and network activity and shares profiles via link.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Firefox Profiler records what happens in the browser: JavaScript calls, style and layout, painting, network requests and thread activity. The profile opens in a web UI with a flame graph, call tree and markers, and can be shared via a link. It also opens Chrome, Linux perf and other profile formats, which makes it handy for cross-browser comparisons.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Records JS, rendering and network in Firefox
Flame graph, call tree, markers
Share profiles via link
Imports Chrome and other profile formats', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- RUMvision — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rumvision.com' OR LOWER(`name`) = 'rumvision')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'RUMvision', NULL, 'https://www.rumvision.com', NULL, NULL, 'Моніторинг Core Web Vitals реальних користувачів (RUM) із розбивкою за шаблонами сторінок, пристроями й сторонніми скриптами.', 'Real-user monitoring (RUM) for Core Web Vitals, broken down by page templates, devices and third-party scripts.', 'RUMvision збирає LCP, INP, CLS і TTFB відвідувачів через легкий скрипт і показує, які шаблони сторінок, пристрої, країни й сторонні скрипти погіршують метрики. Є атрибуція INP до конкретних скриптів і взаємодій, порівняння до й після релізу та сповіщення. Особливо популярний серед інтернет-магазинів.', 'RUMvision collects visitors’ LCP, INP, CLS and TTFB via a lightweight script and shows which page templates, devices, countries and third-party scripts hurt the metrics. It attributes INP to specific scripts and interactions, compares before and after releases and sends alerts. Especially popular with online stores.', 'RUM для LCP, INP, CLS, TTFB
Розбивка за шаблонами, пристроями, країнами
Атрибуція INP до скриптів і взаємодій
Вплив сторонніх скриптів і сповіщення', 'RUM for LCP, INP, CLS, TTFB
Breakdowns by template, device, country
INP attribution to scripts and interactions
Third-party impact and alerts', 'QA-інженери, фронтенд-розробники й SEO-фахівці, що вимірюють і покращують швидкість сайтів та Core Web Vitals', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rumvision.com' OR LOWER(`name`) = 'rumvision') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Real-user monitoring (RUM) for Core Web Vitals, broken down by page templates, devices and third-party scripts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'RUMvision collects visitors’ LCP, INP, CLS and TTFB via a lightweight script and shows which page templates, devices, countries and third-party scripts hurt the metrics. It attributes INP to specific scripts and interactions, compares before and after releases and sends alerts. Especially popular with online stores.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'RUM for LCP, INP, CLS, TTFB
Breakdowns by template, device, country
INP attribution to scripts and interactions
Third-party impact and alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Request Metrics — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'requestmetrics.com' OR LOWER(`name`) = 'request metrics')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Request Metrics', NULL, 'https://requestmetrics.com', NULL, NULL, 'Простий RUM-моніторинг швидкості сайту й Core Web Vitals для невеликих команд, разом із відстеженням помилок JavaScript.', 'Simple RUM monitoring of site speed and Core Web Vitals for small teams, plus JavaScript error tracking.', 'Request Metrics додає на сайт скрипт, що збирає Core Web Vitals і час завантаження реальних відвідувачів, і показує, які сторінки та пристрої найповільніші. Сервіс також відстежує помилки JavaScript, перевіряє доступність сайту й SSL та надсилає сповіщення. Розрахований на невеликі команди, яким не потрібна велика APM-платформа.', 'Request Metrics adds a script that collects real visitors’ Core Web Vitals and load times and shows which pages and devices are slowest. It also tracks JavaScript errors, checks uptime and SSL, and sends alerts. It is aimed at small teams that don’t need a big APM platform.', 'Core Web Vitals реальних відвідувачів
Найповільніші сторінки й пристрої
Відстеження помилок JavaScript
Перевірка доступності сайту й SSL', 'Real-visitor Core Web Vitals
Slowest pages and devices
JavaScript error tracking
Uptime and SSL checks', 'QA-інженери, фронтенд-розробники й SEO-фахівці, що вимірюють і покращують швидкість сайтів та Core Web Vitals', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'requestmetrics.com' OR LOWER(`name`) = 'request metrics') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Simple RUM monitoring of site speed and Core Web Vitals for small teams, plus JavaScript error tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Request Metrics adds a script that collects real visitors’ Core Web Vitals and load times and shows which pages and devices are slowest. It also tracks JavaScript errors, checks uptime and SSL, and sends alerts. It is aimed at small teams that don’t need a big APM platform.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-visitor Core Web Vitals
Slowest pages and devices
JavaScript error tracking
Uptime and SSL checks', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, front-end developers and SEO specialists measuring and improving site speed and Core Web Vitals', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Yellow Lab Tools — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yellowlab.tools' OR LOWER(`name`) = 'yellow lab tools')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Yellow Lab Tools', NULL, 'https://yellowlab.tools', NULL, NULL, 'Безкоштовний відкритий аудит фронтенду: вага сторінки, складність DOM, CSS і JavaScript, погані практики.', 'Free open-source front-end audit: page weight, DOM complexity, CSS and JavaScript quality, bad practices.', 'Yellow Lab Tools завантажує сторінку й оцінює не стільки швидкість, скільки якість фронтенду: вагу й кількість запитів, розмір і складність DOM, дублікати й надмірність CSS, проблемні JavaScript-конструкції, шрифти й зображення. Кожна перевірка має оцінку й пояснення, що виправити. Інструмент відкритий і може працювати на власному сервері.', 'Yellow Lab Tools loads a page and rates front-end quality rather than just speed: weight and number of requests, DOM size and complexity, duplicated and excessive CSS, problematic JavaScript patterns, fonts and images. Each check has a score and an explanation of what to fix. The tool is open source and can be self-hosted.', 'Вага сторінки й кількість запитів
Складність DOM
Аналіз CSS і JavaScript
Відкритий код, можна розгорнути в себе', 'Page weight and request count
DOM complexity
CSS and JavaScript analysis
Open source, self-hostable', 'Фронтенд-розробники й тестувальники, що контролюють розмір JavaScript-бандлів і швидкодію інтерфейсу', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yellowlab.tools' OR LOWER(`name`) = 'yellow lab tools') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free open-source front-end audit: page weight, DOM complexity, CSS and JavaScript quality, bad practices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Yellow Lab Tools loads a page and rates front-end quality rather than just speed: weight and number of requests, DOM size and complexity, duplicated and excessive CSS, problematic JavaScript patterns, fonts and images. Each check has a score and an explanation of what to fix. The tool is open source and can be self-hosted.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Page weight and request count
DOM complexity
CSS and JavaScript analysis
Open source, self-hostable', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bundlephobia — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bundlephobia.com' OR LOWER(`name`) = 'bundlephobia')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bundlephobia', NULL, 'https://bundlephobia.com', NULL, NULL, 'Показує, скільки важить npm-пакет у бандлі (мініфікований і gzip) та скільки часу додасть завантаженню.', 'Shows how much an npm package adds to your bundle (minified and gzipped) and how long it takes to download.', 'Bundlephobia збирає npm-пакет і показує його розмір після мініфікації та gzip, кількість залежностей, приблизний час завантаження на повільних мережах, підтримку tree shaking та історію розміру за версіями. Пропонує легші альтернативи. Корисно перевірити перед тим, як додати бібліотеку в проєкт.', 'Bundlephobia builds an npm package and shows its minified and gzipped size, dependency count, approximate download time on slow networks, tree-shaking support and size history across versions. It suggests lighter alternatives. Useful to check before adding a library to a project.', 'Розмір пакета після мініфікації й gzip
Час завантаження на повільних мережах
Історія розміру за версіями
Легші альтернативи', 'Minified and gzipped package size
Download time on slow networks
Size history across versions
Lighter alternatives', 'Фронтенд-розробники й тестувальники, що контролюють розмір JavaScript-бандлів і швидкодію інтерфейсу', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bundlephobia.com' OR LOWER(`name`) = 'bundlephobia') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Shows how much an npm package adds to your bundle (minified and gzipped) and how long it takes to download.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Bundlephobia builds an npm package and shows its minified and gzipped size, dependency count, approximate download time on slow networks, tree-shaking support and size history across versions. It suggests lighter alternatives. Useful to check before adding a library to a project.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Minified and gzipped package size
Download time on slow networks
Size history across versions
Lighter alternatives', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- webpack-bundle-analyzer — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/webpack-contrib/webpack-bundle-analyzer' OR LOWER(`name`) = 'webpack-bundle-analyzer')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'webpack-bundle-analyzer', NULL, 'https://github.com/webpack-contrib/webpack-bundle-analyzer', NULL, NULL, 'Інтерактивна карта вмісту JavaScript-бандла: які модулі й залежності займають найбільше місця.', 'Interactive treemap of a JavaScript bundle: which modules and dependencies take the most space.', 'webpack-bundle-analyzer будує інтерактивну карту-деревовид усіх модулів у зібраних бандлах webpack із розмірами до обробки, після мініфікації та gzip. Одразу видно великі бібліотеки, дублікати й випадково затягнуті залежності. Працює як плагін webpack або з файлом статистики, є аналоги для Vite і Rollup.', 'webpack-bundle-analyzer draws an interactive treemap of every module in webpack bundles with stat, parsed and gzipped sizes. Large libraries, duplicates and accidentally pulled-in dependencies are visible at once. Works as a webpack plugin or with a stats file; similar tools exist for Vite and Rollup.', 'Інтерактивна карта модулів бандла
Розміри до обробки, мініфіковані й gzip
Пошук дублікатів і великих залежностей
Плагін webpack або файл статистики', 'Interactive bundle module treemap
Stat, parsed and gzipped sizes
Finds duplicates and large dependencies
webpack plugin or stats file', 'Фронтенд-розробники й тестувальники, що контролюють розмір JavaScript-бандлів і швидкодію інтерфейсу', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/webpack-contrib/webpack-bundle-analyzer' OR LOWER(`name`) = 'webpack-bundle-analyzer') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Interactive treemap of a JavaScript bundle: which modules and dependencies take the most space.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'webpack-bundle-analyzer draws an interactive treemap of every module in webpack bundles with stat, parsed and gzipped sizes. Large libraries, duplicates and accidentally pulled-in dependencies are visible at once. Works as a webpack plugin or with a stats file; similar tools exist for Vite and Rollup.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Interactive bundle module treemap
Stat, parsed and gzipped sizes
Finds duplicates and large dependencies
webpack plugin or stats file', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Size Limit — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/ai/size-limit' OR LOWER(`name`) = 'size limit')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Size Limit', NULL, 'https://github.com/ai/size-limit', NULL, NULL, 'Інструмент бюджету продуктивності для JavaScript: валить CI, якщо бібліотека чи застосунок стали важчими за ліміт.', 'Performance budget tool for JavaScript: fails CI when a library or app grows beyond the limit.', 'Size Limit рахує розмір вашого JavaScript разом із залежностями після мініфікації й стиснення, а за бажанням — час його завантаження й виконання на повільному пристрої. Ліміти задаються в конфігурації, і перевірка падає в CI, якщо їх перевищено. GitHub Action коментує pull request зі зміною розміру.', 'Size Limit calculates the size of your JavaScript with dependencies after minification and compression and, optionally, the time to download and execute it on a slow device. Limits live in config, and the check fails in CI when they are exceeded. A GitHub Action comments on pull requests with the size change.', 'Розмір JS із залежностями після стиснення
Час завантаження й виконання на слабкому пристрої
Падіння CI при перевищенні ліміту
Коментарі в pull request через GitHub Action', 'JS size with dependencies after compression
Download and execution time on a slow device
Fails CI when the limit is exceeded
Pull request comments via GitHub Action', 'Фронтенд-розробники й тестувальники, що контролюють розмір JavaScript-бандлів і швидкодію інтерфейсу', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/ai/size-limit' OR LOWER(`name`) = 'size limit') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Performance budget tool for JavaScript: fails CI when a library or app grows beyond the limit.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Size Limit calculates the size of your JavaScript with dependencies after minification and compression and, optionally, the time to download and execute it on a slow device. Limits live in config, and the check fails in CI when they are exceeded. A GitHub Action comments on pull requests with the size change.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'JS size with dependencies after compression
Download and execution time on a slow device
Fails CI when the limit is exceeded
Pull request comments via GitHub Action', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Statoscope — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'statoscope.tech' OR LOWER(`name`) = 'statoscope')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Statoscope', NULL, 'https://statoscope.tech', NULL, NULL, 'Відкритий інструмент аналізу статистики збірки webpack і rspack: розмір, дублікати, порівняння збірок і правила валідації.', 'Open-source analyser for webpack and rspack build stats: size, duplicates, build comparisons and validation rules.', 'Statoscope відкриває файл статистики збірки й показує модулі, чанки, пакети, дублікати версій і зміну розміру між двома збірками. Правила валідації дозволяють заборонити певні залежності чи зростання бандла й перевіряти це в CI. Є вебверсія, плагін webpack і CLI.', 'Statoscope opens a build stats file and shows modules, chunks, packages, duplicate versions and size changes between two builds. Validation rules can forbid certain dependencies or bundle growth and enforce this in CI. Available as a web app, webpack plugin and CLI.', 'Аналіз модулів, чанків і пакетів
Пошук дублікатів версій
Порівняння двох збірок
Правила валідації в CI', 'Module, chunk and package analysis
Duplicate version detection
Compare two builds
Validation rules in CI', 'Фронтенд-розробники й тестувальники, що контролюють розмір JavaScript-бандлів і швидкодію інтерфейсу', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'statoscope.tech' OR LOWER(`name`) = 'statoscope') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source analyser for webpack and rspack build stats: size, duplicates, build comparisons and validation rules.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Statoscope opens a build stats file and shows modules, chunks, packages, duplicate versions and size changes between two builds. Validation rules can forbid certain dependencies or bundle growth and enforce this in CI. Available as a web app, webpack plugin and CLI.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Module, chunk and package analysis
Duplicate version detection
Compare two builds
Validation rules in CI', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Squoosh — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'squoosh.app' OR LOWER(`name`) = 'squoosh')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Squoosh', NULL, 'https://squoosh.app', NULL, NULL, 'Безкоштовний відкритий оптимізатор зображень у браузері: порівняння форматів AVIF, WebP, JPEG XL, MozJPEG зі шкалою якості.', 'Free open-source in-browser image optimiser: compare AVIF, WebP, JPEG XL and MozJPEG with a quality slider.', 'Squoosh стискає зображення прямо в браузері, без завантаження на сервер, і показує оригінал і результат поруч із повзунком. Можна обрати кодек (AVIF, WebP, MozJPEG, OxiPNG, JPEG XL), змінити розмір і палітру й одразу бачити, скільки кілобайтів зекономлено. Зручно, щоб показати команді, наскільки менше може важити головне зображення сторінки.', 'Squoosh compresses images right in the browser, without uploading them, and shows the original and result side by side with a slider. You can pick a codec (AVIF, WebP, MozJPEG, OxiPNG, JPEG XL), resize and reduce the palette and immediately see how many kilobytes are saved. Handy for showing a team how much lighter a page’s hero image could be.', 'Стиснення в браузері без завантаження на сервер
AVIF, WebP, MozJPEG, OxiPNG, JPEG XL
Порівняння до й після з повзунком
Зміна розміру й палітри', 'In-browser compression, no upload
AVIF, WebP, MozJPEG, OxiPNG, JPEG XL
Before/after slider comparison
Resize and palette reduction', 'Фронтенд-розробники й тестувальники, що контролюють розмір JavaScript-бандлів і швидкодію інтерфейсу', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'squoosh.app' OR LOWER(`name`) = 'squoosh') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free open-source in-browser image optimiser: compare AVIF, WebP, JPEG XL and MozJPEG with a quality slider.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Squoosh compresses images right in the browser, without uploading them, and shows the original and result side by side with a slider. You can pick a codec (AVIF, WebP, MozJPEG, OxiPNG, JPEG XL), resize and reduce the palette and immediately see how many kilobytes are saved. Handy for showing a team how much lighter a page’s hero image could be.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'In-browser compression, no upload
AVIF, WebP, MozJPEG, OxiPNG, JPEG XL
Before/after slider comparison
Resize and palette reduction', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- React Developer Tools — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'react.dev/learn/react-developer-tools' OR LOWER(`name`) = 'react developer tools')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'React Developer Tools', NULL, 'https://react.dev/learn/react-developer-tools', NULL, NULL, 'Офіційне розширення браузера для React: дерево компонентів, пропси, стан і профайлер повторних рендерів.', 'Official React browser extension: component tree, props, state and a re-render profiler.', 'React Developer Tools додає в DevTools вкладки Components і Profiler. Перша показує дерево компонентів, їхні пропси, стан і хуки, друга записує сесію й показує, які компоненти рендерилися, скільки часу це забрало й чому вони оновилися. Опція підсвічування рендерів допомагає швидко знайти зайві повторні рендери, що гальмують інтерфейс.', 'React Developer Tools adds Components and Profiler tabs to DevTools. The first shows the component tree with props, state and hooks; the second records a session and shows which components rendered, how long it took and why they updated. Highlighting renders helps quickly spot unnecessary re-renders that slow the UI down.', 'Дерево компонентів, пропси, стан, хуки
Profiler: час і причина кожного рендеру
Підсвічування повторних рендерів
Розширення для Chrome, Firefox, Edge', 'Component tree, props, state, hooks
Profiler: time and reason for each render
Re-render highlighting
Extension for Chrome, Firefox, Edge', 'Фронтенд-розробники й тестувальники, що контролюють розмір JavaScript-бандлів і швидкодію інтерфейсу', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'react.dev/learn/react-developer-tools' OR LOWER(`name`) = 'react developer tools') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Official React browser extension: component tree, props, state and a re-render profiler.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'React Developer Tools adds Components and Profiler tabs to DevTools. The first shows the component tree with props, state and hooks; the second records a session and shows which components rendered, how long it took and why they updated. Highlighting renders helps quickly spot unnecessary re-renders that slow the UI down.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Component tree, props, state, hooks
Profiler: time and reason for each render
Re-render highlighting
Extension for Chrome, Firefox, Edge', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Vue DevTools — Тестування, Веб-розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'devtools.vuejs.org' OR LOWER(`name`) = 'vue devtools')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Vue DevTools', NULL, 'https://devtools.vuejs.org', NULL, NULL, 'Офіційні інструменти розробника Vue: компоненти, стан Pinia, маршрути й таймлайн продуктивності рендерингу.', 'Official Vue developer tools: components, Pinia state, routes and a rendering performance timeline.', 'Vue DevTools доступні як розширення браузера, плагін Vite і окремий застосунок. Вони показують дерево компонентів і стан, сховища Pinia, маршрути, а таймлайн фіксує події, рендери й час їх виконання. Це допомагає знайти компоненти, що оновлюються зайвий раз або рендеряться надто довго.', 'Vue DevTools come as a browser extension, a Vite plugin and a standalone app. They show the component tree and state, Pinia stores and routes, and the timeline records events, renders and how long they took. This helps find components that update too often or render too slowly.', 'Дерево компонентів і стан
Сховища Pinia й маршрути
Таймлайн подій і рендерів
Розширення, плагін Vite, окремий застосунок', 'Component tree and state
Pinia stores and routes
Event and render timeline
Extension, Vite plugin, standalone app', 'Фронтенд-розробники й тестувальники, що контролюють розмір JavaScript-бандлів і швидкодію інтерфейсу', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'devtools.vuejs.org' OR LOWER(`name`) = 'vue devtools') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Official Vue developer tools: components, Pinia state, routes and a rendering performance timeline.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Vue DevTools come as a browser extension, a Vite plugin and a standalone app. They show the component tree and state, Pinia stores and routes, and the timeline records events, renders and how long they took. This helps find components that update too often or render too slowly.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Component tree and state
Pinia stores and routes
Event and render timeline
Extension, Vite plugin, standalone app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Front-end developers and testers keeping JavaScript bundle size and UI responsiveness under control', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Наявні продукти → «Веб-розробка»
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'Lighthouse' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'GTmetrix' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'Chrome DevTools' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'sitespeed.io' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'Sentry' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'web-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

