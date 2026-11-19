SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-19: «Українські додатки» / «Ukrainian Apps» (slug ukrainian-apps) — спорт, аграріям, книги.
-- + 11 нових продуктів і 1 прив'язок наявних (функцію звірено на офіційних сайтах 2026-11-19).
-- Якщо продукт із такою адресою чи назвою вже є — лише прив'язка, тексти не змінюються.
-- Тексти UA/EN — за офіційними сайтами, звірено 2026-11-19. Новинні сайти — план Free; книжки — «Ціна: див. сайт».
-- MEGOGO — прив'язка до «Спорт і вболівальникам» (спортивні трансляції: УПЛ, ліги УЄФА, Setanta Sports).
-- Пропущено: XSPORT (сайт 21+ з рекламою казино й рейтингом букмекерів), Sportarena, Agravery, Книгарня «Є» (403),
--   ФК «Динамо» Київ, «Сенс» (адреси не відкрилися).
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   УПЛ — Українська Прем'єр-ліга — ua-sport (новий)
--   Суспільне Спорт — ua-sport (новий)
--   Куркуль — ua-agro (новий)
--   Latifundist — ua-agro (новий)
--   SuperAgronom — ua-agro (новий)
--   AgroTimes — ua-agro (новий)
--   AgroPortal — ua-agro (новий)
--   Видавництво Старого Лева — ua-books (новий)
--   Vivat — ua-books (новий)
--   Лабораторія — ua-books (новий)
--   Видавництво «Ранок» — ua-books (новий)
--   MEGOGO — ua-sport (наявний, прив'язка)
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);

-- УПЛ — Українська Прем'єр-ліга
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'upl.ua' OR LOWER(`name`) = 'упл — українська прем''єр-ліга')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'УПЛ — Українська Прем''єр-ліга', NULL, 'https://upl.ua', NULL, NULL, 'Офіційний сайт Української Прем''єр-ліги: новини, турнірні таблиці УПЛ і УПЛ-2, календар, звіти й статистика.', 'Official Ukrainian Premier League website: news, UPL and UPL-2 tables, fixtures, match reports and stats.', 'Офіційний сайт Української Прем''єр-ліги (УПЛ) — головного футбольного чемпіонату України. Тут новини ліги, турнірні таблиці УПЛ і УПЛ-2, календар матчів, звіти та статистичні прев''ю, фотогалереї й список дискваліфікацій. З сайту є перехід на UPL.TV із трансляціями частини матчів. Мови — українська й англійська, читати безкоштовно.', 'The official website of the Ukrainian Premier League (UPL), the country’s top football championship. It has league news, UPL and UPL-2 tables, the match calendar, reports and statistical previews, photo galleries and the suspensions list. There is a link to UPL.TV with broadcasts of some matches. Available in Ukrainian and English, free to read.', 'Турнірні таблиці УПЛ і УПЛ-2
Календар матчів
Звіти й статистика
Дискваліфікації
Перехід на UPL.TV', 'UPL and UPL-2 tables
Match calendar
Reports and stats
Suspensions
Link to UPL.TV', 'Уболівальникам українського футболу й спорту в Україні та за кордоном.', 'Fans of Ukrainian football and sport in Ukraine and abroad.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'upl.ua' OR LOWER(`name`) = 'упл — українська прем''єр-ліга') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-sport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Official Ukrainian Premier League website: news, UPL and UPL-2 tables, fixtures, match reports and stats.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official website of the Ukrainian Premier League (UPL), the country’s top football championship. It has league news, UPL and UPL-2 tables, the match calendar, reports and statistical previews, photo galleries and the suspensions list. There is a link to UPL.TV with broadcasts of some matches. Available in Ukrainian and English, free to read.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'UPL and UPL-2 tables
Match calendar
Reports and stats
Suspensions
Link to UPL.TV', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Fans of Ukrainian football and sport in Ukraine and abroad.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Читати сайт безкоштовно.', 'Free to read.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free to read.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Суспільне Спорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'suspilne.media/sport' OR LOWER(`name`) = 'суспільне спорт')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Суспільне Спорт', NULL, 'https://suspilne.media/sport/', NULL, NULL, 'Спортивні новини Суспільного Мовлення: футбол, біатлон та інші види спорту, відео й ексклюзиви.', 'Sports news from Suspilne, Ukraine’s public broadcaster: football, biathlon and other sports, videos and exclusives.', 'Суспільне Спорт — спортивний розділ сайту Суспільного Мовлення, українського суспільного мовника. Новини за видами спорту (футбол, біатлон та інші), відео й ексклюзивні матеріали. Без платного доступу, українською мовою.', 'Suspilne Sport is the sports section of the website of Suspilne, Ukraine’s public broadcaster. It publishes news by sport (football, biathlon and more), videos and exclusive stories. No paywall, in Ukrainian.', 'Новини за видами спорту
Відео
Ексклюзивні матеріали
Біатлон і зимові види спорту
Без платного доступу', 'News by sport
Videos
Exclusive stories
Biathlon and winter sports
No paywall', 'Уболівальникам українського футболу й спорту в Україні та за кордоном.', 'Fans of Ukrainian football and sport in Ukraine and abroad.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'suspilne.media/sport' OR LOWER(`name`) = 'суспільне спорт') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-sport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sports news from Suspilne, Ukraine’s public broadcaster: football, biathlon and other sports, videos and exclusives.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Suspilne Sport is the sports section of the website of Suspilne, Ukraine’s public broadcaster. It publishes news by sport (football, biathlon and more), videos and exclusive stories. No paywall, in Ukrainian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'News by sport
Videos
Exclusive stories
Biathlon and winter sports
No paywall', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Fans of Ukrainian football and sport in Ukraine and abroad.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Читати сайт безкоштовно.', 'Free to read.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free to read.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Куркуль
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kurkul.com' OR LOWER(`name`) = 'куркуль')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Куркуль', NULL, 'https://kurkul.com', NULL, NULL, 'Онлайн-асистент фермера від Latifundist Media: агроновини, довідник компаній, порід, техніки й засобів захисту.', 'Farmer’s online assistant by Latifundist Media: agri news and a directory of companies, breeds, machinery and crop inputs.', 'Куркуль — «онлайн-асистент фермера» від Latifundist Media. Окрім новин, тут є довідник: досьє фермерів, каталог компаній-постачальників, породи тварин, марки техніки, добрива, насіння й засоби захисту рослин; інфографіка «АгроПогода України» та спецпроєкти. Сайт веде до пов''язаних сервісів — погоди, цін на зерно, агроаналітики, біржі сільгосптехніки й вакансій. Читати безкоштовно.', 'Kurkul is a “farmer’s online assistant” by Latifundist Media. Besides news it has a directory: farmer profiles, a supplier catalogue, animal breeds, machinery brands, fertilisers, seeds and crop protection products; the “AgroWeather of Ukraine” infographic and special projects. It links to related services for weather, grain prices, agri analytics, a machinery exchange and jobs. Free to read.', 'Агроновини
Довідник компаній і фермерів
Породи тварин і марки техніки
Добрива, насіння, ЗЗР
Агропогода', 'Agri news
Directory of companies and farmers
Animal breeds and machinery brands
Fertilisers, seeds, crop protection
Agri weather', 'Фермерам, агрономам, аграрному бізнесу й усім, хто стежить за агроринком України.', 'Farmers, agronomists, agribusiness and anyone following the Ukrainian agricultural market.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kurkul.com' OR LOWER(`name`) = 'куркуль') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-agro' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Farmer’s online assistant by Latifundist Media: agri news and a directory of companies, breeds, machinery and crop inputs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Kurkul is a “farmer’s online assistant” by Latifundist Media. Besides news it has a directory: farmer profiles, a supplier catalogue, animal breeds, machinery brands, fertilisers, seeds and crop protection products; the “AgroWeather of Ukraine” infographic and special projects. It links to related services for weather, grain prices, agri analytics, a machinery exchange and jobs. Free to read.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Agri news
Directory of companies and farmers
Animal breeds and machinery brands
Fertilisers, seeds, crop protection
Agri weather', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Farmers, agronomists, agribusiness and anyone following the Ukrainian agricultural market.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Читати сайт безкоштовно.', 'Free to read.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free to read.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Latifundist
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'latifundist.com' OR LOWER(`name`) = 'latifundist')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Latifundist', NULL, 'https://latifundist.com', NULL, NULL, 'Головний сайт про агробізнес: новини, огляди ринків, дані, рейтинг ТОП-100, календар подій і карта елеваторів.', 'Leading agribusiness website: news, market reviews, data, TOP-100 ranking, events calendar and elevator map.', 'Latifundist.com — видання Latifundist Media про аграрний бізнес. Новини, блоги, інтерв''ю й спецпроєкти, розділи «Дані» та «Огляд ринків», рейтинг агрокомпаній ТОП-100, календар галузевих подій, проєкт «Урожай» і карта елеваторів (за підпискою на пов''язаному сервісі). Українською й англійською, новини безкоштовні.', 'Latifundist.com is Latifundist Media’s publication about agribusiness. It has news, blogs, interviews and special projects, “Data” and “Market review” sections, the TOP-100 agri company ranking, an industry events calendar, the Harvest project and an elevator map (by subscription on a related service). In Ukrainian and English; news is free.', 'Новини агробізнесу
Огляди ринків і дані
Рейтинг ТОП-100
Календар подій
Карта елеваторів', 'Agribusiness news
Market reviews and data
TOP-100 ranking
Events calendar
Elevator map', 'Фермерам, агрономам, аграрному бізнесу й усім, хто стежить за агроринком України.', 'Farmers, agronomists, agribusiness and anyone following the Ukrainian agricultural market.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'latifundist.com' OR LOWER(`name`) = 'latifundist') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-agro' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Leading agribusiness website: news, market reviews, data, TOP-100 ranking, events calendar and elevator map.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Latifundist.com is Latifundist Media’s publication about agribusiness. It has news, blogs, interviews and special projects, “Data” and “Market review” sections, the TOP-100 agri company ranking, an industry events calendar, the Harvest project and an elevator map (by subscription on a related service). In Ukrainian and English; news is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Agribusiness news
Market reviews and data
TOP-100 ranking
Events calendar
Elevator map', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Farmers, agronomists, agribusiness and anyone following the Ukrainian agricultural market.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Читати сайт безкоштовно.', 'Free to read.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free to read.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SuperAgronom
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'superagronom.com' OR LOWER(`name`) = 'superagronom')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SuperAgronom', NULL, 'https://superagronom.com', NULL, NULL, 'Сайт для агрономів: новини про насіння, добрива, ЗЗР, техніку й технології, блоги та профілі агрономів.', 'Website for agronomists: news on seeds, fertilisers, crop protection, machinery and technology, blogs and profiles.', 'SuperAgronom.com — сайт для агрономів із мережі Latifundist Media. Новини за темами «Насіння», «Добрива», «ЗЗР», «Техніка», «Технології», «Посівна», «Урожай» і «Погода», блоги й статті, профілі агрономів, відео й тематичні проєкти, а також каталог добрив, насіння та засобів захисту рослин. Читати безкоштовно.', 'SuperAgronom.com is a website for agronomists from the Latifundist Media network. It has news on seeds, fertilisers, crop protection, machinery, technology, sowing, harvest and weather, blogs and articles, agronomist profiles, videos and themed projects, plus a catalogue of fertilisers, seeds and crop protection products. Free to read.', 'Новини за агротемами
Профілі агрономів
Блоги й відео
Каталог добрив, насіння, ЗЗР
Посівна й урожай', 'News by agronomy topic
Agronomist profiles
Blogs and videos
Catalogue of fertilisers, seeds, crop protection
Sowing and harvest', 'Фермерам, агрономам, аграрному бізнесу й усім, хто стежить за агроринком України.', 'Farmers, agronomists, agribusiness and anyone following the Ukrainian agricultural market.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'superagronom.com' OR LOWER(`name`) = 'superagronom') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-agro' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Website for agronomists: news on seeds, fertilisers, crop protection, machinery and technology, blogs and profiles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SuperAgronom.com is a website for agronomists from the Latifundist Media network. It has news on seeds, fertilisers, crop protection, machinery, technology, sowing, harvest and weather, blogs and articles, agronomist profiles, videos and themed projects, plus a catalogue of fertilisers, seeds and crop protection products. Free to read.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'News by agronomy topic
Agronomist profiles
Blogs and videos
Catalogue of fertilisers, seeds, crop protection
Sowing and harvest', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Farmers, agronomists, agribusiness and anyone following the Ukrainian agricultural market.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Читати сайт безкоштовно.', 'Free to read.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free to read.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AgroTimes
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'agrotimes.ua' OR LOWER(`name`) = 'agrotimes')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AgroTimes', NULL, 'https://agrotimes.ua', NULL, NULL, 'Агроновини України та світу від АГП Медіа: агрономія, техніка, елеватори, тваринництво, сад, журнали й конференції.', 'Ukrainian and world agri news by AGP Media: agronomy, machinery, elevators, livestock, horticulture, magazines and conferences.', 'AgroTimes — сайт агроновин від АГП Медіа. Розділи «Агромаркет», «Агрономія», «Техніка», «Елеватор», «Тваринництво», «Овочі-Ягоди-Сад», думки, інтерв''ю, фото й відео, а також галузеві конференції. Видавець випускає друковані журнали The Ukrainian Farmer, «Наше Птахівництво», «Садівництво по-українськи», «Плантатор» і газету «АгроМаркет» — їх можна передплатити. Новини безкоштовні.', 'AgroTimes is an agri news website by AGP Media. Sections cover the agri market, agronomy, machinery, elevators, livestock and fruit and vegetables, plus opinions, interviews, photo and video, and industry conferences. The publisher prints The Ukrainian Farmer, Nashe Ptakhivnytstvo, Sadivnytstvo po-ukrainsky and Plantator magazines and the AgroMarket newspaper, available by subscription. News is free.', 'Агроновини за галузями
Елеватори й тваринництво
Конференції
Друковані журнали за передплатою
Фото й відео', 'Agri news by sector
Elevators and livestock
Conferences
Print magazines by subscription
Photo and video', 'Фермерам, агрономам, аграрному бізнесу й усім, хто стежить за агроринком України.', 'Farmers, agronomists, agribusiness and anyone following the Ukrainian agricultural market.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'agrotimes.ua' OR LOWER(`name`) = 'agrotimes') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-agro' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ukrainian and world agri news by AGP Media: agronomy, machinery, elevators, livestock, horticulture, magazines and conferences.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'AgroTimes is an agri news website by AGP Media. Sections cover the agri market, agronomy, machinery, elevators, livestock and fruit and vegetables, plus opinions, interviews, photo and video, and industry conferences. The publisher prints The Ukrainian Farmer, Nashe Ptakhivnytstvo, Sadivnytstvo po-ukrainsky and Plantator magazines and the AgroMarket newspaper, available by subscription. News is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Agri news by sector
Elevators and livestock
Conferences
Print magazines by subscription
Photo and video', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Farmers, agronomists, agribusiness and anyone following the Ukrainian agricultural market.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Читати сайт безкоштовно.', 'Free to read.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free to read.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AgroPortal
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'agroportal.ua' OR LOWER(`name`) = 'agroportal')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AgroPortal', NULL, 'https://agroportal.ua', NULL, NULL, 'Аграрний сайт новин України: рослинництво, тваринництво, ринок зерна, бджільництво, аналітика й блоги.', 'Ukrainian agri news website: crops, livestock, grain market, beekeeping, analytics and blogs.', 'AgroPortal.ua — аграрний сайт новин України. Новини за темами (рослинництво, тваринництво, ринок зерна, бджільництво, сільгосптехніка, фінанси), аналітика, інтерв''ю, розслідування й блоги, мультимедіа, календар подій, проєкти «Неймовірні села» й «Клуб агроефективності». Українською, читати безкоштовно.', 'AgroPortal.ua is a Ukrainian agricultural news website. It covers crops, livestock, the grain market, beekeeping, farm machinery and finance, with analytics, interviews, investigations and blogs, multimedia, an events calendar and the “Incredible Villages” and “Agro-efficiency Club” projects. In Ukrainian, free to read.', 'Новини рослинництва й тваринництва
Ринок зерна
Бджільництво
Аналітика й розслідування
Календар подій', 'Crop and livestock news
Grain market
Beekeeping
Analytics and investigations
Events calendar', 'Фермерам, агрономам, аграрному бізнесу й усім, хто стежить за агроринком України.', 'Farmers, agronomists, agribusiness and anyone following the Ukrainian agricultural market.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'agroportal.ua' OR LOWER(`name`) = 'agroportal') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-agro' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ukrainian agri news website: crops, livestock, grain market, beekeeping, analytics and blogs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'AgroPortal.ua is a Ukrainian agricultural news website. It covers crops, livestock, the grain market, beekeeping, farm machinery and finance, with analytics, interviews, investigations and blogs, multimedia, an events calendar and the “Incredible Villages” and “Agro-efficiency Club” projects. In Ukrainian, free to read.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Crop and livestock news
Grain market
Beekeeping
Analytics and investigations
Events calendar', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Farmers, agronomists, agribusiness and anyone following the Ukrainian agricultural market.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Читати сайт безкоштовно.', 'Free to read.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free to read.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Видавництво Старого Лева
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'starylev.com.ua' OR LOWER(`name`) = 'видавництво старого лева')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Видавництво Старого Лева', NULL, 'https://starylev.com.ua', NULL, NULL, 'Українське видавництво й онлайн-книгарня: паперові та електронні книжки, набори, «Другий шанс» і сувеніри.', 'Ukrainian publisher and online bookshop: paper and e-books, sets, “Second Chance” books and souvenirs.', 'Видавництво Старого Лева — українське видавництво, яке продає власні книжки в онлайн-книгарні: паперові й електронні, набори, розділ «Другий шанс», сувеніри, а також друк на замовлення. Є оплата частинами через monobank і доставка Новою поштою. Сайт українською, є англійська версія.', 'Old Lion Publishing House is a Ukrainian publisher that sells its own books in an online bookshop: paper and e-books, sets, a “Second Chance” section, souvenirs and print-on-demand. Instalment payment via monobank and Nova Poshta delivery are available. The site is in Ukrainian with an English version.', 'Паперові й електронні книжки
Власні видання
Оплата частинами monobank
Доставка Новою поштою
Друк на замовлення', 'Paper and e-books
Own titles
monobank instalments
Nova Poshta delivery
Print-on-demand', 'Читачам, які купують українські книжки онлайн — паперові й електронні.', 'Readers buying Ukrainian books online — paper and e-books.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'starylev.com.ua' OR LOWER(`name`) = 'видавництво старого лева') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-books' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ukrainian publisher and online bookshop: paper and e-books, sets, “Second Chance” books and souvenirs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Old Lion Publishing House is a Ukrainian publisher that sells its own books in an online bookshop: paper and e-books, sets, a “Second Chance” section, souvenirs and print-on-demand. Instalment payment via monobank and Nova Poshta delivery are available. The site is in Ukrainian with an English version.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Paper and e-books
Own titles
monobank instalments
Nova Poshta delivery
Print-on-demand', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers buying Ukrainian books online — paper and e-books.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Vivat
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vivat.com.ua' OR LOWER(`name`) = 'vivat')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Vivat', NULL, 'https://vivat.com.ua', NULL, NULL, 'Книжковий інтернет-магазин видавництва Vivat: книжки, електронні книги, передзамовлення, мерч.', 'Online bookshop of Vivat publishing house: books, e-books, pre-orders and merch.', 'Vivat — українське видавництво з власним книжковим інтернет-магазином. На сайті — книжки видавництва Vivat та інших видавців із цінами в гривнях, розділ електронних книг, передзамовлення новинок, мерч, сторінки авторів і серій. Сайт українською.', 'Vivat is a Ukrainian publishing house with its own online bookshop. The site sells Vivat titles and books from other publishers with prices in hryvnias, an e-book section, pre-orders of new releases, merch, and author and series pages. The site is in Ukrainian.', 'Книжки Vivat та інших видавців
Електронні книги
Передзамовлення новинок
Мерч
Сторінки авторів і серій', 'Vivat and other publishers’ books
E-books
Pre-orders
Merch
Author and series pages', 'Читачам, які купують українські книжки онлайн — паперові й електронні.', 'Readers buying Ukrainian books online — paper and e-books.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vivat.com.ua' OR LOWER(`name`) = 'vivat') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-books' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Online bookshop of Vivat publishing house: books, e-books, pre-orders and merch.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Vivat is a Ukrainian publishing house with its own online bookshop. The site sells Vivat titles and books from other publishers with prices in hryvnias, an e-book section, pre-orders of new releases, merch, and author and series pages. The site is in Ukrainian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Vivat and other publishers’ books
E-books
Pre-orders
Merch
Author and series pages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers buying Ukrainian books online — paper and e-books.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Лабораторія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'laboratory.ua' OR LOWER(`name`) = 'лабораторія')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Лабораторія', NULL, 'https://laboratory.ua', NULL, NULL, 'Видавництво й інтернет-книгарня «Лабораторія»: книжки різних видавців, бонуси до 15%, доставка й застосунок Librarius.', 'Laboratory publisher and online bookshop: books from many publishers, up to 15% bonuses, delivery and the Librarius app.', '«Лабораторія» — українське видавництво з інтернет-книгарнею. Продає власні книжки та видання інших видавців (Старого Лева, Vivat, Osnovy та інших), нараховує бонуси до 15% за правилами спільноти, доставляє Новою поштою й Укрпоштою, а також за кордон. Для аудіо- та електронних книжок є застосунок Librarius. Приймає рукописи авторів. Сайт українською.', 'Laboratory is a Ukrainian publisher with an online bookshop. It sells its own books and titles from other publishers (Old Lion, Vivat, Osnovy and others), gives up to 15% bonuses under its community rules, and delivers by Nova Poshta, Ukrposhta and abroad. Audio and e-books are in the Librarius app. It accepts manuscripts. The site is in Ukrainian.', 'Власні книжки й інших видавців
Бонуси до 15%
Доставка по Україні й за кордон
Аудіо й е-книжки в Librarius
Прийом рукописів', 'Own and other publishers’ books
Up to 15% bonuses
Delivery in Ukraine and abroad
Audio and e-books in Librarius
Manuscript submissions', 'Читачам, які купують українські книжки онлайн — паперові й електронні.', 'Readers buying Ukrainian books online — paper and e-books.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'laboratory.ua' OR LOWER(`name`) = 'лабораторія') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-books' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Laboratory publisher and online bookshop: books from many publishers, up to 15% bonuses, delivery and the Librarius app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Laboratory is a Ukrainian publisher with an online bookshop. It sells its own books and titles from other publishers (Old Lion, Vivat, Osnovy and others), gives up to 15% bonuses under its community rules, and delivers by Nova Poshta, Ukrposhta and abroad. Audio and e-books are in the Librarius app. It accepts manuscripts. The site is in Ukrainian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Own and other publishers’ books
Up to 15% bonuses
Delivery in Ukraine and abroad
Audio and e-books in Librarius
Manuscript submissions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers buying Ukrainian books online — paper and e-books.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Видавництво «Ранок»
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ranok.com.ua' OR LOWER(`name`) = 'видавництво «ранок»')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Видавництво «Ранок»', NULL, 'https://ranok.com.ua', NULL, NULL, 'Видавництво «Ранок»: дитячі й навчальні книжки, підготовка до НМТ, електронні версії, доставка по Україні й за кордон.', 'Ranok publishing house: children’s and educational books, NMT exam prep, e-versions, delivery in Ukraine and abroad.', 'Видавництво «Ранок» — українське видавництво з інтернет-магазином: власні книжки (серед них дитячі й навчальні, посібники для підготовки до НМТ) і видання партнерів, електронні версії книжок. Доставка Новою поштою, Укрпоштою, Міст пошта, а також за кордон. Автори можуть подати рукопис. Сайт українською.', 'Ranok is a Ukrainian publishing house with an online shop: its own books (including children’s and educational titles and NMT exam prep guides), partner titles and e-versions. Delivery by Nova Poshta, Ukrposhta, Meest and abroad. Authors can submit a manuscript. The site is in Ukrainian.', 'Власні книжки й посібники
Підготовка до НМТ
Електронні версії
Доставка по Україні й за кордон
Прийом рукописів', 'Own books and guides
NMT exam prep
E-versions
Delivery in Ukraine and abroad
Manuscript submissions', 'Читачам, які купують українські книжки онлайн — паперові й електронні.', 'Readers buying Ukrainian books online — paper and e-books.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ranok.com.ua' OR LOWER(`name`) = 'видавництво «ранок»') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-books' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ranok publishing house: children’s and educational books, NMT exam prep, e-versions, delivery in Ukraine and abroad.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ranok is a Ukrainian publishing house with an online shop: its own books (including children’s and educational titles and NMT exam prep guides), partner titles and e-versions. Delivery by Nova Poshta, Ukrposhta, Meest and abroad. Authors can submit a manuscript. The site is in Ukrainian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Own books and guides
NMT exam prep
E-versions
Delivery in Ukraine and abroad
Manuscript submissions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers buying Ukrainian books online — paper and e-books.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Прив'язки наявних продуктів (за назвою, без id)
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'megogo' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-sport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
