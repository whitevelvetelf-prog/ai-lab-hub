SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-19: «Розважальні» / «Entertainment» (slug entertainment) — слабкі підкатегорії.
-- + 3 нових продуктів і 6 прив'язок наявних (функцію звірено на офіційних сайтах 2026-11-19).
-- Якщо продукт із такою адресою чи назвою вже є — лише прив'язка, тексти не змінюються.
-- Пропущено (не вдалося перевірити на офіційних сторінках): Voxal (сторінки немає на сайті NCH), Mematic, AgingBooth
--   (App Store 429), Meme Generator ZomboDroid (сторінка без опису), Canva memes (403), Voilà AI Artist (домен припаркований),
--   Reface для старіння (функції не знайдено). «Зістарення та омолодження» цією партією не поповнено.
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   Clownfish Voice Changer — voice-changers (новий)
--   MorphVOX Pro — voice-changers (новий)
--   Clideo — memes (новий)
--   ElevenLabs — voice-changers (наявний, прив'язка)
--   FineVoice — voice-changers (наявний, прив'язка)
--   Adobe Express — memes (наявний, прив'язка)
--   Glif — memes (наявний, прив'язка)
--   Hailuo AI — dancing-animals (наявний, прив'язка)
--   PicsArt — cartoon-avatars (наявний, прив'язка)
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'entertainment' LIMIT 1);

-- Clownfish Voice Changer
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'clownfish-translator.com/voicechanger' OR LOWER(`name`) = 'clownfish voice changer')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Clownfish Voice Changer', NULL, 'https://clownfish-translator.com/voicechanger/', NULL, NULL, 'Безкоштовна програма для Windows, що змінює голос у всіх застосунках з мікрофоном: Discord, Skype, TeamSpeak, ігри.', 'Windows voice changer that works system-wide in every app that uses the microphone: Discord, Skype, TeamSpeak, games.', 'Clownfish Voice Changer встановлюється на рівні системи, тож змінений голос чують у будь-якому застосунку, що бере звук із мікрофона, — у Discord, Skype, TeamSpeak чи грі. Є близько 15 ефектів (робот, інопланетянин, радіо, гелій, власна висота тону), програвач музики й звуків на гарячих клавішах, озвучування тексту й підтримка VST-плагінів. Починаючи з версії 1.90 звук можна пропускати через VC Client для AI-перетворення голосу моделями RVC. Працює лише на Windows (від Vista до 11).', 'Clownfish Voice Changer installs at system level, so the changed voice is heard in any app that takes sound from the microphone — Discord, Skype, TeamSpeak or a game. It has about 15 effects (robot, alien, radio, helium, custom pitch), a music and sound player with hotkeys, text-to-speech and VST plugin support. Since version 1.90 audio can be routed through VC Client for AI voice conversion with RVC models. Windows only (Vista to 11).', 'Зміна голосу в усіх застосунках з мікрофоном
Близько 15 ефектів голосу
Звуки й музика на гарячих клавішах
AI-перетворення голосу через VC Client (RVC)
Підтримка VST-плагінів', 'Voice changing in every app that uses the microphone
About 15 voice effects
Sounds and music on hotkeys
AI voice conversion via VC Client (RVC)
VST plugin support', 'Геймерам, стримерам і всім, хто хоче пожартувати голосом у Discord, Skype чи іграх.', 'Gamers, streamers and anyone who wants to have fun with their voice in Discord, Skype or games.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'clownfish-translator.com/voicechanger' OR LOWER(`name`) = 'clownfish voice changer') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'voice-changers' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Windows voice changer that works system-wide in every app that uses the microphone: Discord, Skype, TeamSpeak, games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Clownfish Voice Changer installs at system level, so the changed voice is heard in any app that takes sound from the microphone — Discord, Skype, TeamSpeak or a game. It has about 15 effects (robot, alien, radio, helium, custom pitch), a music and sound player with hotkeys, text-to-speech and VST plugin support. Since version 1.90 audio can be routed through VC Client for AI voice conversion with RVC models. Windows only (Vista to 11).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Voice changing in every app that uses the microphone
About 15 voice effects
Sounds and music on hotkeys
AI voice conversion via VC Client (RVC)
VST plugin support', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers, streamers and anyone who wants to have fun with their voice in Discord, Skype or games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MorphVOX Pro
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'screamingbee.com/morphvox-voice-changer' OR LOWER(`name`) = 'morphvox pro')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MorphVOX Pro', NULL, 'https://screamingbee.com/morphvox-voice-changer', NULL, NULL, 'Програма для зміни голосу від Screaming Bee: голоси, придушення шуму, звуки на гарячих клавішах і фони.', 'Voice changer by Screaming Bee: voices, noise cancellation, sounds on hotkeys and background sounds.', 'MorphVOX Pro — програма для зміни голосу від Screaming Bee для ігор і онлайн-спілкування. Змінює голос із придушенням фонового шуму, має набір безкоштовних голосів і звукових пакетів, які можна запускати гарячими клавішами як саундборд, та фонові звуки (вулиця, торговий центр). У новій версії додано режим шумозаглушення, графічний еквалайзер і підлаштування голосу за порівнянням. Для Windows є безкоштовна пробна версія; повна версія продається на сайті.', 'MorphVOX Pro is a voice changer by Screaming Bee for games and online chat. It changes your voice with background noise cancellation, comes with free voices and sound packs you can trigger with hotkeys as a soundboard, and adds background sounds (traffic, shopping mall). The latest version adds a noise reduction mode, a graphic equalizer and voice tuning by comparison. There is a free trial for Windows; the full version is sold on the website.', 'Зміна голосу з придушенням шуму
Безкоштовні голоси й звукові пакети
Саундборд на гарячих клавішах
Фонові звуки
Графічний еквалайзер', 'Voice changing with noise cancellation
Free voices and sound packs
Hotkey soundboard
Background sounds
Graphic equalizer', 'Геймерам, стримерам і всім, хто хоче пожартувати голосом у Discord, Skype чи іграх.', 'Gamers, streamers and anyone who wants to have fun with their voice in Discord, Skype or games.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'screamingbee.com/morphvox-voice-changer' OR LOWER(`name`) = 'morphvox pro') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'voice-changers' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Voice changer by Screaming Bee: voices, noise cancellation, sounds on hotkeys and background sounds.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MorphVOX Pro is a voice changer by Screaming Bee for games and online chat. It changes your voice with background noise cancellation, comes with free voices and sound packs you can trigger with hotkeys as a soundboard, and adds background sounds (traffic, shopping mall). The latest version adds a noise reduction mode, a graphic equalizer and voice tuning by comparison. There is a free trial for Windows; the full version is sold on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Voice changing with noise cancellation
Free voices and sound packs
Hotkey soundboard
Background sounds
Graphic equalizer', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers, streamers and anyone who wants to have fun with their voice in Discord, Skype or games.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free Trial', 'Free Trial', 0.00, 'free', 'Безкоштовна пробна версія для Windows.', 'Free trial for Windows.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free Trial' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free Trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free trial for Windows.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'MorphVOX Pro', 'MorphVOX Pro', 39.99, 'one_time', 'Ціна на сайті Screaming Bee (листопад 2026).', 'Price on the Screaming Bee website (November 2026).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'MorphVOX Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'MorphVOX Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Price on the Screaming Bee website (November 2026).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Clideo
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'clideo.com/meme-maker' OR LOWER(`name`) = 'clideo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Clideo', NULL, 'https://clideo.com/meme-maker', NULL, NULL, 'Онлайн-редактор Clideo з конструктором мемів: картинки, GIF і відео, шаблони з рамками й текст.', 'Clideo online editor with a meme maker: images, GIFs and videos, bordered templates and captions.', 'Clideo — онлайн-редактор відео й зображень, у якому є окремий конструктор мемів. Мем можна зробити з картинки, GIF чи відео: вибрати один із 9 шаблонів (з білою, чорною рамкою або без неї), додати текст одним із 12 шрифтів, обрізати кадр і вимкнути звук у відео. Готовий мем зберігається у звичних форматах зображень і відео, відео-мем — також як анімований GIF. Працює в браузері на комп''ютері й телефоні, є застосунок для iPhone. Є безкоштовний план з обмеженнями, решта — за підпискою.', 'Clideo is an online video and image editor with a dedicated meme maker. You can make a meme from a picture, GIF or video: pick one of 9 templates (white border, black border or none), add text in one of 12 fonts, crop the frame and mute video sound. The meme is saved in common image and video formats, and a video meme can also be saved as an animated GIF. Works in the browser on computer and phone, with an iPhone app. There is a free plan with limits; the rest is by subscription.', 'Меми з картинок, GIF і відео
9 шаблонів із рамками
12 шрифтів для підписів
Обрізання й вимкнення звуку
Експорт у GIF', 'Memes from images, GIFs and videos
9 bordered templates
12 caption fonts
Crop and mute
Export to GIF', 'Усім, хто робить меми з картинок, GIF чи відео для соцмереж і чатів.', 'Anyone making memes from pictures, GIFs or videos for social media and chats.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-19 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'clideo.com/meme-maker' OR LOWER(`name`) = 'clideo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'memes' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Clideo online editor with a meme maker: images, GIFs and videos, bordered templates and captions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Clideo is an online video and image editor with a dedicated meme maker. You can make a meme from a picture, GIF or video: pick one of 9 templates (white border, black border or none), add text in one of 12 fonts, crop the frame and mute video sound. The meme is saved in common image and video formats, and a video meme can also be saved as an animated GIF. Works in the browser on computer and phone, with an iPhone app. There is a free plan with limits; the rest is by subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Memes from images, GIFs and videos
9 bordered templates
12 caption fonts
Crop and mute
Export to GIF', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone making memes from pictures, GIFs or videos for social media and chats.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний план з обмеженнями функцій.', 'Free plan with some feature limits.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free plan with some feature limits.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Прив'язки наявних продуктів (за назвою, без id)
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'elevenlabs' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'voice-changers' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'finevoice' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'voice-changers' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'adobe express' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'memes' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'glif' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'memes' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'hailuo ai' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dancing-animals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'picsart' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'cartoon-avatars' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
