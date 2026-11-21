SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-21: «Українські додатки» / «Ukrainian Apps» (slug ukrainian-apps) — стоматологія й лабораторії до 10.
-- + 7 нових продуктів і 2 прив'язки наявних (функцію звірено на офіційних сайтах 2026-11-21).
-- Якщо продукт із такою адресою чи назвою вже є — лише прив'язка, тексти не змінюються.
-- Тексти UA/EN — за офіційними сайтами, звірено 2026-11-21.
-- Прив'язки: Клініка Віва (стоматологічні центри VIVA), Добробут (4 стоматології) — ua-dental.
-- Пропущено: medlab.ua (магазин обладнання, не лабораторія), Into-Sana (багатопрофільна лікарня), Dentify (403), Люмі-Дент (російська).
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   DentArt — ua-dental (новий)
--   MistoDent — ua-dental (новий)
--   Cliniccards — ua-dental (новий)
--   VitaLab — ua-labs (новий)
--   ДНК-Лабораторія — ua-labs (новий)
--   Hemo Medika — ua-labs (новий)
--   Діасервіс — ua-labs (новий)
--   Клініка Віва — ua-dental (наявний, прив'язка)
--   Добробут — ua-dental (наявний, прив'язка)
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
-- DentArt
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dent-art.com.ua' OR LOWER(`name`) = 'dentart')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DentArt', NULL, 'https://dent-art.com.ua', NULL, NULL, 'Стоматологічна клініка в Києві з 2010 року: вузькі спеціалісти, КТ і 3D-сканування, онлайн-консультація.', 'Dental clinic in Kyiv since 2010: specialist dentists, CT and 3D scanning, online consultation.', 'DentArt («Дент Арт») — приватна стоматологічна клініка в Києві, що працює з 2010 року. Кожен лікар веде свою спеціалізацію: терапія й ендодонтія під мікроскопом, пародонтологія, ортопедія (коронки, вініри, протезування на імплантатах за цифровими протоколами), ортодонтія з брекетами й елайнерами, хірургія та імплантація, гнатологія, дитяча стоматологія. Для діагностики — КТ щелеп, телерентгенограма й внутрішньоротове 3D-сканування. На першій консультації пацієнт отримує план лікування й кошторис за етапами; візити допомагає організувати куратор. Можна почати з онлайн-консультації, якщо ви за кордоном або маєте мало часу.', 'DentArt is a private dental clinic in Kyiv operating since 2010. Each dentist works in their own specialty: microscope-assisted endodontics and restorative care, periodontology, prosthodontics (crowns, veneers, implant-supported prosthetics using digital protocols), orthodontics with braces and aligners, surgery and implants, gnathology and paediatric dentistry. Diagnostics include jaw CT, cephalometric X-rays and intraoral 3D scanning. At the first consultation the patient gets a treatment plan and a cost estimate by stage, and a personal coordinator helps arrange visits. You can start with an online consultation if you are abroad or short on time.', 'Вузькі спеціалісти з усіх напрямків
КТ і 3D-сканування
План і кошторис за етапами
Куратор пацієнта
Онлайн-консультація', 'Specialists in every field
CT and 3D scanning
Treatment plan and estimate by stage
Personal patient coordinator
Online consultation', 'Дорослим і дітям у Києві, а також українцям за кордоном, які планують лікування зубів.', 'Adults and children in Kyiv, and Ukrainians abroad planning dental treatment.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dent-art.com.ua' OR LOWER(`name`) = 'dentart') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-dental' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Dental clinic in Kyiv since 2010: specialist dentists, CT and 3D scanning, online consultation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'DentArt is a private dental clinic in Kyiv operating since 2010. Each dentist works in their own specialty: microscope-assisted endodontics and restorative care, periodontology, prosthodontics (crowns, veneers, implant-supported prosthetics using digital protocols), orthodontics with braces and aligners, surgery and implants, gnathology and paediatric dentistry. Diagnostics include jaw CT, cephalometric X-rays and intraoral 3D scanning. At the first consultation the patient gets a treatment plan and a cost estimate by stage, and a personal coordinator helps arrange visits. You can start with an online consultation if you are abroad or short on time.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Specialists in every field
CT and 3D scanning
Treatment plan and estimate by stage
Personal patient coordinator
Online consultation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adults and children in Kyiv, and Ukrainians abroad planning dental treatment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MistoDent
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mistodent.com.ua' OR LOWER(`name`) = 'mistodent')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MistoDent', NULL, 'https://www.mistodent.com.ua', NULL, NULL, 'Мережа цифрових стоматологій у Харкові, Львові, Ужгороді, Варшаві й Кракові; лікування частинами з monobank.', 'Digital dentistry network in Kharkiv, Lviv, Uzhhorod, Warsaw and Krakow; pay in instalments with monobank.', 'MistoDent — мережа стоматологічних центрів у Харкові, Львові, Ужгороді, Варшаві та Кракові, що працює за принципами цифрової стоматології. Послуги: комплексна цифрова діагностика, пародонтологія, лікування карієсу й каналів під мікроскопом, ортодонтія з брекетами й елайнерами, коронки й вініри, імплантація, відбілювання, дитяча стоматологія та лікування під наркозом. Понад 17 тисяч пацієнтів щороку. Лікування можна оплатити частинами через monobank. Записатися — через форму на сайті або в месенджері.', 'MistoDent is a network of dental centres in Kharkiv, Lviv, Uzhhorod, Warsaw and Krakow built around digital dentistry. Services include comprehensive digital diagnostics, periodontology, microscope-assisted caries and root canal treatment, orthodontics with braces and aligners, crowns and veneers, implants, whitening, paediatric dentistry and treatment under general anaesthesia. Over 17,000 patients a year. Treatment can be paid in instalments via monobank. Book through the website form or a messenger.', 'Цифрова діагностика
Клініки в Україні та Польщі
Дитяча стоматологія й наркоз
Елайнери та брекети
Оплата частинами з monobank', 'Digital diagnostics
Clinics in Ukraine and Poland
Paediatric dentistry and anaesthesia
Aligners and braces
Instalments with monobank', 'Пацієнтам у Харкові, Львові, Ужгороді та українцям у Польщі, яким потрібне лікування зубів.', 'Patients in Kharkiv, Lviv, Uzhhorod and Ukrainians in Poland who need dental care.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mistodent.com.ua' OR LOWER(`name`) = 'mistodent') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-dental' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Digital dentistry network in Kharkiv, Lviv, Uzhhorod, Warsaw and Krakow; pay in instalments with monobank.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MistoDent is a network of dental centres in Kharkiv, Lviv, Uzhhorod, Warsaw and Krakow built around digital dentistry. Services include comprehensive digital diagnostics, periodontology, microscope-assisted caries and root canal treatment, orthodontics with braces and aligners, crowns and veneers, implants, whitening, paediatric dentistry and treatment under general anaesthesia. Over 17,000 patients a year. Treatment can be paid in instalments via monobank. Book through the website form or a messenger.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Digital diagnostics
Clinics in Ukraine and Poland
Paediatric dentistry and anaesthesia
Aligners and braces
Instalments with monobank', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Patients in Kharkiv, Lviv, Uzhhorod and Ukrainians in Poland who need dental care.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Cliniccards
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cliniccards.com/ua' OR LOWER(`name`) = 'cliniccards')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Cliniccards', NULL, 'https://cliniccards.com/ua', NULL, NULL, 'CRM для стоматологічних клінік: картки пацієнтів, розклад, плани лікування, КТ онлайн, фінанси й eHealth.', 'CRM for dental clinics: patient records, schedule, treatment plans, online CT viewing, finances and eHealth.', 'Cliniccards — система управління стоматологічною клінікою, якою користуються клініки Києва, Львова, Чернівців та інших міст. Тут ведуть медичні картки пацієнтів, інтерактивний розклад і онлайн-запис, зрозумілі пацієнтові плани й етапи лікування. КТ та інші діагностичні дані (фото, файли, скани) зберігаються й переглядаються онлайн у хронологічному порядку. Є облік матеріалів і препаратів, модуль задач, понад 40 фінансових та операційних звітів, P&L і розрахунок зарплат, а також реєстрація в системі eHealth. Безкоштовна версія — для збереження й обміну картками пацієнтів; повний функціонал для клініки коштує 70 доларів на місяць за кожного запрошеного спеціаліста.', 'Cliniccards is a dental clinic management system used by clinics in Kyiv, Lviv, Chernivtsi and other cities. It holds patient medical records, an interactive schedule with online booking, and treatment plans and stages that patients can understand. CT scans and other diagnostic data (photos, files, scans) are stored and viewed online in chronological order. It also offers inventory of materials and drugs, a tasks module, over 40 financial and operational reports, P&L and payroll, and registration in the Ukrainian eHealth system. The free version covers storing and sharing patient cards; the full clinic feature set costs $70 per month for each invited specialist.', 'Медичні картки пацієнтів
Розклад і онлайн-запис
Перегляд КТ онлайн
Понад 40 звітів, P&L і зарплати
Реєстрація в eHealth', 'Patient medical records
Schedule and online booking
Online CT viewer
40+ reports, P&L and payroll
eHealth registration', 'Власникам і лікарям стоматологічних клінік, адміністраторам.', 'Dental clinic owners, dentists and front-desk staff.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cliniccards.com/ua' OR LOWER(`name`) = 'cliniccards') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-dental' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'CRM for dental clinics: patient records, schedule, treatment plans, online CT viewing, finances and eHealth.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Cliniccards is a dental clinic management system used by clinics in Kyiv, Lviv, Chernivtsi and other cities. It holds patient medical records, an interactive schedule with online booking, and treatment plans and stages that patients can understand. CT scans and other diagnostic data (photos, files, scans) are stored and viewed online in chronological order. It also offers inventory of materials and drugs, a tasks module, over 40 financial and operational reports, P&L and payroll, and registration in the Ukrainian eHealth system. The free version covers storing and sharing patient cards; the full clinic feature set costs $70 per month for each invited specialist.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Patient medical records
Schedule and online booking
Online CT viewer
40+ reports, P&L and payroll
eHealth registration', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dental clinic owners, dentists and front-desk staff.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'month', 'Збереження фото й файлів до 10 МБ, обмін картками й етапами лікування.', 'Photo and file storage up to 10 MB, sharing patient cards and treatment stages.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Photo and file storage up to 10 MB, sharing patient cards and treatment stages.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Для клінік', 'For Clinics', 70.00, 'month', 'За кожного спеціаліста: розклад, фінанси, плани лікування, звіти й зарплати.', 'Per specialist: scheduling, finances, treatment plans, reports and payroll.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Для клінік' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'For Clinics', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per specialist: scheduling, finances, treatment plans, reports and payroll.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- VitaLab
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vitalab.com.ua' OR LOWER(`name`) = 'vitalab')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'VitaLab', NULL, 'https://vitalab.com.ua', NULL, NULL, 'Українська медична лабораторія з акредитацією ISO 15189: 22 пункти, замовлення, оплата й результати онлайн.', 'Ukrainian medical laboratory accredited to ISO 15189: 22 sites, online ordering, payment and results.', 'VitaLab — сучасна українська медична лабораторія, акредитована за міжнародним стандартом ISO 15189:2022. Працює 22 лабораторні центри й пункти забору, можна викликати медсестру додому чи в офіс. На сайті — каталог аналізів і пакетів, кошик, онлайн-оплата та результати в особистому кабінеті. Є знижки військовим, ВПО й пенсіонерам, регулярні акції на чекапи, а також лабораторні дослідження в Німеччині. Понад 400 тисяч досліджень і 90 тисяч пацієнтів на рік.', 'VitaLab is a modern Ukrainian medical laboratory accredited to the international ISO 15189:2022 standard. It runs 22 laboratory centres and collection points, and you can call a nurse to your home or office. The website has a catalogue of tests and packages, a cart, online payment and results in a personal account. There are discounts for military personnel, internally displaced people and pensioners, regular check-up promotions, and lab testing in Germany. Over 400,000 tests and 90,000 patients a year.', 'Акредитація ISO 15189:2022
22 пункти забору
Замовлення й оплата онлайн
Результати в кабінеті
Виклик медсестри додому', 'ISO 15189:2022 accreditation
22 collection points
Online ordering and payment
Results in your account
Nurse home visits', 'Усім, хто здає аналізи й хоче замовити та оплатити їх онлайн.', 'Anyone taking lab tests who wants to order and pay for them online.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vitalab.com.ua' OR LOWER(`name`) = 'vitalab') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-labs' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ukrainian medical laboratory accredited to ISO 15189: 22 sites, online ordering, payment and results.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'VitaLab is a modern Ukrainian medical laboratory accredited to the international ISO 15189:2022 standard. It runs 22 laboratory centres and collection points, and you can call a nurse to your home or office. The website has a catalogue of tests and packages, a cart, online payment and results in a personal account. There are discounts for military personnel, internally displaced people and pensioners, regular check-up promotions, and lab testing in Germany. Over 400,000 tests and 90,000 patients a year.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'ISO 15189:2022 accreditation
22 collection points
Online ordering and payment
Results in your account
Nurse home visits', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone taking lab tests who wants to order and pay for them online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ДНК-Лабораторія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dnk-lab.com.ua' OR LOWER(`name`) = 'днк-лабораторія')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ДНК-Лабораторія', NULL, 'https://www.dnk-lab.com.ua', NULL, NULL, 'Київська лабораторія з п''ятьма пунктами забору: прайс аналізів, результати онлайн, безкоштовне питання фахівцю, УЗД.', 'Kyiv laboratory with five collection points: test price list, online results, free questions to a specialist, ultrasound.', 'ДНК-Лабораторія — медична лабораторія в Києві з пунктами забору біля метро Дорогожичі, Позняки, Шулявська, на Оболоні й Троєщині. На сайті є прайс-лист досліджень, видача результатів через онлайн-сервіс із можливістю завантажити бланк, норми аналізів і правила підготовки. Можна безкоштовно поставити питання фахівцю онлайн. Окремо — ультразвукова діагностика: УЗД органів, еластографія, доплер судин, ехокардіографія. Військовим — знижка 15% на будь-які обстеження.', 'DNK-Laboratoriya is a medical laboratory in Kyiv with collection points near Dorohozhychi, Pozniaky and Shuliavska metro stations, in Obolon and Troieshchyna. The website has a test price list, an online service for getting results with a downloadable report, reference ranges and preparation rules. You can ask a specialist a question online for free. It also offers ultrasound: organ scans, elastography, vascular Doppler and echocardiography. Military personnel get 15% off any tests.', 'П''ять пунктів забору в Києві
Результати онлайн
Безкоштовне питання фахівцю
УЗД і доплер
Знижка 15% військовим', 'Five collection points in Kyiv
Online results
Free questions to a specialist
Ultrasound and Doppler
15% off for military', 'Киянам, які здають аналізи й хочуть отримати результати онлайн.', 'Kyiv residents taking lab tests who want their results online.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dnk-lab.com.ua' OR LOWER(`name`) = 'днк-лабораторія') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-labs' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Kyiv laboratory with five collection points: test price list, online results, free questions to a specialist, ultrasound.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'DNK-Laboratoriya is a medical laboratory in Kyiv with collection points near Dorohozhychi, Pozniaky and Shuliavska metro stations, in Obolon and Troieshchyna. The website has a test price list, an online service for getting results with a downloadable report, reference ranges and preparation rules. You can ask a specialist a question online for free. It also offers ultrasound: organ scans, elastography, vascular Doppler and echocardiography. Military personnel get 15% off any tests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Five collection points in Kyiv
Online results
Free questions to a specialist
Ultrasound and Doppler
15% off for military', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Kyiv residents taking lab tests who want their results online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hemo Medika
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hemomedika.com.ua' OR LOWER(`name`) = 'hemo medika')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hemo Medika', NULL, 'https://hemomedika.com.ua', NULL, NULL, 'Мережа медичних лабораторій: 115 відділень у понад 82 містах, замовлення аналізів і результати в додатку.', 'Medical laboratory network: 115 branches in 82+ cities, test ordering and results in the app.', 'Hemo Medika — українська мережа медичних лабораторій із 115 відділеннями в понад 82 містах. На сайті можна знайти аналіз, оформити замовлення й зареєструвати профіль за номером телефону, щоб переглядати результати на будь-якому пристрої. Для швидкої перевірки достатньо ввести номер телефону — і отримати інформацію про результати останніх аналізів. Мобільний додаток Hemo Medika дає доступ до особистого кабінету 24/7.', 'Hemo Medika is a Ukrainian network of medical laboratories with 115 branches in more than 82 cities. On the website you can find a test, place an order and register a profile with your phone number to view results on any device. For a quick check, enter your phone number to get information about your latest test results. The Hemo Medika mobile app gives 24/7 access to your personal account.', '115 відділень у 82+ містах
Замовлення аналізів онлайн
Результати за номером телефону
Мобільний додаток
Кабінет 24/7', '115 branches in 82+ cities
Order tests online
Results by phone number
Mobile app
24/7 personal account', 'Усім, хто здає аналізи в Україні, зокрема в невеликих містах.', 'Anyone taking lab tests in Ukraine, including in smaller towns.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hemomedika.com.ua' OR LOWER(`name`) = 'hemo medika') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-labs' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Medical laboratory network: 115 branches in 82+ cities, test ordering and results in the app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hemo Medika is a Ukrainian network of medical laboratories with 115 branches in more than 82 cities. On the website you can find a test, place an order and register a profile with your phone number to view results on any device. For a quick check, enter your phone number to get information about your latest test results. The Hemo Medika mobile app gives 24/7 access to your personal account.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '115 branches in 82+ cities
Order tests online
Results by phone number
Mobile app
24/7 personal account', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone taking lab tests in Ukraine, including in smaller towns.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Діасервіс
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'diaservis.ua' OR LOWER(`name`) = 'діасервіс')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Діасервіс', NULL, 'https://diaservis.ua', NULL, NULL, 'Медична компанія з 69 філіями: аналізи з онлайн-оплатою (−10%), виїзд лабораторної бригади додому, лікарі.', 'Medical company with 69 branches: lab tests with online payment (10% off), home sample collection, doctors.', 'ДІАСЕРВІС — українська медична компанія з 69 філіями по всій країні; багато пунктів забору — у Дніпрі та Дніпропетровській області. Основа — лабораторні аналізи в пунктах забору; на сайті видно завантаженість кожного відділення. Замовлення можна оплатити онлайн і отримати 10% знижки та обслуговування без черги. Є виїзд лабораторної бригади додому, скринінг здоров''я 40+, консультації лікарів, діагностика, реабілітація й сімейні амбулаторії в Запоріжжі.', 'DIASERVIS is a Ukrainian medical company with 69 branches across the country, many of its collection points in Dnipro and the Dnipropetrovsk region. Its core is lab testing at collection points; the website shows how busy each branch is. Orders can be paid online for a 10% discount and no-queue service. It also offers home sample collection, the national 40+ health screening, doctor consultations, diagnostics, rehabilitation and family clinics in Zaporizhzhia.', '69 філій
Завантаженість відділень онлайн
−10% при онлайн-оплаті
Виїзд лаборанта додому
Скринінг здоров''я 40+', '69 branches
Live branch occupancy
10% off with online payment
Home sample collection
40+ health screening', 'Усім, хто здає аналізи, зокрема мешканцям Дніпра й Запоріжжя.', 'Anyone taking lab tests, especially in Dnipro and Zaporizhzhia.', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-21 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'diaservis.ua' OR LOWER(`name`) = 'діасервіс') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-labs' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Medical company with 69 branches: lab tests with online payment (10% off), home sample collection, doctors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'DIASERVIS is a Ukrainian medical company with 69 branches across the country, many of its collection points in Dnipro and the Dnipropetrovsk region. Its core is lab testing at collection points; the website shows how busy each branch is. Orders can be paid online for a 10% discount and no-queue service. It also offers home sample collection, the national 40+ health screening, doctor consultations, diagnostics, rehabilitation and family clinics in Zaporizhzhia.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '69 branches
Live branch occupancy
10% off with online payment
Home sample collection
40+ health screening', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone taking lab tests, especially in Dnipro and Zaporizhzhia.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Прив'язки наявних продуктів (за назвою, без id)
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'клініка віва' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-dental' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'добробут' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-dental' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
