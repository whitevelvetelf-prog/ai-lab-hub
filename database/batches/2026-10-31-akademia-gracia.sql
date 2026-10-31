SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-31: 1 новий продукт, наявні категорії (нових категорій і підкатегорій НЕ створює):
--   Akademia Gracia — «Українські додатки» → «Онлайн-запис на послуги» (ukrainian-apps / ua-booking)
--                   + «Здоров'я та краса» → «Реабілітація та фізіотерапія» (health-beauty / rehabilitation-physiotherapy)
-- Тексти UA/EN — лише за описами в App Store (id1477434749, регіон UA) і Google Play (com.yclients.widget.s197590),
--   звірено 2026-10-31: безкоштовний, без покупок у застосунку; iOS 13+ і Android; українська, англійська та ще 23 мови.
-- Логотип — іконка з App Store, файл public/assets/images/logos/akademia-gracia.png (залити разом із кодом).
-- Партнерської програми немає: partnership_status = no_partnership.
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою;
--   підкатегорії — за slug (запасний варіант — name_en). Якщо категорії/підкатегорії немає — прив'язка просто пропускається.
-- Застосування: phpMyAdmin → БД → «SQL» → вставити → «Вперёд». Повторний запуск безпечний.
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat_ua = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
SET @sub_ua = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat_ua AND (`slug` = 'ua-booking' OR `name_en` = 'Online Booking & Appointments') ORDER BY `slug` = 'ua-booking' DESC LIMIT 1);
SET @cat_health = (SELECT `id` FROM `categories` WHERE `slug` = 'health-beauty' LIMIT 1);
SET @sub_health = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat_health AND (`slug` = 'rehabilitation-physiotherapy' OR `name_en` = 'Rehabilitation & Physiotherapy') ORDER BY `slug` = 'rehabilitation-physiotherapy' DESC LIMIT 1);

-- Akademia Gracia
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE `official_url` LIKE '%id1477434749%' OR `official_url` LIKE '%com.yclients.widget.s197590%' OR LOWER(`name`) IN ('akademia gracia', 'академія грація')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Akademia Gracia', 'assets/images/logos/akademia-gracia.png', 'https://apps.apple.com/ua/app/akademia-gracia/id1477434749', NULL, NULL, 'Застосунок для клієнтів Міжнародного центру корекції постави «Академія Грація» Оксани Слінько: запис онлайн, свої записи й абонементи в телефоні.', 'An app for clients of Oksana Slinko''s International Posture Correction Centre "Akademia Gracia": book online and see your appointments and memberships on your phone.', 'Akademia Gracia — клієнтський застосунок Міжнародного центру корекції постави Оксани Слінько «Академія Грація». У ньому клієнти центру записуються на відвідування, стежать за своїми записами й бачать свої абонементи. Застосунок безкоштовний і без покупок усередині. Він є для iPhone та iPad (iOS 13 і новіші) і для Android; інтерфейс доступний українською, англійською та ще 23 мовами. У Google Play розробником зазначено Altegio Europe, в App Store — Vladyslav Slinko. Для запису потрібно бути клієнтом центру.', 'Akademia Gracia is the client app of Oksana Slinko''s International Posture Correction Centre "Akademia Gracia". Clients of the centre use it to book visits, keep track of their appointments and see their memberships. The app is free with no in-app purchases. It is available for iPhone and iPad (iOS 13 or later) and for Android, with the interface in Ukrainian, English and 23 other languages. On Google Play the developer is listed as Altegio Europe, on the App Store as Vladyslav Slinko. Booking is for clients of the centre.', 'Онлайн-запис до центру
Відстеження своїх записів
Абонементи в застосунку
Безкоштовно, без покупок у застосунку
iPhone, iPad і Android', 'Online booking with the centre
Track your appointments
Memberships in the app
Free, no in-app purchases
iPhone, iPad and Android', 'Клієнтам Міжнародного центру корекції постави «Академія Грація» Оксани Слінько.', 'Clients of Oksana Slinko''s International Posture Correction Centre "Akademia Gracia".', 'mobile', 'none', 'published', 0, 'no_partnership', @uid, '2026-10-31 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE `official_url` LIKE '%id1477434749%' OR `official_url` LIKE '%com.yclients.widget.s197590%' OR LOWER(`name`) IN ('akademia gracia', 'академія грація') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat_ua FROM DUAL WHERE @pid IS NOT NULL AND @cat_ua IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub_ua FROM DUAL WHERE @pid IS NOT NULL AND @sub_ua IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat_health FROM DUAL WHERE @pid IS NOT NULL AND @cat_health IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub_health FROM DUAL WHERE @pid IS NOT NULL AND @sub_health IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app for clients of Oksana Slinko''s International Posture Correction Centre "Akademia Gracia": book online and see your appointments and memberships on your phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Akademia Gracia is the client app of Oksana Slinko''s International Posture Correction Centre "Akademia Gracia". Clients of the centre use it to book visits, keep track of their appointments and see their memberships. The app is free with no in-app purchases. It is available for iPhone and iPad (iOS 13 or later) and for Android, with the interface in Ukrainian, English and 23 other languages. On Google Play the developer is listed as Altegio Europe, on the App Store as Vladyslav Slinko. Booking is for clients of the centre.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online booking with the centre
Track your appointments
Memberships in the app
Free, no in-app purchases
iPhone, iPad and Android', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Clients of Oksana Slinko''s International Posture Correction Centre "Akademia Gracia".', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовно в App Store і Google Play, без покупок у застосунку.', 'Free on the App Store and Google Play, no in-app purchases.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free on the App Store and Google Play, no in-app purchases.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Інтенти запасного пошуку Елі: «постава» → Реабілітація та фізіотерапія (раніше таких не було)
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'постав', @cat_health, @sub_health, 1 FROM DUAL WHERE @cat_health IS NOT NULL AND @sub_health IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'постав' AND si.category_id <=> @cat_health AND si.subcategory_id <=> @sub_health);
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'posture', @cat_health, @sub_health, 1 FROM DUAL WHERE @cat_health IS NOT NULL AND @sub_health IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'posture' AND si.category_id <=> @cat_health AND si.subcategory_id <=> @sub_health);
