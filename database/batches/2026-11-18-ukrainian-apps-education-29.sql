SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-18: «Українські додатки» / «Ukrainian Apps» (slug ukrainian-apps): школи й електронні щоденники, садочки, університети, підготовка до НМТ, IT-курси та онлайн-школи англійської.
-- Нові підкатегорії:
--   * Школи, садочки та університети / Schools, Kindergartens & Universities (slug ua-schools)
--   * Підготовка до НМТ / NMT & Exam Prep (slug ua-exams)
--   * Курси та онлайн-школи / Courses & Online Schools (slug ua-courses)
-- + 29 продуктів (якщо продукт із такою адресою чи назвою вже є — лише прив'язка, тексти не змінюються).
-- Тексти UA/EN написано за офіційними описами застосунків в App Store (регіон UA) та сайтами, звірено 2026-11-18.
-- Ціни не вказано: план «Ціна: див. сайт» (0, one_time); Free — застосунок безкоштовний у магазині застосунків.
-- Пропущено: NZ.UA «Журнали та щоденники» (стара версія з 2021, додано нову), KPI Hub (з 2023), Upword (походження не підтверджено),
--   Laba/Skvot (польські версії застосунків), Novakid, Lingualeo, Skyeng (не українські); Mate academy, Hillel, Promova, Prometheus уже є в каталозі — лише привʼязка.
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   NZ.UA — електронні журнали — Школи, садочки та університети, Освіта
--   My School — щоденник — Школи, садочки та університети
--   Sadok — Школи, садочки та університети, Для бізнесу та ФОП
--   ЄАС — Єдина атестаційна система — Школи, садочки та університети, Освіта
--   Обирай ХАІ — Школи, садочки та університети
--   Learning.ua — Школи, садочки та університети, Освіта
--   Просте ЗНО/НМТ — Підготовка до НМТ
--   НМТ на 200 — Підготовка до НМТ
--   MathCorp — НМТ/ЗНО — Підготовка до НМТ
--   ЗНОХАБ — Підготовка до НМТ
--   Наголоси НМТ — Підготовка до НМТ
--   НМТ+ — Підготовка до НМТ
--   ЗНО і НМТ тести — Підготовка до НМТ
--   Соловій: НМТ українська мова — Підготовка до НМТ
--   Вивчай Просто | НМТ — Підготовка до НМТ
--   Читай — НМТ, ЗНО та ЄВІ — Підготовка до НМТ
--   Mindfly — Підготовка до НМТ
--   CAM ON SCHOOL — Підготовка до НМТ
--   Тест з державної мови — Підготовка до НМТ
--   GoIT — Курси та онлайн-школи
--   MyStat (IT STEP Academy) — Курси та онлайн-школи
--   Genius.Space — Курси та онлайн-школи
--   Englishdom ED Class — Курси та онлайн-школи
--   EDWords — англійські слова — Курси та онлайн-школи
--   AllRight — Курси та онлайн-школи
--   JustSchool — Курси та онлайн-школи
--   Wally: англійська мова — Курси та онлайн-школи
--   Мова — ДНК нації — Курси та онлайн-школи
--   ЛогопедіЯ — Курси та онлайн-школи
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Школи, садочки та університети', 'Schools, Kindergartens & Universities', 'ua-schools' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-schools');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Підготовка до НМТ', 'NMT & Exam Prep', 'ua-exams' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-exams');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Курси та онлайн-школи', 'Courses & Online Schools', 'ua-courses' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-courses');

-- NZ.UA — електронні журнали — Школи, садочки та університети, Освіта
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6670438104' OR LOWER(`name`) = 'nz.ua — електронні журнали')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NZ.UA — електронні журнали', NULL, 'https://apps.apple.com/ua/app/id6670438104', NULL, NULL, 'Електронні щоденники й журнали «Нові Знання»: оцінки, розклад, домашні завдання та кабінет вчителя.', 'Novi Znannia e-diaries and gradebooks: grades, timetable, homework and a teacher’s account.', 'NZ.UA — мобільний застосунок електронних щоденників і журналів «Нові Знання», якими користуються тисячі школярів, батьків і вчителів. Учні й батьки бачать розклад, домашні завдання, оцінки та аналіз успішності; вчителі виставляють оцінки й ведуть розклад із телефона, зокрема частково без інтернету. Доступ для родини надає класний керівник.', 'NZ.UA is the mobile app of the Novi Znannia e-diaries and gradebooks used by thousands of students, parents and teachers. Students and parents see the timetable, homework, grades and progress analysis; teachers enter grades and manage the timetable from a phone, partly offline. Family access is granted by the class teacher.', 'Щоденник і розклад
Домашні завдання
Оцінки й аналіз успішності
Кабінет педагога
Часткова робота офлайн', 'Diary and timetable
Homework
Grades and progress analysis
Teacher account
Partial offline mode', 'Школярам, батькам і вчителям шкіл, що працюють з «Новими Знаннями».', 'Students, parents and teachers at schools using Novi Znannia.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6670438104' OR LOWER(`name`) = 'nz.ua — електронні журнали') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-schools' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-education' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Novi Znannia e-diaries and gradebooks: grades, timetable, homework and a teacher’s account.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NZ.UA is the mobile app of the Novi Znannia e-diaries and gradebooks used by thousands of students, parents and teachers. Students and parents see the timetable, homework, grades and progress analysis; teachers enter grades and manage the timetable from a phone, partly offline. Family access is granted by the class teacher.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Diary and timetable
Homework
Grades and progress analysis
Teacher account
Partial offline mode', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students, parents and teachers at schools using Novi Znannia.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- My School — щоденник — Школи, садочки та університети
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6801995276' OR LOWER(`name`) = 'my school — щоденник')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'My School — щоденник', NULL, 'https://apps.apple.com/ua/app/id6801995276', NULL, NULL, 'Електронний щоденник школи My School: розклад, оцінки з коментарями, домашні завдання й відвідуваність.', 'My School e-diary: timetable, grades with comments, homework and attendance.', 'My School — електронний щоденник для учнів і батьків школи My School. Батьки бачать розклад дитини, оцінки з коментарями вчителів і середній бал, домашні завдання з термінами, пропуски й запізнення, можуть повідомити про відсутність. Учні мають власний розклад, відмітки про виконані завдання, шкільну бібліотеку підручників і цілі. Обліковий запис створює школа.', 'My School is an e-diary for students and parents of My School. Parents see their child’s timetable, grades with teacher comments and average, homework deadlines, absences and lateness, and can report an absence. Students get their own timetable, homework check-offs, a school textbook library and goals. Accounts are created by the school.', 'Розклад уроків
Оцінки з коментарями
Домашні завдання
Відвідуваність
Бібліотека підручників', 'Lesson timetable
Grades with comments
Homework
Attendance
Textbook library', 'Учням і батькам школи My School.', 'My School students and parents.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6801995276' OR LOWER(`name`) = 'my school — щоденник') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-schools' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'My School e-diary: timetable, grades with comments, homework and attendance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'My School is an e-diary for students and parents of My School. Parents see their child’s timetable, grades with teacher comments and average, homework deadlines, absences and lateness, and can report an absence. Students get their own timetable, homework check-offs, a school textbook library and goals. Accounts are created by the school.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Lesson timetable
Grades with comments
Homework
Attendance
Textbook library', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'My School students and parents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sadok — Школи, садочки та університети, Для бізнесу та ФОП
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sadok.app' OR LOWER(`name`) = 'sadok')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sadok', NULL, 'https://sadok.app', NULL, NULL, 'CRM для дитячих садочків і центрів розвитку: відвідуваність, нарахування, рахунки батькам і оплати.', 'CRM for kindergartens and kids’ centers: attendance, charges, invoices to parents and payments.', 'Sadok — CRM-система для керівників, адміністраторів, вихователів і батьків дитячих садочків, центрів і просторів розвитку та студій. Вона автоматизує нарахування й абонементи, облік харчування та додаткових послуг, формує рахунки батькам з урахуванням пропусків, автоматично фіксує оплати через банківську інтеграцію й показує баланси вихованців.', 'Sadok is a CRM for managers, administrators, educators and parents at kindergartens, kids’ development centers and studios. It automates charges and memberships, tracks meals and extra services, issues invoices to parents taking absences into account, records payments via bank integration and shows each child’s balance.', 'Автоматичні нарахування й абонементи
Рахунки батькам у 2 кліки
Автофіксація оплат через банк
Баланси вихованців
Нагадування про оплату', 'Automatic charges and memberships
Invoices to parents in 2 clicks
Automatic bank payment matching
Child balances
Payment reminders', 'Керівникам і адміністраторам садочків та дитячих центрів, батькам.', 'Kindergarten and kids’ center managers, and parents.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sadok.app' OR LOWER(`name`) = 'sadok') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-schools' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-business' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'CRM for kindergartens and kids’ centers: attendance, charges, invoices to parents and payments.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sadok is a CRM for managers, administrators, educators and parents at kindergartens, kids’ development centers and studios. It automates charges and memberships, tracks meals and extra services, issues invoices to parents taking absences into account, records payments via bank integration and shows each child’s balance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automatic charges and memberships
Invoices to parents in 2 clicks
Automatic bank payment matching
Child balances
Payment reminders', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Kindergarten and kids’ center managers, and parents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ЄАС — Єдина атестаційна система — Школи, садочки та університети, Освіта
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6755683551' OR LOWER(`name`) = 'єас — єдина атестаційна система')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ЄАС — Єдина атестаційна система', NULL, 'https://apps.apple.com/ua/app/id6755683551', NULL, NULL, 'Національна платформа атестації педагогів: заяви, документи й результати атестації онлайн.', 'National platform for teacher certification: applications, documents and results online.', 'ЄАС (Єдина атестаційна система) — національна електронна платформа для атестації педагогічних працівників. Педагоги створюють електронний профіль, подають заяву й документи онлайн; характеристики, відгуки, сертифікати й накази формуються та перевіряються автоматично, а результати зберігаються в централізованій базі з аналітикою для органів управління освітою.', 'EAS (Unified Certification System) is a national e-platform for certifying teaching staff. Teachers create an e-profile and submit applications and documents online; references, certificates and orders are generated and checked automatically, and results are stored in a central database with analytics for education authorities.', 'Електронний профіль педагога
Подання документів онлайн
Автоматичні атестаційні матеріали
Історія атестацій', 'Teacher e-profile
Online document submission
Automatic certification materials
Certification history', 'Вчителям і закладам освіти.', 'Teachers and educational institutions.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6755683551' OR LOWER(`name`) = 'єас — єдина атестаційна система') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-schools' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-education' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'National platform for teacher certification: applications, documents and results online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'EAS (Unified Certification System) is a national e-platform for certifying teaching staff. Teachers create an e-profile and submit applications and documents online; references, certificates and orders are generated and checked automatically, and results are stored in a central database with analytics for education authorities.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Teacher e-profile
Online document submission
Automatic certification materials
Certification history', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teachers and educational institutions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Обирай ХАІ — Школи, садочки та університети
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6756081653' OR LOWER(`name`) = 'обирай хаі')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Обирай ХАІ', NULL, 'https://apps.apple.com/ua/app/id6756081653', NULL, NULL, 'Застосунок для вступників до ХАІ: умови вступу, прохідні бали, події та асистент вступу.', 'App for applicants to KhAI: admission rules, passing scores, events and an admission assistant.', '«Обирай ХАІ» — офіційний застосунок для абітурієнтів Національного аерокосмічного університету «Харківський авіаційний інститут». У ньому можна дізнатися про університет і спеціальності, етапи вступної кампанії, потрібні предмети НМТ і прохідні бали минулих років, оцінити свої шанси в асистенті вступу, переглянути події для абітурієнтів і звʼязатися з приймальною комісією.', 'Choose KhAI is the official app for applicants to the National Aerospace University “Kharkiv Aviation Institute”. You can learn about the university and programs, admission stages, required NMT subjects and past passing scores, estimate your chances with the admission assistant, see events for applicants and contact the admissions office.', 'Умови вступу й предмети НМТ
Прохідні бали минулих років
Асистент вступу
Події для абітурієнтів
Звʼязок із приймальною комісією', 'Admission rules and NMT subjects
Past passing scores
Admission assistant
Events for applicants
Admissions office contact', 'Випускникам шкіл і коледжів, які обирають ХАІ, та їхнім батькам.', 'School and college graduates considering KhAI, and their parents.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6756081653' OR LOWER(`name`) = 'обирай хаі') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-schools' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'App for applicants to KhAI: admission rules, passing scores, events and an admission assistant.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Choose KhAI is the official app for applicants to the National Aerospace University “Kharkiv Aviation Institute”. You can learn about the university and programs, admission stages, required NMT subjects and past passing scores, estimate your chances with the admission assistant, see events for applicants and contact the admissions office.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Admission rules and NMT subjects
Past passing scores
Admission assistant
Events for applicants
Admissions office contact', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'School and college graduates considering KhAI, and their parents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Learning.ua — Школи, садочки та університети, Освіта
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'learning.ua' OR LOWER(`name`) = 'learning.ua')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Learning.ua', NULL, 'https://learning.ua', NULL, NULL, 'Інтерактивні завдання з математики та української мови для учнів, батьків і вчителів.', 'Interactive maths and Ukrainian language exercises for students, parents and teachers.', 'Learning.ua — навчальна платформа з математики та української мови. Учні розвʼязують сотні інтерактивних завдань, отримують нагороди й змагаються в лізі; батьки стежать за прогресом кількох дітей; вчителі створюють класи до 35 учнів, власну програму, призначають завдання й контролюють виконання.', 'Learning.ua is a learning platform for maths and Ukrainian. Students solve hundreds of interactive exercises, earn rewards and compete in a league; parents track several children’s progress; teachers create classes of up to 35 students, build their own curriculum, assign tasks and monitor completion.', 'Сотні завдань з математики й української
Прогрес для батьків
Класи для вчителів
Нагороди, ліга й рейтинг', 'Hundreds of maths and Ukrainian tasks
Progress for parents
Classes for teachers
Rewards, league and ranking', 'Школярам молодших і середніх класів, батькам і вчителям.', 'Primary and middle school students, parents and teachers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'learning.ua' OR LOWER(`name`) = 'learning.ua') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-schools' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-education' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Interactive maths and Ukrainian language exercises for students, parents and teachers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Learning.ua is a learning platform for maths and Ukrainian. Students solve hundreds of interactive exercises, earn rewards and compete in a league; parents track several children’s progress; teachers create classes of up to 35 students, build their own curriculum, assign tasks and monitor completion.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hundreds of maths and Ukrainian tasks
Progress for parents
Classes for teachers
Rewards, league and ranking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Primary and middle school students, parents and teachers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Просте ЗНО/НМТ — Підготовка до НМТ
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1533304985' OR LOWER(`name`) = 'просте зно/нмт')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Просте ЗНО/НМТ', NULL, 'https://apps.apple.com/ua/app/id1533304985', NULL, NULL, 'Тести ЗНО 2009–2021 і НМТ 2022–2025, 8+ ігрових режимів і розрахунок балів мультитесту.', 'ZNO tests 2009–2021 and NMT 2022–2025, 8+ game modes and multitest score calculation.', 'ПростеЗНО — застосунок для підготовки до НМТ. У ньому всі тести ЗНО з 2009 по 2021 рік і НМТ за 2022–2025 роки з української мови й літератури, історії України, англійської, математики, біології, хімії та фізики, авторські тести команди, понад 8 ігрових режимів, розумний підбір питань, пояснення викладачів і розрахунок балів за таблицями МОН. Для англійської є аудіювання.', 'ProsteZNO is an NMT prep app with all ZNO tests from 2009–2021 and NMT tests from 2022–2025 in Ukrainian language and literature, Ukrainian history, English, maths, biology, chemistry and physics, plus the team’s own tests, 8+ game modes, smart question selection, teacher explanations and score calculation using Ministry tables. English includes listening.', 'Тести ЗНО 2009–2021 і НМТ 2022–2025
8+ ігрових режимів
Розрахунок балів мультитесту
Пояснення викладачів
Аудіювання з англійської', 'ZNO 2009–2021 and NMT 2022–2025 tests
8+ game modes
Multitest score calculator
Teacher explanations
English listening', 'Випускникам, які готуються до НМТ.', 'School leavers preparing for the NMT.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1533304985' OR LOWER(`name`) = 'просте зно/нмт') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-exams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ZNO tests 2009–2021 and NMT 2022–2025, 8+ game modes and multitest score calculation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ProsteZNO is an NMT prep app with all ZNO tests from 2009–2021 and NMT tests from 2022–2025 in Ukrainian language and literature, Ukrainian history, English, maths, biology, chemistry and physics, plus the team’s own tests, 8+ game modes, smart question selection, teacher explanations and score calculation using Ministry tables. English includes listening.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'ZNO 2009–2021 and NMT 2022–2025 tests
8+ game modes
Multitest score calculator
Teacher explanations
English listening', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'School leavers preparing for the NMT.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- НМТ на 200 — Підготовка до НМТ
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nmtna200.vgroupe.academy' OR LOWER(`name`) = 'нмт на 200')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'НМТ на 200', NULL, 'https://nmtna200.vgroupe.academy', NULL, NULL, 'Персональний репетитор для НМТ: тести за програмою МОН, короткі конспекти й симуляція іспиту.', 'A pocket NMT tutor: Ministry-aligned tests, short notes and exam simulation.', '«НМТ на 200» — застосунок для підготовки до національного мультипредметного тесту. Тести минулих років і авторські завдання за програмою МОН, короткі конспекти з таблицями й формулами, аналітика сильних і слабких тем та симуляція реального іспиту з розподілом часу між предметами.', 'NMT na 200 is an NMT preparation app with past and original tests aligned with the Ministry curriculum, short notes with tables and formulas, analytics of strong and weak topics and a realistic exam simulation with time split across subjects.', 'Тести за програмою МОН
Короткі конспекти
Аналітика прогресу
Симуляція іспиту', 'Ministry-aligned tests
Short notes
Progress analytics
Exam simulation', 'Випускникам, які готуються до НМТ.', 'School leavers preparing for the NMT.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nmtna200.vgroupe.academy' OR LOWER(`name`) = 'нмт на 200') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-exams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A pocket NMT tutor: Ministry-aligned tests, short notes and exam simulation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NMT na 200 is an NMT preparation app with past and original tests aligned with the Ministry curriculum, short notes with tables and formulas, analytics of strong and weak topics and a realistic exam simulation with time split across subjects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Ministry-aligned tests
Short notes
Progress analytics
Exam simulation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'School leavers preparing for the NMT.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MathCorp — НМТ/ЗНО — Підготовка до НМТ
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mathcorporation.com/app' OR LOWER(`name`) = 'mathcorp — нмт/зно')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MathCorp — НМТ/ЗНО', NULL, 'https://www.mathcorporation.com/app', NULL, NULL, 'Інтерактивна платформа підготовки до НМТ і ЗНО: щоденні тести, статистика й аналіз результатів.', 'Interactive NMT and ZNO prep platform: daily tests, statistics and result analysis.', 'MathCorp — інтерактивна освітня платформа для підготовки до НМТ і ЗНО. Школярі щодня тренуються в онлайн-тестах, відстежують прогрес і аналізують результати.', 'MathCorp is an interactive learning platform for NMT and ZNO preparation. Students practice online tests daily, track progress and analyse their results.', 'Онлайн-тести НМТ і ЗНО
Статистика й аналіз
Щоденні тренування', 'NMT and ZNO online tests
Statistics and analysis
Daily practice', 'Випускникам, які готуються до НМТ.', 'School leavers preparing for the NMT.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mathcorporation.com/app' OR LOWER(`name`) = 'mathcorp — нмт/зно') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-exams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Interactive NMT and ZNO prep platform: daily tests, statistics and result analysis.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MathCorp is an interactive learning platform for NMT and ZNO preparation. Students practice online tests daily, track progress and analyse their results.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'NMT and ZNO online tests
Statistics and analysis
Daily practice', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'School leavers preparing for the NMT.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ЗНОХАБ — Підготовка до НМТ
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6742744326' OR LOWER(`name`) = 'знохаб')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ЗНОХАБ', NULL, 'https://apps.apple.com/ua/app/id6742744326', NULL, NULL, 'Онлайн-школа підготовки до НМТ: заняття наживо й у записі, практика та перевірка знань з 7 предметів.', 'NMT prep school: live and recorded classes, practice and knowledge checks in 7 subjects.', 'ЗНОХАБ — онлайн-школа підготовки до НМТ. У застосунку доступні заняття онлайн і в записі, регулярна практика й перевірка знань з української мови, математики, історії України, англійської, української літератури, географії та біології. За даними школи, понад 600 випускників отримали 200 балів на НМТ.', 'ZNOHUB is an online NMT prep school. The app offers live and recorded classes, regular practice and knowledge checks in Ukrainian, maths, Ukrainian history, English, Ukrainian literature, geography and biology. According to the school, more than 600 graduates scored 200 on the NMT.', 'Заняття онлайн і в записі
Практика й перевірка знань
7 предметів НМТ
Досвідчені викладачі', 'Live and recorded classes
Practice and checks
7 NMT subjects
Experienced teachers', 'Випускникам, які готуються до НМТ.', 'School leavers preparing for the NMT.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6742744326' OR LOWER(`name`) = 'знохаб') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-exams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'NMT prep school: live and recorded classes, practice and knowledge checks in 7 subjects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ZNOHUB is an online NMT prep school. The app offers live and recorded classes, regular practice and knowledge checks in Ukrainian, maths, Ukrainian history, English, Ukrainian literature, geography and biology. According to the school, more than 600 graduates scored 200 on the NMT.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live and recorded classes
Practice and checks
7 NMT subjects
Experienced teachers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'School leavers preparing for the NMT.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Наголоси НМТ — Підготовка до НМТ
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nagolocy.com' OR LOWER(`name`) = 'наголоси нмт')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Наголоси НМТ', NULL, 'https://www.nagolocy.com', NULL, NULL, 'Щоденне тренування наголосів і української мови для НМТ: 5–15 хвилин, місії, лідерборд, офлайн.', 'Daily Ukrainian stress and language practice for the NMT: 5–15 minutes, missions, leaderboard, offline.', '«Наголоси» допомагають регулярно тренувати українську, закріплювати матеріал і бачити прогрес. Коротка практика 5–15 хвилин на день, розумне повторення, місії, досягнення й лідерборд; працює офлайн. Підходить для підготовки до НМТ і для всіх, хто хоче говорити грамотніше.', 'Naholosy helps you practice Ukrainian regularly, reinforce material and see your progress. Short 5–15 minute daily sessions, smart repetition, missions, achievements and a leaderboard; works offline. Good for NMT prep and for anyone wanting to speak more correctly.', 'Тренування наголосів
Практика 5–15 хвилин на день
Розумне повторення
Місії й лідерборд
Офлайн', 'Stress practice
5–15 minutes a day
Smart repetition
Missions and leaderboard
Offline', 'Випускникам, які готуються до НМТ.', 'School leavers preparing for the NMT.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nagolocy.com' OR LOWER(`name`) = 'наголоси нмт') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-exams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Daily Ukrainian stress and language practice for the NMT: 5–15 minutes, missions, leaderboard, offline.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Naholosy helps you practice Ukrainian regularly, reinforce material and see your progress. Short 5–15 minute daily sessions, smart repetition, missions, achievements and a leaderboard; works offline. Good for NMT prep and for anyone wanting to speak more correctly.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Stress practice
5–15 minutes a day
Smart repetition
Missions and leaderboard
Offline', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'School leavers preparing for the NMT.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- НМТ+ — Підготовка до НМТ
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nmt-plus.com' OR LOWER(`name`) = 'нмт+')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'НМТ+', NULL, 'https://nmt-plus.com', NULL, NULL, 'Підготовка до НМТ у форматі гри: 20 000+ питань, адаптивний алгоритм, XP, рівні та стріки.', 'Gamified NMT prep: 20,000+ questions, adaptive algorithm, XP, levels and streaks.', 'НМТ+ — застосунок для підготовки до НМТ, що замінює зошити серіями правильних відповідей, XP, рівнями й щоденними викликами. 20 000+ питань з програми МОН, адаптивний алгоритм, 7+ режимів тренування, пояснення до кожного питання, дорожня карта тем і графіки прогресу.', 'NMT+ is an NMT prep app that replaces workbooks with answer streaks, XP, levels and daily challenges. It has 20,000+ questions from the Ministry curriculum, an adaptive algorithm, 7+ practice modes, explanations for every question, a topic roadmap and progress charts.', '20 000+ питань
Адаптивний підбір питань
7+ режимів тренування
Пояснення до відповідей
XP, рівні й стріки', '20,000+ questions
Adaptive question selection
7+ practice modes
Answer explanations
XP, levels and streaks', 'Випускникам, які готуються до НМТ.', 'School leavers preparing for the NMT.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nmt-plus.com' OR LOWER(`name`) = 'нмт+') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-exams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Gamified NMT prep: 20,000+ questions, adaptive algorithm, XP, levels and streaks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NMT+ is an NMT prep app that replaces workbooks with answer streaks, XP, levels and daily challenges. It has 20,000+ questions from the Ministry curriculum, an adaptive algorithm, 7+ practice modes, explanations for every question, a topic roadmap and progress charts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '20,000+ questions
Adaptive question selection
7+ practice modes
Answer explanations
XP, levels and streaks', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'School leavers preparing for the NMT.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ЗНО і НМТ тести — Підготовка до НМТ
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'katenin.dev/znotesty' OR LOWER(`name`) = 'зно і нмт тести')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ЗНО і НМТ тести', NULL, 'https://katenin.dev/znotesty/', NULL, NULL, '95 тестів і 1940 питань без інтернету й реєстрації: 20 питань, таймер і правильні відповіді.', '95 tests and 1,940 questions offline with no sign-up: 20 questions, a timer and correct answers.', '«ЗНО і НМТ тести» — 95 тестів і 1940 питань, доступних без інтернету й реєстрації. Кожен тест має 20 питань і таймер, а наприкінці показано результат і правильні відповіді поруч із вашими. Розділи охоплюють українську мову та інші предмети НМТ.', 'ZNO and NMT Tests offers 95 tests and 1,940 questions with no internet or sign-up. Each test has 20 questions and a timer, and at the end you see your score with the correct answers beside yours. Sections cover Ukrainian and other NMT subjects.', '95 тестів, 1940 питань
Без інтернету й реєстрації
Таймер
Правильні відповіді після тесту', '95 tests, 1,940 questions
No internet or sign-up
Timer
Correct answers after each test', 'Випускникам, які готуються до НМТ.', 'School leavers preparing for the NMT.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'katenin.dev/znotesty' OR LOWER(`name`) = 'зно і нмт тести') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-exams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', '95 tests and 1,940 questions offline with no sign-up: 20 questions, a timer and correct answers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ZNO and NMT Tests offers 95 tests and 1,940 questions with no internet or sign-up. Each test has 20 questions and a timer, and at the end you see your score with the correct answers beside yours. Sections cover Ukrainian and other NMT subjects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '95 tests, 1,940 questions
No internet or sign-up
Timer
Correct answers after each test', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'School leavers preparing for the NMT.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Соловій: НМТ українська мова — Підготовка до НМТ
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'education.soloviy.app' OR LOWER(`name`) = 'соловій: нмт українська мова')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Соловій: НМТ українська мова', NULL, 'https://education.soloviy.app', NULL, NULL, 'Підготовка до НМТ з української: план на кожен день, теорія за темами й тести після кожної теми.', 'NMT Ukrainian prep: a daily plan, theory by topic and tests after each topic.', '«Соловій освіта» — підготовка до НМТ з української мови в телефоні. Коротка діагностика визначає орієнтовний бал і складає план на кожен день до іспиту. Уся програма розкладена на зрозумілі теми, а після кожної теорії одразу йдуть тести.', 'Soloviy Education is NMT Ukrainian language prep on your phone. A short diagnostic estimates your score and builds a day-by-day plan to the exam. The whole curriculum is split into clear topics, each followed by tests.', 'Діагностика й орієнтовний бал
План на кожен день
Теорія за темами
Тести після кожної теми', 'Diagnostic and estimated score
Daily plan
Theory by topic
Tests after each topic', 'Випускникам, які готуються до НМТ.', 'School leavers preparing for the NMT.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'education.soloviy.app' OR LOWER(`name`) = 'соловій: нмт українська мова') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-exams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'NMT Ukrainian prep: a daily plan, theory by topic and tests after each topic.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Soloviy Education is NMT Ukrainian language prep on your phone. A short diagnostic estimates your score and builds a day-by-day plan to the exam. The whole curriculum is split into clear topics, each followed by tests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Diagnostic and estimated score
Daily plan
Theory by topic
Tests after each topic', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'School leavers preparing for the NMT.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Вивчай Просто | НМТ — Підготовка до НМТ
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6758337594' OR LOWER(`name`) = 'вивчай просто | нмт')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Вивчай Просто | НМТ', NULL, 'https://apps.apple.com/ua/app/id6758337594', NULL, NULL, 'Підготовка до НМТ як гра: короткі уроки без води, щоб займатися навіть дорогою до школи.', 'NMT prep as a game: short no-fluff lessons you can do on the way to school.', '«Вивчай Просто | НМТ» перетворює підготовку до НМТ на гру: увесь матеріал скорочено до головного, щоб готуватися короткими сесіями — навіть дорогою до школи — без годин зубріння.', 'Vyvchai Prosto | NMT turns NMT preparation into a game: material is cut down to the essentials so you can study in short sessions, even on the way to school, without hours of cramming.', 'Ігровий формат
Короткі уроки
Матеріал без води', 'Game format
Short lessons
No-fluff material', 'Випускникам, які готуються до НМТ.', 'School leavers preparing for the NMT.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6758337594' OR LOWER(`name`) = 'вивчай просто | нмт') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-exams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'NMT prep as a game: short no-fluff lessons you can do on the way to school.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Vyvchai Prosto | NMT turns NMT preparation into a game: material is cut down to the essentials so you can study in short sessions, even on the way to school, without hours of cramming.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Game format
Short lessons
No-fluff material', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'School leavers preparing for the NMT.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Читай — НМТ, ЗНО та ЄВІ — Підготовка до НМТ
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chitay.org.ua' OR LOWER(`name`) = 'читай — нмт, зно та єві')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Читай — НМТ, ЗНО та ЄВІ', NULL, 'https://chitay.org.ua', NULL, NULL, 'Понад 450 тестів НМТ, ЗНО та ЄВІ/ЄФВВ в форматі реального іспиту з аналізом помилок.', '450+ NMT, ZNO and master’s entrance (EVI/EFVV) tests in real exam format with error analysis.', '«Читай» — застосунок для підготовки до НМТ, ЗНО та вступних іспитів до магістратури (ЄВІ/ЄФВВ). Понад 450 тестів, зокрема офіційні варіанти минулих років, тренування у форматі реального іспиту, аналіз помилок і відстеження прогресу.', 'Chytai is an app for preparing for the NMT, ZNO and master’s entrance exams (EVI/EFVV). It has over 450 tests, including official past papers, real-exam-format practice, error analysis and progress tracking.', '450+ тестів
Офіційні варіанти минулих років
Формат реального іспиту
Аналіз помилок
Вступ до магістратури', '450+ tests
Official past papers
Real exam format
Error analysis
Master’s entrance exams', 'Абітурієнтам і вступникам до магістратури.', 'University and master’s applicants.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chitay.org.ua' OR LOWER(`name`) = 'читай — нмт, зно та єві') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-exams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', '450+ NMT, ZNO and master’s entrance (EVI/EFVV) tests in real exam format with error analysis.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Chytai is an app for preparing for the NMT, ZNO and master’s entrance exams (EVI/EFVV). It has over 450 tests, including official past papers, real-exam-format practice, error analysis and progress tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '450+ tests
Official past papers
Real exam format
Error analysis
Master’s entrance exams', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'University and master’s applicants.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mindfly — Підготовка до НМТ
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mindfly.com.ua' OR LOWER(`name`) = 'mindfly')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mindfly', NULL, 'https://mindfly.com.ua', NULL, NULL, 'Тренажер НМТ і ЗНО з 9 предметів: тести в форматі іспиту, пояснення, статистика й офлайн-режим.', 'NMT and ZNO trainer in 9 subjects: exam-format tests, explanations, statistics and offline mode.', 'Mindfly — тренажер для підготовки до НМТ і ЗНО з математики, української мови й літератури, історії України, англійської, біології, географії, фізики та хімії. Тести у форматі реального іспиту, правильні відповіді з поясненнями, статистика слабких тем і офлайн-режим — можна готуватися навіть в укритті чи без світла.', 'Mindfly is an NMT and ZNO trainer in maths, Ukrainian language and literature, Ukrainian history, English, biology, geography, physics and chemistry. It offers real-exam-format tests, answers with explanations, weak-topic statistics and an offline mode for studying even in a shelter or during blackouts.', '9 предметів
Тести у форматі іспиту
Пояснення відповідей
Статистика
Офлайн-режим', '9 subjects
Exam-format tests
Answer explanations
Statistics
Offline mode', 'Випускникам, які готуються до НМТ.', 'School leavers preparing for the NMT.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mindfly.com.ua' OR LOWER(`name`) = 'mindfly') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-exams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'NMT and ZNO trainer in 9 subjects: exam-format tests, explanations, statistics and offline mode.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mindfly is an NMT and ZNO trainer in maths, Ukrainian language and literature, Ukrainian history, English, biology, geography, physics and chemistry. It offers real-exam-format tests, answers with explanations, weak-topic statistics and an offline mode for studying even in a shelter or during blackouts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '9 subjects
Exam-format tests
Answer explanations
Statistics
Offline mode', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'School leavers preparing for the NMT.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- CAM ON SCHOOL — Підготовка до НМТ
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'westudy.ua/camon' OR LOWER(`name`) = 'cam on school')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CAM ON SCHOOL', NULL, 'https://westudy.ua/camon', NULL, NULL, 'Застосунок онлайн-школи CAM ON для підготовки до НМТ: курси, уроки, тести й конспекти.', 'CAM ON online school app for NMT prep: courses, lessons, tests and notes.', 'CAM ON SCHOOL — мобільний застосунок онлайн-школи для підготовки до НМТ. В одному місці зібрано особистий доступ до курсів і уроків, тести для тренування й перевірки знань, конспекти та матеріали для повторення.', 'CAM ON SCHOOL is the online school’s mobile app for NMT preparation, bringing together personal access to courses and lessons, practice and check tests, notes and revision materials.', 'Курси й уроки
Тести
Конспекти для повторення', 'Courses and lessons
Tests
Revision notes', 'Учням онлайн-школи CAM ON.', 'CAM ON school students.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'westudy.ua/camon' OR LOWER(`name`) = 'cam on school') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-exams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'CAM ON online school app for NMT prep: courses, lessons, tests and notes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'CAM ON SCHOOL is the online school’s mobile app for NMT preparation, bringing together personal access to courses and lessons, practice and check tests, notes and revision materials.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Courses and lessons
Tests
Revision notes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'CAM ON school students.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Тест з державної мови — Підготовка до НМТ
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dilogical.com' OR LOWER(`name`) = 'тест з державної мови')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Тест з державної мови', NULL, 'https://dilogical.com', NULL, NULL, 'Підготовка до іспиту на рівень володіння державною мовою для держслужбовців, вчителів і лікарів.', 'Prep for the state language proficiency exam for civil servants, teachers and doctors.', 'Застосунок для підготовки до іспиту на рівень володіння державною (українською) мовою, який з 16 липня 2021 року складають особи, що претендують на посади на державній службі, в органах місцевого самоврядування, в освіті, медицині та інших сферах, визначених законом.', 'An app for preparing for the state (Ukrainian) language proficiency exam, required since 16 July 2021 for candidates for civil service, local government, education, healthcare and other positions defined by law.', 'Тести на рівень володіння мовою
Підготовка до сертифікації', 'Language proficiency tests
Certification prep', 'Кандидатам на посади, де потрібен сертифікат з державної мови.', 'Candidates for positions requiring a state language certificate.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dilogical.com' OR LOWER(`name`) = 'тест з державної мови') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-exams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Prep for the state language proficiency exam for civil servants, teachers and doctors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app for preparing for the state (Ukrainian) language proficiency exam, required since 16 July 2021 for candidates for civil service, local government, education, healthcare and other positions defined by law.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Language proficiency tests
Certification prep', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Candidates for positions requiring a state language certificate.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- GoIT — Курси та онлайн-школи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1672285281' OR LOWER(`name`) = 'goit')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GoIT', NULL, 'https://apps.apple.com/ua/app/id1672285281', NULL, NULL, 'LMS онлайн-школи GoIT: відеоуроки, автоперевірка коду, дуелі та прогрес на IT-курсах.', 'GoIT online school LMS: video lessons, auto code checking, duels and progress on IT courses.', 'GoIT LMS — платформа онлайн-навчання IT від GoIT: курси з веброзробки, тестування, Java, Python, Frontend і Fullstack. У застосунку доступні відеоуроки, конспекти й домашні завдання (зокрема офлайн), автоматична перевірка коду, статистика прогресу, дуелі з програмування та ачівки.', 'GoIT LMS is GoIT’s online IT learning platform with courses in web development, testing, Java, Python, Frontend and Fullstack. The app offers video lessons, notes and homework (including offline), automatic code checking, progress statistics, coding duels and achievements.', 'Відеоуроки й домашні завдання
Автоперевірка коду
Статистика прогресу
Дуелі з програмування
Офлайн-матеріали', 'Video lessons and homework
Automatic code checking
Progress statistics
Coding duels
Offline materials', 'Студентам IT-курсів GoIT.', 'GoIT IT course students.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1672285281' OR LOWER(`name`) = 'goit') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'GoIT online school LMS: video lessons, auto code checking, duels and progress on IT courses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'GoIT LMS is GoIT’s online IT learning platform with courses in web development, testing, Java, Python, Frontend and Fullstack. The app offers video lessons, notes and homework (including offline), automatic code checking, progress statistics, coding duels and achievements.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Video lessons and homework
Automatic code checking
Progress statistics
Coding duels
Offline materials', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'GoIT IT course students.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MyStat (IT STEP Academy) — Курси та онлайн-школи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'itstep.org' OR LOWER(`name`) = 'mystat (it step academy)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MyStat (IT STEP Academy)', NULL, 'https://itstep.org', NULL, NULL, 'Сервіс для студентів Комп’ютерної Академії IT STEP: розклад, оцінки, новини та відгуки про заняття.', 'Service for IT STEP Computer Academy students: timetable, grades, news and class feedback.', 'MyStat — сервіс для студентів Комп’ютерної Академії IT STEP. У ньому можна переглядати розклад занять і професійних подій, отримувати новини філії й академії, бачити оцінки та динаміку успішності й залишати відгуки про заняття.', 'MyStat is a service for students of IT STEP Computer Academy. You can view the class and event schedule, get branch and academy news, see grades and performance trends, and leave feedback on classes.', 'Розклад занять
Оцінки й динаміка успішності
Новини академії
Відгуки про заняття', 'Class schedule
Grades and trends
Academy news
Class feedback', 'Студентам IT STEP Academy.', 'IT STEP Academy students.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'itstep.org' OR LOWER(`name`) = 'mystat (it step academy)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Service for IT STEP Computer Academy students: timetable, grades, news and class feedback.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MyStat is a service for students of IT STEP Computer Academy. You can view the class and event schedule, get branch and academy news, see grades and performance trends, and leave feedback on classes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Class schedule
Grades and trends
Academy news
Class feedback', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'IT STEP Academy students.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Genius.Space — Курси та онлайн-школи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6780527032' OR LOWER(`name`) = 'genius.space')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Genius.Space', NULL, 'https://apps.apple.com/ua/app/id6780527032', NULL, NULL, 'Застосунок освітньої платформи Genius Space: придбані курси, відеоуроки й прогрес у кишені.', 'Genius Space learning platform app: your courses, video lessons and progress in your pocket.', 'Genius Space — мобільний застосунок освітньої платформи genius.space для навчання новим професіям. У ньому зібрано придбані курси з прогресом, відеоплеєр із вибором якості, закладки уроків, пошук по матеріалах і продовження з місця, де ви зупинилися. Акаунт створюється при купівлі курсу на сайті.', 'Genius Space is the mobile app of the genius.space learning platform for new careers. It holds your purchased courses with progress, a video player with quality options, lesson bookmarks, search across materials and resume-where-you-left-off. Accounts are created when you buy a course on the website.', 'Мої курси з прогресом
Відеоуроки
Закладки й пошук
Продовження з місця зупинки', 'My courses with progress
Video lessons
Bookmarks and search
Resume where you left off', 'Студентам курсів Genius Space.', 'Genius Space course students.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6780527032' OR LOWER(`name`) = 'genius.space') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Genius Space learning platform app: your courses, video lessons and progress in your pocket.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Genius Space is the mobile app of the genius.space learning platform for new careers. It holds your purchased courses with progress, a video player with quality options, lesson bookmarks, search across materials and resume-where-you-left-off. Accounts are created when you buy a course on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'My courses with progress
Video lessons
Bookmarks and search
Resume where you left off', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Genius Space course students.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Englishdom ED Class — Курси та онлайн-школи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'englishdom.com' OR LOWER(`name`) = 'englishdom ed class')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Englishdom ED Class', NULL, 'https://www.englishdom.com', NULL, NULL, 'Застосунок для студентів онлайн-школи англійської Englishdom: уроки, домашні завдання й куратор.', 'App for Englishdom online English school students: lessons, homework and a personal curator.', 'Englishdom — онлайн-школа англійської, яка поєднує індивідуальні уроки з викладачем і самостійне навчання на власній платформі. ED Class — застосунок для студентів школи: розклад і баланс уроків, домашні завдання, вивчення слів, чат із персональним куратором і нагадування про заняття.', 'Englishdom is an online English school combining one-to-one lessons with a teacher and self-study on its own platform. ED Class is the students’ app: lesson schedule and balance, homework, vocabulary practice, chat with a personal curator and class reminders.', 'Розклад і баланс уроків
Домашні завдання
Вивчення слів
Чат із куратором
Нагадування про заняття', 'Lesson schedule and balance
Homework
Vocabulary practice
Curator chat
Class reminders', 'Студентам Englishdom.', 'Englishdom students.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'englishdom.com' OR LOWER(`name`) = 'englishdom ed class') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'App for Englishdom online English school students: lessons, homework and a personal curator.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Englishdom is an online English school combining one-to-one lessons with a teacher and self-study on its own platform. ED Class is the students’ app: lesson schedule and balance, homework, vocabulary practice, chat with a personal curator and class reminders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Lesson schedule and balance
Homework
Vocabulary practice
Curator chat
Class reminders', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Englishdom students.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- EDWords — англійські слова — Курси та онлайн-школи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1282915927' OR LOWER(`name`) = 'edwords — англійські слова')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'EDWords — англійські слова', NULL, 'https://apps.apple.com/ua/app/id1282915927', NULL, NULL, 'Тренажер англійських слів від Englishdom: 3000 найпоширеніших слів і 4 види тренувань.', 'Englishdom vocabulary trainer: 3,000 most common words and 4 practice types.', 'EDWords — застосунок від Englishdom для вивчення 3000 найпоширеніших англійських слів, які покривають, за даними школи, 92% усіх фраз. Слова запамʼятовуються через чотири види тренувань.', 'EDWords is an Englishdom app for learning the 3,000 most common English words, which, according to the school, cover 92% of all phrases. Words are memorised through four types of practice.', '3000 найпоширеніших слів
4 види тренувань
Розширення словникового запасу', '3,000 most common words
4 practice types
Vocabulary building', 'Тим, хто вчить англійську.', 'English learners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1282915927' OR LOWER(`name`) = 'edwords — англійські слова') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Englishdom vocabulary trainer: 3,000 most common words and 4 practice types.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'EDWords is an Englishdom app for learning the 3,000 most common English words, which, according to the school, cover 92% of all phrases. Words are memorised through four types of practice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '3,000 most common words
4 practice types
Vocabulary building', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'English learners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AllRight — Курси та онлайн-школи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1474799842' OR LOWER(`name`) = 'allright')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AllRight', NULL, 'https://apps.apple.com/ua/app/id1474799842', NULL, NULL, 'Онлайн-школа англійської для дітей AllRight: уроки прямо в застосунку, розклад і чат з викладачем.', 'AllRight online English school for kids: lessons in the app, scheduling and teacher chat.', 'AllRight — онлайн-школа англійської для дітей. Уроки проходять прямо в застосунку без компʼютера; тут же можна планувати й переносити заняття, стежити за прогресом і результатами перевірок знань, отримувати відгук і писати викладачеві та службі підтримки. Перший урок безкоштовний.', 'AllRight is an online English school for kids. Lessons run right in the app, no computer needed; you can also schedule and reschedule lessons, track progress and test results, get teacher feedback and chat with the teacher and support. The first lesson is free.', 'Уроки в застосунку
Розклад і перенесення занять
Прогрес дитини
Чат з викладачем
Перший урок безкоштовно', 'Lessons in the app
Scheduling and rescheduling
Child progress
Teacher chat
First lesson free', 'Батькам дітей, які вчать англійську.', 'Parents of children learning English.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1474799842' OR LOWER(`name`) = 'allright') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AllRight online English school for kids: lessons in the app, scheduling and teacher chat.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'AllRight is an online English school for kids. Lessons run right in the app, no computer needed; you can also schedule and reschedule lessons, track progress and test results, get teacher feedback and chat with the teacher and support. The first lesson is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Lessons in the app
Scheduling and rescheduling
Child progress
Teacher chat
First lesson free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents of children learning English.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- JustSchool — Курси та онлайн-школи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'justschool.me' OR LOWER(`name`) = 'justschool')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'JustSchool', NULL, 'https://justschool.me', NULL, NULL, 'Онлайн-школа англійської для дітей і дорослих: уроки з викладачем, розклад і баланс занять.', 'Online English school for kids and adults: lessons with a teacher, schedule and lesson balance.', 'JustSchool — онлайн-школа англійської мови для дітей і дорослих з індивідуальними програмами. У застосунку можна відвідувати онлайн-уроки з викладачем, керувати розкладом, переглядати історію занять і поповнювати баланс, отримувати додаткові матеріали й нагадування.', 'JustSchool is an online English school for kids and adults with individual programs. In the app you can attend online lessons with a teacher, manage your schedule, view lesson history and top up your balance, and get extra materials and reminders.', 'Онлайн-уроки з викладачем
Розклад занять
Історія й баланс уроків
Додаткові матеріали', 'Online lessons with a teacher
Class schedule
Lesson history and balance
Extra materials', 'Дітям і дорослим, які вчать англійську.', 'Kids and adults learning English.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'justschool.me' OR LOWER(`name`) = 'justschool') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Online English school for kids and adults: lessons with a teacher, schedule and lesson balance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'JustSchool is an online English school for kids and adults with individual programs. In the app you can attend online lessons with a teacher, manage your schedule, view lesson history and top up your balance, and get extra materials and reminders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online lessons with a teacher
Class schedule
Lesson history and balance
Extra materials', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Kids and adults learning English.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Wally: англійська мова — Курси та онлайн-школи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wally-study.com' OR LOWER(`name`) = 'wally: англійська мова')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Wally: англійська мова', NULL, 'https://wally-study.com', NULL, NULL, 'Англійська для українців по кілька хвилин на день: граматика A1–C2, 10 000 слів і розбір помилок.', 'English for Ukrainians a few minutes a day: A1–C2 grammar, 10,000 words and error review.', 'Wally — англійська для українців з поясненнями простою українською. Тест визначає рівень від A1 до C2. Повний курс граматики (106 правил, кожне безкоштовне), понад 8000 вправ шести видів із поясненням кожної відповіді, майже 10 000 слів у 48 темах із вимовою й прикладами, «Мої помилки» для відпрацювання та слово дня на віджеті.', 'Wally teaches English to Ukrainians with explanations in plain Ukrainian. A test sets your level from A1 to C2. There is a full grammar course (106 rules, all free), 8,000+ exercises of six types with every answer explained, nearly 10,000 words in 48 topics with pronunciation and examples, a “My mistakes” review and a word-of-the-day widget.', 'Тест рівня A1–C2
106 правил граматики
8000+ вправ
~10 000 слів у 48 темах
Розбір помилок', 'A1–C2 level test
106 grammar rules
8,000+ exercises
~10,000 words in 48 topics
Mistake review', 'Українцям, які вчать англійську самостійно.', 'Ukrainians learning English on their own.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wally-study.com' OR LOWER(`name`) = 'wally: англійська мова') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'English for Ukrainians a few minutes a day: A1–C2 grammar, 10,000 words and error review.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Wally teaches English to Ukrainians with explanations in plain Ukrainian. A test sets your level from A1 to C2. There is a full grammar course (106 rules, all free), 8,000+ exercises of six types with every answer explained, nearly 10,000 words in 48 topics with pronunciation and examples, a “My mistakes” review and a word-of-the-day widget.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'A1–C2 level test
106 grammar rules
8,000+ exercises
~10,000 words in 48 topics
Mistake review', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Ukrainians learning English on their own.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Мова — ДНК нації — Курси та онлайн-школи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ukr-mova.in.ua' OR LOWER(`name`) = 'мова — днк нації')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Мова — ДНК нації', NULL, 'https://ukr-mova.in.ua', NULL, NULL, 'Правила української мови в картинках: правопис, наголоси, фразеологізми й антисуржик.', 'Ukrainian language rules in pictures: spelling, stress, idioms and anti-surzhyk.', '«Мова — ДНК нації» допомагає писати й говорити українською без помилок. Правила пояснює персонаж Лепетун — у картинках, коротко й із прикладами. У бібліотеці — правопис, наголоси, фразеологізми й антисуржик, а пошук підказує правильну форму слова.', 'Mova – DNA of the Nation helps you write and speak Ukrainian without mistakes. The character Lepetun explains rules briefly in pictures with examples. The library covers spelling, stress, idioms and anti-surzhyk, and search suggests the correct word form.', 'Правила в картинках
Правопис і наголоси
Фразеологізми
Антисуржик
Пошук правильної форми', 'Rules in pictures
Spelling and stress
Idioms
Anti-surzhyk
Correct form search', 'Усім, хто хоче говорити й писати українською грамотно.', 'Anyone wanting to speak and write correct Ukrainian.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ukr-mova.in.ua' OR LOWER(`name`) = 'мова — днк нації') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ukrainian language rules in pictures: spelling, stress, idioms and anti-surzhyk.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mova – DNA of the Nation helps you write and speak Ukrainian without mistakes. The character Lepetun explains rules briefly in pictures with examples. The library covers spelling, stress, idioms and anti-surzhyk, and search suggests the correct word form.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Rules in pictures
Spelling and stress
Idioms
Anti-surzhyk
Correct form search', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone wanting to speak and write correct Ukrainian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ЛогопедіЯ — Курси та онлайн-школи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'logopediya.com.ua' OR LOWER(`name`) = 'логопедія')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ЛогопедіЯ', NULL, 'https://logopediya.com.ua', NULL, NULL, 'Логопедичний застосунок для розвитку мовлення дітей: артикуляційна гімнастика, звуки й картки Домана.', 'Speech therapy app for kids: articulation exercises, sound practice and Doman cards.', 'ЛогопедіЯ — застосунок для розвитку мовлення дітей, корисний батькам, логопедам і вихователям. Розділи: артикуляційна гімнастика з відео, озвучені картки Домана, запуск мовлення для дітей, які ще не говорять, понад 900 вправ на автоматизацію звуків, диференціація подібних звуків і розвиток словникового запасу та фразового мовлення.', 'LogopediYa is a speech development app for children, useful for parents, speech therapists and educators. It includes articulation exercises with video, voiced Doman cards, speech starters for non-verbal children, 900+ sound automation exercises, differentiation of similar sounds and vocabulary and phrase development.', 'Артикуляційна гімнастика
Картки Домана
Запуск мовлення
900+ вправ на звуки
Розрізнення звуків', 'Articulation exercises
Doman cards
Speech starters
900+ sound exercises
Sound differentiation', 'Батькам, логопедам і вихователям.', 'Parents, speech therapists and educators.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'logopediya.com.ua' OR LOWER(`name`) = 'логопедія') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Speech therapy app for kids: articulation exercises, sound practice and Doman cards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LogopediYa is a speech development app for children, useful for parents, speech therapists and educators. It includes articulation exercises with video, voiced Doman cards, speech starters for non-verbal children, 900+ sound automation exercises, differentiation of similar sounds and vocabulary and phrase development.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Articulation exercises
Doman cards
Speech starters
900+ sound exercises
Sound differentiation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents, speech therapists and educators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Прив'язка наявних продуктів (за назвою) до нових підкатегорій; тексти не змінюються

-- Мрія — Школи, садочки та університети
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'мрія' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-schools' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Єдина Школа — Школи, садочки та університети
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'єдина школа' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-schools' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Всеукраїнська школа онлайн — Школи, садочки та університети, Підготовка до НМТ
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'всеукраїнська школа онлайн' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-schools' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-exams' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Prometheus — Курси та онлайн-школи
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'prometheus' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Біг Мат (EdEra) — Курси та онлайн-школи
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'біг мат (edera)' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Promova — Курси та онлайн-школи
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'promova' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Mate academy — QA — Курси та онлайн-школи
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'mate academy — qa' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Hillel IT School — QA Manual — Курси та онлайн-школи
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'hillel it school — qa manual' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Інтенти запасного пошуку Елі (tools/eli-intents.php, нові підкатегорії ukrainian-apps)
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'електронний щоденник', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'електронний щоденник' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'електронний журнал', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'електронний журнал' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'щоденник учн', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'щоденник учн' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'дитячий садок', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'дитячий садок' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'садочок', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'садочок' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'абітурієнт', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'абітурієнт' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'вступна кампан', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'вступна кампан' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'вступ до університет', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'вступ до університет' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-schools' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'нмт', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'нмт' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'зно', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'зно' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'мультитест', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'мультитест' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'підготовка до нмт', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'підготовка до нмт' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'тести нмт', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'тести нмт' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'єві', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'єві' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'єфвв', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'єфвв' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-exams' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'онлайн шко', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'онлайн шко' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'it курс', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'it курс' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'айті курс', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'айті курс' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'курси англійськ', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'курси англійськ' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'англійська для діте', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'англійська для діте' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'логопед', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'логопед' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'english school', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'english school' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-courses' LIMIT 1));
