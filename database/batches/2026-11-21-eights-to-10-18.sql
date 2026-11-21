SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-21: «Розважальні» й «Українські додатки» — 11 підкатегорій із 8 продуктами до 10.
-- + 18 нових продуктів і 4 прив'язки наявних (функцію звірено на офіційних сайтах 2026-11-21).
-- Якщо продукт із такою адресою чи назвою вже є — лише прив'язка, тексти не змінюються.
-- Тексти UA/EN — за офіційними сайтами, звірено 2026-11-21.
-- Прив'язки: Vidnoz AI і insMind (фільтр віку на офіційних сторінках) — age-transform; Ланет.TV — ua-movies; SHAFA — ua-classifieds.
-- Пропущено: Pica AI (заміна облич зі знаменитостями), bible.org.ua (порожня сторінка), 104.ua (тепер B2B-інжиніринг), Львівська майстерня шоколаду (на сайті не знайдено кав'ярень), GoGym (сайт російською).
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   Voice Changer (voicechanger.io) — voice-changers (новий)
--   Voice changer with effects — voice-changers (новий)
--   Радіо Марія — ua-faith (новий)
--   РІСУ — Релігійно-інформаційна служба України — ua-faith (новий)
--   Укртелеком — ua-telecom (новий)
--   Мережа Ланет — ua-telecom (новий)
--   Світ Кави — ua-cafes (новий)
--   ONE LOVE coffee — ua-cafes (новий)
--   OmegaTV — ua-movies (новий)
--   Real-estate.lviv.ua — ua-classifieds (новий)
--   DOU — ua-jobs (новий)
--   Happy Monday — ua-jobs (новий)
--   BACKSTAGE — ua-beauty (новий)
--   EasyWeek — ua-beauty (новий)
--   Svitlo.live — ua-energy (новий)
--   Вінницяобленерго — ua-energy (новий)
--   Total Fitness — ua-fitness (новий)
--   OLIMP Strong — ua-fitness (новий)
--   Vidnoz AI — age-transform (наявний, прив'язка)
--   insMind — age-transform (наявний, прив'язка)
--   Ланет.TV — ua-movies (наявний, прив'язка)
--   SHAFA — ua-classifieds (наявний, прив'язка)
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
-- Voice Changer (voicechanger.io)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'voicechanger.io' OR LOWER(`name`) = 'voice changer (voicechanger.io)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Voice Changer (voicechanger.io)', NULL, 'https://voicechanger.io', NULL, NULL, 'Безкоштовний онлайн-змінювач голосу: троль, привид, інопланетянин, телефон, луна та інші ефекти просто в браузері.', 'Free online voice changer: troll, ghost, alien, telephone, echo and other effects right in your browser.', 'Voice Changer — простий безкоштовний вебзастосунок, що змінює голос і додає ефекти. Можна записати голос із мікрофона або завантажити аудіофайл і застосувати ефект: глибокий голос троля чи монстра, «зворотну» луну, як у привида з фільму жахів, голос інопланетянина з дивним акцентом, телефон чи рацію, зіпсований гучномовець, велику залу з відлунням, коливання висоти тону. Голос можна зробити нижчим чи вищим або спотворити до невпізнанності.', 'Voice Changer is a simple free web app that transforms your voice and adds effects. Record from your microphone or upload an audio file, then apply an effect: a deep troll or monster voice, a reverse reverb like a ghost from a horror film, an alien voice with a strange accent, a telephone or walkie-talkie, a broken PA speaker, a large echoing hall, or wobbling pitch. You can make your voice deeper or higher, or distort it beyond recognition.', 'Запис із мікрофона або файл
Троль, привид, інопланетянин
Телефон і рація
Луна та реверс
Безкоштовно в браузері', 'Record from mic or upload a file
Troll, ghost and alien voices
Telephone and walkie-talkie
Echo and reverse reverb
Free in the browser', 'Усім, хто хоче посміятися з друзями чи озвучити смішне відео.', 'Anyone who wants a laugh with friends or a funny voice for a video.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'voicechanger.io' OR LOWER(`name`) = 'voice changer (voicechanger.io)') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'entertainment' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'voice-changers' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free online voice changer: troll, ghost, alien, telephone, echo and other effects right in your browser.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Voice Changer is a simple free web app that transforms your voice and adds effects. Record from your microphone or upload an audio file, then apply an effect: a deep troll or monster voice, a reverse reverb like a ghost from a horror film, an alien voice with a strange accent, a telephone or walkie-talkie, a broken PA speaker, a large echoing hall, or wobbling pitch. You can make your voice deeper or higher, or distort it beyond recognition.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Record from mic or upload a file
Troll, ghost and alien voices
Telephone and walkie-talkie
Echo and reverse reverb
Free in the browser', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone who wants a laugh with friends or a funny voice for a video.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовно для користувачів.', 'Free for users.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for users.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Voice changer with effects
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.baviux.voicechanger' OR LOWER(`name`) = 'voice changer with effects')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Voice changer with effects', NULL, 'https://play.google.com/store/apps/details?id=com.baviux.voicechanger', NULL, NULL, 'Android-додаток від Baviux: запишіть голос і додайте ефект — гелій, робот, монстр, білка, зомбі, задом наперед.', 'Android app by Baviux: record your voice and add an effect — helium, robot, monster, chipmunk, zombie, reverse.', 'Voice changer with effects — популярний Android-додаток студії Baviux для зміни голосу. Запишіть голос або імпортуйте готовий запис, застосуйте один із десятків ефектів (гелій, робот, гігант, задом наперед, монстр, інопланетянин, зомбі, білка тощо) і поділіться результатом із друзями. Запис можна зберегти, встановити як рингтон чи звук сповіщення або перетворити на зображення зі звуком. Додаток безкоштовний, містить рекламу й покупки в ньому.', 'Voice changer with effects is a popular Android app by Baviux. Record your voice or import an existing recording, apply one of dozens of effects (helium, robot, giant, reverse, monster, alien, zombie, chipmunk and more) and share the result with friends. Recordings can be saved, set as a ringtone or notification sound, or turned into an image with sound. The app is free with ads and in-app purchases.', 'Десятки ефектів голосу
Імпорт готового запису
Рингтон і звук сповіщення
Зображення зі звуком
Обмін із друзями', 'Dozens of voice effects
Import existing recordings
Ringtone and notification sound
Image with sound
Share with friends', 'Власникам Android-смартфонів, які люблять жарти й розіграші.', 'Android users who enjoy jokes and pranks.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.baviux.voicechanger' OR LOWER(`name`) = 'voice changer with effects') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'entertainment' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'voice-changers' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Android app by Baviux: record your voice and add an effect — helium, robot, monster, chipmunk, zombie, reverse.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Voice changer with effects is a popular Android app by Baviux. Record your voice or import an existing recording, apply one of dozens of effects (helium, robot, giant, reverse, monster, alien, zombie, chipmunk and more) and share the result with friends. Recordings can be saved, set as a ringtone or notification sound, or turned into an image with sound. The app is free with ads and in-app purchases.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Dozens of voice effects
Import existing recordings
Ringtone and notification sound
Image with sound
Share with friends', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Android users who enjoy jokes and pranks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'З рекламою; є покупки в додатку.', 'With ads; in-app purchases available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'With ads; in-app purchases available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Радіо Марія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'radiomaria.org.ua' OR LOWER(`name`) = 'радіо марія')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Радіо Марія', NULL, 'https://radiomaria.org.ua', NULL, NULL, 'Християнське радіо українською: онлайн-ефір, коментарі Євангелія дня, катехизи й програми про віру, додаток для Android.', 'Christian radio in Ukrainian: live online stream, daily Gospel commentary, catechesis and faith programmes, Android app.', 'Радіо Марія — християнське радіо, що мовить українською. На сайті можна слухати ефір онлайн і читати матеріали: щоденний коментар Євангелія дня, катехизи священників і монахинь, розмови з богословами, програми про родину, молитву й духовне життя. Є мобільний додаток у Google Play, щоб слухати радіо зі смартфона.', 'Radio Maria is a Christian radio station broadcasting in Ukrainian. On the website you can listen to the live stream and read materials: a daily Gospel commentary, catechesis by priests and nuns, conversations with theologians, and programmes about family, prayer and spiritual life. There is a mobile app on Google Play for listening from your phone.', 'Ефір онлайн
Коментар Євангелія дня
Катехизи й богословські розмови
Програми про родину
Додаток у Google Play', 'Live online stream
Daily Gospel commentary
Catechesis and theology talks
Family programmes
Google Play app', 'Вірянам, які хочуть слухати молитву й християнські програми українською.', 'Believers who want to listen to prayer and Christian programmes in Ukrainian.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'radiomaria.org.ua' OR LOWER(`name`) = 'радіо марія') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-faith' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Christian radio in Ukrainian: live online stream, daily Gospel commentary, catechesis and faith programmes, Android app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Radio Maria is a Christian radio station broadcasting in Ukrainian. On the website you can listen to the live stream and read materials: a daily Gospel commentary, catechesis by priests and nuns, conversations with theologians, and programmes about family, prayer and spiritual life. There is a mobile app on Google Play for listening from your phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live online stream
Daily Gospel commentary
Catechesis and theology talks
Family programmes
Google Play app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Believers who want to listen to prayer and Christian programmes in Ukrainian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовно для користувачів.', 'Free for users.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for users.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- РІСУ — Релігійно-інформаційна служба України
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'risu.ua' OR LOWER(`name`) = 'рісу — релігійно-інформаційна служба україни')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'РІСУ — Релігійно-інформаційна служба України', NULL, 'https://risu.ua', NULL, NULL, 'Інтернет-портал про релігію в Україні: новини православних, католиків, протестантів, публікації, блоги й моніторинг.', 'Online portal about religion in Ukraine: news on Orthodox, Catholic and Protestant churches, articles, blogs and monitoring.', 'РІСУ (Релігійно-інформаційна служба України) — інтернет-портал про релігійне життя в Україні та світі. Тут щодня виходять новини про православні, католицькі й протестантські церкви, інші релігії, міжцерковні відносини та церкву під час війни. Є розділи публікацій, блогів, моніторингу, тем і проєктів, а також довідкові ресурси.', 'RISU (Religious Information Service of Ukraine) is an online portal about religious life in Ukraine and worldwide. It publishes daily news about Orthodox, Catholic and Protestant churches, other religions, inter-church relations and the church during the war. There are sections for articles, blogs, monitoring, topics and projects, plus reference resources.', 'Щоденні новини релігії
Православні, католики, протестанти
Публікації та блоги
Моніторинг
Довідкові ресурси', 'Daily religion news
Orthodox, Catholic, Protestant
Articles and blogs
Monitoring
Reference resources', 'Вірянам, журналістам, дослідникам і всім, хто стежить за церковним життям.', 'Believers, journalists, researchers and anyone following church life.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'risu.ua' OR LOWER(`name`) = 'рісу — релігійно-інформаційна служба україни') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-faith' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Online portal about religion in Ukraine: news on Orthodox, Catholic and Protestant churches, articles, blogs and monitoring.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'RISU (Religious Information Service of Ukraine) is an online portal about religious life in Ukraine and worldwide. It publishes daily news about Orthodox, Catholic and Protestant churches, other religions, inter-church relations and the church during the war. There are sections for articles, blogs, monitoring, topics and projects, plus reference resources.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Daily religion news
Orthodox, Catholic, Protestant
Articles and blogs
Monitoring
Reference resources', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Believers, journalists, researchers and anyone following church life.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовно для користувачів.', 'Free for users.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for users.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Укртелеком
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ukrtelecom.ua' OR LOWER(`name`) = 'укртелеком')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Укртелеком', NULL, 'https://ukrtelecom.ua', NULL, NULL, 'Найбільший в Україні оператор фіксованого зв''язку: інтернет, стійкий до відключень світла, ТБ, телефонія, оплата онлайн.', 'Ukraine''s largest fixed-line operator: blackout-resilient internet, TV, telephony and online payment.', 'Укртелеком — українське акціонерне товариство, найбільший у країні оператор фіксованого зв''язку. Пропонує інтернет, зокрема оптичний і стійкий до відключень електроенергії, телебачення, стаціонарну телефонію, магазин пристроїв і програму лояльності. На сайті можна обрати область, переглянути тарифи, залишити заявку на підключення, оплатити послуги за номером особового рахунку чи телефону та звернутися в підтримку.', 'Ukrtelecom is a Ukrainian joint-stock company and the country''s largest fixed-line operator. It offers internet, including fibre that stays online during power outages, TV, landline telephony, a device shop and a loyalty programme. On the website you can choose your region, compare plans, request a connection, pay by account or phone number and contact support.', 'Інтернет, стійкий до блекаутів
Оптика й телебачення
Стаціонарна телефонія
Оплата за номером рахунку
Програма лояльності', 'Blackout-resilient internet
Fibre and TV
Landline telephony
Pay by account number
Loyalty programme', 'Домогосподарствам і бізнесу в усіх областях України.', 'Households and businesses in every region of Ukraine.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ukrtelecom.ua' OR LOWER(`name`) = 'укртелеком') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-telecom' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ukraine''s largest fixed-line operator: blackout-resilient internet, TV, telephony and online payment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ukrtelecom is a Ukrainian joint-stock company and the country''s largest fixed-line operator. It offers internet, including fibre that stays online during power outages, TV, landline telephony, a device shop and a loyalty programme. On the website you can choose your region, compare plans, request a connection, pay by account or phone number and contact support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Blackout-resilient internet
Fibre and TV
Landline telephony
Pay by account number
Loyalty programme', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Households and businesses in every region of Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Мережа Ланет
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lanet.ua' OR LOWER(`name`) = 'мережа ланет')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Мережа Ланет', NULL, 'https://www.lanet.ua', NULL, NULL, 'Інтернет-провайдер Києва й області та Рівненщини: оптика XGPON до 7777 Мбіт/с, пакети «Інтернет + ТБ», IPTV.', 'Internet provider in Kyiv region and Rivne region: XGPON fibre up to 7777 Mbps, internet + TV bundles, IPTV.', 'Мережа Ланет — інтернет-провайдер, що з 2003 року працює в Києві, області та Рівненській області. Пропонує оптоволоконний, гігабітний і бездротовий інтернет, мультигігабітний XGPON зі швидкістю до 2000, 5000 або 7777 Мбіт/с, пакети «Інтернет + ТБ», IPTV й тарифи з MEGOGO. На сайті є карта покриття, акції, пристрої та розділ для бізнесу.', 'Lanet Network is an internet provider operating since 2003 in Kyiv, Kyiv region and Rivne region. It offers fibre, gigabit and wireless internet, multi-gigabit XGPON at up to 2,000, 5,000 or 7,777 Mbps, internet + TV bundles, IPTV and plans with MEGOGO. The website has a coverage map, promotions, devices and a business section.', 'XGPON до 7777 Мбіт/с
Інтернет + ТБ
IPTV і MEGOGO
Карта покриття
Тарифи для бізнесу', 'XGPON up to 7777 Mbps
Internet + TV
IPTV and MEGOGO
Coverage map
Business plans', 'Мешканцям Києва, Київщини й Рівненщини, яким потрібен швидкий домашній інтернет.', 'Residents of Kyiv, Kyiv region and Rivne region who need fast home internet.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lanet.ua' OR LOWER(`name`) = 'мережа ланет') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-telecom' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Internet provider in Kyiv region and Rivne region: XGPON fibre up to 7777 Mbps, internet + TV bundles, IPTV.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Lanet Network is an internet provider operating since 2003 in Kyiv, Kyiv region and Rivne region. It offers fibre, gigabit and wireless internet, multi-gigabit XGPON at up to 2,000, 5,000 or 7,777 Mbps, internet + TV bundles, IPTV and plans with MEGOGO. The website has a coverage map, promotions, devices and a business section.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'XGPON up to 7777 Mbps
Internet + TV
IPTV and MEGOGO
Coverage map
Business plans', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Residents of Kyiv, Kyiv region and Rivne region who need fast home internet.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Світ Кави
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'svitkavy.com/uk' OR LOWER(`name`) = 'світ кави')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Світ Кави', NULL, 'https://svitkavy.com/uk/', NULL, NULL, 'Кав''ярні у Львові й Києві з кавою, десертами та сніданками; кава власного відбору з доставкою по Україні.', 'Coffee shops in Lviv and Kyiv with coffee, desserts and breakfasts; selected coffee delivered across Ukraine.', 'Світ Кави — мережа кав''ярень у Львові та Києві, де подають каву, десерти й сніданки. На сайті можна замовити каву з доставкою в будь-яку точку України. Зерно компанія шукає й постачає безпосередньо з плантацій разом із партнером Mare Terra, підтримуючи зв''язок між фермерами та кавоманами.', 'Svit Kavy is a chain of coffee shops in Lviv and Kyiv serving coffee, desserts and breakfasts. On the website you can order coffee for delivery anywhere in Ukraine. The company sources beans directly from plantations with its partner Mare Terra, building a bridge between farmers and coffee lovers.', 'Кав''ярні у Львові й Києві
Десерти та сніданки
Кава з доставкою по Україні
Зерно напряму з плантацій
Онлайн-замовлення', 'Cafés in Lviv and Kyiv
Desserts and breakfasts
Coffee delivered across Ukraine
Beans direct from farms
Online ordering', 'Любителям кави у Львові, Києві та всій Україні.', 'Coffee lovers in Lviv, Kyiv and across Ukraine.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'svitkavy.com/uk' OR LOWER(`name`) = 'світ кави') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-cafes' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Coffee shops in Lviv and Kyiv with coffee, desserts and breakfasts; selected coffee delivered across Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Svit Kavy is a chain of coffee shops in Lviv and Kyiv serving coffee, desserts and breakfasts. On the website you can order coffee for delivery anywhere in Ukraine. The company sources beans directly from plantations with its partner Mare Terra, building a bridge between farmers and coffee lovers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cafés in Lviv and Kyiv
Desserts and breakfasts
Coffee delivered across Ukraine
Beans direct from farms
Online ordering', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Coffee lovers in Lviv, Kyiv and across Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ONE LOVE coffee
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'onelove.ua' OR LOWER(`name`) = 'one love coffee')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ONE LOVE coffee', NULL, 'https://onelove.ua', NULL, NULL, 'Мережа кав''ярень у Києві з власною обсмажкою: спешелті кава, дріпи, аксесуари й обладнання з доставкою.', 'Kyiv coffee shop chain with its own roastery: specialty coffee, drip bags, accessories and gear with delivery.', 'ONE LOVE — мережа кав''ярень у Києві з власною обсмажкою кави. В інтернет-магазині є спешелті кава, дріп-пакети, аксесуари й обладнання для заварювання з доставкою по Києву та Україні.', 'ONE LOVE is a chain of coffee shops in Kyiv with its own roastery. Its online shop sells specialty coffee, drip bags, accessories and brewing equipment with delivery across Kyiv and Ukraine.', 'Кав''ярні в Києві
Власна обсмажка
Спешелті кава й дріпи
Аксесуари та обладнання
Доставка по Україні', 'Coffee shops in Kyiv
Own roastery
Specialty coffee and drip bags
Accessories and gear
Delivery across Ukraine', 'Киянам і всім, хто любить спешелті каву вдома.', 'Kyiv residents and anyone who loves specialty coffee at home.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'onelove.ua' OR LOWER(`name`) = 'one love coffee') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-cafes' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Kyiv coffee shop chain with its own roastery: specialty coffee, drip bags, accessories and gear with delivery.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ONE LOVE is a chain of coffee shops in Kyiv with its own roastery. Its online shop sells specialty coffee, drip bags, accessories and brewing equipment with delivery across Kyiv and Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Coffee shops in Kyiv
Own roastery
Specialty coffee and drip bags
Accessories and gear
Delivery across Ukraine', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Kyiv residents and anyone who loves specialty coffee at home.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- OmegaTV
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'omegatv.ua' OR LOWER(`name`) = 'omegatv')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OmegaTV', NULL, 'https://omegatv.ua', NULL, NULL, 'Українське IPTV: базовий пакет на 263 канали, «Кінозал» із тисячами фільмів і серіалів, додатки для Smart TV і смартфонів.', 'Ukrainian IPTV: 263-channel basic package, a film hall with thousands of movies and series, apps for Smart TV and phones.', 'OmegaTV — сучасна IPTV-мережа в Україні, що працює з 2015 року. Базовий пакет містить 263 канали, серед них найпопулярніші українські, розважальні й кіноканали. Розділ «Кінозал» — бібліотека з тисяч фільмів, серіалів і мультфільмів. Дивитися можна в додатку на Smart TV, планшеті чи смартфоні (Google Play, App Store, AppGallery) або через приставку OmegaTV BOX, яку дарують за річну оплату.', 'OmegaTV is a modern IPTV network in Ukraine, operating since 2015. Its basic package includes 263 channels, among them the most popular Ukrainian, entertainment and movie channels. The film hall is a library of thousands of movies, series and cartoons. Watch in the app on Smart TV, tablet or phone (Google Play, App Store, AppGallery) or on the OmegaTV BOX set-top box, which comes free with an annual payment.', '263 канали в базовому пакеті
Кінозал: тисячі фільмів
Додатки для Smart TV і смартфонів
Приставка OmegaTV BOX
Підтримка в чаті', '263 channels in the basic package
Film hall with thousands of movies
Apps for Smart TV and phones
OmegaTV BOX set-top box
Chat support', 'Глядачам українського ТБ, фільмів і серіалів удома та в дорозі.', 'Viewers of Ukrainian TV, movies and series at home and on the go.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'omegatv.ua' OR LOWER(`name`) = 'omegatv') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-movies' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ukrainian IPTV: 263-channel basic package, a film hall with thousands of movies and series, apps for Smart TV and phones.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'OmegaTV is a modern IPTV network in Ukraine, operating since 2015. Its basic package includes 263 channels, among them the most popular Ukrainian, entertainment and movie channels. The film hall is a library of thousands of movies, series and cartoons. Watch in the app on Smart TV, tablet or phone (Google Play, App Store, AppGallery) or on the OmegaTV BOX set-top box, which comes free with an annual payment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '263 channels in the basic package
Film hall with thousands of movies
Apps for Smart TV and phones
OmegaTV BOX set-top box
Chat support', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Viewers of Ukrainian TV, movies and series at home and on the go.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Real-estate.lviv.ua
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'real-estate.lviv.ua' OR LOWER(`name`) = 'real-estate.lviv.ua')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Real-estate.lviv.ua', NULL, 'https://www.real-estate.lviv.ua', NULL, NULL, 'Оголошення про нерухомість Львова й області: оренда та продаж квартир, будинків і офісів від власників і рієлторів, з картою.', 'Lviv and Lviv region property listings: rent and sale of flats, houses and offices from owners and agents, with a map.', 'Real-estate.lviv.ua — портал оголошень про нерухомість у Львові та передмісті (Брюховичі, Винники, Сокільники, Пустомити та інші). Тут є житлова й комерційна нерухомість в оренду та на продаж: квартири, будинки, офіси — від власників і рієлторів, з фото, цінами та картою.', 'Real-estate.lviv.ua is a property listings portal for Lviv and its suburbs (Briukhovychi, Vynnyky, Sokilnyky, Pustomyty and others). It has residential and commercial property for rent and sale — flats, houses and offices — from owners and agents, with photos, prices and a map.', 'Оренда й продаж
Квартири, будинки, офіси
Від власників і рієлторів
Фото та ціни
Карта об''єктів', 'Rent and sale
Flats, houses and offices
From owners and agents
Photos and prices
Map of listings', 'Тим, хто шукає чи здає житло або офіс у Львові.', 'Anyone looking for or letting a home or office in Lviv.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'real-estate.lviv.ua' OR LOWER(`name`) = 'real-estate.lviv.ua') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-classifieds' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Lviv and Lviv region property listings: rent and sale of flats, houses and offices from owners and agents, with a map.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Real-estate.lviv.ua is a property listings portal for Lviv and its suburbs (Briukhovychi, Vynnyky, Sokilnyky, Pustomyty and others). It has residential and commercial property for rent and sale — flats, houses and offices — from owners and agents, with photos, prices and a map.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Rent and sale
Flats, houses and offices
From owners and agents
Photos and prices
Map of listings', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone looking for or letting a home or office in Lviv.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовно для користувачів.', 'Free for users.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for users.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- DOU
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jobs.dou.ua' OR LOWER(`name`) = 'dou')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DOU', NULL, 'https://jobs.dou.ua', NULL, NULL, 'Найбільша спільнота розробників України: вакансії в IT, рейтинг компаній, відгуки співробітників і аналітика зарплат.', 'Ukraine''s largest developer community: IT jobs, company ratings, employee reviews and salary analytics.', 'DOU — найбільша спільнота розробників в Україні. Розділ вакансій збирає пропозиції IT-компаній із фільтрами за напрямом, містом і досвідом та швидкими підбірками: для початківців, govtech, miltech, сил оборони, з бронюванням. Також на DOU є рейтинг IT-компаній, відгуки співробітників, аналітика зарплат і мов програмування, статті, новини, події й форум.', 'DOU is the largest developer community in Ukraine. Its jobs section collects IT company vacancies with filters by field, city and experience, plus quick picks for beginners, govtech, miltech, the defence forces and roles with draft deferment. DOU also has IT company ratings, employee reviews, salary and programming-language analytics, articles, news, events and a forum.', 'Вакансії в IT
Підбірки: початківцям, miltech, бронювання
Рейтинг і відгуки про компанії
Аналітика зарплат
Статті та форум', 'IT vacancies
Picks for beginners, miltech, deferment
Company ratings and reviews
Salary analytics
Articles and forum', 'IT-фахівцям, які шукають роботу або хочуть порівняти зарплати й компанії.', 'IT professionals looking for work or comparing salaries and companies.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jobs.dou.ua' OR LOWER(`name`) = 'dou') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-jobs' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ukraine''s largest developer community: IT jobs, company ratings, employee reviews and salary analytics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'DOU is the largest developer community in Ukraine. Its jobs section collects IT company vacancies with filters by field, city and experience, plus quick picks for beginners, govtech, miltech, the defence forces and roles with draft deferment. DOU also has IT company ratings, employee reviews, salary and programming-language analytics, articles, news, events and a forum.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'IT vacancies
Picks for beginners, miltech, deferment
Company ratings and reviews
Salary analytics
Articles and forum', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'IT professionals looking for work or comparing salaries and companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовно для користувачів.', 'Free for users.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for users.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Happy Monday
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'happymonday.ua' OR LOWER(`name`) = 'happy monday')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Happy Monday', NULL, 'https://happymonday.ua', NULL, NULL, 'Платформа пошуку роботи для digital-професій: лише перевірені роботодавці, рекомендації вакансій під ваші цілі.', 'Job search platform for digital professions: verified employers only, job recommendations matched to your goals.', 'Happy Monday — платформа пошуку роботи й розвитку кар''єри для digital-професій: маркетинг, менеджмент, IT-розробка, дизайн, продажі, HR. Публікують вакансії лише перевірені роботодавці. Система рекомендацій підбирає пропозиції під ваш напрям, формат, рівень і бажану зарплату — без спаму й фейкових вакансій. Проєкт Work with Ukraine об''єднує українських фахівців за кордоном і роботодавців.', 'Happy Monday is a job search and career platform for digital professions: marketing, management, IT development, design, sales and HR. Only verified employers can post vacancies. A recommendation system matches offers to your field, format, level and desired salary — no spam or fake jobs. Its Work with Ukraine project connects Ukrainian specialists abroad with employers.', 'Перевірені роботодавці
Рекомендації вакансій
Віддалена робота
Digital-професії
Work with Ukraine', 'Verified employers
Job recommendations
Remote jobs
Digital professions
Work with Ukraine', 'Маркетологам, дизайнерам, менеджерам, HR і розробникам.', 'Marketers, designers, managers, HR specialists and developers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'happymonday.ua' OR LOWER(`name`) = 'happy monday') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-jobs' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Job search platform for digital professions: verified employers only, job recommendations matched to your goals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Happy Monday is a job search and career platform for digital professions: marketing, management, IT development, design, sales and HR. Only verified employers can post vacancies. A recommendation system matches offers to your field, format, level and desired salary — no spam or fake jobs. Its Work with Ukraine project connects Ukrainian specialists abroad with employers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Verified employers
Job recommendations
Remote jobs
Digital professions
Work with Ukraine', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Marketers, designers, managers, HR specialists and developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовно для користувачів.', 'Free for users.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for users.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- BACKSTAGE
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'backstage.ua' OR LOWER(`name`) = 'backstage')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BACKSTAGE', NULL, 'https://backstage.ua', NULL, NULL, 'Найбільша мережа beauty-салонів у Києві: повний спектр послуг, паралельні процедури за один візит, салон у Лондоні.', 'The largest beauty salon chain in Kyiv: full range of services, parallel treatments in one visit, a salon in London.', 'BACKSTAGE beauty&refresh — найбільша мережа beauty-салонів у Києві, що працює 15 років; є також салон у Лондоні. Салони розташовані в ключових районах міста й пропонують повний спектр послуг для волосся, нігтів, шкіри та обличчя. Кілька процедур можна зробити паралельно за один візит. Стерилізація — за протоколом, матеріали індивідуальні. У салонах продають відібраний догляд для дому. Записатися можна на сайті.', 'BACKSTAGE beauty&refresh is the largest beauty salon chain in Kyiv, operating for 15 years, with one salon in London as well. Salons are located in key districts and offer a full range of hair, nail, skin and face services. Several treatments can be done in parallel in a single visit. Sterilisation follows protocol and materials are single-use. Salons sell selected home-care products. Book online on the website.', 'Салони в районах Києва
Повний спектр послуг
Паралельні процедури
Стерилізація за протоколом
Онлайн-запис', 'Salons across Kyiv
Full range of services
Parallel treatments
Protocol sterilisation
Online booking', 'Киянам, які хочуть зробити кілька beauty-процедур за один візит.', 'Kyiv residents who want several beauty treatments in one visit.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'backstage.ua' OR LOWER(`name`) = 'backstage') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-beauty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The largest beauty salon chain in Kyiv: full range of services, parallel treatments in one visit, a salon in London.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'BACKSTAGE beauty&refresh is the largest beauty salon chain in Kyiv, operating for 15 years, with one salon in London as well. Salons are located in key districts and offer a full range of hair, nail, skin and face services. Several treatments can be done in parallel in a single visit. Sterilisation follows protocol and materials are single-use. Salons sell selected home-care products. Book online on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Salons across Kyiv
Full range of services
Parallel treatments
Protocol sterilisation
Online booking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Kyiv residents who want several beauty treatments in one visit.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- EasyWeek
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'easyweek.com.ua' OR LOWER(`name`) = 'easyweek')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'EasyWeek', NULL, 'https://easyweek.com.ua', NULL, NULL, 'Онлайн-запис до салонів краси, барбершопів, клінік і студій по всій Україні; для бізнесу — записи, команда й сайт.', 'Online booking at beauty salons, barbershops, clinics and studios across Ukraine; for businesses — bookings, team and website.', 'EasyWeek — сервіс онлайн-запису до салонів краси, барбершопів, клінік, спа та фітнес-студій по всій Україні. Знайдіть заклад чи майстра за назвою, послугою або адресою, порівняйте рейтинг, ціни та розклад, оберіть вільне вікно й отримайте підтвердження одразу. Для бізнесу EasyWeek об''єднує записи, команду, клієнтів і власний сайт в одному застосунку.', 'EasyWeek is an online booking service for beauty salons, barbershops, clinics, spas and fitness studios across Ukraine. Find a venue or specialist by name, service or address, compare ratings, prices and schedules, pick a free slot and get instant confirmation. For businesses, EasyWeek brings bookings, staff, clients and a website together in one app.', 'Пошук салонів і майстрів
Реальні відгуки та ціни
Вільні вікна онлайн
Миттєве підтвердження
CRM і сайт для бізнесу', 'Find salons and specialists
Real reviews and prices
Free slots online
Instant confirmation
CRM and website for businesses', 'Клієнтам салонів і барбершопів, а також власникам beauty-бізнесу.', 'Clients of salons and barbershops, and beauty business owners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'easyweek.com.ua' OR LOWER(`name`) = 'easyweek') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-beauty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Online booking at beauty salons, barbershops, clinics and studios across Ukraine; for businesses — bookings, team and website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'EasyWeek is an online booking service for beauty salons, barbershops, clinics, spas and fitness studios across Ukraine. Find a venue or specialist by name, service or address, compare ratings, prices and schedules, pick a free slot and get instant confirmation. For businesses, EasyWeek brings bookings, staff, clients and a website together in one app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Find salons and specialists
Real reviews and prices
Free slots online
Instant confirmation
CRM and website for businesses', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Clients of salons and barbershops, and beauty business owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Svitlo.live
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'svitlo.live' OR LOWER(`name`) = 'svitlo.live')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Svitlo.live', NULL, 'https://svitlo.live', NULL, NULL, 'Графіки відключень світла в усіх областях України на інтерактивній карті з щоденним оновленням і порадами.', 'Power outage schedules for every region of Ukraine on an interactive map, updated daily, with tips.', 'Svitlo.live — сайт з актуальними графіками відключень електроенергії в усіх областях України на інтерактивній карті. Дані оновлюються щодня й одразу після нових повідомлень від енергокомпаній. Є поради, що робити, якщо світло вимкнули не за графіком, і як підготуватися до відключень, а також Telegram-канал з оновленнями.', 'Svitlo.live shows current power outage schedules for every region of Ukraine on an interactive map. Data is updated daily and as soon as energy companies publish new information. It also offers advice on what to do if power goes off outside the schedule and how to prepare for outages, plus a Telegram channel with updates.', 'Графіки всіх областей
Інтерактивна карта
Щоденне оновлення
Поради на час відключень
Telegram-канал', 'Schedules for every region
Interactive map
Daily updates
Outage preparation tips
Telegram channel', 'Усім в Україні, хто планує день з огляду на відключення світла.', 'Anyone in Ukraine planning their day around power outages.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'svitlo.live' OR LOWER(`name`) = 'svitlo.live') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-energy' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Power outage schedules for every region of Ukraine on an interactive map, updated daily, with tips.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Svitlo.live shows current power outage schedules for every region of Ukraine on an interactive map. Data is updated daily and as soon as energy companies publish new information. It also offers advice on what to do if power goes off outside the schedule and how to prepare for outages, plus a Telegram channel with updates.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Schedules for every region
Interactive map
Daily updates
Outage preparation tips
Telegram channel', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone in Ukraine planning their day around power outages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовно для користувачів.', 'Free for users.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for users.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Вінницяобленерго
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'voe.com.ua' OR LOWER(`name`) = 'вінницяобленерго')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Вінницяобленерго', NULL, 'https://www.voe.com.ua', NULL, NULL, 'Оператор електромереж Вінниччини: особистий кабінет, передача показів лічильника, черги відключень і підписка на них.', 'Vinnytsia region grid operator: personal account, meter readings, outage queues and outage alerts.', 'АТ «Вінницяобленерго» — оператор системи розподілу електроенергії Вінницької області. На сайті є особистий кабінет, передача показів лічильника, калькулятор багатотарифного лічильника, графіки погодинних відключень за адресою та інформація про черги ГПВ, підписка на повідомлення про відключення, безкоштовна заміна лічильників за інвестпрограмою й послуги з приєднання до мереж. Кол-центр: 0 800 30-95-95.', 'Vinnytsiaoblenergo is the electricity distribution system operator for Vinnytsia region. The website offers a personal account, meter reading submission, a multi-tariff meter calculator, hourly outage schedules by address and outage queue information, outage alert subscriptions, free meter replacement under the investment programme and grid connection services. Call centre: 0 800 30-95-95.', 'Особистий кабінет
Покази лічильника онлайн
Графіки відключень за адресою
Підписка на повідомлення
Приєднання до мереж', 'Personal account
Online meter readings
Outage schedule by address
Outage alerts
Grid connection', 'Споживачам електроенергії у Вінницькій області.', 'Electricity customers in Vinnytsia region.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'voe.com.ua' OR LOWER(`name`) = 'вінницяобленерго') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-energy' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Vinnytsia region grid operator: personal account, meter readings, outage queues and outage alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Vinnytsiaoblenergo is the electricity distribution system operator for Vinnytsia region. The website offers a personal account, meter reading submission, a multi-tariff meter calculator, hourly outage schedules by address and outage queue information, outage alert subscriptions, free meter replacement under the investment programme and grid connection services. Call centre: 0 800 30-95-95.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Personal account
Online meter readings
Outage schedule by address
Outage alerts
Grid connection', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Electricity customers in Vinnytsia region.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовно для користувачів.', 'Free for users.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for users.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Total Fitness
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'totalfitness.com.ua' OR LOWER(`name`) = 'total fitness')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Total Fitness', NULL, 'https://totalfitness.com.ua', NULL, NULL, 'Мережа фітнес-клубів у Києві, Львові, Хмельницькому, Борисполі й Броварах: тренажери, 80+ групових занять, додаток.', 'Fitness club chain in Kyiv, Lviv, Khmelnytskyi, Boryspil and Brovary: gym, 80+ group classes a month, app.', 'Total Fitness — мережа фітнес-клубів у Києві, Львові, Хмельницькому, Борисполі та Броварах; на Подолі відкривається новий простір зі SPA. У клубах — американські тренажери, кардіозона й понад 80 групових занять щомісяця в кожному клубі. У мобільному додатку Total Fitness UA (App Store, Google Play) можна обрати підписку й зареєструватися за три кроки. Для ветеранів є спеціальні тарифи Day GYM і Full GYM без членського внеску.', 'Total Fitness is a chain of fitness clubs in Kyiv, Lviv, Khmelnytskyi, Boryspil and Brovary, with a new space with a spa opening in Podil. Clubs have American gym equipment, a cardio zone and over 80 group classes a month at each club. In the Total Fitness UA app (App Store, Google Play) you can choose a subscription and sign up in three steps. Veterans get special Day GYM and Full GYM plans with no joining fee.', 'Клуби в п''яти містах
80+ групових занять на місяць
Кардіозона
Додаток Total Fitness UA
Тарифи для ветеранів', 'Clubs in five cities
80+ group classes a month
Cardio zone
Total Fitness UA app
Veteran plans', 'Тим, хто шукає зал із груповими заняттями поруч із домом чи роботою.', 'People looking for a gym with group classes near home or work.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'totalfitness.com.ua' OR LOWER(`name`) = 'total fitness') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-fitness' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fitness club chain in Kyiv, Lviv, Khmelnytskyi, Boryspil and Brovary: gym, 80+ group classes a month, app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Total Fitness is a chain of fitness clubs in Kyiv, Lviv, Khmelnytskyi, Boryspil and Brovary, with a new space with a spa opening in Podil. Clubs have American gym equipment, a cardio zone and over 80 group classes a month at each club. In the Total Fitness UA app (App Store, Google Play) you can choose a subscription and sign up in three steps. Veterans get special Day GYM and Full GYM plans with no joining fee.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Clubs in five cities
80+ group classes a month
Cardio zone
Total Fitness UA app
Veteran plans', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People looking for a gym with group classes near home or work.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Day GYM для ветеранів', 'Day GYM for veterans', NULL, 'one_time', '450 грн за 4 тижні, без членського внеску (з посвідченням ветерана).', 'UAH 450 per 4 weeks, no joining fee (with a veteran ID).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Day GYM для ветеранів' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Day GYM for veterans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'UAH 450 per 4 weeks, no joining fee (with a veteran ID).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Full GYM для ветеранів', 'Full GYM for veterans', NULL, 'one_time', '777 грн за 4 тижні, без членського внеску (з посвідченням ветерана).', 'UAH 777 per 4 weeks, no joining fee (with a veteran ID).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Full GYM для ветеранів' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Full GYM for veterans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'UAH 777 per 4 weeks, no joining fee (with a veteran ID).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- OLIMP Strong
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'olimp-strong.com.ua' OR LOWER(`name`) = 'olimp strong')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OLIMP Strong', NULL, 'https://olimp-strong.com.ua', NULL, NULL, 'Мережа з 12 фітнес-клубів у Львові: тренажери, групові й персональні тренування, CrossFit, стронгмен, теніс, сауна.', 'Network of 12 fitness clubs in Lviv: gym, group and personal training, CrossFit, strongman, tennis, sauna.', 'OLIMP Strong («Олімп») — мережа сучасних фітнес-клубів у Львові, що працює з 2012 року й налічує 12 клубів. Тут є тренажерні зали, групові заняття й персональні тренування, зона стронгмену, CrossFit, теніс і сауна. Діють мережеві абонементи, які можна купити онлайн. На сайті — карта клубів і калькулятор індексу маси тіла.', 'OLIMP Strong (Olimp) is a network of modern fitness clubs in Lviv, operating since 2012 with 12 clubs. It offers gyms, group classes and personal training, a strongman zone, CrossFit, tennis and a sauna. Network memberships can be bought online. The website has a club map and a body mass index calculator.', '12 клубів у Львові
CrossFit і стронгмен
Групові й персональні тренування
Теніс і сауна
Абонементи онлайн', '12 clubs in Lviv
CrossFit and strongman
Group and personal training
Tennis and sauna
Memberships online', 'Львів''янам, які шукають зал поруч або силові тренування.', 'Lviv residents looking for a nearby gym or strength training.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'olimp-strong.com.ua' OR LOWER(`name`) = 'olimp strong') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-fitness' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Network of 12 fitness clubs in Lviv: gym, group and personal training, CrossFit, strongman, tennis, sauna.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'OLIMP Strong (Olimp) is a network of modern fitness clubs in Lviv, operating since 2012 with 12 clubs. It offers gyms, group classes and personal training, a strongman zone, CrossFit, tennis and a sauna. Network memberships can be bought online. The website has a club map and a body mass index calculator.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '12 clubs in Lviv
CrossFit and strongman
Group and personal training
Tennis and sauna
Memberships online', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Lviv residents looking for a nearby gym or strength training.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Прив'язки наявних продуктів (за назвою, без id)
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'entertainment' LIMIT 1);
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'vidnoz ai' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'age-transform' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'entertainment' LIMIT 1);
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'insmind' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'age-transform' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'ланет.tv' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-movies' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'shafa' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-classifieds' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
