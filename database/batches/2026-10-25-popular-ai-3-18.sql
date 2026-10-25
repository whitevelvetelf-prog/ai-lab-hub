SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-25: популярні АІ-інструменти, партія 3: дім, здоров’я, фінанси, подорожі, переклад і мови (18 продуктів).
-- Відбір: популярні у світі запити в темах, які найчастіше переглядають відвідувачі (Мій дім, Здоров’я, Освіта, переклад і мови).
-- Тексти UA/EN написано з офіційних сайтів, звірено 2026-10-25. Ціни не вказано: «Ціна: див. сайт»; Free — де підтверджено.
-- Пропущено: REimagineHome і Pl@ntNet (уже є), Lingvanex (походження не підтверджено), Rendair, Cleo, RoamAround (сайти недоступні для перевірки).
-- Категорії й підкатегорії — за slug (без фіксованих id). @new рахується ДО INSERT. Повторний запуск безпечний.
-- Застосування: phpMyAdmin → БД → «Импорт».
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);

-- HomeByMe — my-home/interior-design, my-home/renovation
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'home.by.me/en' OR LOWER(`name`) = 'homebyme')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HomeByMe', NULL, 'https://home.by.me/en/', NULL, NULL, 'Безкоштовний планувальник оселі: план у 2D, облаштування в 3D реальними меблями брендів і рендери в 4K.', 'A free home planner: floor plan in 2D, furnishing in 3D with real branded furniture and 4K renders.', 'HomeByMe — онлайн-сервіс для проєктування житла. Ви креслите план квартири чи будинку у 2D, облаштовуєте його в 3D меблями реальних брендів і отримуєте фотореалістичні зображення в 4K. Є відеоінструкції для початку роботи та статті про тренди інтер’єру. Базове користування безкоштовне.', 'HomeByMe is an online home design service. You draw a floor plan of a flat or house in 2D, furnish it in 3D with real branded furniture and get photorealistic 4K images. There are video tutorials to get started and articles on interior trends. Basic use is free.', 'План приміщення у 2D
Облаштування в 3D
Меблі реальних брендів
Рендери в 4K', '2D floor plan
3D furnishing
Real branded furniture
4K renders', 'Тим, хто планує ремонт чи облаштування житла.', 'People planning a renovation or furnishing a home.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'home.by.me/en' OR LOWER(`name`) = 'homebyme') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'my-home' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'interior-design' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'renovation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free home planner: floor plan in 2D, furnishing in 3D with real branded furniture and 4K renders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'HomeByMe is an online home design service. You draw a floor plan of a flat or house in 2D, furnish it in 3D with real branded furniture and get photorealistic 4K images. There are video tutorials to get started and articles on interior trends. Basic use is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '2D floor plan
3D furnishing
Real branded furniture
4K renders', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People planning a renovation or furnishing a home.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Yuka — health-beauty/nutrition, health-beauty/skin-care
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yuka.io/en' OR LOWER(`name`) = 'yuka')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Yuka', NULL, 'https://yuka.io/en/', NULL, NULL, 'Застосунок-сканер продуктів і косметики: оцінює склад і вплив на здоров’я, без реклами й впливу брендів.', 'A scanner app for food and cosmetics: rates ingredients and health impact, with no ads or brand influence.', 'Yuka сканує штрихкоди харчових продуктів і косметики, розшифровує етикетки й показує оцінку від 0 до 100: добавки, надлишок цукру, калорійність. Сервіс підкреслює незалежність: бренди не можуть впливати на оцінки чи платити за рекламу в застосунку. Базові функції безкоштовні.', 'Yuka scans barcodes of food and cosmetic products, decodes labels and shows a 0–100 score covering additives, excess sugar and calories. The service stresses independence: brands cannot influence scores or pay for ads in the app. Basic features are free.', 'Сканування штрихкодів
Оцінка складу 0–100
Харчі й косметика
Без реклами', 'Barcode scanning
0–100 ingredient score
Food and cosmetics
No ads', 'Тим, хто стежить за складом їжі та косметики.', 'People who check what is in their food and cosmetics.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yuka.io/en' OR LOWER(`name`) = 'yuka') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'health-beauty' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'nutrition' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'skin-care' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A scanner app for food and cosmetics: rates ingredients and health impact, with no ads or brand influence.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Yuka scans barcodes of food and cosmetic products, decodes labels and shows a 0–100 score covering additives, excess sugar and calories. The service stresses independence: brands cannot influence scores or pay for ads in the app. Basic features are free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Barcode scanning
0–100 ingredient score
Food and cosmetics
No ads', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who check what is in their food and cosmetics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Albert — finance-legal/finance
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'albert.com' OR LOWER(`name`) = 'albert')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Albert', NULL, 'https://albert.com', NULL, NULL, 'Фінансовий асистент: бюджет, витрати, рахунки, заощадження та інвестиції, асистент Genius (для США).', 'A financial assistant: budget, spending, bills, savings and investing, with the Genius assistant (US).', 'Albert збирає повну картину ваших фінансів: створює бюджет, відстежує витрати й рахунки, шукає, де заощадити, пропонує банківський рахунок, заощадження та інвестиції. Підписка Genius додає асистента, фінансовий план, допомогу з покупками, сповіщення й сховище документів. Сервіс орієнтований на США.', 'Albert builds a full picture of your finances: it creates a budget, tracks spending and bills, finds savings and offers banking, saving and investing. The Genius subscription adds an assistant, a financial plan, shopping help, alerts and a document vault. The service is aimed at the US.', 'Бюджет і витрати
Відстеження рахунків
Заощадження та інвестиції
Асистент Genius', 'Budget and spending
Bill tracking
Saving and investing
Genius assistant', 'Користувачам у США, які хочуть упорядкувати фінанси.', 'US users who want to organise their finances.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'albert.com' OR LOWER(`name`) = 'albert') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'finance-legal' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'finance' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A financial assistant: budget, spending, bills, savings and investing, with the Genius assistant (US).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Albert builds a full picture of your finances: it creates a budget, tracks spending and bills, finds savings and offers banking, saving and investing. The Genius subscription adds an assistant, a financial plan, shopping help, alerts and a document vault. The service is aimed at the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Budget and spending
Bill tracking
Saving and investing
Genius assistant', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US users who want to organise their finances.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ironclad — finance-legal/documents, finance-legal/legal-services
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ironcladapp.com' OR LOWER(`name`) = 'ironclad')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ironclad', NULL, 'https://ironcladapp.com', NULL, NULL, 'АІ-платформа управління життєвим циклом договорів: створення, погодження, підпис, зберігання й аналіз.', 'An AI contract lifecycle management platform: create, review, sign, store and analyse contracts.', 'Ironclad — корпоративна CLM-платформа для юридичних і бізнес-команд. Вона допомагає створювати договори за шаблонами, погоджувати й підписувати їх, зберігати в репозиторії та витягувати з угод дані й ризики за допомогою АІ. Інтегрується з робочими системами компаній; ціну визначають після демо.', 'Ironclad is an enterprise CLM platform for legal and business teams. It helps create contracts from templates, review and sign them, store them in a repository and use AI to surface data and risks from agreements. It integrates with company systems; pricing follows a demo.', 'Шаблони договорів
Погодження й підпис
Репозиторій угод
АІ-аналіз ризиків', 'Contract templates
Review and signing
Contract repository
AI risk insights', 'Юридичним відділам і великим компаніям.', 'Legal departments and large companies.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ironcladapp.com' OR LOWER(`name`) = 'ironclad') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'finance-legal' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'documents' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'legal-services' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI contract lifecycle management platform: create, review, sign, store and analyse contracts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ironclad is an enterprise CLM platform for legal and business teams. It helps create contracts from templates, review and sign them, store them in a repository and use AI to surface data and risks from agreements. It integrates with company systems; pricing follows a demo.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Contract templates
Review and signing
Contract repository
AI risk insights', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Legal departments and large companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- iplan.ai — productivity/travel
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'iplan.ai' OR LOWER(`name`) = 'iplan.ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'iplan.ai', NULL, 'https://iplan.ai', NULL, NULL, 'АІ-планувальник подорожей: маршрут за кілька секунд з урахуванням мети, інтересів, компанії й бюджету.', 'An AI travel planner: an itinerary in seconds based on purpose, interests, companions and budget.', 'iplan.ai складає план поїздки за кілька секунд. Ви вказуєте напрям, мету подорожі, інтереси, з ким їдете, тривалість і бюджет — АІ підбирає маршрут під ці побажання. План доступний з будь-якого пристрою, є застосунок для Android.', 'iplan.ai builds a trip plan in seconds. You enter the destination, trip purpose, interests, who you travel with, length of stay and budget, and the AI curates an itinerary to match. The plan is available on any device, and there is an Android app.', 'Маршрут за секунди
Урахування інтересів і бюджету
Доступ з будь-якого пристрою
Застосунок для Android', 'Itinerary in seconds
Interests and budget
Access on any device
Android app', 'Мандрівникам, які планують поїздку самостійно.', 'Travellers planning trips on their own.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'iplan.ai' OR LOWER(`name`) = 'iplan.ai') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'productivity' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'travel' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI travel planner: an itinerary in seconds based on purpose, interests, companions and budget.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'iplan.ai builds a trip plan in seconds. You enter the destination, trip purpose, interests, who you travel with, length of stay and budget, and the AI curates an itinerary to match. The plan is available on any device, and there is an Android app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Itinerary in seconds
Interests and budget
Access on any device
Android app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers planning trips on their own.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Lokalise — translation-languages/translation
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lokalise.com' OR LOWER(`name`) = 'lokalise')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lokalise', NULL, 'https://lokalise.com', NULL, NULL, 'Платформа безперервної локалізації з АІ: переклад застосунків, сайтів і контенту, інтеграції з Figma та GitHub.', 'A continuous localization platform with AI: translating apps, websites and content, with Figma and GitHub integrations.', 'Lokalise — платформа управління перекладами для продуктових команд. Вона вбудовується в процес розробки, дає АІ-переклад з власними профілями та оцінкою якості, автоматичні робочі процеси, контекст для перекладачів, API і MCP-сервер. Інтегрується з Figma, GitHub, GitLab, Jira, Contentful, Webflow і WordPress; є пробний період.', 'Lokalise is a translation management platform for product teams. It plugs into the development workflow and offers AI translation with custom profiles and quality scoring, automated workflows, context for translators, an API and an MCP server. It integrates with Figma, GitHub, GitLab, Jira, Contentful, Webflow and WordPress; there is a free trial.', 'АІ-переклад і оцінка якості
Автоматичні робочі процеси
Інтеграції Figma, GitHub, Jira
API та MCP-сервер', 'AI translation and scoring
Automated workflows
Figma, GitHub, Jira integrations
API and MCP server', 'Командам, що локалізують застосунки й сайти.', 'Teams localizing apps and websites.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lokalise.com' OR LOWER(`name`) = 'lokalise') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'translation-languages' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'translation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A continuous localization platform with AI: translating apps, websites and content, with Figma and GitHub integrations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Lokalise is a translation management platform for product teams. It plugs into the development workflow and offers AI translation with custom profiles and quality scoring, automated workflows, context for translators, an API and an MCP server. It integrates with Figma, GitHub, GitLab, Jira, Contentful, Webflow and WordPress; there is a free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI translation and scoring
Automated workflows
Figma, GitHub, Jira integrations
API and MCP server', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Teams localizing apps and websites.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Crowdin — translation-languages/translation
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'crowdin.com' OR LOWER(`name`) = 'crowdin')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Crowdin', NULL, 'https://crowdin.com', NULL, NULL, 'АІ-платформа локалізації: автоматизація перекладу контенту та 700+ застосунків та інтеграцій.', 'An AI-powered localization platform: automated content translation and 700+ apps and integrations.', 'Crowdin — платформа локалізації та управління перекладами для команд і бізнесу. Вона автоматизує переклад програм, сайтів, документації й іншого контенту з допомогою АІ, поєднує роботу перекладачів і машинний переклад та має понад 700 застосунків та інтеграцій. Є безкоштовний старт і 30-денний пробний період Enterprise.', 'Crowdin is a localization and translation management platform for teams and businesses. It automates translation of software, websites, documentation and other content with AI, combines human and machine translation and offers 700+ apps and integrations. There is a free start and a 30-day Enterprise trial.', 'АІ-переклад контенту
700+ інтеграцій
Робота з перекладачами
Пробний Enterprise', 'AI content translation
700+ integrations
Work with translators
Enterprise trial', 'Розробникам і командам локалізації.', 'Developers and localization teams.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'crowdin.com' OR LOWER(`name`) = 'crowdin') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'translation-languages' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'translation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI-powered localization platform: automated content translation and 700+ apps and integrations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Crowdin is a localization and translation management platform for teams and businesses. It automates translation of software, websites, documentation and other content with AI, combines human and machine translation and offers 700+ apps and integrations. There is a free start and a 30-day Enterprise trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI content translation
700+ integrations
Work with translators
Enterprise trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and localization teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Dubverse — multimedia/voiceover, translation-languages/translation
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dubverse.ai' OR LOWER(`name`) = 'dubverse')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dubverse', NULL, 'https://dubverse.ai', NULL, NULL, 'Генеративна АІ-платформа: дубляж відео, синтез мовлення, автосубтитри, переклад відео та API.', 'A generative AI platform: video dubbing, text to speech, auto subtitles, video translation and an API.', 'Dubverse перекладає й дублює відео іншими мовами за допомогою АІ, озвучує тексти природними голосами, створює субтитри й транскрипти. Є калькулятор кредитів, каталог мов і дикторів, корпоративні рішення та API. Можна спробувати безкоштовно.', 'Dubverse translates and dubs videos into other languages with AI, voices text with natural-sounding speakers and creates subtitles and transcripts. It has a credits calculator, a catalogue of languages and speakers, enterprise plans and an API. You can try it for free.', 'АІ-дубляж відео
Синтез мовлення
Автосубтитри й транскрипти
API', 'AI video dubbing
Text to speech
Auto subtitles and transcripts
API', 'Авторам відео та маркетологам.', 'Video creators and marketers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dubverse.ai' OR LOWER(`name`) = 'dubverse') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'multimedia' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'voiceover' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'translation-languages' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'translation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A generative AI platform: video dubbing, text to speech, auto subtitles, video translation and an API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Dubverse translates and dubs videos into other languages with AI, voices text with natural-sounding speakers and creates subtitles and transcripts. It has a credits calculator, a catalogue of languages and speakers, enterprise plans and an API. You can try it for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI video dubbing
Text to speech
Auto subtitles and transcripts
API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Video creators and marketers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Vozo — multimedia/video-editing, translation-languages/translation
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vozo.ai' OR LOWER(`name`) = 'vozo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Vozo', NULL, 'https://www.vozo.ai', NULL, NULL, 'АІ-переклад відео: субтитри, дубляж, синхронізація губ і текст на екрані для 160+ мов.', 'AI video translation: subtitles, dubbing, lip sync and on-screen text for 160+ languages.', 'Vozo локалізує відео за допомогою АІ: перекладає мовлення, робить дубляж зі збереженням голосу, синхронізує рухи губ, додає субтитри та перекладає текст на екрані — понад 160 мов. Орієнтований на авторів, маркетологів і викладачів; є API і безкоштовна реєстрація.', 'Vozo localizes video with AI: it translates speech, dubs while keeping the voice, syncs lip movements, adds subtitles and translates on-screen text in 160+ languages. It targets creators, marketers and educators; there is an API and free sign-up.', 'Переклад відео 160+ мов
Дубляж і синхронізація губ
Субтитри
API', 'Video translation, 160+ languages
Dubbing and lip sync
Subtitles
API', 'Авторам, маркетологам і викладачам.', 'Creators, marketers and educators.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vozo.ai' OR LOWER(`name`) = 'vozo') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'multimedia' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'video-editing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'translation-languages' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'translation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI video translation: subtitles, dubbing, lip sync and on-screen text for 160+ languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Vozo localizes video with AI: it translates speech, dubs while keeping the voice, syncs lip movements, adds subtitles and translates on-screen text in 160+ languages. It targets creators, marketers and educators; there is an API and free sign-up.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Video translation, 160+ languages
Dubbing and lip sync
Subtitles
API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Creators, marketers and educators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Interprefy — translation-languages/translation, translation-languages/speech-recognition
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'interprefy.com' OR LOWER(`name`) = 'interprefy')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Interprefy', NULL, 'https://www.interprefy.com', NULL, NULL, 'Багатомовні події: дистанційний синхронний переклад, АІ-переклад мовлення та живі субтитри.', 'Multilingual events: remote simultaneous interpretation, AI speech translation and live captions.', 'Interprefy забезпечує багатомовність конференцій, вебінарів і зустрічей: професійний дистанційний синхронний переклад, АІ-переклад мовлення та живі субтитри. Працює для офлайн-, гібридних і онлайн-подій, через вебплатформу, мобільний застосунок та інтеграції з платформами зустрічей; є супровід проєктів.', 'Interprefy makes conferences, webinars and meetings multilingual with professional remote simultaneous interpretation, AI speech translation and live captions. It works for in-person, hybrid and virtual events via a web platform, a mobile app and integrations with meeting platforms, with project support.', 'Синхронний переклад
АІ-переклад мовлення
Живі субтитри
Інтеграції з платформами зустрічей', 'Simultaneous interpretation
AI speech translation
Live captions
Meeting platform integrations', 'Організаторам подій і міжнародним компаніям.', 'Event organisers and international companies.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'interprefy.com' OR LOWER(`name`) = 'interprefy') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'translation-languages' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'translation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'speech-recognition' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Multilingual events: remote simultaneous interpretation, AI speech translation and live captions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Interprefy makes conferences, webinars and meetings multilingual with professional remote simultaneous interpretation, AI speech translation and live captions. It works for in-person, hybrid and virtual events via a web platform, a mobile app and integrations with meeting platforms, with project support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Simultaneous interpretation
AI speech translation
Live captions
Meeting platform integrations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Event organisers and international companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- KUDO — translation-languages/translation, translation-languages/speech-recognition
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kudo.ai' OR LOWER(`name`) = 'kudo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'KUDO', NULL, 'https://kudo.ai', NULL, NULL, 'Живий переклад мовлення та субтитри 200 мовами — АІ або професійні перекладачі, для будь-якої платформи.', 'Live speech translation and captions in 200 languages — AI or human interpreters, on any platform.', 'KUDO перекладає мовлення наживо на зустрічах, навчаннях і подіях: на вибір АІ-переклад із субтитрами або професійні усні перекладачі, до 200 мов. Підключається до будь-якої платформи зустрічей чи подій — онлайн, гібридно або в залі; є рішення для освіти, державних установ і релігійних громад.', 'KUDO translates speech live at meetings, trainings and events, with a choice of AI translation with captions or professional interpreters, in up to 200 languages. It connects to any meeting or event platform — remote, hybrid or in-person — with solutions for education, government and houses of worship.', 'Переклад мовлення 200 мовами
АІ або живі перекладачі
Субтитри
Будь-яка платформа зустрічей', 'Speech translation, 200 languages
AI or human interpreters
Captions
Any meeting platform', 'Компаніям і організаторам міжнародних подій.', 'Companies and international event organisers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kudo.ai' OR LOWER(`name`) = 'kudo') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'translation-languages' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'translation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'speech-recognition' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Live speech translation and captions in 200 languages — AI or human interpreters, on any platform.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'KUDO translates speech live at meetings, trainings and events, with a choice of AI translation with captions or professional interpreters, in up to 200 languages. It connects to any meeting or event platform — remote, hybrid or in-person — with solutions for education, government and houses of worship.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Speech translation, 200 languages
AI or human interpreters
Captions
Any meeting platform', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Companies and international event organisers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Timekettle — translation-languages/translation
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'timekettle.co' OR LOWER(`name`) = 'timekettle')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Timekettle', NULL, 'https://www.timekettle.co', NULL, NULL, 'Навушники-перекладачі з АІ: синхронний переклад розмов для подорожей і спілкування різними мовами.', 'AI translator earbuds: real-time conversation translation for travel and cross-language communication.', 'Timekettle виробляє навушники та пристрої для перекладу розмов у реальному часі на базі АІ. Вони працюють разом із застосунком і допомагають мандрівникам, діловим людям і парам, що говорять різними мовами. Це апаратний продукт: пристрої купують в інтернет-магазині, є сторінка для України.', 'Timekettle makes AI-powered earbuds and devices that translate conversations in real time. They work with a companion app and help travellers, business people and couples who speak different languages. It is a hardware product sold through an online store, including a Ukrainian storefront.', 'Переклад розмов у реальному часі
Навушники-перекладачі
Застосунок-компаньйон
Для подорожей', 'Real-time conversation translation
Translator earbuds
Companion app
For travel', 'Мандрівникам і людям, що спілкуються різними мовами.', 'Travellers and people talking across languages.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'timekettle.co' OR LOWER(`name`) = 'timekettle') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'translation-languages' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'translation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI translator earbuds: real-time conversation translation for travel and cross-language communication.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Timekettle makes AI-powered earbuds and devices that translate conversations in real time. They work with a companion app and help travellers, business people and couples who speak different languages. It is a hardware product sold through an online store, including a Ukrainian storefront.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time conversation translation
Translator earbuds
Companion app
For travel', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers and people talking across languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Pocketalk — translation-languages/translation
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pocketalk.com' OR LOWER(`name`) = 'pocketalk')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Pocketalk', NULL, 'https://www.pocketalk.com', NULL, NULL, 'Кишеньковий голосовий перекладач і корпоративний застосунок для перекладу розмов.', 'A pocket voice translator device and an enterprise app for translating conversations.', 'Pocketalk — портативний пристрій для голосового перекладу розмов, а також застосунок Pocketalk Enterprise для організацій. Рішення використовують в освіті, медицині, державних установах, службах безпеки та логістиці; є калькулятор економії на перекладі та портал керування пристроями.', 'Pocketalk is a portable voice translation device for conversations, plus the Pocketalk Enterprise app for organisations. It is used in education, healthcare, government, public safety and logistics, with a translation cost-savings calculator and a device management portal.', 'Портативний голосовий перекладач
Корпоративний застосунок
Для медицини й освіти
Керування пристроями', 'Portable voice translator
Enterprise app
For healthcare and education
Device management', 'Мандрівникам і організаціям, що працюють з іноземцями.', 'Travellers and organisations serving foreign speakers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pocketalk.com' OR LOWER(`name`) = 'pocketalk') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'translation-languages' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'translation' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A pocket voice translator device and an enterprise app for translating conversations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Pocketalk is a portable voice translation device for conversations, plus the Pocketalk Enterprise app for organisations. It is used in education, healthcare, government, public safety and logistics, with a translation cost-savings calculator and a device management portal.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Portable voice translator
Enterprise app
For healthcare and education
Device management', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers and organisations serving foreign speakers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Promova — education-knowledge/courses, translation-languages
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'promova.com' OR LOWER(`name`) = 'promova')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Promova', NULL, 'https://promova.com', NULL, NULL, 'Застосунок для вивчення мов з українським корінням: короткі уроки, курси, репетитори та АІ-тьютор для розмовної практики.', 'A language learning app with Ukrainian roots: bite-sized lessons, courses, tutors and an AI Tutor for speaking practice.', 'Promova допомагає вивчати 12 мов, серед них англійську, іспанську, німецьку, японську й українську. Є короткі уроки, інтерактивні курси, заняття з репетиторами та АІ-тьютор, з яким можна практикувати розмову з першого дня. Застосунок має понад 400 тем і рейтинг 4,6; почати можна безкоштовно.', 'Promova helps you learn 12 languages, including English, Spanish, German, Japanese and Ukrainian. It offers bite-sized lessons, interactive courses, sessions with tutors and an AI Tutor for speaking practice from day one. The app has 400+ topics and a 4.6 rating; you can start for free.', '12 мов
АІ-тьютор для розмови
Курси й репетитори
400+ тем', '12 languages
AI Tutor for speaking
Courses and tutors
400+ topics', 'Тим, хто вивчає іноземну мову.', 'Language learners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'promova.com' OR LOWER(`name`) = 'promova') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'education-knowledge' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'translation-languages' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A language learning app with Ukrainian roots: bite-sized lessons, courses, tutors and an AI Tutor for speaking practice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Promova helps you learn 12 languages, including English, Spanish, German, Japanese and Ukrainian. It offers bite-sized lessons, interactive courses, sessions with tutors and an AI Tutor for speaking practice from day one. The app has 400+ topics and a 4.6 rating; you can start for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '12 languages
AI Tutor for speaking
Courses and tutors
400+ topics', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Language learners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Langotalk — education-knowledge/tutoring, translation-languages
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'langotalk.org' OR LOWER(`name`) = 'langotalk')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Langotalk', NULL, 'https://www.langotalk.org', NULL, NULL, 'Персональний АІ-тьютор з мов: виправляє помилки, заповнює прогалини й веде розмовні уроки 20+ мовами.', 'A personal AI language tutor: corrects mistakes, fills gaps and guides conversational lessons in 20+ languages.', 'Langotalk працює як особистий репетитор: аналізує ваш словник, граматику та вільність мовлення після кожного речення й підлаштовує уроки під вас. Навчання будується на живих діалогах — говоріть, слухайте й читайте замість повторюваних вправ. Понад 20 мов, почати можна безкоштовно.', 'Langotalk acts as a personal tutor: it analyses your vocabulary, grammar and fluency after every sentence and adapts lessons to you. Learning is built on real conversations — speak, listen and read instead of repetitive drills. 20+ languages, free to start.', 'АІ-тьютор
Виправлення помилок
Розмовні уроки
20+ мов', 'AI tutor
Mistake correction
Conversational lessons
20+ languages', 'Тим, хто хоче заговорити іноземною мовою.', 'Learners who want to speak a new language.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'langotalk.org' OR LOWER(`name`) = 'langotalk') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'education-knowledge' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'tutoring' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'translation-languages' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A personal AI language tutor: corrects mistakes, fills gaps and guides conversational lessons in 20+ languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Langotalk acts as a personal tutor: it analyses your vocabulary, grammar and fluency after every sentence and adapts lessons to you. Learning is built on real conversations — speak, listen and read instead of repetitive drills. 20+ languages, free to start.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI tutor
Mistake correction
Conversational lessons
20+ languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Learners who want to speak a new language.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Clozemaster — education-knowledge/courses, translation-languages
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'clozemaster.com' OR LOWER(`name`) = 'clozemaster')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Clozemaster', NULL, 'https://www.clozemaster.com', NULL, NULL, 'Гра для вивчення слів у контексті: тисячі речень із пропусками 50+ мовами.', 'A game for learning vocabulary in context: thousands of fill-in-the-blank sentences in 50+ languages.', 'Clozemaster вчить слова в реальних реченнях: ви заповнюєте пропуски й запам’ятовуєте не лише значення, а й уживання. Понад 50 мов і 170 мовних пар, ігрова механіка й повторення. Підходить як наступний крок після Duolingo; реєстрація безкоштовна.', 'Clozemaster teaches vocabulary in real sentences: you fill in the blanks and remember not only meaning but usage. 50+ languages and 170+ language pairs, with game mechanics and review. It works well as a next step after Duolingo; sign-up is free.', 'Речення з пропусками
50+ мов
170+ мовних пар
Ігрова механіка', 'Fill-in-the-blank sentences
50+ languages
170+ language pairs
Gamified', 'Тим, хто вивчає мову й хоче розширити словник.', 'Learners building vocabulary.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'clozemaster.com' OR LOWER(`name`) = 'clozemaster') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'education-knowledge' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'translation-languages' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A game for learning vocabulary in context: thousands of fill-in-the-blank sentences in 50+ languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Clozemaster teaches vocabulary in real sentences: you fill in the blanks and remember not only meaning but usage. 50+ languages and 170+ language pairs, with game mechanics and review. It works well as a next step after Duolingo; sign-up is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Fill-in-the-blank sentences
50+ languages
170+ language pairs
Gamified', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Learners building vocabulary.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Readlang — education-knowledge/courses, translation-languages
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'readlang.com' OR LOWER(`name`) = 'readlang')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Readlang', NULL, 'https://readlang.com', NULL, NULL, 'Вивчення мови через читання: переклад слів кліком, розумні картки та тексти 100+ мовами.', 'Learn a language by reading: click-to-translate words, smart flashcards and texts in 100+ languages.', 'Readlang дає змогу читати статті, книжки, відео й вебсторінки іноземною мовою і перекладати слова чи фрази одним кліком. Перекладені слова потрапляють у розумні картки для повторення. Понад 100 мов; почати можна безкоштовно.', 'Readlang lets you read articles, books, videos and web pages in a foreign language and translate words or phrases with one click. Translated words go into smart flashcards for review. 100+ languages; free to start.', 'Переклад кліком
Розумні картки
Статті, книжки, вебсторінки
100+ мов', 'Click to translate
Smart flashcards
Articles, books, web pages
100+ languages', 'Тим, хто вивчає мову через читання.', 'Learners who study through reading.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'readlang.com' OR LOWER(`name`) = 'readlang') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'education-knowledge' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'translation-languages' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Learn a language by reading: click-to-translate words, smart flashcards and texts in 100+ languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Readlang lets you read articles, books, videos and web pages in a foreign language and translate words or phrases with one click. Translated words go into smart flashcards for review. 100+ languages; free to start.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Click to translate
Smart flashcards
Articles, books, web pages
100+ languages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Learners who study through reading.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний рівень.', 'Free tier.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free tier.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Glossika — education-knowledge/courses, translation-languages
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ai.glossika.com' OR LOWER(`name`) = 'glossika')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Glossika', NULL, 'https://ai.glossika.com', NULL, NULL, 'Вивчення мов через масове слухання й повторення речень із адаптивними алгоритмами, 60+ мов.', 'Language learning through massive exposure to sentences with adaptive algorithms, 60+ languages.', 'Glossika веде до вільного мовлення через багаторазове прослуховування й повторення речень, що відповідають вашому рівню; адаптивні алгоритми керують графіком навчання. Понад 60 мов, зокрема кілька варіантів китайської та іспанської. Є 7-денний безкоштовний пробний період.', 'Glossika builds fluency through massive exposure to level-appropriate sentences that you listen to and repeat, guided by adaptive learning algorithms. 60+ languages, including several variants of Chinese and Spanish. There is a 7-day free trial.', 'Повторення речень
Адаптивні алгоритми
60+ мов
7 днів безкоштовно', 'Sentence repetition
Adaptive algorithms
60+ languages
7-day free trial', 'Тим, хто хоче заговорити іноземною мовою.', 'Learners aiming to speak fluently.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-25 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ai.glossika.com' OR LOWER(`name`) = 'glossika') ORDER BY `id` LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'education-knowledge' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'courses' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'translation-languages' LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Language learning through massive exposure to sentences with adaptive algorithms, 60+ languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Glossika builds fluency through massive exposure to level-appropriate sentences that you listen to and repeat, guided by adaptive learning algorithms. 60+ languages, including several variants of Chinese and Spanish. There is a 7-day free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sentence repetition
Adaptive algorithms
60+ languages
7-day free trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Learners aiming to speak fluently.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

