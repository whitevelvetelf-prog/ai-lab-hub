SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-21: 12 підкатегорій із 9 продуктами до 10 (Мультимедіа, Подорожі, Розважальні, Українські додатки).
-- + 12 нових продуктів і 0 прив'язки наявних (функцію звірено на офіційних сайтах 2026-11-21).
-- Якщо продукт із такою адресою чи назвою вже є — лише прив'язка, тексти не змінюються.
-- Тексти UA/EN — за офіційними сайтами, звірено 2026-11-21.
-- Прив'язки: немає.
-- Пропущено: sport.ua (реклама букмекерів), SaveEcoBot і Повернись живим (403), Читанка (архів старих книжок), iPay.ua, UA-Футбол і Tribuna (403), ТРЦ Аладдін (на сайті мало відомостей).
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   Easy Diffusion — local-image-generation (новий)
--   Hostelling International — vacation-rentals (новий)
--   iLoveIMG Meme Generator — memes (новий)
--   Veteran Hub — ua-military (новий)
--   Аудіоказки Українською — ua-kids (новий)
--   Благодійний фонд Сергія Притули — ua-charity (новий)
--   Concert.ua — ua-tickets (новий)
--   City24 — ua-payments (новий)
--   НОК України — ua-sport (новий)
--   ТРК «Проспект» — ua-malls (новий)
--   Карта повітряних тривог (alerts.in.ua) — ua-alerts (новий)
--   Вступ.ОСВІТА.UA — ua-schools (новий)
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
-- Easy Diffusion
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'easydiffusion.github.io' OR LOWER(`name`) = 'easy diffusion')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Easy Diffusion', NULL, 'https://easydiffusion.github.io', NULL, NULL, 'Найпростіший спосіб генерувати зображення Stable Diffusion на своєму ПК: інсталятор в один клік, усе локально.', 'The easiest way to run Stable Diffusion image generation on your own PC: one-click installer, everything local.', 'Easy Diffusion — безкоштовний застосунок із відкритим кодом, що дає змогу створювати зображення за допомогою AI на власному комп''ютері без технічних знань. Достатньо запустити інсталятор, ввести текстовий або графічний запит і отримати зображення. Усе працює локально, нічого не завантажується в хмару. Є модифікатори стилів в один клік, докладна довідка з інтерфейсу та порадами щодо запитів, блог розробки, Discord-спільнота й GitHub.', 'Easy Diffusion is a free, open-source app for creating AI images on your own computer with no technical knowledge. Run the installer, enter a text or image prompt and get the generated image. Everything runs locally and nothing is uploaded to the cloud. It offers one-click style modifiers, a detailed UI reference and prompting guide, a development blog, a Discord community and GitHub.', 'Інсталятор в один клік
Усе працює локально
Текстові й графічні запити
Стилі в один клік
Відкритий код', 'One-click installer
Runs fully locally
Text and image prompts
One-click style modifiers
Open source', 'Початківцям, які хочуть генерувати зображення на своєму ПК без хмари.', 'Beginners who want to generate images on their own PC without the cloud.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'easydiffusion.github.io' OR LOWER(`name`) = 'easy diffusion') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'multimedia' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'local-image-generation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The easiest way to run Stable Diffusion image generation on your own PC: one-click installer, everything local.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Easy Diffusion is a free, open-source app for creating AI images on your own computer with no technical knowledge. Run the installer, enter a text or image prompt and get the generated image. Everything runs locally and nothing is uploaded to the cloud. It offers one-click style modifiers, a detailed UI reference and prompting guide, a development blog, a Discord community and GitHub.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'One-click installer
Runs fully locally
Text and image prompts
One-click style modifiers
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginners who want to generate images on their own PC without the cloud.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовно для користувачів.', 'Free for users.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for users.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hostelling International
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hihostels.com' OR LOWER(`name`) = 'hostelling international')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hostelling International', NULL, 'https://www.hihostels.com', NULL, NULL, 'Мережа понад 2000 хостелів у 50+ країнах від благодійної організації, що започаткувала хостели; бронювання на сайті.', 'Network of 2,000+ hostels in 50+ countries from the charity that invented hostelling; book on the website.', 'Hostelling International (HI) — благодійна організація, яка започаткувала рух хостелів. До мережі входить понад 2000 хостелів у більш ніж 50 країнах, і всі вони відповідають єдиному міжнародному стандарту. На сайті можна знайти й забронювати хостел, підібрати варіанти під стиль подорожі — від першої поїздки до довгих мандрівок — і підписатися на новини та пропозиції.', 'Hostelling International (HI) is the charity that invented hostelling. Its network includes over 2,000 hostels in more than 50 countries, all held to one global standard. On the website you can find and book a hostel, get options matched to your travel style — from a first trip to long slow journeys — and subscribe to news and offers.', '2000+ хостелів
50+ країн
Єдиний стандарт якості
Підбір під стиль подорожі
Бронювання онлайн', '2,000+ hostels
50+ countries
One global standard
Picks by travel style
Online booking', 'Мандрівникам, студентам і всім, хто шукає недороге житло в поїздках.', 'Travellers, students and anyone looking for affordable stays.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hihostels.com' OR LOWER(`name`) = 'hostelling international') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'travel-tourism' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vacation-rentals' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Network of 2,000+ hostels in 50+ countries from the charity that invented hostelling; book on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hostelling International (HI) is the charity that invented hostelling. Its network includes over 2,000 hostels in more than 50 countries, all held to one global standard. On the website you can find and book a hostel, get options matched to your travel style — from a first trip to long slow journeys — and subscribe to news and offers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '2,000+ hostels
50+ countries
One global standard
Picks by travel style
Online booking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers, students and anyone looking for affordable stays.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- iLoveIMG Meme Generator
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'iloveimg.com/meme-generator' OR LOWER(`name`) = 'iloveimg meme generator')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'iLoveIMG Meme Generator', NULL, 'https://www.iloveimg.com/meme-generator', NULL, NULL, 'Онлайн-генератор мемів від iLoveIMG: підписи до популярних шаблонів або власні картинки JPG, GIF і PNG.', 'Online meme generator by iLoveIMG: caption popular templates or your own JPG, GIF and PNG images.', 'Meme Generator — інструмент онлайн-редактора iLoveIMG для створення мемів. Можна обрати популярний шаблон або завантажити власне зображення у форматі JPG, GIF чи PNG, додати підписи й завантажити готовий мем, щоб поділитися ним. Працює в браузері без встановлення; поруч — інші інструменти iLoveIMG для стиснення, обрізання й редагування зображень.', 'Meme Generator is a tool in the iLoveIMG online image editor for making memes. Pick a popular template or upload your own JPG, GIF or PNG image, add captions and download the finished meme to share. It works in the browser with no install, alongside other iLoveIMG tools for compressing, cropping and editing images.', 'Популярні шаблони мемів
Власні JPG, GIF, PNG
Підписи до картинок
Працює в браузері
Інші інструменти iLoveIMG', 'Popular meme templates
Your own JPG, GIF, PNG
Image captions
Works in the browser
Other iLoveIMG tools', 'Усім, хто хоче швидко зробити мем без редактора.', 'Anyone who wants to make a meme quickly without an editor.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'iloveimg.com/meme-generator' OR LOWER(`name`) = 'iloveimg meme generator') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'entertainment' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'memes' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Online meme generator by iLoveIMG: caption popular templates or your own JPG, GIF and PNG images.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Meme Generator is a tool in the iLoveIMG online image editor for making memes. Pick a popular template or upload your own JPG, GIF or PNG image, add captions and download the finished meme to share. It works in the browser with no install, alongside other iLoveIMG tools for compressing, cropping and editing images.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Popular meme templates
Your own JPG, GIF, PNG
Image captions
Works in the browser
Other iLoveIMG tools', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone who wants to make a meme quickly without an editor.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Veteran Hub
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'veteranhub.com.ua' OR LOWER(`name`) = 'veteran hub')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Veteran Hub', NULL, 'https://veteranhub.com.ua', NULL, NULL, 'Безоплатні послуги для військових, ветеранів і їхніх родин: юридичні консультації, психолог, персональний супровід.', 'Free services for service members, veterans and their families: legal advice, psychologists and personal support.', 'Veteran Hub (Ветеран Хаб) — громадська організація, яка з моменту заснування надає безоплатні послуги для військових, ветеранів і ветеранок та їхніх подружжя, дітей і близьких. Можна зателефонувати й отримати юридичну консультацію, емоційну підтримку чи консультацію психолога, персональний супровід. Організація також досліджує досвід ветеранів (проєкт «Шлях ветеранів і ветеранок») і пропонує зміни до соціальної політики разом із державою.', 'Veteran Hub is a civic organisation that has provided free services since its founding to service members, veterans and their spouses, children and loved ones. You can call for legal advice, emotional support or a session with a psychologist, and personal case management. The organisation also researches veterans'' experience (the Veterans'' Path project) and proposes social policy changes together with the state.', 'Юридичні консультації
Психологічна підтримка
Персональний супровід
Допомога родинам
Усі послуги безоплатні', 'Legal advice
Psychological support
Personal case management
Help for families
All services free', 'Військовим, ветеранам і ветеранкам, їхнім родинам і близьким.', 'Service members, veterans and their families and loved ones.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'veteranhub.com.ua' OR LOWER(`name`) = 'veteran hub') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-military' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free services for service members, veterans and their families: legal advice, psychologists and personal support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Veteran Hub is a civic organisation that has provided free services since its founding to service members, veterans and their spouses, children and loved ones. You can call for legal advice, emotional support or a session with a psychologist, and personal case management. The organisation also researches veterans'' experience (the Veterans'' Path project) and proposes social policy changes together with the state.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Legal advice
Psychological support
Personal case management
Help for families
All services free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Service members, veterans and their families and loved ones.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовно для користувачів.', 'Free for users.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for users.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Аудіоказки Українською
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1529763321' OR LOWER(`name`) = 'аудіоказки українською')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Аудіоказки Українською', NULL, 'https://apps.apple.com/ua/app/id1529763321', NULL, NULL, 'Велика колекція аудіоказок і колискових українською для iPhone: професійна озвучка, музика, тексти казок, темна тема.', 'A large collection of audio fairy tales and lullabies in Ukrainian for iPhone: professional narration, music, texts, dark mode.', 'Аудіоказки Українською — iOS-додаток із колекцією аудіоказок і колискових українською мовою. Мета проєкту — розвивати в дітей мовлення, мислення, уяву й словниковий запас та популяризувати українську культуру. Казки озвучені професійно, з музичним супроводом; до деяких є тексти. У плеєрі видно читців, художників, композиторів і авторів, є категорії на головному екрані, нещодавно прослухані казки, сповіщення й темна тема. Частина казок безкоштовна, решта — за підпискою з місячним пробним періодом.', 'Audio Fairy Tales in Ukrainian is an iOS app with a collection of audio fairy tales and lullabies in Ukrainian. It aims to develop children''s speech, thinking, imagination and vocabulary and to promote Ukrainian culture. Stories are professionally narrated with music, and some include texts. The player credits narrators, illustrators, composers and authors; there are home-screen categories, recently played stories, notifications and a dark theme. Some tales are free; the rest come with a subscription that has a one-month trial.', 'Казки й колискові українською
Професійна озвучка з музикою
Тексти до казок
Категорії й історія прослуховування
Темна тема', 'Tales and lullabies in Ukrainian
Professional narration with music
Story texts
Categories and listening history
Dark theme', 'Батькам малюків, які хочуть слухати з дітьми казки українською.', 'Parents who want to listen to Ukrainian fairy tales with their children.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1529763321' OR LOWER(`name`) = 'аудіоказки українською') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-kids' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A large collection of audio fairy tales and lullabies in Ukrainian for iPhone: professional narration, music, texts, dark mode.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Audio Fairy Tales in Ukrainian is an iOS app with a collection of audio fairy tales and lullabies in Ukrainian. It aims to develop children''s speech, thinking, imagination and vocabulary and to promote Ukrainian culture. Stories are professionally narrated with music, and some include texts. The player credits narrators, illustrators, composers and authors; there are home-screen categories, recently played stories, notifications and a dark theme. Some tales are free; the rest come with a subscription that has a one-month trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tales and lullabies in Ukrainian
Professional narration with music
Story texts
Categories and listening history
Dark theme', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents who want to listen to Ukrainian fairy tales with their children.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Частина казок доступна безкоштовно; є покупки в додатку.', 'Some tales are free; in-app purchases available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Some tales are free; in-app purchases available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Підписка', 'Subscription', NULL, 'year', 'Річний тариф із місячним пробним періодом; ціну дивіться в App Store.', 'Annual plan with a one-month trial; see App Store for the price.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Annual plan with a one-month trial; see App Store for the price.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Благодійний фонд Сергія Притули
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prytulafoundation.org' OR LOWER(`name`) = 'благодійний фонд сергія притули')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Благодійний фонд Сергія Притули', NULL, 'https://prytulafoundation.org', NULL, NULL, 'Благодійний фонд: дрони, зв''язок і транспорт для війська, медицина, розмінування, укриття.', 'Charity foundation: drones, comms and vehicles for the army, medicine, demining and shelters.', 'Благодійний фонд Сергія Притули збирає кошти й закуповує для українського війська ударні БПЛА й бомбери, оптику, засоби зв''язку, автоматизовані турелі й роботизовані платформи, транспорт. Фонд проводить навчання з тактичної медицини й базову військову підготовку для цивільних, допомагає гуманітарному розмінуванню, мобільній медицині на деокупованих і прифронтових територіях та облаштуванню шкільних укриттів. На сайті є звіти й можна задонатити.', 'The Serhiy Prytula Charity Foundation raises funds and buys strike drones and bombers, optics, communications, automated turrets, robotic platforms and vehicles for the Ukrainian army. It runs tactical medicine training and basic military training for civilians, supports humanitarian demining, mobile medicine in de-occupied and frontline areas, and school shelter upgrades. The website has reports and a donation page.', 'Дрони й техніка для війська
Навчання з такмеду
Гуманітарне розмінування
Мобільна медицина
Звіти й донати онлайн', 'Drones and gear for the army
Tactical medicine training
Humanitarian demining
Mobile medicine
Reports and online donations', 'Усім, хто хоче підтримати армію та відновлення України донатом.', 'Anyone who wants to support the army and Ukraine''s recovery with a donation.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prytulafoundation.org' OR LOWER(`name`) = 'благодійний фонд сергія притули') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-charity' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Charity foundation: drones, comms and vehicles for the army, medicine, demining and shelters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Serhiy Prytula Charity Foundation raises funds and buys strike drones and bombers, optics, communications, automated turrets, robotic platforms and vehicles for the Ukrainian army. It runs tactical medicine training and basic military training for civilians, supports humanitarian demining, mobile medicine in de-occupied and frontline areas, and school shelter upgrades. The website has reports and a donation page.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Drones and gear for the army
Tactical medicine training
Humanitarian demining
Mobile medicine
Reports and online donations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone who wants to support the army and Ukraine''s recovery with a donation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовно для користувачів.', 'Free for users.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for users.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Concert.ua
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'concert.ua/uk' OR LOWER(`name`) = 'concert.ua')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Concert.ua', NULL, 'https://concert.ua/uk', NULL, NULL, 'Афіша й офіційні квитки онлайн з 2012 року: концерти, вистави, стендап, дитячі події та онлайн-трансляції.', 'Event listings and official tickets online since 2012: concerts, plays, stand-up, kids'' events and live streams.', 'Concert.ua — український сервіс продажу квитків, що працює з 2012 року. На сайті є афіша заходів у містах України з розкладом і квитками на концерти, вистави, стендап і дитячі події; деякі події можна дивитися онлайн-трансляцією з будь-якої точки світу. Квитки купують онлайн або в касах.', 'Concert.ua is a Ukrainian ticketing service operating since 2012. The website lists events in Ukrainian cities with schedules and tickets for concerts, plays, stand-up and kids'' events; some events can be watched as a live stream from anywhere in the world. Tickets can be bought online or at box offices.', 'Афіша по містах України
Концерти, вистави, стендап
Дитячі події
Онлайн-трансляції
Офіційні квитки онлайн', 'Listings by Ukrainian city
Concerts, plays, stand-up
Kids'' events
Live streams
Official tickets online', 'Усім, хто шукає, куди піти, і купує квитки онлайн.', 'Anyone looking for something to go to and buying tickets online.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'concert.ua/uk' OR LOWER(`name`) = 'concert.ua') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-tickets' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Event listings and official tickets online since 2012: concerts, plays, stand-up, kids'' events and live streams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Concert.ua is a Ukrainian ticketing service operating since 2012. The website lists events in Ukrainian cities with schedules and tickets for concerts, plays, stand-up and kids'' events; some events can be watched as a live stream from anywhere in the world. Tickets can be bought online or at box offices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Listings by Ukrainian city
Concerts, plays, stand-up
Kids'' events
Live streams
Official tickets online', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone looking for something to go to and buying tickets online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- City24
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'city24.ua' OR LOWER(`name`) = 'city24')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'City24', NULL, 'https://city24.ua', NULL, NULL, 'Онлайн-оплата комуналки, охорони, мобільного, інтернету й штрафів, погашення кредитів, поповнення картки, донати.', 'Pay utilities, security, mobile, internet and fines online, repay loans, top up cards and donate.', 'City24 — сервіс платежів, через який можна оплатити комунальні послуги, охорону, мобільний зв''язок, інтернет, штрафи поліції та платежі за дорученнями, погасити кредит або поповнити картку. Є перевірка й оплата штрафів за серією та номером водійського посвідчення, а також розділ, де можна обрати благодійний фонд і зробити донат. Працює під ліцензією НБУ на надання фінансових платіжних послуг.', 'City24 is a payments service for utilities, security services, mobile, internet, police fines and payment orders, loan repayments and card top-ups. It can check and pay fines by driving licence series and number, and has a section for choosing a charity fund and donating. It operates under a National Bank of Ukraine licence for financial payment services.', 'Комуналка й інтернет
Перевірка й оплата штрафів
Погашення кредитів
Поповнення картки
Донати фондам', 'Utilities and internet
Check and pay fines
Loan repayments
Card top-ups
Charity donations', 'Тим, хто оплачує рахунки й штрафи онлайн.', 'People paying bills and fines online.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'city24.ua' OR LOWER(`name`) = 'city24') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-payments' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Pay utilities, security, mobile, internet and fines online, repay loans, top up cards and donate.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'City24 is a payments service for utilities, security services, mobile, internet, police fines and payment orders, loan repayments and card top-ups. It can check and pay fines by driving licence series and number, and has a section for choosing a charity fund and donating. It operates under a National Bank of Ukraine licence for financial payment services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Utilities and internet
Check and pay fines
Loan repayments
Card top-ups
Charity donations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People paying bills and fines online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- НОК України
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'noc-ukr.org' OR LOWER(`name`) = 'нок україни')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'НОК України', NULL, 'https://noc-ukr.org', NULL, NULL, 'Національний олімпійський комітет України: новини олімпійського спорту, збірні, найкращі спортсмени місяця, події.', 'National Olympic Committee of Ukraine: Olympic sport news, national teams, athletes of the month and events.', 'Національний олімпійський комітет України координує олімпійський рух у країні. На сайті — новини про виступи українських спортсменів на Олімпійських і юнацьких Олімпійських іграх, склади делегацій, конкурс «Найкращий спортсмен місяця», Європейський тиждень спорту #BeActive, програми НОК, Олімпійську академію та Спортивний арбітражний суд.', 'The National Olympic Committee of Ukraine coordinates the Olympic movement in the country. Its website covers Ukrainian athletes at the Olympic and Youth Olympic Games, delegation line-ups, the Athlete of the Month award, the European Week of Sport #BeActive, NOC programmes, the Olympic Academy and the Sports Arbitration Court.', 'Новини олімпійського спорту
Делегації України
Спортсмени місяця
#BeActive
Олімпійська академія', 'Olympic sport news
Ukrainian delegations
Athletes of the month
#BeActive
Olympic Academy', 'Уболівальникам олімпійських видів спорту, спортсменам і тренерам.', 'Fans of Olympic sports, athletes and coaches.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'noc-ukr.org' OR LOWER(`name`) = 'нок україни') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-sport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'National Olympic Committee of Ukraine: Olympic sport news, national teams, athletes of the month and events.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The National Olympic Committee of Ukraine coordinates the Olympic movement in the country. Its website covers Ukrainian athletes at the Olympic and Youth Olympic Games, delegation line-ups, the Athlete of the Month award, the European Week of Sport #BeActive, NOC programmes, the Olympic Academy and the Sports Arbitration Court.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Olympic sport news
Ukrainian delegations
Athletes of the month
#BeActive
Olympic Academy', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Fans of Olympic sports, athletes and coaches.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовно для користувачів.', 'Free for users.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for users.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ТРК «Проспект»
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prospekt.com.ua/ua' OR LOWER(`name`) = 'трк «проспект»')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ТРК «Проспект»', NULL, 'https://prospekt.com.ua/ua', NULL, NULL, 'Торговельний комплекс на лівому березі Києва: магазини, кінотеатр Multiplex на 7 залів, кафе, розваги, безкоштовний паркінг.', 'Shopping centre on Kyiv''s left bank: shops, a 7-screen Multiplex cinema, cafés, entertainment and free parking.', 'ТРК «Проспект» — торговельно-розважальний комплекс у центрі лівобережної частини Києва. Тут магазини, розваги для родини, 7 залів кінотеатру Multiplex (зокрема лаунж-зал на 54 місця з кріслами-реклайнерами), кафе й ресторани, просторий безкоштовний паркінг. На сайті — магазини й заклади, події, правила перебування та адреси найближчих укриттів; якщо о 21:00 ще триває повітряна тривога, галерея того дня вже не відкривається.', 'Prospekt is a shopping and entertainment centre in the heart of Kyiv''s left bank. It has shops, family entertainment, a 7-screen Multiplex cinema (including a 54-seat lounge hall with recliners), cafés and restaurants and a large free car park. The website lists shops and venues, events, visitor rules and the nearest official shelters; if an air raid alert is still on at 9 pm, the gallery does not reopen that day.', 'Магазини й ресторани
Multiplex на 7 залів
Розваги для родини
Безкоштовний паркінг
Найближчі укриття', 'Shops and restaurants
7-screen Multiplex
Family entertainment
Free parking
Nearest shelters', 'Мешканцям лівого берега Києва й гостям міста.', 'Residents of Kyiv''s left bank and visitors.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prospekt.com.ua/ua' OR LOWER(`name`) = 'трк «проспект»') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-malls' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Shopping centre on Kyiv''s left bank: shops, a 7-screen Multiplex cinema, cafés, entertainment and free parking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Prospekt is a shopping and entertainment centre in the heart of Kyiv''s left bank. It has shops, family entertainment, a 7-screen Multiplex cinema (including a 54-seat lounge hall with recliners), cafés and restaurants and a large free car park. The website lists shops and venues, events, visitor rules and the nearest official shelters; if an air raid alert is still on at 9 pm, the gallery does not reopen that day.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Shops and restaurants
7-screen Multiplex
Family entertainment
Free parking
Nearest shelters', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Residents of Kyiv''s left bank and visitors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовно для користувачів.', 'Free for users.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for users.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Карта повітряних тривог (alerts.in.ua)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'alerts.in.ua' OR LOWER(`name`) = 'карта повітряних тривог (alerts.in.ua)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Карта повітряних тривог (alerts.in.ua)', NULL, 'https://alerts.in.ua', NULL, NULL, 'Інтерактивна мапа повітряних тривог і загроз в Україні в реальному часі: причини тривог, рух дронів і ракет.', 'Real-time interactive map of air raid alerts and threats in Ukraine: alert causes, drone and missile movement.', 'alerts.in.ua — інтерактивна мапа, що в реальному часі показує повітряні тривоги та інші загрози в Україні. На мапі видно причини тривог, а також рух дронів і ракет, тож можна швидко зрозуміти ситуацію у своєму регіоні.', 'alerts.in.ua is an interactive map showing air raid alerts and other threats in Ukraine in real time. It displays the causes of alerts and the movement of drones and missiles, so you can quickly understand the situation in your area.', 'Тривоги в реальному часі
Причини тривог
Рух дронів і ракет
Інші загрози
Працює в браузері', 'Real-time alerts
Alert causes
Drone and missile movement
Other threats
Works in the browser', 'Усім в Україні, хто стежить за тривогами у своєму регіоні.', 'Anyone in Ukraine following alerts in their region.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'alerts.in.ua' OR LOWER(`name`) = 'карта повітряних тривог (alerts.in.ua)') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-alerts' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Real-time interactive map of air raid alerts and threats in Ukraine: alert causes, drone and missile movement.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'alerts.in.ua is an interactive map showing air raid alerts and other threats in Ukraine in real time. It displays the causes of alerts and the movement of drones and missiles, so you can quickly understand the situation in your area.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time alerts
Alert causes
Drone and missile movement
Other threats
Works in the browser', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone in Ukraine following alerts in their region.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовно для користувачів.', 'Free for users.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for users.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Вступ.ОСВІТА.UA
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vstup.osvita.ua' OR LOWER(`name`) = 'вступ.освіта.ua')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Вступ.ОСВІТА.UA', NULL, 'https://vstup.osvita.ua', NULL, NULL, 'Інформація для вступників: заклади й спеціальності, конкурс, бали для бюджету, рейтингові списки онлайн.', 'Information for applicants: institutions and programmes, competition data, budget-place scores and live ranking lists.', 'Вступ.ОСВІТА.UA — онлайн-платформа для вступників до закладів вищої та фахової передвищої освіти. Тут є перелік закладів, спеціальностей та освітніх програм, конкурс і прохідні бали на бюджет, а в липні–жовтні — рейтингові списки вступників за кожною спеціальністю. Дані беруться з Єдиної державної електронної бази з питань освіти (ЄДЕБО).', 'Vstup.OSVITA.UA is an online platform for applicants to higher and professional pre-higher education. It lists institutions, specialities and programmes, competition figures and scores needed for state-funded places, and from July to October the ranking lists of applicants for each speciality. The data comes from the Unified State Electronic Database on Education (EDEBO).', 'Заклади й спеціальності
Бали для бюджету
Рейтингові списки
Конкурс на місце
Дані з ЄДЕБО', 'Institutions and specialities
Scores for state-funded places
Ranking lists
Competition per place
Data from EDEBO', 'Абітурієнтам, їхнім батькам і вчителям.', 'University applicants, their parents and teachers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vstup.osvita.ua' OR LOWER(`name`) = 'вступ.освіта.ua') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-schools' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Information for applicants: institutions and programmes, competition data, budget-place scores and live ranking lists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Vstup.OSVITA.UA is an online platform for applicants to higher and professional pre-higher education. It lists institutions, specialities and programmes, competition figures and scores needed for state-funded places, and from July to October the ranking lists of applicants for each speciality. The data comes from the Unified State Electronic Database on Education (EDEBO).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Institutions and specialities
Scores for state-funded places
Ranking lists
Competition per place
Data from EDEBO', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'University applicants, their parents and teachers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовно для користувачів.', 'Free for users.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for users.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Прив'язки наявних продуктів (за назвою, без id)
