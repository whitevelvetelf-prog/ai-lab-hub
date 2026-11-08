SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-08: «Мультимедіа» → «Генерація відео» / «Відеомонтаж» (для статті «АІ для відео»).
-- 7 нових продуктів. Тексти UA/EN — за офіційними сторінками, звірено 2026-11-08. Якщо продукт уже є — лише прив’язка.
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою. Повторний запуск безпечний.
--   VEED — video-editing
--   Fliki — video-generation, voiceover
--   Gling — video-editing
--   HunyuanVideo — video-generation
--   LTX-2 — video-generation
--   Moonvalley Marey — video-generation
--   Wan — video-generation
-- Прив’язка наявних: Riverside.fm → video-editing, Descript → video-editing, LTX Studio → video-generation
-- Застосування: phpMyAdmin → gu621051_ailabhublive → «Импорт» (або SQL → вставити → «Вперёд»).
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'multimedia' LIMIT 1);

-- VEED
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'veed.io' OR LOWER(`name`) = 'veed')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'VEED', NULL, 'https://www.veed.io', NULL, NULL, 'Онлайн-відеоредактор у браузері: запис, монтаж, автоматичні субтитри, переклад і АІ-інструменти.', 'Browser-based video editor: recording, editing, automatic subtitles, translation and AI tools.', 'VEED — онлайн-набір для роботи з відео: запис екрана й камери, монтаж, стрімінг і хмарне зберігання. Субтитри генеруються автоматично: у платних планах — без обмеження кількості в межах 50 годин на місяць, переклад рахується за хвилинами. АІ-генерації оплачуються кредитами, які входять у план на місяць чи рік і не переносяться. Плани рахуються за кількістю місць у команді, почати можна безкоштовно.', 'VEED is an online suite for video: screen and camera recording, editing, streaming and cloud storage. Subtitles are generated automatically: paid plans include unlimited subtitles within a 50-hour monthly fair-use limit, translation is billed by the minute. AI generations use credits included in the plan per month or year, which do not roll over. Plans are per seat; you can start for free.', 'Монтаж у браузері
Автоматичні субтитри
Переклад відео
Запис екрана й камери', 'Editing in the browser
Automatic subtitles
Video translation
Screen and camera recording', 'Блогери, ютубери, подкастери й маркетологи, яким треба швидко змонтувати відео', 'Bloggers, YouTubers, podcasters and marketers who need to edit video fast', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-08 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'veed.io' OR LOWER(`name`) = 'veed') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'video-editing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Browser-based video editor: recording, editing, automatic subtitles, translation and AI tools.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'VEED is an online suite for video: screen and camera recording, editing, streaming and cloud storage. Subtitles are generated automatically: paid plans include unlimited subtitles within a 50-hour monthly fair-use limit, translation is billed by the minute. AI generations use credits included in the plan per month or year, which do not roll over. Plans are per seat; you can start for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Editing in the browser
Automatic subtitles
Video translation
Screen and camera recording', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Bloggers, YouTubers, podcasters and marketers who need to edit video fast', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Fliki
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fliki.ai' OR LOWER(`name`) = 'fliki')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fliki', NULL, 'https://fliki.ai', NULL, NULL, 'Відео з тексту, ідеї чи статті з реалістичною озвучкою: сцени, стокові кадри, переклад і аватари.', 'Video from a script, idea or article with lifelike voiceover: scenes, stock footage, translation and avatars.', 'Fliki перетворює ідею, сценарій чи довгий текст на відео з озвученням: сервіс сам розбиває текст на сцени й підбирає візуал. Безкоштовний план — 3 кредити на місяць, 720p, водяний знак і експорт до 5 хвилин. Standard дає 180 кредитів, 1080p, відео до 15 хвилин, переклад на 80+ мов, клонування голосу й обмежений набір аватарів. Premium — 600 кредитів, АІ-відеокліпи, фотоаватари й доступ до API. Ціни платних планів — на сайті, за річної оплати знижка 25%.', 'Fliki turns an idea, script or long text into a narrated video: it splits the text into scenes and picks visuals for you. The free plan gives 3 credits a month, 720p, a watermark and exports up to 5 minutes. Standard gives 180 credits, 1080p, videos up to 15 minutes, translation into 80+ languages, voice cloning and a limited set of avatars. Premium has 600 credits, AI video clips, photo avatars and API access. Paid plan prices are on the website; annual billing saves 25%.', 'Відео з тексту чи ідеї
Реалістичні голоси
Переклад на 80+ мов
Аватари й клонування голосу', 'Video from text or an idea
Lifelike voices
Translation into 80+ languages
Avatars and voice cloning', 'Автори відео, маркетологи, блогери й усі, хто хоче створювати відео з тексту чи картинки', 'Video creators, marketers, bloggers and anyone who wants to make video from text or an image', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-08 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fliki.ai' OR LOWER(`name`) = 'fliki') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'video-generation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'voiceover' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Video from a script, idea or article with lifelike voiceover: scenes, stock footage, translation and avatars.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Fliki turns an idea, script or long text into a narrated video: it splits the text into scenes and picks visuals for you. The free plan gives 3 credits a month, 720p, a watermark and exports up to 5 minutes. Standard gives 180 credits, 1080p, videos up to 15 minutes, translation into 80+ languages, voice cloning and a limited set of avatars. Premium has 600 credits, AI video clips, photo avatars and API access. Paid plan prices are on the website; annual billing saves 25%.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Video from text or an idea
Lifelike voices
Translation into 80+ languages
Avatars and voice cloning', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Video creators, marketers, bloggers and anyone who wants to make video from text or an image', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', '3 кредити на місяць, 720p, водяний знак, експорт до 5 хв.', '3 credits per month, 720p, watermark, export up to 5 min.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '3 credits per month, 720p, watermark, export up to 5 min.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Gling
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gling.ai' OR LOWER(`name`) = 'gling')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Gling', NULL, 'https://www.gling.ai', NULL, NULL, 'АІ-монтаж для ютуберів: прибирає невдалі дублі, паузи й слова-паразити, робить субтитри й короткі кліпи.', 'AI editing for YouTubers: removes bad takes, silences and filler words, adds captions and short clips.', 'Gling — АІ-редактор для авторів YouTube. Він автоматично вирізає невдалі дублі, тишу й слова-паразити, додає субтитри (експорт SRT), робить короткі кліпи, B-roll, автокадрування й мультикамеру, пропонує назви й розділи. Готовий монтаж можна перенести в Premiere, Final Cut чи DaVinci Resolve (у платних планах). Сервіс розрахований на комп’ютер. Безкоштовно — 1 година на місяць з водяним знаком; Plus — 20 доларів на місяць (10 за річної оплати), Pro — 40 (20), Elite — 100 (50).', 'Gling is an AI editor for YouTube creators. It automatically cuts bad takes, silences and filler words, adds captions (SRT export), makes short clips, B-roll, auto framing and multicam, and suggests titles and chapters. Paid plans export the edit to Premiere, Final Cut or DaVinci Resolve. It is designed for desktop. Free gives 1 hour a month with a watermark; Plus is $20 a month ($10 billed annually), Pro $40 ($20), Elite $100 ($50).', 'Вирізає дублі, паузи й слова-паразити
АІ-субтитри й короткі кліпи
Експорт у Premiere, Final Cut, Resolve
1 година на місяць безкоштовно', 'Cuts bad takes, silences and filler words
AI captions and short clips
Export to Premiere, Final Cut, Resolve
1 hour a month free', 'Блогери, ютубери, подкастери й маркетологи, яким треба швидко змонтувати відео', 'Bloggers, YouTubers, podcasters and marketers who need to edit video fast', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-08 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gling.ai' OR LOWER(`name`) = 'gling') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'video-editing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI editing for YouTubers: removes bad takes, silences and filler words, adds captions and short clips.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Gling is an AI editor for YouTube creators. It automatically cuts bad takes, silences and filler words, adds captions (SRT export), makes short clips, B-roll, auto framing and multicam, and suggests titles and chapters. Paid plans export the edit to Premiere, Final Cut or DaVinci Resolve. It is designed for desktop. Free gives 1 hour a month with a watermark; Plus is $20 a month ($10 billed annually), Pro $40 ($20), Elite $100 ($50).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cuts bad takes, silences and filler words
AI captions and short clips
Export to Premiere, Final Cut, Resolve
1 hour a month free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Bloggers, YouTubers, podcasters and marketers who need to edit video fast', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', '1 година АІ-монтажу на місяць, експорт з водяним знаком.', '1 hour of AI editing per month, watermarked export.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '1 hour of AI editing per month, watermarked export.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Plus', 'Plus', 20.00, 'month', '10 годин на місяць, без водяного знака; 10 $/міс за річної оплати.', '10 hours a month, no watermark; $10/mo billed annually.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Plus' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Plus', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '10 hours a month, no watermark; $10/mo billed annually.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 40.00, 'month', '30 годин на місяць; 20 $/міс за річної оплати.', '30 hours a month; $20/mo billed annually.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '30 hours a month; $20/mo billed annually.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Elite', 'Elite', 100.00, 'month', '100 годин на місяць; 50 $/міс за річної оплати.', '100 hours a month; $50/mo billed annually.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Elite' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Elite', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '100 hours a month; $50/mo billed annually.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- HunyuanVideo
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/tencent-hunyuan/hunyuanvideo' OR LOWER(`name`) = 'hunyuanvideo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HunyuanVideo', NULL, 'https://github.com/Tencent-Hunyuan/HunyuanVideo', NULL, NULL, 'Відкрита модель генерації відео від Tencent: ваги й код для запуску на власній відеокарті.', 'Tencent’s open video generation model: weights and code to run on your own GPU.', 'HunyuanVideo — відкрита базова модель для генерації відео з понад 13 мільярдами параметрів. Код і ваги опубліковано 3 грудня 2024 року; згодом вийшли HunyuanVideo-I2V (з картинки у відео), HunyuanVideo-Avatar і HunyuanVideo-1.5 (листопад 2025, окремий репозиторій). Для запуску першої версії потрібна відеокарта NVIDIA з 45–60 ГБ пам’яті (рекомендовано 80 ГБ) і Linux. Умови використання — у файлі ліцензії репозиторію.', 'HunyuanVideo is an open video foundation model with over 13 billion parameters. Code and weights were released on 3 December 2024; later came HunyuanVideo-I2V (image to video), HunyuanVideo-Avatar and HunyuanVideo-1.5 (November 2025, separate repository). The original model needs an NVIDIA GPU with 45–60 GB of memory (80 GB recommended) and Linux. Terms of use are in the repository licence file.', 'Відкриті ваги
Текст у відео
Версії I2V, Avatar, 1.5
Локальний запуск', 'Open weights
Text to video
I2V, Avatar and 1.5 versions
Runs locally', 'Ентузіасти й розробники з потужною відеокартою, які хочуть генерувати відео локально', 'Enthusiasts and developers with a powerful GPU who want to generate video locally', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-11-08 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/tencent-hunyuan/hunyuanvideo' OR LOWER(`name`) = 'hunyuanvideo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'video-generation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tencent’s open video generation model: weights and code to run on your own GPU.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'HunyuanVideo is an open video foundation model with over 13 billion parameters. Code and weights were released on 3 December 2024; later came HunyuanVideo-I2V (image to video), HunyuanVideo-Avatar and HunyuanVideo-1.5 (November 2025, separate repository). The original model needs an NVIDIA GPU with 45–60 GB of memory (80 GB recommended) and Linux. Terms of use are in the repository licence file.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Open weights
Text to video
I2V, Avatar and 1.5 versions
Runs locally', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Enthusiasts and developers with a powerful GPU who want to generate video locally', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно (відкриті ваги)', 'Free (open weights)', 0.00, 'free', 'Модель і код безкоштовні; потрібна власна потужна відеокарта.', 'Model and code are free; you need your own powerful GPU.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно (відкриті ваги)' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free (open weights)', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Model and code are free; you need your own powerful GPU.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- LTX-2
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/lightricks/ltx-2' OR LOWER(`name`) = 'ltx-2')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LTX-2', NULL, 'https://github.com/Lightricks/LTX-2', NULL, NULL, 'Відкрита модель Lightricks, що генерує відео одразу із синхронним звуком; запуск на власному комп’ютері.', 'Lightricks’ open model that generates video with synchronised audio; runs on your own machine.', 'LTX-2 — модель для генерації відео й аудіо водночас, від авторів LTX Studio. Вміє текст і картинку у відео, звук у відео, інтерполяцію між ключовими кадрами, перегенерацію окремого фрагмента (Retake), перетворення відео у відео, переведення SDR у HDR і дубляж із збереженням голосу та руху губ. Рекомендована версія — LTX-2.5 (завантаження близько 66 ГБ). Код — під Apache-2.0, ваги — під окремою LTX-2.x Community License.', 'LTX-2 is a model that generates video and audio together, from the makers of LTX Studio. It does text and image to video, audio to video, keyframe interpolation, regenerating a single segment (Retake), video to video, SDR to HDR and dubbing that keeps the speaker’s voice and lip movement. The recommended version is LTX-2.5 (about a 66 GB download). The code is Apache-2.0; the weights use a separate LTX-2.x Community License.', 'Відео одразу зі звуком
Текст, картинка, звук у відео
Retake і ключові кадри
Відкриті ваги', 'Video with audio in one pass
Text, image, audio to video
Retake and keyframes
Open weights', 'Ентузіасти й розробники з потужною відеокартою, які хочуть генерувати відео локально', 'Enthusiasts and developers with a powerful GPU who want to generate video locally', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-11-08 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/lightricks/ltx-2' OR LOWER(`name`) = 'ltx-2') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'video-generation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Lightricks’ open model that generates video with synchronised audio; runs on your own machine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LTX-2 is a model that generates video and audio together, from the makers of LTX Studio. It does text and image to video, audio to video, keyframe interpolation, regenerating a single segment (Retake), video to video, SDR to HDR and dubbing that keeps the speaker’s voice and lip movement. The recommended version is LTX-2.5 (about a 66 GB download). The code is Apache-2.0; the weights use a separate LTX-2.x Community License.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Video with audio in one pass
Text, image, audio to video
Retake and keyframes
Open weights', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Enthusiasts and developers with a powerful GPU who want to generate video locally', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно (відкриті ваги)', 'Free (open weights)', 0.00, 'free', 'Код Apache-2.0, ваги — LTX-2.x Community License; потрібна власна відеокарта.', 'Code under Apache-2.0, weights under the LTX-2.x Community License; you need your own GPU.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно (відкриті ваги)' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free (open weights)', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Code under Apache-2.0, weights under the LTX-2.x Community License; you need your own GPU.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Moonvalley Marey
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moonvalley.com' OR LOWER(`name`) = 'moonvalley marey')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Moonvalley Marey', NULL, 'https://www.moonvalley.com', NULL, NULL, 'Відеомодель Marey, навчена на ліцензованих даних: текст і картинка у відео з керуванням камерою й рухом.', 'Marey video model trained on licensed data: text and image to video with camera and motion control.', 'Moonvalley розробляє відеомодель Marey, яку компанія називає повністю ліцензованою й безпечною для комерційного використання, бо її навчено на ліцензованих даних. Marey генерує відео з тексту чи картинки й дає точне керування: рух камери, перенесення пози й руху, траєкторії об’єктів і шари. Доступна в браузері, через ComfyUI і fal.ai; API — у списку очікування. Ціни — на сайті.', 'Moonvalley builds the Marey video model, which the company calls fully licensed and commercially safe because it is trained on licensed data. Marey generates video from text or an image with precise control: camera motion, pose and motion transfer, object trajectories and layers. Available in the browser and via ComfyUI and fal.ai; the API has a waitlist. Prices are on the website.', 'Навчена на ліцензованих даних
Текст і картинка у відео
Керування камерою й рухом
ComfyUI і fal.ai', 'Trained on licensed data
Text and image to video
Camera and motion control
ComfyUI and fal.ai', 'Студії, рекламні агенції й автори, яким потрібне комерційно безпечне АІ-відео', 'Studios, ad agencies and creators who need commercially safe AI video', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-08 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moonvalley.com' OR LOWER(`name`) = 'moonvalley marey') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'video-generation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Marey video model trained on licensed data: text and image to video with camera and motion control.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Moonvalley builds the Marey video model, which the company calls fully licensed and commercially safe because it is trained on licensed data. Marey generates video from text or an image with precise control: camera motion, pose and motion transfer, object trajectories and layers. Available in the browser and via ComfyUI and fal.ai; the API has a waitlist. Prices are on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Trained on licensed data
Text and image to video
Camera and motion control
ComfyUI and fal.ai', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Studios, ad agencies and creators who need commercially safe AI video', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Wan
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wan.video' OR LOWER(`name`) = 'wan')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Wan', NULL, 'https://wan.video', NULL, NULL, 'Творча АІ-платформа Alibaba на моделях Wan: текст і картинка у відео, генерація й редагування зображень.', 'Alibaba’s AI creative platform built on Wan models: text and image to video, image generation and editing.', 'Wan — платформа Alibaba, де працюють моделі сімейства Wan: генерація відео з тексту чи картинки, зображень з тексту, перетворення й редагування зображень. Ранні версії моделі, Wan 2.1 і Wan 2.2, викладено з відкритими вагами під ліцензією Apache 2.0, тож їх можна запускати локально; новіші версії доступні через платформу й API. Ціни — на сайті.', 'Wan is Alibaba’s platform for the Wan model family: video from text or an image, images from text, image-to-image and image editing. Earlier versions, Wan 2.1 and Wan 2.2, were released with open weights under Apache 2.0, so they can run locally; newer versions are available on the platform and via API. Prices are on the website.', 'Текст і картинка у відео
Генерація й редагування зображень
Відкриті Wan 2.1 і 2.2
API', 'Text and image to video
Image generation and editing
Open Wan 2.1 and 2.2
API', 'Автори відео, маркетологи, блогери й усі, хто хоче створювати відео з тексту чи картинки', 'Video creators, marketers, bloggers and anyone who wants to make video from text or an image', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-08 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wan.video' OR LOWER(`name`) = 'wan') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'video-generation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Alibaba’s AI creative platform built on Wan models: text and image to video, image generation and editing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Wan is Alibaba’s platform for the Wan model family: video from text or an image, images from text, image-to-image and image editing. Earlier versions, Wan 2.1 and Wan 2.2, were released with open weights under Apache 2.0, so they can run locally; newer versions are available on the platform and via API. Prices are on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Text and image to video
Image generation and editing
Open Wan 2.1 and 2.2
API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Video creators, marketers, bloggers and anyone who wants to make video from text or an image', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Прив’язка наявних продуктів (за назвою)
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'Riverside.fm' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'video-editing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'Descript' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'video-editing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'LTX Studio' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'video-generation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
