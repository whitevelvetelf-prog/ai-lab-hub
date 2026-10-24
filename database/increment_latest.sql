SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-24: нова категорія «Розважальні» / «Entertainment» (slug entertainment) з підкатегоріями:
--   * Смішні фільтри та ефекти / Funny Filters & Effects (slug funny-filters)
--   * Танцюючі тварини / Dancing Pets & Animals (slug dancing-animals)
--   * Зістарення та омолодження / Aging & De-aging (slug age-transform)
--   * Мультяшні аватари / Cartoon Avatars (slug cartoon-avatars)
--   * Оживлення фото / Photo Animation (slug photo-animation)
--   * Смішні голоси / Funny Voice Changers (slug voice-changers)
--   * Меми та жарти / Memes & Jokes (slug memes)
-- + 24 нових продуктів, 20 наявних лише прив'язано (тексти не змінюються): PicsArt, Meitu, Facetune, FaceApp, YouCam Makeup, Fotor, Facelab, freebeat, Viggle AI, Kling AI, PixVerse, Vidu, Higgsfield, Lensa, Pika, Hedra, Vidnoz AI, Voicemod, Kapwing, Predis.ai
-- Тексти UA/EN написано з офіційних сайтів і сторінок у магазинах застосунків, звірено 2026-10-24.
-- Ціни не вказано: план «Ціна: див. сайт» (0, one_time); Free — де офіційне джерело підтверджує безкоштовний рівень.
-- Пропущено: AgingBooth (без оновлень з 2023), JibJab та ElfYourself (сторінки не читаються), Gradient (оцінка етнічності, «на кого зі знаменитостей схожі»),
--   Wombo (домен перейшов до іншого проєкту), Dawn AI (домен перейшов), AILabTools (фільтри «товщини»/оцінки обличчя), Memomet (сторінка без опису),
--   дрібні iOS-застосунки «AI dance» без сайту.
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   Snapchat Lenses — Смішні фільтри та ефекти, Зістарення та омолодження
--   B612 — Смішні фільтри та ефекти
--   SNOW — Смішні фільтри та ефекти, Мультяшні аватари
--   Photo Lab — Смішні фільтри та ефекти, Мультяшні аватари
--   Effect House — Смішні фільтри та ефекти
--   Remaker AI — Смішні фільтри та ефекти
--   YouCam Perfect — Смішні фільтри та ефекти, Зістарення та омолодження
--   MyEdit — Смішні фільтри та ефекти, Зістарення та омолодження, Мультяшні аватари
--   Dreamina — Танцюючі тварини, Оживлення фото
--   DomoAI — Танцюючі тварини, Оживлення фото
--   Animated Drawings — Танцюючі тварини, Оживлення фото
--   Media.io Age Filter — Зістарення та омолодження
--   ToonMe — Мультяшні аватари
--   ToonApp — Мультяшні аватари, Оживлення фото
--   NewProfilePic — Мультяшні аватари
--   Restyle — Мультяшні аватари
--   Mug Life — Оживлення фото
--   Revive — Оживлення фото
--   Reface — Оживлення фото, Смішні фільтри та ефекти
--   Voice.ai — Смішні голоси
--   Altered — Смішні голоси
--   Uberduck — Смішні голоси
--   Supermeme.ai — Меми та жарти
--   Imgflip AI Meme — Меми та жарти
--   PicsArt (наявний) — Смішні фільтри та ефекти
--   Meitu (наявний) — Смішні фільтри та ефекти, Мультяшні аватари
--   Facetune (наявний) — Смішні фільтри та ефекти
--   FaceApp (наявний) — Зістарення та омолодження, Смішні фільтри та ефекти
--   YouCam Makeup (наявний) — Зістарення та омолодження
--   Fotor (наявний) — Зістарення та омолодження
--   Facelab (наявний) — Зістарення та омолодження
--   freebeat (наявний) — Танцюючі тварини
--   Viggle AI (наявний) — Танцюючі тварини
--   Kling AI (наявний) — Танцюючі тварини
--   PixVerse (наявний) — Танцюючі тварини
--   Vidu (наявний) — Танцюючі тварини
--   Higgsfield (наявний) — Танцюючі тварини
--   Lensa (наявний) — Мультяшні аватари
--   Pika (наявний) — Оживлення фото
--   Hedra (наявний) — Оживлення фото
--   Vidnoz AI (наявний) — Оживлення фото
--   Voicemod (наявний) — Смішні голоси
--   Kapwing (наявний) — Меми та жарти
--   Predis.ai (наявний) — Меми та жарти
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
INSERT INTO `categories` (`name`, `name_en`, `slug`) SELECT 'Розважальні', 'Entertainment', 'entertainment' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `categories` WHERE `slug` = 'entertainment');
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'entertainment' LIMIT 1);
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Смішні фільтри та ефекти', 'Funny Filters & Effects', 'funny-filters' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'funny-filters');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Танцюючі тварини', 'Dancing Pets & Animals', 'dancing-animals' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dancing-animals');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Зістарення та омолодження', 'Aging & De-aging', 'age-transform' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'age-transform');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Мультяшні аватари', 'Cartoon Avatars', 'cartoon-avatars' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'cartoon-avatars');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Оживлення фото', 'Photo Animation', 'photo-animation' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'photo-animation');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Смішні голоси', 'Funny Voice Changers', 'voice-changers' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'voice-changers');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Меми та жарти', 'Memes & Jokes', 'memes' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'memes');

-- Snapchat Lenses — Смішні фільтри та ефекти, Зістарення та омолодження
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'snapchat.com/lens' OR LOWER(`name`) = 'snapchat lenses')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Snapchat Lenses', NULL, 'https://www.snapchat.com/lens', NULL, NULL, 'Каталог AR-лінз Snapchat: смішні фільтри для обличчя й світу навколо, зокрема АІ-лінза «Старий і молодий я».', 'The Snapchat Lens catalog: funny face and world filters, including the Old and Young Me AI Lens.', 'Лінзи Snapchat — це фільтри доповненої реальності, які змінюють обличчя чи простір у кадрі камери: великий рот, собачі вуха, «дитяче» обличчя тощо. На сайті лінзи зібрано за розділами «Для вас», «Тренди», «Обличчя», «Світ», «Музика» й «Автори», кожну можна відкрити просто в застосунку. Є й АІ-лінзи, наприклад «Old and Young Me», що показує вас старшим і молодшим. Власні лінзи можна створювати в Lens Studio або простішому EasyLens.', 'Snapchat Lenses are augmented-reality filters that change your face or the scene in the camera: a giant mouth, dog ears, a baby face and more. The website groups Lenses into For You, Trending, Face, World, Music and Creators, and each one opens straight in the app. There are AI Lenses too, such as Old and Young Me, which shows you older and younger. You can build your own Lenses in Lens Studio or the simpler EasyLens.', 'AR-фільтри для обличчя й простору
АІ-лінза «Старий і молодий я»
Каталог лінз за темами й авторами
Створення власних лінз у Lens Studio та EasyLens', 'AR filters for faces and surroundings
Old and Young Me AI Lens
Lens catalog by topic and creator
Build your own Lenses in Lens Studio and EasyLens', 'Усім, хто любить смішні селфі й короткі відео для друзів.', 'Anyone who enjoys funny selfies and short videos for friends.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'snapchat.com/lens' OR LOWER(`name`) = 'snapchat lenses') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'funny-filters' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'age-transform' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Snapchat Lens catalog: funny face and world filters, including the Old and Young Me AI Lens.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Snapchat Lenses are augmented-reality filters that change your face or the scene in the camera: a giant mouth, dog ears, a baby face and more. The website groups Lenses into For You, Trending, Face, World, Music and Creators, and each one opens straight in the app. There are AI Lenses too, such as Old and Young Me, which shows you older and younger. You can build your own Lenses in Lens Studio or the simpler EasyLens.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AR filters for faces and surroundings
Old and Young Me AI Lens
Lens catalog by topic and creator
Build your own Lenses in Lens Studio and EasyLens', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone who enjoys funny selfies and short videos for friends.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- B612 — Смішні фільтри та ефекти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'b612.snow.me' OR LOWER(`name`) = 'b612')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'B612', NULL, 'https://b612.snow.me', NULL, NULL, 'Камера й редактор від SNOW з AR-ефектами, сезонними фільтрами й АІ-інструментами для фото та відео.', 'A camera and editor from SNOW with AR effects, seasonal filters and AI tools for photos and video.', 'B612 — мобільна камера й редактор від SNOW Corporation. Щодня з’являються нові AR-ефекти й сезонні фільтри, а свої фільтри можна зробити самому. АІ-функції підбирають налаштування під форму обличчя, прибирають зайві предмети й освітлюють темні знімки. Для відео є ефекти, понад 500 музичних треків, GIF Bounce і зйомка двома камерами одночасно. Базові функції безкоштовні, підписка B612 VIP відкриває решту.', 'B612 is a mobile camera and editor from SNOW Corporation. New AR effects and seasonal filters appear daily, and you can make your own filters. AI features tune settings to your face shape, remove distractions and brighten dark shots. For video there are effects, 500+ music tracks, GIF Bounce and dual front-and-rear capture. Basic features are free; the B612 VIP subscription unlocks the rest.', 'AR-ефекти, що оновлюються щодня
Власні фільтри
АІ-видалення зайвого й освітлення
Відео з музикою та GIF Bounce', 'Daily-updated AR effects
Custom filters
AI removal and brightening
Video with music and GIF Bounce', 'Тим, хто знімає селфі й короткі відео для соцмереж.', 'People who shoot selfies and short videos for social media.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'b612.snow.me' OR LOWER(`name`) = 'b612') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'funny-filters' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A camera and editor from SNOW with AR effects, seasonal filters and AI tools for photos and video.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'B612 is a mobile camera and editor from SNOW Corporation. New AR effects and seasonal filters appear daily, and you can make your own filters. AI features tune settings to your face shape, remove distractions and brighten dark shots. For video there are effects, 500+ music tracks, GIF Bounce and dual front-and-rear capture. Basic features are free; the B612 VIP subscription unlocks the rest.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Daily-updated AR effects
Custom filters
AI removal and brightening
Video with music and GIF Bounce', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who shoot selfies and short videos for social media.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SNOW — Смішні фільтри та ефекти, Мультяшні аватари
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'snow.me' OR LOWER(`name`) = 'snow')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SNOW', NULL, 'https://snow.me', NULL, NULL, 'Селфі-камера з AR-стікерами, бʼюті-ефектами й АІ-образами, зокрема в стилі коміксу.', 'A selfie camera with AR stickers, beauty effects and AI looks, including comic style.', 'SNOW — селфі-застосунок від SNOW Corporation (Південна Корея). Бібліотека стікерів і сезонних фільтрів оновлюється щодня, AR-макіяж накладається просто під час зйомки, а власні бʼюті-ефекти можна зберегти. Серед АІ-функцій — образи в стилі коміксу й «дитячі» версії обличчя, фото на документи та видалення зайвих предметів. Користуватися можна безкоштовно, підписка SNOW VIP відкриває додаткові можливості.', 'SNOW is a selfie app from SNOW Corporation (South Korea). Its stickers and seasonal filters are updated daily, AR makeup applies live while you shoot, and you can save your own beauty effects. AI features include comic-style and baby-face looks, ID photos and object removal. It is free to use, and the SNOW VIP subscription unlocks extra features.', 'Стікери й фільтри, що оновлюються щодня
AR-макіяж під час зйомки
АІ-образи: комікс, «дитяче» обличчя
АІ-видалення зайвих предметів', 'Daily-updated stickers and filters
Live AR makeup
AI looks: comics, baby face
AI object removal', 'Любителям селфі й ігрових фотоефектів.', 'Selfie lovers and fans of playful photo effects.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'snow.me' OR LOWER(`name`) = 'snow') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'funny-filters' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'cartoon-avatars' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A selfie camera with AR stickers, beauty effects and AI looks, including comic style.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SNOW is a selfie app from SNOW Corporation (South Korea). Its stickers and seasonal filters are updated daily, AR makeup applies live while you shoot, and you can save your own beauty effects. AI features include comic-style and baby-face looks, ID photos and object removal. It is free to use, and the SNOW VIP subscription unlocks extra features.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Daily-updated stickers and filters
Live AR makeup
AI looks: comics, baby face
AI object removal', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Selfie lovers and fans of playful photo effects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Photo Lab — Смішні фільтри та ефекти, Мультяшні аватари
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'photolab.me' OR LOWER(`name`) = 'photo lab')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Photo Lab', NULL, 'https://photolab.me', NULL, NULL, 'Застосунок із понад 800 фотоефектами, які можна поєднувати в комбінації й ділитися ними.', 'An app with 800+ photo effects you can combine into combos and share.', 'Photo Lab пропонує понад 800 ефектів для фото: художні стилі, рамки, фотомонтажі з обличчям і мультяшні образи. Ефекти можна поєднувати у власні «комбо» й ділитися ними зі спільнотою, а на сайті видно добірки популярних, трендових і нових комбінацій. Застосунок є в App Store, Google Play та Huawei AppGallery.', 'Photo Lab offers 800+ photo effects: art styles, frames, face montages and cartoon looks. You can chain effects into your own combos and share them with the community, and the website shows top, trending and recent combos. The app is on the App Store, Google Play and Huawei AppGallery.', 'Понад 800 фотоефектів
Власні комбінації ефектів
Добірки трендових комбо
iOS, Android і Huawei', '800+ photo effects
Your own effect combos
Trending combo collections
iOS, Android and Huawei', 'Тим, хто хоче швидко зробити смішне чи незвичне фото без редагування вручну.', 'People who want a funny or unusual photo fast, without manual editing.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'photolab.me' OR LOWER(`name`) = 'photo lab') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'funny-filters' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'cartoon-avatars' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app with 800+ photo effects you can combine into combos and share.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Photo Lab offers 800+ photo effects: art styles, frames, face montages and cartoon looks. You can chain effects into your own combos and share them with the community, and the website shows top, trending and recent combos. The app is on the App Store, Google Play and Huawei AppGallery.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '800+ photo effects
Your own effect combos
Trending combo collections
iOS, Android and Huawei', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want a funny or unusual photo fast, without manual editing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Effect House — Смішні фільтри та ефекти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'effecthouse.tiktok.com' OR LOWER(`name`) = 'effect house')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Effect House', NULL, 'https://effecthouse.tiktok.com', NULL, NULL, 'Безкоштовна програма TikTok для створення власних ефектів, фільтрів та міні-ігор, зокрема з АІ.', 'TikTok’s free desktop app for building your own effects, filters and mini-games, including with AI.', 'Effect House — безкоштовний застосунок для Mac і ПК, у якому створюють ефекти для TikTok: фільтри, віртуальних персонажів, ігри, звуки й інтерактивні AR-сцени. АІ-редактор генерує стилі й ресурси для ефекту, а режим Create With AI збирає інтерактивний ефект за кілька кліків. Візуальні скрипти дозволяють обійтися без програмування. Готовий ефект публікують у TikTok, зокрема для прямих ефірів.', 'Effect House is a free Mac and PC app for building TikTok effects: filters, virtual characters, games, sounds and interactive AR scenes. Its AI Editor generates styles and assets, and Create With AI assembles an interactive effect in a few clicks. Visual scripting means no coding is needed. Finished effects are published to TikTok, including for LIVE.', 'Фільтри, ігри й AR-ефекти для TikTok
АІ-редактор стилів і ресурсів
Create With AI — ефект за кілька кліків
Візуальні скрипти без коду', 'Filters, games and AR effects for TikTok
AI Editor for styles and assets
Create With AI: an effect in a few clicks
No-code visual scripting', 'Авторам контенту, які хочуть зробити власний смішний ефект для TikTok.', 'Creators who want to make their own funny TikTok effect.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'effecthouse.tiktok.com' OR LOWER(`name`) = 'effect house') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'funny-filters' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'TikTok’s free desktop app for building your own effects, filters and mini-games, including with AI.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Effect House is a free Mac and PC app for building TikTok effects: filters, virtual characters, games, sounds and interactive AR scenes. Its AI Editor generates styles and assets, and Create With AI assembles an interactive effect in a few clicks. Visual scripting means no coding is needed. Finished effects are published to TikTok, including for LIVE.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Filters, games and AR effects for TikTok
AI Editor for styles and assets
Create With AI: an effect in a few clicks
No-code visual scripting', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Creators who want to make their own funny TikTok effect.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Remaker AI — Смішні фільтри та ефекти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'remaker.ai' OR LOWER(`name`) = 'remaker ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Remaker AI', NULL, 'https://remaker.ai', NULL, NULL, 'Онлайн-сервіс з десятками АІ-фотоефектів, заміною обличчя, генерацією й редагуванням зображень.', 'An online service with dozens of AI photo effects, face swap, image generation and editing.', 'Remaker AI — вебсервіс для переробки зображень за допомогою АІ. Тут є каталог фотоефектів і відеошаблонів, заміна обличчя на фото й відео, генератор портретів і зображень, редагування за текстовою підказкою, а також практичні інструменти: збільшення роздільності, видалення фону та зайвих об’єктів. Частина інструментів доступна безкоштовно.', 'Remaker AI is a web service for remaking images with AI. It has a catalog of photo effects and video templates, face swap for photos and video, portrait and image generators, prompt-based editing and practical tools: upscaling, background and object removal. Some tools are free.', 'Каталог АІ-фотоефектів і відеошаблонів
Заміна обличчя на фото й відео
Редагування за текстовою підказкою
Апскейл і видалення фону', 'Catalog of AI photo effects and video templates
Face swap for photos and video
Prompt-based editing
Upscaling and background removal', 'Тим, хто хоче розважитися з фото онлайн без встановлення застосунків. Обличчя інших людей — лише з їхньої згоди.', 'People who want to play with photos online without installing apps. Use other people’s faces only with their consent.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'remaker.ai' OR LOWER(`name`) = 'remaker ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'funny-filters' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An online service with dozens of AI photo effects, face swap, image generation and editing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Remaker AI is a web service for remaking images with AI. It has a catalog of photo effects and video templates, face swap for photos and video, portrait and image generators, prompt-based editing and practical tools: upscaling, background and object removal. Some tools are free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Catalog of AI photo effects and video templates
Face swap for photos and video
Prompt-based editing
Upscaling and background removal', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to play with photos online without installing apps. Use other people’s faces only with their consent.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- YouCam Perfect — Смішні фільтри та ефекти, Зістарення та омолодження
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'perfectcorp.com/consumer/apps/ycp' OR LOWER(`name`) = 'youcam perfect')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'YouCam Perfect', NULL, 'https://www.perfectcorp.com/consumer/apps/ycp', NULL, NULL, 'Фоторедактор від Perfect Corp з АІ-ефектами, колажами й інструментами для селфі.', 'A photo editor from Perfect Corp with AI effects, collages and selfie tools.', 'YouCam Perfect — мобільний фоторедактор від Perfect Corp. Безкоштовно доступні фотоефекти, кадрування, базове покращення фото й шаблони колажів, а преміум-підписка відкриває розширені АІ-функції без обмежень. Застосунок працює на iPhone, iPad і Android, підтримує 21 мову й має понад 800 мільйонів завантажень.', 'YouCam Perfect is a mobile photo editor from Perfect Corp. Photo effects, cropping, basic enhancement and collage templates are free, while a Premium subscription unlocks advanced AI features without limits. It runs on iPhone, iPad and Android, supports 21 languages and has 800M+ downloads.', 'Безкоштовні фотоефекти й колажі
Розширені АІ-функції в преміумі
21 мова інтерфейсу
iPhone, iPad і Android', 'Free photo effects and collages
Advanced AI features in Premium
21 interface languages
iPhone, iPad and Android', 'Тим, хто редагує селфі й хоче погратися з ефектами на телефоні.', 'People who edit selfies and want to play with effects on their phone.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'perfectcorp.com/consumer/apps/ycp' OR LOWER(`name`) = 'youcam perfect') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'funny-filters' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'age-transform' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A photo editor from Perfect Corp with AI effects, collages and selfie tools.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'YouCam Perfect is a mobile photo editor from Perfect Corp. Photo effects, cropping, basic enhancement and collage templates are free, while a Premium subscription unlocks advanced AI features without limits. It runs on iPhone, iPad and Android, supports 21 languages and has 800M+ downloads.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free photo effects and collages
Advanced AI features in Premium
21 interface languages
iPhone, iPad and Android', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who edit selfies and want to play with effects on their phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MyEdit — Смішні фільтри та ефекти, Зістарення та омолодження, Мультяшні аватари
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myedit.online' OR LOWER(`name`) = 'myedit')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MyEdit', NULL, 'https://myedit.online', NULL, NULL, 'Онлайн-редактор CyberLink з АІ-ефектами: мультяшний стиль, заміна обличчя, зачіски, «оживлення» фото.', 'CyberLink’s online editor with AI effects: cartoon style, face swap, hairstyles and image-to-video.', 'MyEdit — браузерний редактор від CyberLink. Серед розважальних функцій — АІ-арт і мультяшний ефект, заміна обличчя, примірка зачісок, «примірка» вбрання для домашніх улюбленців, фотосесії за шаблонами та перетворення фото на відео. За текстовою підказкою можна зістарити чи омолодити людину на фото. Є й звичайні інструменти: покращення якості, видалення фону та об’єктів. Частину функцій можна спробувати безкоштовно.', 'MyEdit is a browser-based editor from CyberLink. Its fun features include AI art and a cartoonize effect, face swap, hairstyle try-on, pet outfit try-on, template photoshoots and image-to-video. With a text prompt you can make the person in a photo look older or younger. Standard tools are there too: enhancement, background and object removal. Some features can be tried for free.', 'Мультяшний ефект і АІ-арт
Заміна обличчя й примірка зачісок
Зістарення чи омолодження за підказкою
Фото у відео', 'Cartoonize effect and AI art
Face swap and hairstyle try-on
Aging or de-aging by prompt
Image to video', 'Тим, хто хоче розважальні АІ-ефекти просто в браузері.', 'People who want fun AI effects right in the browser.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myedit.online' OR LOWER(`name`) = 'myedit') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'funny-filters' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'age-transform' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'cartoon-avatars' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'CyberLink’s online editor with AI effects: cartoon style, face swap, hairstyles and image-to-video.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MyEdit is a browser-based editor from CyberLink. Its fun features include AI art and a cartoonize effect, face swap, hairstyle try-on, pet outfit try-on, template photoshoots and image-to-video. With a text prompt you can make the person in a photo look older or younger. Standard tools are there too: enhancement, background and object removal. Some features can be tried for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cartoonize effect and AI art
Face swap and hairstyle try-on
Aging or de-aging by prompt
Image to video', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want fun AI effects right in the browser.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Dreamina — Танцюючі тварини, Оживлення фото
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dreamina.capcut.com' OR LOWER(`name`) = 'dreamina')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dreamina', NULL, 'https://dreamina.capcut.com', NULL, NULL, 'Генератор зображень і відео від CapCut, зокрема АІ-відео з танцями та мультяшні ролики.', 'CapCut’s image and video generator, including AI dance videos and cartoon clips.', 'Dreamina — вебсервіс від команди CapCut для створення зображень і відео за допомогою кількох моделей, зокрема Seedance і Seedream. Серед інструментів — фото у відео, ескіз у відео, генератор мультяшних відео, АІ-відео з танцями, аватари й «живі» фото. Можна завантажити фото собаки чи кота й отримати ролик, у якому улюбленець танцює. Є безкоштовний доступ для старту.', 'Dreamina is a web service from the CapCut team for making images and videos with several models, including Seedance and Seedream. Tools include image-to-video, sketch-to-video, a cartoon video generator, AI dance videos, avatars and live photos. You can upload a photo of your dog or cat and get a clip of your pet dancing. Free access is available to get started.', 'АІ-відео з танцями
Фото й ескіз у відео
Генератор мультяшних відео
Аватари й «живі» фото', 'AI dance videos
Image and sketch to video
Cartoon video generator
Avatars and live photos', 'Власникам тварин і всім, хто робить смішні ролики для соцмереж.', 'Pet owners and anyone making funny clips for social media.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dreamina.capcut.com' OR LOWER(`name`) = 'dreamina') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dancing-animals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'photo-animation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'CapCut’s image and video generator, including AI dance videos and cartoon clips.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Dreamina is a web service from the CapCut team for making images and videos with several models, including Seedance and Seedream. Tools include image-to-video, sketch-to-video, a cartoon video generator, AI dance videos, avatars and live photos. You can upload a photo of your dog or cat and get a clip of your pet dancing. Free access is available to get started.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI dance videos
Image and sketch to video
Cartoon video generator
Avatars and live photos', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Pet owners and anyone making funny clips for social media.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- DomoAI — Танцюючі тварини, Оживлення фото
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'domoai.app' OR LOWER(`name`) = 'domoai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DomoAI', NULL, 'https://www.domoai.app', NULL, NULL, 'АІ-студія відео й анімації з шаблонами, «розмовами» тварин і стилізацією роликів.', 'An AI video and animation studio with templates, talking pets and video restyling.', 'DomoAI перетворює текст, фото чи відео на анімовані ролики. Є готові шаблони (обійми, оберт на 360°, зациклена анімація), сценарій «АІ-тварина говорить», синхронізація губ, стилізація відео в аніме чи інші стилі, заміна обличчя та збільшення роздільності. Безкоштовний план дає кредити для старту, платні підписки додають більше кредитів і функцій.', 'DomoAI turns text, photos or footage into animated clips. It has ready templates (hug, 360 view, loop animation), an AI Pet Talk scenario, lip sync, video restyling into anime and other styles, face swap and upscaling. A free plan gives starter credits; paid plans add more credits and features.', 'Шаблони анімації з фото
АІ-тварина, що говорить
Стилізація відео
Синхронізація губ', 'Photo animation templates
AI Pet Talk
Video restyling
Lip sync', 'Тим, хто хоче оживити фото тварин чи друзів для жартівливого відео.', 'People who want to animate pet or friend photos for a funny video.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'domoai.app' OR LOWER(`name`) = 'domoai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dancing-animals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'photo-animation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI video and animation studio with templates, talking pets and video restyling.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'DomoAI turns text, photos or footage into animated clips. It has ready templates (hug, 360 view, loop animation), an AI Pet Talk scenario, lip sync, video restyling into anime and other styles, face swap and upscaling. A free plan gives starter credits; paid plans add more credits and features.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Photo animation templates
AI Pet Talk
Video restyling
Lip sync', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to animate pet or friend photos for a funny video.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Animated Drawings — Танцюючі тварини, Оживлення фото
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sketch.metademolab.com' OR LOWER(`name`) = 'animated drawings')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Animated Drawings', NULL, 'https://sketch.metademolab.com', NULL, NULL, 'Дослідницька демонстрація Meta: перетворює дитячий малюнок людини чи звірятка на танцюючу анімацію.', 'A Meta research demo that turns a drawing of a person or creature into a dancing animation.', 'Animated Drawings — безкоштовна вебдемонстрація від лабораторії Meta FAIR. Завантажуєте фото малюнка персонажа з руками й ногами, позначаєте суглоби, і АІ змушує його рухатися: танцювати, стрибати, ходити. Особливо подобається дітям, які бачать, як оживають їхні малюнки. Проєкт дослідницький, тож працює як демо, без гарантій підтримки.', 'Animated Drawings is a free web demo from Meta FAIR. You upload a photo of a drawn character with arms and legs, mark the joints, and AI makes it move: dance, jump or walk. Kids especially love seeing their drawings come alive. It is a research project, so it runs as a demo with no support guarantees.', 'Анімація дитячих малюнків
Танці, стрибки, ходьба
Працює в браузері
Безкоштовно', 'Animates kids’ drawings
Dancing, jumping, walking
Runs in the browser
Free', 'Дітям і батькам, вчителям, усім, хто малює.', 'Kids and parents, teachers, anyone who draws.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sketch.metademolab.com' OR LOWER(`name`) = 'animated drawings') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dancing-animals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'photo-animation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Meta research demo that turns a drawing of a person or creature into a dancing animation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Animated Drawings is a free web demo from Meta FAIR. You upload a photo of a drawn character with arms and legs, mark the joints, and AI makes it move: dance, jump or walk. Kids especially love seeing their drawings come alive. It is a research project, so it runs as a demo with no support guarantees.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Animates kids’ drawings
Dancing, jumping, walking
Runs in the browser
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Kids and parents, teachers, anyone who draws.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Media.io Age Filter — Зістарення та омолодження
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'media.io/age-filter.html' OR LOWER(`name`) = 'media.io age filter')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Media.io Age Filter', NULL, 'https://www.media.io/age-filter.html', NULL, NULL, 'Онлайн-фільтр Media.io, що показує, як ви виглядатимете старшим чи молодшим.', 'Media.io’s online filter that shows how you would look older or younger.', 'Age Filter — один з інструментів платформи Media.io. Завантажуєте фото обличчя, і АІ створює версію, на якій людина виглядає старшою або молодшою. На тій самій платформі є інші розважальні ефекти: танцювальні рухи, перетворення тварин, аніме-стиль, а також генерація відео й зображень. Спробувати фільтр можна безкоштовно в браузері.', 'Age Filter is one of the tools on the Media.io platform. Upload a face photo and AI creates a version where the person looks older or younger. The same platform has other fun effects such as dance motion, pet transformation and anime style, plus video and image generation. You can try the filter for free in the browser.', 'Зістарення та омолодження обличчя
Працює в браузері
Інші АІ-ефекти платформи
Безкоштовна спроба', 'Aging and de-aging a face
Runs in the browser
Other AI effects on the platform
Free to try', 'Тим, хто з цікавості хоче побачити себе в іншому віці. Результат — розвага, а не прогноз.', 'Anyone curious to see themselves at another age. The result is for fun, not a prediction.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'media.io/age-filter.html' OR LOWER(`name`) = 'media.io age filter') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'age-transform' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Media.io’s online filter that shows how you would look older or younger.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Age Filter is one of the tools on the Media.io platform. Upload a face photo and AI creates a version where the person looks older or younger. The same platform has other fun effects such as dance motion, pet transformation and anime style, plus video and image generation. You can try the filter for free in the browser.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Aging and de-aging a face
Runs in the browser
Other AI effects on the platform
Free to try', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone curious to see themselves at another age. The result is for fun, not a prediction.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ToonMe — Мультяшні аватари
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'toonme.com' OR LOWER(`name`) = 'toonme')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ToonMe', NULL, 'https://toonme.com', NULL, NULL, 'Застосунок, що за допомогою АІ перетворює ваше фото на мультяшний портрет.', 'An app that uses AI to turn your photo into a cartoon portrait.', 'ToonMe робить із селфі мультяшний портрет: АІ перемальовує обличчя в стилі анімації чи коміксу. Застосунок регулярно додає нові стилі. Результат зручно поставити на аватар або надіслати друзям. ToonMe доступний в App Store, Google Play та Huawei AppGallery.', 'ToonMe turns a selfie into a cartoon portrait: AI redraws your face in an animation or comic style. New styles are added regularly. The result works well as an avatar or something to send friends. ToonMe is on the App Store, Google Play and Huawei AppGallery.', 'Мультяшний портрет із селфі
Регулярно нові стилі
Готово для аватарки
iOS, Android і Huawei', 'Cartoon portrait from a selfie
New styles added regularly
Ready for an avatar
iOS, Android and Huawei', 'Тим, хто хоче мультяшну аватарку для соцмереж.', 'People who want a cartoon avatar for social media.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'toonme.com' OR LOWER(`name`) = 'toonme') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'cartoon-avatars' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app that uses AI to turn your photo into a cartoon portrait.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ToonMe turns a selfie into a cartoon portrait: AI redraws your face in an animation or comic style. New styles are added regularly. The result works well as an avatar or something to send friends. ToonMe is on the App Store, Google Play and Huawei AppGallery.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cartoon portrait from a selfie
New styles added regularly
Ready for an avatar
iOS, Android and Huawei', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want a cartoon avatar for social media.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ToonApp — Мультяшні аватари, Оживлення фото
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lyrebirdstudio.net/apps/toonapp' OR LOWER(`name`) = 'toonapp')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ToonApp', NULL, 'https://lyrebirdstudio.net/apps/toonapp', NULL, NULL, 'Застосунок Lyrebird Studio: робить із селфі мультяшний чи аніме-портрет і коротке відео.', 'A Lyrebird Studio app that turns a selfie into a cartoon or anime portrait and a short video.', 'ToonApp перемальовує фото обличчя як мультяшний малюнок, карикатуру, аніме-портрет чи 3D-фігурку. Окремо можна «оживити» знімок у кількасекундне відео за шаблоном, перемалювати пару на спільному фото або зробити ретро-знімок у стилі миттєвої камери. Завантаження безкоштовне, частина стилів і відеоефектів коштує кредитів, а підписка PRO прибирає рекламу й відкриває всі фільтри.', 'ToonApp redraws a face photo as a cartoon, caricature, anime portrait or 3D figure. You can also animate a still into a few-second video from a template, redraw a couple in one shot, or make an instant-camera-style retro print. The download is free; some styles and video effects cost credits, and PRO removes ads and unlocks all filters.', 'Мультяшні, аніме- й 3D-портрети
Фото у коротке відео
Спільні фото пар
PRO без реклами', 'Cartoon, anime and 3D portraits
Photo to short video
Couple photos
Ad-free PRO', 'Тим, хто хоче мультяшний образ себе чи пари на телефоні.', 'People who want a cartoon version of themselves or a couple on their phone.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lyrebirdstudio.net/apps/toonapp' OR LOWER(`name`) = 'toonapp') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'cartoon-avatars' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'photo-animation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Lyrebird Studio app that turns a selfie into a cartoon or anime portrait and a short video.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ToonApp redraws a face photo as a cartoon, caricature, anime portrait or 3D figure. You can also animate a still into a few-second video from a template, redraw a couple in one shot, or make an instant-camera-style retro print. The download is free; some styles and video effects cost credits, and PRO removes ads and unlocks all filters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cartoon, anime and 3D portraits
Photo to short video
Couple photos
Ad-free PRO', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want a cartoon version of themselves or a couple on their phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- NewProfilePic — Мультяшні аватари
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'newprofilepic.com' OR LOWER(`name`) = 'newprofilepic')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NewProfilePic', NULL, 'https://newprofilepic.com', NULL, NULL, 'Генератор аватарок, що щотижня додає нові АІ-ефекти для фото профілю.', 'A profile-picture maker that adds new AI effects every week.', 'NewProfilePic створює нову аватарку з вашого фото за допомогою АІ-ефектів. Ідея проста: обираєте варіант, який пасує вашому настрою, а за тиждень повертаєтеся по нові ефекти й новий образ.', 'NewProfilePic makes a fresh profile picture from your photo with AI effects. The idea is simple: pick the version that matches your mood, then come back a week later for new effects and a new look.', 'АІ-аватарки з вашого фото
Нові ефекти щотижня
Зручно для соцмереж', 'AI profile pictures from your photo
New effects weekly
Made for social media', 'Тим, хто любить часто змінювати аватарку.', 'People who like to change their profile picture often.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'newprofilepic.com' OR LOWER(`name`) = 'newprofilepic') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'cartoon-avatars' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A profile-picture maker that adds new AI effects every week.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NewProfilePic makes a fresh profile picture from your photo with AI effects. The idea is simple: pick the version that matches your mood, then come back a week later for new effects and a new look.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI profile pictures from your photo
New effects weekly
Made for social media', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who like to change their profile picture often.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Restyle — Мультяшні аватари
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'reface.ai/restyle' OR LOWER(`name`) = 'restyle')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Restyle', NULL, 'https://reface.ai/restyle/', NULL, NULL, 'Застосунок від української команди Reface, що перетворює фото й відео на мультяшні та інші АІ-стилі.', 'An app from Ukraine’s Reface team that turns photos and videos into cartoon and other AI styles.', 'Restyle — застосунок від Reface, української компанії, відомої заміною облич. Він перетворює фото чи відео на мультфільм або інший АІ-стиль і пропонує ефекти з рухом і танцями. Доступний в App Store та Google Play.', 'Restyle is an app from Reface, the Ukrainian company known for face swap. It turns a photo or video into a cartoon or another AI style and offers motion and dance effects. It is available on the App Store and Google Play.', 'Фото й відео в мультяшному стилі
АІ-фільтри для відео
Ефекти з рухом і танцями
iOS і Android', 'Photos and videos in cartoon style
AI video filters
Motion and dance effects
iOS and Android', 'Тим, хто хоче мультяшну версію свого фото чи відео.', 'People who want a cartoon version of their photo or video.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'reface.ai/restyle' OR LOWER(`name`) = 'restyle') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'cartoon-avatars' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app from Ukraine’s Reface team that turns photos and videos into cartoon and other AI styles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Restyle is an app from Reface, the Ukrainian company known for face swap. It turns a photo or video into a cartoon or another AI style and offers motion and dance effects. It is available on the App Store and Google Play.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Photos and videos in cartoon style
AI video filters
Motion and dance effects
iOS and Android', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want a cartoon version of their photo or video.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mug Life — Оживлення фото
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'muglife.com' OR LOWER(`name`) = 'mug life')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mug Life', NULL, 'https://www.muglife.com', NULL, NULL, 'Застосунок, що робить із будь-якого фото обличчя 3D-персонажа з мімікою для мемів і GIF.', 'An app that turns any face photo into an expressive 3D character for memes and GIFs.', 'Mug Life аналізує фото, розкладає його на 3D-складові (камера, світло, геометрія, текстура) і перетворює обличчя на анімованого 3D-персонажа, зберігаючи фотореалістичність. Можна змусити його кліпати, усміхатися, кривлятися, обрати вирази з бібліотеки «Емоджімація» чи керувати позою вручну. Результат зберігають як відео, GIF чи аватар.', 'Mug Life analyses a photo, breaks it into 3D parts (camera, lighting, geometry, texture) and turns the face into an animated 3D character while keeping it photorealistic. Make it blink, smile or pull faces, pick expressions from Emojimation or control the pose by hand. Save the result as a video, GIF or avatar.', '3D-анімація обличчя з одного фото
Бібліотека виразів
Ручне керування позою
Експорт у відео, GIF, аватар', '3D face animation from one photo
Expression library
Manual pose control
Export as video, GIF or avatar', 'Тим, хто робить живі меми й смішні привітання. Фото друзів — з їхньої згоди.', 'People making living memes and funny greetings. Use friends’ photos with their consent.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'muglife.com' OR LOWER(`name`) = 'mug life') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'photo-animation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app that turns any face photo into an expressive 3D character for memes and GIFs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mug Life analyses a photo, breaks it into 3D parts (camera, lighting, geometry, texture) and turns the face into an animated 3D character while keeping it photorealistic. Make it blink, smile or pull faces, pick expressions from Emojimation or control the pose by hand. Save the result as a video, GIF or avatar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '3D face animation from one photo
Expression library
Manual pose control
Export as video, GIF or avatar', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People making living memes and funny greetings. Use friends’ photos with their consent.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Revive — Оживлення фото
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'reface.ai/revive' OR LOWER(`name`) = 'revive')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Revive', NULL, 'https://reface.ai/revive/', NULL, NULL, 'Застосунок від Reface, що «оживляє» фото: люди на знімку співають, говорять чи танцюють.', 'A Reface app that brings photos to life: people in the picture sing, talk or dance.', 'Revive від української компанії Reface анімує будь-яке нерухоме фото. Можна змусити людину на знімку заспівати, «заговорити», затанцювати чи повторити трендовий ефект із TikTok, а також зробити жартівливий розіграш для друзів. Доступний у Google Play та App Store.', 'Revive from the Ukrainian company Reface animates any still photo. Make the person in the picture sing, talk, dance or follow a TikTok trend, or set up a playful prank for friends. It is on Google Play and the App Store.', 'Фото, що співає й говорить
Танцювальні ефекти
Трендові ефекти TikTok
iOS і Android', 'Photos that sing and talk
Dance effects
TikTok trend effects
iOS and Android', 'Тим, хто хоче смішне відео з фото друзів чи родини (за їхньою згодою).', 'People who want a funny video from photos of friends or family (with their consent).', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'reface.ai/revive' OR LOWER(`name`) = 'revive') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'photo-animation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Reface app that brings photos to life: people in the picture sing, talk or dance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Revive from the Ukrainian company Reface animates any still photo. Make the person in the picture sing, talk, dance or follow a TikTok trend, or set up a playful prank for friends. It is on Google Play and the App Store.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Photos that sing and talk
Dance effects
TikTok trend effects
iOS and Android', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want a funny video from photos of friends or family (with their consent).', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Reface — Оживлення фото, Смішні фільтри та ефекти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'reface.app' OR LOWER(`name`) = 'reface')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Reface', NULL, 'https://reface.app', NULL, NULL, 'Український застосунок для заміни обличчя у фото й відео, АІ-аватарів і «оживлення» знімків.', 'A Ukrainian app for face swap in photos and videos, AI avatars and animated photos.', 'Reface — застосунок української компанії Reface, завантажений понад 300 мільйонів разів. Він вставляє ваше обличчя у фото та відео, створює АІ-аватари й портрети, приміряє зачіски, перетворює одне фото на анімоване відео й покращує якість знімків. Доступний в App Store та Google Play, розширені функції — за підпискою.', 'Reface is an app from the Ukrainian company Reface, downloaded more than 300 million times. It puts your face into photos and videos, creates AI avatars and portraits, tries on hairstyles, turns a single photo into an animated video and enhances photo quality. It is on the App Store and Google Play, with advanced features by subscription.', 'Заміна обличчя у фото й відео
АІ-аватари
Фото в анімоване відео
Примірка зачісок', 'Face swap in photos and videos
AI avatars
Photo to animated video
Hairstyle try-on', 'Тим, хто хоче побачити себе в смішному відео. Обличчя інших людей — лише з їхньої згоди.', 'People who want to see themselves in a funny video. Use other people’s faces only with their consent.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'reface.app' OR LOWER(`name`) = 'reface') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'photo-animation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'funny-filters' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Ukrainian app for face swap in photos and videos, AI avatars and animated photos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Reface is an app from the Ukrainian company Reface, downloaded more than 300 million times. It puts your face into photos and videos, creates AI avatars and portraits, tries on hairstyles, turns a single photo into an animated video and enhances photo quality. It is on the App Store and Google Play, with advanced features by subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Face swap in photos and videos
AI avatars
Photo to animated video
Hairstyle try-on', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to see themselves in a funny video. Use other people’s faces only with their consent.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Voice.ai — Смішні голоси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'voice.ai' OR LOWER(`name`) = 'voice.ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Voice.ai', NULL, 'https://voice.ai', NULL, NULL, 'Безкоштовний АІ-змінювач голосу з тисячами голосів, а також озвучення тексту й голосові агенти.', 'A free AI voice changer with thousands of voices, plus text to speech and voice agents.', 'Voice.ai відомий безкоштовним змінювачем голосу: можна говорити голосом іншого персонажа в іграх, стрімах і дзвінках, обравши з тисяч голосів спільноти. Платформа також озвучує текст і пропонує АІ-агентів для телефонних дзвінків бізнесу. Почати можна безкоштовно.', 'Voice.ai is known for its free voice changer: talk as a different character in games, streams and calls, choosing from thousands of community voices. The platform also does text to speech and offers AI phone agents for businesses. You can start for free.', 'Змінювач голосу в реальному часі
Тисячі голосів спільноти
Озвучення тексту
Безкоштовний старт', 'Real-time voice changer
Thousands of community voices
Text to speech
Free to start', 'Геймерам, стрімерам і всім, хто хоче пожартувати голосом.', 'Gamers, streamers and anyone who wants to play with their voice.', 'desktop,web', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'voice.ai' OR LOWER(`name`) = 'voice.ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'voice-changers' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free AI voice changer with thousands of voices, plus text to speech and voice agents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Voice.ai is known for its free voice changer: talk as a different character in games, streams and calls, choosing from thousands of community voices. The platform also does text to speech and offers AI phone agents for businesses. You can start for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time voice changer
Thousands of community voices
Text to speech
Free to start', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers, streamers and anyone who wants to play with their voice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Altered — Смішні голоси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'altered.ai' OR LOWER(`name`) = 'altered')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Altered', NULL, 'https://www.altered.ai', NULL, NULL, 'Професійний АІ-змінювач голосу: «голосові скіни» для ігор у реальному часі й студія для озвучення.', 'A professional AI voice changer: real-time voice skins for gaming and a studio for voice content.', 'Altered пропонує два продукти. Real-Time Pro змінює голос із низькою затримкою під час відеодзвінків, ігор і стрімів: «голосові скіни», зміна тембру, акценту, віку й статі зі збереженням темпу та інтонацій. Altered Studio — платформа для створення голосового контенту з перетворенням мовлення в мовлення й іншими АІ-інструментами. Студію можна спробувати безкоштовно.', 'Altered has two products. Real-Time Pro changes your voice with low latency in video calls, games and streams: voice skins and changes to timbre, accent, age and gender while keeping your pacing and inflection. Altered Studio is a voice content platform with speech-to-speech morphing and other AI tools. The Studio can be tried for free.', '«Голосові скіни» в реальному часі
Зміна віку, статі й акценту голосу
Студія для озвучення
Пробна безкоштовна версія студії', 'Real-time voice skins
Change voice age, gender and accent
Voice content studio
Free Studio trial', 'Геймерам, стрімерам і авторам відео.', 'Gamers, streamers and video creators.', 'desktop,web', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'altered.ai' OR LOWER(`name`) = 'altered') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'voice-changers' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A professional AI voice changer: real-time voice skins for gaming and a studio for voice content.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Altered has two products. Real-Time Pro changes your voice with low latency in video calls, games and streams: voice skins and changes to timbre, accent, age and gender while keeping your pacing and inflection. Altered Studio is a voice content platform with speech-to-speech morphing and other AI tools. The Studio can be tried for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time voice skins
Change voice age, gender and accent
Voice content studio
Free Studio trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers, streamers and video creators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Uberduck — Смішні голоси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'uberduck.ai' OR LOWER(`name`) = 'uberduck')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Uberduck', NULL, 'https://www.uberduck.ai', NULL, NULL, 'АІ-вокал і озвучення: текст, який говорять, співають чи читають реп синтетичні голоси.', 'AI vocals and text to speech: synthetic voices that speak, sing or rap your text.', 'Uberduck перетворює текст на мовлення, спів або реп, а також змінює ваш голос на інший зі збереженням манери. Можна створити власний голос і змусити його говорити, співати чи читати реп, або згенерувати пісню з текстом за кілька секунд. Підтримуються десятки мов, зокрема українська. Почати можна безкоштовно, для розробників є API.', 'Uberduck turns text into speech, singing or rap, and converts your voice into another while keeping your style. You can clone a custom voice and make it talk, sing or rap, or generate a song with lyrics in seconds. Dozens of languages are supported, including Ukrainian. You can start for free, and there is an API for developers.', 'Текст у мовлення, спів і реп
Перетворення голосу
Генерація пісень із текстом
Українська серед мов', 'Text to speech, singing and rap
Voice conversion
Song generation with lyrics
Ukrainian among the languages', 'Тим, хто робить смішні пісні, привітання й озвучення.', 'People making funny songs, greetings and voiceovers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'uberduck.ai' OR LOWER(`name`) = 'uberduck') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'voice-changers' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI vocals and text to speech: synthetic voices that speak, sing or rap your text.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Uberduck turns text into speech, singing or rap, and converts your voice into another while keeping your style. You can clone a custom voice and make it talk, sing or rap, or generate a song with lyrics in seconds. Dozens of languages are supported, including Ukrainian. You can start for free, and there is an API for developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Text to speech, singing and rap
Voice conversion
Song generation with lyrics
Ukrainian among the languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People making funny songs, greetings and voiceovers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Supermeme.ai — Меми та жарти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'supermeme.ai' OR LOWER(`name`) = 'supermeme.ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Supermeme.ai', NULL, 'https://supermeme.ai', NULL, NULL, 'АІ-генератор мемів: описуєте ситуацію, а сервіс підбирає шаблони й пише підписи.', 'An AI meme generator: describe a situation and it picks templates and writes captions.', 'Supermeme.ai робить меми з будь-якої ідеї. Описуєте ситуацію, кампанію чи внутрішній жарт, і сервіс пропонує до 8 варіантів мемів із відповідними шаблонами та підписами, які можна редагувати. Є зображення й GIF. Безкоштовно — 10 кредитів щомісяця без картки, безкоштовні завантаження мають невеликий водяний знак.', 'Supermeme.ai makes memes from any idea. Describe a situation, campaign or inside joke, and it suggests up to 8 meme options with fitting templates and editable captions. Images and GIFs are supported. Free accounts get 10 credits a month with no card required; free downloads carry a small watermark.', 'Мем з опису ситуації
До 8 варіантів за раз
Редаговані підписи
Зображення й GIF', 'Memes from a description
Up to 8 options per run
Editable captions
Images and GIFs', 'Авторам соцмереж, маркетологам і всім, хто любить меми.', 'Social media creators, marketers and meme lovers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'supermeme.ai' OR LOWER(`name`) = 'supermeme.ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'memes' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI meme generator: describe a situation and it picks templates and writes captions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Supermeme.ai makes memes from any idea. Describe a situation, campaign or inside joke, and it suggests up to 8 meme options with fitting templates and editable captions. Images and GIFs are supported. Free accounts get 10 credits a month with no card required; free downloads carry a small watermark.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Memes from a description
Up to 8 options per run
Editable captions
Images and GIFs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Social media creators, marketers and meme lovers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Imgflip AI Meme — Меми та жарти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'imgflip.com/ai-meme' OR LOWER(`name`) = 'imgflip ai meme')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Imgflip AI Meme', NULL, 'https://imgflip.com/ai-meme', NULL, NULL, 'АІ-генератор підписів до мемів від Imgflip: клікаєте шаблон і отримуєте новий жарт.', 'Imgflip’s AI meme caption generator: click a template and get a new joke.', 'Imgflip AI Meme генерує підписи до популярних шаблонів мемів. Є дві моделі: класична нейромережа, яка видає несподівані й часом абсурдні жарти, і модель на основі GPT, що пише зв’язніші підписи, особливо якщо задати тему. АІ-кнопка вбудована й у звичайний генератор мемів Imgflip, де підтримує всі шаблони та власні картинки. GPT-генерації безкоштовні до 25 на місяць, далі потрібна підписка Pro.', 'Imgflip AI Meme generates captions for popular meme templates. There are two models: a classic neural network that produces surprising, sometimes absurd jokes, and a GPT-based model that writes more coherent captions, especially when given a topic. The AI button is also built into the regular Imgflip Meme Generator, supporting all templates and custom uploads. GPT generations are free up to 25 a month, then Pro is required.', 'АІ-підписи до шаблонів мемів
Класична й GPT-модель
Вбудовано в генератор Imgflip
25 безкоштовних GPT-генерацій на місяць', 'AI captions for meme templates
Classic and GPT models
Built into the Imgflip generator
25 free GPT generations a month', 'Усім, хто хоче швидко зробити смішний мем.', 'Anyone who wants a funny meme fast.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-24 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'imgflip.com/ai-meme' OR LOWER(`name`) = 'imgflip ai meme') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'memes' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Imgflip’s AI meme caption generator: click a template and get a new joke.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Imgflip AI Meme generates captions for popular meme templates. There are two models: a classic neural network that produces surprising, sometimes absurd jokes, and a GPT-based model that writes more coherent captions, especially when given a topic. The AI button is also built into the regular Imgflip Meme Generator, supporting all templates and custom uploads. GPT generations are free up to 25 a month, then Pro is required.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI captions for meme templates
Classic and GPT models
Built into the Imgflip generator
25 free GPT generations a month', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone who wants a funny meme fast.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PicsArt — Смішні фільтри та ефекти (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'picsart' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'funny-filters' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Meitu — Смішні фільтри та ефекти, Мультяшні аватари (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'meitu' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'funny-filters' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'cartoon-avatars' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Facetune — Смішні фільтри та ефекти (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'facetune' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'funny-filters' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- FaceApp — Зістарення та омолодження, Смішні фільтри та ефекти (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'faceapp' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'age-transform' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'funny-filters' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- YouCam Makeup — Зістарення та омолодження (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'youcam makeup' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'age-transform' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Fotor — Зістарення та омолодження (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'fotor' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'age-transform' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Facelab — Зістарення та омолодження (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'facelab' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'age-transform' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- freebeat — Танцюючі тварини (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'freebeat' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dancing-animals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Viggle AI — Танцюючі тварини (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'viggle ai' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dancing-animals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Kling AI — Танцюючі тварини (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'kling ai' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dancing-animals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- PixVerse — Танцюючі тварини (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'pixverse' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dancing-animals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Vidu — Танцюючі тварини (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'vidu' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dancing-animals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Higgsfield — Танцюючі тварини (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'higgsfield' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'dancing-animals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Lensa — Мультяшні аватари (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'lensa' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'cartoon-avatars' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Pika — Оживлення фото (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'pika' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'photo-animation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Hedra — Оживлення фото (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'hedra' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'photo-animation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Vidnoz AI — Оживлення фото (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'vidnoz ai' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'photo-animation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Voicemod — Смішні голоси (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'voicemod' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'voice-changers' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Kapwing — Меми та жарти (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'kapwing' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'memes' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Predis.ai — Меми та жарти (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'predis.ai' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'memes' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

