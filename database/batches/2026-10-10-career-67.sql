SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-10: нова категорія «Кар'єра та робота» / «Career & Jobs» (slug career)
-- з підкатегоріями:
--   * Резюме та супровідні листи / Resumes & Cover Letters (slug resume-builders)
--   * Підготовка до співбесід / Interview Preparation (slug interview-prep)
--   * Пошук вакансій / Job Search (slug job-search)
--   * Фриланс / Freelancing (slug freelance)
--   * Кар'єрний розвиток / Career Growth (slug career-growth)
-- + 67 нових продуктів + прив'язка наявних.
-- Тексти, функції й тарифи (UA + EN) — лише з офіційних сайтів, звірено 2026-10-10. Невідомі ціни — NULL з поясненням,
-- ціни не в USD — NULL, точна сума в описі плану.
-- Не включено свідомо: AI-підказки під час живої співбесіди (Final Round AI, Cluely, AIApply тощо),
-- сайти, що блокують доступ або недоступні в Україні (Glassdoor, FlexJobs, Malt, MyPerfectResume, Resume Now, CVwizard).
-- Прив'язуються наявні (тексти не змінюються): Kickresume, Rezi, CVGist, Yoodli, Orai, Jobbyo, Taplio, BetterUp
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт» (файл .sql або .sql.zip). Повторний запуск безпечний.
--   Teal — Резюме та супровідні листи
--   Enhancv — Резюме та супровідні листи
--   Zety — Резюме та супровідні листи
--   Novorésumé — Резюме та супровідні листи
--   Resume Worded — Резюме та супровідні листи
--   Resume.io — Резюме та супровідні листи
--   Jobscan — Резюме та супровідні листи
--   Resume Genius — Резюме та супровідні листи
--   LiveCareer — Резюме та супровідні листи
--   FlowCV — Резюме та супровідні листи
--   Reactive Resume — Резюме та супровідні листи
--   VisualCV — Резюме та супровідні листи
--   Hiration — Резюме та супровідні листи
--   Wozber — Резюме та супровідні листи
--   ResumeNerd — Резюме та супровідні листи
--   Skillroads — Резюме та супровідні листи
--   Standard Resume — Резюме та супровідні листи
--   Big Interview — Підготовка до співбесід
--   interviewing.io — Підготовка до співбесід
--   Aced (formerly Exponent) — Підготовка до співбесід
--   Hello Interview — Підготовка до співбесід
--   LeetCode — Підготовка до співбесід
--   NeetCode — Підготовка до співбесід
--   AlgoExpert — Підготовка до співбесід
--   Interview Query — Підготовка до співбесід
--   StrataScratch — Підготовка до співбесід
--   Educative — Підготовка до співбесід
--   Prepfully — Підготовка до співбесід
--   Huru — Підготовка до співбесід
--   InterviewBit — Підготовка до співбесід
--   Interview Kickstart — Підготовка до співбесід
--   Interviews by AI — Підготовка до співбесід
--   LinkedIn — Пошук вакансій
--   Indeed — Пошук вакансій
--   Wellfound — Пошук вакансій
--   Welcome to the Jungle — Пошук вакансій
--   Simplify — Пошук вакансій
--   Jobright — Пошук вакансій
--   LoopCV — Пошук вакансій
--   Himalayas — Пошук вакансій
--   We Work Remotely — Пошук вакансій
--   Remote OK — Пошук вакансій
--   Dice — Пошук вакансій
--   Built In — Пошук вакансій
--   ZipRecruiter — Пошук вакансій
--   Monster — Пошук вакансій
--   Jooble — Пошук вакансій
--   Djinni — Пошук вакансій
--   Work.ua — Пошук вакансій
--   robota.ua — Пошук вакансій
--   Huntr — Пошук вакансій
--   Upwork — Фриланс
--   Fiverr — Фриланс
--   Toptal — Фриланс
--   Contra — Фриланс
--   Freelancehunt — Фриланс
--   Freelancer.com — Фриланс
--   Levels.fyi — Кар'єрний розвиток
--   Careerflow — Кар'єрний розвиток
--   Supergrow — Кар'єрний розвиток
--   AuthoredUp — Кар'єрний розвиток
--   Kleo — Кар'єрний розвиток
--   MentorCruise — Кар'єрний розвиток
--   CareerExplorer — Кар'єрний розвиток
--   80,000 Hours — Кар'єрний розвиток
--   Wonsulting — Кар'єрний розвиток
--   CoachHub — Кар'єрний розвиток
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
INSERT INTO `categories` (`name`, `name_en`, `slug`) SELECT 'Кар''єра та робота', 'Career & Jobs', 'career' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `categories` WHERE `slug` = 'career');
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'career' LIMIT 1);
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Резюме та супровідні листи', 'Resumes & Cover Letters', 'resume-builders' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'resume-builders');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Підготовка до співбесід', 'Interview Preparation', 'interview-prep' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'interview-prep');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Пошук вакансій', 'Job Search', 'job-search' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'job-search');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Фриланс', 'Freelancing', 'freelance' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'freelance');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Кар''єрний розвиток', 'Career Growth', 'career-growth' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'career-growth');

-- =================== Резюме та супровідні листи / Resumes & Cover Letters ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'resume-builders' LIMIT 1);

-- Teal — Резюме та супровідні листи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tealhq.com' OR LOWER(`name`) = 'teal')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Teal', NULL, 'https://www.tealhq.com', NULL, NULL, 'Конструктор резюме з AI, перевірка під вакансію й трекер відгуків на вакансії в одному сервісі.', 'An AI resume builder, job-match checker and job application tracker in one service.', 'Teal допомагає зібрати резюме, підлаштувати його під конкретну вакансію й відстежувати всі відгуки. Сервіс порівнює резюме з описом вакансії й показує оцінку збігу, підказує ключові слова, генерує пункти досвіду з цифрами та короткий підсумок. Є шаблони резюме й супровідних листів, бібліотека прикладів і трекер вакансій. Базові інструменти безкоштовні, розширені — у підписці Teal+.', 'Teal helps you build a resume, tailor it to a specific job and keep track of every application. It compares your resume with a job description and shows a match score, suggests keywords, generates metric-focused bullet points and a summary. There are resume and cover letter templates, an example library and a job tracker. Core tools are free; advanced ones are part of the Teal+ subscription.', 'Оцінка збігу резюме з вакансією
Генератор пунктів досвіду й підсумку
Шаблони резюме й супровідних листів
Трекер відгуків на вакансії', 'Resume-to-job match score
Bullet point and summary generator
Resume and cover letter templates
Job application tracker', 'Шукачам роботи, які подаються на багато вакансій і хочуть адаптувати резюме під кожну.', 'Job seekers applying to many roles who want to tailor their resume to each one.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tealhq.com' OR LOWER(`name`) = 'teal') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI resume builder, job-match checker and job application tracker in one service.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Teal helps you build a resume, tailor it to a specific job and keep track of every application. It compares your resume with a job description and shows a match score, suggests keywords, generates metric-focused bullet points and a summary. There are resume and cover letter templates, an example library and a job tracker. Core tools are free; advanced ones are part of the Teal+ subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Resume-to-job match score
Bullet point and summary generator
Resume and cover letter templates
Job application tracker', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers applying to many roles who want to tailor their resume to each one.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний план без картки.', 'Free forever, no credit card required.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free forever, no credit card required.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Teal+ (тиждень)', 'Teal+ (weekly)', 13.00, 'week', '$13 кожні 7 днів.', '$13 every 7 days.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Teal+ (тиждень)' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Teal+ (weekly)', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$13 every 7 days.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Teal+ (місяць)', 'Teal+ (monthly)', 29.00, 'month', '$29 кожні 30 днів; є варіант $79 за 90 днів.', '$29 every 30 days; $79 every 90 days is also available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Teal+ (місяць)' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Teal+ (monthly)', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$29 every 30 days; $79 every 90 days is also available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Enhancv — Резюме та супровідні листи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'enhancv.com' OR LOWER(`name`) = 'enhancv')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Enhancv', NULL, 'https://enhancv.com', NULL, NULL, 'Конструктор резюме з AI-автором, перевіркою для ATS і адаптацією під вакансію в один клік.', 'A resume builder with an AI writer, ATS check and one-click job tailoring.', 'Enhancv допомагає створити охайне резюме, яке коректно зчитують системи відбору кандидатів (ATS). AI пропонує формулювання, перевіряє резюме й підлаштовує його під вакансію. Окремо є генератор і конструктор супровідних листів, AI-тренування співбесід, трекер відгуків і розширення для Chrome. Безкоштовний план діє 7 днів, далі — платна підписка.', 'Enhancv helps you create a clean resume that applicant tracking systems (ATS) can read correctly. The AI suggests wording, checks your resume and tailors it to a job. There is also a cover letter generator and builder, AI mock interviews, an application tracker and a Chrome extension. The free plan lasts 7 days, after which a paid subscription is needed.', 'AI-автор резюме
Перевірка резюме для ATS
Адаптація під вакансію в один клік
Конструктор супровідних листів', 'AI resume writer
ATS resume check
One-click job tailoring
Cover letter builder', 'Шукачам роботи, студентам, кар''єрним консультантам і рекрутерам.', 'Job seekers, students, career coaches and recruiters.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'enhancv.com' OR LOWER(`name`) = 'enhancv') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A resume builder with an AI writer, ATS check and one-click job tailoring.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Enhancv helps you create a clean resume that applicant tracking systems (ATS) can read correctly. The AI suggests wording, checks your resume and tailors it to a job. There is also a cover letter generator and builder, AI mock interviews, an application tracker and a Chrome extension. The free plan lasts 7 days, after which a paid subscription is needed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI resume writer
ATS resume check
One-click job tailoring
Cover letter builder', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers, students, career coaches and recruiters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний план на 7 днів.', 'Free plan valid for 7 days.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free plan valid for 7 days.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 16.50, 'month', 'Від $16.50 на місяць; є щомісячна, квартальна й піврічна підписка.', 'From $16.50 per month; monthly, quarterly and 6-month subscriptions are available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'From $16.50 per month; monthly, quarterly and 6-month subscriptions are available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Zety — Резюме та супровідні листи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zety.com' OR LOWER(`name`) = 'zety')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Zety', NULL, 'https://zety.com', NULL, NULL, 'Онлайн-конструктор резюме з AI-підказками, ATS-шаблонами й готовими формулюваннями для різних професій.', 'An online resume builder with AI suggestions, ATS-friendly templates and ready-made wording for many jobs.', 'Zety проводить через створення резюме крок за кроком: вибір шаблону, заповнення розділів і завантаження. Шаблони мають ATS-сумісне форматування, а AI та бібліотека готових фраз допомагають швидко описати досвід, навички й досягнення під обрану посаду. Сервіс також має конструктор супровідних листів. Умови підписки й автопродовження варто уважно перевірити перед оплатою.', 'Zety walks you through creating a resume step by step: choose a template, fill in the sections and download. Templates use ATS-friendly formatting, while AI and a library of ready-made phrases help you quickly describe your experience, skills and achievements for the target role. The service also has a cover letter builder. Check the subscription and auto-renewal terms carefully before paying.', 'Сотні ATS-сумісних шаблонів
AI-покращення тексту резюме
Готові фрази під посаду
Конструктор супровідних листів', 'Hundreds of ATS-friendly templates
AI improvement of resume text
Ready-made phrases by job title
Cover letter builder', 'Шукачам роботи будь-якого рівня, зокрема тим, хто пише резюме вперше.', 'Job seekers at any level, including those writing a resume for the first time.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zety.com' OR LOWER(`name`) = 'zety') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An online resume builder with AI suggestions, ATS-friendly templates and ready-made wording for many jobs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Zety walks you through creating a resume step by step: choose a template, fill in the sections and download. Templates use ATS-friendly formatting, while AI and a library of ready-made phrases help you quickly describe your experience, skills and achievements for the target role. The service also has a cover letter builder. Check the subscription and auto-renewal terms carefully before paying.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hundreds of ATS-friendly templates
AI improvement of resume text
Ready-made phrases by job title
Cover letter builder', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers at any level, including those writing a resume for the first time.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платна підписка', 'Paid subscription', NULL, 'month', 'Створення безкоштовне, завантаження й розширені функції — за підпискою; ціни на сайті.', 'Building is free; downloads and advanced features require a subscription; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платна підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Building is free; downloads and advanced features require a subscription; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Novorésumé — Резюме та супровідні листи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'novoresume.com' OR LOWER(`name`) = 'novorésumé')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Novorésumé', NULL, 'https://novoresume.com', NULL, NULL, 'Безкоштовний конструктор резюме з AI-підказками на базі Claude, ATS-шаблонами й імпортом старого резюме.', 'A free resume builder with Claude-powered AI suggestions, ATS-friendly templates and import of an existing resume.', 'Novorésumé дозволяє обрати шаблон і заповнити дані або імпортувати наявне резюме й перебудувати його в охайний ATS-сумісний дизайн одним кліком. Необов''язкові AI-підказки на базі Claude допомагають посилити формулювання. Є шаблони для студентів, випускників, керівників, дво- й багатосторінкові CV. Базова версія безкоштовна, преміум відкриває додаткові шаблони й функції.', 'Novorésumé lets you pick a template and fill in your details, or import an existing resume and rebuild it in a clean ATS-friendly design in one click. Optional Claude-powered AI suggestions help sharpen the wording. There are templates for students, graduates, executives and two-page or multi-page CVs. The basic version is free; premium unlocks extra templates and features.', 'Імпорт наявного резюме
AI-підказки на базі Claude
ATS-сумісні шаблони
Шаблони для студентів і керівників', 'Import of an existing resume
Claude-powered AI suggestions
ATS-friendly templates
Templates for students and executives', 'Шукачам роботи від студентів до досвідчених фахівців.', 'Job seekers from students to senior professionals.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'novoresume.com' OR LOWER(`name`) = 'novorésumé') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free resume builder with Claude-powered AI suggestions, ATS-friendly templates and import of an existing resume.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Novorésumé lets you pick a template and fill in your details, or import an existing resume and rebuild it in a clean ATS-friendly design in one click. Optional Claude-powered AI suggestions help sharpen the wording. There are templates for students, graduates, executives and two-page or multi-page CVs. The basic version is free; premium unlocks extra templates and features.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Import of an existing resume
Claude-powered AI suggestions
ATS-friendly templates
Templates for students and executives', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers from students to senior professionals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Базове резюме безкоштовно, без картки.', 'A basic resume for free, no credit card required.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A basic resume for free, no credit card required.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium (квартал)', 'Premium (quarterly)', NULL, 'month', '49.99 EUR за квартал.', '49.99 EUR per quarter.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium (квартал)' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium (quarterly)', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '49.99 EUR per quarter.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium (рік)', 'Premium (yearly)', NULL, 'year', '189.99 EUR на рік.', '189.99 EUR per year.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium (рік)' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium (yearly)', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '189.99 EUR per year.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Resume Worded — Резюме та супровідні листи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'resumeworded.com' OR LOWER(`name`) = 'resume worded')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Resume Worded', NULL, 'https://resumeworded.com', NULL, NULL, 'AI-оцінка резюме й профілю LinkedIn з детальними порадами, а також адаптація резюме під вакансію.', 'AI scoring of your resume and LinkedIn profile with detailed feedback, plus resume tailoring to a job.', 'Resume Worded миттєво оцінює резюме й профіль LinkedIn і дає конкретні поради, що виправити, щоб отримувати більше запрошень на співбесіди. Окремий інструмент підлаштовує резюме під опис вакансії, ще один допомагає складати пункти досвіду. Є шаблони для Google Docs і Word та шаблони листів для нетворкінгу. Наразі перевірка підтримує англомовні резюме у форматах PDF і DOCX.', 'Resume Worded instantly scores your resume and LinkedIn profile and gives specific feedback on what to fix to get more interviews. A separate tool tailors your resume to a job description, and another helps write bullet points. There are Google Docs and Word templates and networking email templates. The checker currently supports English resumes in PDF and DOCX.', 'Оцінка резюме з порадами
Аналіз профілю LinkedIn
Адаптація резюме під вакансію
Конструктор пунктів досвіду', 'Resume score with feedback
LinkedIn profile review
Resume tailoring to a job
Bullet point builder', 'Шукачам роботи, які подаються англійською, а також кар''єрним консультантам.', 'Job seekers applying in English and career coaches.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'resumeworded.com' OR LOWER(`name`) = 'resume worded') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI scoring of your resume and LinkedIn profile with detailed feedback, plus resume tailoring to a job.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Resume Worded instantly scores your resume and LinkedIn profile and gives specific feedback on what to fix to get more interviews. A separate tool tailors your resume to a job description, and another helps write bullet points. There are Google Docs and Word templates and networking email templates. The checker currently supports English resumes in PDF and DOCX.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Resume score with feedback
LinkedIn profile review
Resume tailoring to a job
Bullet point builder', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers applying in English and career coaches.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовна перевірка резюме.', 'Free resume review.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free resume review.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', NULL, 'month', 'Розширені функції в Resume Worded Pro; ціни на сайті.', 'Advanced features in Resume Worded Pro; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced features in Resume Worded Pro; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Resume.io — Резюме та супровідні листи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'resume.io' OR LOWER(`name`) = 'resume.io')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Resume.io', NULL, 'https://resume.io', NULL, NULL, 'Конструктор резюме й супровідних листів з AI-допомогою, ATS-шаблонами та шаблонами для Word і Google Docs.', 'A resume and cover letter builder with AI help, ATS-friendly templates and Word and Google Docs templates.', 'Resume.io дозволяє скласти резюме приблизно за п''ять хвилин у покроковому конструкторі. AI допомагає з текстом, а шаблони поділені за стилями й галузями: ATS-сумісні, сучасні, прості, для Word і Google Docs. Є приклади резюме для сотень професій і конструктор супровідних листів. Пробний платний доступ автоматично продовжується, тому умови варто перевірити перед оплатою.', 'Resume.io lets you put together a resume in about five minutes with a step-by-step builder. AI helps with the text, and templates are grouped by style and industry: ATS-friendly, modern, simple, Word and Google Docs. There are resume examples for hundreds of professions and a cover letter builder. The paid trial renews automatically, so check the terms before paying.', 'Покроковий конструктор резюме
AI-допомога з текстом
Шаблони для Word і Google Docs
Конструктор супровідних листів', 'Step-by-step resume builder
AI writing help
Word and Google Docs templates
Cover letter builder', 'Шукачам роботи, яким потрібне охайне резюме швидко.', 'Job seekers who need a polished resume quickly.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'resume.io' OR LOWER(`name`) = 'resume.io') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A resume and cover letter builder with AI help, ATS-friendly templates and Word and Google Docs templates.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Resume.io lets you put together a resume in about five minutes with a step-by-step builder. AI helps with the text, and templates are grouped by style and industry: ATS-friendly, modern, simple, Word and Google Docs. There are resume examples for hundreds of professions and a cover letter builder. The paid trial renews automatically, so check the terms before paying.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Step-by-step resume builder
AI writing help
Word and Google Docs templates
Cover letter builder', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers who need a polished resume quickly.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний доступ', 'Trial', NULL, 'week', '7 днів пробного доступу, далі автопродовження за $29.95 кожні 4 тижні.', '7-day trial, then auto-renews at $29.95 every 4 weeks.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пробний доступ' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '7-day trial, then auto-renews at $29.95 every 4 weeks.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Квартальний', 'Quarterly', NULL, 'month', '$49.95 кожні 3 місяці.', '$49.95 every 3 months.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Квартальний' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Quarterly', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$49.95 every 3 months.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Jobscan — Резюме та супровідні листи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jobscan.co' OR LOWER(`name`) = 'jobscan')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Jobscan', NULL, 'https://www.jobscan.co', NULL, NULL, 'Перевірка резюме на сумісність з ATS і збіг з вакансією, AI-оптимізація, супровідні листи й трекер.', 'Checks your resume for ATS compatibility and job match, with AI optimization, cover letters and a tracker.', 'Jobscan сканує резюме й порівнює його з описом вакансії, показуючи, яких навичок і ключових слів бракує для проходження систем відбору (ATS). AI допомагає переписати резюме під вакансію, згенерувати підсумок, пункти досвіду та супровідний лист. Також є оптимізація профілю LinkedIn, підбір вакансій під резюме, трекер відгуків і тренування співбесід з AI.', 'Jobscan scans your resume and compares it with a job description, showing which skills and keywords are missing to get through applicant tracking systems (ATS). AI helps you rewrite the resume for the job and generate a summary, bullet points and a cover letter. There is also LinkedIn profile optimization, job matching, an application tracker and AI interview practice.', 'Сканер резюме для ATS
AI-оптимізація під вакансію
Оптимізація профілю LinkedIn
Трекер відгуків і підбір вакансій', 'ATS resume scanner
AI optimization for a job
LinkedIn profile optimization
Application tracker and job matching', 'Шукачам роботи, особливо тим, хто подається у великі компанії з автоматичним відбором.', 'Job seekers, especially those applying to large companies with automated screening.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jobscan.co' OR LOWER(`name`) = 'jobscan') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Checks your resume for ATS compatibility and job match, with AI optimization, cover letters and a tracker.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Jobscan scans your resume and compares it with a job description, showing which skills and keywords are missing to get through applicant tracking systems (ATS). AI helps you rewrite the resume for the job and generate a summary, bullet points and a cover letter. There is also LinkedIn profile optimization, job matching, an application tracker and AI interview practice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'ATS resume scanner
AI optimization for a job
LinkedIn profile optimization
Application tracker and job matching', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers, especially those applying to large companies with automated screening.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовне сканування резюме з обмеженнями.', 'Free resume scans with limits.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free resume scans with limits.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium', 'Premium', NULL, 'month', 'Необмежені скани й AI-функції за підпискою; ціни на сайті.', 'Unlimited scans and AI features with a subscription; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Unlimited scans and AI features with a subscription; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Resume Genius — Резюме та супровідні листи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'resumegenius.com' OR LOWER(`name`) = 'resume genius')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Resume Genius', NULL, 'https://resumegenius.com', NULL, NULL, 'Конструктор резюме з готовими фразами під посаду, AI-генераторами, ATS-перевіркою й конструктором листів.', 'A resume builder with job-specific phrases, AI generators, an ATS checker and a cover letter maker.', 'Resume Genius допомагає зробити резюме навіть без досвіду роботи: потрібно обрати шаблон і готові професійно написані пункти досвіду під свою посаду. AI генерує резюме за коротким описом, підсумок і пункти досвіду, а перевірка ATS підказує, що виправити. Є конструктор супровідних листів і безкоштовний огляд резюме експертом. Платні плани автоматично продовжуються.', 'Resume Genius helps you make a resume even with no work experience: pick a template and professionally written bullet points for your role. AI generates a resume from a short prompt, a summary and bullet points, while the ATS checker suggests what to fix. There is a cover letter maker and a free expert resume review. Paid plans renew automatically.', 'Готові пункти досвіду під посаду
AI-генератор резюме
ATS-перевірка
Конструктор супровідних листів', 'Job-specific pre-written bullets
AI resume generator
ATS checker
Cover letter maker', 'Шукачам роботи, зокрема без досвіду, і тим, хто змінює професію.', 'Job seekers, including those with no experience and career changers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'resumegenius.com' OR LOWER(`name`) = 'resume genius') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A resume builder with job-specific phrases, AI generators, an ATS checker and a cover letter maker.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Resume Genius helps you make a resume even with no work experience: pick a template and professionally written bullet points for your role. AI generates a resume from a short prompt, a summary and bullet points, while the ATS checker suggests what to fix. There is a cover letter maker and a free expert resume review. Paid plans renew automatically.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Job-specific pre-written bullets
AI resume generator
ATS checker
Cover letter maker', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers, including those with no experience and career changers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний доступ до конструктора й ресурсів.', 'Free access to the builder and resources.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free access to the builder and resources.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, '14 днів', '14 days', 2.95, 'one_time', '$2.95 за 14 днів, далі автопродовження $23.95 кожні 4 тижні.', '$2.95 for 14 days, then auto-renews at $23.95 every four weeks.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = '14 днів' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', '14 days', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$2.95 for 14 days, then auto-renews at $23.95 every four weeks.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Рік', 'Annual', 95.40, 'year', '$95.40 за 12 місяців (еквівалент $7.95/міс).', '$95.40 for 12 months ($7.95/month equivalent).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Рік' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Annual', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$95.40 for 12 months ($7.95/month equivalent).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- LiveCareer — Резюме та супровідні листи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'livecareer.com' OR LOWER(`name`) = 'livecareer')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LiveCareer', NULL, 'https://www.livecareer.com', NULL, NULL, 'Конструктор резюме з AI-імпортом старого резюме, генератором підсумку й 50 тисячами готових фраз.', 'A resume builder with AI import of an old resume, a summary generator and 50,000 ready-made phrases.', 'LiveCareer пропонує ATS-сумісні шаблони резюме й бібліотеку з понад 50 тисяч готових навичок і фраз, підібраних за галуззю, рівнем і посадою. Можна завантажити старе резюме — AI розкладе історію роботи в новий макет — і згенерувати професійний підсумок. Форматування й оптимізація для ATS виконуються автоматично. Пробний доступ автоматично переходить у підписку.', 'LiveCareer offers ATS-friendly resume templates and a library of over 50,000 ready-made skills and phrases matched to industry, level and role. You can upload an old resume and AI will map your work history into a new layout, then generate a professional summary. Formatting and ATS optimization are automatic. The trial converts into a subscription automatically.', 'AI-імпорт старого резюме
50 000+ готових фраз
Генератор професійного підсумку
Автоматичне форматування для ATS', 'AI import of an old resume
50,000+ ready-made phrases
Professional summary generator
Automatic ATS formatting', 'Шукачам роботи, яким складно сформулювати досвід самостійно.', 'Job seekers who find it hard to put their experience into words.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'livecareer.com' OR LOWER(`name`) = 'livecareer') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A resume builder with AI import of an old resume, a summary generator and 50,000 ready-made phrases.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LiveCareer offers ATS-friendly resume templates and a library of over 50,000 ready-made skills and phrases matched to industry, level and role. You can upload an old resume and AI will map your work history into a new layout, then generate a professional summary. Formatting and ATS optimization are automatic. The trial converts into a subscription automatically.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI import of an old resume
50,000+ ready-made phrases
Professional summary generator
Automatic ATS formatting', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers who find it hard to put their experience into words.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, '14 днів', '14 days', 2.95, 'one_time', '$2.95 за 14 днів, далі $23.95 кожні 4 тижні.', '$2.95 for 14 days, then $23.95 every four weeks.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = '14 днів' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', '14 days', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$2.95 for 14 days, then $23.95 every four weeks.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Рік', 'Annual', 71.40, 'year', '$71.40 одразу за рік ($5.95/міс), з автопродовженням.', '$71.40 upfront for a year ($5.95/month), auto-renews.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Рік' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Annual', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$71.40 upfront for a year ($5.95/month), auto-renews.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- FlowCV — Резюме та супровідні листи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'flowcv.com' OR LOWER(`name`) = 'flowcv')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'FlowCV', NULL, 'https://flowcv.com', NULL, NULL, 'Безкоштовний конструктор резюме без водяних знаків: перше резюме безкоштовне назавжди, необмежені PDF.', 'A free resume builder with no watermarks: your first resume is free forever, with unlimited PDF downloads.', 'FlowCV дозволяє обрати один із понад 50 шаблонів або створити власний, заповнити розділи з підказками чи імпортувати наявне резюме. Макет і дизайн гнучко налаштовуються, чернетка зберігається автоматично, а PDF можна завантажувати без обмежень і водяних знаків. Сервіс відповідає GDPR. План Pro додає необмежену кількість резюме, супровідні листи й AI-інструменти.', 'FlowCV lets you pick one of 50+ templates or design your own, fill in sections with guidance or import an existing resume. Layout and design are fully adjustable, drafts save automatically, and PDFs can be downloaded without limits or watermarks. The service is GDPR compliant. The Pro plan adds unlimited resumes, cover letters and AI tools.', '50+ шаблонів і власні шаблони
Необмежені PDF без водяних знаків
Імпорт наявного резюме
Pro: супровідні листи й AI', '50+ templates and custom templates
Unlimited PDFs without watermarks
Import of an existing resume
Pro: cover letters and AI', 'Шукачам роботи, яким потрібне безкоштовне охайне резюме.', 'Job seekers who want a polished resume for free.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'flowcv.com' OR LOWER(`name`) = 'flowcv') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free resume builder with no watermarks: your first resume is free forever, with unlimited PDF downloads.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'FlowCV lets you pick one of 50+ templates or design your own, fill in sections with guidance or import an existing resume. Layout and design are fully adjustable, drafts save automatically, and PDFs can be downloaded without limits or watermarks. The service is GDPR compliant. The Pro plan adds unlimited resumes, cover letters and AI tools.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '50+ templates and custom templates
Unlimited PDFs without watermarks
Import of an existing resume
Pro: cover letters and AI', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers who want a polished resume for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Перше резюме безкоштовне назавжди.', 'Your first resume is free forever.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Your first resume is free forever.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 60.00, 'year', '$60 на рік; можна скасувати будь-коли.', '$60 billed yearly; cancel anytime.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$60 billed yearly; cancel anytime.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Reactive Resume — Резюме та супровідні листи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rxresu.me' OR LOWER(`name`) = 'reactive resume')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Reactive Resume', NULL, 'https://rxresu.me', NULL, NULL, 'Безкоштовний конструктор резюме з відкритим кодом: без реклами й платного доступу, з PDF і Word.', 'A free, open-source resume builder: no ads and no paywall, with PDF and Word downloads.', 'Reactive Resume — проєкт з відкритим кодом для створення, оновлення й поширення резюме. Він не показує рекламу й не має платних обмежень, а резюме можна завантажити у PDF чи Word або поділитися посиланням. Сервіс допомагає писати, оформлювати, перевіряти й адаптувати резюме. Охочі можуть розгорнути його на власному сервері.', 'Reactive Resume is an open-source project for creating, updating and sharing resumes. It shows no ads and has no paywall, and resumes can be downloaded as PDF or Word or shared via a link. The service helps you write, design, check and tailor your resume. You can also self-host it on your own server.', 'Відкритий код
Без реклами й платного доступу
Завантаження PDF і Word
Поширення резюме за посиланням', 'Open source
No ads and no paywall
PDF and Word downloads
Share your resume via a link', 'Шукачам роботи, які цінують приватність, і розробникам, що хочуть власний сервер.', 'Privacy-minded job seekers and developers who want to self-host.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rxresu.me' OR LOWER(`name`) = 'reactive resume') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free, open-source resume builder: no ads and no paywall, with PDF and Word downloads.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Reactive Resume is an open-source project for creating, updating and sharing resumes. It shows no ads and has no paywall, and resumes can be downloaded as PDF or Word or shared via a link. The service helps you write, design, check and tailor your resume. You can also self-host it on your own server.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Open source
No ads and no paywall
PDF and Word downloads
Share your resume via a link', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Privacy-minded job seekers and developers who want to self-host.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Повністю безкоштовний, відкритий код.', 'Completely free and open source.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Completely free and open source.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- VisualCV — Резюме та супровідні листи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'visualcv.com' OR LOWER(`name`) = 'visualcv')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'VisualCV', NULL, 'https://www.visualcv.com', NULL, NULL, 'Конструктор резюме з професійними шаблонами, онлайн-версією резюме й статистикою переглядів.', 'A resume builder with professional templates, an online resume and view tracking.', 'VisualCV допомагає створити резюме на основі професійно розроблених шаблонів і поділитися ним як файлом або онлайн-сторінкою. План Pro відкриває понад 30 шаблонів і показує, хто й скільки разів переглядав чи завантажував ваше CV. Сервісом, за даними компанії, користуються понад 3 мільйони людей.', 'VisualCV helps you build a resume from professionally designed templates and share it as a file or an online page. The Pro plan unlocks 30+ templates and shows how many times your CV was viewed or downloaded. According to the company, more than 3 million people use the service.', '30+ професійних шаблонів
Онлайн-версія резюме
Статистика переглядів і завантажень
Кілька версій резюме', '30+ professional templates
Online resume
View and download tracking
Multiple resume versions', 'Шукачам роботи, яким важливо знати, чи переглядають їхнє резюме.', 'Job seekers who want to know whether their resume is being viewed.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'visualcv.com' OR LOWER(`name`) = 'visualcv') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A resume builder with professional templates, an online resume and view tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'VisualCV helps you build a resume from professionally designed templates and share it as a file or an online page. The Pro plan unlocks 30+ templates and shows how many times your CV was viewed or downloaded. According to the company, more than 3 million people use the service.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '30+ professional templates
Online resume
View and download tracking
Multiple resume versions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers who want to know whether their resume is being viewed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Базовий безкоштовний план.', 'Basic free plan.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic free plan.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 16.00, 'month', '$16 на місяць.', '$16 per month.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$16 per month.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hiration — Резюме та супровідні листи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hiration.com' OR LOWER(`name`) = 'hiration')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hiration', NULL, 'https://www.hiration.com', NULL, NULL, 'AI-платформа для кар''єри: конструктор і перевірка резюме, супровідні листи, LinkedIn і тренування співбесід.', 'An AI career platform: resume builder and review, cover letters, LinkedIn and interview practice.', 'Hiration поєднує п''ять AI-інструментів в одній платформі: конструктор резюме, AI-огляд резюме, тренування співбесід, генерацію супровідних листів і оптимізацію профілю LinkedIn. AI-помічник у чаті підказує наступні кроки пошуку роботи. Платформа також працює з університетськими кар''єрними центрами. Заявлено відповідність SOC 2 Type II, GDPR і WCAG 2.1.', 'Hiration combines five AI tools on one platform: a resume builder, AI resume review, interview practice, cover letter generation and LinkedIn profile optimization. An AI chat assistant suggests next steps in your job search. The platform also works with university career centers. It states SOC 2 Type II, GDPR and WCAG 2.1 compliance.', 'AI-конструктор і огляд резюме
Тренування співбесід
Генерація супровідних листів
Оптимізація LinkedIn', 'AI resume builder and review
Interview practice
Cover letter generation
LinkedIn optimization', 'Шукачам роботи, студентам і кар''єрним центрам університетів.', 'Job seekers, students and university career centers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hiration.com' OR LOWER(`name`) = 'hiration') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI career platform: resume builder and review, cover letters, LinkedIn and interview practice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hiration combines five AI tools on one platform: a resume builder, AI resume review, interview practice, cover letter generation and LinkedIn profile optimization. An AI chat assistant suggests next steps in your job search. The platform also works with university career centers. It states SOC 2 Type II, GDPR and WCAG 2.1 compliance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI resume builder and review
Interview practice
Cover letter generation
LinkedIn optimization', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers, students and university career centers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Почати можна без картки; ціни на сайті.', 'You can start without a card; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'You can start without a card; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Wozber — Резюме та супровідні листи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wozber.com' OR LOWER(`name`) = 'wozber')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Wozber', NULL, 'https://www.wozber.com', NULL, NULL, 'Безкоштовний конструктор резюме без реєстрації, що працює в браузері й не зберігає ваші дані на сервері.', 'A free resume builder with no sign-up that works in the browser and does not store your data on its server.', 'Wozber дозволяє анонімно створити й завантажити резюме та супровідний лист прямо в браузері: персональні дані не зберігаються на сервері, якщо ви самі не вирішите зберегти прогрес. Усе необхідне для створення й завантаження резюме безкоштовне. Є ATS-сумісні шаблони, приклади й сканер резюме для ATS, а за окрему плату — додаткові послуги.', 'Wozber lets you anonymously create and download a resume and cover letter right in your browser: personal data is not stored on the server unless you choose to save your progress. Everything needed to build and download a resume is free. There are ATS-friendly templates, examples and an ATS resume scanner, plus optional paid services.', 'Без реєстрації
Дані залишаються в браузері
ATS-сумісні шаблони
Сканер резюме для ATS', 'No registration
Data stays in the browser
ATS-friendly templates
ATS resume scanner', 'Шукачам роботи, які дбають про приватність.', 'Privacy-conscious job seekers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wozber.com' OR LOWER(`name`) = 'wozber') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free resume builder with no sign-up that works in the browser and does not store your data on its server.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Wozber lets you anonymously create and download a resume and cover letter right in your browser: personal data is not stored on the server unless you choose to save your progress. Everything needed to build and download a resume is free. There are ATS-friendly templates, examples and an ATS resume scanner, plus optional paid services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'No registration
Data stays in the browser
ATS-friendly templates
ATS resume scanner', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Privacy-conscious job seekers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Створення й завантаження резюме безкоштовні.', 'Building and downloading a resume is free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Building and downloading a resume is free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ResumeNerd — Резюме та супровідні листи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'resumenerd.com' OR LOWER(`name`) = 'resumenerd')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ResumeNerd', NULL, 'https://www.resumenerd.com', NULL, NULL, 'Покроковий конструктор резюме з підказками рекрутерів і завантаженням у PDF, Word або TXT.', 'A step-by-step resume builder with recruiter tips and downloads in PDF, Word or TXT.', 'ResumeNerd проводить через створення резюме у три кроки: вибір професійного шаблону, заповнення даних з підказками рекрутерів і завантаження. Шаблони розраховані на проходження систем відбору (ATS). Готове резюме можна завантажити у форматах PDF, MS Word або TXT. На сайті є приклади резюме для різних професій.', 'ResumeNerd guides you through a resume in three steps: choose a professional template, enter your details with recruiter tips and download. Templates are designed to get past applicant tracking systems (ATS). The finished resume can be downloaded as PDF, MS Word or TXT. The site also has resume examples for many professions.', 'Покроковий процес
Підказки рекрутерів
Завантаження PDF, Word, TXT
Приклади резюме за професіями', 'Step-by-step process
Recruiter tips
PDF, Word and TXT downloads
Resume examples by profession', 'Шукачам роботи, яким потрібна покрокова допомога.', 'Job seekers who want step-by-step guidance.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'resumenerd.com' OR LOWER(`name`) = 'resumenerd') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A step-by-step resume builder with recruiter tips and downloads in PDF, Word or TXT.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ResumeNerd guides you through a resume in three steps: choose a professional template, enter your details with recruiter tips and download. Templates are designed to get past applicant tracking systems (ATS). The finished resume can be downloaded as PDF, MS Word or TXT. The site also has resume examples for many professions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Step-by-step process
Recruiter tips
PDF, Word and TXT downloads
Resume examples by profession', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers who want step-by-step guidance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платна підписка', 'Paid subscription', NULL, 'month', 'Ціни на сайті.', 'Prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платна підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Skillroads — Резюме та супровідні листи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'skillroads.com' OR LOWER(`name`) = 'skillroads')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Skillroads', NULL, 'https://skillroads.com', NULL, NULL, 'AI-генератор резюме й супровідних листів з перевіркою для ATS, а також кар''єрні консультації.', 'An AI resume and cover letter generator with an ATS check, plus career coaching services.', 'Skillroads використовує AI для створення резюме, перевірки його якості та сумісності з ATS і генерації супровідних листів. Перевірка резюме дає оцінку й поради. Окремо сервіс пропонує послуги людей: написання й редагування резюме, оновлення профілю LinkedIn і кар''єрні консультації.', 'Skillroads uses AI to create resumes, check their quality and ATS compatibility, and generate cover letters. The resume checker gives a score and recommendations. Separately, it offers human services: resume writing and editing, LinkedIn profile makeovers and career coaching.', 'AI-генератор резюме
Перевірка резюме з оцінкою
Генератор супровідних листів
Послуги кар''єрних консультантів', 'AI resume generator
Resume checker with a score
Cover letter generator
Career coaching services', 'Шукачам роботи, які хочуть поєднати AI з допомогою фахівця.', 'Job seekers who want to combine AI with expert help.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'skillroads.com' OR LOWER(`name`) = 'skillroads') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI resume and cover letter generator with an ATS check, plus career coaching services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Skillroads uses AI to create resumes, check their quality and ATS compatibility, and generate cover letters. The resume checker gives a score and recommendations. Separately, it offers human services: resume writing and editing, LinkedIn profile makeovers and career coaching.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI resume generator
Resume checker with a score
Cover letter generator
Career coaching services', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers who want to combine AI with expert help.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Резюме можна спробувати створити безкоштовно.', 'You can try the resume maker for free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'You can try the resume maker for free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Послуги', 'Services', NULL, 'one_time', 'Написання резюме й консультації — платні, ціни на сайті.', 'Resume writing and coaching are paid; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Послуги' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Services', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Resume writing and coaching are paid; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Standard Resume — Резюме та супровідні листи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'standardresume.co' OR LOWER(`name`) = 'standard resume')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Standard Resume', NULL, 'https://standardresume.co', NULL, NULL, 'Конструктор резюме з імпортом з LinkedIn, 12 шаблонами, перевіреними менеджерами з найму, і веб-резюме.', 'A resume builder with LinkedIn import, 12 hiring-manager-approved templates and a web resume.', 'Standard Resume дозволяє за кілька хвилин імпортувати дані з LinkedIn або почати з нуля, обрати один із 12 шаблонів і поділитися резюме як вебсторінкою чи PDF. Шаблони розроблені й перевірені разом з менеджерами з найму, а форматування застосовується автоматично. На сайті є посібник із написання резюме та приклади.', 'Standard Resume lets you import your data from LinkedIn or start from scratch in minutes, pick one of 12 templates and share the resume as a web page or PDF. Templates are designed and reviewed with hiring managers, and formatting is applied automatically. The site also has a resume writing handbook and examples.', 'Імпорт з LinkedIn
12 шаблонів від менеджерів з найму
Веб-резюме й PDF
Автоматичне форматування', 'LinkedIn import
12 hiring-manager-approved templates
Web resume and PDF
Automatic formatting', 'Фахівцям, особливо в IT, яким потрібне стримане й читабельне резюме.', 'Professionals, especially in tech, who need a clean and readable resume.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'standardresume.co' OR LOWER(`name`) = 'standard resume') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A resume builder with LinkedIn import, 12 hiring-manager-approved templates and a web resume.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Standard Resume lets you import your data from LinkedIn or start from scratch in minutes, pick one of 12 templates and share the resume as a web page or PDF. Templates are designed and reviewed with hiring managers, and formatting is applied automatically. The site also has a resume writing handbook and examples.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'LinkedIn import
12 hiring-manager-approved templates
Web resume and PDF
Automatic formatting', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Professionals, especially in tech, who need a clean and readable resume.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Створити резюме можна безкоштовно; розширені можливості — на сайті.', 'You can create a resume for free; advanced options on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'You can create a resume for free; advanced options on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kickresume — додатково в «Резюме та супровідні листи»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Kickresume') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Rezi — додатково в «Резюме та супровідні листи»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Rezi') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- CVGist — додатково в «Резюме та супровідні листи»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('CVGist') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;


-- =================== Підготовка до співбесід / Interview Preparation ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'interview-prep' LIMIT 1);

-- Big Interview — Підготовка до співбесід
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'biginterview.com' OR LOWER(`name`) = 'big interview')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Big Interview', NULL, 'https://www.biginterview.com', NULL, NULL, 'Платформа тренування співбесід: уроки, симулятор інтерв''ю й AI-відгук на відео відповіді.', 'An interview training platform: lessons, an interview simulator and AI feedback on your video answers.', 'Big Interview поєднує навчальні матеріали про те, як проходити співбесіди, із симулятором, де можна відрепетирувати відповіді на реалістичні запитання. Функція VideoAI аналізує запис відповіді й дає миттєвий відгук щодо подачі, чіткості та інших аспектів. Окремий модуль Big Resume дає AI-поради щодо резюме. Платформу використовують як окремі шукачі роботи, так і кар''єрні центри університетів і державні програми зайнятості.', 'Big Interview combines lessons on how to handle interviews with a simulator where you rehearse answers to realistic questions. The VideoAI feature analyzes a recording of your answer and gives instant feedback on delivery, clarity and more. A separate Big Resume module gives AI feedback on resumes. The platform is used by individual job seekers as well as university career centers and government workforce programs.', 'Уроки з проходження співбесід
Симулятор інтерв''ю
AI-відгук на відео відповіді
AI-поради щодо резюме', 'Interview lessons
Interview simulator
AI feedback on video answers
AI resume feedback', 'Шукачам роботи, студентам і кар''єрним консультантам.', 'Job seekers, students and career advisors.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'biginterview.com' OR LOWER(`name`) = 'big interview') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An interview training platform: lessons, an interview simulator and AI feedback on your video answers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Big Interview combines lessons on how to handle interviews with a simulator where you rehearse answers to realistic questions. The VideoAI feature analyzes a recording of your answer and gives instant feedback on delivery, clarity and more. A separate Big Resume module gives AI feedback on resumes. The platform is used by individual job seekers as well as university career centers and government workforce programs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Interview lessons
Interview simulator
AI feedback on video answers
AI resume feedback', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers, students and career advisors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Ціни на сайті.', 'Prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- interviewing.io — Підготовка до співбесід
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'interviewing.io' OR LOWER(`name`) = 'interviewing.io')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'interviewing.io', NULL, 'https://interviewing.io', NULL, NULL, 'Анонімні пробні технічні співбесіди з інженерами Meta, Google, OpenAI, Amazon та AI-інтерв''юер.', 'Anonymous mock technical interviews with engineers from Meta, Google, OpenAI and Amazon, plus an AI interviewer.', 'interviewing.io дозволяє записатися на анонімні пробні співбесіди з інженерами, які проводять такі інтерв''ю у провідних компаніях: програмування, проєктування систем, машинне навчання, поведінкові запитання. Після співбесіди ви отримуєте детальний відгук. Для практики без людини є AI-інтерв''юер, який проводить співбесіди з програмування й проєктування систем, і понад 200 задач із книжки «Beyond Cracking the Coding Interview» безкоштовно.', 'interviewing.io lets you book anonymous mock interviews with engineers who run these interviews at leading companies: coding, system design, machine learning and behavioral. After each session you get detailed feedback. For practice without a human, an AI interviewer runs coding and system design interviews, and 200+ problems from "Beyond Cracking the Coding Interview" are available for free.', 'Анонімні пробні співбесіди з інженерами
Програмування, system design, ML, поведінкові
AI-інтерв''юер
200+ безкоштовних задач', 'Anonymous mock interviews with engineers
Coding, system design, ML, behavioral
AI interviewer
200+ free problems', 'Розробникам і інженерам, які готуються до співбесід у великих технологічних компаніях.', 'Software engineers preparing for interviews at big tech companies.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'interviewing.io' OR LOWER(`name`) = 'interviewing.io') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Anonymous mock technical interviews with engineers from Meta, Google, OpenAI and Amazon, plus an AI interviewer.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'interviewing.io lets you book anonymous mock interviews with engineers who run these interviews at leading companies: coding, system design, machine learning and behavioral. After each session you get detailed feedback. For practice without a human, an AI interviewer runs coding and system design interviews, and 200+ problems from "Beyond Cracking the Coding Interview" are available for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Anonymous mock interviews with engineers
Coding, system design, ML, behavioral
AI interviewer
200+ free problems', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Software engineers preparing for interviews at big tech companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'AI-інтерв''юер', 'AI interviewer', 0.00, 'free', 'Спробувати AI-інтерв''юера й задачі можна безкоштовно.', 'The AI interviewer and problems can be tried for free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'AI-інтерв''юер' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'AI interviewer', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The AI interviewer and problems can be tried for free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Співбесіди з експертами', 'Expert mock interviews', NULL, 'one_time', 'Оплата за сесію; ціни на сайті.', 'Paid per session; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Співбесіди з експертами' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Expert mock interviews', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Paid per session; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Aced (formerly Exponent) — Підготовка до співбесід
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aced.io' OR LOWER(`name`) = 'aced (formerly exponent)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Aced (formerly Exponent)', NULL, 'https://www.aced.io', NULL, NULL, 'Підготовка до співбесід у техкомпаніях: курси для PM, інженерів, data science, тисячі реальних запитань і коучинг.', 'Tech interview prep: courses for PMs, engineers and data scientists, thousands of real questions and coaching.', 'Aced (раніше Exponent) готує до співбесід на посади продакт-менеджера, розробника, менеджера інженерної команди, data scientist, ML-інженера, дата-інженера та інших. Курси охоплюють проєктування систем, кейси, поведінкові запитання й технічні навички. Є база з тисяч реальних запитань, AI-практика, пробні співбесіди й коучинг з експертами.', 'Aced (formerly Exponent) prepares you for interviews for product manager, software engineer, engineering manager, data scientist, ML engineer, data engineer and other roles. Courses cover system design, cases, behavioral questions and technical skills. There is a bank of thousands of real questions, AI-powered practice, mock interviews and expert coaching.', 'Курси для PM, SWE, DS, ML та інших
Тисячі реальних запитань
AI-практика відповідей
Пробні співбесіди й коучинг', 'Courses for PM, SWE, DS, ML and more
Thousands of real questions
AI answer practice
Mock interviews and coaching', 'Фахівцям, які готуються до співбесід у технологічних компаніях.', 'Professionals preparing for interviews at tech companies.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aced.io' OR LOWER(`name`) = 'aced (formerly exponent)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tech interview prep: courses for PMs, engineers and data scientists, thousands of real questions and coaching.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Aced (formerly Exponent) prepares you for interviews for product manager, software engineer, engineering manager, data scientist, ML engineer, data engineer and other roles. Courses cover system design, cases, behavioral questions and technical skills. There is a bank of thousands of real questions, AI-powered practice, mock interviews and expert coaching.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Courses for PM, SWE, DS, ML and more
Thousands of real questions
AI answer practice
Mock interviews and coaching', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Professionals preparing for interviews at tech companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платна підписка', 'Paid subscription', NULL, 'month', 'Ціни на сайті.', 'Prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платна підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hello Interview — Підготовка до співбесід
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hellointerview.com' OR LOWER(`name`) = 'hello interview')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hello Interview', NULL, 'https://www.hellointerview.com', NULL, NULL, 'Підготовка розробників і менеджерів до співбесід: проєктування систем, програмування, поведінкові запитання.', 'Interview prep for engineers and managers: system design, coding and behavioral questions.', 'Hello Interview пропонує навчальні треки з проєктування систем, програмування, низькорівневого проєктування, проєктування ML-систем, поведінкових співбесід і програмування з AI. Є гайди по компаніях і запитання, що траплялися на реальних співбесідах. Почати можна безкоштовно, преміум відкриває всі курси й керовану практику; доступні також пробні співбесіди з експертами.', 'Hello Interview offers learning tracks on system design, coding, low-level design, ML system design, behavioral interviews and AI-enabled coding. There are company guides and questions reported from real interviews. You can start for free; premium unlocks all courses and guided practice, and mock interviews with experts are also available.', 'System design і low-level design
Гайди по компаніях
Поведінкові співбесіди
Пробні співбесіди з експертами', 'System design and low-level design
Company guides
Behavioral interviews
Expert mock interviews', 'Розробникам і менеджерам інженерних команд.', 'Software engineers and engineering managers.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hellointerview.com' OR LOWER(`name`) = 'hello interview') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Interview prep for engineers and managers: system design, coding and behavioral questions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hello Interview offers learning tracks on system design, coding, low-level design, ML system design, behavioral interviews and AI-enabled coding. There are company guides and questions reported from real interviews. You can start for free; premium unlocks all courses and guided practice, and mock interviews with experts are also available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'System design and low-level design
Company guides
Behavioral interviews
Expert mock interviews', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Software engineers and engineering managers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Частина матеріалів безкоштовна.', 'Part of the content is free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Part of the content is free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium (місяць)', 'Premium (1 month)', 59.00, 'month', '$59 за місяць доступу; бувають знижки.', '$59 for one month of access; discounts are sometimes offered.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium (місяць)' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium (1 month)', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$59 for one month of access; discounts are sometimes offered.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium (рік)', 'Premium (1 year)', 119.00, 'year', '$119 за рік, без автопродовження.', '$119 per year, does not auto-renew.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium (рік)' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium (1 year)', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$119 per year, does not auto-renew.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Lifetime', 'Lifetime', 399.00, 'one_time', '$399 за довічний доступ.', '$399 for lifetime access.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Lifetime' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Lifetime', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$399 for lifetime access.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- LeetCode — Підготовка до співбесід
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'leetcode.com' OR LOWER(`name`) = 'leetcode')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LeetCode', NULL, 'https://leetcode.com', NULL, NULL, 'Платформа задач з програмування для підготовки до технічних співбесід, з конкурсами й преміум-підпискою.', 'A coding problem platform for technical interview prep, with contests and a premium subscription.', 'LeetCode — велика база задач з алгоритмів і структур даних, на яких розробники тренуються перед технічними співбесідами. Розв''язки можна писати й перевіряти прямо в браузері. Преміум-підписка відкриває всі преміум-задачі, добірки за компаніями та інші функції.', 'LeetCode is a large library of algorithm and data structure problems that developers practice before technical interviews. You can write and test solutions right in the browser. The premium subscription unlocks all premium problems, company-tagged problem sets and other features.', 'Тисячі задач з алгоритмів
Редактор і перевірка коду в браузері
Задачі за компаніями (Premium)
Добірки задач для підготовки', 'Thousands of algorithm problems
In-browser editor and test runner
Company-tagged problems (Premium)
Curated problem lists', 'Розробникам, які готуються до технічних співбесід.', 'Developers preparing for technical interviews.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'leetcode.com' OR LOWER(`name`) = 'leetcode') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A coding problem platform for technical interview prep, with contests and a premium subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LeetCode is a large library of algorithm and data structure problems that developers practice before technical interviews. You can write and test solutions right in the browser. The premium subscription unlocks all premium problems, company-tagged problem sets and other features.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Thousands of algorithm problems
In-browser editor and test runner
Company-tagged problems (Premium)
Curated problem lists', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers preparing for technical interviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Більшість задач доступні безкоштовно.', 'Most problems are free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Most problems are free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium (місяць)', 'Premium (monthly)', 39.00, 'month', '$39 на місяць.', '$39 per month.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium (місяць)' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium (monthly)', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$39 per month.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium (рік)', 'Premium (yearly)', 159.00, 'year', '$159 на рік ($13.25/міс).', '$159 per year ($13.25/month).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium (рік)' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium (yearly)', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$159 per year ($13.25/month).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- NeetCode — Підготовка до співбесід
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'neetcode.io' OR LOWER(`name`) = 'neetcode')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NeetCode', NULL, 'https://neetcode.io', NULL, NULL, 'Дорожні карти підготовки до технічних співбесід: 1000+ задач з відеопоясненнями, курси й AI-співбесіди.', 'Tech interview roadmaps: 1,000+ practice problems with video explanations, courses and AI interviews.', 'NeetCode пропонує дорожні карти підготовки до співбесід із понад 1000 задачами та відеопоясненнями до них. У версії Pro відкриваються всі курси, AI-симуляція співбесід з програмування й закрита спільнота в Discord. Багато відеопояснень доступні безкоштовно.', 'NeetCode offers interview prep roadmaps with 1,000+ practice problems and video explanations. NeetCode Pro unlocks all courses, AI-driven coding interviews and a private Discord community. Many video explanations are free.', '1000+ задач з відеопоясненнями
Дорожні карти підготовки
AI-співбесіди з програмування (Pro)
Курси з алгоритмів і system design', '1,000+ problems with video explanations
Prep roadmaps
AI coding interviews (Pro)
Algorithms and system design courses', 'Розробникам, які готуються до співбесід з алгоритмів.', 'Developers preparing for algorithm interviews.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'neetcode.io' OR LOWER(`name`) = 'neetcode') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tech interview roadmaps: 1,000+ practice problems with video explanations, courses and AI interviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NeetCode offers interview prep roadmaps with 1,000+ practice problems and video explanations. NeetCode Pro unlocks all courses, AI-driven coding interviews and a private Discord community. Many video explanations are free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '1,000+ problems with video explanations
Prep roadmaps
AI coding interviews (Pro)
Algorithms and system design courses', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers preparing for algorithm interviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Частина задач і відео безкоштовні.', 'Some problems and videos are free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Some problems and videos are free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro (рік)', 'Pro (1 year)', 199.00, 'year', '$199 на рік (бувають знижки), автопродовження вимкнене за замовчуванням.', '$199 per year (discounts are sometimes offered); auto-renew is off by default.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro (рік)' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro (1 year)', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$199 per year (discounts are sometimes offered); auto-renew is off by default.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro Lifetime', 'Pro Lifetime', 599.00, 'one_time', '$599 разово (бувають знижки).', '$599 one-time (discounts are sometimes offered).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro Lifetime' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro Lifetime', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$599 one-time (discounts are sometimes offered).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AlgoExpert — Підготовка до співбесід
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'algoexpert.io' OR LOWER(`name`) = 'algoexpert')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AlgoExpert', NULL, 'https://www.algoexpert.io', NULL, NULL, 'Набір курсів для підготовки до співбесід з програмування з задачами, відеопоясненнями й пакетами доступу.', 'A set of coding interview prep products with problems, video explanations and bundle access.', 'AlgoExpert — платформа підготовки до співбесід з програмування з добірками задач і відеопоясненнями. Продукти можна купити окремо або пакетом All Access, що об''єднує сім продуктів. Регулярно бувають акції зі знижками.', 'AlgoExpert is a coding interview prep platform with curated problems and video explanations. Products can be bought individually or as an All Access bundle that combines seven products. Discount promotions run regularly.', 'Добірки задач для співбесід
Відеопояснення розв''язків
Пакет із 7 продуктів
Вбудоване середовище для коду', 'Curated interview problems
Video explanations
Bundle of 7 products
Built-in coding environment', 'Розробникам, які готуються до співбесід з алгоритмів.', 'Developers preparing for algorithm interviews.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'algoexpert.io' OR LOWER(`name`) = 'algoexpert') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A set of coding interview prep products with problems, video explanations and bundle access.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'AlgoExpert is a coding interview prep platform with curated problems and video explanations. Products can be bought individually or as an All Access bundle that combines seven products. Discount promotions run regularly.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Curated interview problems
Video explanations
Bundle of 7 products
Built-in coding environment', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers preparing for algorithm interviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'All Access', 'All Access', NULL, 'one_time', 'Пакет із 7 продуктів; ціна залежить від акції, див. сайт.', 'Bundle of 7 products; price depends on the current promotion, see the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'All Access' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'All Access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Bundle of 7 products; price depends on the current promotion, see the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Interview Query — Підготовка до співбесід
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'interviewquery.com' OR LOWER(`name`) = 'interview query')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Interview Query', NULL, 'https://www.interviewquery.com', NULL, NULL, 'Підготовка до співбесід з data science та аналітики: запитання, домашні завдання компаній і пробні співбесіди.', 'Data science and analytics interview prep: questions, company take-home challenges and mock interviews.', 'Interview Query допомагає готуватися до співбесід на посади data scientist, аналітика даних та ML-інженера. Є база запитань, понад 50 реальних домашніх завдань від компаній на кшталт Amazon, Airbnb, DoorDash і Uber з розв''язками, а також пробні співбесіди. Повний доступ — у преміум-підписці.', 'Interview Query helps you prepare for data scientist, data analyst and ML engineer interviews. There is a question bank, 50+ real take-home challenges from companies such as Amazon, Airbnb, DoorDash and Uber with solutions, and mock interviews. Full access is part of the premium subscription.', 'База запитань з data science
50+ реальних домашніх завдань
Пробні співбесіди
SQL, Python, статистика, ML', 'Data science question bank
50+ real take-home challenges
Mock interviews
SQL, Python, statistics, ML', 'Аналітикам даних, data scientists і ML-інженерам.', 'Data analysts, data scientists and ML engineers.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'interviewquery.com' OR LOWER(`name`) = 'interview query') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Data science and analytics interview prep: questions, company take-home challenges and mock interviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Interview Query helps you prepare for data scientist, data analyst and ML engineer interviews. There is a question bank, 50+ real take-home challenges from companies such as Amazon, Airbnb, DoorDash and Uber with solutions, and mock interviews. Full access is part of the premium subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Data science question bank
50+ real take-home challenges
Mock interviews
SQL, Python, statistics, ML', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Data analysts, data scientists and ML engineers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium', 'Premium', NULL, 'month', 'Ціни на сайті; бувають сезонні знижки.', 'Prices on the site; seasonal discounts are offered.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Prices on the site; seasonal discounts are offered.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- StrataScratch — Підготовка до співбесід
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'stratascratch.com' OR LOWER(`name`) = 'stratascratch')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'StrataScratch', NULL, 'https://www.stratascratch.com', NULL, NULL, '1000+ реальних запитань для співбесід з data science, ML та AI-інженерії, AI-співбесіди й портфоліо-проєкти.', '1,000+ real interview questions for data science, ML and AI engineering, AI mock interviews and portfolio projects.', 'StrataScratch дає змогу практикувати реальні запитання зі співбесід на посади data scientist, ML-інженера та AI-інженера: SQL, Python, концепції ML. AI проводить пробні співбесіди й оцінює міркування, а в Data Labs можна будувати проєкти для портфоліо. Безкоштовний план має обмежені функції та 50 AI-кредитів на місяць.', 'StrataScratch lets you practice real interview questions for data scientist, ML engineer and AI engineer roles: SQL, Python and ML concepts. AI runs mock interviews and grades your reasoning, and Data Labs let you build portfolio projects. The free plan has limited features and 50 AI credits per month.', '1000+ реальних запитань
AI-пробні співбесіди
Проєкти для портфоліо
SQL, Python, ML', '1,000+ real questions
AI mock interviews
Portfolio projects
SQL, Python, ML', 'Тим, хто готується до співбесід з data science, ML та AI-інженерії.', 'Candidates preparing for data science, ML and AI engineering interviews.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'stratascratch.com' OR LOWER(`name`) = 'stratascratch') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', '1,000+ real interview questions for data science, ML and AI engineering, AI mock interviews and portfolio projects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'StrataScratch lets you practice real interview questions for data scientist, ML engineer and AI engineer roles: SQL, Python and ML concepts. AI runs mock interviews and grades your reasoning, and Data Labs let you build portfolio projects. The free plan has limited features and 50 AI credits per month.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '1,000+ real questions
AI mock interviews
Portfolio projects
SQL, Python, ML', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Candidates preparing for data science, ML and AI engineering interviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Обмежені функції, 50 AI-кредитів на місяць.', 'Limited features, 50 AI credits per month.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Limited features, 50 AI credits per month.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Рік', 'Yearly', 139.00, 'year', '$139 на рік, 1000 AI-кредитів на місяць.', '$139 billed annually, 1,000 AI credits per month.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Рік' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Yearly', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$139 billed annually, 1,000 AI credits per month.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Educative — Підготовка до співбесід
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'educative.io' OR LOWER(`name`) = 'educative')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Educative', NULL, 'https://www.educative.io', NULL, NULL, 'Інтерактивні текстові курси для розробників: AI, проєктування систем і підготовка до співбесід з практикою.', 'Interactive text-based courses for developers: AI, system design and interview prep with hands-on practice.', 'Educative — платформа інтерактивних курсів для розробників із вбудованими середовищами для коду. Найвідоміші напрями — проєктування систем, підготовка до технічних співбесід, генеративний AI і LLM. Підписка Unlimited відкриває понад 1400 курсів, проєктів, навчальних шляхів і хмарних лабораторій, персоналізовані уроки та пробні співбесіди.', 'Educative is a platform of interactive courses for developers with built-in coding environments. Its best-known topics are system design, technical interview prep, generative AI and LLMs. The Unlimited subscription unlocks 1,400+ courses, projects, paths and cloud labs, personalized tutorials and mock interviews.', '1400+ курсів і проєктів
Проєктування систем
Пробні співбесіди
Хмарні лабораторії', '1,400+ courses and projects
System design
Mock interviews
Cloud labs', 'Розробникам будь-якого рівня, які вчаться через практику.', 'Developers at any level who learn by building.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'educative.io' OR LOWER(`name`) = 'educative') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Interactive text-based courses for developers: AI, system design and interview prep with hands-on practice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Educative is a platform of interactive courses for developers with built-in coding environments. Its best-known topics are system design, technical interview prep, generative AI and LLMs. The Unlimited subscription unlocks 1,400+ courses, projects, paths and cloud labs, personalized tutorials and mock interviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '1,400+ courses and projects
System design
Mock interviews
Cloud labs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers at any level who learn by building.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Unlimited', 'Unlimited', NULL, 'year', 'Підписка на всю бібліотеку; ціни на сайті.', 'Subscription to the whole library; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Unlimited' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Unlimited', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Subscription to the whole library; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Prepfully — Підготовка до співбесід
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prepfully.com' OR LOWER(`name`) = 'prepfully')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Prepfully', NULL, 'https://prepfully.com', NULL, NULL, 'Пробні співбесіди з коучами з Google, Amazon, Meta та інших компаній, AI-співбесіди й гайди по компаніях.', 'Mock interviews with coaches from Google, Amazon, Meta and others, AI mock interviews and company guides.', 'Prepfully з''єднує кандидатів із майже двома тисячами перевірених коучів, які працюють у понад 1600 компаніях, для пробних співбесід під конкретну роль і компанію. Також є AI-співбесіди, база запитань від недавніх кандидатів, перевірена експертами, і гайди з повним процесом відбору.', 'Prepfully connects candidates with nearly two thousand verified coaches working at 1,600+ companies for mock interviews tailored to a specific role and company. There are also AI mock interviews, a question bank submitted by recent candidates and vetted by experts, and end-to-end interview process guides.', 'Пробні співбесіди з коучами з компаній
AI-співбесіди
База запитань від кандидатів
Гайди по процесу відбору', 'Mock interviews with company coaches
AI mock interviews
Candidate-sourced question bank
Interview process guides', 'Кандидатам на посади в технологічних компаніях.', 'Candidates for roles at tech companies.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prepfully.com' OR LOWER(`name`) = 'prepfully') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mock interviews with coaches from Google, Amazon, Meta and others, AI mock interviews and company guides.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Prepfully connects candidates with nearly two thousand verified coaches working at 1,600+ companies for mock interviews tailored to a specific role and company. There are also AI mock interviews, a question bank submitted by recent candidates and vetted by experts, and end-to-end interview process guides.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Mock interviews with company coaches
AI mock interviews
Candidate-sourced question bank
Interview process guides', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Candidates for roles at tech companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'AI-співбесіди', 'AI mock interviews', 0.00, 'free', 'AI-співбесіди можна спробувати безкоштовно.', 'AI mock interviews can be tried for free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'AI-співбесіди' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'AI mock interviews', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'AI mock interviews can be tried for free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Сесії з коучами', 'Coaching sessions', NULL, 'one_time', 'Ціну встановлює коуч; див. сайт.', 'Price is set by each coach; see the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Сесії з коучами' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Coaching sessions', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Price is set by each coach; see the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Huru — Підготовка до співбесід
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'huru.ai' OR LOWER(`name`) = 'huru')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Huru', NULL, 'https://huru.ai', NULL, NULL, 'AI-тренер співбесід: відповідаєте вголос на запитання для 242+ професій і отримуєте оцінку й поради.', 'An AI interview coach: answer questions out loud for 242+ roles and get a score and tips.', 'Huru — платформа відеотренування співбесід. Ви відповідаєте вголос на реальні запитання для понад 242 професій, а модель Huru оцінює відповідь, показує, що вдалося, і що варто покращити в наступній спробі. Інтерфейс доступний кількома мовами, почати можна безкоштовно; є версія для організацій.', 'Huru is a video interview practice platform. You answer real questions out loud for 242+ roles, and Huru''s model scores the answer, shows what worked and what to improve next time. The interface is available in several languages and you can start for free; there is also a version for organizations.', 'Запитання для 242+ професій
Оцінка відповідей AI
Конкретні поради для наступної спроби
Кілька мов інтерфейсу', 'Questions for 242+ roles
AI answer scoring
Specific tips for the next take
Multiple interface languages', 'Шукачам роботи, які хочуть впевненіше відповідати на співбесідах.', 'Job seekers who want to answer more confidently in interviews.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'huru.ai' OR LOWER(`name`) = 'huru') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI interview coach: answer questions out loud for 242+ roles and get a score and tips.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Huru is a video interview practice platform. You answer real questions out loud for 242+ roles, and Huru''s model scores the answer, shows what worked and what to improve next time. The interface is available in several languages and you can start for free; there is also a version for organizations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Questions for 242+ roles
AI answer scoring
Specific tips for the next take
Multiple interface languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers who want to answer more confidently in interviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Почати можна безкоштовно.', 'You can start for free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'You can start for free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Ціни на сайті.', 'Prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- InterviewBit — Підготовка до співбесід
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'interviewbit.com' OR LOWER(`name`) = 'interviewbit')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'InterviewBit', NULL, 'https://www.interviewbit.com', NULL, NULL, 'Задачі й посібники для технічних співбесід, безкоштовні пробні тести й пробні співбесіди з колегами.', 'Problems and guides for technical interviews, free mock tests and peer mock interviews.', 'InterviewBit від Scaler пропонує задачі з програмування, які траплялися на співбесідах, посібники з підготовки, відеокурси й конкурси. Є безкоштовні пробні тести з реальними запитаннями та пробні співбесіди в парі з іншим кандидатом. Також доступні онлайн-компілятори для C++, C, Python, Java і JavaScript.', 'InterviewBit by Scaler offers coding problems asked in interviews, prep guides, video courses and contests. There are free mock assessments with real interview questions and peer mock interviews with another candidate. Online compilers for C++, C, Python, Java and JavaScript are also available.', 'Задачі зі співбесід
Безкоштовні пробні тести
Пробні співбесіди з колегою
Онлайн-компілятори', 'Interview problems
Free mock assessments
Peer mock interviews
Online compilers', 'Студентам і розробникам, які готуються до технічних співбесід.', 'Students and developers preparing for technical interviews.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'interviewbit.com' OR LOWER(`name`) = 'interviewbit') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Problems and guides for technical interviews, free mock tests and peer mock interviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'InterviewBit by Scaler offers coding problems asked in interviews, prep guides, video courses and contests. There are free mock assessments with real interview questions and peer mock interviews with another candidate. Online compilers for C++, C, Python, Java and JavaScript are also available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Interview problems
Free mock assessments
Peer mock interviews
Online compilers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students and developers preparing for technical interviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Задачі й пробні тести безкоштовні.', 'Problems and mock tests are free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Problems and mock tests are free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Interview Kickstart — Підготовка до співбесід
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'interviewkickstart.com' OR LOWER(`name`) = 'interview kickstart')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Interview Kickstart', NULL, 'https://interviewkickstart.com', NULL, NULL, 'Програми з викладачами з великих техкомпаній: підготовка до співбесід, перехід в AI/ML і пробні співбесіди.', 'Instructor-led programs from big tech engineers: interview prep, AI/ML career switch and mock interviews.', 'Interview Kickstart пропонує програми з підготовки до технічних співбесід для бекенд-, дата-, SRE-інженерів, менеджерів і TPM, а також курси для переходу в машинне навчання, data science і агентний AI. Навчання ведуть понад 700 викладачів із провідних техкомпаній, є персональний коучинг і пробні співбесіди. Безкоштовні інструменти включають аналіз резюме й зарплат.', 'Interview Kickstart runs technical interview prep programs for backend, data and SRE engineers, managers and TPMs, plus courses for switching into machine learning, data science and agentic AI. Programs are taught by 700+ instructors from top tech companies, with personal coaching and mock interviews. Free tools include resume and salary analyzers.', 'Програми під конкретні ролі
700+ викладачів із техкомпаній
Пробні співбесіди й коучинг
Курси з AI/ML', 'Role-specific programs
700+ instructors from tech companies
Mock interviews and coaching
AI/ML courses', 'Досвідченим інженерам, які цілять у великі техкомпанії або переходять в AI.', 'Experienced engineers targeting big tech or moving into AI.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'interviewkickstart.com' OR LOWER(`name`) = 'interview kickstart') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Instructor-led programs from big tech engineers: interview prep, AI/ML career switch and mock interviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Interview Kickstart runs technical interview prep programs for backend, data and SRE engineers, managers and TPMs, plus courses for switching into machine learning, data science and agentic AI. Programs are taught by 700+ instructors from top tech companies, with personal coaching and mock interviews. Free tools include resume and salary analyzers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Role-specific programs
700+ instructors from tech companies
Mock interviews and coaching
AI/ML courses', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Experienced engineers targeting big tech or moving into AI.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Програми', 'Programs', NULL, 'one_time', 'Вартість програм — на сайті.', 'Program fees are listed on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Програми' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Programs', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Program fees are listed on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Interviews by AI — Підготовка до співбесід
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'interviewsby.ai' OR LOWER(`name`) = 'interviews by ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Interviews by AI', NULL, 'https://interviewsby.ai', NULL, NULL, 'Вставте опис вакансії — отримаєте реалістичні запитання співбесіди, потренуєтеся вголос і отримаєте AI-відгук.', 'Paste a job description to get realistic interview questions, practice out loud and receive AI feedback.', 'Interviews by AI генерує поведінкові й технічні запитання за описом вакансії або для типових ролей. Ви відповідаєте вголос, а AI дає миттєвий відгук за методом STAR. У версії Pro можна завантажити резюме, щоб запитання точніше відповідали вашому досвіду, і отримати більше часу на відповідь.', 'Interviews by AI generates behavioral and technical questions from a job description or for common roles. You answer out loud and the AI gives instant STAR-based feedback. Pro lets you upload your resume so questions match your experience more closely, and gives longer response times.', 'Запитання за описом вакансії
Відповіді вголос
Відгук за методом STAR
Завантаження резюме (Pro)', 'Questions from a job description
Answer out loud
STAR-based feedback
Resume upload (Pro)', 'Шукачам роботи будь-якої сфери.', 'Job seekers in any field.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'interviewsby.ai' OR LOWER(`name`) = 'interviews by ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Paste a job description to get realistic interview questions, practice out loud and receive AI feedback.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Interviews by AI generates behavioral and technical questions from a job description or for common roles. You answer out loud and the AI gives instant STAR-based feedback. Pro lets you upload your resume so questions match your experience more closely, and gives longer response times.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Questions from a job description
Answer out loud
STAR-based feedback
Resume upload (Pro)', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers in any field.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', '3 запитання на місяць.', '3 questions per month.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '3 questions per month.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 9.00, 'month', '$9 на місяць: необмежені запитання, завантаження резюме, довші відповіді.', '$9 per month: unlimited questions, resume upload, longer responses.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$9 per month: unlimited questions, resume upload, longer responses.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Yoodli — додатково в «Підготовка до співбесід»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Yoodli') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Orai — додатково в «Підготовка до співбесід»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Orai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;


-- =================== Пошук вакансій / Job Search ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'job-search' LIMIT 1);

-- LinkedIn — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'linkedin.com' OR LOWER(`name`) = 'linkedin')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LinkedIn', NULL, 'https://www.linkedin.com', NULL, NULL, 'Професійна мережа з понад мільярдом учасників: вакансії, нетворкінг, профіль-резюме й навчання.', 'A professional network with over a billion members: jobs, networking, a profile as your resume and learning.', 'LinkedIn — професійна соціальна мережа, де можна вести профіль замість резюме, шукати вакансії й стажування, підписуватися на компанії та спілкуватися з рекрутерами. Платформа рекомендує вакансії й контент за вашою сферою. Підписка Premium Career допомагає виділитися серед кандидатів, зв''язуватися з рекрутерами напряму й розвивати навички; є безкоштовний пробний період.', 'LinkedIn is a professional social network where your profile serves as a resume, and you can search for jobs and internships, follow companies and talk to recruiters. The platform recommends jobs and content for your field. The Premium Career subscription helps you stand out to hiring managers, message recruiters directly and build skills; a free trial is available.', 'Пошук вакансій і стажувань
Профіль як онлайн-резюме
Зв''язок із рекрутерами
Premium Career з пробним періодом', 'Job and internship search
Profile as an online resume
Recruiter networking
Premium Career with a free trial', 'Усім, хто шукає роботу, будує професійні зв''язки чи наймає.', 'Anyone looking for work, building a professional network or hiring.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'linkedin.com' OR LOWER(`name`) = 'linkedin') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A professional network with over a billion members: jobs, networking, a profile as your resume and learning.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LinkedIn is a professional social network where your profile serves as a resume, and you can search for jobs and internships, follow companies and talk to recruiters. The platform recommends jobs and content for your field. The Premium Career subscription helps you stand out to hiring managers, message recruiters directly and build skills; a free trial is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Job and internship search
Profile as an online resume
Recruiter networking
Premium Career with a free trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone looking for work, building a professional network or hiring.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Базовий акаунт безкоштовний.', 'The basic account is free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The basic account is free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium Career', 'Premium Career', NULL, 'month', 'Є безкоштовний пробний період; ціна залежить від країни, див. сайт.', 'A free trial is available; the price depends on your country, see the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium Career' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium Career', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free trial is available; the price depends on your country, see the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Indeed — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'indeed.com' OR LOWER(`name`) = 'indeed')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Indeed', NULL, 'https://www.indeed.com', NULL, NULL, 'Міжнародний сайт пошуку роботи з вакансіями з тисяч джерел, відгуками про компанії та даними про зарплати.', 'An international job search site with listings from thousands of sources, company reviews and salary data.', 'Indeed збирає вакансії з тисяч джерел і дає змогу шукати роботу за посадою та містом, зокрема в Україні. Після реєстрації сервіс показує персональні рекомендації вакансій і надсилає свіжі добірки на пошту. Також є відгуки працівників про компанії й дані про зарплати.', 'Indeed aggregates job listings from thousands of sources and lets you search by title and city, including in Ukraine. Once you sign in, it shows personalized job recommendations and emails fresh listings. There are also employee company reviews and salary data.', 'Вакансії з тисяч джерел
Персональні рекомендації
Розсилка свіжих вакансій
Відгуки про компанії й зарплати', 'Listings from thousands of sources
Personalized recommendations
Job alert emails
Company reviews and salaries', 'Шукачам роботи в Україні та за кордоном.', 'Job seekers in Ukraine and abroad.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'indeed.com' OR LOWER(`name`) = 'indeed') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An international job search site with listings from thousands of sources, company reviews and salary data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Indeed aggregates job listings from thousands of sources and lets you search by title and city, including in Ukraine. Once you sign in, it shows personalized job recommendations and emails fresh listings. There are also employee company reviews and salary data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Listings from thousands of sources
Personalized recommendations
Job alert emails
Company reviews and salaries', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers in Ukraine and abroad.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Для шукачів роботи безкоштовно.', 'Free for job seekers.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for job seekers.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Wellfound — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wellfound.com' OR LOWER(`name`) = 'wellfound')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Wellfound', NULL, 'https://wellfound.com', NULL, NULL, 'Вакансії в стартапах: відгукуйтеся напряму засновникам і менеджерам з найму у 27 000+ компаній.', 'Startup jobs: apply directly to founders and hiring managers at 27,000+ companies.', 'Wellfound — платформа найму для стартапів. Кандидати можуть подаватися напряму засновникам і менеджерам з найму у понад 27 000 стартапів і отримувати підібрані під себе вакансії, часто з вказаною зарплатою. Для компаній є безкоштовні публікації вакансій, AI-агенти пошуку кандидатів і рекрутери.', 'Wellfound is a hiring platform for startups. Candidates can apply directly to founders and hiring managers at 27,000+ startups and get matched roles, often with salary ranges shown. Companies get free job posts, AI sourcing agents and dedicated recruiters.', '27 000+ стартапів
Подача напряму засновникам
Підбір вакансій із зарплатами
AI-агенти пошуку для компаній', '27,000+ startups
Apply directly to founders
Matched roles with salaries
AI sourcing agents for companies', 'Фахівцям, які хочуть працювати в стартапі.', 'Professionals who want to work at a startup.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wellfound.com' OR LOWER(`name`) = 'wellfound') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Startup jobs: apply directly to founders and hiring managers at 27,000+ companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Wellfound is a hiring platform for startups. Candidates can apply directly to founders and hiring managers at 27,000+ startups and get matched roles, often with salary ranges shown. Companies get free job posts, AI sourcing agents and dedicated recruiters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '27,000+ startups
Apply directly to founders
Matched roles with salaries
AI sourcing agents for companies', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Professionals who want to work at a startup.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Для шукачів роботи безкоштовно.', 'Free for job seekers.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for job seekers.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Welcome to the Jungle — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'welcometothejungle.com' OR LOWER(`name`) = 'welcome to the jungle')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Welcome to the Jungle', NULL, 'https://www.welcometothejungle.com', NULL, NULL, 'Пошук роботи з детальними профілями компаній, підбором вакансій і AI-коучем для кандидатів.', 'Job search with rich company profiles, job matching and an AI coach for candidates.', 'Welcome to the Jungle допомагає знайти не просто вакансію, а компанію, яка вам підходить: профілі роботодавців містять фото, відео й статистику про те, як там працюється. Ви описуєте себе й свої побажання, а сервіс пропонує відповідні вакансії, зокрема в tech; рекрутери можуть самі знаходити ваш профіль. Є AI-коуч для кандидатів і корисні статті.', 'Welcome to the Jungle helps you find not just a job but a company that fits: employer profiles include photos, videos and stats on what it is like to work there. You describe yourself and your preferences and get matched jobs, including in tech; recruiters can find your profile too. There is an AI candidate coach and career content.', 'Профілі компаній з фото й відео
Підбір вакансій за профілем
Рекрутери знаходять вас самі
AI-коуч для кандидатів', 'Company profiles with photos and videos
Profile-based job matching
Recruiters come to you
AI candidate coach', 'Шукачам роботи в Європі та США, особливо в tech.', 'Job seekers in Europe and the US, especially in tech.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'welcometothejungle.com' OR LOWER(`name`) = 'welcome to the jungle') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Job search with rich company profiles, job matching and an AI coach for candidates.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Welcome to the Jungle helps you find not just a job but a company that fits: employer profiles include photos, videos and stats on what it is like to work there. You describe yourself and your preferences and get matched jobs, including in tech; recruiters can find your profile too. There is an AI candidate coach and career content.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Company profiles with photos and videos
Profile-based job matching
Recruiters come to you
AI candidate coach', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers in Europe and the US, especially in tech.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Для шукачів роботи безкоштовно.', 'Free for job seekers.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for job seekers.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Simplify — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'simplify.jobs' OR LOWER(`name`) = 'simplify')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Simplify', NULL, 'https://simplify.jobs', NULL, NULL, 'AI-помічник для пошуку роботи: підбір вакансій, адаптація резюме, автозаповнення заявок і трекер.', 'An AI job search assistant: job matching, resume tailoring, application autofill and a tracker.', 'Simplify підбирає відповідні вакансії, підлаштовує резюме під кожну, автоматично заповнює форми заявок через розширення Copilot і зводить усі відгуки в трекер. Є також конструктор резюме, допомога з нетворкінгом і представленням рекрутерам. Перед подачею варто перевіряти, що саме заповнив помічник.', 'Simplify matches you with relevant jobs, tailors your resume for each one, autofills application forms via its Copilot extension and keeps all applications in a tracker. There is also a resume builder and help with networking and recruiter introductions. Review what the assistant fills in before you submit.', 'Підбір вакансій
AI-адаптація резюме
Автозаповнення заявок (розширення)
Трекер відгуків', 'Job matching
AI resume tailoring
Application autofill (extension)
Application tracker', 'Шукачам роботи, які подаються на багато вакансій.', 'Job seekers who apply to many roles.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'simplify.jobs' OR LOWER(`name`) = 'simplify') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI job search assistant: job matching, resume tailoring, application autofill and a tracker.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Simplify matches you with relevant jobs, tailors your resume for each one, autofills application forms via its Copilot extension and keeps all applications in a tracker. There is also a resume builder and help with networking and recruiter introductions. Review what the assistant fills in before you submit.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Job matching
AI resume tailoring
Application autofill (extension)
Application tracker', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers who apply to many roles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Почати можна безкоштовно.', 'You can start for free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'You can start for free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платний план', 'Paid plan', NULL, 'month', 'Розширені AI-функції; ціни на сайті.', 'Advanced AI features; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платний план' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plan', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advanced AI features; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Jobright — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jobright.ai' OR LOWER(`name`) = 'jobright')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Jobright', NULL, 'https://jobright.ai', NULL, NULL, 'AI-копілот пошуку роботи: персональний підбір із 8 млн вакансій, адаптоване резюме й автозаповнення.', 'An AI job search copilot: personalized matches from 8M+ jobs, tailored resumes and autofill.', 'Jobright підбирає вакансії, на які ви справді кваліфіковані, з бази понад 8 мільйонів вакансій із щоденними оновленнями та фільтрує фейкові оголошення. Сервіс створює резюме під конкретну вакансію, заповнює заявки в один клік на основних ATS-платформах і підказує знайомих у компанії, через яких можна отримати рекомендацію. Орієнтований переважно на ринок США.', 'Jobright matches you with jobs you are actually qualified for from a database of 8M+ listings with daily updates, filtering out fake postings. It creates job-specific resumes, fills in applications in one click across major ATS platforms and suggests insider connections for referrals. It focuses mainly on the US market.', 'Підбір із 8 млн+ вакансій
Резюме під вакансію
Автозаповнення заявок
Підказки контактів для рекомендацій', 'Matches from 8M+ jobs
Job-specific resumes
Application autofill
Insider connection suggestions', 'Шукачам роботи в США.', 'Job seekers in the US.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jobright.ai' OR LOWER(`name`) = 'jobright') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI job search copilot: personalized matches from 8M+ jobs, tailored resumes and autofill.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Jobright matches you with jobs you are actually qualified for from a database of 8M+ listings with daily updates, filtering out fake postings. It creates job-specific resumes, fills in applications in one click across major ATS platforms and suggests insider connections for referrals. It focuses mainly on the US market.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Matches from 8M+ jobs
Job-specific resumes
Application autofill
Insider connection suggestions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers in the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Спробувати можна безкоштовно.', 'You can try it for free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'You can try it for free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платний план', 'Paid plan', NULL, 'month', 'Ціни на сайті.', 'Prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платний план' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plan', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- LoopCV — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'loopcv.pro' OR LOWER(`name`) = 'loopcv')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LoopCV', NULL, 'https://www.loopcv.pro', NULL, NULL, 'Автоматичні відгуки на вакансії: завантажте CV, і сервіс щодня подається на відповідні вакансії з 30+ сайтів.', 'Automated job applications: upload your CV and it applies daily to matching jobs from 30+ job boards.', 'LoopCV щодня сканує понад 30 сайтів вакансій, підбирає ролі під ваше резюме й надсилає відгуки від вашого імені, а також може надсилати листи рекрутерам. Можна виключити певні компанії, налаштувати фільтри й відстежувати статистику. Є AI-перевірка й конструктор CV, тренування співбесід. Масові автоматичні відгуки варто налаштовувати обережно, щоб не подаватися на невідповідні вакансії.', 'LoopCV scans 30+ job boards daily, matches roles to your resume and submits applications on your behalf, and can also email recruiters. You can exclude companies, set filters and track statistics. There is an AI CV checker and builder and mock interviews. Configure mass auto-applying carefully to avoid applying to unsuitable roles.', 'Автоподача на 30+ сайтах
Фільтри й виключення компаній
Листи рекрутерам
AI-перевірка CV', 'Auto-apply across 30+ job boards
Filters and company exclusions
Recruiter emails
AI CV checker', 'Шукачам роботи, які хочуть автоматизувати рутинні відгуки.', 'Job seekers who want to automate routine applications.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'loopcv.pro' OR LOWER(`name`) = 'loopcv') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Automated job applications: upload your CV and it applies daily to matching jobs from 30+ job boards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LoopCV scans 30+ job boards daily, matches roles to your resume and submits applications on your behalf, and can also email recruiters. You can exclude companies, set filters and track statistics. There is an AI CV checker and builder and mock interviews. Configure mass auto-applying carefully to avoid applying to unsuitable roles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Auto-apply across 30+ job boards
Filters and company exclusions
Recruiter emails
AI CV checker', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers who want to automate routine applications.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний план з обмеженою кількістю автоподач.', 'Free plan with a limited number of auto-applications.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free plan with a limited number of auto-applications.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', NULL, 'month', 'Від 9.99 EUR на місяць.', 'From 9.99 EUR per month.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'From 9.99 EUR per month.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Himalayas — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'himalayas.app' OR LOWER(`name`) = 'himalayas')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Himalayas', NULL, 'https://himalayas.app', NULL, NULL, 'Сайт віддалених вакансій з безкоштовними AI-інструментами: підбір, адаптація резюме, листи й підготовка до співбесід.', 'A remote job board with free AI tools: matching, resume tailoring, cover letters and interview prep.', 'Himalayas — платформа віддаленої роботи, яка зіставляє ваш профіль із понад 100 000 актуальних віддалених вакансій. AI-агент підбирає ролі, підлаштовує резюме й супровідний лист, готує до співбесіди й відстежує заявки. Також можна вивчати віддалені компанії та зарплати. Базовий профіль безкоштовний.', 'Himalayas is a remote work platform that matches your profile against 100,000+ live remote jobs. Its AI agent finds roles, tailors your resume and cover letter, preps you for interviews and tracks applications. You can also research remote companies and salaries. The basic profile is free.', '100 000+ віддалених вакансій
AI-адаптація резюме й листів
Підготовка до співбесід
Дані про компанії й зарплати', '100,000+ remote jobs
AI resume and cover letter tailoring
Interview prep
Company and salary data', 'Тим, хто шукає віддалену роботу.', 'People looking for remote work.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'himalayas.app' OR LOWER(`name`) = 'himalayas') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A remote job board with free AI tools: matching, resume tailoring, cover letters and interview prep.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Himalayas is a remote work platform that matches your profile against 100,000+ live remote jobs. Its AI agent finds roles, tailors your resume and cover letter, preps you for interviews and tracks applications. You can also research remote companies and salaries. The basic profile is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '100,000+ remote jobs
AI resume and cover letter tailoring
Interview prep
Company and salary data', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People looking for remote work.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Профіль і основні AI-інструменти безкоштовні.', 'The profile and core AI tools are free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The profile and core AI tools are free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- We Work Remotely — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'weworkremotely.com' OR LOWER(`name`) = 'we work remotely')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'We Work Remotely', NULL, 'https://weworkremotely.com', NULL, NULL, 'Великий сайт вакансій лише для віддаленої роботи: програмування, дизайн, підтримка, продажі, маркетинг.', 'A large job board for remote-only roles: programming, design, support, sales and marketing.', 'We Work Remotely понад десять років публікує вакансії лише з віддаленою роботою. Вакансії згруповані за напрямами: програмування, дизайн, DevOps, менеджмент і фінанси, продукт, підтримка клієнтів, продажі й маркетинг, а також за типом зайнятості. Є добірки віддалених компаній і безкоштовна перевірка резюме для ATS.', 'We Work Remotely has published remote-only job listings for over a decade. Jobs are grouped by field: programming, design, DevOps, management and finance, product, customer support, sales and marketing, and by role type. There are lists of top remote companies and a free ATS resume review.', 'Лише віддалені вакансії
Пошук за напрямом і типом зайнятості
Добірки віддалених компаній
Безкоштовна перевірка резюме', 'Remote-only jobs
Search by field and role type
Top remote companies lists
Free resume review', 'Фахівцям, які шукають віддалену роботу в міжнародних компаніях.', 'Professionals looking for remote jobs at international companies.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'weworkremotely.com' OR LOWER(`name`) = 'we work remotely') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A large job board for remote-only roles: programming, design, support, sales and marketing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'We Work Remotely has published remote-only job listings for over a decade. Jobs are grouped by field: programming, design, DevOps, management and finance, product, customer support, sales and marketing, and by role type. There are lists of top remote companies and a free ATS resume review.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Remote-only jobs
Search by field and role type
Top remote companies lists
Free resume review', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Professionals looking for remote jobs at international companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Для шукачів роботи безкоштовно.', 'Free for job seekers.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for job seekers.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Remote OK — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'remoteok.com' OR LOWER(`name`) = 'remote ok')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Remote OK', NULL, 'https://remoteok.com', NULL, NULL, 'Платформа віддалених вакансій з відкритими зарплатами для розробників, дизайнерів, маркетологів та інших.', 'A remote job platform with open salaries for developers, designers, marketers and more.', 'Remote OK публікує віддалені вакансії для розробників, дизайнерів, копірайтерів, фахівців підтримки, продажів і проєктних менеджерів, з фільтрами за мінімальною зарплатою та пільгами. Сайт відомий принципом відкритих зарплат. Є конструктор резюме, статистика віддаленої роботи, а для розробників — API і JSON-стрічка вакансій.', 'Remote OK lists remote jobs for developers, designers, copywriters, support, sales and project managers, with filters for minimum salary and benefits. The site is known for its open-salaries approach. There is a resume builder, remote work stats and, for developers, a jobs API and JSON feed.', 'Віддалені вакансії з зарплатами
Фільтри за зарплатою й пільгами
Конструктор резюме
API і JSON-стрічка', 'Remote jobs with salaries
Salary and benefit filters
Resume builder
API and JSON feed', 'Тим, хто шукає віддалену роботу, зокрема digital-номадам.', 'Remote job seekers, including digital nomads.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'remoteok.com' OR LOWER(`name`) = 'remote ok') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A remote job platform with open salaries for developers, designers, marketers and more.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Remote OK lists remote jobs for developers, designers, copywriters, support, sales and project managers, with filters for minimum salary and benefits. The site is known for its open-salaries approach. There is a resume builder, remote work stats and, for developers, a jobs API and JSON feed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Remote jobs with salaries
Salary and benefit filters
Resume builder
API and JSON feed', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Remote job seekers, including digital nomads.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Для шукачів роботи безкоштовно.', 'Free for job seekers.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for job seekers.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Dice — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dice.com' OR LOWER(`name`) = 'dice')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dice', NULL, 'https://www.dice.com', NULL, NULL, 'Сайт вакансій для IT-фахівців: 200 000+ вакансій на місяць від 5 000+ компаній, оцінки зарплат.', 'A tech job board: 200,000+ jobs posted monthly by 5,000+ companies, with salary estimates.', 'Dice спеціалізується на вакансіях у технологіях, зокрема в AI та ML. На платформі наймають понад 5 000 компаній, щомісяця публікується понад 200 000 вакансій. Кандидати створюють безкоштовний профіль, фільтрують вакансії за навичками й досвідом, бачать оцінки зарплат і поради щодо кар''єрного шляху. Орієнтований на ринок США.', 'Dice specializes in tech jobs, including AI and ML. More than 5,000 companies hire on the platform, posting over 200,000 jobs a month. Candidates create a free profile, filter jobs by skills and experience, and see salary estimates and career path tips. It focuses on the US market.', 'Вакансії в IT, AI і ML
Фільтри за навичками
Оцінки зарплат
Безкоштовний профіль кандидата', 'Tech, AI and ML jobs
Skill-based filters
Salary estimates
Free candidate profile', 'IT-фахівцям, які шукають роботу в США.', 'Tech professionals job hunting in the US.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dice.com' OR LOWER(`name`) = 'dice') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A tech job board: 200,000+ jobs posted monthly by 5,000+ companies, with salary estimates.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Dice specializes in tech jobs, including AI and ML. More than 5,000 companies hire on the platform, posting over 200,000 jobs a month. Candidates create a free profile, filter jobs by skills and experience, and see salary estimates and career path tips. It focuses on the US market.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tech, AI and ML jobs
Skill-based filters
Salary estimates
Free candidate profile', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tech professionals job hunting in the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Для шукачів роботи безкоштовно.', 'Free for job seekers.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for job seekers.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Built In — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'builtin.com' OR LOWER(`name`) = 'built in')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Built In', NULL, 'https://builtin.com', NULL, NULL, 'Пошук роботи в техкомпаніях і стартапах з детальними профілями 100 000+ роботодавців і даними про зарплати.', 'Job search at tech companies and startups with rich profiles of 100,000+ employers and salary data.', 'Built In збирає понад 500 000 вакансій і профілі понад 100 000 компаній з інформацією про культуру, пільги та технології. Можна шукати роботу в техкомпаніях за містом чи віддалено, переглядати компанії з віддаленою роботою, зарплати в tech і стартапах, а також технічні новини.', 'Built In brings together 500,000+ jobs and profiles of 100,000+ companies with details on culture, benefits and tech stack. You can search tech jobs by city or remotely, browse remote-friendly companies, and check tech and startup salaries and tech news.', '500 000+ вакансій
Профілі 100 000+ компаній
Віддалені вакансії
Зарплати в tech', '500,000+ jobs
Profiles of 100,000+ companies
Remote jobs
Tech salaries', 'Фахівцям, які шукають роботу в техкомпаніях.', 'Professionals looking for jobs at tech companies.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'builtin.com' OR LOWER(`name`) = 'built in') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Job search at tech companies and startups with rich profiles of 100,000+ employers and salary data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Built In brings together 500,000+ jobs and profiles of 100,000+ companies with details on culture, benefits and tech stack. You can search tech jobs by city or remotely, browse remote-friendly companies, and check tech and startup salaries and tech news.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '500,000+ jobs
Profiles of 100,000+ companies
Remote jobs
Tech salaries', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Professionals looking for jobs at tech companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Для шукачів роботи безкоштовно.', 'Free for job seekers.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for job seekers.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ZipRecruiter — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ziprecruiter.com' OR LOWER(`name`) = 'ziprecruiter')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ZipRecruiter', NULL, 'https://www.ziprecruiter.com', NULL, NULL, 'Сайт пошуку роботи з технологією підбору, що надсилає відповідні вакансії на пошту, і статусом заявок.', 'A job search site whose matching technology emails relevant jobs and shows application status.', 'ZipRecruiter дозволяє шукати вакансії в будь-якій галузі й на будь-якому рівні, задавати радіус пошуку від вашого міста й підписуватися на сповіщення. Технологія підбору надсилає відповідні вакансії на пошту, а сервіс повідомляє, коли роботодавець переглянув вашу заявку. Працює в кількох країнах, зокрема США, Великій Британії та Ірландії.', 'ZipRecruiter lets you search jobs in any industry and at any level, set a search radius from your city and subscribe to alerts. Its matching technology emails relevant jobs, and it tells you when an employer views your application. It operates in several countries, including the US, UK and Ireland.', 'Пошук за радіусом від міста
Сповіщення про відповідні вакансії
Статус перегляду заявки
Будь-які галузі й рівні', 'Search by radius from your city
Job match alerts
Application view status
Any industry and level', 'Шукачам роботи в США, Великій Британії та Ірландії.', 'Job seekers in the US, UK and Ireland.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ziprecruiter.com' OR LOWER(`name`) = 'ziprecruiter') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A job search site whose matching technology emails relevant jobs and shows application status.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ZipRecruiter lets you search jobs in any industry and at any level, set a search radius from your city and subscribe to alerts. Its matching technology emails relevant jobs, and it tells you when an employer views your application. It operates in several countries, including the US, UK and Ireland.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Search by radius from your city
Job match alerts
Application view status
Any industry and level', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers in the US, UK and Ireland.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Для шукачів роботи безкоштовно.', 'Free for job seekers.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for job seekers.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Monster — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'monster.com' OR LOWER(`name`) = 'monster')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Monster', NULL, 'https://www.monster.com', NULL, NULL, 'Сайт пошуку роботи з мільйонами вакансій, інструментами швидкої подачі, зокрема AI Apply, і пошуком за резюме.', 'A job site with millions of listings, quick-apply tools including AI Apply, and resume-based matching.', 'Monster дає доступ до мільйонів вакансій і сучасних інструментів пошуку: допомагає зробити сильніше резюме, подавати заявки через ExpertApply, Quick Apply та AI Apply і створювати сповіщення про вакансії. Завантажене резюме підвищує видимість для роботодавців і покращує підбір. Перед масовою подачею варто перевіряти відповідність вакансії.', 'Monster provides access to millions of listings and modern job search tools: it helps you build a stronger resume, apply via ExpertApply, Quick Apply and AI Apply, and set up job alerts. Uploading your resume increases visibility to employers and improves matches. Check each role''s fit before applying in bulk.', 'Мільйони вакансій
AI Apply і Quick Apply
Сповіщення про вакансії
Видимість резюме для роботодавців', 'Millions of listings
AI Apply and Quick Apply
Job alerts
Resume visibility to employers', 'Шукачам роботи переважно в США.', 'Job seekers, mainly in the US.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'monster.com' OR LOWER(`name`) = 'monster') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A job site with millions of listings, quick-apply tools including AI Apply, and resume-based matching.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Monster provides access to millions of listings and modern job search tools: it helps you build a stronger resume, apply via ExpertApply, Quick Apply and AI Apply, and set up job alerts. Uploading your resume increases visibility to employers and improves matches. Check each role''s fit before applying in bulk.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Millions of listings
AI Apply and Quick Apply
Job alerts
Resume visibility to employers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers, mainly in the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Для шукачів роботи безкоштовно.', 'Free for job seekers.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for job seekers.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Jooble — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jooble.org' OR LOWER(`name`) = 'jooble')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Jooble', NULL, 'https://jooble.org', NULL, NULL, 'Агрегатор вакансій з тисяч сайтів у 66 країнах, створений в Україні.', 'A job aggregator collecting listings from thousands of websites in 66 countries, founded in Ukraine.', 'Jooble збирає вакансії з тисяч сайтів і дозволяє шукати роботу в 66 країнах в одному місці — за посадою, містом чи регіоном. Можна зберігати вакансії в обране й підписатися на розсилку нових пропозицій. Сервіс засновано в Україні, на сайті діє заклик підтримати Україну через United24.', 'Jooble aggregates job listings from thousands of websites and lets you search for work in 66 countries in one place, by title, city or region. You can save jobs to favorites and subscribe to new listing alerts. The service was founded in Ukraine and its site supports Ukraine via United24.', 'Вакансії з тисяч сайтів
66 країн
Обране й розсилка
Пошук за містом і регіоном', 'Listings from thousands of sites
66 countries
Favorites and alerts
Search by city and region', 'Шукачам роботи в Україні та за кордоном.', 'Job seekers in Ukraine and abroad.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jooble.org' OR LOWER(`name`) = 'jooble') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A job aggregator collecting listings from thousands of websites in 66 countries, founded in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Jooble aggregates job listings from thousands of websites and lets you search for work in 66 countries in one place, by title, city or region. You can save jobs to favorites and subscribe to new listing alerts. The service was founded in Ukraine and its site supports Ukraine via United24.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Listings from thousands of sites
66 countries
Favorites and alerts
Search by city and region', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers in Ukraine and abroad.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Для шукачів роботи безкоштовно.', 'Free for job seekers.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for job seekers.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Djinni — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'djinni.co' OR LOWER(`name`) = 'djinni')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Djinni', NULL, 'https://djinni.co', NULL, NULL, 'Анонімний пошук роботи в українському IT і ремоут: компанії самі пропонують вам вакансії.', 'Anonymous job search in Ukrainian tech and remote: companies come to you with offers.', 'Djinni — сервіс пасивного й анонімного пошуку роботи для IT-фахівців. Ви описуєте досвід, очікування й бажану зарплату, а компанії пропонують вакансії. Профіль анонімний: контакти відкриваєте лише тим, кому самі вирішите, тож поточний роботодавець вас не знайде. Щомісяця через Djinni проходить понад 50 тисяч пропозицій.', 'Djinni is a passive, anonymous job search service for tech professionals. You describe your experience, expectations and desired salary, and companies send you job offers. Profiles are anonymous: you only reveal your contacts to those you choose, so your current employer cannot find you. Over 50,000 offers go through Djinni each month.', 'Анонімний профіль
Компанії пропонують вакансії самі
Вказання бажаної зарплати
Українське IT і ремоут', 'Anonymous profile
Companies send you offers
Desired salary in your profile
Ukrainian tech and remote jobs', 'IT-фахівцям в Україні та тим, хто шукає ремоут.', 'Tech professionals in Ukraine and remote job seekers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'djinni.co' OR LOWER(`name`) = 'djinni') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Anonymous job search in Ukrainian tech and remote: companies come to you with offers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Djinni is a passive, anonymous job search service for tech professionals. You describe your experience, expectations and desired salary, and companies send you job offers. Profiles are anonymous: you only reveal your contacts to those you choose, so your current employer cannot find you. Over 50,000 offers go through Djinni each month.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Anonymous profile
Companies send you offers
Desired salary in your profile
Ukrainian tech and remote jobs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tech professionals in Ukraine and remote job seekers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Для шукачів роботи безкоштовно.', 'Free for job seekers.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for job seekers.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Work.ua — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'work.ua' OR LOWER(`name`) = 'work.ua')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Work.ua', NULL, 'https://www.work.ua', NULL, NULL, 'Найбільший в Україні сервіс пошуку роботи: понад 94 000 вакансій, конструктор резюме й розсилка вакансій.', 'Ukraine''s largest job search service: 94,000+ jobs, a resume builder and job alerts.', 'Work.ua — український сервіс пошуку роботи й працівників. Можна шукати вакансії за посадою, компанією, категорією чи містом, створити резюме за 3–5 хвилин або завантажити файл, щоб роботодавці самі пропонували роботу. Є фільтри вакансій із бронюванням працівників і вакансій з перевагою для ветеранів, мобільний застосунок і статті з порадами щодо працевлаштування.', 'Work.ua is a Ukrainian service for finding jobs and employees. You can search by title, company, category or city, create a resume in 3–5 minutes or upload a file so employers can offer you work. There are filters for jobs with employee reservation (deferment) and veteran-friendly jobs, a mobile app and career advice articles.', '94 000+ вакансій в Україні
Резюме за 3–5 хвилин
Вакансії з бронюванням і для ветеранів
Мобільний застосунок', '94,000+ jobs in Ukraine
Resume in 3–5 minutes
Jobs with deferment and for veterans
Mobile app', 'Шукачам роботи в Україні.', 'Job seekers in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'work.ua' OR LOWER(`name`) = 'work.ua') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ukraine''s largest job search service: 94,000+ jobs, a resume builder and job alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Work.ua is a Ukrainian service for finding jobs and employees. You can search by title, company, category or city, create a resume in 3–5 minutes or upload a file so employers can offer you work. There are filters for jobs with employee reservation (deferment) and veteran-friendly jobs, a mobile app and career advice articles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '94,000+ jobs in Ukraine
Resume in 3–5 minutes
Jobs with deferment and for veterans
Mobile app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Для шукачів роботи безкоштовно.', 'Free for job seekers.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for job seekers.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- robota.ua — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'robota.ua' OR LOWER(`name`) = 'robota.ua')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'robota.ua', NULL, 'https://robota.ua', NULL, NULL, 'Український сайт пошуку роботи: понад 100 000 вакансій від 27 000+ компаній і понад 6 мільйонів резюме.', 'A Ukrainian job site: 100,000+ jobs from 27,000+ companies and over 6 million resumes.', 'robota.ua допомагає знайти роботу в Україні та інших країнах: понад 100 000 актуальних вакансій від майже 28 тисяч компаній. Можна шукати за посадою, компанією й містом, створити резюме, щоб роботодавці могли вас знайти, і отримувати добірки вакансій. Кандидати довірили сервісу понад 6,6 мільйона резюме.', 'robota.ua helps you find work in Ukraine and abroad: over 100,000 live jobs from almost 28,000 companies. You can search by title, company and city, create a resume so employers can find you, and receive job alerts. Candidates have posted over 6.6 million resumes on the service.', '100 000+ вакансій
Пошук за посадою, компанією й містом
Резюме для роботодавців
Добірки вакансій', '100,000+ jobs
Search by title, company and city
Resume visible to employers
Job alerts', 'Шукачам роботи в Україні.', 'Job seekers in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'robota.ua' OR LOWER(`name`) = 'robota.ua') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Ukrainian job site: 100,000+ jobs from 27,000+ companies and over 6 million resumes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'robota.ua helps you find work in Ukraine and abroad: over 100,000 live jobs from almost 28,000 companies. You can search by title, company and city, create a resume so employers can find you, and receive job alerts. Candidates have posted over 6.6 million resumes on the service.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '100,000+ jobs
Search by title, company and city
Resume visible to employers
Job alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Для шукачів роботи безкоштовно.', 'Free for job seekers.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free for job seekers.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Huntr — Пошук вакансій
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'huntr.co' OR LOWER(`name`) = 'huntr')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Huntr', NULL, 'https://huntr.co', NULL, NULL, 'Трекер пошуку роботи з AI-резюме під вакансію, супровідними листами й автозаповненням заявок.', 'A job search tracker with AI job-tailored resumes, cover letters and application autofill.', 'Huntr допомагає організувати пошук роботи: трекер вакансій, контактів і співбесід, метрики пошуку. AI створює резюме під конкретну вакансію, супровідні листи, підсумки й пункти досвіду, а розширення для Chrome зберігає вакансії й заповнює заявки в один клік. Безкоштовний план включає необмежену кількість базових резюме; Pro додає необмежені AI-генерації.', 'Huntr helps you organize your job search with trackers for jobs, contacts and interviews plus search metrics. AI creates job-tailored resumes, cover letters, summaries and bullet points, and the Chrome extension saves jobs and autofills applications in one click. The free plan includes unlimited base resumes; Pro adds unlimited AI generations.', 'Трекер вакансій, контактів і співбесід
AI-резюме під вакансію
AI-супровідні листи
Автозаповнення заявок', 'Job, contact and interview tracker
AI job-tailored resumes
AI cover letters
Application autofill', 'Шукачам роботи, кар''єрним коучам і буткемпам.', 'Job seekers, career coaches and bootcamps.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'huntr.co' OR LOWER(`name`) = 'huntr') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A job search tracker with AI job-tailored resumes, cover letters and application autofill.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Huntr helps you organize your job search with trackers for jobs, contacts and interviews plus search metrics. AI creates job-tailored resumes, cover letters, summaries and bullet points, and the Chrome extension saves jobs and autofills applications in one click. The free plan includes unlimited base resumes; Pro adds unlimited AI generations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Job, contact and interview tracker
AI job-tailored resumes
AI cover letters
Application autofill', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers, career coaches and bootcamps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Необмежені базові резюме, базовий підбір і трекер.', 'Unlimited base resumes, basic matching and tracking.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Unlimited base resumes, basic matching and tracking.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 40.00, 'month', '$40 на місяць; $90 за 3 місяці або $160 за 6 місяців.', '$40 per month; $90 every 3 months or $160 every 6 months.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$40 per month; $90 every 3 months or $160 every 6 months.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Jobbyo — додатково в «Пошук вакансій»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Jobbyo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;


-- =================== Фриланс / Freelancing ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'freelance' LIMIT 1);

-- Upwork — Фриланс
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'upwork.com' OR LOWER(`name`) = 'upwork')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Upwork', NULL, 'https://www.upwork.com', NULL, NULL, 'Велика фриланс-платформа, де компанії наймають фахівців з AI, розробки, дизайну, маркетингу та інших сфер.', 'A large freelance marketplace where businesses hire experts in AI, development, design, marketing and more.', 'Upwork з''єднує замовників і фрилансерів у десятках напрямів: AI-послуги, розробка й IT, дизайн, продажі й маркетинг, тексти й переклад, адміністративна підтримка, фінанси, право, HR та інженерія. Платформі довіряють понад 800 тисяч клієнтів. Фрилансери створюють профіль і подаються на проєкти, а замовники можуть шукати виконавців за категорією, оцінками й ставкою.', 'Upwork connects clients and freelancers across dozens of fields: AI services, development and IT, design, sales and marketing, writing and translation, admin support, finance, legal, HR and engineering. More than 800,000 clients use the platform. Freelancers build a profile and bid on projects, while clients can browse talent by category, rating and rate.', 'Десятки категорій робіт
Окрема категорія AI-послуг
Профілі з оцінками й ставками
Пошук виконавців за категорією', 'Dozens of work categories
Dedicated AI services category
Profiles with ratings and rates
Browse talent by category', 'Фрилансерам і компаніям, які шукають виконавців.', 'Freelancers and businesses hiring talent.', 'web,mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'upwork.com' OR LOWER(`name`) = 'upwork') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A large freelance marketplace where businesses hire experts in AI, development, design, marketing and more.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Upwork connects clients and freelancers across dozens of fields: AI services, development and IT, design, sales and marketing, writing and translation, admin support, finance, legal, HR and engineering. More than 800,000 clients use the platform. Freelancers build a profile and bid on projects, while clients can browse talent by category, rating and rate.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Dozens of work categories
Dedicated AI services category
Profiles with ratings and rates
Browse talent by category', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Freelancers and businesses hiring talent.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Реєстрація безкоштовна; платформа бере комісію, умови на сайті.', 'Signing up is free; the platform charges fees, see the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Signing up is free; the platform charges fees, see the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Fiverr — Фриланс
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fiverr.com' OR LOWER(`name`) = 'fiverr')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fiverr', NULL, 'https://www.fiverr.com', NULL, NULL, 'Маркетплейс фриланс-послуг у 700 категоріях, зокрема AI-розробка, AI-автоматизація й vibe coding.', 'A marketplace of freelance services in 700 categories, including AI development, AI automation and vibe coding.', 'Fiverr працює як каталог готових послуг: фрилансери публікують пропозиції з ціною й термінами, а замовник обирає й купує потрібне. Категорії охоплюють графіку й дизайн, програмування, цифровий маркетинг, відео й анімацію, тексти й переклад, музику, бізнес і окремо AI-послуги. Для бізнесу є Fiverr Pro з перевіреними фахівцями.', 'Fiverr works as a catalog of ready-made services: freelancers publish offers with prices and timelines, and clients choose and buy what they need. Categories cover graphics and design, programming, digital marketing, video and animation, writing and translation, music, business and dedicated AI services. Fiverr Pro offers vetted talent for businesses.', '700 категорій послуг
AI-послуги й автоматизація
Фіксовані пакети з ціною
Fiverr Pro для бізнесу', '700 service categories
AI services and automation
Fixed-price packages
Fiverr Pro for businesses', 'Фрилансерам, які продають послуги, і замовникам.', 'Freelancers selling services and their clients.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fiverr.com' OR LOWER(`name`) = 'fiverr') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A marketplace of freelance services in 700 categories, including AI development, AI automation and vibe coding.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Fiverr works as a catalog of ready-made services: freelancers publish offers with prices and timelines, and clients choose and buy what they need. Categories cover graphics and design, programming, digital marketing, video and animation, writing and translation, music, business and dedicated AI services. Fiverr Pro offers vetted talent for businesses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '700 service categories
AI services and automation
Fixed-price packages
Fiverr Pro for businesses', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Freelancers selling services and their clients.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Реєстрація безкоштовна; комісії — на сайті.', 'Signing up is free; fees on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Signing up is free; fees on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Toptal — Фриланс
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'toptal.com' OR LOWER(`name`) = 'toptal')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Toptal', NULL, 'https://www.toptal.com', NULL, NULL, 'Мережа ретельно відібраних фрилансерів: розробники, AI-інженери, дизайнери, фінансисти й менеджери.', 'A network of rigorously screened freelancers: developers, AI engineers, designers, finance experts and managers.', 'Toptal допомагає компаніям наймати фрилансерів і команди з невеликої частки найсильніших кандидатів, які пройшли багатоетапний відбір. Серед напрямів — розробники під десятки технологій, AI-інженери, UX/UI- і графічні дизайнери, фінансові експерти й проєктні менеджери. З 2010 року платформою скористалися понад 35 000 клієнтів. Фахівці подаються через відбір.', 'Toptal helps companies hire freelancers and teams from a small share of top candidates who passed a multi-stage screening. Fields include developers across dozens of technologies, AI engineers, UX/UI and graphic designers, finance experts and project managers. Since 2010, more than 35,000 clients have used the platform. Experts join through the screening process.', 'Багатоетапний відбір фахівців
Розробники й AI-інженери
Дизайнери й фінансисти
Окремі фахівці або команди', 'Multi-stage screening
Developers and AI engineers
Designers and finance experts
Individuals or teams', 'Досвідченим фрилансерам і компаніям, яким потрібні перевірені виконавці.', 'Senior freelancers and companies that need vetted talent.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'toptal.com' OR LOWER(`name`) = 'toptal') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A network of rigorously screened freelancers: developers, AI engineers, designers, finance experts and managers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Toptal helps companies hire freelancers and teams from a small share of top candidates who passed a multi-stage screening. Fields include developers across dozens of technologies, AI engineers, UX/UI and graphic designers, finance experts and project managers. Since 2010, more than 35,000 clients have used the platform. Experts join through the screening process.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Multi-stage screening
Developers and AI engineers
Designers and finance experts
Individuals or teams', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Senior freelancers and companies that need vetted talent.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'За запитом', 'On request', NULL, 'month', 'Вартість найму залежить від фахівця; для фрилансерів реєстрація через відбір.', 'Hiring cost depends on the expert; freelancers join through screening.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'За запитом' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'On request', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Hiring cost depends on the expert; freelancers join through screening.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Contra — Фриланс
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'contra.com' OR LOWER(`name`) = 'contra')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Contra', NULL, 'https://contra.com', NULL, NULL, 'Професійна мережа для креативних фрилансерів без комісії з виконавців, з челенджами й проєктами для AI.', 'A professional network for creative freelancers with commission-free payments, challenges and AI projects.', 'Contra — мережа для незалежних креативних фахівців: дизайнерів, відеомейкерів, розробників. Фрилансери показують портфоліо, отримують замовлення й оплату без комісії, а компанії публікують проєкти й шукають виконавців. Платформа також проводить челенджі з призами та через Contra Labs залучає креативних експертів до навчання й оцінювання AI-моделей.', 'Contra is a network for independent creative professionals: designers, video creators and developers. Freelancers showcase their portfolio, get hired and paid commission-free, while companies post projects and find talent. The platform also runs prize challenges and, through Contra Labs, brings creative experts into training and evaluating AI models.', 'Оплата без комісії для фрилансерів
Портфоліо й профіль
Челенджі з призами
Contra Labs для AI-проєктів', 'Commission-free payments for freelancers
Portfolio and profile
Prize challenges
Contra Labs AI projects', 'Креативним фрилансерам і компаніям, що їх наймають.', 'Creative freelancers and the companies that hire them.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'contra.com' OR LOWER(`name`) = 'contra') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A professional network for creative freelancers with commission-free payments, challenges and AI projects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Contra is a network for independent creative professionals: designers, video creators and developers. Freelancers showcase their portfolio, get hired and paid commission-free, while companies post projects and find talent. The platform also runs prize challenges and, through Contra Labs, brings creative experts into training and evaluating AI models.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Commission-free payments for freelancers
Portfolio and profile
Prize challenges
Contra Labs AI projects', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Creative freelancers and the companies that hire them.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Для фрилансерів без комісії; платні функції — на сайті.', 'Commission-free for freelancers; paid features on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Commission-free for freelancers; paid features on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Freelancehunt — Фриланс
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'freelancehunt.com' OR LOWER(`name`) = 'freelancehunt')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Freelancehunt', NULL, 'https://freelancehunt.com', NULL, NULL, 'Українська біржа фрилансу для проєктів в IT, маркетингу, дизайні та інших сферах.', 'A Ukrainian freelance marketplace for projects in IT, marketing, design and more.', 'Freelancehunt — біржа фрилансу, де замовники знаходять виконавців для разових і постійних завдань, а фрилансери — проєкти у своїй ніші. Співпраця відбувається повністю дистанційно: постановка задачі, виконання й оплата через сервіс. Платформа має одну з найбільших у Європі спільнот технічних фахівців і популярна серед українських фрилансерів.', 'Freelancehunt is a freelance marketplace where clients find contractors for one-off and ongoing tasks, and freelancers find projects in their niche. Collaboration is fully remote: briefing, delivery and payment happen through the service. The platform has one of Europe''s largest communities of technical specialists and is popular among Ukrainian freelancers.', 'Проєкти в IT, маркетингу й дизайні
Разові й постійні завдання
Оплата через сервіс
Велика україномовна спільнота', 'Projects in IT, marketing and design
One-off and ongoing tasks
Payments through the service
Large Ukrainian community', 'Українським фрилансерам і замовникам.', 'Ukrainian freelancers and clients.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'freelancehunt.com' OR LOWER(`name`) = 'freelancehunt') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Ukrainian freelance marketplace for projects in IT, marketing, design and more.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Freelancehunt is a freelance marketplace where clients find contractors for one-off and ongoing tasks, and freelancers find projects in their niche. Collaboration is fully remote: briefing, delivery and payment happen through the service. The platform has one of Europe''s largest communities of technical specialists and is popular among Ukrainian freelancers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Projects in IT, marketing and design
One-off and ongoing tasks
Payments through the service
Large Ukrainian community', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Ukrainian freelancers and clients.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Базова реєстрація безкоштовна; платні плани й комісії — на сайті.', 'Basic sign-up is free; paid plans and fees on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic sign-up is free; paid plans and fees on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Freelancer.com — Фриланс
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'freelancer.com' OR LOWER(`name`) = 'freelancer.com')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Freelancer.com', NULL, 'https://www.freelancer.com', NULL, NULL, 'Міжнародна фриланс-платформа: пошук виконавців за навичкою, країною й часовим поясом, ставки на проєкти.', 'An international freelance platform: find contractors by skill, location and time zone, and bid on projects.', 'Freelancer.com дозволяє замовникам знаходити фрилансерів за навичкою, категорією або країною й часовим поясом: розробників, дизайнерів, маркетологів, SEO-фахівців, перекладачів, юристів, фахівців з логістики та інших. Фрилансери подають ставки на опубліковані проєкти.', 'Freelancer.com lets clients find freelancers by skill, category or location and time zone: developers, designers, marketers, SEO specialists, translators, lawyers, logistics experts and more. Freelancers bid on posted projects.', 'Пошук за навичкою й часовим поясом
Ставки на проєкти
Пошук за країною
Сотні категорій', 'Search by skill and time zone
Project bidding
Search by location
Hundreds of categories', 'Фрилансерам і замовникам по всьому світу.', 'Freelancers and clients worldwide.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'freelancer.com' OR LOWER(`name`) = 'freelancer.com') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An international freelance platform: find contractors by skill, location and time zone, and bid on projects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Freelancer.com lets clients find freelancers by skill, category or location and time zone: developers, designers, marketers, SEO specialists, translators, lawyers, logistics experts and more. Freelancers bid on posted projects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Search by skill and time zone
Project bidding
Search by location
Hundreds of categories', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Freelancers and clients worldwide.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Реєстрація безкоштовна; комісії й членство — на сайті.', 'Signing up is free; fees and memberships on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Signing up is free; fees and memberships on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;


-- =================== Кар'єрний розвиток / Career Growth ===================
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'career-growth' LIMIT 1);

-- Levels.fyi — Кар'єрний розвиток
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'levels.fyi' OR LOWER(`name`) = 'levels.fyi')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Levels.fyi', NULL, 'https://www.levels.fyi', NULL, NULL, 'Дані про зарплати й рівні в техкомпаніях: понад мільйон записів, порівняння пропозицій і допомога в переговорах.', 'Salary and level data for tech companies: 1M+ data points, offer comparisons and negotiation help.', 'Levels.fyi збирає дані про компенсації за компаніями, посадами, рівнями й містами, щоб ви могли оцінити пропозицію й домовитися про кращу. Є теплова карта зарплат, перцентилі в реальному часі, порівняння пільг і зіставлення рівнів між компаніями. Окремо доступні платні послуги: коучинг із переговорів і перегляд резюме.', 'Levels.fyi collects compensation data by company, title, level and location so you can evaluate an offer and negotiate a better one. There is a salary heatmap, real-time percentiles, benefit comparisons and level mapping across companies. Paid services include negotiation coaching and resume review.', '1 млн+ записів про зарплати
Зіставлення рівнів між компаніями
Порівняння пільг
Коучинг із переговорів', '1M+ salary data points
Level mapping across companies
Benefit comparisons
Negotiation coaching', 'Фахівцям у tech, які оцінюють пропозицію чи планують перехід.', 'Tech professionals evaluating an offer or planning a move.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'levels.fyi' OR LOWER(`name`) = 'levels.fyi') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Salary and level data for tech companies: 1M+ data points, offer comparisons and negotiation help.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Levels.fyi collects compensation data by company, title, level and location so you can evaluate an offer and negotiate a better one. There is a salary heatmap, real-time percentiles, benefit comparisons and level mapping across companies. Paid services include negotiation coaching and resume review.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '1M+ salary data points
Level mapping across companies
Benefit comparisons
Negotiation coaching', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tech professionals evaluating an offer or planning a move.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Дані про зарплати безкоштовні.', 'Salary data is free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Salary data is free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Послуги', 'Services', NULL, 'one_time', 'Коучинг із переговорів і перегляд резюме — платні, ціни на сайті.', 'Negotiation coaching and resume review are paid; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Послуги' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Services', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Negotiation coaching and resume review are paid; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Careerflow — Кар'єрний розвиток
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'careerflow.ai' OR LOWER(`name`) = 'careerflow')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Careerflow', NULL, 'https://www.careerflow.ai', NULL, NULL, 'AI-копілот кар''єри: оптимізація LinkedIn і резюме, супровідні листи, трекер вакансій і нетворкінгу.', 'An AI career copilot: LinkedIn and resume optimization, cover letters, job and networking trackers.', 'Careerflow поєднує AI-інструменти для пошуку роботи й розвитку кар''єри: оптимізатор профілю LinkedIn, конструктор і оптимізатор резюме під ATS, генератор супровідних листів, AI-пробні співбесіди, трекер вакансій і контактів, автозаповнення заявок. Окремо доступні послуги експертів, як-от перегляд резюме.', 'Careerflow brings together AI tools for job searching and career growth: a LinkedIn profile optimizer, an ATS resume builder and optimizer, a cover letter generator, AI mock interviews, job and networking trackers and application autofill. Expert services such as resume reviews are also available.', 'Оптимізатор профілю LinkedIn
AI-резюме й супровідні листи
Трекер вакансій і контактів
AI-пробні співбесіди', 'LinkedIn profile optimizer
AI resumes and cover letters
Job and networking tracker
AI mock interviews', 'Шукачам роботи й фахівцям, які розвивають особистий бренд.', 'Job seekers and professionals building their personal brand.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'careerflow.ai' OR LOWER(`name`) = 'careerflow') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI career copilot: LinkedIn and resume optimization, cover letters, job and networking trackers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Careerflow brings together AI tools for job searching and career growth: a LinkedIn profile optimizer, an ATS resume builder and optimizer, a cover letter generator, AI mock interviews, job and networking trackers and application autofill. Expert services such as resume reviews are also available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'LinkedIn profile optimizer
AI resumes and cover letters
Job and networking tracker
AI mock interviews', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers and professionals building their personal brand.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Базові інструменти безкоштовні.', 'Core tools are free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Core tools are free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium', 'Premium', NULL, 'month', 'Ціни на сайті.', 'Prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Supergrow — Кар'єрний розвиток
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'supergrow.ai' OR LOWER(`name`) = 'supergrow')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Supergrow', NULL, 'https://www.supergrow.ai', NULL, NULL, 'Платформа контенту для LinkedIn: AI-інтерв''ю, що вловлює ваш голос, планування постів і аналітика.', 'A LinkedIn content platform: AI interviews that capture your voice, post scheduling and analytics.', 'Supergrow допомагає будувати присутність у LinkedIn окремим авторам і командам. AI-інтерв''ю й «Content DNA» вловлюють ваш стиль і перетворюють експертизу на пости, є календар і черга публікацій, режим Focus для коментування без стрічки та аналітика. Сервіс працює через офіційний API LinkedIn без ботів і скрапінгу.', 'Supergrow helps individuals and teams build their LinkedIn presence. AI interviews and Content DNA capture your voice and turn expertise into posts; there is a calendar and post queue, a Focus Mode for engaging without the feed, and analytics. It works through LinkedIn''s official API, without bots or scraping.', 'AI-інтерв''ю для ідей постів
Календар і черга публікацій
Коментування без стрічки
Аналітика охоплення', 'AI interviews for post ideas
Calendar and post queue
Engage without the feed
Reach analytics', 'Експертам, керівникам і командам, які розвивають бренд у LinkedIn.', 'Experts, executives and teams growing their LinkedIn brand.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'supergrow.ai' OR LOWER(`name`) = 'supergrow') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A LinkedIn content platform: AI interviews that capture your voice, post scheduling and analytics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Supergrow helps individuals and teams build their LinkedIn presence. AI interviews and Content DNA capture your voice and turn expertise into posts; there is a calendar and post queue, a Focus Mode for engaging without the feed, and analytics. It works through LinkedIn''s official API, without bots or scraping.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI interviews for post ideas
Calendar and post queue
Engage without the feed
Reach analytics', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Experts, executives and teams growing their LinkedIn brand.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 39.00, 'month', '$39 на місяць ($31 при оплаті за рік); 7 днів безкоштовно.', '$39 per month ($31 billed annually); 7-day free trial.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$39 per month ($31 billed annually); 7-day free trial.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Teams', 'Teams', 199.00, 'month', '$199 на місяць за 5 акаунтів.', '$199 per month for 5 accounts.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Teams' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Teams', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$199 per month for 5 accounts.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AuthoredUp — Кар'єрний розвиток
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'authoredup.com' OR LOWER(`name`) = 'authoredup')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AuthoredUp', NULL, 'https://authoredup.com', NULL, NULL, 'Інструмент для створення постів у LinkedIn: редактор з форматуванням, чернетки, календар і аналітика.', 'A LinkedIn content tool: a formatting editor, drafts, a calendar and analytics.', 'AuthoredUp — робочий простір для авторів LinkedIn: редактор із форматуванням і попереднім переглядом, організовані чернетки, календар публікацій, історія всіх постів, аналітика й збережені пости для натхнення. Є безкоштовні інструменти й плани для окремих авторів і команд.', 'AuthoredUp is a workspace for LinkedIn creators: an editor with formatting and preview, organized drafts, a publishing calendar, a full post history, analytics and saved posts for inspiration. There are free tools and plans for individuals and teams.', 'Редактор з форматуванням і прев''ю
Чернетки й календар
Аналітика постів
Збережені пости для натхнення', 'Formatting editor with preview
Drafts and calendar
Post analytics
Saved posts for inspiration', 'Авторам і командам, які регулярно публікуються в LinkedIn.', 'Creators and teams posting regularly on LinkedIn.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'authoredup.com' OR LOWER(`name`) = 'authoredup') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A LinkedIn content tool: a formatting editor, drafts, a calendar and analytics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'AuthoredUp is a workspace for LinkedIn creators: an editor with formatting and preview, organized drafts, a publishing calendar, a full post history, analytics and saved posts for inspiration. There are free tools and plans for individuals and teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Formatting editor with preview
Drafts and calendar
Post analytics
Saved posts for inspiration', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Creators and teams posting regularly on LinkedIn.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Individual', 'Individual', 19.95, 'month', '$19.95 на місяць за 1 профіль.', '$19.95 per month for 1 profile.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Individual' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Individual', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$19.95 per month for 1 profile.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Business', 'Business', 14.95, 'month', '$14.95 за профіль на місяць, від 3 профілів.', '$14.95 per profile per month, 3+ profiles.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Business' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Business', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '$14.95 per profile per month, 3+ profiles.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kleo — Кар'єрний розвиток
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kleo.so' OR LOWER(`name`) = 'kleo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kleo', NULL, 'https://kleo.so', NULL, NULL, 'AI-інструмент особистого бренду в LinkedIn: ідеї, написання й дизайн постів у вашому стилі.', 'An AI personal brand tool for LinkedIn: ideas, writing and post design in your own voice.', 'Kleo допомагає зрозуміти, про що писати в LinkedIn, і швидше створювати пости, що звучать як ви. В одному місці зібрано генерацію ідей, написання, дизайн і публікацію. Інструментом користуються консультанти, коучі, засновники й автори, які розвивають особистий бренд без окремої контент-команди.', 'Kleo helps you figure out what to post on LinkedIn and create posts faster that sound like you. Ideation, writing, design and publishing are in one place. It is used by consultants, coaches, founders and creators growing a personal brand without a content team.', 'Ідеї для постів
Написання у вашому стилі
Дизайн візуалів
Публікація з одного місця', 'Post ideas
Writing in your voice
Visual design
Publishing from one place', 'Консультантам, коучам, засновникам і авторам у LinkedIn.', 'Consultants, coaches, founders and creators on LinkedIn.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kleo.so' OR LOWER(`name`) = 'kleo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI personal brand tool for LinkedIn: ideas, writing and post design in your own voice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Kleo helps you figure out what to post on LinkedIn and create posts faster that sound like you. Ideation, writing, design and publishing are in one place. It is used by consultants, coaches, founders and creators growing a personal brand without a content team.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Post ideas
Writing in your voice
Visual design
Publishing from one place', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Consultants, coaches, founders and creators on LinkedIn.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Платні плани', 'Paid plans', NULL, 'month', 'Ціни на сайті.', 'Prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Платні плани' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Paid plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MentorCruise — Кар'єрний розвиток
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mentorcruise.com' OR LOWER(`name`) = 'mentorcruise')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MentorCruise', NULL, 'https://mentorcruise.com', NULL, NULL, 'Платформа менторства з експертами в розробці, продукті, AI, дизайні й бізнесі.', 'A mentorship platform with experts in engineering, product, AI, design and business.', 'MentorCruise з''єднує людей, які хочуть розвиватися, з практиками галузі для тривалого менторства. Можна обрати ментора з розробки, дизайну, продакт-менеджменту, AI, маркетингу, лідерства чи стартапів і домовитися про регулярні дзвінки й підтримку в чаті. Для компаній є менторство для команд і стратегічні воркшопи.', 'MentorCruise connects people who want to grow with industry practitioners for long-term mentorship. You can pick a mentor in engineering, design, product management, AI, marketing, leadership or startups and arrange regular calls and chat support. Companies can get mentorship for teams and strategy workshops.', 'Ментори з розробки, продукту, AI
Регулярні дзвінки й чат
Менторство для команд
Пошук за напрямом', 'Mentors in engineering, product, AI
Regular calls and chat
Mentorship for teams
Browse by field', 'Фахівцям, які хочуть пришвидшити кар''єрний розвиток.', 'Professionals who want to accelerate their career.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mentorcruise.com' OR LOWER(`name`) = 'mentorcruise') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A mentorship platform with experts in engineering, product, AI, design and business.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MentorCruise connects people who want to grow with industry practitioners for long-term mentorship. You can pick a mentor in engineering, design, product management, AI, marketing, leadership or startups and arrange regular calls and chat support. Companies can get mentorship for teams and strategy workshops.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Mentors in engineering, product, AI
Regular calls and chat
Mentorship for teams
Browse by field', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Professionals who want to accelerate their career.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Менторство', 'Mentorship', NULL, 'month', 'Ціну встановлює ментор; див. сайт.', 'Each mentor sets their own price; see the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Менторство' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Mentorship', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Each mentor sets their own price; see the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- CareerExplorer — Кар'єрний розвиток
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'careerexplorer.com' OR LOWER(`name`) = 'careerexplorer')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CareerExplorer', NULL, 'https://www.careerexplorer.com', NULL, NULL, 'Безкоштовний тест профорієнтації з підбором професій за інтересами, сильними сторонами й особистістю.', 'A free career test that matches careers to your interests, strengths and personality.', 'CareerExplorer пропонує оцінювання, яке враховує ваш досвід, цілі, інтереси та особистість, і на його основі підбирає відповідні професії та архетип особистості. У бібліотеці описано понад 1000 професій і напрямів навчання: хто в них досягає успіху й чому. Сервіс безкоштовний.', 'CareerExplorer offers an assessment that considers your experience, goals, interests and personality, then matches you with suitable careers and a personality archetype. Its library describes 1,000+ careers and degrees, including who thrives in them and why. The service is free.', 'Безкоштовний тест профорієнтації
Підбір професій
Архетип особистості
Бібліотека 1000+ професій', 'Free career test
Career matches
Personality archetype
Library of 1,000+ careers', 'Студентам, абітурієнтам і тим, хто думає змінити професію.', 'Students and anyone considering a career change.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'careerexplorer.com' OR LOWER(`name`) = 'careerexplorer') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free career test that matches careers to your interests, strengths and personality.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'CareerExplorer offers an assessment that considers your experience, goals, interests and personality, then matches you with suitable careers and a personality archetype. Its library describes 1,000+ careers and degrees, including who thrives in them and why. The service is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free career test
Career matches
Personality archetype
Library of 1,000+ careers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students and anyone considering a career change.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Тест і підбір професій безкоштовні.', 'The test and career matches are free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The test and career matches are free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- 80,000 Hours — Кар'єрний розвиток
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '80000hours.org' OR LOWER(`name`) = '80,000 hours')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT '80,000 Hours', NULL, 'https://80000hours.org', NULL, NULL, 'Некомерційний гід з кар''єри з користю для світу: посібник, огляди професій у сфері AI, подкаст і вакансії.', 'A nonprofit guide to high-impact careers: a career guide, AI-related career reviews, a podcast and a job board.', '80,000 Hours допомагає обрати кар''єру, яка розв''язує найнагальніші проблеми світу. Безкоштовний посібник пояснює, як планувати кар''єру, а огляди професій розбирають шляхи в політиці й безпеці AI, технічних дослідженнях, біобезпеці, глобальному здоров''ї та інших напрямах. Є подкаст і дошка вакансій.', '80,000 Hours helps you choose a career that tackles the world''s most pressing problems. Its free guide explains how to plan your career, and career reviews cover paths in AI policy and safety, technical research, biosecurity, global health and more. There is a podcast and a job board.', 'Безкоштовний посібник з кар''єри
Огляди професій у сфері AI
Дошка вакансій
Подкаст', 'Free career guide
AI career path reviews
Job board
Podcast', 'Тим, хто хоче, щоб робота мала суспільну користь, зокрема в AI.', 'People who want their work to have social impact, including in AI.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '80000hours.org' OR LOWER(`name`) = '80,000 hours') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A nonprofit guide to high-impact careers: a career guide, AI-related career reviews, a podcast and a job board.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', '80,000 Hours helps you choose a career that tackles the world''s most pressing problems. Its free guide explains how to plan your career, and career reviews cover paths in AI policy and safety, technical research, biosecurity, global health and more. There is a podcast and a job board.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free career guide
AI career path reviews
Job board
Podcast', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want their work to have social impact, including in AI.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Усі матеріали безкоштовні.', 'All resources are free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'All resources are free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Wonsulting — Кар'єрний розвиток
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wonsulting.com' OR LOWER(`name`) = 'wonsulting')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Wonsulting', NULL, 'https://www.wonsulting.com', NULL, NULL, 'AI-інструменти для пошуку роботи (резюме, нетворкінг, співбесіди, трекер) і кар''єрний коучинг.', 'AI job search tools (resumes, networking, interviews, tracker) and career coaching.', 'Wonsulting поєднує набір AI-інструментів WonsultingAI — ResumAI, NetworkAI, JobBoardAI, InterviewAI, JobTrackerAI та генератор супровідних листів — із платними послугами: переглядом резюме й профілю LinkedIn, кар''єрними консультаціями, стратегіями пошуку роботи й підготовкою до співбесід. Умови гарантійних програм варто уважно прочитати на сайті.', 'Wonsulting combines the WonsultingAI tool suite — ResumAI, NetworkAI, JobBoardAI, InterviewAI, JobTrackerAI and a cover letter generator — with paid services: resume and LinkedIn profile revisions, career consulting, job search strategy and interview prep. Read the terms of its guarantee programs carefully on the site.', 'ResumAI і генератор листів
NetworkAI для нетворкінгу
InterviewAI
Кар''єрний коучинг', 'ResumAI and cover letter generator
NetworkAI for networking
InterviewAI
Career coaching', 'Студентам, випускникам і фахівцям, які шукають роботу.', 'Students, recent grads and professionals looking for jobs.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wonsulting.com' OR LOWER(`name`) = 'wonsulting') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI job search tools (resumes, networking, interviews, tracker) and career coaching.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Wonsulting combines the WonsultingAI tool suite — ResumAI, NetworkAI, JobBoardAI, InterviewAI, JobTrackerAI and a cover letter generator — with paid services: resume and LinkedIn profile revisions, career consulting, job search strategy and interview prep. Read the terms of its guarantee programs carefully on the site.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'ResumAI and cover letter generator
NetworkAI for networking
InterviewAI
Career coaching', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students, recent grads and professionals looking for jobs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'AI-інструменти можна спробувати безкоштовно.', 'The AI tools can be tried for free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'The AI tools can be tried for free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Послуги', 'Services', NULL, 'one_time', 'Коучинг і перегляд резюме — платні, ціни на сайті.', 'Coaching and resume reviews are paid; prices on the site.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Послуги' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Services', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Coaching and resume reviews are paid; prices on the site.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- CoachHub — Кар'єрний розвиток
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coachhub.com' OR LOWER(`name`) = 'coachhub')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CoachHub', NULL, 'https://www.coachhub.com', NULL, NULL, 'Цифрова платформа коучингу для компаній: індивідуальний і груповий коучинг, AI-коуч AIMY.', 'A digital coaching platform for companies: individual and group coaching plus the AIMY AI coach.', 'CoachHub надає компаніям коучинг для працівників і керівників: індивідуальний, колективний, виконавчий і гібридний, а також AI-коуча AIMY. Програми допомагають з розвитком лідерства, трансформаціями, впровадженням AI, ефективністю й добробутом працівників. Працівники отримують доступ через роботодавця.', 'CoachHub gives companies coaching for employees and leaders: individual, collective, executive and hybrid, plus the AIMY AI coach. Programs support leadership development, transformations, AI adoption, performance and employee well-being. Employees get access through their employer.', 'Індивідуальний і груповий коучинг
AI-коуч AIMY
Виконавчий коучинг
Програми розвитку лідерства', 'Individual and group coaching
AIMY AI coach
Executive coaching
Leadership development programs', 'Компаніям і HR-командам, які розвивають працівників.', 'Companies and HR teams developing their people.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-10 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coachhub.com' OR LOWER(`name`) = 'coachhub') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A digital coaching platform for companies: individual and group coaching plus the AIMY AI coach.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'CoachHub gives companies coaching for employees and leaders: individual, collective, executive and hybrid, plus the AIMY AI coach. Programs support leadership development, transformations, AI adoption, performance and employee well-being. Employees get access through their employer.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Individual and group coaching
AIMY AI coach
Executive coaching
Leadership development programs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Companies and HR teams developing their people.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Для компаній', 'For companies', NULL, 'year', 'Корпоративні ціни за запитом.', 'Corporate pricing on request.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Для компаній' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'For companies', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Corporate pricing on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Taplio — додатково в «Кар'єрний розвиток»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('Taplio') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- BetterUp — додатково в «Кар'єрний розвиток»
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = LOWER('BetterUp') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

