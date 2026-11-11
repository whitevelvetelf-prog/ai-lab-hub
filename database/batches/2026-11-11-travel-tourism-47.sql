SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-11: нова категорія «Подорожі та туризм» / «Travel & Tourism» (slug travel-tourism) з підкатегоріями:
--   hotel-booking — Бронювання готелів
--   vacation-rentals — Апартаменти, хостели й оренда житла
--   hotel-loyalty — Готельні мережі та бонусні програми
--   flights — Авіаквитки та відстеження рейсів
--   ground-transport — Потяги, автобуси й оренда авто
--   tours-activities — Екскурсії та квитки до атракцій
--   trip-planners — АІ-планувальники подорожей
-- 47 нових продуктів + прив’язка наявних: KAYAK, Hopper, Tripadvisor, Mindtrip, Layla, Wonderplan, iplan.ai, Wanderlog, TripIt, GuideGeek, Roadtrippers, Укрзалізниця, proizd.ua, BlaBlaCar.
-- Тексти UA/EN — за описами в App Store (iTunes lookup, 11.11.2026) і офіційними сайтами; з каталогів конкурентів — лише назви.
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою. Повторний запуск безпечний.
-- Застосування: phpMyAdmin → gu621051_ailabhublive → «Импорт» (або вкладка SQL) → цей файл → «Вперёд».
--   Booking.com — Бронювання готелів, Апартаменти, хостели й оренда житла
--   Expedia — Бронювання готелів, Авіаквитки та відстеження рейсів, Потяги, автобуси й оренда авто
--   Hotels.com — Бронювання готелів
--   Agoda — Бронювання готелів, Апартаменти, хостели й оренда житла, Авіаквитки та відстеження рейсів
--   Trip.com — Бронювання готелів, Авіаквитки та відстеження рейсів, Потяги, автобуси й оренда авто
--   trivago — Бронювання готелів
--   Priceline — Бронювання готелів, Авіаквитки та відстеження рейсів, Потяги, автобуси й оренда авто
--   HotelTonight — Бронювання готелів
--   momondo — Бронювання готелів, Авіаквитки та відстеження рейсів, Потяги, автобуси й оренда авто
--   lastminute.com — Бронювання готелів, Авіаквитки та відстеження рейсів
--   Traveloka — Бронювання готелів, Авіаквитки та відстеження рейсів, Екскурсії та квитки до атракцій
--   Tablet Hotels — Бронювання готелів
--   Mr & Mrs Smith — Бронювання готелів
--   Hotels24.ua — Бронювання готелів
--   Google Hotels — Бронювання готелів
--   Skyscanner — Авіаквитки та відстеження рейсів, Бронювання готелів, Потяги, автобуси й оренда авто
--   Airbnb — Апартаменти, хостели й оренда житла, Екскурсії та квитки до атракцій
--   Vrbo — Апартаменти, хостели й оренда житла
--   Hostelworld — Апартаменти, хостели й оренда житла
--   HomeExchange — Апартаменти, хостели й оренда житла
--   Holidu — Апартаменти, хостели й оренда житла
--   Marriott Bonvoy — Готельні мережі та бонусні програми, Бронювання готелів
--   Hilton Honors — Готельні мережі та бонусні програми, Бронювання готелів
--   IHG One Rewards — Готельні мережі та бонусні програми, Бронювання готелів
--   World of Hyatt — Готельні мережі та бонусні програми, Бронювання готелів
--   ALL Accor — Готельні мережі та бонусні програми, Бронювання готелів
--   Radisson Hotels — Готельні мережі та бонусні програми, Бронювання готелів
--   Wyndham Hotels & Resorts — Готельні мережі та бонусні програми, Бронювання готелів
--   Best Western — Готельні мережі та бонусні програми, Бронювання готелів
--   Choice Hotels — Готельні мережі та бонусні програми, Бронювання готелів
--   Google Flights — Авіаквитки та відстеження рейсів
--   Kiwi.com — Авіаквитки та відстеження рейсів, Потяги, автобуси й оренда авто
--   eDreams — Авіаквитки та відстеження рейсів, Бронювання готелів
--   Flighty — Авіаквитки та відстеження рейсів
--   Flightradar24 — Авіаквитки та відстеження рейсів
--   Omio — Потяги, автобуси й оренда авто, Авіаквитки та відстеження рейсів
--   Trainline — Потяги, автобуси й оренда авто
--   FlixBus — Потяги, автобуси й оренда авто
--   Rentalcars.com — Потяги, автобуси й оренда авто
--   Discover Cars — Потяги, автобуси й оренда авто
--   INFOBUS — Потяги, автобуси й оренда авто, Авіаквитки та відстеження рейсів
--   GetYourGuide — Екскурсії та квитки до атракцій
--   Viator — Екскурсії та квитки до атракцій
--   Klook — Екскурсії та квитки до атракцій, Бронювання готелів
--   Tiqets — Екскурсії та квитки до атракцій
--   Trip Planner AI — АІ-планувальники подорожей
--   Tripsy — АІ-планувальники подорожей
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
INSERT INTO `categories` (`name`, `name_en`, `slug`) SELECT 'Подорожі та туризм', 'Travel & Tourism', 'travel-tourism' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `categories` WHERE `slug` = 'travel-tourism');
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'travel-tourism' LIMIT 1);
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Бронювання готелів', 'Hotel booking', 'hotel-booking' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Апартаменти, хостели й оренда житла', 'Vacation rentals & hostels', 'vacation-rentals' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vacation-rentals');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Готельні мережі та бонусні програми', 'Hotel chains & loyalty', 'hotel-loyalty' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-loyalty');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Авіаквитки та відстеження рейсів', 'Flights & flight tracking', 'flights' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'flights');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Потяги, автобуси й оренда авто', 'Trains, buses & car rental', 'ground-transport' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ground-transport');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Екскурсії та квитки до атракцій', 'Tours & attractions', 'tours-activities' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tours-activities');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'АІ-планувальники подорожей', 'AI trip planners', 'trip-planners' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'trip-planners');

-- Booking.com — Бронювання готелів, Апартаменти, хостели й оренда житла
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'booking.com' OR LOWER(`name`) = 'booking.com')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Booking.com', NULL, 'https://www.booking.com/', NULL, NULL, 'Сервіс бронювання готелів, апартаментів і будинків для відпочинку по всьому світу.', 'Worldwide booking service for hotels, apartments and holiday homes.', 'Booking.com дає змогу шукати й бронювати готелі, мотелі, апартаменти та будинки для відпочинку в будь-якій країні. За даними розробника, у застосунку понад 27 мільйонів варіантів житла. Пошук працює за містом, пам’яткою чи назвою готелю, результати фільтруються за ціною, оцінкою гостей і зручностями; застосунок має український інтерфейс.', 'Booking.com lets you search and book hotels, motels, apartments and holiday homes in any country. According to the developer, the app lists over 27 million places to stay. Search works by city, landmark or hotel name, and results can be filtered by price, guest review score and amenities; the app has a Ukrainian interface.', 'Пошук за містом, пам’яткою чи назвою готелю
Фільтри за ціною, оцінкою й зручностями
Бронювання в останню хвилину
Відгуки гостей
Український інтерфейс', 'Search by city, landmark or hotel name
Filters by price, score and amenities
Last-minute bookings
Guest reviews
Ukrainian interface', 'Користувачі, які шукають і бронюють житло для відпустки, відрядження чи поїздки на вихідні', 'Travellers looking for and booking accommodation for holidays, business trips or weekend getaways', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'booking.com' OR LOWER(`name`) = 'booking.com') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vacation-rentals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Worldwide booking service for hotels, apartments and holiday homes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Booking.com lets you search and book hotels, motels, apartments and holiday homes in any country. According to the developer, the app lists over 27 million places to stay. Search works by city, landmark or hotel name, and results can be filtered by price, guest review score and amenities; the app has a Ukrainian interface.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Search by city, landmark or hotel name
Filters by price, score and amenities
Last-minute bookings
Guest reviews
Ukrainian interface', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers looking for and booking accommodation for holidays, business trips or weekend getaways', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Expedia — Бронювання готелів, Авіаквитки та відстеження рейсів, Потяги, автобуси й оренда авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'expedia.com' OR LOWER(`name`) = 'expedia')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Expedia', NULL, 'https://www.expedia.com/', NULL, NULL, 'Бронювання готелів, авіаквитків, оренди авто, розваг і пакетних турів в одному застосунку.', 'Book hotels, flights, car hire, activities and package holidays in one app.', 'Expedia об’єднує в одному застосунку готелі, авіаквитки, оренду авто, розваги й пакетні тури. Безкоштовна програма лояльності Expedia One Key відкриває ціни для учасників, а відстеження цін на авіаквитки надсилає сповіщення про зміну вартості. Якщо додати готель до перельоту, пакет виходить дешевшим.', 'Expedia brings hotels, flights, car hire, activities and package holidays into one app. The free Expedia One Key loyalty programme unlocks member prices, and price tracking sends alerts when flight prices change. Adding a hotel to a flight makes the package cheaper.', 'Готелі, перельоти, авто й розваги в одному місці
Ціни для учасників Expedia One Key
Відстеження цін на авіаквитки
Пакети «переліт + готель»
Розумні фільтри', 'Hotels, flights, cars and activities in one place
Expedia One Key member prices
Flight price tracking
Flight + hotel packages
Smart filters', 'Користувачі, які шукають і бронюють житло для відпустки, відрядження чи поїздки на вихідні', 'Travellers looking for and booking accommodation for holidays, business trips or weekend getaways', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'expedia.com' OR LOWER(`name`) = 'expedia') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'flights' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ground-transport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Book hotels, flights, car hire, activities and package holidays in one app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Expedia brings hotels, flights, car hire, activities and package holidays into one app. The free Expedia One Key loyalty programme unlocks member prices, and price tracking sends alerts when flight prices change. Adding a hotel to a flight makes the package cheaper.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hotels, flights, cars and activities in one place
Expedia One Key member prices
Flight price tracking
Flight + hotel packages
Smart filters', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers looking for and booking accommodation for holidays, business trips or weekend getaways', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hotels.com — Бронювання готелів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hotels.com' OR LOWER(`name`) = 'hotels.com')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hotels.com', NULL, 'https://www.hotels.com/', NULL, NULL, 'Застосунок для пошуку й бронювання готелів із винагородами за кожну ніч.', 'Hotel search and booking app with rewards for every night stayed.', 'Hotels.com спеціалізується на бронюванні готелів — від бюджетних B&B до курортів і люксових готелів; за даними розробника, у каталозі понад 500 тисяч об’єктів. Учасники безкоштовної програми лояльності отримують ціни для учасників і накопичують винагороди Hotels.com Cash за ночі. Готелі можна порівнювати поруч і отримувати сповіщення про зміну цін.', 'Hotels.com focuses on hotel bookings, from budget B&Bs to resorts and luxury hotels; the developer cites over 500,000 properties. Members of the free loyalty programme get member prices and earn Hotels.com Cash rewards for nights stayed. Hotels can be compared side by side, with price change alerts.', 'Понад 500 тисяч готелів
Ціни для учасників
Винагороди Hotels.com Cash
Порівняння готелів поруч
Сповіщення про ціни', 'Over 500,000 properties
Member prices
Hotels.com Cash rewards
Side-by-side comparison
Price alerts', 'Користувачі, які шукають і бронюють житло для відпустки, відрядження чи поїздки на вихідні', 'Travellers looking for and booking accommodation for holidays, business trips or weekend getaways', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hotels.com' OR LOWER(`name`) = 'hotels.com') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Hotel search and booking app with rewards for every night stayed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hotels.com focuses on hotel bookings, from budget B&Bs to resorts and luxury hotels; the developer cites over 500,000 properties. Members of the free loyalty programme get member prices and earn Hotels.com Cash rewards for nights stayed. Hotels can be compared side by side, with price change alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Over 500,000 properties
Member prices
Hotels.com Cash rewards
Side-by-side comparison
Price alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers looking for and booking accommodation for holidays, business trips or weekend getaways', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Agoda — Бронювання готелів, Апартаменти, хостели й оренда житла, Авіаквитки та відстеження рейсів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'agoda.com' OR LOWER(`name`) = 'agoda')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Agoda', NULL, 'https://www.agoda.com/', NULL, NULL, 'Бронювання готелів, вілл, апартаментів і авіаквитків, сильний вибір в Азії.', 'Book hotels, villas, apartments and flights, with a strong selection in Asia.', 'Agoda — платформа бронювання житла й авіаквитків. За даними розробника, доступно понад 6 мільйонів варіантів проживання (готелі, курорти, вілли, будинки, B&B) і рейси близько 400 авіакомпаній. Пошук порівнює ціни на перельоти майже в реальному часі; застосунок має український інтерфейс.', 'Agoda is a platform for booking accommodation and flights. According to the developer, it offers over 6 million places to stay (hotels, resorts, villas, homes, B&Bs) and flights from around 400 airlines. Flight search compares prices in near real time; the app has a Ukrainian interface.', 'Понад 6 млн варіантів житла
Авіаквитки близько 400 авіакомпаній
Вілли й апартаменти
Порівняння цін на рейси
Український інтерфейс', 'Over 6 million properties
Flights from around 400 airlines
Villas and apartments
Flight price comparison
Ukrainian interface', 'Користувачі, які шукають і бронюють житло для відпустки, відрядження чи поїздки на вихідні', 'Travellers looking for and booking accommodation for holidays, business trips or weekend getaways', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'agoda.com' OR LOWER(`name`) = 'agoda') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vacation-rentals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'flights' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Book hotels, villas, apartments and flights, with a strong selection in Asia.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Agoda is a platform for booking accommodation and flights. According to the developer, it offers over 6 million places to stay (hotels, resorts, villas, homes, B&Bs) and flights from around 400 airlines. Flight search compares prices in near real time; the app has a Ukrainian interface.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Over 6 million properties
Flights from around 400 airlines
Villas and apartments
Flight price comparison
Ukrainian interface', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers looking for and booking accommodation for holidays, business trips or weekend getaways', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Trip.com — Бронювання готелів, Авіаквитки та відстеження рейсів, Потяги, автобуси й оренда авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trip.com' OR LOWER(`name`) = 'trip.com')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Trip.com', NULL, 'https://www.trip.com/', NULL, NULL, 'Бронювання готелів, авіаквитків і квитків на потяги з підтримкою 24/7.', 'Book hotels, flights and train tickets with 24/7 support.', 'Trip.com — туристичний сервіс для бронювання готелів, авіаквитків, квитків на потяги в Європі та Азії й інших послуг. Застосунок підтримує 24 мови, зокрема українську, має цілодобову службу підтримки та програму лояльності з бонусами Trip Coins.', 'Trip.com is a travel service for booking hotels, flights, train tickets in Europe and Asia and other services. The app supports 24 languages including Ukrainian, offers 24/7 customer support and a loyalty programme with Trip Coins rewards.', 'Готелі, рейси й потяги
Підтримка 24/7
24 мови, зокрема українська
Бонуси Trip Coins
Квитки на потяги в Європі та Азії', 'Hotels, flights and trains
24/7 support
24 languages incl. Ukrainian
Trip Coins rewards
Train tickets in Europe and Asia', 'Користувачі, які шукають і бронюють житло для відпустки, відрядження чи поїздки на вихідні', 'Travellers looking for and booking accommodation for holidays, business trips or weekend getaways', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trip.com' OR LOWER(`name`) = 'trip.com') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'flights' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ground-transport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Book hotels, flights and train tickets with 24/7 support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Trip.com is a travel service for booking hotels, flights, train tickets in Europe and Asia and other services. The app supports 24 languages including Ukrainian, offers 24/7 customer support and a loyalty programme with Trip Coins rewards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hotels, flights and trains
24/7 support
24 languages incl. Ukrainian
Trip Coins rewards
Train tickets in Europe and Asia', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers looking for and booking accommodation for holidays, business trips or weekend getaways', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- trivago — Бронювання готелів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trivago.com' OR LOWER(`name`) = 'trivago')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'trivago', NULL, 'https://www.trivago.com/', NULL, NULL, 'Метапошук готелів: порівнює ціни з багатьох сайтів бронювання за один пошук.', 'Hotel metasearch: compares prices from many booking sites in one search.', 'trivago не продає номери сам, а порівнює ціни на той самий готель із різних сайтів бронювання й веде на обрану пропозицію. Можна зберегти улюблені готелі, порівняти їх поруч, отримувати сповіщення про зниження ціни й читати зведені відгуки з кількох джерел. Фільтри враховують, наприклад, тварин, пізній виїзд, безкоштовне скасування чи сніданок.', 'trivago does not sell rooms itself; it compares prices for the same hotel across booking sites and sends you to the chosen offer. You can save favourite hotels, compare them side by side, get price drop alerts and read aggregated reviews from several sources. Filters cover pets, late checkout, free cancellation, breakfast and more.', 'Порівняння цін із багатьох сайтів
Сповіщення про зниження ціни
Зведені відгуки
Порівняння готелів поруч
Фільтр безкоштовного скасування', 'Price comparison across many sites
Price drop alerts
Aggregated reviews
Side-by-side comparison
Free cancellation filter', 'Ті, хто хоче знайти найвигіднішу ціну на конкретний готель перед бронюванням', 'People who want the best price for a specific hotel before booking', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trivago.com' OR LOWER(`name`) = 'trivago') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Hotel metasearch: compares prices from many booking sites in one search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'trivago does not sell rooms itself; it compares prices for the same hotel across booking sites and sends you to the chosen offer. You can save favourite hotels, compare them side by side, get price drop alerts and read aggregated reviews from several sources. Filters cover pets, late checkout, free cancellation, breakfast and more.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Price comparison across many sites
Price drop alerts
Aggregated reviews
Side-by-side comparison
Free cancellation filter', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want the best price for a specific hotel before booking', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Priceline — Бронювання готелів, Авіаквитки та відстеження рейсів, Потяги, автобуси й оренда авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'priceline.com' OR LOWER(`name`) = 'priceline')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Priceline', NULL, 'https://www.priceline.com/', NULL, NULL, 'Американський сервіс знижок на готелі, оренду авто й авіаквитки.', 'US deals service for hotels, car rentals and flights.', 'Priceline (входить до Booking Holdings) пропонує готелі, оренду авто й авіаквитки зі знижками, зокрема ціни лише в застосунку. Програма Priceline VIP за кількість бронювань відкриває додаткові знижки на готелі. Сервіс орієнтований насамперед на поїздки США.', 'Priceline (part of Booking Holdings) offers discounted hotels, car rentals and flights, including app-only deals. The Priceline VIP programme unlocks extra hotel discounts as you book more. The service mainly targets US travel.', 'Знижки лише в застосунку
Програма Priceline VIP
Готелі, авто й рейси
Частина Booking Holdings', 'App-only deals
Priceline VIP programme
Hotels, cars and flights
Part of Booking Holdings', 'Мандрівники, які планують поїздки до США й шукають знижки', 'Travellers planning US trips and looking for deals', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'priceline.com' OR LOWER(`name`) = 'priceline') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'flights' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ground-transport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'US deals service for hotels, car rentals and flights.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Priceline (part of Booking Holdings) offers discounted hotels, car rentals and flights, including app-only deals. The Priceline VIP programme unlocks extra hotel discounts as you book more. The service mainly targets US travel.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'App-only deals
Priceline VIP programme
Hotels, cars and flights
Part of Booking Holdings', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers planning US trips and looking for deals', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- HotelTonight — Бронювання готелів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hoteltonight.com' OR LOWER(`name`) = 'hoteltonight')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HotelTonight', NULL, 'https://www.hoteltonight.com/', NULL, NULL, 'Бронювання готелів в останню хвилину зі знижками за кілька дотиків.', 'Last-minute hotel bookings with discounts in a few taps.', 'HotelTonight (належить Airbnb) спеціалізується на бронюванні готелів в останню хвилину й наперед. Розробник обіцяє бронювання за кілька дотиків, щоденну пропозицію Daily Drop зі знижкою та рівні учасника, що відкривають додаткові знижки. Готелі відбирає команда сервісу.', 'HotelTonight (owned by Airbnb) specialises in last-minute and advance hotel bookings. The developer promises booking in a few taps, a discounted Daily Drop deal and member levels that unlock extra discounts. Hotels are curated by the team.', 'Бронювання в останню хвилину
Щоденна знижка Daily Drop
Рівні учасника зі знижками
Відібрані готелі', 'Last-minute bookings
Daily Drop deal
Member levels with discounts
Curated hotels', 'Ті, хто шукає готель на сьогодні чи найближчі дні', 'People looking for a hotel tonight or in the next few days', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hoteltonight.com' OR LOWER(`name`) = 'hoteltonight') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Last-minute hotel bookings with discounts in a few taps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'HotelTonight (owned by Airbnb) specialises in last-minute and advance hotel bookings. The developer promises booking in a few taps, a discounted Daily Drop deal and member levels that unlock extra discounts. Hotels are curated by the team.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Last-minute bookings
Daily Drop deal
Member levels with discounts
Curated hotels', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People looking for a hotel tonight or in the next few days', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- momondo — Бронювання готелів, Авіаквитки та відстеження рейсів, Потяги, автобуси й оренда авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'momondo.com' OR LOWER(`name`) = 'momondo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'momondo', NULL, 'https://www.momondo.com/', NULL, NULL, 'Метапошук авіаквитків, готелів і оренди авто з сотень сайтів.', 'Metasearch for flights, hotels and car hire across hundreds of sites.', 'momondo (компанія KAYAK) шукає перельоти, готелі й оренду авто на сотнях туристичних сайтів і показує варіанти разом. Можна встановити сповіщення про зниження ціни, бюджет, фільтр безкоштовного скасування й зібрати маршрут подорожі; окремі готелі дають ціни лише в застосунку. Є український інтерфейс.', 'momondo (a KAYAK company) searches flights, hotels and car hire across hundreds of travel sites and shows the options together. You can set price alerts, a budget, a free-cancellation filter and build an itinerary; some hotels offer app-only rates. A Ukrainian interface is available.', 'Пошук на сотнях сайтів
Сповіщення про ціни
Фільтр безкоштовного скасування
Маршрут подорожі
Український інтерфейс', 'Search across hundreds of sites
Price alerts
Free cancellation filter
Trip itinerary
Ukrainian interface', 'Мандрівники, які порівнюють ціни на перельоти й готелі перед покупкою', 'Travellers comparing flight and hotel prices before buying', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'momondo.com' OR LOWER(`name`) = 'momondo') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'flights' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ground-transport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Metasearch for flights, hotels and car hire across hundreds of sites.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'momondo (a KAYAK company) searches flights, hotels and car hire across hundreds of travel sites and shows the options together. You can set price alerts, a budget, a free-cancellation filter and build an itinerary; some hotels offer app-only rates. A Ukrainian interface is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Search across hundreds of sites
Price alerts
Free cancellation filter
Trip itinerary
Ukrainian interface', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers comparing flight and hotel prices before buying', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- lastminute.com — Бронювання готелів, Авіаквитки та відстеження рейсів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lastminute.com' OR LOWER(`name`) = 'lastminute.com')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'lastminute.com', NULL, 'https://www.lastminute.com/', NULL, NULL, 'Європейський сервіс пакетних турів, готелів і перельотів у останню хвилину.', 'European service for last-minute package holidays, hotels and flights.', 'lastminute.com — європейський сервіс для бронювання пакетних турів (переліт + готель), окремих готелів і перельотів. Застосунок супроводжує поїздку від бронювання до повернення додому: усі деталі подорожі зібрані в одному місці.', 'lastminute.com is a European service for booking package holidays (flight + hotel), hotels and flights. The app accompanies the trip from booking to returning home, keeping all travel details in one place.', 'Пакети «переліт + готель»
Готелі й перельоти
Пропозиції в останню хвилину
Деталі поїздки в одному місці', 'Flight + hotel packages
Hotels and flights
Last-minute deals
Trip details in one place', 'Ті, хто спонтанно планує відпустку в Європі', 'People planning a spontaneous holiday in Europe', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lastminute.com' OR LOWER(`name`) = 'lastminute.com') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'flights' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'European service for last-minute package holidays, hotels and flights.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'lastminute.com is a European service for booking package holidays (flight + hotel), hotels and flights. The app accompanies the trip from booking to returning home, keeping all travel details in one place.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Flight + hotel packages
Hotels and flights
Last-minute deals
Trip details in one place', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People planning a spontaneous holiday in Europe', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Traveloka — Бронювання готелів, Авіаквитки та відстеження рейсів, Екскурсії та квитки до атракцій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'traveloka.com' OR LOWER(`name`) = 'traveloka')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Traveloka', NULL, 'https://www.traveloka.com/', NULL, NULL, 'Туристична платформа Південно-Східної Азії з АІ-рекомендаціями.', 'Southeast Asian travel platform with AI recommendations.', 'Traveloka — універсальна туристична платформа, популярна в Південно-Східній Азії: перельоти, готелі, атракції, оренда авто, круїзи. За словами розробника, сервіс використовує АІ для персональних рекомендацій. За кожну покупку нараховуються бали, які дають знижки й інші переваги.', 'Traveloka is an all-in-one travel platform popular in Southeast Asia: flights, hotels, attractions, car hire and cruises. According to the developer, it uses AI for personalised recommendations. Every purchase earns points that unlock discounts and other benefits.', 'АІ-рекомендації
Перельоти, готелі й атракції
Оренда авто й круїзи
Бали за покупки', 'AI recommendations
Flights, hotels and attractions
Car hire and cruises
Points for purchases', 'Мандрівники до Південно-Східної Азії', 'Travellers to Southeast Asia', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'traveloka.com' OR LOWER(`name`) = 'traveloka') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'flights' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tours-activities' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Southeast Asian travel platform with AI recommendations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Traveloka is an all-in-one travel platform popular in Southeast Asia: flights, hotels, attractions, car hire and cruises. According to the developer, it uses AI for personalised recommendations. Every purchase earns points that unlock discounts and other benefits.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI recommendations
Flights, hotels and attractions
Car hire and cruises
Points for purchases', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers to Southeast Asia', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tablet Hotels — Бронювання готелів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tablethotels.com' OR LOWER(`name`) = 'tablet hotels')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tablet Hotels', NULL, 'https://www.tablethotels.com/', NULL, NULL, 'Добірка бутик- і дизайн-готелів від команди, що належить до гіда MICHELIN.', 'Curated boutique and design hotels from the team behind the MICHELIN Guide hotels.', 'Tablet Hotels понад двадцять років відбирає готелі з виразним стилем, сервісом і характером — у сервісі немає «всіх готелів», лише вибрані. Користування застосунком безкоштовне й не потребує членства. Компанія Tablet Inc. також видає застосунок The MICHELIN Guide.', 'For over twenty years Tablet Hotels has hand-picked hotels with distinctive style, service and personality; it lists a curated selection rather than every hotel. Using the app is free and requires no membership. Tablet Inc. also publishes The MICHELIN Guide app.', 'Вручну відібрані готелі
Без членства
Бутик- і дизайн-готелі
Пов’язаний із гідом MICHELIN', 'Hand-picked hotels
No membership needed
Boutique and design hotels
Linked to the MICHELIN Guide', 'Мандрівники, яким важливі стиль і атмосфера готелю', 'Travellers who care about a hotel’s style and atmosphere', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tablethotels.com' OR LOWER(`name`) = 'tablet hotels') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Curated boutique and design hotels from the team behind the MICHELIN Guide hotels.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'For over twenty years Tablet Hotels has hand-picked hotels with distinctive style, service and personality; it lists a curated selection rather than every hotel. Using the app is free and requires no membership. Tablet Inc. also publishes The MICHELIN Guide app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hand-picked hotels
No membership needed
Boutique and design hotels
Linked to the MICHELIN Guide', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers who care about a hotel’s style and atmosphere', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mr & Mrs Smith — Бронювання готелів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mrandmrssmith.com' OR LOWER(`name`) = 'mr & mrs smith')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mr & Mrs Smith', NULL, 'https://www.mrandmrssmith.com/', NULL, NULL, 'Добірка бутик- і люксових готелів, які команда відвідує особисто.', 'Boutique and luxury hotel collection personally visited by the team.', 'Mr & Mrs Smith — колекція бутик- і люксових готелів по всьому світу. За словами компанії, її експерти особисто відвідують кожен готель; у застосунку — фото, інсайдерські поради й бронювання через Apple Pay. Оплатити можна також подарунковими картками й бонусами програми лояльності.', 'Mr & Mrs Smith is a collection of boutique and luxury hotels worldwide. The company says its experts personally visit every hotel; the app has photos, insider tips and booking via Apple Pay. Gift cards and loyalty money can also be used for payment.', 'Готелі, перевірені особисто
Бутик і люкс
Бронювання через Apple Pay
Подарункові картки', 'Personally visited hotels
Boutique and luxury
Booking via Apple Pay
Gift cards', 'Пари й мандрівники, які шукають особливий готель для відпочинку', 'Couples and travellers looking for a special hotel stay', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mrandmrssmith.com' OR LOWER(`name`) = 'mr & mrs smith') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Boutique and luxury hotel collection personally visited by the team.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mr & Mrs Smith is a collection of boutique and luxury hotels worldwide. The company says its experts personally visit every hotel; the app has photos, insider tips and booking via Apple Pay. Gift cards and loyalty money can also be used for payment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Personally visited hotels
Boutique and luxury
Booking via Apple Pay
Gift cards', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Couples and travellers looking for a special hotel stay', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hotels24.ua — Бронювання готелів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hotels24.ua' OR LOWER(`name`) = 'hotels24.ua')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hotels24.ua', NULL, 'https://hotels24.ua/', NULL, NULL, 'Український сервіс безкоштовного бронювання готелів по всій Україні.', 'Ukrainian service for free hotel booking across Ukraine.', 'Hotels24.ua — український сервіс бронювання готелів, що працює з 2010 року (ТОВ «ХОТЕЛС 24 ЮА»). На сайті понад 4,7 тисячі готелів України з цінами, фото, описами номерів, відгуками й розташуванням на карті. Забронювати можна онлайн або за телефоном; є пропозиції для бізнес-клієнтів і груп, конференц-зали.', 'Hotels24.ua is a Ukrainian hotel booking service operating since 2010 (Hotels 24 UA LLC). The site lists over 4,700 hotels in Ukraine with prices, photos, room descriptions, guest reviews and map locations. Bookings can be made online or by phone; there are offers for business clients, groups and conference rooms.', 'Понад 4,7 тис. готелів України
Бронювання онлайн або телефоном
Відгуки гостей і карта
Групи та бізнес-клієнти
Конференц-зали', 'Over 4,700 hotels in Ukraine
Book online or by phone
Guest reviews and map
Groups and business clients
Conference rooms', 'Ті, хто подорожує Україною: відпочинок, відрядження, групові поїздки', 'People travelling within Ukraine for holidays, business or groups', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hotels24.ua' OR LOWER(`name`) = 'hotels24.ua') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ukrainian service for free hotel booking across Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hotels24.ua is a Ukrainian hotel booking service operating since 2010 (Hotels 24 UA LLC). The site lists over 4,700 hotels in Ukraine with prices, photos, room descriptions, guest reviews and map locations. Bookings can be made online or by phone; there are offers for business clients, groups and conference rooms.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Over 4,700 hotels in Ukraine
Book online or by phone
Guest reviews and map
Groups and business clients
Conference rooms', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People travelling within Ukraine for holidays, business or groups', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Google Hotels — Бронювання готелів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'google.com/travel/hotels' OR LOWER(`name`) = 'google hotels')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Google Hotels', NULL, 'https://www.google.com/travel/hotels', NULL, NULL, 'Пошук готелів від Google з порівнянням цін сайтів бронювання на карті.', 'Google hotel search comparing booking-site prices on a map.', 'Google Hotels показує готелі на карті й порівнює ціни на той самий номер із різних сайтів бронювання та сайтів самих готелів. Можна фільтрувати за ціною, оцінкою й зручностями, дивитися відгуки та фото, відстежувати ціни на обрані дати. Бронювання відбувається на сайті партнера чи готелю.', 'Google Hotels shows hotels on a map and compares prices for the same room across booking sites and hotel websites. You can filter by price, rating and amenities, read reviews, view photos and track prices for chosen dates. Booking is completed on the partner or hotel site.', 'Порівняння цін сайтів бронювання
Готелі на карті
Відстеження цін
Відгуки й фото
Фільтри зручностей', 'Booking-site price comparison
Hotels on a map
Price tracking
Reviews and photos
Amenity filters', 'Усі, хто шукає готель і хоче швидко порівняти ціни', 'Anyone searching for a hotel who wants a quick price comparison', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'google.com/travel/hotels' OR LOWER(`name`) = 'google hotels') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Google hotel search comparing booking-site prices on a map.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Google Hotels shows hotels on a map and compares prices for the same room across booking sites and hotel websites. You can filter by price, rating and amenities, read reviews, view photos and track prices for chosen dates. Booking is completed on the partner or hotel site.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Booking-site price comparison
Hotels on a map
Price tracking
Reviews and photos
Amenity filters', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone searching for a hotel who wants a quick price comparison', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Skyscanner — Авіаквитки та відстеження рейсів, Бронювання готелів, Потяги, автобуси й оренда авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'skyscanner.net' OR LOWER(`name`) = 'skyscanner')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Skyscanner', NULL, 'https://www.skyscanner.net/', NULL, NULL, 'Порівняння цін на авіаквитки, готелі й оренду авто з українським інтерфейсом.', 'Price comparison for flights, hotels and car hire with a Ukrainian interface.', 'Skyscanner порівнює тарифи авіакомпаній і туристичних сайтів, а також ціни на готелі й оренду авто. Розумні фільтри дають шукати за тривалістю перельоту, авіакомпанією, кількістю пересадок і класом. Сповіщення про ціну повідомить, коли вартість рейсу зміниться. Застосунок має український інтерфейс.', 'Skyscanner compares fares from airlines and travel sites, plus hotel and car hire prices. Smart filters let you search by flight duration, airline, number of stops and cabin class. Price alerts tell you when a fare changes. The app has a Ukrainian interface.', 'Порівняння тарифів авіакомпаній
Готелі й оренда авто
Фільтри за пересадками й класом
Сповіщення про ціну
Український інтерфейс', 'Airline fare comparison
Hotels and car hire
Filters by stops and class
Price alerts
Ukrainian interface', 'Мандрівники, які шукають недорогі авіаквитки', 'Travellers looking for affordable flights', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'skyscanner.net' OR LOWER(`name`) = 'skyscanner') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'flights' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ground-transport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Price comparison for flights, hotels and car hire with a Ukrainian interface.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Skyscanner compares fares from airlines and travel sites, plus hotel and car hire prices. Smart filters let you search by flight duration, airline, number of stops and cabin class. Price alerts tell you when a fare changes. The app has a Ukrainian interface.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Airline fare comparison
Hotels and car hire
Filters by stops and class
Price alerts
Ukrainian interface', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers looking for affordable flights', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Airbnb — Апартаменти, хостели й оренда житла, Екскурсії та квитки до атракцій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'airbnb.com' OR LOWER(`name`) = 'airbnb')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Airbnb', NULL, 'https://www.airbnb.com/', NULL, NULL, 'Оренда житла в господарів, враження й послуги в понад 240 країнах.', 'Homes from hosts, experiences and services in over 240 countries.', 'Airbnb — платформа оренди житла в приватних господарів: за даними компанії, понад 8 мільйонів варіантів у понад 240 країнах і регіонах. Понад 80 фільтрів допомагають знайти басейн, кухню чи інші потрібні зручності. Також через Airbnb бронюють враження (екскурсії, майстер-класи) й послуги; застосунок має український інтерфейс.', 'Airbnb is a platform for renting homes from hosts; the company cites over 8 million listings in more than 240 countries and regions. Over 80 filters help find a pool, a kitchen or other amenities. Airbnb also offers bookable experiences (tours, workshops) and services; the app has a Ukrainian interface.', 'Понад 8 млн варіантів житла
Понад 80 фільтрів
Враження та послуги
Житло для груп
Український інтерфейс', 'Over 8 million listings
Over 80 filters
Experiences and services
Stays for groups
Ukrainian interface', 'Мандрівники, яким потрібна квартира чи будинок замість готелю', 'Travellers who want an apartment or house instead of a hotel', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'airbnb.com' OR LOWER(`name`) = 'airbnb') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vacation-rentals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tours-activities' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Homes from hosts, experiences and services in over 240 countries.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Airbnb is a platform for renting homes from hosts; the company cites over 8 million listings in more than 240 countries and regions. Over 80 filters help find a pool, a kitchen or other amenities. Airbnb also offers bookable experiences (tours, workshops) and services; the app has a Ukrainian interface.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Over 8 million listings
Over 80 filters
Experiences and services
Stays for groups
Ukrainian interface', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers who want an apartment or house instead of a hotel', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Vrbo — Апартаменти, хостели й оренда житла
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vrbo.com' OR LOWER(`name`) = 'vrbo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Vrbo', NULL, 'https://www.vrbo.com/', NULL, NULL, 'Будинки для відпочинку цілком — для сімей і компаній.', 'Entire holiday homes for families and groups.', 'Vrbo (Expedia Group) спеціалізується на будинках для відпочинку, які орендуються цілком: котеджі, шале, вілли, пляжні будинки — щоб уся компанія жила разом. Учасники отримують ціни для учасників і винагороди за поїздки, а планувальник поїздки дає разом обирати житло.', 'Vrbo (Expedia Group) specialises in entire holiday homes: cottages, cabins, villas and beach houses, so the whole group can stay together. Members get member prices and trip rewards, and the trip planner lets a group choose a home together.', 'Житло цілком
Відгуки гостей
Спільний планувальник поїздки
Ціни для учасників', 'Entire homes
Guest reviews
Shared trip planner
Member prices', 'Сім’ї та компанії друзів', 'Families and groups of friends', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vrbo.com' OR LOWER(`name`) = 'vrbo') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vacation-rentals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Entire holiday homes for families and groups.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Vrbo (Expedia Group) specialises in entire holiday homes: cottages, cabins, villas and beach houses, so the whole group can stay together. Members get member prices and trip rewards, and the trip planner lets a group choose a home together.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Entire homes
Guest reviews
Shared trip planner
Member prices', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families and groups of friends', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hostelworld — Апартаменти, хостели й оренда житла
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hostelworld.com' OR LOWER(`name`) = 'hostelworld')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hostelworld', NULL, 'https://www.hostelworld.com/', NULL, NULL, 'Бронювання хостелів у 180 країнах для бюджетних подорожей.', 'Hostel bookings in 180 countries for budget travel.', 'Hostelworld працює 25 років і, за даними компанії, пропонує 16,5 тисячі хостелів у 180 країнах із відгуками понад 13 мільйонів мандрівників. Фільтри — за розташуванням, ціною, типом кімнати, екологічністю й зручностями. Застосунок також допомагає знайомитися з іншими мандрівниками.', 'Hostelworld has been running for 25 years and lists 16,500 hostels in 180 countries with reviews from over 13 million travellers, according to the company. Filters cover location, price, room type, sustainability and facilities. The app also helps travellers meet each other.', '16,5 тис. хостелів у 180 країнах
Відгуки мандрівників
Фільтр за типом кімнати
Знайомства з мандрівниками', '16,500 hostels in 180 countries
Traveller reviews
Room type filter
Meet other travellers', 'Студенти, бекпекери й усі, хто подорожує з обмеженим бюджетом', 'Students, backpackers and budget travellers', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hostelworld.com' OR LOWER(`name`) = 'hostelworld') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vacation-rentals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Hostel bookings in 180 countries for budget travel.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hostelworld has been running for 25 years and lists 16,500 hostels in 180 countries with reviews from over 13 million travellers, according to the company. Filters cover location, price, room type, sustainability and facilities. The app also helps travellers meet each other.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '16,500 hostels in 180 countries
Traveller reviews
Room type filter
Meet other travellers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students, backpackers and budget travellers', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- HomeExchange — Апартаменти, хостели й оренда житла
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'homeexchange.com' OR LOWER(`name`) = 'homeexchange')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HomeExchange', NULL, 'https://www.homeexchange.com/', NULL, NULL, 'Обмін житлом між учасниками спільноти замість оренди.', 'Home swapping between community members instead of renting.', 'HomeExchange — платформа обміну житлом: учасники живуть у домівках одне одного під час відпустки. За даними компанії, у спільноті понад 250 тисяч учасників у 155 країнах. Обмін можливий і не одночасно — завдяки балам GuestPoints; для повного доступу потрібне річне членство, обміни захищені гарантіями.', 'HomeExchange is a home swapping platform: members stay in each other’s homes on holiday. The company cites over 250,000 members in 155 countries. Swaps need not be simultaneous thanks to GuestPoints; full access requires an annual membership, and exchanges are covered by guarantees.', 'Обмін житлом
Бали GuestPoints
Річне членство
Гарантії для обмінів
Чат з учасниками', 'Home swapping
GuestPoints
Annual membership
Exchange guarantees
Chat with members', 'Власники житла, які хочуть подорожувати, не платячи за оренду', 'Homeowners who want to travel without paying for accommodation', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'homeexchange.com' OR LOWER(`name`) = 'homeexchange') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vacation-rentals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Home swapping between community members instead of renting.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'HomeExchange is a home swapping platform: members stay in each other’s homes on holiday. The company cites over 250,000 members in 155 countries. Swaps need not be simultaneous thanks to GuestPoints; full access requires an annual membership, and exchanges are covered by guarantees.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Home swapping
GuestPoints
Annual membership
Exchange guarantees
Chat with members', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners who want to travel without paying for accommodation', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Потрібне платне членство; актуальні ціни — на офіційному сайті.', 'A paid membership is required; current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A paid membership is required; current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Holidu — Апартаменти, хостели й оренда житла
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'holidu.com' OR LOWER(`name`) = 'holidu')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Holidu', NULL, 'https://www.holidu.com/', NULL, NULL, 'Пошук перевірених будинків і апартаментів для відпочинку в Європі.', 'Search for verified holiday homes and apartments in Europe.', 'Holidu — німецький сервіс пошуку житла для відпочинку в Європі: шале, котеджі, апартаменти, пляжні вілли. Компанія наголошує на перевірених оголошеннях, простому бронюванні та власній службі підтримки.', 'Holidu is a German service for finding holiday rentals in Europe: chalets, cottages, apartments and beach villas. The company highlights verified listings, simple booking and its own support team.', 'Житло для відпочинку в Європі
Перевірені оголошення
Служба підтримки
Шале, котеджі, вілли', 'Holiday rentals in Europe
Verified listings
Support team
Chalets, cottages, villas', 'Ті, хто планує відпочинок у Європі в окремому житлі', 'People planning a European holiday in a rental home', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'holidu.com' OR LOWER(`name`) = 'holidu') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vacation-rentals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Search for verified holiday homes and apartments in Europe.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Holidu is a German service for finding holiday rentals in Europe: chalets, cottages, apartments and beach villas. The company highlights verified listings, simple booking and its own support team.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Holiday rentals in Europe
Verified listings
Support team
Chalets, cottages, villas', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People planning a European holiday in a rental home', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Marriott Bonvoy — Готельні мережі та бонусні програми, Бронювання готелів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'marriott.com' OR LOWER(`name`) = 'marriott bonvoy')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Marriott Bonvoy', NULL, 'https://www.marriott.com/', NULL, NULL, 'Застосунок і програма лояльності Marriott: понад 8 тисяч готелів 30+ брендів.', 'Marriott’s app and loyalty programme: 8,000+ hotels across 30+ brands.', 'Marriott Bonvoy — застосунок і безкоштовна програма лояльності Marriott International: понад 8 тисяч готелів у 130+ країнах під понад 30 брендами. Учасники бронюють напряму з гарантією найкращої ціни, накопичують і витрачають бали, керують перебуванням у застосунку.', 'Marriott Bonvoy is the app and free loyalty programme of Marriott International: over 8,000 hotels in 130+ countries across 30+ brands. Members book direct with a best rate guarantee, earn and redeem points and manage stays in the app.', 'Понад 8 тис. готелів
Гарантія найкращої ціни
Бали за проживання
Безкоштовне членство', 'Over 8,000 hotels
Best rate guarantee
Points for stays
Free membership', 'Мандрівники, які часто зупиняються в готелях однієї мережі й хочуть накопичувати бали та бронювати напряму', 'Frequent travellers who stay with one hotel group and want to earn points and book direct', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'marriott.com' OR LOWER(`name`) = 'marriott bonvoy') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-loyalty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Marriott’s app and loyalty programme: 8,000+ hotels across 30+ brands.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Marriott Bonvoy is the app and free loyalty programme of Marriott International: over 8,000 hotels in 130+ countries across 30+ brands. Members book direct with a best rate guarantee, earn and redeem points and manage stays in the app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Over 8,000 hotels
Best rate guarantee
Points for stays
Free membership', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Frequent travellers who stay with one hotel group and want to earn points and book direct', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hilton Honors — Готельні мережі та бонусні програми, Бронювання готелів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hilton.com' OR LOWER(`name`) = 'hilton honors')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hilton Honors', NULL, 'https://www.hilton.com/', NULL, NULL, 'Застосунок Hilton: бронювання, вибір номера й цифровий ключ у 9 тисячах готелів.', 'Hilton app: booking, room choice and Digital Key across 9,000 hotels.', 'Hilton Honors — застосунок і програма лояльності Hilton для понад 9 тисяч готелів. Можна заздалегідь обрати номер, зареєструватися напередодні й пройти до кімнати без стійки реєстрації завдяки цифровому ключу. Бали нараховуються за проживання й обмінюються на винагороди.', 'Hilton Honors is Hilton’s app and loyalty programme for over 9,000 hotels. You can choose a room in advance, check in the day before and skip the front desk using the Digital Key. Points are earned for stays and redeemed for rewards.', 'Вибір номера заздалегідь
Цифровий ключ
Онлайн-реєстрація
Бали за проживання', 'Choose your room in advance
Digital Key
Online check-in
Points for stays', 'Мандрівники, які часто зупиняються в готелях однієї мережі й хочуть накопичувати бали та бронювати напряму', 'Frequent travellers who stay with one hotel group and want to earn points and book direct', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hilton.com' OR LOWER(`name`) = 'hilton honors') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-loyalty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Hilton app: booking, room choice and Digital Key across 9,000 hotels.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hilton Honors is Hilton’s app and loyalty programme for over 9,000 hotels. You can choose a room in advance, check in the day before and skip the front desk using the Digital Key. Points are earned for stays and redeemed for rewards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Choose your room in advance
Digital Key
Online check-in
Points for stays', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Frequent travellers who stay with one hotel group and want to earn points and book direct', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- IHG One Rewards — Готельні мережі та бонусні програми, Бронювання готелів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ihg.com' OR LOWER(`name`) = 'ihg one rewards')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'IHG One Rewards', NULL, 'https://www.ihg.com/', NULL, NULL, 'Застосунок IHG (Holiday Inn, InterContinental та інші): 7 тисяч готелів.', 'IHG app (Holiday Inn, InterContinental and more): 7,000 hotels.', 'IHG One Rewards — застосунок і безкоштовна програма лояльності IHG Hotels & Resorts: понад 7 тисяч готелів у 100+ країнах під 21+ брендом. Учасники отримують ексклюзивні тарифи при прямому бронюванні та бали за кожне проживання.', 'IHG One Rewards is the app and free loyalty programme of IHG Hotels & Resorts: over 7,000 hotels in 100+ countries across 21+ brands. Members get exclusive rates when booking direct and points for every stay.', 'Понад 7 тис. готелів
Тарифи для учасників
Бали за проживання
Безкоштовне членство', 'Over 7,000 hotels
Member rates
Points for stays
Free membership', 'Мандрівники, які часто зупиняються в готелях однієї мережі й хочуть накопичувати бали та бронювати напряму', 'Frequent travellers who stay with one hotel group and want to earn points and book direct', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ihg.com' OR LOWER(`name`) = 'ihg one rewards') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-loyalty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'IHG app (Holiday Inn, InterContinental and more): 7,000 hotels.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'IHG One Rewards is the app and free loyalty programme of IHG Hotels & Resorts: over 7,000 hotels in 100+ countries across 21+ brands. Members get exclusive rates when booking direct and points for every stay.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Over 7,000 hotels
Member rates
Points for stays
Free membership', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Frequent travellers who stay with one hotel group and want to earn points and book direct', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- World of Hyatt — Готельні мережі та бонусні програми, Бронювання готелів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hyatt.com' OR LOWER(`name`) = 'world of hyatt')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'World of Hyatt', NULL, 'https://www.hyatt.com/', NULL, NULL, 'Застосунок Hyatt для бронювання за гроші чи бали з гарантією ціни.', 'Hyatt app for booking with cash or points and a rate guarantee.', 'World of Hyatt — застосунок і безкоштовна програма лояльності Hyatt. При прямому бронюванні діє гарантія найкращої ціни; оплачувати проживання можна грошима, балами або поєднанням. У застосунку — фото, деталі готелів, пропозиції й місцеві пам’ятки.', 'World of Hyatt is Hyatt’s app and free loyalty programme. Booking direct comes with a best rate guarantee; stays can be paid with cash, points or both. The app shows hotel photos, details, offers and local attractions.', 'Оплата грошима чи балами
Гарантія найкращої ціни
Пропозиції готелів
Безкоштовне членство', 'Pay with cash or points
Best rate guarantee
Hotel offers
Free membership', 'Мандрівники, які часто зупиняються в готелях однієї мережі й хочуть накопичувати бали та бронювати напряму', 'Frequent travellers who stay with one hotel group and want to earn points and book direct', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hyatt.com' OR LOWER(`name`) = 'world of hyatt') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-loyalty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Hyatt app for booking with cash or points and a rate guarantee.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'World of Hyatt is Hyatt’s app and free loyalty programme. Booking direct comes with a best rate guarantee; stays can be paid with cash, points or both. The app shows hotel photos, details, offers and local attractions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Pay with cash or points
Best rate guarantee
Hotel offers
Free membership', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Frequent travellers who stay with one hotel group and want to earn points and book direct', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ALL Accor — Готельні мережі та бонусні програми, Бронювання готелів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'all.accor.com' OR LOWER(`name`) = 'all accor')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ALL Accor', NULL, 'https://all.accor.com/', NULL, NULL, 'Застосунок Accor: Novotel, Ibis, Sofitel, Fairmont та інші — 5 тисяч готелів.', 'Accor app: Novotel, Ibis, Sofitel, Fairmont and more — 5,000 hotels.', 'ALL Accor — застосунок і програма лояльності групи Accor: понад 5 тисяч закладів у 111 країнах, серед брендів Raffles, Sofitel, Fairmont, MGallery, Novotel, Pullman, Mövenpick, Adagio. Підходить і для поїздок в останню хвилину, і для тривалого проживання.', 'ALL Accor is the app and loyalty programme of the Accor group: over 5,000 properties in 111 countries, with brands such as Raffles, Sofitel, Fairmont, MGallery, Novotel, Pullman, Mövenpick and Adagio. It suits both last-minute trips and long stays.', 'Понад 5 тис. закладів
Десятки брендів Accor
Програма лояльності ALL
Тривале проживання', 'Over 5,000 properties
Dozens of Accor brands
ALL loyalty programme
Long stays', 'Мандрівники, які часто зупиняються в готелях однієї мережі й хочуть накопичувати бали та бронювати напряму', 'Frequent travellers who stay with one hotel group and want to earn points and book direct', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'all.accor.com' OR LOWER(`name`) = 'all accor') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-loyalty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Accor app: Novotel, Ibis, Sofitel, Fairmont and more — 5,000 hotels.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ALL Accor is the app and loyalty programme of the Accor group: over 5,000 properties in 111 countries, with brands such as Raffles, Sofitel, Fairmont, MGallery, Novotel, Pullman, Mövenpick and Adagio. It suits both last-minute trips and long stays.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Over 5,000 properties
Dozens of Accor brands
ALL loyalty programme
Long stays', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Frequent travellers who stay with one hotel group and want to earn points and book direct', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Radisson Hotels — Готельні мережі та бонусні програми, Бронювання готелів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'radissonhotels.com' OR LOWER(`name`) = 'radisson hotels')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Radisson Hotels', NULL, 'https://www.radissonhotels.com/', NULL, NULL, 'Застосунок Radisson з тарифами лише для учасників і бонусними балами.', 'Radisson app with member-only rates and reward points.', 'Застосунок Radisson Hotels охоплює готелі мережі в Європі, на Близькому Сході, в Африці, Океанії та Азійсько-Тихоокеанському регіоні. Учасники отримують тарифи лише для учасників (за даними компанії, до 15% дешевше), бонусні бали й ціни лише в застосунку; є український інтерфейс.', 'The Radisson Hotels app covers the group’s hotels in Europe, the Middle East, Africa, Oceania and Asia Pacific. Members get member-only rates (up to 15% off, per the company), reward points and app-only prices; a Ukrainian interface is available.', 'Тарифи лише для учасників
Бонусні бали
Ціни лише в застосунку
Український інтерфейс', 'Member-only rates
Reward points
App-only prices
Ukrainian interface', 'Мандрівники, які часто зупиняються в готелях однієї мережі й хочуть накопичувати бали та бронювати напряму', 'Frequent travellers who stay with one hotel group and want to earn points and book direct', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'radissonhotels.com' OR LOWER(`name`) = 'radisson hotels') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-loyalty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Radisson app with member-only rates and reward points.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Radisson Hotels app covers the group’s hotels in Europe, the Middle East, Africa, Oceania and Asia Pacific. Members get member-only rates (up to 15% off, per the company), reward points and app-only prices; a Ukrainian interface is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Member-only rates
Reward points
App-only prices
Ukrainian interface', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Frequent travellers who stay with one hotel group and want to earn points and book direct', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Wyndham Hotels & Resorts — Готельні мережі та бонусні програми, Бронювання готелів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wyndhamhotels.com' OR LOWER(`name`) = 'wyndham hotels & resorts')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Wyndham Hotels & Resorts', NULL, 'https://www.wyndhamhotels.com/', NULL, NULL, 'Застосунок Wyndham: бронювання, бонуси Wyndham Rewards і функції під час проживання.', 'Wyndham app: booking, Wyndham Rewards and in-stay features.', 'Застосунок Wyndham Hotels & Resorts дає змогу шукати й бронювати тисячі готелів мережі по світу, отримувати тарифи для учасників і бонуси Wyndham Rewards, а також користуватися функціями під час проживання. Улюблені готелі можна зберігати для швидкого бронювання.', 'The Wyndham Hotels & Resorts app lets you search and book thousands of the group’s hotels worldwide, get member rates and Wyndham Rewards, and use in-stay features. Favourite hotels can be saved for quick booking.', 'Тисячі готелів мережі
Wyndham Rewards
Тарифи для учасників
Функції під час проживання', 'Thousands of hotels
Wyndham Rewards
Member rates
In-stay features', 'Мандрівники, які часто зупиняються в готелях однієї мережі й хочуть накопичувати бали та бронювати напряму', 'Frequent travellers who stay with one hotel group and want to earn points and book direct', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wyndhamhotels.com' OR LOWER(`name`) = 'wyndham hotels & resorts') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-loyalty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Wyndham app: booking, Wyndham Rewards and in-stay features.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Wyndham Hotels & Resorts app lets you search and book thousands of the group’s hotels worldwide, get member rates and Wyndham Rewards, and use in-stay features. Favourite hotels can be saved for quick booking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Thousands of hotels
Wyndham Rewards
Member rates
In-stay features', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Frequent travellers who stay with one hotel group and want to earn points and book direct', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Best Western — Готельні мережі та бонусні програми, Бронювання готелів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bestwestern.com' OR LOWER(`name`) = 'best western')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Best Western', NULL, 'https://www.bestwestern.com/', NULL, NULL, 'Застосунок Best Western: 18 брендів у понад 100 країнах і бонуси Best Western Rewards.', 'Best Western app: 18 brands in 100+ countries and Best Western Rewards.', 'Застосунок Best Western To Go дає шукати готелі 18 брендів мережі в понад 100 країнах, бронювати, переглядати майбутні й минулі бронювання та рахунок Best Western Rewards. Є фільтри для подорожей із тваринами й пошуку зарядних станцій для електромобілів.', 'The Best Western To Go app lets you search the group’s 18 brands in over 100 countries, book, view upcoming and past reservations and your Best Western Rewards account. Filters cover pet-friendly stays and EV charging stations.', '18 брендів у 100+ країнах
Best Western Rewards
Фільтр для подорожей із тваринами
Зарядні станції для електромобілів', '18 brands in 100+ countries
Best Western Rewards
Pet-friendly filter
EV charging stations', 'Мандрівники, які часто зупиняються в готелях однієї мережі й хочуть накопичувати бали та бронювати напряму', 'Frequent travellers who stay with one hotel group and want to earn points and book direct', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bestwestern.com' OR LOWER(`name`) = 'best western') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-loyalty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Best Western app: 18 brands in 100+ countries and Best Western Rewards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Best Western To Go app lets you search the group’s 18 brands in over 100 countries, book, view upcoming and past reservations and your Best Western Rewards account. Filters cover pet-friendly stays and EV charging stations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '18 brands in 100+ countries
Best Western Rewards
Pet-friendly filter
EV charging stations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Frequent travellers who stay with one hotel group and want to earn points and book direct', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Choice Hotels — Готельні мережі та бонусні програми, Бронювання готелів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'choicehotels.com' OR LOWER(`name`) = 'choice hotels')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Choice Hotels', NULL, 'https://www.choicehotels.com/', NULL, NULL, 'Застосунок Choice Hotels з гарантією найнижчої ціни й балами Choice Privileges.', 'Choice Hotels app with a lowest price guarantee and Choice Privileges points.', 'Застосунок Choice Hotels дозволяє шукати, бронювати й керувати проживанням з гарантією найнижчої ціни при прямому бронюванні (за даними компанії, до 10% економії). Бали Choice Privileges накопичуються й витрачаються в застосунку; є віртуальні тури 360° і відгуки гостей.', 'The Choice Hotels app lets you search, book and manage stays with a lowest price guarantee when booking direct (up to 10% savings, per the company). Choice Privileges points are earned and redeemed in the app; there are 360° virtual tours and guest reviews.', 'Гарантія найнижчої ціни
Бали Choice Privileges
Віртуальні тури 360°
Відгуки гостей', 'Lowest price guarantee
Choice Privileges points
360° virtual tours
Guest reviews', 'Мандрівники, які часто зупиняються в готелях однієї мережі й хочуть накопичувати бали та бронювати напряму', 'Frequent travellers who stay with one hotel group and want to earn points and book direct', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'choicehotels.com' OR LOWER(`name`) = 'choice hotels') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-loyalty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Choice Hotels app with a lowest price guarantee and Choice Privileges points.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Choice Hotels app lets you search, book and manage stays with a lowest price guarantee when booking direct (up to 10% savings, per the company). Choice Privileges points are earned and redeemed in the app; there are 360° virtual tours and guest reviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Lowest price guarantee
Choice Privileges points
360° virtual tours
Guest reviews', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Frequent travellers who stay with one hotel group and want to earn points and book direct', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Google Flights — Авіаквитки та відстеження рейсів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'google.com/travel/flights' OR LOWER(`name`) = 'google flights')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Google Flights', NULL, 'https://www.google.com/travel/flights', NULL, NULL, 'Пошук авіаквитків від Google з графіком цін і відстеженням тарифів.', 'Google flight search with price graphs and fare tracking.', 'Google Flights шукає рейси авіакомпаній і туристичних сайтів, показує календар і графік цін на різні дати та підказує, чи поточна ціна низька або висока порівняно зі звичайною. Можна відстежувати ціни на маршрут і отримувати сповіщення; купівля відбувається на сайті авіакомпанії чи агента.', 'Google Flights searches airline and travel-site flights, shows a calendar and price graph across dates and indicates whether the current price is low or high compared with usual. You can track route prices and get alerts; purchase is completed on the airline or agent site.', 'Календар і графік цін
Оцінка, чи ціна низька
Відстеження цін на маршрут
Пошук гнучких дат', 'Price calendar and graph
Price level insights
Route price tracking
Flexible date search', 'Усі, хто купує авіаквитки й хоче вибрати вдалий момент', 'Anyone buying flights who wants to pick the right moment', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'google.com/travel/flights' OR LOWER(`name`) = 'google flights') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'flights' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Google flight search with price graphs and fare tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Google Flights searches airline and travel-site flights, shows a calendar and price graph across dates and indicates whether the current price is low or high compared with usual. You can track route prices and get alerts; purchase is completed on the airline or agent site.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Price calendar and graph
Price level insights
Route price tracking
Flexible date search', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone buying flights who wants to pick the right moment', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kiwi.com — Авіаквитки та відстеження рейсів, Потяги, автобуси й оренда авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kiwi.com' OR LOWER(`name`) = 'kiwi.com')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kiwi.com', NULL, 'https://www.kiwi.com/', NULL, NULL, 'Пошук дешевих перельотів із комбінуванням авіакомпаній, потягів і автобусів.', 'Cheap flight search combining airlines, trains and buses.', 'Kiwi.com шукає недорогі перельоти, зокрема маршрути, які поєднують різні авіакомпанії, а також потяги й автобуси. Гарантія Kiwi.com допомагає, якщо пропущено пересадку на такому комбінованому маршруті. Застосунок має український інтерфейс.', 'Kiwi.com finds cheap flights, including routes that combine different airlines, plus trains and buses. The Kiwi.com Guarantee helps if a connection on such a combined route is missed. The app has a Ukrainian interface.', 'Комбіновані маршрути
Потяги й автобуси
Гарантія Kiwi.com
Український інтерфейс', 'Combined routes
Trains and buses
Kiwi.com Guarantee
Ukrainian interface', 'Бюджетні мандрівники, готові до пересадок заради нижчої ціни', 'Budget travellers willing to take connections for a lower price', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kiwi.com' OR LOWER(`name`) = 'kiwi.com') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'flights' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ground-transport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Cheap flight search combining airlines, trains and buses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Kiwi.com finds cheap flights, including routes that combine different airlines, plus trains and buses. The Kiwi.com Guarantee helps if a connection on such a combined route is missed. The app has a Ukrainian interface.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Combined routes
Trains and buses
Kiwi.com Guarantee
Ukrainian interface', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Budget travellers willing to take connections for a lower price', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- eDreams — Авіаквитки та відстеження рейсів, Бронювання готелів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'edreams.com' OR LOWER(`name`) = 'edreams')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'eDreams', NULL, 'https://www.edreams.com/', NULL, NULL, 'Європейська онлайн-агенція: авіаквитки, готелі, оренда авто й автоматична реєстрація.', 'European online travel agency: flights, hotels, car hire and automatic check-in.', 'eDreams — європейська онлайн-туристична агенція для пошуку дешевих авіаквитків, готелів і оренди авто. Застосунок може автоматично зареєструвати вас на рейс, щойно реєстрація відкриється. За даними компанії, у застосунку понад 18 мільйонів користувачів.', 'eDreams is a European online travel agency for finding cheap flights, hotels and car hire. The app can check you in automatically as soon as check-in opens. The company cites over 18 million app users.', 'Авіаквитки й готелі
Автоматична реєстрація на рейс
Оренда авто
Квитки в застосунку', 'Flights and hotels
Automatic flight check-in
Car hire
Tickets in the app', 'Мандрівники, які купують перельоти в Європі', 'Travellers buying flights in Europe', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'edreams.com' OR LOWER(`name`) = 'edreams') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'flights' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'European online travel agency: flights, hotels, car hire and automatic check-in.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'eDreams is a European online travel agency for finding cheap flights, hotels and car hire. The app can check you in automatically as soon as check-in opens. The company cites over 18 million app users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Flights and hotels
Automatic flight check-in
Car hire
Tickets in the app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers buying flights in Europe', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Flighty — Авіаквитки та відстеження рейсів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'flighty.com' OR LOWER(`name`) = 'flighty')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Flighty', NULL, 'https://www.flighty.com/', NULL, NULL, 'Трекер рейсів зі швидкими сповіщеннями про затримки та їхні прогнози.', 'Flight tracker with fast delay alerts and delay predictions.', 'Flighty відстежує ваші рейси й, за словами розробника, повідомляє про затримки на 2–90 хвилин раніше, ніж застосунки авіакомпаній, а про скасування — на 24–48 годин раніше. Показує причину затримки, де зараз ваш літак, прогнози затримок і виходу на посадку. Без реклами й без обов’язкового акаунта; Pro-функції безкоштовні на першому рейсі.', 'Flighty tracks your flights and, according to the developer, alerts you to delays 2–90 minutes faster than airline apps and to cancellations 24–48 hours earlier. It shows why a flight is delayed, where your plane is, delay and gate predictions. No ads and no account required; Pro features are free on your first flight.', 'Швидкі сповіщення про затримки
Прогноз затримок і виходу
Де зараз мій літак
Без реклами
Історія перельотів', 'Fast delay alerts
Delay and gate predictions
Where is my plane
No ads
Flight history', 'Ті, хто часто літає й хоче першим знати про зміни рейсу', 'Frequent flyers who want to know about flight changes first', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'flighty.com' OR LOWER(`name`) = 'flighty') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'flights' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Flight tracker with fast delay alerts and delay predictions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Flighty tracks your flights and, according to the developer, alerts you to delays 2–90 minutes faster than airline apps and to cancellations 24–48 hours earlier. It shows why a flight is delayed, where your plane is, delay and gate predictions. No ads and no account required; Pro features are free on your first flight.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Fast delay alerts
Delay and gate predictions
Where is my plane
No ads
Flight history', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Frequent flyers who want to know about flight changes first', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовна версія; частина функцій — у платній підписці.', 'A free version is available; some features require a paid subscription.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free version is available; some features require a paid subscription.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни платних функцій — на офіційному сайті.', 'Current prices for paid features are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices for paid features are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Flightradar24 — Авіаквитки та відстеження рейсів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'flightradar24.com' OR LOWER(`name`) = 'flightradar24')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Flightradar24', NULL, 'https://www.flightradar24.com/', NULL, NULL, 'Відстеження літаків на карті в реальному часі та статус рейсів.', 'Real-time aircraft tracking on a map and flight status.', 'Flightradar24 показує рух літаків по світу на карті в реальному часі. Можна дізнатися статус рейсу, а навівши телефон на літак у небі — побачити, куди він летить і що це за модель. Основні функції безкоштовні; підписки Silver і Gold додають розширені дані.', 'Flightradar24 shows aircraft moving around the world on a real-time map. You can check flight status, and by pointing your phone at a plane in the sky see where it is going and what aircraft it is. Core features are free; Silver and Gold subscriptions add extended data.', 'Карта літаків у реальному часі
Статус рейсу
Розпізнавання літака камерою
Підписки Silver і Gold', 'Real-time aircraft map
Flight status
Point at a plane to identify it
Silver and Gold subscriptions', 'Мандрівники, ті, хто зустрічає рейси, і любителі авіації', 'Travellers, people meeting flights and aviation enthusiasts', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'flightradar24.com' OR LOWER(`name`) = 'flightradar24') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'flights' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Real-time aircraft tracking on a map and flight status.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Flightradar24 shows aircraft moving around the world on a real-time map. You can check flight status, and by pointing your phone at a plane in the sky see where it is going and what aircraft it is. Core features are free; Silver and Gold subscriptions add extended data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time aircraft map
Flight status
Point at a plane to identify it
Silver and Gold subscriptions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers, people meeting flights and aviation enthusiasts', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовна версія; частина функцій — у платній підписці.', 'A free version is available; some features require a paid subscription.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free version is available; some features require a paid subscription.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни платних функцій — на офіційному сайті.', 'Current prices for paid features are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices for paid features are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Omio — Потяги, автобуси й оренда авто, Авіаквитки та відстеження рейсів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'omio.com' OR LOWER(`name`) = 'omio')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Omio', NULL, 'https://www.omio.com/', NULL, NULL, 'Порівняння й купівля квитків на потяги, автобуси, рейси й пороми.', 'Compare and book train, bus, flight and ferry tickets.', 'Omio допомагає знайти маршрут і порівняти ціни на потяги, автобуси, перельоти й пороми від понад 3 тисяч перевізників у 45+ країнах (Європа, Велика Британія, США, Японія, Південно-Східна Азія, Бразилія). Квитки зберігаються в застосунку; є український інтерфейс.', 'Omio helps you find routes and compare prices for trains, buses, flights and ferries from over 3,000 carriers in 45+ countries (Europe, the UK, the US, Japan, Southeast Asia, Brazil). Tickets are stored in the app; a Ukrainian interface is available.', 'Потяги, автобуси, рейси й пороми
Понад 3 тис. перевізників
Квитки в застосунку
Український інтерфейс', 'Trains, buses, flights and ferries
Over 3,000 carriers
Tickets in the app
Ukrainian interface', 'Ті, хто подорожує Європою наземним транспортом', 'People travelling around Europe by land', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'omio.com' OR LOWER(`name`) = 'omio') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ground-transport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'flights' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Compare and book train, bus, flight and ferry tickets.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Omio helps you find routes and compare prices for trains, buses, flights and ferries from over 3,000 carriers in 45+ countries (Europe, the UK, the US, Japan, Southeast Asia, Brazil). Tickets are stored in the app; a Ukrainian interface is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Trains, buses, flights and ferries
Over 3,000 carriers
Tickets in the app
Ukrainian interface', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People travelling around Europe by land', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Trainline — Потяги, автобуси й оренда авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thetrainline.com' OR LOWER(`name`) = 'trainline')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Trainline', NULL, 'https://www.thetrainline.com/', NULL, NULL, 'Квитки на потяги й автобуси в Європі з відстеженням розкладу.', 'European train and coach tickets with live timetable tracking.', 'Trainline — європейський застосунок для купівлі квитків на потяги й автобуси наперед чи в день поїздки. Сповіщення в реальному часі й відстеження розкладу допомагають не пропустити зміни, а електронні квитки зберігаються в телефоні.', 'Trainline is a European app for buying train and coach tickets in advance or on the day. Real-time notifications and live timetable tracking help you keep up with changes, and e-tickets are stored on your phone.', 'Квитки на потяги й автобуси
Відстеження розкладу
Сповіщення в реальному часі
Електронні квитки', 'Train and coach tickets
Live timetable tracking
Real-time notifications
E-tickets', 'Ті, хто їздить потягами Європою чи Великою Британією', 'Rail travellers in Europe and the UK', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thetrainline.com' OR LOWER(`name`) = 'trainline') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ground-transport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'European train and coach tickets with live timetable tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Trainline is a European app for buying train and coach tickets in advance or on the day. Real-time notifications and live timetable tracking help you keep up with changes, and e-tickets are stored on your phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Train and coach tickets
Live timetable tracking
Real-time notifications
E-tickets', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Rail travellers in Europe and the UK', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- FlixBus — Потяги, автобуси й оренда авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'flixbus.com' OR LOWER(`name`) = 'flixbus')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'FlixBus', NULL, 'https://www.flixbus.com/', NULL, NULL, 'Недорогі автобусні рейси Європою з відстеженням автобуса.', 'Affordable European coach trips with live bus tracking.', 'FlixBus — мережа міжміських автобусів Європи з бронюванням місць, зрозумілим розкладом і відстеженням автобуса в реальному часі. Автобуси мають Wi-Fi, розетки й збільшений простір для ніг; застосунок має український інтерфейс.', 'FlixBus is a European intercity coach network with seat reservations, a clear timetable and live bus tracking. Coaches have Wi-Fi, power outlets and extra legroom; the app has a Ukrainian interface.', 'Міжміські автобуси Європи
Відстеження автобуса
Wi-Fi і розетки
Український інтерфейс', 'European intercity coaches
Live bus tracking
Wi-Fi and power outlets
Ukrainian interface', 'Бюджетні мандрівники Європою', 'Budget travellers in Europe', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'flixbus.com' OR LOWER(`name`) = 'flixbus') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ground-transport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Affordable European coach trips with live bus tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'FlixBus is a European intercity coach network with seat reservations, a clear timetable and live bus tracking. Coaches have Wi-Fi, power outlets and extra legroom; the app has a Ukrainian interface.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'European intercity coaches
Live bus tracking
Wi-Fi and power outlets
Ukrainian interface', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Budget travellers in Europe', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Rentalcars.com — Потяги, автобуси й оренда авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rentalcars.com' OR LOWER(`name`) = 'rentalcars.com')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Rentalcars.com', NULL, 'https://www.rentalcars.com/', NULL, NULL, 'Порівняння й оренда авто в понад 49 тисячах точок по світу.', 'Compare and rent cars at over 49,000 locations worldwide.', 'Rentalcars.com (Booking.com Transport) порівнює пропозиції прокатних компаній і, за даними сервісу, працює в понад 49 тисячах точок видачі по світу. Електронний ваучер приймається більшістю компаній, тож друкувати нічого не потрібно.', 'Rentalcars.com (Booking.com Transport) compares rental companies’ offers and, according to the service, covers over 49,000 pick-up locations worldwide. The e-voucher is accepted almost everywhere, so there is nothing to print.', 'Порівняння прокатних компаній
Понад 49 тис. точок
Електронний ваучер
Керування бронюванням', 'Rental company comparison
Over 49,000 locations
E-voucher
Booking management', 'Мандрівники, яким потрібне авто на місці', 'Travellers who need a car at their destination', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rentalcars.com' OR LOWER(`name`) = 'rentalcars.com') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ground-transport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Compare and rent cars at over 49,000 locations worldwide.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Rentalcars.com (Booking.com Transport) compares rental companies’ offers and, according to the service, covers over 49,000 pick-up locations worldwide. The e-voucher is accepted almost everywhere, so there is nothing to print.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Rental company comparison
Over 49,000 locations
E-voucher
Booking management', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers who need a car at their destination', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Discover Cars — Потяги, автобуси й оренда авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'discovercars.com' OR LOWER(`name`) = 'discover cars')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Discover Cars', NULL, 'https://www.discovercars.com/', NULL, NULL, 'Порівняння оренди авто з прозорими умовами щодо пального й страхування.', 'Car rental comparison with clear fuel and insurance terms.', 'Discover Cars порівнює пропозиції прокату авто й показує умови оренди в одному місці: політику щодо пального й пробігу, що входить у покриття. У застосунку можна змінити дати, додати водія чи покращити клас авто, а також переглянути гнучкі умови скасування.', 'Discover Cars compares car rental offers and shows rental terms in one place: fuel and mileage policy and what coverage is included. In the app you can change dates, add a driver or upgrade the car, and review flexible cancellation terms.', 'Порівняння прокату
Умови пального й пробігу
Зміна бронювання
Гнучке скасування', 'Rental comparison
Fuel and mileage terms
Booking changes
Flexible cancellation', 'Мандрівники, які орендують авто за кордоном', 'Travellers renting a car abroad', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'discovercars.com' OR LOWER(`name`) = 'discover cars') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ground-transport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Car rental comparison with clear fuel and insurance terms.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Discover Cars compares car rental offers and shows rental terms in one place: fuel and mileage policy and what coverage is included. In the app you can change dates, add a driver or upgrade the car, and review flexible cancellation terms.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Rental comparison
Fuel and mileage terms
Booking changes
Flexible cancellation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers renting a car abroad', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- INFOBUS — Потяги, автобуси й оренда авто, Авіаквитки та відстеження рейсів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'infobus.eu' OR LOWER(`name`) = 'infobus')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'INFOBUS', NULL, 'https://infobus.eu/', NULL, NULL, 'Квитки на автобуси, потяги й літаки, зокрема на міжнародні рейси з України.', 'Bus, train and flight tickets, including international routes from Ukraine.', 'INFOBUS — сервіс пошуку й купівлі квитків на автобуси, потяги й літаки. Квиток надходить одразу після оплати й зберігається в застосунку, за покупки нараховуються бонуси. Застосунок має український інтерфейс.', 'INFOBUS is a service for finding and buying bus, train and plane tickets. The ticket arrives right after payment and is stored in the app, and purchases earn bonuses. The app has a Ukrainian interface.', 'Автобуси, потяги й літаки
Квиток одразу після оплати
Бонуси за покупки
Український інтерфейс', 'Buses, trains and planes
Ticket right after payment
Purchase bonuses
Ukrainian interface', 'Ті, хто їздить автобусами між Україною та Європою', 'People travelling by bus between Ukraine and Europe', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'infobus.eu' OR LOWER(`name`) = 'infobus') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ground-transport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'flights' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Bus, train and flight tickets, including international routes from Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'INFOBUS is a service for finding and buying bus, train and plane tickets. The ticket arrives right after payment and is stored in the app, and purchases earn bonuses. The app has a Ukrainian interface.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Buses, trains and planes
Ticket right after payment
Purchase bonuses
Ukrainian interface', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People travelling by bus between Ukraine and Europe', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- GetYourGuide — Екскурсії та квитки до атракцій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getyourguide.com' OR LOWER(`name`) = 'getyourguide')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GetYourGuide', NULL, 'https://www.getyourguide.com/', NULL, NULL, 'Бронювання екскурсій, одноденних поїздок і квитків до атракцій по всьому світу.', 'Book tours, day trips and attraction tickets worldwide.', 'GetYourGuide допомагає знайти й забронювати екскурсії, одноденні поїздки та активності — культура, їжа, пригоди, природа — а також квитки до головних музеїв і пам’яток. Квитки зберігаються в застосунку, є варіанти в останню хвилину; застосунок має український інтерфейс.', 'GetYourGuide helps you find and book tours, day trips and activities (culture, food, adventure, nature) plus tickets to top museums and attractions. Tickets are stored in the app, last-minute options are available, and the app has a Ukrainian interface.', 'Екскурсії й одноденні поїздки
Квитки до музеїв і пам’яток
Бронювання в останню хвилину
Український інтерфейс', 'Tours and day trips
Museum and attraction tickets
Last-minute bookings
Ukrainian interface', 'Мандрівники, які планують, чим зайнятися на місці', 'Travellers planning what to do at their destination', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getyourguide.com' OR LOWER(`name`) = 'getyourguide') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tours-activities' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Book tours, day trips and attraction tickets worldwide.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'GetYourGuide helps you find and book tours, day trips and activities (culture, food, adventure, nature) plus tickets to top museums and attractions. Tickets are stored in the app, last-minute options are available, and the app has a Ukrainian interface.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tours and day trips
Museum and attraction tickets
Last-minute bookings
Ukrainian interface', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers planning what to do at their destination', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Viator — Екскурсії та квитки до атракцій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'viator.com' OR LOWER(`name`) = 'viator')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Viator', NULL, 'https://www.viator.com/', NULL, NULL, 'Каталог екскурсій і активностей від Tripadvisor з гнучкими умовами.', 'Tripadvisor’s catalogue of tours and activities with flexible terms.', 'Viator (компанія Tripadvisor) пропонує екскурсії й активності по всьому світу з гнучкими умовами скасування та доступністю в останню хвилину. У застосунку можна шукати ідеї, бронювати й тримати квитки під рукою.', 'Viator (a Tripadvisor company) offers tours and activities worldwide with flexible cancellation and last-minute availability. In the app you can browse ideas, book and keep tickets at hand.', 'Екскурсії по всьому світу
Гнучке скасування
Бронювання в останню хвилину
Квитки в застосунку', 'Tours worldwide
Flexible cancellation
Last-minute availability
Tickets in the app', 'Мандрівники, які шукають екскурсії та враження', 'Travellers looking for tours and experiences', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'viator.com' OR LOWER(`name`) = 'viator') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tours-activities' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tripadvisor’s catalogue of tours and activities with flexible terms.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Viator (a Tripadvisor company) offers tours and activities worldwide with flexible cancellation and last-minute availability. In the app you can browse ideas, book and keep tickets at hand.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tours worldwide
Flexible cancellation
Last-minute availability
Tickets in the app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers looking for tours and experiences', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Klook — Екскурсії та квитки до атракцій, Бронювання готелів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'klook.com' OR LOWER(`name`) = 'klook')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Klook', NULL, 'https://www.klook.com/', NULL, NULL, 'Активності, екскурсії, готелі й оренда авто з акцентом на Азію.', 'Activities, tours, hotels and car rentals with a focus on Asia.', 'Klook — платформа для бронювання місцевих активностей, одноденних турів, готелів і оренди авто. Каталог включає тисячі активностей у світі з відібраними, перевіреними пропозиціями; сервіс особливо поширений в Азії.', 'Klook is a platform for booking local activities, day tours, hotels and car rentals. The catalogue includes thousands of activities worldwide with hand-picked offers; the service is especially popular in Asia.', 'Тисячі активностей
Одноденні тури
Готелі й оренда авто
Пропозиції в Азії', 'Thousands of activities
Day tours
Hotels and car rentals
Deals in Asia', 'Мандрівники до Азії та всі, хто шукає активності на місці', 'Travellers to Asia and anyone looking for local activities', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'klook.com' OR LOWER(`name`) = 'klook') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tours-activities' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Activities, tours, hotels and car rentals with a focus on Asia.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Klook is a platform for booking local activities, day tours, hotels and car rentals. The catalogue includes thousands of activities worldwide with hand-picked offers; the service is especially popular in Asia.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Thousands of activities
Day tours
Hotels and car rentals
Deals in Asia', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers to Asia and anyone looking for local activities', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tiqets — Екскурсії та квитки до атракцій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tiqets.com' OR LOWER(`name`) = 'tiqets')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tiqets', NULL, 'https://www.tiqets.com/', NULL, NULL, 'Електронні квитки до музеїв і атракцій, часто без черги.', 'Mobile tickets to museums and attractions, often skip-the-line.', 'Tiqets продає електронні квитки до музеїв, пам’яток і атракцій. Квиток надходить у смартфон одразу, а сотні закладів мають варіанти без черги. У застосунку можна переглядати заклади й читати відгуки.', 'Tiqets sells mobile tickets to museums, landmarks and attractions. Tickets arrive on your phone instantly, and hundreds of venues offer skip-the-line options. The app lets you browse venues and read reviews.', 'Електронні квитки
Без черги в сотнях закладів
Відгуки про заклади
Миттєва доставка квитка', 'Mobile tickets
Skip-the-line at hundreds of venues
Venue reviews
Instant ticket delivery', 'Ті, хто планує відвідати музеї й атракції в поїздці', 'People planning museum and attraction visits on a trip', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tiqets.com' OR LOWER(`name`) = 'tiqets') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tours-activities' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mobile tickets to museums and attractions, often skip-the-line.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tiqets sells mobile tickets to museums, landmarks and attractions. Tickets arrive on your phone instantly, and hundreds of venues offer skip-the-line options. The app lets you browse venues and read reviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Mobile tickets
Skip-the-line at hundreds of venues
Venue reviews
Instant ticket delivery', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People planning museum and attraction visits on a trip', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно для мандрівника', 'Free for travellers', 0.00, 'free', 'Застосунок і пошук безкоштовні; ви оплачуєте лише саме бронювання (проживання, квитки, оренду).', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно для мандрівника' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free for travellers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The app and search are free; you only pay for the booking itself (stay, tickets, rental).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Trip Planner AI — АІ-планувальники подорожей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tripplanner.ai' OR LOWER(`name`) = 'trip planner ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Trip Planner AI', NULL, 'https://tripplanner.ai/', NULL, NULL, 'АІ-конструктор маршрутів: план поїздки з рейсами, готелями й активностями за хвилини.', 'AI itinerary builder: a trip plan with flights, hotels and activities in minutes.', 'Trip Planner AI (tripplanner.ai) за датами й напрямками складає повний план поїздки — рейси, готелі, активності, час і маршрути між точками, оцінку бюджету. План підлаштовується під стиль подорожі (сімейна, романтична, автоподорож), а ціни в реальному часі можна порівняти й перейти до бронювання.', 'Trip Planner AI (tripplanner.ai) builds a full trip plan from your dates and destinations: flights, hotels, activities, timing, routes between stops and a budget estimate. The plan adapts to your travel style (family, romantic, road trip), and real-time prices can be compared before booking.', 'Генерація маршруту АІ
Рейси, готелі й активності
Оцінка бюджету
Підлаштування під стиль подорожі
Ціни в реальному часі', 'AI itinerary generation
Flights, hotels and activities
Budget estimate
Adapts to travel style
Real-time prices', 'Ті, хто хоче швидко отримати готовий план поїздки', 'People who want a ready-made trip plan quickly', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tripplanner.ai' OR LOWER(`name`) = 'trip planner ai') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'trip-planners' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI itinerary builder: a trip plan with flights, hotels and activities in minutes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Trip Planner AI (tripplanner.ai) builds a full trip plan from your dates and destinations: flights, hotels, activities, timing, routes between stops and a budget estimate. The plan adapts to your travel style (family, romantic, road trip), and real-time prices can be compared before booking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI itinerary generation
Flights, hotels and activities
Budget estimate
Adapts to travel style
Real-time prices', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want a ready-made trip plan quickly', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовна версія; частина функцій — у платній підписці.', 'A free version is available; some features require a paid subscription.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free version is available; some features require a paid subscription.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни платних функцій — на офіційному сайті.', 'Current prices for paid features are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices for paid features are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tripsy — АІ-планувальники подорожей
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tripsy.app' OR LOWER(`name`) = 'tripsy')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tripsy', NULL, 'https://tripsy.app/', NULL, NULL, 'Планувальник поїздок: маршрут по днях, бронювання й витрати в одному застосунку.', 'Trip planner: day-by-day itinerary, reservations and expenses in one app.', 'Tripsy збирає рейси, готелі, активності, бронювання й витрати подорожі в одному місці та будує маршрут по днях, доступний офлайн. Застосунок перетворює скриншоти, документи, вставлений текст і списки Google Maps чи Apple Maps на місця й бронювання; його можна підключити до сумісного АІ-асистента, щоб редагувати поїздку в розмові. Частина функцій — у Tripsy Pro (підписка або разова покупка).', 'Tripsy brings flights, hotels, activities, reservations and travel expenses together and builds a day-by-day itinerary available offline. It turns screenshots, documents, pasted text and Google Maps or Apple Maps lists into places and reservations, and can connect to a compatible AI assistant to edit trips through conversation. Some features need Tripsy Pro (subscription or one-time purchase).', 'Маршрут по днях
Імпорт зі скриншотів і документів
Підключення АІ-асистента
Облік витрат
Офлайн-доступ', 'Day-by-day itinerary
Import from screenshots and documents
AI assistant connection
Expense tracking
Offline access', 'Ті, хто самостійно планує складні поїздки з кількома містами', 'Independent travellers planning multi-city trips', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-11 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tripsy.app' OR LOWER(`name`) = 'tripsy') ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'trip-planners' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Trip planner: day-by-day itinerary, reservations and expenses in one app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tripsy brings flights, hotels, activities, reservations and travel expenses together and builds a day-by-day itinerary available offline. It turns screenshots, documents, pasted text and Google Maps or Apple Maps lists into places and reservations, and can connect to a compatible AI assistant to edit trips through conversation. Some features need Tripsy Pro (subscription or one-time purchase).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Day-by-day itinerary
Import from screenshots and documents
AI assistant connection
Expense tracking
Offline access', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Independent travellers planning multi-city trips', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовна версія; частина функцій — у платній підписці.', 'A free version is available; some features require a paid subscription.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free version is available; some features require a paid subscription.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни платних функцій — на офіційному сайті.', 'Current prices for paid features are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices for paid features are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Наявні продукти → нові підкатегорії (якщо є в базі; за точною назвою)
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'KAYAK' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'flights' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ground-transport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'Hopper' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'flights' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'Tripadvisor' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tours-activities' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hotel-booking' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'Mindtrip' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'trip-planners' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'Layla' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'trip-planners' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'Wonderplan' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'trip-planners' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'iplan.ai' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'trip-planners' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'Wanderlog' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'trip-planners' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'TripIt' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'trip-planners' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'GuideGeek' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'trip-planners' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'Roadtrippers' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'trip-planners' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'Укрзалізниця' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ground-transport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'proizd.ua' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ground-transport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'BlaBlaCar' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ground-transport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;

-- Пошук Елі: слова-наміри → підкатегорії «Подорожей»
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'готел', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'hotel-booking' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'hotel-booking' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'готел' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'hotel-booking' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'отел', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'hotel-booking' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'hotel-booking' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'отел' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'hotel-booking' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'hotel', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'hotel-booking' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'hotel-booking' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'hotel' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'hotel-booking' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'hotels', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'hotel-booking' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'hotel-booking' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'hotels' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'hotel-booking' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'хостел', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'vacation-rentals' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'vacation-rentals' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'хостел' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'vacation-rentals' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'апартамент', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'vacation-rentals' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'vacation-rentals' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'апартамент' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'vacation-rentals' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'hostel', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'vacation-rentals' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'vacation-rentals' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'hostel' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'vacation-rentals' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'airbnb', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'vacation-rentals' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'vacation-rentals' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'airbnb' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'vacation-rentals' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'готельн', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'hotel-loyalty' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'hotel-loyalty' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'готельн' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'hotel-loyalty' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'авіаквитк', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'flights' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'flights' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'авіаквитк' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'flights' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'рейс', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'flights' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'flights' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'рейс' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'flights' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'літак', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'flights' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'flights' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'літак' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'flights' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'flight', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'flights' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'flights' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'flight' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'flights' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'потяг', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'ground-transport' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'ground-transport' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'потяг' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'ground-transport' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'поїзд', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'ground-transport' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'ground-transport' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'поїзд' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'ground-transport' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'автобус', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'ground-transport' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'ground-transport' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'автобус' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'ground-transport' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'прокат', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'ground-transport' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'ground-transport' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'прокат' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'ground-transport' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'екскурс', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'tours-activities' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'tours-activities' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'екскурс' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'tours-activities' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'атракц', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'tours-activities' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'tours-activities' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'атракц' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'tours-activities' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'tour', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'tours-activities' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'tours-activities' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'tour' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'tours-activities' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'подорож', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'trip-planners' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'trip-planners' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'подорож' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'trip-planners' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'мандрівк', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'trip-planners' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'trip-planners' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'мандрівк' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'trip-planners' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'маршрут', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'trip-planners' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'trip-planners' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'маршрут' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'trip-planners' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'travel', (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'trip-planners' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'trip-planners' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'travel' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'travel-tourism' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'travel-tourism' AND s.slug = 'trip-planners' LIMIT 1));

