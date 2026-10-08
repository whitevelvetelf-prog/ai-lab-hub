SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-08: підкатегорія «Для геймерів» / «For Gamers» (slug for-gamers)
-- у категорії «Мультимедіа» (slug multimedia) + 1 новий продукт + прив'язка наявних.
--   Новий: Mantella — Для геймерів
--   Прив'язуються (наявні зв'язки не змінюються): Aimlabs, Mobalytics, Blitz, iTero, Krisp, Voicemod, NVIDIA Project G-Assist, OBS Studio, AI Dungeon (Latitude), Character.AI
--   Aimlabs, Mobalytics, Blitz, iTero вже є в каталозі (Спорт → Для тренерів) — не дублюються.
-- Без фіксованих id: підкатегорія й продукти шукаються за slug / адресою / назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'multimedia' LIMIT 1);

INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`)
SELECT @cat, 'Для геймерів', 'For Gamers', 'for-gamers' FROM DUAL
WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'for-gamers');
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'for-gamers' LIMIT 1);

-- Mantella — Для геймерів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'art-from-the-machine.github.io/mantella' OR LOWER(`name`) = 'mantella')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mantella', NULL, 'https://art-from-the-machine.github.io/Mantella/', NULL, NULL, 'Безкоштовний мод для Skyrim і Fallout 4, який дозволяє розмовляти з NPC голосом.', 'A free mod for Skyrim and Fallout 4 that lets you talk to NPCs with your voice.', 'Ви говорите в мікрофон, мод розпізнає мову, звертається до мовної моделі й озвучує відповідь голосом персонажа. За даними сторінки проєкту, можна розмовляти з понад 3000 NPC, у кожного своя передісторія. Вони пам''ятають попередні розмови, знають про події в грі й навіть бачать те, що бачите ви. Усе можна запустити локально на власному ПК або підключити OpenAI, OpenRouter чи будь-який сумісний API. Мод працює з модпаками Wabbajack. Якість розмов залежить від обраної моделі та вашого обладнання.', 'You speak into a microphone, the mod recognizes your speech, asks a language model and voices the reply in the character''s voice. According to the project page, you can talk to more than 3,000 NPCs, each with their own backstory. They remember previous conversations, know about events in the game and can even see what you see. You can run everything locally on your own PC or connect OpenAI, OpenRouter or any compatible API. The mod works with Wabbajack modpacks. The quality of conversations depends on the chosen model and your hardware.', 'Розмови з NPC голосом через мікрофон
Понад 3000 NPC зі своїми передісторіями
Пам''ять про попередні розмови
Обізнаність про події в грі
Локальний запуск або підключення зовнішнього API', 'Voice conversations with NPCs through a microphone
More than 3,000 NPCs with their own backstories
Memory of previous conversations
Awareness of in-game events
Local run or an external API connection', 'Гравці Skyrim і Fallout 4 на ПК, яким бракує живих діалогів з NPC.', 'Skyrim and Fallout 4 players on PC who miss lively dialogue with NPCs.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-08 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'art-from-the-machine.github.io/mantella' OR LOWER(`name`) = 'mantella') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free mod for Skyrim and Fallout 4 that lets you talk to NPCs with your voice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'You speak into a microphone, the mod recognizes your speech, asks a language model and voices the reply in the character''s voice. According to the project page, you can talk to more than 3,000 NPCs, each with their own backstory. They remember previous conversations, know about events in the game and can even see what you see. You can run everything locally on your own PC or connect OpenAI, OpenRouter or any compatible API. The mod works with Wabbajack modpacks. The quality of conversations depends on the chosen model and your hardware.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Voice conversations with NPCs through a microphone
More than 3,000 NPCs with their own backstories
Memory of previous conversations
Awareness of in-game events
Local run or an external API connection', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Skyrim and Fallout 4 players on PC who miss lively dialogue with NPCs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Сам мод безкоштовний і має відкритий код. Умови й вартість зовнішнього сервісу мовної моделі, якщо ви його підключаєте, встановлює цей сервіс.', 'The mod itself is free and open source. If you connect an external language model service, its terms and pricing are set by that service.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The mod itself is free and open source. If you connect an external language model service, its terms and pricing are set by that service.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Aimlabs — додатково в «Для геймерів»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Aimlabs') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
-- Mobalytics — додатково в «Для геймерів»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Mobalytics') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
-- Blitz — додатково в «Для геймерів»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Blitz') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
-- iTero — додатково в «Для геймерів»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('iTero') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
-- Krisp — додатково в «Для геймерів»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Krisp') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
-- Voicemod — додатково в «Для геймерів»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Voicemod') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
-- NVIDIA Project G-Assist — додатково в «Для геймерів»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('NVIDIA Project G-Assist') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
-- OBS Studio — додатково в «Для геймерів»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('OBS Studio') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
-- AI Dungeon (Latitude) — додатково в «Для геймерів»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('AI Dungeon (Latitude)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
-- Character.AI — додатково в «Для геймерів»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Character.AI') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Перевірка: кількість продуктів у підкатегорії
SELECT COUNT(*) AS for_gamers_products FROM `product_subcategories` WHERE `subcategory_id` = @sub;
