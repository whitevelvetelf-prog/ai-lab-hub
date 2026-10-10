SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-07: 9 нових продуктів для нових підгруп категорії «Розробка та IT» .
-- Платні й безкоштовні застосунки, сервіси й онлайн-ресурси за підкатегоріями:
--   Розробка ігор (game-development): 9
-- Лише справжні сервіси: сайти перевірено (відповідають, назва на сторінці). Відкинуто неробочі,
-- припарковані й захоплені домени, Cloudflare-перевірки, новинні сайти, благодійні фонди,
-- інвестиційні сервіси, астрологію, знайомства, продаж БАДів, сайти з медичними твердженнями. Тексти описові, без маркетингових оцінок.
-- Тексти, функції й тарифи (UA + EN) — лише з офіційних сайтів, звірено 2026-10-07.
-- Потребує міграції database/migration-2026-10-07-game-development.sql (нові підкатегорії).
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт» (файл .sql або .sql.zip). Повторний запуск безпечний.
--   AI Dungeon (Latitude) — Розробка ігор
--   Convai — Розробка ігор
--   Inworld AI — Розробка ігор
--   Meshy — Розробка ігор
--   modl.ai — Розробка ігор
--   NVIDIA Project G-Assist — Розробка ігор
--   Promethean AI — Розробка ігор
--   Rosebud AI — Розробка ігор
--   Scenario — Розробка ігор
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);

-- AI Dungeon (Latitude) — Розробка ігор
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aidungeon.com' OR LOWER(`name`) = LOWER('AI Dungeon (Latitude)'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AI Dungeon (Latitude)', NULL, 'https://aidungeon.com', NULL, NULL, 'AI Dungeon від Latitude — AI-платформа текстових рольових пригод, де сюжет генерується динамічно у відповідь на дії гравця.', 'AI Dungeon by Latitude is an AI text adventure platform where the story is generated dynamically in response to player actions.', 'Безкоштовна текстова рольова гра з AI: гравець обирає жанр або власний сеттинг і персонажів, а модель продовжує історію на кожну дію без заздалегідь написаного сценарію. Є спільнота сценаріїв і світів, веб-версія та застосунки; підписка відкриває потужніші моделі й більшу пам''ять контексту.', 'A free AI text role-playing game: the player picks a genre or their own setting and characters, and the model continues the story after every action without a prewritten script. There is a community of scenarios and worlds, a web version and apps; a subscription unlocks stronger models and longer context memory.', 'Динамічна генерація сюжету
Власні світи й персонажі
Спільнота сценаріїв
Веб і застосунки', 'Dynamic story generation
Custom worlds and characters
Scenario community
Web and apps', 'Розробники наративних ігор і любителі текстових пригод.', 'Narrative game developers and text adventure fans.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aidungeon.com' OR LOWER(`name`) = LOWER('AI Dungeon (Latitude)')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' AND s.`slug` = 'game-development' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI Dungeon by Latitude is an AI text adventure platform where the story is generated dynamically in response to player actions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A free AI text role-playing game: the player picks a genre or their own setting and characters, and the model continues the story after every action without a prewritten script. There is a community of scenarios and worlds, a web version and apps; a subscription unlocks stronger models and longer context memory.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Dynamic story generation
Custom worlds and characters
Scenario community
Web and apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Narrative game developers and text adventure fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Базовий доступ', 'Basic access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Підписка', 'Subscription', NULL, 'month', 'Потужніші моделі й більша пам''ять', 'Stronger models and more memory' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Stronger models and more memory', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Convai — Розробка ігор
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'convai.com' OR LOWER(`name`) = LOWER('Convai'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Convai', NULL, 'https://convai.com', NULL, NULL, 'Convai — конструктор розмовних AI-NPC, аватарів і віртуальних людей з розумінням природної мови й емоціями; є безкоштовний тариф.', 'Convai builds conversational AI NPCs, avatars and virtual humans with natural language understanding and emotions; free tier available.', 'Платформа для створення персонажів, з якими гравці говорять голосом: діалоги без глибокого програмування, розуміння природної мови, емоційні реакції й дії в сцені, плагіни для Unity, Unreal та вебу, хмарний Avatar Studio. Тарифи: Free (100 взаємодій на місяць), Indie Dev — 29 $ на місяць, Professional — 99 $, Scale — 499 $; річна оплата дешевша.', 'A platform for characters players talk to by voice: dialogues without deep programming, natural language understanding, emotional reactions and in-scene actions, plugins for Unity, Unreal and web, and the cloud Avatar Studio. Plans: Free (100 interactions a month), Indie Dev at $29 a month, Professional at $99 and Scale at $499; yearly billing is cheaper.', 'Конструктор діалогів NPC
Розуміння природної мови
Емоційні реакції персонажа
Плагіни для Unity й Unreal', 'NPC dialogue builder
Natural language understanding
Emotional character reactions
Unity and Unreal plugins', 'Інді-розробники й студії, що додають розмовних персонажів.', 'Indie devs and studios adding conversational characters.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'convai.com' OR LOWER(`name`) = LOWER('Convai')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' AND s.`slug` = 'game-development' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Convai builds conversational AI NPCs, avatars and virtual humans with natural language understanding and emotions; free tier available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform for characters players talk to by voice: dialogues without deep programming, natural language understanding, emotional reactions and in-scene actions, plugins for Unity, Unreal and web, and the cloud Avatar Studio. Plans: Free (100 interactions a month), Indie Dev at $29 a month, Professional at $99 and Scale at $499; yearly billing is cheaper.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'NPC dialogue builder
Natural language understanding
Emotional character reactions
Unity and Unreal plugins', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Indie devs and studios adding conversational characters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', '100 взаємодій на місяць', '100 interactions a month' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '100 interactions a month', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Indie Dev', 'Indie Dev', 29.00, 'month', '3 000 взаємодій на місяць', '3,000 interactions a month' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Indie Dev' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Indie Dev', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '3,000 interactions a month', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Professional', 'Professional', 99.00, 'month', '10 000 взаємодій на місяць', '10,000 interactions a month' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Professional' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Professional', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '10,000 interactions a month', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Scale', 'Scale', 499.00, 'month', '50 000 взаємодій на місяць', '50,000 interactions a month' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Scale' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Scale', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '50,000 interactions a month', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Inworld AI — Розробка ігор
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'inworld.ai' OR LOWER(`name`) = LOWER('Inworld AI'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Inworld AI', NULL, 'https://inworld.ai', NULL, NULL, 'Inworld AI — платформа реалтайм-AI для інтерактивних застосунків та ігор: голосові персонажі й NPC з емоційною озвучкою, TTS, STT і LLM.', 'Inworld AI is a realtime AI platform for interactive apps and games: voiced characters and NPCs with emotional TTS, STT and LLMs.', 'Inworld відома як платформа для живих NPC з пам''яттю й емоціями, а тепер пропонує повний стек реалтайм-AI для ігор і медіа, компаньйонів і освіти: емоційний синтез мовлення Inworld TTS, розпізнавання мовлення, клонування голосу й доступ до LLM. Розробники ігор використовують її для персонажів, з якими гравці розмовляють голосом. Ціна залежить від використання: старт безкоштовний, далі оплата за обсяг.', 'Inworld is known as a platform for lifelike NPCs with memory and emotions and now offers a full realtime AI stack for games and media, companions and education: emotional Inworld TTS speech synthesis, speech recognition, voice cloning and LLM access. Game developers use it for characters players talk to by voice. Pricing is usage-based: start free, then pay for volume.', 'Голосові AI-персонажі та NPC
Емоційний синтез мовлення Inworld TTS
Клонування голосу й STT
Оплата за використання', 'Voiced AI characters and NPCs
Emotional Inworld TTS
Voice cloning and STT
Usage-based pricing', 'Студії, що створюють RPG, наративні й симуляційні ігри з живими персонажами.', 'Studios making RPGs, narrative and simulation games with lifelike characters.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'inworld.ai' OR LOWER(`name`) = LOWER('Inworld AI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' AND s.`slug` = 'game-development' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Inworld AI is a realtime AI platform for interactive apps and games: voiced characters and NPCs with emotional TTS, STT and LLMs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Inworld is known as a platform for lifelike NPCs with memory and emotions and now offers a full realtime AI stack for games and media, companions and education: emotional Inworld TTS speech synthesis, speech recognition, voice cloning and LLM access. Game developers use it for characters players talk to by voice. Pricing is usage-based: start free, then pay for volume.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Voiced AI characters and NPCs
Emotional Inworld TTS
Voice cloning and STT
Usage-based pricing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Studios making RPGs, narrative and simulation games with lifelike characters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'On-Demand', 'On-Demand', 0.00, 'free', 'Безкоштовний старт; TTS-2 — 25 $ за 1 млн символів', 'Free start; TTS-2 at $25 per 1M characters' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'On-Demand' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'On-Demand', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free start; TTS-2 at $25 per 1M characters', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'month', 'Індивідуальна ціна для студій', 'Custom pricing for studios' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Custom pricing for studios', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Meshy — Розробка ігор
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'meshy.ai' OR LOWER(`name`) = LOWER('Meshy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Meshy', NULL, 'https://www.meshy.ai', NULL, NULL, 'Meshy перетворює текстові описи чи референсні зображення на готові для гри 3D-моделі з текстурами.', 'Meshy turns text prompts or reference images into game-ready textured 3D models.', 'AI-генератор 3D-моделей з тексту чи зображень з текстуруванням і експортом у формати ігрових рушіїв.', 'An AI 3D model generator from text or images with texturing and export to game engine formats.', '3D з тексту чи зображення
Текстурування
Формати для рушіїв', '3D from text or image
Texturing
Engine-ready formats', '3D-художники та інді-студії.', '3D artists and indie studios.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'meshy.ai' OR LOWER(`name`) = LOWER('Meshy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' AND s.`slug` = 'game-development' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Meshy turns text prompts or reference images into game-ready textured 3D models.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An AI 3D model generator from text or images with texturing and export to game engine formats.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '3D from text or image
Texturing
Engine-ready formats', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', '3D artists and indie studios.', 'manual' FROM DUAL WHERE @new = 1;

-- modl.ai — Розробка ігор
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'modl.ai' OR LOWER(`name`) = LOWER('modl.ai'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'modl.ai', NULL, 'https://modl.ai', NULL, NULL, 'modl.ai — AI-агенти для автоматизованого тестування ігор: пошук багів до релізу без інтеграції SDK та з інструкціями звичайною мовою.', 'modl.ai provides AI agents for automated game testing: finding bugs before release with no SDK integration and plain-language instructions.', 'Сервіс для QA-команд ігрових студій: AI-агенти автоматично грають і тестують гру, а AI-аналітики формують звіти про баги й проблемні місця. Рішення працює без SDK і змін у коді, тестові сценарії задаються звичайною мовою — від щоденних смоук-тестів до ширшого покриття. Ціна корпоративна, за запитом (демо на сайті).', 'A service for game studio QA teams: AI agents play and test the game automatically, and AI analysts produce reports on bugs and problem areas. It works without SDKs or code hooks, and test scenarios are written in plain language — from daily smoke tests to broader coverage. Enterprise pricing on request (demo available).', 'AI-боти, що автоматично грають і тестують гру
Виявлення багів і проблем балансу
Без SDK та змін у коді
Звіти про якість гри', 'AI bots that play and test the game
Bug and balance issue detection
No SDK or code changes
Game quality reports', 'Студії, що автоматизують QA-тестування.', 'Studios automating QA testing.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'modl.ai' OR LOWER(`name`) = LOWER('modl.ai')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' AND s.`slug` = 'game-development' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'modl.ai provides AI agents for automated game testing: finding bugs before release with no SDK integration and plain-language instructions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service for game studio QA teams: AI agents play and test the game automatically, and AI analysts produce reports on bugs and problem areas. It works without SDKs or code hooks, and test scenarios are written in plain language — from daily smoke tests to broader coverage. Enterprise pricing on request (demo available).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI bots that play and test the game
Bug and balance issue detection
No SDK or code changes
Game quality reports', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Studios automating QA testing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'month', 'Ціна за запитом', 'Pricing on request' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pricing on request', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- NVIDIA Project G-Assist — Розробка ігор
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nvidia.com/en-us/software/nvidia-app/g-assist' OR LOWER(`name`) = LOWER('NVIDIA Project G-Assist'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NVIDIA Project G-Assist', NULL, 'https://www.nvidia.com/en-us/software/nvidia-app/g-assist/', NULL, NULL, 'Project G-Assist — локальний AI-асистент NVIDIA, що працює на відеокартах GeForce RTX: оптимізує налаштування ігор і ПК та відповідає на голосові й текстові запити.', 'Project G-Assist is NVIDIA''s local AI assistant running on GeForce RTX GPUs: it optimizes game and PC settings and answers voice and text requests.', 'Асистент у NVIDIA App, що працює локально на відеокарті без хмари. Допомагає оптимізувати графічні налаштування під конкретну гру, змінювати параметри системи й периферії, стежити за продуктивністю в реальному часі та підтримує плагіни. Безкоштовний для власників сумісних GeForce RTX.', 'An assistant in the NVIDIA App that runs locally on the GPU without the cloud. It helps optimize graphics settings per game, change system and peripheral settings, monitor performance in real time and supports plugins. Free for owners of compatible GeForce RTX GPUs.', 'Локальна робота без хмари
Оптимізація налаштувань гри
Моніторинг продуктивності
Плагіни', 'Local, no cloud
Game settings optimization
Performance monitoring
Plugins', 'Гравці з відеокартами NVIDIA RTX.', 'Gamers with NVIDIA RTX GPUs.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nvidia.com/en-us/software/nvidia-app/g-assist' OR LOWER(`name`) = LOWER('NVIDIA Project G-Assist')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' AND s.`slug` = 'game-development' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Project G-Assist is NVIDIA''s local AI assistant running on GeForce RTX GPUs: it optimizes game and PC settings and answers voice and text requests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An assistant in the NVIDIA App that runs locally on the GPU without the cloud. It helps optimize graphics settings per game, change system and peripheral settings, monitor performance in real time and supports plugins. Free for owners of compatible GeForce RTX GPUs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local, no cloud
Game settings optimization
Performance monitoring
Plugins', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers with NVIDIA RTX GPUs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Потрібна відеокарта GeForce RTX', 'Requires a GeForce RTX GPU' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Requires a GeForce RTX GPU', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Promethean AI — Розробка ігор
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prometheanai.com' OR LOWER(`name`) = LOWER('Promethean AI'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Promethean AI', NULL, 'https://www.prometheanai.com', NULL, NULL, 'Promethean AI — AI-асистент для дизайну 3D-оточень і роботи з бібліотеками асетів: опишіть сцену, і інструмент підбере й розмістить об''єкти.', 'Promethean AI is an AI assistant for 3D environment design and asset library management: describe a scene and it picks and places objects.', 'Інструмент для художників оточень і левел-дизайнерів: індексує ваші 3D- та матеріальні асети й допомагає швидко збирати з них сцени й світи. Основна інтеграція — Unreal Engine, також є відкриті плагіни для Unity, 3ds Max, Maya й Blender. Понад 10 000 користувачів, серед них PlayStation Studios; підтримка Disney Accelerator.', 'A tool for environment artists and level designers: it indexes your 3D and material assets and helps quickly assemble scenes and worlds from them. The main integration is Unreal Engine, with open plugins for Unity, 3ds Max, Maya and Blender. Over 10,000 users including PlayStation Studios; backed by Disney Accelerator.', 'Дизайн 3D-оточень текстом
Автоматичне розміщення об''єктів
Керування бібліотекою асетів
Плагіни для Unreal, Unity, Blender', '3D environments from text
Automatic object placement
Asset library management
Unreal, Unity, Blender plugins', 'Левел-дизайнери та студії, що створюють ігрові світи.', 'Level designers and studios building game worlds.', 'web,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prometheanai.com' OR LOWER(`name`) = LOWER('Promethean AI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' AND s.`slug` = 'game-development' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Promethean AI is an AI assistant for 3D environment design and asset library management: describe a scene and it picks and places objects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A tool for environment artists and level designers: it indexes your 3D and material assets and helps quickly assemble scenes and worlds from them. The main integration is Unreal Engine, with open plugins for Unity, 3ds Max, Maya and Blender. Over 10,000 users including PlayStation Studios; backed by Disney Accelerator.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '3D environments from text
Automatic object placement
Asset library management
Unreal, Unity, Blender plugins', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Level designers and studios building game worlds.', 'manual' FROM DUAL WHERE @new = 1;

-- Rosebud AI — Розробка ігор
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rosebud.ai' OR LOWER(`name`) = LOWER('Rosebud AI'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Rosebud AI', NULL, 'https://rosebud.ai', NULL, NULL, 'Rosebud AI — платформа «текст-у-гру»: опишіть концепцію звичайною мовою, і AI згенерує код, логіку, фізику й грабельний прототип прямо в браузері.', 'Rosebud AI is a text-to-game platform: describe your concept in plain language and AI generates code, logic, physics and a playable prototype in the browser.', 'Rosebud AI Game Maker дає змогу створити гру, описавши її словами або обравши шаблон: RPG, візуальна новела, затишна гра, інтерактивна історія тощо. AI пише код, логіку й фізику, а гру можна одразу тестувати й правити в браузері. Є генератори 2D-асетів і спрайт-шитів, AI-NPC, бібліотека шаблонів і спільнота з готовими іграми.', 'Rosebud AI Game Maker lets you create a game by describing it or picking a template: RPG, visual novel, cozy game, interactive story and more. AI writes the code, logic and physics, and you can test and edit the game instantly in the browser. It also has 2D asset and sprite sheet generators, AI NPCs, a template library and a community of ready-made games.', 'Генерація гри з текстового опису
Код, фізика й логіка без ручного програмування
Миттєве тестування в браузері
Шаблони й спільнота готових ігор', 'Game generation from a text description
Code, physics and logic without manual coding
Instant in-browser testing
Templates and a community of games', 'Інді-розробники, новачки без досвіду програмування, швидке прототипування ідей.', 'Indie developers, beginners without coding experience, rapid idea prototyping.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rosebud.ai' OR LOWER(`name`) = LOWER('Rosebud AI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' AND s.`slug` = 'game-development' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Rosebud AI is a text-to-game platform: describe your concept in plain language and AI generates code, logic, physics and a playable prototype in the browser.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Rosebud AI Game Maker lets you create a game by describing it or picking a template: RPG, visual novel, cozy game, interactive story and more. AI writes the code, logic and physics, and you can test and edit the game instantly in the browser. It also has 2D asset and sprite sheet generators, AI NPCs, a template library and a community of ready-made games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Game generation from a text description
Code, physics and logic without manual coding
Instant in-browser testing
Templates and a community of games', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Indie developers, beginners without coding experience, rapid idea prototyping.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Базове створення ігор', 'Basic game creation' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic game creation', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', NULL, 'month', 'Розширені можливості, ціна на сайті', 'Advanced features, see site for price' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features, see site for price', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Scenario — Розробка ігор
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scenario.com' OR LOWER(`name`) = LOWER('Scenario'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Scenario', NULL, 'https://www.scenario.com', NULL, NULL, 'Scenario — генерація стилістично узгоджених 2D/3D ігрових асетів (спрайти, текстури, UI) з навчанням власної моделі під стиль гри.', 'Scenario generates style-consistent 2D/3D game assets (sprites, textures, UI) and trains custom models on your game''s style.', 'Креативна AI-інфраструктура для ігрових студій: доступ до 65+ моделей генерації зображень і 3D, навчання власних моделей на референсах гри для єдиного стилю, редагування й командна робота. Безкоштовний рівень дає 50 кредитів щодня, Starter — 1 500 кредитів за 15 $ на місяць, Pro з навчанням власних моделей — 5 000 кредитів за 45 $ на місяць.', 'Creative AI infrastructure for game studios: access to 65+ image and 3D models, training custom models on game references for a consistent style, editing and team collaboration. The free tier gives 50 daily credits, Starter offers 1,500 credits for $15 a month, and Pro with custom model training offers 5,000 credits for $45 a month.', 'Генерація спрайтів, текстур і UI
Навчання власної моделі під стиль гри
Єдиний стиль усіх асетів
Командні робочі простори', 'Sprites, textures and UI generation
Custom model training for your style
Consistent style across assets
Team workspaces', 'Ігрові студії, яким потрібно багато візуальних асетів в єдиному стилі.', 'Game studios needing many visual assets in one style.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scenario.com' OR LOWER(`name`) = LOWER('Scenario')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' AND s.`slug` = 'game-development' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Scenario generates style-consistent 2D/3D game assets (sprites, textures, UI) and trains custom models on your game''s style.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Creative AI infrastructure for game studios: access to 65+ image and 3D models, training custom models on game references for a consistent style, editing and team collaboration. The free tier gives 50 daily credits, Starter offers 1,500 credits for $15 a month, and Pro with custom model training offers 5,000 credits for $45 a month.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sprites, textures and UI generation
Custom model training for your style
Consistent style across assets
Team workspaces', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Game studios needing many visual assets in one style.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', '50 кредитів щодня', '50 daily credits' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '50 daily credits', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Starter', 'Starter', 15.00, 'month', '1 500 кредитів на місяць', '1,500 credits a month' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Starter' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Starter', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '1,500 credits a month', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 45.00, 'month', '5 000 кредитів, навчання власних моделей', '5,000 credits, custom model training' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '5,000 credits, custom model training', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
