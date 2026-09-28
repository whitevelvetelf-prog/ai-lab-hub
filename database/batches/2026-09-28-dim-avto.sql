SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія продуктів 2026-09-28: «Мій дім» → Авто — 25 продуктів
-- Нова підкатегорія «Авто» (auto) у категорії «Мій дім» (my-home).
-- Автор (created_by) — користувач whitevelvetelf@gmail.com (id шукається за email). partnership_status = 'found', status = 'published'.
--  [Діагностика несправностей]
--   AI Mechanic — Авто
--   OBDAI — Авто
--   TorqueBot — Авто
--   Automotive AI — Авто
--   FIXD — Авто
--   BlueDriver — Авто
--   Torque Pro — Авто
--   CarScanner — Авто
--  [Облік обслуговування та витрат]
--   CarJourney — Авто
--   GarageHub — Авто
--   Fuelly — Авто
--   Drivvo — Авто
--   aCar — Авто
--   Carfax Car Care — Авто
--  [Навігація та дорога]
--   Google Maps — Авто
--   Waze — Авто
--   Sygic GPS Navigation — Авто
--   HERE WeGo — Авто
--   GasBuddy — Авто
--   EasyPark — Авто
--   ParkMobile — Авто
--  [Електромобілі]
--   PlugShare — Авто
--   A Better Route Planner (ABRP) — Авто
--   ChargePoint — Авто
--  [Подорожі авто]
--   Roadtrippers — Авто
--
-- Застосування (phpMyAdmin хостингу, БД gu621051_ailabhublive): вкладка SQL (або «Импорт» як .sql.zip) → вставити вміст файлу → Вперёд.
-- БЕЗ ФІКСОВАНИХ id: підкатегорія додається, лише якщо в «Мій дім» ще немає slug 'auto'; продукт — лише якщо
-- немає продукту з тим самим нормалізованим URL (без http(s)://, www., кінцевого слеша, регістру) АБО з тією самою назвою.
-- Якщо продукт уже є (напр. Google Maps, Waze) — його не дублюємо, а лише прив'язуємо до «Мій дім» / «Авто»; тарифи не додаємо.
-- Безпечно повторювати; жодних DROP / DELETE / перестворення таблиць.
-- Дані — з постановки задачі. Повний опис — розгорнутий варіант короткого без нових фактів. Точні ціни не підтверджені:
-- замість цифр — план «Ціна за запитом / див. сайт» (price NULL).
-- =====================================================================

INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT c.`id`, 'Авто', 'Auto', 'auto' FROM `categories` c WHERE c.`slug` = 'my-home' AND NOT EXISTS (SELECT 1 FROM `subcategories` s WHERE s.`category_id` = c.`id` AND s.`slug` = 'auto');
SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);

-- AI Mechanic — Авто (freemium)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'AI Mechanic', NULL, 'https://play.google.com/store/apps/details?id=mechsit.ai.obd2gpt', NULL, NULL, 'AI-діагностика стану авто через OBD2-сканер, звіти для механіка й для перепродажу.', 'Мобільний застосунок, який за допомогою OBD2-сканера зчитує дані з автомобіля та за допомогою штучного інтелекту оцінює його технічний стан. На основі діагностики формує звіти: для механіка — щоб швидше знайти проблему, і для перепродажу — щоб показати покупцю стан авто.', NULL, NULL, 'mobile', 'basic', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=mechsit.ai.obd2gpt' OR LOWER(`name`) = LOWER('AI Mechanic')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=mechsit.ai.obd2gpt' OR LOWER(`name`) = LOWER('AI Mechanic')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Ціна за запитом / див. сайт', NULL, 'month', 'Платні можливості; точну ціну не підтверджено — див. офіційний сайт' FROM DUAL WHERE @new = 1;

-- OBDAI — Авто (freemium)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'OBDAI', NULL, 'https://obdai.app', NULL, NULL, 'AI-асистент ARIA аналізує живі дані з OBD-II порту та шукає першопричину несправності.', 'Мобільний застосунок із вбудованим AI-асистентом ARIA, який підключається до OBD-II порту автомобіля й аналізує живі дані з нього. Замість простого переліку кодів помилок асистент намагається знайти першопричину несправності.', NULL, NULL, 'mobile', 'basic', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'obdai.app' OR LOWER(`name`) = LOWER('OBDAI')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'obdai.app' OR LOWER(`name`) = LOWER('OBDAI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Ціна за запитом / див. сайт', NULL, 'month', 'Платні можливості; точну ціну не підтверджено — див. офіційний сайт' FROM DUAL WHERE @new = 1;

-- TorqueBot — Авто (freemium)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'TorqueBot', NULL, 'https://torquebot.io', NULL, NULL, 'AI-механік: опишіть симптом і отримайте ймовірні причини та орієнтовну вартість ремонту.', 'AI-механік, якому достатньо описати симптом несправності звичайними словами. У відповідь сервіс називає ймовірні причини проблеми та орієнтовну вартість ремонту, щоб водій розумів, чого чекати, ще до візиту на СТО. Доступний у браузері й на мобільних пристроях.', NULL, NULL, 'web,mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'torquebot.io' OR LOWER(`name`) = LOWER('TorqueBot')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'torquebot.io' OR LOWER(`name`) = LOWER('TorqueBot')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Ціна за запитом / див. сайт', NULL, 'month', 'Платні можливості; точну ціну не підтверджено — див. офіційний сайт' FROM DUAL WHERE @new = 1;

-- Automotive AI — Авто (free)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'Automotive AI', NULL, 'https://play.google.com/store/apps/details?id=app.automotiveai', NULL, NULL, 'AI-діагноз проблеми за описом чи фото індикатора, пошук сертифікованих майстрів і відео-інструкції.', 'Мобільний застосунок, що ставить AI-діагноз проблемі з авто за текстовим описом або за фото індикатора на приладовій панелі. Крім діагнозу, допомагає знайти сертифікованих майстрів і пропонує відео-інструкції для самостійного вирішення проблеми.', NULL, NULL, 'mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=app.automotiveai' OR LOWER(`name`) = LOWER('Automotive AI')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=app.automotiveai' OR LOWER(`name`) = LOWER('Automotive AI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Безкоштовно' FROM DUAL WHERE @new = 1;

-- FIXD — Авто (freemium)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'FIXD', NULL, 'https://fixdapp.com', NULL, NULL, 'Датчик і застосунок, що переводить коди несправностей у зрозумілі пояснення простою мовою.', 'Комплект із датчика, який підключається до автомобіля, і мобільного застосунку. Застосунок перекладає коди несправностей у зрозумілі пояснення простою мовою, тож розібратися в проблемі можна без технічної підготовки.', NULL, NULL, 'mobile', 'basic', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fixdapp.com' OR LOWER(`name`) = LOWER('FIXD')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fixdapp.com' OR LOWER(`name`) = LOWER('FIXD')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Ціна за запитом / див. сайт', NULL, 'month', 'Платні можливості; точну ціну не підтверджено — див. офіційний сайт' FROM DUAL WHERE @new = 1;

-- BlueDriver — Авто (paid)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'BlueDriver', NULL, 'https://bluedriver.com', NULL, NULL, 'Професійний Bluetooth-сканер з розшифровкою кодів і рекомендаціями ремонту.', 'Професійний Bluetooth-сканер для діагностики автомобіля, що працює разом із мобільним застосунком. Розшифровує коди несправностей і дає рекомендації щодо ремонту.', NULL, NULL, 'mobile', 'basic', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bluedriver.com' OR LOWER(`name`) = LOWER('BlueDriver')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bluedriver.com' OR LOWER(`name`) = LOWER('BlueDriver')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Ціна за запитом / див. сайт', NULL, 'one_time', 'Платний продукт; точну ціну не підтверджено — див. офіційний сайт' FROM DUAL WHERE @new = 1;

-- Torque Pro — Авто (paid)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'Torque Pro', NULL, 'https://torque-bhp.com', NULL, NULL, 'Показники двигуна, витрата пального й коди помилок у реальному часі на екрані телефону.', 'Мобільний застосунок, що виводить на екран телефону показники двигуна, витрату пального й коди помилок у реальному часі. Корисний тим, хто хоче постійно стежити за станом авто під час руху.', NULL, NULL, 'mobile', 'basic', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'torque-bhp.com' OR LOWER(`name`) = LOWER('Torque Pro')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'torque-bhp.com' OR LOWER(`name`) = LOWER('Torque Pro')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Ціна за запитом / див. сайт', NULL, 'one_time', 'Платний продукт; точну ціну не підтверджено — див. офіційний сайт' FROM DUAL WHERE @new = 1;

-- CarScanner — Авто (freemium)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'CarScanner', NULL, 'https://carscanner.info', NULL, NULL, 'Застосунок для читання даних авто через OBD2 з розширеною діагностикою.', 'Мобільний застосунок, який через OBD2-адаптер зчитує дані автомобіля й надає розширені можливості діагностики.', NULL, NULL, 'mobile', 'basic', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'carscanner.info' OR LOWER(`name`) = LOWER('CarScanner')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'carscanner.info' OR LOWER(`name`) = LOWER('CarScanner')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Ціна за запитом / див. сайт', NULL, 'month', 'Платні можливості; точну ціну не підтверджено — див. офіційний сайт' FROM DUAL WHERE @new = 1;

-- CarJourney — Авто (freemium)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'CarJourney', NULL, 'https://carjourney.io', NULL, NULL, 'Журнал обслуговування з AI-скануванням чеків та історією авто, яку можна показати покупцю.', 'Журнал обслуговування автомобіля, у який чеки додаються AI-скануванням замість ручного введення. Зберігає історію авто, яку можна показати покупцю під час продажу. Працює у браузері й на мобільних пристроях.', NULL, NULL, 'web,mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'carjourney.io' OR LOWER(`name`) = LOWER('CarJourney')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'carjourney.io' OR LOWER(`name`) = LOWER('CarJourney')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Ціна за запитом / див. сайт', NULL, 'month', 'Платні можливості; точну ціну не підтверджено — див. офіційний сайт' FROM DUAL WHERE @new = 1;

-- GarageHub — Авто (freemium)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'GarageHub', NULL, 'https://getgaragehub.com', NULL, NULL, 'Детальний облік ремонтів, запчастин і витрат для тих, хто сам обслуговує авто.', 'Сервіс для детального обліку ремонтів, запчастин і витрат, створений для тих, хто сам обслуговує свій автомобіль. Допомагає тримати всю історію робіт в одному місці. Доступний у браузері й на мобільних пристроях.', NULL, NULL, 'web,mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getgaragehub.com' OR LOWER(`name`) = LOWER('GarageHub')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getgaragehub.com' OR LOWER(`name`) = LOWER('GarageHub')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Ціна за запитом / див. сайт', NULL, 'month', 'Платні можливості; точну ціну не підтверджено — див. офіційний сайт' FROM DUAL WHERE @new = 1;

-- Fuelly — Авто (free)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fuelly', NULL, 'https://fuelly.com', NULL, NULL, 'Облік витрати пального й порівняння з іншими власниками такої самої моделі.', 'Сервіс для обліку витрати пального, який дозволяє порівняти свої показники з іншими власниками такої самої моделі авто. Доступний у браузері й на мобільних пристроях.', NULL, NULL, 'web,mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fuelly.com' OR LOWER(`name`) = LOWER('Fuelly')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fuelly.com' OR LOWER(`name`) = LOWER('Fuelly')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Безкоштовно' FROM DUAL WHERE @new = 1;

-- Drivvo — Авто (freemium)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'Drivvo', NULL, 'https://drivvo.com', NULL, NULL, 'Облік витрат на пальне, обслуговування й нагадування про сервіс.', 'Мобільний застосунок для обліку витрат на автомобіль: пальне й обслуговування. Нагадує про планове сервісне обслуговування, щоб нічого не пропустити.', NULL, NULL, 'mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'drivvo.com' OR LOWER(`name`) = LOWER('Drivvo')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'drivvo.com' OR LOWER(`name`) = LOWER('Drivvo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Ціна за запитом / див. сайт', NULL, 'month', 'Платні можливості; точну ціну не підтверджено — див. офіційний сайт' FROM DUAL WHERE @new = 1;

-- aCar — Авто (freemium)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'aCar', NULL, 'https://acarapp.com', NULL, NULL, 'Комплексне ведення авто на Android: пальне, сервіс, витрати, звіти.', 'Застосунок для Android для комплексного ведення автомобіля: облік пального, сервісного обслуговування й інших витрат зі звітами за ними.', NULL, NULL, 'mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'acarapp.com' OR LOWER(`name`) = LOWER('aCar')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'acarapp.com' OR LOWER(`name`) = LOWER('aCar')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Ціна за запитом / див. сайт', NULL, 'month', 'Платні можливості; точну ціну не підтверджено — див. офіційний сайт' FROM DUAL WHERE @new = 1;

-- Carfax Car Care — Авто (free)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'Carfax Car Care', NULL, 'https://carfax.com/carcare', NULL, NULL, 'Нагадування про сервіс і історія обслуговування вашого авто.', 'Сервіс, що нагадує про планове обслуговування й зберігає історію обслуговування вашого авто. Доступний у браузері й на мобільних пристроях.', NULL, NULL, 'web,mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'carfax.com/carcare' OR LOWER(`name`) = LOWER('Carfax Car Care')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'carfax.com/carcare' OR LOWER(`name`) = LOWER('Carfax Car Care')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Безкоштовно' FROM DUAL WHERE @new = 1;

-- Google Maps — Авто (free)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'Google Maps', NULL, 'https://maps.google.com', NULL, NULL, 'Навігація, трафік, офлайн-карти й пошук маршрутів для водіїв.', 'Картографічний сервіс із навігацією для водіїв: показує трафік, будує маршрути й дозволяє завантажити офлайн-карти для поїздок без інтернету. Працює у браузері й на мобільних пристроях.', NULL, NULL, 'web,mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'maps.google.com' OR LOWER(`name`) = LOWER('Google Maps')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'maps.google.com' OR LOWER(`name`) = LOWER('Google Maps')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Безкоштовно' FROM DUAL WHERE @new = 1;

-- Waze — Авто (free)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'Waze', NULL, 'https://waze.com', NULL, NULL, 'Навігація зі спільнотними попередженнями про аварії, камери й перекриття доріг у реальному часі.', 'Мобільна навігація, яка спирається на спільноту водіїв: користувачі в реальному часі попереджають одне одного про аварії, камери й перекриття доріг.', NULL, NULL, 'mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'waze.com' OR LOWER(`name`) = LOWER('Waze')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'waze.com' OR LOWER(`name`) = LOWER('Waze')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Безкоштовно' FROM DUAL WHERE @new = 1;

-- Sygic GPS Navigation — Авто (freemium)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sygic GPS Navigation', NULL, 'https://sygic.com', NULL, NULL, 'Навігація з офлайн-картами понад 200 країн і попередженнями про ліміти швидкості.', 'Мобільна GPS-навігація з офлайн-картами понад 200 країн, тож маршрут можна прокладати без мобільного інтернету. Попереджає про обмеження швидкості на дорозі.', NULL, NULL, 'mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sygic.com' OR LOWER(`name`) = LOWER('Sygic GPS Navigation')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sygic.com' OR LOWER(`name`) = LOWER('Sygic GPS Navigation')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Ціна за запитом / див. сайт', NULL, 'month', 'Платні можливості; точну ціну не підтверджено — див. офіційний сайт' FROM DUAL WHERE @new = 1;

-- HERE WeGo — Авто (free)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'HERE WeGo', NULL, 'https://wego.here.com', NULL, NULL, 'Надійна навігація з офлайн-картами для поїздок без зв''язку.', 'Навігаційний сервіс з офлайн-картами, який допомагає прокладати маршрути в поїздках, де немає зв''язку. Доступний у браузері й на мобільних пристроях.', NULL, NULL, 'web,mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wego.here.com' OR LOWER(`name`) = LOWER('HERE WeGo')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wego.here.com' OR LOWER(`name`) = LOWER('HERE WeGo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Безкоштовно' FROM DUAL WHERE @new = 1;

-- GasBuddy — Авто (freemium)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'GasBuddy', NULL, 'https://gasbuddy.com', NULL, NULL, 'Пошук найдешевшого пального поблизу за цінами від спільноти.', 'Мобільний застосунок для пошуку найдешевшого пального поблизу. Ціни на АЗС оновлює спільнота користувачів.', NULL, NULL, 'mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gasbuddy.com' OR LOWER(`name`) = LOWER('GasBuddy')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gasbuddy.com' OR LOWER(`name`) = LOWER('GasBuddy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Ціна за запитом / див. сайт', NULL, 'month', 'Платні можливості; точну ціну не підтверджено — див. офіційний сайт' FROM DUAL WHERE @new = 1;

-- EasyPark — Авто (free)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'EasyPark', NULL, 'https://easypark.com', NULL, NULL, 'Пошук і оплата паркування зі смартфона.', 'Мобільний застосунок, що допомагає знайти паркування й оплатити його прямо зі смартфона.', NULL, NULL, 'mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'easypark.com' OR LOWER(`name`) = LOWER('EasyPark')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'easypark.com' OR LOWER(`name`) = LOWER('EasyPark')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Безкоштовно' FROM DUAL WHERE @new = 1;

-- ParkMobile — Авто (free)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'ParkMobile', NULL, 'https://parkmobile.io', NULL, NULL, 'Пошук, бронювання й оплата паркування з телефону.', 'Мобільний застосунок для пошуку, бронювання й оплати паркування з телефону.', NULL, NULL, 'mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'parkmobile.io' OR LOWER(`name`) = LOWER('ParkMobile')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'parkmobile.io' OR LOWER(`name`) = LOWER('ParkMobile')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Безкоштовно' FROM DUAL WHERE @new = 1;

-- PlugShare — Авто (freemium)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'PlugShare', NULL, 'https://plugshare.com', NULL, NULL, 'Найбільша карта зарядних станцій з відгуками водіїв і поточним статусом.', 'Найбільша карта зарядних станцій для електромобілів. Для кожної станції показує відгуки водіїв і її поточний статус. Доступна у браузері й на мобільних пристроях.', NULL, NULL, 'web,mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'plugshare.com' OR LOWER(`name`) = LOWER('PlugShare')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'plugshare.com' OR LOWER(`name`) = LOWER('PlugShare')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Ціна за запитом / див. сайт', NULL, 'month', 'Платні можливості; точну ціну не підтверджено — див. офіційний сайт' FROM DUAL WHERE @new = 1;

-- A Better Route Planner (ABRP) — Авто (freemium)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'A Better Route Planner (ABRP)', NULL, 'https://abetterrouteplanner.com', NULL, NULL, 'Планування маршрутів для електромобілів з урахуванням запасу ходу й зарядок.', 'Планувальник маршрутів для електромобілів, який враховує запас ходу авто й розташування зарядних станцій на шляху. Доступний у браузері й на мобільних пристроях.', NULL, NULL, 'web,mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'abetterrouteplanner.com' OR LOWER(`name`) = LOWER('A Better Route Planner (ABRP)')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'abetterrouteplanner.com' OR LOWER(`name`) = LOWER('A Better Route Planner (ABRP)')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Ціна за запитом / див. сайт', NULL, 'month', 'Платні можливості; точну ціну не підтверджено — див. офіційний сайт' FROM DUAL WHERE @new = 1;

-- ChargePoint — Авто (free)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'ChargePoint', NULL, 'https://chargepoint.com', NULL, NULL, 'Мережа зарядних станцій з оплатою й керуванням сесією у застосунку.', 'Мережа зарядних станцій для електромобілів із мобільним застосунком, у якому можна оплатити зарядку й керувати зарядною сесією.', NULL, NULL, 'mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chargepoint.com' OR LOWER(`name`) = LOWER('ChargePoint')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chargepoint.com' OR LOWER(`name`) = LOWER('ChargePoint')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Безкоштовно' FROM DUAL WHERE @new = 1;

-- Roadtrippers — Авто (freemium)
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_by`, `created_at`) SELECT 'Roadtrippers', NULL, 'https://roadtrippers.com', NULL, NULL, 'Планування автомандрівок з цікавими місцями по маршруту.', 'Сервіс для планування автомандрівок, який підказує цікаві місця вздовж маршруту. Доступний у браузері й на мобільних пристроях.', NULL, NULL, 'web,mobile', 'none', 'published', 'found', @uid, '2026-09-28 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'roadtrippers.com' OR LOWER(`name`) = LOWER('Roadtrippers')));
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'roadtrippers.com' OR LOWER(`name`) = LOWER('Roadtrippers')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Ціна за запитом / див. сайт', NULL, 'month', 'Платні можливості; точну ціну не підтверджено — див. офіційний сайт' FROM DUAL WHERE @new = 1;

SELECT
    (SELECT COUNT(*) FROM `product_subcategories` ps JOIN `subcategories` s ON s.`id` = ps.`subcategory_id` JOIN `categories` c ON c.`id` = s.`category_id` WHERE c.`slug` = 'my-home' AND s.`slug` = 'auto') AS auto_products,
    (SELECT COUNT(*) FROM `product_categories` pc JOIN `categories` c ON c.`id` = pc.`category_id` WHERE c.`slug` = 'my-home') AS my_home_products;
