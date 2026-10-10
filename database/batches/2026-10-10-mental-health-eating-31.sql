SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-10: нова підкатегорія «Ментальне здоров'я та харчова поведінка» / «Mental health and eating behavior» (slug mental-health-eating-behavior)
-- у категорії «Здоров'я та краса» (slug health-beauty) + 31 нових продуктів + 21 наявних (лише зв'язок)
-- + EN-текст примітки-застереження (subcat_note_mental_health_eating).
-- Тема чутлива (РХП): описи нейтральні, без обіцянок, порад щодо дієт, ваги чи калорій і без діагнозів.
-- Адреси звірено з офіційними сторінками 2026-10-10. Ціну, якої немає в джерелі, не вказано: план «Ціна: див. сайт» з price NULL
-- (на картці — «За запитом», а не «$0»).
-- Не додано (не існують / неоднозначні): Rise Up + Recover, Eating Disorder Recovery, Bea, Ate Food Diary (тепер AteMate з
-- необов'язковим підрахунком калорій), Am I Hungry? Virtual Coach, Happify (тепер Dario Mind), Sanvello (домен не працює).
-- Наявні (лише додатковий зв'язок, тексти не змінюються): Calm, Wysa, Headspace, Rosebud, Ash (Slingshot AI), Earkick, Mindsera, Kin, NEUROFIT, Elite HRV, Welltory, Replika, Upheal, Mentalyc, Blueprint, Lyssn, Limbic, Breathwrk, Healthy Gamer, Buddhify, Plum Village App
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою. Нічого не видаляється.
-- Застосування: phpMyAdmin → БД → «Импорт» (файл .sql або .sql.zip). Повторний запуск безпечний.
--   Recovery Record
--   Recovery Record for Clinicians
--   Brighter Bite
--   Nourishly
--   Equip
--   Within Health
--   Eating Disorder Hope
--   Food Diary & Intuitive Eating
--   Shutterbite: Mindful Eating
--   Mindful Bites: Food Journal
--   Intuitive Eating Buddy
--   Eat Right Now
--   Eated
--   Youper
--   Moodfit
--   Daylio
--   Finch
--   Insight Timer
--   Dario Mind
--   Elomia
--   7 Cups
--   BetterHelp
--   Talkspace
--   Amwell
--   Teladoc Health
--   Grow Therapy
--   Online-Therapy.com
--   Brightside Health
--   Thriveworks
--   Regain
--   Teen Counseling
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'health-beauty' LIMIT 1);
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Ментальне здоров''я та харчова поведінка', 'Mental health and eating behavior', 'mental-health-eating-behavior' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `slug` = 'mental-health-eating-behavior');
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'mental-health-eating-behavior' LIMIT 1);
-- Примітка-застереження (UA — app/translations.php, EN — тут; оновлюється, якщо вже є)
INSERT INTO `ui_translations` (`key_name`, `lang`, `translated_text`, `source`) VALUES ('subcat_note_mental_health_eating', 'en', 'The tools in this subcategory do not replace treatment. If you suspect an eating disorder or another mental health problem in yourself or someone close to you, contact a doctor or a psychotherapist.', 'manual') ON DUPLICATE KEY UPDATE `translated_text` = VALUES(`translated_text`), `source` = 'manual';

-- Recovery Record — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'recoveryrecord.com' OR LOWER(`name`) = 'recovery record')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Recovery Record', NULL, 'https://www.recoveryrecord.com', NULL, NULL, 'Застосунок для відновлення при РХП: щоденник їжі, думок і почуттів, яким можна ділитися з лікувальною командою.', 'An eating disorder recovery app: a journal of meals, thoughts and feelings that you can share with your treatment team.', 'Recovery Record розрахований на людей, які відновлюються після анорексії, булімії, компульсивного переїдання, ARFID та інших розладів харчової поведінки. У застосунку ведуть щоденник їжі, думок і почуттів, а записами можна ділитися з лікувальною командою. Розробники рекомендують його людям, які проходять лікування. Застосунок не замінює лікаря чи психотерапевта.', 'Recovery Record is built for people recovering from anorexia, bulimia, binge eating, ARFID and other eating disorders. You keep a journal of meals, thoughts and feelings and can share your entries with your treatment team. The developers recommend it for people who are in treatment. The app does not replace a doctor or a psychotherapist.', 'Щоденник їжі, думок і почуттів
Обмін записами з лікувальною командою
Окремий застосунок для фахівців (Recovery Record for Clinicians)', 'Journal of meals, thoughts and feelings
Sharing entries with your treatment team
A separate app for professionals (Recovery Record for Clinicians)', 'Люди, які проходять лікування РХП, разом зі своєю лікувальною командою.', 'People in treatment for an eating disorder, together with their treatment team.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'recoveryrecord.com' OR LOWER(`name`) = 'recovery record') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An eating disorder recovery app: a journal of meals, thoughts and feelings that you can share with your treatment team.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Recovery Record is built for people recovering from anorexia, bulimia, binge eating, ARFID and other eating disorders. You keep a journal of meals, thoughts and feelings and can share your entries with your treatment team. The developers recommend it for people who are in treatment. The app does not replace a doctor or a psychotherapist.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Journal of meals, thoughts and feelings
Sharing entries with your treatment team
A separate app for professionals (Recovery Record for Clinicians)', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in treatment for an eating disorder, together with their treatment team.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'За оглядами, доступ для користувачів безкоштовний; актуальні умови — на сайті.', 'According to reviews, access for users is free; check current terms on the website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'According to reviews, access for users is free; check current terms on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Recovery Record for Clinicians — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'recoveryrecord.com/clinician_overview' OR LOWER(`name`) = 'recovery record for clinicians')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Recovery Record for Clinicians', NULL, 'https://www.recoveryrecord.com/clinician_overview', NULL, NULL, 'Застосунок для фахівців із лікування РХП, що працює в парі із застосунком пацієнта Recovery Record.', 'An app for eating disorder treatment professionals that works together with the Recovery Record patient app.', 'Версія Recovery Record для фахівців: за згодою пацієнта фахівець бачить його записи самоспостереження між сесіями й може надсилати повідомлення. За описом розробника, застосунок підтримує роботу в підходах КПТ, ACT і DBT та відповідає вимогам HIPAA. Розрахований на психологів, дієтологів, лікарів і психіатрів.', 'The professional version of Recovery Record: with the patient''s consent, the clinician sees self-monitoring entries between sessions and can send messages. According to the developer, the app supports work within CBT, ACT and DBT and is HIPAA compliant. It is designed for psychologists, dietitians, physicians and psychiatrists.', 'Перегляд записів пацієнта між сесіями
Повідомлення пацієнту
Підтримка підходів КПТ, ACT і DBT (за описом розробника)
Відповідність HIPAA (за описом розробника)', 'Viewing patient entries between sessions
Messages to the patient
Support for CBT, ACT and DBT approaches (according to the developer)
HIPAA compliance (according to the developer)', 'Психологи, дієтологи, лікарі й психіатри, які працюють із РХП.', 'Psychologists, dietitians, physicians and psychiatrists who work with eating disorders.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'recoveryrecord.com/clinician_overview' OR LOWER(`name`) = 'recovery record for clinicians') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app for eating disorder treatment professionals that works together with the Recovery Record patient app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The professional version of Recovery Record: with the patient''s consent, the clinician sees self-monitoring entries between sessions and can send messages. According to the developer, the app supports work within CBT, ACT and DBT and is HIPAA compliant. It is designed for psychologists, dietitians, physicians and psychiatrists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Viewing patient entries between sessions
Messages to the patient
Support for CBT, ACT and DBT approaches (according to the developer)
HIPAA compliance (according to the developer)', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Psychologists, dietitians, physicians and psychiatrists who work with eating disorders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Brighter Bite — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/us/app/brighter-bite-ed-recovery/id1513041355' OR LOWER(`name`) = 'brighter bite')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Brighter Bite', NULL, 'https://apps.apple.com/us/app/brighter-bite-ed-recovery/id1513041355', NULL, NULL, 'Безкоштовний застосунок без реклами для підтримки відновлення при РХП: техніки подолання, щоденники та звіт у PDF.', 'A free, ad-free app that supports eating disorder recovery: coping techniques, journals and a PDF report.', 'Brighter Bite містить «Coping Chat» із понад 20 технік на основі ACT і DBT, щоденники їжі (з фото), настрою й думок, тест самооцінки, експорт звіту в PDF і добірку ресурсів. Застосунок безкоштовний і без реклами. Він підтримує відновлення, але не замінює лікування.', 'Brighter Bite includes a "Coping Chat" with more than 20 techniques based on ACT and DBT, journals for meals (with photos), mood and thoughts, a self-assessment test, a PDF report export and a collection of resources. The app is free and has no ads. It supports recovery but does not replace treatment.', '«Coping Chat»: понад 20 технік на основі ACT і DBT
Щоденники їжі (з фото), настрою й думок
Тест самооцінки
Експорт звіту в PDF
Добірка ресурсів', '"Coping Chat": more than 20 techniques based on ACT and DBT
Journals for meals (with photos), mood and thoughts
Self-assessment test
PDF report export
Collection of resources', 'Люди у відновленні при РХП, які хочуть мати інструменти між зустрічами з фахівцем.', 'People recovering from an eating disorder who want tools between appointments with a specialist.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/us/app/brighter-bite-ed-recovery/id1513041355' OR LOWER(`name`) = 'brighter bite') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free, ad-free app that supports eating disorder recovery: coping techniques, journals and a PDF report.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Brighter Bite includes a "Coping Chat" with more than 20 techniques based on ACT and DBT, journals for meals (with photos), mood and thoughts, a self-assessment test, a PDF report export and a collection of resources. The app is free and has no ads. It supports recovery but does not replace treatment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '"Coping Chat": more than 20 techniques based on ACT and DBT
Journals for meals (with photos), mood and thoughts
Self-assessment test
PDF report export
Collection of resources', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People recovering from an eating disorder who want tools between appointments with a specialist.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовно й без реклами (за описом в App Store).', 'Free and ad-free (according to the App Store listing).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free and ad-free (according to the App Store listing).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Nourishly — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nourishly.eu' OR LOWER(`name`) = 'nourishly')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nourishly', NULL, 'https://www.nourishly.eu', NULL, NULL, 'Застосунок про харчування й самопочуття: щоденник їжі, симптоми й настрій, зв''язок із дієтологом.', 'An app about nutrition and well-being: a food journal, symptoms and mood, and a connection to your dietitian.', 'Nourishly від розробників Recovery Record створений не лише для РХП: його використовують і при діабеті, шлунково-кишкових проблемах та інших станах. Користувач веде щоденник їжі, голоду й ситості, симптомів, стресу, сну й настрою, а дієтолог чи інший фахівець бачить записи й дає зворотний зв''язок. Є версія для фахівців. За оглядом, для відновлення при РХП застосунок підходить лише разом із клінічним лікуванням.', 'Nourishly, from the makers of Recovery Record, is not built only for eating disorders: it is also used for diabetes, gastrointestinal problems and other conditions. The user keeps a journal of meals, hunger and fullness, symptoms, stress, sleep and mood, and a dietitian or another specialist sees the entries and gives feedback. There is a version for professionals. According to a review, for eating disorder recovery the app is suitable only together with clinical treatment.', 'Щоденник їжі, голоду й ситості
Симптоми, стрес, сон і настрій
Зв''язок із дієтологом чи іншим фахівцем
Версія для фахівців (Nourishly for Clinicians)', 'Journal of meals, hunger and fullness
Symptoms, stress, sleep and mood
Connection to a dietitian or another specialist
Version for professionals (Nourishly for Clinicians)', 'Люди, які працюють із дієтологом; при РХП — лише разом із клінічним лікуванням.', 'People who work with a dietitian; for eating disorders, only together with clinical treatment.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nourishly.eu' OR LOWER(`name`) = 'nourishly') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app about nutrition and well-being: a food journal, symptoms and mood, and a connection to your dietitian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Nourishly, from the makers of Recovery Record, is not built only for eating disorders: it is also used for diabetes, gastrointestinal problems and other conditions. The user keeps a journal of meals, hunger and fullness, symptoms, stress, sleep and mood, and a dietitian or another specialist sees the entries and gives feedback. There is a version for professionals. According to a review, for eating disorder recovery the app is suitable only together with clinical treatment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Journal of meals, hunger and fullness
Symptoms, stress, sleep and mood
Connection to a dietitian or another specialist
Version for professionals (Nourishly for Clinicians)', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who work with a dietitian; for eating disorders, only together with clinical treatment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Equip — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'equip.health' OR LOWER(`name`) = 'equip')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Equip', NULL, 'https://equip.health', NULL, NULL, 'Віртуальне лікування розладів харчової поведінки для всіх основних діагнозів, включно з ARFID.', 'Virtual eating disorder treatment for all major diagnoses, including ARFID.', 'Equip — провайдер віртуального лікування РХП з підходами, що спираються на докази. Сервіс працює з усіма основними діагнозами, включно з ARFID. За оглядом, Equip співпрацює з багатьма страховими планами США. Доступність в інших країнах уточнюйте на сайті.', 'Equip is a provider of virtual, evidence-based eating disorder treatment. It works with all major diagnoses, including ARFID. According to a review, Equip works with many US insurance plans. Check availability in other countries on the website.', 'Віртуальне лікування РХП
Усі основні діагнози, включно з ARFID
Робота зі страховими планами США (за оглядом)', 'Virtual eating disorder treatment
All major diagnoses, including ARFID
Works with US insurance plans (according to a review)', 'Люди з РХП та їхні родини, яким потрібне лікування; доступність у вашій країні уточнюйте на сайті.', 'People with eating disorders and their families who need treatment; check availability in your country on the website.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'equip.health' OR LOWER(`name`) = 'equip') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Virtual eating disorder treatment for all major diagnoses, including ARFID.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Equip is a provider of virtual, evidence-based eating disorder treatment. It works with all major diagnoses, including ARFID. According to a review, Equip works with many US insurance plans. Check availability in other countries on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Virtual eating disorder treatment
All major diagnoses, including ARFID
Works with US insurance plans (according to a review)', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with eating disorders and their families who need treatment; check availability in your country on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Within Health — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'withinhealth.com' OR LOWER(`name`) = 'within health')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Within Health', NULL, 'https://www.withinhealth.com', NULL, NULL, 'Спеціалізований провайдер віртуального лікування й терапії розладів харчової поведінки.', 'A specialized provider of virtual eating disorder treatment and therapy.', 'Within Health надає віртуальне лікування й терапію розладів харчової поведінки. Сервіс платний, а умови оплати й страхування описані на сайті. Чи доступний він у вашій країні, уточнюйте на сайті.', 'Within Health provides virtual eating disorder treatment and therapy. The service is paid, and payment and insurance terms are described on the website. Check on the website whether it is available in your country.', 'Віртуальне лікування РХП
Терапія з фахівцями
Умови й доступність — на сайті', 'Virtual eating disorder treatment
Therapy with specialists
Terms and availability on the website', 'Люди з РХП, яким потрібна спеціалізована допомога; доступність у вашій країні уточнюйте на сайті.', 'People with eating disorders who need specialized care; check availability in your country on the website.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'withinhealth.com' OR LOWER(`name`) = 'within health') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A specialized provider of virtual eating disorder treatment and therapy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Within Health provides virtual eating disorder treatment and therapy. The service is paid, and payment and insurance terms are described on the website. Check on the website whether it is available in your country.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Virtual eating disorder treatment
Therapy with specialists
Terms and availability on the website', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with eating disorders who need specialized care; check availability in your country on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Eating Disorder Hope — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eatingdisorderhope.com' OR LOWER(`name`) = 'eating disorder hope')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eating Disorder Hope', NULL, 'https://www.eatingdisorderhope.com', NULL, NULL, 'Незалежний інформаційний ресурс про РХП: освітні матеріали, інформація про лікування й пошук фахівців.', 'An independent information resource about eating disorders: educational materials, treatment information and finding specialists.', 'Eating Disorder Hope публікує матеріали про анорексію, булімію, компульсивне переїдання та інші РХП, інформацію про лікування й відновлення та допомагає знайти фахівців. За описом сайту, ресурс створений за підтримки Within Health. Матеріали мають освітній характер і не замінюють консультацію фахівця.', 'Eating Disorder Hope publishes materials about anorexia, bulimia, binge eating and other eating disorders, information about treatment and recovery, and helps you find specialists. According to the website, the resource is created with the support of Within Health. The materials are educational and do not replace a consultation with a specialist.', 'Освітні матеріали про РХП
Інформація про лікування й відновлення
Пошук фахівців', 'Educational materials about eating disorders
Information about treatment and recovery
Finding specialists', 'Люди з РХП, їхні близькі та всі, хто шукає достовірну інформацію.', 'People with eating disorders, their loved ones and anyone looking for reliable information.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eatingdisorderhope.com' OR LOWER(`name`) = 'eating disorder hope') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An independent information resource about eating disorders: educational materials, treatment information and finding specialists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Eating Disorder Hope publishes materials about anorexia, bulimia, binge eating and other eating disorders, information about treatment and recovery, and helps you find specialists. According to the website, the resource is created with the support of Within Health. The materials are educational and do not replace a consultation with a specialist.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Educational materials about eating disorders
Information about treatment and recovery
Finding specialists', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with eating disorders, their loved ones and anyone looking for reliable information.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Матеріали сайту доступні безкоштовно.', 'The website materials are free to access.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The website materials are free to access.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Food Diary & Intuitive Eating — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/us/app/food-diary-intuitive-eating/id1660087790' OR LOWER(`name`) = 'food diary & intuitive eating')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Food Diary & Intuitive Eating', NULL, 'https://apps.apple.com/us/app/food-diary-intuitive-eating/id1660087790', NULL, NULL, 'Щоденник їжі без калорій і макросів за принципами інтуїтивного харчування, з оглядами за день, тиждень і місяць.', 'A food diary without calories or macros, based on intuitive eating principles, with daily, weekly and monthly overviews.', 'Застосунок від Embrace Wellness Ltd (в App Store називається «Food Diary - Stop Binge Eating») пропонує вести щоденник їжі без підрахунку калорій і макросів за принципами інтуїтивного харчування. Є щоденні, тижневі й місячні огляди. Базова версія безкоштовна, є опційна платна; користувачі повідомляють, що частина функцій доступна лише в платній.', 'The app by Embrace Wellness Ltd (listed in the App Store as "Food Diary - Stop Binge Eating") lets you keep a food diary without counting calories or macros, based on intuitive eating principles. It has daily, weekly and monthly overviews. The basic version is free, with an optional paid version; users report that some features are only in the paid version.', 'Щоденник їжі без калорій і макросів
Принципи інтуїтивного харчування
Огляди за день, тиждень і місяць', 'Food diary without calories or macros
Intuitive eating principles
Daily, weekly and monthly overviews', 'Люди, які хочуть уважніше ставитися до їжі без підрахунку калорій.', 'People who want to pay more attention to food without counting calories.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/us/app/food-diary-intuitive-eating/id1660087790' OR LOWER(`name`) = 'food diary & intuitive eating') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A food diary without calories or macros, based on intuitive eating principles, with daily, weekly and monthly overviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app by Embrace Wellness Ltd (listed in the App Store as "Food Diary - Stop Binge Eating") lets you keep a food diary without counting calories or macros, based on intuitive eating principles. It has daily, weekly and monthly overviews. The basic version is free, with an optional paid version; users report that some features are only in the paid version.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Food diary without calories or macros
Intuitive eating principles
Daily, weekly and monthly overviews', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to pay more attention to food without counting calories.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовна версія; частина функцій — у платній.', 'Free version; some features are in the paid version.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free version; some features are in the paid version.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Shutterbite: Mindful Eating — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.shutterbite' OR LOWER(`name`) = 'shutterbite: mindful eating')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Shutterbite: Mindful Eating', NULL, 'https://play.google.com/store/apps/details?id=com.shutterbite', NULL, NULL, 'Фотощоденник для усвідомленого харчування без підрахунку калорій, з понад 40 готовими параметрами.', 'A photo food journal for mindful eating without calorie counting, with more than 40 ready-made tracking options.', 'Shutterbite — фотощоденник їжі без підрахунку калорій. Журнал можна налаштувати: є понад 40 готових параметрів, зокрема голод і ситість, чому ви їли, настрій і з ким ви їли. Для кожного параметра є статистика. У застосунку є покупки всередині.', 'Shutterbite is a photo food journal without calorie counting. The journal is customizable: there are more than 40 ready-made tracking options, including hunger and fullness, why you ate, mood and who you ate with. Each option has its own stats. The app has in-app purchases.', 'Фотощоденник їжі без калорій
Понад 40 готових параметрів (голод і ситість, чому їли, настрій, з ким їли)
Статистика за кожним параметром', 'Photo food journal without calories
More than 40 ready-made options (hunger and fullness, why you ate, mood, who you ate with)
Stats for each option', 'Люди, які хочуть усвідомленіше ставитися до їжі без підрахунку калорій.', 'People who want a more mindful approach to food without counting calories.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.shutterbite' OR LOWER(`name`) = 'shutterbite: mindful eating') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A photo food journal for mindful eating without calorie counting, with more than 40 ready-made tracking options.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Shutterbite is a photo food journal without calorie counting. The journal is customizable: there are more than 40 ready-made tracking options, including hunger and fullness, why you ate, mood and who you ate with. Each option has its own stats. The app has in-app purchases.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Photo food journal without calories
More than 40 ready-made options (hunger and fullness, why you ate, mood, who you ate with)
Stats for each option', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want a more mindful approach to food without counting calories.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mindful Bites: Food Journal — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.qianlv.food_log' OR LOWER(`name`) = 'mindful bites: food journal')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mindful Bites: Food Journal', NULL, 'https://play.google.com/store/apps/details?id=com.qianlv.food_log', NULL, NULL, 'Щоденник їжі, настрою й самопочуття без підрахунку калорій.', 'A journal of meals, mood and symptoms without calorie counting.', 'Mindful Bites дає змогу записувати їжу разом з емоційним станом і фізичним самопочуттям, наприклад здуттям чи браком енергії. Підрахунку калорій і макросів немає. У застосунку є покупки всередині.', 'Mindful Bites lets you log meals together with your emotional state and physical symptoms, such as bloating or low energy. There is no calorie or macro counting. The app has in-app purchases.', 'Записи їжі без калорій і макросів
Настрій поруч із прийомами їжі
Фізичне самопочуття й симптоми', 'Meal logging without calories or macros
Mood next to your meals
Physical symptoms', 'Люди, які хочуть бачити зв''язок між їжею, настроєм і самопочуттям.', 'People who want to see how food, mood and how they feel are connected.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.qianlv.food_log' OR LOWER(`name`) = 'mindful bites: food journal') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A journal of meals, mood and symptoms without calorie counting.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mindful Bites lets you log meals together with your emotional state and physical symptoms, such as bloating or low energy. There is no calorie or macro counting. The app has in-app purchases.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Meal logging without calories or macros
Mood next to your meals
Physical symptoms', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to see how food, mood and how they feel are connected.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Intuitive Eating Buddy — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=ro.sagital.areyouhungry' OR LOWER(`name`) = 'intuitive eating buddy')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Intuitive Eating Buddy', NULL, 'https://play.google.com/store/apps/details?id=ro.sagital.areyouhungry', NULL, NULL, 'Щоденник для інтуїтивного харчування: їжа, голод і ситість, настрій, тренування й сон, без калорій.', 'A journal for intuitive eating: food, hunger and fullness, mood, workouts and sleep, without calories.', 'Intuitive Eating Buddy — щоденник, у якому записують їжу, голод і ситість, настрій, тренування, сон і напої, щоб помічати, що впливає на харчування. Розробники заявляють, що підрахунку калорій у застосунку немає й не буде. У застосунку є покупки всередині.', 'Intuitive Eating Buddy is a journal where you log food, hunger and fullness, mood, workouts, sleep and drinks to notice what affects how you eat. The developers state that the app has no calorie counting and will not add it. The app has in-app purchases.', 'Їжа, голод і ситість
Настрій, тренування, сон і напої
Без підрахунку калорій (за заявою розробників)', 'Food, hunger and fullness
Mood, workouts, sleep and drinks
No calorie counting (according to the developers)', 'Люди, які хочуть практикувати інтуїтивне харчування без підрахунку калорій.', 'People who want to practice intuitive eating without counting calories.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=ro.sagital.areyouhungry' OR LOWER(`name`) = 'intuitive eating buddy') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A journal for intuitive eating: food, hunger and fullness, mood, workouts and sleep, without calories.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Intuitive Eating Buddy is a journal where you log food, hunger and fullness, mood, workouts, sleep and drinks to notice what affects how you eat. The developers state that the app has no calorie counting and will not add it. The app has in-app purchases.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Food, hunger and fullness
Mood, workouts, sleep and drinks
No calorie counting (according to the developers)', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to practice intuitive eating without counting calories.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Eat Right Now — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'goeatrightnow.com' OR LOWER(`name`) = 'eat right now')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eat Right Now', NULL, 'https://goeatrightnow.com', NULL, NULL, 'Програма на основі усвідомленості для розриву звичних циклів переїдання, без дієт і обмежень.', 'A mindfulness-based program for breaking habitual overeating cycles, without diets or restrictions.', 'Eat Right Now — програма в застосунку з керованими уроками, вправами на усвідомленість і спільнотою. Вона розрахована на кілька тижнів і, за описом, не передбачає дієт, обмежень чи підрахунку калорій. За описом на сайті, є 7-денний безкоштовний пробний період. Якщо напади переїдання повторюються, варто звернутися до фахівця.', 'Eat Right Now is an in-app program with guided lessons, mindfulness exercises and a community. It runs for several weeks and, according to its description, involves no diets, restrictions or calorie counting. According to the website, there is a 7-day free trial. If binge episodes keep coming back, it is worth seeing a specialist.', 'Керовані уроки
Вправи на усвідомленість
Спільнота учасників
7-денний безкоштовний пробний період (за описом)', 'Guided lessons
Mindfulness exercises
Member community
7-day free trial (according to the description)', 'Люди, які хочуть змінити звичні цикли переїдання за допомогою усвідомленості.', 'People who want to change habitual overeating cycles with mindfulness.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'goeatrightnow.com' OR LOWER(`name`) = 'eat right now') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A mindfulness-based program for breaking habitual overeating cycles, without diets or restrictions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Eat Right Now is an in-app program with guided lessons, mindfulness exercises and a community. It runs for several weeks and, according to its description, involves no diets, restrictions or calorie counting. According to the website, there is a 7-day free trial. If binge episodes keep coming back, it is worth seeing a specialist.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Guided lessons
Mindfulness exercises
Member community
7-day free trial (according to the description)', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to change habitual overeating cycles with mindfulness.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Free trial', 0.00, 'free', '7 днів безкоштовно (за описом на сайті).', '7 days free (according to the website).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний період' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '7 days free (according to the website).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Eated — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eated.io' OR LOWER(`name`) = 'eated')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eated', NULL, 'https://eated.io', NULL, NULL, 'Застосунок про харчові звички без підрахунку калорій: фото страв, баланс тарілки й спостереження за звичками.', 'An app about eating habits without calorie counting: meal photos, plate balance and observations about your habits.', 'Eated — застосунок для iOS, побудований на методі «тарілки» Гарварду. Ви фотографуєте страви, бачите, наскільки збалансована тарілка, а застосунок дає щоденні й тижневі спостереження та пропонує невеликі звички. Підрахунку калорій немає. Спробувати можна безкоштовно.', 'Eated is an iOS app built on Harvard''s plate method. You take photos of your meals, see how balanced your plate is, and the app gives daily and weekly observations and suggests small habits. There is no calorie counting. You can try it for free.', 'Фото страв і баланс тарілки
Щоденні й тижневі спостереження
Невеликі звички
Без підрахунку калорій', 'Meal photos and plate balance
Daily and weekly observations
Small habits
No calorie counting', 'Люди, які хочуть краще розуміти свої харчові звички без підрахунку калорій.', 'People who want to understand their eating habits better without counting calories.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eated.io' OR LOWER(`name`) = 'eated') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app about eating habits without calorie counting: meal photos, plate balance and observations about your habits.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Eated is an iOS app built on Harvard''s plate method. You take photos of your meals, see how balanced your plate is, and the app gives daily and weekly observations and suggests small habits. There is no calorie counting. You can try it for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Meal photos and plate balance
Daily and weekly observations
Small habits
No calorie counting', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to understand their eating habits better without counting calories.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Спробувати безкоштовно', 'Free to try', 0.00, 'free', 'За описом на сайті, спробувати можна безкоштовно.', 'According to the website, it is free to try.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Спробувати безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free to try', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'According to the website, it is free to try.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Youper — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'youper.ai' OR LOWER(`name`) = 'youper')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Youper', NULL, 'https://www.youper.ai', NULL, NULL, 'AI-застосунок, що вчить навичкам КПТ і допомагає відстежувати настрій та впорядковувати думки.', 'An AI app that teaches CBT skills and helps you track your mood and organize your thoughts.', 'Youper використовує розмовний формат, щоб навчати навичкам когнітивно-поведінкової терапії, відстежувати настрій, рефлексувати щодо свого емоційного стану й вести журнал думок. Застосунок не є лікуванням і не замінює фахівця.', 'Youper uses a conversational format to teach cognitive behavioral therapy skills, track your mood, reflect on your emotional well-being and keep a journal of your thoughts. The app is not treatment and does not replace a specialist.', 'Навички КПТ у форматі розмови
Відстеження настрою
Журнал думок', 'CBT skills in a conversational format
Mood tracking
Thought journal', 'Люди, які хочуть опанувати навички КПТ і стежити за своїм настроєм.', 'People who want to learn CBT skills and keep track of their mood.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'youper.ai' OR LOWER(`name`) = 'youper') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI app that teaches CBT skills and helps you track your mood and organize your thoughts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Youper uses a conversational format to teach cognitive behavioral therapy skills, track your mood, reflect on your emotional well-being and keep a journal of your thoughts. The app is not treatment and does not replace a specialist.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'CBT skills in a conversational format
Mood tracking
Thought journal', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to learn CBT skills and keep track of their mood.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Moodfit — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getmoodfit.com' OR LOWER(`name`) = 'moodfit')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Moodfit', NULL, 'https://www.getmoodfit.com', NULL, NULL, 'Набір інструментів для настрою на основі КПТ: відстеження настрою, вправи й спостереження.', 'A CBT-based toolkit for mood: mood tracking, exercises and insights.', 'Moodfit пропонує набір інструментів, які можна налаштувати під себе: відстеження настрою, оцінки, вправи на основі КПТ і спостереження про те, що найбільше впливає на ваш настрій. Є безкоштовний і платний рівні.', 'Moodfit offers a customizable set of tools: mood tracking, assessments, CBT-based exercises and insights into what affects your mood most. There are free and paid tiers.', 'Відстеження настрою
Оцінки самопочуття
Вправи на основі КПТ
Спостереження про чинники настрою', 'Mood tracking
Well-being assessments
CBT-based exercises
Insights into mood factors', 'Люди, які хочуть краще розуміти й підтримувати свій настрій.', 'People who want to understand and support their mood better.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getmoodfit.com' OR LOWER(`name`) = 'moodfit') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A CBT-based toolkit for mood: mood tracking, exercises and insights.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Moodfit offers a customizable set of tools: mood tracking, assessments, CBT-based exercises and insights into what affects your mood most. There are free and paid tiers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Mood tracking
Well-being assessments
CBT-based exercises
Insights into mood factors', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to understand and support their mood better.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Daylio — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'daylio.net' OR LOWER(`name`) = 'daylio')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Daylio', NULL, 'https://daylio.net', NULL, NULL, 'Швидкий трекер настрою й активностей: запис за два дотики, статистика й зв''язки між настроєм і справами.', 'A quick mood and activity tracker: an entry in two taps, stats and links between mood and activities.', 'У Daylio щоденний запис робиться у два дотики: обираєте настрій і активності. Застосунок показує статистику, графіки й зв''язки між настроєм і тим, що ви робили. Шкалу настроїв можна змінювати. Є безкоштовний рівень.', 'In Daylio a daily entry takes two taps: you pick your mood and activities. The app shows stats, charts and correlations between mood and what you did. You can edit the mood scale. There is a free tier.', 'Запис настрою й активностей у два дотики
Статистика й графіки
Зв''язки між настроєм і активностями
Власна шкала настроїв', 'Mood and activity entry in two taps
Stats and charts
Correlations between mood and activities
Custom mood scale', 'Люди, які хочуть просто й швидко вести щоденник настрою.', 'People who want a simple, quick mood journal.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'daylio.net' OR LOWER(`name`) = 'daylio') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A quick mood and activity tracker: an entry in two taps, stats and links between mood and activities.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'In Daylio a daily entry takes two taps: you pick your mood and activities. The app shows stats, charts and correlations between mood and what you did. You can edit the mood scale. There is a free tier.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Mood and activity entry in two taps
Stats and charts
Correlations between mood and activities
Custom mood scale', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want a simple, quick mood journal.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Finch — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'finchcare.com' OR LOWER(`name`) = 'finch')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Finch', NULL, 'https://finchcare.com', NULL, NULL, 'Гейміфікований догляд за собою: м''які звички й віртуальний улюбленець, про якого дбаєте, дбаючи про себе.', 'Gamified self-care: gentle habits and a virtual pet you look after by looking after yourself.', 'У Finch ви доглядаєте за віртуальним улюбленцем, виконуючи невеликі щоденні кроки догляду за собою. Застосунок перетворює м''які звички на гру. Є безкоштовний рівень.', 'In Finch you look after a virtual pet by taking small daily self-care steps. The app turns gentle habits into a game. There is a free tier.', 'Віртуальний улюбленець
Невеликі щоденні кроки догляду за собою
Гейміфікація звичок', 'Virtual pet
Small daily self-care steps
Gamified habits', 'Люди, яким легше дбати про себе в ігровому форматі.', 'People who find self-care easier in a game format.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'finchcare.com' OR LOWER(`name`) = 'finch') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Gamified self-care: gentle habits and a virtual pet you look after by looking after yourself.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'In Finch you look after a virtual pet by taking small daily self-care steps. The app turns gentle habits into a game. There is a free tier.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Virtual pet
Small daily self-care steps
Gamified habits', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who find self-care easier in a game format.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Insight Timer — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'insighttimer.com' OR LOWER(`name`) = 'insight timer')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Insight Timer', NULL, 'https://insighttimer.com', NULL, NULL, 'Велика бібліотека безкоштовних медитацій, практики для сну, спільнота й таймер для тиші.', 'A large library of free meditations, sleep practices, a community and a timer for silent sitting.', 'Insight Timer містить десятки тисяч безкоштовних медитацій і практик для сну та зниження стресу, таймер для медитації в тиші, журнал і відстеження почуттів, а також спільноту. Є безкоштовний рівень і платна підписка.', 'Insight Timer has tens of thousands of free meditations and practices for sleep and stress, a timer for silent meditation, journaling and feeling tracking, and a community. There is a free tier and a paid subscription.', 'Десятки тисяч безкоштовних медитацій
Практики для сну й зниження стресу
Таймер для медитації в тиші
Журнал і спільнота', 'Tens of thousands of free meditations
Practices for sleep and stress
Timer for silent meditation
Journal and community', 'Люди, які хочуть медитувати чи покращити сон.', 'People who want to meditate or sleep better.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'insighttimer.com' OR LOWER(`name`) = 'insight timer') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A large library of free meditations, sleep practices, a community and a timer for silent sitting.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Insight Timer has tens of thousands of free meditations and practices for sleep and stress, a timer for silent meditation, journaling and feeling tracking, and a community. There is a free tier and a paid subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tens of thousands of free meditations
Practices for sleep and stress
Timer for silent meditation
Journal and community', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to meditate or sleep better.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Dario Mind — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dariomind.com' OR LOWER(`name`) = 'dario mind')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dario Mind', NULL, 'https://www.dariomind.com', NULL, NULL, 'Вправи й ігри на основі досліджень для зниження стресу й роботи з негативними думками (колишній Happify).', 'Research-based activities and games for reducing stress and working with negative thoughts (formerly Happify).', 'Dario Mind (Twill) — програма з вправами й іграми, які, за описом розробника, спираються на понад десятиліття академічних досліджень і вчать помічати негативні думки, керувати стресом і розвивати навички подолання труднощів. Нею можна користуватися на смартфоні, планшеті й комп''ютері. Колишній Happify тепер працює під цією назвою. Умови доступу уточнюйте на сайті.', 'Dario Mind (Twill) is a program of activities and games that, according to the developer, are based on more than a decade of academic research and teach you to notice negative thoughts, manage stress and build coping skills. It works on a smartphone, tablet and computer. The former Happify now runs under this name. Check access terms on the website.', 'Вправи й ігри на основі досліджень
Робота з негативними думками й стресом
Смартфон, планшет і комп''ютер', 'Research-based activities and games
Working with negative thoughts and stress
Smartphone, tablet and computer', 'Люди, які хочуть розвивати навички емоційного добробуту в ігровому форматі.', 'People who want to build emotional well-being skills in a game format.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dariomind.com' OR LOWER(`name`) = 'dario mind') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Research-based activities and games for reducing stress and working with negative thoughts (formerly Happify).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Dario Mind (Twill) is a program of activities and games that, according to the developer, are based on more than a decade of academic research and teach you to notice negative thoughts, manage stress and build coping skills. It works on a smartphone, tablet and computer. The former Happify now runs under this name. Check access terms on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Research-based activities and games
Working with negative thoughts and stress
Smartphone, tablet and computer', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to build emotional well-being skills in a game format.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Elomia — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'elomia.com' OR LOWER(`name`) = 'elomia')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Elomia', NULL, 'https://elomia.com', NULL, NULL, 'AI-компаньйон для щоденного емоційного добробуту, створений разом із фахівцями з психічного здоров''я.', 'An AI companion for everyday emotional well-being, built with mental health professionals.', 'Elomia — анонімний AI-компаньйон, доступний цілодобово, для розмов про поганий день, стрес чи пригнічений настрій. За описом розробника, створений разом із фахівцями з психічного здоров''я. Застосунок не замінює психотерапевта.', 'Elomia is an anonymous AI companion, available 24/7, for talking about a bad day, stress or low mood. According to the developer, it is built with mental health professionals. The app does not replace a psychotherapist.', 'Анонімні розмови з AI
Доступно цілодобово
Створено з фахівцями (за описом розробника)', 'Anonymous AI conversations
Available 24/7
Built with professionals (according to the developer)', 'Люди, яким потрібна підтримка в розмові про щоденні емоційні труднощі.', 'People who want supportive conversation about everyday emotional difficulties.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'elomia.com' OR LOWER(`name`) = 'elomia') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI companion for everyday emotional well-being, built with mental health professionals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Elomia is an anonymous AI companion, available 24/7, for talking about a bad day, stress or low mood. According to the developer, it is built with mental health professionals. The app does not replace a psychotherapist.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Anonymous AI conversations
Available 24/7
Built with professionals (according to the developer)', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want supportive conversation about everyday emotional difficulties.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- 7 Cups — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '7cups.com' OR LOWER(`name`) = '7 cups')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT '7 Cups', NULL, 'https://www.7cups.com', NULL, NULL, 'Платформа взаємної підтримки: безкоштовні чати з волонтерами-слухачами й платна онлайн-терапія.', 'A peer support platform: free chats with volunteer listeners and paid online therapy.', '7 Cups з''єднує людей із волонтерами-слухачами для безкоштовної емоційної підтримки в чаті й має велику спільноту. Окремо на платформі доступна платна онлайн-терапія з фахівцями. Слухачі не є терапевтами, і в гострій ситуації варто звернутися до екстреної служби. Умови й доступність уточнюйте на сайті.', '7 Cups connects people with volunteer listeners for free emotional support in chat and has a large community. Paid online therapy with professionals is also available on the platform. Listeners are not therapists, and in an acute situation you should contact emergency services. Check terms and availability on the website.', 'Безкоштовні чати з волонтерами-слухачами
Спільнота взаємної підтримки
Платна онлайн-терапія', 'Free chats with volunteer listeners
Peer support community
Paid online therapy', 'Люди, яким хочеться поговорити з кимось і отримати підтримку.', 'People who want someone to talk to and some support.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '7cups.com' OR LOWER(`name`) = '7 cups') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A peer support platform: free chats with volunteer listeners and paid online therapy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', '7 Cups connects people with volunteer listeners for free emotional support in chat and has a large community. Paid online therapy with professionals is also available on the platform. Listeners are not therapists, and in an acute situation you should contact emergency services. Check terms and availability on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free chats with volunteer listeners
Peer support community
Paid online therapy', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want someone to talk to and some support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Чати з волонтерами-слухачами.', 'Chats with volunteer listeners.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Chats with volunteer listeners.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- BetterHelp — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'betterhelp.com' OR LOWER(`name`) = 'betterhelp')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BetterHelp', NULL, 'https://www.betterhelp.com', NULL, NULL, 'Платформа онлайн-терапії за підпискою: повідомлення, дзвінки й відео з ліцензованим терапевтом.', 'A subscription online therapy platform: messages, calls and video with a licensed therapist.', 'BetterHelp підбирає ліцензованого терапевта, з яким можна спілкуватися повідомленнями, телефоном і відео. Сервіс належить Teladoc Health; для пар є Regain, для підлітків — Teen Counseling. Умови й доступність у вашій країні уточнюйте на сайті сервісу. Чи є фахівці з РХП, уточнюйте на сайті.', 'BetterHelp matches you with a licensed therapist you can talk to by message, phone and video. The service is owned by Teladoc Health; Regain is for couples and Teen Counseling is for teenagers. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'Підбір ліцензованого терапевта
Повідомлення, дзвінки й відео
Підписка', 'Matching with a licensed therapist
Messages, calls and video
Subscription', 'Дорослі, які шукають онлайн-терапію.', 'Adults looking for online therapy.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'betterhelp.com' OR LOWER(`name`) = 'betterhelp') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A subscription online therapy platform: messages, calls and video with a licensed therapist.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'BetterHelp matches you with a licensed therapist you can talk to by message, phone and video. The service is owned by Teladoc Health; Regain is for couples and Teen Counseling is for teenagers. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Matching with a licensed therapist
Messages, calls and video
Subscription', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adults looking for online therapy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Talkspace — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'talkspace.com' OR LOWER(`name`) = 'talkspace')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Talkspace', NULL, 'https://www.talkspace.com', NULL, NULL, 'Онлайн-терапія з акцентом на повідомлення, з живими відеосесіями й психіатрією.', 'Online therapy focused on messaging, with live video sessions and psychiatry.', 'Talkspace пропонує терапію переважно через повідомлення, а також живі відеосесії й психіатричну допомогу. Умови й доступність у вашій країні уточнюйте на сайті сервісу. Чи є фахівці з РХП, уточнюйте на сайті.', 'Talkspace offers therapy mainly through messaging, as well as live video sessions and psychiatric care. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'Терапія через повідомлення
Живі відеосесії
Психіатрія', 'Therapy by messaging
Live video sessions
Psychiatry', 'Люди, які шукають онлайн-терапію чи психіатра.', 'People looking for online therapy or a psychiatrist.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'talkspace.com' OR LOWER(`name`) = 'talkspace') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Online therapy focused on messaging, with live video sessions and psychiatry.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Talkspace offers therapy mainly through messaging, as well as live video sessions and psychiatric care. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Therapy by messaging
Live video sessions
Psychiatry', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People looking for online therapy or a psychiatrist.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Amwell — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'amwell.com' OR LOWER(`name`) = 'amwell')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Amwell', NULL, 'https://amwell.com', NULL, NULL, 'Телемедицина, що включає онлайн-терапію й психіатрію через відеосесії.', 'Telehealth that includes online therapy and psychiatry through video sessions.', 'Amwell — платформа телемедицини, через яку можна отримати онлайн-терапію й психіатричну допомогу у відеоформаті. Умови й доступність у вашій країні уточнюйте на сайті сервісу. Чи є фахівці з РХП, уточнюйте на сайті.', 'Amwell is a telehealth platform that offers online therapy and psychiatric care by video. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'Онлайн-терапія
Психіатрія через відео
Телемедицина', 'Online therapy
Psychiatry by video
Telehealth', 'Люди, які шукають онлайн-консультацію з психічного здоров''я.', 'People looking for an online mental health consultation.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'amwell.com' OR LOWER(`name`) = 'amwell') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Telehealth that includes online therapy and psychiatry through video sessions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Amwell is a telehealth platform that offers online therapy and psychiatric care by video. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online therapy
Psychiatry by video
Telehealth', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People looking for an online mental health consultation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Teladoc Health — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'teladochealth.com' OR LOWER(`name`) = 'teladoc health')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Teladoc Health', NULL, 'https://www.teladochealth.com', NULL, NULL, 'Телемедицина з підтримкою психічного здоров''я та загальною медичною допомогою.', 'Telehealth with mental health support and general medical care.', 'Teladoc Health надає віртуальну медичну допомогу: консультації лікарів, підтримку психічного здоров''я й допомогу вузьких спеціалістів. Умови й доступність у вашій країні уточнюйте на сайті сервісу. Чи є фахівці з РХП, уточнюйте на сайті.', 'Teladoc Health provides virtual care: doctor consultations, mental health support and specialty care. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'Підтримка психічного здоров''я
Віртуальні консультації лікарів
Допомога вузьких спеціалістів', 'Mental health support
Virtual doctor consultations
Specialty care', 'Люди й організації, яким потрібна віртуальна медична допомога.', 'People and organizations that need virtual care.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'teladochealth.com' OR LOWER(`name`) = 'teladoc health') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Telehealth with mental health support and general medical care.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Teladoc Health provides virtual care: doctor consultations, mental health support and specialty care. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Mental health support
Virtual doctor consultations
Specialty care', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People and organizations that need virtual care.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Grow Therapy — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'growtherapy.com' OR LOWER(`name`) = 'grow therapy')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Grow Therapy', NULL, 'https://growtherapy.com', NULL, NULL, 'Підбір терапевтів онлайн і поруч із вами з орієнтацією на роботу зі страховими планами.', 'Finding therapists online and near you, focused on working with insurance plans.', 'Grow Therapy допомагає знайти терапевта онлайн або поруч, з фільтрами за потребами й можливістю перевірити, чи приймає фахівець вашу страховку. Умови й доступність у вашій країні уточнюйте на сайті сервісу. Чи є фахівці з РХП, уточнюйте на сайті.', 'Grow Therapy helps you find a therapist online or nearby, with filters by need and a way to check whether the provider takes your insurance. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'Підбір терапевта
Фільтри за потребами
Перевірка страховки', 'Finding a therapist
Filters by need
Insurance check', 'Люди, які шукають терапевта зі страховим покриттям.', 'People looking for a therapist covered by insurance.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'growtherapy.com' OR LOWER(`name`) = 'grow therapy') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Finding therapists online and near you, focused on working with insurance plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Grow Therapy helps you find a therapist online or nearby, with filters by need and a way to check whether the provider takes your insurance. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Finding a therapist
Filters by need
Insurance check', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People looking for a therapist covered by insurance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Online-Therapy.com — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'online-therapy.com' OR LOWER(`name`) = 'online-therapy.com')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Online-Therapy.com', NULL, 'https://www.online-therapy.com', NULL, NULL, 'Онлайн-терапія з набором інструментів КПТ: сесії з терапевтом, журнал і вправи.', 'Online therapy with a CBT toolbox: sessions with a therapist, a journal and exercises.', 'Online-Therapy.com поєднує сесії з терапевтом із «набором інструментів» на основі КПТ, зокрема журналом і вправами. Умови й доступність у вашій країні уточнюйте на сайті сервісу. Чи є фахівці з РХП, уточнюйте на сайті.', 'Online-Therapy.com combines sessions with a therapist and a CBT-based "toolbox", including a journal and exercises. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'Сесії з терапевтом
Інструменти на основі КПТ
Журнал і вправи', 'Sessions with a therapist
CBT-based tools
Journal and exercises', 'Люди, яким підходить структурований підхід КПТ онлайн.', 'People who prefer a structured CBT approach online.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'online-therapy.com' OR LOWER(`name`) = 'online-therapy.com') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Online therapy with a CBT toolbox: sessions with a therapist, a journal and exercises.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Online-Therapy.com combines sessions with a therapist and a CBT-based "toolbox", including a journal and exercises. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sessions with a therapist
CBT-based tools
Journal and exercises', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who prefer a structured CBT approach online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Brightside Health — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brightside.com' OR LOWER(`name`) = 'brightside health')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Brightside Health', NULL, 'https://www.brightside.com', NULL, NULL, 'Терапія й медикаментозний супровід при депресії й тривозі з відстеженням прогресу.', 'Therapy and medication support for depression and anxiety, with progress tracking.', 'Brightside Health — віртуальна допомога при депресії й тривозі: терапія з ліцензованими фахівцями, психіатричний і медикаментозний супровід та відстеження прогресу. Умови й доступність у вашій країні уточнюйте на сайті сервісу. Чи є фахівці з РХП, уточнюйте на сайті.', 'Brightside Health offers virtual care for depression and anxiety: therapy with licensed clinicians, psychiatric and medication support, and progress tracking. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'Терапія при депресії й тривозі
Психіатричний і медикаментозний супровід
Відстеження прогресу', 'Therapy for depression and anxiety
Psychiatric and medication support
Progress tracking', 'Дорослі з депресією чи тривогою, які шукають віртуальну допомогу.', 'Adults with depression or anxiety looking for virtual care.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brightside.com' OR LOWER(`name`) = 'brightside health') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Therapy and medication support for depression and anxiety, with progress tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Brightside Health offers virtual care for depression and anxiety: therapy with licensed clinicians, psychiatric and medication support, and progress tracking. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Therapy for depression and anxiety
Psychiatric and medication support
Progress tracking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adults with depression or anxiety looking for virtual care.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Thriveworks — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thriveworks.com' OR LOWER(`name`) = 'thriveworks')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Thriveworks', NULL, 'https://thriveworks.com', NULL, NULL, 'Консультації з психічного здоров''я онлайн і очно зі страховим покриттям і відстеженням прогресу.', 'Mental health counseling online and in person, with insurance coverage and progress tracking.', 'Thriveworks дає доступ до терапевтів і психіатрів онлайн або очно, приймає страхові плани й пропонує програму відстеження прогресу. Умови й доступність у вашій країні уточнюйте на сайті сервісу. Чи є фахівці з РХП, уточнюйте на сайті.', 'Thriveworks gives access to therapists and psychiatrists online or in person, accepts insurance plans and offers a progress-tracking program. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'Терапевти й психіатри онлайн або очно
Страхове покриття
Відстеження прогресу', 'Therapists and psychiatrists online or in person
Insurance coverage
Progress tracking', 'Люди, які шукають терапевта чи психіатра зі страховим покриттям.', 'People looking for a therapist or psychiatrist covered by insurance.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thriveworks.com' OR LOWER(`name`) = 'thriveworks') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mental health counseling online and in person, with insurance coverage and progress tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Thriveworks gives access to therapists and psychiatrists online or in person, accepts insurance plans and offers a progress-tracking program. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Therapists and psychiatrists online or in person
Insurance coverage
Progress tracking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People looking for a therapist or psychiatrist covered by insurance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Regain — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'regain.us' OR LOWER(`name`) = 'regain')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Regain', NULL, 'https://www.regain.us', NULL, NULL, 'Сервіс онлайн-терапії для стосунків і пар від BetterHelp.', 'An online relationship and couples therapy service from BetterHelp.', 'Regain — сервіс BetterHelp для терапії стосунків: онлайн-сесії з ліцензованими терапевтами. Умови й доступність у вашій країні уточнюйте на сайті сервісу. Чи є фахівці з РХП, уточнюйте на сайті.', 'Regain is BetterHelp''s relationship therapy service: online sessions with licensed therapists. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'Терапія для пар
Ліцензовані терапевти
Онлайн-сесії', 'Couples therapy
Licensed therapists
Online sessions', 'Пари, які хочуть працювати над стосунками.', 'Couples who want to work on their relationship.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'regain.us' OR LOWER(`name`) = 'regain') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An online relationship and couples therapy service from BetterHelp.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Regain is BetterHelp''s relationship therapy service: online sessions with licensed therapists. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Couples therapy
Licensed therapists
Online sessions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Couples who want to work on their relationship.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Teen Counseling — Ментальне здоров'я та харчова поведінка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'teencounseling.com' OR LOWER(`name`) = 'teen counseling')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Teen Counseling', NULL, 'https://www.teencounseling.com', NULL, NULL, 'Сервіс онлайн-терапії для підлітків від BetterHelp.', 'An online therapy service for teenagers from BetterHelp.', 'Teen Counseling — сервіс BetterHelp, у якому підлітки можуть працювати з ліцензованими терапевтами онлайн. Умови й доступність у вашій країні уточнюйте на сайті сервісу. Чи є фахівці з РХП, уточнюйте на сайті.', 'Teen Counseling is a BetterHelp service where teenagers can work with licensed therapists online. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'Терапія для підлітків
Ліцензовані терапевти
Онлайн-сесії', 'Therapy for teenagers
Licensed therapists
Online sessions', 'Підлітки та їхні батьки.', 'Teenagers and their parents.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'teencounseling.com' OR LOWER(`name`) = 'teen counseling') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An online therapy service for teenagers from BetterHelp.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Teen Counseling is a BetterHelp service where teenagers can work with licensed therapists online. Check terms and availability in your country on the service website. Ask on the website whether eating disorder specialists are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Therapy for teenagers
Licensed therapists
Online sessions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teenagers and their parents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', NULL, 'one_time', 'Актуальні ціни й умови — на офіційному сайті сервісу.', 'Current prices and terms are on the service''s official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices and terms are on the service''s official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Calm — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Calm') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Wysa — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Wysa') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Headspace — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Headspace') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Rosebud — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Rosebud') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Ash (Slingshot AI) — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Ash (Slingshot AI)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Earkick — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Earkick') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Mindsera — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Mindsera') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Kin — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Kin') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- NEUROFIT — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('NEUROFIT') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Elite HRV — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Elite HRV') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Welltory — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Welltory') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Replika — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Replika') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Upheal — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Upheal') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Mentalyc — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Mentalyc') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Blueprint — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Blueprint') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Lyssn — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Lyssn') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Limbic — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Limbic') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Breathwrk — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Breathwrk') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Healthy Gamer — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Healthy Gamer') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Buddhify — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Buddhify') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Plum Village App — додатково в «Ментальне здоров'я та харчова поведінка»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Plum Village App') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

