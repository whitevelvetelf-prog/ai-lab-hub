SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-19: «Подорожі та туризм» / «Travel & Tourism» (slug travel-tourism) — оренда житла, екскурсії, готельні програми.
-- + 6 нових продуктів і 0 прив'язок наявних (функцію звірено на офіційних сайтах 2026-11-19).
-- Якщо продукт із такою адресою чи назвою вже є — лише прив'язка, тексти не змінюються.
-- Тексти UA/EN — за офіційними сайтами, звірено 2026-11-19. Ціни вражень залежать від вибору — план «Ціна: див. сайт».
-- Пропущено: HomeToGo, TrustedHousesitters (сайти відмовили в доступі, 403); Musement перевірено, лишено в запасі.
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   Couchsurfing — vacation-rentals (новий)
--   Hipcamp — vacation-rentals (новий)
--   Headout — tours-activities (новий)
--   Civitatis — tours-activities (новий)
--   Fever — tours-activities (новий)
--   GHA DISCOVERY — hotel-loyalty (новий)
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'travel-tourism' LIMIT 1);

-- Couchsurfing
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'couchsurfing.com' OR LOWER(`name`) = 'couchsurfing')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Couchsurfing', NULL, 'https://www.couchsurfing.com', NULL, NULL, 'Спільнота мандрівників: зупинитися в місцевих жителів, знайти попутників і події в місті.', 'Travellers’ community: stay with locals, meet other travellers and find events in town.', 'Couchsurfing — спільнота, де місцеві жителі приймають мандрівників у себе вдома, а мандрівники знаходять господарів, інших подорожніх поруч і місцеві події. На сторінці міста видно погоду, господарів і мандрівників поблизу та зустрічі; є форуми спільноти й розділ перевірених господарів із відгуками інших учасників. Працює на сайті й у застосунку для iPhone та Android. Умови участі — на офіційному сайті.', 'Couchsurfing is a community where locals host travellers in their homes, and travellers find hosts, other travellers nearby and local events. A city page shows the weather, nearby hosts and travellers and meetups; there are community forums and a section of verified hosts with references from other members. Works on the website and in the iPhone and Android app. Membership terms are on the official website.', 'Пошук господарів у місцевих жителів
Мандрівники поруч і місцеві події
Перевірені господарі з відгуками
Форуми спільноти
Застосунок для iPhone та Android', 'Find local hosts
Nearby travellers and local events
Verified hosts with references
Community forums
iPhone and Android app', 'Мандрівникам, які шукають незвичне чи бюджетне житло й хочуть познайомитися з місцевими.', 'Travellers looking for unusual or budget stays who want to meet locals.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'couchsurfing.com' OR LOWER(`name`) = 'couchsurfing') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vacation-rentals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Travellers’ community: stay with locals, meet other travellers and find events in town.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Couchsurfing is a community where locals host travellers in their homes, and travellers find hosts, other travellers nearby and local events. A city page shows the weather, nearby hosts and travellers and meetups; there are community forums and a section of verified hosts with references from other members. Works on the website and in the iPhone and Android app. Membership terms are on the official website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Find local hosts
Nearby travellers and local events
Verified hosts with references
Community forums
iPhone and Android app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers looking for unusual or budget stays who want to meet locals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hipcamp
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hipcamp.com' OR LOWER(`name`) = 'hipcamp')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hipcamp', NULL, 'https://www.hipcamp.com', NULL, NULL, 'Пошук і бронювання кемпінгів і глемпінгу на приватній землі та в парках, планувальник подорожей.', 'Find and book campsites and glamping on private land and in parks, with a road trip planner.', 'Hipcamp — сервіс пошуку й бронювання місць для кемпінгу: на приватній землі, а також у національних, державних парках і лісах. Є планувальник автоподорожей, безкоштовні сповіщення, коли звільняється місце в заповненому кемпінгу, шари на карті й «гарантія погоди» — компенсація вартості поїздки, якщо йде дощ (за умовами сервісу). Власники землі й кемпінгів можуть розмістити свої місця. Працює на сайті й у застосунку.', 'Hipcamp is a service for finding and booking camping spots: on private land as well as in national and state parks and forests. It has a road trip planner, free alerts when a spot opens up at a sold-out campsite, map layers and a “weather guarantee” that reimburses the trip if it rains (under the service terms). Landowners and campground operators can list their sites. Works on the website and in the app.', 'Кемпінги на приватній землі й у парках
Планувальник автоподорожей
Сповіщення про вільні місця
Гарантія погоди
Розміщення власних місць', 'Campsites on private land and in parks
Road trip planner
Availability alerts
Weather guarantee
List your own sites', 'Туристам з наметом, автодомом чи фургоном і власникам землі, які хочуть приймати кемперів.', 'Tent, RV and van campers, and landowners who want to host campers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hipcamp.com' OR LOWER(`name`) = 'hipcamp') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vacation-rentals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Find and book campsites and glamping on private land and in parks, with a road trip planner.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hipcamp is a service for finding and booking camping spots: on private land as well as in national and state parks and forests. It has a road trip planner, free alerts when a spot opens up at a sold-out campsite, map layers and a “weather guarantee” that reimburses the trip if it rains (under the service terms). Landowners and campground operators can list their sites. Works on the website and in the app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Campsites on private land and in parks
Road trip planner
Availability alerts
Weather guarantee
List your own sites', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tent, RV and van campers, and landowners who want to host campers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Headout
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'headout.com' OR LOWER(`name`) = 'headout')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Headout', NULL, 'https://www.headout.com', NULL, NULL, 'Квитки до атракцій, музеїв і екскурсії в містах світу, бронювання навіть напередодні.', 'Tickets to attractions, museums and tours in cities worldwide, bookable even the night before.', 'Headout — сервіс бронювання квитків до атракцій, музеїв і екскурсій у містах світу (Париж, Рим, Дубай, Токіо та інші). Бронювати можна будь-коли, навіть напередодні; для більшості вражень є безкоштовне скасування й оплата пізніше, діє гарантія захисту бронювання й підтримка 24/7 кількома мовами. Ціна залежить від вибраного враження, перегляд безкоштовний. Компанія Headout Inc, Нью-Йорк.', 'Headout is a service for booking tickets to attractions, museums and tours in cities worldwide (Paris, Rome, Dubai, Tokyo and others). You can book any time, even the night before; most experiences offer free cancellation and pay-later options, with a booking protection guarantee and 24/7 support in several languages. The price depends on the experience; browsing is free. Company: Headout Inc, New York.', 'Квитки до атракцій і музеїв
Бронювання навіть напередодні
Безкоштовне скасування для більшості вражень
Підтримка 24/7
Гарантія бронювання', 'Tickets to attractions and museums
Book even the night before
Free cancellation on most experiences
24/7 support
Booking guarantee', 'Туристам, які хочуть заздалегідь купити квитки й екскурсії в місті, куди їдуть.', 'Tourists who want to book tickets and tours in advance for the city they are visiting.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'headout.com' OR LOWER(`name`) = 'headout') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tours-activities' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tickets to attractions, museums and tours in cities worldwide, bookable even the night before.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Headout is a service for booking tickets to attractions, museums and tours in cities worldwide (Paris, Rome, Dubai, Tokyo and others). You can book any time, even the night before; most experiences offer free cancellation and pay-later options, with a booking protection guarantee and 24/7 support in several languages. The price depends on the experience; browsing is free. Company: Headout Inc, New York.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tickets to attractions and museums
Book even the night before
Free cancellation on most experiences
24/7 support
Booking guarantee', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tourists who want to book tickets and tours in advance for the city they are visiting.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Civitatis
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'civitatis.com/en' OR LOWER(`name`) = 'civitatis')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Civitatis', NULL, 'https://www.civitatis.com/en/', NULL, NULL, 'Екскурсії з гідом, квитки й враження в містах світу; безкоштовне скасування для багатьох активностей.', 'Guided tours, tickets and experiences in cities worldwide; free cancellation on many activities.', 'Civitatis — каталог екскурсій з гідом, квитків і вражень у містах світу. На сторінці кожного міста — активності з оцінками й відгуками, ціни вказано в євро; є й безкоштовні піші екскурсії. Для багатьох активностей діє безкоштовне скасування, сервіс обіцяє ціни без прихованих комісій і підтримку 24/7. Є застосунок.', 'Civitatis is a catalogue of guided tours, tickets and experiences in cities worldwide. Each city page lists activities with ratings and reviews, priced in euros; free walking tours are included too. Many activities have free cancellation, the service promises no hidden fees and 24/7 customer service. There is an app.', 'Екскурсії з гідом і квитки
Безкоштовні піші екскурсії
Безкоштовне скасування для багатьох активностей
Без прихованих комісій
Підтримка 24/7', 'Guided tours and tickets
Free walking tours
Free cancellation on many activities
No hidden fees
24/7 customer service', 'Туристам, які хочуть заздалегідь купити квитки й екскурсії в місті, куди їдуть.', 'Tourists who want to book tickets and tours in advance for the city they are visiting.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'civitatis.com/en' OR LOWER(`name`) = 'civitatis') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tours-activities' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Guided tours, tickets and experiences in cities worldwide; free cancellation on many activities.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Civitatis is a catalogue of guided tours, tickets and experiences in cities worldwide. Each city page lists activities with ratings and reviews, priced in euros; free walking tours are included too. Many activities have free cancellation, the service promises no hidden fees and 24/7 customer service. There is an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Guided tours and tickets
Free walking tours
Free cancellation on many activities
No hidden fees
24/7 customer service', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tourists who want to book tickets and tours in advance for the city they are visiting.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Fever
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'feverup.com' OR LOWER(`name`) = 'fever')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fever', NULL, 'https://feverup.com', NULL, NULL, 'Квитки на події й враження в понад 200 містах: концерти Candlelight, імерсивні виставки, атракції.', 'Tickets to events and experiences in 200+ cities: Candlelight concerts, immersive exhibitions, attractions.', 'Fever — платформа квитків на місцеві події й враження в понад 200 містах більш як 30 країн: понад 150 000 вражень, серед них концерти при свічках Candlelight, музичні фестивалі, імерсивні виставки (зокрема Van Gogh Experience) і туристичні атракції. Підтримка 24/7 одинадцятьма мовами в чаті застосунку чи телефоном, є програма Fever Club і подарункові картки. Працює на сайті й у застосунках для iPhone та Android.', 'Fever is a ticketing platform for local events and experiences in over 200 cities in more than 30 countries: over 150,000 experiences, including Candlelight concerts, music festivals, immersive exhibitions (such as the Van Gogh Experience) and tourist attractions. 24/7 support in 11 languages via in-app chat or phone, plus Fever Club and gift cards. Works on the website and in the iPhone and Android apps.', 'Понад 200 міст і 30 країн
Концерти Candlelight
Імерсивні виставки й фестивалі
Підтримка 24/7 одинадцятьма мовами
Fever Club і подарункові картки', '200+ cities in 30+ countries
Candlelight concerts
Immersive exhibitions and festivals
24/7 support in 11 languages
Fever Club and gift cards', 'Тим, хто шукає концерти, виставки й незвичні події в місті — вдома чи в подорожі.', 'People looking for concerts, exhibitions and unusual events in their city — at home or travelling.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'feverup.com' OR LOWER(`name`) = 'fever') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tours-activities' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tickets to events and experiences in 200+ cities: Candlelight concerts, immersive exhibitions, attractions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Fever is a ticketing platform for local events and experiences in over 200 cities in more than 30 countries: over 150,000 experiences, including Candlelight concerts, music festivals, immersive exhibitions (such as the Van Gogh Experience) and tourist attractions. 24/7 support in 11 languages via in-app chat or phone, plus Fever Club and gift cards. Works on the website and in the iPhone and Android apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '200+ cities in 30+ countries
Candlelight concerts
Immersive exhibitions and festivals
24/7 support in 11 languages
Fever Club and gift cards', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People looking for concerts, exhibitions and unusual events in their city — at home or travelling.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- GHA DISCOVERY
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ghadiscovery.com' OR LOWER(`name`) = 'gha discovery')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GHA DISCOVERY', NULL, 'https://www.ghadiscovery.com', NULL, NULL, 'Безкоштовна програма лояльності Global Hotel Alliance: 60+ брендів, 1000 готелів, бонуси D$.', 'Free Global Hotel Alliance loyalty programme: 60+ brands, 1,000 hotels, D$ rewards.', 'GHA DISCOVERY — програма лояльності Global Hotel Alliance, що об''єднує понад 60 незалежних брендів: близько 1000 готелів у 100 країнах (Anantara, Kempinski, NH Hotels, Corinthia та інші) і понад 30 000 будинків для відпочинку. Участь безкоштовна. За проживання повертається до 7% у DISCOVERY Dollars (D$1 = USD 1), які можна витратити на номери, апгрейди, ресторани й спа. Учасники отримують знижку від 10% при прямому бронюванні. Статуси Silver, Gold, Platinum і Titanium присвоюються за ночі, витрати або кількість брендів, у яких ви зупинялися.', 'GHA DISCOVERY is the Global Hotel Alliance loyalty programme, bringing together 60+ independent brands: around 1,000 hotels in 100 countries (Anantara, Kempinski, NH Hotels, Corinthia and others) and 30,000+ vacation homes. Membership is free. Stays earn up to 7% back in DISCOVERY Dollars (D$1 = USD 1), which can be spent on rooms, upgrades, dining and spa. Members get 10% or more off when booking direct. Silver, Gold, Platinum and Titanium tiers are earned by nights, spend or the number of brands stayed with.', '60+ незалежних готельних брендів
До 7% назад у D$ (D$1 = USD 1)
Знижка від 10% для учасників
Статуси Silver – Titanium
Застосунок для iPhone та Android', '60+ independent hotel brands
Up to 7% back in D$ (D$1 = USD 1)
10%+ member discount
Silver to Titanium tiers
iPhone and Android app', 'Мандрівникам, які зупиняються в незалежних готелях і хочуть знижок, статусів і бонусів.', 'Travellers staying at independent hotels who want discounts, status and rewards.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ghadiscovery.com' OR LOWER(`name`) = 'gha discovery') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-loyalty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free Global Hotel Alliance loyalty programme: 60+ brands, 1,000 hotels, D$ rewards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'GHA DISCOVERY is the Global Hotel Alliance loyalty programme, bringing together 60+ independent brands: around 1,000 hotels in 100 countries (Anantara, Kempinski, NH Hotels, Corinthia and others) and 30,000+ vacation homes. Membership is free. Stays earn up to 7% back in DISCOVERY Dollars (D$1 = USD 1), which can be spent on rooms, upgrades, dining and spa. Members get 10% or more off when booking direct. Silver, Gold, Platinum and Titanium tiers are earned by nights, spend or the number of brands stayed with.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '60+ independent hotel brands
Up to 7% back in D$ (D$1 = USD 1)
10%+ member discount
Silver to Titanium tiers
iPhone and Android app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers staying at independent hotels who want discounts, status and rewards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Участь у програмі безкоштовна.', 'Membership is free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Membership is free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Прив'язки наявних продуктів (за назвою, без id)
