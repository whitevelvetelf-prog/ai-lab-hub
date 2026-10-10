SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-07: 96 нових продуктів для нових підгруп категорії «Релігія» (нові рухи + доповнення Бахаї, Даосизму, Синто, Джайнізму, Сикхізму).
-- Платні й безкоштовні застосунки, сервіси й онлайн-ресурси за підкатегоріями:
--   Ахмадія (ahmadiyya): 11
--   Ісмаїліти (ismailis): 3
--   Християнська наука (christian-science): 7
--   Isha Foundation (Садгуру) (isha-foundation): 6
--   Self-Realization Fellowship (Йогананда) (self-realization-fellowship): 6
--   Мистецтво життя (Art of Living) (art-of-living): 3
--   Сахаджа-йога (sahaja-yoga): 7
--   Еканкар (eckankar): 3
--   Бахаї (bahai): 12
--   Даосизм і конфуціанство (taoism-confucianism): 6
--   Синтоїзм (shinto): 11
--   Джайнізм (jainism): 8
--   Сикхізм (sikhism): 13
-- Лише справжні сервіси: сайти перевірено (відповідають, назва на сторінці). Відкинуто неробочі,
-- припарковані й захоплені домени, Cloudflare-перевірки, новинні сайти, благодійні фонди,
-- інвестиційні сервіси, астрологію, знайомства, продаж БАДів, сайти з медичними твердженнями. Тексти нейтральні й описові, без оцінок вірувань.
-- Тексти, функції й тарифи (UA + EN) — лише з офіційних сайтів, звірено 2026-10-07.
-- Потребує міграцій database/migration-2026-10-07-religion-category.sql і migration-2026-10-07-religion-groups-3.sql.
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт» (файл .sql або .sql.zip). Повторний запуск безпечний.
--   Ahmadiyya Muslim Association UK — Ахмадія
--   Ahmadiyya Muslim Community Canada — Ахмадія
--   Ahmadiyya Muslim Community USA — Ахмадія
--   Ahmadiyya Muslim Jamaat Deutschland — Ахмадія
--   Al Islam (Ahmadiyya Muslim Community) — Ахмадія
--   Al Islam Holy Quran — Ахмадія
--   Jamia Ahmadiyya UK — Ахмадія
--   Lahore Ahmadiyya Movement — Ахмадія
--   MTA International — Ахмадія
--   The Review of Religions — Ахмадія
--   True Islam — Ахмадія
--   Institute of Ismaili Studies — Ісмаїліти
--   Ismaili Gnosis — Ісмаїліти
--   The Ismaili — Ісмаїліти
--   Christian Science — Християнська наука
--   Christian Science Sentinel — Християнська наука
--   Concord — Християнська наука
--   JSH-Online — Християнська наука
--   Mary Baker Eddy Library — Християнська наука
--   Mary Baker Eddy Papers — Християнська наука
--   The Christian Science Journal — Християнська наука
--   Conscious Planet (Save Soil) — Isha Foundation (Садгуру)
--   Inner Engineering — Isha Foundation (Садгуру)
--   Isha Hatha Yoga — Isha Foundation (Садгуру)
--   Isha Institute of Inner-sciences — Isha Foundation (Садгуру)
--   Sadhguru App — Isha Foundation (Садгуру)
--   Sadhguru Exclusive — Isha Foundation (Садгуру)
--   Autobiography of a Yogi — Self-Realization Fellowship (Йогананда)
--   SRF App — Self-Realization Fellowship (Йогананда)
--   SRF Bookstore — Self-Realization Fellowship (Йогананда)
--   SRF Lessons — Self-Realization Fellowship (Йогананда)
--   SRF Online Meditation Center — Self-Realization Fellowship (Йогананда)
--   Yogoda Satsanga Society of India — Self-Realization Fellowship (Йогананда)
--   Art of Living Retreat Center — Мистецтво життя (Art of Living)
--   Gurudev Sri Sri Ravi Shankar — Мистецтво життя (Art of Living)
--   Мистецтво життя Україна — Мистецтво життя (Art of Living)
--   Free Meditation — Сахаджа-йога
--   Sahaja Online — Сахаджа-йога
--   Sahaja Yoga — Сахаджа-йога
--   Sahaja Yoga UK — Сахаджа-йога
--   Shri Mataji Nirmala Devi — Сахаджа-йога
--   We Meditate — Сахаджа-йога
--   Сахаджа Йога в Україні — Сахаджа-йога
--   Eckankar — Еканкар
--   Eckankar UK — Еканкар
--   Temple of ECK — Еканкар
--   Baha'i Blog — Бахаї
--   Bahá'í Library Online — Бахаї
--   Bahá'ís of the United States — Бахаї
--   Bahá’í Calendar — Бахаї
--   Bahá’í Community of Canada — Бахаї
--   Bahá’í Holy Places and Gardens — Бахаї
--   Ocean of Lights — Бахаї
--   Ruhi Institute — Бахаї
--   The Bahá’í World — Бахаї
--   UK Bahá'í Community — Бахаї
--   Wilmette Institute — Бахаї
--   Бахаї України — Бахаї
--   Chinese Text Project — Даосизм і конфуціанство
--   Confucian Academy (孔教學院) — Даосизм і конфуціанство
--   Daoist Foundation — Даосизм і конфуціанство
--   Taoist Tai Chi Society — Даосизм і конфуціанство
--   Taoistic.com — Даосизм і конфуціанство
--   Terebess: Tao Te Ching translations — Даосизм і конфуціанство
--   Atsuta Jingu — Синтоїзм
--   Dazaifu Tenmangu — Синтоїзм
--   Encyclopedia of Shinto — Синтоїзм
--   Itsukushima Shrine — Синтоїзм
--   Izumo Taisha — Синтоїзм
--   Jinja Online Network — Синтоїзм
--   Kanda Myojin — Синтоїзм
--   Kotohira-gu (Konpira-san) — Синтоїзм
--   Kumano Hongu Taisha — Синтоїзм
--   Tsubaki Grand Shrine of America — Синтоїзм
--   Tsurugaoka Hachimangu — Синтоїзм
--   Institute of Jainology — Джайнізм
--   Jain Center of America (New York) — Джайнізм
--   Jain Center of Greater Boston — Джайнізм
--   Jain Center of Northern California — Джайнізм
--   Jain Quantum — Джайнізм
--   Jain Vishva Bharati Institute — Джайнізм
--   Jinvani — Джайнізм
--   Young Jains of America — Джайнізм
--   Delhi Sikh Gurdwara Management Committee — Сикхізм
--   Discover Sikhism — Сикхізм
--   Gurbanifiles.net — Сикхізм
--   Gurmat Bibek — Сикхізм
--   Nanakshahi.net — Сикхізм
--   Sikh Channel — Сикхізм
--   Sikh Dharma International — Сикхізм
--   Sikh Foundation International — Сикхізм
--   Sikh Missionary Society UK — Сикхізм
--   Sikh Museum Initiative — Сикхізм
--   SikhiWiki — Сикхізм
--   SikhNet Play — Сикхізм
--   The Sikh Encyclopedia — Сикхізм
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);

-- Ahmadiyya Muslim Association UK — Ахмадія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ahmadiyya.uk' OR LOWER(`name`) = LOWER('Ahmadiyya Muslim Association UK'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ahmadiyya Muslim Association UK', NULL, 'https://ahmadiyya.uk', NULL, NULL, 'Офіційний сайт Ахмадійської мусульманської асоціації Великої Британії: час молитов, мечеті, події, публікації, історія громади й портал внесків.', 'The official site of the Ahmadiyya Muslim Association UK: prayer times, mosques, events, publications, community history and a contributions portal.', 'Асоціація під духовним проводом Халіфату-і-Ахмадія працює задля миру за гаслом «Любов до всіх, ненависть ні до кого». Сайт показує час молитов, мечеті, календар подій, публікації, історію ахмадійців у Британії, регіони й відділи громади (освіта, вивчення Корану, нові члени тощо) та портал «Чанда» для внесків.', 'Under the spiritual leadership of Khilafat-e-Ahmadiyya, the association works for peace with the motto "Love for All, Hatred for None". The site shows prayer times, mosques, an events calendar, publications, the history of Ahmadiyya in the UK, regions and departments (education, Quran study, new members and more) and the Chanda portal for contributions.', 'Час молитов
Мечеті й регіони
Календар подій
Портал внесків', 'Prayer times
Mosques and regions
Events calendar
Contributions portal', 'Ахмадійці у Великій Британії.', 'Ahmadis in the UK.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ahmadiyya.uk' OR LOWER(`name`) = LOWER('Ahmadiyya Muslim Association UK')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'ahmadiyya' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official site of the Ahmadiyya Muslim Association UK: prayer times, mosques, events, publications, community history and a contributions portal.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Under the spiritual leadership of Khilafat-e-Ahmadiyya, the association works for peace with the motto "Love for All, Hatred for None". The site shows prayer times, mosques, an events calendar, publications, the history of Ahmadiyya in the UK, regions and departments (education, Quran study, new members and more) and the Chanda portal for contributions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Prayer times
Mosques and regions
Events calendar
Contributions portal', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Ahmadis in the UK.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ahmadiyya Muslim Community Canada — Ахмадія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ahmadiyya.ca' OR LOWER(`name`) = LOWER('Ahmadiyya Muslim Community Canada'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ahmadiyya Muslim Community Canada', NULL, 'https://ahmadiyya.ca', NULL, NULL, 'Сайт Ахмадійської мусульманської громади Канади: про громаду, іслам і ахмадію, пресрелізи, події, мечеть, сервіси для членів і портал внесків.', 'The Ahmadiyya Muslim Community Canada site: about the community, Islam and Ahmadiyyat, press releases, events, the mosque, member services and a contributions portal.', 'Сайт канадської громади ахмадійців. Містить інформацію про громаду, іслам і ахмадію, пресрелізи, календар подій, сервіси для членів, ініціативи (премія сера Мухаммада Зафрулли Хана, забіг Run for Canada, «Мусульмани в пам''ять»), контакти мечеті й портал «Чанда».', 'The Canadian Ahmadiyya community''s site. It covers the community, Islam and Ahmadiyyat, press releases, an events calendar, member services, initiatives (the Sir Muhammad Zafrullah Khan award, Run for Canada, Muslims for Remembrance), mosque contacts and the Chanda portal.', 'Події
Пресрелізи
Сервіси для членів
Громадські ініціативи', 'Events
Press releases
Member services
Community initiatives', 'Ахмадійці в Канаді.', 'Ahmadis in Canada.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ahmadiyya.ca' OR LOWER(`name`) = LOWER('Ahmadiyya Muslim Community Canada')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'ahmadiyya' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Ahmadiyya Muslim Community Canada site: about the community, Islam and Ahmadiyyat, press releases, events, the mosque, member services and a contributions portal.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Canadian Ahmadiyya community''s site. It covers the community, Islam and Ahmadiyyat, press releases, an events calendar, member services, initiatives (the Sir Muhammad Zafrullah Khan award, Run for Canada, Muslims for Remembrance), mosque contacts and the Chanda portal.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Events
Press releases
Member services
Community initiatives', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Ahmadis in Canada.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ahmadiyya Muslim Community USA — Ахмадія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ahmadiyya.us' OR LOWER(`name`) = LOWER('Ahmadiyya Muslim Community USA'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ahmadiyya Muslim Community USA', NULL, 'https://www.ahmadiyya.us', NULL, NULL, 'Сайт Ахмадійської мусульманської громади США (понад 70 відділень): час молитов, Коран, відділи громади й ресурси для членів.', 'The Ahmadiyya Muslim Community USA site (over 70 chapters): prayer times, the Quran, community departments and member resources.', 'Сайт американської громади ахмадійців, що має понад 70 місцевих відділень. Містить час молитов, Коран, розділи відділів (освіта, публікації, зв''язки з громадськістю, аудіо й відео, здоров''я, місіонерська служба тощо) і ресурси для членів.', 'The site of the US Ahmadiyya community with over 70 local chapters. It has prayer times, the Holy Quran, department sections (education, publications, public affairs, audio-video, health, missionary service and more) and member resources.', 'Час молитов
Коран
Відділи громади
Понад 70 відділень', 'Prayer times
Quran
Community departments
Over 70 chapters', 'Ахмадійці в США.', 'Ahmadis in the USA.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ahmadiyya.us' OR LOWER(`name`) = LOWER('Ahmadiyya Muslim Community USA')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'ahmadiyya' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Ahmadiyya Muslim Community USA site (over 70 chapters): prayer times, the Quran, community departments and member resources.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of the US Ahmadiyya community with over 70 local chapters. It has prayer times, the Holy Quran, department sections (education, publications, public affairs, audio-video, health, missionary service and more) and member resources.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Prayer times
Quran
Community departments
Over 70 chapters', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Ahmadis in the USA.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ahmadiyya Muslim Jamaat Deutschland — Ахмадія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ahmadiyya.de' OR LOWER(`name`) = LOWER('Ahmadiyya Muslim Jamaat Deutschland'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ahmadiyya Muslim Jamaat Deutschland', NULL, 'https://ahmadiyya.de', NULL, NULL, 'Ahmadiyya Muslim Jamaat Deutschland — сайт ахмадійської громади Німеччини: іслам, бібліотека, Коран, події, статті, медіатека й розклад молитов, гарячі лінії кількома мовами.', 'Ahmadiyya Muslim Jamaat Deutschland is the German Ahmadiyya community site: Islam, library, Quran, events, articles, media, prayer times and multilingual hotlines.', 'Сайт німецької громади ахмадійців (корпорація публічного права). Розділи: іслам, ахмадія, бібліотека, події, новини, статті, медіатека, фотогалерея, Коран, пошук молитовних місць і розклад молитов. Працюють безкоштовні цілодобові інформаційні лінії німецькою, турецькою, арабською та російською.', 'The site of the German Ahmadiyya community (a public-law corporation). Sections cover Islam, Ahmadiyya, a library, events, news, articles, a media library, photo gallery, the Quran, prayer place finder and prayer times. Free 24/7 info hotlines run in German, Turkish, Arabic and Russian.', 'Бібліотека й Коран
Розклад молитов
Пошук мечетей
Гарячі лінії 4 мовами', 'Library and Quran
Prayer times
Mosque finder
Hotlines in 4 languages', 'Мусульмани й зацікавлені в Німеччині.', 'Muslims and interested people in Germany.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ahmadiyya.de' OR LOWER(`name`) = LOWER('Ahmadiyya Muslim Jamaat Deutschland')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'ahmadiyya' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ahmadiyya Muslim Jamaat Deutschland is the German Ahmadiyya community site: Islam, library, Quran, events, articles, media, prayer times and multilingual hotlines.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of the German Ahmadiyya community (a public-law corporation). Sections cover Islam, Ahmadiyya, a library, events, news, articles, a media library, photo gallery, the Quran, prayer place finder and prayer times. Free 24/7 info hotlines run in German, Turkish, Arabic and Russian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Library and Quran
Prayer times
Mosque finder
Hotlines in 4 languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Muslims and interested people in Germany.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Al Islam (Ahmadiyya Muslim Community) — Ахмадія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'alislam.org' OR LOWER(`name`) = LOWER('Al Islam (Ahmadiyya Muslim Community)'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Al Islam (Ahmadiyya Muslim Community)', NULL, 'https://www.alislam.org', NULL, NULL, 'AlIslam.org — офіційний сайт Ахмадійської мусульманської громади: Коран з перекладами й коментарями, хадиси, книги, проповіді халіфа та бібліотека.', 'AlIslam.org is the official site of the Ahmadiyya Muslim Community: the Quran with translations and commentary, hadith, books, the Caliph''s sermons and a library.', 'Офіційний сайт Ахмадійської мусульманської громади з відділеннями, за її даними, у понад 200 країнах. Громада вірить у Месію Мірзу Гулама Ахмада з Кадіяна і має гасло «Любов до всіх, ненависть ні до кого». Розділи: іслам, ахмадія, священний Коран, хадиси, книги, п''ятничні проповіді халіфа, питання й відповіді та медіатека.', 'The official site of the Ahmadiyya Muslim Community, which reports branches in over 200 countries. The community believes in the Messiah Mirza Ghulam Ahmad of Qadian and uses the motto "Love for All, Hatred for None". Sections cover Islam, Ahmadiyyat, the Holy Quran, hadith, books, the Caliph''s Friday sermons, Q&A and a media library.', 'Коран і хадиси
Книги громади
П''ятничні проповіді
Медіатека', 'Quran and hadith
Community books
Friday sermons
Media library', 'Ахмадійці та всі, хто цікавиться громадою.', 'Ahmadis and anyone interested in the community.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'alislam.org' OR LOWER(`name`) = LOWER('Al Islam (Ahmadiyya Muslim Community)')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'ahmadiyya' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AlIslam.org is the official site of the Ahmadiyya Muslim Community: the Quran with translations and commentary, hadith, books, the Caliph''s sermons and a library.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official site of the Ahmadiyya Muslim Community, which reports branches in over 200 countries. The community believes in the Messiah Mirza Ghulam Ahmad of Qadian and uses the motto "Love for All, Hatred for None". Sections cover Islam, Ahmadiyyat, the Holy Quran, hadith, books, the Caliph''s Friday sermons, Q&A and a media library.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Quran and hadith
Community books
Friday sermons
Media library', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Ahmadis and anyone interested in the community.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Al Islam Holy Quran — Ахмадія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'new.alislam.org/library/quran' OR LOWER(`name`) = LOWER('Al Islam Holy Quran'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Al Islam Holy Quran', NULL, 'https://new.alislam.org/library/quran', NULL, NULL, 'Онлайн-Коран Ахмадійської громади: пошук, теми, переклади десятками мов, короткий і п''ятитомний коментарі, переклад урду пословно.', 'The Ahmadiyya community''s online Quran: search, topics, translations in dozens of languages, short and five-volume commentaries and word-by-word Urdu.', 'Розділ бібліотеки AlIslam з повним текстом Корану. Є простий і розширений пошук, перегляд за темами й сурами, англійські переклади (Мауляві Шер Алі, Мухаммад Зафрулла Хан), короткий і п''ятитомний коментарі, кілька перекладів урду (включно з пословним і перекладом Мірзи Тахіра Ахмада) та переклади арабською, бенгальською, китайською, французькою, німецькою, італійською, норвезькою, іспанською й іншими мовами.', 'A section of the AlIslam library with the full Quran text. It offers simple and advanced search, browsing by topic and chapter, English translations (Maulawi Sher Ali, Muhammad Zafrulla Khan), short and five-volume commentaries, several Urdu translations (including word-by-word and Mirza Tahir Ahmad''s) and translations in Arabic, Bangla, Chinese, French, German, Italian, Norwegian, Spanish and more.', 'Пошук у Корані
Десятки перекладів
Коментарі
Пословний переклад урду', 'Quran search
Dozens of translations
Commentaries
Word-by-word Urdu', 'Читачі Корану в ахмадійській традиції.', 'Quran readers in the Ahmadiyya tradition.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'new.alislam.org/library/quran' OR LOWER(`name`) = LOWER('Al Islam Holy Quran')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'ahmadiyya' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Ahmadiyya community''s online Quran: search, topics, translations in dozens of languages, short and five-volume commentaries and word-by-word Urdu.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A section of the AlIslam library with the full Quran text. It offers simple and advanced search, browsing by topic and chapter, English translations (Maulawi Sher Ali, Muhammad Zafrulla Khan), short and five-volume commentaries, several Urdu translations (including word-by-word and Mirza Tahir Ahmad''s) and translations in Arabic, Bangla, Chinese, French, German, Italian, Norwegian, Spanish and more.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Quran search
Dozens of translations
Commentaries
Word-by-word Urdu', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Quran readers in the Ahmadiyya tradition.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Jamia Ahmadiyya UK — Ахмадія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jamiauk.org' OR LOWER(`name`) = LOWER('Jamia Ahmadiyya UK'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Jamia Ahmadiyya UK', NULL, 'https://jamiauk.org', NULL, NULL, 'Jamia Ahmadiyya UK — інститут теології та сучасних мов Ахмадійської громади, що готує місіонерів: навчання, кампус, гуртожиток, журнал і e-learning.', 'Jamia Ahmadiyya UK is the Ahmadiyya community''s institute of theology and modern languages training missionaries: studies, campus, hostel, journal and e-learning.', 'Освітній заклад громади, що спеціалізується на релігійній освіті з акцентом на теологію та сучасні мови. На сайті — про інститут, новини, кампус і життя в гуртожитку, журнал Majallatul Jamia, ІТ-розділ з e-learning і технічною підтримкою та контакти.', 'A community institution specializing in religious education with a focus on theology and modern languages. The site covers the institute, news, campus and hostel life, the Majallatul Jamia journal, an IT section with e-learning and technical support, and contacts.', 'Теологія й мови
Підготовка місіонерів
E-learning
Журнал', 'Theology and languages
Missionary training
E-learning
Journal', 'Майбутні місіонери громади.', 'Future community missionaries.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jamiauk.org' OR LOWER(`name`) = LOWER('Jamia Ahmadiyya UK')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'ahmadiyya' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Jamia Ahmadiyya UK is the Ahmadiyya community''s institute of theology and modern languages training missionaries: studies, campus, hostel, journal and e-learning.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A community institution specializing in religious education with a focus on theology and modern languages. The site covers the institute, news, campus and hostel life, the Majallatul Jamia journal, an IT section with e-learning and technical support, and contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Theology and languages
Missionary training
E-learning
Journal', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Future community missionaries.', 'manual' FROM DUAL WHERE @new = 1;

-- Lahore Ahmadiyya Movement — Ахмадія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ahmadiyya.org' OR LOWER(`name`) = LOWER('Lahore Ahmadiyya Movement'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lahore Ahmadiyya Movement', NULL, 'https://www.ahmadiyya.org', NULL, NULL, 'Ahmadiyya.org — дослідницький та освітній сайт Лахорського руху Ахмадія: п''ятничні хутби, місячник The Islamic View, публікації про іслам і рух.', 'Ahmadiyya.org is the research and educational site of the Lahore Ahmadiyya Movement: Friday khutbas, The Islamic View monthly and publications on Islam and the movement.', 'Сайт Лахорського руху Ахмадія — окремої від Ахмадійської мусульманської громади гілки, яка подає іслам як мирний, толерантний і раціональний. Публікує останні п''ятничні хутби, щомісячний журнал The Islamic View, святкові проповіді, а також розділи про іслам, рух і публікації з пошуком.', 'The site of the Lahore Ahmadiyya Movement — a branch distinct from the Ahmadiyya Muslim Community that presents Islam as peaceful, tolerant and rational. It publishes the latest Friday khutbas, the monthly The Islamic View, Eid sermons and sections on Islam, the movement and publications with search.', 'П''ятничні хутби
Місячник The Islamic View
Публікації
Пошук', 'Friday khutbas
The Islamic View monthly
Publications
Search', 'Дослідники ахмадійських рухів.', 'Researchers of Ahmadiyya movements.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ahmadiyya.org' OR LOWER(`name`) = LOWER('Lahore Ahmadiyya Movement')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'ahmadiyya' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ahmadiyya.org is the research and educational site of the Lahore Ahmadiyya Movement: Friday khutbas, The Islamic View monthly and publications on Islam and the movement.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of the Lahore Ahmadiyya Movement — a branch distinct from the Ahmadiyya Muslim Community that presents Islam as peaceful, tolerant and rational. It publishes the latest Friday khutbas, the monthly The Islamic View, Eid sermons and sections on Islam, the movement and publications with search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Friday khutbas
The Islamic View monthly
Publications
Search', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Researchers of Ahmadiyya movements.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MTA International — Ахмадія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mta.tv' OR LOWER(`name`) = LOWER('MTA International'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MTA International', NULL, 'https://www.mta.tv', NULL, NULL, 'MTA International (Muslim Television Ahmadiyya) — телебачення Ахмадійської громади: кілька каналів, телепрограма, програми від А до Я, проповіді халіфа й застосунки.', 'MTA International (Muslim Television Ahmadiyya) is the Ahmadiyya community''s TV: several channels, a TV guide, programs A–Z, the Caliph''s sermons and apps.', 'Офіційне телебачення Ахмадійської мусульманської громади. Транслює кілька каналів, має телепрограму, каталог програм від А до Я, розділ останніх виступів халіфа (п''ятничні проповіді, промови на зібраннях і з''їздах) і застосунки для перегляду.', 'The official TV of the Ahmadiyya Muslim Community. It broadcasts several channels and has a TV guide, a program catalog A–Z, the latest addresses of the Caliph (Friday sermons, speeches at gatherings and conventions) and apps for viewing.', 'Кілька каналів
Телепрограма
Проповіді халіфа
Застосунки', 'Several channels
TV guide
Caliph''s sermons
Apps', 'Члени громади та глядачі ісламських програм.', 'Community members and viewers of Islamic programs.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mta.tv' OR LOWER(`name`) = LOWER('MTA International')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'ahmadiyya' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'MTA International (Muslim Television Ahmadiyya) is the Ahmadiyya community''s TV: several channels, a TV guide, programs A–Z, the Caliph''s sermons and apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official TV of the Ahmadiyya Muslim Community. It broadcasts several channels and has a TV guide, a program catalog A–Z, the latest addresses of the Caliph (Friday sermons, speeches at gatherings and conventions) and apps for viewing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Several channels
TV guide
Caliph''s sermons
Apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Community members and viewers of Islamic programs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Перегляд онлайн', 'Watch online' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Watch online', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- The Review of Religions — Ахмадія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'reviewofreligions.org' OR LOWER(`name`) = LOWER('The Review of Religions'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Review of Religions', NULL, 'https://www.reviewofreligions.org', NULL, NULL, 'The Review of Religions — журнал порівняльного релігієзнавства Ахмадійської громади, що виходить з 1902 року: статті, аудіостатті, аудіокниги й мультимедіа.', 'The Review of Religions is the Ahmadiyya community''s comparative religion magazine, in print since 1902: articles, audio articles, audiobooks and multimedia.', 'Один із найстаріших журналів порівняльного релігієзнавства, мета якого — представляти вчення ісламу. Розділи: теми, проповіді халіфа, God Summit, Джалса Салана, Existence Project, «Факти проти вигадок», екзегеза Аль-Тафсір аль-Кабір; мультимедіа — аудіостатті та аудіокниги (зокрема «Послання миру» і «Заповіт»). Є передплата.', 'One of the longest-running comparative religion magazines, aiming to present the teachings of Islam. Sections include topics, the Caliph''s addresses, God Summit, Jalsa Salana, the Existence Project, Facts from Fiction and the Al-Tafsir Al-Kabir exegesis; multimedia includes audio articles and audiobooks (such as "A Message of Peace" and "The Will"). Subscriptions are available.', 'Статті з 1902 року
Аудіостатті
Аудіокниги
Existence Project', 'Articles since 1902
Audio articles
Audiobooks
Existence Project', 'Читачі, які цікавляться ісламом і порівнянням релігій.', 'Readers interested in Islam and comparative religion.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'reviewofreligions.org' OR LOWER(`name`) = LOWER('The Review of Religions')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'ahmadiyya' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Review of Religions is the Ahmadiyya community''s comparative religion magazine, in print since 1902: articles, audio articles, audiobooks and multimedia.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'One of the longest-running comparative religion magazines, aiming to present the teachings of Islam. Sections include topics, the Caliph''s addresses, God Summit, Jalsa Salana, the Existence Project, Facts from Fiction and the Al-Tafsir Al-Kabir exegesis; multimedia includes audio articles and audiobooks (such as "A Message of Peace" and "The Will"). Subscriptions are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Articles since 1902
Audio articles
Audiobooks
Existence Project', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers interested in Islam and comparative religion.', 'manual' FROM DUAL WHERE @new = 1;

-- True Islam — Ахмадія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trueislam.com' OR LOWER(`name`) = LOWER('True Islam'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'True Islam', NULL, 'https://trueislam.com', NULL, NULL, 'True Islam — кампанія Ахмадійської громади США про засади миру в ісламі: про глобальну громаду, кампанії, новини, пресрум і контакти.', 'True Islam is the Ahmadiyya Muslim Community USA''s campaign site on Islam''s fundamentals of peace: global community, campaigns, news, press room and contacts.', 'Сайт американської ахмадійської громади, яка описує себе як глобальну спільноту під проводом одного халіфа, що сприяє миру через служіння. Розповідає про засновника громади, роботу й фокус («Засади миру»), кампанії, новини, пресрум і як зв''язатися чи підписатися на оновлення.', 'A site of the US Ahmadiyya community, which describes itself as a global community under one Khalifa promoting peace through service. It covers the community''s founder, its work and focus ("Fundamentals of Peace"), campaigns, news, a press room and ways to get in touch or subscribe.', 'Про громаду
Кампанії
Пресрум
Підписка на новини', 'About the community
Campaigns
Press room
Updates sign-up', 'Ті, хто вперше знайомиться з ахмадією.', 'People new to Ahmadiyyat.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trueislam.com' OR LOWER(`name`) = LOWER('True Islam')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'ahmadiyya' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'True Islam is the Ahmadiyya Muslim Community USA''s campaign site on Islam''s fundamentals of peace: global community, campaigns, news, press room and contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site of the US Ahmadiyya community, which describes itself as a global community under one Khalifa promoting peace through service. It covers the community''s founder, its work and focus ("Fundamentals of Peace"), campaigns, news, a press room and ways to get in touch or subscribe.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'About the community
Campaigns
Press room
Updates sign-up', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People new to Ahmadiyyat.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Institute of Ismaili Studies — Ісмаїліти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'iis.ac.uk' OR LOWER(`name`) = LOWER('Institute of Ismaili Studies'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Institute of Ismaili Studies', NULL, 'https://www.iis.ac.uk', NULL, NULL, 'Інститут ісмаїлітських студій (Лондон, з 1977) — вища освіта й дослідження: магістерські програми, короткі курси, стипендії, програма Таʿлім і публікації.', 'The Institute of Ismaili Studies (London, since 1977) offers higher education and research: graduate programs, short courses, fellowships, the Taʿlim curriculum and publications.', 'Заклад вищої освіти, досліджень і викладання, заснований у Лондоні 1977 року. Пропонує магістерські програми, короткі курси, стипендії та гранти, освітню програму Таʿлім для середньої школи, підтримку студентів, дослідження й публікації з крамницею та особистим кабінетом.', 'A higher education, research and teaching institution founded in London in 1977. It offers graduate programs, short courses, fellowships and scholarships, the secondary Taʿlim curriculum, student support, research and publications with a shop and personal account.', 'Магістерські програми
Короткі курси
Стипендії
Публікації', 'Graduate programs
Short courses
Scholarships
Publications', 'Студенти й науковці, що вивчають ісмаїлізм та іслам.', 'Students and scholars of Ismailism and Islam.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'iis.ac.uk' OR LOWER(`name`) = LOWER('Institute of Ismaili Studies')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'ismailis' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Institute of Ismaili Studies (London, since 1977) offers higher education and research: graduate programs, short courses, fellowships, the Taʿlim curriculum and publications.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A higher education, research and teaching institution founded in London in 1977. It offers graduate programs, short courses, fellowships and scholarships, the secondary Taʿlim curriculum, student support, research and publications with a shop and personal account.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Graduate programs
Short courses
Scholarships
Publications', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students and scholars of Ismailism and Islam.', 'manual' FROM DUAL WHERE @new = 1;

-- Ismaili Gnosis — Ісмаїліти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ismailignosis.com' OR LOWER(`name`) = LOWER('Ismaili Gnosis'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ismaili Gnosis', NULL, 'https://ismailignosis.com', NULL, NULL, 'Ismaili Gnosis — розсилка на Substack з науковими й віросповідними статтями про віру, теологію, історію та обряди шиїтів-ісмаїлітів; понад 9 000 підписників.', 'Ismaili Gnosis is a Substack with scholarly and faith-based articles on Shia Ismaili beliefs, theology, history and rituals; over 9,000 subscribers.', 'Незалежне видання на Substack, що публікує наукові та віросповідні статті про вірування, теологію, теософію, історію й обрядові практики мусульман-шиїтів ісмаїлітів. Має понад 9 000 підписників; статті доступні онлайн і поштою.', 'An independent Substack publication with scholarly and faith-based articles on Shia Ismaili Muslim beliefs, theology, theosophy, history and ritual practices. It has over 9,000 subscribers; articles are available online and by email.', 'Статті про теологію
Історія ісмаїлізму
Розсилка поштою', 'Theology articles
Ismaili history
Email newsletter', 'Читачі, що поглиблено вивчають ісмаїлізм.', 'Readers studying Ismailism in depth.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ismailignosis.com' OR LOWER(`name`) = LOWER('Ismaili Gnosis')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'ismailis' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ismaili Gnosis is a Substack with scholarly and faith-based articles on Shia Ismaili beliefs, theology, history and rituals; over 9,000 subscribers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An independent Substack publication with scholarly and faith-based articles on Shia Ismaili Muslim beliefs, theology, theosophy, history and ritual practices. It has over 9,000 subscribers; articles are available online and by email.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Theology articles
Ismaili history
Email newsletter', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers studying Ismailism in depth.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовна підписка', 'Free subscription', 0.00, 'free', 'Статті поштою', 'Articles by email' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовна підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Articles by email', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- The Ismaili — Ісмаїліти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'the.ismaili' OR LOWER(`name`) = LOWER('The Ismaili'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Ismaili', NULL, 'https://the.ismaili', NULL, NULL, 'The.Ismaili — офіційний сайт ісмаїлітської мусульманської громади: Імамат і Ага-Хан, промови, вірування, новини громади, програми й The Ismaili TV.', 'The.Ismaili is the official site of the Ismaili Muslim community: the Imamat and the Aga Khan, speeches, beliefs, community news, programs and The Ismaili TV.', 'Офіційний сайт громади мусульман-ісмаїлітів-нізаритів. Розділи: Ісмаїлітський Імамат і Його Високість Ага-Хан, промови, у що вірять ісмаїліти, мусульманська спадщина, новини й оголошення, навчання й натхнення, програми, простори громади, служіння та відеосервіс The Ismaili TV. Сайт має регіональні версії.', 'The official site of the Nizari Ismaili Muslim community. Sections cover the Ismaili Imamat and His Highness the Aga Khan, speeches, what Ismailis believe, Muslim heritage, news and announcements, learning and inspiration, programs, community spaces, service and The Ismaili TV video service. The site has regional versions.', 'Про Імамат
Промови Ага-Хана
The Ismaili TV
Регіональні версії', 'About the Imamat
Aga Khan''s speeches
The Ismaili TV
Regional versions', 'Ісмаїліти та зацікавлені.', 'Ismailis and interested readers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'the.ismaili' OR LOWER(`name`) = LOWER('The Ismaili')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'ismailis' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The.Ismaili is the official site of the Ismaili Muslim community: the Imamat and the Aga Khan, speeches, beliefs, community news, programs and The Ismaili TV.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official site of the Nizari Ismaili Muslim community. Sections cover the Ismaili Imamat and His Highness the Aga Khan, speeches, what Ismailis believe, Muslim heritage, news and announcements, learning and inspiration, programs, community spaces, service and The Ismaili TV video service. The site has regional versions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'About the Imamat
Aga Khan''s speeches
The Ismaili TV
Regional versions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Ismailis and interested readers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Christian Science — Християнська наука
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'christianscience.com' OR LOWER(`name`) = LOWER('Christian Science'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Christian Science', NULL, 'https://www.christianscience.com', NULL, NULL, 'ChristianScience.com — офіційний сайт Церкви Христа, Науковця (Християнська наука): вчення, біблійні уроки, періодика, Concord, бібліотека Мері Бейкер Едді.', 'ChristianScience.com is the official site of the Church of Christ, Scientist: teachings, Bible Lessons, periodicals, Concord and the Mary Baker Eddy Library.', 'Сайт Християнської науки — релігії на біблійній основі з власним підходом до молитви та зцілення, заснованої Мері Бейкер Едді. Об''єднує JSH-Online (Journal, Sentinel, Herald), довідник практиків, тижневі біблійні уроки (цифрове та друковане видання), застосунок Concord, бібліотеку Мері Бейкер Едді, передплати й крамницю. Інформація про Материнську церкву в Бостоні. Сайт доступний десятками мов.', 'The site of Christian Science, a Bible-based religion with its own approach to prayer and healing, founded by Mary Baker Eddy. It brings together JSH-Online (Journal, Sentinel, Herald), the practitioner directory, weekly Bible Lessons (digital and print), the Concord app, the Mary Baker Eddy Library, subscriptions and a shop, plus information on The Mother Church in Boston. The site is available in dozens of languages.', 'Тижневі біблійні уроки
Періодика JSH
Застосунок Concord
Десятки мов', 'Weekly Bible Lessons
JSH periodicals
Concord app
Dozens of languages', 'Християнські науковці та зацікавлені.', 'Christian Scientists and interested readers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'christianscience.com' OR LOWER(`name`) = LOWER('Christian Science')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'christian-science' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ChristianScience.com is the official site of the Church of Christ, Scientist: teachings, Bible Lessons, periodicals, Concord and the Mary Baker Eddy Library.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of Christian Science, a Bible-based religion with its own approach to prayer and healing, founded by Mary Baker Eddy. It brings together JSH-Online (Journal, Sentinel, Herald), the practitioner directory, weekly Bible Lessons (digital and print), the Concord app, the Mary Baker Eddy Library, subscriptions and a shop, plus information on The Mother Church in Boston. The site is available in dozens of languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Weekly Bible Lessons
JSH periodicals
Concord app
Dozens of languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Christian Scientists and interested readers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Christian Science Sentinel — Християнська наука
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sentinel.christianscience.com' OR LOWER(`name`) = LOWER('Christian Science Sentinel'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Christian Science Sentinel', NULL, 'https://sentinel.christianscience.com', NULL, NULL, 'Christian Science Sentinel — тижневик Християнської науки з 1898 року: щотижневі номери, аудіо, рубрики й архів у межах JSH-Online.', 'The Christian Science Sentinel is the Christian Science weekly since 1898: weekly issues, audio, sections and archive within JSH-Online.', 'Сайт щотижневого журналу Christian Science Sentinel. Пропонує номери поточного тижня, аудіоверсії, рубрики, пошук по архіву Journal, Sentinel і Herald (1883 — сьогодні), розсилку й довідку. Повний доступ — за передплатою JSH-Online, є пробні 30 днів.', 'The site of the weekly Christian Science Sentinel. It offers this week''s issues, audio versions, sections, search across the Journal, Sentinel and Herald archive (1883–today), a newsletter and help. Full access requires a JSH-Online subscription, with a 30-day trial.', 'Щотижневі номери
Аудіо
Пошук по архіву
Розсилка', 'Weekly issues
Audio
Archive search
Newsletter', 'Читачі тижневика Християнської науки.', 'Readers of the Christian Science weekly.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sentinel.christianscience.com' OR LOWER(`name`) = LOWER('Christian Science Sentinel')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'christian-science' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Christian Science Sentinel is the Christian Science weekly since 1898: weekly issues, audio, sections and archive within JSH-Online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of the weekly Christian Science Sentinel. It offers this week''s issues, audio versions, sections, search across the Journal, Sentinel and Herald archive (1883–today), a newsletter and help. Full access requires a JSH-Online subscription, with a 30-day trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Weekly issues
Audio
Archive search
Newsletter', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers of the Christian Science weekly.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Free trial', 0.00, 'free', '30 днів', '30 days' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний період' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '30 days', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Concord — Християнська наука
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'concord.christianscience.com' OR LOWER(`name`) = LOWER('Concord'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Concord', NULL, 'https://concord.christianscience.com', NULL, NULL, 'Concord — навчальний ресурс Християнської науки для вивчення Біблії та творів Мері Бейкер Едді: пошук, нотатки, кілька мов; 30 днів безкоштовно.', 'Concord is a Christian Science study resource for the Bible and Mary Baker Eddy''s writings: search, notes and several languages; 30-day free trial.', 'Програма для вивчення Біблії та творів Мері Бейкер Едді, яка допомагає шукати тексти, будувати добірки й готуватися до уроків. Доступна англійською, французькою, німецькою, португальською та іспанською; можна створити безкоштовний акаунт, оформити передплату чи подарунок. Є пробний період 30 днів, FAQ і підтримка.', 'A program for studying the Bible and Mary Baker Eddy''s writings that helps search texts, build collections and prepare lessons. Available in English, French, German, Portuguese and Spanish; you can create a free account, subscribe or give a gift. There is a 30-day free trial, FAQs and support.', 'Пошук по текстах
Добірки для вивчення
П''ять мов
30 днів безкоштовно', 'Text search
Study collections
Five languages
30-day free trial', 'Ті, хто щодня вивчає біблійні уроки Християнської науки.', 'People studying the Christian Science Bible Lessons daily.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'concord.christianscience.com' OR LOWER(`name`) = LOWER('Concord')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'christian-science' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Concord is a Christian Science study resource for the Bible and Mary Baker Eddy''s writings: search, notes and several languages; 30-day free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A program for studying the Bible and Mary Baker Eddy''s writings that helps search texts, build collections and prepare lessons. Available in English, French, German, Portuguese and Spanish; you can create a free account, subscribe or give a gift. There is a 30-day free trial, FAQs and support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Text search
Study collections
Five languages
30-day free trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People studying the Christian Science Bible Lessons daily.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Free trial', 0.00, 'free', '30 днів', '30 days' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний період' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '30 days', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- JSH-Online — Християнська наука
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jsh.christianscience.com' OR LOWER(`name`) = LOWER('JSH-Online'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'JSH-Online', NULL, 'https://jsh.christianscience.com', NULL, NULL, 'JSH-Online — офіційний онлайн-архів журналів Християнської науки Journal, Sentinel і Herald з 1883 року: статті, аудіо, подкасти; 30 днів безкоштовно.', 'JSH-Online is the official online archive of the Christian Science Journal, Sentinel and Herald since 1883: articles, audio and podcasts; 30-day free trial.', 'Офіційний сайт The Christian Science Journal, Christian Science Sentinel і The Herald of Christian Science. Передплата відкриває кожен номер Sentinel з 1898 року та архів Journal з 1883 року, аудіоверсії номерів, подкасти й розширений пошук. Частина статей доступна вільно; є пробний період 30 днів і можливість писати для видань.', 'The official site of The Christian Science Journal, Christian Science Sentinel and The Herald of Christian Science. A subscription opens every Sentinel issue since 1898 and the Journal archive since 1883, issue audio, podcasts and advanced search. Some articles are free; there is a 30-day trial and a way to write for the publications.', 'Архів з 1883 року
Аудіоверсії номерів
Подкасти
Розширений пошук', 'Archive since 1883
Issue audio
Podcasts
Advanced search', 'Читачі періодики Християнської науки.', 'Readers of Christian Science periodicals.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jsh.christianscience.com' OR LOWER(`name`) = LOWER('JSH-Online')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'christian-science' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'JSH-Online is the official online archive of the Christian Science Journal, Sentinel and Herald since 1883: articles, audio and podcasts; 30-day free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official site of The Christian Science Journal, Christian Science Sentinel and The Herald of Christian Science. A subscription opens every Sentinel issue since 1898 and the Journal archive since 1883, issue audio, podcasts and advanced search. Some articles are free; there is a 30-day trial and a way to write for the publications.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Archive since 1883
Issue audio
Podcasts
Advanced search', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers of Christian Science periodicals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Free trial', 0.00, 'free', '30 днів безкоштовно', '30 days free' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний період' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '30 days free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mary Baker Eddy Library — Християнська наука
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'marybakereddylibrary.org' OR LOWER(`name`) = LOWER('Mary Baker Eddy Library'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mary Baker Eddy Library', NULL, 'https://www.marybakereddylibrary.org', NULL, NULL, 'Бібліотека Мері Бейкер Едді — про життя й ідеї засновниці Християнської науки: біографія, твори, статті, «Запитай дослідника», колекції, подкаст і програми.', 'The Mary Baker Eddy Library covers the life and ideas of Christian Science''s founder: biography, writings, articles, Ask a Researcher, collections, a podcast and programs.', 'Бібліотека досліджує життя, ідеї й досягнення Мері Бейкер Едді в релігії, охороні здоров''я та журналістиці. Розділи: коротка й поглиблена біографія, твори, біографії, статті, «Жінки в історії», «Запитай дослідника», предмети з колекцій, матеріали Mary Baker Eddy Papers, історія Гімнарію, подкаст і програми. Мови: англійська, німецька, іспанська, французька, португальська.', 'The Library explores Mary Baker Eddy''s life, ideas and achievements in religion, health and journalism. Sections include a quick and deep biography, writings, biographies, articles, Women of History, Ask a Researcher, collection items, Mary Baker Eddy Papers material, the Hymnal''s history, a podcast and programs. Languages: English, German, Spanish, French and Portuguese.', 'Біографія
«Запитай дослідника»
Колекції
Подкаст', 'Biography
Ask a Researcher
Collections
Podcast', 'Дослідники історії релігії.', 'Religious history researchers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'marybakereddylibrary.org' OR LOWER(`name`) = LOWER('Mary Baker Eddy Library')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'christian-science' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Mary Baker Eddy Library covers the life and ideas of Christian Science''s founder: biography, writings, articles, Ask a Researcher, collections, a podcast and programs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Library explores Mary Baker Eddy''s life, ideas and achievements in religion, health and journalism. Sections include a quick and deep biography, writings, biographies, articles, Women of History, Ask a Researcher, collection items, Mary Baker Eddy Papers material, the Hymnal''s history, a podcast and programs. Languages: English, German, Spanish, French and Portuguese.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Biography
Ask a Researcher
Collections
Podcast', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Religious history researchers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mary Baker Eddy Papers — Християнська наука
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'marybakereddypapers.org' OR LOWER(`name`) = LOWER('Mary Baker Eddy Papers'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mary Baker Eddy Papers', NULL, 'https://www.marybakereddypapers.org', NULL, NULL, 'Mary Baker Eddy Papers — проєкт цифрової публікації з анотаціями листування, проповідей і рукописів Мері Бейкер Едді, з розширеним пошуком.', 'The Mary Baker Eddy Papers is a digital edition annotating Mary Baker Eddy''s correspondence, sermons and manuscripts, with advanced search.', 'Великий проєкт Бібліотеки Мері Бейкер Едді з анотування й цифрової публікації її листування, проповідей та інших рукописів. Дає змогу шукати й переглядати документи з коментарями дослідників.', 'A major Mary Baker Eddy Library effort to annotate and digitally publish her correspondence, sermons and other manuscripts. It lets you search and browse documents with researchers'' notes.', 'Листування й проповіді
Анотації
Розширений пошук', 'Letters and sermons
Annotations
Advanced search', 'Історики й дослідники.', 'Historians and researchers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'marybakereddypapers.org' OR LOWER(`name`) = LOWER('Mary Baker Eddy Papers')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'christian-science' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Mary Baker Eddy Papers is a digital edition annotating Mary Baker Eddy''s correspondence, sermons and manuscripts, with advanced search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A major Mary Baker Eddy Library effort to annotate and digitally publish her correspondence, sermons and other manuscripts. It lets you search and browse documents with researchers'' notes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Letters and sermons
Annotations
Advanced search', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Historians and researchers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- The Christian Science Journal — Християнська наука
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'journal.christianscience.com' OR LOWER(`name`) = LOWER('The Christian Science Journal'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Christian Science Journal', NULL, 'https://journal.christianscience.com', NULL, NULL, 'The Christian Science Journal — щомісячний журнал Християнської науки, заснований 1883 року Мері Бейкер Едді: номери, статті й довідник практиків.', 'The Christian Science Journal is the monthly founded by Mary Baker Eddy in 1883: issues, articles and the practitioner directory.', 'Сайт щомісячного журналу, заснованого 1883 року, за словами Мері Бейкер Едді, «щоб зафіксувати божественну Науку Істини». Публікує щомісячні номери й статті, довідник практиків і вчителів, розділи «Про журнал», передплату та можливість подати статтю.', 'The site of the monthly founded in 1883, in Mary Baker Eddy''s words, "designed to put on record the divine Science of Truth". It publishes monthly issues and articles, a directory of practitioners and teachers, about and subscription pages and a way to submit articles.', 'Щомісячні номери
Довідник практиків
Передплата
Подання статей', 'Monthly issues
Practitioner directory
Subscription
Article submissions', 'Християнські науковці.', 'Christian Scientists.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'journal.christianscience.com' OR LOWER(`name`) = LOWER('The Christian Science Journal')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'christian-science' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Christian Science Journal is the monthly founded by Mary Baker Eddy in 1883: issues, articles and the practitioner directory.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of the monthly founded in 1883, in Mary Baker Eddy''s words, "designed to put on record the divine Science of Truth". It publishes monthly issues and articles, a directory of practitioners and teachers, about and subscription pages and a way to submit articles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Monthly issues
Practitioner directory
Subscription
Article submissions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Christian Scientists.', 'manual' FROM DUAL WHERE @new = 1;

-- Conscious Planet (Save Soil) — Isha Foundation (Садгуру)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'consciousplanet.org/en/save-soil' OR LOWER(`name`) = LOWER('Conscious Planet (Save Soil)'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Conscious Planet (Save Soil)', NULL, 'https://consciousplanet.org/en/save-soil', NULL, NULL, 'Conscious Planet / Save Soil — глобальний рух, започаткований Садгуру, на захист ґрунтів: листи лідерам, події, ресурси, політики й медитація Living Soil.', 'Conscious Planet / Save Soil is a global movement launched by Sadhguru to protect soil: letters to leaders, events, resources, policy and a Living Soil meditation.', 'Рух Conscious Planet під проводом Садгуру реалізує екологічні, освітні й громадські проєкти. Кампанія Save Soil закликає уряди ухвалювати політики, що збільшують вміст органічної речовини в сільськогосподарських ґрунтах. Сайт пропонує написати лист своїм лідерам, новини й події (зокрема на COP), ресурси, інструментарій, щоденні дії, медитацію Living Soil і гру Save Soil.', 'The Conscious Planet movement led by Sadhguru runs environmental, education and community projects. Its Save Soil campaign urges governments to adopt policies increasing organic matter in farm soil. The site lets you write to your leaders and offers news and events (including COP), resources, a toolkit, daily actions, a Living Soil meditation and a Save Soil game.', 'Лист лідерам
Ресурси й інструментарій
Події
Гра Save Soil', 'Letter to leaders
Resources and toolkit
Events
Save Soil game', 'Волонтери й екоактивісти.', 'Volunteers and environmental activists.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'consciousplanet.org/en/save-soil' OR LOWER(`name`) = LOWER('Conscious Planet (Save Soil)')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'isha-foundation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Conscious Planet / Save Soil is a global movement launched by Sadhguru to protect soil: letters to leaders, events, resources, policy and a Living Soil meditation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Conscious Planet movement led by Sadhguru runs environmental, education and community projects. Its Save Soil campaign urges governments to adopt policies increasing organic matter in farm soil. The site lets you write to your leaders and offers news and events (including COP), resources, a toolkit, daily actions, a Living Soil meditation and a Save Soil game.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Letter to leaders
Resources and toolkit
Events
Save Soil game', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Volunteers and environmental activists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Участь безкоштовна', 'Free participation' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free participation', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Inner Engineering — Isha Foundation (Садгуру)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'isha.sadhguru.org/global/en/inner-engineering' OR LOWER(`name`) = LOWER('Inner Engineering'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Inner Engineering', NULL, 'https://isha.sadhguru.org/global/en/inner-engineering', NULL, NULL, 'Inner Engineering — онлайн-програма Садгуру із семи кроків: практики йоги, сесії та передача 21-хвилинної Шамбгаві Махамудра Крії.', 'Inner Engineering is Sadhguru''s 7-step online program with yoga practices, sessions and the transmission of the 21-minute Shambhavi Mahamudra Kriya.', 'Програма Isha Foundation, створена Садгуру, яка пропонує інструменти для роботи з тілом, розумом, емоціями й енергією. Складається із семи онлайн-кроків із простими практиками йоги й медитативними процесами та завершується передачею Шамбгаві Махамудра Крії (21 хвилина) на очному занятті. Зареєстровані учасники входять в особистий кабінет.', 'An Isha Foundation program designed by Sadhguru offering tools for body, mind, emotions and energy. It has seven online steps with simple yoga practices and meditative processes and culminates in the transmission of the 21-minute Shambhavi Mahamudra Kriya at an in-person session. Registered users sign in to a personal account.', '7 онлайн-кроків
Шамбгаві Махамудра Крія
Особистий кабінет', '7 online steps
Shambhavi Mahamudra Kriya
Personal account', 'Ті, хто хоче почати практику з Isha.', 'People starting practice with Isha.', 'web,mobile', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'isha.sadhguru.org/global/en/inner-engineering' OR LOWER(`name`) = LOWER('Inner Engineering')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'isha-foundation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Inner Engineering is Sadhguru''s 7-step online program with yoga practices, sessions and the transmission of the 21-minute Shambhavi Mahamudra Kriya.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An Isha Foundation program designed by Sadhguru offering tools for body, mind, emotions and energy. It has seven online steps with simple yoga practices and meditative processes and culminates in the transmission of the 21-minute Shambhavi Mahamudra Kriya at an in-person session. Registered users sign in to a personal account.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '7 online steps
Shambhavi Mahamudra Kriya
Personal account', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People starting practice with Isha.', 'manual' FROM DUAL WHERE @new = 1;

-- Isha Hatha Yoga — Isha Foundation (Садгуру)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'isha.sadhguru.org/us/en/yoga-meditation/yoga-program-for-beginners/hatha-yoga' OR LOWER(`name`) = LOWER('Isha Hatha Yoga'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Isha Hatha Yoga', NULL, 'https://isha.sadhguru.org/us/en/yoga-meditation/yoga-program-for-beginners/hatha-yoga', NULL, NULL, 'Isha Hatha Yoga — класичні програми хатха-йоги Isha Foundation з підготовленими вчителями: пошук найближчих програм у різних країнах.', 'Isha Hatha Yoga offers classical hatha yoga programs by Isha Foundation with trained teachers and a finder for upcoming programs in many countries.', 'Isha Hatha Yoga походить з традиції, що, за словами організації, зберігається тисячоліттями. Програми ведуть ретельно підготовлені вчителі; на сторінці можна знайти найближчі програми за країною (США, Канада, Індія, Європа, Австралія, Малайзія, Сінгапур) і зареєструватися.', 'Isha Hatha Yoga comes from a tradition the organization says has been maintained for thousands of years. Programs are run by highly trained teachers; the page finds upcoming programs by country (USA, Canada, India, Europe, Australia, Malaysia, Singapore) with registration.', 'Класична хатха-йога
Підготовлені вчителі
Пошук програм
Реєстрація', 'Classical hatha yoga
Trained teachers
Program finder
Registration', 'Ті, хто хоче навчитися хатха-йоги.', 'People wanting to learn hatha yoga.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'isha.sadhguru.org/us/en/yoga-meditation/yoga-program-for-beginners/hatha-yoga' OR LOWER(`name`) = LOWER('Isha Hatha Yoga')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'isha-foundation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Isha Hatha Yoga offers classical hatha yoga programs by Isha Foundation with trained teachers and a finder for upcoming programs in many countries.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Isha Hatha Yoga comes from a tradition the organization says has been maintained for thousands of years. Programs are run by highly trained teachers; the page finds upcoming programs by country (USA, Canada, India, Europe, Australia, Malaysia, Singapore) with registration.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Classical hatha yoga
Trained teachers
Program finder
Registration', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People wanting to learn hatha yoga.', 'manual' FROM DUAL WHERE @new = 1;

-- Isha Institute of Inner-sciences — Isha Foundation (Садгуру)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'isha.sadhguru.org/en/center/isha-institute-inner-sciences-usa' OR LOWER(`name`) = LOWER('Isha Institute of Inner-sciences'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Isha Institute of Inner-sciences', NULL, 'https://isha.sadhguru.org/en/center/isha-institute-inner-sciences-usa', NULL, NULL, 'Isha Institute of Inner-sciences — центр Isha Foundation у Теннессі (США): програми, ретрити, відвідування й природні стежки.', 'The Isha Institute of Inner-sciences is Isha Foundation''s centre in Tennessee, USA: programs, retreats, visits and nature trails.', 'Центр Isha у районі Аппер-Камберленд (Теннессі), куди приїжджають відпочити, поміркувати й відновити зв''язок із природою. Сторінка містить програми й ретрити центру, інформацію для відвідувачів і посилання на інші програми Isha.', 'An Isha centre in Tennessee''s Upper Cumberland where people come to relax, reflect and reconnect with nature. The page lists the centre''s programs and retreats, visitor information and links to other Isha programs.', 'Програми й ретрити
Інформація для відвідувачів
Природа Теннессі', 'Programs and retreats
Visitor info
Tennessee nature', 'Учасники програм Isha в США.', 'Isha program participants in the USA.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'isha.sadhguru.org/en/center/isha-institute-inner-sciences-usa' OR LOWER(`name`) = LOWER('Isha Institute of Inner-sciences')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'isha-foundation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Isha Institute of Inner-sciences is Isha Foundation''s centre in Tennessee, USA: programs, retreats, visits and nature trails.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An Isha centre in Tennessee''s Upper Cumberland where people come to relax, reflect and reconnect with nature. The page lists the centre''s programs and retreats, visitor information and links to other Isha programs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Programs and retreats
Visitor info
Tennessee nature', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Isha program participants in the USA.', 'manual' FROM DUAL WHERE @new = 1;

-- Sadhguru App — Isha Foundation (Садгуру)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'isha.sadhguru.org/in/en/sadhguru-app' OR LOWER(`name`) = LOWER('Sadhguru App'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sadhguru App', NULL, 'https://isha.sadhguru.org/in/en/sadhguru-app', NULL, NULL, 'Sadhguru App — безкоштовний застосунок Isha Foundation: керовані медитації, йога-практики, відео, статті й подкасти Садгуру.', 'The Sadhguru App is Isha Foundation''s free app with guided meditations, yoga practices, videos, articles and podcasts by Sadhguru.', 'Офіційний застосунок Isha Foundation з безкоштовними керованими медитаціями (зокрема Isha Kriya), короткими йога-практиками, відео, статтями, цитатами й аудіо Садгуру. Пов''язаний із програмами Isha — Inner Engineering, Hatha Yoga та іншими.', 'Isha Foundation''s official app with free guided meditations (including Isha Kriya), short yoga practices, videos, articles, quotes and audio from Sadhguru. It links to Isha programs such as Inner Engineering and Hatha Yoga.', 'Керовані медитації
Короткі йога-практики
Відео й статті
Безкоштовно', 'Guided meditations
Short yoga practices
Videos and articles
Free', 'Ті, хто практикує медитацію за Садгуру.', 'People meditating with Sadhguru.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'isha.sadhguru.org/in/en/sadhguru-app' OR LOWER(`name`) = LOWER('Sadhguru App')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'isha-foundation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Sadhguru App is Isha Foundation''s free app with guided meditations, yoga practices, videos, articles and podcasts by Sadhguru.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Isha Foundation''s official app with free guided meditations (including Isha Kriya), short yoga practices, videos, articles, quotes and audio from Sadhguru. It links to Isha programs such as Inner Engineering and Hatha Yoga.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Guided meditations
Short yoga practices
Videos and articles
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People meditating with Sadhguru.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базовий застосунок', 'Core app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Core app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sadhguru Exclusive — Isha Foundation (Садгуру)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'isha.sadhguru.org/global/en/sadhguru-exclusive' OR LOWER(`name`) = LOWER('Sadhguru Exclusive'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sadhguru Exclusive', NULL, 'https://isha.sadhguru.org/global/en/sadhguru-exclusive', NULL, NULL, 'Sadhguru Exclusive — передплатна бібліотека ексклюзивних відео Садгуру з щотижневими релізами; англійською, гінді, тамільською, телугу й іспанською.', 'Sadhguru Exclusive is a subscription library of exclusive Sadhguru videos with weekly releases, in English, Hindi, Tamil, Telugu and Spanish.', 'Передплатний сервіс Isha Foundation, який позиціонує себе як велику бібліотеку містичного контенту від Садгуру. Нові відео виходять щотижня; дивитися можна на різних пристроях. Доступний англійською, гінді, тамільською, телугу й іспанською.', 'An Isha Foundation subscription service presenting itself as a large library of mystical content from Sadhguru. New videos arrive every week and can be watched on various devices. Available in English, Hindi, Tamil, Telugu and Spanish.', 'Ексклюзивні відео
Щотижневі релізи
П''ять мов
Перегляд на пристроях', 'Exclusive videos
Weekly releases
Five languages
Watch on devices', 'Послідовники Садгуру.', 'Sadhguru''s followers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'isha.sadhguru.org/global/en/sadhguru-exclusive' OR LOWER(`name`) = LOWER('Sadhguru Exclusive')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'isha-foundation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sadhguru Exclusive is a subscription library of exclusive Sadhguru videos with weekly releases, in English, Hindi, Tamil, Telugu and Spanish.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An Isha Foundation subscription service presenting itself as a large library of mystical content from Sadhguru. New videos arrive every week and can be watched on various devices. Available in English, Hindi, Tamil, Telugu and Spanish.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Exclusive videos
Weekly releases
Five languages
Watch on devices', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sadhguru''s followers.', 'manual' FROM DUAL WHERE @new = 1;

-- Autobiography of a Yogi — Self-Realization Fellowship (Йогананда)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yogananda.org/autobiography-of-a-yogi' OR LOWER(`name`) = LOWER('Autobiography of a Yogi'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Autobiography of a Yogi', NULL, 'https://yogananda.org/autobiography-of-a-yogi', NULL, NULL, 'Сторінка SRF про «Автобіографію йога» Парамаханси Йогананди: історія книги, видання різними мовами й форматами та як її отримати.', 'SRF''s page on Paramahansa Yogananda''s Autobiography of a Yogi: the book''s story, editions in many languages and formats and how to get it.', 'Розділ сайту Self-Realization Fellowship, присвячений «Автобіографії йога» — книзі, що познайомила багатьох читачів на Заході з йогою та медитацією. Розповідає про книгу, її видання різними мовами, друковані, електронні й аудіоформати та посилання на придбання. Доступний вісьмома мовами.', 'A section of the Self-Realization Fellowship site devoted to Autobiography of a Yogi, the book that introduced many Western readers to yoga and meditation. It covers the book, its editions in many languages, print, eBook and audio formats and links to buy. Available in eight languages.', 'Про книгу
Видання різними мовами
Друк, e-book, аудіо', 'About the book
Editions in many languages
Print, eBook, audio', 'Читачі, які відкривають для себе Йогананду.', 'Readers discovering Yogananda.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yogananda.org/autobiography-of-a-yogi' OR LOWER(`name`) = LOWER('Autobiography of a Yogi')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'self-realization-fellowship' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SRF''s page on Paramahansa Yogananda''s Autobiography of a Yogi: the book''s story, editions in many languages and formats and how to get it.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A section of the Self-Realization Fellowship site devoted to Autobiography of a Yogi, the book that introduced many Western readers to yoga and meditation. It covers the book, its editions in many languages, print, eBook and audio formats and links to buy. Available in eight languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'About the book
Editions in many languages
Print, eBook, audio', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers discovering Yogananda.', 'manual' FROM DUAL WHERE @new = 1;

-- SRF App — Self-Realization Fellowship (Йогананда)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yogananda.org/app-faq' OR LOWER(`name`) = LOWER('SRF App'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SRF App', NULL, 'https://yogananda.org/app-faq', NULL, NULL, 'Застосунок Self-Realization Fellowship: керовані медитації, онлайн-служби, бібліотека й доступ до SRF Lessons для учнів Парамаханси Йогананди.', 'The Self-Realization Fellowship app offers guided meditations, online services, a library and access to the SRF Lessons for students of Paramahansa Yogananda.', 'Офіційний застосунок SRF — організації, заснованої Парамахансою Йоганандою. На сторінці FAQ пояснюється, як ним користуватися: керовані медитації, онлайн-служби й події, матеріали для читання, доступ до передплати SRF Lessons і кабінету. Сайт SRF доступний вісьмома мовами.', 'The official app of SRF, the organization founded by Paramahansa Yogananda. The FAQ page explains how to use it: guided meditations, online services and events, reading material, access to the SRF Lessons subscription and account. The SRF site is available in eight languages.', 'Керовані медитації
Онлайн-служби
Доступ до Lessons
Вісім мов сайту', 'Guided meditations
Online services
Lessons access
Eight site languages', 'Учні вчення Йогананди.', 'Students of Yogananda''s teachings.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yogananda.org/app-faq' OR LOWER(`name`) = LOWER('SRF App')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'self-realization-fellowship' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Self-Realization Fellowship app offers guided meditations, online services, a library and access to the SRF Lessons for students of Paramahansa Yogananda.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official app of SRF, the organization founded by Paramahansa Yogananda. The FAQ page explains how to use it: guided meditations, online services and events, reading material, access to the SRF Lessons subscription and account. The SRF site is available in eight languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Guided meditations
Online services
Lessons access
Eight site languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students of Yogananda''s teachings.', 'manual' FROM DUAL WHERE @new = 1;

-- SRF Bookstore — Self-Realization Fellowship (Йогананда)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bookstore.yogananda-srf.org' OR LOWER(`name`) = LOWER('SRF Bookstore'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SRF Bookstore', NULL, 'https://bookstore.yogananda-srf.org', NULL, NULL, 'SRF Bookstore — книгарня Self-Realization Fellowship: «Автобіографія йога» (понад 50 мов, e-book і аудіо), книги й бесіди Йогананди, молитви, записи.', 'SRF Bookstore sells Self-Realization Fellowship books: Autobiography of a Yogi (50+ languages, eBook and audio), Yogananda''s books and talks, prayers and recordings.', 'Інтернет-магазин видань SRF. «Автобіографія йога» доступна англійською, у делюкс-виданні, як електронна та аудіокнига й понад 50 іншими мовами; також усі книги Парамаханси Йогананди, бесіди й есе, молитви, аудіо- та відеозаписи.', 'The online store of SRF publications. Autobiography of a Yogi comes in English, a deluxe edition, eBook and audiobook and over 50 other languages; plus all of Paramahansa Yogananda''s books, talks and essays, prayers and audio and video recordings.', '«Автобіографія йога»
Понад 50 мов
Книги Йогананди
Аудіо й відео', 'Autobiography of a Yogi
Over 50 languages
Yogananda''s books
Audio and video', 'Читачі Йогананди.', 'Readers of Yogananda.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bookstore.yogananda-srf.org' OR LOWER(`name`) = LOWER('SRF Bookstore')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'self-realization-fellowship' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SRF Bookstore sells Self-Realization Fellowship books: Autobiography of a Yogi (50+ languages, eBook and audio), Yogananda''s books and talks, prayers and recordings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The online store of SRF publications. Autobiography of a Yogi comes in English, a deluxe edition, eBook and audiobook and over 50 other languages; plus all of Paramahansa Yogananda''s books, talks and essays, prayers and audio and video recordings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Autobiography of a Yogi
Over 50 languages
Yogananda''s books
Audio and video', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers of Yogananda.', 'manual' FROM DUAL WHERE @new = 1;

-- SRF Lessons — Self-Realization Fellowship (Йогананда)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yogananda.org/lessons' OR LOWER(`name`) = LOWER('SRF Lessons'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SRF Lessons', NULL, 'https://yogananda.org/lessons', NULL, NULL, 'SRF Lessons — уроки для домашнього вивчення від Self-Realization Fellowship: техніки медитації та крія-йоги, вчення Парамаханси Йогананди.', 'SRF Lessons are Self-Realization Fellowship''s home-study lessons: meditation and Kriya Yoga techniques and Paramahansa Yogananda''s teachings.', 'Серія уроків для домашнього вивчення, укладена з настанов Парамаханси Йогананди. Містить техніки концентрації й медитації та вчення про збалансоване духовне життя й готує до крія-йоги. Передплатники керують підпискою й допоміжними матеріалами в особистому кабінеті; доступні вісьмома мовами.', 'A home-study lesson series compiled from Paramahansa Yogananda''s instructions. It contains concentration and meditation techniques and teachings on balanced spiritual living and prepares students for Kriya Yoga. Subscribers manage their subscription and auxiliary materials in a personal account; available in eight languages.', 'Техніки медитації
Підготовка до крія-йоги
Особистий кабінет
Вісім мов', 'Meditation techniques
Kriya Yoga preparation
Personal account
Eight languages', 'Ті, хто хоче вивчати вчення Йогананди вдома.', 'People studying Yogananda''s teachings at home.', 'web,mobile', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yogananda.org/lessons' OR LOWER(`name`) = LOWER('SRF Lessons')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'self-realization-fellowship' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SRF Lessons are Self-Realization Fellowship''s home-study lessons: meditation and Kriya Yoga techniques and Paramahansa Yogananda''s teachings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A home-study lesson series compiled from Paramahansa Yogananda''s instructions. It contains concentration and meditation techniques and teachings on balanced spiritual living and prepares students for Kriya Yoga. Subscribers manage their subscription and auxiliary materials in a personal account; available in eight languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Meditation techniques
Kriya Yoga preparation
Personal account
Eight languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People studying Yogananda''s teachings at home.', 'manual' FROM DUAL WHERE @new = 1;

-- SRF Online Meditation Center — Self-Realization Fellowship (Йогананда)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'onlinemeditation.yogananda.org' OR LOWER(`name`) = LOWER('SRF Online Meditation Center'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SRF Online Meditation Center', NULL, 'https://onlinemeditation.yogananda.org', NULL, NULL, 'Онлайн-центр медитації SRF — групові медитації й служби наживо в інтернеті: календар, як долучитися, волонтерство; шість мов.', 'The SRF Online Meditation Center hosts live group meditations and services online: calendar, how to participate and volunteering; six languages.', 'Онлайн-центр Self-Realization Fellowship для участі в групових медитаціях, службах і подіях наживо. Містить календар служб, інструкцію з участі, розділи волонтерства й пожертв, вхід до акаунта. Мови: англійська, німецька, іспанська, італійська, португальська, японська.', 'Self-Realization Fellowship''s online centre for joining live group meditations, services and events. It has a calendar of services, how-to-participate guidance, volunteer and donate sections and account sign-in. Languages: English, German, Spanish, Italian, Portuguese and Japanese.', 'Групові медитації наживо
Календар служб
Шість мов
Безкоштовно', 'Live group meditations
Service calendar
Six languages
Free', 'Ті, хто медитує разом онлайн.', 'People meditating together online.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'onlinemeditation.yogananda.org' OR LOWER(`name`) = LOWER('SRF Online Meditation Center')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'self-realization-fellowship' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The SRF Online Meditation Center hosts live group meditations and services online: calendar, how to participate and volunteering; six languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Self-Realization Fellowship''s online centre for joining live group meditations, services and events. It has a calendar of services, how-to-participate guidance, volunteer and donate sections and account sign-in. Languages: English, German, Spanish, Italian, Portuguese and Japanese.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live group meditations
Service calendar
Six languages
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People meditating together online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Участь у службах', 'Joining services' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Joining services', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Yogoda Satsanga Society of India — Self-Realization Fellowship (Йогананда)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yssofindia.org' OR LOWER(`name`) = LOWER('Yogoda Satsanga Society of India'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Yogoda Satsanga Society of India', NULL, 'https://yssofindia.org', NULL, NULL, 'Yogoda Satsanga Society of India — організація, заснована Йоганандою 1917 року: біографія, уроки, молитви, портал відданих і шість мов Індії.', 'Yogoda Satsanga Society of India, founded by Yogananda in 1917: biography, Lessons, prayer, a devotee portal and six Indian languages.', 'Індійська організація, заснована Парамахансою Йоганандою для поширення вчення крія-йоги. Сайт містить біографію Йогананди, записи його голосу, уроки YSS, молитовну службу, портал відданих, обліковий запис і пожертви. Доступний англійською, гінді, бенгальською, каннада, тамільською й телугу.', 'The Indian organization founded by Paramahansa Yogananda to share the teachings of Kriya Yoga. The site has Yogananda''s biography, recordings of his voice, YSS Lessons, a prayer service, a devotee portal, accounts and donations. Available in English, Hindi, Bengali, Kannada, Tamil and Telugu.', 'Уроки YSS
Біографія Йогананди
Портал відданих
Шість мов', 'YSS Lessons
Yogananda biography
Devotee portal
Six languages', 'Послідовники Йогананди в Індії.', 'Yogananda''s followers in India.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yssofindia.org' OR LOWER(`name`) = LOWER('Yogoda Satsanga Society of India')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'self-realization-fellowship' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Yogoda Satsanga Society of India, founded by Yogananda in 1917: biography, Lessons, prayer, a devotee portal and six Indian languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Indian organization founded by Paramahansa Yogananda to share the teachings of Kriya Yoga. The site has Yogananda''s biography, recordings of his voice, YSS Lessons, a prayer service, a devotee portal, accounts and donations. Available in English, Hindi, Bengali, Kannada, Tamil and Telugu.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'YSS Lessons
Yogananda biography
Devotee portal
Six languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Yogananda''s followers in India.', 'manual' FROM DUAL WHERE @new = 1;

-- Art of Living Retreat Center — Мистецтво життя (Art of Living)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'artoflivingretreatcenter.org' OR LOWER(`name`) = LOWER('Art of Living Retreat Center'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Art of Living Retreat Center', NULL, 'https://artoflivingretreatcenter.org', NULL, NULL, 'Art of Living Retreat Center — ретрит-центр у Північній Кароліні: медитаційні, йога- та велнес-ретрити, навчання вчителів Sri Sri Yoga і календар.', 'The Art of Living Retreat Center in North Carolina offers meditation, yoga and wellness retreats, Sri Sri Yoga teacher training and a calendar.', 'Ретрит-центр «Мистецтва життя» в горах Північної Кароліни. Пропонує медитаційні ретрити (Happiness Retreat, Breathwork & Meditation, ретрити тиші), йога-ретрити й навчання вчителів Sri Sri Yoga, велнес-ретрити для пар, подруг, матерів і доньок, гостьових ведучих і календар подій.', 'The Art of Living''s retreat centre in the North Carolina mountains. It offers meditation retreats (Happiness Retreat, Breathwork & Meditation, silence retreats), yoga retreats and Sri Sri Yoga teacher training, wellness retreats for couples, friends, mothers and daughters, guest presenters and an events calendar.', 'Медитаційні ретрити
Йога-ретрити
Навчання вчителів
Календар', 'Meditation retreats
Yoga retreats
Teacher training
Calendar', 'Ті, хто шукає ретрит у США.', 'People seeking a retreat in the USA.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'artoflivingretreatcenter.org' OR LOWER(`name`) = LOWER('Art of Living Retreat Center')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'art-of-living' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Art of Living Retreat Center in North Carolina offers meditation, yoga and wellness retreats, Sri Sri Yoga teacher training and a calendar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Art of Living''s retreat centre in the North Carolina mountains. It offers meditation retreats (Happiness Retreat, Breathwork & Meditation, silence retreats), yoga retreats and Sri Sri Yoga teacher training, wellness retreats for couples, friends, mothers and daughters, guest presenters and an events calendar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Meditation retreats
Yoga retreats
Teacher training
Calendar', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People seeking a retreat in the USA.', 'manual' FROM DUAL WHERE @new = 1;

-- Gurudev Sri Sri Ravi Shankar — Мистецтво життя (Art of Living)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gurudev.artofliving.org' OR LOWER(`name`) = LOWER('Gurudev Sri Sri Ravi Shankar'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Gurudev Sri Sri Ravi Shankar', NULL, 'https://gurudev.artofliving.org', NULL, NULL, 'Офіційний сайт Ґурудева Шрі Шрі Раві Шанкара, засновника «Мистецтва життя»: біографія, «Запитай Ґурудева», медитації, мудрість, блог, подкасти й застосунок.', 'The official site of Gurudev Sri Sri Ravi Shankar, founder of the Art of Living: biography, Ask Gurudev, meditations, wisdom, blog, podcasts and app.', 'Сайт про Шрі Шрі Раві Шанкара — гуманітарного й духовного лідера, фонд якого «Мистецтво життя», за даними сайту, працює у 182 країнах. Розділи: біографія, заходи, «Запитай Ґурудева», відзнаки, напрями роботи (духовність, культура, мирні ініціативи, служіння), тур, курси, центри, ресурси, застосунок, медитації, цитати, блог і подкасти. Мови: англійська, німецька.', 'A site about Sri Sri Ravi Shankar, a humanitarian and spiritual leader whose Art of Living foundation, per the site, works in 182 countries. Sections cover biography, engagements, Ask Gurudev, honors, work (spirituality, culture, peace initiatives, service), tour, courses, centers, resources, the app, meditations, quotes, blog and podcasts. Languages: English and German.', '«Запитай Ґурудева»
Медитації
Подкасти
Застосунок', 'Ask Gurudev
Meditations
Podcasts
App', 'Учасники «Мистецтва життя».', 'Art of Living participants.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gurudev.artofliving.org' OR LOWER(`name`) = LOWER('Gurudev Sri Sri Ravi Shankar')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'art-of-living' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official site of Gurudev Sri Sri Ravi Shankar, founder of the Art of Living: biography, Ask Gurudev, meditations, wisdom, blog, podcasts and app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site about Sri Sri Ravi Shankar, a humanitarian and spiritual leader whose Art of Living foundation, per the site, works in 182 countries. Sections cover biography, engagements, Ask Gurudev, honors, work (spirituality, culture, peace initiatives, service), tour, courses, centers, resources, the app, meditations, quotes, blog and podcasts. Languages: English and German.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Ask Gurudev
Meditations
Podcasts
App', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Art of Living participants.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Медитації й матеріали', 'Meditations and materials' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Meditations and materials', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Мистецтво життя Україна — Мистецтво життя (Art of Living)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'artofliving.org/ua-uk' OR LOWER(`name`) = LOWER('Мистецтво життя Україна'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Мистецтво життя Україна', NULL, 'https://www.artofliving.org/ua-uk', NULL, NULL, 'Українська версія сайту The Art of Living: курси «Мистецтво дихання» і «Мистецтво тиші», медитація Sahaj Samadhi, Sri Sri Йога та вступний семінар.', 'The Ukrainian Art of Living site: Part 1 (Art of Breathing) and Part 2 (Art of Silence) courses, Sahaj Samadhi meditation, Sri Sri Yoga and an intro seminar.', 'Українська сторінка міжнародної організації «Мистецтво життя». Пропонує курси Art of Living Частина 1 (дихальна техніка Сударшан Крія) і Частина 2 (Мистецтво тиші), медитацію Sahaj Samadhi, Sri Sri Йогу, вступний семінар, пошук програм і розповідь про засновника. Українською та англійською.', 'The Ukrainian page of the international Art of Living. It offers Art of Living Part 1 (the Sudarshan Kriya breathing technique) and Part 2 (Art of Silence), Sahaj Samadhi meditation, Sri Sri Yoga, an intro seminar, a program finder and the founder''s story. In Ukrainian and English.', 'Курси українською
Сударшан Крія
Медитація Sahaj Samadhi
Вступний семінар', 'Courses in Ukrainian
Sudarshan Kriya
Sahaj Samadhi meditation
Intro seminar', 'Мешканці України, які шукають курси медитації.', 'People in Ukraine looking for meditation courses.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'artofliving.org/ua-uk' OR LOWER(`name`) = LOWER('Мистецтво життя Україна')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'art-of-living' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Ukrainian Art of Living site: Part 1 (Art of Breathing) and Part 2 (Art of Silence) courses, Sahaj Samadhi meditation, Sri Sri Yoga and an intro seminar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Ukrainian page of the international Art of Living. It offers Art of Living Part 1 (the Sudarshan Kriya breathing technique) and Part 2 (Art of Silence), Sahaj Samadhi meditation, Sri Sri Yoga, an intro seminar, a program finder and the founder''s story. In Ukrainian and English.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Courses in Ukrainian
Sudarshan Kriya
Sahaj Samadhi meditation
Intro seminar', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in Ukraine looking for meditation courses.', 'manual' FROM DUAL WHERE @new = 1;

-- Free Meditation — Сахаджа-йога
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'freemeditation.com' OR LOWER(`name`) = LOWER('Free Meditation'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Free Meditation', NULL, 'https://www.freemeditation.com', NULL, NULL, 'FreeMeditation.com — безкоштовний онлайн-курс медитації Сахаджа-йоги, Zoom-медитації, статті, відео й відгуки.', 'FreeMeditation.com offers a free online Sahaja Yoga meditation course, Zoom meditations, articles, videos and testimonials.', 'Ресурс Сахаджа-йоги, що навчає медитувати безкоштовно. Містить онлайн-курс, медитації в Zoom, розділ про самореалізацію, статті, відео й відгуки, а також пошук матеріалів.', 'A Sahaja Yoga resource teaching meditation for free. It has an online course, Zoom meditations, a self-realization section, articles, videos and testimonials, plus search.', 'Онлайн-курс
Zoom-медитації
Статті й відео
Безкоштовно', 'Online course
Zoom meditations
Articles and videos
Free', 'Ті, хто хоче навчитися медитації онлайн.', 'People who want to learn meditation online.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'freemeditation.com' OR LOWER(`name`) = LOWER('Free Meditation')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sahaja-yoga' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'FreeMeditation.com offers a free online Sahaja Yoga meditation course, Zoom meditations, articles, videos and testimonials.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Sahaja Yoga resource teaching meditation for free. It has an online course, Zoom meditations, a self-realization section, articles, videos and testimonials, plus search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online course
Zoom meditations
Articles and videos
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to learn meditation online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Курс і сесії', 'Course and sessions' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Course and sessions', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sahaja Online — Сахаджа-йога
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sahajaonline.com' OR LOWER(`name`) = LOWER('Sahaja Online'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sahaja Online', NULL, 'https://sahajaonline.com', NULL, NULL, 'Sahaja Online — безкоштовні живі онлайн-заняття з керованої медитації Сахаджа з інструкторами: календар, відеотека, ресурси й блог.', 'Sahaja Online runs free live instructor-led guided meditation classes online: calendar, video library, resources and blog.', 'Платформа безкоштовних онлайн-сесій медитації Сахаджа з живими інструкторами. Є коротка інструкція для старту, календар сесій, відеотека, ресурси для медитації вдома й колективної практики, профілі учасників, блог і контакти.', 'A platform of free online Sahaja meditation sessions with live instructors. It has a quick start guide, a session calendar, a video library, resources for meditating at home and collectively, participant profiles, a blog and contacts.', 'Живі онлайн-сесії
Календар
Відеотека
Безкоштовно', 'Live online sessions
Calendar
Video library
Free', 'Ті, хто медитує онлайн з інструктором.', 'People meditating online with an instructor.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sahajaonline.com' OR LOWER(`name`) = LOWER('Sahaja Online')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sahaja-yoga' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sahaja Online runs free live instructor-led guided meditation classes online: calendar, video library, resources and blog.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform of free online Sahaja meditation sessions with live instructors. It has a quick start guide, a session calendar, a video library, resources for meditating at home and collectively, participant profiles, a blog and contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live online sessions
Calendar
Video library
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People meditating online with an instructor.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Усі сесії', 'All sessions' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'All sessions', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sahaja Yoga — Сахаджа-йога
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'us.sahajayoga.org' OR LOWER(`name`) = LOWER('Sahaja Yoga'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sahaja Yoga', NULL, 'https://us.sahajayoga.org', NULL, NULL, 'Sahaja Yoga — метод медитації, заснований Шрі Матаджі: що таке самореалізація, чакри й кундаліні, безкоштовні керовані медитації та 21-денний онлайн-курс.', 'Sahaja Yoga is a meditation method founded by Shri Mataji: self-realization, chakras and kundalini, free guided meditations and a 21-day online course.', 'Сайт Сахаджа-йоги, яка вчить медитації, що спирається на давнє духовне знання. Пояснює, що таке Сахаджа-йога та чим вона відрізняється, розповідає про Шрі Матаджі, самореалізацію, чакри й тонку систему, енергію кундаліні та канали, пропонує FAQ, безкоштовні керовані медитації й безкоштовний онлайн-курс медитації на 21 день.', 'The site of Sahaja Yoga, which teaches meditation rooted in ancient spiritual knowledge. It explains what Sahaja Yoga is and how it differs, covers Shri Mataji, self-realization, chakras and the subtle system, kundalini energy and channels, and offers an FAQ, free guided meditations and a free 21-day online meditation course.', 'Безкоштовні медитації
21-денний онлайн-курс
Про чакри й кундаліні
FAQ', 'Free meditations
21-day online course
Chakras and kundalini
FAQ', 'Початківці в медитації.', 'Meditation beginners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'us.sahajayoga.org' OR LOWER(`name`) = LOWER('Sahaja Yoga')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sahaja-yoga' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sahaja Yoga is a meditation method founded by Shri Mataji: self-realization, chakras and kundalini, free guided meditations and a 21-day online course.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of Sahaja Yoga, which teaches meditation rooted in ancient spiritual knowledge. It explains what Sahaja Yoga is and how it differs, covers Shri Mataji, self-realization, chakras and the subtle system, kundalini energy and channels, and offers an FAQ, free guided meditations and a free 21-day online meditation course.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free meditations
21-day online course
Chakras and kundalini
FAQ', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Meditation beginners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Медитації й курс', 'Meditations and course' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Meditations and course', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sahaja Yoga UK — Сахаджа-йога
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sahajayoga.org.uk' OR LOWER(`name`) = LOWER('Sahaja Yoga UK'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sahaja Yoga UK', NULL, 'https://www.sahajayoga.org.uk', NULL, NULL, 'Sahaja Yoga Meditation UK — безкоштовна медитація у Великій Британії: пошук сесій поруч, живі онлайн-медитації та знайомство з методом.', 'Sahaja Yoga Meditation UK offers free meditation in the UK: a local session finder, live online meditations and an introduction to the method.', 'Британський сайт Сахаджа-йоги, що описує її як безкоштовний і простий досвід медитації, заснований на самореалізації через пробудження кундаліні. Пропонує пошук сесій поруч, живі онлайн-медитації, спробувати медитацію одразу, контакти й розсилку.', 'The UK Sahaja Yoga site describing it as a free, simple meditation experience based on self-realization through kundalini awakening. It offers a local session finder, live online meditations, a try-it-now experience, contacts and a newsletter.', 'Пошук сесій поруч
Онлайн-медитації
Безкоштовно', 'Local session finder
Online meditations
Free', 'Мешканці Великої Британії.', 'People in the UK.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sahajayoga.org.uk' OR LOWER(`name`) = LOWER('Sahaja Yoga UK')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sahaja-yoga' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sahaja Yoga Meditation UK offers free meditation in the UK: a local session finder, live online meditations and an introduction to the method.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The UK Sahaja Yoga site describing it as a free, simple meditation experience based on self-realization through kundalini awakening. It offers a local session finder, live online meditations, a try-it-now experience, contacts and a newsletter.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local session finder
Online meditations
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in the UK.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сесії безкоштовні', 'Sessions are free' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Sessions are free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Shri Mataji Nirmala Devi — Сахаджа-йога
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shrimataji.org' OR LOWER(`name`) = LOWER('Shri Mataji Nirmala Devi'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Shri Mataji Nirmala Devi', NULL, 'https://shrimataji.org', NULL, NULL, 'Офіційний сайт про Шрі Матаджі Нірмалу Деві, засновницю Сахаджа-йоги: біографія, громадська діяльність, виступи в ООН, нагороди й спадщина.', 'The official site about Shri Mataji Nirmala Devi, founder of Sahaja Yoga: biography, public life, UN addresses, awards and legacy.', 'Сайт «Життя, присвячене людству» розповідає біографію Шрі Матаджі: раннє життя, роки навчання, шлюб, незалежність Індії, родину, громадське життя, виступи в ООН і на жіночій конференції, нагороди, спадщину, а також про Сахаджа-йогу, самореалізацію та медитацію.', '"A Life Dedicated to Humanity" tells Shri Mataji''s biography: early life, college years, marriage, Indian independence, family, public life, UN and women''s conference addresses, awards and legacy, plus Sahaja Yoga, self-realization and meditation.', 'Детальна біографія
Виступи в ООН
Спадщина
Про Сахаджа-йогу', 'Detailed biography
UN addresses
Legacy
About Sahaja Yoga', 'Практики Сахаджа-йоги.', 'Sahaja Yoga practitioners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shrimataji.org' OR LOWER(`name`) = LOWER('Shri Mataji Nirmala Devi')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sahaja-yoga' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official site about Shri Mataji Nirmala Devi, founder of Sahaja Yoga: biography, public life, UN addresses, awards and legacy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', '"A Life Dedicated to Humanity" tells Shri Mataji''s biography: early life, college years, marriage, Indian independence, family, public life, UN and women''s conference addresses, awards and legacy, plus Sahaja Yoga, self-realization and meditation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Detailed biography
UN addresses
Legacy
About Sahaja Yoga', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sahaja Yoga practitioners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- We Meditate — Сахаджа-йога
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wemeditate.com' OR LOWER(`name`) = LOWER('We Meditate'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'We Meditate', NULL, 'https://wemeditate.com', NULL, NULL, 'We Meditate — керовані медитації Сахаджа-йоги, музика для медитації, класи поруч і живі онлайн-заняття, статті про чакри та внутрішню енергію.', 'We Meditate offers Sahaja Yoga guided meditations, meditation music, local classes and live online classes, and articles on chakras and inner energy.', 'Сервіс керованих медитацій, що поєднує людей по світу. Розділи: медитувати зараз, музика для медитації, класи поруч і живі онлайн-класи, статті про медитацію, чакри й канали, внутрішню енергію, засновницю й Сахаджа-йогу, історію медитації й натхнення.', 'A guided meditation service connecting people worldwide. Sections include Meditate Now, music for meditation, local and live online classes, articles on meditation, chakras and channels, inner energy, the founder and Sahaja Yoga, the history of meditation and inspiration.', 'Керовані медитації
Музика
Онлайн-класи
Статті', 'Guided meditations
Music
Online classes
Articles', 'Ті, хто медитує щодня.', 'Daily meditators.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wemeditate.com' OR LOWER(`name`) = LOWER('We Meditate')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sahaja-yoga' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'We Meditate offers Sahaja Yoga guided meditations, meditation music, local classes and live online classes, and articles on chakras and inner energy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A guided meditation service connecting people worldwide. Sections include Meditate Now, music for meditation, local and live online classes, articles on meditation, chakras and channels, inner energy, the founder and Sahaja Yoga, the history of meditation and inspiration.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Guided meditations
Music
Online classes
Articles', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Daily meditators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Медитації й класи', 'Meditations and classes' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Meditations and classes', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Сахаджа Йога в Україні — Сахаджа-йога
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sahajayoga.org.ua' OR LOWER(`name`) = LOWER('Сахаджа Йога в Україні'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Сахаджа Йога в Україні', NULL, 'https://www.sahajayoga.org.ua', NULL, NULL, 'Сайт Сахаджа-йоги в Україні: що таке Сахаджа-йога, практика в повсякденному житті, новини й посилання на онлайн-медитації We Meditate.', 'The Sahaja Yoga site in Ukraine: what Sahaja Yoga is, practice in daily life, news and links to We Meditate online meditations.', 'Український сайт, що описує Сахаджа-йогу як метод медитації, заснований на пробудженні духовних сил, наявних у кожній людині. Розділи: що таке Сахаджа-йога, Сахаджа-йога й повсякденне життя, Сахаджа-йога в Україні, новини та посилання на сервіс онлайн-медитацій We Meditate.', 'A Ukrainian site describing Sahaja Yoga as a meditation method based on awakening the spiritual forces present in every person. Sections cover what Sahaja Yoga is, Sahaja Yoga and daily life, Sahaja Yoga in Ukraine, news and links to the We Meditate online meditation service.', 'Українською
Про метод
Новини
Посилання на онлайн-медитації', 'In Ukrainian
About the method
News
Links to online meditations', 'Мешканці України, що цікавляться медитацією.', 'People in Ukraine interested in meditation.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sahajayoga.org.ua' OR LOWER(`name`) = LOWER('Сахаджа Йога в Україні')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sahaja-yoga' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Sahaja Yoga site in Ukraine: what Sahaja Yoga is, practice in daily life, news and links to We Meditate online meditations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Ukrainian site describing Sahaja Yoga as a meditation method based on awakening the spiritual forces present in every person. Sections cover what Sahaja Yoga is, Sahaja Yoga and daily life, Sahaja Yoga in Ukraine, news and links to the We Meditate online meditation service.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'In Ukrainian
About the method
News
Links to online meditations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in Ukraine interested in meditation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Eckankar — Еканкар
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankar.org' OR LOWER(`name`) = LOWER('Eckankar'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eckankar', NULL, 'https://www.eckankar.org', NULL, NULL, 'ECKANKAR — «Шлях духовної свободи»: офіційний сайт із вченнями про душу, HU, сни, минулі життя, курси для учнів ECK, подкасти, журнал і щоденне натхнення.', 'ECKANKAR, "the Path of Spiritual Freedom": the official site with teachings on Soul, HU, dreams and past lives, ECK student courses, podcasts, a magazine and daily inspiration.', 'Офіційний сайт руху Еканкар. Розділи: що таке Еканкар, духовний лідер Шрі Даґ Кунін, FAQ, Храм ECK, для батьків і сімей, досвід HU, сни, мандри душі, минулі життя, Світло і Звук; як стати учнем ECK, курси духовного життя, семінари, подкасти, журнал ECK Soul Adventure, електронні буклети, щоденне натхнення й щоденна практика.', 'The official Eckankar site. Sections cover what Eckankar is, spiritual leader Sri Doug Kunin, FAQs, the Temple of ECK, parents and families, experiencing HU, dreams, Soul Travel, past lives, Light and Sound; becoming an ECK student, spiritual living courses, seminars, podcasts, ECK Soul Adventure magazine, eBooklets, daily inspiration and daily practice.', 'Про вчення
Курси для учнів
Подкасти
Щоденне натхнення', 'About the teachings
Student courses
Podcasts
Daily inspiration', 'Ті, хто цікавиться Еканкаром.', 'People interested in Eckankar.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankar.org' OR LOWER(`name`) = LOWER('Eckankar')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'eckankar' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ECKANKAR, "the Path of Spiritual Freedom": the official site with teachings on Soul, HU, dreams and past lives, ECK student courses, podcasts, a magazine and daily inspiration.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official Eckankar site. Sections cover what Eckankar is, spiritual leader Sri Doug Kunin, FAQs, the Temple of ECK, parents and families, experiencing HU, dreams, Soul Travel, past lives, Light and Sound; becoming an ECK student, spiritual living courses, seminars, podcasts, ECK Soul Adventure magazine, eBooklets, daily inspiration and daily practice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'About the teachings
Student courses
Podcasts
Daily inspiration', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People interested in Eckankar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Матеріали сайту', 'Site materials' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Site materials', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Eckankar UK — Еканкар
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankar.org.uk' OR LOWER(`name`) = LOWER('Eckankar UK'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eckankar UK', NULL, 'https://www.eckankar.org.uk', NULL, NULL, 'ECKANKAR UK — британське відділення Еканкару: події, журнал ECK Soul Adventure, про рух і контакти.', 'ECKANKAR UK is the British branch of Eckankar: events, ECK Soul Adventure, about the movement and contacts.', 'Сайт Еканкару у Великій Британії для тих, хто шукає глибшого особистого зв''язку з Богом і Божественним Духом. Містить перелік подій, посилання на ECK Soul Adventure, розділ про Еканкар і контакти.', 'The Eckankar UK site for people seeking a deeper personal connection with God and Divine Spirit. It lists events, links to ECK Soul Adventure and has an about section and contacts.', 'Події
ECK Soul Adventure
Контакти', 'Events
ECK Soul Adventure
Contacts', 'Зацікавлені у Великій Британії.', 'Interested people in the UK.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankar.org.uk' OR LOWER(`name`) = LOWER('Eckankar UK')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'eckankar' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ECKANKAR UK is the British branch of Eckankar: events, ECK Soul Adventure, about the movement and contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Eckankar UK site for people seeking a deeper personal connection with God and Divine Spirit. It lists events, links to ECK Soul Adventure and has an about section and contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Events
ECK Soul Adventure
Contacts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Interested people in the UK.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Temple of ECK — Еканкар
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankar.org/explore/toe-calendar' OR LOWER(`name`) = LOWER('Temple of ECK'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Temple of ECK', NULL, 'https://www.eckankar.org/explore/toe-calendar/', NULL, NULL, 'Храм ECK у Чангассені (Міннесота): екскурсії, події, календар і стежки для споглядання; відкритий для людей усіх вір.', 'The Temple of ECK in Chanhassen, Minnesota: tours, events, a calendar and contemplation trails; open to people of all faiths.', 'Сторінка головного храму Еканкару в Чангассені. Запрошує на екскурсії й події, показує календар заходів і розповідає про стежки для споглядання на території. Храм відкритий для відвідувачів будь-якої віри.', 'The page of Eckankar''s main temple in Chanhassen. It invites visitors to tours and events, shows the events calendar and describes the contemplation trails on the grounds. The temple welcomes visitors of any faith.', 'Екскурсії
Календар подій
Стежки для споглядання', 'Tours
Events calendar
Contemplation trails', 'Відвідувачі храму.', 'Temple visitors.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eckankar.org/explore/toe-calendar' OR LOWER(`name`) = LOWER('Temple of ECK')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'eckankar' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Temple of ECK in Chanhassen, Minnesota: tours, events, a calendar and contemplation trails; open to people of all faiths.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The page of Eckankar''s main temple in Chanhassen. It invites visitors to tours and events, shows the events calendar and describes the contemplation trails on the grounds. The temple welcomes visitors of any faith.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tours
Events calendar
Contemplation trails', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Temple visitors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відвідування', 'Visits' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Visits', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Baha'i Blog — Бахаї
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bahaiblog.net' OR LOWER(`name`) = LOWER('Baha''i Blog'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Baha''i Blog', NULL, 'https://www.bahaiblog.net', NULL, NULL, 'Baha''i Blog — австралійська ініціатива бахаї з музикою, аудіо, подкастами, відео, статтями й зображеннями про Віру бахаї та її ідеали.', 'Baha''i Blog is an Australian Baha''i initiative with music, audio, podcasts, videos, articles and images about the Baha''i Faith and its ideals.', 'Проєкт, що поєднує бахаї та їхніх друзів через особисті історії, мистецтво й медіа. Розділи: музика, аудіо й подкасти, відео, статті, зображення, календар бахаї, що таке Віра бахаї, матеріали для завантаження та хаб для авторів контенту (брифи, редакційні принципи, оплата).', 'A project connecting Baha''is and friends through personal stories, arts and media. Sections include music, audio and podcasts, videos, articles, images, the Baha''i calendar, what the Baha''i Faith is, downloadable content and a creator hub (briefs, editorial values, remuneration).', 'Музика й подкасти
Відео й статті
Матеріали для завантаження
Хаб для авторів', 'Music and podcasts
Videos and articles
Downloadable content
Creator hub', 'Бахаї та їхні друзі.', 'Baha''is and friends.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bahaiblog.net' OR LOWER(`name`) = LOWER('Baha''i Blog')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'bahai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Baha''i Blog is an Australian Baha''i initiative with music, audio, podcasts, videos, articles and images about the Baha''i Faith and its ideals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A project connecting Baha''is and friends through personal stories, arts and media. Sections include music, audio and podcasts, videos, articles, images, the Baha''i calendar, what the Baha''i Faith is, downloadable content and a creator hub (briefs, editorial values, remuneration).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Music and podcasts
Videos and articles
Downloadable content
Creator hub', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Baha''is and friends.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bahá'í Library Online — Бахаї
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bahai-library.com' OR LOWER(`name`) = LOWER('Bahá''í Library Online'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bahá''í Library Online', NULL, 'https://bahai-library.com', NULL, NULL, 'Bahá''í Library Online — незалежна онлайн-бібліотека бахаї: першоджерела, листи Всесвітнього Дому Справедливості й Шоґі Еффенді, статті й книги за темами.', 'Bahá''í Library Online is an independent Bahá’í library: primary sources, letters of the Universal House of Justice and Shoghi Effendi, articles and books by subject.', 'Приватний незалежний сайт, не схвалений інституціями бахаї й не пов''язаний з офіційною Довідковою бібліотекою. Містить першоджерела (авторитетні писання й настанови), документи й листи Всесвітнього Дому Справедливості, неопубліковані листи Шоґі Еффенді, статті, книги, нові й рекомендовані матеріали, перегляд за темами та карту сайту.', 'A private, independent site not endorsed by any Bahá’í institution or affiliated with the official Reference Library. It holds primary sources (authoritative writings and guidance), Universal House of Justice documents and letters, unpublished Shoghi Effendi letters, articles, books, new and featured material, subject browsing and a site map.', 'Першоджерела
Листи й документи
Статті й книги
Перегляд за темами', 'Primary sources
Letters and documents
Articles and books
Browse by subject', 'Дослідники Віри бахаї.', 'Researchers of the Bahá’í Faith.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bahai-library.com' OR LOWER(`name`) = LOWER('Bahá''í Library Online')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'bahai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Bahá''í Library Online is an independent Bahá’í library: primary sources, letters of the Universal House of Justice and Shoghi Effendi, articles and books by subject.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A private, independent site not endorsed by any Bahá’í institution or affiliated with the official Reference Library. It holds primary sources (authoritative writings and guidance), Universal House of Justice documents and letters, unpublished Shoghi Effendi letters, articles, books, new and featured material, subject browsing and a site map.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Primary sources
Letters and documents
Articles and books
Browse by subject', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Researchers of the Bahá’í Faith.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bahá'ís of the United States — Бахаї
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bahai.us' OR LOWER(`name`) = LOWER('Bahá''ís of the United States'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bahá''ís of the United States', NULL, 'https://www.bahai.us', NULL, NULL, 'Сайт громади бахаї США: вірування й походження Віри, Дім поклоніння у Вілметті, громадська діяльність і вхід для членів.', 'The Bahá’ís of the United States site: beliefs and origins of the Faith, the House of Worship in Wilmette, community building and member login.', 'Офіційний сайт американської громади бахаї. Пояснює основні вірування й практики Віри, зосереджені на служінні суспільству та духовному оновленні, походження Віри й учення Бахаулли, розповідає про Дім поклоніння бахаї у Вілметті (Іллінойс), громадське будівництво й має вхід для членів.', 'The official site of the US Bahá’í community. It explains the Faith''s basic beliefs and practices, focused on service to society and spiritual renewal, its origins and Bahá’u’lláh''s teachings, and covers the Bahá’í House of Worship in Wilmette, Illinois, community building and a member login.', 'Вірування коротко
Дім поклоніння у Вілметті
Громадська діяльність
Вхід для членів', 'Beliefs at a glance
Wilmette House of Worship
Community building
Member login', 'Бахаї та зацікавлені в США.', 'Bahá’ís and interested people in the USA.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bahai.us' OR LOWER(`name`) = LOWER('Bahá''ís of the United States')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'bahai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Bahá’ís of the United States site: beliefs and origins of the Faith, the House of Worship in Wilmette, community building and member login.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official site of the US Bahá’í community. It explains the Faith''s basic beliefs and practices, focused on service to society and spiritual renewal, its origins and Bahá’u’lláh''s teachings, and covers the Bahá’í House of Worship in Wilmette, Illinois, community building and a member login.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Beliefs at a glance
Wilmette House of Worship
Community building
Member login', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Bahá’ís and interested people in the USA.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bahá’í Calendar — Бахаї
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bahai.org/action/devotional-life/calendar' OR LOWER(`name`) = LOWER('Bahá’í Calendar'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bahá’í Calendar', NULL, 'https://www.bahai.org/action/devotional-life/calendar', NULL, NULL, 'Календар бахаї (Баді) на bahai.org: 19 місяців по 19 днів, святі дні й ритми громадського життя, кількома мовами.', 'The Bahá’í (Badí‘) calendar on bahai.org: 19 months of 19 days, Holy Days and the rhythms of community life, in several languages.', 'Сторінка офіційного сайту всесвітньої громади бахаї про календар бахаї, що складається з 19 місяців по 19 днів у сонячному році та включає святі дні. Пояснює, як календар виражає ритми й єдність життя громади. Доступна арабською, китайською, французькою, гінді, перською, португальською, російською, іспанською та суахілі.', 'A page on the worldwide Bahá’í community''s official site about the Bahá’í calendar of 19 months of 19 days in a solar year, including Holy Days. It explains how the calendar expresses the rhythms and unity of community life. Available in Arabic, Chinese, French, Hindi, Persian, Portuguese, Russian, Spanish and Swahili.', '19 місяців по 19 днів
Святі дні
Десять мов', '19 months of 19 days
Holy Days
Ten languages', 'Бахаї та зацікавлені.', 'Baha''is and interested readers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bahai.org/action/devotional-life/calendar' OR LOWER(`name`) = LOWER('Bahá’í Calendar')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'bahai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Bahá’í (Badí‘) calendar on bahai.org: 19 months of 19 days, Holy Days and the rhythms of community life, in several languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A page on the worldwide Bahá’í community''s official site about the Bahá’í calendar of 19 months of 19 days in a solar year, including Holy Days. It explains how the calendar expresses the rhythms and unity of community life. Available in Arabic, Chinese, French, Hindi, Persian, Portuguese, Russian, Spanish and Swahili.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '19 months of 19 days
Holy Days
Ten languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Baha''is and interested readers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bahá’í Community of Canada — Бахаї
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bahai.ca' OR LOWER(`name`) = LOWER('Bahá’í Community of Canada'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bahá’í Community of Canada', NULL, 'https://www.bahai.ca', NULL, NULL, 'Офіційний сайт громади бахаї Канади: хто ми, що робимо, контакти; англійською та французькою.', 'The official site of the Bahá’í Community of Canada: who we are, what we do and contacts; in English and French.', 'Сайт різноманітної й зростаючої громади бахаї Канади з цитатою Бахаулли «Нехай ваше бачення охоплює весь світ». Розділи «Хто ми» та «Що ми робимо» розповідають про громаду, її діяльність і участь у суспільному житті; є контакти та французька версія.', 'The site of Canada''s diverse and growing Bahá’í community, quoting Bahá’u’lláh: "Let your vision be world-embracing". Who We Are and What We Do cover the community, its activities and participation in public life; contacts and a French version are available.', 'Про громаду
Діяльність
Англійська й французька', 'About the community
Activities
English and French', 'Бахаї та зацікавлені в Канаді.', 'Bahá’ís and interested people in Canada.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bahai.ca' OR LOWER(`name`) = LOWER('Bahá’í Community of Canada')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'bahai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official site of the Bahá’í Community of Canada: who we are, what we do and contacts; in English and French.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of Canada''s diverse and growing Bahá’í community, quoting Bahá’u’lláh: "Let your vision be world-embracing". Who We Are and What We Do cover the community, its activities and participation in public life; contacts and a French version are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'About the community
Activities
English and French', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Bahá’ís and interested people in Canada.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bahá’í Holy Places and Gardens — Бахаї
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ganbahai.org.il' OR LOWER(`name`) = LOWER('Bahá’í Holy Places and Gardens'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bahá’í Holy Places and Gardens', NULL, 'https://ganbahai.org.il', NULL, NULL, 'Сайт святих місць і садів Всесвітнього центру бахаї в Хайфі та Акко (Бахджі): години відкриття, екскурсії за записом, оглядові майданчики й події.', 'The site of the Bahá’í World Centre''s holy places and gardens in Haifa and ‘Akko (Bahjí): opening hours, guided tours by reservation, viewpoints and events.', 'Офіційний сайт для відвідувачів садів і святинь бахаї в Ізраїлі. Містить години роботи в Хайфі й Бахджі, бронювання екскурсій, оглядові точки для самостійного відвідування (верхні тераси, головний вхід, Німецька колонія), години доступу до Святині й садів, події та закриття.', 'The official visitor site for the Bahá’í gardens and shrines in Israel. It lists opening hours in Haifa and Bahjí, guided tour booking, self-guided viewpoints (Upper Terraces, Main Entrance, German Colony Plaza), Shrine and garden hours, events and closures.', 'Години відкриття
Бронювання екскурсій
Оглядові майданчики
Події', 'Opening hours
Tour booking
Viewpoints
Events', 'Паломники й туристи в Хайфі та Акко.', 'Pilgrims and tourists in Haifa and Akko.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ganbahai.org.il' OR LOWER(`name`) = LOWER('Bahá’í Holy Places and Gardens')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'bahai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The site of the Bahá’í World Centre''s holy places and gardens in Haifa and ‘Akko (Bahjí): opening hours, guided tours by reservation, viewpoints and events.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official visitor site for the Bahá’í gardens and shrines in Israel. It lists opening hours in Haifa and Bahjí, guided tour booking, self-guided viewpoints (Upper Terraces, Main Entrance, German Colony Plaza), Shrine and garden hours, events and closures.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Opening hours
Tour booking
Viewpoints
Events', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Pilgrims and tourists in Haifa and Akko.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відвідування', 'Visits' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Visits', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ocean of Lights — Бахаї
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oceanoflights.org' OR LOWER(`name`) = LOWER('Ocean of Lights'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ocean of Lights', NULL, 'https://oceanoflights.org', NULL, NULL, 'Ocean of Lights — дослідження священних текстів бахаї з каталогом скрижалей, аудіо, нотатками й паралельними перекладами; англійською, арабською, перською.', 'Ocean of Lights explores Bahá’í sacred texts with a tablet catalog, audio, notes and side-by-side translations; in English, Arabic and Persian.', 'Ресурс, побудований навколо скрижалей: твори Бахаулли, Баба, Абдул-Баха, Шоґі Еффенді, Найвеличнішого Святого Листка й послання Всесвітнього Дому Справедливості з пов''язаним аудіо, нотатками й паралельними перекладами для навчання. Є огляд Віри, центральні постаті, каталог скрижалей, посібник і FAQ.', 'A tablet-centred resource: writings of Bahá’u’lláh, the Báb, ‘Abdu’l-Bahá, Shoghi Effendi, the Greatest Holy Leaf and messages of the Universal House of Justice, with linked audio, notes and side-by-side translations as study aids. It includes an overview of the Faith, central figures, a tablet catalog, a guide and FAQs.', 'Каталог скрижалей
Паралельні переклади
Аудіо
Три мови', 'Tablet catalog
Side-by-side translations
Audio
Three languages', 'Ті, хто вивчає писання бахаї в оригіналі.', 'People studying Bahá’í writings in the original.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oceanoflights.org' OR LOWER(`name`) = LOWER('Ocean of Lights')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'bahai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ocean of Lights explores Bahá’í sacred texts with a tablet catalog, audio, notes and side-by-side translations; in English, Arabic and Persian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A tablet-centred resource: writings of Bahá’u’lláh, the Báb, ‘Abdu’l-Bahá, Shoghi Effendi, the Greatest Holy Leaf and messages of the Universal House of Justice, with linked audio, notes and side-by-side translations as study aids. It includes an overview of the Faith, central figures, a tablet catalog, a guide and FAQs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tablet catalog
Side-by-side translations
Audio
Three languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People studying Bahá’í writings in the original.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ruhi Institute — Бахаї
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ruhi.org' OR LOWER(`name`) = LOWER('Ruhi Institute'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ruhi Institute', NULL, 'https://www.ruhi.org', NULL, NULL, 'Ruhi Institute — навчальні курси бахаї для духовної освіти різного віку: основна послідовність курсів, матеріали багатьма мовами, ресурси для вчителів.', 'The Ruhi Institute offers Bahá’í study courses for spiritual education at all ages: the main sequence, materials in many languages and teacher resources.', 'Інститут розробляє навчальні матеріали для духовної освіти. На сайті — концептуальна рамка (мета, розробка програм, шлях служіння), програми й матеріали для всіх вікових груп, курси для вивчення різними мовами, основна послідовність курсів, історичні буклети, куточок учителя, пісні, розмальовки й арт-аркуші.', 'The Institute develops materials for spiritual education. The site has its conceptual framework (purpose, curriculum development, path of service), programs and materials for all ages, courses to study in many languages, the main sequence of courses, history booklets, a teachers'' corner, songs, coloring and art sheets.', 'Основна послідовність курсів
Матеріали багатьма мовами
Куточок учителя
Пісні й розмальовки', 'Main sequence of courses
Materials in many languages
Teachers'' corner
Songs and coloring sheets', 'Учасники навчальних гуртків бахаї.', 'Bahá’í study circle participants.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ruhi.org' OR LOWER(`name`) = LOWER('Ruhi Institute')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'bahai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Ruhi Institute offers Bahá’í study courses for spiritual education at all ages: the main sequence, materials in many languages and teacher resources.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Institute develops materials for spiritual education. The site has its conceptual framework (purpose, curriculum development, path of service), programs and materials for all ages, courses to study in many languages, the main sequence of courses, history booklets, a teachers'' corner, songs, coloring and art sheets.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Main sequence of courses
Materials in many languages
Teachers'' corner
Songs and coloring sheets', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Bahá’í study circle participants.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Матеріали онлайн', 'Online materials' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Online materials', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- The Bahá’í World — Бахаї
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bahaiworld.bahai.org' OR LOWER(`name`) = LOWER('The Bahá’í World'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Bahá’í World', NULL, 'https://bahaiworld.bahai.org', NULL, NULL, 'The Bahá’í World — онлайн-видання громади бахаї зі статтями про цивілізацію, історію, науку й суспільство в світлі вчення бахаї; бібліотека спецколекцій.', 'The Bahá’í World is the community''s online publication with articles on civilization, history, science and society in light of Bahá’í teachings; special collections library.', 'Онлайн-публікація, що спирається на вчення бахаї та досвід громади. Публікує есеї про нейронауку й людську природу, інновації, цивілізацію і світовий порядок, історію тощо, має бібліотеку спецколекцій, розділ «Про видання» та підписку.', 'An online publication drawing on Bahá’í teachings and community experience. It publishes essays on neuroscience and human nature, innovation, civilization and world order, history and more, and has a special collections library, an about section and subscriptions.', 'Есеї й статті
Спецколекції
Підписка', 'Essays and articles
Special collections
Subscription', 'Читачі, що цікавляться суспільною думкою бахаї.', 'Readers interested in Bahá’í social thought.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bahaiworld.bahai.org' OR LOWER(`name`) = LOWER('The Bahá’í World')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'bahai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Bahá’í World is the community''s online publication with articles on civilization, history, science and society in light of Bahá’í teachings; special collections library.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An online publication drawing on Bahá’í teachings and community experience. It publishes essays on neuroscience and human nature, innovation, civilization and world order, history and more, and has a special collections library, an about section and subscriptions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Essays and articles
Special collections
Subscription', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers interested in Bahá’í social thought.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- UK Bahá'í Community — Бахаї
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bahai.org.uk' OR LOWER(`name`) = LOWER('UK Bahá''í Community'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'UK Bahá''í Community', NULL, 'https://www.bahai.org.uk', NULL, NULL, 'Сайт громади бахаї Великої Британії: вірування, святі місця у Британії, календар бахаї, освіта, суспільний дискурс, служіння й історія громади.', 'The UK Bahá’í Community site: beliefs, UK holy sites, the Bahá’í calendar, education, public discourse, service and community history.', 'Британська громада бахаї вчиться разом із суспільством будувати згуртовані громади. На сайті — про Віру й вірування, святі місця бахаї у Великій Британії, календар бахаї, освіта й розвиток спроможності, участь у суспільному дискурсі, служіння суспільству, історія громади та політики безпеки.', 'The UK Bahá’í community is learning with all of society to build vibrant, united communities. The site covers the Faith and beliefs, UK Bahá’í holy sites, the Bahá’í calendar, education and capacity building, engaging in public discourse, serving society, community history and safeguarding policies.', 'Святі місця у Британії
Календар бахаї
Освіта
Історія громади', 'UK holy sites
Bahá’í calendar
Education
Community history', 'Бахаї та зацікавлені у Великій Британії.', 'Bahá’ís and interested people in the UK.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bahai.org.uk' OR LOWER(`name`) = LOWER('UK Bahá''í Community')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'bahai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The UK Bahá’í Community site: beliefs, UK holy sites, the Bahá’í calendar, education, public discourse, service and community history.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The UK Bahá’í community is learning with all of society to build vibrant, united communities. The site covers the Faith and beliefs, UK Bahá’í holy sites, the Bahá’í calendar, education and capacity building, engaging in public discourse, serving society, community history and safeguarding policies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'UK holy sites
Bahá’í calendar
Education
Community history', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Bahá’ís and interested people in the UK.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Wilmette Institute — Бахаї
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wilmetteinstitute.org' OR LOWER(`name`) = LOWER('Wilmette Institute'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Wilmette Institute', NULL, 'https://wilmetteinstitute.org', NULL, NULL, 'Wilmette Institute — онлайн-курси бахаї та безоплатна сертифікатна програма з соціальної трансформації: курси, викладачі, вступ і бібліотека.', 'The Wilmette Institute offers Bahá’í online courses and a tuition-free certificate program in social transformation: courses, faculty, admissions and library.', 'Онлайн-навчальний заклад із курсами для особистих і суспільних змін. Пропонує сертифікат із соціальної трансформації без оплати за навчання, окремі курси, академічний календар 2026/2027, правила вступу й есе, бібліотечні й студентські сервіси, підсумкові презентації та відгуки випускників.', 'An online institution with courses for personal and social change. It offers a tuition-free certificate in social transformation, individual courses, the 2026/2027 academic calendar, admissions policies and essays, library and student services, final course presentations and alumni stories.', 'Онлайн-курси
Безоплатний сертифікат
Академічний календар
Бібліотека', 'Online courses
Tuition-free certificate
Academic calendar
Library', 'Дорослі, що вивчають вчення бахаї.', 'Adults studying Bahá’í teachings.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wilmetteinstitute.org' OR LOWER(`name`) = LOWER('Wilmette Institute')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'bahai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Wilmette Institute offers Bahá’í online courses and a tuition-free certificate program in social transformation: courses, faculty, admissions and library.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An online institution with courses for personal and social change. It offers a tuition-free certificate in social transformation, individual courses, the 2026/2027 academic calendar, admissions policies and essays, library and student services, final course presentations and alumni stories.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online courses
Tuition-free certificate
Academic calendar
Library', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adults studying Bahá’í teachings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Сертифікатна програма', 'Certificate program', 0.00, 'free', 'Без оплати за навчання', 'Tuition-free' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Сертифікатна програма' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Certificate program', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Tuition-free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Бахаї України — Бахаї
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bahai.ua' OR LOWER(`name`) = LOWER('Бахаї України'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Бахаї України', NULL, 'https://bahai.ua', NULL, NULL, 'Офіційний сайт громади бахаї України: вчення (Бахаулла, Баб, Абдул-Баха), єдність людства, освіта дітей і молоді, соціальна діяльність.', 'The official site of the Bahá’í community of Ukraine: teachings (Bahá’u’lláh, the Báb, ‘Abdu’l-Bahá), unity of humanity, education for children and youth, social action.', 'Сайт релігійної громади послідовників Віри бахаї в Україні. Розділ «Вчення» розповідає про Бахауллу, Баба, Абдул-Баха, Шоґі Еффенді, Всесвітній Дім Справедливості, єдність людства, принцип консультації, мир, єдність науки й релігії, природу душі та сім''ю. «Діяльність» — поклоніння й служіння, освіта дітей, програми для підлітків і молоді, соціальні ініціативи.', 'The site of the Bahá’í religious community in Ukraine. The Teachings section covers Bahá’u’lláh, the Báb, ‘Abdu’l-Bahá, Shoghi Effendi, the Universal House of Justice, the unity of humanity, consultation, peace, the harmony of science and religion, the nature of the soul and the family. Activities cover worship and service, children''s education, junior youth and youth programs and social action.', 'Українською
Основи вчення
Освіта дітей і молоді
Соціальна діяльність', 'In Ukrainian
Core teachings
Children and youth education
Social action', 'Мешканці України, що цікавляться Вірою бахаї.', 'People in Ukraine interested in the Bahá’í Faith.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bahai.ua' OR LOWER(`name`) = LOWER('Бахаї України')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'bahai' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The official site of the Bahá’í community of Ukraine: teachings (Bahá’u’lláh, the Báb, ‘Abdu’l-Bahá), unity of humanity, education for children and youth, social action.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of the Bahá’í religious community in Ukraine. The Teachings section covers Bahá’u’lláh, the Báb, ‘Abdu’l-Bahá, Shoghi Effendi, the Universal House of Justice, the unity of humanity, consultation, peace, the harmony of science and religion, the nature of the soul and the family. Activities cover worship and service, children''s education, junior youth and youth programs and social action.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'In Ukrainian
Core teachings
Children and youth education
Social action', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in Ukraine interested in the Bahá’í Faith.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Chinese Text Project — Даосизм і конфуціанство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ctext.org' OR LOWER(`name`) = LOWER('Chinese Text Project'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Chinese Text Project', NULL, 'https://ctext.org', NULL, NULL, 'Chinese Text Project — найбільша відкрита бібліотека давньокитайських текстів: конфуціанські й даоські класики (Лунь юй, Дао де цзин), паралельні переклади й пошук.', 'The Chinese Text Project is a large open library of pre-modern Chinese texts: Confucian and Daoist classics (Analects, Daodejing), parallel translations and search.', 'Онлайн-бібліотека давньокитайських текстів для дослідників і читачів. Містить конфуціанські класики («Лунь юй», «Мен-цзи», «Ліцзі»), даоські тексти («Дао де цзин», «Чжуан-цзи»), паралельні англійські переклади, словник, повнотекстовий пошук і цифрові факсиміле. Вільний доступ підтримують передплати установ.', 'An online library of pre-modern Chinese texts for researchers and readers. It contains Confucian classics (Analects, Mengzi, Liji), Daoist texts (Daodejing, Zhuangzi), parallel English translations, a dictionary, full-text search and digital facsimiles. Free access is supported by institutional subscriptions.', 'Конфуціанські класики
Даоські тексти
Паралельні переклади
Повнотекстовий пошук', 'Confucian classics
Daoist texts
Parallel translations
Full-text search', 'Синологи, студенти й читачі класики.', 'Sinologists, students and readers of the classics.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ctext.org' OR LOWER(`name`) = LOWER('Chinese Text Project')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'taoism-confucianism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Chinese Text Project is a large open library of pre-modern Chinese texts: Confucian and Daoist classics (Analects, Daodejing), parallel translations and search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An online library of pre-modern Chinese texts for researchers and readers. It contains Confucian classics (Analects, Mengzi, Liji), Daoist texts (Daodejing, Zhuangzi), parallel English translations, a dictionary, full-text search and digital facsimiles. Free access is supported by institutional subscriptions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Confucian classics
Daoist texts
Parallel translations
Full-text search', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sinologists, students and readers of the classics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для читачів', 'For readers' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For readers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Confucian Academy (孔教學院) — Даосизм і конфуціанство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'confucianacademy.com' OR LOWER(`name`) = LOWER('Confucian Academy (孔教學院)'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Confucian Academy (孔教學院)', NULL, 'https://www.confucianacademy.com', NULL, NULL, 'Конфуціанська академія (Гонконг) — конфуціанська релігійна й освітня організація: новини, поширення вчення Конфуція, освіта, культура й видання.', 'The Confucian Academy (Hong Kong) is a Confucian religious and educational body: news, promoting Confucius''s teachings, education, culture and publications.', 'Сайт Конфуціанської академії китайською мовою. Розділи: про академію, новини, поширення вчення Конфуція, освітня діяльність, культура й видання (зокрема «Читанка Конфуція» та збірки висловів), кабінет членів, дарування статуй Конфуція й контакти.', 'The Confucian Academy''s site in Chinese. Sections cover the academy, news, promoting Confucius''s teachings, education, culture and publications (such as a Confucius reader and collections of sayings), a member area, donated Confucius statues and contacts.', 'Новини академії
Видання
Освіта
Китайською', 'Academy news
Publications
Education
In Chinese', 'Китайськомовні читачі, що цікавляться конфуціанством.', 'Chinese-speaking readers interested in Confucianism.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'confucianacademy.com' OR LOWER(`name`) = LOWER('Confucian Academy (孔教學院)')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'taoism-confucianism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Confucian Academy (Hong Kong) is a Confucian religious and educational body: news, promoting Confucius''s teachings, education, culture and publications.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Confucian Academy''s site in Chinese. Sections cover the academy, news, promoting Confucius''s teachings, education, culture and publications (such as a Confucius reader and collections of sayings), a member area, donated Confucius statues and contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Academy news
Publications
Education
In Chinese', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Chinese-speaking readers interested in Confucianism.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Daoist Foundation — Даосизм і конфуціанство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'daoistfoundation.org' OR LOWER(`name`) = LOWER('Daoist Foundation'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Daoist Foundation', NULL, 'https://www.daoistfoundation.org', NULL, NULL, 'Daoist Foundation — некомерційна організація США для автентичного вивчення та практики даосизму: практика, спільнота, події, тексти, проєкти й ресурси.', 'The Daoist Foundation is a US nonprofit fostering authentic Daoist study and practice: cultivation, community, events, texts, projects and resources.', 'Федерально визнана некомерційна організація, що зберігає й передає традиційну даоську культуру. Розділи: практика (самовдосконалення), спільнота, події, тексти, проєкти, видавництво, ресурси, про фонд і контакти.', 'A federally recognized nonprofit preserving and transmitting traditional Daoist culture. Sections cover cultivation, community, events, texts, projects, an imprint, resources, about and contact.', 'Даоська практика
Тексти
Події
Ресурси', 'Daoist cultivation
Texts
Events
Resources', 'Ті, хто вивчає й практикує даосизм.', 'People studying and practicing Daoism.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'daoistfoundation.org' OR LOWER(`name`) = LOWER('Daoist Foundation')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'taoism-confucianism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Daoist Foundation is a US nonprofit fostering authentic Daoist study and practice: cultivation, community, events, texts, projects and resources.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A federally recognized nonprofit preserving and transmitting traditional Daoist culture. Sections cover cultivation, community, events, texts, projects, an imprint, resources, about and contact.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Daoist cultivation
Texts
Events
Resources', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People studying and practicing Daoism.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Матеріали сайту', 'Site materials' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Site materials', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Taoist Tai Chi Society — Даосизм і конфуціанство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'taoisttaichi.org' OR LOWER(`name`) = LOWER('Taoist Tai Chi Society'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Taoist Tai Chi Society', NULL, 'https://www.taoisttaichi.org', NULL, NULL, 'Taoist Tai Chi Society — міжнародне товариство даоського тай-чи (Fung Loy Kok): пошук занять поруч, даоські практики, співи й програми; 14 мов.', 'The Taoist Tai Chi Society is an international society for Taoist tai chi (Fung Loy Kok): local class finder, Taoist practices, chanting and programs; 14 languages.', 'Товариство навчає даоських мистецтв тай-чи, які поєднує із даосизмом як практикою вдосконалення тіла, розуму й духу. Сайт допомагає знайти найближче місце занять, розповідає про програми для людей старшого віку, даоські співи «за світ» і розділ про тай-чи для людей із хронічними станами (як доповнення, за словами організації). Доступний чотирнадцятьма мовами.', 'The society teaches Taoist tai chi arts, linking them to Taoism as cultivation of body, mind and spirit. The site helps find a nearby location, covers programs for seniors, Taoist chanting for the world and a section on tai chi for people with chronic conditions (as a complement, in the organization''s words). Available in fourteen languages.', 'Пошук занять поруч
Програми для старших
Даоські співи
14 мов', 'Local class finder
Programs for seniors
Taoist chanting
14 languages', 'Ті, хто хоче займатися тай-чи.', 'People who want to practice tai chi.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'taoisttaichi.org' OR LOWER(`name`) = LOWER('Taoist Tai Chi Society')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'taoism-confucianism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Taoist Tai Chi Society is an international society for Taoist tai chi (Fung Loy Kok): local class finder, Taoist practices, chanting and programs; 14 languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The society teaches Taoist tai chi arts, linking them to Taoism as cultivation of body, mind and spirit. The site helps find a nearby location, covers programs for seniors, Taoist chanting for the world and a section on tai chi for people with chronic conditions (as a complement, in the organization''s words). Available in fourteen languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local class finder
Programs for seniors
Taoist chanting
14 languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to practice tai chi.', 'manual' FROM DUAL WHERE @new = 1;

-- Taoistic.com — Даосизм і конфуціанство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'taoistic.com' OR LOWER(`name`) = LOWER('Taoistic.com'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Taoistic.com', NULL, 'https://www.taoistic.com', NULL, NULL, 'Taoistic.com — сайт про даосизм Лао-цзи: «Дао де цзин», цитати й фальшиві цитати, Чжуан-цзи, даоські мислителі й теми.', 'Taoistic.com is a site on Lao Tzu''s Taoism: the Tao Te Ching, quotes and fake quotes, Chuang Tzu, Taoist thinkers and themes.', 'Освітній сайт, що подає даосизм як філософію гармонійного життя «тут і тепер». Містить переклад «Дао де цзин», добірку цитат і окремий розділ про фальшиві цитати, сторінки про Чжуан-цзи та інших даосів, тематичні статті й пояснення поняття Дао.', 'An educational site presenting Taoism as a philosophy of living well here and now. It contains a Tao Te Ching translation, a quotes collection with a separate section on fake quotes, pages on Chuang Tzu and other Taoists, themed articles and explanations of the Tao.', '«Дао де цзин»
Цитати й фальшиві цитати
Чжуан-цзи
Теми', 'Tao Te Ching
Quotes and fake quotes
Chuang Tzu
Themes', 'Читачі, що відкривають даосизм.', 'Readers discovering Taoism.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'taoistic.com' OR LOWER(`name`) = LOWER('Taoistic.com')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'taoism-confucianism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Taoistic.com is a site on Lao Tzu''s Taoism: the Tao Te Ching, quotes and fake quotes, Chuang Tzu, Taoist thinkers and themes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An educational site presenting Taoism as a philosophy of living well here and now. It contains a Tao Te Ching translation, a quotes collection with a separate section on fake quotes, pages on Chuang Tzu and other Taoists, themed articles and explanations of the Tao.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tao Te Ching
Quotes and fake quotes
Chuang Tzu
Themes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers discovering Taoism.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Terebess: Tao Te Ching translations — Даосизм і конфуціанство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'terebess.hu/english/tao/_index.html' OR LOWER(`name`) = LOWER('Terebess: Tao Te Ching translations'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Terebess: Tao Te Ching translations', NULL, 'https://terebess.hu/english/tao/_index.html', NULL, NULL, 'Terebess Asia Online — велика добірка англійських перекладів «Дао де цзин» Лао-цзи з поясненням структури тексту й рукописів.', 'Terebess Asia Online hosts a large collection of English translations of Lao Tzu''s Tao Te Ching, with notes on the text''s structure and manuscripts.', 'Сторінка-покажчик із десятками англійських версій «Дао де цзин». Пояснює, що текст має близько 5 000 ієрогліфів і 81 коротку главу в двох частинах (Дао цзин, глави 1–37, і Де цзин, 38–81), а найдавніший рукопис — Гоуденський (бл. 300 р. до н. е.). Дає змогу порівнювати переклади.', 'An index page with dozens of English versions of the Tao Te Ching. It explains the text has about 5,000 characters and 81 short chapters in two parts (Dao jing, chapters 1–37, and De jing, 38–81), with the Guodian manuscript (c. 300 BCE) as the earliest. It lets you compare translations.', 'Десятки перекладів
Про структуру тексту
Порівняння версій', 'Dozens of translations
Text structure notes
Compare versions', 'Читачі й дослідники «Дао де цзин».', 'Readers and scholars of the Tao Te Ching.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'terebess.hu/english/tao/_index.html' OR LOWER(`name`) = LOWER('Terebess: Tao Te Ching translations')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'taoism-confucianism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Terebess Asia Online hosts a large collection of English translations of Lao Tzu''s Tao Te Ching, with notes on the text''s structure and manuscripts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An index page with dozens of English versions of the Tao Te Ching. It explains the text has about 5,000 characters and 81 short chapters in two parts (Dao jing, chapters 1–37, and De jing, 38–81), with the Guodian manuscript (c. 300 BCE) as the earliest. It lets you compare translations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Dozens of translations
Text structure notes
Compare versions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers and scholars of the Tao Te Ching.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Atsuta Jingu — Синтоїзм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'atsutajingu.or.jp' OR LOWER(`name`) = LOWER('Atsuta Jingu'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Atsuta Jingu', NULL, 'https://www.atsutajingu.or.jp', NULL, NULL, 'Ацута Дзінгу (Наґоя) — офіційний сайт святилища, де зберігається меч Кусанаґі: історія, свята, обряди, скарбниця й інформація для відвідувачів.', 'Atsuta Jingu (Nagoya) is the official site of the shrine enshrining the Kusanagi sword: history, festivals, rites, treasure hall and visitor information.', 'Сайт одного з найшанованіших святилищ Японії, заснованого, за переказом, для вшанування меча Кусанаґі — однієї з трьох імператорських регалій. Японською розповідає про історію, свята й ритуали (Новий рік, сітіґосан, оміямаірі, очищення), скарбницю, залу мечів, банкетний зал, сезонні пейзажі, проїзд і паркування.', 'The site of one of Japan''s most revered shrines, founded, according to tradition, to enshrine the Kusanagi sword — one of the three Imperial Regalia. In Japanese it covers history, festivals and rites (New Year, shichi-go-san, omiyamairi, purification), the treasure hall, sword hall, banquet hall, seasonal scenery, access and parking.', 'Історія святилища
Свята й обряди
Скарбниця
Інформація для відвідувачів', 'Shrine history
Festivals and rites
Treasure hall
Visitor information', 'Відвідувачі та паломники в Наґої.', 'Visitors and pilgrims in Nagoya.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'atsutajingu.or.jp' OR LOWER(`name`) = LOWER('Atsuta Jingu')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'shinto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Atsuta Jingu (Nagoya) is the official site of the shrine enshrining the Kusanagi sword: history, festivals, rites, treasure hall and visitor information.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of one of Japan''s most revered shrines, founded, according to tradition, to enshrine the Kusanagi sword — one of the three Imperial Regalia. In Japanese it covers history, festivals and rites (New Year, shichi-go-san, omiyamairi, purification), the treasure hall, sword hall, banquet hall, seasonal scenery, access and parking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Shrine history
Festivals and rites
Treasure hall
Visitor information', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Visitors and pilgrims in Nagoya.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Dazaifu Tenmangu — Синтоїзм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dazaifutenmangu.or.jp' OR LOWER(`name`) = LOWER('Dazaifu Tenmangu'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dazaifu Tenmangu', NULL, 'https://www.dazaifutenmangu.or.jp', NULL, NULL, 'Дадзайфу Тенманґу — головне святилище Тенмандзін, присвячене Суґаварі-но Мітідзане: молитви про успіх у навчанні, амулети поштою, свята й мапа території.', 'Dazaifu Tenmangu is the head Tenmangu shrine dedicated to Sugawara no Michizane: prayers for study success, amulets by mail, festivals and grounds map.', 'Сайт святилища в Дадзайфу (Фукуока), де вшановують Суґавару-но Мітідзане як божество навчання, культури й захисту від нещасть. Містить історію, путівник територією (сливи, мистецтво, доступність), молитви (про вступ, навчання, безпеку на дорогах, пологи), замовлення амулетів поштою, весілля й календар свят.', 'The site of the shrine in Dazaifu (Fukuoka), revering Sugawara no Michizane as the deity of learning, culture and protection from misfortune. It covers history, a grounds guide (plum trees, art, accessibility), prayers (for exams, study, road safety, childbirth), amulets by mail, weddings and a festival calendar.', 'Молитви про успіх у навчанні
Амулети поштою
Календар свят
Путівник', 'Prayers for study success
Amulets by mail
Festival calendar
Grounds guide', 'Студенти, паломники й туристи.', 'Students, pilgrims and tourists.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dazaifutenmangu.or.jp' OR LOWER(`name`) = LOWER('Dazaifu Tenmangu')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'shinto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Dazaifu Tenmangu is the head Tenmangu shrine dedicated to Sugawara no Michizane: prayers for study success, amulets by mail, festivals and grounds map.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of the shrine in Dazaifu (Fukuoka), revering Sugawara no Michizane as the deity of learning, culture and protection from misfortune. It covers history, a grounds guide (plum trees, art, accessibility), prayers (for exams, study, road safety, childbirth), amulets by mail, weddings and a festival calendar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Prayers for study success
Amulets by mail
Festival calendar
Grounds guide', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students, pilgrims and tourists.', 'manual' FROM DUAL WHERE @new = 1;

-- Encyclopedia of Shinto — Синтоїзм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'd-museum.kokugakuin.ac.jp/eos' OR LOWER(`name`) = LOWER('Encyclopedia of Shinto'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Encyclopedia of Shinto', NULL, 'https://d-museum.kokugakuin.ac.jp/eos/', NULL, NULL, 'Encyclopedia of Shinto — англомовна онлайн-енциклопедія синтоїзму від Університету Кокуґакуїн: божества, святилища, обряди, вірування й історія.', 'The Encyclopedia of Shinto is Kokugakuin University''s English online encyclopedia of Shinto: kami, shrines, rituals, beliefs and history.', 'Частина цифрового музею Університету Кокуґакуїн — академічна енциклопедія синтоїзму англійською мовою. Містить статті про ками, святилища, обряди й свята, вірування, організації та історію синтоїзму з передмовою, посібником користувача й пошуком.', 'Part of Kokugakuin University''s digital museum: an academic encyclopedia of Shinto in English. It has articles on kami, shrines, rituals and festivals, beliefs, institutions and Shinto history, with a foreword, usage guide and search.', 'Академічні статті
Ками й святилища
Обряди
Англійською', 'Academic articles
Kami and shrines
Rituals
In English', 'Студенти й дослідники японської релігії.', 'Students and researchers of Japanese religion.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'd-museum.kokugakuin.ac.jp/eos' OR LOWER(`name`) = LOWER('Encyclopedia of Shinto')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'shinto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Encyclopedia of Shinto is Kokugakuin University''s English online encyclopedia of Shinto: kami, shrines, rituals, beliefs and history.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Part of Kokugakuin University''s digital museum: an academic encyclopedia of Shinto in English. It has articles on kami, shrines, rituals and festivals, beliefs, institutions and Shinto history, with a foreword, usage guide and search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Academic articles
Kami and shrines
Rituals
In English', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students and researchers of Japanese religion.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Itsukushima Shrine — Синтоїзм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'itsukushimajinja.jp' OR LOWER(`name`) = LOWER('Itsukushima Shrine'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Itsukushima Shrine', NULL, 'https://www.itsukushimajinja.jp', NULL, NULL, 'Іцукусіма Дзіндзя — офіційний сайт святилища на острові Міядзіма (об''єкт Світової спадщини): історія, маршрут огляду, ціни, обряди й весілля, календар подій.', 'Itsukushima Shrine is the official site of the World Heritage shrine on Miyajima: history, visiting route, fees, rites and weddings and an events calendar.', 'Національний скарб і об''єкт Світової спадщини ЮНЕСКО з 1996 року. Сайт японською розповідає про історію й божеств, маршрут огляду святилища (галереї, головна зала, сцена но, великі ворота торії), вартість входу, години роботи, молитви й весілля, допоміжні святилища та календар подій.', 'A National Treasure and UNESCO World Heritage Site since 1996. The Japanese site covers history and deities, the visiting route (corridors, main hall, Noh stage, the great torii), admission fees, opening hours, prayers and weddings, subsidiary shrines and an events calendar.', 'Маршрут огляду
Вартість і години
Обряди й весілля
Календар подій', 'Visiting route
Fees and hours
Rites and weddings
Events calendar', 'Туристи на Міядзімі.', 'Visitors to Miyajima.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'itsukushimajinja.jp' OR LOWER(`name`) = LOWER('Itsukushima Shrine')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'shinto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Itsukushima Shrine is the official site of the World Heritage shrine on Miyajima: history, visiting route, fees, rites and weddings and an events calendar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A National Treasure and UNESCO World Heritage Site since 1996. The Japanese site covers history and deities, the visiting route (corridors, main hall, Noh stage, the great torii), admission fees, opening hours, prayers and weddings, subsidiary shrines and an events calendar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Visiting route
Fees and hours
Rites and weddings
Events calendar', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Visitors to Miyajima.', 'manual' FROM DUAL WHERE @new = 1;

-- Izumo Taisha — Синтоїзм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'izumooyashiro.or.jp' OR LOWER(`name`) = LOWER('Izumo Taisha'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Izumo Taisha', NULL, 'https://izumooyashiro.or.jp', NULL, NULL, 'Ідзумо Тайся — офіційний сайт одного з найдавніших святилищ Японії, присвяченого Окунінусі: божество, свята, перенесення святилища, мапа території.', 'Izumo Taisha is the official site of one of Japan''s oldest shrines, dedicated to Ōkuninushi: deity, festivals, shrine renewal and grounds map.', 'Святилище, відоме як місце шанування божества шлюбних уз і удачі Окунінусі (Дайкоку-сама). Японською сайт розповідає про святилище та божество, легенду про білого зайця з Інаби, свята й обряди, календар (зокрема свято Камі-арі), історію й проєкт перенесення святилища, мапу території, природу та птахів, доїзд і FAQ. Є англійська сторінка.', 'A shrine known for revering Ōkuninushi (Daikoku-sama), deity of marriage ties and fortune. In Japanese it covers the shrine and deity, the White Hare of Inaba legend, festivals and rites, the calendar (including Kamiari-sai), the history and renewal project, a grounds map, nature and birds, access and FAQs. An English page is available.', 'Про божество
Свята й календар
Мапа території
FAQ', 'About the deity
Festivals and calendar
Grounds map
FAQ', 'Паломники й туристи в Сімане.', 'Pilgrims and tourists in Shimane.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'izumooyashiro.or.jp' OR LOWER(`name`) = LOWER('Izumo Taisha')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'shinto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Izumo Taisha is the official site of one of Japan''s oldest shrines, dedicated to Ōkuninushi: deity, festivals, shrine renewal and grounds map.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A shrine known for revering Ōkuninushi (Daikoku-sama), deity of marriage ties and fortune. In Japanese it covers the shrine and deity, the White Hare of Inaba legend, festivals and rites, the calendar (including Kamiari-sai), the history and renewal project, a grounds map, nature and birds, access and FAQs. An English page is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'About the deity
Festivals and calendar
Grounds map
FAQ', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Pilgrims and tourists in Shimane.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Jinja Online Network — Синтоїзм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jinja.jp' OR LOWER(`name`) = LOWER('Jinja Online Network'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Jinja Online Network', NULL, 'https://jinja.jp', NULL, NULL, 'Jinja Online Network — японська мережа сайтів святилищ і спільнота «Тіндзю-но кай» для тих, хто доглядає за місцевими святилищами.', 'Jinja Online Network is a Japanese federation of shrine websites and the Chinju-no-kai community for people caring for local shrines.', 'Федерація онлайн-мережі святилищ відкрила «Тіндзю-но кай» — спільноту, де парафіяни, священники й усі охочі обмінюються досвідом догляду за місцевими святилищами, багато з яких не мають постійного священника. Участь безкоштовна й відкрита для всіх.', 'The shrine online network federation launched Chinju-no-kai, a community where parishioners, priests and anyone interested share know-how on caring for local shrines, many of which have no resident priest. Participation is free and open to all.', 'Спільнота доглядачів святилищ
Обмін досвідом
Участь безкоштовна', 'Shrine caretakers community
Know-how sharing
Free participation', 'Парафіяни та доглядачі місцевих святилищ.', 'Parishioners and caretakers of local shrines.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jinja.jp' OR LOWER(`name`) = LOWER('Jinja Online Network')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'shinto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Jinja Online Network is a Japanese federation of shrine websites and the Chinju-no-kai community for people caring for local shrines.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The shrine online network federation launched Chinju-no-kai, a community where parishioners, priests and anyone interested share know-how on caring for local shrines, many of which have no resident priest. Participation is free and open to all.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Shrine caretakers community
Know-how sharing
Free participation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parishioners and caretakers of local shrines.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Участь у спільноті', 'Community participation' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Community participation', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kanda Myojin — Синтоїзм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kandamyoujin.or.jp' OR LOWER(`name`) = LOWER('Kanda Myojin'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kanda Myojin', NULL, 'https://www.kandamyoujin.or.jp', NULL, NULL, 'Канда Мьодзін (Токіо) — сайт святилища-покровителя Едо: новини, свято Канда-мацурі, щорічні обряди, амулети, онлайн-запис на новорічні церемонії.', 'Kanda Myojin (Tokyo) is the site of Edo''s guardian shrine: news, the Kanda Matsuri, annual rites, amulets and online booking for New Year ceremonies.', 'Святилище в районі Сотокан, покровитель 108 кварталів Канди, Ніхомбасі, Акіхабари, Отемачі та Маруноучі; раз на два роки проводить Канда-мацурі. Сайт містить привітання настоятеля, новини, щорічні обряди, бронювання граблів-кумаде, відео території, перелік амулетів, онлайн-запис на новорічні церемонії та англійську й китайську версії.', 'A shrine in Sotokanda, guardian of 108 neighbourhoods of Kanda, Nihonbashi, Akihabara, Otemachi and Marunouchi; it holds the Kanda Matsuri every two years. The site has the chief priest''s greeting, news, annual rites, kumade booking, grounds video, an amulet list, online booking for New Year ceremonies and English and Chinese versions.', 'Канда-мацурі
Онлайн-запис на церемонії
Амулети
Три мови', 'Kanda Matsuri
Online ceremony booking
Amulets
Three languages', 'Мешканці й гості Токіо.', 'Tokyo residents and visitors.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kandamyoujin.or.jp' OR LOWER(`name`) = LOWER('Kanda Myojin')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'shinto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Kanda Myojin (Tokyo) is the site of Edo''s guardian shrine: news, the Kanda Matsuri, annual rites, amulets and online booking for New Year ceremonies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A shrine in Sotokanda, guardian of 108 neighbourhoods of Kanda, Nihonbashi, Akihabara, Otemachi and Marunouchi; it holds the Kanda Matsuri every two years. The site has the chief priest''s greeting, news, annual rites, kumade booking, grounds video, an amulet list, online booking for New Year ceremonies and English and Chinese versions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Kanda Matsuri
Online ceremony booking
Amulets
Three languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tokyo residents and visitors.', 'manual' FROM DUAL WHERE @new = 1;

-- Kotohira-gu (Konpira-san) — Синтоїзм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'konpira.or.jp' OR LOWER(`name`) = LOWER('Kotohira-gu (Konpira-san)'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kotohira-gu (Konpira-san)', NULL, 'https://www.konpira.or.jp', NULL, NULL, 'Котохіра-ґу (Компіра-сан) — сайт святилища в Каґаві: молитви й весілля з онлайн-записом, амулети поштою, календар, музеї, кафе й доїзд.', 'Kotohira-gu (Konpira-san) in Kagawa: prayers and weddings with online booking, amulets by mail, calendar, museums, café and access.', 'Святилище на горі Дзодзу, відоме як покровитель мореплавців. Сайт японською пропонує онлайн-запис на молитви й весілля, бронювання для приїзду автомобілем, замовлення амулетів поштою, календар Компіра-сан, години роботи будівель, інформацію про музеї, кафе-ресторан і доїзд.', 'A shrine on Mount Zozu known as a guardian of seafarers. The Japanese site offers online booking for prayers and weddings, car-visit reservations, amulets by mail, the Konpira-san calendar, building hours, museums, a café-restaurant and access information.', 'Онлайн-запис на молитви
Амулети поштою
Календар
Музеї', 'Online prayer booking
Amulets by mail
Calendar
Museums', 'Паломники й туристи на Сікоку.', 'Pilgrims and tourists in Shikoku.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'konpira.or.jp' OR LOWER(`name`) = LOWER('Kotohira-gu (Konpira-san)')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'shinto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Kotohira-gu (Konpira-san) in Kagawa: prayers and weddings with online booking, amulets by mail, calendar, museums, café and access.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A shrine on Mount Zozu known as a guardian of seafarers. The Japanese site offers online booking for prayers and weddings, car-visit reservations, amulets by mail, the Konpira-san calendar, building hours, museums, a café-restaurant and access information.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online prayer booking
Amulets by mail
Calendar
Museums', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Pilgrims and tourists in Shikoku.', 'manual' FROM DUAL WHERE @new = 1;

-- Kumano Hongu Taisha — Синтоїзм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hongutaisha.jp' OR LOWER(`name`) = LOWER('Kumano Hongu Taisha'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kumano Hongu Taisha', NULL, 'https://www.hongutaisha.jp', NULL, NULL, 'Кумано Хонґу Тайся — головне з понад 3 000 святилищ Кумано: новини, свята, амулети й інформація для паломників маршруту Кумано Кодо; є англійська версія.', 'Kumano Hongu Taisha is the head of over 3,000 Kumano shrines: news, festivals, amulets and pilgrim info for the Kumano Kodo; English version available.', 'Офіційний сайт головного святилища мережі Кумано, що складається з трьох груп залів і шанується як Кумано Сансьо Ґонґен. Публікує новини (Новий рік, щорічне свято, нові амулети), зміни цін на амулети, інформацію про обереги Ґо-о й мапу сайту; є англійська версія.', 'The official site of the head shrine of the Kumano network, made up of three groups of halls and revered as Kumano Sansho Gongen. It publishes news (New Year, the annual festival, new amulets), amulet price changes, information on Goō talismans and a site map; an English version is available.', 'Новини святилища
Свята
Амулети
Англійська версія', 'Shrine news
Festivals
Amulets
English version', 'Паломники маршруту Кумано Кодо.', 'Kumano Kodo pilgrims.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hongutaisha.jp' OR LOWER(`name`) = LOWER('Kumano Hongu Taisha')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'shinto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Kumano Hongu Taisha is the head of over 3,000 Kumano shrines: news, festivals, amulets and pilgrim info for the Kumano Kodo; English version available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official site of the head shrine of the Kumano network, made up of three groups of halls and revered as Kumano Sansho Gongen. It publishes news (New Year, the annual festival, new amulets), amulet price changes, information on Goō talismans and a site map; an English version is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Shrine news
Festivals
Amulets
English version', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Kumano Kodo pilgrims.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tsubaki Grand Shrine of America — Синтоїзм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tsubakishrine.org' OR LOWER(`name`) = LOWER('Tsubaki Grand Shrine of America'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tsubaki Grand Shrine of America', NULL, 'https://www.tsubakishrine.org', NULL, NULL, 'Tsubaki Grand Shrine of America — традиційне синтоїстське святилище у штаті Вашингтон: історія, божества, розклад, амулети (офуда, омаморі, ема), камідана й членство.', 'Tsubaki Grand Shrine of America is a traditional Shinto shrine in Washington State: history, kami, schedule, amulets (ofuda, omamori, ema), kamidana and membership.', 'Традиційне синтоїстське святилище на ділянці 25 акрів біля Ґраніт-Фоллз. Сайт розповідає про історію святилища, божеств Сарутахіко й Аме-но-Удзуме, відповідає на питання, публікує розклад, пропонує офуда, омаморі, ема, камідана й приналежності, членство та контакти для церемоній.', 'A traditional Shinto shrine on a 25-acre site near Granite Falls. The site covers its history, the kami Sarutahiko and Ame-no-Uzume, Q&A, the schedule, ofuda, omamori, ema, kamidana and supplies, membership and contacts for ceremonies.', 'Амулети й камідана
Розклад
Членство
Церемонії', 'Amulets and kamidana
Schedule
Membership
Ceremonies', 'Послідовники синто в Північній Америці.', 'Shinto followers in North America.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tsubakishrine.org' OR LOWER(`name`) = LOWER('Tsubaki Grand Shrine of America')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'shinto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tsubaki Grand Shrine of America is a traditional Shinto shrine in Washington State: history, kami, schedule, amulets (ofuda, omamori, ema), kamidana and membership.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A traditional Shinto shrine on a 25-acre site near Granite Falls. The site covers its history, the kami Sarutahiko and Ame-no-Uzume, Q&A, the schedule, ofuda, omamori, ema, kamidana and supplies, membership and contacts for ceremonies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Amulets and kamidana
Schedule
Membership
Ceremonies', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Shinto followers in North America.', 'manual' FROM DUAL WHERE @new = 1;

-- Tsurugaoka Hachimangu — Синтоїзм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hachimangu.or.jp' OR LOWER(`name`) = LOWER('Tsurugaoka Hachimangu'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tsurugaoka Hachimangu', NULL, 'https://www.hachimangu.or.jp', NULL, NULL, 'Цуруґаока Хатіманґу (Камакура) — сайт святилища: історія від Мінамото-но Йорітомо, огляд території, свята, молитви й амулети, весілля, музей; англійською й китайською.', 'Tsurugaoka Hachimangu (Kamakura): the shrine''s site with history from Minamoto no Yoritomo, grounds, festivals, prayers and amulets, weddings and museum; in English and Chinese.', 'Святилище, з якого почалося місто Камакура. Сайт розповідає про історію від Мінамото-но Йорітомо й бога Хатімана, культурні традиції самурайської доби, маршрути територією й Камакурою, скарби, свята, молитви й амулети, весілля, музей і діяльність. Є англійська й китайська версії та посилання на Instagram і YouTube.', 'The shrine from which the city of Kamakura grew. The site covers history from Minamoto no Yoritomo and the deity Hachiman, samurai-era cultural traditions, routes around the grounds and Kamakura, treasures, festivals, prayers and amulets, weddings, the museum and activities. English and Chinese versions and Instagram and YouTube links are available.', 'Історія Камакури
Свята
Музей
Три мови', 'Kamakura history
Festivals
Museum
Three languages', 'Туристи й паломники в Камакурі.', 'Tourists and pilgrims in Kamakura.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hachimangu.or.jp' OR LOWER(`name`) = LOWER('Tsurugaoka Hachimangu')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'shinto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tsurugaoka Hachimangu (Kamakura): the shrine''s site with history from Minamoto no Yoritomo, grounds, festivals, prayers and amulets, weddings and museum; in English and Chinese.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The shrine from which the city of Kamakura grew. The site covers history from Minamoto no Yoritomo and the deity Hachiman, samurai-era cultural traditions, routes around the grounds and Kamakura, treasures, festivals, prayers and amulets, weddings, the museum and activities. English and Chinese versions and Instagram and YouTube links are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Kamakura history
Festivals
Museum
Three languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tourists and pilgrims in Kamakura.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Institute of Jainology — Джайнізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jainology.org' OR LOWER(`name`) = LOWER('Institute of Jainology'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Institute of Jainology', NULL, 'https://www.jainology.org', NULL, NULL, 'Institute of Jainology (Лондон) — «Ненасильство та співчуття в дії»: події, Ahimsa Day, JAINpedia, освіта, міжрелігійний діалог і джайнські храми Британії.', 'The Institute of Jainology (London), "Non-Violence and Compassion in Action": events, Ahimsa Day, JAINpedia, education, interfaith work and UK Jain temples.', 'Організація, що просуває джайнські цінності співчуття й ненасильства. Сайт містить анонси подій, історію інституту, ресурси й перелік джайнських храмів у Британії, видання на продаж, розсилку, День ахімси, представництво в уряді, проєкти OneJAIN, освіту, JAINpedia і міжрелігійні ініціативи.', 'An organization promoting the Jain values of compassion and non-violence. The site has events, the institute''s timeline, resources and a list of UK Jain temples, publications for sale, a newsletter, Ahimsa Day, government representation, OneJAIN projects, education, JAINpedia and interfaith initiatives.', 'Джайнські храми Британії
День ахімси
JAINpedia
Розсилка', 'UK Jain temples
Ahimsa Day
JAINpedia
Newsletter', 'Джайни у Великій Британії та зацікавлені.', 'Jains in the UK and interested readers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jainology.org' OR LOWER(`name`) = LOWER('Institute of Jainology')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'jainism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Institute of Jainology (London), "Non-Violence and Compassion in Action": events, Ahimsa Day, JAINpedia, education, interfaith work and UK Jain temples.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An organization promoting the Jain values of compassion and non-violence. The site has events, the institute''s timeline, resources and a list of UK Jain temples, publications for sale, a newsletter, Ahimsa Day, government representation, OneJAIN projects, education, JAINpedia and interfaith initiatives.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'UK Jain temples
Ahimsa Day
JAINpedia
Newsletter', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Jains in the UK and interested readers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Jain Center of America (New York) — Джайнізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nyjaincenter.org' OR LOWER(`name`) = LOWER('Jain Center of America (New York)'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Jain Center of America (New York)', NULL, 'https://www.nyjaincenter.org', NULL, NULL, 'Jain Center of America (Нью-Йорк, з 1965) — один із перших джайнських центрів Північної Америки: храми, події, календар, членство, освіта й лекції.', 'The Jain Center of America (New York, since 1965) is one of North America''s first Jain centers: temples, events, calendar, membership, education and lectures.', 'Центр, заснований 1965 року як одне з перших джайнських об''єднань Північної Америки, що просуває джайнські принципи й має місце поклоніння. Сайт містить новини й календар, розсилки, галерею, храми Махавіра Свамі та Адінатха, лекційні зали, кабінет членів, пожертви, молодіжну й старшу групи, волонтерство, освіту й лекції науковців.', 'A centre founded in 1965 as one of the first Jain organizations in North America, promoting Jain principles and providing a place of worship. The site has news and a calendar, newsletters, a gallery, the Mahavir Swami and Adinathji temples, lecture halls, member accounts, donations, youth and senior groups, volunteering, education and scholar lectures.', 'Календар подій
Храми
Кабінет членів
Лекції науковців', 'Events calendar
Temples
Member accounts
Scholar lectures', 'Джайни Нью-Йорка.', 'Jains in New York.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nyjaincenter.org' OR LOWER(`name`) = LOWER('Jain Center of America (New York)')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'jainism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Jain Center of America (New York, since 1965) is one of North America''s first Jain centers: temples, events, calendar, membership, education and lectures.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A centre founded in 1965 as one of the first Jain organizations in North America, promoting Jain principles and providing a place of worship. The site has news and a calendar, newsletters, a gallery, the Mahavir Swami and Adinathji temples, lecture halls, member accounts, donations, youth and senior groups, volunteering, education and scholar lectures.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Events calendar
Temples
Member accounts
Scholar lectures', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Jains in New York.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Jain Center of Greater Boston — Джайнізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jcgb.org' OR LOWER(`name`) = LOWER('Jain Center of Greater Boston'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Jain Center of Greater Boston', NULL, 'https://jcgb.org', NULL, NULL, 'Jain Center of Greater Boston (з 1973) — джайнський центр у Норвуді: події й календар, пуджі, свята Паріюшан і Дівалі, школа патшала, членство.', 'The Jain Center of Greater Boston (since 1973) in Norwood: events and calendar, poojas, Paryushan and Diwali festivals, pathshala, membership.', 'Один із перших джайнських центрів такого типу в Північній Америці. Сайт розповідає про центр і громаду, волонтерів, молодіжні групи YJA і YJP, ресурси; містить календар подій (Дев Шастра пуджа, Снатра пуджа, Махавір Джанма Кальянак, Паріюшан, Дас Лакшан, Дівалі), членство, школу патшала й пожертви.', 'One of the first Jain centres of its kind in North America. The site covers the centre and community, volunteers, YJA and YJP youth groups and resources, with an events calendar (Dev Shastra Pooja, Snatra Pooja, Mahavir Janma Kalyanak, Paryushan, Das Laxan, Diwali), membership, pathshala and donations.', 'Календар свят
Школа патшала
Молодіжні групи
Членство', 'Festival calendar
Pathshala
Youth groups
Membership', 'Джайни Бостона.', 'Jains in Boston.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jcgb.org' OR LOWER(`name`) = LOWER('Jain Center of Greater Boston')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'jainism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Jain Center of Greater Boston (since 1973) in Norwood: events and calendar, poojas, Paryushan and Diwali festivals, pathshala, membership.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'One of the first Jain centres of its kind in North America. The site covers the centre and community, volunteers, YJA and YJP youth groups and resources, with an events calendar (Dev Shastra Pooja, Snatra Pooja, Mahavir Janma Kalyanak, Paryushan, Das Laxan, Diwali), membership, pathshala and donations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Festival calendar
Pathshala
Youth groups
Membership', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Jains in Boston.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Jain Center of Northern California — Джайнізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jcnc.org' OR LOWER(`name`) = LOWER('Jain Center of Northern California'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Jain Center of Northern California', NULL, 'https://jcnc.org', NULL, NULL, 'JCNC — Джайнський центр Північної Каліфорнії: події, панчанг, щоденна пуджа, лекції, школа патшала, бібліотека, культурні й молодіжні заходи.', 'JCNC, the Jain Center of Northern California: events, panchang, daily pooja, lectures, pathshala, library, cultural and youth activities.', 'Сайт центру з розділами: реставрація, події й анонси, панчанг (календар), минулі й приватні події, вибори правління; релігійне життя (щоденна пуджа, абхішек, свадх''яя, лекції), освіта (патшала, книги, програма JAB із розкладом і вартістю), волонтерство, пожертви, бібліотека, культурні заходи й молодь.', 'The centre''s site with sections on restoration, events and announcements, the panchang (calendar), past and private events and elections; religious life (daily pooja, abhishek, swadhyay, lectures), education (pathshala, books, the JAB program schedule and fees), volunteering, donations, the library, cultural events and youth.', 'Панчанг
Щоденна пуджа
Школа патшала
Бібліотека', 'Panchang
Daily pooja
Pathshala
Library', 'Джайни Каліфорнії.', 'Jains in California.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jcnc.org' OR LOWER(`name`) = LOWER('Jain Center of Northern California')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'jainism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'JCNC, the Jain Center of Northern California: events, panchang, daily pooja, lectures, pathshala, library, cultural and youth activities.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The centre''s site with sections on restoration, events and announcements, the panchang (calendar), past and private events and elections; religious life (daily pooja, abhishek, swadhyay, lectures), education (pathshala, books, the JAB program schedule and fees), volunteering, donations, the library, cultural events and youth.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Panchang
Daily pooja
Pathshala
Library', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Jains in California.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Jain Quantum — Джайнізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jainqq.org' OR LOWER(`name`) = LOWER('Jain Quantum'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Jain Quantum', NULL, 'https://www.jainqq.org', NULL, NULL, 'Jain Quantum — пошукова система по джайнській літературі: пошук у агамах і сутрах різними мовами, перегляд за категоріями.', 'Jain Quantum is a Jain literature search engine: search across agamas and sutras in many languages and browse by category.', 'Пошуковик, що робить джайнську літературу доступною для учнів патшали, вчителів, викладачів університетів і нерелігійних читачів. Дає змогу знаходити дрібні деталі на сторінках текстів: фільтри за мовою й категорією (анга-агами — Ачаранга, Сутракританга, Стхананга, Самаваянга, Бхагаваті сутри тощо), перегляд і пожертви.', 'A search engine making Jain literature accessible to pathshala students, teachers, university professors and non-Jains. It finds the smallest details within pages: filters by language and category (Ang Agams such as Acharang, Sutrakritanga, Sthananga, Samvayanga and Bhagavati Sutras), browsing and donations.', 'Пошук по агамах
Фільтр за мовою
Перегляд за категоріями
Безкоштовно', 'Agama search
Language filter
Browse by category
Free', 'Учні, викладачі й дослідники джайнізму.', 'Students, teachers and researchers of Jainism.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jainqq.org' OR LOWER(`name`) = LOWER('Jain Quantum')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'jainism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Jain Quantum is a Jain literature search engine: search across agamas and sutras in many languages and browse by category.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A search engine making Jain literature accessible to pathshala students, teachers, university professors and non-Jains. It finds the smallest details within pages: filters by language and category (Ang Agams such as Acharang, Sutrakritanga, Sthananga, Samvayanga and Bhagavati Sutras), browsing and donations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Agama search
Language filter
Browse by category
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students, teachers and researchers of Jainism.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Jain Vishva Bharati Institute — Джайнізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jvbi.ac.in' OR LOWER(`name`) = LOWER('Jain Vishva Bharati Institute'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Jain Vishva Bharati Institute', NULL, 'https://www.jvbi.ac.in', NULL, NULL, 'Jain Vishva Bharati Institute — університет у Ладну (Раджастхан), пов''язаний із джайнською традицією Терапанта: вступ, дистанційна освіта, бібліотека й чат-асистент.', 'Jain Vishva Bharati Institute is a university in Ladnun, Rajasthan, linked to the Jain Terapanth tradition: admissions, distance education, library and a chat assistant.', 'Вищий навчальний заклад, що поєднує академічну освіту з джайнськими цінностями. Сайт пропонує вступ на 2026–27 навчальний рік, дистанційну освіту, онлайн-заявку, бібліотеку, кабінет студента, випускників, вакансії, лікарню натуропатії та чат-асистента англійською й гінді.', 'A higher education institution combining academic study with Jain values. The site offers 2026–27 admissions, distance education, online applications, a library, a student login, alumni, careers, a naturopathy hospital and a chat assistant in English and Hindi.', 'Вступ і заявки онлайн
Дистанційна освіта
Бібліотека
Чат-асистент', 'Admissions and online applications
Distance education
Library
Chat assistant', 'Абітурієнти й студенти джайнології.', 'Applicants and students of Jainology.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jvbi.ac.in' OR LOWER(`name`) = LOWER('Jain Vishva Bharati Institute')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'jainism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Jain Vishva Bharati Institute is a university in Ladnun, Rajasthan, linked to the Jain Terapanth tradition: admissions, distance education, library and a chat assistant.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A higher education institution combining academic study with Jain values. The site offers 2026–27 admissions, distance education, online applications, a library, a student login, alumni, careers, a naturopathy hospital and a chat assistant in English and Hindi.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Admissions and online applications
Distance education
Library
Chat assistant', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Applicants and students of Jainology.', 'manual' FROM DUAL WHERE @new = 1;

-- Jinvani — Джайнізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jinvani.in' OR LOWER(`name`) = LOWER('Jinvani'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Jinvani', NULL, 'https://jinvani.in', NULL, NULL, 'Jinvani — цифрова збірка джайнських текстів гінді: Бгактамар, чалісі, стотри, пуджі (щоденні, святкові), аарті та «розмовляюча Джинвані».', 'Jinvani is a digital collection of Jain texts in Hindi: Bhaktamar, chalisas, stotras, poojas (daily and festival), aartis and a "talking Jinvani".', 'Онлайн-збірка «Наша цифрова Джинвані» з джайнськими текстами гінді. Розділи: джайнські храми, книги, Бгактамар, чалісі, стотри, щоденні, святкові й особливі пуджі, тексти аарті, а також «Talking Jinvani» — аудіоверсія текстів і пошук.', '"Our Digital Jinvani", an online collection of Jain texts in Hindi. Sections include Jain temples, books, Bhaktamar, chalisas, stotras, daily, festival and occasional poojas, aarti lyrics and "Talking Jinvani" audio versions, plus search.', 'Тексти пудж
Бгактамар
Аудіоверсії
Гінді', 'Pooja texts
Bhaktamar
Audio versions
Hindi', 'Джайни, які моляться гінді.', 'Jains praying in Hindi.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jinvani.in' OR LOWER(`name`) = LOWER('Jinvani')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'jainism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Jinvani is a digital collection of Jain texts in Hindi: Bhaktamar, chalisas, stotras, poojas (daily and festival), aartis and a "talking Jinvani".', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', '"Our Digital Jinvani", an online collection of Jain texts in Hindi. Sections include Jain temples, books, Bhaktamar, chalisas, stotras, daily, festival and occasional poojas, aarti lyrics and "Talking Jinvani" audio versions, plus search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Pooja texts
Bhaktamar
Audio versions
Hindi', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Jains praying in Hindi.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Young Jains of America — Джайнізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yja.org' OR LOWER(`name`) = LOWER('Young Jains of America'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Young Jains of America', NULL, 'https://www.yja.org', NULL, NULL, 'Young Jains of America (з 1991) — молодіжна джайнська організація: освіта, події, спільнота, ресурси до Паріюшан і нічні молитви в Zoom.', 'Young Jains of America (since 1991) is a Jain youth organization: education, events, community, Paryushan resources and nightly Zoom prayers.', 'Організація, що дає молоді платформу для розвитку духовної й культурної обізнаності. Сайт має розділи «Про нас», освіта, події, спільнота, пожертви, вхід і реєстрацію; публікує ресурси до свят Паріюшан і Дас Лакшан та запрошує на щовечірні молитви й короткі доповіді в Zoom.', 'An organization giving young people a platform for spiritual and cultural awareness. The site has about, education, events, community, donate, login and join sections; it publishes Paryushan and Das Lakshan resources and invites people to nightly prayers and lightning talks on Zoom.', 'Молодіжні події
Освітні ресурси
Zoom-молитви
Членство', 'Youth events
Education resources
Zoom prayers
Membership', 'Молоді джайни в США.', 'Young Jains in the USA.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yja.org' OR LOWER(`name`) = LOWER('Young Jains of America')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'jainism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Young Jains of America (since 1991) is a Jain youth organization: education, events, community, Paryushan resources and nightly Zoom prayers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An organization giving young people a platform for spiritual and cultural awareness. The site has about, education, events, community, donate, login and join sections; it publishes Paryushan and Das Lakshan resources and invites people to nightly prayers and lightning talks on Zoom.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Youth events
Education resources
Zoom prayers
Membership', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Young Jains in the USA.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Delhi Sikh Gurdwara Management Committee — Сикхізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dsgmc.in' OR LOWER(`name`) = LOWER('Delhi Sikh Gurdwara Management Committee'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Delhi Sikh Gurdwara Management Committee', NULL, 'https://dsgmc.in', NULL, NULL, 'DSGMC — Комітет з управління сикхськими гурдварами Делі (Бангла Сахіб, Ракаб Ґандж та ін.): основи сикхізму, свята, проповідь, амріт санчар і контакти.', 'DSGMC, the Delhi Sikh Gurdwara Management Committee (Bangla Sahib, Rakab Ganj and others): Sikhism basics, Gurpurbs, outreach, Amrit Sanchar and contacts.', 'Офіційний сайт комітету, що керує історичними гурдварами Делі. Містить відомості про DSGMC, тахти й джатхедарів, керівництво, розділи про сикхізм (основні статті й принципи, меч у сикхізмі, обов''язки Хальси, ґурпурби, глосарій), проповідницьку діяльність, амріт санчар, форму зворотного зв''язку й контакти.', 'The official site of the committee managing Delhi''s historic gurdwaras. It covers DSGMC, the Takhts and Jathedars, office bearers, Sikhism sections (basic articles and principles, the sword in Sikhism, duties of the Khalsa, Gurpurbs, glossary), Dharam Parchar, Amrit Sanchar, a feedback form and contacts.', 'Гурдвари Делі
Основи сикхізму
Ґурпурби
Зворотний зв''язок', 'Delhi gurdwaras
Sikhism basics
Gurpurbs
Feedback', 'Сикхи й відвідувачі гурдвар Делі.', 'Sikhs and visitors to Delhi gurdwaras.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dsgmc.in' OR LOWER(`name`) = LOWER('Delhi Sikh Gurdwara Management Committee')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sikhism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'DSGMC, the Delhi Sikh Gurdwara Management Committee (Bangla Sahib, Rakab Ganj and others): Sikhism basics, Gurpurbs, outreach, Amrit Sanchar and contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official site of the committee managing Delhi''s historic gurdwaras. It covers DSGMC, the Takhts and Jathedars, office bearers, Sikhism sections (basic articles and principles, the sword in Sikhism, duties of the Khalsa, Gurpurbs, glossary), Dharam Parchar, Amrit Sanchar, a feedback form and contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Delhi gurdwaras
Sikhism basics
Gurpurbs
Feedback', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sikhs and visitors to Delhi gurdwaras.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Discover Sikhism — Сикхізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'discoversikhism.com' OR LOWER(`name`) = LOWER('Discover Sikhism'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Discover Sikhism', NULL, 'https://www.discoversikhism.com', NULL, NULL, 'Discover Sikhism — освітній портал про сикхів і сикхізм: гуру, Ґуру Ґрантх Сахіб, історія, практики, гурдвари й ресурси для вивчення.', 'Discover Sikhism is an educational portal on the Sikhs and Sikhism: the Gurus, Guru Granth Sahib, history, practices, gurdwaras and study resources.', 'Сайт для знайомства з сикхізмом: десять гуру, священне писання Ґуру Ґрантх Сахіб, історія сикхів, основні принципи й практики, гурдвари, свята, книги й інші ресурси для вивчення.', 'A site for getting to know Sikhism: the ten Gurus, the Guru Granth Sahib scripture, Sikh history, core principles and practices, gurdwaras, festivals, books and other study resources.', 'Про гуру
Ґуру Ґрантх Сахіб
Історія сикхів
Ресурси', 'About the Gurus
Guru Granth Sahib
Sikh history
Resources', 'Ті, хто вперше знайомиться із сикхізмом.', 'People new to Sikhism.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'discoversikhism.com' OR LOWER(`name`) = LOWER('Discover Sikhism')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sikhism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Discover Sikhism is an educational portal on the Sikhs and Sikhism: the Gurus, Guru Granth Sahib, history, practices, gurdwaras and study resources.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site for getting to know Sikhism: the ten Gurus, the Guru Granth Sahib scripture, Sikh history, core principles and practices, gurdwaras, festivals, books and other study resources.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'About the Gurus
Guru Granth Sahib
Sikh history
Resources', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People new to Sikhism.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Gurbanifiles.net — Сикхізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gurbanifiles.net' OR LOWER(`name`) = LOWER('Gurbanifiles.net'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Gurbanifiles.net', NULL, 'https://www.gurbanifiles.net', NULL, NULL, 'Gurbanifiles.net — файли Шрі Ґуру Ґрантх Сахіб для завантаження: ґурмукхі, деванаґарі, шахмукхі, переклади, окремі бані, Unicode-шрифти й PDF.', 'Gurbanifiles.net offers Sri Guru Granth Sahib files to download: Gurmukhi, Devanagari, Shahmukhi, translations, special Banis, Unicode fonts and PDFs.', 'Ресурс для завантаження найсвіжіших файлів Шрі Ґуру Ґрантх Сахіб, які раніше поширювалися на Gurbani-CD. Розділи: ґурмукхі, деванаґарі, переклади, особливі бані, бані за авторами, шахмукхі, Unicode й шрифти, гуджараті, бенгальська, каннада та інші письмена, пов''язані файли й PDF для кишенькових пристроїв.', 'A resource for downloading up-to-date Sri Guru Granth Sahib files formerly distributed on Gurbani-CD. Sections include Gurmukhi, Devanagari, translations, special Banis, Bani by author, Shahmukhi, Unicode and fonts, Gujarati, Bengali, Kannada and other scripts, related files and PDFs for pocket devices.', 'Різні письмена
Переклади
Unicode-шрифти
PDF', 'Multiple scripts
Translations
Unicode fonts
PDFs', 'Читачі й дослідники Ґурбані.', 'Gurbani readers and researchers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gurbanifiles.net' OR LOWER(`name`) = LOWER('Gurbanifiles.net')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sikhism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Gurbanifiles.net offers Sri Guru Granth Sahib files to download: Gurmukhi, Devanagari, Shahmukhi, translations, special Banis, Unicode fonts and PDFs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A resource for downloading up-to-date Sri Guru Granth Sahib files formerly distributed on Gurbani-CD. Sections include Gurmukhi, Devanagari, translations, special Banis, Bani by author, Shahmukhi, Unicode and fonts, Gujarati, Bengali, Kannada and other scripts, related files and PDFs for pocket devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Multiple scripts
Translations
Unicode fonts
PDFs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gurbani readers and researchers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Завантаження', 'Downloads' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Downloads', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Gurmat Bibek — Сикхізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gurmatbibek.com' OR LOWER(`name`) = LOWER('Gurmat Bibek'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Gurmat Bibek', NULL, 'https://www.gurmatbibek.com', NULL, NULL, 'Gurmat Bibek — ресурс про розуміння ґурмату: сантх''я (правильне читання Ґурбані), ґурмат бодх, література й форум.', 'Gurmat Bibek is a resource on understanding Gurmat: Santhiya (correct Gurbani recitation), Gurmat Bodh, literature and a message board.', 'Сайт про «бібек вічар» — глибоке осмислення вчення Гуру. Розділи: сантх''я (навчання правильному читанню Ґурбані), ґурмат бодх, ґурмат-література, дошка оголошень і контакти. Тексти пенджабською та англійською.', 'A site on "Bibek Vichar" — a deep understanding of the Guru''s teaching. Sections include Santhiya (learning correct Gurbani recitation), Gurmat Bodh, Gurmat literature, a message board and contacts. Texts are in Punjabi and English.', 'Сантх''я
Ґурмат-література
Форум
Пенджабська й англійська', 'Santhiya
Gurmat literature
Message board
Punjabi and English', 'Сикхи, що поглиблюють розуміння Ґурбані.', 'Sikhs deepening their understanding of Gurbani.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gurmatbibek.com' OR LOWER(`name`) = LOWER('Gurmat Bibek')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sikhism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Gurmat Bibek is a resource on understanding Gurmat: Santhiya (correct Gurbani recitation), Gurmat Bodh, literature and a message board.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site on "Bibek Vichar" — a deep understanding of the Guru''s teaching. Sections include Santhiya (learning correct Gurbani recitation), Gurmat Bodh, Gurmat literature, a message board and contacts. Texts are in Punjabi and English.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Santhiya
Gurmat literature
Message board
Punjabi and English', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sikhs deepening their understanding of Gurbani.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Nanakshahi.net — Сикхізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nanakshahi.net' OR LOWER(`name`) = LOWER('Nanakshahi.net'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nanakshahi.net', NULL, 'https://nanakshahi.net', NULL, NULL, 'Nanakshahi.net — календар Нанакшахі: ґурпурби та історичні події сикхів, місячні шабади, конвертер дат і рухомі свята; англійською й пенджабською.', 'Nanakshahi.net is the Nanakshahi calendar: Gurpurabs and Sikh historical events, monthly shabads, a date converter and movable Gurpurabs; English and Punjabi.', 'Сайт для перегляду дат за календарем Нанакшахі. Містить календар, ґурпурби, місячні шабади, розклад, калькулятор і конвертер дат, рухомі ґурпурби та підказки про сезонні раги. Доступний англійською й пенджабською.', 'A site for Nanakshahi calendar dates. It has the calendar, Gurpurabs, monthly shabads, timings, a date calculator and converter, movable Gurpurabs and notes on seasonal raags. Available in English and Punjabi.', 'Календар Нанакшахі
Ґурпурби
Конвертер дат
Дві мови', 'Nanakshahi calendar
Gurpurabs
Date converter
Two languages', 'Сикхи, що стежать за святами.', 'Sikhs following holy days.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nanakshahi.net' OR LOWER(`name`) = LOWER('Nanakshahi.net')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sikhism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Nanakshahi.net is the Nanakshahi calendar: Gurpurabs and Sikh historical events, monthly shabads, a date converter and movable Gurpurabs; English and Punjabi.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site for Nanakshahi calendar dates. It has the calendar, Gurpurabs, monthly shabads, timings, a date calculator and converter, movable Gurpurabs and notes on seasonal raags. Available in English and Punjabi.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Nanakshahi calendar
Gurpurabs
Date converter
Two languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sikhs following holy days.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sikh Channel — Сикхізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sikhchannel.tv' OR LOWER(`name`) = LOWER('Sikh Channel'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sikh Channel', NULL, 'https://www.sikhchannel.tv', NULL, NULL, 'Sikh Channel — некомерційний телеканал для сикхської громади світу: прямий ефір, блоги, подкасти й партнери.', 'Sikh Channel is a non-profit TV channel serving the worldwide Sikh community: live broadcast, blogs, podcasts and partners.', 'Некомерційний громадський медіасервіс для сикхів по всьому світу. Пропонує трансляцію наживо, блоги, подкасти, інформацію про партнерів і рекламу та контакти.', 'A non-profit community media service for Sikhs worldwide. It offers a live stream, blogs, podcasts, partner and advertising information and contacts.', 'Прямий ефір
Подкасти
Блоги', 'Live stream
Podcasts
Blogs', 'Сикхська діаспора.', 'The Sikh diaspora.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sikhchannel.tv' OR LOWER(`name`) = LOWER('Sikh Channel')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sikhism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sikh Channel is a non-profit TV channel serving the worldwide Sikh community: live broadcast, blogs, podcasts and partners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A non-profit community media service for Sikhs worldwide. It offers a live stream, blogs, podcasts, partner and advertising information and contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live stream
Podcasts
Blogs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'The Sikh diaspora.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Перегляд наживо', 'Live viewing' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Live viewing', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sikh Dharma International — Сикхізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sikhdharma.org' OR LOWER(`name`) = LOWER('Sikh Dharma International'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sikh Dharma International', NULL, 'https://www.sikhdharma.org', NULL, NULL, 'Sikh Dharma International — некомерційна організація, що поширює вчення сикхських гуру: ідеологія, духовна практика, історія, Gurmukhi, застосунок Japji.', 'Sikh Dharma International is a nonprofit sharing the Sikh Gurus'' teachings: ideology, spiritual practice, history, Gurmukhi, and the Japji app.', 'Організація, натхненна Йоґі Бхаджаном, що ділиться універсальним вченням сикхських гуру. Розділи: ідеологія й вірування, духовна практика, історія сикхів, «Радість ґурмукхі», відеоінструкції, застосунок Japji, історії громади, акханд патх, молитва, практика садхани, блог і програми процвітання (дасвандх).', 'An organization inspired by Yogi Bhajan sharing the universal teachings of the Sikh Gurus. Sections include ideology and beliefs, spiritual practice, Sikh history, Joy of Gurmukhi, how-to videos, the Japji app, community stories, Akhand Paths, prayer, sadhana practice, a blog and prosperity programs (Dasvandh).', 'Застосунок Japji
Вивчення ґурмукхі
Садхана
Відеоінструкції', 'Japji app
Learning Gurmukhi
Sadhana
How-to videos', 'Практики сикхізму, зокрема на Заході.', 'Sikh practitioners, including in the West.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sikhdharma.org' OR LOWER(`name`) = LOWER('Sikh Dharma International')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sikhism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sikh Dharma International is a nonprofit sharing the Sikh Gurus'' teachings: ideology, spiritual practice, history, Gurmukhi, and the Japji app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An organization inspired by Yogi Bhajan sharing the universal teachings of the Sikh Gurus. Sections include ideology and beliefs, spiritual practice, Sikh history, Joy of Gurmukhi, how-to videos, the Japji app, community stories, Akhand Paths, prayer, sadhana practice, a blog and prosperity programs (Dasvandh).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Japji app
Learning Gurmukhi
Sadhana
How-to videos', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sikh practitioners, including in the West.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Матеріали й застосунок', 'Materials and app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Materials and app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sikh Foundation International — Сикхізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sikhfoundation.org' OR LOWER(`name`) = LOWER('Sikh Foundation International'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sikh Foundation International', NULL, 'https://sikhfoundation.org', NULL, NULL, 'Sikh Foundation International — фонд сикхського мистецтва й студій, заснований Наріндером Сінґхом Капані: колекція Kapany, сикхські й пенджабські студії, публікації й події.', 'Sikh Foundation International, founded by Narinder Singh Kapany, supports Sikh arts and studies: the Kapany Collection, Sikh and Punjabi studies, publications and events.', 'Фонд, що популяризує сикхське мистецтво, культуру й академічні студії. Сайт розповідає про місію й засновників, команду й спадщину, колекцію Kapany, блог, програми сикхських і пенджабських студій, публікації, події (наприклад, вечір до 100-річчя доктора Капані), волонтерство й пожертви.', 'A foundation promoting Sikh art, culture and academic studies. The site covers its mission and founders, people and legacy, the Kapany Collection, a blog, Sikh and Punjabi studies programs, publications, events (such as an evening for Dr. Kapany''s 100th year), volunteering and donations.', 'Колекція Kapany
Академічні студії
Публікації
Події', 'Kapany Collection
Academic studies
Publications
Events', 'Шанувальники сикхського мистецтва й науковці.', 'Sikh art lovers and scholars.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sikhfoundation.org' OR LOWER(`name`) = LOWER('Sikh Foundation International')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sikhism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sikh Foundation International, founded by Narinder Singh Kapany, supports Sikh arts and studies: the Kapany Collection, Sikh and Punjabi studies, publications and events.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A foundation promoting Sikh art, culture and academic studies. The site covers its mission and founders, people and legacy, the Kapany Collection, a blog, Sikh and Punjabi studies programs, publications, events (such as an evening for Dr. Kapany''s 100th year), volunteering and donations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Kapany Collection
Academic studies
Publications
Events', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sikh art lovers and scholars.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sikh Missionary Society UK — Сикхізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sikhmissionarysociety.org' OR LOWER(`name`) = LOWER('Sikh Missionary Society UK'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sikh Missionary Society UK', NULL, 'https://www.sikhmissionarysociety.org', NULL, NULL, 'Sikh Missionary Society (UK) — товариство поширення сикхської віри: статті, публікації, гуру, принципи, кодекс поведінки, молитви, обряди й календар свят.', 'Sikh Missionary Society (UK) advances the Sikh faith: articles, publications, the Gurus, principles, code of conduct, prayers, ceremonies and a festival calendar.', 'Товариство, мета якого — розвиток сикхської віри у Британії та за кордоном. На сайті: статті й публікації, сикхізм як універсальна віра, біографії десяти гуру, принципи, кодекс поведінки, філософія, молитви, обряди, інституції й тахти, календар сикхських свят і глосарій англійською та пенджабською.', 'A society aiming to advance the Sikh faith in the UK and abroad. The site has articles and publications, Sikhism as a universal faith, biographies of the ten Gurus, principles, code of conduct, philosophy, prayers, ceremonies, institutions and Takhts, a Sikh festival calendar and a glossary in English and Punjabi.', 'Біографії гуру
Кодекс поведінки
Календар свят
Публікації', 'Gurus'' biographies
Code of conduct
Festival calendar
Publications', 'Сикхи й ті, хто вивчає сикхізм.', 'Sikhs and people studying Sikhism.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sikhmissionarysociety.org' OR LOWER(`name`) = LOWER('Sikh Missionary Society UK')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sikhism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sikh Missionary Society (UK) advances the Sikh faith: articles, publications, the Gurus, principles, code of conduct, prayers, ceremonies and a festival calendar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A society aiming to advance the Sikh faith in the UK and abroad. The site has articles and publications, Sikhism as a universal faith, biographies of the ten Gurus, principles, code of conduct, philosophy, prayers, ceremonies, institutions and Takhts, a Sikh festival calendar and a glossary in English and Punjabi.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Gurus'' biographies
Code of conduct
Festival calendar
Publications', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sikhs and people studying Sikhism.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sikh Museum Initiative — Сикхізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sikhmuseum.org.uk' OR LOWER(`name`) = LOWER('Sikh Museum Initiative'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sikh Museum Initiative', NULL, 'https://www.sikhmuseum.org.uk', NULL, NULL, 'Sikh Museum Initiative — виставки, лекції й цифрові технології про сикхську історію: мечі, прикраси й інші предмети з 3D-оцифруванням.', 'The Sikh Museum Initiative runs exhibitions, lectures and digital projects on Sikh history: swords, jewellery and other objects brought to life with 3D technology.', 'Ініціатива, що досліджує історичний світ сикхів через виставки, лекції та цифрові технології. Показує сикхську історію через мечі, прикраси й інші матеріальні об''єкти, оживлені за допомогою 3D-технологій. На сайті — портфоліо, блог, події, пожертви й контакти.', 'An initiative exploring the historical world of the Sikhs through exhibitions, lectures and digital technologies. It presents Sikh history through swords, jewellery and other material objects brought to life with 3D technology. The site has a portfolio, blog, events, donations and contacts.', 'Виставки
3D-оцифрування предметів
Лекції
Блог', 'Exhibitions
3D object digitization
Lectures
Blog', 'Шанувальники історії й музеїв.', 'History and museum enthusiasts.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sikhmuseum.org.uk' OR LOWER(`name`) = LOWER('Sikh Museum Initiative')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sikhism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Sikh Museum Initiative runs exhibitions, lectures and digital projects on Sikh history: swords, jewellery and other objects brought to life with 3D technology.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An initiative exploring the historical world of the Sikhs through exhibitions, lectures and digital technologies. It presents Sikh history through swords, jewellery and other material objects brought to life with 3D technology. The site has a portfolio, blog, events, donations and contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Exhibitions
3D object digitization
Lectures
Blog', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'History and museum enthusiasts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SikhiWiki — Сикхізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sikhiwiki.org' OR LOWER(`name`) = LOWER('SikhiWiki'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SikhiWiki', NULL, 'https://www.sikhiwiki.org', NULL, NULL, 'SikhiWiki — безкоштовна вікі-енциклопедія сикхізму: понад 6 000 статей про гуру, біографії, гурдвари, імена й онлайн-уроки.', 'SikhiWiki is a free Sikh wiki encyclopedia with over 6,000 articles on the Gurus, biographies, gurdwaras, names and online tutorials.', 'Безкоштовна енциклопедія й навчальний інструмент про сикхізм, сикхів і їхню культуру з понад 6 350 статтями. Містить тисячі сикхських імен, сторінки про десять гуру, послання гуру, онлайн-уроки, біографії й гурдвари.', 'A free encyclopedia and learning tool on Sikhism, the Sikh people and their culture with over 6,350 articles. It contains thousands of Sikh names, pages on the ten Gurus, the Guru''s message, online tutorials, biographies and gurdwaras.', 'Понад 6 000 статей
Сикхські імена
Онлайн-уроки
Біографії', 'Over 6,000 articles
Sikh names
Online tutorials
Biographies', 'Усі, хто вивчає сикхізм.', 'Anyone studying Sikhism.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sikhiwiki.org' OR LOWER(`name`) = LOWER('SikhiWiki')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sikhism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SikhiWiki is a free Sikh wiki encyclopedia with over 6,000 articles on the Gurus, biographies, gurdwaras, names and online tutorials.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A free encyclopedia and learning tool on Sikhism, the Sikh people and their culture with over 6,350 articles. It contains thousands of Sikh names, pages on the ten Gurus, the Guru''s message, online tutorials, biographies and gurdwaras.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Over 6,000 articles
Sikh names
Online tutorials
Biographies', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone studying Sikhism.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SikhNet Play — Сикхізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.sikhnet.com' OR LOWER(`name`) = LOWER('SikhNet Play'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SikhNet Play', NULL, 'https://play.sikhnet.com', NULL, NULL, 'SikhNet Play — безкоштовний стримінг понад 35 000 записів Ґурбані від майже 1 000 музикантів: радіо, класика, каталог артистів і мобільний застосунок.', 'SikhNet Play streams over 35,000 Gurbani tracks from nearly 1,000 musicians for free: radio, classics, an artist directory and a mobile app.', 'Сервіс SikhNet для прослуховування Ґурбані. Містить понад 35 000 аудіотреків від близько 1 000 виконавців, добірку класики «Diamonds of Eternity», радіо, каталог артистів, можливість завантажити власні записи та мобільний застосунок. Пов''язаний із щоденним Хукамом і новинами SikhNet.', 'SikhNet''s Gurbani listening service. It has over 35,000 audio tracks from about 1,000 artists, the "Diamonds of Eternity" classics collection, radio, an artist directory, uploads and a mobile app. It ties in with SikhNet''s Daily Hukam and news.', '35 000+ треків Ґурбані
Радіо
Каталог артистів
Мобільний застосунок', '35,000+ Gurbani tracks
Radio
Artist directory
Mobile app', 'Слухачі кіртану.', 'Kirtan listeners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.sikhnet.com' OR LOWER(`name`) = LOWER('SikhNet Play')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sikhism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SikhNet Play streams over 35,000 Gurbani tracks from nearly 1,000 musicians for free: radio, classics, an artist directory and a mobile app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SikhNet''s Gurbani listening service. It has over 35,000 audio tracks from about 1,000 artists, the "Diamonds of Eternity" classics collection, radio, an artist directory, uploads and a mobile app. It ties in with SikhNet''s Daily Hukam and news.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '35,000+ Gurbani tracks
Radio
Artist directory
Mobile app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Kirtan listeners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Стримінг', 'Streaming' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Streaming', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- The Sikh Encyclopedia — Сикхізм
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thesikhencyclopedia.com' OR LOWER(`name`) = LOWER('The Sikh Encyclopedia'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Sikh Encyclopedia', NULL, 'https://www.thesikhencyclopedia.com', NULL, NULL, 'The Sikh Encyclopedia — онлайн-енциклопедія про сикхів: мистецтво й спадщина, історія, релігія, культура, постаті та місця.', 'The Sikh Encyclopedia is an online encyclopedia on the Sikhs: arts and heritage, history, religion, culture, people and places.', 'Енциклопедія, впорядкована за категоріями: мистецтво й спадщина (зокрема пояснення, чому сикхське мистецтво довго плутали з індуїстським чи ісламським), історія, релігія, культура, постаті й місця. Статті доступні онлайн безкоштовно.', 'An encyclopedia organized by category: arts and heritage (including why Sikh art was long confused with Hindu or Islamic art), history, religion, culture, people and places. Articles are free online.', 'Статті за категоріями
Мистецтво й спадщина
Історія', 'Articles by category
Arts and heritage
History', 'Студенти й дослідники.', 'Students and researchers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thesikhencyclopedia.com' OR LOWER(`name`) = LOWER('The Sikh Encyclopedia')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'religion' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'religion' AND s.`slug` = 'sikhism' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Sikh Encyclopedia is an online encyclopedia on the Sikhs: arts and heritage, history, religion, culture, people and places.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An encyclopedia organized by category: arts and heritage (including why Sikh art was long confused with Hindu or Islamic art), history, religion, culture, people and places. Articles are free online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Articles by category
Arts and heritage
History', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students and researchers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
