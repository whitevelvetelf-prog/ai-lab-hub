SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-07: 104 нових продуктів для нових підгруп категорії «Мультимедіа» .
-- Платні й безкоштовні застосунки, сервіси й онлайн-ресурси за підкатегоріями:
--   Геймінг (gaming): 104
-- Лише справжні сервіси: сайти перевірено (відповідають, назва на сторінці). Відкинуто неробочі,
-- припарковані й захоплені домени, Cloudflare-перевірки, новинні сайти, благодійні фонди,
-- інвестиційні сервіси, астрологію, знайомства, продаж БАДів, сайти з медичними твердженнями. Тексти описові, без маркетингових оцінок.
-- Тексти, функції й тарифи (UA + EN) — лише з офіційних сайтів, звірено 2026-10-07.
-- Потребує міграції database/migration-2026-10-07-gaming.sql (нові підкатегорії).
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт» (файл .sql або .sql.zip). Повторний запуск безпечний.
--   3DMark — Геймінг
--   Amazon Luna — Геймінг
--   Backloggd — Геймінг
--   Battle.net — Геймінг
--   Board Game Arena — Геймінг
--   BoardGameGeek — Геймінг
--   Boosteroid — Геймінг
--   Can You RUN It — Геймінг
--   CheapShark — Геймінг
--   Chess.com — Геймінг
--   Completionator — Геймінг
--   CrazyGames — Геймінг
--   CurseForge — Геймінг
--   D&D Beyond — Геймінг
--   Deku Deals — Геймінг
--   Dolphin Emulator — Геймінг
--   DOSBox — Геймінг
--   DS4Windows — Геймінг
--   DuckStation — Геймінг
--   EA app — Геймінг
--   Eneba — Геймінг
--   Epic Games Store — Геймінг
--   Exophase — Геймінг
--   Fanatical — Геймінг
--   Fandom Games — Геймінг
--   Fextralife — Геймінг
--   Foundry Virtual Tabletop — Геймінг
--   Friends & Fables — Геймінг
--   Game Jolt — Геймінг
--   Game8 — Геймінг
--   GameFAQs — Геймінг
--   GamerPower — Геймінг
--   GameSpot — Геймінг
--   GeForce NOW — Геймінг
--   GG.deals — Геймінг
--   GOG — Геймінг
--   GOG GALAXY — Геймінг
--   Green Man Gaming — Геймінг
--   Grouvee — Геймінг
--   Heroic Games Launcher — Геймінг
--   HowLongToBeat — Геймінг
--   Humble Bundle — Геймінг
--   HWiNFO — Геймінг
--   IGDB — Геймінг
--   IGN — Геймінг
--   Infinite Backlog — Геймінг
--   Instant Gaming — Геймінг
--   IsThereAnyDeal — Геймінг
--   itch.io — Геймінг
--   Kongregate — Геймінг
--   Lichess — Геймінг
--   Lutris — Геймінг
--   Metacritic Games — Геймінг
--   Minecraft — Геймінг
--   MobyGames — Геймінг
--   mod.io — Геймінг
--   Modrinth — Геймінг
--   Moonlight — Геймінг
--   Newgrounds — Геймінг
--   Nexus Mods — Геймінг
--   Nintendo Switch Online — Геймінг
--   OpenCritic — Геймінг
--   Overwolf — Геймінг
--   Owlbear Rodeo — Геймінг
--   Parsec — Геймінг
--   PCGamingWiki — Геймінг
--   PCSX2 — Геймінг
--   Playnite — Геймінг
--   PlayStation App — Геймінг
--   PlayStation Plus — Геймінг
--   Plink — Геймінг
--   Poki — Геймінг
--   PowerPyx — Геймінг
--   PPSSPP — Геймінг
--   Prism Launcher — Геймінг
--   ProtonDB — Геймінг
--   PSNProfiles — Геймінг
--   PSPrices — Геймінг
--   RAWG — Геймінг
--   Razer Cortex — Геймінг
--   ReShade — Геймінг
--   RetroAchievements — Геймінг
--   RetroArch — Геймінг
--   Roblox — Геймінг
--   Roll20 — Геймінг
--   ScummVM — Геймінг
--   Shadow PC — Геймінг
--   Special K — Геймінг
--   Steam — Геймінг
--   Steam Deck — Геймінг
--   Steam Remote Play — Геймінг
--   Steam Workshop — Геймінг
--   SteamDB — Геймінг
--   Tabletop Simulator — Геймінг
--   Thunderstore — Геймінг
--   TrueAchievements — Геймінг
--   TrueTrophies — Геймінг
--   Twitch — Геймінг
--   Ubisoft Connect — Геймінг
--   Vortex — Геймінг
--   Xbox app — Геймінг
--   Xbox Cloud Gaming — Геймінг
--   Xbox Game Pass — Геймінг
--   YouTube Gaming — Геймінг
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);

-- 3DMark — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '3dmark.com' OR LOWER(`name`) = LOWER('3DMark'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT '3DMark', NULL, 'https://www.3dmark.com', NULL, NULL, '3DMark (UL) — бенчмарк ігрової продуктивності ПК, ноутбуків і смартфонів з порівнянням результатів.', '3DMark (UL) benchmarks gaming performance of PCs, laptops and phones with result comparisons.', 'Набір тестів (Time Spy, Steel Nomad, Port Royal тощо) для оцінки відеокарти й процесора, стрес-тести стабільності та онлайн-база результатів для порівняння.', 'A set of tests (Time Spy, Steel Nomad, Port Royal and more) to rate GPU and CPU, stability stress tests and an online results database for comparison.', 'Бенчмарки
Стрес-тести
Порівняння результатів', 'Benchmarks
Stress tests
Result comparison', 'ПК-ентузіасти.', 'PC enthusiasts.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '3dmark.com' OR LOWER(`name`) = LOWER('3DMark')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', '3DMark (UL) benchmarks gaming performance of PCs, laptops and phones with result comparisons.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A set of tests (Time Spy, Steel Nomad, Port Royal and more) to rate GPU and CPU, stability stress tests and an online results database for comparison.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Benchmarks
Stress tests
Result comparison', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC enthusiasts.', 'manual' FROM DUAL WHERE @new = 1;

-- Amazon Luna — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'luna.amazon.com' OR LOWER(`name`) = LOWER('Amazon Luna'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Amazon Luna', NULL, 'https://luna.amazon.com', NULL, NULL, 'Amazon Luna — хмарний геймінг Amazon з іграми для учасників Prime і каналами підписки.', 'Amazon Luna is Amazon''s cloud gaming service with games for Prime members and subscription channels.', 'Сервіс для гри без завантажень на ТВ, ПК і телефонах; учасники Prime отримують добірку ігор і роздачі ключів (колишній Prime Gaming), а також можна підключити Ubisoft+.', 'A no-download gaming service on TVs, PCs and phones; Prime members get a rotating game selection and key giveaways (formerly Prime Gaming), and Ubisoft+ can be linked.', 'Хмарна гра
Ігри з Prime
Роздачі ключів', 'Cloud play
Prime games
Key giveaways', 'Учасники Amazon Prime.', 'Amazon Prime members.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'luna.amazon.com' OR LOWER(`name`) = LOWER('Amazon Luna')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Amazon Luna is Amazon''s cloud gaming service with games for Prime members and subscription channels.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A no-download gaming service on TVs, PCs and phones; Prime members get a rotating game selection and key giveaways (formerly Prime Gaming), and Ubisoft+ can be linked.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cloud play
Prime games
Key giveaways', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Amazon Prime members.', 'manual' FROM DUAL WHERE @new = 1;

-- Backloggd — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'backloggd.com' OR LOWER(`name`) = LOWER('Backloggd'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Backloggd', NULL, 'https://backloggd.com', NULL, NULL, 'Backloggd — щоденник ігор: оцінки, рецензії, списки й журнал пройденого, як Letterboxd для ігор.', 'Backloggd is a game diary: ratings, reviews, lists and a play log, like Letterboxd for games.', 'Соціальна платформа, де гравці ведуть колекцію й бекло́г, пишуть рецензії, складають списки та стежать за друзями.', 'A social platform where players track collections and backlogs, write reviews, build lists and follow friends.', 'Журнал ігор
Рецензії
Списки', 'Game log
Reviews
Lists', 'Гравці, що ведуть облік ігор.', 'Gamers tracking their games.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'backloggd.com' OR LOWER(`name`) = LOWER('Backloggd')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Backloggd is a game diary: ratings, reviews, lists and a play log, like Letterboxd for games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A social platform where players track collections and backlogs, write reviews, build lists and follow friends.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Game log
Reviews
Lists', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers tracking their games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Battle.net — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'download.battle.net/en-us/desktop' OR LOWER(`name`) = LOWER('Battle.net'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Battle.net', NULL, 'https://download.battle.net/en-us/desktop', NULL, NULL, 'Battle.net — лаунчер і магазин Blizzard та Activision: Diablo, World of Warcraft, Overwatch, Call of Duty.', 'Battle.net is the Blizzard and Activision launcher and store: Diablo, World of Warcraft, Overwatch, Call of Duty.', 'Програма для запуску й оновлення ігор, спілкування з друзями, голосових чатів і покупок; мобільний застосунок з автентифікатором.', 'An app for launching and updating games, chatting with friends, voice chat and purchases; a mobile app includes an authenticator.', 'Ігри Blizzard
Друзі й чат
Автентифікатор', 'Blizzard games
Friends and chat
Authenticator', 'Гравці Blizzard та Activision.', 'Blizzard and Activision players.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'download.battle.net/en-us/desktop' OR LOWER(`name`) = LOWER('Battle.net')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Battle.net is the Blizzard and Activision launcher and store: Diablo, World of Warcraft, Overwatch, Call of Duty.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app for launching and updating games, chatting with friends, voice chat and purchases; a mobile app includes an authenticator.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Blizzard games
Friends and chat
Authenticator', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Blizzard and Activision players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Лаунчер', 'Launcher' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Launcher', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Board Game Arena — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'boardgamearena.com' OR LOWER(`name`) = LOWER('Board Game Arena'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Board Game Arena', NULL, 'https://boardgamearena.com', NULL, NULL, 'Board Game Arena — сотні настільних ігор онлайн у браузері безкоштовно, з друзями й гравцями світу.', 'Board Game Arena offers hundreds of board games online in the browser for free, with friends and players worldwide.', 'Найбільша платформа ліцензованих настільних ігор онлайн з автоматичним дотриманням правил, турнірами й Premium-доступом до більшої кількості ігор.', 'The largest platform of licensed online board games with automatic rule enforcement, tournaments and Premium access to more games.', 'Сотні ігор
Правила автоматично
Турніри', 'Hundreds of games
Automatic rules
Tournaments', 'Любителі настільних ігор.', 'Board game fans.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'boardgamearena.com' OR LOWER(`name`) = LOWER('Board Game Arena')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Board Game Arena offers hundreds of board games online in the browser for free, with friends and players worldwide.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The largest platform of licensed online board games with automatic rule enforcement, tournaments and Premium access to more games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hundreds of games
Automatic rules
Tournaments', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Board game fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базовий доступ', 'Basic access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- BoardGameGeek — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'boardgamegeek.com' OR LOWER(`name`) = LOWER('BoardGameGeek'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BoardGameGeek', NULL, 'https://boardgamegeek.com', NULL, NULL, 'BoardGameGeek — найбільша база й спільнота настільних ігор: рейтинги, огляди, форуми й облік колекції.', 'BoardGameGeek is the largest board game database and community: ratings, reviews, forums and collection tracking.', 'Сайт з даними про сотні тисяч настільних ігор, рейтингами, файлами правил, форумами, маркетплейсом і обліком зіграних партій.', 'A site with data on hundreds of thousands of board games, ratings, rules files, forums, a marketplace and play logging.', 'База настільних ігор
Рейтинги
Облік колекції', 'Board game database
Ratings
Collection tracking', 'Любителі настільних ігор.', 'Board game fans.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'boardgamegeek.com' OR LOWER(`name`) = LOWER('BoardGameGeek')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'BoardGameGeek is the largest board game database and community: ratings, reviews, forums and collection tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site with data on hundreds of thousands of board games, ratings, rules files, forums, a marketplace and play logging.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Board game database
Ratings
Collection tracking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Board game fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Boosteroid — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'boosteroid.com' OR LOWER(`name`) = LOWER('Boosteroid'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Boosteroid', NULL, 'https://boosteroid.com', NULL, NULL, 'Boosteroid — хмарний геймінг з українським корінням: запускайте ігри з ваших бібліотек у браузері, на ТВ і телефоні.', 'Boosteroid is cloud gaming with Ukrainian roots: run games from your libraries in a browser, on TV and phone.', 'Сервіс без завантаження й оновлень ігор, що працює на Windows, macOS, Android, Linux і смарт-ТВ, підтримує ігри з Steam, Epic, Ubisoft та інших магазинів; оплата підпискою.', 'A service with no game downloads or updates, running on Windows, macOS, Android, Linux and smart TVs, supporting games from Steam, Epic, Ubisoft and other stores; paid by subscription.', 'Гра в браузері
Смарт-ТВ
Власні бібліотеки', 'In-browser play
Smart TVs
Your libraries', 'Гравці без ігрового ПК.', 'Gamers without a gaming PC.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'boosteroid.com' OR LOWER(`name`) = LOWER('Boosteroid')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Boosteroid is cloud gaming with Ukrainian roots: run games from your libraries in a browser, on TV and phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service with no game downloads or updates, running on Windows, macOS, Android, Linux and smart TVs, supporting games from Steam, Epic, Ubisoft and other stores; paid by subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'In-browser play
Smart TVs
Your libraries', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers without a gaming PC.', 'manual' FROM DUAL WHERE @new = 1;

-- Can You RUN It — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'systemrequirementslab.com/cyri' OR LOWER(`name`) = LOWER('Can You RUN It'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Can You RUN It', NULL, 'https://www.systemrequirementslab.com/cyri', NULL, NULL, 'Can You RUN It — перевірка, чи потягне ваш ПК гру, за мінімальними й рекомендованими системними вимогами.', 'Can You RUN It checks whether your PC can run a game against minimum and recommended requirements.', 'Сервіс System Requirements Lab аналізує конфігурацію комп''ютера й порівнює з вимогами тисяч ігор, підказуючи, що оновити.', 'System Requirements Lab''s service analyzes your PC and compares it to requirements of thousands of games, suggesting upgrades.', 'Перевірка вимог
Тисячі ігор
Поради з апгрейду', 'Requirement check
Thousands of games
Upgrade tips', 'ПК-гравці.', 'PC gamers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'systemrequirementslab.com/cyri' OR LOWER(`name`) = LOWER('Can You RUN It')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Can You RUN It checks whether your PC can run a game against minimum and recommended requirements.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'System Requirements Lab''s service analyzes your PC and compares it to requirements of thousands of games, suggesting upgrades.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Requirement check
Thousands of games
Upgrade tips', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс', 'Service' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Service', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- CheapShark — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cheapshark.com' OR LOWER(`name`) = LOWER('CheapShark'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CheapShark', NULL, 'https://www.cheapshark.com', NULL, NULL, 'CheapShark — пошук найкращих знижок на ПК-ігри в Steam, Green Man Gaming, GOG, Humble та інших магазинах.', 'CheapShark finds the best PC game deals across Steam, Green Man Gaming, GOG, Humble and others.', 'Безкоштовний сервіс з пошуком, сповіщеннями поштою про досягнення бажаної ціни й відкритим API для розробників.', 'A free service with search, email alerts when a target price is reached and an open API for developers.', 'Пошук знижок
Сповіщення
Відкритий API', 'Deal search
Alerts
Open API', 'ПК-гравці.', 'PC gamers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cheapshark.com' OR LOWER(`name`) = LOWER('CheapShark')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'CheapShark finds the best PC game deals across Steam, Green Man Gaming, GOG, Humble and others.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A free service with search, email alerts when a target price is reached and an open API for developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Deal search
Alerts
Open API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс', 'Service' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Service', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Chess.com — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chess.com' OR LOWER(`name`) = LOWER('Chess.com'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Chess.com', NULL, 'https://www.chess.com', NULL, NULL, 'Chess.com — найбільша шахова платформа: партії, задачі, уроки, AI-боти й аналіз, понад 250 млн учасників.', 'Chess.com is the largest chess platform: games, puzzles, lessons, AI bots and analysis, 250M+ members.', 'Онлайн-шахи з партіями проти людей і ботів, задачами, відеоуроками, аналізом з AI-тренером і турнірами; членство розширює можливості.', 'Online chess with games against people and bots, puzzles, video lessons, AI coach analysis and tournaments; membership adds features.', 'Партії й боти
Задачі
AI-аналіз
Уроки', 'Games and bots
Puzzles
AI analysis
Lessons', 'Шахісти.', 'Chess players.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chess.com' OR LOWER(`name`) = LOWER('Chess.com')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Chess.com is the largest chess platform: games, puzzles, lessons, AI bots and analysis, 250M+ members.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Online chess with games against people and bots, puzzles, video lessons, AI coach analysis and tournaments; membership adds features.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Games and bots
Puzzles
AI analysis
Lessons', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Chess players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базовий доступ', 'Basic access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Completionator — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'completionator.com' OR LOWER(`name`) = LOWER('Completionator'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Completionator', NULL, 'https://completionator.com', NULL, NULL, 'Completionator — облік і завершення колекції відеоігор з відстеженням часу й статистикою.', 'Completionator tracks and completes your video game collection with playtime and stats.', 'Дозволяє каталогізувати фізичні й цифрові ігри, позначати прогрес, ставити цілі й бачити статистику бекло́гу.', 'It catalogs physical and digital games, marks progress, sets goals and shows backlog stats.', 'Каталог ігор
Цілі
Статистика', 'Game catalog
Goals
Stats', 'Колекціонери.', 'Collectors.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'completionator.com' OR LOWER(`name`) = LOWER('Completionator')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Completionator tracks and completes your video game collection with playtime and stats.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It catalogs physical and digital games, marks progress, sets goals and shows backlog stats.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Game catalog
Goals
Stats', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Collectors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- CrazyGames — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'crazygames.com' OR LOWER(`name`) = LOWER('CrazyGames'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CrazyGames', NULL, 'https://www.crazygames.com', NULL, NULL, 'CrazyGames — безкоштовні браузерні ігри високої якості: мультиплеєр, шутери, гонки, головоломки.', 'CrazyGames offers high-quality free browser games: multiplayer, shooters, racing and puzzles.', 'Каталог тисяч вебігор, у які можна грати одразу, з акаунтами, прогресом, друзями й мультиплеєрними іграми.', 'A catalog of thousands of web games playable instantly, with accounts, progress, friends and multiplayer games.', 'Миттєва гра
Мультиплеєр
Прогрес в акаунті', 'Instant play
Multiplayer
Account progress', 'Казуальні гравці.', 'Casual players.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'crazygames.com' OR LOWER(`name`) = LOWER('CrazyGames')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'CrazyGames offers high-quality free browser games: multiplayer, shooters, racing and puzzles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A catalog of thousands of web games playable instantly, with accounts, progress, friends and multiplayer games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Instant play
Multiplayer
Account progress', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Casual players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'З рекламою', 'Ad-supported' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Ad-supported', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- CurseForge — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'curseforge.com' OR LOWER(`name`) = LOWER('CurseForge'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CurseForge', NULL, 'https://www.curseforge.com', NULL, NULL, 'CurseForge (Overwolf) — платформа модів для Minecraft, World of Warcraft, The Sims 4 та інших ігор з застосунком.', 'CurseForge (Overwolf) is a mod platform for Minecraft, World of Warcraft, The Sims 4 and other games with an app.', 'Каталог модів, аддонів і модпаків з десктопним застосунком для встановлення та оновлення, а також винагородами для авторів.', 'A catalog of mods, addons and modpacks with a desktop app for installation and updates plus creator rewards.', 'Моди Minecraft і WoW
Модпаки
Застосунок', 'Minecraft and WoW mods
Modpacks
App', 'Моддери.', 'Modders.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'curseforge.com' OR LOWER(`name`) = LOWER('CurseForge')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'CurseForge (Overwolf) is a mod platform for Minecraft, World of Warcraft, The Sims 4 and other games with an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A catalog of mods, addons and modpacks with a desktop app for installation and updates plus creator rewards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Minecraft and WoW mods
Modpacks
App', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Modders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс', 'Service' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Service', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- D&D Beyond — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dndbeyond.com' OR LOWER(`name`) = LOWER('D&D Beyond'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'D&D Beyond', NULL, 'https://www.dndbeyond.com', NULL, NULL, 'D&D Beyond — офіційний цифровий набір інструментів Dungeons & Dragons: конструктор персонажів, правила й енкаунтери.', 'D&D Beyond is the official Dungeons & Dragons digital toolset: character builder, rules and encounters.', 'Сервіс Wizards of the Coast з цифровими книгами правил, конструктором і листами персонажів, планувальником сутичок і 3D-столом Maps.', 'A Wizards of the Coast service with digital rulebooks, character builder and sheets, encounter planner and the 3D Maps tabletop.', 'Конструктор персонажів
Цифрові правила
Планувальник сутичок', 'Character builder
Digital rules
Encounter planner', 'Гравці D&D.', 'D&D players.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dndbeyond.com' OR LOWER(`name`) = LOWER('D&D Beyond')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'D&D Beyond is the official Dungeons & Dragons digital toolset: character builder, rules and encounters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Wizards of the Coast service with digital rulebooks, character builder and sheets, encounter planner and the 3D Maps tabletop.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Character builder
Digital rules
Encounter planner', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'D&D players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базові правила', 'Basic rules' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic rules', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Deku Deals — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dekudeals.com' OR LOWER(`name`) = LOWER('Deku Deals'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Deku Deals', NULL, 'https://www.dekudeals.com', NULL, NULL, 'Deku Deals — відстеження цін на ігри Nintendo Switch і сповіщення зі списку бажаного.', 'Deku Deals tracks Nintendo Switch game prices with wishlist notifications.', 'Сервіс показує знижки в eShop і роздрібних магазинах, історію цін, колекцію ігор і надсилає сповіщення про знижки на бажані ігри.', 'The service shows eShop and retail discounts, price history and your collection, and notifies you of sales on wishlisted games.', 'Ціни Switch
Список бажаного
Колекція', 'Switch prices
Wishlist
Collection', 'Власники Switch.', 'Switch owners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dekudeals.com' OR LOWER(`name`) = LOWER('Deku Deals')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Deku Deals tracks Nintendo Switch game prices with wishlist notifications.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The service shows eShop and retail discounts, price history and your collection, and notifies you of sales on wishlisted games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Switch prices
Wishlist
Collection', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Switch owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс', 'Service' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Service', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Dolphin Emulator — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dolphin-emu.org' OR LOWER(`name`) = LOWER('Dolphin Emulator'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dolphin Emulator', NULL, 'https://dolphin-emu.org', NULL, NULL, 'Dolphin — відкритий емулятор GameCube і Wii з підтримкою HD-роздільності, контролерів і мережевої гри.', 'Dolphin is an open-source GameCube and Wii emulator with HD resolution, controller support and netplay.', 'Емулятор для Windows, macOS, Linux і Android, що дозволяє грати у власні диски GameCube і Wii з покращеною графікою.', 'An emulator for Windows, macOS, Linux and Android for playing your own GameCube and Wii discs with enhanced graphics.', 'GameCube і Wii
HD-роздільність
Netplay', 'GameCube and Wii
HD resolution
Netplay', 'Любителі консолей Nintendo.', 'Nintendo console fans.', 'desktop,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dolphin-emu.org' OR LOWER(`name`) = LOWER('Dolphin Emulator')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Dolphin is an open-source GameCube and Wii emulator with HD resolution, controller support and netplay.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An emulator for Windows, macOS, Linux and Android for playing your own GameCube and Wii discs with enhanced graphics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'GameCube and Wii
HD resolution
Netplay', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Nintendo console fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Open source', 'Open source' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- DOSBox — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dosbox.com' OR LOWER(`name`) = LOWER('DOSBox'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DOSBox', NULL, 'https://www.dosbox.com', NULL, NULL, 'DOSBox — емулятор DOS для запуску старих ігор на Windows, macOS і Linux.', 'DOSBox is a DOS emulator for running old games on Windows, macOS and Linux.', 'Відкритий емулятор x86 і звукових карт, що дозволяє грати в класичні DOS-ігри; на ньому базуються GOG-версії багатьох старих ігор.', 'An open-source x86 and sound card emulator for playing classic DOS games; many GOG classic releases are built on it.', 'DOS-ігри
Емуляція звуку
Open source', 'DOS games
Sound emulation
Open source', 'Любителі ретро.', 'Retro fans.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dosbox.com' OR LOWER(`name`) = LOWER('DOSBox')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'DOSBox is a DOS emulator for running old games on Windows, macOS and Linux.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An open-source x86 and sound card emulator for playing classic DOS games; many GOG classic releases are built on it.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'DOS games
Sound emulation
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Retro fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Open source', 'Open source' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- DS4Windows — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ds4-windows.com' OR LOWER(`name`) = LOWER('DS4Windows'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DS4Windows', NULL, 'https://ds4-windows.com', NULL, NULL, 'DS4Windows — безкоштовна утиліта для використання геймпадів PS4/PS5 на Windows з емуляцією Xbox-контролера.', 'DS4Windows is a free utility to use PS4/PS5 controllers on Windows by emulating an Xbox controller.', 'Програма перепризначає кнопки, налаштовує гіроскоп, тачпад, підсвітку й профілі для ігор.', 'The app remaps buttons and configures gyro, touchpad, lightbar and per-game profiles.', 'Геймпади PlayStation на ПК
Профілі
Гіроскоп', 'PlayStation pads on PC
Profiles
Gyro', 'ПК-гравці з геймпадами Sony.', 'PC gamers with Sony pads.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ds4-windows.com' OR LOWER(`name`) = LOWER('DS4Windows')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'DS4Windows is a free utility to use PS4/PS5 controllers on Windows by emulating an Xbox controller.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app remaps buttons and configures gyro, touchpad, lightbar and per-game profiles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'PlayStation pads on PC
Profiles
Gyro', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC gamers with Sony pads.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Програма', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- DuckStation — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'duckstation.org' OR LOWER(`name`) = LOWER('DuckStation'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DuckStation', NULL, 'https://www.duckstation.org', NULL, NULL, 'DuckStation — швидкий емулятор PlayStation 1 з підвищенням роздільності й PGXP.', 'DuckStation is a fast PlayStation 1 emulator with upscaling and PGXP.', 'Емулятор PS1 з високою точністю, покращеною графікою, віджетами для ТВ-режиму й підтримкою RetroAchievements.', 'A high-accuracy PS1 emulator with enhanced graphics, a big-picture mode and RetroAchievements support.', 'Емуляція PS1
PGXP
RetroAchievements', 'PS1 emulation
PGXP
RetroAchievements', 'Любителі PS1.', 'PS1 fans.', 'desktop,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'duckstation.org' OR LOWER(`name`) = LOWER('DuckStation')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'DuckStation is a fast PlayStation 1 emulator with upscaling and PGXP.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A high-accuracy PS1 emulator with enhanced graphics, a big-picture mode and RetroAchievements support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'PS1 emulation
PGXP
RetroAchievements', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PS1 fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Програма', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- EA app — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ea.com/ea-app' OR LOWER(`name`) = LOWER('EA app'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'EA app', NULL, 'https://www.ea.com/ea-app', NULL, NULL, 'EA app — ПК-платформа Electronic Arts для ігор EA, друзів і підписки EA Play.', 'EA app is Electronic Arts'' PC platform for EA games, friends and the EA Play subscription.', 'Лаунчер для ігор EA (EA SPORTS FC, Battlefield, The Sims тощо) з бібліотекою, друзями, автооновленнями й доступом до каталогу EA Play.', 'A launcher for EA games (EA SPORTS FC, Battlefield, The Sims and more) with a library, friends, auto-updates and EA Play catalog access.', 'Ігри EA
EA Play
Друзі', 'EA games
EA Play
Friends', 'Гравці ігор EA.', 'EA players.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ea.com/ea-app' OR LOWER(`name`) = LOWER('EA app')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'EA app is Electronic Arts'' PC platform for EA games, friends and the EA Play subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A launcher for EA games (EA SPORTS FC, Battlefield, The Sims and more) with a library, friends, auto-updates and EA Play catalog access.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'EA games
EA Play
Friends', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'EA players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Лаунчер', 'Launcher' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Launcher', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Eneba — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eneba.com' OR LOWER(`name`) = LOWER('Eneba'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eneba', NULL, 'https://www.eneba.com', NULL, NULL, 'Eneba — маркетплейс ігор, подарункових карток і поповнень для ПК, PlayStation, Xbox і Nintendo з литовським корінням.', 'Eneba is a marketplace for games, gift cards and top-ups for PC, PlayStation, Xbox and Nintendo, with Lithuanian roots.', 'Платформа продавців цифрових ключів і карток із системою захисту покупця, порівнянням пропозицій і програмою кешбеку.', 'A platform of digital key and card sellers with buyer protection, offer comparison and cash back.', 'Ключі й картки
Захист покупця
Кешбек', 'Keys and cards
Buyer protection
Cash back', 'Гравці на всіх платформах.', 'Gamers on all platforms.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eneba.com' OR LOWER(`name`) = LOWER('Eneba')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Eneba is a marketplace for games, gift cards and top-ups for PC, PlayStation, Xbox and Nintendo, with Lithuanian roots.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform of digital key and card sellers with buyer protection, offer comparison and cash back.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Keys and cards
Buyer protection
Cash back', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers on all platforms.', 'manual' FROM DUAL WHERE @new = 1;

-- Epic Games Store — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'store.epicgames.com' OR LOWER(`name`) = LOWER('Epic Games Store'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Epic Games Store', NULL, 'https://store.epicgames.com', NULL, NULL, 'Epic Games Store — магазин ПК-ігор від Epic з щотижневими безкоштовними іграми, Fortnite і Unreal-екосистемою.', 'Epic Games Store is Epic''s PC game store with weekly free games, Fortnite and the Unreal ecosystem.', 'Магазин і лаунчер з ексклюзивами, щотижневими роздачами безкоштовних ігор, розпродажами, кешбеком Epic Rewards і мобільним застосунком для Android та iOS у ЄС.', 'A store and launcher with exclusives, weekly free game giveaways, sales, Epic Rewards cash back and a mobile app on Android and iOS in the EU.', 'Щотижневі безкоштовні ігри
Epic Rewards
Розпродажі', 'Weekly free games
Epic Rewards
Sales', 'ПК-гравці.', 'PC gamers.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'store.epicgames.com' OR LOWER(`name`) = LOWER('Epic Games Store')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Epic Games Store is Epic''s PC game store with weekly free games, Fortnite and the Unreal ecosystem.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A store and launcher with exclusives, weekly free game giveaways, sales, Epic Rewards cash back and a mobile app on Android and iOS in the EU.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Weekly free games
Epic Rewards
Sales', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Лаунчер і безкоштовні ігри', 'Launcher and free games' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Launcher and free games', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Exophase — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'exophase.com' OR LOWER(`name`) = LOWER('Exophase'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Exophase', NULL, 'https://www.exophase.com', NULL, NULL, 'Exophase — відстеження досягнень і трофеїв на Steam, Xbox, PlayStation, Nintendo та інших платформах в одному профілі.', 'Exophase tracks achievements and trophies across Steam, Xbox, PlayStation, Nintendo and more in one profile.', 'Спільнота з профілями, що об''єднують активність з різних платформ, рейтингами, статистикою ігрового часу й гайдами.', 'A community with profiles combining activity from multiple platforms, leaderboards, playtime stats and guides.', 'Усі платформи
Єдиний профіль
Статистика', 'All platforms
One profile
Stats', 'Мисливці за досягненнями.', 'Achievement hunters.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'exophase.com' OR LOWER(`name`) = LOWER('Exophase')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Exophase tracks achievements and trophies across Steam, Xbox, PlayStation, Nintendo and more in one profile.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A community with profiles combining activity from multiple platforms, leaderboards, playtime stats and guides.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'All platforms
One profile
Stats', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Achievement hunters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Fanatical — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fanatical.com' OR LOWER(`name`) = LOWER('Fanatical'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fanatical', NULL, 'https://www.fanatical.com', NULL, NULL, 'Fanatical — офіційний продавець ключів ПК-ігор: бандли «збери сам», розпродажі й таємничі бандли.', 'Fanatical is an official PC game key retailer: build-your-own bundles, sales and mystery bundles.', 'Магазин ліцензованих ключів зі знижками, бандлами, флеш-розпродажами та програмою Star Deal.', 'A licensed key store with discounts, bundles, flash sales and Star Deals.', 'Бандли
Флеш-розпродажі
Офіційні ключі', 'Bundles
Flash sales
Official keys', 'ПК-гравці.', 'PC gamers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fanatical.com' OR LOWER(`name`) = LOWER('Fanatical')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fanatical is an official PC game key retailer: build-your-own bundles, sales and mystery bundles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A licensed key store with discounts, bundles, flash sales and Star Deals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Bundles
Flash sales
Official keys', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC gamers.', 'manual' FROM DUAL WHERE @new = 1;

-- Fandom Games — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fandom.com/topics/games' OR LOWER(`name`) = LOWER('Fandom Games'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fandom Games', NULL, 'https://www.fandom.com/topics/games', NULL, NULL, 'Fandom — найбільша платформа фанатських вікі про ігри: персонажі, квести, предмети й історія.', 'Fandom is the largest platform of fan wikis about games: characters, quests, items and lore.', 'Тисячі вікі, створених спільнотами гравців, для майже кожної популярної гри, з новинами й статтями.', 'Thousands of community-made wikis for nearly every popular game, plus news and articles.', 'Фанатські вікі
Квести й предмети
Новини', 'Fan wikis
Quests and items
News', 'Гравці.', 'Gamers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fandom.com/topics/games' OR LOWER(`name`) = LOWER('Fandom Games')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fandom is the largest platform of fan wikis about games: characters, quests, items and lore.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Thousands of community-made wikis for nearly every popular game, plus news and articles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Fan wikis
Quests and items
News', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Fextralife — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fextralife.com' OR LOWER(`name`) = LOWER('Fextralife'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fextralife', NULL, 'https://fextralife.com', NULL, NULL, 'Fextralife — вікі й гайди для RPG і soulslike-ігор: понад 375 000 статей про білди, предмети й лор.', 'Fextralife hosts wikis and guides for RPGs and soulslikes: 375,000+ articles on builds, items and lore.', 'Мережа вікі для Elden Ring, Dark Souls, Baldur''s Gate 3 та сотень інших ігор з білдами, мапами, описами предметів і прямими трансляціями.', 'A wiki network for Elden Ring, Dark Souls, Baldur''s Gate 3 and hundreds of other games with builds, maps, item descriptions and livestreams.', 'Вікі ігор
Білди
Лор', 'Game wikis
Builds
Lore', 'Гравці RPG.', 'RPG players.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fextralife.com' OR LOWER(`name`) = LOWER('Fextralife')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fextralife hosts wikis and guides for RPGs and soulslikes: 375,000+ articles on builds, items and lore.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A wiki network for Elden Ring, Dark Souls, Baldur''s Gate 3 and hundreds of other games with builds, maps, item descriptions and livestreams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Game wikis
Builds
Lore', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'RPG players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Foundry Virtual Tabletop — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'foundryvtt.com' OR LOWER(`name`) = LOWER('Foundry Virtual Tabletop'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Foundry Virtual Tabletop', NULL, 'https://foundryvtt.com', NULL, NULL, 'Foundry VTT — віртуальний стіл для НРІ з самостійним хостингом і тисячами модулів спільноти; одноразова покупка.', 'Foundry VTT is a self-hosted virtual tabletop for TTRPGs with thousands of community modules; one-time purchase.', 'Програма, яку майстер розміщує на своєму ПК чи сервері, з системами для D&D, Pathfinder та інших, автоматизацією правил і модулями.', 'Software the GM hosts on their PC or server, with systems for D&D, Pathfinder and others, rules automation and modules.', 'Самостійний хостинг
Тисячі модулів
Одноразова покупка', 'Self-hosted
Thousands of modules
One-time purchase', 'Майстри НРІ.', 'TTRPG game masters.', 'desktop,web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'foundryvtt.com' OR LOWER(`name`) = LOWER('Foundry Virtual Tabletop')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Foundry VTT is a self-hosted virtual tabletop for TTRPGs with thousands of community modules; one-time purchase.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Software the GM hosts on their PC or server, with systems for D&D, Pathfinder and others, rules automation and modules.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Self-hosted
Thousands of modules
One-time purchase', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'TTRPG game masters.', 'manual' FROM DUAL WHERE @new = 1;

-- Friends & Fables — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fables.gg' OR LOWER(`name`) = LOWER('Friends & Fables'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Friends & Fables', NULL, 'https://fables.gg', NULL, NULL, 'Friends & Fables — текстова RPG у дусі D&D з AI-майстром гри для соло й кооперативних пригод.', 'Friends & Fables is a D&D-inspired text RPG with an AI game master for solo and co-op adventures.', 'AI-майстер веде кампанію, відстежує персонажів, інвентар і бої за правилами, дозволяє грати самому або з друзями в Discord і на сайті.', 'An AI game master runs the campaign, tracks characters, inventory and combat by the rules, and lets you play solo or with friends on Discord and the web.', 'AI-майстер
Соло й кооператив
Discord', 'AI game master
Solo and co-op
Discord', 'Любителі НРІ.', 'TTRPG fans.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fables.gg' OR LOWER(`name`) = LOWER('Friends & Fables')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Friends & Fables is a D&D-inspired text RPG with an AI game master for solo and co-op adventures.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An AI game master runs the campaign, tracks characters, inventory and combat by the rules, and lets you play solo or with friends on Discord and the web.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI game master
Solo and co-op
Discord', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'TTRPG fans.', 'manual' FROM DUAL WHERE @new = 1;

-- Game Jolt — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gamejolt.com' OR LOWER(`name`) = LOWER('Game Jolt'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Game Jolt', NULL, 'https://gamejolt.com', NULL, NULL, 'Game Jolt — спільнота й платформа інді-ігор, фанарту та творчості гравців.', 'Game Jolt is a community and platform for indie games, fan art and player creations.', 'Сайт і застосунок, де розробники публікують ігри, а гравці діляться фанартом, відео й постами в спільнотах ігор.', 'A site and app where developers publish games and players share fan art, videos and posts in game communities.', 'Інді-ігри
Фанарт
Спільноти', 'Indie games
Fan art
Communities', 'Любителі інді.', 'Indie fans.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gamejolt.com' OR LOWER(`name`) = LOWER('Game Jolt')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Game Jolt is a community and platform for indie games, fan art and player creations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site and app where developers publish games and players share fan art, videos and posts in game communities.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Indie games
Fan art
Communities', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Indie fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Game8 — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'game8.co' OR LOWER(`name`) = LOWER('Game8'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Game8', NULL, 'https://game8.co', NULL, NULL, 'Game8 — детальні гайди й проходження ігор із Японії: тир-листи, білди, мапи й бази даних.', 'Game8 offers detailed game guides and walkthroughs from Japan: tier lists, builds, maps and databases.', 'Сайт гайдів для популярних ігор (Pokémon, Genshin Impact, Elden Ring тощо) з тир-листами персонажів, білдами й покроковими проходженнями.', 'A guide site for popular games (Pokémon, Genshin Impact, Elden Ring and more) with character tier lists, builds and step-by-step walkthroughs.', 'Тир-листи
Білди
Проходження', 'Tier lists
Builds
Walkthroughs', 'Гравці.', 'Gamers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'game8.co' OR LOWER(`name`) = LOWER('Game8')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Game8 offers detailed game guides and walkthroughs from Japan: tier lists, builds, maps and databases.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A guide site for popular games (Pokémon, Genshin Impact, Elden Ring and more) with character tier lists, builds and step-by-step walkthroughs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tier lists
Builds
Walkthroughs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- GameFAQs — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gamefaqs.gamespot.com' OR LOWER(`name`) = LOWER('GameFAQs'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GameFAQs', NULL, 'https://gamefaqs.gamespot.com', NULL, NULL, 'GameFAQs — архів текстових проходжень, чит-кодів і форумів для десятків тисяч ігор.', 'GameFAQs is an archive of text walkthroughs, cheats and forums for tens of thousands of games.', 'Один із найстаріших ігрових сайтів з FAQ від гравців, кодами, збереженнями й активними форумами по кожній грі.', 'One of the oldest gaming sites with player-written FAQs, codes, saves and active per-game forums.', 'Текстові проходження
Чит-коди
Форуми', 'Text walkthroughs
Cheats
Forums', 'Гравці.', 'Gamers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gamefaqs.gamespot.com' OR LOWER(`name`) = LOWER('GameFAQs')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'GameFAQs is an archive of text walkthroughs, cheats and forums for tens of thousands of games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'One of the oldest gaming sites with player-written FAQs, codes, saves and active per-game forums.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Text walkthroughs
Cheats
Forums', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- GamerPower — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gamerpower.com' OR LOWER(`name`) = LOWER('GamerPower'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GamerPower', NULL, 'https://www.gamerpower.com', NULL, NULL, 'GamerPower — свіжі безкоштовні ігри, ключі й роздачі для ПК, консолей і мобільних з відкритим API.', 'GamerPower lists the latest free games, keys and giveaways for PC, consoles and mobile with an open API.', 'Сервіс збирає актуальні роздачі в Epic, Steam, GOG, Prime та інших, внутрішньоігрові бонуси й промокоди та сповіщає про нові.', 'The service gathers current giveaways on Epic, Steam, GOG, Prime and others, in-game loot and promo codes and alerts you to new ones.', 'Безкоштовні ігри
Внутрішньоігрові бонуси
Сповіщення', 'Free games
In-game loot
Alerts', 'Усі гравці.', 'All gamers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gamerpower.com' OR LOWER(`name`) = LOWER('GamerPower')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'GamerPower lists the latest free games, keys and giveaways for PC, consoles and mobile with an open API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The service gathers current giveaways on Epic, Steam, GOG, Prime and others, in-game loot and promo codes and alerts you to new ones.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free games
In-game loot
Alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'All gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс', 'Service' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Service', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- GameSpot — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gamespot.com' OR LOWER(`name`) = LOWER('GameSpot'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GameSpot', NULL, 'https://www.gamespot.com', NULL, NULL, 'GameSpot — огляди, новини, відео й гайди з відеоігор.', 'GameSpot offers video game reviews, news, videos and guides.', 'Ігрове видання з рецензіями, оглядами апаратури, трейлерами й гайдами по популярних іграх.', 'A gaming outlet with reviews, hardware coverage, trailers and guides for popular games.', 'Огляди
Відео
Гайди', 'Reviews
Videos
Guides', 'Гравці.', 'Gamers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gamespot.com' OR LOWER(`name`) = LOWER('GameSpot')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'GameSpot offers video game reviews, news, videos and guides.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A gaming outlet with reviews, hardware coverage, trailers and guides for popular games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Reviews
Videos
Guides', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- GeForce NOW — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nvidia.com/en-us/geforce-now' OR LOWER(`name`) = LOWER('GeForce NOW'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GeForce NOW', NULL, 'https://www.nvidia.com/en-us/geforce-now/', NULL, NULL, 'GeForce NOW — хмарний геймінг NVIDIA: грайте у свої ігри зі Steam, Epic та інших на будь-якому пристрої з RTX-графікою.', 'GeForce NOW is NVIDIA cloud gaming: play your own Steam, Epic and other games on any device with RTX graphics.', 'Сервіс запускає ігри, якими ви вже володієте, на хмарних серверах NVIDIA та транслює на ПК, Mac, телефон чи ТВ. Безкоштовний рівень з чергою й обмеженими сесіями, платні Performance і Ultimate.', 'The service runs games you already own on NVIDIA cloud servers and streams them to PC, Mac, phone or TV. A free tier with queues and limited sessions, plus paid Performance and Ultimate.', 'Власні ігри в хмарі
RTX-графіка
Будь-який пристрій', 'Your games in the cloud
RTX graphics
Any device', 'Гравці без потужного ПК.', 'Gamers without a powerful PC.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nvidia.com/en-us/geforce-now' OR LOWER(`name`) = LOWER('GeForce NOW')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'GeForce NOW is NVIDIA cloud gaming: play your own Steam, Epic and other games on any device with RTX graphics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The service runs games you already own on NVIDIA cloud servers and streams them to PC, Mac, phone or TV. A free tier with queues and limited sessions, plus paid Performance and Ultimate.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Your games in the cloud
RTX graphics
Any device', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers without a powerful PC.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'З чергою й обмеженням сесій', 'Queue and session limits' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Queue and session limits', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- GG.deals — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gg.deals' OR LOWER(`name`) = LOWER('GG.deals'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GG.deals', NULL, 'https://gg.deals', NULL, NULL, 'GG.deals — порівняння цін на ігри в офіційних магазинах і маркетплейсах ключів, історія цін і безкоштовні роздачі.', 'GG.deals compares game prices across official stores and key shops, with price history and freebies.', 'Агрегатор цін на ігри для ПК і консолей з окремим показом офіційних магазинів, сповіщеннями про знижки, історією цін і списком роздач.', 'A price aggregator for PC and console games that separates official stores, with deal alerts, price history and a giveaway list.', 'Офіційні магазини окремо
Історія цін
Роздачі', 'Official stores separated
Price history
Giveaways', 'Гравці, що шукають знижки.', 'Deal-hunting gamers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gg.deals' OR LOWER(`name`) = LOWER('GG.deals')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'GG.deals compares game prices across official stores and key shops, with price history and freebies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A price aggregator for PC and console games that separates official stores, with deal alerts, price history and a giveaway list.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Official stores separated
Price history
Giveaways', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Deal-hunting gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс', 'Service' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Service', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- GOG — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gog.com' OR LOWER(`name`) = LOWER('GOG'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GOG', NULL, 'https://www.gog.com', NULL, NULL, 'GOG.com (CD PROJEKT) — магазин ігор без DRM: класика й новинки для Windows, macOS і Linux, програма збереження ігор.', 'GOG.com (CD PROJEKT) is a DRM-free game store: classics and new releases for Windows, Mac and Linux, plus a game preservation program.', 'Ігри, які назавжди лишаються у вас без захисту DRM, з офлайн-інсталяторами, відновленими класичними проєктами, розпродажами й 30-денним поверненням коштів.', 'Games that stay yours forever without DRM, with offline installers, restored classics, sales and a 30-day refund policy.', 'Без DRM
Офлайн-інсталятори
Класичні ігри', 'DRM-free
Offline installers
Classic games', 'ПК-гравці й любителі класики.', 'PC gamers and classic fans.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gog.com' OR LOWER(`name`) = LOWER('GOG')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'GOG.com (CD PROJEKT) is a DRM-free game store: classics and new releases for Windows, Mac and Linux, plus a game preservation program.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Games that stay yours forever without DRM, with offline installers, restored classics, sales and a 30-day refund policy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'DRM-free
Offline installers
Classic games', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC gamers and classic fans.', 'manual' FROM DUAL WHERE @new = 1;

-- GOG GALAXY — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gog.com/galaxy' OR LOWER(`name`) = LOWER('GOG GALAXY'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GOG GALAXY', NULL, 'https://www.gog.com/galaxy', NULL, NULL, 'GOG GALAXY 2.0 — лаунчер, що об''єднує бібліотеки ігор з різних платформ і друзів в одному місці.', 'GOG GALAXY 2.0 is a launcher combining game libraries from multiple platforms and friends in one place.', 'Безкоштовна програма з інтеграціями Steam, Epic, Xbox, PlayStation та інших, спільною бібліотекою, статистикою ігрового часу, досягненнями й хмарними збереженнями.', 'A free app with integrations for Steam, Epic, Xbox, PlayStation and others, a unified library, playtime stats, achievements and cloud saves.', 'Єдина бібліотека
Інтеграції платформ
Статистика', 'Unified library
Platform integrations
Stats', 'Гравці з кількома магазинами.', 'Gamers with multiple stores.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gog.com/galaxy' OR LOWER(`name`) = LOWER('GOG GALAXY')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'GOG GALAXY 2.0 is a launcher combining game libraries from multiple platforms and friends in one place.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A free app with integrations for Steam, Epic, Xbox, PlayStation and others, a unified library, playtime stats, achievements and cloud saves.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Unified library
Platform integrations
Stats', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers with multiple stores.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Програма', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Green Man Gaming — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'greenmangaming.com' OR LOWER(`name`) = LOWER('Green Man Gaming'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Green Man Gaming', NULL, 'https://www.greenmangaming.com', NULL, NULL, 'Green Man Gaming — офіційний продавець ключів ПК-ігор зі знижками, бандлами й програмою XP.', 'Green Man Gaming is an official PC game key retailer with discounts, bundles and an XP program.', 'Британський магазин ліцензованих ключів для Steam та інших платформ з регулярними знижками, передзамовленнями й бонусами для учасників програми лояльності.', 'A UK store of licensed keys for Steam and other platforms with regular discounts, pre-orders and loyalty program bonuses.', 'Офіційні ключі
Знижки
Програма XP', 'Official keys
Discounts
XP program', 'ПК-гравці.', 'PC gamers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'greenmangaming.com' OR LOWER(`name`) = LOWER('Green Man Gaming')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Green Man Gaming is an official PC game key retailer with discounts, bundles and an XP program.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A UK store of licensed keys for Steam and other platforms with regular discounts, pre-orders and loyalty program bonuses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Official keys
Discounts
XP program', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC gamers.', 'manual' FROM DUAL WHERE @new = 1;

-- Grouvee — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'grouvee.com' OR LOWER(`name`) = LOWER('Grouvee'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Grouvee', NULL, 'https://www.grouvee.com', NULL, NULL, 'Grouvee — облік колекції ігор, бекло́гу й списку бажаного з оцінками та спільнотою.', 'Grouvee tracks your game collection, backlog and wishlist with ratings and a community.', 'Сервіс для каталогізації ігор на полицях: що є, у що граєте, що пройдено й що хочете купити, з оцінками й рецензіями.', 'A service for cataloging games on your shelves: what you own, play, finished and want, with ratings and reviews.', 'Колекція
Бекло́г
Список бажаного', 'Collection
Backlog
Wishlist', 'Колекціонери ігор.', 'Game collectors.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'grouvee.com' OR LOWER(`name`) = LOWER('Grouvee')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Grouvee tracks your game collection, backlog and wishlist with ratings and a community.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service for cataloging games on your shelves: what you own, play, finished and want, with ratings and reviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Collection
Backlog
Wishlist', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Game collectors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Heroic Games Launcher — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'heroicgameslauncher.com' OR LOWER(`name`) = LOWER('Heroic Games Launcher'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Heroic Games Launcher', NULL, 'https://heroicgameslauncher.com', NULL, NULL, 'Heroic — безкоштовний відкритий лаунчер для ігор Epic, GOG і Amazon на Linux, macOS, Windows і Steam Deck.', 'Heroic is a free open-source launcher for Epic, GOG and Amazon games on Linux, macOS, Windows and Steam Deck.', 'Альтернативний клієнт, що встановлює й запускає ігри з Epic, GOG і Amazon Prime, з підтримкою Wine/Proton і хмарних збережень.', 'An alternative client that installs and runs games from Epic, GOG and Amazon Prime, with Wine/Proton support and cloud saves.', 'Epic, GOG, Amazon
Linux і Steam Deck
Open source', 'Epic, GOG, Amazon
Linux and Steam Deck
Open source', 'Гравці на Linux і Steam Deck.', 'Linux and Steam Deck gamers.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'heroicgameslauncher.com' OR LOWER(`name`) = LOWER('Heroic Games Launcher')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Heroic is a free open-source launcher for Epic, GOG and Amazon games on Linux, macOS, Windows and Steam Deck.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An alternative client that installs and runs games from Epic, GOG and Amazon Prime, with Wine/Proton support and cloud saves.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Epic, GOG, Amazon
Linux and Steam Deck
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Linux and Steam Deck gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Open source', 'Open source' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- HowLongToBeat — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'howlongtobeat.com' OR LOWER(`name`) = LOWER('HowLongToBeat'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HowLongToBeat', NULL, 'https://howlongtobeat.com', NULL, NULL, 'HowLongToBeat — скільки часу потрібно, щоб пройти гру: основний сюжет, із доповненнями та на 100 %, плюс бекло́г.', 'HowLongToBeat shows how long games take to beat: main story, plus extras and 100%, plus backlog tracking.', 'База тривалості проходження, зібрана з даних гравців, з можливістю вести бекло́г, позначати пройдені ігри й імпортувати бібліотеку Steam.', 'A database of completion times from player submissions, with backlog tracking, marking completed games and Steam library import.', 'Тривалість проходження
Бекло́г
Імпорт Steam', 'Completion times
Backlog
Steam import', 'Гравці з великим бекло́гом.', 'Gamers with big backlogs.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'howlongtobeat.com' OR LOWER(`name`) = LOWER('HowLongToBeat')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'HowLongToBeat shows how long games take to beat: main story, plus extras and 100%, plus backlog tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A database of completion times from player submissions, with backlog tracking, marking completed games and Steam library import.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Completion times
Backlog
Steam import', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers with big backlogs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Humble Bundle — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'humblebundle.com' OR LOWER(`name`) = LOWER('Humble Bundle'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Humble Bundle', NULL, 'https://www.humblebundle.com', NULL, NULL, 'Humble Bundle — бандли ігор, книжок і програм за ціною на ваш вибір з частиною виручки на благодійність, а також Humble Choice.', 'Humble Bundle sells game, book and software bundles at your chosen price with part going to charity, plus Humble Choice.', 'Магазин бандлів і окремих ігор, де покупець сам вирішує, скільки заплатити й яку частку віддати на благодійність; щомісячна підписка Humble Choice з добіркою ігор.', 'A store of bundles and individual games where buyers choose how much to pay and how much goes to charity; the monthly Humble Choice subscription offers curated games.', 'Бандли
Благодійність
Humble Choice', 'Bundles
Charity
Humble Choice', 'Економні ПК-гравці.', 'Budget PC gamers.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'humblebundle.com' OR LOWER(`name`) = LOWER('Humble Bundle')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Humble Bundle sells game, book and software bundles at your chosen price with part going to charity, plus Humble Choice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A store of bundles and individual games where buyers choose how much to pay and how much goes to charity; the monthly Humble Choice subscription offers curated games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Bundles
Charity
Humble Choice', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Budget PC gamers.', 'manual' FROM DUAL WHERE @new = 1;

-- HWiNFO — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hwinfo.com' OR LOWER(`name`) = LOWER('HWiNFO'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HWiNFO', NULL, 'https://www.hwinfo.com', NULL, NULL, 'HWiNFO — безкоштовний аналіз, моніторинг і діагностика заліза: температури, частоти, навантаження в реальному часі.', 'HWiNFO is free hardware analysis, monitoring and diagnostics: real-time temperatures, clocks and load.', 'Програма показує детальну інформацію про компоненти ПК і сотні датчиків, веде журнали й передає дані в оверлеї на кшталт RivaTuner.', 'The app shows detailed component info and hundreds of sensors, logs data and feeds overlays like RivaTuner.', 'Датчики в реальному часі
Детальна інформація
Журнали', 'Real-time sensors
Detailed info
Logging', 'ПК-гравці й оверклокери.', 'PC gamers and overclockers.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hwinfo.com' OR LOWER(`name`) = LOWER('HWiNFO')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'HWiNFO is free hardware analysis, monitoring and diagnostics: real-time temperatures, clocks and load.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app shows detailed component info and hundreds of sensors, logs data and feeds overlays like RivaTuner.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time sensors
Detailed info
Logging', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC gamers and overclockers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для домашнього використання', 'For home use' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For home use', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- IGDB — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'igdb.com' OR LOWER(`name`) = LOWER('IGDB'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'IGDB', NULL, 'https://www.igdb.com', NULL, NULL, 'IGDB (Twitch) — база даних ігор з інформацією про релізи, платформи, жанри й компанії та API.', 'IGDB (Twitch) is a game database with release, platform, genre and company info plus an API.', 'Відкрита для спільноти база, яку використовують Twitch та інші сервіси; дає змогу відстежувати релізи, вести списки й отримувати дані через API.', 'A community-driven database used by Twitch and other services; track releases, keep lists and access data via API.', 'Дані про ігри
Календар релізів
API', 'Game data
Release calendar
API', 'Гравці й розробники.', 'Gamers and developers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'igdb.com' OR LOWER(`name`) = LOWER('IGDB')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'IGDB (Twitch) is a game database with release, platform, genre and company info plus an API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A community-driven database used by Twitch and other services; track releases, keep lists and access data via API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Game data
Release calendar
API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers and developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- IGN — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ign.com' OR LOWER(`name`) = LOWER('IGN'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'IGN', NULL, 'https://www.ign.com', NULL, NULL, 'IGN — новини, огляди й проходження відеоігор, вікі-гайди, відео й інтерактивні мапи.', 'IGN offers video game news, reviews and walkthroughs, wiki guides, videos and interactive maps.', 'Одне з найбільших ігрових медіа з оглядами, трейлерами, гайдами й інтерактивними мапами популярних ігор.', 'One of the largest gaming outlets with reviews, trailers, guides and interactive maps for popular games.', 'Огляди
Проходження
Інтерактивні мапи', 'Reviews
Walkthroughs
Interactive maps', 'Гравці.', 'Gamers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ign.com' OR LOWER(`name`) = LOWER('IGN')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'IGN offers video game news, reviews and walkthroughs, wiki guides, videos and interactive maps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'One of the largest gaming outlets with reviews, trailers, guides and interactive maps for popular games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Reviews
Walkthroughs
Interactive maps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Infinite Backlog — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'infinitebacklog.net' OR LOWER(`name`) = LOWER('Infinite Backlog'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Infinite Backlog', NULL, 'https://infinitebacklog.net', NULL, NULL, 'Infinite Backlog — трекер колекції відеоігор з імпортом бібліотек Steam, Xbox, PlayStation і GOG.', 'Infinite Backlog is a video game collection tracker with Steam, Xbox, PlayStation and GOG library import.', 'Дозволяє зібрати всі ігри з різних платформ в одному місці, відмічати статус проходження й стежити за прогресом.', 'It gathers all your games from different platforms in one place, marks completion status and tracks progress.', 'Імпорт бібліотек
Статус проходження
Статистика', 'Library import
Completion status
Stats', 'Гравці на кількох платформах.', 'Multi-platform gamers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'infinitebacklog.net' OR LOWER(`name`) = LOWER('Infinite Backlog')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Infinite Backlog is a video game collection tracker with Steam, Xbox, PlayStation and GOG library import.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It gathers all your games from different platforms in one place, marks completion status and tracks progress.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Library import
Completion status
Stats', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Multi-platform gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Instant Gaming — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'instant-gaming.com' OR LOWER(`name`) = LOWER('Instant Gaming'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Instant Gaming', NULL, 'https://www.instant-gaming.com', NULL, NULL, 'Instant Gaming — магазин цифрових ключів ігор для ПК і консолей зі знижками й миттєвою доставкою.', 'Instant Gaming is a digital game key store for PC and consoles with discounts and instant delivery.', 'Французький магазин ключів для Steam, Xbox, PlayStation і Nintendo з передзамовленнями, щоденними знижками й програмою партнерів.', 'A French key store for Steam, Xbox, PlayStation and Nintendo with pre-orders, daily discounts and an affiliate program.', 'Ключі зі знижками
Миттєва доставка
Передзамовлення', 'Discounted keys
Instant delivery
Pre-orders', 'Гравці.', 'Gamers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'instant-gaming.com' OR LOWER(`name`) = LOWER('Instant Gaming')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Instant Gaming is a digital game key store for PC and consoles with discounts and instant delivery.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A French key store for Steam, Xbox, PlayStation and Nintendo with pre-orders, daily discounts and an affiliate program.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Discounted keys
Instant delivery
Pre-orders', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers.', 'manual' FROM DUAL WHERE @new = 1;

-- IsThereAnyDeal — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'isthereanydeal.com' OR LOWER(`name`) = LOWER('IsThereAnyDeal'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'IsThereAnyDeal', NULL, 'https://isthereanydeal.com', NULL, NULL, 'IsThereAnyDeal — відстеження цін на ПК-ігри в десятках офіційних магазинів, історія цін і сповіщення про знижки.', 'IsThereAnyDeal tracks PC game prices across dozens of official stores, with price history and deal alerts.', 'Сервіс порівнює ціни в Steam, GOG, Humble, Fanatical та інших, показує історичні мінімуми, бандли й роздачі та синхронізує список бажаного.', 'The service compares prices across Steam, GOG, Humble, Fanatical and others, shows historical lows, bundles and giveaways and syncs your wishlist.', 'Порівняння цін
Історичні мінімуми
Сповіщення', 'Price comparison
Historical lows
Alerts', 'Економні ПК-гравці.', 'Budget PC gamers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'isthereanydeal.com' OR LOWER(`name`) = LOWER('IsThereAnyDeal')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'IsThereAnyDeal tracks PC game prices across dozens of official stores, with price history and deal alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The service compares prices across Steam, GOG, Humble, Fanatical and others, shows historical lows, bundles and giveaways and syncs your wishlist.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Price comparison
Historical lows
Alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Budget PC gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс', 'Service' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Service', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- itch.io — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'itch.io' OR LOWER(`name`) = LOWER('itch.io'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'itch.io', NULL, 'https://itch.io', NULL, NULL, 'itch.io — відкритий маркетплейс інді-ігор: безкоштовні й платні проєкти, гейм-джеми та «плати скільки хочеш».', 'itch.io is an open indie game marketplace: free and paid projects, game jams and pay-what-you-want.', 'Платформа, де незалежні автори публікують ігри, а гравці знаходять експериментальні проєкти, браузерні ігри, бандли й гейм-джеми; є десктопний застосунок.', 'A platform where independent creators publish games and players find experimental projects, browser games, bundles and game jams; a desktop app is available.', 'Інді-ігри
Гейм-джеми
Браузерні ігри
Бандли', 'Indie games
Game jams
Browser games
Bundles', 'Любителі інді-ігор.', 'Indie game fans.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'itch.io' OR LOWER(`name`) = LOWER('itch.io')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'itch.io is an open indie game marketplace: free and paid projects, game jams and pay-what-you-want.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform where independent creators publish games and players find experimental projects, browser games, bundles and game jams; a desktop app is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Indie games
Game jams
Browser games
Bundles', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Indie game fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Багато безкоштовних ігор', 'Many free games' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Many free games', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kongregate — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kongregate.com' OR LOWER(`name`) = LOWER('Kongregate'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kongregate', NULL, 'https://www.kongregate.com', NULL, NULL, 'Kongregate — портал безкоштовних онлайн-ігор з контентом від авторів, чатом, значками й досягненнями.', 'Kongregate is a portal of free online games with user-created content, chat, badges and achievements.', 'Один із класичних порталів браузерних ігор з системою значків, рівнями профілю й спільнотою.', 'A classic browser game portal with badges, profile levels and a community.', 'Браузерні ігри
Значки
Чат', 'Browser games
Badges
Chat', 'Казуальні гравці.', 'Casual players.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kongregate.com' OR LOWER(`name`) = LOWER('Kongregate')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Kongregate is a portal of free online games with user-created content, chat, badges and achievements.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A classic browser game portal with badges, profile levels and a community.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Browser games
Badges
Chat', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Casual players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Lichess — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lichess.org' OR LOWER(`name`) = LOWER('Lichess'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lichess', NULL, 'https://lichess.org', NULL, NULL, 'Lichess — безкоштовний відкритий шаховий сервер без реклами: партії, задачі, аналіз і навчання.', 'Lichess is a free open-source chess server without ads: games, puzzles, analysis and learning.', 'Некомерційна платформа з онлайн-партіями будь-якого контролю часу, задачами, рушієм Stockfish для аналізу, турнірами й студіями.', 'A nonprofit platform with online games at any time control, puzzles, Stockfish analysis, tournaments and studies.', 'Партії онлайн
Задачі
Аналіз Stockfish
Без реклами', 'Online games
Puzzles
Stockfish analysis
No ads', 'Шахісти.', 'Chess players.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lichess.org' OR LOWER(`name`) = LOWER('Lichess')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Lichess is a free open-source chess server without ads: games, puzzles, analysis and learning.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A nonprofit platform with online games at any time control, puzzles, Stockfish analysis, tournaments and studies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online games
Puzzles
Stockfish analysis
No ads', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Chess players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Повністю', 'Fully free' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Fully free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Lutris — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lutris.net' OR LOWER(`name`) = LOWER('Lutris'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lutris', NULL, 'https://lutris.net', NULL, NULL, 'Lutris — відкрита ігрова платформа для Linux, що встановлює ігри з різних джерел і емулятори.', 'Lutris is an open gaming platform for Linux that installs games from many sources and emulators.', 'Програма з базою скриптів встановлення, що налаштовує Wine, емулятори й нативні ігри та об''єднує їх в одній бібліотеці.', 'An app with a database of install scripts that sets up Wine, emulators and native games and unifies them in one library.', 'Скрипти встановлення
Wine й емулятори
Open source', 'Install scripts
Wine and emulators
Open source', 'Гравці на Linux.', 'Linux gamers.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lutris.net' OR LOWER(`name`) = LOWER('Lutris')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Lutris is an open gaming platform for Linux that installs games from many sources and emulators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app with a database of install scripts that sets up Wine, emulators and native games and unifies them in one library.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Install scripts
Wine and emulators
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Linux gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Open source', 'Open source' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Metacritic Games — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'metacritic.com/game' OR LOWER(`name`) = LOWER('Metacritic Games'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Metacritic Games', NULL, 'https://www.metacritic.com/game/', NULL, NULL, 'Metacritic — агрегатор оцінок ігор від критиків (Metascore) і користувачів.', 'Metacritic aggregates game ratings from critics (Metascore) and users.', 'Зведені оцінки рецензій провідних видань, оцінки гравців, списки найкращих ігор за роками й платформами.', 'Aggregated review scores from leading outlets, user scores and best-of lists by year and platform.', 'Metascore
Оцінки гравців
Добірки за роками', 'Metascore
User scores
Yearly lists', 'Гравці, що обирають гру.', 'Gamers choosing a game.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'metacritic.com/game' OR LOWER(`name`) = LOWER('Metacritic Games')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Metacritic aggregates game ratings from critics (Metascore) and users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Aggregated review scores from leading outlets, user scores and best-of lists by year and platform.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Metascore
User scores
Yearly lists', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers choosing a game.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Minecraft — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'minecraft.net' OR LOWER(`name`) = LOWER('Minecraft'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Minecraft', NULL, 'https://www.minecraft.net', NULL, NULL, 'Minecraft — пісочниця для будівництва й виживання з величезною спільнотою, маркетплейсом і Realms.', 'Minecraft is a building and survival sandbox with a huge community, marketplace and Realms.', 'Офіційний сайт гри від Mojang/Microsoft: версії Java і Bedrock, сервери Realms, маркетплейс доповнень і Minecraft Education.', 'The official Mojang/Microsoft site: Java and Bedrock editions, Realms servers, add-on marketplace and Minecraft Education.', 'Java і Bedrock
Realms
Маркетплейс', 'Java and Bedrock
Realms
Marketplace', 'Гравці всіх віків.', 'Players of all ages.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'minecraft.net' OR LOWER(`name`) = LOWER('Minecraft')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Minecraft is a building and survival sandbox with a huge community, marketplace and Realms.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official Mojang/Microsoft site: Java and Bedrock editions, Realms servers, add-on marketplace and Minecraft Education.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Java and Bedrock
Realms
Marketplace', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Players of all ages.', 'manual' FROM DUAL WHERE @new = 1;

-- MobyGames — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mobygames.com' OR LOWER(`name`) = LOWER('MobyGames'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MobyGames', NULL, 'https://www.mobygames.com', NULL, NULL, 'MobyGames — найстаріша енциклопедія відеоігор: розробники, творці, скриншоти, обкладинки й історія платформ.', 'MobyGames is the oldest video game encyclopedia: developers, credits, screenshots, cover art and platform history.', 'Детальний архів ігор з 1999 року з титрами, версіями для різних платформ, рекламними матеріалами й колекціями користувачів.', 'A detailed game archive since 1999 with credits, platform versions, promo material and user collections.', 'Титри й автори
Версії платформ
Архів обкладинок', 'Credits
Platform versions
Cover archive', 'Дослідники й любителі ретро.', 'Researchers and retro fans.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mobygames.com' OR LOWER(`name`) = LOWER('MobyGames')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'MobyGames is the oldest video game encyclopedia: developers, credits, screenshots, cover art and platform history.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A detailed game archive since 1999 with credits, platform versions, promo material and user collections.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Credits
Platform versions
Cover archive', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Researchers and retro fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- mod.io — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mod.io' OR LOWER(`name`) = LOWER('mod.io'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'mod.io', NULL, 'https://mod.io', NULL, NULL, 'mod.io — кросплатформна підтримка модів для ПК, консолей і мобільних, яку інтегрують розробники ігор.', 'mod.io provides cross-platform mod support for PC, console and mobile, integrated by game developers.', 'Платформа, через яку гравці завантажують моди прямо в грі на будь-якій платформі, а студії отримують модерацію й монетизацію контенту.', 'A platform through which players download mods in-game on any platform, while studios get moderation and content monetization.', 'Моди на консолях
Внутрішньоігровий браузер
Модерація', 'Mods on consoles
In-game browser
Moderation', 'Гравці та студії.', 'Players and studios.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mod.io' OR LOWER(`name`) = LOWER('mod.io')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'mod.io provides cross-platform mod support for PC, console and mobile, integrated by game developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform through which players download mods in-game on any platform, while studios get moderation and content monetization.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Mods on consoles
In-game browser
Moderation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Players and studios.', 'manual' FROM DUAL WHERE @new = 1;

-- Modrinth — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'modrinth.com' OR LOWER(`name`) = LOWER('Modrinth'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Modrinth', NULL, 'https://modrinth.com', NULL, NULL, 'Modrinth — відкрита платформа модів, плагінів, шейдерів і модпаків для Minecraft з власним застосунком.', 'Modrinth is an open platform for Minecraft mods, plugins, shaders and modpacks with its own app.', 'Сучасний каталог з відкритим кодом, швидкими завантаженнями, монетизацією для авторів і Modrinth App для керування збірками.', 'A modern open-source catalog with fast downloads, creator monetization and Modrinth App for managing setups.', 'Моди й шейдери
Модпаки
Open source', 'Mods and shaders
Modpacks
Open source', 'Гравці Minecraft.', 'Minecraft players.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'modrinth.com' OR LOWER(`name`) = LOWER('Modrinth')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Modrinth is an open platform for Minecraft mods, plugins, shaders and modpacks with its own app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A modern open-source catalog with fast downloads, creator monetization and Modrinth App for managing setups.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Mods and shaders
Modpacks
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Minecraft players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс', 'Service' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Service', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Moonlight — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moonlight-stream.org' OR LOWER(`name`) = LOWER('Moonlight'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Moonlight', NULL, 'https://moonlight-stream.org', NULL, NULL, 'Moonlight — безкоштовний відкритий клієнт для стримінгу ігор з вашого ПК на інші пристрої.', 'Moonlight is a free open-source client for streaming games from your PC to other devices.', 'Разом із сервером Sunshine чи GameStream дозволяє грати в ПК-ігри на ноутбуці, телефоні, планшеті, ТВ чи Steam Deck з низькою затримкою.', 'Together with Sunshine or GameStream it lets you play PC games on a laptop, phone, tablet, TV or Steam Deck with low latency.', 'Стримінг з власного ПК
Низька затримка
Open source', 'Stream from your PC
Low latency
Open source', 'Гравці з ігровим ПК.', 'Gamers with a gaming PC.', 'desktop,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moonlight-stream.org' OR LOWER(`name`) = LOWER('Moonlight')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Moonlight is a free open-source client for streaming games from your PC to other devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Together with Sunshine or GameStream it lets you play PC games on a laptop, phone, tablet, TV or Steam Deck with low latency.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Stream from your PC
Low latency
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers with a gaming PC.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Open source', 'Open source' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Newgrounds — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'newgrounds.com' OR LOWER(`name`) = LOWER('Newgrounds'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Newgrounds', NULL, 'https://www.newgrounds.com', NULL, NULL, 'Newgrounds — легендарний портал інді-ігор, анімації, музики й мистецтва від авторів.', 'Newgrounds is a legendary portal of indie games, animation, music and art by creators.', 'Спільнота з 1995 року, де автори публікують браузерні ігри, мультфільми й музику, а глядачі голосують і коментують.', 'A community since 1995 where creators publish browser games, cartoons and music and viewers vote and comment.', 'Браузерні ігри
Анімація
Музика', 'Browser games
Animation
Music', 'Любителі інді-культури.', 'Indie culture fans.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'newgrounds.com' OR LOWER(`name`) = LOWER('Newgrounds')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Newgrounds is a legendary portal of indie games, animation, music and art by creators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A community since 1995 where creators publish browser games, cartoons and music and viewers vote and comment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Browser games
Animation
Music', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Indie culture fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Nexus Mods — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nexusmods.com' OR LOWER(`name`) = LOWER('Nexus Mods'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nexus Mods', NULL, 'https://www.nexusmods.com', NULL, NULL, 'Nexus Mods — найбільша платформа модів для ПК-ігор: Skyrim, Fallout, Cyberpunk 2077, Baldur''s Gate 3 тощо.', 'Nexus Mods is the largest PC game mod platform: Skyrim, Fallout, Cyberpunk 2077, Baldur''s Gate 3 and more.', 'Сотні тисяч модів для тисяч ігор, менеджер Vortex і новий застосунок Nexus Mods, колекції модів в один клік; Premium дає швидкі завантаження без реклами.', 'Hundreds of thousands of mods for thousands of games, the Vortex manager and the new Nexus Mods app, one-click mod collections; Premium gives fast ad-free downloads.', 'Сотні тисяч модів
Колекції
Vortex', 'Hundreds of thousands of mods
Collections
Vortex', 'ПК-гравці, що модять ігри.', 'PC gamers who mod.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nexusmods.com' OR LOWER(`name`) = LOWER('Nexus Mods')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Nexus Mods is the largest PC game mod platform: Skyrim, Fallout, Cyberpunk 2077, Baldur''s Gate 3 and more.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hundreds of thousands of mods for thousands of games, the Vortex manager and the new Nexus Mods app, one-click mod collections; Premium gives fast ad-free downloads.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hundreds of thousands of mods
Collections
Vortex', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC gamers who mod.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'З обмеженням швидкості', 'Speed-limited downloads' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Speed-limited downloads', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Nintendo Switch Online — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nintendo.com/us/online' OR LOWER(`name`) = LOWER('Nintendo Switch Online'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nintendo Switch Online', NULL, 'https://www.nintendo.com/us/online/', NULL, NULL, 'Nintendo Switch Online — підписка з онлайн-грою, хмарними збереженнями й класичними іграми NES, SNES, N64 тощо.', 'Nintendo Switch Online is a subscription with online play, cloud saves and classic NES, SNES, N64 games and more.', 'Членство для Nintendo Switch: мережева гра, резервні копії збережень, бібліотеки ретроігор, а в розширеному пакеті — ігри N64, Game Boy Advance і доповнення.', 'Membership for Nintendo Switch: online play, save data backup, retro game libraries and, with the Expansion Pack, N64, Game Boy Advance games and DLC.', 'Онлайн-гра
Хмарні збереження
Ретроігри', 'Online play
Cloud saves
Retro games', 'Власники Nintendo Switch.', 'Nintendo Switch owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nintendo.com/us/online' OR LOWER(`name`) = LOWER('Nintendo Switch Online')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Nintendo Switch Online is a subscription with online play, cloud saves and classic NES, SNES, N64 games and more.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Membership for Nintendo Switch: online play, save data backup, retro game libraries and, with the Expansion Pack, N64, Game Boy Advance games and DLC.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online play
Cloud saves
Retro games', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Nintendo Switch owners.', 'manual' FROM DUAL WHERE @new = 1;

-- OpenCritic — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'opencritic.com' OR LOWER(`name`) = LOWER('OpenCritic'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OpenCritic', NULL, 'https://opencritic.com', NULL, NULL, 'OpenCritic — агрегатор рецензій на ігри від провідних критиків з рейтингом і відсотком рекомендацій.', 'OpenCritic aggregates game reviews from top critics with a score and percent recommended.', 'Збирає рецензії в одному місці, показує середню оцінку, частку критиків, що рекомендують гру, і позначки про мікротранзакції.', 'It collects reviews in one place and shows the average score, the share of critics recommending a game and monetization notes.', 'Оцінки критиків
Відсоток рекомендацій
Примітки про монетизацію', 'Critic scores
Percent recommended
Monetization notes', 'Гравці, що обирають гру.', 'Gamers choosing a game.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'opencritic.com' OR LOWER(`name`) = LOWER('OpenCritic')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'OpenCritic aggregates game reviews from top critics with a score and percent recommended.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It collects reviews in one place and shows the average score, the share of critics recommending a game and monetization notes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Critic scores
Percent recommended
Monetization notes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers choosing a game.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Overwolf — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'overwolf.com' OR LOWER(`name`) = LOWER('Overwolf'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Overwolf', NULL, 'https://www.overwolf.com', NULL, NULL, 'Overwolf — платформа внутрішньоігрових застосунків.', 'Overwolf is an in-game app platform.', 'Платформа оверлеїв і застосунків для ігор.', 'A platform of game overlays and apps.', 'Оверлеї', 'Overlays', 'ПК-гравці.', 'PC gamers.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'overwolf.com' OR LOWER(`name`) = LOWER('Overwolf')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Overwolf is an in-game app platform.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform of game overlays and apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Overlays', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC gamers.', 'manual' FROM DUAL WHERE @new = 1;

-- Owlbear Rodeo — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'owlbear.rodeo' OR LOWER(`name`) = LOWER('Owlbear Rodeo'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Owlbear Rodeo', NULL, 'https://www.owlbear.rodeo', NULL, NULL, 'Owlbear Rodeo — простий браузерний віртуальний стіл для НРІ з мапами, жетонами й розширеннями.', 'Owlbear Rodeo is a simple browser virtual tabletop for TTRPGs with maps, tokens and extensions.', 'Мінімалістичний стіл без зайвих функцій: завантажуєте мапу, додаєте жетони, туман війни й запрошуєте гравців посиланням.', 'A minimalist tabletop: upload a map, add tokens and fog of war and invite players with a link.', 'Мапи й жетони
Туман війни
Запрошення посиланням', 'Maps and tokens
Fog of war
Invite by link', 'Майстри НРІ.', 'TTRPG game masters.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'owlbear.rodeo' OR LOWER(`name`) = LOWER('Owlbear Rodeo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Owlbear Rodeo is a simple browser virtual tabletop for TTRPGs with maps, tokens and extensions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A minimalist tabletop: upload a map, add tokens and fog of war and invite players with a link.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Maps and tokens
Fog of war
Invite by link', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'TTRPG game masters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базовий рівень', 'Basic tier' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic tier', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Parsec — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'parsec.app' OR LOWER(`name`) = LOWER('Parsec'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Parsec', NULL, 'https://parsec.app', NULL, NULL, 'Parsec — віддалений робочий стіл з низькою затримкою для ігор і спільної гри з друзями.', 'Parsec is a low-latency remote desktop for gaming and playing together with friends.', 'Дозволяє підключатися до свого ПК або запрошувати друзів у локальні кооперативні ігри через інтернет.', 'Connect to your own PC or invite friends into local co-op games over the internet.', 'Низька затримка
Кооператив онлайн', 'Low latency
Online co-op', 'Гравці.', 'Gamers.', 'desktop,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'parsec.app' OR LOWER(`name`) = LOWER('Parsec')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Parsec is a low-latency remote desktop for gaming and playing together with friends.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Connect to your own PC or invite friends into local co-op games over the internet.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Low latency
Online co-op', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers.', 'manual' FROM DUAL WHERE @new = 1;

-- PCGamingWiki — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pcgamingwiki.com' OR LOWER(`name`) = LOWER('PCGamingWiki'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PCGamingWiki', NULL, 'https://www.pcgamingwiki.com', NULL, NULL, 'PCGamingWiki — вікі з виправленнями й налаштуваннями ПК-ігор: роздільність, FPS, ультраширокі екрани, збереження.', 'PCGamingWiki is a wiki of PC game fixes and settings: resolution, FPS, ultrawide, save locations.', 'Для кожної гри — де лежать збереження й конфіги, підтримка роздільностей, частоти кадрів, контролерів і фікси відомих проблем.', 'For each game: save and config locations, resolution, frame rate and controller support and fixes for known issues.', 'Фікси ігор
Шляхи збережень
Підтримка ультраширокого', 'Game fixes
Save locations
Ultrawide support', 'ПК-гравці.', 'PC gamers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pcgamingwiki.com' OR LOWER(`name`) = LOWER('PCGamingWiki')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'PCGamingWiki is a wiki of PC game fixes and settings: resolution, FPS, ultrawide, save locations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'For each game: save and config locations, resolution, frame rate and controller support and fixes for known issues.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Game fixes
Save locations
Ultrawide support', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Вікі', 'Wiki' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Wiki', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PCSX2 — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pcsx2.net' OR LOWER(`name`) = LOWER('PCSX2'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PCSX2', NULL, 'https://pcsx2.net', NULL, NULL, 'PCSX2 — відкритий емулятор PlayStation 2 для Windows, Linux і macOS з підвищенням роздільності.', 'PCSX2 is an open-source PlayStation 2 emulator for Windows, Linux and macOS with upscaling.', 'Емулятор, що запускає більшість ігор PS2 з власних дисків, з покращеною графікою, текстурами, збереженнями й підтримкою геймпадів.', 'An emulator that runs most PS2 games from your discs with enhanced graphics, textures, saves and gamepad support.', 'Емуляція PS2
Підвищення роздільності
Open source', 'PS2 emulation
Upscaling
Open source', 'Любителі PS2.', 'PS2 fans.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pcsx2.net' OR LOWER(`name`) = LOWER('PCSX2')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'PCSX2 is an open-source PlayStation 2 emulator for Windows, Linux and macOS with upscaling.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An emulator that runs most PS2 games from your discs with enhanced graphics, textures, saves and gamepad support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'PS2 emulation
Upscaling
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PS2 fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Open source', 'Open source' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Playnite — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'playnite.link' OR LOWER(`name`) = LOWER('Playnite'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Playnite', NULL, 'https://playnite.link', NULL, NULL, 'Playnite — безкоштовний відкритий менеджер бібліотеки ігор, що об''єднує Steam, Epic, GOG, емулятори й інші джерела.', 'Playnite is a free open-source game library manager unifying Steam, Epic, GOG, emulators and other sources.', 'Програма для Windows з єдиним інтерфейсом для всіх ігор, режимом для ТВ, метаданими, плагінами й темами.', 'A Windows app with one interface for all games, a TV mode, metadata, plugins and themes.', 'Єдина бібліотека
Емулятори
Плагіни й теми', 'Unified library
Emulators
Plugins and themes', 'ПК-гравці.', 'PC gamers.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'playnite.link' OR LOWER(`name`) = LOWER('Playnite')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Playnite is a free open-source game library manager unifying Steam, Epic, GOG, emulators and other sources.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Windows app with one interface for all games, a TV mode, metadata, plugins and themes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Unified library
Emulators
Plugins and themes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Open source', 'Open source' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PlayStation App — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'playstation.com/en-us/playstation-app' OR LOWER(`name`) = LOWER('PlayStation App'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PlayStation App', NULL, 'https://www.playstation.com/en-us/playstation-app/', NULL, NULL, 'PlayStation App — чат з друзями, PlayStation Store, трофеї й керування консоллю PS5 з телефона.', 'PlayStation App offers friend chat, PlayStation Store, trophies and PS5 control from your phone.', 'Офіційний застосунок Sony: бачите, хто онлайн і що грає, спілкуєтеся в голосових групах, купуєте ігри й запускаєте завантаження на консоль віддалено.', 'Sony''s official app: see who''s online and what they play, voice chat in groups, buy games and start downloads on your console remotely.', 'Друзі й голосові чати
PS Store
Віддалені завантаження', 'Friends and voice chat
PS Store
Remote downloads', 'Власники PlayStation.', 'PlayStation owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'playstation.com/en-us/playstation-app' OR LOWER(`name`) = LOWER('PlayStation App')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'PlayStation App offers friend chat, PlayStation Store, trophies and PS5 control from your phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sony''s official app: see who''s online and what they play, voice chat in groups, buy games and start downloads on your console remotely.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Friends and voice chat
PS Store
Remote downloads', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PlayStation owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PlayStation Plus — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'playstation.com/en-us/ps-plus' OR LOWER(`name`) = LOWER('PlayStation Plus'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PlayStation Plus', NULL, 'https://www.playstation.com/en-us/ps-plus/', NULL, NULL, 'PlayStation Plus — підписка Sony з онлайн-мультиплеєром, щомісячними іграми й каталогом сотень ігор (Essential, Extra, Premium).', 'PlayStation Plus is Sony''s subscription with online multiplayer, monthly games and a catalog of hundreds of games (Essential, Extra, Premium).', 'Рівень Essential дає онлайн-гру й щомісячні ігри, Extra — каталог PS4/PS5, Premium — класичні ігри, пробні версії й хмарний стримінг.', 'Essential provides online play and monthly games, Extra adds a PS4/PS5 catalog, Premium adds classics, trials and cloud streaming.', 'Онлайн-мультиплеєр
Щомісячні ігри
Каталог ігор
Хмарний стримінг', 'Online multiplayer
Monthly games
Game catalog
Cloud streaming', 'Власники PlayStation.', 'PlayStation owners.', 'mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'playstation.com/en-us/ps-plus' OR LOWER(`name`) = LOWER('PlayStation Plus')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'PlayStation Plus is Sony''s subscription with online multiplayer, monthly games and a catalog of hundreds of games (Essential, Extra, Premium).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Essential provides online play and monthly games, Extra adds a PS4/PS5 catalog, Premium adds classics, trials and cloud streaming.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online multiplayer
Monthly games
Game catalog
Cloud streaming', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PlayStation owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Plink — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'plink.gg' OR LOWER(`name`) = LOWER('Plink'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Plink', NULL, 'https://plink.gg', NULL, NULL, 'Plink — пошук тіммейтів.', 'Plink is a teammate finder.', 'Застосунок LFG для гравців.', 'An LFG app for gamers.', 'Пошук тіммейтів', 'Teammate finder', 'Гравці.', 'Gamers.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'plink.gg' OR LOWER(`name`) = LOWER('Plink')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Plink is a teammate finder.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An LFG app for gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Teammate finder', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers.', 'manual' FROM DUAL WHERE @new = 1;

-- Poki — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'poki.com' OR LOWER(`name`) = LOWER('Poki'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Poki', NULL, 'https://poki.com', NULL, NULL, 'Poki — тисячі безкоштовних браузерних ігор без встановлення на ПК, телефоні й планшеті.', 'Poki offers thousands of free browser games with no install on PC, phone and tablet.', 'Платформа миттєвих вебігор з ексклюзивами, категоріями й рекомендаціями, популярна серед дітей і підлітків.', 'An instant web games platform with exclusives, categories and recommendations, popular with kids and teens.', 'Без встановлення
Тисячі ігор
Ексклюзиви', 'No install
Thousands of games
Exclusives', 'Казуальні гравці.', 'Casual players.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'poki.com' OR LOWER(`name`) = LOWER('Poki')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Poki offers thousands of free browser games with no install on PC, phone and tablet.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An instant web games platform with exclusives, categories and recommendations, popular with kids and teens.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'No install
Thousands of games
Exclusives', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Casual players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'З рекламою', 'Ad-supported' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Ad-supported', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PowerPyx — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'powerpyx.com' OR LOWER(`name`) = LOWER('PowerPyx'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PowerPyx', NULL, 'https://www.powerpyx.com', NULL, NULL, 'PowerPyx — гайди з трофеїв, досягнень і колекційних предметів для PlayStation, Xbox і ПК.', 'PowerPyx offers trophy, achievement and collectible guides for PlayStation, Xbox and PC.', 'Детальні дорожні карти до платини, розташування колекційних предметів і відео-гайди для нових релізів.', 'Detailed platinum roadmaps, collectible locations and video guides for new releases.', 'Гайди з трофеїв
Колекційні предмети
Відео', 'Trophy guides
Collectibles
Videos', 'Мисливці за трофеями.', 'Trophy hunters.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'powerpyx.com' OR LOWER(`name`) = LOWER('PowerPyx')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'PowerPyx offers trophy, achievement and collectible guides for PlayStation, Xbox and PC.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Detailed platinum roadmaps, collectible locations and video guides for new releases.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Trophy guides
Collectibles
Videos', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Trophy hunters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PPSSPP — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ppsspp.org' OR LOWER(`name`) = LOWER('PPSSPP'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PPSSPP', NULL, 'https://www.ppsspp.org', NULL, NULL, 'PPSSPP — емулятор PSP для Android, iOS, Windows, macOS і Linux з HD-графікою.', 'PPSSPP is a PSP emulator for Android, iOS, Windows, macOS and Linux with HD graphics.', 'Дозволяє грати у власні ігри PSP у вищій роздільності, зберігатися в будь-який момент і використовувати контролери; є платна версія Gold для підтримки.', 'It plays your own PSP games at higher resolution, with save states and controllers; a paid Gold version supports development.', 'Емуляція PSP
HD-графіка
Збереження стану', 'PSP emulation
HD graphics
Save states', 'Любителі PSP.', 'PSP fans.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ppsspp.org' OR LOWER(`name`) = LOWER('PPSSPP')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'PPSSPP is a PSP emulator for Android, iOS, Windows, macOS and Linux with HD graphics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It plays your own PSP games at higher resolution, with save states and controllers; a paid Gold version supports development.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'PSP emulation
HD graphics
Save states', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PSP fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Основна версія', 'Main version' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Main version', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Prism Launcher — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prismlauncher.org' OR LOWER(`name`) = LOWER('Prism Launcher'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Prism Launcher', NULL, 'https://prismlauncher.org', NULL, NULL, 'Prism Launcher — відкритий лаунчер Minecraft з кількома інстансами, акаунтами й встановленням модів.', 'Prism Launcher is an open-source Minecraft launcher with multiple instances, accounts and mod installation.', 'Дозволяє тримати окремі збірки Minecraft з різними версіями й модпаками, встановлювати моди з Modrinth і CurseForge та перемикати акаунти.', 'It keeps separate Minecraft setups with different versions and modpacks, installs mods from Modrinth and CurseForge and switches accounts.', 'Кілька інстансів
Модпаки
Open source', 'Multiple instances
Modpacks
Open source', 'Гравці Minecraft.', 'Minecraft players.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prismlauncher.org' OR LOWER(`name`) = LOWER('Prism Launcher')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Prism Launcher is an open-source Minecraft launcher with multiple instances, accounts and mod installation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It keeps separate Minecraft setups with different versions and modpacks, installs mods from Modrinth and CurseForge and switches accounts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Multiple instances
Modpacks
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Minecraft players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Open source', 'Open source' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ProtonDB — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'protondb.com' OR LOWER(`name`) = LOWER('ProtonDB'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ProtonDB', NULL, 'https://www.protondb.com', NULL, NULL, 'ProtonDB — звіти гравців про сумісність ігор Windows з Linux і Steam Deck через Proton.', 'ProtonDB gathers player reports on Windows game compatibility with Linux and Steam Deck via Proton.', 'База, де кожна гра має рейтинг сумісності (від Borked до Platinum) і поради з налаштувань від спільноти.', 'A database where each game has a compatibility rating (Borked to Platinum) and community tweak tips.', 'Рейтинги сумісності
Поради спільноти
Steam Deck', 'Compatibility ratings
Community tips
Steam Deck', 'Гравці на Linux і Steam Deck.', 'Linux and Steam Deck gamers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'protondb.com' OR LOWER(`name`) = LOWER('ProtonDB')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ProtonDB gathers player reports on Windows game compatibility with Linux and Steam Deck via Proton.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A database where each game has a compatibility rating (Borked to Platinum) and community tweak tips.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Compatibility ratings
Community tips
Steam Deck', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Linux and Steam Deck gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PSNProfiles — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'psnprofiles.com' OR LOWER(`name`) = LOWER('PSNProfiles'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PSNProfiles', NULL, 'https://psnprofiles.com', NULL, NULL, 'PSNProfiles — профілі трофеїв PlayStation, рейтинги, гайди й дорожні карти до платини.', 'PSNProfiles offers PlayStation trophy profiles, leaderboards, guides and platinum roadmaps.', 'Сайт синхронізує трофеї з PSN, показує рідкість, рейтинги країн і світу та гайди спільноти.', 'The site syncs trophies from PSN, shows rarity, country and world leaderboards and community guides.', 'Синхронізація з PSN
Рідкість трофеїв
Гайди', 'PSN sync
Trophy rarity
Guides', 'Гравці PlayStation.', 'PlayStation gamers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'psnprofiles.com' OR LOWER(`name`) = LOWER('PSNProfiles')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'PSNProfiles offers PlayStation trophy profiles, leaderboards, guides and platinum roadmaps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site syncs trophies from PSN, shows rarity, country and world leaderboards and community guides.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'PSN sync
Trophy rarity
Guides', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PlayStation gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PSPrices — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'psprices.com' OR LOWER(`name`) = LOWER('PSPrices'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PSPrices', NULL, 'https://psprices.com', NULL, NULL, 'PSPrices — трекер цін у PlayStation Store, Xbox і Nintendo eShop у 76 регіонах з історією цін і сповіщеннями.', 'PSPrices tracks PlayStation Store, Xbox and Nintendo eShop prices in 76 regions with history and alerts.', 'Показує поточні знижки, історію цін, найкращі регіональні ціни й надсилає сповіщення про зниження ціни на ігри зі списку бажаного.', 'It shows current discounts, price history and best regional prices and alerts you when wishlisted games drop.', '76 регіонів
Історія цін
Сповіщення', '76 regions
Price history
Alerts', 'Консольні гравці.', 'Console gamers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'psprices.com' OR LOWER(`name`) = LOWER('PSPrices')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'PSPrices tracks PlayStation Store, Xbox and Nintendo eShop prices in 76 regions with history and alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It shows current discounts, price history and best regional prices and alerts you when wishlisted games drop.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '76 regions
Price history
Alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Console gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс', 'Service' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Service', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- RAWG — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rawg.io' OR LOWER(`name`) = LOWER('RAWG'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'RAWG', NULL, 'https://rawg.io', NULL, NULL, 'RAWG — велика база відеоігор і сервіс пошуку: колекція в одному профілі, рекомендації та що грають друзі.', 'RAWG is a large video game database and discovery service: one profile for your collection, recommendations and what friends play.', 'Каталог сотень тисяч ігор з фільтрами, рейтингами, скриншотами, інтеграцією бібліотек і публічним API для розробників.', 'A catalog of hundreds of thousands of games with filters, ratings, screenshots, library integrations and a public API for developers.', 'База ігор
Рекомендації
API', 'Game database
Recommendations
API', 'Гравці й розробники.', 'Gamers and developers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rawg.io' OR LOWER(`name`) = LOWER('RAWG')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'RAWG is a large video game database and discovery service: one profile for your collection, recommendations and what friends play.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A catalog of hundreds of thousands of games with filters, ratings, screenshots, library integrations and a public API for developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Game database
Recommendations
API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers and developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Razer Cortex — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'razer.com/cortex' OR LOWER(`name`) = LOWER('Razer Cortex'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Razer Cortex', NULL, 'https://www.razer.com/cortex', NULL, NULL, 'Razer Cortex — бустер ігор для ПК.', 'Razer Cortex is a PC game booster.', 'Оптимізація системи під час гри.', 'System optimization while gaming.', 'Бустер', 'Booster', 'ПК-гравці.', 'PC gamers.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'razer.com/cortex' OR LOWER(`name`) = LOWER('Razer Cortex')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Razer Cortex is a PC game booster.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'System optimization while gaming.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Booster', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC gamers.', 'manual' FROM DUAL WHERE @new = 1;

-- ReShade — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'reshade.me' OR LOWER(`name`) = LOWER('ReShade'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ReShade', NULL, 'https://reshade.me', NULL, NULL, 'ReShade — безкоштовний інжектор пост-обробки для ігор: ефекти кольору, різкості, глибини поля, трасування променів.', 'ReShade is a free post-processing injector for games: color, sharpening, depth of field and ray-traced effects.', 'Дозволяє додавати до будь-якої гри шейдери з бібліотеки спільноти й налаштовувати картинку у внутрішньоігровому меню.', 'It adds community shaders to almost any game and tunes the image via an in-game menu.', 'Пост-обробка
Шейдери спільноти
Внутрішньоігрове меню', 'Post-processing
Community shaders
In-game menu', 'ПК-гравці й скриншотери.', 'PC gamers and screenshotters.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'reshade.me' OR LOWER(`name`) = LOWER('ReShade')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ReShade is a free post-processing injector for games: color, sharpening, depth of field and ray-traced effects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It adds community shaders to almost any game and tunes the image via an in-game menu.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Post-processing
Community shaders
In-game menu', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC gamers and screenshotters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Програма', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- RetroAchievements — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'retroachievements.org' OR LOWER(`name`) = LOWER('RetroAchievements'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'RetroAchievements', NULL, 'https://retroachievements.org', NULL, NULL, 'RetroAchievements — спільнота, що додає досягнення до класичних ігор в емуляторах на кшталт RetroArch.', 'RetroAchievements is a community adding achievements to classic games in emulators like RetroArch.', 'Безкоштовний сервіс із досягненнями, створеними спільнотою, для ігор NES, SNES, PlayStation та інших систем, з рейтингами й набором Hardcore.', 'A free service with community-made achievements for NES, SNES, PlayStation and other systems, with leaderboards and Hardcore mode.', 'Досягнення для ретроігор
Hardcore-режим
Рейтинги', 'Retro achievements
Hardcore mode
Leaderboards', 'Любителі ретроігор.', 'Retro game fans.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'retroachievements.org' OR LOWER(`name`) = LOWER('RetroAchievements')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'RetroAchievements is a community adding achievements to classic games in emulators like RetroArch.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A free service with community-made achievements for NES, SNES, PlayStation and other systems, with leaderboards and Hardcore mode.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Retro achievements
Hardcore mode
Leaderboards', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Retro game fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс', 'Service' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Service', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- RetroArch — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'retroarch.com' OR LOWER(`name`) = LOWER('RetroArch'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'RetroArch', NULL, 'https://www.retroarch.com', NULL, NULL, 'RetroArch — відкритий фронтенд для емуляторів, ігрових рушіїв і медіаплеєрів на ПК, телефонах і консолях.', 'RetroArch is an open-source frontend for emulators, game engines and media players on PC, phones and consoles.', 'Програма, що запускає «ядра» емуляторів у єдиному інтерфейсі з шейдерами, мережевою грою, перемоткою, досягненнями RetroAchievements і запис.', 'An app running emulator cores in one interface with shaders, netplay, rewind, RetroAchievements and recording.', 'Ядра емуляторів
Шейдери
Мережева гра', 'Emulator cores
Shaders
Netplay', 'Любителі ретроігор.', 'Retro gamers.', 'desktop,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'retroarch.com' OR LOWER(`name`) = LOWER('RetroArch')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'RetroArch is an open-source frontend for emulators, game engines and media players on PC, phones and consoles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app running emulator cores in one interface with shaders, netplay, rewind, RetroAchievements and recording.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Emulator cores
Shaders
Netplay', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Retro gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Open source', 'Open source' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Roblox — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'roblox.com' OR LOWER(`name`) = LOWER('Roblox'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Roblox', NULL, 'https://www.roblox.com', NULL, NULL, 'Roblox — платформа мільйонів ігор, створених користувачами, з інструментами створення Roblox Studio.', 'Roblox is a platform of millions of user-created games with the Roblox Studio creation tools.', 'Безкоштовна платформа, де гравці грають у світи інших користувачів, спілкуються й створюють власні ігри; внутрішня валюта Robux і батьківський контроль.', 'A free platform where players play other users'' worlds, socialize and create their own games; Robux currency and parental controls.', 'Мільйони ігор
Roblox Studio
Батьківський контроль', 'Millions of games
Roblox Studio
Parental controls', 'Діти, підлітки й творці ігор.', 'Kids, teens and creators.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'roblox.com' OR LOWER(`name`) = LOWER('Roblox')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Roblox is a platform of millions of user-created games with the Roblox Studio creation tools.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A free platform where players play other users'' worlds, socialize and create their own games; Robux currency and parental controls.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Millions of games
Roblox Studio
Parental controls', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Kids, teens and creators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Гра безкоштовна', 'Free to play' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free to play', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Roll20 — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'roll20.net' OR LOWER(`name`) = LOWER('Roll20'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Roll20', NULL, 'https://roll20.net', NULL, NULL, 'Roll20 — віртуальний стіл для настільних рольових ігор: мапи, жетони, кубики, листи персонажів і відеочат.', 'Roll20 is a virtual tabletop for pen-and-paper RPGs: maps, tokens, dice, character sheets and video chat.', 'Браузерна платформа для D&D та інших НРІ з динамічним освітленням, маркетплейсом модулів і безкоштовним базовим рівнем.', 'A browser platform for D&D and other TTRPGs with dynamic lighting, a module marketplace and a free basic tier.', 'Віртуальний стіл
Листи персонажів
Динамічне освітлення', 'Virtual tabletop
Character sheets
Dynamic lighting', 'Гравці НРІ.', 'TTRPG players.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'roll20.net' OR LOWER(`name`) = LOWER('Roll20')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Roll20 is a virtual tabletop for pen-and-paper RPGs: maps, tokens, dice, character sheets and video chat.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A browser platform for D&D and other TTRPGs with dynamic lighting, a module marketplace and a free basic tier.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Virtual tabletop
Character sheets
Dynamic lighting', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'TTRPG players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базовий рівень', 'Basic tier' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic tier', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ScummVM — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scummvm.org' OR LOWER(`name`) = LOWER('ScummVM'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ScummVM', NULL, 'https://www.scummvm.org', NULL, NULL, 'ScummVM — програма для запуску класичних графічних квестів і RPG на сучасних системах.', 'ScummVM runs classic graphical adventure and role-playing games on modern systems.', 'Відкритий проєкт, що замінює оригінальні виконувані файли ігор LucasArts, Sierra та інших, дозволяючи грати у власні копії на ПК, телефонах і консолях.', 'An open project replacing the executables of LucasArts, Sierra and other games so you can play your copies on PC, phones and consoles.', 'Класичні квести
Багато платформ
Open source', 'Classic adventures
Many platforms
Open source', 'Любителі класичних квестів.', 'Classic adventure fans.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scummvm.org' OR LOWER(`name`) = LOWER('ScummVM')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ScummVM runs classic graphical adventure and role-playing games on modern systems.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An open project replacing the executables of LucasArts, Sierra and other games so you can play your copies on PC, phones and consoles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Classic adventures
Many platforms
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Classic adventure fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Open source', 'Open source' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Shadow PC — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shadow.tech' OR LOWER(`name`) = LOWER('Shadow PC'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Shadow PC', NULL, 'https://shadow.tech', NULL, NULL, 'Shadow PC — повноцінний Windows-ПК у хмарі для ігор і роботи на будь-якому пристрої.', 'Shadow PC is a full Windows PC in the cloud for gaming and work on any device.', 'Віддалений комп''ютер з потужною відеокартою, на який ви встановлюєте будь-які ігри й програми; доступ з ПК, Mac, Android, iOS і ТВ за підпискою.', 'A remote computer with a powerful GPU where you install any games and apps; access from PC, Mac, Android, iOS and TV by subscription.', 'Windows у хмарі
Будь-які ігри
Будь-який пристрій', 'Windows in the cloud
Any games
Any device', 'Гравці без потужного ПК.', 'Gamers without a strong PC.', 'desktop,mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shadow.tech' OR LOWER(`name`) = LOWER('Shadow PC')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Shadow PC is a full Windows PC in the cloud for gaming and work on any device.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A remote computer with a powerful GPU where you install any games and apps; access from PC, Mac, Android, iOS and TV by subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Windows in the cloud
Any games
Any device', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers without a strong PC.', 'manual' FROM DUAL WHERE @new = 1;

-- Special K — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'special-k.info' OR LOWER(`name`) = LOWER('Special K'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Special K', NULL, 'https://www.special-k.info', NULL, NULL, 'Special K — «швейцарський ніж» ПК-геймінгу: HDR-ретрофіт, обмежувач кадрів, фікси й покращення для ігор.', 'Special K is the Swiss Army knife of PC gaming: HDR retrofit, frame limiter, fixes and game enhancements.', 'Безкоштовний модифікаційний фреймворк, що додає HDR в ігри без нього, точне обмеження кадрів, моніторинг, фікси текстур і стабільності.', 'A free modding framework that adds HDR to games lacking it, precise frame limiting, monitoring and texture and stability fixes.', 'HDR-ретрофіт
Обмежувач кадрів
Фікси', 'HDR retrofit
Frame limiter
Fixes', 'ПК-ентузіасти.', 'PC enthusiasts.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'special-k.info' OR LOWER(`name`) = LOWER('Special K')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Special K is the Swiss Army knife of PC gaming: HDR retrofit, frame limiter, fixes and game enhancements.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A free modding framework that adds HDR to games lacking it, precise frame limiting, monitoring and texture and stability fixes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'HDR retrofit
Frame limiter
Fixes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC enthusiasts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Програма', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Steam — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'store.steampowered.com' OR LOWER(`name`) = LOWER('Steam'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Steam', NULL, 'https://store.steampowered.com', NULL, NULL, 'Steam (Valve) — найбільша платформа ПК-ігор: магазин, бібліотека, друзі, досягнення, Workshop і розпродажі.', 'Steam (Valve) is the largest PC gaming platform: store, library, friends, achievements, Workshop and sales.', 'Магазин і клієнт із десятками тисяч ігор, сезонними розпродажами, відгуками гравців, списком бажаного, хмарними збереженнями, Remote Play, спільнотами й Steam Workshop для модів. Мобільний застосунок дає Steam Guard, чат і покупки.', 'A store and client with tens of thousands of games, seasonal sales, player reviews, wishlists, cloud saves, Remote Play, communities and Steam Workshop for mods. The mobile app offers Steam Guard, chat and purchases.', 'Десятки тисяч ігор
Розпродажі
Хмарні збереження
Steam Workshop', 'Tens of thousands of games
Sales
Cloud saves
Steam Workshop', 'ПК-гравці.', 'PC gamers.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'store.steampowered.com' OR LOWER(`name`) = LOWER('Steam')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Steam (Valve) is the largest PC gaming platform: store, library, friends, achievements, Workshop and sales.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A store and client with tens of thousands of games, seasonal sales, player reviews, wishlists, cloud saves, Remote Play, communities and Steam Workshop for mods. The mobile app offers Steam Guard, chat and purchases.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tens of thousands of games
Sales
Cloud saves
Steam Workshop', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Клієнт; ігри купуються окремо', 'Client; games sold separately' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Client; games sold separately', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Steam Deck — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'steamdeck.com' OR LOWER(`name`) = LOWER('Steam Deck'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Steam Deck', NULL, 'https://www.steamdeck.com', NULL, NULL, 'Steam Deck (Valve) — портативний ігровий ПК на SteamOS для гри в бібліотеку Steam будь-де.', 'Steam Deck (Valve) is a handheld gaming PC on SteamOS for playing your Steam library anywhere.', 'Консоль-ПК з OLED-екраном, що запускає ігри Steam (зокрема Windows-ігри через Proton), підтримує док-станцію й інші магазини в десктопному режимі.', 'A handheld PC with an OLED screen running Steam games (including Windows games via Proton), with dock support and other stores in desktop mode.', 'Портативний ПК
SteamOS і Proton
OLED-екран', 'Handheld PC
SteamOS and Proton
OLED screen', 'ПК-гравці в дорозі.', 'PC gamers on the go.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'steamdeck.com' OR LOWER(`name`) = LOWER('Steam Deck')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Steam Deck (Valve) is a handheld gaming PC on SteamOS for playing your Steam library anywhere.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A handheld PC with an OLED screen running Steam games (including Windows games via Proton), with dock support and other stores in desktop mode.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Handheld PC
SteamOS and Proton
OLED screen', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC gamers on the go.', 'manual' FROM DUAL WHERE @new = 1;

-- Steam Remote Play — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'store.steampowered.com/remoteplay' OR LOWER(`name`) = LOWER('Steam Remote Play'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Steam Remote Play', NULL, 'https://store.steampowered.com/remoteplay', NULL, NULL, 'Steam Remote Play і Steam Link — стримінг ігор зі свого ПК на телефон, ТВ чи інший комп''ютер та Remote Play Together.', 'Steam Remote Play and Steam Link stream games from your PC to phone, TV or another computer, plus Remote Play Together.', 'Вбудована функція Steam для гри поза ПК, а Remote Play Together дає змогу друзям приєднатися до локальної кооперативної гри онлайн без власної копії.', 'A built-in Steam feature for playing away from your PC; Remote Play Together lets friends join local co-op online without owning the game.', 'Стримінг з ПК
Steam Link
Remote Play Together', 'PC streaming
Steam Link
Remote Play Together', 'Користувачі Steam.', 'Steam users.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'store.steampowered.com/remoteplay' OR LOWER(`name`) = LOWER('Steam Remote Play')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Steam Remote Play and Steam Link stream games from your PC to phone, TV or another computer, plus Remote Play Together.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A built-in Steam feature for playing away from your PC; Remote Play Together lets friends join local co-op online without owning the game.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'PC streaming
Steam Link
Remote Play Together', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Steam users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Функція Steam', 'Steam feature' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Steam feature', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Steam Workshop — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'steamcommunity.com/workshop' OR LOWER(`name`) = LOWER('Steam Workshop'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Steam Workshop', NULL, 'https://steamcommunity.com/workshop/', NULL, NULL, 'Steam Workshop — створення, пошук і завантаження контенту від гравців для ігор у Steam: моди, мапи, скіни.', 'Steam Workshop lets you create, find and download player-made content for Steam games: mods, maps, skins.', 'Вбудований каталог, де підписка на мод автоматично встановлює й оновлює його в грі; працює для тисяч ігор.', 'A built-in catalog where subscribing to a mod installs and updates it in-game automatically; works for thousands of games.', 'Підписка на моди
Автооновлення
Тисячі ігор', 'Mod subscriptions
Auto-updates
Thousands of games', 'Користувачі Steam.', 'Steam users.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'steamcommunity.com/workshop' OR LOWER(`name`) = LOWER('Steam Workshop')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Steam Workshop lets you create, find and download player-made content for Steam games: mods, maps, skins.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A built-in catalog where subscribing to a mod installs and updates it in-game automatically; works for thousands of games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Mod subscriptions
Auto-updates
Thousands of games', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Steam users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Функція Steam', 'Steam feature' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Steam feature', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SteamDB — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'steamdb.info' OR LOWER(`name`) = LOWER('SteamDB'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SteamDB', NULL, 'https://steamdb.info', NULL, NULL, 'SteamDB — незалежна база даних Steam: історія цін, онлайн гравців, оновлення, розпродажі й аналітика ігор.', 'SteamDB is an independent Steam database: price history, player counts, updates, sales and game analytics.', 'Сайт відстежує зміни в Steam: графіки онлайну, історичні мінімуми цін у різних регіонах, патчі, дати розпродажів, найпопулярніші ігри й список бажаного з калькулятором вартості акаунта.', 'The site tracks Steam changes: player count charts, historical low prices across regions, patches, sale dates, top games and wishlist tools with an account value calculator.', 'Історія цін
Онлайн гравців
Оновлення ігор', 'Price history
Player counts
Game updates', 'Користувачі Steam.', 'Steam users.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'steamdb.info' OR LOWER(`name`) = LOWER('SteamDB')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SteamDB is an independent Steam database: price history, player counts, updates, sales and game analytics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site tracks Steam changes: player count charts, historical low prices across regions, patches, sale dates, top games and wishlist tools with an account value calculator.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Price history
Player counts
Game updates', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Steam users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tabletop Simulator — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tabletopsimulator.com' OR LOWER(`name`) = LOWER('Tabletop Simulator'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tabletop Simulator', NULL, 'https://www.tabletopsimulator.com', NULL, NULL, 'Tabletop Simulator — фізична пісочниця для настільних ігор онлайн з тисячами модів у Steam Workshop.', 'Tabletop Simulator is a physics sandbox for online tabletop games with thousands of Steam Workshop mods.', 'Гра в Steam, де можна грати в будь-яку настільну гру з друзями, створювати власні й завантажувати ігри зі Workshop; підтримує VR.', 'A Steam game where you play any tabletop game with friends, create your own and download games from the Workshop; VR supported.', 'Фізична пісочниця
Моди Workshop
VR', 'Physics sandbox
Workshop mods
VR', 'Любителі настолок.', 'Tabletop fans.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tabletopsimulator.com' OR LOWER(`name`) = LOWER('Tabletop Simulator')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tabletop Simulator is a physics sandbox for online tabletop games with thousands of Steam Workshop mods.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Steam game where you play any tabletop game with friends, create your own and download games from the Workshop; VR supported.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Physics sandbox
Workshop mods
VR', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tabletop fans.', 'manual' FROM DUAL WHERE @new = 1;

-- Thunderstore — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thunderstore.io' OR LOWER(`name`) = LOWER('Thunderstore'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Thunderstore', NULL, 'https://thunderstore.io', NULL, NULL, 'Thunderstore — база модів для понад 300 ігор (Lethal Company, Valheim, Risk of Rain 2) з менеджером r2modman.', 'Thunderstore is a mod database for 300+ games (Lethal Company, Valheim, Risk of Rain 2) with the r2modman manager.', 'Понад 110 000 модів, менеджери модів r2modman і Thunderstore Mod Manager, профілі й обмін збірками з друзями.', 'Over 110,000 mods, the r2modman and Thunderstore Mod Manager tools, profiles and sharing setups with friends.', '110 000+ модів
300+ ігор
Менеджери модів', '110,000+ mods
300+ games
Mod managers', 'Гравці інді-ігор із модами.', 'Indie game modders.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thunderstore.io' OR LOWER(`name`) = LOWER('Thunderstore')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Thunderstore is a mod database for 300+ games (Lethal Company, Valheim, Risk of Rain 2) with the r2modman manager.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Over 110,000 mods, the r2modman and Thunderstore Mod Manager tools, profiles and sharing setups with friends.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '110,000+ mods
300+ games
Mod managers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Indie game modders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс', 'Service' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Service', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TrueAchievements — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trueachievements.com' OR LOWER(`name`) = LOWER('TrueAchievements'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TrueAchievements', NULL, 'https://www.trueachievements.com', NULL, NULL, 'TrueAchievements — спільнота мисливців за досягненнями Xbox: гайди, складність досягнень і рейтинги гравців.', 'TrueAchievements is a community for Xbox achievement hunters: guides, achievement difficulty and player leaderboards.', 'Сайт відстежує досягнення Xbox, оцінює їхню складність, публікує гайди, новини Game Pass і дає змогу порівнювати прогрес з друзями.', 'The site tracks Xbox achievements, scores their difficulty, publishes guides and Game Pass news and lets you compare progress with friends.', 'Досягнення Xbox
Гайди
Новини Game Pass', 'Xbox achievements
Guides
Game Pass news', 'Гравці Xbox.', 'Xbox gamers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trueachievements.com' OR LOWER(`name`) = LOWER('TrueAchievements')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'TrueAchievements is a community for Xbox achievement hunters: guides, achievement difficulty and player leaderboards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site tracks Xbox achievements, scores their difficulty, publishes guides and Game Pass news and lets you compare progress with friends.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Xbox achievements
Guides
Game Pass news', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Xbox gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TrueTrophies — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'truetrophies.com' OR LOWER(`name`) = LOWER('TrueTrophies'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TrueTrophies', NULL, 'https://www.truetrophies.com', NULL, NULL, 'TrueTrophies — трофеї PlayStation: гайди, складність трофеїв, новини й огляди.', 'TrueTrophies covers PlayStation trophies: guides, trophy difficulty, news and reviews.', 'Аналог TrueAchievements для PS5 та інших платформ PlayStation: відстеження трофеїв, гайди на платину й спільнота.', 'The PlayStation counterpart of TrueAchievements for PS5 and other platforms: trophy tracking, platinum guides and community.', 'Трофеї PlayStation
Гайди на платину
Спільнота', 'PlayStation trophies
Platinum guides
Community', 'Гравці PlayStation.', 'PlayStation gamers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'truetrophies.com' OR LOWER(`name`) = LOWER('TrueTrophies')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'TrueTrophies covers PlayStation trophies: guides, trophy difficulty, news and reviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The PlayStation counterpart of TrueAchievements for PS5 and other platforms: trophy tracking, platinum guides and community.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'PlayStation trophies
Platinum guides
Community', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PlayStation gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Twitch — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'twitch.tv' OR LOWER(`name`) = LOWER('Twitch'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Twitch', NULL, 'https://www.twitch.tv', NULL, NULL, 'Twitch — платформа ігрових трансляцій.', 'Twitch is a gaming livestream platform.', 'Сервіс прямих трансляцій ігор і чатів.', 'A live game streaming and chat service.', 'Трансляції
Чат', 'Streams
Chat', 'Гравці.', 'Gamers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'twitch.tv' OR LOWER(`name`) = LOWER('Twitch')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Twitch is a gaming livestream platform.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A live game streaming and chat service.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Streams
Chat', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers.', 'manual' FROM DUAL WHERE @new = 1;

-- Ubisoft Connect — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ubisoft.com/en-us/ubisoft-connect' OR LOWER(`name`) = LOWER('Ubisoft Connect'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ubisoft Connect', NULL, 'https://www.ubisoft.com/en-us/ubisoft-connect', NULL, NULL, 'Ubisoft Connect — екосистема сервісів Ubisoft: лаунчер, нагороди, друзі й крос-прогрес у різних платформах.', 'Ubisoft Connect is Ubisoft''s ecosystem: launcher, rewards, friends and cross-progression across platforms.', 'Багатоплатформний сервіс для гравців Ubisoft: запуск ігор на ПК, нагороди й завдання, друзі, крос-збереження та доступ до підписки Ubisoft+.', 'A multi-platform service for Ubisoft players: PC game launching, rewards and challenges, friends, cross-saves and access to the Ubisoft+ subscription.', 'Лаунчер
Нагороди
Крос-прогрес', 'Launcher
Rewards
Cross-progression', 'Гравці Ubisoft.', 'Ubisoft players.', 'desktop,mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ubisoft.com/en-us/ubisoft-connect' OR LOWER(`name`) = LOWER('Ubisoft Connect')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ubisoft Connect is Ubisoft''s ecosystem: launcher, rewards, friends and cross-progression across platforms.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A multi-platform service for Ubisoft players: PC game launching, rewards and challenges, friends, cross-saves and access to the Ubisoft+ subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Launcher
Rewards
Cross-progression', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Ubisoft players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс', 'Service' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Service', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Vortex — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nexusmods.com/about/vortex' OR LOWER(`name`) = LOWER('Vortex'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Vortex', NULL, 'https://www.nexusmods.com/about/vortex', NULL, NULL, 'Vortex — безкоштовний менеджер модів від Nexus Mods з порядком завантаження, профілями й встановленням в один клік.', 'Vortex is Nexus Mods'' free mod manager with load order, profiles and one-click install.', 'Програма для Windows, що встановлює, оновлює й упорядковує моди для сотень ігор, розв''язує конфлікти й підтримує колекції.', 'A Windows app that installs, updates and orders mods for hundreds of games, resolves conflicts and supports collections.', 'Встановлення в один клік
Порядок завантаження
Профілі', 'One-click install
Load order
Profiles', 'Моддери.', 'Modders.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nexusmods.com/about/vortex' OR LOWER(`name`) = LOWER('Vortex')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Vortex is Nexus Mods'' free mod manager with load order, profiles and one-click install.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Windows app that installs, updates and orders mods for hundreds of games, resolves conflicts and supports collections.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'One-click install
Load order
Profiles', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Modders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Програма', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Xbox app — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'xbox.com/en-us/apps/xbox-app-for-pc' OR LOWER(`name`) = LOWER('Xbox app'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Xbox app', NULL, 'https://www.xbox.com/en-US/apps/xbox-app-for-pc', NULL, NULL, 'Xbox app — застосунок для ПК і телефона: ігри PC Game Pass, друзі, вечірки, хмарний геймінг і керування консоллю.', 'The Xbox app for PC and mobile: PC Game Pass games, friends, parties, cloud gaming and console management.', 'Програма Microsoft для запуску ігор з Game Pass на ПК, спілкування, перегляду досягнень, віддаленої гри з консолі Xbox і хмарних ігор.', 'Microsoft''s app for launching Game Pass games on PC, chatting, viewing achievements, remote play from an Xbox console and cloud games.', 'PC Game Pass
Друзі й вечірки
Remote Play
Хмарні ігри', 'PC Game Pass
Friends and parties
Remote play
Cloud games', 'Гравці Xbox і ПК.', 'Xbox and PC gamers.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'xbox.com/en-us/apps/xbox-app-for-pc' OR LOWER(`name`) = LOWER('Xbox app')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Xbox app for PC and mobile: PC Game Pass games, friends, parties, cloud gaming and console management.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Microsoft''s app for launching Game Pass games on PC, chatting, viewing achievements, remote play from an Xbox console and cloud games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'PC Game Pass
Friends and parties
Remote play
Cloud games', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Xbox and PC gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Xbox Cloud Gaming — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'xbox.com/en-us/cloud-gaming' OR LOWER(`name`) = LOWER('Xbox Cloud Gaming'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Xbox Cloud Gaming', NULL, 'https://www.xbox.com/en-US/cloud-gaming', NULL, NULL, 'Xbox Cloud Gaming — стримінг ігор Xbox на телефони, планшети, ТВ і ПК з підпискою Game Pass.', 'Xbox Cloud Gaming streams Xbox games to phones, tablets, TVs and PCs with Game Pass.', 'Хмарний сервіс Microsoft, що дозволяє грати в сотні ігор без консолі в браузері, застосунку Xbox і на сумісних ТВ.', 'Microsoft''s cloud service letting you play hundreds of games without a console in a browser, the Xbox app and on compatible TVs.', 'Без консолі
ТВ і телефони
Game Pass', 'No console
TVs and phones
Game Pass', 'Підписники Game Pass.', 'Game Pass subscribers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'xbox.com/en-us/cloud-gaming' OR LOWER(`name`) = LOWER('Xbox Cloud Gaming')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Xbox Cloud Gaming streams Xbox games to phones, tablets, TVs and PCs with Game Pass.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Microsoft''s cloud service letting you play hundreds of games without a console in a browser, the Xbox app and on compatible TVs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'No console
TVs and phones
Game Pass', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Game Pass subscribers.', 'manual' FROM DUAL WHERE @new = 1;

-- Xbox Game Pass — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'xbox.com/en-us/xbox-game-pass' OR LOWER(`name`) = LOWER('Xbox Game Pass'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Xbox Game Pass', NULL, 'https://www.xbox.com/en-US/xbox-game-pass', NULL, NULL, 'Xbox Game Pass — підписка на сотні ігор для консолі й ПК, включно з новинками Microsoft у день релізу та хмарною грою.', 'Xbox Game Pass is a subscription to hundreds of console and PC games, including Microsoft day-one releases and cloud play.', 'Каталог, що постійно оновлюється, з кількома рівнями підписки (Essential, Premium, Ultimate, PC Game Pass), онлайн-мультиплеєром і хмарним геймінгом у вищих рівнях.', 'A constantly updated catalog with several tiers (Essential, Premium, Ultimate, PC Game Pass), online multiplayer and cloud gaming on higher tiers.', 'Сотні ігор
Новинки в день релізу
Хмарна гра', 'Hundreds of games
Day-one releases
Cloud play', 'Гравці Xbox і ПК.', 'Xbox and PC gamers.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'xbox.com/en-us/xbox-game-pass' OR LOWER(`name`) = LOWER('Xbox Game Pass')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Xbox Game Pass is a subscription to hundreds of console and PC games, including Microsoft day-one releases and cloud play.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A constantly updated catalog with several tiers (Essential, Premium, Ultimate, PC Game Pass), online multiplayer and cloud gaming on higher tiers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hundreds of games
Day-one releases
Cloud play', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Xbox and PC gamers.', 'manual' FROM DUAL WHERE @new = 1;

-- YouTube Gaming — Геймінг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'youtube.com/gaming' OR LOWER(`name`) = LOWER('YouTube Gaming'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'YouTube Gaming', NULL, 'https://www.youtube.com/gaming', NULL, NULL, 'YouTube Gaming — ігровий розділ YouTube: трансляції, відео, Let''s Play і трейлери.', 'YouTube Gaming is YouTube''s gaming hub: livestreams, videos, Let''s Plays and trailers.', 'Добірка ігрових трансляцій і відео, рекомендацій каналів і подій з можливістю стримити й підтримувати авторів.', 'A curated hub of gaming streams and videos, channel recommendations and events, with streaming and creator support.', 'Трансляції
Let''s Play
Трейлери', 'Livestreams
Let''s Plays
Trailers', 'Гравці й глядачі.', 'Gamers and viewers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'youtube.com/gaming' OR LOWER(`name`) = LOWER('YouTube Gaming')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`slug` = 'gaming' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'YouTube Gaming is YouTube''s gaming hub: livestreams, videos, Let''s Plays and trailers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A curated hub of gaming streams and videos, channel recommendations and events, with streaming and creator support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Livestreams
Let''s Plays
Trailers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers and viewers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
