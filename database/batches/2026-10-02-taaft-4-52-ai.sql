SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-02: 52 нових AI-продуктів (кандидати з лідерборду TAAFT — лише назви;
-- тексти й тарифи написано з офіційних сайтів продуктів, сайти звірено 2026-10-02)
--   11x — Продажі, AI-агенти
--   AdSpawn — SMM, Генерація відео
--   AI Video API — API, Генерація відео
--   AI/ML API — API
--   Aicut — Генерація відео, SMM
--   ANDRE — Аналітика, Звіти
--   Breadcrumb — Аналітика, Продажі
--   HeadSnap — Фотографія, Генерація зображень
--   Hedy — AI-асистенти, Транскрипція
--   illustration.app — Графічний дизайн, Генерація зображень
--   imagetocaption.ai — SMM, Копірайтинг
--   insMind — Генерація відео, Фотографія, SMM
--   Instafill — Документи, Автоматизація
--   Keragon — Автоматизація, Медицина
--   Kopage — Конструктори сайтів
--   LaunchLemonade — AI-агенти, Чат-боти
--   Lingolette — Переклад, Репетиторство
--   LTX Studio — Генерація відео, Відеомонтаж
--   Lyrics Into Song AI — Музика
--   Mammouth AI — Чат-боти, AI-асистенти
--   Millis AI — Голосові агенти, API
--   mixus — Юридичні послуги, AI-агенти
--   NEUROFIT — Ментальне здоров'я
--   NodeLand — Тести, Дошки та діаграми
--   Nouswise — Дослідження та пошук, AI-агенти
--   OpenHands — Асистенти коду, AI-агенти
--   Paperguide — Дослідження та пошук, Публікації
--   PicLumen — Генерація зображень, Генерація відео
--   PicTools.AI — Фотографія, Видалення фону
--   PokaMind — HR і рекрутинг, AI-асистенти
--   Sensay — HR і рекрутинг, Чат-боти
--   SongGenerator.io — Музика, Аудіо
--   SoundBoost — Аудіо, Музика
--   Subscribr — Генерація відео, Копірайтинг, SMM
--   Syllaby — Генерація відео, AI-аватари, SMM
--   Thesify — Дослідження та пошук, Публікації
--   Vadoo AI — Генерація відео, SMM
--   VenturusAI — Фінанси, Аналітика
--   VideoToPage — Копірайтинг, SEO
--   Viggle AI — 3D та анімація, Генерація відео
--   Zivy — Тайм-менеджмент, Плагіни
--   Accio Work — AI-агенти, Аналітика
--   TalkTastic — Транскрипція, AI-асистенти
--   Voicepen — Копірайтинг, Транскрипція
--   StoryArtAI — Генерація зображень, Публікації
--   CVGist — HR і рекрутинг, Копірайтинг
--   Tengr.ai — Генерація зображень
--   Athena AI — AI-асистенти, Дошки та діаграми
--   Informly — Підтримка клієнтів, Чат-боти
--   Chief — AI-асистенти, Транскрипція
--   LiGo — SMM, Копірайтинг
--   Rabbithole — Дослідження та пошук, Чат-боти
--
-- Застосування (phpMyAdmin хостингу, БД gu621051_ailabhublive): «Импорт» → *.sql.zip → «Импорт» (або SQL → вставити → Вперёд).
-- Без фіксованих id і без DROP / DELETE. @new обчислюється ДО вставки продукту (без ROW_COUNT()); продукт додається
-- лише якщо немає продукту з тим самим нормалізованим URL АБО назвою, інакше наявному лише додаються категорія й
-- підкатегорія (за slug категорії + назвою). Id тарифів — за product_id + plan_name. Повторний запуск безпечний. Логотипи не додаються (NULL).
-- Автор — whitevelvetelf@gmail.com (id за email). Статус published, партнерство «Знайдено».
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);

-- 11x — Продажі
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '11x.ai' OR LOWER(`name`) = LOWER('11x'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT '11x', NULL, 'https://11x.ai', NULL, NULL, 'Цифрові AI-працівники для продажів і маркетингу: виконують багатокрокові ланцюжки розсилок, досліджують компанії, шукають потенційних клієнтів і пишуть повідомлення, звільняючи менеджерам час на живі розмови.', 'Digital AI workers for sales and marketing: they run multi-step outreach sequences, research companies, prospect and write messages, freeing reps to focus on real conversations.', '11x пропонує «цифрових працівників» — AI-агентів, які беруть на себе рутину відділів продажів, RevOps і маркетингу. Агенти досліджують цільові компанії, шукають потенційних клієнтів, готують персональні повідомлення й ведуть багатокрокові ланцюжки контактів у різних каналах, а з часом навчаються й покращують результати. Це дозволяє невеликим командам масштабувати вихідні продажі без розширення штату, а менеджерам — більше часу приділяти реальним розмовам із клієнтами. Сервіс орієнтований на компанії, співпраця починається з демонстрації.', '11x offers digital workers, AI agents that take over routine work for sales, RevOps and marketing teams. The agents research target companies, find prospects, prepare personalized messages and run multi-step outreach sequences across channels, learning and improving results over time. This lets small teams scale outbound without growing headcount, and gives reps more time for real conversations with customers. The service targets companies, and engagement starts with a demo.', 'AI-агенти для вихідних продажів
Дослідження цільових компаній
Пошук потенційних клієнтів
Персональні повідомлення
Багатокрокові ланцюжки контактів
Навчання на результатах', 'AI agents for outbound sales
Target company research
Prospecting
Personalized messages
Multi-step outreach sequences
Learning from results', 'Керівники продажів, RevOps і маркетингу в B2B-компаніях.', 'Sales, RevOps and marketing leaders at B2B companies.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '11x.ai' OR LOWER(`name`) = LOWER('11x')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' AND s.`name` = 'Продажі' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' AND s.`name` = 'AI-агенти' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Digital AI workers for sales and marketing: they run multi-step outreach sequences, research companies, prospect and write messages, freeing reps to focus on real conversations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', '11x offers digital workers, AI agents that take over routine work for sales, RevOps and marketing teams. The agents research target companies, find prospects, prepare personalized messages and run multi-step outreach sequences across channels, learning and improving results over time. This lets small teams scale outbound without growing headcount, and gives reps more time for real conversations with customers. The service targets companies, and engagement starts with a demo.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI agents for outbound sales
Target company research
Prospecting
Personalized messages
Multi-step outreach sequences
Learning from results', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sales, RevOps and marketing leaders at B2B companies.', 'manual' FROM DUAL WHERE @new = 1;

-- AdSpawn — SMM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'adspawn.io' OR LOWER(`name`) = LOWER('AdSpawn'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AdSpawn', NULL, 'https://adspawn.io', NULL, NULL, 'Автоматичне створення рекламних креативів для мобільних ігор: достатньо дати посилання на гру в магазині застосунків, і сервіс сам збере матеріали, згенерує нові та надішле готові рекламні ролики на пошту.', 'Automated ad creatives for mobile games: just share your game''s store link and the service gathers assets, generates new ones and emails you finished ad videos.', 'AdSpawn допомагає розробникам мобільних ігор отримувати рекламні креативи для залучення гравців без власної студії. Потрібно лише вказати посилання на гру в магазині застосунків: сервіс автоматично знаходить доступні матеріали гри, генерує нові та запускає виробництво креативів, а посилання на готові ролики надсилає на пошту. Перші креативи можна отримати безкоштовно. Для тих, хто хоче робити рекламу самостійно, є окремий безкоштовний інструмент створення рекламних роликів.', 'AdSpawn helps mobile game developers get user acquisition creatives without an in-house studio. You only provide the game''s app store link: the service automatically finds available game assets, generates new ones and starts creative production, then emails you a link to the finished videos. The first creatives are free. For those who want to make ads themselves, there is a separate free ad video tool.', 'Креативи за посиланням на гру
Автоматичний збір і генерація матеріалів
Готові ролики на пошту
Перші креативи безкоштовно
Інструмент для власних роликів', 'Creatives from a game store link
Automatic asset gathering and generation
Finished videos by email
First creatives free
Tool for making your own videos', 'Розробники й видавці мобільних ігор, фахівці із залучення користувачів.', 'Mobile game developers and publishers, user acquisition specialists.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'adspawn.io' OR LOWER(`name`) = LOWER('AdSpawn')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' AND s.`name` = 'SMM' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Генерація відео' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Automated ad creatives for mobile games: just share your game''s store link and the service gathers assets, generates new ones and emails you finished ad videos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'AdSpawn helps mobile game developers get user acquisition creatives without an in-house studio. You only provide the game''s app store link: the service automatically finds available game assets, generates new ones and starts creative production, then emails you a link to the finished videos. The first creatives are free. For those who want to make ads themselves, there is a separate free ad video tool.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Creatives from a game store link
Automatic asset gathering and generation
Finished videos by email
First creatives free
Tool for making your own videos', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Mobile game developers and publishers, user acquisition specialists.', 'manual' FROM DUAL WHERE @new = 1;

-- AI Video API — API
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aivideoapi.com' OR LOWER(`name`) = LOWER('AI Video API'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AI Video API', NULL, 'https://aivideoapi.com', NULL, NULL, 'API-хаб для генерації відео: створення роликів із тексту або анімація зображень через сторонні відеомоделі з однаковим інтерфейсом, із квотами відео на місяць і оплатою понад ліміт.', 'An API hub for video generation: create videos from text or animate images through third-party video models with one interface, with monthly video quotas and overage billing.', 'AI Video API дає розробникам доступ до генерації відео через один інтерфейс. Можна створювати відео з текстового опису або оживлювати завантажені зображення. Сервіс використовує сторонні відеомоделі, обіцяє швидку чергу й зберігає створені відео приватно. Тарифи відрізняються кількістю відео на місяць і набором доступних моделей; понад квоту кожне відео оплачується окремо. Безкоштовний старт дає кілька відео для проби. API також доступний через маркетплейс API.', 'AI Video API gives developers access to video generation through one interface. You can create videos from a text description or bring uploaded images to life. The service uses third-party video models, promises a fast queue and stores generated videos privately. Plans differ in the number of videos per month and the models available; beyond the quota each video is billed separately. The free start gives a few videos to try. The API is also available through an API marketplace.', 'Генерація відео з тексту через API
Анімація зображень
Кілька відеомоделей
Приватне зберігання відео
Квоти й оплата понад ліміт', 'Text-to-video via API
Image animation
Several video models
Private video storage
Quotas and overage billing', 'Розробники, які вбудовують генерацію відео у свої застосунки.', 'Developers building video generation into their apps.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aivideoapi.com' OR LOWER(`name`) = LOWER('AI Video API')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' AND s.`name` = 'API' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Генерація відео' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An API hub for video generation: create videos from text or animate images through third-party video models with one interface, with monthly video quotas and overage billing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'AI Video API gives developers access to video generation through one interface. You can create videos from a text description or bring uploaded images to life. The service uses third-party video models, promises a fast queue and stores generated videos privately. Plans differ in the number of videos per month and the models available; beyond the quota each video is billed separately. The free start gives a few videos to try. The API is also available through an API marketplace.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Text-to-video via API
Image animation
Several video models
Private video storage
Quotas and overage billing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers building video generation into their apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Starter', 'Starter', 0.00, 'free', '5 відео для проби', '5 videos to try' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Starter' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Starter', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '5 videos to try', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ultra', 'Ultra', 39.90, 'month', 'До 250 відео на місяць; $399 при оплаті за рік', 'Up to 250 videos per month; $399 billed yearly' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ultra' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Ultra', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Up to 250 videos per month; $399 billed yearly', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Mega', 'Mega', 99.90, 'month', 'До 750 відео на місяць; $999 при оплаті за рік', 'Up to 750 videos per month; $999 billed yearly' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Mega' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Mega', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Up to 750 videos per month; $999 billed yearly', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AI/ML API — API
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aimlapi.com' OR LOWER(`name`) = LOWER('AI/ML API'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AI/ML API', NULL, 'https://aimlapi.com', NULL, NULL, 'Єдиний API для понад тисячі AI-моделей: текст і міркування, зображення, відео, аудіо, голос, пошук і вбудовування — з одним рахунком, пісочницею та підключенням через MCP до Claude, Cursor та інших агентів.', 'One API for 1,000+ AI models: text and reasoning, images, video, audio, voice, search and embeddings, with one bill, a playground and MCP connection to Claude, Cursor and other agents.', 'AI/ML API дає розробникам доступ до великої кількості моделей різних постачальників через один API-ключ і один рахунок. Підтримуються чат-моделі й моделі міркування, генерація зображень і відео, аудіо та голос, пошук, вбудовування та інші типи задач. Сервіс сумісний із популярними агентами: його можна підключити як MCP-сервер у Claude, Claude Code, Cursor та інших клієнтах. На сайті є пісочниця для тестування моделей і порівняння цін, швидкості й можливостей. Оплата залежить від використання.', 'AI/ML API gives developers access to a large number of models from different providers through one API key and one bill. Chat and reasoning models, image and video generation, audio and voice, search, embeddings and other task types are supported. The service works with popular agents: it can be connected as an MCP server in Claude, Claude Code, Cursor and other clients. The site has a playground for testing models and comparing price, speed and capabilities. Pricing is usage-based.', 'Понад 1000 моделей через один API
Текст, зображення, відео, аудіо й голос
Один рахунок за всіх постачальників
MCP для Claude, Cursor та інших агентів
Пісочниця для тестування
Порівняння цін і швидкості моделей', '1,000+ models through one API
Text, images, video, audio and voice
One bill for all providers
MCP for Claude, Cursor and other agents
Playground for testing
Model price and speed comparison', 'Розробники й стартапи, яким потрібен доступ до багатьох моделей без окремих договорів.', 'Developers and startups that need many models without separate contracts.', 'web', 'course', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aimlapi.com' OR LOWER(`name`) = LOWER('AI/ML API')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' AND s.`name` = 'API' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'One API for 1,000+ AI models: text and reasoning, images, video, audio, voice, search and embeddings, with one bill, a playground and MCP connection to Claude, Cursor and other agents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'AI/ML API gives developers access to a large number of models from different providers through one API key and one bill. Chat and reasoning models, image and video generation, audio and voice, search, embeddings and other task types are supported. The service works with popular agents: it can be connected as an MCP server in Claude, Claude Code, Cursor and other clients. The site has a playground for testing models and comparing price, speed and capabilities. Pricing is usage-based.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '1,000+ models through one API
Text, images, video, audio and voice
One bill for all providers
MCP for Claude, Cursor and other agents
Playground for testing
Model price and speed comparison', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and startups that need many models without separate contracts.', 'manual' FROM DUAL WHERE @new = 1;

-- Aicut — Генерація відео
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aicut.pro' OR LOWER(`name`) = LOWER('Aicut'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Aicut', NULL, 'https://aicut.pro', NULL, NULL, 'AI-генератор відео для каналів без обличчя автора: обираєте формат, що зараз популярний, пишете один рядок — і отримуєте готовий епізод з озвученням, субтитрами й автопублікацією в YouTube, TikTok та Instagram.', 'An AI video generator for faceless channels: pick a format that is trending now, write one line and get a finished episode with voiceover, captions and auto-posting to YouTube, TikTok and Instagram.', 'Aicut допомагає вести канали з короткими AI-відео без зйомок і появи автора в кадрі. Сервіс показує добірку форматів, які зараз набирають перегляди, з оновленням щотижня; ви обираєте формат, пишете один рядок ідеї та отримуєте готовий епізод. Відео створюються з озвученням і субтитрами, а публікацію в YouTube, TikTok та Instagram можна запланувати автоматично. Усі дії оплачуються з єдиного балансу токенів, і вартість генерації видно до запуску. Платні плани включають щомісячні токени, а додаткові можна докупити пакетами, які не згорають. Реєстрація безкоштовна.', 'Aicut helps you run channels of short AI videos without filming or appearing on camera. The service shows a selection of formats currently gaining views, updated weekly; you pick a format, write one line of idea and get a finished episode. Videos come with voiceover and captions, and publishing to YouTube, TikTok and Instagram can be scheduled automatically. Every action is paid from one token balance, and the cost of a generation is shown before you start. Paid plans include monthly tokens, and extra tokens can be bought in packs that never expire. Sign-up is free.', 'Добірка популярних форматів відео
Епізод з одного рядка ідеї
Озвучення й субтитри
Автопублікація в YouTube, TikTok та Instagram
Вартість видно до генерації
Пакети токенів без терміну дії', 'Selection of trending video formats
An episode from one line of idea
Voiceover and captions
Auto-posting to YouTube, TikTok and Instagram
Cost shown before generation
Token packs that never expire', 'Автори коротких відео й власники каналів без обличчя автора.', 'Short-form video creators and owners of faceless channels.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aicut.pro' OR LOWER(`name`) = LOWER('Aicut')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Генерація відео' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' AND s.`name` = 'SMM' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI video generator for faceless channels: pick a format that is trending now, write one line and get a finished episode with voiceover, captions and auto-posting to YouTube, TikTok and Instagram.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Aicut helps you run channels of short AI videos without filming or appearing on camera. The service shows a selection of formats currently gaining views, updated weekly; you pick a format, write one line of idea and get a finished episode. Videos come with voiceover and captions, and publishing to YouTube, TikTok and Instagram can be scheduled automatically. Every action is paid from one token balance, and the cost of a generation is shown before you start. Paid plans include monthly tokens, and extra tokens can be bought in packs that never expire. Sign-up is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Selection of trending video formats
An episode from one line of idea
Voiceover and captions
Auto-posting to YouTube, TikTok and Instagram
Cost shown before generation
Token packs that never expire', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Short-form video creators and owners of faceless channels.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Creator', 'Creator', 19.00, 'month', 'Для старту, усі інструменти й автопублікація', 'For getting started, all tools and auto-posting' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Creator' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Creator', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For getting started, all tools and auto-posting', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ANDRE — Аналітика
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'andre.ai' OR LOWER(`name`) = LOWER('ANDRE'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ANDRE', NULL, 'https://andre.ai', NULL, NULL, 'AI-аналітик опитувань: перетворює дані опитувань клієнтів і відгуків на висновки, графіки й готові до показу слайди приблизно за 15 хвилин, без навичок аналізу даних.', 'An AI survey analyst: it turns customer survey and feedback data into insights, charts and presentation-ready slides in about 15 minutes, with no data skills needed.', 'ANDRE автоматизує аналіз опитувань клієнтського досвіду й відгуків. Ви завантажуєте файл з відповідями, а сервіс очищає дані, шукає закономірності, будує AI-графіки, пропонує формулювання висновків і готує практичні рекомендації. Результат оформлюється у звіт і презентаційні слайди, якими можна поділитися або завантажити. Тарифи відрізняються максимальним розміром файлу, кількістю звітів на місяць і рівнем підтримки; є безкоштовний пробний період.', 'ANDRE automates the analysis of customer experience surveys and feedback. You upload a file of responses and the service cleans the data, finds patterns, builds AI charts, suggests narratives and prepares actionable conclusions. The result is formatted as a report and presentation slides that can be shared or downloaded. Plans differ in maximum file size, number of reports per month and support level; there is a free trial.', 'Автоматичне очищення даних опитувань
Пошук закономірностей і висновків
AI-графіки
Готові слайди й звіти
Практичні рекомендації
Поширення й завантаження звітів', 'Automatic survey data cleaning
Pattern and insight discovery
AI charts
Ready slides and reports
Actionable recommendations
Report sharing and download', 'Маркетологи, CX-фахівці й продуктові команди, що проводять опитування клієнтів.', 'Marketers, CX specialists and product teams running customer surveys.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'andre.ai' OR LOWER(`name`) = LOWER('ANDRE')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'design-creative' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' AND s.`name` = 'Аналітика' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'design-creative' AND s.`name` = 'Звіти' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI survey analyst: it turns customer survey and feedback data into insights, charts and presentation-ready slides in about 15 minutes, with no data skills needed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ANDRE automates the analysis of customer experience surveys and feedback. You upload a file of responses and the service cleans the data, finds patterns, builds AI charts, suggests narratives and prepares actionable conclusions. The result is formatted as a report and presentation slides that can be shared or downloaded. Plans differ in maximum file size, number of reports per month and support level; there is a free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automatic survey data cleaning
Pattern and insight discovery
AI charts
Ready slides and reports
Actionable recommendations
Report sharing and download', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Marketers, CX specialists and product teams running customer surveys.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Startup', 'Startup', 945.00, 'month', 'Швидкі висновки для невеликих команд; пробний період', 'Fast insights for small teams; free trial' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Startup' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Startup', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Fast insights for small teams; free trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Scale-up', 'Scale-up', 2895.00, 'month', 'Для команд, що працюють у великому масштабі', 'For teams working at scale' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Scale-up' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Scale-up', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For teams working at scale', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'month', 'Повне рішення з підтримкою', 'Complete solution with support' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Complete solution with support', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Breadcrumb — Аналітика
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'breadcrumb.ai' OR LOWER(`name`) = LOWER('Breadcrumb'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Breadcrumb', NULL, 'https://breadcrumb.ai', NULL, NULL, 'Платформа звітів для спонсорства в спорті й розвагах: збирає результати кампаній у живий звіт для спонсора з оцінкою віддачі, щоб команди продажів могли продовжувати й розширювати партнерства.', 'A reporting platform for sports and entertainment sponsorship: it combines campaign results into a live sponsor recap with ROI estimates, so sales teams can renew and expand partnerships.', 'Breadcrumb допомагає спортивним клубам і розважальним організаціям доводити спонсорам цінність партнерства. Сервіс зводить в один звіт розрізнені дані: результати кампаній, активації, звіти підрядників і знання про клієнта. Звіт оновлюється в міру розвитку кампанії, показує оцінену медійну вартість і віддачу на вкладення, а спонсор може ставити запитання AI прямо в ньому. Такі звіти легко персоналізувати й повторювати для різних партнерів, а команда продажів отримує аргументи, щоб продовжити, розширити чи продати нове партнерство. Співпраця починається з демонстрації.', 'Breadcrumb helps sports teams and entertainment organizations prove the value of a partnership to sponsors. The service brings scattered data together in one recap: campaign results, activations, vendor reports and account knowledge. The recap updates as the campaign develops, shows estimated media value and return on investment, and the sponsor can ask the AI questions right inside it. Recaps are easy to personalize and repeat across partners, and the sales team gets the arguments to renew, expand or sell a new partnership. Engagement starts with a demo.', 'Живі звіти для спонсорів
Оцінка медійної вартості й віддачі
Об''єднання даних кампаній і активацій
Запитання до AI у звіті
Персоналізація під кожного партнера', 'Live sponsor recaps
Media value and ROI estimates
Combining campaign and activation data
Ask the AI inside the recap
Personalization per partner', 'Спортивні клуби, ліги й організатори подій, які працюють зі спонсорами.', 'Sports clubs, leagues and event organizers working with sponsors.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'breadcrumb.ai' OR LOWER(`name`) = LOWER('Breadcrumb')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' AND s.`name` = 'Аналітика' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' AND s.`name` = 'Продажі' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A reporting platform for sports and entertainment sponsorship: it combines campaign results into a live sponsor recap with ROI estimates, so sales teams can renew and expand partnerships.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Breadcrumb helps sports teams and entertainment organizations prove the value of a partnership to sponsors. The service brings scattered data together in one recap: campaign results, activations, vendor reports and account knowledge. The recap updates as the campaign develops, shows estimated media value and return on investment, and the sponsor can ask the AI questions right inside it. Recaps are easy to personalize and repeat across partners, and the sales team gets the arguments to renew, expand or sell a new partnership. Engagement starts with a demo.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live sponsor recaps
Media value and ROI estimates
Combining campaign and activation data
Ask the AI inside the recap
Personalization per partner', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sports clubs, leagues and event organizers working with sponsors.', 'manual' FROM DUAL WHERE @new = 1;

-- HeadSnap — Фотографія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'headsnap.io' OR LOWER(`name`) = LOWER('HeadSnap'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HeadSnap', NULL, 'https://headsnap.io', NULL, NULL, 'AI-генератор ділових фото для профілю: з чотирьох селфі приблизно за 20 хвилин створює десятки студійних портретів для LinkedIn, резюме, соцмереж і сайтів знайомств без фотосесії.', 'An AI headshot generator: from four selfies it creates dozens of studio-quality portraits in about 20 minutes for LinkedIn, resumes, social media and dating profiles, with no photoshoot.', 'HeadSnap дозволяє отримати якісні фото для профілю без дорогої фотосесії. Ви обираєте один із понад 15 типів фото — від ділових портретів до знімків для соцмереж чи сайтів знайомств — і завантажуєте щонайменше чотири якісні селфі: обличчям до камери, одна людина в кадрі, без окулярів і головних уборів. Приблизно за 20 хвилин сервіс навчає модель на вашому обличчі й надсилає готові фото на пошту. Окремий режим дозволяє за текстовим описом розмістити себе в іншій сцені. Пакети оплачуються разово, без підписки; найбільший пакет включає комерційну ліцензію, а для агенцій є підписка.', 'HeadSnap lets you get quality profile photos without an expensive photoshoot. You choose one of more than 15 photo types, from business headshots to shots for social media or dating sites, and upload at least four quality selfies: facing the camera, one person in frame, no glasses or hats. In about 20 minutes the service trains a model on your face and emails you the finished photos. A separate mode lets you place yourself in another scene from a text description. Packs are paid once with no subscription; the largest pack includes a commercial license, and agencies can subscribe.', 'Ділові портрети з 4 селфі
Понад 15 типів фото
Готово приблизно за 20 хвилин
Фото в будь-якій сцені за описом
Разова оплата без підписки
Комерційна ліцензія в найбільшому пакеті', 'Business portraits from 4 selfies
15+ photo types
Ready in about 20 minutes
Photos in any scene from a description
One-time payment, no subscription
Commercial license in the largest pack', 'Фахівці, шукачі роботи й усі, кому потрібні якісні фото для профілю.', 'Professionals, job seekers and anyone who needs quality profile photos.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'headsnap.io' OR LOWER(`name`) = LOWER('HeadSnap')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Фотографія' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Генерація зображень' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI headshot generator: from four selfies it creates dozens of studio-quality portraits in about 20 minutes for LinkedIn, resumes, social media and dating profiles, with no photoshoot.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'HeadSnap lets you get quality profile photos without an expensive photoshoot. You choose one of more than 15 photo types, from business headshots to shots for social media or dating sites, and upload at least four quality selfies: facing the camera, one person in frame, no glasses or hats. In about 20 minutes the service trains a model on your face and emails you the finished photos. A separate mode lets you place yourself in another scene from a text description. Packs are paid once with no subscription; the largest pack includes a commercial license, and agencies can subscribe.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Business portraits from 4 selfies
15+ photo types
Ready in about 20 minutes
Photos in any scene from a description
One-time payment, no subscription
Commercial license in the largest pack', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Professionals, job seekers and anyone who needs quality profile photos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Novice', 'Novice', 18.00, 'one_time', '35 AI-портретів', '35 AI headshots' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Novice' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Novice', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '35 AI headshots', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Proficient', 'Proficient', 25.00, 'one_time', '70 портретів, пріоритетна обробка', '70 headshots, priority processing' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Proficient' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Proficient', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '70 headshots, priority processing', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ultimate', 'Ultimate', 30.00, 'one_time', 'Понад 100 портретів, усі стилі, комерційна ліцензія', '100+ headshots, all styles, commercial license' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ultimate' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Ultimate', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '100+ headshots, all styles, commercial license', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'AI Jedi', 'AI Jedi', 35.00, 'month', 'Для активних користувачів і агенцій; $200 при оплаті за рік', 'For power users and agencies; $200 billed yearly' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'AI Jedi' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'AI Jedi', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For power users and agencies; $200 billed yearly', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hedy — AI-асистенти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hedy.ai' OR LOWER(`name`) = LOWER('Hedy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hedy', NULL, 'https://hedy.ai', NULL, NULL, 'AI-помічник для зустрічей, що підказує в реальному часі, а не після розмови: слухає зустріч на вашому пристрої без бота в дзвінку, пропонує, що сказати, робить нотатки, підсумки й пам''ятає попередні сесії.', 'An AI meeting assistant that coaches you in real time rather than after the call: it listens on your device with no bot in the call, suggests what to say, takes notes and summaries, and remembers past sessions.', 'Hedy допомагає почуватися впевнено на зустрічах, співбесідах і переговорах. Застосунок слухає розмову безпосередньо на вашому пристрої — жоден бот не приєднується до дзвінка — і в реальному часі підказує, що сказати, пропонує відповіді, підсумки й наступні кроки. Розмови розшифровуються понад 30 мовами, після них зберігаються нотатки й підсумки. Hedy пам''ятає попередні сесії, тож можна поставити запитання про будь-яку минулу зустріч чи підготуватися до наступної з урахуванням усього контексту. На платному тарифі доступні необмежена тривалість, імпорт і розшифровка старих записів, організація й чат між сесіями, а також інтеграції із Zapier, Make та API. Безкоштовно — кілька годин на місяць; є довічна ліцензія.', 'Hedy helps you feel confident in meetings, interviews and negotiations. The app listens to the conversation right on your device, with no bot joining the call, and suggests in real time what to say, offering replies, summaries and next steps. Conversations are transcribed in more than 30 languages, and notes and summaries are saved afterwards. Hedy remembers past sessions, so you can ask about any previous meeting or prepare for the next one with full context. The paid plan adds unlimited length, import and transcription of old recordings, organization and chat across sessions, plus Zapier, Make and API integrations. A few hours a month are free; a lifetime license is available.', 'Підказки в реальному часі під час зустрічі
Без бота в дзвінку, запис на пристрої
Розшифровка понад 30 мовами
Нотатки, підсумки й наступні кроки
Пам''ять про попередні сесії
Імпорт старих записів
Zapier, Make та API', 'Real-time suggestions during the meeting
No bot in the call, recording on device
Transcription in 30+ languages
Notes, summaries and next steps
Memory of past sessions
Import of old recordings
Zapier, Make and API', 'Менеджери, продажники, консультанти й усі, хто багато спілкується на зустрічах.', 'Managers, salespeople, consultants and anyone who spends a lot of time in meetings.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hedy.ai' OR LOWER(`name`) = LOWER('Hedy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'productivity' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'productivity' AND s.`name` = 'AI-асистенти' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Транскрипція' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI meeting assistant that coaches you in real time rather than after the call: it listens on your device with no bot in the call, suggests what to say, takes notes and summaries, and remembers past sessions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hedy helps you feel confident in meetings, interviews and negotiations. The app listens to the conversation right on your device, with no bot joining the call, and suggests in real time what to say, offering replies, summaries and next steps. Conversations are transcribed in more than 30 languages, and notes and summaries are saved afterwards. Hedy remembers past sessions, so you can ask about any previous meeting or prepare for the next one with full context. The paid plan adds unlimited length, import and transcription of old recordings, organization and chat across sessions, plus Zapier, Make and API integrations. A few hours a month are free; a lifetime license is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time suggestions during the meeting
No bot in the call, recording on device
Transcription in 30+ languages
Notes, summaries and next steps
Memory of past sessions
Import of old recordings
Zapier, Make and API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Managers, salespeople, consultants and anyone who spends a lot of time in meetings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'До 5 годин на місяць', 'Up to 5 hours per month' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Up to 5 hours per month', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 12.99, 'month', 'Необмежені сесії, імпорт записів, інтеграції; $99.99 при оплаті за рік', 'Unlimited sessions, recording import, integrations; $99.99 billed yearly' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Unlimited sessions, recording import, integrations; $99.99 billed yearly', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Lifetime', 'Lifetime', 299.00, 'one_time', 'Довічний доступ', 'Lifetime access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Lifetime' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Lifetime', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Lifetime access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- illustration.app — Графічний дизайн
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'illustration.app' OR LOWER(`name`) = LOWER('illustration.app'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'illustration.app', NULL, 'https://illustration.app', NULL, NULL, 'AI-генератор ілюстрацій замість стокових картинок: створює власні узгоджені векторні ілюстрації в одному стилі для сайтів, застосунків і маркетингу, а також автоматично замінює іконки в презентаціях PowerPoint.', 'An AI illustration generator to replace stock images: it creates your own consistent vector illustrations in one style for websites, apps and marketing, and automatically replaces icons in PowerPoint decks.', 'illustration.app дозволяє за секунди створювати власні ілюстрації замість стокових. Ви описуєте, що потрібно, і отримуєте масштабовану векторну графіку, яку можна редагувати й використовувати на сайтах, у застосунках і маркетингових матеріалах; стиль лишається узгодженим між усіма зображеннями. Окрема функція працює з презентаціями: завантажте файл PowerPoint, оберіть слайди й іконки, які треба замінити, — і сервіс підставить ілюстрації у вашому стилі точно в розмір наявних блоків, після чого можна завантажити оновлену презентацію. Оплата відбувається кредитами за кожне зображення; працювати можна через кабінет або через MCP.', 'illustration.app lets you create your own illustrations in seconds instead of using stock images. You describe what you need and get scalable vector graphics you can edit and use on websites, in apps and in marketing materials; the style stays consistent across all images. A separate feature works with presentations: upload a PowerPoint file, choose the slides and icons to replace, and the service inserts illustrations in your style exactly in the size of the existing boxes, after which you can download the updated deck. You pay credits per image; you can work through the dashboard or via MCP.', 'Власні векторні ілюстрації з опису
Узгоджений стиль між зображеннями
Редагована масштабована графіка
Заміна іконок у презентаціях PowerPoint
Збереження розмірів блоків на слайдах
Робота через кабінет або MCP', 'Custom vector illustrations from a description
Consistent style across images
Editable scalable graphics
Icon replacement in PowerPoint decks
Preserves box sizes on slides
Works via dashboard or MCP', 'Дизайнери, маркетологи й команди, яким потрібні власні ілюстрації без ілюстратора.', 'Designers, marketers and teams who need custom illustrations without an illustrator.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'illustration.app' OR LOWER(`name`) = LOWER('illustration.app')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'design-creative' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'design-creative' AND s.`name` = 'Графічний дизайн' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Генерація зображень' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI illustration generator to replace stock images: it creates your own consistent vector illustrations in one style for websites, apps and marketing, and automatically replaces icons in PowerPoint decks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'illustration.app lets you create your own illustrations in seconds instead of using stock images. You describe what you need and get scalable vector graphics you can edit and use on websites, in apps and in marketing materials; the style stays consistent across all images. A separate feature works with presentations: upload a PowerPoint file, choose the slides and icons to replace, and the service inserts illustrations in your style exactly in the size of the existing boxes, after which you can download the updated deck. You pay credits per image; you can work through the dashboard or via MCP.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Custom vector illustrations from a description
Consistent style across images
Editable scalable graphics
Icon replacement in PowerPoint decks
Preserves box sizes on slides
Works via dashboard or MCP', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Designers, marketers and teams who need custom illustrations without an illustrator.', 'manual' FROM DUAL WHERE @new = 1;

-- imagetocaption.ai — SMM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'imagetocaption.ai' OR LOWER(`name`) = LOWER('imagetocaption.ai'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'imagetocaption.ai', NULL, 'https://imagetocaption.ai', NULL, NULL, 'AI-генератор підписів для соцмереж: за зображенням, каруселлю чи Reels пише підпис і хештеги у вашому фірмовому стилі для Instagram, TikTok, LinkedIn і Facebook.', 'An AI social media caption generator: from an image, carousel or Reel it writes a caption and hashtags in your brand voice for Instagram, TikTok, LinkedIn and Facebook.', 'imagetocaption.ai допомагає не витрачати час на вигадування підписів до публікацій. Спершу ви задаєте фірмовий стиль: вставляєте рекомендації бренду або посилання на попередні дописи, і сервіс підлаштовується під ваш тон. Потім додаєте фото, каруселі чи Reels будь-якої роздільної здатності без обмеження кількості, а AI за кілька секунд пише підпис із хештегами. Його можна скопіювати, підправити або опублікувати в один клік. Сервісом користуються автори контенту, агенції й малий бізнес. Є 10-денний безкоштовний пробний період без картки.', 'imagetocaption.ai helps you stop spending time coming up with captions. First you set your brand voice: paste brand guidelines or link to past posts, and the service matches your tone. Then you add photos, carousels or Reels of any resolution with no upload limit, and the AI writes a caption with hashtags in seconds. You can copy it, tweak it or publish in one click. The service is used by content creators, agencies and small businesses. There is a 10-day free trial with no card.', 'Підписи за зображенням чи відео
Ваш фірмовий стиль у кожному дописі
Хештеги
Instagram, TikTok, LinkedIn і Facebook
Необмежене завантаження медіа
Публікація в один клік', 'Captions from an image or video
Your brand voice in every post
Hashtags
Instagram, TikTok, LinkedIn and Facebook
Unlimited media uploads
One-click publishing', 'Автори контенту, SMM-агенції й малий бізнес.', 'Content creators, social media agencies and small businesses.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'imagetocaption.ai' OR LOWER(`name`) = LOWER('imagetocaption.ai')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' AND s.`name` = 'SMM' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' AND s.`name` = 'Копірайтинг' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI social media caption generator: from an image, carousel or Reel it writes a caption and hashtags in your brand voice for Instagram, TikTok, LinkedIn and Facebook.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'imagetocaption.ai helps you stop spending time coming up with captions. First you set your brand voice: paste brand guidelines or link to past posts, and the service matches your tone. Then you add photos, carousels or Reels of any resolution with no upload limit, and the AI writes a caption with hashtags in seconds. You can copy it, tweak it or publish in one click. The service is used by content creators, agencies and small businesses. There is a 10-day free trial with no card.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Captions from an image or video
Your brand voice in every post
Hashtags
Instagram, TikTok, LinkedIn and Facebook
Unlimited media uploads
One-click publishing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Content creators, social media agencies and small businesses.', 'manual' FROM DUAL WHERE @new = 1;

-- insMind — Генерація відео
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'insmind.com' OR LOWER(`name`) = LOWER('insMind'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'insMind', NULL, 'https://insmind.com', NULL, NULL, 'AI-платформа маркетингового контенту: агент планує, створює й доопрацьовує відео, зображення й рекламу з ідеї, фото чи відео, а також пропонує інструменти редагування — видалення фону, розширення кадру, покращення.', 'An AI marketing content platform: an agent plans, creates and refines videos, images and ads from an idea, photo or video, plus editing tools such as background removal, image extension and enhancement.', 'insMind допомагає перетворювати ідеї на готовий маркетинговий контент. Почати можна з ідеї, зображення чи відео, а AI-агент планує, створює й доопрацьовує результат і зберігає персонажів і товари, щоб наступні матеріали були швидшими й узгодженими. Доступні довгі відео й історії бренду з постійними персонажами, сценами, голосом і музикою, трендові ролики для соцмереж, відео з аватарами-ведучими, озвученням і субтитрами, відео товарів, рекламні й лайфстайл-зображення. Для редагування є AI-фони, видалення фону, розширення меж зображення, покращення якості та інші інструменти. Є мобільний застосунок; оплата щомісячна, річна або разова.', 'insMind helps turn ideas into ready marketing content. You can start with an idea, image or video, and the AI agent plans, creates and refines the result and saves characters and products so later materials are faster and consistent. Available are long-form videos and brand stories with consistent characters, scenes, voice and music, trend-based social videos, presenter videos with avatars, voiceover and captions, product videos, and ad and lifestyle images. For editing there are AI backgrounds, background removal, image extension, quality enhancement and other tools. There is a mobile app; billing is monthly, yearly or one-time.', 'AI-агент для маркетингового контенту
Збереження персонажів і товарів
Довгі відео з узгодженими сценами
Відео з аватарами, озвученням і субтитрами
Відео товарів і рекламні зображення
Видалення фону й розширення кадру
Мобільний застосунок', 'AI agent for marketing content
Saving characters and products
Long videos with consistent scenes
Videos with avatars, voiceover and captions
Product videos and ad images
Background removal and image extension
Mobile app', 'Маркетологи, інтернет-магазини й автори контенту.', 'Marketers, online stores and content creators.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'insmind.com' OR LOWER(`name`) = LOWER('insMind')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Генерація відео' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Фотографія' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' AND s.`name` = 'SMM' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI marketing content platform: an agent plans, creates and refines videos, images and ads from an idea, photo or video, plus editing tools such as background removal, image extension and enhancement.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'insMind helps turn ideas into ready marketing content. You can start with an idea, image or video, and the AI agent plans, creates and refines the result and saves characters and products so later materials are faster and consistent. Available are long-form videos and brand stories with consistent characters, scenes, voice and music, trend-based social videos, presenter videos with avatars, voiceover and captions, product videos, and ad and lifestyle images. For editing there are AI backgrounds, background removal, image extension, quality enhancement and other tools. There is a mobile app; billing is monthly, yearly or one-time.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI agent for marketing content
Saving characters and products
Long videos with consistent scenes
Videos with avatars, voiceover and captions
Product videos and ad images
Background removal and image extension
Mobile app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Marketers, online stores and content creators.', 'manual' FROM DUAL WHERE @new = 1;

-- Instafill — Документи
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'instafill.ai' OR LOWER(`name`) = LOWER('Instafill'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Instafill', NULL, 'https://instafill.ai', NULL, NULL, 'AI-заповнювач форм: завантажте будь-яку PDF- чи Word-форму, і сервіс прочитає кожне поле, підставить відповіді з наявних у вас документів і поверне заповнений PDF.', 'An AI form filler: upload any PDF or Word form and the service reads every field, fills in answers from documents you already have, and returns a completed PDF.', 'Instafill бере на себе паперову роботу з формами. Ви завантажуєте PDF або документ Word, а сервіс розпізнає всі поля, бере відповіді з інформації, яку ви вже маєте, і повертає заповнену форму у PDF. Це зручно для анкет, заявок, договорів і звітних форм, які доводиться заповнювати регулярно. Компанії використовують Instafill для автоматизації типових заявок, наприклад на компенсації чи оцінку нерухомості. Сервіс зазначає, що дані користувачів не використовуються для навчання AI-моделей. Вхід через Google або пошту.', 'Instafill takes the paperwork of forms off your hands. You upload a PDF or Word document, and the service detects every field, takes answers from information you already have and returns the completed form as a PDF. It is handy for questionnaires, applications, contracts and reporting forms you have to fill in regularly. Companies use Instafill to automate standard applications, for example for rebates or property valuations. The service states that user data is not used to train AI models. Sign in with Google or email.', 'Автоматичне заповнення PDF-форм
Підтримка документів Word
Відповіді з ваших наявних даних
Готовий заповнений PDF
Дані не використовуються для навчання AI', 'Automatic PDF form filling
Word document support
Answers from your existing data
Completed PDF
Data not used to train AI', 'Фахівці й компанії, які регулярно заповнюють типові форми й заявки.', 'Professionals and companies that regularly fill in standard forms and applications.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'instafill.ai' OR LOWER(`name`) = LOWER('Instafill')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'finance-legal' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'finance-legal' AND s.`name` = 'Документи' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' AND s.`name` = 'Автоматизація' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI form filler: upload any PDF or Word form and the service reads every field, fills in answers from documents you already have, and returns a completed PDF.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Instafill takes the paperwork of forms off your hands. You upload a PDF or Word document, and the service detects every field, takes answers from information you already have and returns the completed form as a PDF. It is handy for questionnaires, applications, contracts and reporting forms you have to fill in regularly. Companies use Instafill to automate standard applications, for example for rebates or property valuations. The service states that user data is not used to train AI models. Sign in with Google or email.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automatic PDF form filling
Word document support
Answers from your existing data
Completed PDF
Data not used to train AI', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Professionals and companies that regularly fill in standard forms and applications.', 'manual' FROM DUAL WHERE @new = 1;

-- Keragon — Автоматизація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'keragon.com' OR LOWER(`name`) = LOWER('Keragon'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Keragon', NULL, 'https://keragon.com', NULL, NULL, 'Платформа автоматизації для медичних закладів із дотриманням HIPAA: опишіть процес звичайною мовою, і Keragon збудує й запустить його у вашій медичній системі та понад 400 сервісах — реєстрація пацієнтів, нагадування, перевірка страховки.', 'A HIPAA-compliant automation platform for healthcare: describe a workflow in plain language and Keragon builds and runs it across your EHR and 400+ tools, from patient intake to reminders and insurance checks.', 'Keragon автоматизує адміністративну роботу клінік і медичних компаній без коду. Процес описується звичайною мовою, а платформа сама будує й запускає його, з''єднуючи електронну медичну систему з понад 400 інструментами галузі. Типові сценарії — надсилання анкет і створення картки при записі нового пацієнта, персональні нагадування про візит текстом, поштою чи голосом з підтвердженням, перевірка страхового покриття перед кожним візитом, повторний запис пацієнтів, які пропустили прийом, і підготовка до майбутніх візитів. Також доступні AI-агенти для операційної роботи. Платформа відповідає вимогам HIPAA. Оплата залежить від кількості запусків процесів і кредитів агентів; є 14-денний безкоштовний пробний період.', 'Keragon automates administrative work for clinics and healthcare companies without code. You describe a workflow in plain language, and the platform builds and runs it, connecting your electronic health record with more than 400 industry tools. Typical scenarios include sending intake forms and creating a record when a new patient books, personalized visit reminders by text, email or voice with confirmation, checking insurance coverage before every visit, rebooking patients who missed an appointment, and preparing for upcoming visits. AI agents for operations are also available. The platform is HIPAA compliant. Pricing depends on workflow runs and agent credits; there is a 14-day free trial.', 'Автоматизація процесів звичайною мовою
Понад 400 медичних інтеграцій
Реєстрація пацієнтів і анкети
Нагадування про візити
Перевірка страхового покриття
AI-агенти для операційної роботи
Відповідність HIPAA', 'Workflow automation in plain language
400+ healthcare integrations
Patient intake and forms
Visit reminders
Insurance eligibility checks
AI agents for operations
HIPAA compliance', 'Приватні практики, клініки й медичні компанії (насамперед у США).', 'Private practices, clinics and healthcare companies (mainly in the US).', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'keragon.com' OR LOWER(`name`) = LOWER('Keragon')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'health-beauty' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' AND s.`name` = 'Автоматизація' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'health-beauty' AND s.`name` = 'Медицина' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A HIPAA-compliant automation platform for healthcare: describe a workflow in plain language and Keragon builds and runs it across your EHR and 400+ tools, from patient intake to reminders and insurance checks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Keragon automates administrative work for clinics and healthcare companies without code. You describe a workflow in plain language, and the platform builds and runs it, connecting your electronic health record with more than 400 industry tools. Typical scenarios include sending intake forms and creating a record when a new patient books, personalized visit reminders by text, email or voice with confirmation, checking insurance coverage before every visit, rebooking patients who missed an appointment, and preparing for upcoming visits. AI agents for operations are also available. The platform is HIPAA compliant. Pricing depends on workflow runs and agent credits; there is a 14-day free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Workflow automation in plain language
400+ healthcare integrations
Patient intake and forms
Visit reminders
Insurance eligibility checks
AI agents for operations
HIPAA compliance', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Private practices, clinics and healthcare companies (mainly in the US).', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Starter', 'Starter', 149.00, 'month', '200 запусків процесів і 5 000 кредитів агентів на місяць; 14 днів безкоштовно', '200 workflow runs and 5,000 agent credits per month; 14 days free' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Starter' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Starter', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '200 workflow runs and 5,000 agent credits per month; 14 days free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kopage — Конструктори сайтів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kopage.com' OR LOWER(`name`) = LOWER('Kopage'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kopage', NULL, 'https://kopage.com', NULL, NULL, 'AI-конструктор сайтів під власним брендом для фрилансерів і агенцій: генерує готовий сайт для клієнта за описом, а далі дає SEO-інструменти, блог, інтернет-магазин і підключення доменів.', 'A white-label AI website builder for freelancers and agencies: it generates a ready website for a client from a description, then provides SEO tools, a blog, an online store and custom domains.', 'Kopage допомагає створювати й продавати сайти для місцевого бізнесу під власним брендом. Достатньо описати, про що сайт, і AI за кілька секунд згенерує повноцінну стартову версію, яку можна редагувати в інтуїтивному редакторі. Після запуску доступні SEO-налаштування, блог, інтернет-магазин та інші функції. Режим white label дозволяє показувати клієнтам платформу як вашу власну. Тарифи відрізняються кількістю активних сайтів і AI-токенів; підключення власних доменів доступне на всіх планах. Почати можна безкоштовно без картки.', 'Kopage helps you build and sell websites for local businesses under your own brand. Just describe what the site is about and the AI generates a full starter version in seconds, which you can edit in an intuitive editor. After launch, SEO settings, a blog, an online store and other features are available. White-label mode lets you present the platform to clients as your own. Plans differ in the number of active sites and AI tokens; custom domains are available on all plans. You can start for free with no card.', 'Сайт для клієнта за описом
Робота під вашим брендом (white label)
Інтуїтивний редактор
SEO-інструменти й блог
Інтернет-магазин
Власні домени', 'A client website from a description
Works under your brand (white label)
Intuitive editor
SEO tools and blog
Online store
Custom domains', 'Фрилансери й веб-агенції, які роблять сайти для малого бізнесу.', 'Freelancers and web agencies building websites for small businesses.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kopage.com' OR LOWER(`name`) = LOWER('Kopage')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' AND s.`name` = 'Конструктори сайтів' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A white-label AI website builder for freelancers and agencies: it generates a ready website for a client from a description, then provides SEO tools, a blog, an online store and custom domains.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Kopage helps you build and sell websites for local businesses under your own brand. Just describe what the site is about and the AI generates a full starter version in seconds, which you can edit in an intuitive editor. After launch, SEO settings, a blog, an online store and other features are available. White-label mode lets you present the platform to clients as your own. Plans differ in the number of active sites and AI tokens; custom domains are available on all plans. You can start for free with no card.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'A client website from a description
Works under your brand (white label)
Intuitive editor
SEO tools and blog
Online store
Custom domains', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Freelancers and web agencies building websites for small businesses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Solo', 'Solo', 49.00, 'month', '5 активних сайтів, white label, 10K AI-токенів', '5 active websites, white label, 10K AI tokens' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Solo' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Solo', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '5 active websites, white label, 10K AI tokens', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 149.00, 'month', '25 активних сайтів для клієнтів', '25 active client websites' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '25 active client websites', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- LaunchLemonade — AI-агенти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'launchlemonade.app' OR LOWER(`name`) = LOWER('LaunchLemonade'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LaunchLemonade', NULL, 'https://launchlemonade.app', NULL, NULL, 'Платформа для створення AI-асистентів без коду: опишіть завдання, оберіть будь-яку модель і додайте свої знання — асистентом можна користуватися самому, ділитися з командою, вбудовувати на сайт чи продавати в магазині.', 'A no-code platform for building AI assistants: describe the task, choose any model and add your knowledge, then use the assistant yourself, share it with your team, embed it on a site or sell it in the store.', 'LaunchLemonade дозволяє за кілька хвилин зібрати AI-асистента, який знає ваш бізнес. Ви описуєте роботу, обираєте будь-яку з десятків моделей від різних розробників і додаєте власні знання. Готовим асистентом можна користуватися самостійно, поділитися з командою, вбудувати на сайт або продавати в магазині агентів. Моделі можна перемикати посеред розмови чи отримати другу думку перед рішенням. Доступні голос, живі дашборди, запуски за розкладом, підключення ваших інструментів і журнал дій агента. Окремий помічник «керівник апарату» надсилає щоденні брифінги, розшифровує зустрічі й керує поштою та календарем. Дані зберігаються у Великій Британії, за замовчуванням приватні й не використовуються для навчання моделей. Є безкоштовний тариф.', 'LaunchLemonade lets you assemble an AI assistant that knows your business in minutes. You describe the work, choose any of dozens of models from different developers and add your own knowledge. The finished assistant can be used on your own, shared with your team, embedded on a website or sold in the agent store. You can switch models mid-chat or get a second opinion before acting. Voice, live dashboards, scheduled runs, connections to your tools and an agent activity trace are available. A separate chief-of-staff assistant sends daily briefings, transcribes meetings and manages email and calendar. Data is hosted in the UK, private by default and never used to train models. There is a free plan.', 'Асистенти без коду на будь-якій моделі
Власна база знань
Поширення в команді й вбудовування на сайт
Продаж асистентів у магазині
Голос, дашборди й запуски за розкладом
Щоденні брифінги, пошта й календар
Хостинг у Великій Британії', 'No-code assistants on any model
Your own knowledge base
Sharing with the team and embedding on a site
Selling assistants in the store
Voice, dashboards and scheduled runs
Daily briefings, email and calendar
UK hosting', 'Підприємці, консультанти й невеликі команди, які хочуть власних AI-асистентів.', 'Entrepreneurs, consultants and small teams who want their own AI assistants.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'launchlemonade.app' OR LOWER(`name`) = LOWER('LaunchLemonade')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' AND s.`name` = 'AI-агенти' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' AND s.`name` = 'Чат-боти' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A no-code platform for building AI assistants: describe the task, choose any model and add your knowledge, then use the assistant yourself, share it with your team, embed it on a site or sell it in the store.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LaunchLemonade lets you assemble an AI assistant that knows your business in minutes. You describe the work, choose any of dozens of models from different developers and add your own knowledge. The finished assistant can be used on your own, shared with your team, embedded on a website or sold in the agent store. You can switch models mid-chat or get a second opinion before acting. Voice, live dashboards, scheduled runs, connections to your tools and an agent activity trace are available. A separate chief-of-staff assistant sends daily briefings, transcribes meetings and manages email and calendar. Data is hosted in the UK, private by default and never used to train models. There is a free plan.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'No-code assistants on any model
Your own knowledge base
Sharing with the team and embedding on a site
Selling assistants in the store
Voice, dashboards and scheduled runs
Daily briefings, email and calendar
UK hosting', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Entrepreneurs, consultants and small teams who want their own AI assistants.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Щоденні безкоштовні чати з усіма моделями', 'Daily free chats across all models' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Daily free chats across all models', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 49.00, 'month', 'Усі моделі, пам''ять, необмежені власні агенти', 'All models, memory, unlimited custom agents' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'All models, memory, unlimited custom agents', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Lingolette — Переклад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lingolette.com' OR LOWER(`name`) = LOWER('Lingolette'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lingolette', NULL, 'https://lingolette.com', NULL, NULL, 'AI-тренажер для вивчення мов, що допомагає перейти з середнього рівня на просунутий: розмовна практика з AI-репетиторами різних діалектів, миттєві виправлення, слова в контексті й щоденні статті з запитаннями.', 'An AI language trainer that helps you move from intermediate to advanced: speaking practice with AI tutors in different dialects, instant corrections, words in context and daily articles with questions.', 'Lingolette допомагає подолати «плато» середнього рівня й заговорити вільно. Основа — голосові розмови з AI-репетитором на будь-яку цікаву вам тему, причому можна обрати репетиторів із різними діалектами. Під час практики ви отримуєте зрозумілі покрокові виправлення. Будь-яке слово можна натиснути, щоб побачити значення, почути вимову й додати його до словника. Щодня з''являються статті з запитаннями на розуміння, і їх можна обговорити з AI-репетитором. Підтримуються англійська, іспанська, німецька, японська, французька, китайська, корейська та ще близько двох десятків мов. Є веб-версія та мобільний застосунок, а також рішення для компаній.', 'Lingolette helps you break through the intermediate plateau and speak fluently. Its core is voice conversations with an AI tutor on any topic you like, and you can choose tutors with different dialects. During practice you get clear step-by-step corrections. Any word can be tapped to see its meaning, hear the pronunciation and add it to your dictionary. New articles with comprehension questions appear daily, and you can discuss them with the AI tutor. English, Spanish, German, Japanese, French, Mandarin, Korean and about two dozen more languages are supported. There is a web version and a mobile app, as well as an offering for companies.', 'Голосові розмови з AI-репетитором
Репетитори різних діалектів
Миттєві виправлення
Слова в контексті й особистий словник
Щоденні статті з запитаннями
Понад 25 мов
Мобільний застосунок', 'Voice conversations with an AI tutor
Tutors with different dialects
Instant corrections
Words in context and a personal dictionary
Daily articles with questions
25+ languages
Mobile app', 'Люди із середнім рівнем мови, які хочуть розмовляти вільно, а також компанії.', 'Intermediate learners who want to speak fluently, as well as companies.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lingolette.com' OR LOWER(`name`) = LOWER('Lingolette')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'translation-languages' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'education-knowledge' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'translation-languages' AND s.`name` = 'Переклад' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'education-knowledge' AND s.`name` = 'Репетиторство' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI language trainer that helps you move from intermediate to advanced: speaking practice with AI tutors in different dialects, instant corrections, words in context and daily articles with questions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Lingolette helps you break through the intermediate plateau and speak fluently. Its core is voice conversations with an AI tutor on any topic you like, and you can choose tutors with different dialects. During practice you get clear step-by-step corrections. Any word can be tapped to see its meaning, hear the pronunciation and add it to your dictionary. New articles with comprehension questions appear daily, and you can discuss them with the AI tutor. English, Spanish, German, Japanese, French, Mandarin, Korean and about two dozen more languages are supported. There is a web version and a mobile app, as well as an offering for companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Voice conversations with an AI tutor
Tutors with different dialects
Instant corrections
Words in context and a personal dictionary
Daily articles with questions
25+ languages
Mobile app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Intermediate learners who want to speak fluently, as well as companies.', 'manual' FROM DUAL WHERE @new = 1;

-- LTX Studio — Генерація відео
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ltx.io/studio' OR LOWER(`name`) = LOWER('LTX Studio'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LTX Studio', NULL, 'https://ltx.io/studio', NULL, NULL, 'Творча студія для AI-відеовиробництва від LTX: генерація відео й зображень власними моделями LTX, розкадровки, керування камерою, відео з аудіо, покращення до HDR і автоматизація на вузлах.', 'A creative studio for AI video production from LTX: video and image generation with LTX''s own models, storyboards, camera control, audio-to-video, HDR enhancement and node-based automation.', 'LTX Studio — платформа для кінематографістів, маркетологів і авторів контенту, побудована на власних відкритих моделях генерації відео компанії LTX. У студії можна створювати відео й зображення, працювати з розкадровками, точно керувати рухом камери, генерувати відео під аудіодоріжку, переносити рух і керувати персонажами у режимі «відео у відео», покращувати відео з SDR до HDR і будувати автоматизовані процеси на вузлах. Нові версії моделей стають доступними на всіх тарифах. Безкоштовно надається разовий пакет кредитів, а для компаній є корпоративні плани й пілотні проєкти. Окремо LTX публікує відкриті моделі й API для розробників.', 'LTX Studio is a platform for filmmakers, marketers and content creators built on LTX''s own open video generation models. In the studio you can create video and images, work with storyboards, precisely control camera motion, generate video to an audio track, transfer motion and control characters in video-to-video mode, enhance video from SDR to HDR and build automated node-based workflows. New model versions become available on all plans. A one-time pack of free credits is provided, and companies get enterprise plans and pilot projects. Separately, LTX publishes open models and an API for developers.', 'Генерація відео й зображень моделями LTX
Розкадровки
Керування камерою
Відео з аудіо
Покращення до HDR
Автоматизація на вузлах
API й відкриті моделі', 'Video and image generation with LTX models
Storyboards
Camera control
Audio-to-video
HDR enhancement
Node-based automation
API and open models', 'Кінематографісти, студії, маркетологи й автори відео.', 'Filmmakers, studios, marketers and video creators.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ltx.io/studio' OR LOWER(`name`) = LOWER('LTX Studio')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Генерація відео' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Відеомонтаж' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A creative studio for AI video production from LTX: video and image generation with LTX''s own models, storyboards, camera control, audio-to-video, HDR enhancement and node-based automation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LTX Studio is a platform for filmmakers, marketers and content creators built on LTX''s own open video generation models. In the studio you can create video and images, work with storyboards, precisely control camera motion, generate video to an audio track, transfer motion and control characters in video-to-video mode, enhance video from SDR to HDR and build automated node-based workflows. New model versions become available on all plans. A one-time pack of free credits is provided, and companies get enterprise plans and pilot projects. Separately, LTX publishes open models and an API for developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Video and image generation with LTX models
Storyboards
Camera control
Audio-to-video
HDR enhancement
Node-based automation
API and open models', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Filmmakers, studios, marketers and video creators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', '800 кредитів разово', '800 credits one-time' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '800 credits one-time', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Lyrics Into Song AI — Музика
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lyricsintosong.ai' OR LOWER(`name`) = LOWER('Lyrics Into Song AI'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lyrics Into Song AI', NULL, 'https://lyricsintosong.ai', NULL, NULL, 'AI-генератор пісень із тексту: перетворює ваші слова на повноцінну пісню з мелодією, гармонією й аранжуванням у вибраному жанрі, настрої та голосі; може й сам згенерувати текст.', 'An AI song generator from lyrics: it turns your words into a full song with melody, harmony and arrangement in a chosen genre, mood and voice, and can write the lyrics for you too.', 'Lyrics Into Song AI допомагає авторам пісень і музикантам почути свої тексти в музиці. Ви вводите назву, описуєте стиль — жанр, настрій, тип голосу, темп — і вставляєте слова, а сервіс створює завершену пісню з мелодією, гармонією й аранжуванням. Якщо тексту немає, його можна згенерувати, а також зробити інструментальну композицію. Доступні кілька моделей генерації. На платних тарифах можна переписати частину пісні зі зміненим текстом, створити кавер, подовжити трек, завантажити WAV і MIDI, видалити вокал, створити відео зі співом за фото й працювати в пріоритетній черзі. Спробувати можна безкоштовно без входу.', 'Lyrics Into Song AI helps songwriters and musicians hear their lyrics as music. You enter a title, describe the style, including genre, mood, voice type and tempo, and paste the lyrics, and the service creates a finished song with melody, harmony and arrangement. If you have no lyrics, they can be generated, and instrumental tracks are possible too. Several generation models are available. Paid plans let you rewrite part of a song with changed lyrics, make covers, extend tracks, download WAV and MIDI, remove vocals, create singing videos from a photo and use a priority queue. You can try it for free without logging in.', 'Пісня з вашого тексту
Вибір жанру, настрою, голосу й темпу
Генерація тексту пісні
Інструментальні треки
Заміна частини пісні й кавери
WAV і MIDI, видалення вокалу
Відео зі співом за фото', 'A song from your lyrics
Choice of genre, mood, voice and tempo
Lyric generation
Instrumental tracks
Section replacement and covers
WAV and MIDI, vocal removal
Singing video from a photo', 'Автори пісень, музиканти-аматори й автори контенту.', 'Songwriters, hobby musicians and content creators.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lyricsintosong.ai' OR LOWER(`name`) = LOWER('Lyrics Into Song AI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Музика' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI song generator from lyrics: it turns your words into a full song with melody, harmony and arrangement in a chosen genre, mood and voice, and can write the lyrics for you too.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Lyrics Into Song AI helps songwriters and musicians hear their lyrics as music. You enter a title, describe the style, including genre, mood, voice type and tempo, and paste the lyrics, and the service creates a finished song with melody, harmony and arrangement. If you have no lyrics, they can be generated, and instrumental tracks are possible too. Several generation models are available. Paid plans let you rewrite part of a song with changed lyrics, make covers, extend tracks, download WAV and MIDI, remove vocals, create singing videos from a photo and use a priority queue. You can try it for free without logging in.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'A song from your lyrics
Choice of genre, mood, voice and tempo
Lyric generation
Instrumental tracks
Section replacement and covers
WAV and MIDI, vocal removal
Singing video from a photo', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Songwriters, hobby musicians and content creators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Basic', 'Basic', 149.00, 'year', '250 пісень на місяць, WAV і MIDI, видалення вокалу', '250 songs per month, WAV and MIDI, vocal removal' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Basic' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Basic', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '250 songs per month, WAV and MIDI, vocal removal', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mammouth AI — Чат-боти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mammouth.ai' OR LOWER(`name`) = LOWER('Mammouth AI'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mammouth AI', NULL, 'https://mammouth.ai', NULL, NULL, 'Одна підписка на провідні AI-моделі різних розробників: чат-моделі, моделі міркування, веб-пошук і глибокі дослідження, генерація зображень і відео, проєкти, голосовий чат і кредити API для програмістів.', 'One subscription to leading AI models from different developers: chat and reasoning models, web search and deep research, image and video generation, projects, voice chat and API credits for coders.', 'Mammouth AI збирає в одному місці доступ до популярних мовних моделей від OpenAI, Anthropic, Google, Mistral, xAI та відкритих моделей, а також до моделей міркування, веб-пошуку й глибоких досліджень. Окрім тексту, можна генерувати зображення й відео кількома моделями. Зручна функція — повторно надіслати той самий запит іншій моделі в один клік, щоб порівняти відповіді. Є проєкти для впорядкування документів і чатів, робота з файлами й зображеннями, голосовий чат і диктування, а також інструменти для програмістів із включеними кредитами API. Сервіс працює на різних пристроях, обробляє дані згідно з GDPR і не використовує вміст користувачів для навчання моделей. Якщо ліміт вичерпано, лишається доступна легша модель.', 'Mammouth AI brings together access to popular language models from OpenAI, Anthropic, Google, Mistral, xAI and open models, as well as reasoning models, web search and deep research. Beyond text, you can generate images and video with several models. A handy feature resends the same prompt to another model in one click so you can compare answers. There are projects for organizing documents and chats, work with files and images, voice chat and dictation, and tools for coders with included API credits. The service works across devices, processes data under GDPR and does not use user content to train models. If you hit a limit, a lighter model remains available.', 'Провідні мовні моделі в одній підписці
Повторний запит іншій моделі в один клік
Веб-пошук і глибокі дослідження
Генерація зображень і відео
Проєкти, файли й голосовий чат
Кредити API для програмістів
Відповідність GDPR', 'Leading language models in one subscription
One-click re-prompting to another model
Web search and deep research
Image and video generation
Projects, files and voice chat
API credits for coders
GDPR compliance', 'Люди, які щодня користуються різними AI-моделями й хочуть заощадити на підписках.', 'People who use different AI models daily and want to save on subscriptions.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mammouth.ai' OR LOWER(`name`) = LOWER('Mammouth AI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'productivity' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' AND s.`name` = 'Чат-боти' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'productivity' AND s.`name` = 'AI-асистенти' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'One subscription to leading AI models from different developers: chat and reasoning models, web search and deep research, image and video generation, projects, voice chat and API credits for coders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Mammouth AI brings together access to popular language models from OpenAI, Anthropic, Google, Mistral, xAI and open models, as well as reasoning models, web search and deep research. Beyond text, you can generate images and video with several models. A handy feature resends the same prompt to another model in one click so you can compare answers. There are projects for organizing documents and chats, work with files and images, voice chat and dictation, and tools for coders with included API credits. The service works across devices, processes data under GDPR and does not use user content to train models. If you hit a limit, a lighter model remains available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Leading language models in one subscription
One-click re-prompting to another model
Web search and deep research
Image and video generation
Projects, files and voice chat
API credits for coders
GDPR compliance', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who use different AI models daily and want to save on subscriptions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Starter', 'Starter', 12.00, 'month', 'Для регулярного використання, включно з ПДВ', 'For regular use, VAT included' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Starter' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Starter', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For regular use, VAT included', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Standard', 'Standard', 24.00, 'month', 'Для інтенсивного використання, включно з ПДВ', 'For intensive use, VAT included' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Standard' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Standard', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For intensive use, VAT included', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Millis AI — Голосові агенти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'millis.ai' OR LOWER(`name`) = LOWER('Millis AI'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Millis AI', NULL, 'https://millis.ai', NULL, NULL, 'Платформа для створення голосових AI-агентів із дуже низькою затримкою відповіді: агентів можна зібрати без коду чи кількома рядками коду й підключити до телефонних номерів для вхідних і вихідних дзвінків.', 'A platform for building voice AI agents with very low response latency: build agents with no code or a few lines of code and connect them to phone numbers for inbound and outbound calls.', 'Millis AI допомагає розробникам і бізнесу створювати голосових агентів на основі мовних моделей, які відповідають майже без пауз, тож розмова звучить природно. Агента можна налаштувати звичайною мовою без коду або кількома рядками коду й запустити за лічені хвилини. Платформа дозволяє підключити телефонні номери для вхідних і вихідних дзвінків у понад сотні країн, а також швидко замінити застарілих голосових ботів на нових агентів. Підтримуються інтеграції з іншими сервісами. Є демонстрація, щоб послухати агента в дії.', 'Millis AI helps developers and businesses build voice agents on language models that respond almost without pauses, so the conversation sounds natural. An agent can be configured in plain language with no code or with a few lines of code and launched in minutes. The platform lets you connect phone numbers for inbound and outbound calls in more than a hundred countries and quickly replace legacy voice bots with new agents. Integrations with other services are supported. There is a demo to hear an agent in action.', 'Голосові агенти з низькою затримкою
Налаштування без коду або кодом
Телефонні номери у понад 100 країнах
Вхідні й вихідні дзвінки
Заміна застарілих голосових ботів
Інтеграції', 'Low-latency voice agents
No-code or code setup
Phone numbers in 100+ countries
Inbound and outbound calls
Replacing legacy voice bots
Integrations', 'Розробники й компанії, що будують голосових агентів для дзвінків.', 'Developers and companies building voice agents for calls.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'millis.ai' OR LOWER(`name`) = LOWER('Millis AI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' AND s.`name` = 'Голосові агенти' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' AND s.`name` = 'API' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A platform for building voice AI agents with very low response latency: build agents with no code or a few lines of code and connect them to phone numbers for inbound and outbound calls.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Millis AI helps developers and businesses build voice agents on language models that respond almost without pauses, so the conversation sounds natural. An agent can be configured in plain language with no code or with a few lines of code and launched in minutes. The platform lets you connect phone numbers for inbound and outbound calls in more than a hundred countries and quickly replace legacy voice bots with new agents. Integrations with other services are supported. There is a demo to hear an agent in action.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Low-latency voice agents
No-code or code setup
Phone numbers in 100+ countries
Inbound and outbound calls
Replacing legacy voice bots
Integrations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and companies building voice agents for calls.', 'manual' FROM DUAL WHERE @new = 1;

-- mixus — Юридичні послуги
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mixus.ai' OR LOWER(`name`) = LOWER('mixus'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'mixus', NULL, 'https://mixus.ai', NULL, NULL, 'AI-агенти для юридичних фірм, що працюють через електронну пошту й Word: юрист пересилає справу агенту, а той повертає правки, чернетки, аналіз і таблиці, які адвокати перевіряють і затверджують.', 'AI agents for law firms that work through email and Word: a lawyer forwards a matter to the agent, which returns redlines, drafts, analysis and spreadsheets that attorneys review and approve.', 'mixus побудований навколо того, як юристи вже працюють — у пошті та Word. Справу пересилають агенту листом і ставлять у копію тих, хто має перевірити результат; агент працює в тому самому ланцюжку листів. Назад повертаються готові до перевірки файли: правки з відстеженням змін, чернетки документів, аналіз і таблиці. Адвокати переглядають зміни, питання й посилання та затверджують результат, тож контроль залишається на рівні фірми. Сервіс навчається на рішеннях юристів — що прийнято, змінено чи відхилено — і формує робочі сценарії з попередніх угод і затверджених формулювань фірми. Співпраця починається з демонстрації.', 'mixus is built around how lawyers already work: in email and Word. A matter is forwarded to the agent by email with reviewers in CC; the agent works in the same thread. It returns reviewable files: tracked-change redlines, document drafts, analysis and spreadsheets. Attorneys review the changes, issues and citations and approve the result, so control stays at the firm level. The service learns from lawyers'' decisions about what is accepted, edited or dismissed, and builds playbooks from the firm''s prior deals and approved language. Engagement starts with a demo.', 'Завдання агенту електронною поштою
Робота в Word: правки й чернетки
Аналіз документів і таблиці
Затвердження результатів адвокатом
Навчання на рішеннях фірми
Сценарії з попередніх угод', 'Tasks to the agent by email
Work in Word: redlines and drafts
Document analysis and spreadsheets
Attorney approval of results
Learning from the firm''s decisions
Playbooks from prior deals', 'Юридичні фірми та юридичні відділи компаній.', 'Law firms and corporate legal departments.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mixus.ai' OR LOWER(`name`) = LOWER('mixus')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'finance-legal' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'finance-legal' AND s.`name` = 'Юридичні послуги' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' AND s.`name` = 'AI-агенти' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI agents for law firms that work through email and Word: a lawyer forwards a matter to the agent, which returns redlines, drafts, analysis and spreadsheets that attorneys review and approve.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'mixus is built around how lawyers already work: in email and Word. A matter is forwarded to the agent by email with reviewers in CC; the agent works in the same thread. It returns reviewable files: tracked-change redlines, document drafts, analysis and spreadsheets. Attorneys review the changes, issues and citations and approve the result, so control stays at the firm level. The service learns from lawyers'' decisions about what is accepted, edited or dismissed, and builds playbooks from the firm''s prior deals and approved language. Engagement starts with a demo.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tasks to the agent by email
Work in Word: redlines and drafts
Document analysis and spreadsheets
Attorney approval of results
Learning from the firm''s decisions
Playbooks from prior deals', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Law firms and corporate legal departments.', 'manual' FROM DUAL WHERE @new = 1;

-- NEUROFIT — Ментальне здоров'я
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'neurofit.app' OR LOWER(`name`) = LOWER('NEUROFIT'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NEUROFIT', NULL, 'https://neurofit.app', NULL, NULL, 'Мобільний застосунок для регуляції нервової системи: допомагає відстежувати стан, пропонує короткі тілесні (соматичні) вправи для зняття стресу та персонального AI-коуча.', 'A mobile app for nervous system regulation: it helps you track your state, offers short body-based (somatic) exercises for stress relief and a personal AI coach.', 'NEUROFIT спирається на ідею, що хронічний стрес живе не лише в думках, а й у тілі, тому основний акцент зроблено на тілесних вправах. Застосунок допомагає вимірювати стан нервової системи, пропонує короткі соматичні вправи для зняття напруги та персонального AI-коуча, який підказує, що робити далі. Ним користуються як звичайні люди, так і фахівці з охорони здоров''я та терапевти для своїх клієнтів. Також компанія пропонує SDK для розробників і довідкові матеріали про соматичні практики. Застосунок доступний для iOS і Android. Він не замінює консультацію лікаря чи психотерапевта.', 'NEUROFIT is based on the idea that chronic stress lives not only in thoughts but in the body, so its main focus is on body-based exercises. The app helps you measure the state of your nervous system, offers short somatic exercises to release tension and a personal AI coach that suggests what to do next. It is used both by individuals and by health professionals and therapists with their clients. The company also offers an SDK for developers and reference materials on somatic practices. The app is available for iOS and Android. It does not replace a doctor or therapist.', 'Відстеження стану нервової системи
Короткі соматичні вправи
Персональний AI-коуч
Використання фахівцями з клієнтами
SDK для розробників
iOS і Android', 'Nervous system state tracking
Short somatic exercises
Personal AI coach
Used by professionals with clients
SDK for developers
iOS and Android', 'Люди, які хочуть краще справлятися зі стресом, а також терапевти й фахівці з охорони здоров''я.', 'People who want to cope better with stress, as well as therapists and health professionals.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'neurofit.app' OR LOWER(`name`) = LOWER('NEUROFIT')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'health-beauty' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'health-beauty' AND s.`name` = 'Ментальне здоров''я' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A mobile app for nervous system regulation: it helps you track your state, offers short body-based (somatic) exercises for stress relief and a personal AI coach.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NEUROFIT is based on the idea that chronic stress lives not only in thoughts but in the body, so its main focus is on body-based exercises. The app helps you measure the state of your nervous system, offers short somatic exercises to release tension and a personal AI coach that suggests what to do next. It is used both by individuals and by health professionals and therapists with their clients. The company also offers an SDK for developers and reference materials on somatic practices. The app is available for iOS and Android. It does not replace a doctor or therapist.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Nervous system state tracking
Short somatic exercises
Personal AI coach
Used by professionals with clients
SDK for developers
iOS and Android', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to cope better with stress, as well as therapists and health professionals.', 'manual' FROM DUAL WHERE @new = 1;

-- NodeLand — Тести
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nodeland.io' OR LOWER(`name`) = LOWER('NodeLand'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NodeLand', NULL, 'https://nodeland.io', NULL, NULL, 'Інструменти для навчання: візуальні карти, щоб пов''язувати ідеї й бачити тему цілком, і картки для інтервального повторення, щоб краще запам''ятовувати вивчене.', 'Learning tools: visual maps to connect ideas and see a topic as a whole, and flashcards for spaced repetition to remember what you learn.', 'NodeLand пропонує два способи глибше розібратися в темі. Перший — полотно з візуальними картами: можна впорядковувати нотатки, досліджувати зв''язки між ідеями, додавати власний контекст і бачити всю тему одразу. Другий — картки для практики запам''ятовування з повторенням через проміжки часу. Інструменти можна поєднувати залежно від етапу навчання. Інтерфейс доступний англійською та португальською.', 'NodeLand offers two ways to get closer to a topic. The first is a canvas with visual maps: you can organize notes, explore relationships between ideas, add your own context and see the whole subject at once. The second is flashcards for practicing recall with repetition over time. The tools can be combined depending on your stage of learning. The interface is available in English and Portuguese.', 'Візуальні карти ідей
Пов''язані нотатки з контекстом
Картки для запам''ятовування
Повторення через проміжки часу
Англійська й португальська', 'Visual idea maps
Connected notes with context
Flashcards for recall
Spaced repetition
English and Portuguese', 'Студенти й усі, хто вчиться самостійно.', 'Students and self-learners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nodeland.io' OR LOWER(`name`) = LOWER('NodeLand')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'education-knowledge' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'productivity' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'education-knowledge' AND s.`name` = 'Тести' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'productivity' AND s.`name` = 'Дошки та діаграми' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Learning tools: visual maps to connect ideas and see a topic as a whole, and flashcards for spaced repetition to remember what you learn.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NodeLand offers two ways to get closer to a topic. The first is a canvas with visual maps: you can organize notes, explore relationships between ideas, add your own context and see the whole subject at once. The second is flashcards for practicing recall with repetition over time. The tools can be combined depending on your stage of learning. The interface is available in English and Portuguese.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Visual idea maps
Connected notes with context
Flashcards for recall
Spaced repetition
English and Portuguese', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students and self-learners.', 'manual' FROM DUAL WHERE @new = 1;

-- Nouswise — Дослідження та пошук
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nouswise.com' OR LOWER(`name`) = LOWER('Nouswise'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nouswise', NULL, 'https://nouswise.com', NULL, NULL, 'AI-агент для досліджень у регульованих галузях: відповідає на запитання за вашими джерелами знань із посиланням на кожне твердження, працює з шифруванням і може розгортатися у хмарі або локально.', 'An AI research agent for regulated industries: it answers questions from your knowledge sources with a citation for every claim, uses encryption and can be deployed in the cloud or on-premise.', 'Nouswise допомагає організаціям отримувати перевірювані відповіді з власних даних. Агент досліджує внутрішні джерела знань і повертає відповіді з посиланнями на джерело, щоб кожен висновок можна було перевірити. Сервіс орієнтований на галузі з суворими вимогами: дані шифруються під час зберігання й передачі, платформа відповідає стандартам SOC 1 і SOC 2, а розгорнути її можна в захищеній хмарі або на власних серверах. Для студентів і окремих користувачів є безкоштовний і недорогий тарифи, для компаній — корпоративний план із пробним періодом.', 'Nouswise helps organizations get verifiable answers from their own data. The agent researches internal knowledge sources and returns answers with source citations so every conclusion can be checked. The service targets industries with strict requirements: data is encrypted at rest and in transit, the platform meets SOC 1 and SOC 2 standards, and it can be deployed in a secure cloud or on your own servers. Students and individuals get free and low-cost plans, and companies get an enterprise plan with a trial.', 'Дослідження за власними джерелами знань
Відповіді з посиланнями на джерела
Шифрування даних
Відповідність SOC 1 і SOC 2
Розгортання у хмарі або локально', 'Research over your own knowledge sources
Answers with source citations
Data encryption
SOC 1 and SOC 2 compliance
Cloud or on-premise deployment', 'Організації з регульованих галузей, дослідники й студенти.', 'Organizations in regulated industries, researchers and students.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nouswise.com' OR LOWER(`name`) = LOWER('Nouswise')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'education-knowledge' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'education-knowledge' AND s.`name` = 'Дослідження та пошук' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' AND s.`name` = 'AI-агенти' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI research agent for regulated industries: it answers questions from your knowledge sources with a citation for every claim, uses encryption and can be deployed in the cloud or on-premise.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Nouswise helps organizations get verifiable answers from their own data. The agent researches internal knowledge sources and returns answers with source citations so every conclusion can be checked. The service targets industries with strict requirements: data is encrypted at rest and in transit, the platform meets SOC 1 and SOC 2 standards, and it can be deployed in a secure cloud or on your own servers. Students and individuals get free and low-cost plans, and companies get an enterprise plan with a trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Research over your own knowledge sources
Answers with source citations
Data encryption
SOC 1 and SOC 2 compliance
Cloud or on-premise deployment', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Organizations in regulated industries, researchers and students.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Starter', 'Starter', 0.00, 'free', 'Для студентів', 'For students' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Starter' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Starter', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For students', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Essential', 'Essential', 19.99, 'month', 'Для окремих користувачів і невеликих команд', 'For individuals and small teams' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Essential' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Essential', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For individuals and small teams', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- OpenHands — Асистенти коду
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'openhands.dev' OR LOWER(`name`) = LOWER('OpenHands'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OpenHands', NULL, 'https://openhands.dev', NULL, NULL, 'Відкрита платформа хмарних агентів для програмування: агенти виконують реальні інженерні завдання, від написання коду до рев''ю pull request, працюють з будь-якою моделлю й запускаються локально, у хмарі чи на власних серверах.', 'An open platform for cloud coding agents: agents do real engineering work from writing code to reviewing pull requests, work with any model and run locally, in the cloud or on your own servers.', 'OpenHands — платформа з відкритим кодом для агентної розробки програмного забезпечення. Агенти OpenHands працюють з вашими репозиторіями й виконують реальні завдання, а також можуть працювати за налаштованими сценаріями автоматизації: наприклад, переглядати нові pull request і залишати коментарі, щоночі перевіряти безпеку, стежити за каналом Slack чи збирати щоденні звіти команди. Платформа не прив''язана до конкретної моделі — можна підключити власний ключ або користуватися моделями за собівартістю. Є вебінтерфейс, термінальний інтерфейс і CLI, інтеграції з Git, Jira та Slack, API для автоматизації. Локальна версія безкоштовна, хмарна для окремих розробників теж безкоштовна, а для компаній є корпоративний варіант із приватним розгортанням.', 'OpenHands is an open-source platform for agentic software development. OpenHands agents work with your repositories and perform real tasks, and can also run configured automations: for example, reviewing new pull requests and posting comments, running nightly security passes, monitoring a Slack channel or collecting daily team standups. The platform is not tied to a particular model: you can bring your own key or use models at cost. There is a web interface, a terminal interface and a CLI, Git, Jira and Slack integrations and an API for automation. The local version is free, the cloud version for individual developers is free too, and companies get an enterprise option with private deployment.', 'Агенти для реальних інженерних задач
Автоматизації: рев''ю PR, перевірки безпеки, звіти
Будь-яка модель або власний ключ
Вебінтерфейс, термінал і CLI
Інтеграції з Git, Jira та Slack
Локально, у хмарі чи на своїх серверах', 'Agents for real engineering tasks
Automations: PR review, security passes, digests
Any model or your own key
Web interface, terminal and CLI
Git, Jira and Slack integrations
Local, cloud or self-hosted', 'Розробники й інженерні команди.', 'Developers and engineering teams.', 'web,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'openhands.dev' OR LOWER(`name`) = LOWER('OpenHands')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'development-it' AND s.`name` = 'Асистенти коду' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' AND s.`name` = 'AI-агенти' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An open platform for cloud coding agents: agents do real engineering work from writing code to reviewing pull requests, work with any model and run locally, in the cloud or on your own servers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'OpenHands is an open-source platform for agentic software development. OpenHands agents work with your repositories and perform real tasks, and can also run configured automations: for example, reviewing new pull requests and posting comments, running nightly security passes, monitoring a Slack channel or collecting daily team standups. The platform is not tied to a particular model: you can bring your own key or use models at cost. There is a web interface, a terminal interface and a CLI, Git, Jira and Slack integrations and an API for automation. The local version is free, the cloud version for individual developers is free too, and companies get an enterprise option with private deployment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Agents for real engineering tasks
Automations: PR review, security passes, digests
Any model or your own key
Web interface, terminal and CLI
Git, Jira and Slack integrations
Local, cloud or self-hosted', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and engineering teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open Source', 'Open Source', 0.00, 'free', 'Локальна версія безкоштовно', 'Local version free' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open Source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open Source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Local version free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Individual (Cloud)', 'Individual (Cloud)', 0.00, 'free', 'Хмарний доступ, власний ключ або моделі за собівартістю', 'Cloud access, own key or models at cost' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Individual (Cloud)' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Individual (Cloud)', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Cloud access, own key or models at cost', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'month', 'Приватне розгортання й підтримка', 'Private deployment and support' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Private deployment and support', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Paperguide — Дослідження та пошук
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'paperguide.ai' OR LOWER(`name`) = LOWER('Paperguide'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Paperguide', NULL, 'https://paperguide.ai', NULL, NULL, 'AI-платформа для наукових досліджень: пошук відповідей у сотнях мільйонів статей із посиланнями, менеджер джерел з імпортом із Zotero та Mendeley, дослідницькі агенти, витягування даних, систематичні огляди й письмо з цитуванням.', 'An AI platform for scientific research: search answers across hundreds of millions of papers with citations, a reference manager with Zotero and Mendeley import, research agents, data extraction, systematic reviews and citation-grounded writing.', 'Paperguide супроводжує науковця від першого пошуку до чернетки з посиланнями. Можна поставити дослідницьке запитання звичайною мовою, і AI-пошук дасть узагальнену відповідь за величезною базою наукових статей, де кожне твердження пов''язане з джерелом. Менеджер посилань дозволяє імпортувати бібліотеки із Zotero чи Mendeley або додавати статті за DOI. Дослідницький агент порівнює роботи й узагальнює дані, інструмент витягування даних заповнює таблиці зі статей, а AI-автор допомагає писати текст із коректним цитуванням. Для доказової медицини та інших галузей доступні прозорі систематичні огляди. Безкоштовний тариф дає щомісячні AI-кредити; для студентів і викладачів є знижка.', 'Paperguide supports a researcher from the first search to a cited draft. You can ask a research question in plain language and AI search gives a synthesized answer across a huge database of scientific papers, with every claim linked to its source. The reference manager lets you import libraries from Zotero or Mendeley or add papers by DOI. The research agent compares studies and synthesizes evidence, the data extraction tool fills tables from papers, and the AI writer helps write text with correct citations. Auditable systematic reviews are available for evidence-based medicine and other fields. The free plan gives monthly AI credits; students and academics get a discount.', 'AI-пошук за науковими статтями з посиланнями
Менеджер посилань з імпортом Zotero й Mendeley
Дослідницький агент
Витягування даних у таблиці
Систематичні огляди
AI-автор із цитуванням
Чат із PDF', 'AI search across scientific papers with citations
Reference manager with Zotero and Mendeley import
Research agent
Data extraction into tables
Systematic reviews
AI writer with citations
Chat with PDF', 'Науковці, аспіранти й дослідницькі команди.', 'Researchers, graduate students and research teams.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'paperguide.ai' OR LOWER(`name`) = LOWER('Paperguide')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'education-knowledge' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'education-knowledge' AND s.`name` = 'Дослідження та пошук' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' AND s.`name` = 'Публікації' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI platform for scientific research: search answers across hundreds of millions of papers with citations, a reference manager with Zotero and Mendeley import, research agents, data extraction, systematic reviews and citation-grounded writing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Paperguide supports a researcher from the first search to a cited draft. You can ask a research question in plain language and AI search gives a synthesized answer across a huge database of scientific papers, with every claim linked to its source. The reference manager lets you import libraries from Zotero or Mendeley or add papers by DOI. The research agent compares studies and synthesizes evidence, the data extraction tool fills tables from papers, and the AI writer helps write text with correct citations. Auditable systematic reviews are available for evidence-based medicine and other fields. The free plan gives monthly AI credits; students and academics get a discount.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI search across scientific papers with citations
Reference manager with Zotero and Mendeley import
Research agent
Data extraction into tables
Systematic reviews
AI writer with citations
Chat with PDF', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Researchers, graduate students and research teams.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', '2 000 AI-кредитів на місяць, обмежені функції', '2,000 AI credits per month, limited features' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '2,000 AI credits per month, limited features', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PicLumen — Генерація зображень
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'piclumen.com' OR LOWER(`name`) = LOWER('PicLumen'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PicLumen', NULL, 'https://piclumen.com', NULL, NULL, 'Платформа генерації зображень, відео й музики з кількома сторонніми моделями: створення й редагування зображень, відео з тексту чи фото, полотно для побудови процесів і готові рішення для бізнесу, зокрема фото товарів для Amazon.', 'A platform for generating images, video and music with several third-party models: image creation and editing, video from text or photos, a canvas for building workflows and ready business solutions such as product visuals for Amazon.', 'PicLumen об''єднує в одному сервісі генерацію зображень, відео й музики на основі кількох моделей різних розробників. Для зображень доступні створення з тексту чи іншого зображення, різні стилі — від реалістичного до аніме, піксель-арту чи 3D-персонажів — і інструменти редагування. Для відео — генерація з тексту або фото, створення GIF, видалення об''єктів і тексту з відео, зменшення шуму, уповільнення та стилізація. Є безмежне полотно для побудови процесів генерації, а також готові бізнес-рішення, наприклад візуали товарів для Amazon. Доступний мобільний застосунок; тарифи працюють на внутрішній валюті сервісу.', 'PicLumen brings image, video and music generation together in one service based on several models from different developers. For images there is generation from text or another image, various styles from realistic to anime, pixel art or 3D characters, and editing tools. For video there is generation from text or photos, GIF creation, removing objects and text from video, denoising, slow motion and stylization. There is an infinite canvas for building generation workflows, as well as ready business solutions such as product visuals for Amazon. A mobile app is available; plans use the service''s internal currency.', 'Генерація зображень у різних стилях
Відео з тексту чи фото
Редагування відео: видалення об''єктів, шуму
Генерація музики
Полотно для процесів генерації
Візуали товарів для Amazon
Мобільний застосунок', 'Image generation in various styles
Video from text or photos
Video editing: object removal, denoising
Music generation
Canvas for generation workflows
Product visuals for Amazon
Mobile app', 'Автори контенту, дизайнери й інтернет-продавці.', 'Content creators, designers and online sellers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'piclumen.com' OR LOWER(`name`) = LOWER('PicLumen')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Генерація зображень' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Генерація відео' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A platform for generating images, video and music with several third-party models: image creation and editing, video from text or photos, a canvas for building workflows and ready business solutions such as product visuals for Amazon.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PicLumen brings image, video and music generation together in one service based on several models from different developers. For images there is generation from text or another image, various styles from realistic to anime, pixel art or 3D characters, and editing tools. For video there is generation from text or photos, GIF creation, removing objects and text from video, denoising, slow motion and stylization. There is an infinite canvas for building generation workflows, as well as ready business solutions such as product visuals for Amazon. A mobile app is available; plans use the service''s internal currency.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Image generation in various styles
Video from text or photos
Video editing: object removal, denoising
Music generation
Canvas for generation workflows
Product visuals for Amazon
Mobile app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Content creators, designers and online sellers.', 'manual' FROM DUAL WHERE @new = 1;

-- PicTools.AI — Фотографія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pictools.ai' OR LOWER(`name`) = LOWER('PicTools.AI'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PicTools.AI', NULL, 'https://pictools.ai', NULL, NULL, 'Онлайн-редактор фото з AI, з яким працюють словами: завантажте знімок, опишіть зміну — заміна одягу чи фону, ретуш, видалення об''єкта — або оберіть один із понад 130 фільтрів, і за секунди отримаєте результат у повній роздільності.', 'An online AI photo editor you talk to: upload a photo and describe the change (new outfit or background, retouching, object removal) or pick one of 130+ filters, and get a full-resolution result in seconds.', 'PicTools.AI замінює складні фоторедактори простим діалогом. Ви завантажуєте фото у форматі JPG, PNG чи WEBP з телефона або комп''ютера, звичайними словами описуєте, що потрібно змінити, або обираєте один із понад 130 готових фільтрів — і за кілька секунд отримуєте відредаговане зображення в повній роздільності. Серед типових правок — заміна одягу зі збереженням обличчя й пози, ретуш портрета, видалення зайвих об''єктів і заміна фону. Нічого не потрібно встановлювати чи вчитися працювати з шарами й масками. Після реєстрації надаються кілька безкоштовних кредитів; далі можна оформити підписку або купити пакети кредитів, що не згорають.', 'PicTools.AI replaces complex photo editors with a simple conversation. You upload a JPG, PNG or WEBP photo from your phone or computer, describe in plain words what to change or choose one of 130+ ready filters, and in seconds get the edited image at full resolution. Typical edits include changing an outfit while keeping the face and pose, retouching a portrait, removing unwanted objects and changing the background. There is nothing to install and no layers or masks to learn. A few free credits are given after signing up; after that you can subscribe or buy credit packs that never expire.', 'Редагування фото текстовим описом
Понад 130 готових фільтрів
Заміна одягу й фону
Ретуш портретів
Видалення об''єктів
Результат у повній роздільності
Підписка або пакети кредитів', 'Photo editing by text description
130+ ready filters
Outfit and background changes
Portrait retouching
Object removal
Full-resolution results
Subscription or credit packs', 'Усі, кому потрібно швидко відредагувати фото без досвіду роботи з редакторами.', 'Anyone who needs to edit a photo quickly without editing experience.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pictools.ai' OR LOWER(`name`) = LOWER('PicTools.AI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Фотографія' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Видалення фону' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An online AI photo editor you talk to: upload a photo and describe the change (new outfit or background, retouching, object removal) or pick one of 130+ filters, and get a full-resolution result in seconds.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PicTools.AI replaces complex photo editors with a simple conversation. You upload a JPG, PNG or WEBP photo from your phone or computer, describe in plain words what to change or choose one of 130+ ready filters, and in seconds get the edited image at full resolution. Typical edits include changing an outfit while keeping the face and pose, retouching a portrait, removing unwanted objects and changing the background. There is nothing to install and no layers or masks to learn. A few free credits are given after signing up; after that you can subscribe or buy credit packs that never expire.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Photo editing by text description
130+ ready filters
Outfit and background changes
Portrait retouching
Object removal
Full-resolution results
Subscription or credit packs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone who needs to edit a photo quickly without editing experience.', 'manual' FROM DUAL WHERE @new = 1;

-- PokaMind — HR і рекрутинг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pokamind.com' OR LOWER(`name`) = LOWER('PokaMind'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PokaMind', NULL, 'https://pokamind.com', NULL, NULL, 'AI-інструменти для роботи, пов''язаної з людьми: аналіз зустрічей, нотатки коучингових сесій, тренування розмов, зворотний зв''язок і щотижневі дайджести, які створюються під потреби конкретної команди.', 'AI tools for people-facing work: meeting analysis, coaching notes, conversation practice, feedback and weekly digests, built for the needs of a specific team.', 'PokaMind робить AI-інструменти для тієї частини роботи, де люди спілкуються з людьми. Серед них — аналіз зустрічей із підсумками й думками учасників, нотатки коучингових сесій, тренування складних розмов, збір і підготовка зворотного зв''язку та щотижневі дайджести. Кожен інструмент спершу створювався під конкретного клієнта, а в кожному сценарії людина запускає чи перевіряє результат. Компанія також пілотує настільного робота-помічника. Співпраця починається з демонстрації.', 'PokaMind builds AI tools for the part of work where people communicate with people. They include meeting analysis with summaries and participants'' views, coaching session notes, practice for difficult conversations, collecting and preparing feedback, and weekly digests. Each tool was first built for a specific client, and in every scenario a person starts or checks the result. The company is also piloting a desktop robot assistant. Engagement starts with a demo.', 'Аналіз зустрічей
Нотатки коучингових сесій
Тренування розмов
Збір зворотного зв''язку
Щотижневі дайджести
Інструменти під потреби команди', 'Meeting analysis
Coaching session notes
Conversation practice
Feedback collection
Weekly digests
Tools built for your team', 'HR-команди, коучі й менеджери, які багато працюють з людьми.', 'HR teams, coaches and managers who work a lot with people.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pokamind.com' OR LOWER(`name`) = LOWER('PokaMind')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'productivity' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' AND s.`name` = 'HR і рекрутинг' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'productivity' AND s.`name` = 'AI-асистенти' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI tools for people-facing work: meeting analysis, coaching notes, conversation practice, feedback and weekly digests, built for the needs of a specific team.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PokaMind builds AI tools for the part of work where people communicate with people. They include meeting analysis with summaries and participants'' views, coaching session notes, practice for difficult conversations, collecting and preparing feedback, and weekly digests. Each tool was first built for a specific client, and in every scenario a person starts or checks the result. The company is also piloting a desktop robot assistant. Engagement starts with a demo.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Meeting analysis
Coaching session notes
Conversation practice
Feedback collection
Weekly digests
Tools built for your team', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'HR teams, coaches and managers who work a lot with people.', 'manual' FROM DUAL WHERE @new = 1;

-- Sensay — HR і рекрутинг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sensay.io' OR LOWER(`name`) = LOWER('Sensay'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sensay', NULL, 'https://sensay.io', NULL, NULL, 'Платформа збереження знань під час звільнення працівників: AI-інтерв''юер опитує тих, хто йде, впорядковує їхні знання з документами й надає команді AI-чат, який відповідає на запитання через Slack, Teams та інші канали.', 'A platform for keeping knowledge when employees leave: an AI interviewer talks to people who are leaving, organizes their know-how with documents and gives the team an AI chat that answers via Slack, Teams and other channels.', 'Sensay допомагає компаніям не втрачати експертизу, коли досвідчені працівники звільняються. Після швидкого налаштування ви вказуєте, хто залишає компанію, а сервіс планує інтерв''ю з AI-інтерв''юером, який розпитує людину про її знання й робочі процеси. До бази знань можна додати файли, посилання й контекст. Зібране впорядковується й надійно зберігається, а команда отримує AI-асистента, якому можна поставити запитання в Slack, Teams чи інших звичних інструментах і отримати відповідь на основі знань колишнього колеги. Ціна фіксована за кожну базу знань на рік.', 'Sensay helps companies avoid losing expertise when experienced employees leave. After a quick setup you tell it who is leaving, and the service schedules an interview with an AI interviewer that asks the person about their knowledge and workflows. Files, links and context can be added to the knowledge base. Everything collected is organized and stored securely, and the team gets an AI assistant they can query in Slack, Teams or other usual tools to get answers based on the former colleague''s knowledge. The price is fixed per knowledge base per year.', 'AI-інтерв''ю з працівниками, що звільняються
Додавання документів і посилань
Впорядкована база знань
Шифроване зберігання
AI-чат для команди в Slack і Teams', 'AI interviews with departing employees
Adding documents and links
Organized knowledge base
Encrypted storage
AI chat for the team in Slack and Teams', 'HR-команди й керівники компаній, для яких важливо зберегти експертизу.', 'HR teams and company leaders who care about retaining expertise.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sensay.io' OR LOWER(`name`) = LOWER('Sensay')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' AND s.`name` = 'HR і рекрутинг' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' AND s.`name` = 'Чат-боти' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A platform for keeping knowledge when employees leave: an AI interviewer talks to people who are leaving, organizes their know-how with documents and gives the team an AI chat that answers via Slack, Teams and other channels.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sensay helps companies avoid losing expertise when experienced employees leave. After a quick setup you tell it who is leaving, and the service schedules an interview with an AI interviewer that asks the person about their knowledge and workflows. Files, links and context can be added to the knowledge base. Everything collected is organized and stored securely, and the team gets an AI assistant they can query in Slack, Teams or other usual tools to get answers based on the former colleague''s knowledge. The price is fixed per knowledge base per year.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI interviews with departing employees
Adding documents and links
Organized knowledge base
Encrypted storage
AI chat for the team in Slack and Teams', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'HR teams and company leaders who care about retaining expertise.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Knowledge base', 'Knowledge base', 500.00, 'year', 'За одну базу знань на рік, усі функції', 'Per knowledge base per year, all features' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Knowledge base' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Knowledge base', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per knowledge base per year, all features', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SongGenerator.io — Музика
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'songgenerator.io' OR LOWER(`name`) = LOWER('SongGenerator.io'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SongGenerator.io', NULL, 'https://songgenerator.io', NULL, NULL, 'AI-генератор пісень без роялті: створює треки з текстового опису в будь-якому жанрі, генерує тексти пісень, відокремлює вокал від музики, розділяє на стеми, подовжує треки й робить lyric-відео.', 'A royalty-free AI song generator: it creates tracks from a text description in any genre, writes lyrics, separates vocals from music, splits stems, extends tracks and makes lyric videos.', 'SongGenerator.io допомагає створювати професійну музику без роялті. Опишіть ідею текстом — від спокійної балади до енергійного року — і сервіс згенерує завершений трек. Також доступні генератор текстів пісень, видалення вокалу, що дає окремо вокальну й інструментальну доріжки, розділення на стеми, подовження музики, кавери, музика за зображенням, звукові ефекти та відео з текстом пісні. Генерації приватні й мають комерційну ліцензію навіть на безкоштовному тарифі, який дає щоденні кредити; платні плани додають більше кредитів, паралельні завдання й завантаження WAV.', 'SongGenerator.io helps you create professional royalty-free music. Describe an idea in text, from a calm ballad to an energetic rock anthem, and the service generates a finished track. Also available are a lyrics generator, vocal removal that gives separate vocal and instrumental tracks, stem splitting, music extension, covers, music from an image, sound effects and lyric videos. Generations are private and come with a commercial license even on the free plan, which gives daily credits; paid plans add more credits, parallel jobs and WAV downloads.', 'Музика з текстового опису
Генерація текстів пісень
Видалення вокалу й розділення на стеми
Подовження треків і кавери
Звукові ефекти
Lyric-відео
Комерційна ліцензія', 'Music from a text description
Lyrics generation
Vocal removal and stem splitting
Track extension and covers
Sound effects
Lyric videos
Commercial license', 'Автори пісень, автори контенту й музиканти.', 'Songwriters, content creators and musicians.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'songgenerator.io' OR LOWER(`name`) = LOWER('SongGenerator.io')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Музика' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Аудіо' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A royalty-free AI song generator: it creates tracks from a text description in any genre, writes lyrics, separates vocals from music, splits stems, extends tracks and makes lyric videos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SongGenerator.io helps you create professional royalty-free music. Describe an idea in text, from a calm ballad to an energetic rock anthem, and the service generates a finished track. Also available are a lyrics generator, vocal removal that gives separate vocal and instrumental tracks, stem splitting, music extension, covers, music from an image, sound effects and lyric videos. Generations are private and come with a commercial license even on the free plan, which gives daily credits; paid plans add more credits, parallel jobs and WAV downloads.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Music from a text description
Lyrics generation
Vocal removal and stem splitting
Track extension and covers
Sound effects
Lyric videos
Commercial license', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Songwriters, content creators and musicians.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', '20 кредитів на день, комерційна ліцензія, MP3', '20 credits per day, commercial license, MP3' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '20 credits per day, commercial license, MP3', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ultra', 'Ultra', 23.99, 'month', 'Для бізнесу й агенцій (ціна при оплаті за рік зі знижкою)', 'For businesses and agencies (price with discounted annual billing)' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ultra' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Ultra', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For businesses and agencies (price with discounted annual billing)', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SoundBoost — Аудіо
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'soundboost.ai' OR LOWER(`name`) = LOWER('SoundBoost'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SoundBoost', NULL, 'https://soundboost.ai', NULL, NULL, 'AI-мастеринг музики онлайн: завантажте трек і опишіть словами бажане звучання або дайте посилання на референс у Spotify — сервіс за секунди зробить готовий до релізу майстер; також є розділення на стеми й генератор кліпів.', 'Online AI music mastering: upload a track and describe the sound you want in words or give a Spotify reference link, and the service produces a release-ready master in seconds; stem splitting and a music video generator are included.', 'SoundBoost дає музикантам професійний мастеринг без студії. Ви завантажуєте пісню й описуєте звучання словами — наприклад, просите ширшу стереопанораму чи конкретний характер звуку — або вставляєте посилання на трек у Spotify як референс. Сервіс без готових пресетів робить унікальний майстер, оптимізований під гучність стримінгових платформ; результат можна прослухати безкоштовно без реєстрації. Окремо доступні розділення треку на стеми й видалення вокалу, генератор музичних відео з пісні та інструмент для візуалів. Платна підписка дає необмежений мастеринг і стеми, усі ефекти, експорт у WAV, HD-WAV і MP3 та кілька ревізій для кожного треку. Є мобільний застосунок.', 'SoundBoost gives musicians professional mastering without a studio. You upload a song and describe the sound in words, for example asking for a wider stereo field or a particular character, or paste a Spotify track link as a reference. Without presets the service creates a unique master optimized for streaming loudness; you can preview it for free without signing up. Also available are stem splitting and vocal removal, a music video generator and a visuals tool. The paid subscription gives unlimited mastering and stems, all effects, WAV, HD-WAV and MP3 export and several revisions per track. There is a mobile app.', 'Мастеринг за текстовим описом
Референс-мастеринг за посиланням Spotify
Безкоштовне прослуховування без реєстрації
Розділення на стеми й видалення вокалу
Генератор музичних відео
Експорт WAV, HD-WAV і MP3', 'Mastering from a text description
Reference mastering via a Spotify link
Free preview without sign-up
Stem splitting and vocal removal
Music video generator
WAV, HD-WAV and MP3 export', 'Незалежні музиканти, продюсери й студенти-музиканти.', 'Independent musicians, producers and music students.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'soundboost.ai' OR LOWER(`name`) = LOWER('SoundBoost')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Аудіо' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Музика' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Online AI music mastering: upload a track and describe the sound you want in words or give a Spotify reference link, and the service produces a release-ready master in seconds; stem splitting and a music video generator are included.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SoundBoost gives musicians professional mastering without a studio. You upload a song and describe the sound in words, for example asking for a wider stereo field or a particular character, or paste a Spotify track link as a reference. Without presets the service creates a unique master optimized for streaming loudness; you can preview it for free without signing up. Also available are stem splitting and vocal removal, a music video generator and a visuals tool. The paid subscription gives unlimited mastering and stems, all effects, WAV, HD-WAV and MP3 export and several revisions per track. There is a mobile app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Mastering from a text description
Reference mastering via a Spotify link
Free preview without sign-up
Stem splitting and vocal removal
Music video generator
WAV, HD-WAV and MP3 export', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Independent musicians, producers and music students.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Unlimited', 'Unlimited', 4.00, 'month', 'Необмежений мастеринг і стеми, усі ефекти; ціна при оплаті за рік', 'Unlimited mastering and stems, all effects; price with annual billing' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Unlimited' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Unlimited', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Unlimited mastering and stems, all effects; price with annual billing', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Subscribr — Генерація відео
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'subscribr.ai' OR LOWER(`name`) = LOWER('Subscribr'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Subscribr', NULL, 'https://subscribr.ai', NULL, NULL, 'Платформа для ведення YouTube-каналу: знаходить ідеї, що зараз працюють у вашій ніші, пише сценарії, робить обкладинки й змонтовані відео — місячний план роликів за один раз; працює також через Claude, ChatGPT та інших агентів.', 'A platform for running a YouTube channel: it finds ideas working in your niche right now, writes scripts, makes thumbnails and edited videos, a month of videos at once; it also works through Claude, ChatGPT and other agents.', 'Subscribr об''єднує весь цикл роботи YouTube-каналу в одному сервісі. Бот ідей аналізує велику базу відео, щоб показати, що зараз добре працює у вашій ніші, а агент сценаріїв проводить текст через багатоетапний процес до готового сценарію. Далі сервіс створює обкладинки й монтує готове відео — в одному з кількох візуальних стилів або з аватаром і обраним голосом — і допомагає оптимізувати канал. Навички й робочий простір можна використовувати з Claude, ChatGPT, Cursor та іншими агентами через MCP. Сервіс підходить власникам бізнесу, авторам каналів без обличчя, ютуберам і агенціям; навички монтажу чи дизайну не потрібні. Почати можна безкоштовно.', 'Subscribr brings the whole YouTube channel workflow into one service. An ideation bot analyzes a large video database to show what is working in your niche right now, and a script agent takes text through a multi-step process to a finished script. The service then creates thumbnails and edits a finished video, in one of several visual styles or with an avatar and voice of your choice, and helps optimize the channel. Its skills and workspace can be used with Claude, ChatGPT, Cursor and other agents via MCP. It suits business owners, faceless channel creators, YouTubers and agencies; no editing or design skills are needed. You can start for free.', 'Ідеї на основі популярних відео в ніші
Багатоетапний агент сценаріїв
Обкладинки для відео
Готові змонтовані відео
Аватари й обрані голоси
Робота через Claude, ChatGPT і MCP', 'Ideas based on popular videos in your niche
Multi-step script agent
Video thumbnails
Finished edited videos
Avatars and chosen voices
Works via Claude, ChatGPT and MCP', 'YouTube-автори, власники каналів без обличчя, бізнес і агенції.', 'YouTube creators, faceless channel owners, businesses and agencies.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'subscribr.ai' OR LOWER(`name`) = LOWER('Subscribr')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Генерація відео' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' AND s.`name` = 'Копірайтинг' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' AND s.`name` = 'SMM' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A platform for running a YouTube channel: it finds ideas working in your niche right now, writes scripts, makes thumbnails and edited videos, a month of videos at once; it also works through Claude, ChatGPT and other agents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Subscribr brings the whole YouTube channel workflow into one service. An ideation bot analyzes a large video database to show what is working in your niche right now, and a script agent takes text through a multi-step process to a finished script. The service then creates thumbnails and edits a finished video, in one of several visual styles or with an avatar and voice of your choice, and helps optimize the channel. Its skills and workspace can be used with Claude, ChatGPT, Cursor and other agents via MCP. It suits business owners, faceless channel creators, YouTubers and agencies; no editing or design skills are needed. You can start for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Ideas based on popular videos in your niche
Multi-step script agent
Video thumbnails
Finished edited videos
Avatars and chosen voices
Works via Claude, ChatGPT and MCP', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'YouTube creators, faceless channel owners, businesses and agencies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Growth', 'Growth', 99.00, 'month', 'До 8 відео на місяць з ідеєю, сценарієм, обкладинкою й монтажем', 'Up to 8 videos a month with idea, script, thumbnail and edit' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Growth' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Growth', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Up to 8 videos a month with idea, script, thumbnail and edit', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Syllaby — Генерація відео
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'syllaby.io' OR LOWER(`name`) = LOWER('Syllaby'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Syllaby', NULL, 'https://syllaby.io', NULL, NULL, 'Платформа для відео без обличчя автора й AI-аватарів: ідеї, сценарії, короткі й довгі відео з узгодженими персонажами, клонування голосу, обкладинки, планувальник публікацій і аналітика соцмереж.', 'A platform for faceless videos and AI avatars: ideas, scripts, short and long videos with consistent characters, voice cloning, thumbnails, a post scheduler and social analytics.', 'Syllaby допомагає бізнесу й авторам регулярно публікувати відео без зйомок. Сервіс генерує ідеї й сценарії, створює короткі й довгі відео без обличчя автора з узгодженими персонажами, перетворює аудіо чи посилання на відео й розбиває текст на сцени. Доступні AI-аватари, клонування голосу, генерація зображень і обкладинок, відеоредактор, вибір художнього стилю та кілька сторонніх відеомоделей. Готові ролики можна масово запланувати до публікації, а календар контенту й аналітика соцмереж допомагають стежити за результатами. Є мобільний застосунок, API та MCP, а також послуга, де команда Syllaby веде акаунт за вас. Сервіс має рішення для юристів, ріелторів, лікарів і інших професій.', 'Syllaby helps businesses and creators publish video regularly without filming. The service generates ideas and scripts, creates short and long faceless videos with consistent characters, turns audio or URLs into video and splits text into scenes. AI avatars, voice cloning, image and thumbnail generation, a video editor, art style selection and several third-party video models are available. Finished videos can be bulk-scheduled, and a content calendar and social analytics help track results. There is a mobile app, an API and MCP, as well as a service where the Syllaby team runs your account for you. It has solutions for lawyers, real estate agents, doctors and other professions.', 'Ідеї й сценарії відео
Короткі й довгі відео без обличчя автора
AI-аватари й клонування голосу
Узгоджені персонажі
Масове планування публікацій
Календар контенту й аналітика
Мобільний застосунок, API та MCP', 'Video ideas and scripts
Short and long faceless videos
AI avatars and voice cloning
Consistent characters
Bulk post scheduling
Content calendar and analytics
Mobile app, API and MCP', 'Фахівці (юристи, ріелтори, лікарі), малий бізнес і автори контенту.', 'Professionals (lawyers, real estate agents, doctors), small businesses and content creators.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'syllaby.io' OR LOWER(`name`) = LOWER('Syllaby')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Генерація відео' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'AI-аватари' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' AND s.`name` = 'SMM' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A platform for faceless videos and AI avatars: ideas, scripts, short and long videos with consistent characters, voice cloning, thumbnails, a post scheduler and social analytics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Syllaby helps businesses and creators publish video regularly without filming. The service generates ideas and scripts, creates short and long faceless videos with consistent characters, turns audio or URLs into video and splits text into scenes. AI avatars, voice cloning, image and thumbnail generation, a video editor, art style selection and several third-party video models are available. Finished videos can be bulk-scheduled, and a content calendar and social analytics help track results. There is a mobile app, an API and MCP, as well as a service where the Syllaby team runs your account for you. It has solutions for lawyers, real estate agents, doctors and other professions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Video ideas and scripts
Short and long faceless videos
AI avatars and voice cloning
Consistent characters
Bulk post scheduling
Content calendar and analytics
Mobile app, API and MCP', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Professionals (lawyers, real estate agents, doctors), small businesses and content creators.', 'manual' FROM DUAL WHERE @new = 1;

-- Thesify — Дослідження та пошук
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thesify.ai' OR LOWER(`name`) = LOWER('Thesify'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Thesify', NULL, 'https://thesify.ai', NULL, NULL, 'AI-інструменти для науковців: Reviewer за хвилини дає експертний відгук на рукопис і підказує відповідні журнали, а Coauthor — агенти, які шукають і читають літературу та допомагають з чернетками.', 'AI tools for researchers: Reviewer gives expert feedback on a manuscript in minutes and suggests suitable journals, while Coauthor provides agents that search and read the literature and help with drafts.', 'Thesify допомагає дослідникам швидше доводити статті до публікації. Інструмент Reviewer аналізує рукопис і за кілька хвилин дає детальний відгук, подібний до рецензії, — щоб посилити аргументи й виправити слабкі місця ще до подання, не чекаючи на відгуки наукового керівника чи колег. Також є рекомендації журналів для подання й чат щодо рукопису. Окремий продукт Coauthor — це AI-агенти, що шукають і читають наукову літературу та допомагають готувати чернетки, звільняючи час для самого дослідження. Рецензії можна купувати поштучно або пакетами.', 'Thesify helps researchers get papers published faster. The Reviewer tool analyzes a manuscript and within minutes gives detailed, review-style feedback so you can strengthen arguments and fix weak points before submission, without waiting for a supervisor or peers. There are also journal recommendations and a manuscript chat. A separate product, Coauthor, provides AI agents that search and read scientific literature and help prepare drafts, freeing time for the research itself. Reviews can be bought one at a time or in packs.', 'Експертний відгук на рукопис за хвилини
Рекомендації журналів
Чат щодо рукопису
Агенти для пошуку й читання літератури
Допомога з чернетками
Звіт із відгуком для завантаження', 'Expert manuscript feedback in minutes
Journal recommendations
Manuscript chat
Agents for literature search and reading
Help with drafts
Downloadable feedback report', 'Науковці, аспіранти й дослідники, які готують статті до публікації.', 'Researchers, graduate students and academics preparing papers for publication.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thesify.ai' OR LOWER(`name`) = LOWER('Thesify')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'education-knowledge' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'education-knowledge' AND s.`name` = 'Дослідження та пошук' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' AND s.`name` = 'Публікації' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI tools for researchers: Reviewer gives expert feedback on a manuscript in minutes and suggests suitable journals, while Coauthor provides agents that search and read the literature and help with drafts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Thesify helps researchers get papers published faster. The Reviewer tool analyzes a manuscript and within minutes gives detailed, review-style feedback so you can strengthen arguments and fix weak points before submission, without waiting for a supervisor or peers. There are also journal recommendations and a manuscript chat. A separate product, Coauthor, provides AI agents that search and read scientific literature and help prepare drafts, freeing time for the research itself. Reviews can be bought one at a time or in packs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Expert manuscript feedback in minutes
Journal recommendations
Manuscript chat
Agents for literature search and reading
Help with drafts
Downloadable feedback report', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Researchers, graduate students and academics preparing papers for publication.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Single Review', 'Single Review', 14.95, 'one_time', 'Одна рецензія рукопису', 'One manuscript review' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Single Review' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Single Review', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'One manuscript review', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, '3 Reviews', '3 Reviews', 39.95, 'one_time', 'Пакет із трьох рецензій', 'Pack of three reviews' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = '3 Reviews' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', '3 Reviews', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pack of three reviews', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, '10 Reviews', '10 Reviews', 99.95, 'one_time', 'Пакет із десяти рецензій', 'Pack of ten reviews' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = '10 Reviews' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', '10 Reviews', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pack of ten reviews', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Vadoo AI — Генерація відео
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vadoo.tv' OR LOWER(`name`) = LOWER('Vadoo AI'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Vadoo AI', NULL, 'https://vadoo.tv', NULL, NULL, 'Платформа для коротких відео й зображень із багатьма сторонніми моделями: відео з тексту чи зображення, сценарії, субтитри, озвучення, B-roll, SEO-інструменти й автопублікація в TikTok, Reels і Shorts.', 'A platform for short videos and images with many third-party models: video from text or images, scripts, captions, voiceover, B-roll, SEO tools and auto-posting to TikTok, Reels and Shorts.', 'Vadoo AI створена для виробництва короткого відеоконтенту. У ній зібрано багато моделей генерації відео й зображень від різних розробників, тож можна працювати в одному процесі, не перемикаючись між сервісами. Доступні перетворення тексту на відео, анімація статичних зображень, AI-написання сценаріїв, субтитри, озвучення, підбір додаткових кадрів, SEO-інструменти та автоматична публікація для TikTok, Reels, Shorts і подкастів. Відео експортуються без водяного знака; тарифи відрізняються кількістю відео на місяць, максимальною тривалістю, шаблонами й кількістю учасників команди. Є мобільний застосунок і безкоштовний старт.', 'Vadoo AI is built for short-form video production. It brings together many video and image generation models from different developers, so you can work in one workflow without switching services. Available are text-to-video, animation of still images, AI scriptwriting, captions, voiceover, B-roll selection, SEO tools and automatic posting for TikTok, Reels, Shorts and podcasts. Videos export without a watermark; plans differ in videos per month, maximum length, templates and number of team members. There is a mobile app and a free start.', 'Багато моделей генерації відео й зображень
Відео з тексту чи зображення
Сценарії, субтитри й озвучення
Додаткові кадри (B-roll)
SEO-інструменти
Автопублікація в соцмережі
Командна робота', 'Many video and image generation models
Video from text or an image
Scripts, captions and voiceover
B-roll
SEO tools
Auto-posting to social networks
Team collaboration', 'Автори коротких відео, маркетологи й агенції.', 'Short-form video creators, marketers and agencies.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vadoo.tv' OR LOWER(`name`) = LOWER('Vadoo AI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Генерація відео' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' AND s.`name` = 'SMM' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A platform for short videos and images with many third-party models: video from text or images, scripts, captions, voiceover, B-roll, SEO tools and auto-posting to TikTok, Reels and Shorts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Vadoo AI is built for short-form video production. It brings together many video and image generation models from different developers, so you can work in one workflow without switching services. Available are text-to-video, animation of still images, AI scriptwriting, captions, voiceover, B-roll selection, SEO tools and automatic posting for TikTok, Reels, Shorts and podcasts. Videos export without a watermark; plans differ in videos per month, maximum length, templates and number of team members. There is a mobile app and a free start.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Many video and image generation models
Video from text or an image
Scripts, captions and voiceover
B-roll
SEO tools
Auto-posting to social networks
Team collaboration', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Short-form video creators, marketers and agencies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Starter', 'Starter', 19.00, 'month', '20 відео на місяць до 1,5 хв', '20 videos per month up to 1.5 min' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Starter' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Starter', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '20 videos per month up to 1.5 min', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 39.00, 'month', '100 відео на місяць до 3 хв, +2 учасники', '100 videos per month up to 3 min, +2 collaborators' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '100 videos per month up to 3 min, +2 collaborators', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Advance', 'Advance', 99.00, 'month', '400 відео на місяць до 5 хв, +10 учасників', '400 videos per month up to 5 min, +10 collaborators' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Advance' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Advance', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '400 videos per month up to 5 min, +10 collaborators', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- VenturusAI — Фінанси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'venturusai.com' OR LOWER(`name`) = LOWER('VenturusAI'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'VenturusAI', NULL, 'https://venturusai.com', NULL, NULL, 'AI-аналітика бізнес-ідей: за описом стартапу чи компанії за пів хвилини готує детальний звіт зі стратегічним аналізом, а на платних тарифах — чат з AI-консультантом, дашборд і презентацію для інвесторів.', 'AI business idea analysis: from a description of a startup or company it prepares a detailed strategic report in half a minute, and on paid plans adds a chat with an AI advisor, a dashboard and an investor pitch deck.', 'VenturusAI допомагає підприємцям оцінити ідею чи наявний бізнес. Ви описуєте задум, обираєте мову звіту, і сервіс менш ніж за хвилину формує детальний аналіз із висновками для ухвалення рішень і стратегічного планування. Звіти можна зробити публічними чи приватними, а права на їхнє комерційне використання лишаються за вами. На платних тарифах доступні довші описи ідей, PDF без водяного знака, чат з AI-консультантом Vera, дашборд, поглиблені звіти, пошук із графіками та генерація презентацій для інвесторів. Є спільнота підприємців. Почати можна безкоштовно без картки.', 'VenturusAI helps entrepreneurs evaluate an idea or an existing business. You describe the plan, choose the report language, and in under a minute the service produces a detailed analysis with conclusions for decision-making and strategic planning. Reports can be public or private, and you keep the rights to use them commercially. Paid plans allow longer idea descriptions, watermark-free PDFs, chat with the AI advisor Vera, a dashboard, advanced reports, search with charts and investor pitch deck generation. There is a community of founders. You can start for free with no card.', 'Аналіз бізнес-ідеї за описом
Звіт різними мовами
Права на комерційне використання звіту
Чат з AI-консультантом
Поглиблені звіти й дашборд
Презентації для інвесторів', 'Business idea analysis from a description
Reports in different languages
Commercial rights to the report
Chat with an AI advisor
Advanced reports and dashboard
Investor pitch decks', 'Засновники стартапів, підприємці й малий бізнес.', 'Startup founders, entrepreneurs and small businesses.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'venturusai.com' OR LOWER(`name`) = LOWER('VenturusAI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'finance-legal' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'finance-legal' AND s.`name` = 'Фінанси' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' AND s.`name` = 'Аналітика' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI business idea analysis: from a description of a startup or company it prepares a detailed strategic report in half a minute, and on paid plans adds a chat with an AI advisor, a dashboard and an investor pitch deck.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'VenturusAI helps entrepreneurs evaluate an idea or an existing business. You describe the plan, choose the report language, and in under a minute the service produces a detailed analysis with conclusions for decision-making and strategic planning. Reports can be public or private, and you keep the rights to use them commercially. Paid plans allow longer idea descriptions, watermark-free PDFs, chat with the AI advisor Vera, a dashboard, advanced reports, search with charts and investor pitch deck generation. There is a community of founders. You can start for free with no card.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Business idea analysis from a description
Reports in different languages
Commercial rights to the report
Chat with an AI advisor
Advanced reports and dashboard
Investor pitch decks', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Startup founders, entrepreneurs and small businesses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Starter', 'Starter', 0.00, 'free', 'Опис ідеї до 1 000 символів', 'Idea description up to 1,000 characters' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Starter' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Starter', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Idea description up to 1,000 characters', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Lite', 'Lite', 10.00, 'month', 'Чат із Vera, дашборд, 2 поглиблені звіти на місяць', 'Chat with Vera, dashboard, 2 advanced reports per month' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Lite' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Lite', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Chat with Vera, dashboard, 2 advanced reports per month', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 16.67, 'month', 'Презентації для інвесторів, 5 поглиблених звітів на місяць', 'Pitch decks, 5 advanced reports per month' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pitch decks, 5 advanced reports per month', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- VideoToPage — Копірайтинг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'videotopage.com' OR LOWER(`name`) = LOWER('VideoToPage'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'VideoToPage', NULL, 'https://videotopage.com', NULL, NULL, 'Сервіс, що перетворює відео чи аудіо на статтю для блогу, матеріал або допис для соцмереж: достатньо посилання на YouTube, файлу чи запису — і за хвилини отримаєте текст, готовий до публікації у WordPress, Notion чи Ghost.', 'A service that turns video or audio into a blog post, article or social post: a YouTube link, file or recording is enough to get text ready to publish to WordPress, Notion or Ghost within minutes.', 'VideoToPage допомагає витягти більше користі з кожного відео. Ви вставляєте посилання на YouTube, завантажуєте відео- чи аудіофайл або записуєте його прямо в сервісі, а потім обираєте один із генераторів, щоб структурувати контент так, як потрібно: стаття для блогу, матеріал, допис для соцмереж чи інший формат. Результат готовий за кілька хвилин і може бути опублікований у WordPress, Notion, Ghost та інших платформах. Спробувати можна безкоштовно на кількох хвилинах відео; завантаження власних файлів доступне на платних тарифах.', 'VideoToPage helps you get more value from every video. You paste a YouTube link, upload a video or audio file or record directly in the service, then choose one of the generators to structure the content the way you need: a blog post, an article, a social post or another format. The result is ready in a few minutes and can be published to WordPress, Notion, Ghost and other platforms. You can try it for free on a few minutes of video; uploading your own files is available on paid plans.', 'Стаття з відео чи аудіо
Посилання на YouTube, файл або запис
Різні генератори структури
Дописи для соцмереж
Публікація у WordPress, Notion, Ghost', 'An article from video or audio
YouTube link, file or recording
Various structure generators
Social media posts
Publishing to WordPress, Notion, Ghost', 'Автори відео, контент-команди й агенції, що перевикористовують відеоконтент.', 'Video creators, content teams and agencies repurposing video content.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'videotopage.com' OR LOWER(`name`) = LOWER('VideoToPage')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'seo-content' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' AND s.`name` = 'Копірайтинг' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'seo-content' AND s.`name` = 'SEO' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A service that turns video or audio into a blog post, article or social post: a YouTube link, file or recording is enough to get text ready to publish to WordPress, Notion or Ghost within minutes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'VideoToPage helps you get more value from every video. You paste a YouTube link, upload a video or audio file or record directly in the service, then choose one of the generators to structure the content the way you need: a blog post, an article, a social post or another format. The result is ready in a few minutes and can be published to WordPress, Notion, Ghost and other platforms. You can try it for free on a few minutes of video; uploading your own files is available on paid plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'An article from video or audio
YouTube link, file or recording
Various structure generators
Social media posts
Publishing to WordPress, Notion, Ghost', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Video creators, content teams and agencies repurposing video content.', 'manual' FROM DUAL WHERE @new = 1;

-- Viggle AI — 3D та анімація
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'viggle.ai' OR LOWER(`name`) = LOWER('Viggle AI'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Viggle AI', NULL, 'https://viggle.ai', NULL, NULL, 'Платформа генеративного руху: переносить рухи з відео з телефона на 3D-персонажа для ігрових рушіїв, анімує персонажів, створює меми й ігри та має API для розробників.', 'A generative motion platform: it transfers motion from a phone video to a 3D character for game engines, animates characters, makes memes and games, and offers an API for developers.', 'Viggle AI спеціалізується на русі персонажів. Інструмент захоплення руху дозволяє зняти звичайне відео на телефон і за кілька хвилин перетворити його на анімацію 3D-персонажа, готову до експорту в популярні ігрові рушії, без студії та спеціального обладнання. Генератор мемів додає рух персонажам або замінює персонажів у відео, зокрема в реальному часі. Також доступні створення ігор, підключення агентів і API для розробників, які хочуть вбудувати генерацію руху у свої продукти. Є мобільний застосунок і безкоштовна спроба.', 'Viggle AI specializes in character motion. The motion capture tool lets you shoot an ordinary phone video and turn it into 3D character animation within minutes, ready to export to popular game engines, without a studio or special equipment. The meme maker adds motion to characters or swaps characters in videos, including in real time. Game creation, agent connections and an API for developers who want to build motion generation into their products are also available. There is a mobile app and a free trial.', 'Захоплення руху з відео з телефона
Анімація 3D-персонажів
Експорт у ігрові рушії
Генератор мемів із рухом
Створення ігор
API для розробників', 'Motion capture from a phone video
3D character animation
Export to game engines
Meme maker with motion
Game creation
API for developers', 'Аніматори, розробники ігор і автори контенту.', 'Animators, game developers and content creators.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'viggle.ai' OR LOWER(`name`) = LOWER('Viggle AI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = '3D та анімація' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Генерація відео' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A generative motion platform: it transfers motion from a phone video to a 3D character for game engines, animates characters, makes memes and games, and offers an API for developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Viggle AI specializes in character motion. The motion capture tool lets you shoot an ordinary phone video and turn it into 3D character animation within minutes, ready to export to popular game engines, without a studio or special equipment. The meme maker adds motion to characters or swaps characters in videos, including in real time. Game creation, agent connections and an API for developers who want to build motion generation into their products are also available. There is a mobile app and a free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Motion capture from a phone video
3D character animation
Export to game engines
Meme maker with motion
Game creation
API for developers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Animators, game developers and content creators.', 'manual' FROM DUAL WHERE @new = 1;

-- Zivy — Тайм-менеджмент
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zivy.app' OR LOWER(`name`) = LOWER('Zivy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Zivy', NULL, 'https://zivy.app', NULL, NULL, 'AI-помічник для Slack: стежить за розмовами в усіх каналах, виносить на поверхню важливі повідомлення й перетворює обговорення на завдання, щоб не витрачати години на розбір сповіщень.', 'An AI assistant for Slack: it tracks conversations across all channels, surfaces important messages and turns discussions into tasks so you don''t spend hours sorting notifications.', 'Zivy допомагає впоратися з потоком повідомлень у Slack, особливо у великих чи розподілених командах. Сервіс відстежує розмови в усіх ваших каналах, відфільтровує шум і показує повідомлення, які справді потребують уваги, у потрібний момент. Обговорення можна швидко переглядати, відкладати, позначати й перетворювати на завдання, а AI сам знаходить дії, які вам потрібно виконати. Завдяки цьому не доводиться постійно перевіряти Slack чи наздоганяти пропущене. Є демонстрація.', 'Zivy helps you cope with the flow of messages in Slack, especially in large or remote teams. The service tracks conversations across all your channels, filters out the noise and shows the messages that really need your attention at the right time. Discussions can be skimmed, snoozed, tagged and turned into tasks, and the AI itself finds actions you need to take. As a result you no longer have to keep checking Slack or catch up on missed messages. There is a demo.', 'Відстеження всіх каналів Slack
Фільтрація шуму
Важливі повідомлення вчасно
Перетворення розмов на завдання
Відкладення й позначки повідомлень', 'Tracking all Slack channels
Noise filtering
Important messages on time
Turning conversations into tasks
Snoozing and tagging messages', 'Менеджери й члени команд, яких перевантажує Slack.', 'Managers and team members overloaded by Slack.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zivy.app' OR LOWER(`name`) = LOWER('Zivy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'productivity' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'productivity' AND s.`name` = 'Тайм-менеджмент' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' AND s.`name` = 'Плагіни' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI assistant for Slack: it tracks conversations across all channels, surfaces important messages and turns discussions into tasks so you don''t spend hours sorting notifications.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Zivy helps you cope with the flow of messages in Slack, especially in large or remote teams. The service tracks conversations across all your channels, filters out the noise and shows the messages that really need your attention at the right time. Discussions can be skimmed, snoozed, tagged and turned into tasks, and the AI itself finds actions you need to take. As a result you no longer have to keep checking Slack or catch up on missed messages. There is a demo.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tracking all Slack channels
Noise filtering
Important messages on time
Turning conversations into tasks
Snoozing and tagging messages', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Managers and team members overloaded by Slack.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Early bird', 'Early bird', 18.00, 'month', 'Ціна для ранніх користувачів (звичайна $25)', 'Early adopter price (regular $25)' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Early bird' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Early bird', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Early adopter price (regular $25)', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Accio Work — AI-агенти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'accio.com' OR LOWER(`name`) = LOWER('Accio Work'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Accio Work', NULL, 'https://accio.com', NULL, NULL, 'AI-команда для інтернет-торгівлі: агенти виконують бізнес-завдання — аналіз продажів магазинів, порівняння конкурентів, перевірку покупців, створення головних зображень товарів — з плагінами, запуском за розкладом і підключенням до маркетплейсів.', 'An AI team for e-commerce: agents carry out business tasks such as store sales analysis, competitor comparison, buyer due diligence and product hero images, with plugins, scheduled runs and marketplace connections.', 'Accio Work — робочий простір з AI-агентами для бізнесу, насамперед для глобальної інтернет-торгівлі. Ви ставите завдання звичайною мовою, а агент уточнює обсяг і доступи, планує кроки й виконує роботу: наприклад, збирає дані про продажі ваших магазинів за тиждень і готує порівняльний звіт, порівнює конкурентів, перевіряє покупців чи створює головні зображення для карток товарів. Доступні плагіни, завдання за розкладом, різні канали зв''язку й командна робота, а також інтеграції з провідними екосистемами електронної комерції. Працювати можна в браузері або в застосунку для Windows.', 'Accio Work is a workspace with AI agents for business, primarily for global e-commerce. You set a task in plain language, and the agent confirms scope and access, plans the steps and does the work: for example, it gathers a week of sales data for your stores and prepares a comparison report, compares competitors, checks buyers or creates hero images for product listings. Plugins, scheduled tasks, multiple channels and team collaboration are available, along with integrations with leading e-commerce ecosystems. You can work in the browser or in a Windows app.', 'AI-агенти для бізнес-завдань
Звіти про продажі магазинів
Порівняння конкурентів
Перевірка покупців
Зображення для карток товарів
Плагіни й завдання за розкладом
Інтеграції з маркетплейсами', 'AI agents for business tasks
Store sales reports
Competitor comparison
Buyer due diligence
Product listing images
Plugins and scheduled tasks
Marketplace integrations', 'Продавці й команди, що працюють у глобальній інтернет-торгівлі.', 'Sellers and teams working in global e-commerce.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'accio.com' OR LOWER(`name`) = LOWER('Accio Work')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'tools-automation' AND s.`name` = 'AI-агенти' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' AND s.`name` = 'Аналітика' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI team for e-commerce: agents carry out business tasks such as store sales analysis, competitor comparison, buyer due diligence and product hero images, with plugins, scheduled runs and marketplace connections.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Accio Work is a workspace with AI agents for business, primarily for global e-commerce. You set a task in plain language, and the agent confirms scope and access, plans the steps and does the work: for example, it gathers a week of sales data for your stores and prepares a comparison report, compares competitors, checks buyers or creates hero images for product listings. Plugins, scheduled tasks, multiple channels and team collaboration are available, along with integrations with leading e-commerce ecosystems. You can work in the browser or in a Windows app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI agents for business tasks
Store sales reports
Competitor comparison
Buyer due diligence
Product listing images
Plugins and scheduled tasks
Marketplace integrations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sellers and teams working in global e-commerce.', 'manual' FROM DUAL WHERE @new = 1;

-- TalkTastic — Транскрипція
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'talktastic.com' OR LOWER(`name`) = LOWER('TalkTastic'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TalkTastic', NULL, 'https://talktastic.com', NULL, NULL, 'Голосовий набір для macOS: диктуйте в будь-якому застосунку, а AI з урахуванням контексту переписує сказане у вашому стилі; поєднує розпізнавання на пристрої з мультимодальними моделями й слухає лише за вашою командою.', 'Voice typing for macOS: dictate in any app while AI rewrites what you said in your style based on context; it combines on-device recognition with multimodal models and only listens on your command.', 'TalkTastic дозволяє писати голосом у будь-якій програмі на Mac: достатньо натиснути клавішу й говорити. Сервіс не просто розшифровує мовлення, а розуміє контекст програми, у якій ви працюєте, і одразу переписує текст у вашому стилі — наприклад, перетворює короткі думки на розгорнутий охайний лист. Розпізнавання поєднує AI на пристрої з мультимодальними мовними моделями. Конфіденційність налаштовується детально: застосунок слухає лише за вашою командою, знімки екрана робить тільки на запит, а налаштування можна змінити будь-коли.', 'TalkTastic lets you write by voice in any app on a Mac: just press a key and speak. The service does not just transcribe speech but understands the context of the app you are in and immediately rewrites the text in your style, for example turning brief thoughts into a polished, full email. Recognition combines on-device AI with multimodal language models. Privacy is fine-grained: the app only listens when you tell it to, takes screenshots only on request, and settings can be changed at any time.', 'Диктування в будь-якому застосунку macOS
Переписування з урахуванням контексту
Ваш стиль письма
Розпізнавання на пристрої
Детальні налаштування приватності', 'Dictation in any macOS app
Context-aware rewriting
Your writing style
On-device recognition
Fine-grained privacy settings', 'Користувачі Mac, які багато пишуть: автори, підприємці, зайняті фахівці.', 'Mac users who write a lot: writers, entrepreneurs, busy professionals.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'talktastic.com' OR LOWER(`name`) = LOWER('TalkTastic')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'productivity' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Транскрипція' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'productivity' AND s.`name` = 'AI-асистенти' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Voice typing for macOS: dictate in any app while AI rewrites what you said in your style based on context; it combines on-device recognition with multimodal models and only listens on your command.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TalkTastic lets you write by voice in any app on a Mac: just press a key and speak. The service does not just transcribe speech but understands the context of the app you are in and immediately rewrites the text in your style, for example turning brief thoughts into a polished, full email. Recognition combines on-device AI with multimodal language models. Privacy is fine-grained: the app only listens when you tell it to, takes screenshots only on request, and settings can be changed at any time.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Dictation in any macOS app
Context-aware rewriting
Your writing style
On-device recognition
Fine-grained privacy settings', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Mac users who write a lot: writers, entrepreneurs, busy professionals.', 'manual' FROM DUAL WHERE @new = 1;

-- Voicepen — Копірайтинг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'voicepen.ai' OR LOWER(`name`) = LOWER('Voicepen'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Voicepen', NULL, 'https://voicepen.ai', NULL, NULL, 'AI-сервіс, що перетворює аудіо, відео, голосові нотатки й сайти на SEO-статті для блогу: вставте посилання на YouTube чи завантажте подкаст — і отримаєте теми й готові тексти.', 'An AI service that turns audio, video, voice memos and websites into SEO blog posts: paste a YouTube link or upload a podcast and get topics and finished texts.', 'Voicepen допомагає створювати статті для блогу без написання з нуля. Достатньо вставити посилання на відео YouTube чи сайт або завантажити подкаст, вебінар, ролик із TikTok чи голосову нотатку — сервіс розшифрує запис, запропонує теми й напише статті, оптимізовані для пошуку. Також можна просто отримати розшифровку будь-якого запису. Сервіс підходить бізнесу й маркетологам, які хочуть повторно використовувати вебінари, подкасти й зустрічі як текстовий контент.', 'Voicepen helps you create blog posts without writing from scratch. Just paste a YouTube video or website link or upload a podcast, webinar, TikTok clip or voice memo, and the service transcribes it, suggests topics and writes search-optimized posts. You can also simply get a transcript of any recording. The service suits businesses and marketers who want to repurpose webinars, podcasts and meetings as text content.', 'Статті з відео YouTube
Статті з подкастів і голосових нотаток
Статті з сайтів
Розшифровка записів
Пропозиції тем
SEO-оптимізація', 'Posts from YouTube videos
Posts from podcasts and voice memos
Posts from websites
Transcription of recordings
Topic suggestions
SEO optimization', 'Маркетологи, автори контенту й бізнес.', 'Marketers, content creators and businesses.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'voicepen.ai' OR LOWER(`name`) = LOWER('Voicepen')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' AND s.`name` = 'Копірайтинг' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Транскрипція' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI service that turns audio, video, voice memos and websites into SEO blog posts: paste a YouTube link or upload a podcast and get topics and finished texts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Voicepen helps you create blog posts without writing from scratch. Just paste a YouTube video or website link or upload a podcast, webinar, TikTok clip or voice memo, and the service transcribes it, suggests topics and writes search-optimized posts. You can also simply get a transcript of any recording. The service suits businesses and marketers who want to repurpose webinars, podcasts and meetings as text content.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Posts from YouTube videos
Posts from podcasts and voice memos
Posts from websites
Transcription of recordings
Topic suggestions
SEO optimization', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Marketers, content creators and businesses.', 'manual' FROM DUAL WHERE @new = 1;

-- StoryArtAI — Генерація зображень
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'storyartai.com' OR LOWER(`name`) = LOWER('StoryArtAI'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'StoryArtAI', NULL, 'https://storyartai.com', NULL, NULL, 'AI-генератор ілюстрацій для дитячих книжок: опишіть сцену, оберіть один із семи стилів — від акварелі до коміксу — і отримайте узгоджені ілюстрації з тими самими персонажами на кожній сторінці.', 'An AI illustration generator for children''s books: describe a scene, choose one of seven styles from watercolor to comics, and get consistent illustrations with the same characters on every page.', 'StoryArtAI допомагає батькам, авторам і педагогам ілюструвати дитячі історії без навичок дизайну. Ви описуєте сцену простими словами, обираєте один із семи художніх стилів — м''яку акварель, яскравий комікс та інші — і отримуєте якісну ілюстрацію. Персонажі лишаються впізнаваними між сторінками, тож можна проілюструвати цілу книжку. Ілюстрації підходять для книжок, занять у класі й казок на ніч; контент орієнтований на дітей 3–12 років. Почати можна безкоштовно.', 'StoryArtAI helps parents, authors and educators illustrate children''s stories without design skills. You describe a scene in simple words, choose one of seven art styles, such as soft watercolor or bold comics, and get a high-quality illustration. Characters stay recognizable across pages, so you can illustrate a whole book. Illustrations suit books, classrooms and bedtime stories; content is aimed at children aged 3 to 12. You can start for free.', 'Ілюстрації за описом сцени
Сім художніх стилів
Узгоджені персонажі між сторінками
Якісне завантаження
Безпечний для дітей контент', 'Illustrations from a scene description
Seven art styles
Consistent characters across pages
High-quality downloads
Kid-safe content', 'Батьки, автори дитячих книжок і педагоги.', 'Parents, children''s book authors and educators.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'storyartai.com' OR LOWER(`name`) = LOWER('StoryArtAI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Генерація зображень' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' AND s.`name` = 'Публікації' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI illustration generator for children''s books: describe a scene, choose one of seven styles from watercolor to comics, and get consistent illustrations with the same characters on every page.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'StoryArtAI helps parents, authors and educators illustrate children''s stories without design skills. You describe a scene in simple words, choose one of seven art styles, such as soft watercolor or bold comics, and get a high-quality illustration. Characters stay recognizable across pages, so you can illustrate a whole book. Illustrations suit books, classrooms and bedtime stories; content is aimed at children aged 3 to 12. You can start for free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Illustrations from a scene description
Seven art styles
Consistent characters across pages
High-quality downloads
Kid-safe content', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents, children''s book authors and educators.', 'manual' FROM DUAL WHERE @new = 1;

-- CVGist — HR і рекрутинг
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cvgist.com' OR LOWER(`name`) = LOWER('CVGist'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CVGist', NULL, 'https://cvgist.com', NULL, NULL, 'AI-генератор резюме: створює нове резюме з короткого опису, адаптує наявне під конкретну вакансію або імпортує дані з LinkedIn, з понад 90 шаблонами й форматом Word, сумісним з ATS.', 'An AI resume generator: it creates a new resume from a short brief, tailors an existing one to a specific job or imports data from LinkedIn, with 90+ templates and an ATS-compatible Word format.', 'CVGist допомагає швидко отримати професійне резюме без довгих форм. Можна адаптувати наявне резюме під конкретну вакансію, щоб воно використовувало мову з опису посади, створити нове з короткого опису досвіду або імпортувати дані з профілю LinkedIn чи файлу PDF або DOCX. Готове резюме оформлюється в одному з понад 90 шаблонів, зберігається у форматі Microsoft Word, сумісне з автоматичними системами відбору кандидатів і далі вільно редагується. Є безкоштовна версія адаптації та платне преміум-резюме за невелику разову плату.', 'CVGist helps you get a professional resume quickly without long forms. You can tailor an existing resume to a specific job so it uses the language of the job posting, create a new one from a short description of your experience, or import data from your LinkedIn profile or a PDF or DOCX file. The finished resume uses one of more than 90 templates, is saved in Microsoft Word format, is compatible with applicant tracking systems and can be freely edited afterwards. There is a free tailoring version and a paid premium resume for a small one-time fee.', 'Адаптація резюме під вакансію
Нове резюме з короткого опису
Імпорт із LinkedIn, PDF чи DOCX
Понад 90 шаблонів
Формат Word, сумісний з ATS', 'Resume tailored to a job
A new resume from a short brief
Import from LinkedIn, PDF or DOCX
90+ templates
ATS-compatible Word format', 'Шукачі роботи.', 'Job seekers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cvgist.com' OR LOWER(`name`) = LOWER('CVGist')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' AND s.`name` = 'HR і рекрутинг' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' AND s.`name` = 'Копірайтинг' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI resume generator: it creates a new resume from a short brief, tailors an existing one to a specific job or imports data from LinkedIn, with 90+ templates and an ATS-compatible Word format.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'CVGist helps you get a professional resume quickly without long forms. You can tailor an existing resume to a specific job so it uses the language of the job posting, create a new one from a short description of your experience, or import data from your LinkedIn profile or a PDF or DOCX file. The finished resume uses one of more than 90 templates, is saved in Microsoft Word format, is compatible with applicant tracking systems and can be freely edited afterwards. There is a free tailoring version and a paid premium resume for a small one-time fee.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Resume tailored to a job
A new resume from a short brief
Import from LinkedIn, PDF or DOCX
90+ templates
ATS-compatible Word format', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Job seekers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium resume', 'Premium resume', 2.99, 'one_time', 'Преміум-резюме з шаблоном', 'Premium resume with a template' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium resume' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium resume', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Premium resume with a template', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tengr.ai — Генерація зображень
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tengr.ai' OR LOWER(`name`) = LOWER('Tengr.ai'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tengr.ai', NULL, 'https://tengr.ai', NULL, NULL, 'AI-генератор зображень із власною моделлю: швидкі зображення високої роздільності, редагування текстовим описом, деталізація, стилі, тони й ракурси камери, з повними правами на комерційне використання та API.', 'An AI image generator with its own model: fast high-resolution images, editing by text description, a detailer, styles, tones and camera angles, with full commercial rights and an API.', 'Tengr.ai — сервіс генерації зображень на власній моделі, що створює швидкі зображення високої роздільності з точним слідуванням підказці. Редагувати результат можна, просто описавши бажані зміни. Доступні налаштування художнього стилю, колірних тонів і ракурсу камери, інструмент деталізації та заміна облич. Усі згенеровані зображення належать користувачу й можуть використовуватися комерційно. Сервіс поєднує свободу підказок із системою фільтрів безпеки. Є API, рішення для бізнесу й спільнота користувачів.', 'Tengr.ai is an image generation service built on its own model, producing fast high-resolution images that follow the prompt precisely. You can edit a result simply by describing the changes you want. Settings for art style, color tones and camera angle, a detailer tool and face swap are available. All generated images belong to the user and can be used commercially. The service combines prompt freedom with a system of safety filters. There is an API, business solutions and a user community.', 'Власна модель генерації зображень
Висока роздільність
Редагування текстовим описом
Стилі, тони й ракурси камери
Інструмент деталізації
Комерційні права
API', 'Own image generation model
High resolution
Editing by text description
Styles, tones and camera angles
Detailer tool
Commercial rights
API', 'Дизайнери, автори контенту й бізнес.', 'Designers, content creators and businesses.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tengr.ai' OR LOWER(`name`) = LOWER('Tengr.ai')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Генерація зображень' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI image generator with its own model: fast high-resolution images, editing by text description, a detailer, styles, tones and camera angles, with full commercial rights and an API.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tengr.ai is an image generation service built on its own model, producing fast high-resolution images that follow the prompt precisely. You can edit a result simply by describing the changes you want. Settings for art style, color tones and camera angle, a detailer tool and face swap are available. All generated images belong to the user and can be used commercially. The service combines prompt freedom with a system of safety filters. There is an API, business solutions and a user community.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Own image generation model
High resolution
Editing by text description
Styles, tones and camera angles
Detailer tool
Commercial rights
API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Designers, content creators and businesses.', 'manual' FROM DUAL WHERE @new = 1;

-- Athena AI — AI-асистенти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'athenachat.bot' OR LOWER(`name`) = LOWER('Athena AI'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Athena AI', NULL, 'https://athenachat.bot', NULL, NULL, 'AI-асистент для досліджень і створення в одному чаті: будує діаграми, генерує зображення, створює вебсайти й допомагає досліджувати документи; безкоштовно — кілька запитів на місяць.', 'An AI assistant for research and creation in one chat: it builds diagrams, generates images, creates websites and helps research documents; a few requests a month are free.', 'Athena AI поєднує кілька творчих і дослідницьких задач в одному чаті. За запитом асистент будує діаграми — наприклад, план запуску продукту від брифу до релізу, — генерує зображення, створює прості вебсайти й допомагає досліджувати документи. Результат можна одразу використати або доопрацювати в розмові. Сервіс доступний на кількох платформах; безкоштовно надається обмежена кількість запитів на місяць, далі — платні тарифи.', 'Athena AI combines several creative and research tasks in one chat. On request the assistant builds diagrams, for example a product launch plan from brief to release, generates images, creates simple websites and helps research documents. The result can be used right away or refined in the conversation. The service is available on several platforms; a limited number of requests per month is free, followed by paid plans.', 'Діаграми з текстового запиту
Генерація зображень
Створення вебсайтів
Дослідження документів
Доопрацювання в чаті', 'Diagrams from a text request
Image generation
Website creation
Document research
Refinement in chat', 'Фахівці, студенти й підприємці, яким потрібні діаграми, візуали й дослідження в одному місці.', 'Professionals, students and entrepreneurs who need diagrams, visuals and research in one place.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'athenachat.bot' OR LOWER(`name`) = LOWER('Athena AI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'productivity' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'productivity' AND s.`name` = 'AI-асистенти' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'productivity' AND s.`name` = 'Дошки та діаграми' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI assistant for research and creation in one chat: it builds diagrams, generates images, creates websites and helps research documents; a few requests a month are free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Athena AI combines several creative and research tasks in one chat. On request the assistant builds diagrams, for example a product launch plan from brief to release, generates images, creates simple websites and helps research documents. The result can be used right away or refined in the conversation. The service is available on several platforms; a limited number of requests per month is free, followed by paid plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Diagrams from a text request
Image generation
Website creation
Document research
Refinement in chat', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Professionals, students and entrepreneurs who need diagrams, visuals and research in one place.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', '10 безкоштовних запитів на місяць', '10 free requests per month' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '10 free requests per month', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Informly — Підтримка клієнтів
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'informly.app' OR LOWER(`name`) = LOWER('Informly'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Informly', NULL, 'https://informly.app', NULL, NULL, 'AI-платформа знань для підтримки клієнтів і команди: підключіть документи з PDF, Notion, Google Drive чи Confluence — і асистент за секунду відповідатиме на запитання з посиланням на точне джерело.', 'An AI knowledge platform for customer support and teams: connect documents from PDF, Notion, Google Drive or Confluence, and the assistant answers questions in under a second with a link to the exact source.', 'Informly допомагає командам підтримки й співробітникам не чекати на відповіді. Ви підключаєте джерела знань — PDF-файли, сторінки Notion, документи Google Drive, вікі Confluence та інші, — і вони автоматично синхронізуються. Після цього команда й клієнти можуть ставити запитання асистенту, а він відповідає менш ніж за секунду з посиланням на конкретний документ і розділ. Додаткове навчання моделі й IT-проєкт не потрібні: налаштування займає кілька хвилин. Асистента можна поширити за посиланням або вбудувати на сайт. Платформа має сертифікати SOC2 і HIPAA; є безкоштовний тариф без картки.', 'Informly helps support teams and employees stop waiting for answers. You connect knowledge sources such as PDF files, Notion pages, Google Drive documents, Confluence wikis and others, and they sync automatically. After that, the team and customers can ask the assistant questions, and it answers in under a second with a link to the specific document and section. No model training or IT project is needed: setup takes a few minutes. The assistant can be shared via a link or embedded on a website. The platform has SOC2 and HIPAA certifications; there is a free plan with no card.', 'Підключення PDF, Notion, Google Drive, Confluence
Відповіді з посиланням на джерело
Автоматична синхронізація документів
Вбудовування на сайт
Налаштування за кілька хвилин
SOC2 і HIPAA', 'Connect PDF, Notion, Google Drive, Confluence
Answers with a source link
Automatic document sync
Website embedding
Setup in a few minutes
SOC2 and HIPAA', 'Команди підтримки клієнтів і компанії з великою базою документації.', 'Customer support teams and companies with large documentation bases.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'informly.app' OR LOWER(`name`) = LOWER('Informly')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' AND s.`name` = 'Підтримка клієнтів' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' AND s.`name` = 'Чат-боти' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI knowledge platform for customer support and teams: connect documents from PDF, Notion, Google Drive or Confluence, and the assistant answers questions in under a second with a link to the exact source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Informly helps support teams and employees stop waiting for answers. You connect knowledge sources such as PDF files, Notion pages, Google Drive documents, Confluence wikis and others, and they sync automatically. After that, the team and customers can ask the assistant questions, and it answers in under a second with a link to the specific document and section. No model training or IT project is needed: setup takes a few minutes. The assistant can be shared via a link or embedded on a website. The platform has SOC2 and HIPAA certifications; there is a free plan with no card.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Connect PDF, Notion, Google Drive, Confluence
Answers with a source link
Automatic document sync
Website embedding
Setup in a few minutes
SOC2 and HIPAA', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Customer support teams and companies with large documentation bases.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний тариф без обмеження в часі', 'Free forever plan' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free forever plan', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Chief — AI-асистенти
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chief.bot' OR LOWER(`name`) = LOWER('Chief'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Chief', NULL, 'https://chief.bot', NULL, NULL, 'AI-центр керування для керівників (раніше Storytell): записує зустрічі в Zoom, Teams, Google Meet, телефонні й живі розмови без бота в дзвінку, а потім перетворює розмову на чернетки, оновлення інструментів і завдання для агентів.', 'An AI command center for executives (formerly Storytell): it records Zoom, Teams, Google Meet, phone and in-person meetings with no bot in the call, then turns the conversation into drafts, tool updates and tasks for agents.', 'Chief, який раніше називався Storytell, допомагає перетворювати зустрічі на виконану роботу. Нативний застосунок для macOS і Windows записує розмови в Zoom, Teams, Google Meet, телефонні дзвінки й живі зустрічі, причому жоден бот не приєднується до дзвінка. Нотатки — лише початок: на основі розмови можна створювати робочі чернетки, оновлювати підключені інструменти й передавати контекст своїм AI-агентам, щоб, наприклад, відгук клієнта одразу перетворювався на скоординовані дії команди. Сервіс орієнтований на керівників і тих, хто будує продукти, та пропонує корпоративну демонстрацію.', 'Chief, formerly called Storytell, helps turn meetings into finished work. The native app for macOS and Windows records conversations in Zoom, Teams, Google Meet, phone calls and in-person meetings, with no bot joining the call. Notes are just the start: from the conversation you can create working drafts, update connected tools and hand context to your AI agents, so that, for example, customer feedback immediately becomes coordinated team action. The service targets executives and builders and offers an enterprise demo.', 'Запис зустрічей без бота в дзвінку
Zoom, Teams, Google Meet, телефон і живі зустрічі
Нотатки й чернетки з розмови
Оновлення підключених інструментів
Передача контексту AI-агентам
Застосунки для macOS і Windows', 'Meeting recording with no bot in the call
Zoom, Teams, Google Meet, phone and in-person
Notes and drafts from the conversation
Updates to connected tools
Handing context to AI agents
Apps for macOS and Windows', 'Керівники, засновники й продуктові команди.', 'Executives, founders and product teams.', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chief.bot' OR LOWER(`name`) = LOWER('Chief')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'productivity' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'productivity' AND s.`name` = 'AI-асистенти' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'multimedia' AND s.`name` = 'Транскрипція' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI command center for executives (formerly Storytell): it records Zoom, Teams, Google Meet, phone and in-person meetings with no bot in the call, then turns the conversation into drafts, tool updates and tasks for agents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Chief, formerly called Storytell, helps turn meetings into finished work. The native app for macOS and Windows records conversations in Zoom, Teams, Google Meet, phone calls and in-person meetings, with no bot joining the call. Notes are just the start: from the conversation you can create working drafts, update connected tools and hand context to your AI agents, so that, for example, customer feedback immediately becomes coordinated team action. The service targets executives and builders and offers an enterprise demo.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Meeting recording with no bot in the call
Zoom, Teams, Google Meet, phone and in-person
Notes and drafts from the conversation
Updates to connected tools
Handing context to AI agents
Apps for macOS and Windows', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Executives, founders and product teams.', 'manual' FROM DUAL WHERE @new = 1;

-- LiGo — SMM
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ligosocial.com' OR LOWER(`name`) = LOWER('LiGo'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LiGo', NULL, 'https://ligosocial.com', NULL, NULL, 'AI-агенти для LinkedIn від LigoSocial: щоранку готують 3–5 чернеток дописів вашим голосом на основі ваших думок і трендів ніші та надсилають їх на пошту, у Slack, Discord чи ClickUp.', 'AI agents for LinkedIn from LigoSocial: every morning they prepare 3–5 post drafts in your voice based on your opinions and niche trends and send them to email, Slack, Discord or ClickUp.', 'LiGo допомагає регулярно публікуватися в LinkedIn без щоденних зусиль. Агентів налаштовують один раз: вони аналізують ваші попередні думки й висловлювання, стежать за трендами вашої ніші, зокрема в обговореннях на Reddit, і щоранку надсилають кілька готових до публікації чернеток дописів вашим голосом. Чернетки приходять туди, де вам зручно, — на пошту, у Slack, Discord чи ClickUp. Є розширення для Chrome і безкоштовні інструменти; спробувати можна 7 днів безкоштовно.', 'LiGo helps you post on LinkedIn regularly without daily effort. You configure the agents once: they analyze your past opinions and statements, track trends in your niche, including discussions on Reddit, and every morning send several ready-to-publish post drafts in your voice. Drafts arrive wherever is convenient for you: email, Slack, Discord or ClickUp. There is a Chrome extension and free tools; you can try it free for 7 days.', '3–5 чернеток дописів щоранку
Ваш голос на основі попередніх думок
Відстеження трендів ніші
Доставка на пошту, у Slack, Discord, ClickUp
Розширення для Chrome', '3–5 post drafts every morning
Your voice based on past opinions
Niche trend tracking
Delivery to email, Slack, Discord, ClickUp
Chrome extension', 'Фахівці й підприємці, які розвивають особистий бренд у LinkedIn.', 'Professionals and entrepreneurs building a personal brand on LinkedIn.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ligosocial.com' OR LOWER(`name`) = LOWER('LiGo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'business-marketing' AND s.`name` = 'SMM' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' AND s.`name` = 'Копірайтинг' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI agents for LinkedIn from LigoSocial: every morning they prepare 3–5 post drafts in your voice based on your opinions and niche trends and send them to email, Slack, Discord or ClickUp.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'LiGo helps you post on LinkedIn regularly without daily effort. You configure the agents once: they analyze your past opinions and statements, track trends in your niche, including discussions on Reddit, and every morning send several ready-to-publish post drafts in your voice. Drafts arrive wherever is convenient for you: email, Slack, Discord or ClickUp. There is a Chrome extension and free tools; you can try it free for 7 days.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '3–5 post drafts every morning
Your voice based on past opinions
Niche trend tracking
Delivery to email, Slack, Discord, ClickUp
Chrome extension', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Professionals and entrepreneurs building a personal brand on LinkedIn.', 'manual' FROM DUAL WHERE @new = 1;

-- Rabbithole — Дослідження та пошук
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rabbithole.chat' OR LOWER(`name`) = LOWER('Rabbithole'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Rabbithole', NULL, 'https://rabbithole.chat', NULL, NULL, 'AI-чат для захопливих досліджень тем: ставите запитання про історію, науку чи технології й заглиблюєтеся в тему крок за кроком, зберігаючи історію розмов, щоб повертатися до них пізніше.', 'An AI chat for engaging topic exploration: ask questions about history, science or technology and go deeper step by step, keeping a conversation history to return to later.', 'Rabbithole заохочує допитливість і пояснює складні теми як цікаву історію. Можна почати з готових запитань — наприклад, що сталося з Александрійською бібліотекою чи як люди вперше висадилися на Місяць — або поставити власне й поступово заглиблюватися в тему. Після входу через Google розмови зберігаються в історії, тож до них можна повернутися й продовжити будь-коли. Є платний тариф.', 'Rabbithole encourages curiosity and explains complex topics as an engaging story. You can start with ready questions, such as what happened to the Library of Alexandria or how humans first landed on the Moon, or ask your own and gradually go deeper. After signing in with Google, conversations are saved in your history so you can return and continue them at any time. There is a paid plan.', 'Дослідження тем у форматі розмови
Готові цікаві запитання
Історія розмов
Вхід через Google', 'Topic exploration as a conversation
Ready interesting questions
Conversation history
Sign in with Google', 'Допитливі люди, студенти й усі, хто любить пізнавати нове.', 'Curious people, students and anyone who loves learning.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-02 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rabbithole.chat' OR LOWER(`name`) = LOWER('Rabbithole')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'education-knowledge' LIMIT 1;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'education-knowledge' AND s.`name` = 'Дослідження та пошук' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'text-chatbots' AND s.`name` = 'Чат-боти' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An AI chat for engaging topic exploration: ask questions about history, science or technology and go deeper step by step, keeping a conversation history to return to later.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Rabbithole encourages curiosity and explains complex topics as an engaging story. You can start with ready questions, such as what happened to the Library of Alexandria or how humans first landed on the Moon, or ask your own and gradually go deeper. After signing in with Google, conversations are saved in your history so you can return and continue them at any time. There is a paid plan.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Topic exploration as a conversation
Ready interesting questions
Conversation history
Sign in with Google', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Curious people, students and anyone who loves learning.', 'manual' FROM DUAL WHERE @new = 1;
