SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-19: «Українські додатки» / «Ukrainian Apps» (slug ukrainian-apps) — торгові центри й лабораторії.
-- + 8 нових продуктів і 0 прив'язок наявних (функцію звірено на офіційних сайтах 2026-11-19).
-- Якщо продукт із такою адресою чи назвою вже є — лише прив'язка, тексти не змінюються.
-- Тексти UA/EN — за офіційними сайтами, звірено 2026-11-19. Сайти ТРЦ безкоштовні (план Free); аналізи — «Ціна: див. сайт».
-- Пропущено: Gulliver, Ocean Mall (сайти не відкрилися), karavan.ua (журнал, не ТРЦ), Добробут (основний текст сайту російською),
--   Медлаб, Біотест, Унілаб (сайти недоступні).
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   Lavina Mall — ua-malls (новий)
--   Retroville — ua-malls (новий)
--   Dream Town — ua-malls (новий)
--   Victoria Gardens — ua-malls (новий)
--   King Cross Leopolis — ua-malls (новий)
--   Blockbuster Mall — ua-malls (новий)
--   Сінево — ua-labs (новий)
--   CSD LAB — ua-labs (новий)
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);

-- Lavina Mall
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lavinamall.ua' OR LOWER(`name`) = 'lavina mall')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lavina Mall', NULL, 'https://lavinamall.ua', NULL, NULL, 'Сайт київського ТРЦ Lavina Mall: каталог магазинів, мапа, кіно, розваги, акції й новини.', 'Website of Lavina Mall in Kyiv: store directory, mall map, cinema, entertainment, deals and news.', 'Lavina Mall — торгово-розважальний центр у Києві (вул. Берковецька, 6Д) з близько 400 магазинами, понад 30 закладами харчування, сімейним парком Galaxy і кінотеатром Multiplex. На сайті є каталог магазинів, мапа ТРЦ, розділи розваг і ресторанів, акції та знижки, новини й події, а також як дістатися (зокрема шатл-бас).', 'Lavina Mall is a shopping and entertainment centre in Kyiv (6D Berkovetska St) with about 400 stores, 30+ places to eat, the Galaxy family park and a Multiplex cinema. The website has a store directory, a mall map, entertainment and restaurant sections, deals and sales, news and events, and directions (including the shuttle bus).', 'Каталог близько 400 магазинів
Мапа ТРЦ
Кіно Multiplex і парк Galaxy
Акції та знижки
Як дістатися й шатл-бас', 'Directory of about 400 stores
Mall map
Multiplex cinema and Galaxy park
Deals and sales
Directions and shuttle bus', 'Киянам і гостям міста, які планують похід по магазинах, у кіно чи ресторан.', 'Kyiv residents and visitors planning shopping, a cinema trip or a meal out.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lavinamall.ua' OR LOWER(`name`) = 'lavina mall') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-malls' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Website of Lavina Mall in Kyiv: store directory, mall map, cinema, entertainment, deals and news.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Lavina Mall is a shopping and entertainment centre in Kyiv (6D Berkovetska St) with about 400 stores, 30+ places to eat, the Galaxy family park and a Multiplex cinema. The website has a store directory, a mall map, entertainment and restaurant sections, deals and sales, news and events, and directions (including the shuttle bus).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Directory of about 400 stores
Mall map
Multiplex cinema and Galaxy park
Deals and sales
Directions and shuttle bus', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Kyiv residents and visitors planning shopping, a cinema trip or a meal out.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Сайт ТРЦ безкоштовний.', 'The mall website is free to use.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The mall website is free to use.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Retroville
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'retroville.ua' OR LOWER(`name`) = 'retroville')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Retroville', NULL, 'https://retroville.ua', NULL, NULL, 'Сайт київського ТРЦ Retroville: магазини, карта ТРЦ, події, акції й паркінг на 3245 місць.', 'Website of Retroville mall in Kyiv: stores, mall map, events, deals and parking for 3,245 cars.', 'Retroville — торгово-розважальний центр на Виноградарі в Києві (просп. Європейського Союзу, 47), працює щодня з 10:00 до 22:00. На сайті — каталог магазинів, карта ТРЦ, події й акції, інформація про паркінг на 3245 місць і громадський транспорт, а також розділи бізнес-центру й спорту. У ТРЦ є кінотеатр.', 'Retroville is a shopping and entertainment centre in Vynohradar, Kyiv (47 Yevropeiskoho Soiuzu Ave), open daily from 10:00 to 22:00. The website has a store directory, a mall map, events and deals, information on the 3,245-space car park and public transport, plus business-centre and sports sections. The mall has a cinema.', 'Каталог магазинів
Карта ТРЦ
Події та акції
Паркінг на 3245 місць
Як дістатися громадським транспортом', 'Store directory
Mall map
Events and deals
Car park with 3,245 spaces
Public transport directions', 'Киянам і гостям міста, які планують похід по магазинах, у кіно чи ресторан.', 'Kyiv residents and visitors planning shopping, a cinema trip or a meal out.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'retroville.ua' OR LOWER(`name`) = 'retroville') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-malls' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Website of Retroville mall in Kyiv: stores, mall map, events, deals and parking for 3,245 cars.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Retroville is a shopping and entertainment centre in Vynohradar, Kyiv (47 Yevropeiskoho Soiuzu Ave), open daily from 10:00 to 22:00. The website has a store directory, a mall map, events and deals, information on the 3,245-space car park and public transport, plus business-centre and sports sections. The mall has a cinema.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Store directory
Mall map
Events and deals
Car park with 3,245 spaces
Public transport directions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Kyiv residents and visitors planning shopping, a cinema trip or a meal out.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Сайт ТРЦ безкоштовний.', 'The mall website is free to use.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The mall website is free to use.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Dream Town
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dreamtown.ua' OR LOWER(`name`) = 'dream town')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dream Town', NULL, 'https://dreamtown.ua', NULL, NULL, 'Сайт ТРЦ DREAM на Оболоні (DREAM yellow і DREAM berry): магазини, розваги, ресторани, акції.', 'Website of DREAM malls in Obolon, Kyiv (DREAM yellow and DREAM berry): stores, entertainment, restaurants, deals.', 'Dream Town — два торгово-розважальні центри DREAM на Оболонському проспекті в Києві: DREAM yellow (1Б, метро «Оболонь», «Мінська») і DREAM berry (21Б, метро «Мінська», «Героїв Дніпра»). На сайті — магазини за категоріями, розваги й кіно, ресторани та фуд-корт, послуги (квитки, пакування подарунків, фото, банк), карта ТРЦ, події, акції, графік роботи, паркінг і підписка на новини. Є англійська версія.', 'Dream Town is two DREAM shopping centres on Obolonskyi Avenue in Kyiv: DREAM yellow (1B, Obolon and Minska metro) and DREAM berry (21B, Minska and Heroiv Dnipra metro). The website lists stores by category, entertainment and cinema, restaurants and the food court, services (tickets, gift wrapping, photo, bank), a mall map, events, deals, opening hours, parking and a newsletter. There is an English version.', 'Два ТРЦ: DREAM yellow і DREAM berry
Магазини за категоріями
Розваги, кіно й фуд-корт
Послуги: квитки, пакування, фото
Акції, події й паркінг', 'Two malls: DREAM yellow and DREAM berry
Stores by category
Entertainment, cinema and food court
Services: tickets, gift wrapping, photo
Deals, events and parking', 'Киянам і гостям міста, які планують похід по магазинах, у кіно чи ресторан.', 'Kyiv residents and visitors planning shopping, a cinema trip or a meal out.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dreamtown.ua' OR LOWER(`name`) = 'dream town') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-malls' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Website of DREAM malls in Obolon, Kyiv (DREAM yellow and DREAM berry): stores, entertainment, restaurants, deals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Dream Town is two DREAM shopping centres on Obolonskyi Avenue in Kyiv: DREAM yellow (1B, Obolon and Minska metro) and DREAM berry (21B, Minska and Heroiv Dnipra metro). The website lists stores by category, entertainment and cinema, restaurants and the food court, services (tickets, gift wrapping, photo, bank), a mall map, events, deals, opening hours, parking and a newsletter. There is an English version.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Two malls: DREAM yellow and DREAM berry
Stores by category
Entertainment, cinema and food court
Services: tickets, gift wrapping, photo
Deals, events and parking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Kyiv residents and visitors planning shopping, a cinema trip or a meal out.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Сайт ТРЦ безкоштовний.', 'The mall website is free to use.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The mall website is free to use.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Victoria Gardens
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'victoriagardens.com.ua' OR LOWER(`name`) = 'victoria gardens')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Victoria Gardens', NULL, 'https://victoriagardens.com.ua', NULL, NULL, 'Сайт львівського ТРЦ Victoria Gardens: магазини, акції, ресторани, кіно Multiplex і новини.', 'Website of Victoria Gardens mall in Lviv: stores, deals, restaurants, Multiplex cinema and news.', 'Victoria Gardens — торгово-розважальний центр у Львові (вул. Кульпарківська, 226А), працює з 10:00 до 22:00; кінотеатр Multiplex — до 23:00, «Сільпо» — з 08:00 до 23:00. На сайті є каталог магазинів, акції та знижки, ресторани й кафе, розваги й послуги, новини, маршрут, сторінка для орендарів і розсилка. Є англійська версія.', 'Victoria Gardens is a shopping and entertainment centre in Lviv (226A Kulparkivska St), open 10:00–22:00; the Multiplex cinema runs until 23:00 and Silpo from 08:00 to 23:00. The website has a store directory, deals and sales, restaurants and cafes, entertainment and services, news, directions, a tenants page and a newsletter. There is an English version.', 'Каталог магазинів
Акції та знижки
Ресторани й кафе
Кінотеатр Multiplex
Як дістатися', 'Store directory
Deals and sales
Restaurants and cafes
Multiplex cinema
Directions', 'Львів''янам і гостям міста, які планують похід по магазинах, у кіно чи ресторан.', 'Lviv residents and visitors planning shopping, a cinema trip or a meal out.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'victoriagardens.com.ua' OR LOWER(`name`) = 'victoria gardens') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-malls' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Website of Victoria Gardens mall in Lviv: stores, deals, restaurants, Multiplex cinema and news.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Victoria Gardens is a shopping and entertainment centre in Lviv (226A Kulparkivska St), open 10:00–22:00; the Multiplex cinema runs until 23:00 and Silpo from 08:00 to 23:00. The website has a store directory, deals and sales, restaurants and cafes, entertainment and services, news, directions, a tenants page and a newsletter. There is an English version.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Store directory
Deals and sales
Restaurants and cafes
Multiplex cinema
Directions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Lviv residents and visitors planning shopping, a cinema trip or a meal out.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Сайт ТРЦ безкоштовний.', 'The mall website is free to use.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The mall website is free to use.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- King Cross Leopolis
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kingcross.com.ua' OR LOWER(`name`) = 'king cross leopolis')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'King Cross Leopolis', NULL, 'https://kingcross.com.ua', NULL, NULL, 'Сайт ТРЦ King Cross Leopolis біля Львова: 100 брендів, Планета Кіно IMAX, ковзанка, карта й акції.', 'Website of King Cross Leopolis mall near Lviv: 100 brands, Planeta Kino IMAX, ice rink, map and deals.', 'King Cross Leopolis — торгово-розважальний центр на виїзді зі Львова (с. Сокільники, вул. Стрийська, 30), працює з 10:00 до 21:00. Тут близько 100 брендів, «Планета Кіно» з IMAX, ковзанка й дитячий простір Fly Kids, а також послуги: хімчистка, автомийка, фінансова компанія. На сайті — каталог магазинів, ресторани, розваги, акції, новини, карта ТРЦ, маршрут і вакансії. Є англійська версія.', 'King Cross Leopolis is a shopping and entertainment centre on the edge of Lviv (30 Stryiska St, Sokilnyky), open 10:00–21:00. It has about 100 brands, Planeta Kino with IMAX, an ice rink and the Fly Kids play area, plus services such as dry cleaning, a car wash and a finance company. The website has a store directory, restaurants, entertainment, deals, news, a mall map, directions and vacancies. There is an English version.', 'Близько 100 брендів
Планета Кіно IMAX і ковзанка
Карта ТРЦ
Акції та новини
Вакансії в ТРЦ', 'About 100 brands
Planeta Kino IMAX and ice rink
Mall map
Deals and news
Jobs at the mall', 'Львів''янам і гостям міста, які планують похід по магазинах, у кіно чи ресторан.', 'Lviv residents and visitors planning shopping, a cinema trip or a meal out.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kingcross.com.ua' OR LOWER(`name`) = 'king cross leopolis') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-malls' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Website of King Cross Leopolis mall near Lviv: 100 brands, Planeta Kino IMAX, ice rink, map and deals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'King Cross Leopolis is a shopping and entertainment centre on the edge of Lviv (30 Stryiska St, Sokilnyky), open 10:00–21:00. It has about 100 brands, Planeta Kino with IMAX, an ice rink and the Fly Kids play area, plus services such as dry cleaning, a car wash and a finance company. The website has a store directory, restaurants, entertainment, deals, news, a mall map, directions and vacancies. There is an English version.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'About 100 brands
Planeta Kino IMAX and ice rink
Mall map
Deals and news
Jobs at the mall', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Lviv residents and visitors planning shopping, a cinema trip or a meal out.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Сайт ТРЦ безкоштовний.', 'The mall website is free to use.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The mall website is free to use.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Blockbuster Mall
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'blockbustermall.com.ua' OR LOWER(`name`) = 'blockbuster mall')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Blockbuster Mall', NULL, 'https://blockbustermall.com.ua', NULL, NULL, 'Сайт київського ТРЦ Blockbuster Mall: магазини, ресторани, розваги, послуги, події й карта.', 'Website of Blockbuster Mall in Kyiv: stores, restaurants, entertainment, services, events and map.', 'Blockbuster Mall — великий торгово-розважальний центр у Києві. На сайті є каталог магазинів, ресторанів, розваг і послуг, події та акції, карта ТРЦ, галерея й контакти, а також посилання на сторінки ТРЦ у Facebook та Instagram.', 'Blockbuster Mall is a large shopping and entertainment centre in Kyiv. The website has a directory of stores, restaurants, entertainment and services, events and deals, a mall map, a gallery and contacts, plus links to the mall’s Facebook and Instagram pages.', 'Каталог магазинів і ресторанів
Розваги й послуги
Події та акції
Карта ТРЦ
Контакти й соцмережі', 'Store and restaurant directory
Entertainment and services
Events and deals
Mall map
Contacts and social media', 'Киянам і гостям міста, які планують похід по магазинах, у кіно чи ресторан.', 'Kyiv residents and visitors planning shopping, a cinema trip or a meal out.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'blockbustermall.com.ua' OR LOWER(`name`) = 'blockbuster mall') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-malls' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Website of Blockbuster Mall in Kyiv: stores, restaurants, entertainment, services, events and map.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Blockbuster Mall is a large shopping and entertainment centre in Kyiv. The website has a directory of stores, restaurants, entertainment and services, events and deals, a mall map, a gallery and contacts, plus links to the mall’s Facebook and Instagram pages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Store and restaurant directory
Entertainment and services
Events and deals
Mall map
Contacts and social media', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Kyiv residents and visitors planning shopping, a cinema trip or a meal out.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Сайт ТРЦ безкоштовний.', 'The mall website is free to use.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The mall website is free to use.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Сінево
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'synevo.ua' OR LOWER(`name`) = 'сінево')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Сінево', NULL, 'https://www.synevo.ua', NULL, NULL, 'Мережа медичних лабораторій Synevo: понад 1600 тестів із цінами, замовлення онлайн, результати в кабінеті.', 'Synevo medical laboratory network: 1,600+ tests with prices, online ordering and results in your account.', 'Сінево (Synevo) — європейська медична лабораторія, що входить до шведського холдингу Medicover. В Україні — понад 360 відділень у 164 населених пунктах і 7 лабораторій, понад 1600 видів тестів. На сайті є каталог аналізів із цінами в гривнях, кошик для замовлення онлайн, особистий кабінет із результатами й виклик медсестри додому.', 'Synevo is a European medical laboratory that is part of the Swedish Medicover group. In Ukraine it has 360+ branches in 164 towns and 7 laboratories, with over 1,600 types of tests. The website has a test catalogue with prices in hryvnias, a cart for ordering online, a personal account with results and a nurse home-visit service.', 'Понад 1600 видів тестів
Ціни на сайті в гривнях
Замовлення онлайн
Результати в особистому кабінеті
Медсестра вдома', '1,600+ types of tests
Prices on the site in UAH
Online ordering
Results in your personal account
Nurse home visit', 'Усім, хто здає аналізи в Україні й хоче замовити їх онлайн та отримати результати в кабінеті.', 'Anyone in Ukraine taking lab tests who wants to order them online and get results in a personal account.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'synevo.ua' OR LOWER(`name`) = 'сінево') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-labs' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Synevo medical laboratory network: 1,600+ tests with prices, online ordering and results in your account.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Synevo is a European medical laboratory that is part of the Swedish Medicover group. In Ukraine it has 360+ branches in 164 towns and 7 laboratories, with over 1,600 types of tests. The website has a test catalogue with prices in hryvnias, a cart for ordering online, a personal account with results and a nurse home-visit service.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '1,600+ types of tests
Prices on the site in UAH
Online ordering
Results in your personal account
Nurse home visit', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone in Ukraine taking lab tests who wants to order them online and get results in a personal account.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- CSD LAB
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'csdlab.ua' OR LOWER(`name`) = 'csd lab')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CSD LAB', NULL, 'https://csdlab.ua', NULL, NULL, 'Мережа лабораторій CSD LAB: понад 1350 досліджень із цінами, купівля онлайн, результати в кабінеті.', 'CSD LAB laboratory network: 1,350+ tests with prices, online purchase and results in your account.', 'CSD LAB — українська мережа медичних лабораторій із 183 сертифікованими відділеннями по всій країні та понад 1350 лабораторними дослідженнями. На сайті можна купити аналізи онлайн за цінами в гривнях, завантажити направлення для замовлення, отримати результат в особистому кабінеті й замовити аналізи вдома з мобільною медсестрою.', 'CSD LAB is a Ukrainian network of medical laboratories with 183 certified branches across the country and over 1,350 lab tests. On the website you can buy tests online with prices in hryvnias, upload a referral to place an order, get results in your personal account and book tests at home with a mobile nurse.', 'Понад 1350 досліджень
183 відділення в Україні
Купівля аналізів онлайн
Результати в особистому кабінеті
Аналізи вдома', '1,350+ lab tests
183 branches in Ukraine
Buy tests online
Results in your personal account
Tests at home', 'Усім, хто здає аналізи в Україні й хоче замовити їх онлайн та отримати результати в кабінеті.', 'Anyone in Ukraine taking lab tests who wants to order them online and get results in a personal account.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'csdlab.ua' OR LOWER(`name`) = 'csd lab') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-labs' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'CSD LAB laboratory network: 1,350+ tests with prices, online purchase and results in your account.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'CSD LAB is a Ukrainian network of medical laboratories with 183 certified branches across the country and over 1,350 lab tests. On the website you can buy tests online with prices in hryvnias, upload a referral to place an order, get results in your personal account and book tests at home with a mobile nurse.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '1,350+ lab tests
183 branches in Ukraine
Buy tests online
Results in your personal account
Tests at home', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone in Ukraine taking lab tests who wants to order them online and get results in a personal account.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Прив'язки наявних продуктів (за назвою, без id)
