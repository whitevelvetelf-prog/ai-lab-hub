SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-18: «Українські додатки» / «Ukrainian Apps» (slug ukrainian-apps): кіно й серіали онлайн, кінотеатри, музика, радіо й подкасти, ігри українською.
-- Нові підкатегорії:
--   * Кіно й серіали онлайн / Movies & Series Streaming (slug ua-movies)
--   * Музика, радіо та подкасти / Music, Radio & Podcasts (slug ua-music)
--   * Ігри українською / Games in Ukrainian (slug ua-games)
-- + 30 продуктів (якщо продукт із такою адресою чи назвою вже є — лише прив'язка, тексти не змінюються).
-- Тексти UA/EN написано за офіційними описами застосунків в App Store (регіон UA) та сайтами, звірено 2026-11-18.
-- Ціни не вказано: план «Ціна: див. сайт» (0, one_time); Free — застосунок безкоштовний у магазині застосунків.
-- Пропущено: KinoZone (з 2019), Linia kino (з 2021, російськомовний), Alias UA і «Де це?» (з 2022–2023), «Всяка Музяка» (з 2016), Crosswordium (є російська версія),
--   Vvuha (походження не підтверджено), «Правда або Дія 18+» (18+), лотереї (азартні ігри), Kinorium (не український).
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   Takflix — Кіно й серіали онлайн
--   youtv — Кіно й серіали онлайн, ТБ, новини та радіо
--   Vodafone TV — Кіно й серіали онлайн, ТБ, новини та радіо
--   Твоя Сінематика — Кіно й серіали онлайн
--   Вкіно — Кіно, концерти та квитки
--   Сінема Сіті — Кіно, концерти та квитки
--   Wizoria — Кіно, концерти та квитки
--   SmartCinema — Кіно, концерти та квитки
--   Слухай UA — Музика, радіо та подкасти
--   Перець FM — Музика, радіо та подкасти
--   DJFM — Музика, радіо та подкасти
--   Svoe Radio — Музика, радіо та подкасти
--   Radio Ukraine FM & AM Online — Музика, радіо та подкасти
--   Радіо «Дзвони» — Музика, радіо та подкасти
--   Крокодил Українською — Ігри українською
--   Поясни Слово — Ігри українською
--   Аліас: гра в слова (aliasgame.com.ua) — Ігри українською
--   Аліас Українською — Ігри українською
--   Gamir — Ігри українською
--   Вікторина Українською — Ігри українською
--   Кобза — Ігри українською
--   Близько — Ігри українською
--   СЛОВА: балда українською — Ігри українською
--   Слова зі слова — Ігри українською
--   Сканворди UA — Ігри українською
--   Українські кросворди — Ігри українською
--   БезСуржику — Ігри українською, Освіта
--   Паляниця — знайди слова — Ігри українською
--   Guess The Song — Ігри українською, Музика, радіо та подкасти
--   Військові звання України — Ігри українською, Військовим і ветеранам
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Кіно й серіали онлайн', 'Movies & Series Streaming', 'ua-movies' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-movies');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Музика, радіо та подкасти', 'Music, Radio & Podcasts', 'ua-music' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-music');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Ігри українською', 'Games in Ukrainian', 'ua-games' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-games');

-- Takflix — Кіно й серіали онлайн
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'takflix.com' OR LOWER(`name`) = 'takflix')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Takflix', NULL, 'https://takflix.com', NULL, NULL, 'Онлайн-кінотеатр українського кіно: добірка кураторів, половина доходу йде українським кінематографістам.', 'Online cinema of Ukrainian films: curated selection, half of revenue goes to Ukrainian filmmakers.', 'Takflix — VOD-сервіс українських фільмів, відібраних кураторами. Тут зібрано одну з найбільших онлайн-колекцій українського кіно, а 50% доходу сервісу йде безпосередньо українським кінематографістам. Дивитися можна на сайті та в застосунку з будь-якої точки світу.', 'Takflix is a VOD service of Ukrainian films hand-picked by curators. It hosts one of the largest online collections of Ukrainian cinema, and 50% of revenue goes directly to Ukrainian filmmakers. Watch on the website or in the app from anywhere in the world.', 'Українські фільми від кураторів
50% доходу — кінематографістам
Перегляд з будь-якої країни
Сайт і застосунок', 'Curated Ukrainian films
50% of revenue to filmmakers
Watch from any country
Website and app', 'Глядачам, які шукають українське кіно, зокрема за кордоном.', 'Viewers looking for Ukrainian cinema, including abroad.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'takflix.com' OR LOWER(`name`) = 'takflix') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-movies' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Online cinema of Ukrainian films: curated selection, half of revenue goes to Ukrainian filmmakers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Takflix is a VOD service of Ukrainian films hand-picked by curators. It hosts one of the largest online collections of Ukrainian cinema, and 50% of revenue goes directly to Ukrainian filmmakers. Watch on the website or in the app from anywhere in the world.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Curated Ukrainian films
50% of revenue to filmmakers
Watch from any country
Website and app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Viewers looking for Ukrainian cinema, including abroad.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- youtv — Кіно й серіали онлайн, ТБ, новини та радіо
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1176282993' OR LOWER(`name`) = 'youtv')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'youtv', NULL, 'https://apps.apple.com/ua/app/id1176282993', NULL, NULL, 'Онлайн-ТБ і кінотеатр: 500+ каналів, 18 000+ фільмів і понад 300 каналів безкоштовно.', 'Online TV and cinema: 500+ channels, 18,000+ films and 300+ free channels.', 'youtv — інтерактивне українське телебачення й онлайн-кінотеатр. 500+ телеканалів (350+ у HD), понад 18 000 фільмів і HD/Full HD-контент; понад 300 каналів, зокрема «Єдині новини», ICTV, Інтер і Суспільне, доступні безкоштовно. Є 7 днів безкоштовного доступу без привʼязки картки.', 'youtv is interactive Ukrainian television and an online cinema with 500+ TV channels (350+ in HD), 18,000+ films and HD/Full HD content; over 300 channels, including the national news marathon, ICTV, Inter and Suspilne, are free. There is a 7-day free trial without a card.', '500+ телеканалів
18 000+ фільмів
300+ каналів безкоштовно
7 днів без привʼязки картки', '500+ TV channels
18,000+ films
300+ free channels
7-day trial without a card', 'Глядачам ТБ, фільмів і серіалів.', 'TV, film and series viewers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1176282993' OR LOWER(`name`) = 'youtv') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-movies' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-media' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Online TV and cinema: 500+ channels, 18,000+ films and 300+ free channels.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'youtv is interactive Ukrainian television and an online cinema with 500+ TV channels (350+ in HD), 18,000+ films and HD/Full HD content; over 300 channels, including the national news marathon, ICTV, Inter and Suspilne, are free. There is a 7-day free trial without a card.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '500+ TV channels
18,000+ films
300+ free channels
7-day trial without a card', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'TV, film and series viewers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Vodafone TV — Кіно й серіали онлайн, ТБ, новини та радіо
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6447689855' OR LOWER(`name`) = 'vodafone tv')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Vodafone TV', NULL, 'https://apps.apple.com/ua/app/id6447689855', NULL, NULL, 'Телебачення, фільми й серіали від Vodafone Україна в HD і 4K, з переглядом офлайн.', 'TV, films and series from Vodafone Ukraine in HD and 4K, with offline viewing.', 'Vodafone TV — сервіс Vodafone Україна з бібліотекою відеоконтенту в HD і 4K: українські та міжнародні телеканали наживо, фільми й серіали провідних студій. Фільми можна завантажити й дивитися офлайн без інтернету.', 'Vodafone TV is Vodafone Ukraine’s service with an HD and 4K video library: live Ukrainian and international TV channels and films and series from leading studios. Films can be downloaded and watched offline.', 'ТБ-канали наживо
Фільми й серіали
HD і 4K
Перегляд офлайн', 'Live TV channels
Films and series
HD and 4K
Offline viewing', 'Абонентам Vodafone і всім глядачам.', 'Vodafone subscribers and all viewers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6447689855' OR LOWER(`name`) = 'vodafone tv') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-movies' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-media' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'TV, films and series from Vodafone Ukraine in HD and 4K, with offline viewing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Vodafone TV is Vodafone Ukraine’s service with an HD and 4K video library: live Ukrainian and international TV channels and films and series from leading studios. Films can be downloaded and watched offline.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live TV channels
Films and series
HD and 4K
Offline viewing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Vodafone subscribers and all viewers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Твоя Сінематика — Кіно й серіали онлайн
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cinematyka.app' OR LOWER(`name`) = 'твоя сінематика')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Твоя Сінематика', NULL, 'https://cinematyka.app', NULL, NULL, 'Особиста бібліотека кіно й серіалів: оцінюй фільми свайпами, веди власний топ і статистику.', 'Personal film and series library: rate titles by swiping, keep your own top list and stats.', '«Твоя Сінематика» — особиста бібліотека кіно й серіалів. Стрічки гортаються як картки: вправо — бачено (що далі тягнеш, то вища оцінка від 1 до 10), вліво — ще не бачено, вгору — «На потім». З оцінок автоматично складаються бібліотека, власний топ і статистика.', 'Tvoia Sinematyka is a personal film and series library. Titles are swiped like cards: right means watched (the further you drag, the higher the 1–10 rating), left means not seen, up means “Later”. Your ratings build a library, your own top list and statistics.', 'Оцінювання свайпами
Список «На потім»
Власний топ фільмів
Статистика переглядів', 'Swipe ratings
“Later” list
Your own top list
Viewing statistics', 'Кіноманам, які хочуть вести облік переглянутого.', 'Film fans who want to track what they have watched.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cinematyka.app' OR LOWER(`name`) = 'твоя сінематика') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-movies' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Personal film and series library: rate titles by swiping, keep your own top list and stats.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tvoia Sinematyka is a personal film and series library. Titles are swiped like cards: right means watched (the further you drag, the higher the 1–10 rating), left means not seen, up means “Later”. Your ratings build a library, your own top list and statistics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Swipe ratings
“Later” list
Your own top list
Viewing statistics', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Film fans who want to track what they have watched.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Вкіно — Кіно, концерти та квитки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vkino.com.ua' OR LOWER(`name`) = 'вкіно')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Вкіно', NULL, 'https://vkino.com.ua', NULL, NULL, 'Купівля квитків у кінотеатри України онлайн: афіша, вибір сеансу й місць, оплата карткою.', 'Buy cinema tickets across Ukraine online: listings, session and seat choice, card payment.', 'Вкіно — застосунок для купівлі квитків у кіно без черг. Можна переглянути афішу, обрати фільм, кінотеатр і найкращі місця та оплатити банківською карткою з телефона.', 'Vkino is an app for buying cinema tickets without queues. Browse listings, choose a film, cinema and the best seats, and pay by card from your phone.', 'Афіша кінотеатрів
Вибір сеансу й місць
Оплата карткою
Електронні квитки', 'Cinema listings
Session and seat choice
Card payment
E-tickets', 'Глядачам кінотеатрів.', 'Cinema-goers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vkino.com.ua' OR LOWER(`name`) = 'вкіно') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-tickets' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Buy cinema tickets across Ukraine online: listings, session and seat choice, card payment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Vkino is an app for buying cinema tickets without queues. Browse listings, choose a film, cinema and the best seats, and pay by card from your phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cinema listings
Session and seat choice
Card payment
E-tickets', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Cinema-goers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Сінема Сіті — Кіно, концерти та квитки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cinemaciti.ua' OR LOWER(`name`) = 'сінема сіті')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Сінема Сіті', NULL, 'https://cinemaciti.ua', NULL, NULL, 'Застосунок мережі кінотеатрів Сінема Сіті: квитки без реєстрації, кешбек, промокоди й сертифікати.', 'Cinema Citi chain app: tickets without registration, cashback, promo codes and gift cards.', 'Застосунок мережі кінотеатрів «Сінема Сіті» дає змогу швидко купити квитки без реєстрації або зареєструватися за 5 секунд і отримувати кешбек на рахунок, використовувати промокоди й подарункові сертифікати онлайн.', 'The Cinema Citi cinema chain app lets you quickly buy tickets without registering, or sign up in 5 seconds to earn cashback, use promo codes and redeem gift certificates online.', 'Квитки без реєстрації
Кешбек
Промокоди
Подарункові сертифікати', 'Tickets without registration
Cashback
Promo codes
Gift certificates', 'Глядачам кінотеатрів «Сінема Сіті».', 'Cinema Citi visitors.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cinemaciti.ua' OR LOWER(`name`) = 'сінема сіті') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-tickets' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Cinema Citi chain app: tickets without registration, cashback, promo codes and gift cards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Cinema Citi cinema chain app lets you quickly buy tickets without registering, or sign up in 5 seconds to earn cashback, use promo codes and redeem gift certificates online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tickets without registration
Cashback
Promo codes
Gift certificates', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Cinema Citi visitors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Wizoria — Кіно, концерти та квитки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wizoria.ua' OR LOWER(`name`) = 'wizoria')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Wizoria', NULL, 'https://wizoria.ua', NULL, NULL, 'Застосунок мережі кінотеатрів Wizoria: квитки, кешбек Wizoria, промокоди й сертифікати.', 'Wizoria cinema chain app: tickets, Wizoria cashback, promo codes and gift cards.', 'Застосунок мережі кінотеатрів Wizoria дозволяє купувати чи бронювати квитки без реєстрації або з акаунтом, отримувати Wizoria Cashback, застосовувати промокоди на знижки й подарункові сертифікати та синхронізувати дані із сайтом.', 'The Wizoria cinema chain app lets you buy or book tickets with or without an account, earn Wizoria Cashback, apply discount promo codes and gift certificates, and sync with the website.', 'Купівля й бронювання квитків
Wizoria Cashback
Промокоди
Подарункові сертифікати', 'Ticket purchase and booking
Wizoria Cashback
Promo codes
Gift certificates', 'Глядачам кінотеатрів Wizoria.', 'Wizoria cinema visitors.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wizoria.ua' OR LOWER(`name`) = 'wizoria') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-tickets' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Wizoria cinema chain app: tickets, Wizoria cashback, promo codes and gift cards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Wizoria cinema chain app lets you buy or book tickets with or without an account, earn Wizoria Cashback, apply discount promo codes and gift certificates, and sync with the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Ticket purchase and booking
Wizoria Cashback
Promo codes
Gift certificates', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Wizoria cinema visitors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SmartCinema — Кіно, концерти та квитки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'smartcinema.ua' OR LOWER(`name`) = 'smartcinema')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SmartCinema', NULL, 'https://smartcinema.ua', NULL, NULL, 'Застосунок кінотеатру SmartCinema: розклад сеансів, онлайн-квитки з QR-кодом і бонуси.', 'SmartCinema app: session schedule, online tickets with QR code and bonuses.', 'Застосунок кінотеатру SmartCinema: актуальний розклад сеансів, купівля квитків онлайн і електронні квитки з QR-кодом, які не потрібно друкувати. Вхід за бонусною карткою показує бали на бонусному рахунку.', 'The SmartCinema app offers the current session schedule, online ticket purchase and QR e-tickets that don’t need printing. Logging in with your bonus card shows your bonus balance.', 'Розклад сеансів
Онлайн-квитки
QR-квитки без друку
Бонусний рахунок', 'Session schedule
Online tickets
QR tickets, no printing
Bonus account', 'Глядачам кінотеатру SmartCinema.', 'SmartCinema visitors.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'smartcinema.ua' OR LOWER(`name`) = 'smartcinema') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-tickets' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SmartCinema app: session schedule, online tickets with QR code and bonuses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The SmartCinema app offers the current session schedule, online ticket purchase and QR e-tickets that don’t need printing. Logging in with your bonus card shows your bonus balance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Session schedule
Online tickets
QR tickets, no printing
Bonus account', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'SmartCinema visitors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Слухай UA — Музика, радіо та подкасти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'slukhai.com.ua' OR LOWER(`name`) = 'слухай ua')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Слухай UA', NULL, 'https://slukhai.com.ua', NULL, NULL, 'Українське радіо, подкасти, музика й новини онлайн в одному застосунку від ТРК «Люкс».', 'Ukrainian radio, podcasts, music and news online in one app from TRK Lux.', 'Слухай UA — аудіосервіс ТРК «Люкс», де в одному застосунку зібрано FM-станції та прямі ефіри, подкасти, музику й новини. Відтворення не переривається у фоні, тож слухати можна будь-де й будь-коли.', 'Slukhai UA is TRK Lux’s audio service bringing FM stations and live broadcasts, podcasts, music and news into one app. Playback keeps going in the background, so you can listen anywhere, anytime.', 'FM-радіо й прямі ефіри
Подкасти
Музика
Новини
Фонове відтворення', 'FM radio and live broadcasts
Podcasts
Music
News
Background playback', 'Слухачам українського радіо й подкастів.', 'Ukrainian radio and podcast listeners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'slukhai.com.ua' OR LOWER(`name`) = 'слухай ua') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-music' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ukrainian radio, podcasts, music and news online in one app from TRK Lux.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Slukhai UA is TRK Lux’s audio service bringing FM stations and live broadcasts, podcasts, music and news into one app. Playback keeps going in the background, so you can listen anywhere, anytime.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'FM radio and live broadcasts
Podcasts
Music
News
Background playback', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Ukrainian radio and podcast listeners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Перець FM — Музика, радіо та подкасти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'perec.fm' OR LOWER(`name`) = 'перець fm')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Перець FM', NULL, 'https://perec.fm', NULL, NULL, 'Перша й єдина гумористична радіостанція України — у застосунку.', 'Ukraine’s first and only comedy radio station — in an app.', 'Перець FM — перша й єдина гумористична радіостанція України. У застосунку можна слухати її прямий ефір.', 'Perets FM is Ukraine’s first and only comedy radio station. The app streams its live broadcast.', 'Прямий ефір
Гумор і музика', 'Live broadcast
Comedy and music', 'Тим, хто любить гумор у радіоефірі.', 'Fans of comedy radio.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'perec.fm' OR LOWER(`name`) = 'перець fm') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-music' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ukraine’s first and only comedy radio station — in an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Perets FM is Ukraine’s first and only comedy radio station. The app streams its live broadcast.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live broadcast
Comedy and music', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Fans of comedy radio.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- DJFM — Музика, радіо та подкасти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'djfm.ua' OR LOWER(`name`) = 'djfm')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DJFM', NULL, 'https://djfm.ua', NULL, NULL, 'Радіостанція DJFM: танцювальні хіти, спілкування зі слухачами, конкурси й розіграші.', 'DJFM radio: dance hits, listener interaction, contests and giveaways.', 'DJFM — радіостанція нового покоління, що поєднує танцювальні хіти зі спілкуванням зі слухачами, конкурсами, розіграшами та корисною інформацією. Застосунок транслює прямий ефір.', 'DJFM is a new-generation radio station combining dance hits with listener interaction, contests, giveaways and useful information. The app streams the live broadcast.', 'Прямий ефір
Танцювальні хіти
Конкурси й розіграші', 'Live broadcast
Dance hits
Contests and giveaways', 'Слухачам танцювальної музики.', 'Dance music listeners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'djfm.ua' OR LOWER(`name`) = 'djfm') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-music' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'DJFM radio: dance hits, listener interaction, contests and giveaways.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'DJFM is a new-generation radio station combining dance hits with listener interaction, contests, giveaways and useful information. The app streams the live broadcast.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live broadcast
Dance hits
Contests and giveaways', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dance music listeners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Svoe Radio — Музика, радіо та подкасти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6760871153' OR LOWER(`name`) = 'svoe radio')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Svoe Radio', NULL, 'https://apps.apple.com/ua/app/id6760871153', NULL, NULL, 'Онлайн-радіо з найкращою українською музикою 24/7 у будь-якій точці світу.', 'Online radio playing the best Ukrainian music 24/7 anywhere in the world.', 'Svoe Radio — персональна онлайн-радіостанція, що транслює найкращу українську музику 24/7 у будь-якій точці світу. Створена для тих, хто любить рідні хіти й підтримує українських виконавців.', 'Svoe Radio is a personal online radio station streaming the best Ukrainian music 24/7 anywhere in the world, made for people who love Ukrainian hits and support Ukrainian artists.', 'Українська музика 24/7
Слухати з будь-якої країни
Підтримка українських виконавців', 'Ukrainian music 24/7
Listen from any country
Support for Ukrainian artists', 'Шанувальникам української музики, зокрема за кордоном.', 'Fans of Ukrainian music, including abroad.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6760871153' OR LOWER(`name`) = 'svoe radio') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-music' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Online radio playing the best Ukrainian music 24/7 anywhere in the world.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Svoe Radio is a personal online radio station streaming the best Ukrainian music 24/7 anywhere in the world, made for people who love Ukrainian hits and support Ukrainian artists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Ukrainian music 24/7
Listen from any country
Support for Ukrainian artists', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Fans of Ukrainian music, including abroad.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Radio Ukraine FM & AM Online — Музика, радіо та подкасти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'radioua.com.ua' OR LOWER(`name`) = 'radio ukraine fm & am online')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Radio Ukraine FM & AM Online', NULL, 'https://radioua.com.ua', NULL, NULL, 'Близько 350 українських радіостанцій: пошук за жанром і містом, поточна пісня й подкасти.', 'About 350 Ukrainian radio stations: search by genre and city, current song and podcasts.', 'Застосунок із близько 350 FM- та онлайн-радіостанціями України: поп, рок, фолк, танцювальна музика, новини, спорт і подкасти. Станції можна шукати за назвою, жанром чи містом, бачити назву й обкладинку поточної пісні. Безкоштовно й без реєстрації.', 'An app with about 350 Ukrainian FM and online radio stations: pop, rock, folk, dance, news, sports and podcasts. Search stations by name, genre or city and see the title and cover of the current song. Free, no registration.', '~350 радіостанцій України
Пошук за жанром і містом
Поточна пісня
Подкасти
Без реєстрації', '~350 Ukrainian stations
Search by genre and city
Current song
Podcasts
No registration', 'Слухачам українського радіо.', 'Ukrainian radio listeners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'radioua.com.ua' OR LOWER(`name`) = 'radio ukraine fm & am online') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-music' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'About 350 Ukrainian radio stations: search by genre and city, current song and podcasts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app with about 350 Ukrainian FM and online radio stations: pop, rock, folk, dance, news, sports and podcasts. Search stations by name, genre or city and see the title and cover of the current song. Free, no registration.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '~350 Ukrainian stations
Search by genre and city
Current song
Podcasts
No registration', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Ukrainian radio listeners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Радіо «Дзвони» — Музика, радіо та подкасти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dzvony.fm' OR LOWER(`name`) = 'радіо «дзвони»')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Радіо «Дзвони»', NULL, 'https://dzvony.fm', NULL, NULL, 'Християнське Радіо «Дзвони» 105.8 FM: прямий ефір, розклад програм і Євангеліє дня.', 'Christian Radio Dzvony 105.8 FM: live broadcast, program schedule and daily Gospel.', 'Застосунок християнського Радіо «Дзвони» 105.8 FM: пряма трансляція, розклад програм, Євангеліє дня та молитви.', 'The app of the Christian Radio Dzvony 105.8 FM: live broadcast, program schedule, the daily Gospel and prayers.', 'Прямий ефір
Розклад програм
Євангеліє дня
Молитви', 'Live broadcast
Program schedule
Daily Gospel
Prayers', 'Слухачам християнського радіо.', 'Christian radio listeners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dzvony.fm' OR LOWER(`name`) = 'радіо «дзвони»') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-music' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Christian Radio Dzvony 105.8 FM: live broadcast, program schedule and daily Gospel.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app of the Christian Radio Dzvony 105.8 FM: live broadcast, program schedule, the daily Gospel and prayers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live broadcast
Program schedule
Daily Gospel
Prayers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Christian radio listeners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Крокодил Українською — Ігри українською
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kram.fun' OR LOWER(`name`) = 'крокодил українською')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Крокодил Українською', NULL, 'https://kram.fun', NULL, NULL, 'Гра для компанії: покажи слово жестами й мімікою, а команда відгадує.', 'Party game: act out a word with gestures and the team guesses.', '«Крокодил Українською» — гра для вечірки, сімейного відпочинку чи зустрічі з друзями. Один гравець показує слово жестами й мімікою, не промовляючи його, а решта намагаються відгадати.', 'Krokodyl in Ukrainian is a game for parties, family time or meeting friends. One player acts out a word with gestures and facial expressions without speaking, and the others try to guess it.', 'Слова українською
Гра для компанії
Один телефон на всіх', 'Ukrainian words
Party game
One phone for all', 'Компаніям друзів, родинам і всім, хто любить ігри в слова.', 'Groups of friends, families and word game fans.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kram.fun' OR LOWER(`name`) = 'крокодил українською') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-games' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Party game: act out a word with gestures and the team guesses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Krokodyl in Ukrainian is a game for parties, family time or meeting friends. One player acts out a word with gestures and facial expressions without speaking, and the others try to guess it.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Ukrainian words
Party game
One phone for all', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Groups of friends, families and word game fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Поясни Слово — Ігри українською
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6745406565' OR LOWER(`name`) = 'поясни слово')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Поясни Слово', NULL, 'https://apps.apple.com/ua/app/id6745406565', NULL, NULL, 'Гра в слова для компаній: понад 13 500 слів, поясни на час без однокореневих слів.', 'Party word game: 13,500+ words, explain against the clock without using root words.', '«Поясни Слово» — класична гра в слова для компаній з понад 13 500 словами. Гравці пояснюють слова на час, не називаючи однокореневих, і змагаються командами. Цифровий аналог улюбленої настільної гри.', 'Explain the Word is a classic party word game with 13,500+ words. Players explain words against the clock without using words with the same root and compete in teams — a digital version of the favourite board game.', '13 500+ слів
Командна гра на час
Цифровий аналог настілки', '13,500+ words
Timed team game
Digital board game', 'Компаніям друзів, родинам і всім, хто любить ігри в слова.', 'Groups of friends, families and word game fans.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6745406565' OR LOWER(`name`) = 'поясни слово') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-games' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Party word game: 13,500+ words, explain against the clock without using root words.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Explain the Word is a classic party word game with 13,500+ words. Players explain words against the clock without using words with the same root and compete in teams — a digital version of the favourite board game.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '13,500+ words
Timed team game
Digital board game', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Groups of friends, families and word game fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Аліас: гра в слова (aliasgame.com.ua) — Ігри українською
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aliasgame.com.ua' OR LOWER(`name`) = 'аліас: гра в слова (aliasgame.com.ua)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Аліас: гра в слова (aliasgame.com.ua)', NULL, 'https://aliasgame.com.ua', NULL, NULL, 'Аліас для вечірок: понад 10 000 слів у 30+ категоріях, команди й раунди на час.', 'Alias for parties: 10,000+ words in 30+ categories, teams and timed rounds.', 'Alias — гра для вечірок, у якій гравці пояснюють слова своїй команді, не використовуючи спільнокореневих слів чи перекладів. Понад 10 000 слів у більш ніж 30 категоріях; виграє команда, що набрала найбільше очок за всі раунди.', 'Alias is a party game where players explain words to their team without using related words or translations. It has 10,000+ words in more than 30 categories; the team with the most points after all rounds wins.', '10 000+ слів
30+ категорій
Команди й раунди на час', '10,000+ words
30+ categories
Teams and timed rounds', 'Компаніям друзів, родинам і всім, хто любить ігри в слова.', 'Groups of friends, families and word game fans.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aliasgame.com.ua' OR LOWER(`name`) = 'аліас: гра в слова (aliasgame.com.ua)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-games' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Alias for parties: 10,000+ words in 30+ categories, teams and timed rounds.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Alias is a party game where players explain words to their team without using related words or translations. It has 10,000+ words in more than 30 categories; the team with the most points after all rounds wins.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '10,000+ words
30+ categories
Teams and timed rounds', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Groups of friends, families and word game fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Аліас Українською — Ігри українською
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'haibude.com/alias-ukrainian' OR LOWER(`name`) = 'аліас українською')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Аліас Українською', NULL, 'https://haibude.com/alias-ukrainian/', NULL, NULL, 'Аліас («скажи інакше») українською з одним телефоном для 4+ гравців: слова й підрахунок очок.', 'Alias (“say it differently”) in Ukrainian on one phone for 4+ players: words and scoring.', 'Застосунок для гри в Аліас українською (скажи інакше) з одним телефоном. Розрахований на 4 і більше гравців: показує слова з бази й рахує очки двох команд.', 'An app for playing Alias in Ukrainian on one phone. Designed for 4 or more players, it shows words from its database and keeps score for two teams.', 'Слова з бази
Підрахунок очок двох команд
Один телефон', 'Word database
Scoring for two teams
One phone', 'Компаніям друзів, родинам і всім, хто любить ігри в слова.', 'Groups of friends, families and word game fans.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'haibude.com/alias-ukrainian' OR LOWER(`name`) = 'аліас українською') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-games' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Alias (“say it differently”) in Ukrainian on one phone for 4+ players: words and scoring.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app for playing Alias in Ukrainian on one phone. Designed for 4 or more players, it shows words from its database and keeps score for two teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Word database
Scoring for two teams
One phone', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Groups of friends, families and word game fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Gamir — Ігри українською
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gamir.app' OR LOWER(`name`) = 'gamir')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Gamir', NULL, 'https://gamir.app', NULL, NULL, 'Шість класичних ігор для компанії в одному застосунку українською: 10 000+ питань і слів, без інтернету.', 'Six classic party games in one Ukrainian app: 10,000+ questions and words, offline.', 'Gamir — шість ігор для компанії, на яких виросли українці, зібрані в одному застосунку. Усе українською: понад 10 000 питань і слів, написаних і відібраних вручну. Один телефон на столі, від 2 до 12 гравців, без інтернету й реєстрації, правила застосунок пояснює сам.', 'Gamir brings six party games Ukrainians grew up with into one app. Everything is in Ukrainian, with 10,000+ hand-written questions and words. One phone on the table, 2 to 12 players, no internet or sign-up, and the app explains the rules itself.', '6 ігор для компанії
10 000+ питань і слів
2–12 гравців
Без інтернету й реєстрації', '6 party games
10,000+ questions and words
2–12 players
No internet or sign-up', 'Компаніям друзів, родинам і всім, хто любить ігри в слова.', 'Groups of friends, families and word game fans.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gamir.app' OR LOWER(`name`) = 'gamir') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-games' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Six classic party games in one Ukrainian app: 10,000+ questions and words, offline.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Gamir brings six party games Ukrainians grew up with into one app. Everything is in Ukrainian, with 10,000+ hand-written questions and words. One phone on the table, 2 to 12 players, no internet or sign-up, and the app explains the rules itself.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '6 party games
10,000+ questions and words
2–12 players
No internet or sign-up', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Groups of friends, families and word game fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Вікторина Українською — Ігри українською
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'anemos-llc.com' OR LOWER(`name`) = 'вікторина українською')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Вікторина Українською', NULL, 'https://anemos-llc.com', NULL, NULL, 'Гра-вікторина українською: тести, загадки й питання, щоб перевірити знання й потренувати памʼять.', 'Quiz game in Ukrainian: tests, riddles and questions to check knowledge and train memory.', '«Вікторина Українською» — гра, яка допомагає перевірити знання, потренувати памʼять і весело провести час. Підійде тим, хто любить тести, загадки й словесні ігри.', 'Quiz in Ukrainian is a game for checking your knowledge, training memory and having fun, ideal for fans of tests, riddles and word games.', 'Питання з різних тем
Тренування памʼяті
Гра українською', 'Questions on many topics
Memory training
Game in Ukrainian', 'Любителям вікторин.', 'Quiz fans.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'anemos-llc.com' OR LOWER(`name`) = 'вікторина українською') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-games' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Quiz game in Ukrainian: tests, riddles and questions to check knowledge and train memory.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Quiz in Ukrainian is a game for checking your knowledge, training memory and having fun, ideal for fans of tests, riddles and word games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Questions on many topics
Memory training
Game in Ukrainian', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Quiz fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Кобза — Ігри українською
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1605389381' OR LOWER(`name`) = 'кобза')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Кобза', NULL, 'https://apps.apple.com/ua/app/id1605389381', NULL, NULL, 'Популярна гра відгадування слова з 5 літер за 6 спроб — українською.', 'The popular guess-a-5-letter-word-in-6-tries game — in Ukrainian.', '«Кобза» — українська версія популярної гри: потрібно відгадати загадане слово з 5 літер за 6 спроб. Після кожної спроби кольори клітинок підказують, наскільки ви близькі до відповіді.', 'Kobza is the Ukrainian version of the popular game: guess the hidden 5-letter word in 6 tries. After each try, tile colours show how close you are.', 'Слово з 5 літер
6 спроб
Кольорові підказки', '5-letter word
6 tries
Colour hints', 'Любителям словесних головоломок.', 'Word puzzle fans.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1605389381' OR LOWER(`name`) = 'кобза') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-games' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The popular guess-a-5-letter-word-in-6-tries game — in Ukrainian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Kobza is the Ukrainian version of the popular game: guess the hidden 5-letter word in 6 tries. After each try, tile colours show how close you are.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '5-letter word
6 tries
Colour hints', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Word puzzle fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Близько — Ігри українською
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'blyzko.com' OR LOWER(`name`) = 'близько')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Близько', NULL, 'https://blyzko.com', NULL, NULL, 'Українська гра, де приховане слово відгадують за змістом: що «тепліше», то ближче.', 'Ukrainian game where you guess a hidden word by meaning: the warmer, the closer.', '«Близько» — українська гра, у якій приховане слово відгадують за змістом і сенсом. Вводиш будь-яке слово, а гра показує, наскільки воно близьке до загаданого: що тепліший колір і довша смуга, то ближче.', 'Blyzko is a Ukrainian game where you guess a hidden word by meaning. Enter any word and the game shows how close it is: the warmer the colour and the longer the bar, the closer you are.', 'Відгадування за змістом
Кольорова шкала близькості
Щоденне слово', 'Guess by meaning
Colour closeness scale
Daily word', 'Любителям словесних головоломок.', 'Word puzzle fans.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'blyzko.com' OR LOWER(`name`) = 'близько') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-games' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ukrainian game where you guess a hidden word by meaning: the warmer, the closer.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Blyzko is a Ukrainian game where you guess a hidden word by meaning. Enter any word and the game shows how close it is: the warmer the colour and the longer the bar, the closer you are.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Guess by meaning
Colour closeness scale
Daily word', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Word puzzle fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- СЛОВА: балда українською — Ігри українською
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'slivtsia.com.ua' OR LOWER(`name`) = 'слова: балда українською')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'СЛОВА: балда українською', NULL, 'https://slivtsia.com.ua', NULL, NULL, 'Класична «балда» українською: складай слова з літер, змагайся онлайн і дізнавайся значення слів.', 'Classic “balda” in Ukrainian: build words from letters, compete online and learn word meanings.', '«СЛОВА: балда українською» поєднує класичну механіку «балди» з відкриттям нових українських слів, їхніх значень і слова дня. У центрі поля — стартове слово: додаєш літеру й складаєш слова з сусідніх літер; що довше слово, то більше очок. Можна грати самому чи змагатися з друзями онлайн.', 'SLOVA: Balda in Ukrainian combines the classic “balda” mechanics with discovering new Ukrainian words, their meanings and a word of the day. Start from a word in the centre, add a letter and form words from adjacent letters; longer words score more. Play solo or online against friends.', 'Класична «балда»
Значення слів
Слово дня
Гра з друзями онлайн', 'Classic balda
Word meanings
Word of the day
Online play with friends', 'Любителям словесних ігор.', 'Word game fans.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'slivtsia.com.ua' OR LOWER(`name`) = 'слова: балда українською') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-games' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Classic “balda” in Ukrainian: build words from letters, compete online and learn word meanings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SLOVA: Balda in Ukrainian combines the classic “balda” mechanics with discovering new Ukrainian words, their meanings and a word of the day. Start from a word in the centre, add a letter and form words from adjacent letters; longer words score more. Play solo or online against friends.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Classic balda
Word meanings
Word of the day
Online play with friends', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Word game fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Слова зі слова — Ігри українською
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'games.ua-play.com' OR LOWER(`name`) = 'слова зі слова')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Слова зі слова', NULL, 'https://games.ua-play.com', NULL, NULL, 'Головоломка українською: складай слова з літер довгого слова й дивись значення відгаданих.', 'Ukrainian puzzle: make words from a long word’s letters and see the meanings.', '«Слова зі слова» — гра-головоломка, що розвиває словниковий запас: із літер довгого слова потрібно скласти якомога більше коротших. Українською мовою, з можливістю переглядати значення відгаданих слів, системою підказок і монетами за час у грі.', 'Words from a Word is a vocabulary-building puzzle: form as many shorter words as possible from the letters of a long one. In Ukrainian, with meanings of guessed words, a hint system and coins for time played.', 'Слова з літер довгого слова
Значення слів
Підказки', 'Words from a long word
Word meanings
Hints', 'Любителям словесних ігор.', 'Word game fans.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'games.ua-play.com' OR LOWER(`name`) = 'слова зі слова') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-games' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ukrainian puzzle: make words from a long word’s letters and see the meanings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Words from a Word is a vocabulary-building puzzle: form as many shorter words as possible from the letters of a long one. In Ukrainian, with meanings of guessed words, a hint system and coins for time played.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Words from a long word
Word meanings
Hints', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Word game fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Сканворди UA — Ігри українською
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scanvordy.gravit.tech' OR LOWER(`name`) = 'сканворди ua')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Сканворди UA', NULL, 'https://scanvordy.gravit.tech', NULL, NULL, 'Класичні сканворди повністю українською, без інтернету.', 'Classic arrow-word puzzles fully in Ukrainian, offline.', '«Сканворди UA» — класичні сканворди українською: питання розташовані просто в клітинках сітки, а стрілки підказують напрям слова. Розвʼязувати можна без інтернету.', 'Skanvordy UA offers classic arrow-word puzzles in Ukrainian, with clues placed in grid cells and arrows showing word direction. Solve them offline.', 'Сканворди українською
Без інтернету', 'Arrow-words in Ukrainian
Offline', 'Любителям кросвордів і сканвордів.', 'Crossword fans.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scanvordy.gravit.tech' OR LOWER(`name`) = 'сканворди ua') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-games' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Classic arrow-word puzzles fully in Ukrainian, offline.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Skanvordy UA offers classic arrow-word puzzles in Ukrainian, with clues placed in grid cells and arrows showing word direction. Solve them offline.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Arrow-words in Ukrainian
Offline', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Crossword fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Українські кросворди — Ігри українською
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6624294382' OR LOWER(`name`) = 'українські кросворди')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Українські кросворди', NULL, 'https://apps.apple.com/ua/app/id6624294382', NULL, NULL, 'Кросворди українською мовою для розвитку мислення й словникового запасу.', 'Crosswords in Ukrainian to boost thinking and vocabulary.', '«Українські кросворди» — кросворди українською мовою, що розвивають творче мислення й аналітичні навички, розширюють словниковий запас і допомагають цікаво провести вільний час.', 'Ukrainian Crosswords offers crosswords in Ukrainian that develop creative and analytical thinking, expand vocabulary and make for a good pastime.', 'Кросворди українською
Розвиток словникового запасу', 'Crosswords in Ukrainian
Vocabulary building', 'Любителям кросвордів.', 'Crossword fans.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6624294382' OR LOWER(`name`) = 'українські кросворди') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-games' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Crosswords in Ukrainian to boost thinking and vocabulary.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ukrainian Crosswords offers crosswords in Ukrainian that develop creative and analytical thinking, expand vocabulary and make for a good pastime.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Crosswords in Ukrainian
Vocabulary building', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Crossword fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- БезСуржику — Ігри українською, Освіта
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6444486704' OR LOWER(`name`) = 'безсуржику')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'БезСуржику', NULL, 'https://apps.apple.com/ua/app/id6444486704', NULL, NULL, 'Гра-кросворд проти суржику: згадай правильний український відповідник поширеного слова.', 'Crossword game against surzhyk: recall the correct Ukrainian form of common words.', '«БезСуржику» допомагає позбутися суржику через кросворди: гравець бачить поширене в побуті некоректне слово чи вислів і має пригадати й ввести правильний український відповідник.', 'BezSurzhyku helps you get rid of surzhyk through crosswords: you see a common incorrect word or phrase and must recall and enter the correct Ukrainian equivalent.', 'Кросворди проти суржику
Правильні відповідники
Тренування мови', 'Anti-surzhyk crosswords
Correct equivalents
Language practice', 'Усім, хто хоче говорити чистою українською.', 'Anyone wanting to speak proper Ukrainian.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6444486704' OR LOWER(`name`) = 'безсуржику') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-games' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-education' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Crossword game against surzhyk: recall the correct Ukrainian form of common words.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'BezSurzhyku helps you get rid of surzhyk through crosswords: you see a common incorrect word or phrase and must recall and enter the correct Ukrainian equivalent.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Anti-surzhyk crosswords
Correct equivalents
Language practice', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone wanting to speak proper Ukrainian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Паляниця — знайди слова — Ігри українською
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1641128977' OR LOWER(`name`) = 'паляниця — знайди слова')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Паляниця — знайди слова', NULL, 'https://apps.apple.com/ua/app/id1641128977', NULL, NULL, 'Гра «знайди слова» українською з вибором рівня складності.', 'Ukrainian word search game with selectable difficulty.', '«Паляниця» — гра «знайди слова» українською: потрібно складати правильні слова з літер на полі. Рівень складності можна обрати самостійно.', 'Palyanytsia is a Ukrainian word search game: form correct words from the letters on the board. You can choose the difficulty level.', 'Пошук слів
Вибір складності
Українська мова', 'Word search
Difficulty choice
Ukrainian language', 'Любителям словесних головоломок.', 'Word puzzle fans.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1641128977' OR LOWER(`name`) = 'паляниця — знайди слова') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-games' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ukrainian word search game with selectable difficulty.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Palyanytsia is a Ukrainian word search game: form correct words from the letters on the board. You can choose the difficulty level.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Word search
Difficulty choice
Ukrainian language', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Word puzzle fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Guess The Song — Ігри українською, Музика, радіо та подкасти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'guessthesong.pro' OR LOWER(`name`) = 'guess the song')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Guess The Song', NULL, 'https://guessthesong.pro', NULL, NULL, 'Музична вікторина: впізнай хіт за перші ноти — самому, проти суперника онлайн чи з друзями.', 'Music trivia: recognise a hit from the first notes — solo, live against a rival or with friends.', 'Guess The Song — музична вікторина з понад 10 000 популярних пісень усіх десятиліть і жанрів. Грає пісня, на екрані чотири обкладинки — обери правильну: що швидше впізнаєш, то більше очок. Можна грати самому, проти реального суперника наживо чи з друзями на вечірці. Акаунт не потрібен.', 'Guess The Song is a music quiz with 10,000+ popular songs from every decade and genre. A song plays and four covers appear: tap the right one, and the sooner you know it, the more points you get. Play solo, live against a real opponent or with friends at a party. No account needed.', '10 000+ пісень
Гра наживо проти суперника
Режим для вечірок
Без акаунта', '10,000+ songs
Live play against a rival
Party mode
No account', 'Меломанам і компаніям друзів.', 'Music lovers and groups of friends.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'guessthesong.pro' OR LOWER(`name`) = 'guess the song') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-games' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-music' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Music trivia: recognise a hit from the first notes — solo, live against a rival or with friends.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Guess The Song is a music quiz with 10,000+ popular songs from every decade and genre. A song plays and four covers appear: tap the right one, and the sooner you know it, the more points you get. Play solo, live against a real opponent or with friends at a party. No account needed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '10,000+ songs
Live play against a rival
Party mode
No account', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Music lovers and groups of friends.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Військові звання України — Ігри українською, Військовим і ветеранам
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nbw.app/en/products/ukrainian-military-ranks' OR LOWER(`name`) = 'військові звання україни')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Військові звання України', NULL, 'https://nbw.app/en/products/ukrainian-military-ranks', NULL, NULL, 'Навчальна гра-вікторина про систему військових звань ЗСУ різних родів військ.', 'Educational quiz game on the Armed Forces of Ukraine rank system across branches.', 'Ukrainian Military Ranks — навчальна гра-вікторина, яка допомагає легко вивчити систему військових звань України й структуру ЗСУ. Питання охоплюють Сухопутні війська, Десантно-штурмові війська, Повітряні сили та інші роди військ.', 'Ukrainian Military Ranks is an educational quiz game that makes it easy to learn Ukraine’s military rank system and the structure of the Armed Forces, with questions covering the Ground Forces, Air Assault Forces, Air Force and other branches.', 'Вікторина про звання ЗСУ
Різні роди військ
Навчання у формі гри', 'Quiz on Ukrainian ranks
Different branches
Game-based learning', 'Усім, хто хоче розібратися у військових званнях.', 'Anyone wanting to understand military ranks.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nbw.app/en/products/ukrainian-military-ranks' OR LOWER(`name`) = 'військові звання україни') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-games' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-military' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Educational quiz game on the Armed Forces of Ukraine rank system across branches.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ukrainian Military Ranks is an educational quiz game that makes it easy to learn Ukraine’s military rank system and the structure of the Armed Forces, with questions covering the Ground Forces, Air Assault Forces, Air Force and other branches.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Quiz on Ukrainian ranks
Different branches
Game-based learning', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone wanting to understand military ranks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Прив'язка наявних продуктів (за назвою) до нових підкатегорій; тексти не змінюються

-- MEGOGO — Кіно й серіали онлайн
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'megogo' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-movies' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- SWEET.TV — Кіно й серіали онлайн
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'sweet.tv' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-movies' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Київстар ТБ — Кіно й серіали онлайн
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'київстар тб' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-movies' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- 1+1 video — Кіно й серіали онлайн
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = '1+1 video' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-movies' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- RadioPlayer — Музика, радіо та подкасти
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'radioplayer' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-music' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- suspilne.radio — Музика, радіо та подкасти
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'suspilne.radio' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-music' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Люкс FM — Музика, радіо та подкасти
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'люкс fm' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-music' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Громадське радіо — Музика, радіо та подкасти
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'громадське радіо' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-music' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Інтенти запасного пошуку Елі (tools/eli-intents.php, нові підкатегорії ukrainian-apps)
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'фільми онлайн', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'фільми онлайн' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'серіали онлайн', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'серіали онлайн' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'онлайн кінотеатр', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'онлайн кінотеатр' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'дивитися фільм', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'дивитися фільм' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'дивитися серіа', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'дивитися серіа' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'українське кін', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'українське кін' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'українські фільм', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'українські фільм' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'movies online', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'movies online' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-movies' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'раді', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'раді' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'радіостанц', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'радіостанц' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'fm раді', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'fm раді' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'українська музик', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'українська музик' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'українські пісн', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'українські пісн' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'слухати раді', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'слухати раді' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'radio', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'radio' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-music' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'ігри українськ', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'ігри українськ' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'гра українськ', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'гра українськ' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'аліас', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'аліас' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'крокодил', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'крокодил' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'кросворд', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'кросворд' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'сканворд', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'сканворд' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'вікторин', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'вікторин' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'гра в слов', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'гра в слов' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'ігри для компан', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'ігри для компан' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'party game', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'party game' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-games' LIMIT 1));
