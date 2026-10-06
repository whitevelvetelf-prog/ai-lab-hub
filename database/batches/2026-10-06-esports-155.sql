SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-06: 155 нових продуктів для категорії «Спорт», підкатегорія «Кіберспорт».
-- Платні й безкоштовні застосунки та сервіси для кіберспорту: статистика й компаньйони ігор, турнірні платформи,
-- тренажери аіму, навчання, сім-рейсинг, стримінг, софт периферії, продуктивність і зв'язок команди.
-- Кандидати — власний список; сайти перевірено (відповідають, назва на сторінці); на проді відсутні
-- (звірка нормалізованих доменів і назв із gu621051_ailabhublive, 2026-10-06). Виключено: беттинг/казино,
-- матчі на гроші, ринки скінів, закриті й перейменовані сервіси, новинні сайти.
-- Тексти, функції й тарифи (UA + EN) — лише з офіційних сайтів, звірено 2026-10-06.
-- Потребує міграції database/migration-2026-10-06-esports-subcategory.sql (підкатегорія slug 'esports').
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт» (файл .sql). Повторний запуск безпечний.
--   17Lands — Кіберспорт
--   3D Aim Trainer — Кіберспорт
--   Aimbeast — Кіберспорт
--   Aiming.Pro — Кіберспорт
--   Aitum — Кіберспорт
--   Allstar — Кіберспорт
--   AMD Software: Adrenalin Edition — Кіберспорт
--   Apex Legends Status — Кіберспорт
--   Apollo — Кіберспорт
--   BakkesPlugins — Кіберспорт
--   Ballchasing — Кіберспорт
--   Battlefy — Кіберспорт
--   BLAST.tv — Кіберспорт
--   bo3.gg — Кіберспорт
--   BotRix — Кіберспорт
--   Brawlify — Кіберспорт
--   CapFrameX — Кіберспорт
--   Challengermode — Кіберспорт
--   Challonge — Кіберспорт
--   Coach Dave Academy — Кіберспорт
--   CODMunity — Кіберспорт
--   Corsair iCUE — Кіберспорт
--   csstats.gg — Кіберспорт
--   CyberShoke — Кіберспорт
--   Discord — Кіберспорт
--   Dota Plus — Кіберспорт
--   Dota2ProTracker — Кіберспорт
--   Dotabuff — Кіберспорт
--   Dustloop Wiki — Кіберспорт
--   Eklipse — Кіберспорт
--   Elgato Stream Deck — Кіберспорт
--   Esports Charts — Кіберспорт
--   Esports Earnings — Кіберспорт
--   ExitLag — Кіберспорт
--   FACEIT — Кіберспорт
--   FACEIT Analyser — Кіберспорт
--   Fightcade — Кіберспорт
--   Firebot — Кіберспорт
--   Firestone — Кіберспорт
--   Fortnite Tracker — Кіберспорт
--   Fortnite.GG — Кіберспорт
--   Fossabot — Кіберспорт
--   Fragnet Arena — Кіберспорт
--   GamerLink — Кіберспорт
--   Gamers Club — Кіберспорт
--   Games of Legends — Кіберспорт
--   GameTree — Кіберспорт
--   Garage 61 — Кіберспорт
--   Hatchet — Кіберспорт
--   Healthy Gamer — Кіберспорт
--   Hitmarker — Кіберспорт
--   HLTV — Кіберспорт
--   HSReplay.net — Кіберспорт
--   HyperX NGENUITY — Кіберспорт
--   iRacing — Кіберспорт
--   League of Graphs — Кіберспорт
--   LeagueSpot — Кіберспорт
--   Lightstream — Кіберспорт
--   Limitless TCG — Кіберспорт
--   LiveSplit — Кіберспорт
--   Logitech G HUB — Кіберспорт
--   LoL Esports — Кіберспорт
--   LoLalytics — Кіберспорт
--   LoLCHESS.GG — Кіберспорт
--   LoLPros.gg — Кіберспорт
--   Lossless Scaling — Кіберспорт
--   Low Fuel Motorsport — Кіберспорт
--   Lumia Stream — Кіберспорт
--   Matcherino — Кіберспорт
--   Medal — Кіберспорт
--   METAsrc — Кіберспорт
--   MetaTFT — Кіберспорт
--   Mix It Up — Кіберспорт
--   Moobot — Кіберспорт
--   Mouse Sensitivity — Кіберспорт
--   Moxfield — Кіберспорт
--   MSI Afterburner — Кіберспорт
--   MTGGoldfish — Кіберспорт
--   Mudfish — Кіберспорт
--   Mumble — Кіберспорт
--   Nightbot — Кіберспорт
--   Noesis — Кіберспорт
--   NoPing — Кіберспорт
--   NVIDIA App — Кіберспорт
--   NVIDIA Broadcast — Кіберспорт
--   OpenDota — Кіберспорт
--   Oracle's Elixir — Кіберспорт
--   osu! — Кіберспорт
--   Outplayed — Кіберспорт
--   Overwolf — Кіберспорт
--   OWN3D — Кіберспорт
--   Parsec — Кіберспорт
--   PGL — Кіберспорт
--   Pikalytics — Кіберспорт
--   Plink — Кіберспорт
--   Pokémon Showdown — Кіберспорт
--   PopFlash — Кіберспорт
--   Prejump — Кіберспорт
--   Process Lasso — Кіберспорт
--   ProGuides — Кіберспорт
--   RaceLab — Кіберспорт
--   RaceRoom — Кіберспорт
--   Razer Cortex — Кіберспорт
--   Razer Synapse — Кіберспорт
--   Restream — Кіберспорт
--   rib.gg — Кіберспорт
--   Rivals Tracker — Кіберспорт
--   RivalsMeta — Кіберспорт
--   SAMMI — Кіберспорт
--   sesh — Кіберспорт
--   Shikenso Analytics — Кіберспорт
--   SiegeGG — Кіберспорт
--   SimHub — Кіберспорт
--   Simracing.GP — Кіберспорт
--   Sizzle — Кіберспорт
--   Skill Capped — Кіберспорт
--   Skybox EDGE — Кіберспорт
--   Slippi — Кіберспорт
--   Smogon — Кіберспорт
--   Speedrun.com — Кіберспорт
--   start.gg — Кіберспорт
--   Statbot — Кіберспорт
--   SteelSeries GG — Кіберспорт
--   STRATZ — Кіберспорт
--   StreamElements — Кіберспорт
--   Streamer.bot — Кіберспорт
--   StreamerSquare — Кіберспорт
--   Streamlabs — Кіберспорт
--   StreamLadder — Кіберспорт
--   StreamSpell — Кіберспорт
--   SullyGnome — Кіберспорт
--   Sym.gg — Кіберспорт
--   tactics.tools — Кіберспорт
--   TeamSpeak — Кіберспорт
--   TFTactics — Кіберспорт
--   THESPIKE.GG — Кіберспорт
--   Toornament — Кіберспорт
--   Track Titan — Кіберспорт
--   Tracker.gg — Кіберспорт
--   Trackmania Exchange — Кіберспорт
--   Trackmania.io — Кіберспорт
--   Twitch — Кіберспорт
--   TwitchTracker — Кіберспорт
--   U.GG — Кіберспорт
--   Ultimate Frame Data — Кіберспорт
--   Untapped.gg — Кіберспорт
--   ValoPlant — Кіберспорт
--   VALORANT Esports — Кіберспорт
--   VDO.Ninja — Кіберспорт
--   VLR.gg — Кіберспорт
--   Voltaic — Кіберспорт
--   VRS — Кіберспорт
--   Wootility — Кіберспорт
--   Workshop.codes — Кіберспорт
--   WTFast — Кіберспорт
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);

-- 17Lands — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '17lands.com' OR LOWER(`name`) = LOWER('17Lands'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT '17Lands', NULL, 'https://www.17lands.com', NULL, NULL, '17Lands — трекер і відкрита аналітика драфтів MTG Arena: автоматичний збір ваших піків і колод, дані про карти й кольори, метагейм драфту, тренувальні драфти й публічні набори даних.', '17Lands is an MTG Arena draft tracker and open analytics: automatic logging of your picks and decks, card and color data, draft metagame, mock drafts and public data sets.', 'Місія 17Lands — допомогти спільноті Magic: The Gathering краще грати в лімітед. Сервіс збирає й відкрито ділиться даними, щоб гравці розуміли власні результати й отримували висновки, можливі лише на великому спільному масиві даних. Трекер 17Lands автоматично зберігає всі піки драфту й зіграні колоди у форматі, яким зручно ділитися: друзі можуть підказати, що варто було взяти, а колодою можна похизуватися після сету без поразок. Аналітика охоплює дані кольорів колод, карт і їх порівняння, метагейм драфту, дослідник архетипів, швидкість формату, колоди-трофеї й таблиці лідерів. Є тренувальні драфти й публічні набори даних; частина аналітики доступна без акаунта.', '17Lands'' mission is to help the Magic: The Gathering community improve at limited. It aggregates and openly shares data so players understand their own performance and get insights only possible from a large communal data pool. The 17Lands tracker automatically saves all your draft picks and played decks in an easy-to-share format: friends can tell you what you should have picked, or you can show off an undefeated deck. Analytics include deck color data, card data and comparisons, draft metagame, an archetype explorer, format speed, trophy decks and leaderboards. There are mock drafts and public data sets, and much of the analytics works without an account.', 'Автоматичний трекер драфтів
Дані карт і кольорів колод
Метагейм і дослідник архетипів
Тренувальні драфти
Публічні набори даних', 'Automatic draft tracker
Card and deck color data
Metagame and archetype explorer
Mock drafts
Public data sets', 'Гравці MTG Arena в лімітед-форматах.', 'MTG Arena limited players.', 'web,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '17lands.com' OR LOWER(`name`) = LOWER('17Lands')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', '17Lands is an MTG Arena draft tracker and open analytics: automatic logging of your picks and decks, card and color data, draft metagame, mock drafts and public data sets.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', '17Lands'' mission is to help the Magic: The Gathering community improve at limited. It aggregates and openly shares data so players understand their own performance and get insights only possible from a large communal data pool. The 17Lands tracker automatically saves all your draft picks and played decks in an easy-to-share format: friends can tell you what you should have picked, or you can show off an undefeated deck. Analytics include deck color data, card data and comparisons, draft metagame, an archetype explorer, format speed, trophy decks and leaderboards. There are mock drafts and public data sets, and much of the analytics works without an account.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automatic draft tracker
Card and deck color data
Metagame and archetype explorer
Mock drafts
Public data sets', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'MTG Arena limited players.', 'manual' FROM DUAL WHERE @new = 1;

-- 3D Aim Trainer — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '3daimtrainer.com' OR LOWER(`name`) = LOWER('3D Aim Trainer'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT '3D Aim Trainer', NULL, 'https://www.3daimtrainer.com', NULL, NULL, '3D Aim Trainer — безкоштовний аім-тренер у браузері для FPS-гравців: понад 200 вправ на клік, трекінг, флік і перемикання цілей, тести аіму, гайди під ігри й конвертер чутливості.', '3D Aim Trainer is a free browser-based aim trainer for FPS gamers: 200+ drills for clicking, tracking, flicking and target switching, aim tests, game guides and a sensitivity converter.', '3D Aim Trainer допомагає FPS-гравцям тренувати й тестувати аім онлайн без встановлення. Понад 200 вправ розвивають клік, трекінг, флік і перемикання між цілями; сервіс повністю безкоштовний, за даними сайту на ньому зареєстровано 12 мільйонів гравців. Тренування на спеціальних сценаріях пришвидшує прогрес порівняно з самою грою, бо не треба чекати черги й висадки. Є гайди під Fortnite, Valorant, CS2, Apex Legends, Marvel Rivals, Call of Duty та інші ігри, огляди ігрової периферії, конвертер і підбір чутливості, статистика аіму й Discord. Доступна й версія для завантаження.', '3D Aim Trainer helps FPS players train and test their aim online with no installation. Over 200 drills build clicking, tracking, flicking and target switching; it is 100% free, and the site reports 12 million registered gamers. Training on dedicated scenarios speeds up progress compared with playing alone, with no queues or deploying. There are guides for Fortnite, Valorant, CS2, Apex Legends, Marvel Rivals, Call of Duty and more, gaming gear reviews, a sensitivity converter and finder, aim stats and a Discord. A downloadable version is also available.', '200+ вправ на аім
Клік, трекінг, флік і перемикання цілей
Працює в браузері
Гайди під популярні шутери
Конвертер чутливості
Безкоштовно', '200+ aim drills
Clicking, tracking, flicking and switching
Runs in the browser
Guides for popular shooters
Sensitivity converter
Free', 'Гравці шутерів, які хочуть покращити аім.', 'Shooter players who want to improve their aim.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '3daimtrainer.com' OR LOWER(`name`) = LOWER('3D Aim Trainer')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', '3D Aim Trainer is a free browser-based aim trainer for FPS gamers: 200+ drills for clicking, tracking, flicking and target switching, aim tests, game guides and a sensitivity converter.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', '3D Aim Trainer helps FPS players train and test their aim online with no installation. Over 200 drills build clicking, tracking, flicking and target switching; it is 100% free, and the site reports 12 million registered gamers. Training on dedicated scenarios speeds up progress compared with playing alone, with no queues or deploying. There are guides for Fortnite, Valorant, CS2, Apex Legends, Marvel Rivals, Call of Duty and more, gaming gear reviews, a sensitivity converter and finder, aim stats and a Discord. A downloadable version is also available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '200+ aim drills
Clicking, tracking, flicking and switching
Runs in the browser
Guides for popular shooters
Sensitivity converter
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Shooter players who want to improve their aim.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Усі вправи в браузері', 'All drills in the browser' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'All drills in the browser', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Aimbeast — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aimbeast.com' OR LOWER(`name`) = LOWER('Aimbeast'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Aimbeast', NULL, 'https://aimbeast.com', NULL, NULL, 'Aimbeast — аім-тренер у Steam для FPS і TPS із ботами, що поводяться як люди: редактор карт, сценарії спільноти, щотижневі челенджі, автоматичні рутини й відстеження прогресу.', 'Aimbeast is a Steam aim trainer for FPS and TPS with human-like AI bots: a map editor, community scenarios, weekly challenges, automated routines and progress tracking.', 'Aimbeast — рішення для тренування й розминки гравців у шутери від першої й третьої особи. Він поєднує ботів зі штучним інтелектом, що поводяться як люди, і багато корисних сценаріїв, щоб швидко й ефективно покращити аім. Зручний редактор карт дозволяє створювати й одразу тестувати карти та сценарії й ділитися ними у Workshop. Сценарії спільноти тренують окремі аспекти аіму й гнучко налаштовуються; щотижня є челендж із трьома новими сценаріями. З улюблених сценаріїв можна збирати рутини, а вкладка прогресу показує зростання. Приціли, звуки та інше налаштовуються в меню. Гра продається в Steam.', 'Aimbeast is a training and warmup solution for first- and third-person shooter players. It combines human-like AI and many useful scenarios to improve your aim quickly and efficiently. An easy map editor lets you create and test maps and scenarios in real time and share them on the Workshop. Community scenarios train specific aspects of aim and are highly customizable, and weekly challenges feature three new scenarios. You can combine favourite scenarios into routines, and a progress tab tracks improvement. Crosshairs, sounds and more are customizable. It is sold on Steam.', 'Боти з поведінкою як у людей
Редактор карт і Workshop
Сценарії спільноти
Щотижневі челенджі
Рутини й відстеження прогресу', 'Human-like AI bots
Map editor and Workshop
Community scenarios
Weekly challenges
Routines and progress tracking', 'Гравці шутерів на ПК.', 'PC shooter players.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aimbeast.com' OR LOWER(`name`) = LOWER('Aimbeast')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Aimbeast is a Steam aim trainer for FPS and TPS with human-like AI bots: a map editor, community scenarios, weekly challenges, automated routines and progress tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Aimbeast is a training and warmup solution for first- and third-person shooter players. It combines human-like AI and many useful scenarios to improve your aim quickly and efficiently. An easy map editor lets you create and test maps and scenarios in real time and share them on the Workshop. Community scenarios train specific aspects of aim and are highly customizable, and weekly challenges feature three new scenarios. You can combine favourite scenarios into routines, and a progress tab tracks improvement. Crosshairs, sounds and more are customizable. It is sold on Steam.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Human-like AI bots
Map editor and Workshop
Community scenarios
Weekly challenges
Routines and progress tracking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC shooter players.', 'manual' FROM DUAL WHERE @new = 1;

-- Aiming.Pro — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aiming.pro' OR LOWER(`name`) = LOWER('Aiming.Pro'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Aiming.Pro', NULL, 'https://aiming.pro', NULL, NULL, 'Aiming.Pro — онлайн-аім-тренер у браузері: понад 10 000 динамічних вправ і 1000 плейлистів, трекінг, флік, перемикання цілей і таймінг кліку, панель прогресу, таблиці лідерів і курси.', 'Aiming.Pro is an online browser-based aim trainer: 10,000+ dynamic drills and 1,000 playlists, tracking, flicks, target switching and click timing, a progress dashboard, leaderboards and courses.', 'Aiming.Pro перетворює браузер на персонального тренера з аіму; ним скористалися близько 4 мільйонів гравців. Тренер безкоштовний і простий: швидко розімнутися можна будь-де без Steam. Понад 10 000 динамічних вправ і 1000 унікальних плейлистів охоплюють трекінг рухомих цілей, флік, перемикання між цілями й таймінг кліку. Інтуїтивна панель візуалізує прогрес, бенчмарки й челенджі в таблицях лідерів мотивують, а інтерактивні покрокові курси допомагають системно тренуватися. Розширені можливості відкриває підписка Plus+.', 'Aiming.Pro turns your browser into a personal aiming coach, used by about 4 million players. It is free and easy: warm up anywhere without Steam. Over 10,000 dynamic drills and 1,000 unique playlists cover tracking moving targets, flicks, target switching and click timing. An intuitive dashboard visualises progress, benchmarks and leaderboard challenges keep you motivated, and interactive step-by-step courses help you train systematically. The Plus+ subscription unlocks extras.', '10 000+ динамічних вправ
Трекінг, флік і перемикання цілей
Панель прогресу
Бенчмарки й таблиці лідерів
Покрокові курси
Plus+', '10,000+ dynamic drills
Tracking, flicks and switching
Progress dashboard
Benchmarks and leaderboards
Step-by-step courses
Plus+', 'Гравці FPS, які розминаються й тренують аім у браузері.', 'FPS players warming up and training aim in the browser.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aiming.pro' OR LOWER(`name`) = LOWER('Aiming.Pro')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Aiming.Pro is an online browser-based aim trainer: 10,000+ dynamic drills and 1,000 playlists, tracking, flicks, target switching and click timing, a progress dashboard, leaderboards and courses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Aiming.Pro turns your browser into a personal aiming coach, used by about 4 million players. It is free and easy: warm up anywhere without Steam. Over 10,000 dynamic drills and 1,000 unique playlists cover tracking moving targets, flicks, target switching and click timing. An intuitive dashboard visualises progress, benchmarks and leaderboard challenges keep you motivated, and interactive step-by-step courses help you train systematically. The Plus+ subscription unlocks extras.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '10,000+ dynamic drills
Tracking, flicks and switching
Progress dashboard
Benchmarks and leaderboards
Step-by-step courses
Plus+', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'FPS players warming up and training aim in the browser.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Тренер у браузері', 'Browser trainer' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Browser trainer', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Aitum — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aitum.tv' OR LOWER(`name`) = LOWER('Aitum'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Aitum', NULL, 'https://aitum.tv', NULL, NULL, 'Aitum — інструмент автоматизації для стримерів: мультистрим, реакції на підписки, донати й бали каналу (відео, звук, TTS, світло), керування OBS і обладнанням та запуск будь-якої дії на Stream Deck.', 'Aitum is an automation tool for streamers: multistreaming, reactions to subs, tips and channel points (video, sound, TTS, lights), OBS and hardware control, and triggering any action on Stream Deck.', 'Aitum допомагає стримити масштабніше й вирізнятися. Мультистрим розширює охоплення, а автоматичні реакції заохочують монетизацію: підписка на Twitch може запускати мем-відео, Super Chat на YouTube — звук, Cheers — озвучення TTS. Інструмент підвищує якість продакшну: підписка на YouTube змінює світло, бали каналу запускають відео-нагадування попити води. Aitum керує програмами й обладнанням — наприклад, перемикає сцену OBS на «BRB», запускає рекламу на Twitch чи вмикає й вимикає виходи трансляції — і може автоматично запускати будь-яку дію на Stream Deck. Є безкоштовні пресети.', 'Aitum helps you stream bigger and stand out. Multistreaming widens your reach, and automatic reactions encourage monetization: a Twitch sub can trigger a meme video, a YouTube Super Chat a sound, Cheers a TTS response. It raises production value: a YouTube subscription changes your lights, channel points trigger a hydrate video. Aitum controls software and hardware, such as switching OBS to a BRB scene, running Twitch ads or starting and stopping outputs, and can automatically trigger any action on Stream Deck. Free presets are available.', 'Мультистрим
Реакції на підписки й донати
Керування OBS і світлом
Дії на Stream Deck
Безкоштовні пресети', 'Multistreaming
Reactions to subs and tips
OBS and light control
Stream Deck actions
Free presets', 'Стримери, які автоматизують продакшн трансляцій.', 'Streamers automating their production.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aitum.tv' OR LOWER(`name`) = LOWER('Aitum')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Aitum is an automation tool for streamers: multistreaming, reactions to subs, tips and channel points (video, sound, TTS, lights), OBS and hardware control, and triggering any action on Stream Deck.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Aitum helps you stream bigger and stand out. Multistreaming widens your reach, and automatic reactions encourage monetization: a Twitch sub can trigger a meme video, a YouTube Super Chat a sound, Cheers a TTS response. It raises production value: a YouTube subscription changes your lights, channel points trigger a hydrate video. Aitum controls software and hardware, such as switching OBS to a BRB scene, running Twitch ads or starting and stopping outputs, and can automatically trigger any action on Stream Deck. Free presets are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Multistreaming
Reactions to subs and tips
OBS and light control
Stream Deck actions
Free presets', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Streamers automating their production.', 'manual' FROM DUAL WHERE @new = 1;

-- Allstar — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'allstar.gg' OR LOWER(`name`) = LOWER('Allstar'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Allstar', NULL, 'https://allstar.gg', NULL, NULL, 'Allstar — автоматичні хайлайти з ваших ігор: Autocapture збирає кліпи з Premier, Competitive і FACEIT у CS2, є редактор, змагання кліпів із призами та спільнота.', 'Allstar creates in-game highlights automatically: Autocapture gathers clips from CS2 Premier, Competitive and FACEIT, with an editor, clip competitions with prizes and a community.', 'Allstar створює ваші ігрові хайлайти «просто з повітря». Функція Autocapture автоматично збирає всі кліпи в одному місці — для режимів Premier, Competitive і FACEIT — і доступна в планах Standard та Unlimited. Платформа охоплює захоплення, редагування, змагання, спілкування й інструменти для розробників. Регулярно проходять змагання кліпів, наприклад щомісячний Open, де оцінюється сума найкращих кліпів. Знайти профіль можна за SteamID; реєстрація безкоштовна.', 'Allstar makes your in-game highlights ''magically out of thin air''. Autocapture automatically gathers all your clips in one place, for Premier, Competitive and FACEIT, and is available on Standard and Unlimited plans. The platform covers capture, editing, competitions, connecting and building. Regular clip competitions run, such as a monthly Open scored on the sum of your best clips. You can find a profile by SteamID, and sign-up is free.', 'Автоматичні хайлайти Autocapture
Premier, Competitive і FACEIT
Редактор кліпів
Змагання кліпів
Пошук за SteamID', 'Autocapture highlights
Premier, Competitive and FACEIT
Clip editor
Clip competitions
Search by SteamID', 'Гравці CS2, які хочуть хайлайти без ручного запису.', 'CS2 players who want highlights without manual recording.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'allstar.gg' OR LOWER(`name`) = LOWER('Allstar')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Allstar creates in-game highlights automatically: Autocapture gathers clips from CS2 Premier, Competitive and FACEIT, with an editor, clip competitions with prizes and a community.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Allstar makes your in-game highlights ''magically out of thin air''. Autocapture automatically gathers all your clips in one place, for Premier, Competitive and FACEIT, and is available on Standard and Unlimited plans. The platform covers capture, editing, competitions, connecting and building. Regular clip competitions run, such as a monthly Open scored on the sum of your best clips. You can find a profile by SteamID, and sign-up is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Autocapture highlights
Premier, Competitive and FACEIT
Clip editor
Clip competitions
Search by SteamID', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'CS2 players who want highlights without manual recording.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовна реєстрація', 'Free sign-up' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free sign-up', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AMD Software: Adrenalin Edition — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'amd.com/en/products/software/adrenalin.html' OR LOWER(`name`) = LOWER('AMD Software: Adrenalin Edition'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AMD Software: Adrenalin Edition', NULL, 'https://www.amd.com/en/products/software/adrenalin.html', NULL, NULL, 'AMD Software: Adrenalin Edition — програма для відеокарт і процесорів AMD: драйвери, ігрова статистика, профілі HYPR-RX, AMD FSR, Fluid Motion Frames, Radeon Anti-Lag і Boost для вищого FPS і меншої затримки.', 'AMD Software: Adrenalin Edition is the app for AMD graphics and processors: drivers, game stats, HYPR-RX profiles, AMD FSR, Fluid Motion Frames, Radeon Anti-Lag and Boost for higher FPS and lower latency.', 'AMD Software: Adrenalin Edition — простий інтерфейс для продуктів AMD із доступом до нових функцій, ігрової статистики, оновлень драйверів тощо. Є AI-функції, як-от вбудований AMD Chat, і технологія масштабування AMD FSR на основі машинного навчання. Профілі HYPR-RX на головній вкладці одним кліком вмикають набір функцій для максимальної продуктивності й мінімальної затримки введення, а HYPR-RX Eco — для енергозбереження. Генерація кадрів AMD Fluid Motion Frames підвищує FPS і плавність, Radeon Anti-Lag зменшує затримку в іграх DirectX 9, 11 і 12, Radeon Boost динамічно знижує роздільність під час повороту камери, а Radeon Super Resolution масштабує зображення на рівні драйвера. Окремо можна встановити AI Bundle для локальних AI-навантажень.', 'AMD Software: Adrenalin Edition is an easy interface for AMD products with access to new features, game stats, driver updates and more. It offers AI features such as built-in AMD Chat and AMD FSR, an ML-based upscaling technology. HYPR-RX profiles on the home tab enable a suite of features in one click for top performance and minimal input lag, while HYPR-RX Eco saves power. AMD Fluid Motion Frames frame generation boosts FPS and smoothness, Radeon Anti-Lag reduces latency in DirectX 9, 11 and 12 games, Radeon Boost dynamically lowers resolution during camera rotation, and Radeon Super Resolution upscales at the driver level. An optional AI Bundle installs tools for local AI workloads.', 'Оновлення драйверів AMD
Профілі HYPR-RX в один клік
AMD FSR і Fluid Motion Frames
Radeon Anti-Lag і Boost
Ігрова статистика
AMD Chat', 'AMD driver updates
One-click HYPR-RX profiles
AMD FSR and Fluid Motion Frames
Radeon Anti-Lag and Boost
Game stats
AMD Chat', 'Геймери з відеокартами й процесорами AMD.', 'Gamers with AMD graphics and processors.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'amd.com/en/products/software/adrenalin.html' OR LOWER(`name`) = LOWER('AMD Software: Adrenalin Edition')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AMD Software: Adrenalin Edition is the app for AMD graphics and processors: drivers, game stats, HYPR-RX profiles, AMD FSR, Fluid Motion Frames, Radeon Anti-Lag and Boost for higher FPS and lower latency.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'AMD Software: Adrenalin Edition is an easy interface for AMD products with access to new features, game stats, driver updates and more. It offers AI features such as built-in AMD Chat and AMD FSR, an ML-based upscaling technology. HYPR-RX profiles on the home tab enable a suite of features in one click for top performance and minimal input lag, while HYPR-RX Eco saves power. AMD Fluid Motion Frames frame generation boosts FPS and smoothness, Radeon Anti-Lag reduces latency in DirectX 9, 11 and 12 games, Radeon Boost dynamically lowers resolution during camera rotation, and Radeon Super Resolution upscales at the driver level. An optional AI Bundle installs tools for local AI workloads.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AMD driver updates
One-click HYPR-RX profiles
AMD FSR and Fluid Motion Frames
Radeon Anti-Lag and Boost
Game stats
AMD Chat', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers with AMD graphics and processors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для продуктів AMD', 'For AMD products' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For AMD products', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Apex Legends Status — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apexlegendsstatus.com' OR LOWER(`name`) = LOWER('Apex Legends Status'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Apex Legends Status', NULL, 'https://apexlegendsstatus.com', NULL, NULL, 'Apex Legends Status — статус серверів Apex Legends у реальному часі для ПК, PlayStation, Xbox і Switch, статистика гравців і клубів, мета легенд, рейтингові таблиці, ALGS, інтерактивні карти й Discord-бот.', 'Apex Legends Status shows live Apex Legends server status for PC, PlayStation, Xbox and Switch, plus player and club stats, legend meta, ranked leaderboards, ALGS, interactive maps and a Discord bot.', 'Apex Legends Status відстежує сервери ПК, EA і матчмейкінгу Apex Legends на ПК, PlayStation, Xbox і Nintendo Switch по всьому світу: графіки в реальному часі, теплова карта й скарги гравців оновлюються щохвилини, є історія збоїв і пояснення кодів помилок. Крім статусу, сайт пропонує статистику гравців і клубів, порівняння, статистику турнірів і ALGS, частоту вибору й відсоток перемог легенд, розподіл рангів, таблиці лідерів у реальному часі, ротацію крафту й відлік до нового сезону. Інструменти включають інтерактивні карти, вибір зони висадки, гру RingGuessr, Discord-бот, API та застосунок для Android.', 'Apex Legends Status monitors Apex Legends PC, EA and matchmaking servers on PC, PlayStation, Xbox and Nintendo Switch worldwide, with real-time graphs, a heatmap and player reports updated every minute, plus outage history and error-code explanations. Beyond status, it offers player and club stats, comparisons, tournament and ALGS stats, legend pick and win rates, ranked distribution, live ranked leaderboards, crafting rotation and a new season countdown. Tools include interactive maps, a landing zone picker, the RingGuessr game, a Discord bot, an API and an Android app.', 'Статус серверів у реальному часі
Статистика гравців і клубів
Мета легенд і розподіл рангів
Статистика ALGS і турнірів
Інтерактивні карти й вибір висадки
Discord-бот, API й застосунок Android', 'Real-time server status
Player and club stats
Legend meta and ranked distribution
ALGS and tournament stats
Interactive maps and drop picker
Discord bot, API and Android app', 'Гравці Apex Legends і уболівальники ALGS.', 'Apex Legends players and ALGS fans.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apexlegendsstatus.com' OR LOWER(`name`) = LOWER('Apex Legends Status')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Apex Legends Status shows live Apex Legends server status for PC, PlayStation, Xbox and Switch, plus player and club stats, legend meta, ranked leaderboards, ALGS, interactive maps and a Discord bot.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Apex Legends Status monitors Apex Legends PC, EA and matchmaking servers on PC, PlayStation, Xbox and Nintendo Switch worldwide, with real-time graphs, a heatmap and player reports updated every minute, plus outage history and error-code explanations. Beyond status, it offers player and club stats, comparisons, tournament and ALGS stats, legend pick and win rates, ranked distribution, live ranked leaderboards, crafting rotation and a new season countdown. Tools include interactive maps, a landing zone picker, the RingGuessr game, a Discord bot, an API and an Android app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time server status
Player and club stats
Legend meta and ranked distribution
ALGS and tournament stats
Interactive maps and drop picker
Discord bot, API and Android app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Apex Legends players and ALGS fans.', 'manual' FROM DUAL WHERE @new = 1;

-- Apollo — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apollo.fyi' OR LOWER(`name`) = LOWER('Apollo'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Apollo', NULL, 'https://apollo.fyi', NULL, NULL, 'Apollo — бот-календар подій для Discord: планування подій, записи учасників одним кліком, автоматичні нагадування й панель організатора; понад 300 тис. серверів.', 'Apollo is an event calendar bot for Discord: schedule events, one-click signups, automated reminders and an organizer dashboard, used on 300,000+ servers.', 'Apollo допомагає проводити події в Discord, на які спільнота справді приходить. Організатори отримують панель керування, а учасники записуються одним кліком прямо в Discord. Бот планує події, керує реєстраціями й автоматизує нагадування: досить налаштувати один раз, а далі Apollo працює сам. За даними сайту, бот працює на понад 300 тисячах серверів, у ньому заплановано понад 29 мільйонів подій і оброблено понад 100 мільйонів записів. Для кіберспортивних спільнот це зручний спосіб організувати тренування, скрими й турніри. Є Premium і підтримка.', 'Apollo helps you run Discord events your community actually shows up for. Organizers get a dashboard, and members sign up in one click right in Discord. The bot schedules events, manages signups and automates reminders: set it up once and Apollo runs the rest. The site reports 300,000+ servers, 29M+ events scheduled and 100M+ signups handled. For esports communities it is a handy way to organize practice, scrims and tournaments. There is Premium and support.', 'Календар подій у Discord
Запис одним кліком
Автоматичні нагадування
Панель організатора
Premium', 'Discord event calendar
One-click signups
Automated reminders
Organizer dashboard
Premium', 'Discord-спільноти, кіберспортивні команди й клани.', 'Discord communities, esports teams and clans.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apollo.fyi' OR LOWER(`name`) = LOWER('Apollo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Apollo is an event calendar bot for Discord: schedule events, one-click signups, automated reminders and an organizer dashboard, used on 300,000+ servers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Apollo helps you run Discord events your community actually shows up for. Organizers get a dashboard, and members sign up in one click right in Discord. The bot schedules events, manages signups and automates reminders: set it up once and Apollo runs the rest. The site reports 300,000+ servers, 29M+ events scheduled and 100M+ signups handled. For esports communities it is a handy way to organize practice, scrims and tournaments. There is Premium and support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Discord event calendar
One-click signups
Automated reminders
Organizer dashboard
Premium', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Discord communities, esports teams and clans.', 'manual' FROM DUAL WHERE @new = 1;

-- BakkesPlugins — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bakkesplugins.com' OR LOWER(`name`) = LOWER('BakkesPlugins'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BakkesPlugins', NULL, 'https://bakkesplugins.com', NULL, NULL, 'BakkesPlugins — спільнотний дім модів Rocket League для BakkesMod: плагіни, кастомні карти й тренувальні паки, інструменти, машини та туторіали з миттєвою публікацією.', 'BakkesPlugins is the community home for Rocket League mods for BakkesMod: plugins, custom maps and training packs, tools, cars and tutorials with instant publishing.', 'BakkesPlugins — спільнотна платформа для плагінів BakkesMod і кастомізації Rocket League. Тут можна знайти плагіни й модифікації, кастомні карти й тренувальні паки, допоміжні утиліти, машини та туторіали. Автори публікують завантаження миттєво — без черги перевірки. Є пошук, категорії, форуми, гайди й SDK для розробників плагінів.', 'BakkesPlugins is a community platform for BakkesMod plugins and Rocket League customization. You can find plugins and modifications, custom maps and training packs, helper utilities, cars and tutorials. Creators publish uploads instantly, with no review queue. There is search, categories, forums, guides and an SDK for plugin developers.', 'Плагіни BakkesMod
Кастомні карти й тренувальні паки
Утиліти й машини
Миттєва публікація
SDK і туторіали для розробників', 'BakkesMod plugins
Custom maps and training packs
Utilities and cars
Instant publishing
SDK and tutorials for developers', 'Гравці Rocket League на ПК, які тренуються з модами.', 'PC Rocket League players who train with mods.', 'web,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bakkesplugins.com' OR LOWER(`name`) = LOWER('BakkesPlugins')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'BakkesPlugins is the community home for Rocket League mods for BakkesMod: plugins, custom maps and training packs, tools, cars and tutorials with instant publishing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'BakkesPlugins is a community platform for BakkesMod plugins and Rocket League customization. You can find plugins and modifications, custom maps and training packs, helper utilities, cars and tutorials. Creators publish uploads instantly, with no review queue. There is search, categories, forums, guides and an SDK for plugin developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'BakkesMod plugins
Custom maps and training packs
Utilities and cars
Instant publishing
SDK and tutorials for developers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC Rocket League players who train with mods.', 'manual' FROM DUAL WHERE @new = 1;

-- Ballchasing — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ballchasing.com' OR LOWER(`name`) = LOWER('Ballchasing'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ballchasing', NULL, 'https://ballchasing.com', NULL, NULL, 'Ballchasing — 3D-переглядач і генератор статистики повторів Rocket League у браузері: завантаження власних повторів, буст, позиціонування, демо, налаштування камер, групи повторів і API.', 'Ballchasing is a browser-based 3D viewer and stats generator for Rocket League replays: upload your replays, boost, positioning, demos, camera settings, replay groups and an API.', 'Ballchasing дозволяє завантажувати власні повтори Rocket League або переглядати наявні в браузері за допомогою 3D-переглядача й отримувати статистику: зібраний і витрачений буст, позиціонування, демо, налаштування камер тощо. Нові показники охоплюють епічні сейви, вибивання, прострілы й удари в повітрі, які гра відстежує сама. Повтори можна об''єднувати в групи, порівнювати із середніми показниками й розподілами спільноти. Завантаження повторів доступне після входу через Steam, для розробників є документація API. Проєкт веде одна людина, його можна підтримати через Patreon.', 'Ballchasing lets you upload your own Rocket League replays or view existing ones in the browser with a 3D viewer and get stats: boost collected and consumed, positioning, demos, camera settings and more. New stats include epic saves, clears, centers and aerial hits tracked by the game itself. Replays can be grouped and compared with community averages and distributions. Downloading replays requires Steam login, and developers get API documentation. The project is run by one person and can be supported via Patreon.', '3D-перегляд повторів у браузері
Статистика бусту й позиціонування
Нові показники механіки
Групи повторів і порівняння
API для розробників', '3D replay viewing in the browser
Boost and positioning stats
New mechanics stats
Replay groups and comparisons
API for developers', 'Гравці, команди й тренери Rocket League.', 'Rocket League players, teams and coaches.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ballchasing.com' OR LOWER(`name`) = LOWER('Ballchasing')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ballchasing is a browser-based 3D viewer and stats generator for Rocket League replays: upload your replays, boost, positioning, demos, camera settings, replay groups and an API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ballchasing lets you upload your own Rocket League replays or view existing ones in the browser with a 3D viewer and get stats: boost collected and consumed, positioning, demos, camera settings and more. New stats include epic saves, clears, centers and aerial hits tracked by the game itself. Replays can be grouped and compared with community averages and distributions. Downloading replays requires Steam login, and developers get API documentation. The project is run by one person and can be supported via Patreon.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '3D replay viewing in the browser
Boost and positioning stats
New mechanics stats
Replay groups and comparisons
API for developers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Rocket League players, teams and coaches.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Перегляд і статистика повторів', 'Replay viewing and stats' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Replay viewing and stats', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Battlefy — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'battlefy.com' OR LOWER(`name`) = LOWER('Battlefy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Battlefy', NULL, 'https://battlefy.com', NULL, NULL, 'Battlefy — платформа для пошуку й організації кіберспортивних турнірів: офіційні серії на кшталт Apex Legends Global Series і грошові кубки Battlefield, інструменти для організаторів та довідковий центр.', 'Battlefy is a platform to find and organize esports tournaments: official series like the Apex Legends Global Series and Battlefield cash cups, organizer tools and a help center.', 'Battlefy дозволяє знаходити й організовувати кіберспортивні турніри. На платформі проходять офіційні змагання видавців, зокрема Apex Legends Global Series та серії й кубки Battlefield 6 REDSEC. Організатори можуть створювати власні турніри, а гравці — реєструватися й стежити за сітками. Розділ Armoury містить додаткові можливості, є довідковий центр.', 'Battlefy lets you find and organize esports tournaments. It hosts official publisher competitions, including the Apex Legends Global Series and Battlefield 6 REDSEC series and cups. Organizers can create their own tournaments, and players can register and follow brackets. The Armoury section adds extra features, and there is a help center.', 'Пошук турнірів
Організація власних турнірів
Офіційні серії видавців
Сітки й реєстрація
Довідковий центр', 'Find tournaments
Organize your own tournaments
Official publisher series
Brackets and registration
Help center', 'Гравці й організатори кіберспортивних турнірів.', 'Esports tournament players and organizers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'battlefy.com' OR LOWER(`name`) = LOWER('Battlefy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Battlefy is a platform to find and organize esports tournaments: official series like the Apex Legends Global Series and Battlefield cash cups, organizer tools and a help center.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Battlefy lets you find and organize esports tournaments. It hosts official publisher competitions, including the Apex Legends Global Series and Battlefield 6 REDSEC series and cups. Organizers can create their own tournaments, and players can register and follow brackets. The Armoury section adds extra features, and there is a help center.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Find tournaments
Organize your own tournaments
Official publisher series
Brackets and registration
Help center', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Esports tournament players and organizers.', 'manual' FROM DUAL WHERE @new = 1;

-- BLAST.tv — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'blast.tv' OR LOWER(`name`) = LOWER('BLAST.tv'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BLAST.tv', NULL, 'https://blast.tv', NULL, NULL, 'BLAST.tv — хаб змагального кіберспорту з Counter-Strike, Dota 2 і Rocket League: розклад і сітки турнірів, живі рахунки, статистика, фентезі, симулятори й міні-ігри з нагородами за перегляд.', 'BLAST.tv is a competitive esports hub for Counter-Strike, Dota 2 and Rocket League: tournament schedules and brackets, live scores, stats, fantasy, simulators and mini-games with viewing rewards.', 'BLAST.tv — центр новин і подій змагального кіберспорту від організатора BLAST. Для Counter-Strike, Dota 2 і Rocket League тут зібрано розклад турнірів, живі рахунки, статистику гравців і команд і фентезі-міні-ігри на кшталт Counter-Strikle. Сайт охоплює турніри BLAST і події інших організаторів — ESL Pro League, IEM, PGL, RLCS, Esports World Cup. Також публікуються новини, налаштування й поради для великих ігор. Користувачі можуть отримувати нагороди за перегляд.', 'BLAST.tv is a news and event hub for competitive esports from tournament organizer BLAST. For Counter-Strike, Dota 2 and Rocket League it gathers tournament schedules, live scores, player and team stats and fantasy mini-games such as Counter-Strikle. It covers BLAST events and those of other organizers: ESL Pro League, IEM, PGL, RLCS and the Esports World Cup. It also publishes news, settings and tips for big games. Users can earn rewards for watching.', 'Розклад і сітки турнірів CS, Dota 2, RL
Живі рахунки й статистика
Фентезі й міні-ігри
Новини й поради
Нагороди за перегляд', 'CS, Dota 2 and RL schedules and brackets
Live scores and stats
Fantasy and mini-games
News and tips
Viewing rewards', 'Уболівальники Counter-Strike, Dota 2 і Rocket League.', 'Counter-Strike, Dota 2 and Rocket League fans.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'blast.tv' OR LOWER(`name`) = LOWER('BLAST.tv')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'BLAST.tv is a competitive esports hub for Counter-Strike, Dota 2 and Rocket League: tournament schedules and brackets, live scores, stats, fantasy, simulators and mini-games with viewing rewards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'BLAST.tv is a news and event hub for competitive esports from tournament organizer BLAST. For Counter-Strike, Dota 2 and Rocket League it gathers tournament schedules, live scores, player and team stats and fantasy mini-games such as Counter-Strikle. It covers BLAST events and those of other organizers: ESL Pro League, IEM, PGL, RLCS and the Esports World Cup. It also publishes news, settings and tips for big games. Users can earn rewards for watching.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'CS, Dota 2 and RL schedules and brackets
Live scores and stats
Fantasy and mini-games
News and tips
Viewing rewards', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Counter-Strike, Dota 2 and Rocket League fans.', 'manual' FROM DUAL WHERE @new = 1;

-- bo3.gg — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bo3.gg' OR LOWER(`name`) = LOWER('bo3.gg'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'bo3.gg', NULL, 'https://bo3.gg', NULL, NULL, 'bo3.gg — рахунки, розклад і живі результати кіберспортивних матчів CS2, Valorant, R6S, Dota 2, LoL і MLBB: турніри, рейтинги гравців і команд, порівняння, рекорди й новини. Є українська версія.', 'bo3.gg covers scores, schedules and live results for CS2, Valorant, R6S, Dota 2, LoL and MLBB esports: tournaments, player and team rankings, comparisons, records and news, including a Ukrainian version.', 'bo3.gg — кіберспортивний портал із фокусом на CS2, що також охоплює Valorant, Rainbow Six Siege, Dota 2, League of Legends і Mobile Legends. Розділ матчів показує розклад, живі ігри й завершені результати, а турніри — найближчі, поточні й минулі події з призовими фондами й рівнями. Для гравців і команд є рейтинги за ігровою оцінкою та заробітками, а також рейтинг команд від Valve. Інструменти включають рекорди, порівняння команд і гравців та Pick''em для мейджорів. Є новини, статті, прогнози й форум. Сайт перекладено понад 15 мовами, зокрема українською.', 'bo3.gg is an esports portal focused on CS2 that also covers Valorant, Rainbow Six Siege, Dota 2, League of Legends and Mobile Legends. The matches section shows schedules, live games and finished results, and tournaments lists upcoming, ongoing and past events with prize pools and tiers. Players and teams get rankings by performance score and earnings, plus Valve''s team ranking. Tools include records, team and player comparisons and Pick''em for Majors. There are news, articles, predictions and a forum. The site is translated into more than 15 languages, including Ukrainian.', 'Живі результати й розклад матчів
Турніри з призовими й рівнями
Рейтинги гравців і команд
Порівняння команд і гравців
Pick''em для мейджорів
Українська версія сайту', 'Live scores and match schedules
Tournaments with prize pools and tiers
Player and team rankings
Team and player comparisons
Pick''em for Majors
Ukrainian-language version', 'Уболівальники CS2 та інших кіберспортивних дисциплін.', 'Fans of CS2 and other esports titles.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bo3.gg' OR LOWER(`name`) = LOWER('bo3.gg')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'bo3.gg covers scores, schedules and live results for CS2, Valorant, R6S, Dota 2, LoL and MLBB esports: tournaments, player and team rankings, comparisons, records and news, including a Ukrainian version.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'bo3.gg is an esports portal focused on CS2 that also covers Valorant, Rainbow Six Siege, Dota 2, League of Legends and Mobile Legends. The matches section shows schedules, live games and finished results, and tournaments lists upcoming, ongoing and past events with prize pools and tiers. Players and teams get rankings by performance score and earnings, plus Valve''s team ranking. Tools include records, team and player comparisons and Pick''em for Majors. There are news, articles, predictions and a forum. The site is translated into more than 15 languages, including Ukrainian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live scores and match schedules
Tournaments with prize pools and tiers
Player and team rankings
Team and player comparisons
Pick''em for Majors
Ukrainian-language version', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Fans of CS2 and other esports titles.', 'manual' FROM DUAL WHERE @new = 1;

-- BotRix — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'botrix.live' OR LOWER(`name`) = LOWER('BotRix'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BotRix', NULL, 'https://botrix.live', NULL, NULL, 'BotRix — хмарний бот для стримерів і Discord-спільнот: працює з Twitch, Kick, YouTube, Trovo й Discord, гнучко налаштовується й не потребує встановлення.', 'BotRix is a cloud bot for streamers and Discord communities: it works with Twitch, Kick, YouTube, Trovo and Discord, is highly customizable and needs no installation.', 'BotRix — інструмент для творців контенту, які стримлять на Trovo, Twitch, YouTube чи Kick або ведуть Discord-спільноту. Він простий у налаштуванні як для ІТ-фахівців, так і для любителів, а кожну деталь можна змінити під себе, щоб контент був унікальним. BotRix працює в хмарі — нічого не треба завантажувати чи встановлювати, а сучасна інфраструктура забезпечує надійність. Увійти можна через Kick, Twitch, YouTube, Trovo або Discord. Сервіс у бета-версії.', 'BotRix is a tool for creators who stream on Trovo, Twitch, YouTube or Kick or run a Discord community. It is easy to configure for both IT pros and hobbyists, and every detail can be adjusted so your content stays unique. BotRix runs in the cloud, with nothing to download or install, on reliable modern infrastructure. You can log in with Kick, Twitch, YouTube, Trovo or Discord. The service is in beta.', 'Twitch, Kick, YouTube, Trovo і Discord
Хмарний, без встановлення
Гнучкі налаштування
Для новачків і профі', 'Twitch, Kick, YouTube, Trovo and Discord
Cloud-hosted, no install
Flexible settings
For beginners and pros', 'Стримери на кількох платформах і Discord-спільноти.', 'Multi-platform streamers and Discord communities.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'botrix.live' OR LOWER(`name`) = LOWER('BotRix')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'BotRix is a cloud bot for streamers and Discord communities: it works with Twitch, Kick, YouTube, Trovo and Discord, is highly customizable and needs no installation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'BotRix is a tool for creators who stream on Trovo, Twitch, YouTube or Kick or run a Discord community. It is easy to configure for both IT pros and hobbyists, and every detail can be adjusted so your content stays unique. BotRix runs in the cloud, with nothing to download or install, on reliable modern infrastructure. You can log in with Kick, Twitch, YouTube, Trovo or Discord. The service is in beta.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Twitch, Kick, YouTube, Trovo and Discord
Cloud-hosted, no install
Flexible settings
For beginners and pros', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Multi-platform streamers and Discord communities.', 'manual' FROM DUAL WHERE @new = 1;

-- Brawlify — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brawlify.com' OR LOWER(`name`) = LOWER('Brawlify'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Brawlify', NULL, 'https://brawlify.com', NULL, NULL, 'Brawlify — компаньйон Brawl Stars: статистика гравців і клубів у реальному часі, події, карти й режими, мета бійців, рейтинги та відстеження прогресу трофеїв.', 'Brawlify is a Brawl Stars companion: real-time player and club stats, events, maps and modes, brawler meta, rankings and trophy progress tracking.', 'Brawlify пропонує статистику в реальному часі, живі події та детальне відстеження кожного гравця й клубу Brawl Stars. На сайті зібрано понад 100 бійців, рейтинги, поточні події, карти й десятки режимів, а також мету. Відстеження прогресу показує тренди трофеїв, теплову карту активності, журнал боїв і статистику бійців. Перші 7 днів автоматичного відстеження безкоштовні, далі його можна продовжити. Щоб почати, достатньо ввести тег гравця чи клубу.', 'Brawlify offers real-time stats, live events and deep tracking for every Brawl Stars player and club. The site covers 100+ brawlers, rankings, current events, maps and dozens of modes, plus the meta. Progress tracking shows trophy trends, an activity heatmap, the battle log and brawler stats. The first 7 days of auto-tracking are free and can be extended. Just enter a player or club tag to start.', 'Статистика гравців і клубів
Поточні події, карти й режими
Мета й рейтинги бійців
Тренди трофеїв і журнал боїв
7 днів автовідстеження безкоштовно', 'Player and club stats
Live events, maps and modes
Brawler meta and rankings
Trophy trends and battle log
7 days of free auto-tracking', 'Гравці Brawl Stars і клуби.', 'Brawl Stars players and clubs.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brawlify.com' OR LOWER(`name`) = LOWER('Brawlify')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Brawlify is a Brawl Stars companion: real-time player and club stats, events, maps and modes, brawler meta, rankings and trophy progress tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Brawlify offers real-time stats, live events and deep tracking for every Brawl Stars player and club. The site covers 100+ brawlers, rankings, current events, maps and dozens of modes, plus the meta. Progress tracking shows trophy trends, an activity heatmap, the battle log and brawler stats. The first 7 days of auto-tracking are free and can be extended. Just enter a player or club tag to start.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Player and club stats
Live events, maps and modes
Brawler meta and rankings
Trophy trends and battle log
7 days of free auto-tracking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Brawl Stars players and clubs.', 'manual' FROM DUAL WHERE @new = 1;

-- CapFrameX — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'capframex.com' OR LOWER(`name`) = LOWER('CapFrameX'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CapFrameX', NULL, 'https://www.capframex.com', NULL, NULL, 'CapFrameX — безкоштовний інструмент запису й аналізу часу кадрів на основі Intel PresentMon з оверлеєм RivaTuner: детальні й надійні бенчмарки FPS, перцентилі й показники x%-low.', 'CapFrameX is a free frametime capture and analysis tool based on Intel PresentMon with a RivaTuner overlay: detailed, reliable FPS benchmarks, percentiles and x%-low metrics.', 'CapFrameX записує й аналізує час кадрів на основі Intel PresentMon, а оверлей надає RivaTuner Statistics Server. Це джерело детальних і надійних бенчмарків для перевірки, наскільки плавно працює гра. У блозі пояснюються різні метрики продуктивності — час кадрів, FPS, медіана, перцентилі, x%-low — і те, чому аналіз може показувати нижчий FPS, ніж у грі. Код доступний на GitHub, проєкт можна підтримати донатом.', 'CapFrameX captures and analyses frametimes based on Intel''s PresentMon, with an overlay provided by RivaTuner Statistics Server. It is a source of detailed and reliable benchmarks to check how smoothly a game runs. The blog explains performance metrics (frametimes, FPS, median, percentiles, x%-low) and why analysis may show lower FPS than seen in-game. The code is on GitHub, and you can support the project with a donation.', 'Запис часу кадрів
Аналіз FPS і перцентилів
Оверлей RivaTuner
На основі Intel PresentMon
Відкритий код', 'Frametime capture
FPS and percentile analysis
RivaTuner overlay
Based on Intel PresentMon
Open source', 'Ентузіасти ПК і гравці, які перевіряють плавність гри.', 'PC enthusiasts and players checking smoothness.', 'desktop', 'course', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'capframex.com' OR LOWER(`name`) = LOWER('CapFrameX')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'CapFrameX is a free frametime capture and analysis tool based on Intel PresentMon with a RivaTuner overlay: detailed, reliable FPS benchmarks, percentiles and x%-low metrics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'CapFrameX captures and analyses frametimes based on Intel''s PresentMon, with an overlay provided by RivaTuner Statistics Server. It is a source of detailed and reliable benchmarks to check how smoothly a game runs. The blog explains performance metrics (frametimes, FPS, median, percentiles, x%-low) and why analysis may show lower FPS than seen in-game. The code is on GitHub, and you can support the project with a donation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Frametime capture
FPS and percentile analysis
RivaTuner overlay
Based on Intel PresentMon
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC enthusiasts and players checking smoothness.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий код', 'Open source' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Challengermode — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'challengermode.com' OR LOWER(`name`) = LOWER('Challengermode'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Challengermode', NULL, 'https://www.challengermode.com', NULL, NULL, 'Challengermode — платформа змагань для ігрових студій, видавців, кіберспортивних організаторів і брендів: турніри, таблиці лідерів і спільнотні функції, що вбудовуються в гру як другий шар.', 'Challengermode is a competitive engagement platform for game studios, publishers, esports organizers and brands: tournaments, leaderboards and community features added to a game as a second layer.', 'Challengermode — інфраструктура змагального геймінгу для залучення гравців будь-якого масштабу. Платформа допомагає ігровим студіям, видавцям, кіберспортивним організаторам і брендам створювати змагальні активності для всіх гравців. Для розробників вона додає в гру змагальні й спільнотні функції як другий шар — від турнірів до таблиць лідерів — що підвищує залученість, утримання й монетизацію без складної розробки. Окремі рішення є для організаторів, брендів, спільнот і гравців, а також сторінка тарифів.', 'Challengermode is competitive gaming infrastructure for engaging experiences at any scale. It helps game studios, publishers, esports organizers and brands create competitive experiences for all gamers. For developers it adds competitive and community-driven features to a game as a second layer, from tournaments to leaderboards, boosting engagement, retention and monetization without complex development. There are separate solutions for organizers, brands, communities and players, plus a pricing page.', 'Турніри й таблиці лідерів у грі
Змагальний шар без складної розробки
Рішення для організаторів і брендів
Спільнотні функції
Тарифи для бізнесу', 'In-game tournaments and leaderboards
Competitive layer without complex development
Solutions for organizers and brands
Community features
Business pricing', 'Ігрові студії, видавці, організатори турнірів і бренди.', 'Game studios, publishers, tournament organizers and brands.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'challengermode.com' OR LOWER(`name`) = LOWER('Challengermode')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Challengermode is a competitive engagement platform for game studios, publishers, esports organizers and brands: tournaments, leaderboards and community features added to a game as a second layer.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Challengermode is competitive gaming infrastructure for engaging experiences at any scale. It helps game studios, publishers, esports organizers and brands create competitive experiences for all gamers. For developers it adds competitive and community-driven features to a game as a second layer, from tournaments to leaderboards, boosting engagement, retention and monetization without complex development. There are separate solutions for organizers, brands, communities and players, plus a pricing page.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'In-game tournaments and leaderboards
Competitive layer without complex development
Solutions for organizers and brands
Community features
Business pricing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Game studios, publishers, tournament organizers and brands.', 'manual' FROM DUAL WHERE @new = 1;

-- Challonge — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'challonge.com' OR LOWER(`name`) = LOWER('Challonge'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Challonge', NULL, 'https://challonge.com', NULL, NULL, 'Challonge — спрощене керування турнірами для будь-якої гри чи спорту: сітки на вибування, подвійне вибування, кругова система, швейцарська система, групові етапи й генератор сіток.', 'Challonge offers simplified tournament management for any game or sport: single and double elimination, round robin, Swiss, group stages and a bracket generator.', 'Мільйони людей по всьому світу довіряють Challonge керування турнірами, проведення подій і організацію своїх змагальних спільнот. Платформа підтримує багато форматів і налаштувань — від вечірньої гри з друзями до регулярної серії чи багатоденного турніру з тисячами учасників. Серед базових форматів — одиночне й подвійне вибування, «кожен проти всіх» і кругова система, серед просунутих — швейцарська система та групові етапи. Спробувати можна через безкоштовний генератор сіток.', 'Millions of people worldwide trust Challonge to manage tournaments, host events and keep competitive communities organized. It supports many formats and settings, from a Friday night game with friends to an ongoing series or a multi-day event with thousands of participants. Basic formats include single and double elimination, free for all and round robin; advanced formats include Swiss and group stages. You can try it with the free bracket generator.', 'Одиночне й подвійне вибування
Кругова й швейцарська система
Групові етапи
Турніри до тисяч учасників
Генератор сіток', 'Single and double elimination
Round robin and Swiss
Group stages
Events with thousands of entrants
Bracket generator', 'Організатори турнірів — від друзів до великих спільнот.', 'Tournament organizers, from friend groups to large communities.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'challonge.com' OR LOWER(`name`) = LOWER('Challonge')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Challonge offers simplified tournament management for any game or sport: single and double elimination, round robin, Swiss, group stages and a bracket generator.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Millions of people worldwide trust Challonge to manage tournaments, host events and keep competitive communities organized. It supports many formats and settings, from a Friday night game with friends to an ongoing series or a multi-day event with thousands of participants. Basic formats include single and double elimination, free for all and round robin; advanced formats include Swiss and group stages. You can try it with the free bracket generator.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Single and double elimination
Round robin and Swiss
Group stages
Events with thousands of entrants
Bracket generator', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tournament organizers, from friend groups to large communities.', 'manual' FROM DUAL WHERE @new = 1;

-- Coach Dave Academy — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coachdaveacademy.com' OR LOWER(`name`) = LOWER('Coach Dave Academy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Coach Dave Academy', NULL, 'https://coachdaveacademy.com', NULL, NULL, 'Coach Dave Academy — застосунок Delta для сім-рейсерів: професійні сетапи, телеметрія, відеоаналіз і AI-коучинг для iRacing, Le Mans Ultimate, Assetto Corsa Competizione й Assetto Corsa EVO.', 'Coach Dave Academy''s Delta app gives sim racers pro setups, telemetry, video analysis and AI coaching for iRacing, Le Mans Ultimate, Assetto Corsa Competizione and Assetto Corsa EVO.', 'Coach Dave Academy допомагає сім-рейсерам знаходити час на колі. Застосунок Delta поєднує професійні сетапи, телеметрію, відео й AI-коучинг. Він підтримує iRacing, Le Mans Ultimate, Assetto Corsa Competizione й Assetto Corsa EVO. Серед можливостей — AI-коучинг, відеоаналіз, Setup IQ, аналіз даних, сетапи від професіоналів і таблиці лідерів. За даними сайту, сервісу довіряють понад 14 тисяч сім-рейсерів. Також є блог, туторіали, огляди обладнання, сповіщення про нові сетапи та розсилка.', 'Coach Dave Academy helps sim racers unlock lap time. Its Delta app combines pro setups, telemetry, video and AI coaching in one place. It supports iRacing, Le Mans Ultimate, Assetto Corsa Competizione and Assetto Corsa EVO. Features include AI coaching, video analysis, Setup IQ, data analysis, pro setups and leaderboards. The site says it is trusted by 14,000+ sim racers. There is also a blog, tutorials, equipment reviews, setup alerts and a newsletter.', 'Застосунок Delta
Професійні сетапи
AI-коучинг і відеоаналіз
Телеметрія й Setup IQ
iRacing, LMU, ACC, AC EVO', 'Delta app
Pro setups
AI coaching and video analysis
Telemetry and Setup IQ
iRacing, LMU, ACC, AC EVO', 'Сім-рейсери, які хочуть знайти час на колі.', 'Sim racers looking for lap time.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coachdaveacademy.com' OR LOWER(`name`) = LOWER('Coach Dave Academy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Coach Dave Academy''s Delta app gives sim racers pro setups, telemetry, video analysis and AI coaching for iRacing, Le Mans Ultimate, Assetto Corsa Competizione and Assetto Corsa EVO.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Coach Dave Academy helps sim racers unlock lap time. Its Delta app combines pro setups, telemetry, video and AI coaching in one place. It supports iRacing, Le Mans Ultimate, Assetto Corsa Competizione and Assetto Corsa EVO. Features include AI coaching, video analysis, Setup IQ, data analysis, pro setups and leaderboards. The site says it is trusted by 14,000+ sim racers. There is also a blog, tutorials, equipment reviews, setup alerts and a newsletter.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Delta app
Pro setups
AI coaching and video analysis
Telemetry and Setup IQ
iRacing, LMU, ACC, AC EVO', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sim racers looking for lap time.', 'manual' FROM DUAL WHERE @new = 1;

-- CODMunity — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'codmunity.gg' OR LOWER(`name`) = LOWER('CODMunity'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CODMunity', NULL, 'https://codmunity.gg', NULL, NULL, 'CODMunity — мета й статистика Call of Duty: Warzone: зброя за статистикою й популярністю, найкращі збірки, TTK, порівняння, рейтингові таблиці топ-250 і календар змагань.', 'CODMunity tracks the Call of Duty: Warzone meta and stats: guns ranked by stats and pick rate, best loadouts, TTK, comparisons, Top 250 ranked tracking and a competitive calendar.', 'CODMunity щодня оновлює мету Warzone: кожна зброя оцінюється за характеристиками й частотою вибору, а найкращі збірки підібрано для дальнього бою, пістолетів-кулеметів і снайперок. Є рейтинг мети, пакети перків, тір-листи й конструктор тір-листів, примітки до патчів, статистика зброї, порівняння збірок і снайперок, рейтинги TTK і популярності. Інструменти включають трекер камуфляжів, базу, найкраще спорядження й студію оверлеїв. Змагальний розділ відстежує рейтингові ігри Warzone, Resurgence і Multiplayer — топ-250, пороги, рекорди — та календар турнірів, зокрема World Series of Warzone. Є Premium.', 'CODMunity updates the Warzone meta daily: every gun is ranked by stats and pick rate, with the best loadouts for long range, SMGs and snipers. There is a meta ranking, perk packages, tier lists and a tier list creator, patch notes, weapon stats, loadout and sniper comparisons, TTK and popularity rankings. Tools include a camo tracker, database, best gear and an overlay studio. The competitive section tracks Warzone, Resurgence and Multiplayer ranked play (Top 250, cutoffs, records) and a tournament calendar including the World Series of Warzone. Premium is available.', 'Мета зброї Warzone
Найкращі збірки
TTK і порівняння
Рейтингові таблиці топ-250
Календар змагань
Оверлеї для стриму', 'Warzone weapon meta
Best loadouts
TTK and comparisons
Top 250 ranked tracking
Competitive calendar
Stream overlays', 'Гравці Call of Duty: Warzone.', 'Call of Duty: Warzone players.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'codmunity.gg' OR LOWER(`name`) = LOWER('CODMunity')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'CODMunity tracks the Call of Duty: Warzone meta and stats: guns ranked by stats and pick rate, best loadouts, TTK, comparisons, Top 250 ranked tracking and a competitive calendar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'CODMunity updates the Warzone meta daily: every gun is ranked by stats and pick rate, with the best loadouts for long range, SMGs and snipers. There is a meta ranking, perk packages, tier lists and a tier list creator, patch notes, weapon stats, loadout and sniper comparisons, TTK and popularity rankings. Tools include a camo tracker, database, best gear and an overlay studio. The competitive section tracks Warzone, Resurgence and Multiplayer ranked play (Top 250, cutoffs, records) and a tournament calendar including the World Series of Warzone. Premium is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Warzone weapon meta
Best loadouts
TTK and comparisons
Top 250 ranked tracking
Competitive calendar
Stream overlays', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Call of Duty: Warzone players.', 'manual' FROM DUAL WHERE @new = 1;

-- Corsair iCUE — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'corsair.com/us/en/s/icue' OR LOWER(`name`) = LOWER('Corsair iCUE'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Corsair iCUE', NULL, 'https://www.corsair.com/us/en/s/icue', NULL, NULL, 'CORSAIR iCUE — програма, що об''єднує сумісні пристрої Corsair: керування RGB-підсвіткою й вентиляторами, макроси клавіатури, моніторинг температури, ігрові інтеграції й підтримка Stream Deck.', 'CORSAIR iCUE connects compatible Corsair products in one interface: RGB lighting and fan control, keyboard macros, temperature monitoring, game integrations and Stream Deck support.', 'iCUE — програма моніторингу ПК і керування RGB-підсвіткою, що об''єднує всі сумісні пристрої Corsair в одному інтерфейсі. Вона керує підсвіткою й швидкістю вентиляторів, програмує макроси клавіатури й показує температуру системи. Є синхронізовані світлові ефекти, ексклюзивні ігрові інтеграції, iCUE Murals і профілі. Підтримуються сторонні материнські плати, інтеграція з Elgato Stream Deck, керування освітленням Philips Hue, Nanoleaf і Govee, а на LCD-екранах можна виводити віджети, датчики температури й навантаження, власні зображення та GIF.', 'iCUE is PC monitoring and RGB lighting control software that connects all compatible Corsair devices in one interface. It controls lighting and fan speeds, programs keyboard macros and monitors system temperature. There are synchronized lighting effects, exclusive game integrations, iCUE Murals and profiles. It supports third-party motherboards, Elgato Stream Deck integration and Philips Hue, Nanoleaf and Govee lighting, and LCD screens can show widgets, temperature and load sensors, custom images and GIFs.', 'RGB-підсвітка й вентилятори
Макроси клавіатури
Моніторинг температури
Ігрові інтеграції
Stream Deck і розумне освітлення', 'RGB lighting and fans
Keyboard macros
Temperature monitoring
Game integrations
Stream Deck and smart lighting', 'Геймери з пристроями й комплектуючими Corsair.', 'Gamers with Corsair devices and components.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'corsair.com/us/en/s/icue' OR LOWER(`name`) = LOWER('Corsair iCUE')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'CORSAIR iCUE connects compatible Corsair products in one interface: RGB lighting and fan control, keyboard macros, temperature monitoring, game integrations and Stream Deck support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'iCUE is PC monitoring and RGB lighting control software that connects all compatible Corsair devices in one interface. It controls lighting and fan speeds, programs keyboard macros and monitors system temperature. There are synchronized lighting effects, exclusive game integrations, iCUE Murals and profiles. It supports third-party motherboards, Elgato Stream Deck integration and Philips Hue, Nanoleaf and Govee lighting, and LCD screens can show widgets, temperature and load sensors, custom images and GIFs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'RGB lighting and fans
Keyboard macros
Temperature monitoring
Game integrations
Stream Deck and smart lighting', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers with Corsair devices and components.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для пристроїв Corsair', 'For Corsair devices' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For Corsair devices', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- csstats.gg — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'csstats.gg' OR LOWER(`name`) = LOWER('csstats.gg'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'csstats.gg', NULL, 'https://csstats.gg', NULL, NULL, 'csstats.gg — трекер статистики Counter-Strike 2 для режимів Competitive і Premier: профілі гравців через Steam, таблиці лідерів, розподіл рангів, статистика банів, прицели професіоналів і тренувальні інструменти.', 'csstats.gg is a Counter-Strike 2 stat tracker for Competitive and Premier: player profiles via Steam, leaderboards, rank distribution, ban stats, pro crosshairs and training tools.', 'csstats.gg відстежує вашу статистику CS2 у матчах Competitive і Premier. Знайти гравця можна пошуком, входом через Steam або додавши «x» на початку адреси профілю steamcommunity.com — сервіс одразу перенаправить на профіль csstats. За даними сайту, оброблено понад 400 млн ігор і понад 45 млн гравців, відстежено мільйони VAC-банів. Є таблиці лідерів, розподіл рангів, усі матчі, статистика банів, прицели професіоналів і генератор прицілу, тренувальна карта й візерунки віддачі. Бета-версія Steam-бота дає швидше відстеження й сповіщення про матчі. Інтерфейс перекладено десятками мов, зокрема українською.', 'csstats.gg tracks your CS2 stats in Competitive and Premier matchmaking. Find a player by searching, signing in with Steam, or adding an ''x'' to the start of a steamcommunity.com URL for an instant redirect to their csstats profile. The site reports over 400 million games processed, over 45 million players seen and millions of VAC bans tracked. There are leaderboards, rank distribution, all matches, ban stats, pro crosshairs and a crosshair generator, a training map and spray patterns. A Steam bot beta offers faster tracking and match notifications. The interface is available in dozens of languages, including Ukrainian.', 'Статистика Competitive і Premier
Профіль через Steam або «x» перед адресою
Таблиці лідерів і розподіл рангів
Статистика VAC-банів
Прицели професіоналів і генератор
Тренувальна карта й візерунки віддачі', 'Competitive and Premier stats
Profile via Steam or an ''x'' URL prefix
Leaderboards and rank distribution
VAC ban stats
Pro crosshairs and generator
Training map and spray patterns', 'Гравці Counter-Strike 2, які стежать за своїм прогресом.', 'Counter-Strike 2 players who track their progress.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'csstats.gg' OR LOWER(`name`) = LOWER('csstats.gg')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'csstats.gg is a Counter-Strike 2 stat tracker for Competitive and Premier: player profiles via Steam, leaderboards, rank distribution, ban stats, pro crosshairs and training tools.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'csstats.gg tracks your CS2 stats in Competitive and Premier matchmaking. Find a player by searching, signing in with Steam, or adding an ''x'' to the start of a steamcommunity.com URL for an instant redirect to their csstats profile. The site reports over 400 million games processed, over 45 million players seen and millions of VAC bans tracked. There are leaderboards, rank distribution, all matches, ban stats, pro crosshairs and a crosshair generator, a training map and spray patterns. A Steam bot beta offers faster tracking and match notifications. The interface is available in dozens of languages, including Ukrainian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Competitive and Premier stats
Profile via Steam or an ''x'' URL prefix
Leaderboards and rank distribution
VAC ban stats
Pro crosshairs and generator
Training map and spray patterns', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Counter-Strike 2 players who track their progress.', 'manual' FROM DUAL WHERE @new = 1;

-- CyberShoke — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cybershoke.net' OR LOWER(`name`) = LOWER('CyberShoke'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CyberShoke', NULL, 'https://cybershoke.net', NULL, NULL, 'CYBERSHOKE — понад 4000 ігрових серверів для CS2, CS:GO і RUST: можна грати без пошуку гравців і налаштування сервера, тренуватися поруч із професіоналами й стрімерами, є преміум-підписка.', 'CYBERSHOKE runs 4,000+ game servers for CS2, CS:GO and RUST: play without looking for players or setting up a server, train alongside pros and streamers, with a premium subscription available.', 'CYBERSHOKE — мережа з понад 4000 серверів для CS2, CS:GO і RUST. Ідея проста: грати без турбот про пошук гравців чи налаштування сервера. На сайті видно, скільки гравців зараз у кожній грі, а на серверах можна зустріти професійних гравців, стрімерів і друзів — сайт показує години, які на них провели відомі гравці CS. Вхід здійснюється через Steam. Є розділ можливостей серверів, преміум-підписка й відповіді на часті запитання.', 'CYBERSHOKE is a network of more than 4,000 servers for CS2, CS:GO and RUST. The idea is simple: play without worrying about finding players or setting up a server. The site shows how many players are in each game right now, and on the servers you can meet pro players, streamers and friends; the site lists hours well-known CS players have spent there. Sign-in is via Steam. There is a features section, a premium subscription and an FAQ.', '4000+ серверів CS2, CS:GO і RUST
Гра без налаштування сервера
Тренування поруч із професіоналами
Вхід через Steam
Преміум-підписка', '4,000+ CS2, CS:GO and RUST servers
Play without server setup
Train alongside pros
Steam sign-in
Premium subscription', 'Гравці CS2, які тренуються на спільнотних серверах.', 'CS2 players who practise on community servers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cybershoke.net' OR LOWER(`name`) = LOWER('CyberShoke')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'CYBERSHOKE runs 4,000+ game servers for CS2, CS:GO and RUST: play without looking for players or setting up a server, train alongside pros and streamers, with a premium subscription available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'CYBERSHOKE is a network of more than 4,000 servers for CS2, CS:GO and RUST. The idea is simple: play without worrying about finding players or setting up a server. The site shows how many players are in each game right now, and on the servers you can meet pro players, streamers and friends; the site lists hours well-known CS players have spent there. Sign-in is via Steam. There is a features section, a premium subscription and an FAQ.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '4,000+ CS2, CS:GO and RUST servers
Play without server setup
Train alongside pros
Steam sign-in
Premium subscription', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'CS2 players who practise on community servers.', 'manual' FROM DUAL WHERE @new = 1;

-- Discord — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'discord.com' OR LOWER(`name`) = LOWER('Discord'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Discord', NULL, 'https://discord.com', NULL, NULL, 'Discord — груповий голосовий, відео й текстовий чат для геймерів і спільнот: сервери, канали, демонстрація екрана, Quests, підписка Nitro та інструменти для розробників ігор.', 'Discord is group voice, video and text chat for gamers and communities: servers, channels, screen sharing, Quests, the Nitro subscription and tools for game developers.', 'Discord — груповий чат, створений для ігор і спільнот. Користувачі збираються на серверах із текстовими й голосовими каналами, спілкуються відео й діляться екраном; кіберспортивні команди й спільноти використовують його для тренувань, турнірів і зв''язку з фанатами. Є каталог серверів і популярних ігор, Quests із нагородами, ресурси з безпеки — Family Center, Teen Charter, центри політик і приватності. Підписка Nitro додає розширені можливості. Розробники ігор можуть інтегрувати Discord у свої ігри, створювати застосунки й активності. Застосунки доступні в браузері, на ПК і мобільних.', 'Discord is group chat built for games and communities. People gather on servers with text and voice channels, video chat and screen sharing; esports teams and communities use it for practice, tournaments and connecting with fans. There is a server directory and trending games, Quests with rewards, and safety resources such as Family Center, the Teen Charter and policy and privacy hubs. The Nitro subscription adds extra features. Game developers can integrate Discord into their games and build apps and activities. Apps are available in the browser, on desktop and mobile.', 'Сервери з текстовими й голосовими каналами
Відео й демонстрація екрана
Quests із нагородами
Підписка Nitro
Інтеграції для розробників ігор', 'Servers with text and voice channels
Video and screen sharing
Quests with rewards
Nitro subscription
Integrations for game developers', 'Геймери, кіберспортивні команди й спільноти.', 'Gamers, esports teams and communities.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'discord.com' OR LOWER(`name`) = LOWER('Discord')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Discord is group voice, video and text chat for gamers and communities: servers, channels, screen sharing, Quests, the Nitro subscription and tools for game developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Discord is group chat built for games and communities. People gather on servers with text and voice channels, video chat and screen sharing; esports teams and communities use it for practice, tournaments and connecting with fans. There is a server directory and trending games, Quests with rewards, and safety resources such as Family Center, the Teen Charter and policy and privacy hubs. The Nitro subscription adds extra features. Game developers can integrate Discord into their games and build apps and activities. Apps are available in the browser, on desktop and mobile.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Servers with text and voice channels
Video and screen sharing
Quests with rewards
Nitro subscription
Integrations for game developers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers, esports teams and communities.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Основні функції', 'Core features' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Core features', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Dota Plus — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dota2.com/plus' OR LOWER(`name`) = LOWER('Dota Plus'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dota Plus', NULL, 'https://www.dota2.com/plus', NULL, NULL, 'Dota Plus — офіційна місячна підписка Valve для Dota 2: прогрес і рівні героїв, персональні челенджі, асистент Plus із порадами під час гри та безкоштовний щотижневий Battle Cup.', 'Dota Plus is Valve''s official monthly Dota 2 subscription: hero progression and levels, hero-specific challenges, the Plus Assistant with in-game suggestions and a free weekly Battle Cup.', 'Dota Plus — щомісячна підписка, створена, щоб допомогти отримати максимум від кожного матчу. Кожна гра на герої приносить досвід для його рівня: зі зростанням рівня відкриваються значки, Reward Shards і нові фрази для чат-колеса. Кожен герой має набір челенджів під його механіку, що допомагають відточити навички. Асистент Plus дає підказки під час гри, а учасники підписки безкоштовно грають у щотижневому турнірі Battle Cup — інші можуть купити квиток. Оформити підписку можна в клієнті гри; за 6 і 12 місяців діють знижки 6% і 12%, також доступні блоки без автопродовження.', 'Dota Plus is a monthly subscription designed to help you get the most out of every match. Every game with a hero earns XP toward that hero''s level, unlocking badges, Reward Shards and new chat wheel lines. Each hero has tailored challenges based on its mechanics to sharpen your skills. The Plus Assistant gives in-game suggestions, and members play the weekly Battle Cup tournament for free, while others can buy a ticket. You subscribe in the game client; 6- and 12-month terms are 6% and 12% off, and non-renewing time blocks are also available.', 'Прогрес і рівні героїв
Челенджі під механіку кожного героя
Асистент Plus під час гри
Безкоштовний щотижневий Battle Cup
Знижки за 6 і 12 місяців', 'Hero progression and levels
Hero-specific challenges
Plus Assistant in game
Free weekly Battle Cup
Discounts for 6 and 12 months', 'Гравці Dota 2, які хочуть додаткові підказки й прогрес у грі.', 'Dota 2 players who want extra guidance and progression.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dota2.com/plus' OR LOWER(`name`) = LOWER('Dota Plus')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Dota Plus is Valve''s official monthly Dota 2 subscription: hero progression and levels, hero-specific challenges, the Plus Assistant with in-game suggestions and a free weekly Battle Cup.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Dota Plus is a monthly subscription designed to help you get the most out of every match. Every game with a hero earns XP toward that hero''s level, unlocking badges, Reward Shards and new chat wheel lines. Each hero has tailored challenges based on its mechanics to sharpen your skills. The Plus Assistant gives in-game suggestions, and members play the weekly Battle Cup tournament for free, while others can buy a ticket. You subscribe in the game client; 6- and 12-month terms are 6% and 12% off, and non-renewing time blocks are also available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hero progression and levels
Hero-specific challenges
Plus Assistant in game
Free weekly Battle Cup
Discounts for 6 and 12 months', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dota 2 players who want extra guidance and progression.', 'manual' FROM DUAL WHERE @new = 1;

-- Dota2ProTracker — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dota2protracker.com' OR LOWER(`name`) = LOWER('Dota2ProTracker'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dota2ProTracker', NULL, 'https://dota2protracker.com', NULL, NULL, 'Dota2ProTracker — мета Dota 2 і найкращі збірки предметів і навичок для кожного героя на кожній позиції на основі матчів гравців 7000+ MMR і професіоналів.', 'Dota2ProTracker shows the Dota 2 meta and the best item and skill builds for every hero in every position, based on 7000+ MMR and professional matches.', 'Dota2ProTracker збирає дані з матчів гравців рівня 7000+ MMR і професійних ігор, щоб показувати мету Dota 2 та найкращі збірки для кожного героя на кожній позиції. Для поточного патча видно кількість проаналізованих матчів, відсоток перемог Radiant і найбільш спірних героїв. Таблиці мети показують найсильніших героїв загалом і окремо для керрі, мідера, офлейнера, сапорту й хард-сапорту з кількістю матчів, відсотком перемог і власною оцінкою D2PT. Також є статистика професійних гравців, енциклопедії героїв і інструменти драфту. Дані доповнено інформацією Imprint і STRATZ.', 'Dota2ProTracker collects data from 7000+ MMR and professional matches to show the Dota 2 meta and the best builds for every hero in every position. For the current patch you see the number of analysed matches, Radiant win rate and most contested heroes. Meta tables list the strongest heroes overall and per position (carry, mid, offlane, support, hard support) with match counts, win rates and a D2PT rating. There are also pro player stats, hero encyclopedias and drafting tools. Data is enriched by Imprint and STRATZ.', 'Дані матчів 7000+ MMR і профі
Збірки предметів і навичок
Мета для кожної позиції
Оцінка героїв D2PT
Статистика професійних гравців
Інструменти драфту', '7000+ MMR and pro match data
Item and skill builds
Meta for every position
D2PT hero rating
Pro player stats
Drafting tools', 'Гравці Dota 2, які хочуть грати збірками сильних гравців.', 'Dota 2 players who want to use builds of top players.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dota2protracker.com' OR LOWER(`name`) = LOWER('Dota2ProTracker')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Dota2ProTracker shows the Dota 2 meta and the best item and skill builds for every hero in every position, based on 7000+ MMR and professional matches.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Dota2ProTracker collects data from 7000+ MMR and professional matches to show the Dota 2 meta and the best builds for every hero in every position. For the current patch you see the number of analysed matches, Radiant win rate and most contested heroes. Meta tables list the strongest heroes overall and per position (carry, mid, offlane, support, hard support) with match counts, win rates and a D2PT rating. There are also pro player stats, hero encyclopedias and drafting tools. Data is enriched by Imprint and STRATZ.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '7000+ MMR and pro match data
Item and skill builds
Meta for every position
D2PT hero rating
Pro player stats
Drafting tools', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dota 2 players who want to use builds of top players.', 'manual' FROM DUAL WHERE @new = 1;

-- Dotabuff — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dotabuff.com' OR LOWER(`name`) = LOWER('Dotabuff'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dotabuff', NULL, 'https://www.dotabuff.com', NULL, NULL, 'Dotabuff — статистика Dota 2: профілі гравців через вхід зі Steam, мета героїв і предметів, тренди, таблиці лідерів, кіберспортивні матчі, команди й ліги та аналітичні статті.', 'Dotabuff provides Dota 2 statistics: player profiles via Steam sign-in, hero and item meta, trends, leaderboards, esports matches, teams and leagues, and analytical articles.', 'Dotabuff — один із провідних сайтів статистики Dota 2. Після входу через Steam видно власний профіль Dota 2. Розділ героїв показує мету, тренди, лінії, популярність, відсоток перемог, вплив на гру й економіку, а розділ предметів — найуживаніші предмети та їхній вплив. Кіберспортивний розділ містить кліпи, серії, рахунки, ліги, гравців, команди й матчі. Є верифіковані гравці, рейтингова таблиця лідерів, досягнення, живі й нещодавні матчі. Блог публікує розбори ролей і патчів. Розширені можливості доступні в підписці Dotabuff Plus.', 'Dotabuff is one of the leading Dota 2 stats sites. After signing in with Steam you can see your Dota 2 profile. The heroes section shows meta, trends, lanes, popularity, win rate, game impact and economy, while the items section covers the most used items and their impact. The esports section includes clips, series, scores, leagues, players, teams and matches. There are verified players, a ranked leaderboard, achievements, and live and recent matches. The blog publishes role and patch breakdowns. Advanced features are available with a Dotabuff Plus subscription.', 'Профіль гравця через Steam
Мета й тренди героїв
Статистика предметів
Кіберспортивні матчі, команди й ліги
Таблиця лідерів
Підписка Dotabuff Plus', 'Player profile via Steam
Hero meta and trends
Item stats
Esports matches, teams and leagues
Ranked leaderboard
Dotabuff Plus subscription', 'Гравці Dota 2 та уболівальники її кіберспортивної сцени.', 'Dota 2 players and fans of its esports scene.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dotabuff.com' OR LOWER(`name`) = LOWER('Dotabuff')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Dotabuff provides Dota 2 statistics: player profiles via Steam sign-in, hero and item meta, trends, leaderboards, esports matches, teams and leagues, and analytical articles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Dotabuff is one of the leading Dota 2 stats sites. After signing in with Steam you can see your Dota 2 profile. The heroes section shows meta, trends, lanes, popularity, win rate, game impact and economy, while the items section covers the most used items and their impact. The esports section includes clips, series, scores, leagues, players, teams and matches. There are verified players, a ranked leaderboard, achievements, and live and recent matches. The blog publishes role and patch breakdowns. Advanced features are available with a Dotabuff Plus subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Player profile via Steam
Hero meta and trends
Item stats
Esports matches, teams and leagues
Ranked leaderboard
Dotabuff Plus subscription', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dota 2 players and fans of its esports scene.', 'manual' FROM DUAL WHERE @new = 1;

-- Dustloop Wiki — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dustloop.com' OR LOWER(`name`) = LOWER('Dustloop Wiki'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dustloop Wiki', NULL, 'https://www.dustloop.com', NULL, NULL, 'Dustloop Wiki — спільнотний інформаційний центр файтингів Arc System Works: Guilty Gear -Strive-, Dragon Ball FighterZ, Granblue Fantasy Versus: Rising, BlazBlue та інших, із фрейм-даними й сторінками персонажів.', 'Dustloop Wiki is the community information hub for Arc System Works fighting games: Guilty Gear -Strive-, Dragon Ball FighterZ, Granblue Fantasy Versus: Rising, BlazBlue and more, with frame data and character pages.', 'Dustloop — вікі, яку веде спільнота гравців файтингів Arc System Works. Тут зібрано сторінки ігор Guilty Gear -Strive-, Dragon Ball FighterZ, Granblue Fantasy Versus: Rising, BlazBlue: Central Fiction, BlazBlue Cross Tag Battle, DNF Duel, Guilty Gear Xrd та інших. Для кожної гри є сторінки персонажів і системних механік, фрейм-дані, пояснення нотації та загальні теми. Редактори мають інструкції з оформлення сторінок, зображень, відео й фрейм-даних, а спільнота спілкується в Discord.', 'Dustloop is a wiki run by the community of Arc System Works fighting game players. It covers Guilty Gear -Strive-, Dragon Ball FighterZ, Granblue Fantasy Versus: Rising, BlazBlue: Central Fiction, BlazBlue Cross Tag Battle, DNF Duel, Guilty Gear Xrd and more. Each game has character and system mechanics pages, frame data, notation explanations and general topics. Editors get guides on writing pages, images, videos and frame data, and the community chats on Discord.', 'Вікі файтингів Arc System Works
Сторінки персонажів і механік
Фрейм-дані
Пояснення нотації
Спільнота в Discord', 'Arc System Works fighting game wiki
Character and mechanics pages
Frame data
Notation guide
Discord community', 'Гравці Guilty Gear, Dragon Ball FighterZ, Granblue та інших файтингів ArcSys.', 'Players of Guilty Gear, Dragon Ball FighterZ, Granblue and other ArcSys fighters.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dustloop.com' OR LOWER(`name`) = LOWER('Dustloop Wiki')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Dustloop Wiki is the community information hub for Arc System Works fighting games: Guilty Gear -Strive-, Dragon Ball FighterZ, Granblue Fantasy Versus: Rising, BlazBlue and more, with frame data and character pages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Dustloop is a wiki run by the community of Arc System Works fighting game players. It covers Guilty Gear -Strive-, Dragon Ball FighterZ, Granblue Fantasy Versus: Rising, BlazBlue: Central Fiction, BlazBlue Cross Tag Battle, DNF Duel, Guilty Gear Xrd and more. Each game has character and system mechanics pages, frame data, notation explanations and general topics. Editors get guides on writing pages, images, videos and frame data, and the community chats on Discord.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Arc System Works fighting game wiki
Character and mechanics pages
Frame data
Notation guide
Discord community', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Players of Guilty Gear, Dragon Ball FighterZ, Granblue and other ArcSys fighters.', 'manual' FROM DUAL WHERE @new = 1;

-- Eklipse — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eklipse.gg' OR LOWER(`name`) = LOWER('Eklipse'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eklipse', NULL, 'https://eklipse.gg', NULL, NULL, 'Eklipse — AI-генератор кліпів для геймерів і стримерів: автоматично знаходить найкращі моменти стримів на Twitch, Kick і YouTube, перетворює їх на TikTok-ролики, додає меми й публікує в соцмережах.', 'Eklipse is an AI clip maker for gamers and streamers: it automatically finds the best moments in Twitch, Kick and YouTube streams, turns them into TikToks, adds memes and publishes to social media.', 'Eklipse автоматично нарізає найкращі ігрові моменти зі стримів на Twitch, Kick і YouTube без ручного монтажу. Безкоштовні функції включають миттєві хайлайти стримів і подкастів, Eklipse Studio для перетворення хайлайтів на TikTok, планувальник публікацій, голосові команди для AI, AI-Edit з мемами, мобільний застосунок і підтримку стримів із консолей; Ultra Highlights зберігає моменти до 1440p. Преміум додає професійний монтаж і підтримку Kick. Сервіс підтримує понад 3000 ігор — від Call of Duty, Fortnite і Valorant до League of Legends і Roblox.', 'Eklipse automatically clips your best gaming moments from Twitch, Kick and YouTube streams with no manual editing. Free features include instant stream and podcast highlights, Eklipse Studio to turn highlights into TikToks, a content publisher, voice commands for the AI, AI-Edit with memes, a mobile app and console stream support; Ultra Highlights captures moments in up to 1440p. Premium adds pro edits and Kick support. It supports over 3,000 games, from Call of Duty, Fortnite and Valorant to League of Legends and Roblox.', 'AI-хайлайти стримів
Twitch, Kick і YouTube
Конвертація в TikTok
AI-Edit з мемами
Планувальник публікацій
3000+ ігор', 'AI stream highlights
Twitch, Kick and YouTube
Conversion to TikTok
AI-Edit with memes
Content publisher
3,000+ games', 'Стримери, які хочуть контент для соцмереж без монтажу.', 'Streamers who want social content without editing.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eklipse.gg' OR LOWER(`name`) = LOWER('Eklipse')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Eklipse is an AI clip maker for gamers and streamers: it automatically finds the best moments in Twitch, Kick and YouTube streams, turns them into TikToks, adds memes and publishes to social media.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Eklipse automatically clips your best gaming moments from Twitch, Kick and YouTube streams with no manual editing. Free features include instant stream and podcast highlights, Eklipse Studio to turn highlights into TikToks, a content publisher, voice commands for the AI, AI-Edit with memes, a mobile app and console stream support; Ultra Highlights captures moments in up to 1440p. Premium adds pro edits and Kick support. It supports over 3,000 games, from Call of Duty, Fortnite and Valorant to League of Legends and Roblox.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI stream highlights
Twitch, Kick and YouTube
Conversion to TikTok
AI-Edit with memes
Content publisher
3,000+ games', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Streamers who want social content without editing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базові AI-хайлайти', 'Basic AI highlights' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic AI highlights', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Elgato Stream Deck — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'elgato.com/us/en/s/downloads' OR LOWER(`name`) = LOWER('Elgato Stream Deck'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Elgato Stream Deck', NULL, 'https://www.elgato.com/us/en/s/downloads', NULL, NULL, 'Elgato Stream Deck — програма для пристроїв Stream Deck, віртуального Stream Deck і мобільного застосунку: гарячі клавіші й плагіни для стримінгу та ігор, ігрові профілі й Smart Profiles.', 'Elgato Stream Deck is software for Stream Deck devices, Virtual Stream Deck and the mobile app: hotkeys and plugins for streaming and gaming, game profiles and Smart Profiles.', 'Програма Stream Deck від Elgato керує пристроями Stream Deck (Mini, Classic, XL, Neo, +, Pedal та іншими), віртуальним Stream Deck і мобільним застосунком. Кожна клавіша може надсилати гарячі клавіші або працювати через плагіни, тож Stream Deck спрощує стримінг, монтаж, дизайн і роботу майже в будь-якій програмі. Для ігор можна додати гарячі клавіші, зібрати профілі для різних ігор і використовувати Smart Profiles, що самі перемикають розкладку між іграми. Іконки й набори доступні в Elgato Marketplace. На сторінці завантажень також є Wave Link, Camera Hub, Control Center та інший софт Elgato.', 'Elgato''s Stream Deck software controls Stream Deck devices (Mini, Classic, XL, Neo, +, Pedal and more), the Virtual Stream Deck and the mobile app. Each key can send hotkeys or run plugins, so Stream Deck streamlines streaming, editing, design and work in almost any app. For gaming you can add hotkeys, build per-game profiles and use Smart Profiles that switch layouts automatically between games. Icons and packs are available in the Elgato Marketplace. The downloads page also offers Wave Link, Camera Hub, Control Center and other Elgato software.', 'Гарячі клавіші й плагіни
Ігрові профілі й Smart Profiles
Віртуальний і мобільний Stream Deck
Icon packs в Elgato Marketplace
Керування стримом', 'Hotkeys and plugins
Game profiles and Smart Profiles
Virtual and mobile Stream Deck
Icon packs in Elgato Marketplace
Stream control', 'Стримери й геймери з пристроями Elgato.', 'Streamers and gamers with Elgato gear.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'elgato.com/us/en/s/downloads' OR LOWER(`name`) = LOWER('Elgato Stream Deck')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Elgato Stream Deck is software for Stream Deck devices, Virtual Stream Deck and the mobile app: hotkeys and plugins for streaming and gaming, game profiles and Smart Profiles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Elgato''s Stream Deck software controls Stream Deck devices (Mini, Classic, XL, Neo, +, Pedal and more), the Virtual Stream Deck and the mobile app. Each key can send hotkeys or run plugins, so Stream Deck streamlines streaming, editing, design and work in almost any app. For gaming you can add hotkeys, build per-game profiles and use Smart Profiles that switch layouts automatically between games. Icons and packs are available in the Elgato Marketplace. The downloads page also offers Wave Link, Camera Hub, Control Center and other Elgato software.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hotkeys and plugins
Game profiles and Smart Profiles
Virtual and mobile Stream Deck
Icon packs in Elgato Marketplace
Stream control', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Streamers and gamers with Elgato gear.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Програма для пристроїв Elgato', 'Software for Elgato devices' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Software for Elgato devices', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Esports Charts — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'escharts.com' OR LOWER(`name`) = LOWER('Esports Charts'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Esports Charts', NULL, 'https://escharts.com', NULL, NULL, 'Esports Charts — аналітика глядацької аудиторії та популярності кіберспорту: пікові й сумарні перегляди турнірів, дані про команди, гравців, організаторів і стримінгові платформи, заробітки й рекорди.', 'Esports Charts analyses esports viewership and popularity: peak and total tournament viewership, data on teams, players, organizers and streaming platforms, earnings and records.', 'Esports Charts відстежує глядацьку аудиторію, популярність і аналітику кіберспорту. Сайт показує поточні, рекомендовані й майбутні турніри та серії подій з дисциплін League of Legends, Dota 2, Counter-Strike, Mobile Legends: Bang Bang, PUBG Mobile, Valorant та інших. Розділи охоплюють організації, команди, гравців, організаторів, стримінгові платформи, матчі, кіберспортивну карту, магазини мерчу й рекорди, а інструменти — заробітки та дані кіберспорту. Новини аналізують пікові перегляди й час перегляду великих турнірів.', 'Esports Charts tracks esports viewership, popularity and analytics. It shows ongoing, featured and upcoming tournaments and event series across League of Legends, Dota 2, Counter-Strike, Mobile Legends: Bang Bang, PUBG Mobile, Valorant and more. Sections cover organizations, teams, players, organizers, streaming platforms, matches, an esports map, team merch stores and records, and tools include earnings and esports data. News analyses peak viewership and watch time of major events.', 'Пікові й сумарні перегляди турнірів
Дані про команди й гравців
Стримінгові платформи й організатори
Заробітки й рекорди
Аналітичні новини', 'Peak and total tournament viewership
Team and player data
Streaming platforms and organizers
Earnings and records
Analytical news', 'Кіберспортивні організації, бренди, журналісти й аналітики.', 'Esports organizations, brands, journalists and analysts.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'escharts.com' OR LOWER(`name`) = LOWER('Esports Charts')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Esports Charts analyses esports viewership and popularity: peak and total tournament viewership, data on teams, players, organizers and streaming platforms, earnings and records.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Esports Charts tracks esports viewership, popularity and analytics. It shows ongoing, featured and upcoming tournaments and event series across League of Legends, Dota 2, Counter-Strike, Mobile Legends: Bang Bang, PUBG Mobile, Valorant and more. Sections cover organizations, teams, players, organizers, streaming platforms, matches, an esports map, team merch stores and records, and tools include earnings and esports data. News analyses peak viewership and watch time of major events.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Peak and total tournament viewership
Team and player data
Streaming platforms and organizers
Earnings and records
Analytical news', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Esports organizations, brands, journalists and analysts.', 'manual' FROM DUAL WHERE @new = 1;

-- Esports Earnings — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'esportsearnings.com' OR LOWER(`name`) = LOWER('Esports Earnings'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Esports Earnings', NULL, 'https://www.esportsearnings.com', NULL, NULL, 'Esports Earnings — спільнотна база призових кіберспорту: заробітки гравців і команд, підсумки за іграми, країнами й лігами, історія та результати турнірів на основі відкритих даних.', 'Esports Earnings is a community-driven esports prize money database: player and team earnings, totals by game, country and league, history and tournament results from public data.', 'Esports Earnings — ресурс спільноти, що збирає відкриту інформацію про призові змагального геймінгу. Ігри впорядковано за загальною сумою виданих призів із кількістю турнірів і найбільш заробітними гравцями кожної гри. Розділи охоплюють історію, гравців, країни, турніри, команди, ліги та ігри, а також нещодавні турніри з призовими. Точність даних залежить від внесків користувачів, тож допомога спільноти завжди вітається.', 'Esports Earnings is a community resource collecting public information on competitive gaming prize money. Games are ordered by total prizes awarded, with tournament counts and the top earners in each game. Sections cover history, players, countries, tournaments, teams, leagues and games, plus recent tournaments with prize amounts. Data accuracy depends on user contributions, so community help is always welcome.', 'Призові за іграми
Заробітки гравців і команд
Статистика за країнами й лігами
Історія й результати турнірів
Дані від спільноти', 'Prize money by game
Player and team earnings
Stats by country and league
Tournament history and results
Community-sourced data', 'Уболівальники, журналісти й дослідники кіберспорту.', 'Esports fans, journalists and researchers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'esportsearnings.com' OR LOWER(`name`) = LOWER('Esports Earnings')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Esports Earnings is a community-driven esports prize money database: player and team earnings, totals by game, country and league, history and tournament results from public data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Esports Earnings is a community resource collecting public information on competitive gaming prize money. Games are ordered by total prizes awarded, with tournament counts and the top earners in each game. Sections cover history, players, countries, tournaments, teams, leagues and games, plus recent tournaments with prize amounts. Data accuracy depends on user contributions, so community help is always welcome.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Prize money by game
Player and team earnings
Stats by country and league
Tournament history and results
Community-sourced data', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Esports fans, journalists and researchers.', 'manual' FROM DUAL WHERE @new = 1;

-- ExitLag — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'exitlag.com' OR LOWER(`name`) = LOWER('ExitLag'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ExitLag', NULL, 'https://www.exitlag.com', NULL, NULL, 'ExitLag — сервіс зменшення лагів і покращення з''єднання в онлайн-іграх для Windows, Android та iOS: оптимізовані маршрути, тест пінгу для популярних ігор і рішення для провайдерів та спільнот.', 'ExitLag reduces lag and improves game connections on Windows, Android and iOS: optimized routes, a ping test for popular games, and solutions for ISPs and communities.', 'ExitLag допомагає зменшити лаги й покращити з''єднання в онлайн-іграх. Сервіс доступний для Windows, а також для Android та iOS. Новий тест пінгу показує результати для улюблених ігор. Для бізнесу є рішення для інтернет-провайдерів, що хочуть вийти на ігровий ринок, і Community Network для приватних серверів, хостингів і ігрових спільнот. Є довідковий центр, Discord-спільнота й партнерська програма; доступ надається за підпискою.', 'ExitLag helps reduce lag and improve your connection in online games. It is available for Windows, Android and iOS. A new ping test shows results for your favourite games. For business there are solutions for ISPs entering the gaming market and a Community Network for private servers, hosting companies and gaming communities. There is a help center, a Discord community and an affiliate program; access is subscription-based.', 'Зменшення лагів і пінгу
Windows, Android та iOS
Тест пінгу для ігор
Рішення для провайдерів
Community Network для серверів', 'Lower lag and ping
Windows, Android and iOS
Game ping test
ISP solutions
Community Network for servers', 'Онлайн-гравці з нестабільним з''єднанням.', 'Online players with unstable connections.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'exitlag.com' OR LOWER(`name`) = LOWER('ExitLag')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ExitLag reduces lag and improves game connections on Windows, Android and iOS: optimized routes, a ping test for popular games, and solutions for ISPs and communities.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ExitLag helps reduce lag and improve your connection in online games. It is available for Windows, Android and iOS. A new ping test shows results for your favourite games. For business there are solutions for ISPs entering the gaming market and a Community Network for private servers, hosting companies and gaming communities. There is a help center, a Discord community and an affiliate program; access is subscription-based.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Lower lag and ping
Windows, Android and iOS
Game ping test
ISP solutions
Community Network for servers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Online players with unstable connections.', 'manual' FROM DUAL WHERE @new = 1;

-- FACEIT — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'faceit.com' OR LOWER(`name`) = LOWER('FACEIT'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'FACEIT', NULL, 'https://www.faceit.com', NULL, NULL, 'FACEIT — платформа змагальної гри для CS2, Overwatch та інших ігор: матчмейкінг із рівнями майстерності, власний античит, турніри й ліги, призи та спільнота понад 34 млн гравців.', 'FACEIT is a competitive gaming platform for CS2, Overwatch and other titles: skill-level matchmaking, its own anti-cheat, tournaments and leagues, prizes and a community of 34M+ players.', 'FACEIT пропонує підвищити свій рівень гри, вигравати реальні призи й стати частиною спільноти з понад 34 мільйонів серйозних гравців. Платформа підтримує CS2, Overwatch та інші змагальні ігри; на ній одночасно сотні тисяч гравців онлайн і тисячі живих матчів, а загальна сума виданих нагород перевищує $10 млн. Матчмейкінг будується на рівнях майстерності, а власний античит FACEIT захищає матчі від нечесної гри. Для участі потрібен клієнт для ПК. Новачки в Counter-Strike теж можуть грати на FACEIT.', 'FACEIT invites you to level up your game, win real prizes and join a community of over 34 million serious gamers. It supports CS2, Overwatch and other competitive titles, with hundreds of thousands of players online and thousands of live matches at a time, and more than $10 million in rewards paid out. Matchmaking is based on skill levels, and FACEIT''s own anti-cheat protects matches from cheating. A PC client is required to play. Players new to Counter-Strike can also play on FACEIT.', 'Матчмейкінг за рівнями майстерності
Власний античит FACEIT
CS2, Overwatch та інші ігри
Турніри, ліги й призи
Спільнота 34+ млн гравців
Клієнт для ПК', 'Skill-level matchmaking
FACEIT anti-cheat
CS2, Overwatch and more
Tournaments, leagues and prizes
Community of 34M+ players
PC client', 'Гравці CS2 та інших змагальних ігор, які хочуть чесних матчів свого рівня.', 'CS2 and other competitive players who want fair games at their level.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'faceit.com' OR LOWER(`name`) = LOWER('FACEIT')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'FACEIT is a competitive gaming platform for CS2, Overwatch and other titles: skill-level matchmaking, its own anti-cheat, tournaments and leagues, prizes and a community of 34M+ players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'FACEIT invites you to level up your game, win real prizes and join a community of over 34 million serious gamers. It supports CS2, Overwatch and other competitive titles, with hundreds of thousands of players online and thousands of live matches at a time, and more than $10 million in rewards paid out. Matchmaking is based on skill levels, and FACEIT''s own anti-cheat protects matches from cheating. A PC client is required to play. Players new to Counter-Strike can also play on FACEIT.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Skill-level matchmaking
FACEIT anti-cheat
CS2, Overwatch and more
Tournaments, leagues and prizes
Community of 34M+ players
PC client', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'CS2 and other competitive players who want fair games at their level.', 'manual' FROM DUAL WHERE @new = 1;

-- FACEIT Analyser — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'faceitanalyser.com' OR LOWER(`name`) = LOWER('FACEIT Analyser'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'FACEIT Analyser', NULL, 'https://faceitanalyser.com', NULL, NULL, 'FACEIT Analyser — аналітика гравців і матчів FACEIT у CS2: пошук гравця, аналіз матчу, «Чи грали ми разом», порівняння, клуби, глобальна статистика, таблиці лідерів і міні-ігри про профі.', 'FACEIT Analyser provides FACEIT player and match analytics for CS2: player finder, match analyser, ''Have We Met'', comparisons, clubs, global stats, leaderboards and pro trivia mini-games.', 'FACEIT Analyser аналізує статистику гравців і матчів на FACEIT. Знайти гравця можна за ніком, адресою FACEIT чи Steam, а якщо додати «fan» до будь-якої адреси FACEIT або Steam, аналіз відкриється миттєво. Аналізатор матчів розбирає окремі ігри, функція «Have We Met» показує, чи грали ви з певним гравцем, а порівняння й клуби допомагають оцінити команду. Глобальна статистика включає таблиці лідерів і розподіл рангів, а міні-ігри — вгадування професіоналів і вікторини. Для розробників є документація API.', 'FACEIT Analyser analyses FACEIT player and match stats. Find a player by nickname, FACEIT URL or Steam URL, and adding ''fan'' to any FACEIT or Steam URL opens the analysis instantly. The match analyser breaks down individual games, ''Have We Met'' shows whether you played with a given player, and comparisons and clubs help assess a team. Global stats include leaderboards and rank distribution, and mini-games include pro guessers and trivia. Developers get API docs.', 'Аналіз гравців і матчів FACEIT
Миттєвий аналіз за адресою
«Чи грали ми разом»
Порівняння й клуби
Таблиці лідерів і розподіл рангів
API', 'FACEIT player and match analysis
Instant analysis by URL
Have We Met
Comparisons and clubs
Leaderboards and rank distribution
API', 'Гравці CS2 на FACEIT.', 'CS2 players on FACEIT.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'faceitanalyser.com' OR LOWER(`name`) = LOWER('FACEIT Analyser')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'FACEIT Analyser provides FACEIT player and match analytics for CS2: player finder, match analyser, ''Have We Met'', comparisons, clubs, global stats, leaderboards and pro trivia mini-games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'FACEIT Analyser analyses FACEIT player and match stats. Find a player by nickname, FACEIT URL or Steam URL, and adding ''fan'' to any FACEIT or Steam URL opens the analysis instantly. The match analyser breaks down individual games, ''Have We Met'' shows whether you played with a given player, and comparisons and clubs help assess a team. Global stats include leaderboards and rank distribution, and mini-games include pro guessers and trivia. Developers get API docs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'FACEIT player and match analysis
Instant analysis by URL
Have We Met
Comparisons and clubs
Leaderboards and rank distribution
API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'CS2 players on FACEIT.', 'manual' FROM DUAL WHERE @new = 1;

-- Fightcade — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fightcade.com' OR LOWER(`name`) = LOWER('Fightcade'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fightcade', NULL, 'https://www.fightcade.com', NULL, NULL, 'Fightcade — безкоштовний застосунок матчмейкінгу для ретро-файтингів онлайн з емуляторами й власною реалізацією GGPO: rollback-нетплей майже без відчутної затримки, повтори; Windows, macOS і Linux.', 'Fightcade is a free matchmaking app for playing retro fighting games online with bundled emulators and a custom GGPO implementation: rollback netplay with barely perceivable lag and replays, on Windows, macOS and Linux.', 'Fightcade — найзручніший спосіб грати в ретро-ігри онлайн. Це застосунок матчмейкінгу з комплектом емуляторів для безшовної онлайн-гри, безкоштовний і без реклами. Власна реалізація GGPO та покращення емуляторів роблять його платформою для rollback-нетплею P2P, тож навіть вимогливі до затримки й відгуку файтинги можна грати через інтернет майже без відчутного лагу. Є повтори, спільнота й підтримка через Patreon із додатковими функціями. Доступний для Windows 7–11, macOS 10.13+ і Linux.', 'Fightcade is the best way to play retro games online. It is a matchmaking app bundled with emulators for seamless online play, free and without ads. A custom GGPO implementation and emulator improvements make it a platform for rollback-based P2P netplay, so even demanding fighting games can be played over the internet with very little perceivable lag. There are replays, a community and Patreon support with extra features. It runs on Windows 7–11, macOS 10.13+ and Linux.', 'Матчмейкінг ретро-файтингів
Rollback-нетплей GGPO
Вбудовані емулятори
Повтори
Windows, macOS і Linux
Без реклами', 'Retro fighting game matchmaking
GGPO rollback netplay
Bundled emulators
Replays
Windows, macOS and Linux
No ads', 'Гравці класичних файтингів.', 'Classic fighting game players.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fightcade.com' OR LOWER(`name`) = LOWER('Fightcade')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fightcade is a free matchmaking app for playing retro fighting games online with bundled emulators and a custom GGPO implementation: rollback netplay with barely perceivable lag and replays, on Windows, macOS and Linux.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Fightcade is the best way to play retro games online. It is a matchmaking app bundled with emulators for seamless online play, free and without ads. A custom GGPO implementation and emulator improvements make it a platform for rollback-based P2P netplay, so even demanding fighting games can be played over the internet with very little perceivable lag. There are replays, a community and Patreon support with extra features. It runs on Windows 7–11, macOS 10.13+ and Linux.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Retro fighting game matchmaking
GGPO rollback netplay
Bundled emulators
Replays
Windows, macOS and Linux
No ads', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Classic fighting game players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Без реклами', 'No ads' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'No ads', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Firebot — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'firebot.app' OR LOWER(`name`) = LOWER('Firebot'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Firebot', NULL, 'https://firebot.app', NULL, NULL, 'Firebot — безкоштовний універсальний бот для Twitch-стримерів із відкритим кодом: сучасний інтерфейс і система ефектів, що дозволяє запрограмувати бота майже на що завгодно без коду.', 'Firebot is a free, open-source all-in-one bot for Twitch streamers: a modern interface and an effects system that lets you program the bot to do almost anything without code.', 'Firebot — повнофункціональний бот із відкритим кодом, що допомагає вивести стрими на новий рівень. Він створений із фокусом на зручність: інтерфейс інтуїтивний і гарний водночас. Основа бота — проста, але потужна система ефектів, яка дозволяє налаштувати його майже на будь-яку дію без знання програмування. Firebot безкоштовний, має код на GitHub, спільноту в Discord, довідку й відповіді на часті запитання.', 'Firebot is a fully featured open-source bot that helps level up your streams. It was built with usability in mind, with an interface that is both intuitive and beautiful. At its core is a simple yet powerful effects system that lets you program the bot to do just about anything with no programming knowledge. Firebot is free, with code on GitHub, a Discord community, help docs and an FAQ.', 'Універсальний бот для Twitch
Система ефектів без коду
Сучасний інтерфейс
Відкритий код
Безкоштовно', 'All-in-one Twitch bot
No-code effects system
Modern interface
Open source
Free', 'Стримери на Twitch.', 'Twitch streamers.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'firebot.app' OR LOWER(`name`) = LOWER('Firebot')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Firebot is a free, open-source all-in-one bot for Twitch streamers: a modern interface and an effects system that lets you program the bot to do almost anything without code.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Firebot is a fully featured open-source bot that helps level up your streams. It was built with usability in mind, with an interface that is both intuitive and beautiful. At its core is a simple yet powerful effects system that lets you program the bot to do just about anything with no programming knowledge. Firebot is free, with code on GitHub, a Discord community, help docs and an FAQ.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'All-in-one Twitch bot
No-code effects system
Modern interface
Open source
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Twitch streamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий код', 'Open source' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Firestone — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'firestoneapp.com' OR LOWER(`name`) = LOWER('Firestone'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Firestone', NULL, 'https://www.firestoneapp.com', NULL, NULL, 'Firestone — застосунок і сайт статистики Hearthstone: Battlegrounds, Arena й Constructed, статистика героїв і складів за рангами, мета-колоди та Premium.', 'Firestone is a Hearthstone app and stats site: Battlegrounds, Arena and Constructed, hero and comp stats by rank, meta decks and Premium.', 'Firestone показує статистику й мета-інсайти Hearthstone для режимів Battlegrounds, Arena і Constructed. Для Battlegrounds є таблиці героїв із середнім місцем, частотою вибору, розподілом місць і кількістю ігор, розбиті за тірами, а також склади й карти — дані оновлюються кожні кілька годин на основі сотень тисяч ігор. Для Arena доступна статистика класів і карт, для Constructed — мета-колоди. Фільтри дозволяють обрати патч і ранг. Firestone також є застосунком для гри, а Premium відкриває додаткові можливості.', 'Firestone shows Hearthstone stats and meta insights for Battlegrounds, Arena and Constructed. For Battlegrounds it lists heroes by tier with average placement, pick rate, placement distribution and game counts, plus comps and cards, refreshed every few hours from hundreds of thousands of games. Arena has class and card stats, and Constructed has meta decks. Filters let you choose patch and rank. Firestone is also an in-game app, and Premium unlocks extra features.', 'Статистика героїв Battlegrounds
Склади й карти
Arena: класи й карти
Мета-колоди Constructed
Фільтри за патчем і рангом
Застосунок для гри', 'Battlegrounds hero stats
Comps and cards
Arena classes and cards
Constructed meta decks
Patch and rank filters
In-game app', 'Гравці Hearthstone, особливо в Battlegrounds.', 'Hearthstone players, especially in Battlegrounds.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'firestoneapp.com' OR LOWER(`name`) = LOWER('Firestone')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Firestone is a Hearthstone app and stats site: Battlegrounds, Arena and Constructed, hero and comp stats by rank, meta decks and Premium.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Firestone shows Hearthstone stats and meta insights for Battlegrounds, Arena and Constructed. For Battlegrounds it lists heroes by tier with average placement, pick rate, placement distribution and game counts, plus comps and cards, refreshed every few hours from hundreds of thousands of games. Arena has class and card stats, and Constructed has meta decks. Filters let you choose patch and rank. Firestone is also an in-game app, and Premium unlocks extra features.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Battlegrounds hero stats
Comps and cards
Arena classes and cards
Constructed meta decks
Patch and rank filters
In-game app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Hearthstone players, especially in Battlegrounds.', 'manual' FROM DUAL WHERE @new = 1;

-- Fortnite Tracker — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fortnitetracker.com' OR LOWER(`name`) = LOWER('Fortnite Tracker'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fortnite Tracker', NULL, 'https://fortnitetracker.com', NULL, NULL, 'Fortnite Tracker — статистика гравців Fortnite від Tracker Network: пошук за нікнеймом, PSN чи Epic, таблиці лідерів, Power Rank, події, кіберспорт, магазин предметів і пошук команди.', 'Fortnite Tracker is Tracker Network''s Fortnite stats site: search by gamertag, PSN or Epic account, leaderboards, Power Rank, events, esports, item shop and team finder.', 'Fortnite Tracker допомагає знайти статистику Fortnite за нікнеймом, PSN чи ID акаунта або після входу через Epic Games; сервіс відстежує понад 100 мільйонів гравців. Є таблиці лідерів — Power Rank за регіонами, перемоги в сезоні, рейтингові ігри — а також розділи подій і кіберспорту з новинами про FNCS, пошук команди (LFP), магазин предметів і Creative. Сайт входить у Tracker Network, тож підписка Premium прибирає рекламу й додає налаштування профілю. Є мобільні застосунки.', 'Fortnite Tracker finds Fortnite stats by gamertag, PSN or account ID, or after signing in with Epic Games, and tracks over 100 million players. There are leaderboards (regional Power Rank, season wins, ranked), events and esports sections with FNCS news, looking for players (LFP), the item shop and Creative. The site is part of Tracker Network, so Premium removes ads and adds profile customization. Mobile apps are available.', 'Статистика за нікнеймом чи акаунтом Epic
Таблиці лідерів і Power Rank
Події й кіберспорт FNCS
Пошук команди (LFP)
Магазин предметів
Мобільні застосунки', 'Stats by gamertag or Epic account
Leaderboards and Power Rank
Events and FNCS esports
Looking for players (LFP)
Item shop
Mobile apps', 'Гравці Fortnite, зокрема ті, хто грає в турнірах.', 'Fortnite players, including tournament players.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fortnitetracker.com' OR LOWER(`name`) = LOWER('Fortnite Tracker')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fortnite Tracker is Tracker Network''s Fortnite stats site: search by gamertag, PSN or Epic account, leaderboards, Power Rank, events, esports, item shop and team finder.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Fortnite Tracker finds Fortnite stats by gamertag, PSN or account ID, or after signing in with Epic Games, and tracks over 100 million players. There are leaderboards (regional Power Rank, season wins, ranked), events and esports sections with FNCS news, looking for players (LFP), the item shop and Creative. The site is part of Tracker Network, so Premium removes ads and adds profile customization. Mobile apps are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Stats by gamertag or Epic account
Leaderboards and Power Rank
Events and FNCS esports
Looking for players (LFP)
Item shop
Mobile apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Fortnite players, including tournament players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Статистика з рекламою', 'Stats with ads' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Stats with ads', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium Monthly', 'Premium Monthly', 3.99, 'month', 'Premium Tracker Network: без реклами', 'Tracker Network Premium: no ads' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium Monthly' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium Monthly', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Tracker Network Premium: no ads', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Fortnite.GG — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fortnite.gg' OR LOWER(`name`) = LOWER('Fortnite.GG'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fortnite.GG', NULL, 'https://fortnite.gg', NULL, NULL, 'Fortnite.GG — інтерактивна карта Fortnite з усіма точками появи й завданнями, магазин предметів, косметика, витоки, статистика режимів, кількість гравців у Creative, гайди зі зброї та калькулятор досвіду.', 'Fortnite.GG is an interactive Fortnite map with all spawns and quests, plus the item shop, cosmetics, leaks, mode stats, Creative player counts, weapon guides and an XP calculator.', 'Fortnite.GG зібрав в одному місці інтерактивну карту з усіма точками появи предметів і щотижневими завданнями, еволюцію й ротацію карти. Розділ магазину й косметики показує поточний магазин, список бажаного, шафку, витоки, найпопулярніші й безкоштовні предмети. Статистика охоплює режими Battle Royale, Blitz, OG, Reload, рейтингові ігри, Arenas і Boxfights. Для Creative є кількість гравців, автори й добірки, а також рейтинги косметики, гайди зі зброї, калькулятор досвіду, книга лору й зворотний відлік сезону. Сайт перекладено багатьма мовами, є преміум-версія.', 'Fortnite.GG brings together an interactive map with all item spawns and weekly quests, plus map evolution and rotation. The shop and cosmetics sections show the current item shop, wishlist, locker, leaks, most used and free cosmetics. Stats cover Battle Royale, Blitz, OG, Reload, Ranked, Arenas and Boxfights. For Creative there are player counts, creators and collections, plus cosmetic rankings, weapon guides, an XP calculator, a lorebook and a season countdown. The site is translated into many languages and has a premium version.', 'Інтерактивна карта з точками появи й завданнями
Магазин предметів і витоки
Статистика режимів і рейтингових ігор
Кількість гравців у Creative
Калькулятор досвіду й гайди зі зброї', 'Interactive map with spawns and quests
Item shop and leaks
Mode and ranked stats
Creative player counts
XP calculator and weapon guides', 'Гравці Fortnite будь-якого рівня.', 'Fortnite players of any level.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fortnite.gg' OR LOWER(`name`) = LOWER('Fortnite.GG')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fortnite.GG is an interactive Fortnite map with all spawns and quests, plus the item shop, cosmetics, leaks, mode stats, Creative player counts, weapon guides and an XP calculator.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Fortnite.GG brings together an interactive map with all item spawns and weekly quests, plus map evolution and rotation. The shop and cosmetics sections show the current item shop, wishlist, locker, leaks, most used and free cosmetics. Stats cover Battle Royale, Blitz, OG, Reload, Ranked, Arenas and Boxfights. For Creative there are player counts, creators and collections, plus cosmetic rankings, weapon guides, an XP calculator, a lorebook and a season countdown. The site is translated into many languages and has a premium version.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Interactive map with spawns and quests
Item shop and leaks
Mode and ranked stats
Creative player counts
XP calculator and weapon guides', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Fortnite players of any level.', 'manual' FROM DUAL WHERE @new = 1;

-- Fossabot — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fossabot.com' OR LOWER(`name`) = LOWER('Fossabot'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fossabot', NULL, 'https://fossabot.com', NULL, NULL, 'Fossabot — безкоштовний хмарний чат-бот для Twitch, YouTube, Kick і X: прибирає спам, відповідає на команди, має спільну панель для команди модераторів і журнал змін. Налаштування — за дві хвилини.', 'Fossabot is a free cloud chatbot for Twitch, YouTube, Kick and X: it removes spam, answers commands and offers a shared dashboard for your mod team with audit logs. Set up in two minutes.', 'Fossabot — чат-бот, що прибирає спам, відповідає на команди й тримає спільноту в рамках. Він безкоштовний, працює в хмарі й налаштовується за дві хвилини; підтримує Twitch, YouTube, Kick і X. Одна панель для стримера й усієї команди модераторів: зміни одразу бачать усі, а кожна дія потрапляє в журнал аудиту. Команди автоматизують повторювані повідомлення, а спам-фільтри самі обробляють посилання, капс, символи й повтори. Серед користувачів — відомі стримери, наприклад Sodapoppin і Fuslie.', 'Fossabot is a chatbot that removes spam, answers commands and keeps your community in check. It is free, cloud-hosted and set up in two minutes, supporting Twitch, YouTube, Kick and X. One dashboard serves the streamer and the whole mod team: changes show up for everyone instantly, and each action lands in the audit log. Commands automate repetitive messages, and spam filters handle links, caps, symbols and repetition on their own. Users include well-known streamers such as Sodapoppin and Fuslie.', 'Twitch, YouTube, Kick і X
Спам-фільтри
Команди чату
Спільна панель модераторів
Журнал аудиту
Хмарний і безкоштовний', 'Twitch, YouTube, Kick and X
Spam filters
Chat commands
Shared mod dashboard
Audit logs
Cloud-hosted and free', 'Стримери та їхні команди модераторів.', 'Streamers and their mod teams.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fossabot.com' OR LOWER(`name`) = LOWER('Fossabot')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fossabot is a free cloud chatbot for Twitch, YouTube, Kick and X: it removes spam, answers commands and offers a shared dashboard for your mod team with audit logs. Set up in two minutes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Fossabot is a chatbot that removes spam, answers commands and keeps your community in check. It is free, cloud-hosted and set up in two minutes, supporting Twitch, YouTube, Kick and X. One dashboard serves the streamer and the whole mod team: changes show up for everyone instantly, and each action lands in the audit log. Commands automate repetitive messages, and spam filters handle links, caps, symbols and repetition on their own. Users include well-known streamers such as Sodapoppin and Fuslie.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Twitch, YouTube, Kick and X
Spam filters
Chat commands
Shared mod dashboard
Audit logs
Cloud-hosted and free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Streamers and their mod teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Хмарний чат-бот', 'Cloud chatbot' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Cloud chatbot', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Fragnet Arena — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'arena.fragnet.net' OR LOWER(`name`) = LOWER('Fragnet Arena'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fragnet Arena', NULL, 'https://arena.fragnet.net', NULL, NULL, 'Fragnet Arena — платформа турнірів CS2 і Dota 2: пошук змагань, сервери, новини та кваліфікації до професійних турнірів, зокрема відбори на PGL Masters.', 'Fragnet Arena is a CS2 and Dota 2 tournament platform: find competitions, servers, news and qualifiers to pro events, including PGL Masters qualifications.', 'Fragnet Arena пропонує знайти змагання, стежити за подіями й залишити свій слід на арені. Платформа проводить турніри CS2 і Dota 2 та регіональні кваліфікації до професійних подій: на сайті, наприклад, завершені відбори Азії, Північної й Південної Америки на PGL Masters Bucharest 2026. Розділи сайту включають турніри, сервери та новини, а блок останніх матчів показує результати з картами й рахунками. Нові змагання з''являються на сторінці після оголошення.', 'Fragnet Arena invites you to find your competition, follow the action and make your mark in the arena. It runs CS2 and Dota 2 tournaments and regional qualifiers for pro events; for example, the site lists completed Asia, North America and South America qualifiers for PGL Masters Bucharest 2026. Sections include tournaments, servers and news, and a latest-matches block shows results with maps and scores. New competitions appear once they are announced.', 'Турніри CS2 і Dota 2
Кваліфікації до професійних подій
Ігрові сервери
Результати матчів із картами
Новини платформи', 'CS2 and Dota 2 tournaments
Qualifiers to pro events
Game servers
Match results with maps
Platform news', 'Команди й гравці CS2 та Dota 2, які шукають турніри.', 'CS2 and Dota 2 teams and players looking for tournaments.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'arena.fragnet.net' OR LOWER(`name`) = LOWER('Fragnet Arena')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fragnet Arena is a CS2 and Dota 2 tournament platform: find competitions, servers, news and qualifiers to pro events, including PGL Masters qualifications.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Fragnet Arena invites you to find your competition, follow the action and make your mark in the arena. It runs CS2 and Dota 2 tournaments and regional qualifiers for pro events; for example, the site lists completed Asia, North America and South America qualifiers for PGL Masters Bucharest 2026. Sections include tournaments, servers and news, and a latest-matches block shows results with maps and scores. New competitions appear once they are announced.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'CS2 and Dota 2 tournaments
Qualifiers to pro events
Game servers
Match results with maps
Platform news', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'CS2 and Dota 2 teams and players looking for tournaments.', 'manual' FROM DUAL WHERE @new = 1;

-- GamerLink — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gamerlinkapp.com' OR LOWER(`name`) = LOWER('GamerLink'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GamerLink', NULL, 'https://gamerlinkapp.com', NULL, NULL, 'GamerLink — універсальний застосунок пошуку групи (LFG) для понад 300 ігор на всіх основних платформах: оголошення за грою, платформою й уподобаннями та профіль гравця. Безкоштовно для ПК, iOS і Android.', 'GamerLink is a universal looking-for-group (LFG) app for 300+ games on all major platforms: posts by game, platform and preferences, plus a gamer profile. Free on PC, iOS and Android.', 'GamerLink допомагає знаходити друзів і найкращих напарників у понад 300 іграх на всіх основних платформах. LFG-оголошення створюються вибором гри, платформи й кількох ігрових уподобань, тож для кожної гри пошук групи працює зручно. Власний профіль гравця об''єднує онлайн-ідентичність і гнучко налаштовується. Застосунок має високі оцінки користувачів, а невелика команда оперативно реагує на відгуки. Завантажити його можна безкоштовно для ПК, iOS і Android.', 'GamerLink helps you connect with friends and find the best teammates in 300+ games across all major platforms. LFG posts are created by choosing a game, platform and several game preferences, making group search smooth for every title. A customizable gamer profile consolidates your online identity. The app is highly rated, and the small team is responsive to feedback. It is a free download on PC, iOS and Android.', 'Пошук групи в 300+ іграх
Фільтри за грою й платформою
Профіль гравця
ПК, iOS і Android
Безкоштовно', 'LFG for 300+ games
Game and platform filters
Gamer profile
PC, iOS and Android
Free', 'Гравці, які шукають напарників для рейтингових ігор.', 'Players looking for teammates for ranked games.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gamerlinkapp.com' OR LOWER(`name`) = LOWER('GamerLink')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'GamerLink is a universal looking-for-group (LFG) app for 300+ games on all major platforms: posts by game, platform and preferences, plus a gamer profile. Free on PC, iOS and Android.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'GamerLink helps you connect with friends and find the best teammates in 300+ games across all major platforms. LFG posts are created by choosing a game, platform and several game preferences, making group search smooth for every title. A customizable gamer profile consolidates your online identity. The app is highly rated, and the small team is responsive to feedback. It is a free download on PC, iOS and Android.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'LFG for 300+ games
Game and platform filters
Gamer profile
PC, iOS and Android
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Players looking for teammates for ranked games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовне завантаження', 'Free download' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free download', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Gamers Club — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gamersclub.gg' OR LOWER(`name`) = LOWER('Gamers Club'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Gamers Club', NULL, 'https://gamersclub.gg', NULL, NULL, 'Gamers Club — найбільша кіберспортивна платформа Бразилії: рейтингові матчі, аматорські чемпіонати й ліги з CS, Valorant, LoL, Free Fire, R6 та інших ігор, призи та академія з відеоуроками від професіоналів.', 'Gamers Club is Brazil''s largest esports platform: ranked matches, amateur championships and leagues in CS, Valorant, LoL, Free Fire, R6 and more, prizes and an academy with video lessons from pros.', 'Gamers Club називає себе найбільшою кіберспортивною платформою Бразилії. На ній грають у Valorant, League of Legends, Free Fire, Delta Force, Counter-Strike, Wild Rift, Deadlock і Rainbow Six Siege. Гравці беруть участь в аматорських чемпіонатах і лігах, виграють гроші, скіни, периферію й медалі, грають рейтингові матчі й підвищують рівень майстерності, а окремі турніри ведуть до професійного кіберспортивного кола. Розділ Academy пропонує відеоуроки від професіоналів — від основ до професійного рівня. Сайт португальською мовою.', 'Gamers Club calls itself Brazil''s largest esports platform. Players compete in Valorant, League of Legends, Free Fire, Delta Force, Counter-Strike, Wild Rift, Deadlock and Rainbow Six Siege. They join amateur championships and leagues, win cash, skins, peripherals and medals, play ranked matches to raise their skill level, and some tournaments lead to the professional circuit. The Academy offers video lessons from pros, from basics to pro level. The site is in Portuguese.', 'Рейтингові матчі й рівні майстерності
Аматорські чемпіонати й ліги
Призи: гроші, скіни, периферія
Шлях до професійного кіберспорту
Академія з відеоуроками професіоналів', 'Ranked matches and skill levels
Amateur championships and leagues
Prizes: cash, skins, peripherals
Path to pro esports
Academy with pro video lessons', 'Гравці з Бразилії та Латинської Америки, які хочуть змагатися.', 'Players in Brazil and Latin America who want to compete.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gamersclub.gg' OR LOWER(`name`) = LOWER('Gamers Club')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Gamers Club is Brazil''s largest esports platform: ranked matches, amateur championships and leagues in CS, Valorant, LoL, Free Fire, R6 and more, prizes and an academy with video lessons from pros.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Gamers Club calls itself Brazil''s largest esports platform. Players compete in Valorant, League of Legends, Free Fire, Delta Force, Counter-Strike, Wild Rift, Deadlock and Rainbow Six Siege. They join amateur championships and leagues, win cash, skins, peripherals and medals, play ranked matches to raise their skill level, and some tournaments lead to the professional circuit. The Academy offers video lessons from pros, from basics to pro level. The site is in Portuguese.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Ranked matches and skill levels
Amateur championships and leagues
Prizes: cash, skins, peripherals
Path to pro esports
Academy with pro video lessons', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Players in Brazil and Latin America who want to compete.', 'manual' FROM DUAL WHERE @new = 1;

-- Games of Legends — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gol.gg' OR LOWER(`name`) = LOWER('Games of Legends'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Games of Legends', NULL, 'https://gol.gg', NULL, NULL, 'Games of Legends (gol.gg) — статистика професійних змагань League of Legends: турніри, команди, гравці й чемпіони провідних ліг (LCK, LPL, LEC, LCS та інших) і результати останніх ігор.', 'Games of Legends (gol.gg) tracks competitive League of Legends stats: tournaments, teams, players and champions across major leagues (LCK, LPL, LEC, LCS and more) and the latest game results.', 'Games of Legends — це «дім статистики професійного League of Legends». Через пошук можна знайти команду, гравця чи чемпіона, а швидкий доступ веде до провідних ліг: LCK, LPL, LEC, LCS, CBLOL, LCP та регіональних. На головній — таблиця останніх ігор із турніром, датою й складами сторін. Розділи сайту охоплюють турніри, команди, гравців, чемпіонів, ігрові моменти й інструменти аналізу. Підтримати проєкт і прибрати рекламу можна через Patreon.', 'Games of Legends calls itself the home of competitive League of Legends statistics. You can search for a team, player or champion, and quick links lead to the major leagues: LCK, LPL, LEC, LCS, CBLOL, LCP and regional leagues. The home page lists the latest competitive games with tournament, date and sides. Sections cover tournaments, teams, players, champions, plays and analysis tools. You can support the project and remove ads via Patreon.', 'Статистика команд і гравців профі-ліг
Дані про чемпіонів у професійних іграх
Результати останніх ігор
Швидкий доступ до LCK, LPL, LEC, LCS
Інструменти аналізу', 'Pro league team and player stats
Champion data from pro games
Latest game results
Quick access to LCK, LPL, LEC, LCS
Analysis tools', 'Аналітики, тренери й уболівальники професійного League of Legends.', 'Analysts, coaches and fans of competitive League of Legends.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gol.gg' OR LOWER(`name`) = LOWER('Games of Legends')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Games of Legends (gol.gg) tracks competitive League of Legends stats: tournaments, teams, players and champions across major leagues (LCK, LPL, LEC, LCS and more) and the latest game results.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Games of Legends calls itself the home of competitive League of Legends statistics. You can search for a team, player or champion, and quick links lead to the major leagues: LCK, LPL, LEC, LCS, CBLOL, LCP and regional leagues. The home page lists the latest competitive games with tournament, date and sides. Sections cover tournaments, teams, players, champions, plays and analysis tools. You can support the project and remove ads via Patreon.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Pro league team and player stats
Champion data from pro games
Latest game results
Quick access to LCK, LPL, LEC, LCS
Analysis tools', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Analysts, coaches and fans of competitive League of Legends.', 'manual' FROM DUAL WHERE @new = 1;

-- GameTree — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gametree.me' OR LOWER(`name`) = LOWER('GameTree'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GameTree', NULL, 'https://gametree.me', NULL, NULL, 'GameTree — застосунок і Discord-бот для пошуку гравців (LFG): координація ігор і пошук підхожих напарників у тисячах ігор — від Valorant, LoL і CS2 до Rocket League з урахуванням рангу.', 'GameTree is an LFG app and Discord bot: coordinate games and find the right players in thousands of titles, from Valorant, LoL and CS2 to rank-aware Rocket League teammate search.', 'GameTree спрощує пошук групи: допомагає координувати ігри, підтримувати зв''язок і знаходити підхожих гравців через застосунок і Discord-бот. Сервіс охоплює тисячі ігор, зокрема Apex Legends, Call of Duty, CS2, Dota 2, Fortnite, League of Legends, Marvel Rivals, Overwatch, Rainbow Six Siege, Rocket League (з пошуком тіммейтів за рангом) і Valorant. Discord-бот LFG має документацію, а блог, вікі й словник геймера допомагають новачкам. Інтерфейс доступний кількома мовами, зокрема українською.', 'GameTree makes LFG easy: it helps you coordinate games, stay connected and find the right players through its app and Discord bot. It covers thousands of games, including Apex Legends, Call of Duty, CS2, Dota 2, Fortnite, League of Legends, Marvel Rivals, Overwatch, Rainbow Six Siege, Rocket League (with rank-aware teammate finding) and Valorant. The LFG Discord bot is documented, and a blog, wiki and gamer dictionary help newcomers. The interface is available in several languages, including Ukrainian.', 'Пошук гравців у тисячах ігор
Discord-бот LFG
Пошук за рангом
Координація ігор
Українська версія', 'Player search in thousands of games
LFG Discord bot
Rank-aware matching
Game coordination
Ukrainian version', 'Гравці, які шукають команду, та Discord-спільноти.', 'Players seeking teams and Discord communities.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gametree.me' OR LOWER(`name`) = LOWER('GameTree')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'GameTree is an LFG app and Discord bot: coordinate games and find the right players in thousands of titles, from Valorant, LoL and CS2 to rank-aware Rocket League teammate search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'GameTree makes LFG easy: it helps you coordinate games, stay connected and find the right players through its app and Discord bot. It covers thousands of games, including Apex Legends, Call of Duty, CS2, Dota 2, Fortnite, League of Legends, Marvel Rivals, Overwatch, Rainbow Six Siege, Rocket League (with rank-aware teammate finding) and Valorant. The LFG Discord bot is documented, and a blog, wiki and gamer dictionary help newcomers. The interface is available in several languages, including Ukrainian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Player search in thousands of games
LFG Discord bot
Rank-aware matching
Game coordination
Ukrainian version', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Players seeking teams and Discord communities.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок і Discord-бот', 'App and Discord bot' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App and Discord bot', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Garage 61 — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'garage61.net' OR LOWER(`name`) = LOWER('Garage 61'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Garage 61', NULL, 'https://garage61.net', NULL, NULL, 'Garage 61 — софт для сім-рейсингу в iRacing: автоматичний збір телеметрії, порівняння даних і сетапів, синхронізація сетапів і гоуст-кіл, таблиці лідерів і підтримка команд.', 'Garage 61 is sim racing software for iRacing: automatic telemetry collection, telemetry and setup comparison, setup and ghost lap sync, leaderboards and team support.', 'Garage 61 — інноваційний софт для автоспорту, що допомагає командам і пілотам ставати швидшими. Назва відсилає до боксів 56–60 у Ле-Мані, які традиційно віддають передовим проєктам. Розробники хочуть зробити ПЗ, що не заважає, а допомагає зосередитися на швидкості, і оптимізоване для командної роботи та навчання пілотів один в одного. Уже доступні: збір телеметрії встановленням агента, порівняння й вивчення телеметрії та сетапів, вбудована синхронізація сетапів і гоуст-кіл, таблиці лідерів для пошуку даних для порівняння і розширена підтримка команд. Наразі сервіс зосереджений на iRacing і перебуває в альфа-версії.', 'Garage 61 is innovative motorsport software that helps teams and drivers get faster. The name refers to garages 56 to 60 at Le Mans, traditionally reserved for cutting-edge projects. The developers aim for software that doesn''t get in the way but helps you focus on speed, optimized for teams to work together and drivers to learn from each other. Available now: telemetry collection by installing an agent, comparing and studying telemetry and setups, built-in setup and ghost lap sync, leaderboards to find data to compare against and extensive team support. It currently focuses on iRacing and is in alpha.', 'Автоматичний збір телеметрії
Порівняння телеметрії й сетапів
Синхронізація сетапів і гоуст-кіл
Таблиці лідерів
Підтримка команд', 'Automatic telemetry collection
Telemetry and setup comparison
Setup and ghost lap sync
Leaderboards
Team support', 'Гонщики й команди iRacing.', 'iRacing drivers and teams.', 'web,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'garage61.net' OR LOWER(`name`) = LOWER('Garage 61')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Garage 61 is sim racing software for iRacing: automatic telemetry collection, telemetry and setup comparison, setup and ghost lap sync, leaderboards and team support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Garage 61 is innovative motorsport software that helps teams and drivers get faster. The name refers to garages 56 to 60 at Le Mans, traditionally reserved for cutting-edge projects. The developers aim for software that doesn''t get in the way but helps you focus on speed, optimized for teams to work together and drivers to learn from each other. Available now: telemetry collection by installing an agent, comparing and studying telemetry and setups, built-in setup and ghost lap sync, leaderboards to find data to compare against and extensive team support. It currently focuses on iRacing and is in alpha.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automatic telemetry collection
Telemetry and setup comparison
Setup and ghost lap sync
Leaderboards
Team support', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'iRacing drivers and teams.', 'manual' FROM DUAL WHERE @new = 1;

-- Hatchet — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hatchet.gg' OR LOWER(`name`) = LOWER('Hatchet'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hatchet', NULL, 'https://hatchet.gg', NULL, NULL, 'Hatchet (колишній Stream Hatchet) — бізнес-аналітика для геймінгу, кіберспорту й стримінгу: пошук креаторів, відстеження кампаній і вимірювання ROI на понад 30 платформах за десять років даних.', 'Hatchet (formerly Stream Hatchet) is business intelligence for gaming, esports and live streaming: creator discovery, campaign tracking and ROI measurement across 30+ platforms with ten years of data.', 'Hatchet постачає аналітику стримінгу, геймінгу, креаторів, кіберспорту, преси й спільнот для брендів, видавців, дослідницьких агенцій і команд. Платформа покриває весь цикл маркетингу з креаторами: пошук і перевірку креаторів, запуск кампаній і доведення ROI в усіх соцмережах. Її основа — десять років перевірених даних стримінгу й соцмереж на понад 30 платформах без оцінок і фейкових аудиторій. Сервіс створювали саме для геймінгу, тож функції й процеси відповідають тому, як працюють ігрові кампанії. Доступ — після демонстрації; є сторінка тарифів.', 'Hatchet supplies live-streaming, gaming, creator, esports, press and community intelligence for brands, publishers, research agencies and teams. The platform covers the whole creator marketing lifecycle: find and vet creators, run campaigns and prove ROI across every social network. It is built on ten years of verified streaming and social data across 30+ platforms, with no estimates or fake audiences. It was built for gaming from day one, so features and workflows match how gaming campaigns actually run. Access starts with a demo, and there is a pricing page.', 'Пошук і перевірка креаторів
Відстеження кампаній і ROI
10 років даних стримінгу й соцмереж
30+ платформ
Аналітика кіберспорту', 'Creator discovery and vetting
Campaign tracking and ROI
10 years of streaming and social data
30+ platforms
Esports intelligence', 'Бренди, видавці ігор, агенції й кіберспортивні команди.', 'Brands, game publishers, agencies and esports teams.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hatchet.gg' OR LOWER(`name`) = LOWER('Hatchet')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Hatchet (formerly Stream Hatchet) is business intelligence for gaming, esports and live streaming: creator discovery, campaign tracking and ROI measurement across 30+ platforms with ten years of data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hatchet supplies live-streaming, gaming, creator, esports, press and community intelligence for brands, publishers, research agencies and teams. The platform covers the whole creator marketing lifecycle: find and vet creators, run campaigns and prove ROI across every social network. It is built on ten years of verified streaming and social data across 30+ platforms, with no estimates or fake audiences. It was built for gaming from day one, so features and workflows match how gaming campaigns actually run. Access starts with a demo, and there is a pricing page.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Creator discovery and vetting
Campaign tracking and ROI
10 years of streaming and social data
30+ platforms
Esports intelligence', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Brands, game publishers, agencies and esports teams.', 'manual' FROM DUAL WHERE @new = 1;

-- Healthy Gamer — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'healthygamer.gg' OR LOWER(`name`) = LOWER('Healthy Gamer'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Healthy Gamer', NULL, 'https://www.healthygamer.gg', NULL, NULL, 'Healthy Gamer — підтримка ментального здоров''я для покоління інтернету від психіатра д-ра Алока Канодзії (Dr. K): коучинг, гайд Dr. K, членство, матеріали для батьків і спільнота.', 'Healthy Gamer provides mental health support for the internet generation, developed by psychiatrist Dr. Alok Kanojia (Dr. K): coaching, Dr. K''s Guide, memberships, resources for parents and community.', 'Healthy Gamer — проєкт психіатра д-ра Алока Канодзії, відомого як Dr. K, що допомагає з ментальним здоров''ям людям, які виросли в інтернеті, зокрема геймерам. Підтримка будується на трьох складових: коучингу, контенті й спільноті. Сервіс пропонує коучинг HG Coaching, навчальний курс «Dr. K''s Guide», членство з доступом до матеріалів, окремий розділ для батьків, бібліотеку відео й магазин. У США коучинг, гайди й членство можуть покриватися рахунками HSA і FSA.', 'Healthy Gamer is a project by psychiatrist Dr. Alok Kanojia, known as Dr. K, supporting the mental health of people who grew up online, including gamers. Support rests on coaching, content and community. It offers HG Coaching, the Dr. K''s Guide course, memberships with access to materials, a section for parents, a video library and a shop. In the US, coaching, guides and memberships may be eligible for HSA and FSA.', 'Коучинг HG Coaching
Курс Dr. K''s Guide
Членство з матеріалами
Розділ для батьків
Бібліотека відео', 'HG Coaching
Dr. K''s Guide course
Memberships with materials
Resources for parents
Video library', 'Геймери та молодь, яким потрібна підтримка ментального здоров''я, і їхні батьки.', 'Gamers and young people seeking mental health support, and their parents.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'healthygamer.gg' OR LOWER(`name`) = LOWER('Healthy Gamer')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Healthy Gamer provides mental health support for the internet generation, developed by psychiatrist Dr. Alok Kanojia (Dr. K): coaching, Dr. K''s Guide, memberships, resources for parents and community.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Healthy Gamer is a project by psychiatrist Dr. Alok Kanojia, known as Dr. K, supporting the mental health of people who grew up online, including gamers. Support rests on coaching, content and community. It offers HG Coaching, the Dr. K''s Guide course, memberships with access to materials, a section for parents, a video library and a shop. In the US, coaching, guides and memberships may be eligible for HSA and FSA.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'HG Coaching
Dr. K''s Guide course
Memberships with materials
Resources for parents
Video library', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers and young people seeking mental health support, and their parents.', 'manual' FROM DUAL WHERE @new = 1;

-- Hitmarker — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hitmarker.net' OR LOWER(`name`) = LOWER('Hitmarker'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hitmarker', NULL, 'https://hitmarker.net', NULL, NULL, 'Hitmarker — вакансії в ігровій індустрії, кіберспорті й контенті: перевірені ролі в студіях, кіберспортивних організаціях і командах креаторів, профілі кандидатів і безкоштовне розміщення вакансій.', 'Hitmarker lists jobs in games, esports and content: verified roles at studios, esports orgs and creator teams, candidate profiles and free job posting.', 'Hitmarker допомагає знайти роботу в іграх, кіберспорті й контенті та найняти талановитих людей у цій індустрії. На сайті — перевірені вакансії в студіях, кіберспортивних організаціях і командах креаторів, щодня додаються десятки нових. Пошук працює за назвою, компанією й напрямом: геймдизайн, арт, кіберспорт, спільнота, розробка. Новинка — профілі Hitmarker, що перетворюють досвід і навички кандидата на профіль для роботодавців. Розміщення вакансії безкоштовне; також є новини й ресурси.', 'Hitmarker helps you find jobs in games, esports and content, and hire talented people in the industry. It lists verified roles at studios, esports organizations and creator teams, with dozens added daily. Search works by title, company and field: game design, art, esports, community, engineering. New Hitmarker Profiles turn a candidate''s experience and skills into a profile employers can see. Posting a job is free, and there are news and resources.', 'Перевірені вакансії в іграх і кіберспорті
Десятки нових вакансій щодня
Пошук за напрямом і компанією
Профілі кандидатів
Безкоштовне розміщення вакансій', 'Verified game and esports jobs
Dozens of new jobs daily
Search by field and company
Candidate profiles
Free job posting', 'Фахівці, які шукають роботу в кіберспорті й геймдеві, та роботодавці.', 'Professionals seeking esports and gamedev jobs, and employers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hitmarker.net' OR LOWER(`name`) = LOWER('Hitmarker')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Hitmarker lists jobs in games, esports and content: verified roles at studios, esports orgs and creator teams, candidate profiles and free job posting.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hitmarker helps you find jobs in games, esports and content, and hire talented people in the industry. It lists verified roles at studios, esports organizations and creator teams, with dozens added daily. Search works by title, company and field: game design, art, esports, community, engineering. New Hitmarker Profiles turn a candidate''s experience and skills into a profile employers can see. Posting a job is free, and there are news and resources.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Verified game and esports jobs
Dozens of new jobs daily
Search by field and company
Candidate profiles
Free job posting', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Professionals seeking esports and gamedev jobs, and employers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Розміщення вакансії', 'Job posting', 0.00, 'free', 'Безкоштовно для роботодавців', 'Free for employers' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Розміщення вакансії' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Job posting', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for employers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- HLTV — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hltv.org' OR LOWER(`name`) = LOWER('HLTV'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HLTV', NULL, 'https://www.hltv.org', NULL, NULL, 'HLTV.org — головний портал професійного Counter-Strike: новини, матчі й результати, турніри, рейтинг команд, статистика гравців і команд, трансфери, фентезі та форум.', 'HLTV.org is the home of competitive Counter-Strike: news, matches and results, events, team ranking, player and team stats, transfers, fantasy and a forum.', 'HLTV.org називає себе домом професійного Counter-Strike. Тут зібрано новини, розклад і результати матчів, поточні турніри, архів і календар подій, а також рейтинг команд. Розділ гравців містить профілі, трансфери, MVP та EVP турнірів, щорічний топ-20, перспективних гравців, Зал слави й дослідник гравців. Статистика охоплює огляд, найкращих гравців і команди та карти. Є фентезі-ліга до великих турнірів, форум, фото- та медіарозділи. Налаштування дозволяють фільтрувати матчі за типом, LAN, командами й важливістю.', 'HLTV.org calls itself the home of competitive Counter-Strike. It covers news, match schedules and results, ongoing events, an event archive and calendar, and a team ranking. The players section has profiles, transfers, event MVPs and EVPs, the yearly top 20, prospects, a Hall of Fame and a player explorer. Stats include an overview, top players, top teams and maps. There is a fantasy game for big events, a forum, and photo and media sections. Settings let you filter matches by type, LAN, teams and importance.', 'Новини, матчі й результати
Рейтинг команд
Статистика гравців, команд і карт
Трансфери, MVP і топ-20 гравців
Фентезі до турнірів
Форум спільноти', 'News, matches and results
Team ranking
Player, team and map stats
Transfers, MVPs and top 20 players
Fantasy for events
Community forum', 'Уболівальники, аналітики й гравці Counter-Strike.', 'Counter-Strike fans, analysts and players.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hltv.org' OR LOWER(`name`) = LOWER('HLTV')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'HLTV.org is the home of competitive Counter-Strike: news, matches and results, events, team ranking, player and team stats, transfers, fantasy and a forum.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'HLTV.org calls itself the home of competitive Counter-Strike. It covers news, match schedules and results, ongoing events, an event archive and calendar, and a team ranking. The players section has profiles, transfers, event MVPs and EVPs, the yearly top 20, prospects, a Hall of Fame and a player explorer. Stats include an overview, top players, top teams and maps. There is a fantasy game for big events, a forum, and photo and media sections. Settings let you filter matches by type, LAN, teams and importance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'News, matches and results
Team ranking
Player, team and map stats
Transfers, MVPs and top 20 players
Fantasy for events
Community forum', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Counter-Strike fans, analysts and players.', 'manual' FROM DUAL WHERE @new = 1;

-- HSReplay.net — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hsreplay.net' OR LOWER(`name`) = LOWER('HSReplay.net'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HSReplay.net', NULL, 'https://hsreplay.net', NULL, NULL, 'HSReplay.net — повтори й поглиблена статистика Hearthstone: мета колод і карт на основі мільйонів ігор щотижня, тір-листи, Battlegrounds, Arena, Hearthstone Deck Tracker і Premium.', 'HSReplay.net offers Hearthstone replays and advanced stats: deck and card meta based on millions of games per week, tier lists, Battlegrounds, Arena, Hearthstone Deck Tracker and Premium.', 'HSReplay.net дозволяє переглядати й ділитися повторами Hearthstone просто в браузері та вивчати поглиблену статистику колод і карт на основі мільйонів ігор щотижня. Є тренди, мета, колоди, карти й тір-лист для Standard, інструмент Arenasmith і дані про муліган. Для Battlegrounds — оверлей, герої, склади, міньйони й дрібнички. Збирає дані десктопний застосунок Hearthstone Deck Tracker, а розширений доступ відкриває Premium. Сервіс розробляє HearthSim, команда Untapped.gg.', 'HSReplay.net lets you watch and share Hearthstone replays in the browser and explore advanced deck and card stats based on millions of games per week. There are trends, meta, decks, cards and a Standard tier list, the Arenasmith tool and mulligan data. For Battlegrounds there is an overlay plus heroes, comps, minions and trinkets. Data is collected by the Hearthstone Deck Tracker desktop app, and Premium unlocks advanced access. It is built by HearthSim, the team behind Untapped.gg.', 'Повтори Hearthstone у браузері
Мета колод і карт
Тір-лист і дані мулігану
Battlegrounds: оверлей і склади
Hearthstone Deck Tracker
Premium', 'Hearthstone replays in the browser
Deck and card meta
Tier list and mulligan data
Battlegrounds overlay and comps
Hearthstone Deck Tracker
Premium', 'Гравці Hearthstone, зокрема в Battlegrounds і Arena.', 'Hearthstone players, including Battlegrounds and Arena.', 'web,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hsreplay.net' OR LOWER(`name`) = LOWER('HSReplay.net')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'HSReplay.net offers Hearthstone replays and advanced stats: deck and card meta based on millions of games per week, tier lists, Battlegrounds, Arena, Hearthstone Deck Tracker and Premium.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'HSReplay.net lets you watch and share Hearthstone replays in the browser and explore advanced deck and card stats based on millions of games per week. There are trends, meta, decks, cards and a Standard tier list, the Arenasmith tool and mulligan data. For Battlegrounds there is an overlay plus heroes, comps, minions and trinkets. Data is collected by the Hearthstone Deck Tracker desktop app, and Premium unlocks advanced access. It is built by HearthSim, the team behind Untapped.gg.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hearthstone replays in the browser
Deck and card meta
Tier list and mulligan data
Battlegrounds overlay and comps
Hearthstone Deck Tracker
Premium', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Hearthstone players, including Battlegrounds and Arena.', 'manual' FROM DUAL WHERE @new = 1;

-- HyperX NGENUITY — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hyperx.com/pages/ngenuity' OR LOWER(`name`) = LOWER('HyperX NGENUITY'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HyperX NGENUITY', NULL, 'https://hyperx.com/pages/ngenuity', NULL, NULL, 'HyperX NGENUITY — програма для налаштування сумісних гарнітур, мишей і клавіатур HyperX: призначення кнопок, запис і збереження макросів, налаштування підсвітки.', 'HyperX NGENUITY is software to personalize compatible HyperX headsets, mice and keyboards: button bindings, recording and storing macros, and lighting customization.', 'NGENUITY дозволяє персоналізувати сумісні продукти HyperX — гарнітури, миші й клавіатури. У програмі можна призначати дії кнопкам, програмувати й зберігати макроси та налаштовувати підсвітку, отримуючи стільки контролю, скільки потрібно. Програма доступна для завантаження на сторінці HyperX.', 'NGENUITY lets you personalize compatible HyperX products: headsets, mice and keyboards. You can set button bindings, program and store macros and customize lighting, with as much control as you want. The software is available to download from HyperX.', 'Призначення кнопок
Запис і збереження макросів
Налаштування підсвітки
Гарнітури, миші й клавіатури HyperX', 'Button bindings
Macro recording and storage
Lighting customization
HyperX headsets, mice and keyboards', 'Геймери з периферією HyperX.', 'Gamers with HyperX gear.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hyperx.com/pages/ngenuity' OR LOWER(`name`) = LOWER('HyperX NGENUITY')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'HyperX NGENUITY is software to personalize compatible HyperX headsets, mice and keyboards: button bindings, recording and storing macros, and lighting customization.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NGENUITY lets you personalize compatible HyperX products: headsets, mice and keyboards. You can set button bindings, program and store macros and customize lighting, with as much control as you want. The software is available to download from HyperX.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Button bindings
Macro recording and storage
Lighting customization
HyperX headsets, mice and keyboards', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers with HyperX gear.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для пристроїв HyperX', 'For HyperX devices' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For HyperX devices', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- iRacing — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'iracing.com' OR LOWER(`name`) = LOWER('iRacing'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'iRacing', NULL, 'https://www.iracing.com', NULL, NULL, 'iRacing — онлайн-симулятор гонок для ПК за підпискою: понад 180 офіційно ліцензованих машин, понад 150 лазерно відсканованих трас, офіційні серії й кіберспорт eNASCAR, Porsche Esports, IMSA.', 'iRacing is a subscription-based online racing simulator for PC: 180+ officially licensed cars, 150+ laser-scanned tracks, official series and esports such as eNASCAR, Porsche Esports and IMSA.', 'iRacing — онлайн-симулятор гонок для ПК, що працює за підпискою. У ньому понад 180 офіційно ліцензованих автомобілів на понад 150 лазерно відсканованих трасах, а змагатися можна в NASCAR, INDYCAR, IMSA, Porsche Esports та інших серіях; спільнота налічує близько 350 тисяч гонщиків. Офіційні серії, різні дисципліни, погодна система, гонки з AI, командні гонки, VR і ліги доповнює кіберспортивна програма з календарем спецподій, eNASCAR Coca-Cola iRacing Series і Porsche Esports Supercup. Є застосунок-компаньйон і інструмент телеметрії Cosworth Pi Toolbox. Для новачків — гайд, вимоги до системи й підтримка кермів і контролерів.', 'iRacing is a subscription-based online racing simulator for PC. It offers 180+ officially licensed cars on 150+ laser-scanned tracks, and you can compete in NASCAR, INDYCAR, IMSA, Porsche Esports and more, with a community of about 350,000 sim racers. Official series, multiple disciplines, a weather system, AI racing, team racing, VR and leagues are complemented by an esports program with a special events calendar, the eNASCAR Coca-Cola iRacing Series and the Porsche Esports Supercup. There is a companion app and the Cosworth Pi Toolbox telemetry tool. Newcomers get a guide, system requirements and wheel and controller support.', '180+ ліцензованих машин
150+ лазерно відсканованих трас
Офіційні серії й ліги
Кіберспорт eNASCAR і Porsche Esports
Командні гонки, VR і погода
Застосунок-компаньйон', '180+ licensed cars
150+ laser-scanned tracks
Official series and leagues
eNASCAR and Porsche Esports
Team racing, VR and weather
Companion app', 'Сім-рейсери від новачків до кіберспортсменів.', 'Sim racers from beginners to esports pros.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'iracing.com' OR LOWER(`name`) = LOWER('iRacing')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'iRacing is a subscription-based online racing simulator for PC: 180+ officially licensed cars, 150+ laser-scanned tracks, official series and esports such as eNASCAR, Porsche Esports and IMSA.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'iRacing is a subscription-based online racing simulator for PC. It offers 180+ officially licensed cars on 150+ laser-scanned tracks, and you can compete in NASCAR, INDYCAR, IMSA, Porsche Esports and more, with a community of about 350,000 sim racers. Official series, multiple disciplines, a weather system, AI racing, team racing, VR and leagues are complemented by an esports program with a special events calendar, the eNASCAR Coca-Cola iRacing Series and the Porsche Esports Supercup. There is a companion app and the Cosworth Pi Toolbox telemetry tool. Newcomers get a guide, system requirements and wheel and controller support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '180+ licensed cars
150+ laser-scanned tracks
Official series and leagues
eNASCAR and Porsche Esports
Team racing, VR and weather
Companion app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sim racers from beginners to esports pros.', 'manual' FROM DUAL WHERE @new = 1;

-- League of Graphs — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'leagueofgraphs.com' OR LOWER(`name`) = LOWER('League of Graphs'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'League of Graphs', NULL, 'https://www.leagueofgraphs.com', NULL, NULL, 'League of Graphs — статистика й рейтинги чемпіонів та гравців League of Legends і TFT: профілі, тір-лист, найкращі гравці, рекорди, повтори ігор і застосунок для гри Porofessor з одним спільним акаунтом.', 'League of Graphs offers League of Legends and TFT stats and rankings for champions and players: profiles, tier list, best players, records, game replays and the Porofessor in-game app with a shared account.', 'League of Graphs — сайт статистики League of Legends із перемикачем на Teamfight Tactics. Тут є профілі гравців, тір-лист чемпіонів, найкращі гравці, розподіл за рангами, рекорди, очки майстерності та випробування. Розділ статистики показує цікаві зрізи гри: перемоги синіх і червоних, драконів, тривалість ігор, ворди, пінги, AFK і здачі, а також те, як відсоток перемог залежить від досвіду на чемпіоні. Окремо зібрано статистику режиму Arena, інфографіку та повтори ігор — із пентакілами, високим KDA, професіоналами й записами з Twitch. Один акаунт працює і для League of Graphs, і для застосунку Porofessor. Інтерфейс доступний багатьма мовами, зокрема українською.', 'League of Graphs is a League of Legends stats site with a switch to Teamfight Tactics. It has player profiles, a champion tier list, best players, rank distribution, records, mastery points and challenges. The stats section offers interesting slices of the game: blue vs red, drakes, game durations, warding, pings, AFK and surrender stats, and how win rate depends on champion experience. There are separate Arena stats, infographics and replays, including pentakills, high-KDA games, pros and Twitch replays. One account works for both League of Graphs and the Porofessor app. The interface is available in many languages, including Ukrainian.', 'Профілі гравців і тір-лист чемпіонів
Найкращі гравці, рекорди й розподіл рангів
Детальні зрізи статистики гри
Статистика режиму Arena
Повтори ігор і професіоналів
Спільний акаунт із Porofessor', 'Player profiles and champion tier list
Best players, records and rank distribution
Detailed game stat breakdowns
Arena mode stats
Game and pro replays
Shared account with Porofessor', 'Гравці League of Legends і TFT, які стежать за своєю статистикою та метою.', 'League of Legends and TFT players who follow their stats and the meta.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'leagueofgraphs.com' OR LOWER(`name`) = LOWER('League of Graphs')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'League of Graphs offers League of Legends and TFT stats and rankings for champions and players: profiles, tier list, best players, records, game replays and the Porofessor in-game app with a shared account.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'League of Graphs is a League of Legends stats site with a switch to Teamfight Tactics. It has player profiles, a champion tier list, best players, rank distribution, records, mastery points and challenges. The stats section offers interesting slices of the game: blue vs red, drakes, game durations, warding, pings, AFK and surrender stats, and how win rate depends on champion experience. There are separate Arena stats, infographics and replays, including pentakills, high-KDA games, pros and Twitch replays. One account works for both League of Graphs and the Porofessor app. The interface is available in many languages, including Ukrainian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Player profiles and champion tier list
Best players, records and rank distribution
Detailed game stat breakdowns
Arena mode stats
Game and pro replays
Shared account with Porofessor', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'League of Legends and TFT players who follow their stats and the meta.', 'manual' FROM DUAL WHERE @new = 1;

-- LeagueSpot — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'leaguespot.com' OR LOWER(`name`) = LOWER('LeagueSpot'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LeagueSpot', NULL, 'https://leaguespot.com', NULL, NULL, 'LeagueSpot — безпечна платформа для бізнесу й організацій, щоб створювати брендовані сітки, турніри й ліги з будь-якої гри із захистом молодшої аудиторії та даних.', 'LeagueSpot is a safe platform for businesses and organizations to build branded brackets, tournaments and leagues for any game, protecting younger audiences and data.', 'LeagueSpot позиціонує себе як надійну ігрову платформу для бізнесу й організацій, які хочуть проводити власні брендовані турніри й ліги. Перевага — ваш бренд, досвід і аудиторія без сторонніх відволікань. Платформа дозволяє охопити й захистити молодшу аудиторію та інші особливі групи, гарантує безпеку даних і має конструктор турнірів для будь-якої гри — Warzone, Valorant, Rocket League, Minecraft тощо. Підтримуються і кіберспорт, і аматорська гра. Серед партнерів — YMCA, яка використовує LeagueSpot для безпечних освітніх онлайн-програм для молоді.', 'LeagueSpot positions itself as a trusted gaming platform for businesses and organizations that want to run their own branded tournaments and leagues. The benefit is your branding, experience and audience with zero interruptions. It lets you reach and protect younger demographics and other special groups, ensures data security and offers a tournament creator for any game: Warzone, Valorant, Rocket League, Minecraft and more. It supports esports and amateur play. Partners include the YMCA, which uses LeagueSpot for safe, educational online youth programs.', 'Брендовані турніри й ліги
Захист молодшої аудиторії
Безпека даних
Конструктор турнірів для будь-якої гри
Кіберспорт і аматорська гра', 'Branded tournaments and leagues
Protection for younger audiences
Data security
Tournament creator for any game
Esports and amateur play', 'Компанії, школи, молодіжні організації та бренди.', 'Companies, schools, youth organizations and brands.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'leaguespot.com' OR LOWER(`name`) = LOWER('LeagueSpot')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'LeagueSpot is a safe platform for businesses and organizations to build branded brackets, tournaments and leagues for any game, protecting younger audiences and data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LeagueSpot positions itself as a trusted gaming platform for businesses and organizations that want to run their own branded tournaments and leagues. The benefit is your branding, experience and audience with zero interruptions. It lets you reach and protect younger demographics and other special groups, ensures data security and offers a tournament creator for any game: Warzone, Valorant, Rocket League, Minecraft and more. It supports esports and amateur play. Partners include the YMCA, which uses LeagueSpot for safe, educational online youth programs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Branded tournaments and leagues
Protection for younger audiences
Data security
Tournament creator for any game
Esports and amateur play', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Companies, schools, youth organizations and brands.', 'manual' FROM DUAL WHERE @new = 1;

-- Lightstream — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'golightstream.com' OR LOWER(`name`) = LOWER('Lightstream'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lightstream', NULL, 'https://golightstream.com', NULL, NULL, 'Lightstream Studio — хмарне ПЗ для стримінгу в браузері без завантажень: стрими з консолей, оверлеї й алерти, до 10 гостей для мультиплеєрних трансляцій, шаблони й кастомні призначення.', 'Lightstream Studio is cloud streaming software in the browser with no downloads: console streaming, overlays and alerts, up to 10 guests for multiplayer streams, templates and custom destinations.', 'Lightstream робить стримінг із консолей простим: повний креативний набір працює в браузері на хмарі, і вийти в ефір можна за хвилини. Ставите стрим на улюблені платформи або власні призначення, використовуєте готові алерти й оверлеї або завантажуєте свої. До стриму можна запросити до 10 гостей для мультиплеєрних ігор чи настільних RPG, а шаблони дозволяють налаштувати все в один клік. Безкоштовний план має базові функції з логотипом Lightstream, Premium коштує $12 на місяць або $9 на місяць при оплаті за рік і дозволяє прибрати логотип.', 'Lightstream makes console streaming easy: a complete creative suite runs in the browser, powered by the cloud, and you can go live in minutes. Stream to your favourite platforms or custom destinations, use ready-made alerts and overlays or upload your own. Invite up to 10 guests for multiplayer games or tabletop RPG nights, and templates set everything up in one click. The free plan has core features with the Lightstream logo, while Premium costs $12 per month or $9 per month annually and removes the logo.', 'Стримінг у браузері без завантажень
Стрими з консолей
Оверлеї й алерти
До 10 гостей
Шаблони в один клік', 'Browser streaming, no downloads
Console streaming
Overlays and alerts
Up to 10 guests
One-click templates', 'Стримери з консолей і ті, хто не хоче налаштовувати OBS.', 'Console streamers and those who don''t want to set up OBS.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'golightstream.com' OR LOWER(`name`) = LOWER('Lightstream')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Lightstream Studio is cloud streaming software in the browser with no downloads: console streaming, overlays and alerts, up to 10 guests for multiplayer streams, templates and custom destinations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Lightstream makes console streaming easy: a complete creative suite runs in the browser, powered by the cloud, and you can go live in minutes. Stream to your favourite platforms or custom destinations, use ready-made alerts and overlays or upload your own. Invite up to 10 guests for multiplayer games or tabletop RPG nights, and templates set everything up in one click. The free plan has core features with the Lightstream logo, while Premium costs $12 per month or $9 per month annually and removes the logo.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Browser streaming, no downloads
Console streaming
Overlays and alerts
Up to 10 guests
One-click templates', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Console streamers and those who don''t want to set up OBS.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Базові функції з логотипом Lightstream', 'Core features with Lightstream logo' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Core features with Lightstream logo', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium', 'Premium', 12.00, 'month', 'Без логотипа; $9/міс при оплаті за рік', 'No logo; $9/mo billed annually' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'No logo; $9/mo billed annually', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Limitless TCG — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'limitlesstcg.com' OR LOWER(`name`) = LOWER('Limitless TCG'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Limitless TCG', NULL, 'https://limitlesstcg.com', NULL, NULL, 'Limitless — результати турнірів, деклісти, мета й статті для змагального Pokémon TCG: база карт, топові колоди, рейтинги гравців і інструменти на кшталт калькулятора Swiss та конструктора колод.', 'Limitless provides tournament results, decklists, meta and articles for competitive Pokémon TCG: card database, top decks, player rankings and tools like a Swiss calculator and deck builder.', 'Limitless прагне дати змагальному гравцю Pokémon TCG усю потрібну інформацію. Сайт збирає результати турнірів і деклісти, показує топові колоди формату з часткою в метагеймі й призовими деклістами регіональних турнірів. Є база карт із розширеним пошуком і перекладами, розділи гравців і рейтингів, блог. Інструменти включають друк проксі, калькулятор Swiss, генератор зображень, калькулятор ймовірностей добору й конструктор колод (бета), а партнерство з Metafy відкриває доступ до тренерів. Сайт доступний кількома мовами, рекламу можна прибрати через Patreon.', 'Limitless aims to provide all the content a competitive Pokémon TCG player needs. It collects tournament results and decklists, shows top decks with metagame share and placing decklists from regionals. There is a card database with advanced search and translations, players and rankings sections, and a blog. Tools include a proxy printer, Swiss calculator, image generator, draw calculator and a deck builder (beta), and a partnership with Metafy gives access to coaches. The site is available in several languages, and ads can be removed via Patreon.', 'Результати турнірів і деклісти
Топові колоди й частка в метагеймі
База карт із розширеним пошуком
Калькулятор Swiss і ймовірностей
Конструктор колод (бета)', 'Tournament results and decklists
Top decks and metagame share
Card database with advanced search
Swiss and draw calculators
Deck builder (beta)', 'Змагальні гравці Pokémon TCG.', 'Competitive Pokémon TCG players.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'limitlesstcg.com' OR LOWER(`name`) = LOWER('Limitless TCG')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Limitless provides tournament results, decklists, meta and articles for competitive Pokémon TCG: card database, top decks, player rankings and tools like a Swiss calculator and deck builder.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Limitless aims to provide all the content a competitive Pokémon TCG player needs. It collects tournament results and decklists, shows top decks with metagame share and placing decklists from regionals. There is a card database with advanced search and translations, players and rankings sections, and a blog. Tools include a proxy printer, Swiss calculator, image generator, draw calculator and a deck builder (beta), and a partnership with Metafy gives access to coaches. The site is available in several languages, and ads can be removed via Patreon.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tournament results and decklists
Top decks and metagame share
Card database with advanced search
Swiss and draw calculators
Deck builder (beta)', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Competitive Pokémon TCG players.', 'manual' FROM DUAL WHERE @new = 1;

-- LiveSplit — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'livesplit.org' OR LOWER(`name`) = LOWER('LiveSplit'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LiveSplit', NULL, 'https://livesplit.org', NULL, NULL, 'LiveSplit — безкоштовний таймер для спідранерів із гнучким налаштуванням: інтеграція зі Speedrun.com, точний час через атомний годинник, ігровий час і автоспліти, відеокомпонент.', 'LiveSplit is a free, highly customizable timer for speedrunners: Speedrun.com integration, accurate timing via an atomic clock, game time and auto splitting, and a video component.', 'LiveSplit — програма-таймер для спідранерів, проста у використанні й багата на функції. Speedrun.com повністю інтегрований: можна переглядати таблиці лідерів, завантажувати спліти й надсилати власні забіги прямо з програми, а компонент World Record показує світові рекорди. Таймер синхронізується з атомним годинником через інтернет і виправляє неточності локального таймера. LiveSplit сам визначає, чи для гри доступні ігровий час і автоспліти; ігровий час зчитується напряму з емулятора чи ПК-гри. Відеокомпонент дозволяє відтворювати відео поруч із таймером, а інтерфейс збирається з компонентів.', 'LiveSplit is a timer program for speedrunners that is easy to use and full of features. Speedrun.com is fully integrated: browse leaderboards, download splits and submit runs directly from LiveSplit, while the World Record component shows records. The timer syncs with an atomic clock over the internet and corrects local inaccuracies. LiveSplit detects when Game Time and Auto Splitting are available for a game, and game time is read directly from an emulator or PC game. A video component plays video alongside the timer, and the layout is built from components.', 'Інтеграція зі Speedrun.com
Точний час через атомний годинник
Ігровий час і автоспліти
Відеокомпонент
Налаштування з компонентів', 'Speedrun.com integration
Atomic-clock accurate timing
Game time and auto splitting
Video component
Component-based layouts', 'Спідранери на ПК та емуляторах.', 'Speedrunners on PC and emulators.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'livesplit.org' OR LOWER(`name`) = LOWER('LiveSplit')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'LiveSplit is a free, highly customizable timer for speedrunners: Speedrun.com integration, accurate timing via an atomic clock, game time and auto splitting, and a video component.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LiveSplit is a timer program for speedrunners that is easy to use and full of features. Speedrun.com is fully integrated: browse leaderboards, download splits and submit runs directly from LiveSplit, while the World Record component shows records. The timer syncs with an atomic clock over the internet and corrects local inaccuracies. LiveSplit detects when Game Time and Auto Splitting are available for a game, and game time is read directly from an emulator or PC game. A video component plays video alongside the timer, and the layout is built from components.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Speedrun.com integration
Atomic-clock accurate timing
Game time and auto splitting
Video component
Component-based layouts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Speedrunners on PC and emulators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Програма для Windows', 'Windows program' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Windows program', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Logitech G HUB — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'logitechg.com/en-us/software/ghub' OR LOWER(`name`) = LOWER('Logitech G HUB'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Logitech G HUB', NULL, 'https://www.logitechg.com/en-us/software/ghub', NULL, NULL, 'Logitech G HUB — програма для ігрової периферії Logitech G: налаштування мишей, клавіатур, гарнітур і веб-камер, створення та обмін профілями для Windows і macOS.', 'Logitech G HUB is software for Logitech G gaming gear: configure mice, keyboards, headsets and webcams, and create and share profiles, for Windows and macOS.', 'G HUB розкриває повний потенціал ігрової периферії Logitech G: призначайте функції, налаштовуйте й грайте. Програма керує налаштуваннями мишей, клавіатур, гарнітур і веб-камер, дозволяє створювати профілі для ігор і ділитися ними зі спільнотою. Вона доступна для Windows і macOS. Logitech G також пропонує Mixline для маршрутизації й зведення звуку під час стримів, Streamlabs для трансляцій і Astro Command Center для старіших гарнітур ASTRO, а нова система Haptic Inductive Trigger System дає тактильний відгук у реальному часі.', 'G HUB unlocks the full potential of Logitech G gaming gear: assign, tune, immerse and play. It manages settings for mice, keyboards, headsets and webcams and lets you create game profiles and share them with the community. It is available for Windows and macOS. Logitech G also offers Mixline for audio routing and mixing while streaming, Streamlabs for broadcasting and Astro Command Center for older ASTRO headsets, and the new Haptic Inductive Trigger System provides real-time haptic feedback.', 'Налаштування мишей, клавіатур і гарнітур
Ігрові профілі
Обмін профілями зі спільнотою
Windows і macOS
Зв''язка з Mixline і Streamlabs', 'Mouse, keyboard and headset settings
Game profiles
Profile sharing
Windows and macOS
Works with Mixline and Streamlabs', 'Геймери з периферією Logitech G.', 'Gamers with Logitech G gear.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'logitechg.com/en-us/software/ghub' OR LOWER(`name`) = LOWER('Logitech G HUB')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Logitech G HUB is software for Logitech G gaming gear: configure mice, keyboards, headsets and webcams, and create and share profiles, for Windows and macOS.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'G HUB unlocks the full potential of Logitech G gaming gear: assign, tune, immerse and play. It manages settings for mice, keyboards, headsets and webcams and lets you create game profiles and share them with the community. It is available for Windows and macOS. Logitech G also offers Mixline for audio routing and mixing while streaming, Streamlabs for broadcasting and Astro Command Center for older ASTRO headsets, and the new Haptic Inductive Trigger System provides real-time haptic feedback.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Mouse, keyboard and headset settings
Game profiles
Profile sharing
Windows and macOS
Works with Mixline and Streamlabs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers with Logitech G gear.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для пристроїв Logitech G', 'For Logitech G devices' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For Logitech G devices', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- LoL Esports — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lolesports.com' OR LOWER(`name`) = LOWER('LoL Esports'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LoL Esports', NULL, 'https://lolesports.com', NULL, NULL, 'LoL Esports — офіційний сайт кіберспорту League of Legends від Riot Games: розклад і результати матчів усіх регіональних ліг і міжнародних турнірів, трансляції з нагородами для глядачів і новини.', 'LoL Esports is Riot Games'' official League of Legends esports site: schedules and results for all regional leagues and international events, broadcasts with viewer rewards, and news.', 'LoL Esports — офіційне місце, щоб дивитися кіберспорт League of Legends і отримувати нагороди за перегляд. Розклад охоплює весь сезон: регіональні спліти, First Stand, MSI та чемпіонат світу. На сторінці розкладу зібрано результати й найближчі матчі всіх ліг — від EMEA Masters до міжнародних турнірів, з можливістю приховати рахунок, щоб не побачити спойлер. Є загальні силові рейтинги команд і новини, наприклад пояснення формату чемпіонату світу.', 'LoL Esports is the official place to watch League of Legends esports and earn rewards for watching. The schedule covers the whole season: regional splits, First Stand, MSI and Worlds. The schedule page collects results and upcoming matches from all leagues, from EMEA Masters to international events, with a click-to-reveal option to avoid score spoilers. There are global power rankings for teams and news such as Worlds format explainers.', 'Розклад і результати всіх ліг
Трансляції з нагородами за перегляд
Міжнародні турніри: First Stand, MSI, Worlds
Приховування рахунку від спойлерів
Силові рейтинги команд
Офіційні новини', 'Schedules and results for all leagues
Broadcasts with viewing rewards
International events: First Stand, MSI, Worlds
Spoiler-free score reveal
Team power rankings
Official news', 'Уболівальники кіберспорту League of Legends.', 'League of Legends esports fans.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lolesports.com' OR LOWER(`name`) = LOWER('LoL Esports')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'LoL Esports is Riot Games'' official League of Legends esports site: schedules and results for all regional leagues and international events, broadcasts with viewer rewards, and news.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LoL Esports is the official place to watch League of Legends esports and earn rewards for watching. The schedule covers the whole season: regional splits, First Stand, MSI and Worlds. The schedule page collects results and upcoming matches from all leagues, from EMEA Masters to international events, with a click-to-reveal option to avoid score spoilers. There are global power rankings for teams and news such as Worlds format explainers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Schedules and results for all leagues
Broadcasts with viewing rewards
International events: First Stand, MSI, Worlds
Spoiler-free score reveal
Team power rankings
Official news', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'League of Legends esports fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Перегляд трансляцій і розкладу', 'Watching broadcasts and schedules' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Watching broadcasts and schedules', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- LoLalytics — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lolalytics.com' OR LOWER(`name`) = LOWER('LoLalytics'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LoLalytics', NULL, 'https://lolalytics.com', NULL, NULL, 'LoLalytics — аналітика мети League of Legends: тір-лист, збірки, руни й контрпіки для поточного патча на основі всіх чемпіонів із кожної рейтингової гри обраного діапазону рангів.', 'LoLalytics analyses the League of Legends meta: tier list, builds, runes and counters for the current patch, based on every champion from every ranked game in the chosen rank bracket.', 'LoLalytics аналізує поточну мету League of Legends і підказує найкращі збірки, руни та контрпіки для актуального патча. Сервіс наголошує, що враховує 100% чемпіонів, зіграних у кожній рейтинговій грі обраного діапазону рангів, і ніколи не додає ігри з інших діапазонів, тому для кожного діапазону показує власний середній відсоток перемог. На головній сторінці видно, які чемпіони отримали посилення чи послаблення, з динамікою відсотка перемог, частоти виборів і банів. Є тір-листи для рейтингових ігор, ARAM та Arena, таблиця лідерів, сторінка контрпіків і розділ про збірки професійних гравців.', 'LoLalytics analyses the current League of Legends meta and shows the best builds, runes and counters for the latest patch. The service stresses that it includes 100% of the champions played in every ranked game of the selected rank bracket and never mixes in games from other brackets, so each bracket gets its own average win rate. The home page lists buffed and nerfed champions with changes in win, pick and ban rates. There are tier lists for ranked, ARAM and Arena, a leaderboard, a counters page and a section on pro builds.', 'Тір-лист для поточного патча
Збірки, руни й контрпіки
Дані за обраним діапазоном рангів
Зміни чемпіонів після патча
Тір-листи ARAM та Arena
Збірки професійних гравців', 'Tier list for the current patch
Builds, runes and counters
Data per selected rank bracket
Champion changes after each patch
ARAM and Arena tier lists
Pro player builds', 'Гравці League of Legends, які обирають чемпіонів і збірки за статистикою.', 'League of Legends players who pick champions and builds based on stats.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lolalytics.com' OR LOWER(`name`) = LOWER('LoLalytics')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'LoLalytics analyses the League of Legends meta: tier list, builds, runes and counters for the current patch, based on every champion from every ranked game in the chosen rank bracket.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LoLalytics analyses the current League of Legends meta and shows the best builds, runes and counters for the latest patch. The service stresses that it includes 100% of the champions played in every ranked game of the selected rank bracket and never mixes in games from other brackets, so each bracket gets its own average win rate. The home page lists buffed and nerfed champions with changes in win, pick and ban rates. There are tier lists for ranked, ARAM and Arena, a leaderboard, a counters page and a section on pro builds.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tier list for the current patch
Builds, runes and counters
Data per selected rank bracket
Champion changes after each patch
ARAM and Arena tier lists
Pro player builds', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'League of Legends players who pick champions and builds based on stats.', 'manual' FROM DUAL WHERE @new = 1;

-- LoLCHESS.GG — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lolchess.gg' OR LOWER(`name`) = LOWER('LoLCHESS.GG'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LoLCHESS.GG', NULL, 'https://lolchess.gg', NULL, NULL, 'LoLCHESS.GG — статистика Teamfight Tactics: склади, таблиці лідерів, бази чемпіонів, трейтів, предметів і аугментів, конструктор команд, оверлей, гайди й пошук напарників.', 'LoLCHESS.GG offers Teamfight Tactics stats: comps, leaderboards, databases of champions, traits, items and augments, a team builder, an overlay, guides and LFG.', 'LoLCHESS.GG — сайт статистики TFT від команди, що також робить сервіси для Valorant, PUBG, Deadlock та інших ігор. Розділ складів показує актуальні комп поточного сету з поясненнями, а статистика й таблиці — останню мету, чемпіонів, трейти й предмети. Є глобальні таблиці лідерів з LP і відсотком перемог, можливість переглянути гру топових гравців, бази даних чемпіонів, трейтів, предметів і аугментів, конструктор і інструменти, оверлей для гри, гайди та пошук групи. Увійти можна через акаунт Riot. Сервіс доступний на сайті й мобільних пристроях.', 'LoLCHESS.GG is a TFT stats site from a team that also builds services for Valorant, PUBG, Deadlock and other games. The comps section shows current comps of the set with explanations, and the stats and tables pages show the latest meta, champions, traits and items. There are global leaderboards with LP and win rates, the option to spectate top players, databases of champions, traits, items and augments, builder tools, an in-game overlay, guides and LFG. You can sign in with a Riot account. The service works on the web and mobile devices.', 'Актуальні склади поточного сету
Глобальні таблиці лідерів
Бази чемпіонів, трейтів і аугментів
Конструктор команд і оверлей
Перегляд ігор топових гравців
Пошук групи (LFG)', 'Current comps for the set
Global leaderboards
Champion, trait and augment databases
Team builder and overlay
Spectate top players
Looking for group (LFG)', 'Гравці Teamfight Tactics, зокрема на мобільних пристроях.', 'Teamfight Tactics players, including on mobile.', 'web,mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lolchess.gg' OR LOWER(`name`) = LOWER('LoLCHESS.GG')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'LoLCHESS.GG offers Teamfight Tactics stats: comps, leaderboards, databases of champions, traits, items and augments, a team builder, an overlay, guides and LFG.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LoLCHESS.GG is a TFT stats site from a team that also builds services for Valorant, PUBG, Deadlock and other games. The comps section shows current comps of the set with explanations, and the stats and tables pages show the latest meta, champions, traits and items. There are global leaderboards with LP and win rates, the option to spectate top players, databases of champions, traits, items and augments, builder tools, an in-game overlay, guides and LFG. You can sign in with a Riot account. The service works on the web and mobile devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Current comps for the set
Global leaderboards
Champion, trait and augment databases
Team builder and overlay
Spectate top players
Looking for group (LFG)', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teamfight Tactics players, including on mobile.', 'manual' FROM DUAL WHERE @new = 1;

-- LoLPros.gg — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lolpros.gg' OR LOWER(`name`) = LOWER('LoLPros.gg'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LoLPros.gg', NULL, 'https://lolpros.gg', NULL, NULL, 'LoLPros.gg — база акаунтів професійних гравців League of Legends: ладер профі, пошук, живі ігри, ліги, мультипошук, карта Challenger, історія ладера й зміни нікнеймів.', 'LoLPros.gg is a database of League of Legends pro player accounts: a pro ladder, search, live games, leagues, multi-search, a Challenger map, ladder history and name changes.', 'LoLPros.gg відстежує акаунти професійних і найсильніших гравців League of Legends. Ладер показує топ гравців за LP, є пошук, живі ігри, розділ ліг і мультипошук. Також доступні карта Challenger-гравців, історія ладера, список відсутніх Challenger і стрічка останніх змін нікнеймів — зручно, щоб зрозуміти, з ким із професіоналів ви граєте.', 'LoLPros.gg tracks accounts of pro and top League of Legends players. The ladder lists top players by LP, and there is search, live games, a leagues section and multi-search. You also get a Challenger map, ladder history, a missing Challengers list and a feed of recent name changes, handy for knowing which pros you are playing with.', 'Ладер профі за LP
Пошук і мультипошук
Живі ігри професіоналів
Карта Challenger
Зміни нікнеймів', 'Pro ladder by LP
Search and multi-search
Pro live games
Challenger map
Name changes', 'Гравці й уболівальники League of Legends.', 'League of Legends players and fans.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lolpros.gg' OR LOWER(`name`) = LOWER('LoLPros.gg')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'LoLPros.gg is a database of League of Legends pro player accounts: a pro ladder, search, live games, leagues, multi-search, a Challenger map, ladder history and name changes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LoLPros.gg tracks accounts of pro and top League of Legends players. The ladder lists top players by LP, and there is search, live games, a leagues section and multi-search. You also get a Challenger map, ladder history, a missing Challengers list and a feed of recent name changes, handy for knowing which pros you are playing with.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Pro ladder by LP
Search and multi-search
Pro live games
Challenger map
Name changes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'League of Legends players and fans.', 'manual' FROM DUAL WHERE @new = 1;

-- Lossless Scaling — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'store.steampowered.com/app/993090/lossless_scaling' OR LOWER(`name`) = LOWER('Lossless Scaling'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lossless Scaling', NULL, 'https://store.steampowered.com/app/993090/Lossless_Scaling/', NULL, NULL, 'Lossless Scaling — утиліта Steam для генерації кадрів і масштабування: власна ML-модель LSFG 3 додає кадри в іграх без вбудованої генерації, а алгоритми й моделі на кшталт LS1 підвищують якість чи продуктивність.', 'Lossless Scaling is a Steam utility for frame generation and scaling: its own LSFG 3 ML model adds frames to games without built-in frame generation, while algorithms and models like LS1 improve quality or performance.', 'Lossless Scaling робить ігри плавнішими за допомогою генерації кадрів LSFG і за потреби покращує якість або продуктивність різними алгоритмами масштабування й моделями машинного навчання, як-от LS1. Він сумісний з більшістю ігор — навіть тих, де немає власної генерації кадрів чи масштабування, — а також з іншими програмами й широким колом обладнання. LSFG — власна ML-модель, створена з нуля саме для Lossless Scaling; вона підходить для ігор без вбудованого рішення, старих ігор і емуляторів із заблокованою частотою кадрів і має окрему полегшену модель для слабких GPU. Програма платна й продається в Steam.', 'Lossless Scaling makes games smoother with LSFG frame generation and optionally improves quality or performance with various scaling algorithms and machine learning models like LS1. It is compatible with most games, even those without built-in frame generation or scaling, as well as other apps and a wide range of hardware. LSFG is a proprietary ML model built from scratch for Lossless Scaling; it suits games lacking a built-in solution, older games and emulators with locked frame rates, and has a separate performance model for low-power GPUs. It is a paid app sold on Steam.', 'Генерація кадрів LSFG 3
Масштабування й ML-моделі LS1
Сумісність із більшістю ігор
Підходить для емуляторів
Модель для слабких GPU', 'LSFG 3 frame generation
Scaling and LS1 ML models
Works with most games
Good for emulators
Model for low-power GPUs', 'Гравці, які хочуть вищий FPS на наявному залізі.', 'Players wanting higher FPS on existing hardware.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'store.steampowered.com/app/993090/lossless_scaling' OR LOWER(`name`) = LOWER('Lossless Scaling')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Lossless Scaling is a Steam utility for frame generation and scaling: its own LSFG 3 ML model adds frames to games without built-in frame generation, while algorithms and models like LS1 improve quality or performance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Lossless Scaling makes games smoother with LSFG frame generation and optionally improves quality or performance with various scaling algorithms and machine learning models like LS1. It is compatible with most games, even those without built-in frame generation or scaling, as well as other apps and a wide range of hardware. LSFG is a proprietary ML model built from scratch for Lossless Scaling; it suits games lacking a built-in solution, older games and emulators with locked frame rates, and has a separate performance model for low-power GPUs. It is a paid app sold on Steam.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'LSFG 3 frame generation
Scaling and LS1 ML models
Works with most games
Good for emulators
Model for low-power GPUs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Players wanting higher FPS on existing hardware.', 'manual' FROM DUAL WHERE @new = 1;

-- Low Fuel Motorsport — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lowfuelmotorsport.com' OR LOWER(`name`) = LOWER('Low Fuel Motorsport'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Low Fuel Motorsport', NULL, 'https://lowfuelmotorsport.com', NULL, NULL, 'Low Fuel Motorsport (LFM) — незалежна платформа змагального сім-рейсингу: рейтингові гонки, сезони й розклад, команди, сетапи, Race Engineer, статистика й трансляції. Понад 300 тис. користувачів.', 'Low Fuel Motorsport (LFM) is an independent competitive sim racing platform: ranked races, seasons and schedules, teams, setups, Race Engineer, stats and broadcasts, with 300K+ users.', 'Low Fuel Motorsport називає себе провідною незалежною платформою змагального сім-рейсингу. На ній понад 300 тисяч користувачів і понад 128 мільйонів пройдених кіл; щодня приходять десятки нових гонщиків. Блок «Що зараз гаряче» показує найближчі гонки з таймером старту, кількістю учасників і мінімальною ліцензією — від серій GT3 і Porsche Cup до мультикласових гонок. Є розклад сезону, команди, сетапи, Race Engineer, події, статистика й трансляції партнерів. Платформа живе на внески: підписка LFM+ і донати.', 'Low Fuel Motorsport calls itself the world''s leading independent competitive sim racing platform. It has more than 300,000 users and over 128 million laps driven, with dozens of new drivers every day. The ''What''s hot'' block shows upcoming races with a countdown, entrants and minimum licence, from GT3 and Porsche Cup series to multiclass races. There is a season schedule, teams, setups, Race Engineer, events, stats and partner broadcasts. The platform is funded by LFM+ memberships and donations.', 'Рейтингові гонки з ліцензіями
Розклад сезонів і серій
Команди й сетапи
Race Engineer і статистика
Трансляції
Підписка LFM+', 'Ranked races with licences
Season and series schedule
Teams and setups
Race Engineer and stats
Broadcasts
LFM+ membership', 'Сім-рейсери, які шукають змагальні онлайн-гонки.', 'Sim racers looking for competitive online racing.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lowfuelmotorsport.com' OR LOWER(`name`) = LOWER('Low Fuel Motorsport')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Low Fuel Motorsport (LFM) is an independent competitive sim racing platform: ranked races, seasons and schedules, teams, setups, Race Engineer, stats and broadcasts, with 300K+ users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Low Fuel Motorsport calls itself the world''s leading independent competitive sim racing platform. It has more than 300,000 users and over 128 million laps driven, with dozens of new drivers every day. The ''What''s hot'' block shows upcoming races with a countdown, entrants and minimum licence, from GT3 and Porsche Cup series to multiclass races. There is a season schedule, teams, setups, Race Engineer, events, stats and partner broadcasts. The platform is funded by LFM+ memberships and donations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Ranked races with licences
Season and series schedule
Teams and setups
Race Engineer and stats
Broadcasts
LFM+ membership', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sim racers looking for competitive online racing.', 'manual' FROM DUAL WHERE @new = 1;

-- Lumia Stream — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lumiastream.com' OR LOWER(`name`) = LOWER('Lumia Stream'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lumia Stream', NULL, 'https://lumiastream.com', NULL, NULL, 'Lumia Stream — універсальний інструмент для стримерів на Twitch, YouTube, TikTok і Facebook: мультистрим із єдиним чатом, оверлеї, чат-боти, алерти, керування розумним освітленням, OBS і AI TTS.', 'Lumia Stream is an all-in-one tool for streamers on Twitch, YouTube, TikTok and Facebook: multistreaming with one chat, overlays, chatbots, alerts, smart light control, OBS and AI TTS.', 'Lumia Stream дає повний контроль над стримом: мультистрим, керування освітленням, нагороди за лояльність, оверлеї та багато іншого в одному інструменті. Усі чати мультистриму зібрано в одному місці, а алерти не загубляться. Сервіс підключає стримерів на Twitch, YouTube, TikTok і Facebook до оверлеїв, чат-ботів, алертів, розумних ламп, OBS тощо. Є Control Room, імпорт зі StreamElements, сторінки біо й донатів, HUD, розширення Twitch, плагіни Stream Deck і Touch Portal, AI-озвучення тексту та плагіни. Завантажити можна безкоштовно, є платні тарифи.', 'Lumia Stream gives you full control of your stream: multistreaming, light control, loyalty rewards, overlays and more in one tool. All your multistream chats are in one place so you never miss an alert. It connects streamers on Twitch, YouTube, TikTok and Facebook to overlays, chatbots, alerts, smart lights, OBS and more. There is a Control Room, a StreamElements importer, bio and tip pages, a HUD, a Twitch extension, Stream Deck and Touch Portal plugins, AI TTS and plugins. It is a free download with paid plans.', 'Мультистрим з єдиним чатом
Оверлеї й алерти
Керування розумним освітленням
Чат-боти й OBS
AI-озвучення тексту
Плагіни Stream Deck', 'Multistream with one chat
Overlays and alerts
Smart light control
Chatbots and OBS
AI TTS
Stream Deck plugins', 'Стримери на кількох платформах.', 'Multi-platform streamers.', 'desktop,web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lumiastream.com' OR LOWER(`name`) = LOWER('Lumia Stream')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Lumia Stream is an all-in-one tool for streamers on Twitch, YouTube, TikTok and Facebook: multistreaming with one chat, overlays, chatbots, alerts, smart light control, OBS and AI TTS.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Lumia Stream gives you full control of your stream: multistreaming, light control, loyalty rewards, overlays and more in one tool. All your multistream chats are in one place so you never miss an alert. It connects streamers on Twitch, YouTube, TikTok and Facebook to overlays, chatbots, alerts, smart lights, OBS and more. There is a Control Room, a StreamElements importer, bio and tip pages, a HUD, a Twitch extension, Stream Deck and Touch Portal plugins, AI TTS and plugins. It is a free download with paid plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Multistream with one chat
Overlays and alerts
Smart light control
Chatbots and OBS
AI TTS
Stream Deck plugins', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Multi-platform streamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовне завантаження', 'Free download' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free download', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Matcherino — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'matcherino.com' OR LOWER(`name`) = LOWER('Matcherino'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Matcherino', NULL, 'https://matcherino.com', NULL, NULL, 'Matcherino — кіберспортивні турніри з призовими фондами, які наповнює спільнота: безкоштовні інструменти для організаторів — сітки, реєстрація, виплати переможцям по всьому світу й спонсорство.', 'Matcherino runs esports tournaments with community-funded prize pools: free organizer tools for brackets, registration, global payouts to winners and sponsorships.', 'Matcherino — платформа, де переможці кіберспортивних турнірів отримують виплати. Вона поєднує турнірні інструменти, краудфандинг призового фонду й глобальні виплати. Організатори безкоштовно отримують сітки, реєстрацію, виплати й залучення спонсорів, а спільнота може поповнювати призовий фонд турніру. За даними сайту, платформа вже виплатила переможцям понад $5 млн і провела десятки тисяч матчів. Гравці можуть шукати турніри й приєднуватися до них.', 'Matcherino is where esports winners get paid. It combines tournament tools, prize pool crowdfunding and global payouts. Organizers get free brackets, registration, payouts and sponsorships, and the community can add to a tournament''s prize pool. The site reports more than $5 million paid out to winners and tens of thousands of matches played. Players can explore and join tournaments.', 'Призові фонди від спільноти
Безкоштовні сітки й реєстрація
Глобальні виплати переможцям
Залучення спонсорів
Пошук турнірів', 'Community-funded prize pools
Free brackets and registration
Global payouts to winners
Sponsorships
Tournament discovery', 'Організатори кіберспортивних турнірів і гравці.', 'Esports tournament organizers and players.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'matcherino.com' OR LOWER(`name`) = LOWER('Matcherino')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Matcherino runs esports tournaments with community-funded prize pools: free organizer tools for brackets, registration, global payouts to winners and sponsorships.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Matcherino is where esports winners get paid. It combines tournament tools, prize pool crowdfunding and global payouts. Organizers get free brackets, registration, payouts and sponsorships, and the community can add to a tournament''s prize pool. The site reports more than $5 million paid out to winners and tens of thousands of matches played. Players can explore and join tournaments.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Community-funded prize pools
Free brackets and registration
Global payouts to winners
Sponsorships
Tournament discovery', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Esports tournament organizers and players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Для організаторів', 'For organizers', 0.00, 'free', 'Безкоштовні інструменти турнірів', 'Free tournament tools' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Для організаторів' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'For organizers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tournament tools', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Medal — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'medal.tv' OR LOWER(`name`) = LOWER('Medal'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Medal', NULL, 'https://medal.tv', NULL, NULL, 'Medal — безкоштовний запис, редагування й поширення ігрових кліпів на ПК: зберігає момент, що щойно стався, одним натисканням, дає миттєве посилання, багатодоріжковий звук і застосунки для iOS та Android.', 'Medal is free game clip recording, editing and sharing on PC: save what just happened with one button, get an instant link, multi-track audio and iOS and Android apps.', 'Medal дозволяє зберегти те, що щойно сталося в грі, одним натисканням і одразу отримати посилання, яким можна поділитися будь-де. Він працює у фоні з мінімальним впливом на продуктивність, підтримує всі ігри на ПК і багатодоріжковий звук — гру, мікрофон і Discord можна збалансувати або вимкнути окремо. На мобільних пристроях кліпи можна дивитися й публікувати. За даними сайту, на Medal уже завантажено майже 3 мільярди кліпів, а користувачі знайшли понад 12 мільйонів друзів; кліпи можна позначати друзями.', 'Medal lets you capture what just happened in a game with one button and get an instant link to share anywhere. It runs in the background with minimal impact, supports all PC games and multi-track audio, so game, mic and Discord can be balanced or muted separately. On mobile you can watch and post clips. The site reports nearly 3 billion clips uploaded and over 12 million friends connected, and you can tag friends in clips.', 'Запис кліпу одним натисканням
Миттєве посилання для поширення
Усі ігри на ПК
Багатодоріжковий звук
Застосунки для iOS і Android', 'One-button clip capture
Instant share link
All PC games
Multi-track audio
iOS and Android apps', 'Гравці, які діляться найкращими моментами.', 'Gamers sharing their best moments.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'medal.tv' OR LOWER(`name`) = LOWER('Medal')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Medal is free game clip recording, editing and sharing on PC: save what just happened with one button, get an instant link, multi-track audio and iOS and Android apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Medal lets you capture what just happened in a game with one button and get an instant link to share anywhere. It runs in the background with minimal impact, supports all PC games and multi-track audio, so game, mic and Discord can be balanced or muted separately. On mobile you can watch and post clips. The site reports nearly 3 billion clips uploaded and over 12 million friends connected, and you can tag friends in clips.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'One-button clip capture
Instant share link
All PC games
Multi-track audio
iOS and Android apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers sharing their best moments.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Запис і поширення кліпів', 'Clip recording and sharing' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Clip recording and sharing', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- METAsrc — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'metasrc.com' OR LOWER(`name`) = LOWER('METAsrc'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'METAsrc', NULL, 'https://www.metasrc.com', NULL, NULL, 'METAsrc — статистичні збірки, гайди й тір-листи для League of Legends і Teamfight Tactics: рейтингові ігри, ARAM, Arena, League Classic і режими TFT, а також огляди змін мети в нових патчах.', 'METAsrc provides statistical builds, guides and tier lists for League of Legends and Teamfight Tactics: ranked, ARAM, Arena, League Classic and TFT modes, plus meta previews for new patches.', 'METAsrc збирає статистичні збірки, гайди й тір-листи для League of Legends і TFT. Для LoL доступні рейтингові ігри, League Classic, Arena, ARAM і ARAM: Mayhem, для TFT — рейтингові ігри, Double Up і поточний сет. Редакція публікує гайди на основі даних і огляди патчів: які зміни чемпіонів, предметів і режимів найімовірніше вплинуть на мету. Сайт перекладено на понад 15 мов.', 'METAsrc collects statistical builds, guides and tier lists for League of Legends and TFT. For LoL it covers ranked, League Classic, Arena, ARAM and ARAM: Mayhem; for TFT it covers ranked, Double Up and the current set. The team publishes data-backed guides and patch previews on which champion, item and mode changes are most likely to shift the meta. The site is translated into more than 15 languages.', 'Статистичні збірки й тір-листи
LoL: рейтингові ігри, ARAM, Arena, League Classic
TFT: рейтингові ігри й Double Up
Гайди на основі даних
Огляди мети перед патчами', 'Statistical builds and tier lists
LoL: ranked, ARAM, Arena, League Classic
TFT: ranked and Double Up
Data-backed guides
Patch meta previews', 'Гравці LoL і TFT, які шукають актуальні збірки для свого режиму.', 'LoL and TFT players looking for current builds for their game mode.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'metasrc.com' OR LOWER(`name`) = LOWER('METAsrc')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'METAsrc provides statistical builds, guides and tier lists for League of Legends and Teamfight Tactics: ranked, ARAM, Arena, League Classic and TFT modes, plus meta previews for new patches.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'METAsrc collects statistical builds, guides and tier lists for League of Legends and TFT. For LoL it covers ranked, League Classic, Arena, ARAM and ARAM: Mayhem; for TFT it covers ranked, Double Up and the current set. The team publishes data-backed guides and patch previews on which champion, item and mode changes are most likely to shift the meta. The site is translated into more than 15 languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Statistical builds and tier lists
LoL: ranked, ARAM, Arena, League Classic
TFT: ranked and Double Up
Data-backed guides
Patch meta previews', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'LoL and TFT players looking for current builds for their game mode.', 'manual' FROM DUAL WHERE @new = 1;

-- MetaTFT — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'metatft.com' OR LOWER(`name`) = LOWER('MetaTFT'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MetaTFT', NULL, 'https://www.metatft.com', NULL, NULL, 'MetaTFT — статистика й дані Teamfight Tactics: склади команд, аугменти, предмети, історія матчів і застосунок для гри. Машинне навчання аналізує понад 2 млн ігор на день, дані оновлюються кожні кілька хвилин.', 'MetaTFT offers Teamfight Tactics stats and data: comps, augments, items, match history and an in-game app. Machine learning analyses over 2 million games a day, with data refreshed every few minutes.', 'MetaTFT використовує машинне навчання, щоб знаходити найсильніші склади Teamfight Tactics, аналізуючи понад 2 мільйони ігор щодня. Дані оновлюються кожні кілька хвилин і враховують навіть дрібні патчі. Сторінка складів показує середнє місце й частоту вибору для топових комп і дозволяє фільтрувати їх за рангом і регіоном, а кожен склад можна розгорнути з варіантами, прикладами розстановки й найкращими аугментами. Є статистика аугментів, юнітів, предметів і трейтів, дослідник даних, тренди, історія матчів, таблиці лідерів і дані турнірів. Інструменти включають застосунок для гри, бібліотеку VOD і повторів, конструктор команд і оверлей для стріму.', 'MetaTFT uses machine learning to find the strongest Teamfight Tactics comps, analysing over 2 million games every day. Data is refreshed every few minutes and updated for b-patches. The comps page shows average placement and pick rate for the top meta comps, filterable by rank and region, and each comp expands to show options, positioning examples and best augments. There are stats for augments, units, items and traits, a data explorer, trends, match history, leaderboards and tournament data. Tools include an in-game app, VOD and replay libraries, a team builder and a stream overlay.', 'Топові склади з середнім місцем
Статистика аугментів, юнітів і предметів
Машинне навчання на 2 млн+ ігор на день
Застосунок для гри й оверлей для стріму
Історія матчів і таблиці лідерів
Конструктор команд', 'Top comps with average placement
Augment, unit and item stats
Machine learning on 2M+ games a day
In-game app and stream overlay
Match history and leaderboards
Team builder', 'Гравці Teamfight Tactics, які хочуть підвищувати ранг за допомогою даних.', 'Teamfight Tactics players who want to climb with data.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'metatft.com' OR LOWER(`name`) = LOWER('MetaTFT')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'MetaTFT offers Teamfight Tactics stats and data: comps, augments, items, match history and an in-game app. Machine learning analyses over 2 million games a day, with data refreshed every few minutes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MetaTFT uses machine learning to find the strongest Teamfight Tactics comps, analysing over 2 million games every day. Data is refreshed every few minutes and updated for b-patches. The comps page shows average placement and pick rate for the top meta comps, filterable by rank and region, and each comp expands to show options, positioning examples and best augments. There are stats for augments, units, items and traits, a data explorer, trends, match history, leaderboards and tournament data. Tools include an in-game app, VOD and replay libraries, a team builder and a stream overlay.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Top comps with average placement
Augment, unit and item stats
Machine learning on 2M+ games a day
In-game app and stream overlay
Match history and leaderboards
Team builder', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teamfight Tactics players who want to climb with data.', 'manual' FROM DUAL WHERE @new = 1;

-- Mix It Up — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mixitupapp.com' OR LOWER(`name`) = LOWER('Mix It Up'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mix It Up', NULL, 'https://mixitupapp.com', NULL, NULL, 'Mix It Up — безкоштовний бот для стримів на Twitch, YouTube, Kick і Velora: 133 функції й 43 інтеграції — команди, алерти, оверлеї, модерація, розіграші й економіка глядачів.', 'Mix It Up is a free streaming bot for Twitch, YouTube, Kick and Velora: 133 features and 43 integrations, including commands, alerts, overlays, moderation, giveaways and a viewer economy.', 'Mix It Up — «один бот на весь стрим». Кожен глядач отримує привітання, кожна підписка — свій момент, а будь-яка ідея стримера перетворюється на щось на екрані. Команди, алерти, оверлеї, модерація, розіграші й уся економіка глядачів зібрані в одному застосунку на всіх платформах, де ви стримите. Можна почати з однієї команди й розвиватися разом із каналом. Бот підтримує Twitch, YouTube, Kick і Velora, має 133 функції й 43 інтеграції та безкоштовний.', 'Mix It Up is ''one bot for the whole stream''. Every viewer gets a welcome, every sub gets a moment, and every idea becomes something on screen. Commands, alerts, overlays, moderation, giveaways and your whole viewer economy live in one app across every platform you stream to. Start with a single command and grow with your channel. It supports Twitch, YouTube, Kick and Velora, has 133 features and 43 integrations, and is free.', 'Twitch, YouTube, Kick і Velora
Команди й алерти
Оверлеї й модерація
Розіграші й економіка глядачів
43 інтеграції', 'Twitch, YouTube, Kick and Velora
Commands and alerts
Overlays and moderation
Giveaways and viewer economy
43 integrations', 'Стримери на кількох платформах.', 'Multi-platform streamers.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mixitupapp.com' OR LOWER(`name`) = LOWER('Mix It Up')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mix It Up is a free streaming bot for Twitch, YouTube, Kick and Velora: 133 features and 43 integrations, including commands, alerts, overlays, moderation, giveaways and a viewer economy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mix It Up is ''one bot for the whole stream''. Every viewer gets a welcome, every sub gets a moment, and every idea becomes something on screen. Commands, alerts, overlays, moderation, giveaways and your whole viewer economy live in one app across every platform you stream to. Start with a single command and grow with your channel. It supports Twitch, YouTube, Kick and Velora, has 133 features and 43 integrations, and is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Twitch, YouTube, Kick and Velora
Commands and alerts
Overlays and moderation
Giveaways and viewer economy
43 integrations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Multi-platform streamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовний бот', 'Free bot' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free bot', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Moobot — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moo.bot' OR LOWER(`name`) = LOWER('Moobot'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Moobot', NULL, 'https://moo.bot', NULL, NULL, 'Moobot — чат-бот Twitch для дружньої, залученої й лояльної спільноти: автоматизує рутинні завдання, прибирає небажану поведінку й заохочує бажану. Верифікований на Twitch, понад 18 років роботи.', 'Moobot is a Twitch chatbot for a friendly, engaged and loyal community: it automates routine tasks, removes unwanted behaviour and rewards desirable behaviour. Verified on Twitch, running for 18+ years.', 'Moobot допомагає будувати дружню, залучену й лояльну спільноту на Twitch. Бот заохочує залученість і лояльність глядачів, що веде до нових підписок і фоловерів. Він автоматизує багато нудних завдань, щоб стример міг зосередитися на розвагах і спілкуванні з глядачами, прибирає небажану поведінку й винагороджує бажану. Moobot верифікований на Twitch і має довіру спільноти понад 18 років. Бота й панель можна повністю налаштувати. Підключення через Twitch займає секунди й не потребує оплати, реєстрації чи завантаження.', 'Moobot helps you build a friendly, engaged and loyal community on Twitch. It encourages viewer engagement and loyalty, leading to more subs and followers. It automates many tedious tasks so the streamer can focus on entertaining and engaging viewers, removes unwanted behaviour and rewards desirable behaviour. Moobot is verified on Twitch and has been trusted by the community for over 18 years. The bot and dashboard are fully adjustable. Connecting with Twitch takes seconds, with no payment, registration or download.', 'Автоматизація рутинних завдань
Модерація чату
Заохочення лояльності глядачів
Верифікований на Twitch
Без оплати й встановлення', 'Routine task automation
Chat moderation
Viewer loyalty rewards
Verified on Twitch
No payment or install', 'Стримери на Twitch.', 'Twitch streamers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moo.bot' OR LOWER(`name`) = LOWER('Moobot')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Moobot is a Twitch chatbot for a friendly, engaged and loyal community: it automates routine tasks, removes unwanted behaviour and rewards desirable behaviour. Verified on Twitch, running for 18+ years.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Moobot helps you build a friendly, engaged and loyal community on Twitch. It encourages viewer engagement and loyalty, leading to more subs and followers. It automates many tedious tasks so the streamer can focus on entertaining and engaging viewers, removes unwanted behaviour and rewards desirable behaviour. Moobot is verified on Twitch and has been trusted by the community for over 18 years. The bot and dashboard are fully adjustable. Connecting with Twitch takes seconds, with no payment, registration or download.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Routine task automation
Chat moderation
Viewer loyalty rewards
Verified on Twitch
No payment or install', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Twitch streamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Підключення через Twitch', 'Connect with Twitch' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Connect with Twitch', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mouse Sensitivity — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mouse-sensitivity.com' OR LOWER(`name`) = LOWER('Mouse Sensitivity'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mouse Sensitivity', NULL, 'https://www.mouse-sensitivity.com', NULL, NULL, 'Mouse Sensitivity («Same Aim — Different Game») — калькулятор і конвертер чутливості миші між іграми: прості й розширені розрахунки, eDPI, аналізатор DPI, зворотні розрахунки та Premium для прицілювання й оптики.', 'Mouse Sensitivity (''Same Aim, Different Game'') is a mouse sensitivity calculator and converter between games: simple and advanced calculations, eDPI, a DPI analyzer, reverse calculations and Premium for ADS and scopes.', 'Mouse Sensitivity допомагає зберегти однаковий аім у різних іграх. Калькулятор працює в простому й розширеному режимах: враховує одиниці, поле зору (FOV), співвідношення сторін, відстань повороту на 360° і масштаб по осі Y, дозволяє зберігати, редагувати й ділитися налаштуваннями. Є калькулятор eDPI, аналізатор DPI і зворотний розрахунок, що підбирає найкращий метод за поточними налаштуваннями прицілу. Premium конвертує чутливість для прицілювання й оптичних прицілів, щоб ідеальний аім працював із будь-якою зброєю в будь-якій грі. Є форум, Discord, інструкції й можливість запросити нову гру.', 'Mouse Sensitivity helps you keep the same aim across games. The calculator has simple and advanced modes: it accounts for units, field of view, aspect ratio, 360° distance and Y-axis scale, and lets you save, edit and share entries. There is an eDPI calculator, a DPI analyzer and reverse calculations that find the best matching method for your current ADS and scope settings. Premium converts zoom sensitivity (ADS and scopes) so your aim works with any weapon in any game. There is a forum, Discord, instructions and game requests.', 'Конвертер чутливості між іграми
Калькулятор eDPI
Аналізатор DPI
Зворотні розрахунки
Premium для ADS і оптики', 'Sensitivity converter between games
eDPI calculator
DPI analyzer
Reverse calculations
Premium for ADS and scopes', 'Гравці шутерів, які переходять між іграми.', 'Shooter players switching between games.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mouse-sensitivity.com' OR LOWER(`name`) = LOWER('Mouse Sensitivity')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mouse Sensitivity (''Same Aim, Different Game'') is a mouse sensitivity calculator and converter between games: simple and advanced calculations, eDPI, a DPI analyzer, reverse calculations and Premium for ADS and scopes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mouse Sensitivity helps you keep the same aim across games. The calculator has simple and advanced modes: it accounts for units, field of view, aspect ratio, 360° distance and Y-axis scale, and lets you save, edit and share entries. There is an eDPI calculator, a DPI analyzer and reverse calculations that find the best matching method for your current ADS and scope settings. Premium converts zoom sensitivity (ADS and scopes) so your aim works with any weapon in any game. There is a forum, Discord, instructions and game requests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sensitivity converter between games
eDPI calculator
DPI analyzer
Reverse calculations
Premium for ADS and scopes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Shooter players switching between games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Простий калькулятор', 'Simple calculator' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Simple calculator', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Moxfield — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moxfield.com' OR LOWER(`name`) = LOWER('Moxfield'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Moxfield', NULL, 'https://www.moxfield.com', NULL, NULL, 'Moxfield — сучасний конструктор колод Magic: The Gathering для всіх офіційних форматів і кількох спільнотних: пошук колод, карт і авторів, прекони Commander, пакети карт і гра Moxle.', 'Moxfield is a modern Magic: The Gathering deck builder for all official constructed formats and some community ones: search decks, cards and brewers, Commander precons, card packages and the Moxle game.', 'Moxfield — сучасний конструктор колод для Magic: The Gathering. Він підтримує всі офіційні сконструйовані формати — Commander/EDH, Modern, Standard, Pioneer, Legacy — і кілька форматів спільноти. Можна шукати колоди, карти й авторів із розширеним пошуком, переглядати прекони Commander та інші прекони, тематичні пакети карт і стежити за улюбленими творцями контенту. Є щоденна гра Moxle. Підтримка на Patreon прибирає рекламу й відкриває додаткові можливості.', 'Moxfield is a modern deck builder for Magic: The Gathering. It supports all official constructed formats (Commander/EDH, Modern, Standard, Pioneer, Legacy) plus some community-driven ones. You can search decks, cards and brewers with advanced search, browse Commander and other precons and card packages, and follow your favourite creators. There is also the daily Moxle game. Supporting on Patreon removes ads and unlocks extras.', 'Конструктор колод MTG
Усі офіційні формати й Commander
Пошук колод, карт і авторів
Прекони й пакети карт
Patreon без реклами', 'MTG deck builder
All official formats and Commander
Search decks, cards and brewers
Precons and card packages
Ad-free with Patreon', 'Гравці Magic: The Gathering, які збирають колоди для турнірів і Commander.', 'Magic: The Gathering players building decks for events and Commander.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moxfield.com' OR LOWER(`name`) = LOWER('Moxfield')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Moxfield is a modern Magic: The Gathering deck builder for all official constructed formats and some community ones: search decks, cards and brewers, Commander precons, card packages and the Moxle game.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Moxfield is a modern deck builder for Magic: The Gathering. It supports all official constructed formats (Commander/EDH, Modern, Standard, Pioneer, Legacy) plus some community-driven ones. You can search decks, cards and brewers with advanced search, browse Commander and other precons and card packages, and follow your favourite creators. There is also the daily Moxle game. Supporting on Patreon removes ads and unlocks extras.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'MTG deck builder
All official formats and Commander
Search decks, cards and brewers
Precons and card packages
Ad-free with Patreon', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Magic: The Gathering players building decks for events and Commander.', 'manual' FROM DUAL WHERE @new = 1;

-- MSI Afterburner — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'msi.com/landing/afterburner/graphics-cards' OR LOWER(`name`) = LOWER('MSI Afterburner'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MSI Afterburner', NULL, 'https://www.msi.com/Landing/afterburner/graphics-cards', NULL, NULL, 'MSI Afterburner — безкоштовна утиліта для розгону й андервольтингу відеокарт будь-якого бренду з моніторингом заліза в реальному часі; завантажувати її варто лише з msi.com або Guru3D.', 'MSI Afterburner is a free utility for overclocking and undervolting graphics cards of any brand, with real-time hardware monitoring; download it only from msi.com or Guru3D.', 'MSI Afterburner — найпоширеніша програма для відеокарт: надійна, працює з картами будь-яких брендів, дає повний контроль і дозволяє моніторити залізо в реальному часі. Інструменти розгону й андервольтингу допомагають безпечно дослідити межі відеокарти; на сайті є відеоінструкції. Програма повністю безкоштовна. MSI попереджає про фішингові сайти, що маскуються під Afterburner: справжня програма доступна лише на msi.com і Guru3D.', 'MSI Afterburner is the most used graphics card software: reliable, works with cards from any brand, gives full control and lets you monitor hardware in real time. Overclocking and undervolting tools help you safely explore your GPU''s limits, with video walkthroughs on the site. It is completely free. MSI warns about phishing sites posing as Afterburner: the genuine app is only on msi.com and Guru3D.', 'Розгін і андервольтинг GPU
Моніторинг заліза в реальному часі
Відеокарти будь-яких брендів
Відеоінструкції
Безкоштовно', 'GPU overclocking and undervolting
Real-time hardware monitoring
Any GPU brand
Video walkthroughs
Free', 'Геймери, які налаштовують продуктивність ПК.', 'Gamers tuning PC performance.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'msi.com/landing/afterburner/graphics-cards' OR LOWER(`name`) = LOWER('MSI Afterburner')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'MSI Afterburner is a free utility for overclocking and undervolting graphics cards of any brand, with real-time hardware monitoring; download it only from msi.com or Guru3D.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MSI Afterburner is the most used graphics card software: reliable, works with cards from any brand, gives full control and lets you monitor hardware in real time. Overclocking and undervolting tools help you safely explore your GPU''s limits, with video walkthroughs on the site. It is completely free. MSI warns about phishing sites posing as Afterburner: the genuine app is only on msi.com and Guru3D.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'GPU overclocking and undervolting
Real-time hardware monitoring
Any GPU brand
Video walkthroughs
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers tuning PC performance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для будь-яких відеокарт', 'For any graphics card' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For any graphics card', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MTGGoldfish — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mtggoldfish.com' OR LOWER(`name`) = LOWER('MTGGoldfish'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MTGGoldfish', NULL, 'https://www.mtggoldfish.com', NULL, NULL, 'MTGGoldfish — ціни на карти Magic: The Gathering і Magic Online, популярні колоди й метагейм за форматами, турніри, статті, інструменти для колекції та цінові сповіщення.', 'MTGGoldfish tracks Magic: The Gathering and Magic Online card prices, popular decks and metagame by format, tournaments, articles, collection tools and price alerts.', 'MTGGoldfish — ресурс про ціни, колоди й стратегію Magic: The Gathering. Розділ карт показує сети, популярні ціни й карти, що найбільше подорожчали чи подешевшали. Розділ колод — популярні колоди й частку в метагеймі для Standard, Modern, Pioneer, Legacy, Commander та інших форматів із вартістю в паперовій версії й Magic Online. Також є колоди користувачів, конструктор і оцінка вартості колоди, турніри, статті й відео. Інструменти включають колекцію, мої колоди й цінові сповіщення. Premium прибирає рекламу й додає функції на кшталт імпорту колекції та історії цін за $6 на місяць.', 'MTGGoldfish is a resource for Magic: The Gathering prices, decks and strategy. The cards section shows sets, popular prices and the biggest price movers. The decks section lists popular decks and metagame share for Standard, Modern, Pioneer, Legacy, Commander and more, with tabletop and Magic Online costs. There are user-submitted decks, a deck builder and deck pricing, tournaments, articles and videos. Tools include collection, my decks and price alerts. Premium removes ads and adds features like collection import and price history downloads for $6 per month.', 'Ціни на карти й зміни цін
Метагейм і популярні колоди
Вартість колоди: папір і MTGO
Турніри й статті
Колекція й цінові сповіщення
Premium за $6/міс', 'Card prices and price movers
Metagame and popular decks
Deck cost: tabletop and MTGO
Tournaments and articles
Collection and price alerts
Premium at $6/mo', 'Гравці й колекціонери Magic: The Gathering.', 'Magic: The Gathering players and collectors.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mtggoldfish.com' OR LOWER(`name`) = LOWER('MTGGoldfish')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'MTGGoldfish tracks Magic: The Gathering and Magic Online card prices, popular decks and metagame by format, tournaments, articles, collection tools and price alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MTGGoldfish is a resource for Magic: The Gathering prices, decks and strategy. The cards section shows sets, popular prices and the biggest price movers. The decks section lists popular decks and metagame share for Standard, Modern, Pioneer, Legacy, Commander and more, with tabletop and Magic Online costs. There are user-submitted decks, a deck builder and deck pricing, tournaments, articles and videos. Tools include collection, my decks and price alerts. Premium removes ads and adds features like collection import and price history downloads for $6 per month.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Card prices and price movers
Metagame and popular decks
Deck cost: tabletop and MTGO
Tournaments and articles
Collection and price alerts
Premium at $6/mo', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Magic: The Gathering players and collectors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Ціни, колоди й статті з рекламою', 'Prices, decks and articles with ads' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Prices, decks and articles with ads', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium', 'Premium', 6.00, 'month', 'Без реклами, імпорт колекції, історія цін; 30 днів гарантії повернення', 'No ads, collection import, price history; 30-day money-back guarantee' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'No ads, collection import, price history; 30-day money-back guarantee', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mudfish — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mudfish.net' OR LOWER(`name`) = LOWER('Mudfish'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mudfish', NULL, 'https://mudfish.net', NULL, NULL, 'Mudfish — VPN для ігор і вебу з налаштуванням маршрутів: клієнт для Windows, macOS і Linux, застосунки для Android та iOS і розширення для браузерів; оплата за використаний трафік.', 'Mudfish is a VPN for games and the web with configurable routes: a client for Windows, macOS and Linux, Android and iOS apps and browser extensions, with usage-based pricing.', 'Mudfish пропонує продукти для різних пристроїв. Mudfish Cloud VPN для Windows, macOS і Linux дозволяє налаштовувати маршрути для ігор і сайтів на ПК, мобільні застосунки працюють на Android та iOS, а розширення для Chrome, Firefox, Edge і Whale спрямовують веб-трафік через проксі. Можливості й обсяг трафіку залежать від продукту. Є таблиця порівняння, статус вузлів, документація, форум і інструменти на кшталт тесту пінгу та перевірки IP. Ціни залежать від використання, мінімальний платіж починається від центів на місяць.', 'Mudfish offers products for different devices. Mudfish Cloud VPN for Windows, macOS and Linux lets you configure routes for games and websites on your PC, mobile apps run on Android and iOS, and extensions for Chrome, Firefox, Edge and Whale route web traffic through a proxy. Features and traffic handled vary by product. There is a comparison table, node status, documentation, a forum and tools like a ping test and IP check. Pricing is usage-based, starting from cents per month.', 'VPN для ігор із налаштуванням маршрутів
Windows, macOS і Linux
Android та iOS
Розширення для браузерів
Оплата за використання', 'Game VPN with route configuration
Windows, macOS and Linux
Android and iOS
Browser extensions
Usage-based pricing', 'Гравці, які грають на віддалених серверах.', 'Players connecting to distant servers.', 'desktop,mobile,web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mudfish.net' OR LOWER(`name`) = LOWER('Mudfish')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mudfish is a VPN for games and the web with configurable routes: a client for Windows, macOS and Linux, Android and iOS apps and browser extensions, with usage-based pricing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mudfish offers products for different devices. Mudfish Cloud VPN for Windows, macOS and Linux lets you configure routes for games and websites on your PC, mobile apps run on Android and iOS, and extensions for Chrome, Firefox, Edge and Whale route web traffic through a proxy. Features and traffic handled vary by product. There is a comparison table, node status, documentation, a forum and tools like a ping test and IP check. Pricing is usage-based, starting from cents per month.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Game VPN with route configuration
Windows, macOS and Linux
Android and iOS
Browser extensions
Usage-based pricing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Players connecting to distant servers.', 'manual' FROM DUAL WHERE @new = 1;

-- Mumble — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mumble.info' OR LOWER(`name`) = LOWER('Mumble'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mumble', NULL, 'https://www.mumble.info', NULL, NULL, 'Mumble — безкоштовний голосовий чат із відкритим кодом, низькою затримкою й високою якістю звуку; ви запускаєте власний сервер і повністю контролюєте спілкування команди.', 'Mumble is a free, open-source, low-latency, high-quality voice chat app; you run your own server and keep full control of team communication.', 'Mumble — проєкт голосового чату з відкритим кодом, що поєднує низьку затримку й високу якість звуку. Програма безкоштовна, її можна завантажити з офіційного сайту, а для спілкування команди розгортається власний сервер. Проєкт розвиває спільнота: у блозі виходять новини релізів і гостьові пости, зокрема про пошук і виправлення вразливостей, а розділи документації й «Contribute» пояснюють, як долучитися навіть тим, хто не є сильним програмістом.', 'Mumble is an open-source voice chat project combining low latency with high audio quality. It is free to download from the official site, and teams run their own server to communicate. The project is community-driven: the blog covers releases and guest posts, including on finding and fixing vulnerabilities, and the documentation and Contribute pages explain how to help even if you are not a strong coder.', 'Низька затримка
Висока якість звуку
Власний сервер
Відкритий код
Безкоштовно', 'Low latency
High audio quality
Self-hosted server
Open source
Free', 'Команди й клани, яким потрібен приватний голосовий зв''язок.', 'Teams and clans needing private voice chat.', 'desktop,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mumble.info' OR LOWER(`name`) = LOWER('Mumble')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mumble is a free, open-source, low-latency, high-quality voice chat app; you run your own server and keep full control of team communication.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mumble is an open-source voice chat project combining low latency with high audio quality. It is free to download from the official site, and teams run their own server to communicate. The project is community-driven: the blog covers releases and guest posts, including on finding and fixing vulnerabilities, and the documentation and Contribute pages explain how to help even if you are not a strong coder.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Low latency
High audio quality
Self-hosted server
Open source
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teams and clans needing private voice chat.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий код', 'Open source' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Nightbot — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nightbot.tv' OR LOWER(`name`) = LOWER('Nightbot'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nightbot', NULL, 'https://nightbot.tv', NULL, NULL, 'Nightbot — чат-бот для стримерів, що автоматизує повідомлення в живому чаті: команди-відповіді, автоматична модерація спаму, заплановані оголошення та інші базові інструменти.', 'Nightbot is a streamer chatbot that automates live chat: command replies, automatic spam moderation, scheduled announcements and other essentials.', 'Nightbot — базовий інструмент стримера для автоматизації повідомлень у живому чаті, модерації тощо. Замість того, щоб повторювати одне й те саме, можна прив''язати повідомлення до команди, наприклад !uptime, і бот відповідатиме сам. Розширені фільтри автоматично прибирають різні види спаму, щоб чат лишався чистим і безпечним. Заплановані оголошення надсилаються з заданим інтервалом — наприклад, запрошення в Discord чи на YouTube-канал. Бот додається в чат кількома кліками.', 'Nightbot is an essential streamer tool for automating live chat messages, moderation and more. Instead of repeating yourself, link a message to a command such as !uptime and the bot replies for you. Advanced chat filters automatically remove many kinds of spam to keep chat clean and safe. Scheduled announcements are sent at set intervals, for example invitations to your Discord or YouTube channel. You add the bot to chat in a few clicks.', 'Команди з автоматичними відповідями
Автоматична модерація спаму
Заплановані оголошення
Додавання в чат кількома кліками', 'Commands with automatic replies
Automatic spam moderation
Scheduled announcements
Add to chat in a few clicks', 'Стримери на Twitch і YouTube.', 'Twitch and YouTube streamers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nightbot.tv' OR LOWER(`name`) = LOWER('Nightbot')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Nightbot is a streamer chatbot that automates live chat: command replies, automatic spam moderation, scheduled announcements and other essentials.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Nightbot is an essential streamer tool for automating live chat messages, moderation and more. Instead of repeating yourself, link a message to a command such as !uptime and the bot replies for you. Advanced chat filters automatically remove many kinds of spam to keep chat clean and safe. Scheduled announcements are sent at set intervals, for example invitations to your Discord or YouTube channel. You add the bot to chat in a few clicks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Commands with automatic replies
Automatic spam moderation
Scheduled announcements
Add to chat in a few clicks', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Twitch and YouTube streamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Чат-бот для стримів', 'Stream chatbot' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Stream chatbot', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Noesis — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'noesis.gg' OR LOWER(`name`) = LOWER('Noesis'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Noesis', NULL, 'https://www.noesis.gg', NULL, NULL, 'Noesis — онлайн-переглядач і аналітика демо Counter-Strike 2: інтерактивний 2D-повтор раундів, позиції, гранати, вбивства й теплові карти. Ним користуються аналітики професійних команд.', 'Noesis is an online Counter-Strike 2 demo viewer and analytics tool: interactive 2D round replays, positions, grenades, kills and heatmaps, used by analysts of pro teams.', 'Noesis — онлайн-інструмент, що дозволяє завантажувати, переглядати й аналізувати демо CS2. Переглядач відтворює раунди у 2D, показує позиції гравців, використання гранат і вбивства, будує теплові карти тощо. Сервіс економить час на розборі демо, залишаючи більше часу на вдосконалення. У відгуках на сайті аналітик G2 розповідає, що використовує Noesis для кожного аналізу суперника перед грою, а тренер і коментатор — що переглядає матчі на ноутбуці під час виїзних турнірів. Є також стратегічна дошка, академія з навчальними матеріалами й 14-денний безкоштовний пробний період без банківської картки.', 'Noesis is an online tool to upload, review and analyse CS2 demos. The viewer replays rounds in 2D, shows player positions, utility usage and kills, builds heatmaps and more. It saves time on demo review, leaving more time to improve. In testimonials on the site, a G2 analyst says he uses Noesis for every pre-game opponent analysis, and a coach and broadcaster reviews matches on a laptop while travelling to events. There is also a strategy board, an academy with learning materials and a 14-day free trial with no credit card needed.', '2D-повтор раундів CS2
Позиції, гранати й вбивства
Теплові карти
Аналіз суперників перед грою
Стратегічна дошка
14 днів безкоштовно', '2D CS2 round replays
Positions, grenades and kills
Heatmaps
Opponent analysis before games
Strategy board
14-day free trial', 'Гравці, тренери й аналітики команд CS2.', 'CS2 players, coaches and team analysts.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'noesis.gg' OR LOWER(`name`) = LOWER('Noesis')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Noesis is an online Counter-Strike 2 demo viewer and analytics tool: interactive 2D round replays, positions, grenades, kills and heatmaps, used by analysts of pro teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Noesis is an online tool to upload, review and analyse CS2 demos. The viewer replays rounds in 2D, shows player positions, utility usage and kills, builds heatmaps and more. It saves time on demo review, leaving more time to improve. In testimonials on the site, a G2 analyst says he uses Noesis for every pre-game opponent analysis, and a coach and broadcaster reviews matches on a laptop while travelling to events. There is also a strategy board, an academy with learning materials and a 14-day free trial with no credit card needed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '2D CS2 round replays
Positions, grenades and kills
Heatmaps
Opponent analysis before games
Strategy board
14-day free trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'CS2 players, coaches and team analysts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Free trial', 0.00, 'free', '14 днів, без банківської картки', '14 days, no credit card needed' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний період' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '14 days, no credit card needed', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- NoPing — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'noping.com' OR LOWER(`name`) = LOWER('NoPing'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NoPing', NULL, 'https://www.noping.com', NULL, NULL, 'NoPing — ігровий бустер: до 80% нижчий пінг і до 110% більше FPS у понад 3000 іграх завдяки AI-маршрутизації, понад 2000 серверів у 150+ країнах; 1 день безкоштовно без картки.', 'NoPing is a game booster promising up to 80% lower ping and up to 110% more FPS in 3,000+ games with AI smart routing, 2,000+ servers in 150+ countries, and a 1-day free trial with no card.', 'NoPing обіцяє знизити високий пінг, прибрати лаги й підвищити FPS в онлайн-іграх: за даними компанії — до 80% менше пінгу й до 110% більше FPS у понад 3000 іграх. Технологія з AI й розумною маршрутизацією працює через понад 2000 серверів у більш ніж 150 країнах; сервісом користуються понад 3 млн гравців, зокрема професіонали. Оновлений інтерфейс, полегшена версія Lite, більше серверів і переглянуті функції покращують продуктивність ПК і стабільність з''єднання. Доступно для Windows, Android та iOS, є безкоштовний пробний день без банківської картки.', 'NoPing aims to lower high ping, kill lag and boost FPS in online games: the company claims up to 80% less ping and up to 110% more FPS in 3,000+ games. AI-powered smart routing runs over 2,000+ servers in 150+ countries, used by 3M+ players including pros. A redesigned interface, a Lite version, more servers and revamped features improve PC performance and connection stability. It is available for Windows, Android and iOS, with a 1-day free trial and no credit card.', 'Нижчий пінг і вищий FPS
AI-маршрутизація
3000+ ігор
2000+ серверів у 150+ країнах
Windows, Android та iOS
1 день безкоштовно', 'Lower ping and higher FPS
AI smart routing
3,000+ games
2,000+ servers in 150+ countries
Windows, Android and iOS
1-day free trial', 'Онлайн-гравці з високим пінгом.', 'Online players with high ping.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'noping.com' OR LOWER(`name`) = LOWER('NoPing')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'NoPing is a game booster promising up to 80% lower ping and up to 110% more FPS in 3,000+ games with AI smart routing, 2,000+ servers in 150+ countries, and a 1-day free trial with no card.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NoPing aims to lower high ping, kill lag and boost FPS in online games: the company claims up to 80% less ping and up to 110% more FPS in 3,000+ games. AI-powered smart routing runs over 2,000+ servers in 150+ countries, used by 3M+ players including pros. A redesigned interface, a Lite version, more servers and revamped features improve PC performance and connection stability. It is available for Windows, Android and iOS, with a 1-day free trial and no credit card.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Lower ping and higher FPS
AI smart routing
3,000+ games
2,000+ servers in 150+ countries
Windows, Android and iOS
1-day free trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Online players with high ping.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Free trial', 0.00, 'free', '1 день без банківської картки', '1 day, no credit card' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний період' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '1 day, no credit card', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- NVIDIA App — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nvidia.com/en-us/software/nvidia-app' OR LOWER(`name`) = LOWER('NVIDIA App'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NVIDIA App', NULL, 'https://www.nvidia.com/en-us/software/nvidia-app/', NULL, NULL, 'NVIDIA App — компаньйон для геймерів і творців на ПК з GeForce: драйвери Game Ready і Studio, оновлення DLSS в іграх, центр керування GPU, оптимізація налаштувань ігор і запис ShadowPlay в оверлеї.', 'NVIDIA App is the companion for PC gamers and creators with GeForce: Game Ready and Studio drivers, DLSS updates in games, a GPU control center, game settings optimization and ShadowPlay recording in the overlay.', 'NVIDIA App підтримує ПК в актуальному стані з найновішими драйверами й технологіями NVIDIA. Драйвери Game Ready налаштовуються разом із розробниками й тестуються, щоб забезпечити найкращий досвід у день виходу гри, а драйвери Studio — стабільність для творців. Застосунок дозволяє оновлювати сотні ігор до новітніх функцій DLSS, зокрема Multi Frame Generation. Єдиний центр керування GPU дає змогу змінювати налаштування NVIDIA, вмикати DLSS Override і Smooth Motion, отримувати персональні налаштування ігор на основі хмарних даних та моніторити й автоматично розганяти GPU одним кліком. Запис відео й скриншотів ShadowPlay доступний через внутрішньоігровий оверлей.', 'NVIDIA App keeps your PC up to date with the latest NVIDIA drivers and technology. Game Ready drivers are tuned with developers and tested to deliver the best experience on game release day, while Studio drivers give creators reliability. The app can update hundreds of games to the latest DLSS features, including Multi Frame Generation. A unified GPU control center lets you change NVIDIA settings, enable DLSS Override and Smooth Motion, get personalized game settings based on cloud data, and monitor and auto-tune your GPU in one click. ShadowPlay video and screenshot recording is available through the in-game overlay.', 'Драйвери Game Ready і Studio
Оновлення DLSS в іграх
Центр керування GPU
Оптимізація налаштувань ігор
Запис ShadowPlay в оверлеї
Автоматичний розгін GPU', 'Game Ready and Studio drivers
DLSS updates in games
GPU control center
Game settings optimization
ShadowPlay recording in the overlay
Automatic GPU tuning', 'Геймери й творці з відеокартами NVIDIA.', 'Gamers and creators with NVIDIA GPUs.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nvidia.com/en-us/software/nvidia-app' OR LOWER(`name`) = LOWER('NVIDIA App')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'NVIDIA App is the companion for PC gamers and creators with GeForce: Game Ready and Studio drivers, DLSS updates in games, a GPU control center, game settings optimization and ShadowPlay recording in the overlay.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NVIDIA App keeps your PC up to date with the latest NVIDIA drivers and technology. Game Ready drivers are tuned with developers and tested to deliver the best experience on game release day, while Studio drivers give creators reliability. The app can update hundreds of games to the latest DLSS features, including Multi Frame Generation. A unified GPU control center lets you change NVIDIA settings, enable DLSS Override and Smooth Motion, get personalized game settings based on cloud data, and monitor and auto-tune your GPU in one click. ShadowPlay video and screenshot recording is available through the in-game overlay.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Game Ready and Studio drivers
DLSS updates in games
GPU control center
Game settings optimization
ShadowPlay recording in the overlay
Automatic GPU tuning', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers and creators with NVIDIA GPUs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для відеокарт NVIDIA', 'For NVIDIA GPUs' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For NVIDIA GPUs', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- NVIDIA Broadcast — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nvidia.com/en-us/geforce/broadcasting/broadcast-app' OR LOWER(`name`) = LOWER('NVIDIA Broadcast'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NVIDIA Broadcast', NULL, 'https://www.nvidia.com/en-us/geforce/broadcasting/broadcast-app/', NULL, NULL, 'NVIDIA Broadcast — застосунок з AI-ефектами для голосу й відео на GeForce RTX: прибирання шуму й луни, Studio Voice, віртуальний фон, освітлення обличчя, Eye Contact і Auto Frame для стримів і дзвінків.', 'NVIDIA Broadcast is an app with AI voice and video effects on GeForce RTX: noise and echo removal, Studio Voice, virtual background, face relighting, Eye Contact and Auto Frame for streams and calls.', 'NVIDIA Broadcast перетворює стрими, голосові чати й відеодзвінки за допомогою AI-ефектів. Noise Removal і Room Echo Removal одним натисканням прибирають фоновий шум і луну, а Studio Voice покращує звук мікрофона до студійного рівня. Віртуальний фон дозволяє видалити, замінити чи розмити фон без зеленого екрана, Virtual Key Light автоматично освітлює обличчя, Eye Contact створює враження погляду в камеру, Video Noise Removal очищає картинку при слабкому світлі, а Auto Frame стежить за рухом і кадрує зображення. Застосунок працює з популярними програмами: достатньо обрати NVIDIA Broadcast як пристрій у потрібному застосунку. Для роботи потрібна відеокарта GeForce RTX.', 'NVIDIA Broadcast transforms livestreams, voice chats and video calls with AI effects. Noise Removal and Room Echo Removal eliminate background noise and echo at the touch of a button, and Studio Voice upgrades your mic to studio-like quality. Virtual background removes, replaces or blurs your background without a green screen, Virtual Key Light relights your face automatically, Eye Contact makes it look like you are looking at the camera, Video Noise Removal cleans up low-light video, and Auto Frame tracks your movement and crops the shot. It works with your favourite apps: just select NVIDIA Broadcast as the device in the app. A GeForce RTX GPU is required.', 'Прибирання шуму й луни
Studio Voice
Віртуальний фон без зеленого екрана
Virtual Key Light і Eye Contact
Auto Frame
Потрібна GeForce RTX', 'Noise and echo removal
Studio Voice
Virtual background without green screen
Virtual Key Light and Eye Contact
Auto Frame
Requires GeForce RTX', 'Стримери й геймери з відеокартами GeForce RTX.', 'Streamers and gamers with GeForce RTX GPUs.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nvidia.com/en-us/geforce/broadcasting/broadcast-app' OR LOWER(`name`) = LOWER('NVIDIA Broadcast')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'NVIDIA Broadcast is an app with AI voice and video effects on GeForce RTX: noise and echo removal, Studio Voice, virtual background, face relighting, Eye Contact and Auto Frame for streams and calls.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NVIDIA Broadcast transforms livestreams, voice chats and video calls with AI effects. Noise Removal and Room Echo Removal eliminate background noise and echo at the touch of a button, and Studio Voice upgrades your mic to studio-like quality. Virtual background removes, replaces or blurs your background without a green screen, Virtual Key Light relights your face automatically, Eye Contact makes it look like you are looking at the camera, Video Noise Removal cleans up low-light video, and Auto Frame tracks your movement and crops the shot. It works with your favourite apps: just select NVIDIA Broadcast as the device in the app. A GeForce RTX GPU is required.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Noise and echo removal
Studio Voice
Virtual background without green screen
Virtual Key Light and Eye Contact
Auto Frame
Requires GeForce RTX', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Streamers and gamers with GeForce RTX GPUs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для власників GeForce RTX', 'For GeForce RTX owners' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For GeForce RTX owners', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- OpenDota — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'opendota.com' OR LOWER(`name`) = LOWER('OpenDota'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OpenDota', NULL, 'https://www.opendota.com', NULL, NULL, 'OpenDota — безкоштовна платформа даних Dota 2 з відкритим кодом: детальна статистика матчів із розбору повторів, герої, команди, дослідник даних, рекорди та відкритий API.', 'OpenDota is a free, open-source Dota 2 data platform: detailed match data from parsed replays, heroes, teams, a data explorer, records and an open API.', 'OpenDota — платформа даних Dota 2, увесь код якої відкритий, тож будь-хто може покращувати й змінювати проєкт. Розбір файлів повторів дає дуже детальні дані про матчі. Сервери фінансують спонсори, а код підтримують волонтери, тому сервіс безкоштовний. На сайті є запит на розбір матчу, розділи матчів, героїв і команд, дослідник даних, комбінації героїв, медалі, рекорди й сценарії, а також документований API для розробників.', 'OpenDota is a Dota 2 data platform whose code is fully open source, so contributors can improve and modify it. Parsing replay files provides highly detailed match data. Servers are funded by sponsors and the code is maintained by volunteers, so the service is free of charge. The site offers match parse requests, matches, heroes and teams sections, a data explorer, hero combos, medals, records and scenarios, plus a documented API for developers.', 'Відкритий код проєкту
Детальні дані з розбору повторів
Дослідник даних і рекорди
Герої, команди й комбінації
Відкритий API
Безкоштовно', 'Open-source code
Detailed data from parsed replays
Data explorer and records
Heroes, teams and combos
Open API
Free of charge', 'Гравці Dota 2, аналітики й розробники, яким потрібні відкриті дані.', 'Dota 2 players, analysts and developers who need open data.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'opendota.com' OR LOWER(`name`) = LOWER('OpenDota')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'OpenDota is a free, open-source Dota 2 data platform: detailed match data from parsed replays, heroes, teams, a data explorer, records and an open API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'OpenDota is a Dota 2 data platform whose code is fully open source, so contributors can improve and modify it. Parsing replay files provides highly detailed match data. Servers are funded by sponsors and the code is maintained by volunteers, so the service is free of charge. The site offers match parse requests, matches, heroes and teams sections, a data explorer, hero combos, medals, records and scenarios, plus a documented API for developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Open-source code
Detailed data from parsed replays
Data explorer and records
Heroes, teams and combos
Open API
Free of charge', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dota 2 players, analysts and developers who need open data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс фінансують спонсори', 'Funded by sponsors' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Funded by sponsors', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Oracle's Elixir — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oracleselixir.com' OR LOWER(`name`) = LOWER('Oracle''s Elixir'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Oracle''s Elixir', NULL, 'https://oracleselixir.com', NULL, NULL, 'Oracle''s Elixir — поглиблена статистика кіберспорту League of Legends з 2015 року: аналітика гравців, команд і чемпіонів професійних ліг, якою користуються тренери, аналітики й коментатори.', 'Oracle''s Elixir has provided advanced League of Legends esports stats since 2015: player, team and champion analytics for pro leagues, used by coaches, analysts and broadcasters.', 'Oracle''s Elixir позиціонує себе як головне джерело поглибленої статистики кіберспорту League of Legends. З 2015 року його дані й аналітику використовують професійні тренери, аналітики, коментатори, журналісти, гравці фентезі-ліг і віддані вболівальники; показники сайту регулярно з''являються в трансляціях і медіа. Тут зібрано детальну аналітику гравців, команд і чемпіонів для LCS, LEC, LCK, LPL та інших професійних ліг. Є розклад і результати матчів, блог, подкаст, розділ інструментів і завантажень та глосарій показників.', 'Oracle''s Elixir positions itself as the premier source for advanced League of Legends esports stats. Since 2015 its data and analysis have been used by pro coaches, analysts, broadcasters, writers, daily fantasy players and hardcore fans, and its metrics regularly appear on broadcasts and in media coverage. It offers in-depth player, team and champion analytics for the LCS, LEC, LCK, LPL and other pro leagues. There are match schedules and results, a blog, a podcast, a tools and downloads section and a definitions glossary.', 'Поглиблена статистика гравців і команд
Аналітика чемпіонів у професійних іграх
LCS, LEC, LCK, LPL та інші ліги
Розклад і результати матчів
Інструменти й завантаження даних
Глосарій показників', 'Advanced player and team stats
Champion analytics from pro games
LCS, LEC, LCK, LPL and more leagues
Match schedule and results
Tools and data downloads
Stat definitions glossary', 'Тренери, аналітики, коментатори та уболівальники кіберспорту LoL.', 'LoL esports coaches, analysts, broadcasters and fans.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oracleselixir.com' OR LOWER(`name`) = LOWER('Oracle''s Elixir')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Oracle''s Elixir has provided advanced League of Legends esports stats since 2015: player, team and champion analytics for pro leagues, used by coaches, analysts and broadcasters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Oracle''s Elixir positions itself as the premier source for advanced League of Legends esports stats. Since 2015 its data and analysis have been used by pro coaches, analysts, broadcasters, writers, daily fantasy players and hardcore fans, and its metrics regularly appear on broadcasts and in media coverage. It offers in-depth player, team and champion analytics for the LCS, LEC, LCK, LPL and other pro leagues. There are match schedules and results, a blog, a podcast, a tools and downloads section and a definitions glossary.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Advanced player and team stats
Champion analytics from pro games
LCS, LEC, LCK, LPL and more leagues
Match schedule and results
Tools and data downloads
Stat definitions glossary', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'LoL esports coaches, analysts, broadcasters and fans.', 'manual' FROM DUAL WHERE @new = 1;

-- osu! — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'osu.ppy.sh' OR LOWER(`name`) = LOWER('osu!'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'osu!', NULL, 'https://osu.ppy.sh', NULL, NULL, 'osu! — безкоштовна ритм-гра зі змагальною спільнотою: бітмапи від гравців, глобальні й національні рейтинги, рейтингова гра, щоденні челенджі, турніри, конкурси й живі трансляції.', 'osu! is a free rhythm game with a competitive community: player-made beatmaps, global and country rankings, ranked play, daily challenges, tournaments, contests and live streams.', 'osu! — ритм-гра з великою змагальною спільнотою. Гравці завантажують і створюють бітмапи, проходять їх і змагаються в глобальних, національних і командних рейтингах та в топі найкращих проходжень. Є рейтингова гра, плейлисти й щоденний челендж. Спільнота має форум, чат, конкурси, турніри та живі трансляції, а також вікі, FAQ і правила. Гра безкоштовна; на сайті є магазин і журнал змін розробки, інтерфейс перекладено десятками мов.', 'osu! is a rhythm game with a large competitive community. Players download and create beatmaps, play them and compete in global, country and team rankings and top plays. There is ranked play, playlists and a daily challenge. The community has a forum, chat, contests, tournaments and live streams, plus a wiki, FAQ and rules. The game is free; the site has a store and a development changelog, and the interface is translated into dozens of languages.', 'Бітмапи від спільноти
Глобальні й національні рейтинги
Рейтингова гра й щоденний челендж
Турніри й конкурси
Безкоштовна гра', 'Community beatmaps
Global and country rankings
Ranked play and daily challenge
Tournaments and contests
Free to play', 'Гравці ритм-ігор і учасники турнірів osu!.', 'Rhythm game players and osu! tournament players.', 'desktop,web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'osu.ppy.sh' OR LOWER(`name`) = LOWER('osu!')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'osu! is a free rhythm game with a competitive community: player-made beatmaps, global and country rankings, ranked play, daily challenges, tournaments, contests and live streams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'osu! is a rhythm game with a large competitive community. Players download and create beatmaps, play them and compete in global, country and team rankings and top plays. There is ranked play, playlists and a daily challenge. The community has a forum, chat, contests, tournaments and live streams, plus a wiki, FAQ and rules. The game is free; the site has a store and a development changelog, and the interface is translated into dozens of languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Community beatmaps
Global and country rankings
Ranked play and daily challenge
Tournaments and contests
Free to play', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Rhythm game players and osu! tournament players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовна гра', 'Free to play' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free to play', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Outplayed — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'outplayed.tv' OR LOWER(`name`) = LOWER('Outplayed'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Outplayed', NULL, 'https://outplayed.tv', NULL, NULL, 'Outplayed від Overwolf — застосунок для запису ігрових моментів: автоматично зберігає найкращі епізоди, показує їх на таймлайні матчу, має відеоредактор і відстеження продуктивності; понад 50 ігор.', 'Outplayed by Overwolf is a game capture app: it automatically saves your best moments, shows them on a match timeline and offers a video editor and performance tracking for 50+ games.', 'Outplayed — застосунок для запису відео для геймерів. Під час гри він автоматично фіксує найкращі моменти й найсильніші розіграші, а також записує вручну за запитом. Після матчу кліпи можна переглянути на таймлайні, оцінити швидкість APM і пережити гру знову. Улюблені кліпи легко обрізати або об''єднати у відеоредакторі в епічну нарізку й поділитися в соцмережах. Outplayed підтримує понад 50 ігор, має понад 16 мільйонів завантажень і оцінку 4,6. Застосунок безкоштовний із рекламою, є підписка.', 'Outplayed is a video capture app for gamers. While you play it automatically captures your best moments and biggest plays, and also records manually on demand. After the match you can browse clips on the match timeline, review your APM and relive the game. Trim favourite clips or combine them in the video editor into an epic montage and share across social networks. Outplayed supports 50+ games, has 16M+ downloads and a 4.6 rating. It is free with ads, and a subscription is available.', 'Автоматичний запис найкращих моментів
Таймлайн матчу
Відеоредактор
Відстеження продуктивності й APM
50+ ігор', 'Automatic best-moment capture
Match timeline
Video editor
Performance and APM tracking
50+ games', 'Гравці на ПК, які записують і публікують хайлайти.', 'PC gamers recording and posting highlights.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'outplayed.tv' OR LOWER(`name`) = LOWER('Outplayed')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Outplayed by Overwolf is a game capture app: it automatically saves your best moments, shows them on a match timeline and offers a video editor and performance tracking for 50+ games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Outplayed is a video capture app for gamers. While you play it automatically captures your best moments and biggest plays, and also records manually on demand. After the match you can browse clips on the match timeline, review your APM and relive the game. Trim favourite clips or combine them in the video editor into an epic montage and share across social networks. Outplayed supports 50+ games, has 16M+ downloads and a 4.6 rating. It is free with ads, and a subscription is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automatic best-moment capture
Match timeline
Video editor
Performance and APM tracking
50+ games', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC gamers recording and posting highlights.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'З рекламою', 'With ads' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'With ads', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Overwolf — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'overwolf.com' OR LOWER(`name`) = LOWER('Overwolf'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Overwolf', NULL, 'https://www.overwolf.com', NULL, NULL, 'Overwolf — платформа внутрішньоігрових застосунків і модів: магазин застосунків-компаньйонів, моди й аддони, ігрові сервери, а для творців — інструменти розробки, монетизація й фонд підтримки.', 'Overwolf is a platform for in-game apps and mods: an app store of companion apps, mods and addons, game servers, and for creators dev tools, monetization and a creator fund.', 'Overwolf називає себе гільдією творців внутрішньоігрового контенту. Для гравців це магазин застосунків-компаньйонів, модів, аддонів і ігрових серверів, що покращують досвід у грі — на Overwolf працюють, наприклад, трекери статистики й оверлеї для популярних кіберспортивних ігор. Для творців платформа пропонує документацію з розробки десктопних застосунків і модів, інструменти монетизації застосунків, модів, серверів і сайтів та акселератор із фінансуванням. Ігрові студії можуть додавати моди й нові джерела доходу, а рекламодавці — працювати з аудиторією гравців. За даними компанії, у 2024 році творці отримали $240 млн виплат.', 'Overwolf calls itself the guild of in-game creators. For gamers it is an app store of companion apps, mods, addons and game servers that improve the in-game experience; stat trackers and overlays for popular esports titles run on Overwolf. For creators it offers documentation for building desktop apps and mods, monetization tools for apps, mods, servers and websites, and an accelerator with funding. Game studios can add mods and new revenue streams, and advertisers can reach gamers. The company reports $240 million paid out to creators in 2024.', 'Магазин застосунків-компаньйонів
Моди, аддони й сервери
Інструменти розробки застосунків
Монетизація для творців
Акселератор і фонд підтримки', 'Companion app store
Mods, addons and servers
App development tools
Monetization for creators
Accelerator and creator fund', 'Гравці на ПК, розробники застосунків і модів, ігрові студії.', 'PC gamers, app and mod developers, game studios.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'overwolf.com' OR LOWER(`name`) = LOWER('Overwolf')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Overwolf is a platform for in-game apps and mods: an app store of companion apps, mods and addons, game servers, and for creators dev tools, monetization and a creator fund.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Overwolf calls itself the guild of in-game creators. For gamers it is an app store of companion apps, mods, addons and game servers that improve the in-game experience; stat trackers and overlays for popular esports titles run on Overwolf. For creators it offers documentation for building desktop apps and mods, monetization tools for apps, mods, servers and websites, and an accelerator with funding. Game studios can add mods and new revenue streams, and advertisers can reach gamers. The company reports $240 million paid out to creators in 2024.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Companion app store
Mods, addons and servers
App development tools
Monetization for creators
Accelerator and creator fund', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC gamers, app and mod developers, game studios.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для гравців', 'For gamers' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For gamers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- OWN3D — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'own3d.tv' OR LOWER(`name`) = LOWER('OWN3D'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OWN3D', NULL, 'https://www.own3d.tv', NULL, NULL, 'OWN3D — дизайни й інструменти для стримерів: понад 900 оверлеїв і алертів для Twitch, Kick і YouTube, конструктори оверлеїв, емодзі й бейджів, інструменти для OBS та підписка Stream Pass з AI-кредитами.', 'OWN3D offers designs and tools for streamers: 900+ overlays and alerts for Twitch, Kick and YouTube, overlay, emote and badge makers, OBS tools and the Stream Pass subscription with AI credits.', 'OWN3D — місце для дизайну стриму, інструментів для OBS Studio, розширень Twitch, сервісів і туторіалів для початківців і профі. Каталог містить пакети оверлеїв для Twitch, Kick і YouTube, оверлеї для Just Chatting, IRL та ігор, алерти й звуки, панелі, банери, екрани перерви, емодзі й бейджі підписників. Конструктори дозволяють самостійно зробити оверлей, анімовані емодзі, бейджі й нагороди за бали каналу. Безкоштовний інструмент PRO допомагає налаштувати оверлеї, алерти, донати, цілі й чат-бот, а підписка Stream Pass дає 50 AI-кредитів на місяць і доступ до понад 900 оверлеїв і алертів.', 'OWN3D is a place for stream designs, OBS Studio tools, Twitch extensions, services and tutorials for beginners and pros. The catalog includes overlay packages for Twitch, Kick and YouTube, Just Chatting, IRL and game overlays, alerts and sounds, panels, banners, intermission screens, emotes and sub badges. Makers let you build your own overlay, animated emotes, badges and channel point rewards. The free PRO tool helps set up overlays, alerts, donations, goals and a chatbot, and the Stream Pass subscription gives 50 AI credits a month and access to 900+ overlays and alerts.', '900+ оверлеїв і алертів
Конструктори оверлеїв, емодзі й бейджів
Twitch, Kick і YouTube
Безкоштовний інструмент PRO
Stream Pass з AI-кредитами', '900+ overlays and alerts
Overlay, emote and badge makers
Twitch, Kick and YouTube
Free PRO tool
Stream Pass with AI credits', 'Стримери, які оформлюють канал.', 'Streamers designing their channel.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'own3d.tv' OR LOWER(`name`) = LOWER('OWN3D')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'OWN3D offers designs and tools for streamers: 900+ overlays and alerts for Twitch, Kick and YouTube, overlay, emote and badge makers, OBS tools and the Stream Pass subscription with AI credits.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'OWN3D is a place for stream designs, OBS Studio tools, Twitch extensions, services and tutorials for beginners and pros. The catalog includes overlay packages for Twitch, Kick and YouTube, Just Chatting, IRL and game overlays, alerts and sounds, panels, banners, intermission screens, emotes and sub badges. Makers let you build your own overlay, animated emotes, badges and channel point rewards. The free PRO tool helps set up overlays, alerts, donations, goals and a chatbot, and the Stream Pass subscription gives 50 AI credits a month and access to 900+ overlays and alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '900+ overlays and alerts
Overlay, emote and badge makers
Twitch, Kick and YouTube
Free PRO tool
Stream Pass with AI credits', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Streamers designing their channel.', 'manual' FROM DUAL WHERE @new = 1;

-- Parsec — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'parsec.app' OR LOWER(`name`) = LOWER('Parsec'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Parsec', NULL, 'https://parsec.app', NULL, NULL, 'Parsec — віддалений робочий стіл і ігровий стримінг 4K до 60 кадрів/с майже без затримки: підключення до ігор, роботи чи проєктів звідусіль, грати разом через інтернет, плани для команд і бізнесу.', 'Parsec is remote desktop and game streaming in 4K at up to 60 fps with near-zero latency: connect to games, work or projects from anywhere, play together online, with plans for teams and enterprise.', 'Parsec — переосмислений віддалений робочий стіл: плавна картинка 4K до 60 кадрів на секунду з майже нульовою затримкою. Він дає безпечний і гнучкий доступ до ігор, роботи чи проєктів будь-коли й звідусіль, а гравці використовують його, щоб грати разом через інтернет, наприклад у локальний мультиплеєр файтингів. На сайті показано порівняння якості картинки, плавності руху й стабільності кадрів з іншими застосунками. Для творців і професіоналів є розширені режими кольору й підтримка кількох моніторів, а плани для команд і підприємств додають звітність, SAML SSO і SCIM; для платних планів доступний 14-денний пробний період.', 'Parsec is remote desktop reimagined: a seamless 4K experience at up to 60 frames per second with near-zero latency. It gives secure, flexible access to games, work or projects any time, from anywhere, and players use it to play together online, for example couch multiplayer in fighting games. The site compares image quality, smooth motion and frame stability with other streaming apps. Creators and pros get advanced color modes and multi-monitor support, while team and enterprise plans add reporting, SAML SSO and SCIM; paid plans have a 14-day free trial.', 'Стримінг 4K до 60 кадрів/с
Майже нульова затримка
Спільна гра через інтернет
Кілька моніторів
Плани для команд і бізнесу', '4K streaming up to 60 fps
Near-zero latency
Play together online
Multi-monitor support
Team and enterprise plans', 'Геймери, які грають разом на відстані, і творці.', 'Gamers playing together remotely and creators.', 'desktop,web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'parsec.app' OR LOWER(`name`) = LOWER('Parsec')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Parsec is remote desktop and game streaming in 4K at up to 60 fps with near-zero latency: connect to games, work or projects from anywhere, play together online, with plans for teams and enterprise.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Parsec is remote desktop reimagined: a seamless 4K experience at up to 60 frames per second with near-zero latency. It gives secure, flexible access to games, work or projects any time, from anywhere, and players use it to play together online, for example couch multiplayer in fighting games. The site compares image quality, smooth motion and frame stability with other streaming apps. Creators and pros get advanced color modes and multi-monitor support, while team and enterprise plans add reporting, SAML SSO and SCIM; paid plans have a 14-day free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '4K streaming up to 60 fps
Near-zero latency
Play together online
Multi-monitor support
Team and enterprise plans', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers playing together remotely and creators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Особисте використання', 'Personal use' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Personal use', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PGL — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pglesports.com' OR LOWER(`name`) = LOWER('PGL'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PGL', NULL, 'https://www.pglesports.com', NULL, NULL, 'PGL Esports — організатор великих турнірів і циклів з Counter-Strike 2 і Dota 2 для масової аудиторії: мейджори, PGL Masters, Wallachia, розклад подій, квитки й новини.', 'PGL Esports organizes premier Counter-Strike 2 and Dota 2 tournaments and circuits for massive audiences: Majors, PGL Masters, Wallachia, event calendars, tickets and news.', 'PGL проводить провідні кіберспортивні турніри й цикли для великої аудиторії. На сайті опубліковано календар подій на кілька років уперед: турніри з CS2 у Бухаресті, Клуж-Напоці, Астані та інших містах, серію з Dota 2 PGL Wallachia, PGL Masters і мейджори з CS2. Для кожної події вказано місто й дати, для завершених — фінальні результати. Є розділи новин, квитків, фото, міст-господарів, вакансій і для преси.', 'PGL runs premier esports tournaments and circuits for massive audiences. Its site publishes an event calendar several years ahead: CS2 events in Bucharest, Cluj-Napoca, Astana and other cities, the PGL Wallachia Dota 2 series, PGL Masters and CS2 Majors. Each event lists city and dates, with final results for completed ones. There are news, tickets, photos, host city, careers and press sections.', 'Турніри CS2 і Dota 2
Календар подій на роки вперед
Мейджори й PGL Masters
Квитки на події
Новини й результати', 'CS2 and Dota 2 tournaments
Event calendar years ahead
Majors and PGL Masters
Event tickets
News and results', 'Уболівальники CS2 і Dota 2.', 'CS2 and Dota 2 fans.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pglesports.com' OR LOWER(`name`) = LOWER('PGL')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'PGL Esports organizes premier Counter-Strike 2 and Dota 2 tournaments and circuits for massive audiences: Majors, PGL Masters, Wallachia, event calendars, tickets and news.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PGL runs premier esports tournaments and circuits for massive audiences. Its site publishes an event calendar several years ahead: CS2 events in Bucharest, Cluj-Napoca, Astana and other cities, the PGL Wallachia Dota 2 series, PGL Masters and CS2 Majors. Each event lists city and dates, with final results for completed ones. There are news, tickets, photos, host city, careers and press sections.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'CS2 and Dota 2 tournaments
Event calendar years ahead
Majors and PGL Masters
Event tickets
News and results', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'CS2 and Dota 2 fans.', 'manual' FROM DUAL WHERE @new = 1;

-- Pikalytics — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pikalytics.com' OR LOWER(`name`) = LOWER('Pikalytics'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Pikalytics', NULL, 'https://www.pikalytics.com', NULL, NULL, 'Pikalytics — статистика змагального Pokémon VGC: найкращі покемони, збірки, атаки, предмети й команди з реальних турнірів, конструктор команд, калькулятор шкоди й таблиці швидкості.', 'Pikalytics provides competitive Pokémon VGC stats: best Pokémon, builds, moves, items and teams from real tournaments, a team builder, damage calculator and speed tiers.', 'Pikalytics показує найкращих покемонів, збірки, атаки, здібності, предмети й розподіли характеристик для актуального формату VGC на основі реальних турнірів і даних живого використання. Сторінка формату пояснює, що таке ядра команд, частота використання й відсоток перемог, і показує топ-20 покемонів та найкращі команди з турнірів, упорядковані за місцем. Є конструктор команд, звіти про мету, калькулятор шкоди, таблиці швидкості та навчальні вікторини, статті й дані турнірів.', 'Pikalytics shows the best Pokémon, builds, moves, abilities, items and stat spreads for the current VGC format, based on real tournaments and live usage data. The format page explains cores, usage and win rate, and lists the top 20 Pokémon and top tournament teams ordered by placing. There is a team builder, meta reports, a damage calculator, speed tiers and learning quizzes, articles and tournament data.', 'Використання й відсоток перемог покемонів
Збірки, атаки й предмети
Топові команди з турнірів
Конструктор команд
Калькулятор шкоди й таблиці швидкості', 'Pokémon usage and win rates
Builds, moves and items
Top tournament teams
Team builder
Damage calculator and speed tiers', 'Гравці змагального Pokémon VGC.', 'Competitive Pokémon VGC players.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pikalytics.com' OR LOWER(`name`) = LOWER('Pikalytics')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Pikalytics provides competitive Pokémon VGC stats: best Pokémon, builds, moves, items and teams from real tournaments, a team builder, damage calculator and speed tiers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Pikalytics shows the best Pokémon, builds, moves, abilities, items and stat spreads for the current VGC format, based on real tournaments and live usage data. The format page explains cores, usage and win rate, and lists the top 20 Pokémon and top tournament teams ordered by placing. There is a team builder, meta reports, a damage calculator, speed tiers and learning quizzes, articles and tournament data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Pokémon usage and win rates
Builds, moves and items
Top tournament teams
Team builder
Damage calculator and speed tiers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Competitive Pokémon VGC players.', 'manual' FROM DUAL WHERE @new = 1;

-- Plink — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'plink.gg' OR LOWER(`name`) = LOWER('Plink'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Plink', NULL, 'https://plink.gg', NULL, NULL, 'Plink — застосунок пошуку напарників (LFG) для геймерів: знаходьте тіммейтів в один клік, спілкуйтеся в безкоштовному голосовому чаті, відстежуйте статистику останніх ігор і діліться хайлайтами.', 'Plink is a teamfinder (LFG) app for gamers: find teammates in one click, talk in free voice chat, track recent game stats and share highlights.', 'Plink позиціонує себе як першу платформу матчмейкінгу, створену спеціально для геймерів. У ній можна в один клік знайти ідеальних напарників для улюблених ігор, грати разом, спілкуватися в безкоштовному голосовому чаті, відстежувати статистику останніх ігор і ділитися ігровими хайлайтами. Також видно, у що грають друзі. Є мобільний застосунок.', 'Plink positions itself as the first matchmaking platform made especially for gamers. You can find perfect teammates for your favourite games in a click, play together, talk in free voice chat, track recent game stats and share in-game highlights. You can also see what games your friends play. There is a mobile app.', 'Пошук напарників в один клік
Безкоштовний голосовий чат
Статистика останніх ігор
Хайлайти
Мобільний застосунок', 'One-click teammate search
Free voice chat
Recent game stats
Highlights
Mobile app', 'Гравці, які шукають сталу команду.', 'Players looking for a steady team.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'plink.gg' OR LOWER(`name`) = LOWER('Plink')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Plink is a teamfinder (LFG) app for gamers: find teammates in one click, talk in free voice chat, track recent game stats and share highlights.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Plink positions itself as the first matchmaking platform made especially for gamers. You can find perfect teammates for your favourite games in a click, play together, talk in free voice chat, track recent game stats and share in-game highlights. You can also see what games your friends play. There is a mobile app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'One-click teammate search
Free voice chat
Recent game stats
Highlights
Mobile app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Players looking for a steady team.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук напарників і голосовий чат', 'Teamfinder and voice chat' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Teamfinder and voice chat', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Pokémon Showdown — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pokemonshowdown.com' OR LOWER(`name`) = LOWER('Pokémon Showdown'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Pokémon Showdown', NULL, 'https://pokemonshowdown.com', NULL, NULL, 'Pokémon Showdown — безкоштовний онлайн-симулятор боїв Pokémon: випадкові або власні команди, повна анімація, рейтингові бої, повтори, калькулятор шкоди й статистика використання.', 'Pokémon Showdown is a free online Pokémon battle simulator: random or custom teams, full animation, ranked battles, replays, a damage calculator and usage stats.', 'Pokémon Showdown — симулятор боїв Pokémon, у якому можна битися онлайн із випадково згенерованими або власними командами. Бої повністю анімовані. Грати можна в браузері або встановити застосунок для Windows, macOS чи як розширення браузера. Сайт містить Pokédex, повтори, стратегії й форум, а також калькулятор шкоди, статистику використання й відкритий код на GitHub. Офіційний сервер Smogon University доповнюють спільнотні сервери з різними форматами й турнірами.', 'Pokémon Showdown is a Pokémon battle simulator where you battle online with randomly generated or custom teams. Battles are fully animated. Play in the browser or install apps for Windows, macOS or as a browser extension. The site includes a Pokédex, replays, strategy and a forum, plus a damage calculator, usage stats and open-source code on GitHub. The official Smogon University server is complemented by community servers with different formats and tournaments.', 'Онлайн-бої з випадковими чи власними командами
Повна анімація боїв
Повтори й Pokédex
Калькулятор шкоди й статистика
Спільнотні сервери й турніри
Відкритий код', 'Online battles with random or custom teams
Fully animated battles
Replays and Pokédex
Damage calculator and usage stats
Community servers and tournaments
Open source', 'Гравці змагального Pokémon, які тренуються онлайн.', 'Competitive Pokémon players practising online.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pokemonshowdown.com' OR LOWER(`name`) = LOWER('Pokémon Showdown')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Pokémon Showdown is a free online Pokémon battle simulator: random or custom teams, full animation, ranked battles, replays, a damage calculator and usage stats.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Pokémon Showdown is a Pokémon battle simulator where you battle online with randomly generated or custom teams. Battles are fully animated. Play in the browser or install apps for Windows, macOS or as a browser extension. The site includes a Pokédex, replays, strategy and a forum, plus a damage calculator, usage stats and open-source code on GitHub. The official Smogon University server is complemented by community servers with different formats and tournaments.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online battles with random or custom teams
Fully animated battles
Replays and Pokédex
Damage calculator and usage stats
Community servers and tournaments
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Competitive Pokémon players practising online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Симулятор боїв', 'Battle simulator' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Battle simulator', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PopFlash — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'popflash.site' OR LOWER(`name`) = LOWER('PopFlash'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PopFlash', NULL, 'https://popflash.site', NULL, NULL, 'PopFlash — найпростіший спосіб провести матч CS2 на якісних серверах без налаштувань: від 1v1 до 5v5, ніж-раунди, вето карт, овертайм, статистика й демо, тренувальні сервери та турніри.', 'PopFlash is the easiest way to run a CS2 match on quality servers with no configuration: 1v1 to 5v5, knife rounds, map vetos, overtime, stats and demos, practice servers and tournaments.', 'PopFlash дозволяє хостити матчі Counter-Strike одним кліком. Підтримуються формати 1v1, 2v2, 3v3 (Wingman), 4v4 і 5v5 (Competitive), а ніж-раунди, вето карт, овертайм, статистика й запис демо налаштовуються. Тренувальний сервер запускається одним кліком, щоб відпрацювати гранати й виходи з командою. У налаштуваннях скримів можна змінити дружній вогонь, довжину матчу, овертайм, запис демо й карти з Workshop. Сервіс дозволяє проводити турніри без турбот про сервери й демо, а Discord-бот автоматично переміщує гравців у голосові канали на старті матчу. Є панель статистики спільноти й понад 50 показників на гравця в кожному матчі. Вхід — через Steam; спільнота налічує близько 2 млн гравців.', 'PopFlash lets you host Counter-Strike matches in one click. It supports 1v1, 2v2, 3v3 (Wingman), 4v4 and 5v5 (Competitive), with customizable knife rounds, map vetos, overtime, stats and demo recording. A practice server launches in one click so you can line up nades and executes with your team. Scrim settings cover friendly fire, match length, overtime, demo recording and Workshop maps. You can host tournaments without worrying about servers or demos, and a Discord bot automatically moves players to voice channels when matches start. There is a community stats dashboard and over 50 stats per player per match. Sign-in is via Steam, and the community counts about 2 million players.', 'Матчі CS2 від 1v1 до 5v5 одним кліком
Вето карт, ніж-раунди й овертайм
Тренувальні сервери
Проведення турнірів
Discord-бот для голосових каналів
50+ показників на гравця й демо', 'One-click CS2 matches from 1v1 to 5v5
Map vetos, knife rounds and overtime
Practice servers
Tournament hosting
Discord bot for voice channels
50+ stats per player and demos', 'Команди й спільноти CS2, які проводять скрими та внутрішні турніри.', 'CS2 teams and communities running scrims and in-house tournaments.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'popflash.site' OR LOWER(`name`) = LOWER('PopFlash')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'PopFlash is the easiest way to run a CS2 match on quality servers with no configuration: 1v1 to 5v5, knife rounds, map vetos, overtime, stats and demos, practice servers and tournaments.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PopFlash lets you host Counter-Strike matches in one click. It supports 1v1, 2v2, 3v3 (Wingman), 4v4 and 5v5 (Competitive), with customizable knife rounds, map vetos, overtime, stats and demo recording. A practice server launches in one click so you can line up nades and executes with your team. Scrim settings cover friendly fire, match length, overtime, demo recording and Workshop maps. You can host tournaments without worrying about servers or demos, and a Discord bot automatically moves players to voice channels when matches start. There is a community stats dashboard and over 50 stats per player per match. Sign-in is via Steam, and the community counts about 2 million players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'One-click CS2 matches from 1v1 to 5v5
Map vetos, knife rounds and overtime
Practice servers
Tournament hosting
Discord bot for voice channels
50+ stats per player and demos', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'CS2 teams and communities running scrims and in-house tournaments.', 'manual' FROM DUAL WHERE @new = 1;

-- Prejump — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prejump.com' OR LOWER(`name`) = LOWER('Prejump'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Prejump', NULL, 'https://prejump.com', NULL, NULL, 'Prejump — тренувальні паки Rocket League й чіткий план практики: найбільша колекція паків, програма підвищення рангу для вашого плейлиста, курси, ігри на розуміння гри та відстеження прогресу.', 'Prejump offers Rocket League training packs and a clear practice plan: the largest pack collection, a rank-up plan for your playlist, courses, game-sense quizzes and progress tracking.', 'Prejump допомагає зрозуміти, що тренувати далі в Rocket League, і вдосконалюватися з меншою кількістю здогадок. Сервіс пропонує найбільшу колекцію тренувальних паків в інтернеті. Програма Rank Up (бета) починає з вашого поточного рангу й будує план для плейлиста, у якому ви граєте: спершу практика, потім рейтингові ігри. Розділ «Моє тренування» відстежує бенчмарки й щотижневий прогрес, курси пропонують послідовний шлях замість випадкових паків, а короткі ігри-вікторини перевіряють розуміння гри. Реєстрація безкоштовна, є Premium.', 'Prejump helps you know what to practice next in Rocket League and improve with less guesswork. It offers the largest collection of training packs on the internet. The Rank Up beta starts from your current rank and builds a plan for the playlist you play: practise first, then take it into ranked. My Training tracks benchmarks and weekly progress, courses offer a path instead of random packs, and short quiz games test your game sense. Sign-up is free, with a Premium option.', 'Найбільша колекція тренувальних паків
План підвищення рангу для плейлиста
Відстеження бенчмарків і прогресу
Курси навичок
Вікторини на розуміння гри', 'Largest training pack collection
Rank-up plan for your playlist
Benchmark and progress tracking
Skill courses
Game-sense quizzes', 'Гравці Rocket League, які хочуть системно тренуватися.', 'Rocket League players who want structured practice.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prejump.com' OR LOWER(`name`) = LOWER('Prejump')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Prejump offers Rocket League training packs and a clear practice plan: the largest pack collection, a rank-up plan for your playlist, courses, game-sense quizzes and progress tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Prejump helps you know what to practice next in Rocket League and improve with less guesswork. It offers the largest collection of training packs on the internet. The Rank Up beta starts from your current rank and builds a plan for the playlist you play: practise first, then take it into ranked. My Training tracks benchmarks and weekly progress, courses offer a path instead of random packs, and short quiz games test your game sense. Sign-up is free, with a Premium option.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Largest training pack collection
Rank-up plan for your playlist
Benchmark and progress tracking
Skill courses
Game-sense quizzes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Rocket League players who want structured practice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Реєстрація й тренувальні паки', 'Sign-up and training packs' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Sign-up and training packs', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Process Lasso — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bitsum.com' OR LOWER(`name`) = LOWER('Process Lasso'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Process Lasso', NULL, 'https://bitsum.com', NULL, NULL, 'Process Lasso від Bitsum — оптимізація й автоматизація процесора в реальному часі для Windows: ProBalance зберігає чуйність системи під навантаженням, правила для пріоритетів і спорідненості ядер, Performance Mode.', 'Process Lasso by Bitsum provides real-time CPU optimization and automation for Windows: ProBalance keeps the system responsive under load, rules for priorities and CPU affinities, and Performance Mode.', 'Process Lasso допомагає тримати ПК чуйним під час високого навантаження на процесор і автоматизувати налаштування процесів за правилами. ProBalance зберігає відгук системи, Performance Mode вмикає план живлення Bitsum Highest Performance, а власна метрика показує чуйність системи. Можна автоматично задавати спорідненість ядер, пріоритети та інші параметри процесів, перемикати плани живлення при запуску певних програм, створювати правила-сторожі за порогами й використовувати алгоритми CPU Limiter та Instance Balancer. IdleSaver дає максимум продуктивності під час роботи й економить енергію в простої. Є безкоштовна версія й Pro з довічною ліцензією.', 'Process Lasso keeps your PC responsive during high CPU loads and automates process settings with rules. ProBalance maintains responsiveness, Performance Mode enables the Bitsum Highest Performance power plan, and a proprietary metric monitors responsiveness. You can automate CPU affinities, priorities and other process settings, switch power plans when specific apps run, create watchdog rules triggered by thresholds and use algorithms like the CPU Limiter and Instance Balancer. IdleSaver gives maximum performance in use and saves energy when idle. There is a free version and Pro.', 'ProBalance під навантаженням
Автоматизація пріоритетів і ядер
Performance Mode
Плани живлення для програм
Правила-сторожі
Версії Free і Pro', 'ProBalance under load
Priority and affinity automation
Performance Mode
Per-app power plans
Watchdog rules
Free and Pro versions', 'Досвідчені користувачі Windows і геймери.', 'Windows power users and gamers.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bitsum.com' OR LOWER(`name`) = LOWER('Process Lasso')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Process Lasso by Bitsum provides real-time CPU optimization and automation for Windows: ProBalance keeps the system responsive under load, rules for priorities and CPU affinities, and Performance Mode.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Process Lasso keeps your PC responsive during high CPU loads and automates process settings with rules. ProBalance maintains responsiveness, Performance Mode enables the Bitsum Highest Performance power plan, and a proprietary metric monitors responsiveness. You can automate CPU affinities, priorities and other process settings, switch power plans when specific apps run, create watchdog rules triggered by thresholds and use algorithms like the CPU Limiter and Instance Balancer. IdleSaver gives maximum performance in use and saves energy when idle. There is a free version and Pro.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'ProBalance under load
Priority and affinity automation
Performance Mode
Per-app power plans
Watchdog rules
Free and Pro versions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Windows power users and gamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовна версія', 'Free version' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free version', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro (оновлення)', 'Pro upgrade', 24.95, 'one_time', 'Оновлення до Pro', 'Pro upgrade price' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro (оновлення)' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro upgrade', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pro upgrade price', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ProGuides — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'proguides.com' OR LOWER(`name`) = LOWER('ProGuides'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ProGuides', NULL, 'https://www.proguides.com', NULL, NULL, 'ProGuides — курси й коучинг від професійних гравців: майстер-класи на сотні годин, коучинг на вимогу та AI-асистент Discovery, що дає персональні рекомендації й налаштовує завдання в Aimlabs.', 'ProGuides offers courses and coaching from pro gamers: hundreds of hours of master classes, on-demand coaching and the Discovery AI assistant with personal recommendations and Aimlabs task tuning.', 'ProGuides пропонує «тренуватися як чемпіон» і вчитися в найкращих. Майстер-класи дозволяють проходити у власному темпі сотні годин курсів у каталозі, що постійно зростає. Коучинг на вимогу дає змогу вчитися напряму в сильних гравців і працювати з ними в парі. AI-асистент Discovery допомагає як персональний помічник: створює завдання й рекомендації, наприклад для Valorant, змінює завдання в Aimlabs Creator Studio під ваші слабкі місця й відповідає на запитання, коли ви застрягли.', 'ProGuides invites you to train like a champion and learn from the greats. Master classes let you work through hundreds of hours of courses at your own pace from a growing catalog. On-demand coaching lets you learn directly from top players and partner with them. The Discovery AI assistant acts as a personal helper: it creates tasks and recommendations, for example for Valorant, tunes Aimlabs Creator Studio tasks to your weak points and answers questions when you feel stuck.', 'Майстер-класи на сотні годин
Коучинг на вимогу від профі
AI-асистент Discovery
Персональні завдання й рекомендації
Налаштування завдань Aimlabs', 'Hundreds of hours of master classes
On-demand coaching from pros
Discovery AI assistant
Personal tasks and recommendations
Aimlabs task tuning', 'Гравці, які хочуть системно вдосконалюватися з професіоналами.', 'Players who want structured improvement with pros.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'proguides.com' OR LOWER(`name`) = LOWER('ProGuides')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ProGuides offers courses and coaching from pro gamers: hundreds of hours of master classes, on-demand coaching and the Discovery AI assistant with personal recommendations and Aimlabs task tuning.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ProGuides invites you to train like a champion and learn from the greats. Master classes let you work through hundreds of hours of courses at your own pace from a growing catalog. On-demand coaching lets you learn directly from top players and partner with them. The Discovery AI assistant acts as a personal helper: it creates tasks and recommendations, for example for Valorant, tunes Aimlabs Creator Studio tasks to your weak points and answers questions when you feel stuck.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hundreds of hours of master classes
On-demand coaching from pros
Discovery AI assistant
Personal tasks and recommendations
Aimlabs task tuning', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Players who want structured improvement with pros.', 'manual' FROM DUAL WHERE @new = 1;

-- RaceLab — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'racelab.app' OR LOWER(`name`) = LOWER('RaceLab'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'RaceLab', NULL, 'https://racelab.app', NULL, NULL, 'RaceLab — оверлеї для сім-рейсерів: VR-сумісні оверлеї, розумні розкладки й інструменти для стримінгу в iRacing, Assetto Corsa, ACC, rFactor 2, Le Mans Ultimate, Automobilista 2 і F1.', 'RaceLab provides overlays for sim racers: VR-native overlays, smart layouts and streaming tools for iRacing, Assetto Corsa, ACC, rFactor 2, Le Mans Ultimate, Automobilista 2 and F1.', 'RaceLab — сторонній застосунок сучасних оверлеїв для сім-рейсингу від Pace Engineering. Він працює з iRacing, Assetto Corsa, Assetto Corsa Competizione, rFactor 2, Le Mans Ultimate, Automobilista 2 і Formula 1. Оверлеї підтримують VR, розумні розкладки допомагають розмістити дані на екрані, а інструменти стримінгу виводять оверлеї в трансляцію. На сайті є розділи оверлеїв, розкладок, серій, членства й медіа; застосунок доступний для завантаження.', 'RaceLab is a third-party modern overlay app for sim racing from Pace Engineering. It works with iRacing, Assetto Corsa, Assetto Corsa Competizione, rFactor 2, Le Mans Ultimate, Automobilista 2 and Formula 1. Overlays are VR-native, smart layouts help arrange data on screen, and streaming tools bring overlays into your broadcast. The site covers overlays, layouts, series, memberships and media, and the app is available to download.', 'Оверлеї для 7 симуляторів
Підтримка VR
Розумні розкладки
Інструменти для стримінгу
Членство', 'Overlays for 7 sims
VR support
Smart layouts
Streaming tools
Memberships', 'Сім-рейсери й стримери гонок.', 'Sim racers and racing streamers.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'racelab.app' OR LOWER(`name`) = LOWER('RaceLab')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'RaceLab provides overlays for sim racers: VR-native overlays, smart layouts and streaming tools for iRacing, Assetto Corsa, ACC, rFactor 2, Le Mans Ultimate, Automobilista 2 and F1.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'RaceLab is a third-party modern overlay app for sim racing from Pace Engineering. It works with iRacing, Assetto Corsa, Assetto Corsa Competizione, rFactor 2, Le Mans Ultimate, Automobilista 2 and Formula 1. Overlays are VR-native, smart layouts help arrange data on screen, and streaming tools bring overlays into your broadcast. The site covers overlays, layouts, series, memberships and media, and the app is available to download.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Overlays for 7 sims
VR support
Smart layouts
Streaming tools
Memberships', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sim racers and racing streamers.', 'manual' FROM DUAL WHERE @new = 1;

-- RaceRoom — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'raceroom.com' OR LOWER(`name`) = LOWER('RaceRoom'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'RaceRoom', NULL, 'https://www.raceroom.com', NULL, NULL, 'RaceRoom Racing Experience — безкоштовний для старту гоночний симулятор для ПК від KW Studios: реальні машини й серії, траси з усього світу, офіційні змагання на кшталт Beat the Pro і мультиплеєр.', 'RaceRoom Racing Experience is a free-to-start PC racing simulator from KW Studios: real cars and series, tracks from around the world, official competitions like Beat the Pro and multiplayer.', 'RaceRoom — «дім віртуального автоспорту» від KW Studios. Симулятор RaceRoom Racing Experience для ПК можна почати безкоштовно. У ньому машини понад 25 відомих виробників, реальні гоночні серії й траси з усього світу; за даними сайту — понад 280 машин і 70 трас. Тисячі офіційних змагань, як-от Beat the Pro на конкретній трасі, і сотні тисяч мультиплеєрних гонок роблять його платформою для онлайн-змагань. Компанія також пропонує контролери, симулятори, оренду симуляторів і B2B-концепції для подій.', 'RaceRoom is the ''home of virtual motorsports'' from KW Studios. The RaceRoom Racing Experience PC simulator is free to start. It features cars from 25+ famous manufacturers, real racing series and tracks from around the world; the site lists 280+ cars and 70+ tracks. Thousands of official competitions, such as Beat the Pro on a given track, and hundreds of thousands of multiplayer races make it an online competition platform. The company also offers controllers, simulators, simulator rental and B2B event concepts.', 'Безкоштовний старт
Реальні машини й серії
Траси з усього світу
Офіційні змагання Beat the Pro
Мультиплеєрні гонки', 'Free to start
Real cars and series
Tracks from around the world
Official Beat the Pro competitions
Multiplayer races', 'Початківці й досвідчені сім-рейсери на ПК.', 'Beginner and experienced PC sim racers.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'raceroom.com' OR LOWER(`name`) = LOWER('RaceRoom')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'RaceRoom Racing Experience is a free-to-start PC racing simulator from KW Studios: real cars and series, tracks from around the world, official competitions like Beat the Pro and multiplayer.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'RaceRoom is the ''home of virtual motorsports'' from KW Studios. The RaceRoom Racing Experience PC simulator is free to start. It features cars from 25+ famous manufacturers, real racing series and tracks from around the world; the site lists 280+ cars and 70+ tracks. Thousands of official competitions, such as Beat the Pro on a given track, and hundreds of thousands of multiplayer races make it an online competition platform. The company also offers controllers, simulators, simulator rental and B2B event concepts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free to start
Real cars and series
Tracks from around the world
Official Beat the Pro competitions
Multiplayer races', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner and experienced PC sim racers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовний старт гри', 'Free to start' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free to start', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Razer Cortex — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'razer.com/cortex' OR LOWER(`name`) = LOWER('Razer Cortex'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Razer Cortex', NULL, 'https://www.razer.com/cortex', NULL, NULL, 'Razer Cortex — безкоштовний бустер ігор для ПК і ноутбуків від Razer: оптимізація системи для швидшого завантаження ігор і вищої частоти кадрів.', 'Razer Cortex is Razer''s free game booster for PCs and laptops: system optimization for faster game load times and higher frame rates.', 'Razer Cortex — бустер ігор для ПК і ноутбуків від Razer. Програма оптимізує систему, щоб ігри швидше завантажувалися й працювали з вищою частотою кадрів, і робить керування продуктивністю простим. Завантажити її можна безкоштовно на сайті Razer.', 'Razer Cortex is Razer''s game booster for PCs and laptops. It optimizes your system so games load faster and run at higher frame rates, keeping performance management simple. It is a free download from Razer''s site.', 'Бустер ігор
Швидше завантаження ігор
Вища частота кадрів
Для ПК і ноутбуків
Безкоштовно', 'Game booster
Faster game load times
Higher frame rates
For PCs and laptops
Free', 'Гравці на ПК і ноутбуках, які хочуть кращої продуктивності.', 'PC and laptop gamers wanting better performance.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'razer.com/cortex' OR LOWER(`name`) = LOWER('Razer Cortex')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Razer Cortex is Razer''s free game booster for PCs and laptops: system optimization for faster game load times and higher frame rates.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Razer Cortex is Razer''s game booster for PCs and laptops. It optimizes your system so games load faster and run at higher frame rates, keeping performance management simple. It is a free download from Razer''s site.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Game booster
Faster game load times
Higher frame rates
For PCs and laptops
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'PC and laptop gamers wanting better performance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовне завантаження', 'Free download' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free download', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Razer Synapse — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'razer.com/synapse-4' OR LOWER(`name`) = LOWER('Razer Synapse'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Razer Synapse', NULL, 'https://www.razer.com/synapse-4', NULL, NULL, 'Razer Synapse 4 — програма керування пристроями й підсвіткою Razer: макроси, налаштування, ефекти Chroma, перенесення профілів із Synapse 3, на 30% швидша робота й новий інтерфейс.', 'Razer Synapse 4 is Razer''s device control and lighting software: macros, settings, Chroma effects, migration of Synapse 3 profiles, 30% faster processing and a new interface.', 'Razer Synapse 4 керує пристроями Razer і їхньою підсвіткою: налаштуваннями, макросами та ефектами Chroma. Порівняно з Synapse 3 загальна обробка на 30% швидша — швидше створюються макроси, змінюються налаштування й встановлюються драйвери. Нова багатопотокова архітектура розділяє пристрої, тож встановлення чи оновлення одного не перериває роботу інших. Інструмент Profile Migration одним кліком переносить профілі, макроси й ефекти Chroma з Synapse 3 або дозволяє обрати лише потрібні. Інтерфейс повністю оновлено, навігація стала простішою.', 'Razer Synapse 4 controls Razer devices and their lighting: settings, macros and Chroma effects. Compared with Synapse 3, overall processing is 30% faster, speeding up macro creation, settings configuration and driver installation. A new multi-threaded architecture compartmentalizes devices, so installing or updating one doesn''t interrupt others. The Profile Migration tool transfers Synapse 3 profiles, macros and Chroma effects in one click or lets you pick only the ones you want. The interface is fully redesigned with simpler navigation.', 'Керування пристроями Razer
Макроси й налаштування
Підсвітка Chroma
Перенесення профілів із Synapse 3
На 30% швидша робота', 'Razer device control
Macros and settings
Chroma lighting
Synapse 3 profile migration
30% faster processing', 'Геймери з периферією Razer.', 'Gamers with Razer peripherals.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'razer.com/synapse-4' OR LOWER(`name`) = LOWER('Razer Synapse')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Razer Synapse 4 is Razer''s device control and lighting software: macros, settings, Chroma effects, migration of Synapse 3 profiles, 30% faster processing and a new interface.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Razer Synapse 4 controls Razer devices and their lighting: settings, macros and Chroma effects. Compared with Synapse 3, overall processing is 30% faster, speeding up macro creation, settings configuration and driver installation. A new multi-threaded architecture compartmentalizes devices, so installing or updating one doesn''t interrupt others. The Profile Migration tool transfers Synapse 3 profiles, macros and Chroma effects in one click or lets you pick only the ones you want. The interface is fully redesigned with simpler navigation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Razer device control
Macros and settings
Chroma lighting
Synapse 3 profile migration
30% faster processing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers with Razer peripherals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для пристроїв Razer', 'For Razer devices' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For Razer devices', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Restream — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'restream.io' OR LOWER(`name`) = LOWER('Restream'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Restream', NULL, 'https://restream.io', NULL, NULL, 'Restream — платформа живого відео: мультистрим на кілька каналів одночасно, браузерна студія, трансляція записаних відео як живих, AI-кліпи й вебінари; зокрема для ігрових стримів.', 'Restream is a live video platform: multistream to several channels at once, a browser studio, upload-and-stream, AI clips and webinars, including for gaming streams.', 'Restream — проста платформа живого відео, що допомагає створювати якісні трансляції й мультистримити їх на улюблені канали. Мультистрим дозволяє бути всюди одночасно, Studio — браузерна студія для ефірів, Upload & Stream перетворює записані відео на живі трансляції, Clips нарізає з живого відео вірусні кліпи, а Webinars дає змогу проводити вебінари. Серед сценаріїв використання — ігрові стрими, подкасти, інтерв''ю й спорт. Є безкоштовний старт і платні тарифи.', 'Restream is a simple live video platform that helps you create great streams and multistream them to your favourite channels. Multistreaming puts you everywhere at once, Studio is a browser-based live studio, Upload & Stream turns recorded videos into live streams, Clips turns live video into viral clips, and Webinars hosts webinars. Use cases include gaming, podcasts, interviews and sports. There is a free start and paid plans.', 'Мультистрим на кілька платформ
Браузерна студія
Трансляція записаних відео
AI-кліпи
Вебінари', 'Multistream to many platforms
Browser studio
Upload and stream
AI clips
Webinars', 'Стримери, які транслюють одразу на кількох платформах.', 'Streamers broadcasting to several platforms at once.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'restream.io' OR LOWER(`name`) = LOWER('Restream')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Restream is a live video platform: multistream to several channels at once, a browser studio, upload-and-stream, AI clips and webinars, including for gaming streams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Restream is a simple live video platform that helps you create great streams and multistream them to your favourite channels. Multistreaming puts you everywhere at once, Studio is a browser-based live studio, Upload & Stream turns recorded videos into live streams, Clips turns live video into viral clips, and Webinars hosts webinars. Use cases include gaming, podcasts, interviews and sports. There is a free start and paid plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Multistream to many platforms
Browser studio
Upload and stream
AI clips
Webinars', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Streamers broadcasting to several platforms at once.', 'manual' FROM DUAL WHERE @new = 1;

-- rib.gg — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rib.gg' OR LOWER(`name`) = LOWER('rib.gg'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'rib.gg', NULL, 'https://rib.gg', NULL, NULL, 'RIB.GG — статистика, живі рахунки й результати кожного матчу VCT і Challengers з Valorant: статистика матчів у реальному часі, гравців і команд, розклади, рейтинги й новини, а також кіберспорт PUBG.', 'RIB.GG offers Valorant stats, live scores and results for every VCT and Challengers match: live match stats, pro player and team stats, schedules, rankings and news, plus PUBG esports.', 'RIB.GG — живі рахунки, статистика й редакційне висвітлення змагального Valorant. Сайт показує результати й статистику кожного матчу VCT і Challengers, зокрема в реальному часі, статистику професійних гравців і команд, розклади, рейтинги й новини. Є розділи матчів, подій, агентів і форуми, а також окремий напрям з кіберспорту PUBG для ПК. Інтерфейс доступний англійською, бразильською португальською та китайською. Сайт не пов''язаний із Riot Games.', 'RIB.GG provides live scores, stats and editorial coverage of competitive Valorant. It shows results and stats for every VCT and Challengers match, including live, plus pro player and team stats, schedules, rankings and news. There are matches, events, agents and forum sections, plus separate PUBG PC esports coverage. The interface is in English, Brazilian Portuguese and Chinese. The site is not affiliated with Riot Games.', 'Живі рахунки й статистика матчів
Усі матчі VCT і Challengers
Статистика гравців і команд
Агенти, події й рейтинги
Кіберспорт PUBG', 'Live scores and match stats
Every VCT and Challengers match
Player and team stats
Agents, events and rankings
PUBG esports', 'Уболівальники й аналітики професійного Valorant.', 'Fans and analysts of pro Valorant.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rib.gg' OR LOWER(`name`) = LOWER('rib.gg')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'RIB.GG offers Valorant stats, live scores and results for every VCT and Challengers match: live match stats, pro player and team stats, schedules, rankings and news, plus PUBG esports.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'RIB.GG provides live scores, stats and editorial coverage of competitive Valorant. It shows results and stats for every VCT and Challengers match, including live, plus pro player and team stats, schedules, rankings and news. There are matches, events, agents and forum sections, plus separate PUBG PC esports coverage. The interface is in English, Brazilian Portuguese and Chinese. The site is not affiliated with Riot Games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live scores and match stats
Every VCT and Challengers match
Player and team stats
Agents, events and rankings
PUBG esports', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Fans and analysts of pro Valorant.', 'manual' FROM DUAL WHERE @new = 1;

-- Rivals Tracker — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rivalstracker.com' OR LOWER(`name`) = LOWER('Rivals Tracker'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Rivals Tracker', NULL, 'https://rivalstracker.com', NULL, NULL, 'Rivals Tracker — статистика гравців і історія матчів Marvel Rivals, дані про героїв і Team-Up, мета в реальному часі, розподіл рангів і таблиці лідерів топ-500.', 'Rivals Tracker covers Marvel Rivals player stats and match history, hero and Team-Up data, live meta insights, rank distribution and top-500 leaderboards.', 'Rivals Tracker дозволяє шукати гравців Marvel Rivals і їхню історію матчів, а потім досліджувати статистику, мету, ранги й Team-Up. Для понад 50 героїв доступні відсоток перемог, вибору й банів, тір-лист, рейтинги сезону, дані Team-Up і здібностей. Окремо показано лідерів за відсотком перемог, найпопулярніших і найчастіше забанених героїв у змагальних іграх рівня Diamond+. Глобальна таблиця топ-500 і таблиці за героями, а також розподіл рангів і склади команд охоплюють режими Competitive і Quick Play.', 'Rivals Tracker lets you search Marvel Rivals players and their match history, then explore stats, meta, ranks and Team-Ups. For 50+ heroes it shows win, pick and ban rates, a tier list, season rankings, Team-Up and ability data. It highlights win-rate leaders and the most picked and banned heroes in Diamond+ competitive play. A global top-500 leaderboard, hero leaderboards, rank distribution and team comps cover Competitive and Quick Play.', 'Пошук гравців та історія матчів
Статистика 50+ героїв
Мета Diamond+ і бани
Таблиця лідерів топ-500
Розподіл рангів і склади команд', 'Player search and match history
Stats for 50+ heroes
Diamond+ meta and bans
Top-500 leaderboard
Rank distribution and team comps', 'Гравці Marvel Rivals у змагальному режимі.', 'Competitive Marvel Rivals players.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rivalstracker.com' OR LOWER(`name`) = LOWER('Rivals Tracker')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Rivals Tracker covers Marvel Rivals player stats and match history, hero and Team-Up data, live meta insights, rank distribution and top-500 leaderboards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Rivals Tracker lets you search Marvel Rivals players and their match history, then explore stats, meta, ranks and Team-Ups. For 50+ heroes it shows win, pick and ban rates, a tier list, season rankings, Team-Up and ability data. It highlights win-rate leaders and the most picked and banned heroes in Diamond+ competitive play. A global top-500 leaderboard, hero leaderboards, rank distribution and team comps cover Competitive and Quick Play.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Player search and match history
Stats for 50+ heroes
Diamond+ meta and bans
Top-500 leaderboard
Rank distribution and team comps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Competitive Marvel Rivals players.', 'manual' FROM DUAL WHERE @new = 1;

-- RivalsMeta — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rivalsmeta.com' OR LOWER(`name`) = LOWER('RivalsMeta'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'RivalsMeta', NULL, 'https://rivalsmeta.com', NULL, NULL, 'RivalsMeta — трекер Marvel Rivals: статистика гравців, тір-лист і мета героїв, Team-Up, склади команд, таблиці лідерів, Зал слави, скіни та PvE.', 'RivalsMeta is a Marvel Rivals tracker: player stats, hero tier list and meta, Team-Ups, team comps, leaderboards, Hall of Fame, skins and PvE.', 'RivalsMeta допомагає відстежувати статистику, досліджувати мету й підвищувати ранг у Marvel Rivals. На головній сторінці — прогрес поточного сезону, нові герої, топ мета-героїв із відсотком перемог і частотою вибору та вершина таблиці лідерів. Розділи сайту охоплюють героїв, Team-Up, таблицю лідерів, тір-лист, склади команд, Зал слави, скіни й PvE. Є підказка, де знайти свій UID гравця.', 'RivalsMeta helps you track your stats, explore the meta and climb in Marvel Rivals. The home page shows current season progress, new heroes, top meta heroes with win and pick rates, and the top of the leaderboard. Sections cover heroes, Team-Ups, leaderboard, tier list, team comps, Hall of Fame, skins and PvE. There is a guide on where to find your player UID.', 'Статистика гравців за UID
Тір-лист і мета героїв
Team-Up і склади команд
Таблиці лідерів і Зал слави
Скіни та PvE', 'Player stats by UID
Hero tier list and meta
Team-Ups and team comps
Leaderboards and Hall of Fame
Skins and PvE', 'Гравці Marvel Rivals, які хочуть підвищити ранг.', 'Marvel Rivals players who want to climb.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rivalsmeta.com' OR LOWER(`name`) = LOWER('RivalsMeta')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'RivalsMeta is a Marvel Rivals tracker: player stats, hero tier list and meta, Team-Ups, team comps, leaderboards, Hall of Fame, skins and PvE.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'RivalsMeta helps you track your stats, explore the meta and climb in Marvel Rivals. The home page shows current season progress, new heroes, top meta heroes with win and pick rates, and the top of the leaderboard. Sections cover heroes, Team-Ups, leaderboard, tier list, team comps, Hall of Fame, skins and PvE. There is a guide on where to find your player UID.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Player stats by UID
Hero tier list and meta
Team-Ups and team comps
Leaderboards and Hall of Fame
Skins and PvE', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Marvel Rivals players who want to climb.', 'manual' FROM DUAL WHERE @new = 1;

-- SAMMI — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sammi.solutions' OR LOWER(`name`) = LOWER('SAMMI'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SAMMI', NULL, 'https://sammi.solutions', NULL, NULL, 'SAMMI — безкоштовний набір для автоматизації стримів: інтерактивні стрими на Twitch і YouTube, керування OBS через WebSocket, реакції на події та складні автоматизації без написання коду.', 'SAMMI is a free stream automation toolkit: interactive Twitch and YouTube streams, OBS control via WebSocket, event reactions and complex automations without writing code.', 'SAMMI (Stream Automation, Management, Monitoring & Innovation) — повністю налаштовуваний помічник стримера, що дозволяє глядачам Twitch і YouTube Live взаємодіяти зі стримом і керувати ним. Через OBS WebSocket він дистанційно керує OBS Studio, слухає події Twitch, надсилає повідомлення в чат, редагує нагороди за бали каналу, а також слухає події YouTube Live. SAMMI має власну візуальну мову програмування: можна швидко зробити кнопки для простих взаємодій або будувати складні команди. Основний застосунок безкоштовний, є розширення й документація.', 'SAMMI (Stream Automation, Management, Monitoring & Innovation) is a fully customizable streaming assistant that lets your Twitch and YouTube Live audience interact with and control your stream. Via OBS WebSocket it controls OBS Studio remotely, listens to Twitch events, sends chat messages, edits channel point rewards and listens to YouTube Live events. SAMMI is its own visual programming language: build buttons for basic interactions or explore more complex commands. The core app is free, with extensions and documentation.', 'Керування OBS через WebSocket
Події Twitch і YouTube Live
Нагороди за бали каналу
Візуальне програмування
Безкоштовний основний застосунок', 'OBS control via WebSocket
Twitch and YouTube Live events
Channel point rewards
Visual programming
Free core app', 'Стримери, які будують інтерактивні стрими без коду.', 'Streamers building interactive streams without code.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sammi.solutions' OR LOWER(`name`) = LOWER('SAMMI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SAMMI is a free stream automation toolkit: interactive Twitch and YouTube streams, OBS control via WebSocket, event reactions and complex automations without writing code.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SAMMI (Stream Automation, Management, Monitoring & Innovation) is a fully customizable streaming assistant that lets your Twitch and YouTube Live audience interact with and control your stream. Via OBS WebSocket it controls OBS Studio remotely, listens to Twitch events, sends chat messages, edits channel point rewards and listens to YouTube Live events. SAMMI is its own visual programming language: build buttons for basic interactions or explore more complex commands. The core app is free, with extensions and documentation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'OBS control via WebSocket
Twitch and YouTube Live events
Channel point rewards
Visual programming
Free core app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Streamers building interactive streams without code.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Основний застосунок', 'Core app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Core app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- sesh — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sesh.fyi' OR LOWER(`name`) = LOWER('sesh'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'sesh', NULL, 'https://sesh.fyi', NULL, NULL, 'sesh — бот-календар для Discord: створення подій природною мовою, RSVP і нагадування, опитування доступності, щоб знайти час для всіх, і панель керування.', 'sesh is a calendar bot for Discord: create events in natural language, RSVPs and reminders, availability polls to find a time that works for everyone, and a dashboard.', 'sesh — бот-календар для Discord, у якому події створюються без жорстких форматів: час можна вказати будь-якими словами. Учасники відповідають через просте RSVP, за бажанням отримують нагадування. Опитування доступності допомагають знайти час, коли вільні всі: учасники голосують через Discord або веб, і більше не треба безкінечно домовлятися. Це зручно для планування групових подій, тренувань і зустрічей. Є панель керування, інструкція, Premium і сервер підтримки.', 'sesh is a Discord calendar bot where you create events without rigid formats, specifying times however you like. Members respond with a simple RSVP and optional reminders. Availability polls help find when everyone is free: members vote via Discord or the web, ending endless back-and-forth. It is handy for group events, practice sessions and meetings. There is a dashboard, a manual, Premium and a support server.', 'Події природною мовою
RSVP і нагадування
Опитування доступності
Веб-панель
Premium', 'Natural-language events
RSVP and reminders
Availability polls
Web dashboard
Premium', 'Discord-спільноти й команди, які планують ігри разом.', 'Discord communities and teams planning games together.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sesh.fyi' OR LOWER(`name`) = LOWER('sesh')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'sesh is a calendar bot for Discord: create events in natural language, RSVPs and reminders, availability polls to find a time that works for everyone, and a dashboard.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'sesh is a Discord calendar bot where you create events without rigid formats, specifying times however you like. Members respond with a simple RSVP and optional reminders. Availability polls help find when everyone is free: members vote via Discord or the web, ending endless back-and-forth. It is handy for group events, practice sessions and meetings. There is a dashboard, a manual, Premium and a support server.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Natural-language events
RSVP and reminders
Availability polls
Web dashboard
Premium', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Discord communities and teams planning games together.', 'manual' FROM DUAL WHERE @new = 1;

-- Shikenso Analytics — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shikenso.com' OR LOWER(`name`) = LOWER('Shikenso Analytics'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Shikenso Analytics', NULL, 'https://shikenso.com', NULL, NULL, 'Shikenso — платформа аналітики спонсорства й ROI для спорту й кіберспорту: розпізнавання логотипів у медіа, експозиція бренду, залученість аудиторії й перевірка кампаній із креаторами.', 'Shikenso is a sponsorship analytics and ROI platform for sports and esports: logo detection across media, brand exposure, audience engagement and creator campaign verification.', 'Shikenso допомагає вимірювати вплив, залученість і видимість спонсорства. Для кіберспорту платформа відстежує експозицію бренду, ефективність і залученість аудиторії, а для кампаній із креаторами — перевіряє виконання від брифу до звіту. Правовласники доводять цінність і закривають угоди, клуби отримують швидкі точні дані, бренди вимірюють ROI на всіх каналах, агенції спрощують звітність. Серед кейсів — MOONTON Games із медійною вартістю €158 млн і команда GIANTX, що інтегрувала 17 нових партнерів. Компанія також публікує звіти з соціальної аналітики.', 'Shikenso measures sponsorship impact, engagement and visibility. For esports it tracks brand exposure, performance and audience engagement, and for creator campaigns it verifies deliverables from briefing to reporting. Rights holders prove value and close deals, clubs get fast accurate data, brands measure ROI across every channel, and agencies streamline reporting. Case studies include MOONTON Games with €158M in media value and GIANTX integrating 17 new partners. The company also publishes social intelligence reports.', 'Розпізнавання логотипів у медіа
Експозиція бренду в кіберспорті
Медійна вартість спонсорства
Перевірка кампаній із креаторами
Звіти для правовласників і брендів', 'Logo detection across media
Brand exposure in esports
Sponsorship media value
Creator campaign verification
Reports for rights holders and brands', 'Кіберспортивні команди, правовласники, бренди й агенції.', 'Esports teams, rights holders, brands and agencies.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shikenso.com' OR LOWER(`name`) = LOWER('Shikenso Analytics')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Shikenso is a sponsorship analytics and ROI platform for sports and esports: logo detection across media, brand exposure, audience engagement and creator campaign verification.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Shikenso measures sponsorship impact, engagement and visibility. For esports it tracks brand exposure, performance and audience engagement, and for creator campaigns it verifies deliverables from briefing to reporting. Rights holders prove value and close deals, clubs get fast accurate data, brands measure ROI across every channel, and agencies streamline reporting. Case studies include MOONTON Games with €158M in media value and GIANTX integrating 17 new partners. The company also publishes social intelligence reports.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Logo detection across media
Brand exposure in esports
Sponsorship media value
Creator campaign verification
Reports for rights holders and brands', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Esports teams, rights holders, brands and agencies.', 'manual' FROM DUAL WHERE @new = 1;

-- SiegeGG — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'siege.gg' OR LOWER(`name`) = LOWER('SiegeGG'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SiegeGG', NULL, 'https://siege.gg', NULL, NULL, 'SiegeGG — статистика, аналітика й новини кіберспорту Rainbow Six Siege: змагання, матчі й результати, статистика гравців, оперативників і карт, річна статистика та журнал.', 'SiegeGG covers Rainbow Six Siege esports stats, analysis and news: competitions, matches and results, player, operator and map stats, yearly stats and a magazine.', 'SiegeGG «відкриває кіберспорт Rainbow Six». Сайт показує найближчі, поточні й завершені матчі регіональних ліг — EU MENA, Північної й Південної Америки, APAC, Китаю — зі стрічкою свіжих результатів. Статистика охоплює гравців, оперативників, карти й річні показники, а розділи новин, змагань і журналу дають аналітику та історії про сцену.', 'SiegeGG is ''opening up Rainbow Six esports''. The site shows upcoming, live and finished matches from regional leagues (EU MENA, North and South America, APAC, China) with a ticker of recent results. Stats cover players, operators, maps and yearly figures, while news, competitions and magazine sections provide analysis and stories about the scene.', 'Матчі й результати R6
Статистика гравців
Статистика оперативників і карт
Річна статистика
Новини й журнал', 'R6 matches and results
Player stats
Operator and map stats
Yearly stats
News and magazine', 'Уболівальники й гравці Rainbow Six Siege.', 'Rainbow Six Siege fans and players.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'siege.gg' OR LOWER(`name`) = LOWER('SiegeGG')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SiegeGG covers Rainbow Six Siege esports stats, analysis and news: competitions, matches and results, player, operator and map stats, yearly stats and a magazine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SiegeGG is ''opening up Rainbow Six esports''. The site shows upcoming, live and finished matches from regional leagues (EU MENA, North and South America, APAC, China) with a ticker of recent results. Stats cover players, operators, maps and yearly figures, while news, competitions and magazine sections provide analysis and stories about the scene.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'R6 matches and results
Player stats
Operator and map stats
Yearly stats
News and magazine', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Rainbow Six Siege fans and players.', 'manual' FROM DUAL WHERE @new = 1;

-- SimHub — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'simhubdash.com' OR LOWER(`name`) = LOWER('SimHub'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SimHub', NULL, 'https://www.simhubdash.com', NULL, NULL, 'SimHub — софт, що виводить симулятор у реальний світ: власні дашборди й оверлеї, тактильний відгук через вібромотори й вентилятори, рухові платформи; понад 100 ігор і 200 пристроїв.', 'SimHub extends your simulator into the real world: custom dashboards and overlays, haptics via bass shakers and fans, motion platforms; 100+ games and 200+ devices supported.', 'SimHub «оживлює» симулятор, з''єднуючи його з реальним обладнанням: кермами, дисплеями, тактильними пристроями тощо. Він підтримує понад 100 ігор і понад 200 пристроїв, і все більше брендів використовують SimHub для своїх пристроїв. Dash Studio дозволяє створювати власні дашборди й оверлеї або завантажувати контент спільноти. Через бас-шейкери, мотори й вентилятори можна відчути дорогу, двигун і пробуксовку, налаштувавши все під себе. Платний аддон Motion додає підтримку рухових платформ. Є документація, форум, Discord і проєкти користувачів.', 'SimHub brings your simulator to life by connecting it to real hardware: wheels, displays, haptics and more. It supports 100+ games and 200+ devices, and more brands rely on SimHub to power their devices. Dash Studio lets you build your own dashboards and overlays or download community content. Through bass shakers, motors and fans you can feel the road, the engine and slip, tuned to your liking. A paid Motion add-on adds motion platform support. There are docs, a forum, Discord and user projects.', 'Дашборди й оверлеї Dash Studio
Тактильний відгук
Аддон Motion для рухових платформ
100+ ігор і 200+ пристроїв
Контент спільноти', 'Dash Studio dashboards and overlays
Haptic feedback
Motion add-on for platforms
100+ games and 200+ devices
Community content', 'Сім-рейсери й любителі авіасимуляторів зі своїм обладнанням.', 'Sim racers and flight sim fans with their own rigs.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'simhubdash.com' OR LOWER(`name`) = LOWER('SimHub')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SimHub extends your simulator into the real world: custom dashboards and overlays, haptics via bass shakers and fans, motion platforms; 100+ games and 200+ devices supported.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SimHub brings your simulator to life by connecting it to real hardware: wheels, displays, haptics and more. It supports 100+ games and 200+ devices, and more brands rely on SimHub to power their devices. Dash Studio lets you build your own dashboards and overlays or download community content. Through bass shakers, motors and fans you can feel the road, the engine and slip, tuned to your liking. A paid Motion add-on adds motion platform support. There are docs, a forum, Discord and user projects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Dash Studio dashboards and overlays
Haptic feedback
Motion add-on for platforms
100+ games and 200+ devices
Community content', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sim racers and flight sim fans with their own rigs.', 'manual' FROM DUAL WHERE @new = 1;

-- Simracing.GP — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'simracing.gp' OR LOWER(`name`) = LOWER('Simracing.GP'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Simracing.GP', NULL, 'https://simracing.gp', NULL, NULL, 'Simracing.GP — платформа онлайн-чемпіонатів і ліг сім-рейсингу: автоматичний запуск серверів, синхронізація ліврей, турнірна таблиця в реальному часі та інтеграція з Discord. Старт безкоштовний.', 'Simracing.GP is a platform for online sim racing championships and leagues: automatic server launch, livery sync, real-time standings and Discord integration. Free to start.', 'Simracing.GP допомагає знайти свою спільноту сім-рейсингу: приєднатися до онлайн-чемпіонатів і ліг або провести власні. Організатор лише призначає дату й час — виділений сервер запускається автоматично без ручного налаштування, лівреї всіх пілотів завантажуються й встановлюються перед кожною гонкою, а турнірна таблиця оновлюється в реальному часі. Підтримуються чемпіонати, серії на кількох симуляторах (Assetto Corsa, Assetto Corsa Competizione, Automobilista та інші) й інтеграція з Discord. За даними сайту, на платформі проведено понад 30 тисяч гонок і пройдено понад 13 мільйонів кіл. Почати можна безкоштовно, без банківської картки; є туторіали, гайди й калькулятор пального.', 'Simracing.GP helps you find your sim racing community: join online championships and leagues or run your own. The organizer just sets a date and time; a dedicated server launches automatically with no manual setup, every driver''s livery is downloaded and installed before each race, and standings update in real time. It supports championships, multi-game series (Assetto Corsa, Assetto Corsa Competizione, Automobilista and more) and Discord integration. The site reports 30,000+ races completed and 13+ million laps driven. It is free to start with no credit card, and offers tutorials, guides and a fuel calculator.', 'Автоматичний запуск серверів
Синхронізація ліврей
Турнірна таблиця в реальному часі
Серії на кількох симуляторах
Інтеграція з Discord
Калькулятор пального', 'Automatic server launch
Livery sync
Real-time standings
Multi-game series
Discord integration
Fuel calculator', 'Організатори ліг сім-рейсингу та гонщики.', 'Sim racing league organizers and drivers.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'simracing.gp' OR LOWER(`name`) = LOWER('Simracing.GP')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Simracing.GP is a platform for online sim racing championships and leagues: automatic server launch, livery sync, real-time standings and Discord integration. Free to start.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Simracing.GP helps you find your sim racing community: join online championships and leagues or run your own. The organizer just sets a date and time; a dedicated server launches automatically with no manual setup, every driver''s livery is downloaded and installed before each race, and standings update in real time. It supports championships, multi-game series (Assetto Corsa, Assetto Corsa Competizione, Automobilista and more) and Discord integration. The site reports 30,000+ races completed and 13+ million laps driven. It is free to start with no credit card, and offers tutorials, guides and a fuel calculator.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automatic server launch
Livery sync
Real-time standings
Multi-game series
Discord integration
Fuel calculator', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sim racing league organizers and drivers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовний старт', 'Free to start', 0.00, 'free', 'Без банківської картки', 'No credit card required' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовний старт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free to start', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'No credit card required', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sizzle — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sizzle.gg' OR LOWER(`name`) = LOWER('Sizzle'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sizzle', NULL, 'https://www.sizzle.gg', NULL, NULL, 'Sizzle.gg — безкоштовні автоматичні ігрові хайлайти: підключіть Twitch чи YouTube або завантажте відео, і AI зробить кліпи й компіляції з фільтрами за вбивствами, нокдаунами, хедшотами й перемогами.', 'Sizzle.gg creates free automatic gaming highlights: link Twitch or YouTube or upload a video, and AI makes clips and compilations filtered by kills, knockdowns, headshots and victories.', 'Sizzle.gg — місце для ігрових хайлайтів. Стримери на Twitch чи YouTube підключають акаунти, щоб сервіс автоматично отримував стрими й знаходив найкращі моменти; також можна просто завантажити відео. За допомогою AI Sizzle створює кліпи й компіляції з персональними фільтрами: вбивства, нокдауни, хедшоти, перемоги тощо. Встановлювати програми не потрібно, сервіс безкоштовний. На сайті є стрічка свіжих кліпів спільноти й блог.', 'Sizzle.gg is a place for gaming highlights. Twitch or YouTube streamers link their accounts so the service automatically fetches streams and finds the best moments, or you can simply upload a video. Using AI, Sizzle creates clips and compilations with personal filters: kills, knockdowns, headshots, victories and more. No software is required, and it is free. The site has a feed of the latest community clips and a blog.', 'Автоматичні хайлайти з AI
Підключення Twitch і YouTube
Фільтри: вбивства, хедшоти, перемоги
Компіляції
Без встановлення', 'AI automatic highlights
Twitch and YouTube linking
Filters: kills, headshots, victories
Compilations
No installation', 'Стримери й гравці шутерів.', 'Streamers and shooter players.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sizzle.gg' OR LOWER(`name`) = LOWER('Sizzle')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sizzle.gg creates free automatic gaming highlights: link Twitch or YouTube or upload a video, and AI makes clips and compilations filtered by kills, knockdowns, headshots and victories.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sizzle.gg is a place for gaming highlights. Twitch or YouTube streamers link their accounts so the service automatically fetches streams and finds the best moments, or you can simply upload a video. Using AI, Sizzle creates clips and compilations with personal filters: kills, knockdowns, headshots, victories and more. No software is required, and it is free. The site has a feed of the latest community clips and a blog.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI automatic highlights
Twitch and YouTube linking
Filters: kills, headshots, victories
Compilations
No installation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Streamers and shooter players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Автоматичні хайлайти', 'Automatic highlights' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Automatic highlights', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Skill Capped — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'skill-capped.com' OR LOWER(`name`) = LOWER('Skill Capped'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Skill Capped', NULL, 'https://www.skill-capped.com', NULL, NULL, 'Skill Capped — онлайн-платформа навчання іграм: відеокурси для League of Legends, Valorant і World of Warcraft (PvP, PvE, Classic) — сотні курсів і тисячі відео від сильних гравців.', 'Skill Capped is an online game learning platform: video courses for League of Legends, Valorant and World of Warcraft (PvP, PvE, Classic), with hundreds of courses and thousands of videos.', 'Skill Capped — онлайн-платформа для навчання іграм, яка допомагає радикально покращити гру. Після вибору гри відкривається каталог курсів: для League of Legends — понад 150 курсів і понад 900 відео на сотні годин, для Valorant — десятки курсів, для World of Warcraft — окремі розділи PvP, PvE і Classic із сотнями відео. Курси охоплюють механіку, макрогру, ролі й персонажів.', 'Skill Capped is an online game learning platform that helps you radically improve. After choosing a game you get a course catalog: League of Legends has 150+ courses and 900+ videos totalling hundreds of hours, Valorant has dozens of courses, and World of Warcraft has separate PvP, PvE and Classic sections with hundreds of videos. Courses cover mechanics, macro play, roles and characters.', 'Відеокурси League of Legends
Курси Valorant
WoW PvP, PvE і Classic
Сотні годин відео
Механіка й макрогра', 'League of Legends video courses
Valorant courses
WoW PvP, PvE and Classic
Hundreds of hours of video
Mechanics and macro play', 'Гравці LoL, Valorant і WoW, які вчаться за відеокурсами.', 'LoL, Valorant and WoW players learning from video courses.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'skill-capped.com' OR LOWER(`name`) = LOWER('Skill Capped')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Skill Capped is an online game learning platform: video courses for League of Legends, Valorant and World of Warcraft (PvP, PvE, Classic), with hundreds of courses and thousands of videos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Skill Capped is an online game learning platform that helps you radically improve. After choosing a game you get a course catalog: League of Legends has 150+ courses and 900+ videos totalling hundreds of hours, Valorant has dozens of courses, and World of Warcraft has separate PvP, PvE and Classic sections with hundreds of videos. Courses cover mechanics, macro play, roles and characters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'League of Legends video courses
Valorant courses
WoW PvP, PvE and Classic
Hundreds of hours of video
Mechanics and macro play', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'LoL, Valorant and WoW players learning from video courses.', 'manual' FROM DUAL WHERE @new = 1;

-- Skybox EDGE — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'skybox.gg' OR LOWER(`name`) = LOWER('Skybox EDGE'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Skybox EDGE', NULL, 'https://skybox.gg', NULL, NULL, 'Skybox — платформа даних для Counter-Strike 2: EDGE допомагає командам покращуватися, готуватися до матчів і грати краще, а рішення для трансляцій додають інтерактив і аналітику для глядачів.', 'Skybox is a Counter-Strike 2 data platform: EDGE helps teams improve, prepare for matches and play better, while broadcast solutions add interactive experiences and insights for viewers.', 'Skybox розробляє інструменти даних для CS2. Платформа EDGE, яка за словами компанії змінює те, як команди покращуються, готуються й грають, тепер у відкритому доступі. Окремий напрям — рішення для трансляцій: інтерактивні формати, унікальна аналітика й історії на основі даних, що тримають глядачів у напрузі. Є продукти для видавців ігор і сторінка тарифів. Короткі поради з CS2 компанія публікує в TikTok.', 'Skybox builds data tools for CS2. Its EDGE platform, which the company says is changing how teams improve, prepare and play, is now in open access. A separate line covers broadcasts: interactive experiences, unique insights and data-driven storytelling to keep audiences on the edge of their seats. There are also products for publishers and a pricing page. Skybox shares short CS2 tips on TikTok.', 'Платформа EDGE для команд CS2
Підготовка до матчів на основі даних
Інтерактивні рішення для трансляцій
Аналітика для глядачів
Продукти для видавців', 'EDGE platform for CS2 teams
Data-driven match preparation
Interactive broadcast solutions
Insights for viewers
Products for publishers', 'Команди CS2, тренери, організатори трансляцій і видавці ігор.', 'CS2 teams, coaches, broadcasters and game publishers.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'skybox.gg' OR LOWER(`name`) = LOWER('Skybox EDGE')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Skybox is a Counter-Strike 2 data platform: EDGE helps teams improve, prepare for matches and play better, while broadcast solutions add interactive experiences and insights for viewers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Skybox builds data tools for CS2. Its EDGE platform, which the company says is changing how teams improve, prepare and play, is now in open access. A separate line covers broadcasts: interactive experiences, unique insights and data-driven storytelling to keep audiences on the edge of their seats. There are also products for publishers and a pricing page. Skybox shares short CS2 tips on TikTok.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'EDGE platform for CS2 teams
Data-driven match preparation
Interactive broadcast solutions
Insights for viewers
Products for publishers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'CS2 teams, coaches, broadcasters and game publishers.', 'manual' FROM DUAL WHERE @new = 1;

-- Slippi — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'slippi.gg' OR LOWER(`name`) = LOWER('Slippi'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Slippi', NULL, 'https://slippi.gg', NULL, NULL, 'Slippi — новий нетплей для Super Smash Bros. Melee: rollback-неткод для плавної гри навіть між континентами, вбудований матчмейкінг, автоматичні повтори й таблиці лідерів.', 'Slippi is the new netplay for Super Smash Bros. Melee: rollback netcode for smooth play even across continents, built-in matchmaking, automatic replays and leaderboards.', 'Slippi пропонує новий досвід нетплею для змагальної спільноти Super Smash Bros. Melee. Rollback-неткод забезпечує надплавну гру й з''єднання з низькою затримкою навіть між континентами. Вбудований матчмейкінг швидко знаходить суперників поблизу, а всі ігри автоматично зберігаються як компактні файли повторів. Є таблиці лідерів і завантаження для різних систем. Проєкт підтримується донатами й підписками.', 'Slippi offers a new netplay experience for the competitive Super Smash Bros. Melee community. Rollback netcode enables ultra-smooth gameplay and low-lag connections, even across continents. Built-in matchmaking quickly finds nearby opponents, and all games are automatically saved as compact replay files. There are leaderboards and downloads for different systems. The project is supported by donations and subscriptions.', 'Rollback-неткод
Вбудований матчмейкінг
Автоматичні повтори
Таблиці лідерів
Підтримка донатами', 'Rollback netcode
Built-in matchmaking
Automatic replays
Leaderboards
Donation-supported', 'Гравці змагального Super Smash Bros. Melee.', 'Competitive Super Smash Bros. Melee players.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'slippi.gg' OR LOWER(`name`) = LOWER('Slippi')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Slippi is the new netplay for Super Smash Bros. Melee: rollback netcode for smooth play even across continents, built-in matchmaking, automatic replays and leaderboards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Slippi offers a new netplay experience for the competitive Super Smash Bros. Melee community. Rollback netcode enables ultra-smooth gameplay and low-lag connections, even across continents. Built-in matchmaking quickly finds nearby opponents, and all games are automatically saved as compact replay files. There are leaderboards and downloads for different systems. The project is supported by donations and subscriptions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Rollback netcode
Built-in matchmaking
Automatic replays
Leaderboards
Donation-supported', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Competitive Super Smash Bros. Melee players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Підтримка донатами', 'Supported by donations' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Supported by donations', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Smogon — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'smogon.com' OR LOWER(`name`) = LOWER('Smogon'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Smogon', NULL, 'https://www.smogon.com', NULL, NULL, 'Smogon University — сайт і спільнота змагальних боїв Pokémon: стратегічний Pokédex, статті, гайди, архів поколінь, турніри, наставництво для новачків, форуми й Discord.', 'Smogon University is a competitive Pokémon battling website and community: a strategy Pokédex, articles, guides, a generations archive, tournaments, tutoring for beginners, forums and Discord.', 'Smogon — сайт і спільнота, що спеціалізується на мистецтві змагальних боїв Pokémon. Розділ навчання містить стратегічний Pokédex, статті журналу Flying Press, гайди по іграх і архів стратегій для всіх поколінь від Red/Blue до X/Y. Тренуватися й битися можна в Pokémon Showdown, використовувати калькулятор шкоди, брати участь у турнірах і заняттях Battling 101 з наставниками. Спільнота спілкується на форумах і в Discord, а також працює над проєктом Create-A-Pokémon.', 'Smogon is a website and community specializing in the art of competitive Pokémon battling. The learning section includes a strategy Pokédex, Flying Press articles, in-game guides and strategy archives for every generation from Red/Blue to X/Y. You can train and battle on Pokémon Showdown, use a damage calculator, join tournaments and Battling 101 tutoring. The community talks on forums and Discord and runs the Create-A-Pokémon project.', 'Стратегічний Pokédex
Статті й гайди
Архів стратегій усіх поколінь
Турніри й наставництво Battling 101
Форуми й Discord', 'Strategy Pokédex
Articles and guides
Strategy archive for all generations
Tournaments and Battling 101 tutoring
Forums and Discord', 'Гравці, які хочуть вивчити змагальні бої Pokémon.', 'Players who want to learn competitive Pokémon battling.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'smogon.com' OR LOWER(`name`) = LOWER('Smogon')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Smogon University is a competitive Pokémon battling website and community: a strategy Pokédex, articles, guides, a generations archive, tournaments, tutoring for beginners, forums and Discord.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Smogon is a website and community specializing in the art of competitive Pokémon battling. The learning section includes a strategy Pokédex, Flying Press articles, in-game guides and strategy archives for every generation from Red/Blue to X/Y. You can train and battle on Pokémon Showdown, use a damage calculator, join tournaments and Battling 101 tutoring. The community talks on forums and Discord and runs the Create-A-Pokémon project.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Strategy Pokédex
Articles and guides
Strategy archive for all generations
Tournaments and Battling 101 tutoring
Forums and Discord', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Players who want to learn competitive Pokémon battling.', 'manual' FROM DUAL WHERE @new = 1;

-- Speedrun.com — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'speedrun.com' OR LOWER(`name`) = LOWER('Speedrun.com'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Speedrun.com', NULL, 'https://www.speedrun.com', NULL, NULL, 'Speedrun.com — головна платформа спідрану: таблиці лідерів ігор, верифікація забігів, челенджі з призовими фондами, новини спільноти й форуми. Підписка Supporter прибирає рекламу.', 'Speedrun.com is the main speedrunning platform: game leaderboards, run verification, challenges with prize pools, community news and forums. Supporter removes ads.', 'Speedrun.com об''єднує спільноту спідранерів: тут ведуться таблиці лідерів для ігор, гравці надсилають забіги, а модератори їх перевіряють. Розділ челенджів містить спідран-змагання з призовими фондами, наприклад серію SRC Series. На головній — свіжі забіги, новини сайту й спільноти, анонси подій на кшталт марафонів. Є форуми й довідка. Підписка Supporter прибирає рекламу.', 'Speedrun.com brings the speedrunning community together: it hosts game leaderboards, players submit runs and moderators verify them. The challenges section features speedrun competitions with prize pools, such as the SRC Series. The home page shows latest runs, site and community news, and event announcements like marathons. There are forums and help pages. A Supporter subscription removes ads.', 'Таблиці лідерів спідрану
Надсилання й верифікація забігів
Челенджі з призовими
Новини й події спільноти
Форуми', 'Speedrun leaderboards
Run submission and verification
Challenges with prize pools
Community news and events
Forums', 'Спідранери й глядачі спідрану.', 'Speedrunners and speedrun viewers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'speedrun.com' OR LOWER(`name`) = LOWER('Speedrun.com')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Speedrun.com is the main speedrunning platform: game leaderboards, run verification, challenges with prize pools, community news and forums. Supporter removes ads.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Speedrun.com brings the speedrunning community together: it hosts game leaderboards, players submit runs and moderators verify them. The challenges section features speedrun competitions with prize pools, such as the SRC Series. The home page shows latest runs, site and community news, and event announcements like marathons. There are forums and help pages. A Supporter subscription removes ads.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Speedrun leaderboards
Run submission and verification
Challenges with prize pools
Community news and events
Forums', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Speedrunners and speedrun viewers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'З рекламою', 'With ads' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'With ads', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Supporter', 'Supporter', 3.99, 'month', 'Без реклами', 'No ads' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Supporter' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Supporter', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'No ads', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- start.gg — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'start.gg' OR LOWER(`name`) = LOWER('start.gg'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'start.gg', NULL, 'https://www.start.gg', NULL, NULL, 'start.gg — платформа турнірів «спільнота через змагання»: створення й пошук подій, реєстрація учасників і сітки для файтингів, Smash та інших ігор — від онлайн-турнірів до EVO.', 'start.gg is a ''community through competition'' tournament platform: create and find events, register entrants and run brackets for fighting games, Smash and more, from online events to EVO.', 'start.gg допомагає будувати спільноту через змагання. Організатори створюють події, а гравці шукають турніри за грою й реєструються. На головній — рекомендовані події з відкритою реєстрацією: великі турніри з файтингів на кшталт EVO France чи Evo Singapore, локальні турніри Super Smash Bros. Ultimate і Melee та онлайн-події. Для кожної події видно ігри, дати, місце й кількість учасників. Платформа особливо популярна у спільнотах файтингів і Smash.', 'start.gg helps build community through competition. Organizers create events, and players find tournaments by game and register. The home page features events with open registration: major fighting game tournaments such as EVO France or Evo Singapore, local Super Smash Bros. Ultimate and Melee events, and online events. Each event shows games, dates, location and attendee count. The platform is especially popular with fighting game and Smash communities.', 'Створення турнірів і сіток
Пошук подій за грою
Реєстрація учасників
Онлайн- і офлайн-події
Популярна у спільнотах файтингів і Smash', 'Tournament and bracket creation
Find events by game
Entrant registration
Online and offline events
Popular with fighting game and Smash communities', 'Організатори турнірів і гравці файтингів та інших ігор.', 'Tournament organizers and fighting game and other players.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'start.gg' OR LOWER(`name`) = LOWER('start.gg')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'start.gg is a ''community through competition'' tournament platform: create and find events, register entrants and run brackets for fighting games, Smash and more, from online events to EVO.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'start.gg helps build community through competition. Organizers create events, and players find tournaments by game and register. The home page features events with open registration: major fighting game tournaments such as EVO France or Evo Singapore, local Super Smash Bros. Ultimate and Melee events, and online events. Each event shows games, dates, location and attendee count. The platform is especially popular with fighting game and Smash communities.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tournament and bracket creation
Find events by game
Entrant registration
Online and offline events
Popular with fighting game and Smash communities', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tournament organizers and fighting game and other players.', 'manual' FROM DUAL WHERE @new = 1;

-- Statbot — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'statbot.net' OR LOWER(`name`) = LOWER('Statbot'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Statbot', NULL, 'https://statbot.net', NULL, NULL, 'Statbot — бот статистики Discord-серверів: детальні дані про активність учасників і каналів, лічильники в каналах і персональна панель сервера; використовується на понад 900 тис. серверів.', 'Statbot is a Discord server stats bot: detailed member and channel activity data, channel counters and a personalized server dashboard, used on 900,000+ servers.', 'Statbot допомагає ухвалювати правильні рішення щодо спільноти завдяки детальним даним про активність учасників і каналів у Discord. Статистика доступна через бота, лічильники в каналах і персональну панель сервера, а доступ до неї можна відкрити команді й учасникам для більшої залученості. Лічильники каналів показують статистику сервера в назвах каналів і налаштовуються. За даними сайту, Statbot довіряють понад 900 тисяч серверів.', 'Statbot helps you make the right decisions about your community with in-depth data on member and channel activity in Discord. Stats are available through the bot, channel counters and a personalized server dashboard, and access can be shared with your team and members for more engagement. Customizable channel counters show server stats as channel names. The site says Statbot is trusted by over 900,000 servers.', 'Статистика учасників і каналів
Лічильники в назвах каналів
Персональна панель сервера
Доступ для команди
900+ тис. серверів', 'Member and channel stats
Channel name counters
Personalized server dashboard
Team access
900K+ servers', 'Адміністратори Discord-спільнот і кіберспортивних організацій.', 'Admins of Discord communities and esports orgs.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'statbot.net' OR LOWER(`name`) = LOWER('Statbot')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Statbot is a Discord server stats bot: detailed member and channel activity data, channel counters and a personalized server dashboard, used on 900,000+ servers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Statbot helps you make the right decisions about your community with in-depth data on member and channel activity in Discord. Stats are available through the bot, channel counters and a personalized server dashboard, and access can be shared with your team and members for more engagement. Customizable channel counters show server stats as channel names. The site says Statbot is trusted by over 900,000 servers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Member and channel stats
Channel name counters
Personalized server dashboard
Team access
900K+ servers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Admins of Discord communities and esports orgs.', 'manual' FROM DUAL WHERE @new = 1;

-- SteelSeries GG — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'steelseries.com/gg' OR LOWER(`name`) = LOWER('SteelSeries GG'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SteelSeries GG', NULL, 'https://steelseries.com/gg', NULL, NULL, 'SteelSeries GG — безкоштовний застосунок, що об''єднує сервіси SteelSeries: аудіо Sonar, запис кліпів Moments, тренування аіму 3D Aim Trainer і налаштування периферії Engine.', 'SteelSeries GG is a free app bundling SteelSeries services: Sonar audio, Moments game clipping, 3D Aim Trainer routines and Engine gear setup.', 'GG поєднує всі ігрові сервіси SteelSeries в одному простому застосунку, щоб записувати кліпи, налаштовувати звук і периферію та ділитися результатами. Sonar дає перевагу в звуці завдяки детальному налаштуванню аудіо, Moments записує ігрові моменти, вбудовані тренувальні рутини 3D Aim Trainer допомагають розвивати аім, а Engine налаштовує периферію SteelSeries. Застосунок безкоштовний і доступний для Windows і macOS.', 'GG bundles all SteelSeries gaming services into one simple app so you can clip, tune, set up and share. Sonar gives you an audio advantage with detailed sound tuning, Moments captures game clips, built-in 3D Aim Trainer routines help train aim, and Engine sets up SteelSeries gear. The app is free for Windows and macOS.', 'Аудіо Sonar
Запис кліпів Moments
Тренування 3D Aim Trainer
Налаштування периферії Engine
Безкоштовно для Windows і macOS', 'Sonar audio
Moments clipping
3D Aim Trainer routines
Engine gear setup
Free for Windows and macOS', 'Геймери з периферією SteelSeries.', 'Gamers with SteelSeries gear.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'steelseries.com/gg' OR LOWER(`name`) = LOWER('SteelSeries GG')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SteelSeries GG is a free app bundling SteelSeries services: Sonar audio, Moments game clipping, 3D Aim Trainer routines and Engine gear setup.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'GG bundles all SteelSeries gaming services into one simple app so you can clip, tune, set up and share. Sonar gives you an audio advantage with detailed sound tuning, Moments captures game clips, built-in 3D Aim Trainer routines help train aim, and Engine sets up SteelSeries gear. The app is free for Windows and macOS.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sonar audio
Moments clipping
3D Aim Trainer routines
Engine gear setup
Free for Windows and macOS', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers with SteelSeries gear.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовне завантаження', 'Free download' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free download', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- STRATZ — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'stratz.com' OR LOWER(`name`) = LOWER('STRATZ'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'STRATZ', NULL, 'https://stratz.com', NULL, NULL, 'STRATZ — поглиблена аналітика Dota 2: персоналізовані візуалізації даних, прогнози матчів на основі AI, гайди, ліги, гільдії та GraphQL API. Дані розбираються з кожного публічного матчу.', 'STRATZ offers advanced Dota 2 analytics: personalized data visualizations, AI-powered match predictions, guides, leagues, guilds and a GraphQL API, with data parsed from every public match.', 'STRATZ створила команда ветеранів кіберспорту, щоб будувати майбутнє кіберспортивної аналітики. Сервіс зберігає й розбирає дані з кожного публічного матчу Dota 2 і перетворює їх на персоналізовані, зрозумілі інтерфейси, з яких гравці можуть вчитися. Серед можливостей — візуалізації даних під конкретного гравця, прогнози матчів на основі AI, сторінки героїв, гравців, матчів і ліг, гільдії, таблиці лідерів і база знань. Для розробників є GraphQL API. Розширені функції доступні в підписці STRATZ+. Вхід — через Steam; нові матеріали з''являються майже щоп''ятниці.', 'STRATZ was built by a team of esports veterans to create the future of esports analytics. It stores and parses data from every public Dota 2 match and turns it into personalized, clear interfaces that players can learn from. Features include player-specific data visualizations, AI-powered match predictions, hero, player, match and league pages, guilds, leaderboards and a knowledge base. Developers get a GraphQL API. Advanced features are part of the STRATZ+ subscription. Sign-in is via Steam, and new content ships most Fridays.', 'Розбір кожного публічного матчу Dota 2
Персоналізовані візуалізації даних
Прогнози матчів на основі AI
Героі, гравці, ліги й гільдії
GraphQL API для розробників
Підписка STRATZ+', 'Parses every public Dota 2 match
Personalized data visualizations
AI-powered match predictions
Heroes, players, leagues and guilds
GraphQL API for developers
STRATZ+ subscription', 'Гравці Dota 2, аналітики й розробники кіберспортивних сервісів.', 'Dota 2 players, analysts and esports app developers.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'stratz.com' OR LOWER(`name`) = LOWER('STRATZ')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'STRATZ offers advanced Dota 2 analytics: personalized data visualizations, AI-powered match predictions, guides, leagues, guilds and a GraphQL API, with data parsed from every public match.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'STRATZ was built by a team of esports veterans to create the future of esports analytics. It stores and parses data from every public Dota 2 match and turns it into personalized, clear interfaces that players can learn from. Features include player-specific data visualizations, AI-powered match predictions, hero, player, match and league pages, guilds, leaderboards and a knowledge base. Developers get a GraphQL API. Advanced features are part of the STRATZ+ subscription. Sign-in is via Steam, and new content ships most Fridays.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Parses every public Dota 2 match
Personalized data visualizations
AI-powered match predictions
Heroes, players, leagues and guilds
GraphQL API for developers
STRATZ+ subscription', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dota 2 players, analysts and esports app developers.', 'manual' FROM DUAL WHERE @new = 1;

-- StreamElements — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'streamelements.com' OR LOWER(`name`) = LOWER('StreamElements'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'StreamElements', NULL, 'https://streamelements.com', NULL, NULL, 'StreamElements — хмарна платформа для стримерів на Twitch, YouTube і Facebook Gaming: алерти й оверлеї, плагін SE.Live для OBS, чат-бот, донати, мерч, таблиця підтримувачів і мультистрим Ground Control.', 'StreamElements is a cloud platform for streamers on Twitch, YouTube and Facebook Gaming: alerts and overlays, the SE.Live plugin for OBS, a chatbot, tips, merch, a supporter leaderboard and Ground Control multistreaming.', 'StreamElements — хмарна платформа з інструментами для живих трансляцій. Кастомні алерти й оверлеї залучають аудиторію, плагін SE.Live розширює OBS Studio, а чат-бот дає інструменти для залучення й модерації. SE.Tips налаштовує зручні донати з власним дизайном, інструменти мерчу допомагають продавати, а SE.Leaderboard відзначає головних підтримувачів на Twitch. Застосунок Ground Control керує мультистримом, є інструмент для брендованих коротких відео для TikTok, YouTube й Instagram. Також є спільнота творців, база знань, блог і відеоуроки.', 'StreamElements is a cloud platform with live streaming tools. Custom alerts and overlays engage your audience, the SE.Live plugin extends OBS Studio, and the chatbot offers engagement and moderation tools. SE.Tips sets up hassle-free tipping with custom designs, merch tools help you sell, and SE.Leaderboard recognizes top Twitch supporters. The Ground Control app manages multistreaming, and a tool creates branded short videos for TikTok, YouTube and Instagram. There is a creator community, knowledge base, blog and video tutorials.', 'Алерти й оверлеї
Плагін SE.Live для OBS
Чат-бот і модерація
Донати й мерч
Мультистрим Ground Control', 'Alerts and overlays
SE.Live plugin for OBS
Chatbot and moderation
Tips and merch
Ground Control multistreaming', 'Стримери на Twitch, YouTube і Facebook Gaming.', 'Streamers on Twitch, YouTube and Facebook Gaming.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'streamelements.com' OR LOWER(`name`) = LOWER('StreamElements')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'StreamElements is a cloud platform for streamers on Twitch, YouTube and Facebook Gaming: alerts and overlays, the SE.Live plugin for OBS, a chatbot, tips, merch, a supporter leaderboard and Ground Control multistreaming.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'StreamElements is a cloud platform with live streaming tools. Custom alerts and overlays engage your audience, the SE.Live plugin extends OBS Studio, and the chatbot offers engagement and moderation tools. SE.Tips sets up hassle-free tipping with custom designs, merch tools help you sell, and SE.Leaderboard recognizes top Twitch supporters. The Ground Control app manages multistreaming, and a tool creates branded short videos for TikTok, YouTube and Instagram. There is a creator community, knowledge base, blog and video tutorials.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Alerts and overlays
SE.Live plugin for OBS
Chatbot and moderation
Tips and merch
Ground Control multistreaming', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Streamers on Twitch, YouTube and Facebook Gaming.', 'manual' FROM DUAL WHERE @new = 1;

-- Streamer.bot — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'streamer.bot' OR LOWER(`name`) = LOWER('Streamer.bot'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Streamer.bot', NULL, 'https://streamer.bot', NULL, NULL, 'Streamer.bot — потужний локальний бот для автоматизації стримів: підтримка Twitch, YouTube, Kick, OBS Studio, Streamlabs, Stream Deck та інших, власні скрипти, інтеграції й фокус на приватності.', 'Streamer.bot is a powerful local stream automation bot supporting Twitch, YouTube, Kick, OBS Studio, Streamlabs, Stream Deck and more, with custom scripting, integrations and a privacy focus.', 'Streamer.bot перетворює стрим на інтерактивний досвід. Він легкий, але потужний: розширені автоматизації, локальна робота без хмари, власні скрипти, широка розширюваність і фокус на приватності. Бот підключається до Twitch, YouTube, Kick (через офіційний API — повідомлення чату, фоловери, підписки), OBS Studio і Streamlabs. Інтеграції включають Crowd Control, вебхуки Discord, DonorDrive, Elgato Camera Hub, Stream Deck і Wave Link, Fourthwall, HypeRate.io, IFTTT тощо, а також голосового помічника Speaker.bot. Є документація, блог і журнали змін.', 'Streamer.bot turns your stream into an enhanced, interactive experience. It is lightweight but powerful: advanced automations, local-first operation, custom scripting, extreme extensibility and a privacy focus. It connects to Twitch, YouTube, Kick (via the official API for chat, follows and subs), OBS Studio and Streamlabs. Integrations include Crowd Control, Discord webhooks, DonorDrive, Elgato Camera Hub, Stream Deck and Wave Link, Fourthwall, HypeRate.io, IFTTT and more, plus the Speaker.bot voice companion. There are docs, a blog and changelogs.', 'Розширені автоматизації стриму
Twitch, YouTube, Kick, OBS і Streamlabs
Власні скрипти
Інтеграції зі Stream Deck і Discord
Локальна робота й приватність', 'Advanced stream automations
Twitch, YouTube, Kick, OBS and Streamlabs
Custom scripting
Stream Deck and Discord integrations
Local-first and private', 'Стримери, які хочуть інтерактивні стрими з автоматизацією.', 'Streamers who want automated interactive streams.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'streamer.bot' OR LOWER(`name`) = LOWER('Streamer.bot')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Streamer.bot is a powerful local stream automation bot supporting Twitch, YouTube, Kick, OBS Studio, Streamlabs, Stream Deck and more, with custom scripting, integrations and a privacy focus.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Streamer.bot turns your stream into an enhanced, interactive experience. It is lightweight but powerful: advanced automations, local-first operation, custom scripting, extreme extensibility and a privacy focus. It connects to Twitch, YouTube, Kick (via the official API for chat, follows and subs), OBS Studio and Streamlabs. Integrations include Crowd Control, Discord webhooks, DonorDrive, Elgato Camera Hub, Stream Deck and Wave Link, Fourthwall, HypeRate.io, IFTTT and more, plus the Speaker.bot voice companion. There are docs, a blog and changelogs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Advanced stream automations
Twitch, YouTube, Kick, OBS and Streamlabs
Custom scripting
Stream Deck and Discord integrations
Local-first and private', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Streamers who want automated interactive streams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Програма для Windows', 'Windows app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Windows app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- StreamerSquare — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'streamersquare.com' OR LOWER(`name`) = LOWER('StreamerSquare'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'StreamerSquare', NULL, 'https://www.streamersquare.com', NULL, NULL, 'StreamerSquare — навчальний хаб для стримерів: понад 30 курсів, консультації 1-на-1, гайди, події, можливості й знижки для стримерів — від вибору обладнання до заробітку на спонсорстві.', 'StreamerSquare is a learning hub for streamers: 30+ courses, 1-on-1 consulting, guides, events, opportunities and streamer deals, from choosing gear to earning from sponsorships.', 'StreamerSquare робить навчання успішного стримінгу простим. У платформі для творців уже понад тисяча стримерів, які розвивають канали. Вона охоплює все — від вибору обладнання до заробітку на спонсорстві: понад 30 детальних курсів, консультації 1-на-1, гайди, живі події, добірки можливостей і знижки для стримерів. Безкоштовний акаунт дає доступ до вступних матеріалів, а повний доступ коштує $14,99 на місяць або $149,99 на рік.', 'StreamerSquare makes learning to be a successful streamer easy. Over a thousand streamers grow their channels with its all-in-one creator hub. It covers everything from choosing equipment to earning from sponsorships: 30+ in-depth courses, 1-on-1 consulting, guides, live events, opportunities and streamer deals. A free account gives access to introductory content, and full access costs $14.99 per month or $149.99 per year.', '30+ курсів зі стримінгу
Консультації 1-на-1
Гайди й живі події
Спонсорські можливості
Знижки для стримерів', '30+ streaming courses
1-on-1 consulting
Guides and live events
Sponsorship opportunities
Streamer deals', 'Стримери-початківці й ті, хто хоче монетизувати канал.', 'New streamers and those looking to monetize.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'streamersquare.com' OR LOWER(`name`) = LOWER('StreamerSquare')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'StreamerSquare is a learning hub for streamers: 30+ courses, 1-on-1 consulting, guides, events, opportunities and streamer deals, from choosing gear to earning from sponsorships.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'StreamerSquare makes learning to be a successful streamer easy. Over a thousand streamers grow their channels with its all-in-one creator hub. It covers everything from choosing equipment to earning from sponsorships: 30+ in-depth courses, 1-on-1 consulting, guides, live events, opportunities and streamer deals. A free account gives access to introductory content, and full access costs $14.99 per month or $149.99 per year.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '30+ streaming courses
1-on-1 consulting
Guides and live events
Sponsorship opportunities
Streamer deals', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'New streamers and those looking to monetize.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовний акаунт', 'Free account', 0.00, 'free', 'Вступні матеріали', 'Introductory content' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовний акаунт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free account', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Introductory content', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Щомісяця', 'Monthly', 14.99, 'month', 'Усі курси й події', 'All courses and events' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Щомісяця' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Monthly', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'All courses and events', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Щороку', 'Annual', 149.99, 'year', 'Економія $30', 'Save $30' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Щороку' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Annual', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Save $30', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Streamlabs — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'streamlabs.com' OR LOWER(`name`) = LOWER('Streamlabs'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Streamlabs', NULL, 'https://streamlabs.com', NULL, NULL, 'Streamlabs — набір інструментів для стримерів: безкоштовна програма для трансляцій Streamlabs Desktop з відкритим кодом, вихід на популярні платформи, взаємодія з глядачами, дизайн стриму й підписка Ultra.', 'Streamlabs is an all-in-one suite for live streamers: the free, open-source Streamlabs Desktop broadcasting software, going live to popular platforms, viewer engagement, stream design and the Ultra subscription.', 'Streamlabs — універсальний набір простих інструментів, щоб виходити в ефір на популярні платформи, взаємодіяти з глядачами, оформлювати стрим і зростати. Streamlabs Desktop для Windows — безкоштовна, функціональна програма для трансляцій з відкритим кодом на GitHub. За даними компанії, з 2015 року стримери отримали через Streamlabs $1,4 млрд. Підписка Streamlabs Ultra відкриває доступ до розширених інструментів і тем; вона коштує $27 на місяць або $189 на рік.', 'Streamlabs is an all-in-one suite of simple tools to go live on popular platforms, engage viewers, design your stream and grow. Streamlabs Desktop for Windows is free, feature-packed broadcasting software, open source on GitHub. The company says streamers have received $1.4 billion through Streamlabs since 2015. The Streamlabs Ultra subscription unlocks advanced tools and themes for $27 per month or $189 per year.', 'Streamlabs Desktop з відкритим кодом
Вихід на популярні платформи
Взаємодія з глядачами
Теми й дизайн стриму
Підписка Ultra', 'Open-source Streamlabs Desktop
Go live to popular platforms
Viewer engagement
Themes and stream design
Ultra subscription', 'Стримери-початківці й досвідчені стримери.', 'New and experienced streamers.', 'desktop,web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'streamlabs.com' OR LOWER(`name`) = LOWER('Streamlabs')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Streamlabs is an all-in-one suite for live streamers: the free, open-source Streamlabs Desktop broadcasting software, going live to popular platforms, viewer engagement, stream design and the Ultra subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Streamlabs is an all-in-one suite of simple tools to go live on popular platforms, engage viewers, design your stream and grow. Streamlabs Desktop for Windows is free, feature-packed broadcasting software, open source on GitHub. The company says streamers have received $1.4 billion through Streamlabs since 2015. The Streamlabs Ultra subscription unlocks advanced tools and themes for $27 per month or $189 per year.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Open-source Streamlabs Desktop
Go live to popular platforms
Viewer engagement
Themes and stream design
Ultra subscription', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'New and experienced streamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Streamlabs Desktop', 'Streamlabs Desktop' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Streamlabs Desktop', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ultra (щомісяця)', 'Ultra Monthly', 27.00, 'month', 'Усі розширені інструменти й теми', 'All advanced tools and themes' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ultra (щомісяця)' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Ultra Monthly', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'All advanced tools and themes', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ultra (щороку)', 'Ultra Annual', 189.00, 'year', 'Економія $135 порівняно з помісячною оплатою', 'Save $135 vs monthly' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ultra (щороку)' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Ultra Annual', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Save $135 vs monthly', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- StreamLadder — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'streamladder.com' OR LOWER(`name`) = LOWER('StreamLadder'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'StreamLadder', NULL, 'https://www.streamladder.com', NULL, NULL, 'StreamLadder — AI перетворює стрими з Twitch, YouTube і Kick на вірусні TikTok, Reels і Shorts: AI-кліпи ClipGPT, рефреймінг, редактор кліпів і субтитри; 7 днів безкоштовно.', 'StreamLadder uses AI to turn Twitch, YouTube and Kick streams into viral TikToks, Reels and Shorts: ClipGPT AI clipping, reframing, a clip editor and captions, with a 7-day free trial.', 'StreamLadder допомагає стримерам зростати в соцмережах: достатньо вставити посилання на стрим, AI знаходить найкращі кліпи, а редагування займає хвилини, а не години. Сервіс оформлює моменти під формати TikTok, Reels і Shorts: AI-кліпінг ClipGPT, автоматичний рефреймінг у вертикальний формат, редактор кліпів і субтитри. За даними сайту, 1 мільйон стримерів створили 12 мільйонів кліпів, які разом набрали понад сто мільйонів переглядів. Нові користувачі отримують 7-денний безкоштовний пробний період з доступом до всіх платних функцій; є мобільний застосунок.', 'StreamLadder helps streamers grow on social media: paste your stream URL, AI finds your best clips, and editing takes minutes, not hours. It styles moments for TikTok, Reels and Shorts with ClipGPT AI clipping, automatic vertical reframing, a clip editor and captions. The site reports 12 million clips made by 1 million streamers, totalling over a hundred million views. New users get a 7-day free trial with access to all paid features, and there is a mobile app.', 'AI-кліпінг ClipGPT
Вертикальний рефреймінг
Редактор кліпів і субтитри
Twitch, YouTube і Kick
7 днів безкоштовно', 'ClipGPT AI clipping
Vertical reframing
Clip editor and captions
Twitch, YouTube and Kick
7-day free trial', 'Стримери, які публікують короткі відео.', 'Streamers publishing short-form video.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'streamladder.com' OR LOWER(`name`) = LOWER('StreamLadder')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'StreamLadder uses AI to turn Twitch, YouTube and Kick streams into viral TikToks, Reels and Shorts: ClipGPT AI clipping, reframing, a clip editor and captions, with a 7-day free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'StreamLadder helps streamers grow on social media: paste your stream URL, AI finds your best clips, and editing takes minutes, not hours. It styles moments for TikTok, Reels and Shorts with ClipGPT AI clipping, automatic vertical reframing, a clip editor and captions. The site reports 12 million clips made by 1 million streamers, totalling over a hundred million views. New users get a 7-day free trial with access to all paid features, and there is a mobile app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'ClipGPT AI clipping
Vertical reframing
Clip editor and captions
Twitch, YouTube and Kick
7-day free trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Streamers publishing short-form video.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Free trial', 0.00, 'free', '7 днів, усі платні функції', '7 days, all paid features' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний період' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '7 days, all paid features', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- StreamSpell — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'streamspell.com' OR LOWER(`name`) = LOWER('StreamSpell'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'StreamSpell', NULL, 'https://www.streamspell.com', NULL, NULL, 'StreamSpell — понад 1500 оверлеїв, віджетів, алертів, рамок для вебкамери, переходів і реактивних оверлеїв для OBS і Streamlabs, а також асети для Stream Deck і кастомні оверлеї.', 'StreamSpell offers 1,500+ overlays, widgets, alerts, webcam frames, transitions and reactive overlays for OBS and Streamlabs, plus Stream Deck assets and custom overlays.', 'StreamSpell — магазин оформлення для стримерів на Twitch, YouTube, Facebook та інших платформах. Каталог із понад 1500 оверлеїв, віджетів, алертів, рамок для вебкамери, переходів і реактивних оверлеїв оновлюється щотижня. Повні пакети дозволяють зробити ребрендинг каналу за раз: анімовані оверлеї, алерти, рамки для камери тощо. Усе сумісне з OBS, Streamlabs, StreamElements та іншими програмами. Також є асети для Stream Deck і замовлення кастомних оверлеїв.', 'StreamSpell is a design shop for streamers on Twitch, YouTube, Facebook and more. Its catalog of 1,500+ overlays, widgets, alerts, webcam frames, transitions and reactive overlays is updated weekly. Full packages let you rebrand your channel in one go with animated overlays, alerts, webcam frames and more. Everything works with OBS, Streamlabs, StreamElements and other apps. There are also Stream Deck assets and custom overlay commissions.', '1500+ оверлеїв і віджетів
Алерти й переходи
Реактивні оверлеї
Асети для Stream Deck
Кастомні оверлеї на замовлення', '1,500+ overlays and widgets
Alerts and transitions
Reactive overlays
Stream Deck assets
Custom overlay commissions', 'Стримери, яким потрібне готове оформлення.', 'Streamers who need ready-made designs.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'streamspell.com' OR LOWER(`name`) = LOWER('StreamSpell')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'StreamSpell offers 1,500+ overlays, widgets, alerts, webcam frames, transitions and reactive overlays for OBS and Streamlabs, plus Stream Deck assets and custom overlays.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'StreamSpell is a design shop for streamers on Twitch, YouTube, Facebook and more. Its catalog of 1,500+ overlays, widgets, alerts, webcam frames, transitions and reactive overlays is updated weekly. Full packages let you rebrand your channel in one go with animated overlays, alerts, webcam frames and more. Everything works with OBS, Streamlabs, StreamElements and other apps. There are also Stream Deck assets and custom overlay commissions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '1,500+ overlays and widgets
Alerts and transitions
Reactive overlays
Stream Deck assets
Custom overlay commissions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Streamers who need ready-made designs.', 'manual' FROM DUAL WHERE @new = 1;

-- SullyGnome — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sullygnome.com' OR LOWER(`name`) = LOWER('SullyGnome'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SullyGnome', NULL, 'https://sullygnome.com', NULL, NULL, 'SullyGnome — статистика й аналітика Twitch: канали, ігри, команди, вехи й статті з даними за довільні періоди від кількох днів до всієї історії.', 'SullyGnome provides Twitch stats and analysis: channels, games, teams, milestones and articles, with data for custom ranges from a few days to all time.', 'SullyGnome — сервіс статистики й аналізу Twitch. Він показує дані про канали, ігри та команди за обраний період — 3, 7, 14, 30, 90, 180 чи 365 днів, окремі місяці за кілька років або за весь час. Є пошук, вехи каналів, аналітичні статті й темний режим. Часовий пояс можна налаштувати. Проєкт підтримується через Patreon.', 'SullyGnome is a Twitch stats and analysis service. It shows data on channels, games and teams for a chosen period (3, 7, 14, 30, 90, 180 or 365 days, individual months across several years, or all time). There is search, channel milestones, analytical articles and a dark mode. The time zone is configurable. The project is supported via Patreon.', 'Статистика каналів, ігор і команд
Довільні періоди аналізу
Вехи каналів
Аналітичні статті
Темний режим', 'Channel, game and team stats
Custom analysis periods
Channel milestones
Analytical articles
Dark mode', 'Стримери, кіберспортивні організації й маркетологи.', 'Streamers, esports organizations and marketers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sullygnome.com' OR LOWER(`name`) = LOWER('SullyGnome')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SullyGnome provides Twitch stats and analysis: channels, games, teams, milestones and articles, with data for custom ranges from a few days to all time.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SullyGnome is a Twitch stats and analysis service. It shows data on channels, games and teams for a chosen period (3, 7, 14, 30, 90, 180 or 365 days, individual months across several years, or all time). There is search, channel milestones, analytical articles and a dark mode. The time zone is configurable. The project is supported via Patreon.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Channel, game and team stats
Custom analysis periods
Channel milestones
Analytical articles
Dark mode', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Streamers, esports organizations and marketers.', 'manual' FROM DUAL WHERE @new = 1;

-- Sym.gg — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sym.gg' OR LOWER(`name`) = LOWER('Sym.gg'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sym.gg', NULL, 'https://sym.gg', NULL, NULL, 'Sym.gg — «наука про ігри»: найточніші дані про зброю й механіку Battlefield і Call of Duty — графіки й порівняння зброї, Gunsmith, механіки й примітки до патчів.', 'Sym.gg is ''game science'': the most accurate weapon and mechanics data for Battlefield and Call of Duty, including weapon charts and comparisons, Gunsmith, mechanics and patch notes.', 'Sym.gg позиціонує себе як джерело найточніших даних для Battlefield і Call of Duty. Для Battlefield 6, 2042, V, 1, 4 та інших частин є загальна інформація, механіка зброї, графіки й порівняння зброї, а для Warzone, Black Ops 6 і Modern Warfare 3 — Gunsmith і механіки гри. Окремо публікуються примітки до патчів у форматі Sym, статті й браузер даних. Команда спілкується зі спільнотою в Discord.', 'Sym.gg positions itself as the source of the most accurate data for Battlefield and Call of Duty. For Battlefield 6, 2042, V, 1, 4 and other entries it offers general information, weapon mechanics, weapon charts and comparisons, and for Warzone, Black Ops 6 and Modern Warfare 3 it covers Gunsmith and game mechanics. It also publishes Sym-style patch notes, articles and a data browser. The team engages with the community on Discord.', 'Дані про зброю Battlefield і CoD
Графіки й порівняння зброї
Gunsmith для Warzone і Black Ops
Механіка ігор
Примітки до патчів', 'Battlefield and CoD weapon data
Weapon charts and comparisons
Gunsmith for Warzone and Black Ops
Game mechanics
Patch notes', 'Гравці Battlefield і Call of Duty, які оптимізують збірки.', 'Battlefield and Call of Duty players optimizing loadouts.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sym.gg' OR LOWER(`name`) = LOWER('Sym.gg')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sym.gg is ''game science'': the most accurate weapon and mechanics data for Battlefield and Call of Duty, including weapon charts and comparisons, Gunsmith, mechanics and patch notes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sym.gg positions itself as the source of the most accurate data for Battlefield and Call of Duty. For Battlefield 6, 2042, V, 1, 4 and other entries it offers general information, weapon mechanics, weapon charts and comparisons, and for Warzone, Black Ops 6 and Modern Warfare 3 it covers Gunsmith and game mechanics. It also publishes Sym-style patch notes, articles and a data browser. The team engages with the community on Discord.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Battlefield and CoD weapon data
Weapon charts and comparisons
Gunsmith for Warzone and Black Ops
Game mechanics
Patch notes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Battlefield and Call of Duty players optimizing loadouts.', 'manual' FROM DUAL WHERE @new = 1;

-- tactics.tools — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tactics.tools' OR LOWER(`name`) = LOWER('tactics.tools'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'tactics.tools', NULL, 'https://tactics.tools', NULL, NULL, 'tactics.tools — поглиблена статистика й аналітика Teamfight Tactics: топові склади, юніти, предмети, трейти, тренди, історія матчів, таблиці лідерів і конструктор команд для поточного сету.', 'tactics.tools provides in-depth Teamfight Tactics stats and analytics: top comps, units, items, traits, trends, match history, leaderboards and a team builder for the current set.', 'tactics.tools збирає все потрібне, щоб опанувати Teamfight Tactics. Розділ статистики показує топові склади з частотою вибору, середнім місцем, відсотком топ-4 і перемог, а також юніти, предмети, трейти, дослідник даних і тренди. Інструменти включають таблиці, тір-листи, примітки до патчів PBE і сітку ідеальних синергій. Для гравців є рейтингові таблиці лідерів і Double Up, закладки, підсумки сезону Wrapped і конструктор команд. Окремі сторінки описують юніти, трейти, предмети, аугменти й портали поточного сету.', 'tactics.tools gathers everything you need to master Teamfight Tactics. The stats section shows top comps with play rate, average placement, top-4 and win rates, plus units, items, traits, a data explorer and trends. Tools include tables, tier lists, PBE patch notes and a perfect-synergy grid. For players there are ranked and Double Up leaderboards, bookmarks, season Wrapped recaps and a team builder. Set info pages cover units, traits, items, augments and portals of the current set.', 'Топові склади зі статистикою
Юніти, предмети, трейти й тренди
Дослідник даних і тір-листи
Таблиці лідерів і Double Up
Конструктор команд
Підсумки сезону Wrapped', 'Top comps with stats
Units, items, traits and trends
Data explorer and tier lists
Ranked and Double Up leaderboards
Team builder
Season Wrapped recaps', 'Гравці Teamfight Tactics будь-якого рівня.', 'Teamfight Tactics players of any level.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tactics.tools' OR LOWER(`name`) = LOWER('tactics.tools')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'tactics.tools provides in-depth Teamfight Tactics stats and analytics: top comps, units, items, traits, trends, match history, leaderboards and a team builder for the current set.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'tactics.tools gathers everything you need to master Teamfight Tactics. The stats section shows top comps with play rate, average placement, top-4 and win rates, plus units, items, traits, a data explorer and trends. Tools include tables, tier lists, PBE patch notes and a perfect-synergy grid. For players there are ranked and Double Up leaderboards, bookmarks, season Wrapped recaps and a team builder. Set info pages cover units, traits, items, augments and portals of the current set.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Top comps with stats
Units, items, traits and trends
Data explorer and tier lists
Ranked and Double Up leaderboards
Team builder
Season Wrapped recaps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teamfight Tactics players of any level.', 'manual' FROM DUAL WHERE @new = 1;

-- TeamSpeak — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'teamspeak.com' OR LOWER(`name`) = LOWER('TeamSpeak'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TeamSpeak', NULL, 'https://www.teamspeak.com', NULL, NULL, 'TeamSpeak — голосовий зв''язок для ігор, бізнесу й спільнот: кришталево чистий звук, захист військового рівня, наднизька затримка, демонстрація екрана 4K 60 fps у TeamSpeak 6 і власні сервери.', 'TeamSpeak is voice communication for gaming, business and communities: crystal-clear audio, military-grade security, ultra-low latency, 4K 60 fps screen sharing in TeamSpeak 6 and your own servers.', 'TeamSpeak обіцяє кришталево чистий голосовий зв''язок на різних платформах із захистом військового рівня, роботою без лагів і високою надійністю. У TeamSpeak 6 з''явилася демонстрація екрана 4K 60 fps з наднизькою затримкою (бета). Спільноти без власного обладнання можуть орендувати офіційний сервер, а власники серверів — розгорнути TeamSpeak у себе для повного контролю, приватності й продуктивності. Для бізнесу є SDK і приватні захищені мережі. Новачкам допомагає гайд із налаштування й підключення до серверів.', 'TeamSpeak offers crystal-clear cross-platform voice communication with military-grade security, lag-free performance and high reliability. TeamSpeak 6 adds 4K 60 fps ultra-low-latency screen sharing (beta). Communities without hardware can rent an official server, while server owners can host TeamSpeak themselves for full control, privacy and performance. Businesses get an SDK and secure private networks. A getting-started guide helps new users set up and join servers.', 'Чистий голосовий зв''язок
Наднизька затримка
Демонстрація екрана 4K 60 fps
Власні або орендовані сервери
SDK для бізнесу', 'Clear voice communication
Ultra-low latency
4K 60 fps screen sharing
Own or rented servers
SDK for business', 'Кіберспортивні команди, клани й ігрові спільноти.', 'Esports teams, clans and gaming communities.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'teamspeak.com' OR LOWER(`name`) = LOWER('TeamSpeak')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'TeamSpeak is voice communication for gaming, business and communities: crystal-clear audio, military-grade security, ultra-low latency, 4K 60 fps screen sharing in TeamSpeak 6 and your own servers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TeamSpeak offers crystal-clear cross-platform voice communication with military-grade security, lag-free performance and high reliability. TeamSpeak 6 adds 4K 60 fps ultra-low-latency screen sharing (beta). Communities without hardware can rent an official server, while server owners can host TeamSpeak themselves for full control, privacy and performance. Businesses get an SDK and secure private networks. A getting-started guide helps new users set up and join servers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Clear voice communication
Ultra-low latency
4K 60 fps screen sharing
Own or rented servers
SDK for business', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Esports teams, clans and gaming communities.', 'manual' FROM DUAL WHERE @new = 1;

-- TFTactics — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tftactics.gg' OR LOWER(`name`) = LOWER('TFTactics'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TFTactics', NULL, 'https://tftactics.gg', NULL, NULL, 'TFTactics — компаньйон для Teamfight Tactics: склади команд, тір-листи, конструктор предметів і команд, база даних і оверлей у грі з особистим тренером, що аналізує кожен матч.', 'TFTactics is a Teamfight Tactics companion: team comps, tier lists, item and team builders, a database and an in-game overlay with a personal coach that analyses every match.', 'TFTactics допомагає грати розумніше й підвищувати ранг у TFT завдяки постійно оновлюваним гайдам предметів, рекомендаціям складів і детальній статистиці чемпіонів. Сервіс доступний як оверлей у грі. Функція особистого тренера після кожного матчу показує, що вдалося і що варто покращити, а історія матчів допомагає побачити власні тенденції. Можна планувати склад самостійно або взяти один із відібраних сильних складів поточної мети. Є трекер дошки, повна статистика чемпіонів на кожному рівні та інтерактивна шпаргалка предметів. Застосунок відповідає правилам Riot Games і працює через Overwolf.', 'TFTactics helps you play smarter and climb in TFT with constantly updated item guides, team recommendations and deep champion stats. It is available as an in-game overlay. A personal coach feature shows after every match what you did right and what to improve, and match history reveals your tendencies. You can plan your own comp or pick one of the hand-picked meta comps. There is a board tracker, full champion stats for every level and an interactive item cheat sheet. The app complies with Riot Games'' terms and runs on Overwolf.', 'Оверлей у грі
Особистий тренер після кожного матчу
Відібрані склади поточної мети
Конструктор предметів і команд
Трекер дошки
Історія матчів', 'In-game overlay
Personal coach after every match
Hand-picked meta comps
Item and team builders
Board tracker
Match history', 'Гравці Teamfight Tactics, які хочуть підказки просто під час гри.', 'Teamfight Tactics players who want help during the game.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tftactics.gg' OR LOWER(`name`) = LOWER('TFTactics')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'TFTactics is a Teamfight Tactics companion: team comps, tier lists, item and team builders, a database and an in-game overlay with a personal coach that analyses every match.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TFTactics helps you play smarter and climb in TFT with constantly updated item guides, team recommendations and deep champion stats. It is available as an in-game overlay. A personal coach feature shows after every match what you did right and what to improve, and match history reveals your tendencies. You can plan your own comp or pick one of the hand-picked meta comps. There is a board tracker, full champion stats for every level and an interactive item cheat sheet. The app complies with Riot Games'' terms and runs on Overwolf.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'In-game overlay
Personal coach after every match
Hand-picked meta comps
Item and team builders
Board tracker
Match history', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teamfight Tactics players who want help during the game.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт і застосунок-оверлей', 'Website and overlay app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website and overlay app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- THESPIKE.GG — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thespike.gg' OR LOWER(`name`) = LOWER('THESPIKE.GG'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'THESPIKE.GG', NULL, 'https://www.thespike.gg', NULL, NULL, 'THESPIKE.GG — новини, висвітлення подій і рейтинги команд Valorant: інтерв''ю з гравцями, аналітика турнірів, гайди Pick''Ems і результати матчів.', 'THESPIKE.GG covers Valorant news, events and team rankings: player interviews, tournament analysis, Pick''Ems guides and match results.', 'THESPIKE.GG — сайт про кіберспорт Valorant: новини, висвітлення подій і рейтинги команд. Редакція публікує інтерв''ю з гравцями на місці подій, огляди плей-оф великих турнірів, новини про склади команд і гайди Pick''Ems з прогнозами переможців. На сайті є розділ живих і найближчих матчів за регіонами.', 'THESPIKE.GG is a Valorant esports site with news, event coverage and team rankings. The team publishes on-site player interviews, playoff previews for major events, roster news and Pick''Ems guides with predicted winners. There is a live and upcoming matches section by region.', 'Новини кіберспорту Valorant
Інтерв''ю з гравцями
Рейтинги команд
Гайди Pick''Ems
Матчі за регіонами', 'Valorant esports news
Player interviews
Team rankings
Pick''Ems guides
Matches by region', 'Уболівальники Valorant, які стежать за професійною сценою.', 'Valorant fans following the pro scene.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thespike.gg' OR LOWER(`name`) = LOWER('THESPIKE.GG')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'THESPIKE.GG covers Valorant news, events and team rankings: player interviews, tournament analysis, Pick''Ems guides and match results.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'THESPIKE.GG is a Valorant esports site with news, event coverage and team rankings. The team publishes on-site player interviews, playoff previews for major events, roster news and Pick''Ems guides with predicted winners. There is a live and upcoming matches section by region.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Valorant esports news
Player interviews
Team rankings
Pick''Ems guides
Matches by region', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Valorant fans following the pro scene.', 'manual' FROM DUAL WHERE @new = 1;

-- Toornament — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'toornament.com' OR LOWER(`name`) = LOWER('Toornament'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Toornament', NULL, 'https://www.toornament.com', NULL, NULL, 'Toornament — усе для кіберспортивних змагань: тисячі турнірів щотижня для гравців і команд, інструменти керування турнірами й лігами будь-якого формату для організаторів і рішення для ігрових студій.', 'Toornament provides everything for esports competitions: thousands of tournaments every week for players and teams, tournament and league management for organizers, and solutions for game studios.', 'Toornament пропонує все необхідне для кіберспортивних змагань. Гравці й команди знаходять тисячі турнірів щотижня в найкращих іграх для будь-якого рівня по всьому світу. Організатори легко керують турнірами й лігами незалежно від гри й формату завдяки широкому вибору налаштувань. Ігрові студії можуть підтримати змагальну активність у своїй грі структурованими турнірами й циклами. Для організаторів і студій є окремі тарифні плани.', 'Toornament offers everything you need for esports competitions. Players and teams find thousands of tournaments every week in the best games, for all levels, all over the world. Organizers easily manage tournaments and leagues whatever the game and format, with a wide choice of settings. Game studios can empower competitive activity for their game with structured tournaments and circuits. There are separate plans for organizers and studios.', 'Тисячі турнірів щотижня
Керування турнірами й лігами
Будь-яка гра й формат
Цикли турнірів для студій
Тарифи для організаторів', 'Thousands of tournaments weekly
Tournament and league management
Any game and format
Circuits for studios
Organizer plans', 'Гравці, організатори турнірів і ігрові студії.', 'Players, tournament organizers and game studios.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'toornament.com' OR LOWER(`name`) = LOWER('Toornament')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Toornament provides everything for esports competitions: thousands of tournaments every week for players and teams, tournament and league management for organizers, and solutions for game studios.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Toornament offers everything you need for esports competitions. Players and teams find thousands of tournaments every week in the best games, for all levels, all over the world. Organizers easily manage tournaments and leagues whatever the game and format, with a wide choice of settings. Game studios can empower competitive activity for their game with structured tournaments and circuits. There are separate plans for organizers and studios.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Thousands of tournaments weekly
Tournament and league management
Any game and format
Circuits for studios
Organizer plans', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Players, tournament organizers and game studios.', 'manual' FROM DUAL WHERE @new = 1;

-- Track Titan — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tracktitan.io' OR LOWER(`name`) = LOWER('Track Titan'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Track Titan', NULL, 'https://www.tracktitan.io', NULL, NULL, 'Track Titan — AI-аналіз телеметрії для сім-рейсингу на ПК і консолях: Coaching Flows показують головну помилку на колі й як її виправити, сетапи для багатьох симуляторів і коучинг 1:1.', 'Track Titan is AI telemetry analysis for sim racing on PC and console: Coaching Flows show your biggest mistake on a lap and how to fix it, with setups for many sims and 1:1 coaching.', 'Track Titan допомагає стати швидшим розумнішим способом; ним користуються понад 300 тисяч сім-рейсерів. Замість болісного розбору телеметрії функція Coaching Flows проводить через найбільшу помилку на колі й пояснює, як саме її виправити. Сервіс автоматично записує ігрові дані під час їзди, миттєво показує, де й чому ви чи ваш улюблений пілот втрачаєте час, і пропонує персоналізовані новини про ігри й чемпіонати. Доступні сетапи для AMS2, ACC, AC, F1, iRacing і LMU, коучинг 1:1 та кіберспортивний напрям. Працює на ПК і консолях; почати можна безкоштовно, є платні членства.', 'Track Titan helps you get race-ready the smarter way and is used by over 300,000 sim racers. Instead of painful telemetry analysis, Coaching Flows walk you through the biggest mistake on a lap and exactly how to fix it. It records in-game data seamlessly as you drive, instantly shows where and why you or your favourite driver lose time, and offers personalized news about the games and championships you follow. Setups are available for AMS2, ACC, AC, F1, iRacing and LMU, plus 1:1 coaching and an esports program. It works on PC and console, is free to start and has paid memberships.', 'Coaching Flows: головна помилка кола
Автоматичний запис телеметрії
Порівняння з іншими пілотами
Сетапи для 6+ симуляторів
Коучинг 1:1
ПК і консолі', 'Coaching Flows: biggest lap mistake
Automatic telemetry recording
Comparison with other drivers
Setups for 6+ sims
1:1 coaching
PC and console', 'Сім-рейсери на ПК і консолях.', 'Sim racers on PC and console.', 'web,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tracktitan.io' OR LOWER(`name`) = LOWER('Track Titan')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Track Titan is AI telemetry analysis for sim racing on PC and console: Coaching Flows show your biggest mistake on a lap and how to fix it, with setups for many sims and 1:1 coaching.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Track Titan helps you get race-ready the smarter way and is used by over 300,000 sim racers. Instead of painful telemetry analysis, Coaching Flows walk you through the biggest mistake on a lap and exactly how to fix it. It records in-game data seamlessly as you drive, instantly shows where and why you or your favourite driver lose time, and offers personalized news about the games and championships you follow. Setups are available for AMS2, ACC, AC, F1, iRacing and LMU, plus 1:1 coaching and an esports program. It works on PC and console, is free to start and has paid memberships.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Coaching Flows: biggest lap mistake
Automatic telemetry recording
Comparison with other drivers
Setups for 6+ sims
1:1 coaching
PC and console', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sim racers on PC and console.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовний старт', 'Start free', 0.00, 'free', 'Базовий аналіз телеметрії', 'Basic telemetry analysis' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовний старт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Start free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic telemetry analysis', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tracker.gg — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tracker.gg' OR LOWER(`name`) = LOWER('Tracker.gg'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tracker.gg', NULL, 'https://tracker.gg', NULL, NULL, 'Tracker Network (tracker.gg) — статистика гравців у понад 20 іграх: Valorant, LoL, Fortnite, Marvel Rivals, R6 Siege, Apex, Rocket League, CS2 та інших. Понад 300 млн відстежуваних гравців, мобільний застосунок і оверлей.', 'Tracker Network (tracker.gg) tracks player stats in 20+ games: Valorant, LoL, Fortnite, Marvel Rivals, R6 Siege, Apex, Rocket League, CS2 and more. Over 300M players tracked, with a mobile app and an overlay.', 'Tracker Network допомагає знайти статистику улюблених ігор і вдосконалювати гру. Сервіс відстежує понад 300 мільйонів гравців і понад 25 мільйонів матчів за добу. Серед підтримуваних ігор — Valorant, League of Legends, Fortnite, Marvel Rivals, Rainbow Six Siege, Deadlock, Battlefield, Apex Legends, Rocket League, Counter-Strike 2, Halo Infinite, Destiny 2, Overwatch, PUBG, Call of Duty: Warzone та інші. Tracker працює в браузері, мобільному застосунку й оверлеї в грі. Підписка Premium прибирає рекламу, додає налаштування профілю, рамки, пріоритетну підтримку, роль у Discord і пріоритет у пошуку гравців чи команди.', 'Tracker Network helps you find stats for your favourite games and improve your play. It tracks over 300 million players and more than 25 million matches a day. Supported games include Valorant, League of Legends, Fortnite, Marvel Rivals, Rainbow Six Siege, Deadlock, Battlefield, Apex Legends, Rocket League, Counter-Strike 2, Halo Infinite, Destiny 2, Overwatch, PUBG, Call of Duty: Warzone and more. Tracker works in the browser, a mobile app and an in-game overlay. Premium removes ads and adds profile customization, frames, priority support, a Discord role and priority in LFG/LFP.', 'Статистика в 20+ іграх
300+ млн відстежуваних гравців
Браузер, мобільний застосунок і оверлей
Пошук гравців і команди (LFG/LFP)
Premium без реклами', 'Stats for 20+ games
300M+ players tracked
Web, mobile app and overlay
Looking for group/players (LFG/LFP)
Ad-free Premium', 'Гравці популярних змагальних ігор, які стежать за своєю статистикою.', 'Players of popular competitive games who track their stats.', 'web,mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tracker.gg' OR LOWER(`name`) = LOWER('Tracker.gg')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tracker Network (tracker.gg) tracks player stats in 20+ games: Valorant, LoL, Fortnite, Marvel Rivals, R6 Siege, Apex, Rocket League, CS2 and more. Over 300M players tracked, with a mobile app and an overlay.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tracker Network helps you find stats for your favourite games and improve your play. It tracks over 300 million players and more than 25 million matches a day. Supported games include Valorant, League of Legends, Fortnite, Marvel Rivals, Rainbow Six Siege, Deadlock, Battlefield, Apex Legends, Rocket League, Counter-Strike 2, Halo Infinite, Destiny 2, Overwatch, PUBG, Call of Duty: Warzone and more. Tracker works in the browser, a mobile app and an in-game overlay. Premium removes ads and adds profile customization, frames, priority support, a Discord role and priority in LFG/LFP.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Stats for 20+ games
300M+ players tracked
Web, mobile app and overlay
Looking for group/players (LFG/LFP)
Ad-free Premium', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Players of popular competitive games who track their stats.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Статистика з рекламою', 'Stats with ads' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Stats with ads', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium Monthly', 'Premium Monthly', 3.99, 'month', 'Без реклами, налаштування профілю, пріоритетна підтримка', 'No ads, profile customization, priority support' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium Monthly' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium Monthly', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'No ads, profile customization, priority support', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium Annual', 'Premium Annual', 2.92, 'month', 'Ціна за місяць при оплаті за рік, економія 27%', 'Per month, billed annually, save 27%' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium Annual' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium Annual', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per month, billed annually, save 27%', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Trackmania Exchange — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trackmania.exchange' OR LOWER(`name`) = LOWER('Trackmania Exchange'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Trackmania Exchange', NULL, 'https://trackmania.exchange', NULL, NULL, 'Trackmania Exchange (TMX) — база карт і повторів Trackmania: офіційні й кіберспортивні карти, Track of the Day, мапераки, змагання, конкурси картографів, таблиці лідерів і API.', 'Trackmania Exchange (TMX) is the Trackmania map and replay database: official and esports maps, Tracks of the Day, mappacks, competitions, mapping contests, leaderboards and an API.', 'TrackmaniaExchange — база карт і повторів для Trackmania, частина мережі ManiaExchange, що охоплює й попередні ігри серії. Тут можна знайти карти, повтори й контент спільноти: офіційні карти Nadeo, кіберспортивні карти й мапераки, Tracks of the Day, рекомендовані й спільні карти, офіційні кампанії. Є змагання, кампанії й конкурси картографів, відео, таблиця лідерів, форум і Discord. Зареєстровані користувачі можуть завантажувати карти й повтори та створювати мапераки, а для розробників доступний API.', 'TrackmaniaExchange is the map and replay database for Trackmania, part of the ManiaExchange network that also covers earlier games in the series. You can find maps, replays and community content: official Nadeo maps, esports maps and mappacks, Tracks of the Day, featured and collaborative maps, and official campaigns. There are competitions, campaigns and mapping contests, videos, a leaderboard, a forum and Discord. Registered users can upload maps and replays and create mappacks, and developers get an API.', 'База карт і повторів Trackmania
Кіберспортивні карти й мапераки
Tracks of the Day
Змагання й конкурси картографів
API ManiaExchange', 'Trackmania map and replay database
Esports maps and mappacks
Tracks of the Day
Competitions and mapping contests
ManiaExchange API', 'Гравці й картографи Trackmania.', 'Trackmania players and mappers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trackmania.exchange' OR LOWER(`name`) = LOWER('Trackmania Exchange')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Trackmania Exchange (TMX) is the Trackmania map and replay database: official and esports maps, Tracks of the Day, mappacks, competitions, mapping contests, leaderboards and an API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TrackmaniaExchange is the map and replay database for Trackmania, part of the ManiaExchange network that also covers earlier games in the series. You can find maps, replays and community content: official Nadeo maps, esports maps and mappacks, Tracks of the Day, featured and collaborative maps, and official campaigns. There are competitions, campaigns and mapping contests, videos, a leaderboard, a forum and Discord. Registered users can upload maps and replays and create mappacks, and developers get an API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Trackmania map and replay database
Esports maps and mappacks
Tracks of the Day
Competitions and mapping contests
ManiaExchange API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Trackmania players and mappers.', 'manual' FROM DUAL WHERE @new = 1;

-- Trackmania.io — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trackmania.io' OR LOWER(`name`) = LOWER('Trackmania.io'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Trackmania.io', NULL, 'https://trackmania.io', NULL, NULL, 'Trackmania.io — статистика Trackmania від Openplanet: гравці, рейтинги, матчі, траси, змагання, клуби, Track of the Day з таблицями лідерів, щотижневі змагання й кампанії.', 'Trackmania.io is Openplanet''s Trackmania stats service: players, rankings, matches, tracks, competitions, clubs, Track of the Day with leaderboards, weekly events and campaigns.', 'Trackmania.io — сервіс статистики Trackmania від команди Openplanet із входом через Ubisoft Connect. Розділи охоплюють гравців, рейтинги, матчі, траси, змагання, клубні кімнати й клуби. Сторінка Track of the Day показує щоденну нову карту з автором, авторським часом, завантаженням і таблицями лідерів. Також є Cup of the Week, щотижневі Shorts і Grands, сезонні та клубні кампанії.', 'Trackmania.io is a Trackmania stats service from the Openplanet team, with Ubisoft Connect sign-in. Sections cover players, rankings, matches, tracks, competitions, club rooms and clubs. The Track of the Day page shows each daily map with author, author time, download and leaderboards. There are also Cup of the Week, Weekly Shorts and Grands, and seasonal and club campaigns.', 'Статистика й рейтинги гравців
Track of the Day з таблицями лідерів
Cup of the Week і щотижневі змагання
Клуби й кампанії
Вхід через Ubisoft Connect', 'Player stats and rankings
Track of the Day with leaderboards
Cup of the Week and weekly events
Clubs and campaigns
Ubisoft Connect sign-in', 'Змагальні гравці Trackmania.', 'Competitive Trackmania players.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trackmania.io' OR LOWER(`name`) = LOWER('Trackmania.io')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Trackmania.io is Openplanet''s Trackmania stats service: players, rankings, matches, tracks, competitions, clubs, Track of the Day with leaderboards, weekly events and campaigns.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Trackmania.io is a Trackmania stats service from the Openplanet team, with Ubisoft Connect sign-in. Sections cover players, rankings, matches, tracks, competitions, club rooms and clubs. The Track of the Day page shows each daily map with author, author time, download and leaderboards. There are also Cup of the Week, Weekly Shorts and Grands, and seasonal and club campaigns.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Player stats and rankings
Track of the Day with leaderboards
Cup of the Week and weekly events
Clubs and campaigns
Ubisoft Connect sign-in', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Competitive Trackmania players.', 'manual' FROM DUAL WHERE @new = 1;

-- Twitch — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'twitch.tv' OR LOWER(`name`) = LOWER('Twitch'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Twitch', NULL, 'https://www.twitch.tv', NULL, NULL, 'Twitch — провідна платформа живих трансляцій ігор і кіберспорту: стрими й турніри наживо, інструменти для стримерів і підключення сторонніх сервісів на кшталт Crowd Control і StreamElements.', 'Twitch is a leading live streaming platform for games and esports: live streams and tournaments, streamer tools and third-party connections like Crowd Control and StreamElements.', 'Twitch — платформа живих трансляцій, де дивляться ігри, кіберспортивні турніри та стрими творців. Для стримерів є гайд швидкого старту, ключ трансляції в панелі керування та добірка інструментів «Stream While You Play». Через сторонні підключення можна додати Crowd Control, що дає глядачам керувати подіями у грі (підтримує понад 100 ігор), і StreamElements з ботом, оверлеями, балами лояльності й розіграшами. Twitch доступний у браузері, мобільних застосунках і на консолях.', 'Twitch is a live streaming platform where people watch games, esports tournaments and creator streams. Streamers get a quick-start guide, a stream key in the dashboard and a ''Stream While You Play'' tools selection. Third-party connections add Crowd Control, which lets viewers trigger in-game events (100+ games supported), and StreamElements with a bot, overlays, loyalty points and giveaways. Twitch is available in the browser, mobile apps and on consoles.', 'Живі трансляції ігор і турнірів
Інструменти для стримерів
Crowd Control: глядачі впливають на гру
Інтеграція зі StreamElements
Браузер, мобільні й консолі', 'Live game and tournament streams
Streamer tools
Crowd Control: viewers affect the game
StreamElements integration
Web, mobile and consoles', 'Глядачі кіберспорту й стримери.', 'Esports viewers and streamers.', 'web,mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'twitch.tv' OR LOWER(`name`) = LOWER('Twitch')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Twitch is a leading live streaming platform for games and esports: live streams and tournaments, streamer tools and third-party connections like Crowd Control and StreamElements.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Twitch is a live streaming platform where people watch games, esports tournaments and creator streams. Streamers get a quick-start guide, a stream key in the dashboard and a ''Stream While You Play'' tools selection. Third-party connections add Crowd Control, which lets viewers trigger in-game events (100+ games supported), and StreamElements with a bot, overlays, loyalty points and giveaways. Twitch is available in the browser, mobile apps and on consoles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live game and tournament streams
Streamer tools
Crowd Control: viewers affect the game
StreamElements integration
Web, mobile and consoles', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Esports viewers and streamers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Перегляд і трансляції', 'Watching and streaming' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Watching and streaming', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TwitchTracker — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'twitchtracker.com' OR LOWER(`name`) = LOWER('TwitchTracker'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TwitchTracker', NULL, 'https://twitchtracker.com', NULL, NULL, 'TwitchTracker — статистика й рейтинги Twitch для каналів, ігор і стримів: глядачі онлайн, активні стримери, час перегляду, мови, порівняння каналів і оцінки підписників.', 'TwitchTracker offers Twitch stats and rankings for channels, games and streams: live viewers, active streamers, watch time, languages, channel comparisons and subscriber estimates.', 'TwitchTracker показує статистику й рейтинги Twitch для каналів, ігор і стримів. На головній — скільки глядачів дивляться зараз, скільки каналів транслюють і скільки унікальних ігор у прямому ефірі, а також середні тижневі показники. Розділи охоплюють огляд, глядачів, канали, активних стримерів, час перегляду й трансляцій, ігри, мови, порівняння каналів і підписників, а також кліпи. Часовий пояс можна змінити.', 'TwitchTracker shows Twitch stats and rankings for channels, games and streams. The home page shows how many viewers are watching, how many channels are live and how many unique games are being streamed, plus weekly averages. Sections cover overview, viewers, channels, active streamers, watch and stream time, games, languages, channel comparison, subscribers and clips. The time zone can be changed.', 'Глядачі й канали в реальному часі
Рейтинги каналів та ігор
Час перегляду й трансляцій
Порівняння каналів
Статистика за мовами', 'Live viewers and channels
Channel and game rankings
Watch and stream time
Channel comparison
Stats by language', 'Стримери, аналітики й кіберспортивні організації.', 'Streamers, analysts and esports organizations.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'twitchtracker.com' OR LOWER(`name`) = LOWER('TwitchTracker')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'TwitchTracker offers Twitch stats and rankings for channels, games and streams: live viewers, active streamers, watch time, languages, channel comparisons and subscriber estimates.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TwitchTracker shows Twitch stats and rankings for channels, games and streams. The home page shows how many viewers are watching, how many channels are live and how many unique games are being streamed, plus weekly averages. Sections cover overview, viewers, channels, active streamers, watch and stream time, games, languages, channel comparison, subscribers and clips. The time zone can be changed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live viewers and channels
Channel and game rankings
Watch and stream time
Channel comparison
Stats by language', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Streamers, analysts and esports organizations.', 'manual' FROM DUAL WHERE @new = 1;

-- U.GG — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'u.gg' OR LOWER(`name`) = LOWER('U.GG'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'U.GG', NULL, 'https://u.gg', NULL, NULL, 'U.GG — безкоштовний застосунок і сайт зі збірками, статистикою та оверлеями для League of Legends, Valorant, Deadlock і World of Warcraft: збірки в грі, скаутинг на етапі вибору чемпіонів і аналітика після матчу.', 'U.GG is a free app and website with builds, stats and overlays for League of Legends, Valorant, Deadlock and World of Warcraft: in-game builds, champion-select scouting and post-game analytics.', 'Новий застосунок U.GG об''єднує продукти для LoL, WoW, Deadlock і Valorant в одному безкоштовному інструменті. Для League of Legends він показує різницю реалізованого золота в лінії, відстежує ключові метрики за рангом, чемпіоном і роллю та динамічно підказує порядок прокачування навичок. Збірки й рунні сторінки імпортуються автоматично з урахуванням рангу, ролі й суперника. На етапі вибору чемпіонів можна оцінити найкращі вибори, контрпіки та синергію команди, а в живій грі — отримати додатковий скаутинг усіх гравців. Після матчу доступна аналітика за таймлайном, профілі з відстеженням LP за кожну гру та таблиці лідерів для всіх регіонів. Застосунок відповідає правилам Riot Games.', 'The new U.GG app combines its LoL, WoW, Deadlock and Valorant products into one free tool. For League of Legends it shows realized lane gold difference, tracks key metrics by elo, champion and role, and gives dynamic skill-order recommendations. Builds and rune pages are auto-imported based on elo, role and matchup. In champion select you can scout the best picks, counters and team synergies, and in a live game get extra scouting on every player. After the match there are timeline-based analytics, profiles with per-game LP tracking and leaderboards for all regions. The app is Riot Games compliant.', 'Збірки й руни в грі з автоімпортом
Скаутинг на етапі вибору чемпіонів
Динамічний порядок прокачування навичок
Відстеження LP за кожну гру
Аналітика після матчу
Підтримка LoL, Valorant, Deadlock і WoW', 'In-game builds and runes with auto-import
Champion-select scouting
Dynamic skill leveling order
Per-game LP tracking
Post-game analytics
LoL, Valorant, Deadlock and WoW support', 'Гравці League of Legends, Valorant і Deadlock, які хочуть швидше підвищувати ранг.', 'League of Legends, Valorant and Deadlock players who want to climb faster.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'u.gg' OR LOWER(`name`) = LOWER('U.GG')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'U.GG is a free app and website with builds, stats and overlays for League of Legends, Valorant, Deadlock and World of Warcraft: in-game builds, champion-select scouting and post-game analytics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The new U.GG app combines its LoL, WoW, Deadlock and Valorant products into one free tool. For League of Legends it shows realized lane gold difference, tracks key metrics by elo, champion and role, and gives dynamic skill-order recommendations. Builds and rune pages are auto-imported based on elo, role and matchup. In champion select you can scout the best picks, counters and team synergies, and in a live game get extra scouting on every player. After the match there are timeline-based analytics, profiles with per-game LP tracking and leaderboards for all regions. The app is Riot Games compliant.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'In-game builds and runes with auto-import
Champion-select scouting
Dynamic skill leveling order
Per-game LP tracking
Post-game analytics
LoL, Valorant, Deadlock and WoW support', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'League of Legends, Valorant and Deadlock players who want to climb faster.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовний десктопний застосунок і сайт', 'Free desktop app and website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free desktop app and website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ultimate Frame Data — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ultimateframedata.com' OR LOWER(`name`) = LOWER('Ultimate Frame Data'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ultimate Frame Data', NULL, 'https://ultimateframedata.com', NULL, NULL, 'Ultimate Frame Data — зручні для мобільного фрейм-дані для кожного персонажа Super Smash Bros. Ultimate і Street Fighter 6, які оновлюються після патчів.', 'Ultimate Frame Data offers mobile-friendly frame data for every character in Super Smash Bros. Ultimate and Street Fighter 6, updated after patches.', 'Ultimate Frame Data — довідник фрейм-даних для файтингів, оптимізований для мобільних пристроїв. Він охоплює кожного персонажа Super Smash Bros. Ultimate, а також Street Fighter 6. Після балансних патчів автори поступово оновлюють сторінки персонажів і повідомляють про це в стрічці новин на головній. Фрейм-дані показують швидкість, безпеку й відновлення ударів — це основа для розуміння матч-апів і побудови комбо.', 'Ultimate Frame Data is a mobile-optimized frame data reference for fighting games. It covers every character in Super Smash Bros. Ultimate, plus Street Fighter 6. After balance patches the authors update character pages step by step and post progress in the news feed on the home page. Frame data shows the startup, safety and recovery of moves, the basis for understanding matchups and building combos.', 'Фрейм-дані кожного персонажа Smash Ultimate
Street Fighter 6
Оновлення після патчів
Зручно на мобільному', 'Frame data for every Smash Ultimate character
Street Fighter 6
Updates after patches
Mobile-friendly', 'Гравці файтингів, які вивчають матч-апи й комбо.', 'Fighting game players studying matchups and combos.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ultimateframedata.com' OR LOWER(`name`) = LOWER('Ultimate Frame Data')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ultimate Frame Data offers mobile-friendly frame data for every character in Super Smash Bros. Ultimate and Street Fighter 6, updated after patches.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ultimate Frame Data is a mobile-optimized frame data reference for fighting games. It covers every character in Super Smash Bros. Ultimate, plus Street Fighter 6. After balance patches the authors update character pages step by step and post progress in the news feed on the home page. Frame data shows the startup, safety and recovery of moves, the basis for understanding matchups and building combos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Frame data for every Smash Ultimate character
Street Fighter 6
Updates after patches
Mobile-friendly', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Fighting game players studying matchups and combos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Довідник фрейм-даних', 'Frame data reference' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Frame data reference', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Untapped.gg — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'untapped.gg' OR LOWER(`name`) = LOWER('Untapped.gg'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Untapped.gg', NULL, 'https://untapped.gg', NULL, NULL, 'Untapped.gg — набір інструментів для карткових і стратегічних ігор: застосунок-компаньйон відстежує матчі й показує колоду та статистику поверх гри, а сайт — мету, тір-листи й колоди з мільйонів реальних матчів.', 'Untapped.gg is a tool suite for card and strategy games: a companion app tracks matches and shows your deck and stats on top of the game, while the site offers meta stats, tier lists and decks from millions of real matches.', 'Untapped.gg — набір просунутих інструментів для улюблених ігор, зокрема MTG Arena, MARVEL SNAP, Yu-Gi-Oh! Master Duel, Pokémon TCG Pocket і Slay the Spire 2. Застосунок-компаньйон відстежує матчі й показує колоду та статистику просто поверх гри, щоб ви могли зосередитися на наступному ході. На сайті доступні мета-статистика, тір-листи й колоди на основі мільйонів реальних матчів. За даними команди, сервісом користуються понад 30 млн гравців, відстежено понад 2 млрд матчів. Untapped.gg робить незалежна команда HearthSim, яка понад 10 років створює ігрові інструменти й також розробляє HSReplay.net.', 'Untapped.gg is a suite of advanced tools for favourite games, including MTG Arena, MARVEL SNAP, Yu-Gi-Oh! Master Duel, Pokémon TCG Pocket and Slay the Spire 2. The companion app tracks your matches and shows your deck and stats on top of the game so you can focus on your next move. The website offers meta stats, tier lists and decks powered by millions of real matches. The team reports over 30 million players and more than 2 billion matches tracked. Untapped.gg is built by HearthSim, an independent team that has made gaming tools for over 10 years and also runs HSReplay.net.', 'Трекер матчів поверх гри
Колода й статистика під час гри
Мета-статистика й тір-листи
MTG Arena, MARVEL SNAP, Yu-Gi-Oh!, Pokémon TCG Pocket
2+ млрд відстежених матчів', 'Match tracker on top of the game
Deck and stats during play
Meta stats and tier lists
MTG Arena, MARVEL SNAP, Yu-Gi-Oh!, Pokémon TCG Pocket
2B+ matches tracked', 'Гравці цифрових карткових ігор, які хочуть грати сильнішими колодами.', 'Digital card game players who want stronger decks.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'untapped.gg' OR LOWER(`name`) = LOWER('Untapped.gg')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Untapped.gg is a tool suite for card and strategy games: a companion app tracks matches and shows your deck and stats on top of the game, while the site offers meta stats, tier lists and decks from millions of real matches.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Untapped.gg is a suite of advanced tools for favourite games, including MTG Arena, MARVEL SNAP, Yu-Gi-Oh! Master Duel, Pokémon TCG Pocket and Slay the Spire 2. The companion app tracks your matches and shows your deck and stats on top of the game so you can focus on your next move. The website offers meta stats, tier lists and decks powered by millions of real matches. The team reports over 30 million players and more than 2 billion matches tracked. Untapped.gg is built by HearthSim, an independent team that has made gaming tools for over 10 years and also runs HSReplay.net.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Match tracker on top of the game
Deck and stats during play
Meta stats and tier lists
MTG Arena, MARVEL SNAP, Yu-Gi-Oh!, Pokémon TCG Pocket
2B+ matches tracked', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Digital card game players who want stronger decks.', 'manual' FROM DUAL WHERE @new = 1;

-- ValoPlant — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'valoplant.gg' OR LOWER(`name`) = LOWER('ValoPlant'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ValoPlant', NULL, 'https://valoplant.gg', NULL, NULL, 'ValoPlant — інструмент стратегій Valorant: планувальник карт і тактична дошка, сотні лайнапів для будь-якого агента, 2D-повтори матчів і AI-розбір кожної гри від AI-тренера, є оверлей у грі.', 'ValoPlant is a Valorant strategy tool: map planner and tactics board, hundreds of lineups for any agent, 2D match replays and an AI coach review of every game, with an in-game overlay.', 'ValoPlant допомагає створювати стратегії Valorant, вивчати лайнапи для будь-якого агента й переглядати свої матчі у 2D. Планувальник карт працює як тактична дошка: на інтерактивній карті можна розставити агентів і розписати виходи. Бібліотека містить сотні лайнапів. Повтори можна імпортувати з файлів .vrf і переглядати у 2D, а AI-тренер робить розбір кожної гри. Сервіс доступний у браузері й як оверлей у грі з гарячими клавішами та режимом другого екрана.', 'ValoPlant helps you create Valorant strategies, learn lineups for any agent and watch your matches back in 2D. The map planner works as a tactics board: place agents on an interactive map and plan executes. The library contains hundreds of lineups. Replays can be imported from .vrf files and viewed in 2D, and an AI coach reviews every game. It runs in the browser and as an in-game overlay with hotkeys and a second-screen mode.', 'Планувальник карт і тактична дошка
Сотні лайнапів для агентів
2D-повтори з імпортом .vrf
AI-розбір кожного матчу
Оверлей у грі', 'Map planner and tactics board
Hundreds of agent lineups
2D replays with .vrf import
AI review of every match
In-game overlay', 'Гравці й команди Valorant, які готують стратегії.', 'Valorant players and teams preparing strategies.', 'web,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'valoplant.gg' OR LOWER(`name`) = LOWER('ValoPlant')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ValoPlant is a Valorant strategy tool: map planner and tactics board, hundreds of lineups for any agent, 2D match replays and an AI coach review of every game, with an in-game overlay.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ValoPlant helps you create Valorant strategies, learn lineups for any agent and watch your matches back in 2D. The map planner works as a tactics board: place agents on an interactive map and plan executes. The library contains hundreds of lineups. Replays can be imported from .vrf files and viewed in 2D, and an AI coach reviews every game. It runs in the browser and as an in-game overlay with hotkeys and a second-screen mode.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Map planner and tactics board
Hundreds of agent lineups
2D replays with .vrf import
AI review of every match
In-game overlay', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Valorant players and teams preparing strategies.', 'manual' FROM DUAL WHERE @new = 1;

-- VALORANT Esports — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'valorantesports.com' OR LOWER(`name`) = LOWER('VALORANT Esports'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'VALORANT Esports', NULL, 'https://valorantesports.com', NULL, NULL, 'VALORANT Esports — офіційний сайт кіберспорту Valorant від Riot Games: розклад сезону VCT від Kickoff до Champions, матчі всіх ліг, силові рейтинги команд, новини й нагороди за перегляд.', 'VALORANT Esports is Riot Games'' official Valorant esports site: the VCT season schedule from Kickoff to Champions, matches from all leagues, team power rankings, news and viewing rewards.', 'VALORANT Esports — офіційне місце для перегляду кіберспорту Valorant. Розклад охоплює весь сезон: Kickoff, Stage 1 і Stage 2 у регіонах та міжнародні Masters і Champions. Сторінка розкладу показує матчі всіх ліг, зокрема Game Changers, а глобальні силові рейтинги — найсильніші команди. Новини розповідають про турніри й акції Watch and Earn з нагородами за перегляд.', 'VALORANT Esports is the official place to watch Valorant esports. The schedule covers the whole season: Kickoff, Stage 1 and Stage 2 in the regions, plus international Masters and Champions. The schedule page shows matches from all leagues, including Game Changers, and global power rankings list the strongest teams. News covers events and Watch and Earn campaigns with viewing rewards.', 'Розклад сезону VCT
Матчі всіх ліг, зокрема Game Changers
Силові рейтинги команд
Нагороди за перегляд
Офіційні новини', 'VCT season schedule
Matches from all leagues incl. Game Changers
Team power rankings
Viewing rewards
Official news', 'Уболівальники кіберспорту Valorant.', 'Valorant esports fans.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'valorantesports.com' OR LOWER(`name`) = LOWER('VALORANT Esports')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'VALORANT Esports is Riot Games'' official Valorant esports site: the VCT season schedule from Kickoff to Champions, matches from all leagues, team power rankings, news and viewing rewards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'VALORANT Esports is the official place to watch Valorant esports. The schedule covers the whole season: Kickoff, Stage 1 and Stage 2 in the regions, plus international Masters and Champions. The schedule page shows matches from all leagues, including Game Changers, and global power rankings list the strongest teams. News covers events and Watch and Earn campaigns with viewing rewards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'VCT season schedule
Matches from all leagues incl. Game Changers
Team power rankings
Viewing rewards
Official news', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Valorant esports fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Перегляд трансляцій і розкладу', 'Watching broadcasts and schedules' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Watching broadcasts and schedules', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- VDO.Ninja — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vdo.ninja' OR LOWER(`name`) = LOWER('VDO.Ninja'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'VDO.Ninja', NULL, 'https://vdo.ninja', NULL, NULL, 'VDO.Ninja — безкоштовний сервіс, що передає живе відео зі смартфона, комп''ютера чи від друзів прямо у вашу студію через джерело «Browser Source» в OBS; є кімнати з режимом режисера.', 'VDO.Ninja is a free service that brings live video from a smartphone, computer or friends directly into your studio via an OBS Browser Source, with rooms and a director mode.', 'VDO.Ninja дозволяє приводити живе відео зі смартфона, комп''ютера чи від друзів просто у свою студію — повністю безкоштовно. Отримане посилання вставляється в OBS як «Browser Source», і відео з''являється в сцені. Кімнати дають груповий чат та інструменти для керування кількома гостями: режисер бачить і чує всіх, може вимикати гостям звук чи камеру, вибирати відеокодек і вирішувати, чи бачать гості один одного. Сервіс підтримує демонстрацію екрана й запис і популярний серед кіберспортивних трансляцій для підключення гравців і коментаторів.', 'VDO.Ninja brings live video from your smartphone, computer or friends directly into your studio, 100% free. You paste the generated link into OBS as a Browser Source and the video appears in your scene. Rooms provide group chat and tools to manage multiple guests: the director sees and hears everyone, can mute guests or disable their cameras, choose a video codec and decide whether guests see each other. It supports screen sharing and recording and is popular in esports productions for bringing in players and casters.', 'Відео з телефона чи ПК в OBS
Кімнати з режисером
Керування гостями
Демонстрація екрана
Безкоштовно', 'Phone or PC video into OBS
Rooms with a director
Guest management
Screen sharing
Free', 'Стримери й продакшн-команди кіберспортивних трансляцій.', 'Streamers and esports broadcast production teams.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vdo.ninja' OR LOWER(`name`) = LOWER('VDO.Ninja')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'VDO.Ninja is a free service that brings live video from a smartphone, computer or friends directly into your studio via an OBS Browser Source, with rooms and a director mode.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'VDO.Ninja brings live video from your smartphone, computer or friends directly into your studio, 100% free. You paste the generated link into OBS as a Browser Source and the video appears in your scene. Rooms provide group chat and tools to manage multiple guests: the director sees and hears everyone, can mute guests or disable their cameras, choose a video codec and decide whether guests see each other. It supports screen sharing and recording and is popular in esports productions for bringing in players and casters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Phone or PC video into OBS
Rooms with a director
Guest management
Screen sharing
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Streamers and esports broadcast production teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Повністю безкоштовно', '100% free' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '100% free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- VLR.gg — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vlr.gg' OR LOWER(`name`) = LOWER('VLR.gg'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'VLR.gg', NULL, 'https://www.vlr.gg', NULL, NULL, 'VLR.gg — кіберспортивний портал Valorant: новини, розклад і результати матчів, турніри, рейтинги команд, статистика та форуми з режимом без спойлерів.', 'VLR.gg covers Valorant esports: news, match schedules and results, events, team rankings, stats and forums, with a spoiler-free mode.', 'VLR.gg — головний ресурс про кіберспорт Valorant: новини змагань, розклад, результати матчів, рейтинги команд, статистика й форуми. Головна сторінка показує найближчі й завершені матчі VCT та інших турнірів зі зворотним відліком, а форум — активні обговорення й Pick''ems до великих турнірів. Можна ввімкнути нічну тему й приховати рахунки, щоб уникнути спойлерів. Розділи подій, рейтингів і статистики допомагають стежити за командами й гравцями протягом сезону.', 'VLR.gg is a key resource for Valorant esports: competitive news, schedules, match results, team rankings, stats and forums. The home page shows upcoming and completed VCT and other matches with countdowns, while the forum hosts active discussions and Pick''ems for major events. You can switch on night mode and hide scores to avoid spoilers. Events, rankings and stats sections help you follow teams and players throughout the season.', 'Розклад і результати матчів Valorant
Рейтинги команд
Статистика гравців і команд
Форуми й Pick''ems
Режим без спойлерів', 'Valorant match schedules and results
Team rankings
Player and team stats
Forums and Pick''ems
Spoiler-free mode', 'Уболівальники й аналітики кіберспорту Valorant.', 'Valorant esports fans and analysts.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vlr.gg' OR LOWER(`name`) = LOWER('VLR.gg')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'VLR.gg covers Valorant esports: news, match schedules and results, events, team rankings, stats and forums, with a spoiler-free mode.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'VLR.gg is a key resource for Valorant esports: competitive news, schedules, match results, team rankings, stats and forums. The home page shows upcoming and completed VCT and other matches with countdowns, while the forum hosts active discussions and Pick''ems for major events. You can switch on night mode and hide scores to avoid spoilers. Events, rankings and stats sections help you follow teams and players throughout the season.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Valorant match schedules and results
Team rankings
Player and team stats
Forums and Pick''ems
Spoiler-free mode', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Valorant esports fans and analysts.', 'manual' FROM DUAL WHERE @new = 1;

-- Voltaic — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'voltaic.gg' OR LOWER(`name`) = LOWER('Voltaic'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Voltaic', NULL, 'https://www.voltaic.gg', NULL, NULL, 'Voltaic — освітня спільнота й елітна команда з аіму для FPS-ігор: бенчмарки для оцінки аіму, коучинг Amped Aim, ресурси для Valorant, CS2, Overwatch 2, Apex і Discord.', 'Voltaic is an educational community and elite aiming team for FPS games: benchmarks to assess your aim, Amped Aim coaching, resources for Valorant, CS2, Overwatch 2, Apex and a Discord.', 'Voltaic — освітня спільнота й елітна команда з аіму, зосереджена на вдосконаленні, аімі та кіберспортивних талантах у FPS-іграх; її називають домом аім-тренування. Власні бенчмарки дозволяють оцінити свій аім для будь-якої FPS-гри. Сервіс коучингу Amped Aim орієнтований на гравців рівня T1/T2, які хочуть покращити механіку. Є ресурси для вдосконалення у Valorant, Counter-Strike 2, Overwatch 2 і Apex Legends, відео про аім, блог, магазин мерчу та великий Discord-сервер.', 'Voltaic is an educational community and elite aiming team focused on improvement, aim and esports talent in FPS games, often called the home of aim training. Its custom benchmarks let you assess your aim for any FPS game. The Amped Aim coaching service targets T1/T2 players who want to improve mechanics. There are improvement resources for Valorant, Counter-Strike 2, Overwatch 2 and Apex Legends, aim videos, a blog, a merch shop and a large Discord server.', 'Бенчмарки для оцінки аіму
Коучинг Amped Aim
Ресурси для Valorant, CS2, Overwatch 2, Apex
Відео про аім
Спільнота в Discord', 'Aim assessment benchmarks
Amped Aim coaching
Resources for Valorant, CS2, Overwatch 2, Apex
Aim videos
Discord community', 'FPS-гравці, які серйозно тренують аім.', 'FPS players serious about aim training.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'voltaic.gg' OR LOWER(`name`) = LOWER('Voltaic')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Voltaic is an educational community and elite aiming team for FPS games: benchmarks to assess your aim, Amped Aim coaching, resources for Valorant, CS2, Overwatch 2, Apex and a Discord.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Voltaic is an educational community and elite aiming team focused on improvement, aim and esports talent in FPS games, often called the home of aim training. Its custom benchmarks let you assess your aim for any FPS game. The Amped Aim coaching service targets T1/T2 players who want to improve mechanics. There are improvement resources for Valorant, Counter-Strike 2, Overwatch 2 and Apex Legends, aim videos, a blog, a merch shop and a large Discord server.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Aim assessment benchmarks
Amped Aim coaching
Resources for Valorant, CS2, Overwatch 2, Apex
Aim videos
Discord community', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'FPS players serious about aim training.', 'manual' FROM DUAL WHERE @new = 1;

-- VRS — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vrs.racing' OR LOWER(`name`) = LOWER('VRS'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'VRS', NULL, 'https://vrs.racing', NULL, NULL, 'VRS — обладнання для сім-рейсингу й коучинг iRacing: база керма DirectForce Pro з прямим приводом, керма, педалі, кокпіти, академія, сетапи, телеметрія й безкоштовні карти трас.', 'VRS offers sim racing hardware and iRacing coaching: DirectForce Pro direct-drive wheel bases, wheels, pedals, cockpits, an academy, setups, telemetry and free track maps.', 'VRS поєднує обладнання для сім-рейсингу й інструменти, що допомагають стати швидшим в iRacing. Лінійка DirectForce Pro включає бази керма з прямим приводом і технологією NextGen FFB, керма GT і формульного типу, педалі, кокпіт GT-2 і кастомні симулятори. Академія VRS пропонує коучинг, сетапи, програму для NASCAR, безкоштовні карти трас iRacing та інструменти телеметрії на платформі для учасників. Є блог, завантаження й підтримка.', 'VRS combines sim racing hardware with tools to help you get faster in iRacing. The DirectForce Pro line includes direct-drive wheel bases with NextGen FFB, GT and formula wheels, pedals, the GT-2 cockpit and custom simulators. The VRS Academy offers coaching, setups, a NASCAR program, free iRacing track maps and telemetry tools on its member platform. There is a blog, downloads and support.', 'Бази керма з прямим приводом
Керма, педалі й кокпіти
Коучинг iRacing
Сетапи й телеметрія
Безкоштовні карти трас', 'Direct-drive wheel bases
Wheels, pedals and cockpits
iRacing coaching
Setups and telemetry
Free track maps', 'Сім-рейсери iRacing, які хочуть покращити час кола.', 'iRacing sim racers who want faster lap times.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vrs.racing' OR LOWER(`name`) = LOWER('VRS')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'VRS offers sim racing hardware and iRacing coaching: DirectForce Pro direct-drive wheel bases, wheels, pedals, cockpits, an academy, setups, telemetry and free track maps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'VRS combines sim racing hardware with tools to help you get faster in iRacing. The DirectForce Pro line includes direct-drive wheel bases with NextGen FFB, GT and formula wheels, pedals, the GT-2 cockpit and custom simulators. The VRS Academy offers coaching, setups, a NASCAR program, free iRacing track maps and telemetry tools on its member platform. There is a blog, downloads and support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Direct-drive wheel bases
Wheels, pedals and cockpits
iRacing coaching
Setups and telemetry
Free track maps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'iRacing sim racers who want faster lap times.', 'manual' FROM DUAL WHERE @new = 1;

-- Wootility — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wootility.io' OR LOWER(`name`) = LOWER('Wootility'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Wootility', NULL, 'https://wootility.io', NULL, NULL, 'Wootility — програма налаштування клавіатур Wooting з аналоговими перемикачами: унікальні налаштування спрацьовування, профілі спільноти, не потребує роботи у фоні після збереження.', 'Wootility configures Wooting analog keyboards: unique actuation settings, community profiles, and it doesn''t need to run in the background once you save.', 'Wootility — місце, де можна швидко налаштувати пристрої Wooting, експериментувати з унікальними параметрами й підлаштувати клавіатуру під себе. Після налаштування програма не має працювати у фоні: зберегли, закрили й граєте. Можна шукати й ділитися профілями, створеними спільнотою, брати участь у Discord-спільноті Wooting і повідомляти про помилки та ідеї на GitHub. Оглядове відео показує всі основні функції й допомагає зібрати налаштування під свою гру. Доступна веб-версія.', 'Wootility is where you configure Wooting devices in a snap, play with unique settings and customize your keyboard. It doesn''t need to run in the background afterwards: save, close and play. You can search and share community-made profiles, join the Wooting Discord and post bug reports and feature requests on GitHub. An overview video walks through all core features to help you build the right setup for your game. A web version is available.', 'Налаштування клавіатур Wooting
Унікальні параметри спрацьовування
Профілі спільноти
Не працює у фоні
Веб-версія', 'Wooting keyboard configuration
Unique actuation settings
Community profiles
No background process
Web version', 'Власники клавіатур Wooting, зокрема кіберспортсмени.', 'Wooting keyboard owners, including esports players.', 'web,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wootility.io' OR LOWER(`name`) = LOWER('Wootility')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Wootility configures Wooting analog keyboards: unique actuation settings, community profiles, and it doesn''t need to run in the background once you save.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Wootility is where you configure Wooting devices in a snap, play with unique settings and customize your keyboard. It doesn''t need to run in the background afterwards: save, close and play. You can search and share community-made profiles, join the Wooting Discord and post bug reports and feature requests on GitHub. An overview video walks through all core features to help you build the right setup for your game. A web version is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Wooting keyboard configuration
Unique actuation settings
Community profiles
No background process
Web version', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Wooting keyboard owners, including esports players.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для клавіатур Wooting', 'For Wooting keyboards' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For Wooting keyboards', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Workshop.codes — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'workshop.codes' OR LOWER(`name`) = LOWER('Workshop.codes'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Workshop.codes', NULL, 'https://workshop.codes', NULL, NULL, 'Workshop.codes — каталог кодів Overwatch Workshop: аім-тренери, режими 1v1 і власні ігрові режими спільноти з пошуком, вікі та браузерним редактором коду.', 'Workshop.codes is a catalog of Overwatch Workshop codes: aim trainers, 1v1 modes and community game modes, with search, a wiki and a browser-based code editor.', 'Workshop.codes допомагає знаходити й ділитися кодами Overwatch Workshop, щоб грати з друзями, випадковими гравцями чи самостійно. Серед популярних кодів — аім-тренери, дуелі 1v1 на хедшоти, тренування з ботами й розминки на флік-постріли, а також ігрові режими на кшталт Tower Defense чи Genji Ball. Коди можна сортувати за популярністю, переглядами й датою оновлення. Для авторів є браузерний редактор Workshop.codes зі звичним синтаксисом, папками, міксинами й автоматичними змінними, вікі та посилання на OverPy для розробки режимів.', 'Workshop.codes helps you find and share Overwatch Workshop codes to play with friends, randoms or solo. Popular codes include aim trainers, 1v1 headshot duels, bot training and flick warmups, plus game modes such as tower defense or Genji Ball. Codes can be sorted by favourites, views and last update. For creators there is the browser-based Workshop.codes Editor with familiar syntax, folders, mixins and automatic variables, a wiki and a link to OverPy for mode development.', 'Каталог кодів Overwatch Workshop
Аім-тренери й дуелі 1v1
Пошук і сортування за популярністю
Браузерний редактор коду
Вікі для авторів режимів', 'Overwatch Workshop code catalog
Aim trainers and 1v1 duels
Search and sort by popularity
Browser-based code editor
Wiki for mode creators', 'Гравці Overwatch, які тренують аім, і автори власних режимів.', 'Overwatch players training aim and creators of custom modes.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'workshop.codes' OR LOWER(`name`) = LOWER('Workshop.codes')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Workshop.codes is a catalog of Overwatch Workshop codes: aim trainers, 1v1 modes and community game modes, with search, a wiki and a browser-based code editor.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Workshop.codes helps you find and share Overwatch Workshop codes to play with friends, randoms or solo. Popular codes include aim trainers, 1v1 headshot duels, bot training and flick warmups, plus game modes such as tower defense or Genji Ball. Codes can be sorted by favourites, views and last update. For creators there is the browser-based Workshop.codes Editor with familiar syntax, folders, mixins and automatic variables, a wiki and a link to OverPy for mode development.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Overwatch Workshop code catalog
Aim trainers and 1v1 duels
Search and sort by popularity
Browser-based code editor
Wiki for mode creators', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Overwatch players training aim and creators of custom modes.', 'manual' FROM DUAL WHERE @new = 1;

-- WTFast — Кіберспорт
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wtfast.com' OR LOWER(`name`) = LOWER('WTFast'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'WTFast', NULL, 'https://www.wtfast.com', NULL, NULL, 'WTFast — GPN (Gamers Private Network): мережа з AI, оптимізована для ігрового трафіку, що автоматично обирає кращий шлях до серверів, знижує пінг і втрати пакетів у понад 1000 іграх.', 'WTFast is a GPN (Gamers Private Network): an AI-powered network optimized for game traffic that automatically picks a better path to servers, lowering ping and packet loss in 1,000+ games.', 'WTFast використовує запатентовані алгоритми, щоб зменшити лаги, знизити пінг і оптимізувати з''єднання в онлайн-іграх. Це не VPN, а GPN — приватна мережа для геймерів з AI, оптимізована саме під ігровий трафік. За допомогою машинного навчання система автоматично обирає оптимальний шлях для ігрового з''єднання, тож менше затримок і втрачених пакетів. Аналітика в реальному часі показує, що відбувається з даними на шляху до ігрових серверів. Підтримується понад 1000 ігор, є безкоштовний пробний період і рішення для роутерів.', 'WTFast uses patented algorithms to reduce lag, lower ping and optimize your online gaming connection. It is not a VPN but a GPN, an AI-powered Gamers Private Network optimized for game traffic. Using machine learning, the system automatically selects an optimized path for your game connection, reducing latency and lost packets. Real-time analytics show what happens to your data on the way to game servers. Over 1,000 games are supported, with a free trial and router solutions.', 'Мережа GPN для ігрового трафіку
Автоматичний вибір маршруту з AI
Менше пінгу й втрат пакетів
Аналітика в реальному часі
1000+ ігор', 'GPN for game traffic
AI automatic route selection
Lower ping and packet loss
Real-time analytics
1,000+ games', 'Онлайн-гравці, яким важлива стабільність з''єднання.', 'Online players who need a stable connection.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-06 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wtfast.com' OR LOWER(`name`) = LOWER('WTFast')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'sports' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'sports' AND s.`slug` = 'esports' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'WTFast is a GPN (Gamers Private Network): an AI-powered network optimized for game traffic that automatically picks a better path to servers, lowering ping and packet loss in 1,000+ games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'WTFast uses patented algorithms to reduce lag, lower ping and optimize your online gaming connection. It is not a VPN but a GPN, an AI-powered Gamers Private Network optimized for game traffic. Using machine learning, the system automatically selects an optimized path for your game connection, reducing latency and lost packets. Real-time analytics show what happens to your data on the way to game servers. Over 1,000 games are supported, with a free trial and router solutions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'GPN for game traffic
AI automatic route selection
Lower ping and packet loss
Real-time analytics
1,000+ games', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Online players who need a stable connection.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Free trial', 0.00, 'free', 'Безкоштовна спроба', 'Try for free' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний період' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Try for free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
