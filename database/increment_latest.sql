SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-14: нова категорія «Доступність» / «Accessibility» (slug accessibility) з підкатегоріями:
--   * Для незрячих і слабозорих / Blind & Low Vision (slug blind-low-vision)
--   * Для глухих і слабочуючих / Deaf & Hard of Hearing (slug deaf-hard-of-hearing)
--   * Мовлення та альтернативна комунікація / Speech & AAC (slug speech-aac)
--   * Читання та нейровідмінності / Reading & Neurodiversity (slug reading-neurodiversity)
--   * Керування без рук / Hands-free Access (slug hands-free)
--   * Цифрова доступність для бізнесу / Digital Accessibility for Business (slug digital-accessibility)
-- + 64 нових продуктів, 1 наявних лише прив'язано (тексти не змінюються): Speechify
-- Назви-кандидати — з відкритих каталогів і списків; тексти UA/EN написано заново з офіційних сайтів, звірено 2026-10-14.
-- Ціни не вказано: план «Ціна: див. сайт» (0, one_time); Free — де офіційний сайт підтверджує безкоштовний рівень.
-- Описи нейтральні, без медичних порад і обіцянок результату.
-- Пропущено: Supersense (сайт не оновлювався з 2021), Oko/AYES і Camera Mouse (сайти недоступні), TranscribeGlass (сайт 2021),
--   Project Relate (не приймає нових користувачів), Project Gameface (архівовано), Sesame Enable (компанія закрилася),
--   Dragon (сторінка 404), Cephable (змінив профіль), Immersive Reader (вбудована функція Microsoft 365), precisiongazemouse.org (домен захоплено).
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   Be My Eyes — Для незрячих і слабозорих
--   Seeing AI — Для незрячих і слабозорих
--   Envision — Для незрячих і слабозорих
--   Aira — Для незрячих і слабозорих
--   Google Lookout — Для незрячих і слабозорих
--   TapTapSee — Для незрячих і слабозорих
--   Cash Reader — Для незрячих і слабозорих
--   NVDA — Для незрячих і слабозорих
--   JAWS — Для незрячих і слабозорих
--   ZoomText — Для незрячих і слабозорих
--   BlindSquare — Для незрячих і слабозорих
--   Lazarillo — Для незрячих і слабозорих
--   WeWALK Smart Cane — Для незрячих і слабозорих
--   Glidance Glide — Для незрячих і слабозорих
--   Voice Dream Reader — Для незрячих і слабозорих
--   Sullivan Plus — Для незрячих і слабозорих
--   Ava — Для глухих і слабочуючих
--   Live Transcribe & Sound Notifications — Для глухих і слабочуючих
--   Rogervoice — Для глухих і слабочуючих
--   Rylo (Nagish) — Для глухих і слабочуючих
--   InnoCaption — Для глухих і слабочуючих
--   Hand Talk — Для глухих і слабочуючих
--   Signapse — Для глухих і слабочуючих
--   XRAI Glass — Для глухих і слабочуючих
--   Captify — Для глухих і слабочуючих
--   Voiceitt — Мовлення та альтернативна комунікація
--   Proloquo2Go — Мовлення та альтернативна комунікація
--   Proloquo4Text — Мовлення та альтернативна комунікація
--   TD Snap — Мовлення та альтернативна комунікація
--   Avaz AAC — Мовлення та альтернативна комунікація
--   CoughDrop — Мовлення та альтернативна комунікація
--   Cboard — Мовлення та альтернативна комунікація
--   Spoken AAC — Мовлення та альтернативна комунікація
--   Acapela My-Own-Voice — Мовлення та альтернативна комунікація
--   Speech Assistant AAC — Мовлення та альтернативна комунікація
--   NaturalReader — Читання та нейровідмінності
--   Read&Write — Читання та нейровідмінності
--   Helperbird — Читання та нейровідмінності
--   Goblin Tools — Читання та нейровідмінності
--   Tiimo — Читання та нейровідмінності
--   Inflow — Читання та нейровідмінності
--   Bionic Reading — Читання та нейровідмінності
--   BeeLine Reader — Читання та нейровідмінності
--   Ghotit — Читання та нейровідмінності
--   Talon Voice — Керування без рук
--   Voice Access — Керування без рук
--   Enable Viacam (eViacam) — Керування без рук
--   Smyle Mouse — Керування без рук
--   Tecla — Керування без рук
--   GlassOuse — Керування без рук
--   Tobii Dynavox — Керування без рук
--   axe DevTools — Цифрова доступність для бізнесу
--   Stark — Цифрова доступність для бізнесу
--   WAVE (WebAIM) — Цифрова доступність для бізнесу
--   AudioEye — Цифрова доступність для бізнесу
--   UserWay — Цифрова доступність для бізнесу
--   accessiBe — Цифрова доступність для бізнесу
--   Evinced — Цифрова доступність для бізнесу
--   Level Access — Цифрова доступність для бізнесу
--   Siteimprove Accessibility — Цифрова доступність для бізнесу
--   Fable — Цифрова доступність для бізнесу
--   Pope Tech — Цифрова доступність для бізнесу
--   Silktide — Цифрова доступність для бізнесу
--   Equally AI — Цифрова доступність для бізнесу
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
INSERT INTO `categories` (`name`, `name_en`, `slug`) SELECT 'Доступність', 'Accessibility', 'accessibility' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `categories` WHERE `slug` = 'accessibility');
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'accessibility' LIMIT 1);
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Для незрячих і слабозорих', 'Blind & Low Vision', 'blind-low-vision' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'blind-low-vision');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Для глухих і слабочуючих', 'Deaf & Hard of Hearing', 'deaf-hard-of-hearing' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'deaf-hard-of-hearing');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Мовлення та альтернативна комунікація', 'Speech & AAC', 'speech-aac' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'speech-aac');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Читання та нейровідмінності', 'Reading & Neurodiversity', 'reading-neurodiversity' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'reading-neurodiversity');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Керування без рук', 'Hands-free Access', 'hands-free' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hands-free');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Цифрова доступність для бізнесу', 'Digital Accessibility for Business', 'digital-accessibility' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'digital-accessibility');

-- =================== Для незрячих і слабозорих ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'blind-low-vision' LIMIT 1);

-- Be My Eyes — Для незрячих і слабозорих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bemyeyes.com' OR LOWER(`name`) = 'be my eyes')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Be My Eyes', NULL, 'https://www.bemyeyes.com', NULL, NULL, 'Застосунок, що з’єднує незрячих і слабозорих людей із волонтерами та AI-помічником Be My AI через відео з камери.', 'An app that connects blind and low-vision people with volunteers and the Be My AI assistant through live camera video.', 'Be My Eyes дає змогу навести камеру смартфона на предмет, документ чи екран і отримати допомогу: від волонтера з усього світу через відеодзвінок або від вбудованого AI-помічника Be My AI, який описує зображення. Дзвінки безкоштовні й без обмежень, волонтер чує лише ваш голос і бачить те, що показує камера. Є версія для комп’ютера, підтримка смарт-окулярів і довідник служб підтримки компаній.', 'Be My Eyes lets you point your phone camera at an object, document or screen and get help: from a volunteer anywhere in the world via video call, or from the built-in Be My AI assistant that describes images. Calls are free and unlimited, and volunteers only hear your voice and see what your camera shows. There is a desktop version, smart-glasses support and a directory of company support services.', 'Відеодзвінки волонтерам 24/7
AI-опис зображень Be My AI
Версія для комп’ютера та смарт-окулярів
Довідник служб підтримки компаній', '24/7 video calls to volunteers
Be My AI image descriptions
Desktop and smart-glasses versions
Directory of company support services', 'Незрячим і слабозорим людям, а також волонтерам, які хочуть допомагати.', 'Blind and low-vision people, and volunteers who want to help.', 'mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bemyeyes.com' OR LOWER(`name`) = 'be my eyes') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app that connects blind and low-vision people with volunteers and the Be My AI assistant through live camera video.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Be My Eyes lets you point your phone camera at an object, document or screen and get help: from a volunteer anywhere in the world via video call, or from the built-in Be My AI assistant that describes images. Calls are free and unlimited, and volunteers only hear your voice and see what your camera shows. There is a desktop version, smart-glasses support and a directory of company support services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '24/7 video calls to volunteers
Be My AI image descriptions
Desktop and smart-glasses versions
Directory of company support services', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Blind and low-vision people, and volunteers who want to help.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Seeing AI — Для незрячих і слабозорих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'seeingai.com' OR LOWER(`name`) = 'seeing ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Seeing AI', NULL, 'https://www.seeingai.com', NULL, NULL, 'Безкоштовний застосунок Microsoft, який озвучує текст, документи, товари, людей і сцени навколо.', 'A free Microsoft app that reads aloud text, documents, products, people and scenes around you.', 'Seeing AI — дослідницький проєкт Microsoft, створений разом зі спільнотою незрячих і слабозорих людей. Застосунок через камеру смартфона читає короткий текст і цілі документи, описує фото та сцени, розпізнає товари за штрихкодом, допомагає з повсякденними завданнями. Розповсюджується безкоштовно.', 'Seeing AI is a Microsoft research project built with the blind and low-vision community. Using the phone camera, the app reads short text and whole documents, describes photos and scenes, recognizes products by barcode and helps with everyday tasks. It is free.', 'Читання тексту й документів
Опис фото та сцен
Розпізнавання товарів за штрихкодом
Створено разом зі спільнотою незрячих', 'Reading text and documents
Photo and scene descriptions
Product recognition by barcode
Built with the blind community', 'Незрячим і слабозорим користувачам смартфонів.', 'Blind and low-vision smartphone users.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'seeingai.com' OR LOWER(`name`) = 'seeing ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free Microsoft app that reads aloud text, documents, products, people and scenes around you.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Seeing AI is a Microsoft research project built with the blind and low-vision community. Using the phone camera, the app reads short text and whole documents, describes photos and scenes, recognizes products by barcode and helps with everyday tasks. It is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Reading text and documents
Photo and scene descriptions
Product recognition by barcode
Built with the blind community', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Blind and low-vision smartphone users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Envision — Для незрячих і слабозорих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'letsenvision.com' OR LOWER(`name`) = 'envision')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Envision', NULL, 'https://www.letsenvision.com', NULL, NULL, 'Застосунок і смарт-окуляри, що озвучують текст понад 60 мовами, описують оточення й об’єкти.', 'An app and smart glasses that read text in 60+ languages and describe surroundings and objects.', 'Envision створює асистивні рішення для людей із порушеннями зору: безкоштовний застосунок Envision App, AI-помічника Ally (читає друкований текст, описує сцени, сканує документи, шукає в інтернеті) і смарт-окуляри Envision Glasses та Ally Solos Glasses для доступу до візуальної інформації без рук. Окуляри підтримують відеодзвінки знайомим через Envision Companion.', 'Envision builds assistive solutions for people with visual impairments: the free Envision App, the Ally AI assistant (reads print, describes scenes, scans documents, searches the web) and Envision Glasses and Ally Solos Glasses for hands-free access to visual information. The glasses support video calls to trusted contacts via Envision Companion.', 'Читання тексту понад 60 мовами, зокрема рукописного
AI-помічник Ally
Смарт-окуляри без рук
Відеодзвінки знайомим', 'Text reading in 60+ languages, including handwriting
Ally AI assistant
Hands-free smart glasses
Video calls to trusted contacts', 'Незрячим і слабозорим людям, організаціям, що їх підтримують.', 'Blind and low-vision people and organizations that support them.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'letsenvision.com' OR LOWER(`name`) = 'envision') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app and smart glasses that read text in 60+ languages and describe surroundings and objects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Envision builds assistive solutions for people with visual impairments: the free Envision App, the Ally AI assistant (reads print, describes scenes, scans documents, searches the web) and Envision Glasses and Ally Solos Glasses for hands-free access to visual information. The glasses support video calls to trusted contacts via Envision Companion.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Text reading in 60+ languages, including handwriting
Ally AI assistant
Hands-free smart glasses
Video calls to trusted contacts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Blind and low-vision people and organizations that support them.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Aira — Для незрячих і слабозорих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aira.io' OR LOWER(`name`) = 'aira')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Aira', NULL, 'https://aira.io', NULL, NULL, 'Відеоінтерпретація на вимогу: професійні візуальні інтерпретатори для незрячих і перекладачі ASL для глухих.', 'On-demand video interpreting: professional visual interpreters for blind users and ASL interpreters for Deaf users.', 'Aira пропонує два застосунки: Aira Explorer з’єднує незрячих і слабозорих людей із професійними візуальними інтерпретаторами, які описують те, що бачить камера; Aira ASL дає віддалений переклад американською жестовою мовою з опційними субтитрами. Організації-партнери оплачують доступ для своїх працівників, студентів і клієнтів, тож у тисячах локацій сервіс безкоштовний для користувача.', 'Aira offers two apps: Aira Explorer connects blind and low-vision people with professional visual interpreters who describe what the camera sees; Aira ASL provides remote American Sign Language interpreting with optional live captions. Partner organizations pay for access for their employees, students and customers, so the service is free to users at thousands of locations.', 'Професійні візуальні інтерпретатори
Переклад жестовою мовою ASL
Безкоштовно в локаціях партнерів
Підтримка смарт-окулярів', 'Professional visual interpreters
ASL interpreting
Free at partner locations
Smart-glasses support', 'Незрячим і слабозорим людям, глухим користувачам ASL, організаціям.', 'Blind and low-vision people, Deaf ASL users and organizations.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aira.io' OR LOWER(`name`) = 'aira') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'On-demand video interpreting: professional visual interpreters for blind users and ASL interpreters for Deaf users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Aira offers two apps: Aira Explorer connects blind and low-vision people with professional visual interpreters who describe what the camera sees; Aira ASL provides remote American Sign Language interpreting with optional live captions. Partner organizations pay for access for their employees, students and customers, so the service is free to users at thousands of locations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Professional visual interpreters
ASL interpreting
Free at partner locations
Smart-glasses support', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Blind and low-vision people, Deaf ASL users and organizations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Google Lookout — Для незрячих і слабозорих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.google.android.apps.accessibility.reveal' OR LOWER(`name`) = 'google lookout')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Google Lookout', NULL, 'https://play.google.com/store/apps/details?id=com.google.android.apps.accessibility.reveal', NULL, NULL, 'Візуальний помічник Google для Android: текст, документи, банкноти, етикетки продуктів і пошук предметів.', 'Google’s visual assistant for Android: text, documents, banknotes, food labels and finding objects.', 'Lookout використовує комп’ютерний зір і генеративний AI, щоб допомагати людям зі слабким зором або без зору. Сім режимів: текст, документи (понад 30 мов, зокрема рукопис), огляд оточення, банкноти (долар, євро, рупія), етикетки продуктів, пошук предметів (двері, чашки, транспорт) із напрямком і відстанню та опис зображень із запитаннями до них.', 'Lookout uses computer vision and generative AI to help people with low vision or blindness. Seven modes: text, documents (30+ languages, including handwriting), exploring surroundings, currency (US dollar, euro, Indian rupee), food labels, finding objects (doors, cups, vehicles) with direction and distance, and image descriptions you can ask questions about.', 'Сім режимів розпізнавання
Документи понад 30 мовами
Пошук предметів із відстанню
Запитання до зображень', 'Seven recognition modes
Documents in 30+ languages
Object finding with distance
Ask questions about images', 'Користувачам Android зі слабким зором або без зору.', 'Android users with low vision or blindness.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.google.android.apps.accessibility.reveal' OR LOWER(`name`) = 'google lookout') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Google’s visual assistant for Android: text, documents, banknotes, food labels and finding objects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Lookout uses computer vision and generative AI to help people with low vision or blindness. Seven modes: text, documents (30+ languages, including handwriting), exploring surroundings, currency (US dollar, euro, Indian rupee), food labels, finding objects (doors, cups, vehicles) with direction and distance, and image descriptions you can ask questions about.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Seven recognition modes
Documents in 30+ languages
Object finding with distance
Ask questions about images', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Android users with low vision or blindness.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TapTapSee — Для незрячих і слабозорих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'taptapseeapp.com' OR LOWER(`name`) = 'taptapsee')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TapTapSee', NULL, 'https://taptapseeapp.com', NULL, NULL, 'Камера-застосунок, що фотографує або знімає коротке відео й озвучує, що на ньому, через VoiceOver.', 'A camera app that takes a photo or short video and speaks aloud what it shows via VoiceOver.', 'TapTapSee створено спеціально для незрячих і слабозорих людей. Подвійний дотик праворуч робить фото, ліворуч — відео до 10 секунд; застосунок розпізнає об’єкт під будь-яким кутом, а VoiceOver озвучує результат. Можна повторити останнє розпізнавання, завантажити фото з галереї й поділитися результатом.', 'TapTapSee is designed for blind and visually impaired people. Double-tap the right side to take a photo, the left side for a video of up to 10 seconds; the app identifies the object at any angle and VoiceOver speaks the result. You can repeat the last identification, upload photos from the camera roll and share results.', 'Розпізнавання фото й відео до 10 с
Озвучення через VoiceOver
Завантаження з галереї
Повтор останнього результату', 'Photo and up-to-10s video recognition
Results spoken via VoiceOver
Upload from camera roll
Repeat the last result', 'Незрячим і слабозорим власникам iPhone та Android.', 'Blind and low-vision iPhone and Android owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'taptapseeapp.com' OR LOWER(`name`) = 'taptapsee') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A camera app that takes a photo or short video and speaks aloud what it shows via VoiceOver.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TapTapSee is designed for blind and visually impaired people. Double-tap the right side to take a photo, the left side for a video of up to 10 seconds; the app identifies the object at any angle and VoiceOver speaks the result. You can repeat the last identification, upload photos from the camera roll and share results.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Photo and up-to-10s video recognition
Results spoken via VoiceOver
Upload from camera roll
Repeat the last result', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Blind and low-vision iPhone and Android owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Cash Reader — Для незрячих і слабозорих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cashreader.app/en' OR LOWER(`name`) = 'cash reader')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Cash Reader', NULL, 'https://cashreader.app/en/', NULL, NULL, 'Розпізнає банкноти 114 валют і називає номінал голосом або вібрацією, працює офлайн.', 'Recognizes banknotes in 114 currencies and announces the value by voice or vibration, works offline.', 'Cash Reader — застосунок для незрячих і слабозорих людей: наведіть камеру на банкноту, і він назве номінал голосом або рахованими вібраціями (зручно для глухосліпих і в шумних місцях). Розпізнає зім’яті й потерті купюри, вмикає ліхтарик у темряві, конвертує іноземну валюту в домашню. Дані валют завантажуються один раз, далі все працює на пристрої. Безкоштовна версія розпізнає найменші номінали; повна — за підпискою або разовою покупкою.', 'Cash Reader is an app for blind and low-vision people: point the camera at a banknote and it announces the value by voice or countable vibrations (useful for deafblind users and noisy places). It recognizes folded and worn notes, turns on the flashlight in the dark and converts foreign currency to your home currency. Currency data is downloaded once and everything then runs on the device. The free version identifies the lowest denominations; full access is by subscription or lifetime purchase.', '114 валют, мультивалютний режим
Озвучення або вібрація
Повністю офлайн
Конвертація валют для подорожей', '114 currencies, multi-currency mode
Voice or vibration output
Fully offline
Currency conversion for travel', 'Незрячим, слабозорим і глухосліпим людям, мандрівникам.', 'Blind, low-vision and deafblind people, travelers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cashreader.app/en' OR LOWER(`name`) = 'cash reader') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Recognizes banknotes in 114 currencies and announces the value by voice or vibration, works offline.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Cash Reader is an app for blind and low-vision people: point the camera at a banknote and it announces the value by voice or countable vibrations (useful for deafblind users and noisy places). It recognizes folded and worn notes, turns on the flashlight in the dark and converts foreign currency to your home currency. Currency data is downloaded once and everything then runs on the device. The free version identifies the lowest denominations; full access is by subscription or lifetime purchase.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '114 currencies, multi-currency mode
Voice or vibration output
Fully offline
Currency conversion for travel', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Blind, low-vision and deafblind people, travelers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- NVDA — Для незрячих і слабозорих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nvaccess.org/about-nvda' OR LOWER(`name`) = 'nvda')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NVDA', NULL, 'https://www.nvaccess.org/about-nvda/', NULL, NULL, 'Безкоштовна програма екранного доступу для Windows з відкритим кодом від NV Access.', 'A free, open-source screen reader for Windows from NV Access.', 'NVDA (NonVisual Desktop Access) — програма екранного доступу для Windows, яку розробляють незрячі розробники з NV Access. Вона безкоштовна у всьому світі, швидко встановлюється, може працювати з USB-флешки на чужому комп’ютері, доступна багатьма мовами й розширюється доповненнями спільноти.', 'NVDA (NonVisual Desktop Access) is a Windows screen reader developed by blind developers at NV Access. It is free worldwide, installs quickly, can run from a USB stick on another computer, is available in many languages and is extended by community add-ons.', 'Безкоштовно й з відкритим кодом
Портативна версія на USB
Багато мов інтерфейсу
Доповнення від спільноти', 'Free and open source
Portable USB version
Many interface languages
Community add-ons', 'Незрячим і слабозорим користувачам Windows, тестувальникам доступності.', 'Blind and low-vision Windows users, accessibility testers.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nvaccess.org/about-nvda' OR LOWER(`name`) = 'nvda') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free, open-source screen reader for Windows from NV Access.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NVDA (NonVisual Desktop Access) is a Windows screen reader developed by blind developers at NV Access. It is free worldwide, installs quickly, can run from a USB stick on another computer, is available in many languages and is extended by community add-ons.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free and open source
Portable USB version
Many interface languages
Community add-ons', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Blind and low-vision Windows users, accessibility testers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- JAWS — Для незрячих і слабозорих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vispero.com/jaws-screen-reader-software' OR LOWER(`name`) = 'jaws')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'JAWS', NULL, 'https://vispero.com/jaws-screen-reader-software/', NULL, NULL, 'Комерційна програма екранного доступу для Windows із мовленням і шрифтом Брайля від Vispero.', 'A commercial Windows screen reader with speech and Braille output from Vispero.', 'JAWS (Job Access With Speech) — програма екранного доступу для Windows від компанії Vispero (раніше Freedom Scientific). Озвучує вміст екрана й виводить його на брайлівські дисплеї, підтримує робочі, навчальні й домашні застосунки, має корпоративне ліцензування та регулярні оновлення.', 'JAWS (Job Access With Speech) is a Windows screen reader from Vispero (formerly Freedom Scientific). It speaks screen content and outputs it to Braille displays, supports work, school and home applications, and offers enterprise licensing and regular updates.', 'Мовлення та вивід на брайлівський дисплей
Підтримка робочих застосунків
Корпоративне ліцензування
Регулярні оновлення', 'Speech and Braille display output
Support for work applications
Enterprise licensing
Regular updates', 'Незрячим користувачам Windows, роботодавцям, освітнім закладам.', 'Blind Windows users, employers and educational institutions.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vispero.com/jaws-screen-reader-software' OR LOWER(`name`) = 'jaws') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A commercial Windows screen reader with speech and Braille output from Vispero.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'JAWS (Job Access With Speech) is a Windows screen reader from Vispero (formerly Freedom Scientific). It speaks screen content and outputs it to Braille displays, supports work, school and home applications, and offers enterprise licensing and regular updates.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Speech and Braille display output
Support for work applications
Enterprise licensing
Regular updates', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Blind Windows users, employers and educational institutions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ZoomText — Для незрячих і слабозорих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vispero.com/zoomtext-screen-magnifier-software' OR LOWER(`name`) = 'zoomtext')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ZoomText', NULL, 'https://vispero.com/zoomtext-screen-magnifier-software/', NULL, NULL, 'Екранна лупа для Windows від Vispero: збільшення, чіткі шрифти, кольорові схеми й озвучення.', 'A Windows screen magnifier from Vispero: magnification, crisp fonts, color schemes and speech.', 'ZoomText збільшує й покращує текст на екрані для людей зі слабким зором: плавне панорамування, відстеження фокусу, технологія чітких шрифтів xFont, налаштовувані кольори для меншого навантаження на очі. Працює в браузерах, PDF і робочих програмах, має корпоративне ліцензування.', 'ZoomText enlarges and enhances on-screen text for people with low vision: smooth panning, focus tracking, xFont crisp-text technology and custom colors to reduce eye strain. It works across browsers, PDFs and business applications and offers enterprise licensing.', 'Збільшення з плавним панорамуванням
Чіткі шрифти xFont
Налаштовувані кольори
Корпоративне розгортання', 'Magnification with smooth panning
xFont crisp text
Custom color schemes
Enterprise deployment', 'Людям зі слабким зором, які працюють за комп’ютером.', 'People with low vision who work on a computer.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vispero.com/zoomtext-screen-magnifier-software' OR LOWER(`name`) = 'zoomtext') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Windows screen magnifier from Vispero: magnification, crisp fonts, color schemes and speech.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ZoomText enlarges and enhances on-screen text for people with low vision: smooth panning, focus tracking, xFont crisp-text technology and custom colors to reduce eye strain. It works across browsers, PDFs and business applications and offers enterprise licensing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Magnification with smooth panning
xFont crisp text
Custom color schemes
Enterprise deployment', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with low vision who work on a computer.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- BlindSquare — Для незрячих і слабозорих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'blindsquare.com' OR LOWER(`name`) = 'blindsquare')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BlindSquare', NULL, 'https://www.blindsquare.com', NULL, NULL, 'Доступна GPS-навігація для незрячих, глухосліпих і слабозорих: точки інтересу й перехрестя голосом.', 'Accessible GPS navigation for blind, deafblind and partially sighted people: points of interest and intersections by voice.', 'BlindSquare — самоозвучуваний навігаційний застосунок, створений для незрячих, глухосліпих і слабозорих людей. Він розповідає про точки інтересу й перехрестя поруч, працює разом зі сторонніми навігаторами та підтримує навігацію всередині приміщень. Для Android є застосунок XploreNinja на тій самій технології.', 'BlindSquare is a self-voicing navigation app built for blind, deafblind and partially sighted people. It describes nearby points of interest and intersections, works together with third-party navigation apps and supports indoor navigation. For Android there is XploreNinja, built on the same technology.', 'Озвучення точок інтересу й перехресть
Робота з іншими навігаторами
Навігація в приміщеннях
Android-версія XploreNinja', 'Spoken points of interest and intersections
Works with other navigation apps
Indoor navigation
XploreNinja for Android', 'Незрячим, глухосліпим і слабозорим пішоходам.', 'Blind, deafblind and partially sighted pedestrians.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'blindsquare.com' OR LOWER(`name`) = 'blindsquare') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Accessible GPS navigation for blind, deafblind and partially sighted people: points of interest and intersections by voice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'BlindSquare is a self-voicing navigation app built for blind, deafblind and partially sighted people. It describes nearby points of interest and intersections, works together with third-party navigation apps and supports indoor navigation. For Android there is XploreNinja, built on the same technology.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Spoken points of interest and intersections
Works with other navigation apps
Indoor navigation
XploreNinja for Android', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Blind, deafblind and partially sighted pedestrians.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Lazarillo — Для незрячих і слабозорих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lazarillo.app' OR LOWER(`name`) = 'lazarillo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lazarillo', NULL, 'https://lazarillo.app', NULL, NULL, 'Безкоштовний застосунок інклюзивної навігації та цифрові карти приміщень для бізнесу й міст.', 'A free inclusive navigation app plus indoor digital maps for businesses and cities.', 'Lazarillo має безкоштовний мобільний застосунок із покроковими голосовими підказками для людей з інвалідністю, зокрема з порушеннями зору. Для бізнесу, міст і організацій компанія створює інтерактивні карти приміщень і територій, які вбудовуються на сайт, у застосунок чи кіоски; навігація всередині працює з bluetooth-маячками, 3D-скануванням або 5G.', 'Lazarillo offers a free mobile app with turn-by-turn audio guidance for people with disabilities, including visual impairments. For businesses, cities and organizations it builds interactive indoor and outdoor maps that embed into websites, apps or kiosks; indoor navigation works with Bluetooth beacons, 3D scanning or 5G.', 'Покрокові голосові підказки
Карти приміщень для організацій
Вбудовування на сайт і кіоски
Bluetooth-маячки та 3D-сканування', 'Turn-by-turn audio guidance
Indoor maps for organizations
Embedding in websites and kiosks
Bluetooth beacons and 3D scanning', 'Людям із порушеннями зору; торговим центрам, університетам, містам.', 'People with visual impairments; malls, universities and cities.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lazarillo.app' OR LOWER(`name`) = 'lazarillo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free inclusive navigation app plus indoor digital maps for businesses and cities.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Lazarillo offers a free mobile app with turn-by-turn audio guidance for people with disabilities, including visual impairments. For businesses, cities and organizations it builds interactive indoor and outdoor maps that embed into websites, apps or kiosks; indoor navigation works with Bluetooth beacons, 3D scanning or 5G.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Turn-by-turn audio guidance
Indoor maps for organizations
Embedding in websites and kiosks
Bluetooth beacons and 3D scanning', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with visual impairments; malls, universities and cities.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- WeWALK Smart Cane — Для незрячих і слабозорих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wewalk.io/en' OR LOWER(`name`) = 'wewalk smart cane')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'WeWALK Smart Cane', NULL, 'https://wewalk.io/en/', NULL, NULL, 'Розумна тростина з виявленням перешкод на рівні грудей, голосовою навігацією та AI-помічником.', 'A smart cane with chest-height obstacle detection, voice navigation and an AI assistant.', 'WeWALK Smart Cane 2 поєднує звичайну білу тростину з електронікою: виявлення перешкод на рівні грудей, покрокова голосова навігація, вбудований голосовий помічник і керування застосунком кнопками на ручці без телефона в руці. Сервіс WeASSIST з’єднує з навченими операторами для візуальної допомоги, а платформа AIM допомагає опанувати техніку користування тростиною.', 'WeWALK Smart Cane 2 combines a traditional white cane with electronics: chest-height obstacle detection, turn-by-turn voice navigation, a built-in voice assistant and button controls on the handle so you do not have to hold your phone. The WeASSIST service connects you to trained agents for visual assistance, and the AIM platform helps learn cane techniques.', 'Виявлення перешкод на рівні грудей
Голосова навігація
Керування кнопками на ручці
Візуальна допомога WeASSIST', 'Chest-height obstacle detection
Voice navigation
Button controls on the handle
WeASSIST visual assistance', 'Незрячим і слабозорим людям, які користуються тростиною.', 'Blind and partially sighted cane users.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wewalk.io/en' OR LOWER(`name`) = 'wewalk smart cane') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A smart cane with chest-height obstacle detection, voice navigation and an AI assistant.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'WeWALK Smart Cane 2 combines a traditional white cane with electronics: chest-height obstacle detection, turn-by-turn voice navigation, a built-in voice assistant and button controls on the handle so you do not have to hold your phone. The WeASSIST service connects you to trained agents for visual assistance, and the AIM platform helps learn cane techniques.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Chest-height obstacle detection
Voice navigation
Button controls on the handle
WeASSIST visual assistance', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Blind and partially sighted cane users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Glidance Glide — Для незрячих і слабозорих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'glidance.io' OR LOWER(`name`) = 'glidance glide')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Glidance Glide', NULL, 'https://glidance.io', NULL, NULL, 'Розумний засіб пересування на двох колесах: веде в обхід перешкод і описує оточення.', 'A smart two-wheeled mobility aid that steers around obstacles and describes the surroundings.', 'Glide від Glidance — засіб пересування для людей, які не бачать або мають слабкий зір, як альтернатива тростині чи собаці-поводирю. Пристрій має два всюдихідні колеса й телескопічну ручку: людина підштовхує його вперед, а Glide сам обирає напрямок, обходить перешкоди, описує оточення й важливі об’єкти.', 'Glide by Glidance is a mobility aid for people who are blind or have low vision, offered as an alternative to a cane or guide dog. It has two all-terrain wheels and a telescoping handle: you nudge it forward and Glide steers, avoids obstacles and describes the surroundings and key landmarks.', 'Автоматичний обхід перешкод
Опис оточення під час руху
Всюдихідні колеса
Телескопічна ручка', 'Automatic obstacle avoidance
Surroundings described on the move
All-terrain wheels
Telescoping handle', 'Незрячим і слабозорим людям, які шукають новий засіб пересування.', 'Blind and low-vision people looking for a new mobility aid.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'glidance.io' OR LOWER(`name`) = 'glidance glide') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A smart two-wheeled mobility aid that steers around obstacles and describes the surroundings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Glide by Glidance is a mobility aid for people who are blind or have low vision, offered as an alternative to a cane or guide dog. It has two all-terrain wheels and a telescoping handle: you nudge it forward and Glide steers, avoids obstacles and describes the surroundings and key landmarks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automatic obstacle avoidance
Surroundings described on the move
All-terrain wheels
Telescoping handle', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Blind and low-vision people looking for a new mobility aid.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Voice Dream Reader — Для незрячих і слабозорих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'voicedream.com' OR LOWER(`name`) = 'voice dream reader')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Voice Dream Reader', NULL, 'https://www.voicedream.com', NULL, NULL, 'Читання вголос PDF, EPUB, документів і вебсторінок синтезом мовлення на iPhone, iPad і Mac.', 'Text-to-speech reading of PDFs, EPUBs, documents and web pages on iPhone, iPad and Mac.', 'Voice Dream Reader перетворює PDF, EPUB, Word, PowerPoint, вебсторінки й книги на аудіо. Можна обирати голос, швидкість і вимову, виділяти фрагменти й робити нотатки, слухати офлайн і синхронізувати між iPhone, iPad і Mac. Застосунок повністю працює з VoiceOver, підтримує голосове керування та брайлівські дисплеї. Є пробний період.', 'Voice Dream Reader turns PDFs, EPUBs, Word and PowerPoint files, web pages and books into audio. You can choose the voice, speed and pronunciation, highlight passages and take notes, listen offline and sync across iPhone, iPad and Mac. The app fully supports VoiceOver, voice control and Braille displays. A free trial is available.', 'Читання PDF, EPUB, Word і вебсторінок
Вибір голосу й швидкості
Повна підтримка VoiceOver і Брайля
Офлайн і синхронізація', 'Reads PDFs, EPUBs, Word and web pages
Voice and speed choice
Full VoiceOver and Braille support
Offline and sync', 'Незрячим і слабозорим людям, людям із дислексією, усім, хто любить слухати тексти.', 'Blind and low-vision people, people with dyslexia and anyone who prefers listening.', 'mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'voicedream.com' OR LOWER(`name`) = 'voice dream reader') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Text-to-speech reading of PDFs, EPUBs, documents and web pages on iPhone, iPad and Mac.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Voice Dream Reader turns PDFs, EPUBs, Word and PowerPoint files, web pages and books into audio. You can choose the voice, speed and pronunciation, highlight passages and take notes, listen offline and sync across iPhone, iPad and Mac. The app fully supports VoiceOver, voice control and Braille displays. A free trial is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Reads PDFs, EPUBs, Word and web pages
Voice and speed choice
Full VoiceOver and Braille support
Offline and sync', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Blind and low-vision people, people with dyslexia and anyone who prefers listening.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sullivan Plus — Для незрячих і слабозорих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mysullivan.org' OR LOWER(`name`) = 'sullivan plus')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sullivan Plus', NULL, 'https://mysullivan.org', NULL, NULL, 'AI-застосунок для незрячих і слабозорих: розпізнавання тексту, об’єктів, сцен, кольору й освітлення.', 'An AI app for blind and low-vision users: recognizes text, objects, scenes, colors and light.', 'Sullivan Plus через камеру смартфона розпізнає текст (листи, журнали, візитки) і автоматично фотографує, коли бачить текст, описує сцену реченням, називає об’єкти поруч, визначає колір і за допомогою датчика освітленості підказує звуком, наскільки світло в приміщенні.', 'Using the phone camera, Sullivan Plus recognizes text (letters, magazines, business cards) and automatically takes a photo when it detects text, describes a scene in a sentence, names nearby objects, identifies colors and uses the light sensor to signal brightness with sound.', 'Автоматичне розпізнавання тексту
Опис сцени реченням
Визначення кольору
Сигнал рівня освітлення', 'Automatic text recognition
Scene description in a sentence
Color detection
Light level signal', 'Незрячим і слабозорим людям.', 'Blind and low-vision people.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mysullivan.org' OR LOWER(`name`) = 'sullivan plus') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI app for blind and low-vision users: recognizes text, objects, scenes, colors and light.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Using the phone camera, Sullivan Plus recognizes text (letters, magazines, business cards) and automatically takes a photo when it detects text, describes a scene in a sentence, names nearby objects, identifies colors and uses the light sensor to signal brightness with sound.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automatic text recognition
Scene description in a sentence
Color detection
Light level signal', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Blind and low-vision people.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Для глухих і слабочуючих ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'deaf-hard-of-hearing' LIMIT 1);

-- Ava — Для глухих і слабочуючих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ava.me' OR LOWER(`name`) = 'ava')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ava', NULL, 'https://www.ava.me', NULL, NULL, 'Субтитри в реальному часі для глухих і слабочуючих: AI-транскрипція та професійні стенографісти Scribe.', 'Real-time captions for Deaf and hard-of-hearing people: AI transcription and professional Scribe captioners.', 'Ava показує субтитри до розмов наживо, на зустрічах і в будь-якій відеоконференції (Ava Connect підключається одним кліком). AI забезпечує швидкість, а професійні стенографісти Ava Scribe — точність для навчання й роботи. Ava зберігає транскрипти й робить підсумок розмови. Є безкоштовний рівень і платні плани для людей та організацій.', 'Ava shows captions for live conversations, meetings and any video conference (Ava Connect joins in one click). AI provides speed, and professional Ava Scribe captioners add accuracy for study and work. Ava stores transcripts and generates conversation summaries. There is a free tier and paid plans for individuals and organizations.', 'Живі субтитри розмов і відеодзвінків
Професійні стенографісти Scribe
Збереження транскриптів і підсумки
Мобільний і настільний застосунок', 'Live captions for conversations and calls
Professional Scribe captioners
Saved transcripts and summaries
Mobile and desktop apps', 'Глухим і слабочуючим людям, університетам і роботодавцям.', 'Deaf and hard-of-hearing people, universities and employers.', 'mobile,desktop,web', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ava.me' OR LOWER(`name`) = 'ava') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Real-time captions for Deaf and hard-of-hearing people: AI transcription and professional Scribe captioners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ava shows captions for live conversations, meetings and any video conference (Ava Connect joins in one click). AI provides speed, and professional Ava Scribe captioners add accuracy for study and work. Ava stores transcripts and generates conversation summaries. There is a free tier and paid plans for individuals and organizations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live captions for conversations and calls
Professional Scribe captioners
Saved transcripts and summaries
Mobile and desktop apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Deaf and hard-of-hearing people, universities and employers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Live Transcribe & Sound Notifications — Для глухих і слабочуючих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.google.audio.hearing.visualization.accessibility.scribe' OR LOWER(`name`) = 'live transcribe & sound notifications')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Live Transcribe & Sound Notifications', NULL, 'https://play.google.com/store/apps/details?id=com.google.audio.hearing.visualization.accessibility.scribe', NULL, NULL, 'Безкоштовний застосунок Google для Android: транскрипція розмов понад 80 мовами та сповіщення про звуки.', 'A free Google app for Android: live transcription in 80+ languages and sound notifications.', 'Live Transcribe & Sound Notifications робить розмови й навколишні звуки доступнішими для глухих і слабочуючих людей. Транскрипція в реальному часі понад 80 мовами й діалектами, власні слова (імена, предмети), вібрація, коли називають ваше ім’я, підтримка зовнішніх мікрофонів, показ тексту на зовнішньому екрані складаних телефонів і сповіщення про важливі звуки (дзвінок у двері, плач дитини, сигналізація).', 'Live Transcribe & Sound Notifications makes conversations and surrounding sounds more accessible for Deaf and hard-of-hearing people. Real-time transcription in 80+ languages and dialects, custom words (names, objects), vibration when someone says your name, external microphone support, transcripts on the outer screen of foldables, and alerts for important sounds (doorbell, baby crying, alarms).', 'Транскрипція понад 80 мовами
Сповіщення про звуки
Вібрація на ваше ім’я
Зовнішні мікрофони', 'Transcription in 80+ languages
Sound notifications
Vibration when your name is said
External microphones', 'Глухим і слабочуючим користувачам Android.', 'Deaf and hard-of-hearing Android users.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.google.audio.hearing.visualization.accessibility.scribe' OR LOWER(`name`) = 'live transcribe & sound notifications') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free Google app for Android: live transcription in 80+ languages and sound notifications.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Live Transcribe & Sound Notifications makes conversations and surrounding sounds more accessible for Deaf and hard-of-hearing people. Real-time transcription in 80+ languages and dialects, custom words (names, objects), vibration when someone says your name, external microphone support, transcripts on the outer screen of foldables, and alerts for important sounds (doorbell, baby crying, alarms).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Transcription in 80+ languages
Sound notifications
Vibration when your name is said
External microphones', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Deaf and hard-of-hearing Android users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Rogervoice — Для глухих і слабочуючих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rogervoice.com' OR LOWER(`name`) = 'rogervoice')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Rogervoice', NULL, 'https://rogervoice.com', NULL, NULL, 'Субтитри до телефонних дзвінків у реальному часі; у США безкоштовно для людей із втратою слуху.', 'Real-time captions for phone calls; free in the US for people with hearing loss.', 'Rogervoice дослівно транскрибує телефонні розмови в реальному часі. Якщо не хочете говорити, можна надрукувати повідомлення — застосунок озвучить його. Голосова пошта перетворюється на текст, розмови шифруються наскрізно. У США сервіс сертифіковано як телефонну ретрансляцію (TRS) і він безкоштовний для людей із втратою слуху; є також французька версія.', 'Rogervoice transcribes phone calls word for word in real time. If you prefer not to speak, type a message and the app voices it. Voicemail is turned into text and calls are end-to-end encrypted. In the US it is certified as a Telephone Relay Service (TRS) and free for people with hearing loss; there is also a French version.', 'Субтитри до дзвінків у реальному часі
Друк замість мовлення
Транскрипція голосової пошти
Наскрізне шифрування', 'Real-time call captions
Type instead of speaking
Voicemail transcription
End-to-end encryption', 'Глухим і слабочуючим людям, які телефонують.', 'Deaf and hard-of-hearing people who make phone calls.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rogervoice.com' OR LOWER(`name`) = 'rogervoice') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Real-time captions for phone calls; free in the US for people with hearing loss.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Rogervoice transcribes phone calls word for word in real time. If you prefer not to speak, type a message and the app voices it. Voicemail is turned into text and calls are end-to-end encrypted. In the US it is certified as a Telephone Relay Service (TRS) and free for people with hearing loss; there is also a French version.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time call captions
Type instead of speaking
Voicemail transcription
End-to-end encryption', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Deaf and hard-of-hearing people who make phone calls.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Rylo (Nagish) — Для глухих і слабочуючих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rylo.com' OR LOWER(`name`) = 'rylo (nagish)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Rylo (Nagish)', NULL, 'https://rylo.com', NULL, NULL, 'Безкоштовні субтитри до дзвінків і жива транскрипція (раніше Nagish), сертифіковано FCC.', 'Free call captions and live transcription (formerly Nagish), FCC certified.', 'Rylo (колишня назва — Nagish) показує текстом усе, що кажуть під час телефонної розмови, і безкоштовний для людей із втратою слуху в США завдяки сертифікації FCC. Можна взяти новий номер або зберегти свій, відповідати голосом чи клавіатурою, використовувати швидкі AI-відповіді. Транскрипти зберігаються лише на пристрої; підтримується понад 50 мов з автовизначенням.', 'Rylo (formerly Nagish) shows as text everything said during a phone call and is free for people with hearing loss in the US thanks to FCC certification. You can get a new number or keep yours, reply by voice or keyboard and use AI quick replies. Transcripts are stored only on the device; 50+ languages are supported with auto-detection.', 'Субтитри до дзвінків
Свій або новий номер
Швидкі AI-відповіді
Транскрипти лише на пристрої', 'Call captions
Keep your number or get a new one
AI quick replies
Transcripts stored on device', 'Глухим і слабочуючим людям у США.', 'Deaf and hard-of-hearing people in the US.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rylo.com' OR LOWER(`name`) = 'rylo (nagish)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free call captions and live transcription (formerly Nagish), FCC certified.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Rylo (formerly Nagish) shows as text everything said during a phone call and is free for people with hearing loss in the US thanks to FCC certification. You can get a new number or keep yours, reply by voice or keyboard and use AI quick replies. Transcripts are stored only on the device; 50+ languages are supported with auto-detection.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Call captions
Keep your number or get a new one
AI quick replies
Transcripts stored on device', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Deaf and hard-of-hearing people in the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- InnoCaption — Для глухих і слабочуючих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'innocaption.com' OR LOWER(`name`) = 'innocaption')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'InnoCaption', NULL, 'https://www.innocaption.com', NULL, NULL, 'Субтитри до телефонних дзвінків: автоматичне розпізнавання або живі стенографісти 24/7, безкоштовно в США.', 'Phone call captions: automatic recognition or live stenographers 24/7, free in the US.', 'InnoCaption — застосунок для субтитрів до дзвінків для глухих і слабочуючих людей. Можна обрати автоматичне розпізнавання мовлення або живих стенографістів і перемикатися навіть під час розмови. Система One Number дозволяє отримувати субтитри для дзвінків на свій звичайний номер. Сервіс сертифікований FCC і безкоштовний для людей із втратою слуху в США.', 'InnoCaption is a call captioning app for Deaf and hard-of-hearing people. You can choose automatic speech recognition or live stenographers and switch even during a call. The One Number System lets calls to your existing number be captioned. The service is FCC certified and free for people with hearing loss in the US.', 'Автоматичні або живі субтитри
Перемикання під час дзвінка
Субтитри на власний номер
Історія транскриптів', 'Automatic or live captions
Switch modes during a call
Captions on your own number
Transcript history', 'Глухим і слабочуючим людям у США.', 'Deaf and hard-of-hearing people in the US.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'innocaption.com' OR LOWER(`name`) = 'innocaption') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Phone call captions: automatic recognition or live stenographers 24/7, free in the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'InnoCaption is a call captioning app for Deaf and hard-of-hearing people. You can choose automatic speech recognition or live stenographers and switch even during a call. The One Number System lets calls to your existing number be captioned. The service is FCC certified and free for people with hearing loss in the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automatic or live captions
Switch modes during a call
Captions on your own number
Transcript history', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Deaf and hard-of-hearing people in the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hand Talk — Для глухих і слабочуючих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'handtalk.me/en' OR LOWER(`name`) = 'hand talk')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hand Talk', NULL, 'https://www.handtalk.me/en/', NULL, NULL, 'Віртуальні перекладачі жестової мови (ASL і бразильська Libras) для сайтів і застосунок для вивчення.', 'Virtual sign language interpreters (ASL and Brazilian Libras) for websites, plus a learning app.', 'Hand Talk перекладає вміст сайтів американською (ASL) і бразильською (Libras) жестовими мовами за допомогою віртуальних 3D-перекладачів. Плагін Hand Talk Plugin додає до сайту також десятки асистивних функцій. Застосунок Hand Talk App допомагає перекладати й вивчати жестову мову в ігровій формі.', 'Hand Talk translates website content into American (ASL) and Brazilian (Libras) sign languages using virtual 3D interpreters. The Hand Talk Plugin also adds dozens of assistive features to a website. The Hand Talk App helps translate and learn sign language in a playful way.', 'Віртуальні перекладачі ASL і Libras
Плагін для сайту з асистивними функціями
Застосунок для вивчення жестової мови', 'Virtual ASL and Libras interpreters
Website plugin with assistive features
Sign language learning app', 'Власникам сайтів і брендам; глухим користувачам; тим, хто вивчає жестову мову.', 'Website owners and brands; Deaf users; sign language learners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'handtalk.me/en' OR LOWER(`name`) = 'hand talk') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Virtual sign language interpreters (ASL and Brazilian Libras) for websites, plus a learning app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hand Talk translates website content into American (ASL) and Brazilian (Libras) sign languages using virtual 3D interpreters. The Hand Talk Plugin also adds dozens of assistive features to a website. The Hand Talk App helps translate and learn sign language in a playful way.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Virtual ASL and Libras interpreters
Website plugin with assistive features
Sign language learning app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Website owners and brands; Deaf users; sign language learners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Signapse — Для глухих і слабочуючих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'signapse.ai' OR LOWER(`name`) = 'signapse')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Signapse', NULL, 'https://www.signapse.ai', NULL, NULL, 'AI-переклад англійського тексту й відео британською (BSL) та американською (ASL) жестовими мовами.', 'AI translation of English text and video into British (BSL) and American (ASL) sign languages.', 'Signapse генерує відео з цифровими перекладачами жестової мови BSL і ASL. SignStudio робить переклад для відеоконтенту, SignStream API — живий переклад для трансляцій, табло й подій (наприклад, оголошень на залізниці), SignStream Chat перетворює набране повідомлення на відео жестовою мовою.', 'Signapse generates videos with digital BSL and ASL signers. SignStudio translates video content, the SignStream API provides live translation for streams, signage and events (such as railway announcements), and SignStream Chat turns a typed message into a sign language video.', 'Цифрові перекладачі BSL і ASL
Переклад відеоконтенту SignStudio
Живий переклад через API
Чат із перекладом жестовою мовою', 'Digital BSL and ASL signers
SignStudio video translation
Live translation via API
Sign language chat', 'Транспортним компаніям, медіа, організаторам подій, бізнесу.', 'Transport companies, media, event organizers and businesses.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'signapse.ai' OR LOWER(`name`) = 'signapse') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI translation of English text and video into British (BSL) and American (ASL) sign languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Signapse generates videos with digital BSL and ASL signers. SignStudio translates video content, the SignStream API provides live translation for streams, signage and events (such as railway announcements), and SignStream Chat turns a typed message into a sign language video.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Digital BSL and ASL signers
SignStudio video translation
Live translation via API
Sign language chat', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Transport companies, media, event organizers and businesses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- XRAI Glass — Для глухих і слабочуючих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'xrai.glass' OR LOWER(`name`) = 'xrai glass')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'XRAI Glass', NULL, 'https://xrai.glass', NULL, NULL, 'Застосунок, що перетворює мовлення на субтитри в реальному часі на телефоні або в смарт-окулярах.', 'An app that turns speech into real-time subtitles on your phone or smart glasses.', 'XRAI Glass показує субтитри до розмов на телефоні або в сумісних AR-окулярах. Переклад понад 300 мовами, розпізнавання хто говорить, одночасна транскрипція до 10 мов, підсумки розмов і запитання до них. Компанія також пропонує окуляри XRAI AR2 і рішення для субтитрів на робочих місцях, концертах і стадіонах.', 'XRAI Glass shows conversation subtitles on your phone or compatible AR glasses. Translation in 300+ languages, speaker identification, simultaneous transcription of up to 10 languages, conversation summaries and Q&A. The company also offers XRAI AR2 glasses and captioning for workplaces, live shows and stadiums.', 'Субтитри на телефоні й в AR-окулярах
Переклад понад 300 мовами
Визначення того, хто говорить
Підсумки розмов', 'Subtitles on phone and AR glasses
Translation in 300+ languages
Speaker identification
Conversation summaries', 'Глухим і слабочуючим людям, організаторам подій, роботодавцям.', 'Deaf and hard-of-hearing people, event organizers and employers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'xrai.glass' OR LOWER(`name`) = 'xrai glass') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app that turns speech into real-time subtitles on your phone or smart glasses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'XRAI Glass shows conversation subtitles on your phone or compatible AR glasses. Translation in 300+ languages, speaker identification, simultaneous transcription of up to 10 languages, conversation summaries and Q&A. The company also offers XRAI AR2 glasses and captioning for workplaces, live shows and stadiums.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Subtitles on phone and AR glasses
Translation in 300+ languages
Speaker identification
Conversation summaries', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Deaf and hard-of-hearing people, event organizers and employers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Captify — Для глухих і слабочуючих
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'captify.glass' OR LOWER(`name`) = 'captify')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Captify', NULL, 'https://captify.glass', NULL, NULL, 'Окуляри з субтитрами для глухих і слабочуючих: розмова з’являється текстом перед очима.', 'Captioning glasses for Deaf and hard-of-hearing people: conversation appears as text in front of your eyes.', 'Captify — окуляри, розроблені спеціально для людей із порушеннями слуху (компанія належить слабочуючим засновникам). Вбудовані мікрофони вловлюють розмову навіть у шумних місцях і показують її текстом у полі зору. Можна замовити лінзи з рецептом, зокрема прогресивні, і з захистом від синього світла.', 'Captify are glasses designed specifically for people with hearing loss (the company is hard-of-hearing owned). Built-in microphones pick up conversation even in noisy places and display it as text in your field of view. Prescription lenses, including progressives, and blue-light protection are available.', 'Субтитри в полі зору
Мікрофони для шумних місць
Лінзи з рецептом
Розроблено для людей із втратою слуху', 'Captions in your field of view
Microphones for noisy places
Prescription lenses
Designed for people with hearing loss', 'Глухим і слабочуючим людям.', 'Deaf and hard-of-hearing people.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'captify.glass' OR LOWER(`name`) = 'captify') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Captioning glasses for Deaf and hard-of-hearing people: conversation appears as text in front of your eyes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Captify are glasses designed specifically for people with hearing loss (the company is hard-of-hearing owned). Built-in microphones pick up conversation even in noisy places and display it as text in your field of view. Prescription lenses, including progressives, and blue-light protection are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Captions in your field of view
Microphones for noisy places
Prescription lenses
Designed for people with hearing loss', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Deaf and hard-of-hearing people.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Мовлення та альтернативна комунікація ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'speech-aac' LIMIT 1);

-- Voiceitt — Мовлення та альтернативна комунікація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'voiceitt.com' OR LOWER(`name`) = 'voiceitt')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Voiceitt', NULL, 'https://www.voiceitt.com', NULL, NULL, 'Розпізнавання нестандартного мовлення: перетворює мовлення людей із дизартрією на текст і голос.', 'Speech recognition for non-standard speech: turns the speech of people with dysarthria into text and voice.', 'Voiceitt розробляє розпізнавання мовлення для людей, чиє мовлення важко розпізнати стандартним системам: після інсульту, з БАС, хворобою Паркінсона, ДЦП та іншими станами. Це вебзастосунок для спілкування з людьми й технікою, розширення для Chrome для диктування та підтримка відеозустрічей; для компаній є API. Пробний період — 30 днів.', 'Voiceitt develops speech recognition for people whose speech standard systems struggle to understand: after stroke, with ALS, Parkinson’s, cerebral palsy and other conditions. It offers a web app for communicating with people and technology, a Chrome extension for dictation and video meeting support; there is an API for companies. A 30-day trial is available.', 'Розпізнавання нестандартного мовлення
Вебзастосунок і розширення для Chrome
Підтримка відеозустрічей
API для компаній', 'Non-standard speech recognition
Web app and Chrome extension
Video meeting support
API for companies', 'Людям із порушеннями мовлення, їхнім близьким і фахівцям.', 'People with speech disabilities, their families and specialists.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'voiceitt.com' OR LOWER(`name`) = 'voiceitt') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Speech recognition for non-standard speech: turns the speech of people with dysarthria into text and voice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Voiceitt develops speech recognition for people whose speech standard systems struggle to understand: after stroke, with ALS, Parkinson’s, cerebral palsy and other conditions. It offers a web app for communicating with people and technology, a Chrome extension for dictation and video meeting support; there is an API for companies. A 30-day trial is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Non-standard speech recognition
Web app and Chrome extension
Video meeting support
API for companies', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with speech disabilities, their families and specialists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Proloquo2Go — Мовлення та альтернативна комунікація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'assistiveware.com/products/proloquo2go' OR LOWER(`name`) = 'proloquo2go')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Proloquo2Go', NULL, 'https://www.assistiveware.com/products/proloquo2go', NULL, NULL, 'Застосунок альтернативної комунікації (AAC) із символами для iPad та iPhone від AssistiveWare.', 'A symbol-based AAC (augmentative and alternative communication) app for iPad and iPhone by AssistiveWare.', 'Proloquo2Go допомагає дітям і дорослим, які не говорять або говорять не завжди, висловлюватися за допомогою символів і синтезованого голосу. Словник налаштовується під людину й розвивається разом із нею; функції спираються на клінічні знання та дослідження користувачів. Застосунок використовують люди з аутизмом, ДЦП, синдромом Дауна тощо.', 'Proloquo2Go helps children and adults who cannot (always) speak express themselves with symbols and a synthesized voice. The vocabulary is personalized and grows with the user; features are based on clinical knowledge and user research. It is used by people with autism, cerebral palsy, Down syndrome and more.', 'Комунікація символами з озвученням
Персоналізований словник
Розвиток мовлення разом із користувачем
Для iPad та iPhone', 'Symbol communication with speech
Personalized vocabulary
Language growth with the user
For iPad and iPhone', 'Людям, які не говорять, їхнім родинам, логопедам і вчителям.', 'Nonspeaking people, their families, speech therapists and teachers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'assistiveware.com/products/proloquo2go' OR LOWER(`name`) = 'proloquo2go') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A symbol-based AAC (augmentative and alternative communication) app for iPad and iPhone by AssistiveWare.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Proloquo2Go helps children and adults who cannot (always) speak express themselves with symbols and a synthesized voice. The vocabulary is personalized and grows with the user; features are based on clinical knowledge and user research. It is used by people with autism, cerebral palsy, Down syndrome and more.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Symbol communication with speech
Personalized vocabulary
Language growth with the user
For iPad and iPhone', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Nonspeaking people, their families, speech therapists and teachers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Proloquo4Text — Мовлення та альтернативна комунікація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'assistiveware.com/products/proloquo4text' OR LOWER(`name`) = 'proloquo4text')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Proloquo4Text', NULL, 'https://www.assistiveware.com/products/proloquo4text', NULL, NULL, 'Текстовий AAC-застосунок для iOS: набираєте фразу — він її озвучує, з передбаченням наступних слів.', 'A text-based AAC app for iOS: type a phrase and it speaks it, with next-word prediction.', 'Proloquo4Text призначений для дітей, підлітків і дорослих, які вміють писати, але не можуть (завжди) говорити. Набраний текст озвучується синтезованим голосом, а передбачення вчиться на ваших фразах і пропонує наступні слова. Усе потрібне — на одному екрані; застосунок використовують люди з аутизмом, ДЦП, БАС та іншими станами.', 'Proloquo4Text is for children, teens and adults who can write but cannot (always) speak. Typed text is spoken with a synthesized voice, and prediction learns from your phrases to suggest the next words. Everything is on a single screen; it is used by people with autism, cerebral palsy, ALS and other conditions.', 'Озвучення набраного тексту
Передбачення наступних слів
Одноекранний інтерфейс
Налаштування доступності', 'Typed text spoken aloud
Next-word prediction
Single-screen layout
Accessibility settings', 'Людям, які пишуть, але не можуть говорити.', 'People who can write but cannot speak.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'assistiveware.com/products/proloquo4text' OR LOWER(`name`) = 'proloquo4text') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A text-based AAC app for iOS: type a phrase and it speaks it, with next-word prediction.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Proloquo4Text is for children, teens and adults who can write but cannot (always) speak. Typed text is spoken with a synthesized voice, and prediction learns from your phrases to suggest the next words. Everything is on a single screen; it is used by people with autism, cerebral palsy, ALS and other conditions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Typed text spoken aloud
Next-word prediction
Single-screen layout
Accessibility settings', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who can write but cannot speak.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TD Snap — Мовлення та альтернативна комунікація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'us.tobiidynavox.com/pages/td-snap' OR LOWER(`name`) = 'td snap')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TD Snap', NULL, 'https://us.tobiidynavox.com/pages/td-snap', NULL, NULL, 'AAC-платформа Tobii Dynavox із наборами сторінок для керування поглядом, дотиком або перемикачами.', 'Tobii Dynavox AAC platform with page sets for eye gaze, touch or switch access.', 'TD Snap — програма для людей із порушеннями мовлення та мови. Вона має кілька наборів сторінок: із символами для розвитку мовлення й грамотності, з тематичними фразами, текстовий для тих, хто читає. Усі набори працюють із керуванням поглядом, дотиком і перемикачами, тож підходять і людям з обмеженою рухливістю.', 'TD Snap is software for people with speech and language disabilities. It offers several page sets: symbol-supported ones for language and literacy development, topic-based phrases and a text-based set for literate users. All page sets work with eye gaze, touch and switch access, so they also suit people with limited mobility.', 'Кілька наборів сторінок
Керування поглядом, дотиком, перемикачами
Підтримка розвитку грамотності
Інструменти для фахівців і родин', 'Multiple page sets
Eye gaze, touch and switch access
Literacy development support
Tools for professionals and families', 'Людям з аутизмом, ДЦП та іншими порушеннями мовлення; фахівцям і родинам.', 'People with autism, cerebral palsy and other speech disabilities; professionals and families.', 'mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'us.tobiidynavox.com/pages/td-snap' OR LOWER(`name`) = 'td snap') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tobii Dynavox AAC platform with page sets for eye gaze, touch or switch access.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TD Snap is software for people with speech and language disabilities. It offers several page sets: symbol-supported ones for language and literacy development, topic-based phrases and a text-based set for literate users. All page sets work with eye gaze, touch and switch access, so they also suit people with limited mobility.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Multiple page sets
Eye gaze, touch and switch access
Literacy development support
Tools for professionals and families', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with autism, cerebral palsy and other speech disabilities; professionals and families.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Avaz AAC — Мовлення та альтернативна комунікація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'avazapp.com' OR LOWER(`name`) = 'avaz aac')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Avaz AAC', NULL, 'https://www.avazapp.com', NULL, NULL, 'AAC-застосунок із картинками для комунікації та навчання дітей з особливими потребами.', 'A picture-based AAC app for communication and learning for children with special needs.', 'Avaz (з гінді — «голос») — застосунок комунікації й навчання на основі картинок. Дитина може повідомляти, що хоче їсти, як почувається, а в школі — брати участь у навчанні. Застосунок розрахований на дитину, батьків і фахівців; є окремий текстовий варіант Avaz FreeSpeech, вебінари, ігри та матеріали для AAC.', 'Avaz (Hindi for “voice”) is a picture-based communication and learning app. A child can say what they want to eat or how they feel and take part in lessons at school. It is designed for the child, parents and professionals; there is also Avaz FreeSpeech, plus webinars, games and AAC resources.', 'Комунікація картинками
Підтримка навчання в школі
Для дитини, батьків і фахівців
Вебінари й ігри для AAC', 'Picture-based communication
Support for school learning
For child, parents and professionals
AAC webinars and games', 'Дітям із порушеннями мовлення, батькам, логопедам.', 'Children with speech disabilities, parents and speech therapists.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'avazapp.com' OR LOWER(`name`) = 'avaz aac') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A picture-based AAC app for communication and learning for children with special needs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Avaz (Hindi for “voice”) is a picture-based communication and learning app. A child can say what they want to eat or how they feel and take part in lessons at school. It is designed for the child, parents and professionals; there is also Avaz FreeSpeech, plus webinars, games and AAC resources.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Picture-based communication
Support for school learning
For child, parents and professionals
AAC webinars and games', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Children with speech disabilities, parents and speech therapists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- CoughDrop — Мовлення та альтернативна комунікація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mycoughdrop.com' OR LOWER(`name`) = 'coughdrop')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CoughDrop', NULL, 'https://www.mycoughdrop.com', NULL, NULL, 'Хмарний AAC-застосунок для людей зі складними комунікативними потребами, з командою підтримки.', 'A cloud-based AAC app for people with complex communication needs, with a support team.', 'CoughDrop — AAC-програма для людей з аутизмом, ДЦП, синдромами Дауна, Ангельмана, Ретта та іншими станами, що ускладнюють спілкування. Батьки, терапевти й вчителі підключаються безкоштовно й отримують звіти та інструменти спільної роботи. Є повнофункціональний пробний період на 2 місяці, підписка або разова покупка.', 'CoughDrop is AAC software for people with autism, cerebral palsy, Down, Angelman and Rett syndromes and other conditions that make communication harder. Parents, therapists and teachers join for free and get reporting and collaboration tools. There is a full-featured 2-month trial, a subscription or a lifetime purchase.', 'Хмарна синхронізація між пристроями
Безкоштовний доступ для команди підтримки
Звіти про комунікацію
Пробний період 2 місяці', 'Cloud sync across devices
Free access for the support team
Communication reports
2-month trial', 'Людям зі складними комунікативними потребами, родинам, терапевтам.', 'People with complex communication needs, families and therapists.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mycoughdrop.com' OR LOWER(`name`) = 'coughdrop') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A cloud-based AAC app for people with complex communication needs, with a support team.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'CoughDrop is AAC software for people with autism, cerebral palsy, Down, Angelman and Rett syndromes and other conditions that make communication harder. Parents, therapists and teachers join for free and get reporting and collaboration tools. There is a full-featured 2-month trial, a subscription or a lifetime purchase.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cloud sync across devices
Free access for the support team
Communication reports
2-month trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with complex communication needs, families and therapists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Cboard — Мовлення та альтернативна комунікація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cboard.io' OR LOWER(`name`) = 'cboard')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Cboard', NULL, 'https://www.cboard.io', NULL, NULL, 'Безкоштовний AAC-застосунок з відкритим кодом: дошки із символами й озвучення, понад 45 мов.', 'A free open-source AAC app: symbol boards and text-to-speech in 45+ languages.', 'Cboard — застосунок з відкритим кодом для дітей і дорослих із порушеннями мовлення. Комунікаційні дошки з символами та синтезом мовлення працюють у браузері на комп’ютерах, планшетах і телефонах, офлайн — у Chrome. Підтримується понад 45 мов, є набір тексту й темна тема без доплати.', 'Cboard is an open-source app for children and adults with speech and language impairments. Communication boards with symbols and text-to-speech run in the browser on computers, tablets and phones, with offline support in Chrome. It supports 45+ languages, typing and a dark mode at no cost.', 'Відкритий код, безкоштовно
Понад 45 мов
Працює в браузері й офлайн
Набір тексту та символи', 'Open source and free
45+ languages
Runs in the browser and offline
Typing and symbols', 'Людям із порушеннями мовлення, родинам і школам з обмеженим бюджетом.', 'People with speech impairments, families and schools on a budget.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cboard.io' OR LOWER(`name`) = 'cboard') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free open-source AAC app: symbol boards and text-to-speech in 45+ languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Cboard is an open-source app for children and adults with speech and language impairments. Communication boards with symbols and text-to-speech run in the browser on computers, tablets and phones, with offline support in Chrome. It supports 45+ languages, typing and a dark mode at no cost.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Open source and free
45+ languages
Runs in the browser and offline
Typing and symbols', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with speech impairments, families and schools on a budget.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Spoken AAC — Мовлення та альтернативна комунікація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'spokenaac.com' OR LOWER(`name`) = 'spoken aac')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Spoken AAC', NULL, 'https://spokenaac.com', NULL, NULL, 'AAC-застосунок «торкнись і говори» з передбаченням слів і природними голосами для Android та iOS.', 'A tap-to-talk AAC app with word prediction and natural voices for Android and iOS.', 'Spoken призначений для людей, які не можуть користуватися голосом через невербальний аутизм, афазію, інсульт або інші порушення мовлення. Застосунок вчиться на тому, як ви говорите, і передбачає наступні слова, тож речення складаються швидко й озвучуються природним голосом. Великий словник дозволяє висловлювати складні думки. Можна спробувати безкоштовно.', 'Spoken is for people unable to use their voice due to nonverbal autism, aphasia, stroke or other speech disorders. The app learns how you talk and predicts the next words, so sentences are built quickly and spoken in a natural voice. An extensive vocabulary lets you express complex thoughts. You can try it for free.', 'Передбачення наступних слів
Природні голоси
Великий словник
Android та iOS', 'Next-word prediction
Natural voices
Extensive vocabulary
Android and iOS', 'Людям з афазією, невербальним аутизмом, після інсульту.', 'People with aphasia, nonverbal autism or after stroke.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'spokenaac.com' OR LOWER(`name`) = 'spoken aac') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A tap-to-talk AAC app with word prediction and natural voices for Android and iOS.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Spoken is for people unable to use their voice due to nonverbal autism, aphasia, stroke or other speech disorders. The app learns how you talk and predicts the next words, so sentences are built quickly and spoken in a natural voice. An extensive vocabulary lets you express complex thoughts. You can try it for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Next-word prediction
Natural voices
Extensive vocabulary
Android and iOS', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with aphasia, nonverbal autism or after stroke.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Acapela My-Own-Voice — Мовлення та альтернативна комунікація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'acapela-group.com/voices/voice-banking' OR LOWER(`name`) = 'acapela my-own-voice')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Acapela My-Own-Voice', NULL, 'https://www.acapela-group.com/voices/voice-banking/', NULL, NULL, 'Онлайн-сервіс «банкінгу голосу»: створення цифрової копії власного голосу з 50 записаних речень.', 'An online voice banking service: create a digital copy of your own voice from 50 recorded sentences.', 'My-Own-Voice від Acapela дає людям, яким діагностували порушення мовлення (наприклад, БАС), можливість заздалегідь записати свій голос і отримати його цифрову копію. У версії 3 достатньо записати 50 речень. Створений голос можна використовувати з асистивними пристроями й AAC-програмами, щоб і далі говорити «своїм» голосом.', 'Acapela’s My-Own-Voice lets people diagnosed with speech disorders (such as ALS) record their voice in advance and get a digital copy of it. Version 3 needs only 50 recorded sentences. The resulting voice can be used with assistive devices and AAC software so you can keep speaking in your own voice.', 'Цифрова копія власного голосу
Достатньо 50 речень
Робота з AAC-пристроями
Онлайн-запис', 'Digital copy of your own voice
Only 50 sentences needed
Works with AAC devices
Online recording', 'Людям, яким загрожує втрата мовлення, та їхнім клініцистам.', 'People at risk of losing their speech and their clinicians.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'acapela-group.com/voices/voice-banking' OR LOWER(`name`) = 'acapela my-own-voice') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An online voice banking service: create a digital copy of your own voice from 50 recorded sentences.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Acapela’s My-Own-Voice lets people diagnosed with speech disorders (such as ALS) record their voice in advance and get a digital copy of it. Version 3 needs only 50 recorded sentences. The resulting voice can be used with assistive devices and AAC software so you can keep speaking in your own voice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Digital copy of your own voice
Only 50 sentences needed
Works with AAC devices
Online recording', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People at risk of losing their speech and their clinicians.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Speech Assistant AAC — Мовлення та альтернативна комунікація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'asoft.nl' OR LOWER(`name`) = 'speech assistant aac')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Speech Assistant AAC', NULL, 'https://www.asoft.nl', NULL, NULL, 'Простий AAC-застосунок синтезу мовлення для iPad, iPhone і Apple Watch з разовою оплатою.', 'A simple text-to-speech AAC app for iPad, iPhone and Apple Watch with a one-time payment.', 'Speech Assistant AAC від ASoft допомагає людям із порушеннями мовлення спілкуватися: набрані або збережені фрази озвучуються голосами iOS чи власними записами. Є історія фраз, вкладки й категорії, повне налаштування; працює англійською, нідерландською, французькою, німецькою, іспанською та італійською. Застосунок не збирає даних; оплата разова, без підписки.', 'Speech Assistant AAC by ASoft helps people with speech impairments communicate: typed or saved phrases are spoken with iOS voices or your own recordings. It has phrase history, tabs and categories and is fully customizable; available in English, Dutch, French, German, Spanish and Italian. The app collects no data; one-time payment, no subscription.', 'Озвучення фраз голосами iOS або записами
Історія та категорії фраз
Працює на Apple Watch
Без збору даних і підписки', 'Phrases spoken with iOS voices or recordings
Phrase history and categories
Works on Apple Watch
No data collection or subscription', 'Людям із порушеннями мовлення, які користуються технікою Apple.', 'People with speech impairments who use Apple devices.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'asoft.nl' OR LOWER(`name`) = 'speech assistant aac') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A simple text-to-speech AAC app for iPad, iPhone and Apple Watch with a one-time payment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Speech Assistant AAC by ASoft helps people with speech impairments communicate: typed or saved phrases are spoken with iOS voices or your own recordings. It has phrase history, tabs and categories and is fully customizable; available in English, Dutch, French, German, Spanish and Italian. The app collects no data; one-time payment, no subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Phrases spoken with iOS voices or recordings
Phrase history and categories
Works on Apple Watch
No data collection or subscription', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with speech impairments who use Apple devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Читання та нейровідмінності ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'reading-neurodiversity' LIMIT 1);

-- Speechify — Читання та нейровідмінності (наявний, лише прив'язка)
SET @new = 0;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'speechify.com' OR LOWER(`name`) = 'speechify') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- NaturalReader — Читання та нейровідмінності
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'naturalreaders.com' OR LOWER(`name`) = 'naturalreader')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NaturalReader', NULL, 'https://www.naturalreaders.com', NULL, NULL, 'Синтез мовлення з AI-голосами: читає текст, PDF, вебсторінки й фото тексту понад 90 мовами.', 'Text-to-speech with AI voices: reads text, PDFs, web pages and photos of text in 90+ languages.', 'NaturalReader перетворює текст, PDF, зображення, вебсторінки й навіть паперові книги на природне аудіо. Для особистого читання є безкоштовний план назавжди, для озвучення відео й навчальних курсів — комерційна ліцензія, для шкіл — групові ліцензії зі знижкою. Голоси на основі мовних моделей підлаштовують інтонацію під зміст.', 'NaturalReader turns text, PDFs, images, web pages and even printed books into natural-sounding audio. Personal reading has a free-forever plan, video and e-learning voiceovers need a commercial license, and schools get discounted group licenses. LLM-based voices adjust their delivery to the content.', 'Читання тексту, PDF, вебсторінок і фото
Понад 90 мов
Безкоштовний особистий план
Ліцензії для шкіл', 'Reads text, PDFs, web pages and photos
90+ languages
Free personal plan
School licenses', 'Людям із дислексією, студентам, усім, хто сприймає текст на слух.', 'People with dyslexia, students and anyone who prefers listening.', 'web,mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'naturalreaders.com' OR LOWER(`name`) = 'naturalreader') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Text-to-speech with AI voices: reads text, PDFs, web pages and photos of text in 90+ languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NaturalReader turns text, PDFs, images, web pages and even printed books into natural-sounding audio. Personal reading has a free-forever plan, video and e-learning voiceovers need a commercial license, and schools get discounted group licenses. LLM-based voices adjust their delivery to the content.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Reads text, PDFs, web pages and photos
90+ languages
Free personal plan
School licenses', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with dyslexia, students and anyone who prefers listening.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Read&Write — Читання та нейровідмінності
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'everway.com/products/read-and-write-education' OR LOWER(`name`) = 'read&write')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Read&Write', NULL, 'https://www.everway.com/products/read-and-write-education/', NULL, NULL, 'Інструмент підтримки читання й письма для учнів: озвучення з підсвіткою, словники, диктування, спрощення тексту.', 'Literacy support for students: read-aloud with highlighting, dictionaries, dictation, text simplification.', 'Read&Write (Everway, раніше Texthelp) допомагає учням із різними потребами читати, писати й розуміти тексти. Він читає вголос із підсвічуванням слів, розпізнає текст на зображеннях і в PDF, пояснює незнайомі слова з картинками, спрощує складні тексти й дозволяє диктувати замість набору. Учителі використовують його для інклюзивних класів.', 'Read&Write (Everway, formerly Texthelp) helps students with different needs read, write and understand texts. It reads aloud with word highlighting, recognizes text in images and PDFs, explains unfamiliar words with pictures, simplifies complex text and allows dictation instead of typing. Teachers use it for inclusive classrooms.', 'Озвучення з підсвічуванням слів
Розпізнавання тексту в PDF і зображеннях
Спрощення складного тексту
Диктування', 'Read-aloud with word highlighting
Text recognition in PDFs and images
Complex text simplification
Dictation', 'Учням і студентам, зокрема з дислексією; школам і університетам.', 'Students, including those with dyslexia; schools and universities.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'everway.com/products/read-and-write-education' OR LOWER(`name`) = 'read&write') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Literacy support for students: read-aloud with highlighting, dictionaries, dictation, text simplification.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Read&Write (Everway, formerly Texthelp) helps students with different needs read, write and understand texts. It reads aloud with word highlighting, recognizes text in images and PDFs, explains unfamiliar words with pictures, simplifies complex text and allows dictation instead of typing. Teachers use it for inclusive classrooms.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Read-aloud with word highlighting
Text recognition in PDFs and images
Complex text simplification
Dictation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students, including those with dyslexia; schools and universities.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Helperbird — Читання та нейровідмінності
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'helperbird.com' OR LOWER(`name`) = 'helperbird')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Helperbird', NULL, 'https://www.helperbird.com', NULL, NULL, 'Розширення для браузера з 40+ інструментами доступності: шрифти для дислексії, озвучення, режим читання.', 'A browser extension with 40+ accessibility tools: dyslexia fonts, read-aloud, reading mode.', 'Helperbird додає до браузера інструменти для читання й письма: Immersive Reader від Microsoft на будь-якій сторінці, озвучення природними голосами понад 30 мовами з підсвічуванням слів, розпізнавання тексту зі сканів, голосовий набір і передбачення слів, шрифти OpenDyslexic і Lexend, кольорові фільтри й лінійку читання. Базові функції безкоштовні й працюють без акаунта.', 'Helperbird adds reading and writing tools to your browser: Microsoft’s Immersive Reader on any page, natural read-aloud voices in 30+ languages with word highlighting, text recognition from scans, voice typing and word prediction, OpenDyslexic and Lexend fonts, color tints and a reading ruler. Basic features are free and work without an account.', 'Шрифти для дислексії
Озвучення понад 30 мовами
Голосовий набір і передбачення слів
Кольорові фільтри й лінійка читання', 'Dyslexia fonts
Read-aloud in 30+ languages
Voice typing and word prediction
Color tints and reading ruler', 'Людям із дислексією, СДУГ, слабким зором; студентам.', 'People with dyslexia, ADHD or low vision; students.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'helperbird.com' OR LOWER(`name`) = 'helperbird') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A browser extension with 40+ accessibility tools: dyslexia fonts, read-aloud, reading mode.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Helperbird adds reading and writing tools to your browser: Microsoft’s Immersive Reader on any page, natural read-aloud voices in 30+ languages with word highlighting, text recognition from scans, voice typing and word prediction, OpenDyslexic and Lexend fonts, color tints and a reading ruler. Basic features are free and work without an account.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Dyslexia fonts
Read-aloud in 30+ languages
Voice typing and word prediction
Color tints and reading ruler', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with dyslexia, ADHD or low vision; students.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Goblin Tools — Читання та нейровідмінності
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'goblin.tools' OR LOWER(`name`) = 'goblin tools')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Goblin Tools', NULL, 'https://goblin.tools', NULL, NULL, 'Набір простих AI-інструментів для нейровідмінних людей: розбиття завдань на кроки, тон тексту, оцінка часу.', 'A set of simple AI tools for neurodivergent people: breaking tasks into steps, text tone, time estimates.', 'Goblin Tools — збірка невеликих інструментів, кожен з яких виконує одне завдання: розбиває справу на дрібні кроки, підказує, як звучить текст, переформульовує його, оцінює час на завдання тощо. Розробники наголошують, що відповіді AI — це припущення, а не істина. Сайт безкоштовний без реклами; мобільні застосунки коштують недорого.', 'Goblin Tools is a collection of small single-task tools: break a chore into small steps, check how a text sounds, rephrase it, estimate how long a task takes and more. The developers stress that AI output is guesswork, not truth. The website is free with no ads; the mobile apps cost a small amount.', 'Розбиття завдань на кроки
Оцінка тону тексту
Переформулювання
Сайт безкоштовний без реклами', 'Break tasks into steps
Text tone check
Rephrasing
Free website with no ads', 'Людям з аутизмом, СДУГ та іншими нейровідмінностями.', 'Autistic people, people with ADHD and other neurodivergent people.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'goblin.tools' OR LOWER(`name`) = 'goblin tools') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A set of simple AI tools for neurodivergent people: breaking tasks into steps, text tone, time estimates.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Goblin Tools is a collection of small single-task tools: break a chore into small steps, check how a text sounds, rephrase it, estimate how long a task takes and more. The developers stress that AI output is guesswork, not truth. The website is free with no ads; the mobile apps cost a small amount.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Break tasks into steps
Text tone check
Rephrasing
Free website with no ads', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Autistic people, people with ADHD and other neurodivergent people.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tiimo — Читання та нейровідмінності
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tiimoapp.com' OR LOWER(`name`) = 'tiimo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tiimo', NULL, 'https://www.tiimoapp.com', NULL, NULL, 'Візуальний планувальник для нейровідмінних людей: таймлайн дня, таймери, AI-розбиття завдань.', 'A visual planner for neurodivergent people: day timeline, timers, AI task breakdown.', 'Tiimo перетворює розклад на візуальну стрічку часу з кольоровими завданнями, таймером зворотного відліку й віджетами, щоб бачити, що далі. AI допомагає розбити справу на кроки й оцінити час, є трекер настрою, нагороди за послідовність і застосунок для годинника. Безкоштовна версія включає планування, списки й таймер; Pro має пробний період 7 днів.', 'Tiimo turns your schedule into a visual timeline with color-coded tasks, a countdown timer and widgets so you can see what is next. AI helps break tasks into steps and estimate time, and there is a mood tracker, rewards for consistency and a watch app. The free version includes planning, to-do lists and the timer; Pro has a 7-day trial.', 'Візуальна стрічка дня
Таймер зворотного відліку
AI-розбиття завдань
Додаток для годинника', 'Visual day timeline
Countdown timer
AI task breakdown
Watch app', 'Людям із СДУГ, аутизмом та всім, кому важко планувати час.', 'People with ADHD, autism and anyone who struggles with time planning.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tiimoapp.com' OR LOWER(`name`) = 'tiimo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A visual planner for neurodivergent people: day timeline, timers, AI task breakdown.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tiimo turns your schedule into a visual timeline with color-coded tasks, a countdown timer and widgets so you can see what is next. AI helps break tasks into steps and estimate time, and there is a mood tracker, rewards for consistency and a watch app. The free version includes planning, to-do lists and the timer; Pro has a 7-day trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Visual day timeline
Countdown timer
AI task breakdown
Watch app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with ADHD, autism and anyone who struggles with time planning.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Inflow — Читання та нейровідмінності
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getinflow.io' OR LOWER(`name`) = 'inflow')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Inflow', NULL, 'https://www.getinflow.io', NULL, NULL, 'Застосунок для дорослих із СДУГ: програма навичок, створена клініцистами й психологами.', 'An app for adults with ADHD: a skills program created by clinicians and psychologists.', 'Inflow пропонує структуровану програму, яка допомагає краще зрозуміти особливості свого мислення при СДУГ і виробити навички організації та завершення справ. За описом розробників, програму створили клініцисти й психологи, що працюють із СДУГ. Застосунок не замінює діагностику й лікування.', 'Inflow offers a structured program that helps you understand how your ADHD brain works and build skills for organizing and getting things done. According to the developers, the program was created by ADHD clinicians and psychologists. The app does not replace diagnosis or treatment.', 'Структурована програма навичок
Створено фахівцями з СДУГ
Підтримка в організації справ', 'Structured skills program
Created by ADHD specialists
Support with getting organized', 'Дорослим із СДУГ або з підозрою на нього.', 'Adults with ADHD or who suspect they have it.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getinflow.io' OR LOWER(`name`) = 'inflow') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app for adults with ADHD: a skills program created by clinicians and psychologists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Inflow offers a structured program that helps you understand how your ADHD brain works and build skills for organizing and getting things done. According to the developers, the program was created by ADHD clinicians and psychologists. The app does not replace diagnosis or treatment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Structured skills program
Created by ADHD specialists
Support with getting organized', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adults with ADHD or who suspect they have it.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bionic Reading — Читання та нейровідмінності
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bionic-reading.com' OR LOWER(`name`) = 'bionic reading')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bionic Reading', NULL, 'https://bionic-reading.com', NULL, NULL, 'Метод читання з виділенням початку слів: застосунки, конвертер шрифтів і файлів.', 'A reading method that highlights the beginnings of words: apps, font and file converters.', 'Bionic Reading — швейцарський метод подання тексту, де початкові літери слів виділено жирним, щоб око легше трималося рядка. Доступні застосунки для смартфона (завантаження тексту, файлу чи сайту), шрифти Bionic Reading та конвертер, що додає метод до власних шрифтів як функцію OpenType, з разовою покупкою.', 'Bionic Reading is a Swiss text presentation method in which the first letters of words are bold to help the eye follow the line. It offers smartphone apps (upload text, a file or a website), Bionic Reading fonts and a converter that adds the method to your own fonts as an OpenType feature, as a one-time purchase.', 'Виділення початку слів
Застосунки для смартфона
Конвертер шрифтів OpenType
Робота з файлами й сайтами', 'Highlights word beginnings
Smartphone apps
OpenType font converter
Works with files and websites', 'Тим, кому важко втримувати увагу під час читання.', 'People who find it hard to keep focus while reading.', 'web,mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bionic-reading.com' OR LOWER(`name`) = 'bionic reading') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A reading method that highlights the beginnings of words: apps, font and file converters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Bionic Reading is a Swiss text presentation method in which the first letters of words are bold to help the eye follow the line. It offers smartphone apps (upload text, a file or a website), Bionic Reading fonts and a converter that adds the method to your own fonts as an OpenType feature, as a one-time purchase.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Highlights word beginnings
Smartphone apps
OpenType font converter
Works with files and websites', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who find it hard to keep focus while reading.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- BeeLine Reader — Читання та нейровідмінності
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'beelinereader.com' OR LOWER(`name`) = 'beeline reader')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BeeLine Reader', NULL, 'https://www.beelinereader.com', NULL, NULL, 'Кольорові градієнти в рядках тексту, що допомагають оку переходити з рядка на рядок.', 'Color gradients across lines of text that help the eye move from one line to the next.', 'BeeLine Reader фарбує рядки тексту плавним кольоровим градієнтом, щоб кінець одного рядка вів до початку наступного й було легше не збиватися. Працює на сайтах, в електронних книгах, PDF і мобільних застосунках; видавці й освітні платформи підключають його легким JavaScript-скриптом.', 'BeeLine Reader colors lines of text with a smooth gradient so the end of one line leads into the start of the next, making it easier not to lose your place. It works on websites, e-books, PDFs and mobile apps; publishers and learning platforms add it with a lightweight JavaScript snippet.', 'Кольорові градієнти в рядках
Сайти, електронні книги, PDF
Легкий скрипт для видавців', 'Color gradients across lines
Websites, e-books, PDFs
Lightweight script for publishers', 'Читачам, яким важко зосередитися; видавцям і освітнім платформам.', 'Readers who struggle to focus; publishers and learning platforms.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'beelinereader.com' OR LOWER(`name`) = 'beeline reader') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Color gradients across lines of text that help the eye move from one line to the next.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'BeeLine Reader colors lines of text with a smooth gradient so the end of one line leads into the start of the next, making it easier not to lose your place. It works on websites, e-books, PDFs and mobile apps; publishers and learning platforms add it with a lightweight JavaScript snippet.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Color gradients across lines
Websites, e-books, PDFs
Lightweight script for publishers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Readers who struggle to focus; publishers and learning platforms.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ghotit — Читання та нейровідмінності
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ghotit.com' OR LOWER(`name`) = 'ghotit')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ghotit', NULL, 'https://www.ghotit.com', NULL, NULL, 'Перевірка правопису й читання для людей із дислексією та дисграфією, зокрема офлайн-версія.', 'Spelling and reading support for people with dyslexia and dysgraphia, including an offline version.', 'Ghotit створили засновники, які самі мають дислексію й дисграфію. Програма виправляє сильно спотворені слова з урахуванням контексту, читає англійський текст уголос і допомагає писати самостійно. Для компаній є офлайн-версія з акцентом на приватність для працівників із дислексією та команд, для яких англійська не рідна.', 'Ghotit was created by founders who live with dyslexia and dysgraphia. It corrects badly misspelled words using context, reads English text aloud and helps you write independently. For companies there is an offline, privacy-first version for employees with dyslexia and teams for whom English is a second language.', 'Контекстна перевірка правопису
Читання тексту вголос
Офлайн-версія для компаній', 'Context-aware spell checking
Text read-aloud
Offline version for companies', 'Людям із дислексією та дисграфією, роботодавцям.', 'People with dyslexia and dysgraphia, employers.', 'desktop,web', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ghotit.com' OR LOWER(`name`) = 'ghotit') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Spelling and reading support for people with dyslexia and dysgraphia, including an offline version.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ghotit was created by founders who live with dyslexia and dysgraphia. It corrects badly misspelled words using context, reads English text aloud and helps you write independently. For companies there is an offline, privacy-first version for employees with dyslexia and teams for whom English is a second language.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Context-aware spell checking
Text read-aloud
Offline version for companies', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with dyslexia and dysgraphia, employers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Керування без рук ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hands-free' LIMIT 1);

-- Talon Voice — Керування без рук
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'talonvoice.com' OR LOWER(`name`) = 'talon voice')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Talon Voice', NULL, 'https://talonvoice.com', NULL, NULL, 'Керування комп’ютером без рук: голос, відстеження погляду, звуки та скрипти на Python.', 'Hands-free computer control: voice, eye tracking, noise recognition and Python scripting.', 'Talon дає змогу писати текст, програмувати й керувати комп’ютером голосом, поглядом (з айтрекером) і короткими звуками. Команди налаштовуються скриптами на Python, а спільнота ділиться готовими наборами команд. Працює на macOS, Windows і Linux; базова версія безкоштовна.', 'Talon lets you write, code and control your computer with your voice, your eyes (with an eye tracker) and short noises. Commands are customized with Python scripts, and the community shares ready-made command sets. It runs on macOS, Windows and Linux; the base version is free.', 'Голосове керування й диктування
Відстеження погляду
Команди звуками
Налаштування на Python', 'Voice control and dictation
Eye tracking
Noise commands
Python customization', 'Людям із травмами рук, RSI, обмеженою рухливістю; програмістам.', 'People with hand injuries, RSI or limited mobility; programmers.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'talonvoice.com' OR LOWER(`name`) = 'talon voice') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Hands-free computer control: voice, eye tracking, noise recognition and Python scripting.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Talon lets you write, code and control your computer with your voice, your eyes (with an eye tracker) and short noises. Commands are customized with Python scripts, and the community shares ready-made command sets. It runs on macOS, Windows and Linux; the base version is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Voice control and dictation
Eye tracking
Noise commands
Python customization', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with hand injuries, RSI or limited mobility; programmers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Voice Access — Керування без рук
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.google.android.apps.accessibility.voiceaccess' OR LOWER(`name`) = 'voice access')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Voice Access', NULL, 'https://play.google.com/store/apps/details?id=com.google.android.apps.accessibility.voiceaccess', NULL, NULL, 'Безкоштовний застосунок Google для керування Android голосом: навігація, натискання, набір тексту.', 'A free Google app to control Android by voice: navigation, tapping, text entry.', 'Voice Access допомагає людям, яким важко користуватися сенсорним екраном (через параліч, тремор чи тимчасову травму), керувати телефоном голосом: «назад», «відкрий Gmail», «натисни далі», «прокрути вниз», диктувати й редагувати текст. Вбудований підручник пояснює основні команди, а «Допомога» показує їхній список.', 'Voice Access helps people who have difficulty using a touch screen (due to paralysis, tremor or a temporary injury) control their phone by voice: “go back”, “open Gmail”, “tap next”, “scroll down”, plus dictation and text editing. A built-in tutorial covers the main commands, and “Help” shows the list.', 'Навігація голосом
Натискання й прокручування
Диктування й редагування тексту
Вбудований підручник', 'Voice navigation
Tapping and scrolling
Dictation and text editing
Built-in tutorial', 'Користувачам Android з обмеженою рухливістю рук.', 'Android users with limited hand mobility.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.google.android.apps.accessibility.voiceaccess' OR LOWER(`name`) = 'voice access') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free Google app to control Android by voice: navigation, tapping, text entry.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Voice Access helps people who have difficulty using a touch screen (due to paralysis, tremor or a temporary injury) control their phone by voice: “go back”, “open Gmail”, “tap next”, “scroll down”, plus dictation and text editing. A built-in tutorial covers the main commands, and “Help” shows the list.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Voice navigation
Tapping and scrolling
Dictation and text editing
Built-in tutorial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Android users with limited hand mobility.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Enable Viacam (eViacam) — Керування без рук
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eviacam.crea-si.com' OR LOWER(`name`) = 'enable viacam (eviacam)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Enable Viacam (eViacam)', NULL, 'https://eviacam.crea-si.com', NULL, NULL, 'Безкоштовна програма з відкритим кодом: курсор миші рухається за рухами голови через вебкамеру.', 'Free open-source software that moves the mouse pointer as you move your head, using a webcam.', 'eViacam замінює мишу: курсор рухається, коли ви рухаєте головою перед звичайною вебкамерою, без кабелів, міток і додаткового обладнання. Майстер налаштування допомагає почати, а швидкість, прискорення, плавність і час затримки для кліку налаштовуються під людину. Програма безкоштовна; розробники приймають пожертви.', 'eViacam replaces the mouse: the pointer moves as you move your head in front of an ordinary webcam, with no cables, markers or extra hardware. A setup wizard helps you start, and speed, acceleration, smoothness and dwell-click time can be tuned. The software is free; the developers accept donations.', 'Керування курсором рухами голови
Лише вебкамера
Клік затримкою
Відкритий код', 'Pointer control by head movement
Webcam only
Dwell clicking
Open source', 'Людям, які не можуть користуватися мишею, зокрема з RSI.', 'People who cannot use a mouse, including those with RSI.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eviacam.crea-si.com' OR LOWER(`name`) = 'enable viacam (eviacam)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free open-source software that moves the mouse pointer as you move your head, using a webcam.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'eViacam replaces the mouse: the pointer moves as you move your head in front of an ordinary webcam, with no cables, markers or extra hardware. A setup wizard helps you start, and speed, acceleration, smoothness and dwell-click time can be tuned. The software is free; the developers accept donations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Pointer control by head movement
Webcam only
Dwell clicking
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who cannot use a mouse, including those with RSI.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Smyle Mouse — Керування без рук
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'smylemouse.com' OR LOWER(`name`) = 'smyle mouse')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Smyle Mouse', NULL, 'https://smylemouse.com', NULL, NULL, 'Програма «головна миша»: керування курсором рухами голови й клік усмішкою через вебкамеру.', 'Head-mouse software: control the pointer with head movements and click with facial gestures via webcam.', 'Smyle Mouse дозволяє користуватися комп’ютером без рук: курсор слідує за рухами голови, а клік виконується жестами обличчя, наприклад усмішкою. Потрібна лише вебкамера. Програма підходить людям із травмою спинного мозку, іншими порушеннями рухливості та тим, хто хоче зменшити навантаження на руки. Є безкоштовна пробна версія.', 'Smyle Mouse lets you use a computer hands-free: the pointer follows your head movements and clicks are made with facial gestures such as a smile. Only a webcam is needed. It suits people with spinal cord injury, other mobility impairments and those who want to reduce strain on their hands. A free trial is available.', 'Курсор за рухами голови
Клік жестами обличчя
Лише вебкамера
Пробна версія', 'Pointer follows head movement
Clicks with facial gestures
Webcam only
Free trial', 'Людям із травмою спинного мозку, RSI, обмеженою рухливістю рук.', 'People with spinal cord injury, RSI or limited hand mobility.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'smylemouse.com' OR LOWER(`name`) = 'smyle mouse') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Head-mouse software: control the pointer with head movements and click with facial gestures via webcam.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Smyle Mouse lets you use a computer hands-free: the pointer follows your head movements and clicks are made with facial gestures such as a smile. Only a webcam is needed. It suits people with spinal cord injury, other mobility impairments and those who want to reduce strain on their hands. A free trial is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Pointer follows head movement
Clicks with facial gestures
Webcam only
Free trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with spinal cord injury, RSI or limited hand mobility.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tecla — Керування без рук
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gettecla.com' OR LOWER(`name`) = 'tecla')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tecla', NULL, 'https://gettecla.com', NULL, NULL, 'Пристрій Tecla-e: керування смартфоном, планшетом, комп’ютером і побутовою технікою через перемикачі.', 'The Tecla-e device: control phones, tablets, computers and home appliances through switches.', 'Tecla-e — асистивний пристрій для людей з обмеженою рухливістю верхньої частини тіла. До нього підключають перемикач, що підходить людині (кнопка легкого дотику, «вдих-видих», моргання, джойстик або керування інвалідним візком), і через нього керують телефоном, планшетом, комп’ютером та ІЧ-технікою вдома.', 'Tecla-e is an assistive device for people with limited upper-body mobility. You connect the switch that suits you (light-touch button, sip-and-puff, blink switch, joystick or wheelchair controls) and use it to control your phone, tablet, computer and infrared home appliances.', 'Підключення будь-яких перемикачів
Керування телефоном і комп’ютером
Керування ІЧ-технікою
Інтеграція з візком', 'Works with any switch
Phone and computer control
Infrared appliance control
Wheelchair integration', 'Людям із квадриплегією, БАС, ДЦП, розсіяним склерозом.', 'People with quadriplegia, ALS, cerebral palsy or multiple sclerosis.', 'mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gettecla.com' OR LOWER(`name`) = 'tecla') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Tecla-e device: control phones, tablets, computers and home appliances through switches.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tecla-e is an assistive device for people with limited upper-body mobility. You connect the switch that suits you (light-touch button, sip-and-puff, blink switch, joystick or wheelchair controls) and use it to control your phone, tablet, computer and infrared home appliances.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Works with any switch
Phone and computer control
Infrared appliance control
Wheelchair integration', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with quadriplegia, ALS, cerebral palsy or multiple sclerosis.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- GlassOuse — Керування без рук
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'glassouse.com' OR LOWER(`name`) = 'glassouse')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GlassOuse', NULL, 'https://glassouse.com', NULL, NULL, 'Бездротова «головна миша» у вигляді окулярів: курсор рухами голови, клік прикусом або затримкою.', 'A wireless head mouse worn like glasses: pointer by head movement, click by bite switch or dwell.', 'GlassOuse — легка оправа, що перетворює рухи голови на рухи курсора на комп’ютері, смартфоні, планшеті чи Smart TV. Клік виконується прикусним перемикачем, перемикачем «вдих-видих» або затримкою. Пристрій сумісний із Windows, macOS, iOS, Android, Linux і ChromeOS без драйверів.', 'GlassOuse is a lightweight frame that turns head movements into pointer movements on a computer, smartphone, tablet or Smart TV. Clicks are made with a bite switch, a sip-and-puff switch or dwell. It works with Windows, macOS, iOS, Android, Linux and ChromeOS without drivers.', 'Курсор рухами голови
Прикусний або «вдих-видих» перемикач
Без драйверів
Працює з телефоном і Smart TV', 'Pointer by head movement
Bite or sip-and-puff switch
No drivers
Works with phones and Smart TVs', 'Людям із БАС, травмою спинного мозку, ДЦП, розсіяним склерозом.', 'People with ALS, spinal cord injury, cerebral palsy or multiple sclerosis.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'glassouse.com' OR LOWER(`name`) = 'glassouse') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A wireless head mouse worn like glasses: pointer by head movement, click by bite switch or dwell.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'GlassOuse is a lightweight frame that turns head movements into pointer movements on a computer, smartphone, tablet or Smart TV. Clicks are made with a bite switch, a sip-and-puff switch or dwell. It works with Windows, macOS, iOS, Android, Linux and ChromeOS without drivers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Pointer by head movement
Bite or sip-and-puff switch
No drivers
Works with phones and Smart TVs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with ALS, spinal cord injury, cerebral palsy or multiple sclerosis.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tobii Dynavox — Керування без рук
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'us.tobiidynavox.com' OR LOWER(`name`) = 'tobii dynavox')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tobii Dynavox', NULL, 'https://us.tobiidynavox.com', NULL, NULL, 'Пристрої для керування поглядом і синтезу мовлення та AAC-програми для людей з інвалідністю.', 'Eye-gaze controlled speech devices and AAC software for people with disabilities.', 'Tobii Dynavox виробляє рішення для комунікації людей з інвалідністю: пристрої синтезу мовлення з керуванням поглядом на Windows, сенсорні пристрої на iOS, айтрекери, а також програми для доступу дотиком і перемикачами. Рішення адаптуються для людей із БАС, афазією, аутизмом, ДЦП та іншими станами.', 'Tobii Dynavox makes communication solutions for people with disabilities: eye-gaze controlled speech-generating devices on Windows, touch devices on iOS, eye trackers and software for touch and switch access. The solutions are adapted for people with ALS, aphasia, autism, cerebral palsy and other conditions.', 'Пристрої з керуванням поглядом
Айтрекери
Доступ дотиком і перемикачами
AAC-програми', 'Eye-gaze controlled devices
Eye trackers
Touch and switch access
AAC software', 'Людям із БАС, ДЦП, аутизмом; клініцистам і родинам.', 'People with ALS, cerebral palsy or autism; clinicians and families.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'us.tobiidynavox.com' OR LOWER(`name`) = 'tobii dynavox') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Eye-gaze controlled speech devices and AAC software for people with disabilities.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tobii Dynavox makes communication solutions for people with disabilities: eye-gaze controlled speech-generating devices on Windows, touch devices on iOS, eye trackers and software for touch and switch access. The solutions are adapted for people with ALS, aphasia, autism, cerebral palsy and other conditions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Eye-gaze controlled devices
Eye trackers
Touch and switch access
AAC software', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with ALS, cerebral palsy or autism; clinicians and families.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- =================== Цифрова доступність для бізнесу ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'digital-accessibility' LIMIT 1);

-- axe DevTools — Цифрова доступність для бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'deque.com/axe/devtools' OR LOWER(`name`) = 'axe devtools')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'axe DevTools', NULL, 'https://www.deque.com/axe/devtools/', NULL, NULL, 'Автоматичне тестування доступності сайтів і мобільних застосунків від Deque, з розширенням для браузера.', 'Automated accessibility testing for websites and mobile apps from Deque, with a browser extension.', 'axe DevTools від Deque вбудовує перевірку доступності в процес розробки: розширення для браузера, виправлення в IDE в один клік, автоматичні тести для вебу, iOS та Android у CI. Платформа Deque також пропонує сканування всього сайту зі звітами та навчання з доступності. Є безкоштовні інструменти.', 'axe DevTools by Deque builds accessibility checks into development: a browser extension, one-click fixes in the IDE and automated tests for web, iOS and Android in CI. The Deque platform also offers site-wide scanning with reports and accessibility training. Free tools are available.', 'Розширення для браузера
Виправлення в IDE
Автотести для вебу та мобільних застосунків
Сканування всього сайту', 'Browser extension
Fixes in the IDE
Automated tests for web and mobile
Site-wide scanning', 'Розробникам, QA-командам, фахівцям із доступності.', 'Developers, QA teams and accessibility specialists.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'deque.com/axe/devtools' OR LOWER(`name`) = 'axe devtools') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Automated accessibility testing for websites and mobile apps from Deque, with a browser extension.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'axe DevTools by Deque builds accessibility checks into development: a browser extension, one-click fixes in the IDE and automated tests for web, iOS and Android in CI. The Deque platform also offers site-wide scanning with reports and accessibility training. Free tools are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Browser extension
Fixes in the IDE
Automated tests for web and mobile
Site-wide scanning', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers, QA teams and accessibility specialists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Stark — Цифрова доступність для бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getstark.co' OR LOWER(`name`) = 'stark')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Stark', NULL, 'https://www.getstark.co', NULL, NULL, 'Набір інструментів доступності для дизайнерів і розробників: плагіни для Figma, Sketch, GitHub і браузера.', 'Accessibility tools for designers and developers: plugins for Figma, Sketch, GitHub and the browser.', 'Stark вбудовує перевірки доступності в інструменти, з якими вже працює команда: Figma, Sketch, GitHub і браузер. Вебзастосунок Stark допомагає відстежувати проблеми, виправлення й прогрес на всьому шляху продукту — від дизайну до коду. Почати можна безкоштовно, для команд є пробний період.', 'Stark builds accessibility checks into the tools your team already uses: Figma, Sketch, GitHub and the browser. The Stark web app tracks issues, fixes and progress across the product lifecycle, from design to code. You can start for free, and teams get a trial.', 'Плагіни для Figma і Sketch
Інтеграція з GitHub
Розширення для браузера
Відстеження прогресу команди', 'Figma and Sketch plugins
GitHub integration
Browser extension
Team progress tracking', 'Дизайнерам, розробникам, продакт-менеджерам.', 'Designers, developers and product managers.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getstark.co' OR LOWER(`name`) = 'stark') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Accessibility tools for designers and developers: plugins for Figma, Sketch, GitHub and the browser.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Stark builds accessibility checks into the tools your team already uses: Figma, Sketch, GitHub and the browser. The Stark web app tracks issues, fixes and progress across the product lifecycle, from design to code. You can start for free, and teams get a trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Figma and Sketch plugins
GitHub integration
Browser extension
Team progress tracking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Designers, developers and product managers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- WAVE (WebAIM) — Цифрова доступність для бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wave.webaim.org' OR LOWER(`name`) = 'wave (webaim)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'WAVE (WebAIM)', NULL, 'https://wave.webaim.org', NULL, NULL, 'Безкоштовний інструмент WebAIM для перевірки сторінок на помилки доступності й відповідність WCAG.', 'A free WebAIM tool that checks pages for accessibility errors and WCAG issues.', 'WAVE — набір інструментів оцінки доступності від WebAIM. Достатньо ввести адресу сторінки, щоб побачити помилки та попередження WCAG прямо на ній. Розширення для Chrome, Firefox і Edge перевіряють закриті паролем, локальні й динамічні сторінки, а платні API й тестовий рушій дозволяють перевіряти багато сторінок і вбудувати перевірки в CI.', 'WAVE is a suite of accessibility evaluation tools from WebAIM. Enter a page address to see WCAG errors and alerts right on the page. Extensions for Chrome, Firefox and Edge check password-protected, local and dynamic pages, and the paid API and testing engine let you check many pages and integrate checks into CI.', 'Перевірка сторінки за адресою
Розширення для браузерів
API для масової перевірки
Інтеграція в CI', 'Check a page by URL
Browser extensions
API for bulk testing
CI integration', 'Веброзробникам, редакторам сайтів, тестувальникам.', 'Web developers, site editors and testers.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wave.webaim.org' OR LOWER(`name`) = 'wave (webaim)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free WebAIM tool that checks pages for accessibility errors and WCAG issues.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'WAVE is a suite of accessibility evaluation tools from WebAIM. Enter a page address to see WCAG errors and alerts right on the page. Extensions for Chrome, Firefox and Edge check password-protected, local and dynamic pages, and the paid API and testing engine let you check many pages and integrate checks into CI.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Check a page by URL
Browser extensions
API for bulk testing
CI integration', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Web developers, site editors and testers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AudioEye — Цифрова доступність для бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'audioeye.com' OR LOWER(`name`) = 'audioeye')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AudioEye', NULL, 'https://www.audioeye.com', NULL, NULL, 'Платформа веб-доступності для бізнесу: автоматичне виявлення й виправлення проблем, аудити, моніторинг.', 'A web accessibility platform for businesses: automated issue detection and fixes, audits, monitoring.', 'AudioEye знаходить і автоматично виправляє поширені проблеми доступності на сайтах, а також пропонує аудити та експертну підтримку. Компанія наголошує, що доступне дерево сторінки важливе й для AI-агентів, які купують і бронюють від імені користувачів. Є SDK та MCP для розробників.', 'AudioEye finds and automatically fixes common accessibility issues on websites and offers audits and expert support. The company points out that an accessible page tree also matters for AI agents shopping and booking on behalf of users. There is an SDK and MCP for developers.', 'Автоматичне виявлення й виправлення
Аудити доступності
Моніторинг сайту
SDK і MCP для розробників', 'Automated detection and fixes
Accessibility audits
Site monitoring
SDK and MCP for developers', 'Бізнесу будь-якого розміру, агенціям.', 'Businesses of all sizes and agencies.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'audioeye.com' OR LOWER(`name`) = 'audioeye') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A web accessibility platform for businesses: automated issue detection and fixes, audits, monitoring.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'AudioEye finds and automatically fixes common accessibility issues on websites and offers audits and expert support. The company points out that an accessible page tree also matters for AI agents shopping and booking on behalf of users. There is an SDK and MCP for developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automated detection and fixes
Accessibility audits
Site monitoring
SDK and MCP for developers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Businesses of all sizes and agencies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- UserWay — Цифрова доступність для бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'userway.org' OR LOWER(`name`) = 'userway')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'UserWay', NULL, 'https://userway.org', NULL, NULL, 'Рішення веб-доступності від Level Access: віджет, сканування сайту на WCAG і виправлення на рівні коду.', 'Web accessibility solutions from Level Access: a widget, WCAG site scanning and code-level fixes.', 'UserWay (частина Level Access) пропонує кілька рівнів: швидке підключення AI-віджета, що виправляє поширені проблеми під час завантаження сторінки, постійне сканування сайту на відповідність WCAG і ADA, а також виправлення на рівні коду та експертну підтримку для великих організацій.', 'UserWay (part of Level Access) offers several levels: a quick AI widget that fixes common issues on page load, continuous site scanning for WCAG and ADA, and code-level fixes with expert support for larger organizations.', 'AI-віджет доступності
Сканування на WCAG і ADA
Виправлення в коді
Експертна підтримка', 'AI accessibility widget
WCAG and ADA scanning
Code-level fixes
Expert support', 'Власникам сайтів, малому бізнесу, великим організаціям.', 'Website owners, small businesses and large organizations.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'userway.org' OR LOWER(`name`) = 'userway') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Web accessibility solutions from Level Access: a widget, WCAG site scanning and code-level fixes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'UserWay (part of Level Access) offers several levels: a quick AI widget that fixes common issues on page load, continuous site scanning for WCAG and ADA, and code-level fixes with expert support for larger organizations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI accessibility widget
WCAG and ADA scanning
Code-level fixes
Expert support', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Website owners, small businesses and large organizations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- accessiBe — Цифрова доступність для бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'accessibe.com' OR LOWER(`name`) = 'accessibe')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'accessiBe', NULL, 'https://accessibe.com', NULL, NULL, 'Платформа доступності: AI, інструменти для розробників і експертні послуги для відповідності WCAG, ADA та EAA.', 'An accessibility platform: AI, developer tools and expert services for WCAG, ADA and EAA conformance.', 'accessiBe поєднує автоматизований AI, інструменти для розробників і людську експертизу, щоб підтримувати доступність сайту з урахуванням WCAG, американського ADA та європейського EAA. Є варіанти для агенцій і власників сайтів, підтримка програм екранного доступу та керування з клавіатури.', 'accessiBe combines automated AI, developer tools and human expertise to support website accessibility with WCAG, the US ADA and the European EAA in mind. There are options for agencies and site owners, plus screen reader and keyboard navigation support.', 'Автоматизований AI
Інструменти для розробників
Експертні послуги
Програма для агенцій', 'Automated AI
Developer tools
Expert services
Agency program', 'Власникам сайтів і веб-агенціям.', 'Website owners and web agencies.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'accessibe.com' OR LOWER(`name`) = 'accessibe') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An accessibility platform: AI, developer tools and expert services for WCAG, ADA and EAA conformance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'accessiBe combines automated AI, developer tools and human expertise to support website accessibility with WCAG, the US ADA and the European EAA in mind. There are options for agencies and site owners, plus screen reader and keyboard navigation support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automated AI
Developer tools
Expert services
Agency program', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Website owners and web agencies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Evinced — Цифрова доступність для бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'evinced.com' OR LOWER(`name`) = 'evinced')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Evinced', NULL, 'https://www.evinced.com', NULL, NULL, 'AI-інструменти для пошуку, групування й запобігання помилкам доступності у вебі та мобільних застосунках.', 'AI tools that find, cluster and prevent accessibility bugs in web and mobile apps.', 'Evinced використовує комп’ютерний зір, щоб «бачити» екран, як людина, і знаходити класи проблем доступності, які раніше вимагали ручного аудиту. Знайдені проблеми групуються, щоб не тонути в тисячах повідомлень, відстежуються й запобігаються в процесі розробки — навіть коли продукт змінюється тисячі разів на тиждень.', 'Evinced uses computer vision to “see” a screen the way a person does and find classes of accessibility issues that used to require manual audits. Issues are clustered so you are not buried in thousands of reports, then tracked and prevented during development, even with thousands of changes a week.', 'Пошук проблем комп’ютерним зором
Групування повторюваних помилок
Веб і мобільні застосунки
Вбудовування в розробку', 'Issue detection with computer vision
Clustering of repeated bugs
Web and mobile apps
Built into development', 'Командам розробки великих продуктів.', 'Development teams of large products.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'evinced.com' OR LOWER(`name`) = 'evinced') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI tools that find, cluster and prevent accessibility bugs in web and mobile apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Evinced uses computer vision to “see” a screen the way a person does and find classes of accessibility issues that used to require manual audits. Issues are clustered so you are not buried in thousands of reports, then tracked and prevented during development, even with thousands of changes a week.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Issue detection with computer vision
Clustering of repeated bugs
Web and mobile apps
Built into development', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Development teams of large products.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Level Access — Цифрова доступність для бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'levelaccess.com' OR LOWER(`name`) = 'level access')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Level Access', NULL, 'https://www.levelaccess.com', NULL, NULL, 'Платформа цифрової доступності: тестування, виправлення, звітність і управління програмою доступності.', 'A digital accessibility platform: testing, fixing, reporting and accessibility program management.', 'Level Access працює в цифровій доступності з 1999 року. Платформа охоплює моніторинг, документацію й управління програмою доступності, автоматичне виправлення поширених проблем, створення доступних PDF з файлів Microsoft Office і рішення для банків та страхових компаній. Є партнерська програма.', 'Level Access has worked in digital accessibility since 1999. The platform covers monitoring, documentation and program management, automatic fixes for common issues, accessible PDFs from Microsoft Office files and solutions for banks and insurers. There is a partner program.', 'Моніторинг і управління програмою
Автоматичні виправлення
Доступні PDF з Office
Рішення для фінансового сектору', 'Monitoring and program management
Automatic fixes
Accessible PDFs from Office
Financial sector solutions', 'Великим компаніям, державним установам, фінансовому сектору.', 'Enterprises, government and the financial sector.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'levelaccess.com' OR LOWER(`name`) = 'level access') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A digital accessibility platform: testing, fixing, reporting and accessibility program management.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Level Access has worked in digital accessibility since 1999. The platform covers monitoring, documentation and program management, automatic fixes for common issues, accessible PDFs from Microsoft Office files and solutions for banks and insurers. There is a partner program.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Monitoring and program management
Automatic fixes
Accessible PDFs from Office
Financial sector solutions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Enterprises, government and the financial sector.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Siteimprove Accessibility — Цифрова доступність для бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'siteimprove.com/platform/accessibility' OR LOWER(`name`) = 'siteimprove accessibility')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Siteimprove Accessibility', NULL, 'https://www.siteimprove.com/platform/accessibility/', NULL, NULL, 'Сканування всього сайту на відповідність WCAG, пріоритизація виправлень і вимірювання прогресу.', 'Site-wide WCAG scanning, fix prioritization and progress measurement.', 'Модуль доступності Siteimprove сканує весь сайт, документи, PDF, застосунки й навіть сторінки за VPN, допомагає пріоритизувати виправлення, об’єднує команду навколо задач і вимірює прогрес. Siteimprove.ai також має інструменти для пошукової видимості, аналітики й створення контенту.', 'Siteimprove’s accessibility module scans the whole site, documents, PDFs, apps and even pages behind a VPN, helps prioritize fixes, aligns the team around tasks and measures progress. Siteimprove.ai also offers tools for search visibility, analytics and content creation.', 'Сканування сайту й PDF
Пріоритизація виправлень
Вимірювання прогресу
Інтеграція з аналітикою', 'Site and PDF scanning
Fix prioritization
Progress measurement
Analytics integration', 'Командам великих сайтів, університетам, держустановам.', 'Teams running large websites, universities and government.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'siteimprove.com/platform/accessibility' OR LOWER(`name`) = 'siteimprove accessibility') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Site-wide WCAG scanning, fix prioritization and progress measurement.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Siteimprove’s accessibility module scans the whole site, documents, PDFs, apps and even pages behind a VPN, helps prioritize fixes, aligns the team around tasks and measures progress. Siteimprove.ai also offers tools for search visibility, analytics and content creation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Site and PDF scanning
Fix prioritization
Progress measurement
Analytics integration', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teams running large websites, universities and government.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Fable — Цифрова доступність для бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'makeitfable.com' OR LOWER(`name`) = 'fable')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fable', NULL, 'https://makeitfable.com', NULL, NULL, 'Тестування доступності за участі людей з інвалідністю та навчання для продуктових команд.', 'Accessibility testing with people with disabilities and training for product teams.', 'Fable з’єднує продуктові команди з перевіреною спільнотою людей з інвалідністю, які тестують сайти й застосунки та дають відгук. Так виявляються бар’єри, які автоматичні перевірки не бачать: коли людина не може оформити замовлення, надіслати форму чи знайти потрібне. Також Fable пропонує навчання з доступності.', 'Fable connects product teams with a vetted community of people with disabilities who test websites and apps and give feedback. This surfaces barriers automated checks miss: when someone cannot complete a checkout, submit a form or find what they need. Fable also offers accessibility training.', 'Тестування людьми з інвалідністю
Дослідження користувачів
Навчання з доступності', 'Testing by people with disabilities
User research
Accessibility training', 'Продуктовим і UX-командам.', 'Product and UX teams.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'makeitfable.com' OR LOWER(`name`) = 'fable') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Accessibility testing with people with disabilities and training for product teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Fable connects product teams with a vetted community of people with disabilities who test websites and apps and give feedback. This surfaces barriers automated checks miss: when someone cannot complete a checkout, submit a form or find what they need. Fable also offers accessibility training.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Testing by people with disabilities
User research
Accessibility training', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Product and UX teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Pope Tech — Цифрова доступність для бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pope.tech' OR LOWER(`name`) = 'pope tech')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Pope Tech', NULL, 'https://pope.tech', NULL, NULL, 'Платформа веб-доступності на основі WAVE: сканування всіх сторінок, ручні тести, звіти, інструменти для LMS.', 'A WAVE-powered web accessibility platform: scanning all pages, manual tests, reports, LMS tools.', 'Pope Tech використовує рушій WAVE, щоб автоматично знаходити проблеми доступності на всіх сторінках, і додає керовані ручні тести з розкладом, дашборди й звіти, необмежену кількість користувачів і сайтів у межах тарифу. Для освіти є вбудований посібник у LMS, що допомагає викладачам створювати доступні курси.', 'Pope Tech uses the WAVE engine to find accessibility issues on all your pages automatically and adds guided manual tests with scheduling, dashboards and reports, with unlimited users and sites within your page tier. For education there is a built-in LMS guide that helps instructors create accessible courses.', 'Сканування на рушії WAVE
Керовані ручні тести
Дашборди й звіти
Посібник для LMS', 'WAVE-powered scanning
Guided manual tests
Dashboards and reports
LMS guide', 'Університетам, школам, організаціям із багатьма сайтами.', 'Universities, schools and organizations with many sites.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pope.tech' OR LOWER(`name`) = 'pope tech') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A WAVE-powered web accessibility platform: scanning all pages, manual tests, reports, LMS tools.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Pope Tech uses the WAVE engine to find accessibility issues on all your pages automatically and adds guided manual tests with scheduling, dashboards and reports, with unlimited users and sites within your page tier. For education there is a built-in LMS guide that helps instructors create accessible courses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'WAVE-powered scanning
Guided manual tests
Dashboards and reports
LMS guide', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Universities, schools and organizations with many sites.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Silktide — Цифрова доступність для бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'silktide.com' OR LOWER(`name`) = 'silktide')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Silktide', NULL, 'https://silktide.com', NULL, NULL, 'Платформа для сайтів: перевірка всіх сторінок і PDF на доступність і якість контенту, аналітика.', 'A website platform: testing every page and PDF for accessibility and content quality, plus analytics.', 'Silktide перевіряє кожну сторінку й PDF на контент, доступність, зручність і відповідність вимогам та показує, що виправити спершу. Також платформа показує, як бренд описують AI-асистенти й пошук, і поєднує трафік, шляхи користувачів і теплові карти зі сторінками. Підтримує перевірку кількома мовами.', 'Silktide tests every page and PDF for content, accessibility, user experience and compliance and shows what to fix first. The platform also shows how AI assistants and search engines describe your brand and connects traffic, journeys and heatmaps to each page. It supports testing in multiple languages.', 'Перевірка сторінок і PDF на доступність
Пріоритети виправлень
Аналітика й теплові карти
Кілька мов', 'Accessibility testing of pages and PDFs
Fix priorities
Analytics and heatmaps
Multiple languages', 'Командам великих сайтів, держустановам.', 'Teams running large websites and government.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'silktide.com' OR LOWER(`name`) = 'silktide') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A website platform: testing every page and PDF for accessibility and content quality, plus analytics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Silktide tests every page and PDF for content, accessibility, user experience and compliance and shows what to fix first. The platform also shows how AI assistants and search engines describe your brand and connects traffic, journeys and heatmaps to each page. It supports testing in multiple languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Accessibility testing of pages and PDFs
Fix priorities
Analytics and heatmaps
Multiple languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teams running large websites and government.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Equally AI — Цифрова доступність для бізнесу
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'equally.ai' OR LOWER(`name`) = 'equally ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Equally AI', NULL, 'https://www.equally.ai', NULL, NULL, 'Платформа веб-доступності з віджетом, AI-виправленнями та перевіркою на ADA, EAA і WCAG.', 'A web accessibility platform with a widget, AI fixes and ADA, EAA and WCAG checks.', 'Equally AI пропонує віджет доступності, AI-виправлення та інструменти для перевірки сайту на ADA, EAA і WCAG. Встановлення просте й підтримує різні платформи сайтів. Є безкоштовний план, платні — з пробним періодом 7 днів.', 'Equally AI offers an accessibility widget, AI fixes and tools to check a site against ADA, EAA and WCAG. Installation is simple and supports various website platforms. There is a free plan, and paid plans come with a 7-day trial.', 'Віджет доступності
AI-виправлення
Перевірка на ADA, EAA, WCAG
Безкоштовний план', 'Accessibility widget
AI fixes
ADA, EAA and WCAG checks
Free plan', 'Власникам сайтів, малому й середньому бізнесу, агенціям.', 'Website owners, SMBs and agencies.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-14 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'equally.ai' OR LOWER(`name`) = 'equally ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A web accessibility platform with a widget, AI fixes and ADA, EAA and WCAG checks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Equally AI offers an accessibility widget, AI fixes and tools to check a site against ADA, EAA and WCAG. Installation is simple and supports various website platforms. There is a free plan, and paid plans come with a 7-day trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Accessibility widget
AI fixes
ADA, EAA and WCAG checks
Free plan', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Website owners, SMBs and agencies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

