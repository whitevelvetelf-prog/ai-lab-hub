SET NAMES utf8mb4;

-- =====================================================================
-- Ad server (зони, кампанії, оголошення, покази, кліки).
-- Лише CREATE TABLE IF NOT EXISTS — безпечно для повторного запуску.
-- Не плутати зі старою таблицею campaigns (банер головної сторінки).
-- =====================================================================
CREATE TABLE IF NOT EXISTS ad_zones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    page_type ENUM('category', 'subcategory', 'global') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ad_campaigns (
    id INT AUTO_INCREMENT PRIMARY KEY,
    campaign_type ENUM('paid', 'internal') NOT NULL DEFAULT 'paid',
    advertiser_name VARCHAR(255) NOT NULL,
    contact_email VARCHAR(255) NULL,
    payment_type ENUM('fixed_period') NULL,
    paid_amount DECIMAL(10,2) NULL,
    status ENUM('active', 'paused', 'expired') NOT NULL DEFAULT 'active',
    start_date DATE NOT NULL,
    end_date DATE NULL,
    notes TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ads (
    id INT AUTO_INCREMENT PRIMARY KEY,
    campaign_id INT NOT NULL,
    zone_id INT NOT NULL,
    image_url VARCHAR(500) NOT NULL,
    target_url VARCHAR(500) NOT NULL,
    category_id INT NULL,
    subcategory_id INT NULL,
    status ENUM('active', 'inactive') NOT NULL DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (campaign_id) REFERENCES ad_campaigns(id),
    FOREIGN KEY (zone_id) REFERENCES ad_zones(id)
);

CREATE TABLE IF NOT EXISTS ad_impressions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    ad_id INT NOT NULL,
    session_id VARCHAR(100) NULL,
    shown_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ad_id) REFERENCES ads(id)
);

CREATE TABLE IF NOT EXISTS ad_clicks (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    ad_id INT NOT NULL,
    session_id VARCHAR(100) NULL,
    clicked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ad_id) REFERENCES ads(id)
);

-- Текст оголошення (headline/subtext) живе в БД, а не в зображенні, щоб
-- перекладатись як решта контенту. Колонки додаються лише якщо їх ще нема
-- (information_schema + PREPARE — працює і на MySQL, і на MariaDB).
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ads' AND COLUMN_NAME='headline')=0,
  'ALTER TABLE ads ADD COLUMN headline VARCHAR(255) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ads' AND COLUMN_NAME='subtext')=0,
  'ALTER TABLE ads ADD COLUMN subtext VARCHAR(500) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- ad_translations — переклад headline/subtext (за зразком product_translations;
-- рушій app/translation-cache.php: cached_translation / localized_field).
CREATE TABLE IF NOT EXISTS ad_translations (
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    ad_id           INT NOT NULL,
    field_name      VARCHAR(50) NOT NULL,
    lang            VARCHAR(5) NOT NULL,
    translated_text MEDIUMTEXT NOT NULL,
    source          ENUM('auto', 'manual') NOT NULL DEFAULT 'auto',
    updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uniq_ad_field_lang (ad_id, field_name, lang),
    CONSTRAINT fk_ad_translations_ad
        FOREIGN KEY (ad_id) REFERENCES ads (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Зони та внутрішні оголошення AI LAB HUB (промо Елі й підтримки проєкту)
-- для сторінок категорії (зона 1) і підкатегорії (зона 2). Показуються, коли
-- немає активної платної кампанії. UPDATE — щоб оновити рядок 1, якщо раніше
-- застосовано попередню версію блоку (INSERT IGNORE наявні рядки не змінює).
INSERT IGNORE INTO ad_zones (id, name, page_type) VALUES
(1, 'Сторінка категорії - верх', 'category'),
(2, 'Сторінка підкатегорії - верх', 'subcategory');

INSERT IGNORE INTO ad_campaigns (id, campaign_type, advertiser_name, status, start_date, notes) VALUES
(1, 'internal', 'AI LAB HUB', 'active', CURDATE(), 'Внутрішнє промо: Еля та підтримка проєкту');

INSERT IGNORE INTO ads (id, campaign_id, zone_id, image_url, target_url, headline, subtext, category_id, subcategory_id, status) VALUES
(1, 1, 1, '/assets/images/ads/eli-promo.svg', 'eli.php', 'Не знаєте, який AI-інструмент обрати?', 'Спитайте Елю — вона підбере інструмент під вашу задачу та бюджет', NULL, NULL, 'active'),
(2, 1, 1, '/assets/images/ads/support-promo.svg', 'donate.php', 'Підтримайте AI LAB HUB', 'Проєкт розвивається завдяки вам — кожен внесок наближає нові інструменти', NULL, NULL, 'active'),
(3, 1, 2, '/assets/images/ads/eli-promo.svg', 'eli.php', 'Не знаєте, який AI-інструмент обрати?', 'Спитайте Елю — вона підбере інструмент під вашу задачу та бюджет', NULL, NULL, 'active'),
(4, 1, 2, '/assets/images/ads/support-promo.svg', 'donate.php', 'Підтримайте AI LAB HUB', 'Проєкт розвивається завдяки вам — кожен внесок наближає нові інструменти', NULL, NULL, 'active');

UPDATE ads SET image_url = '/assets/images/ads/eli-promo.svg', target_url = 'eli.php' WHERE id = 1 AND image_url LIKE '%marketplace-promo%';
UPDATE ad_campaigns SET notes = 'Внутрішнє промо: Еля та підтримка проєкту' WHERE id = 1 AND notes LIKE 'Промо Marketplace%';

-- Оголошення, створені до появи headline/subtext: заповнюємо текстом
-- (зображення тепер лише фон без тексту).
UPDATE ads SET headline = 'Не знаєте, який AI-інструмент обрати?', subtext = 'Спитайте Елю — вона підбере інструмент під вашу задачу та бюджет'
 WHERE id IN (1, 3) AND headline IS NULL;
UPDATE ads SET headline = 'Підтримайте AI LAB HUB', subtext = 'Проєкт розвивається завдяки вам — кожен внесок наближає нові інструменти'
 WHERE id IN (2, 4) AND headline IS NULL;

-- Готовий EN-переклад (вручну, source='manual' — без витрат Google Translate).
INSERT IGNORE INTO ad_translations (ad_id, field_name, lang, translated_text, source) VALUES
(1, 'headline', 'en', 'Not sure which AI tool to choose?', 'manual'),
(1, 'subtext',  'en', 'Ask Eli — she will find a tool that fits your task and budget', 'manual'),
(2, 'headline', 'en', 'Support AI LAB HUB', 'manual'),
(2, 'subtext',  'en', 'The project grows thanks to you — every contribution brings new tools closer', 'manual'),
(3, 'headline', 'en', 'Not sure which AI tool to choose?', 'manual'),
(3, 'subtext',  'en', 'Ask Eli — she will find a tool that fits your task and budget', 'manual'),
(4, 'headline', 'en', 'Support AI LAB HUB', 'manual'),
(4, 'subtext',  'en', 'The project grows thanks to you — every contribution brings new tools closer', 'manual');

-- EN-підпис посилання «реклама» у меню CRM кабінету (admin).
INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('account_crm_ads_link', 'en', 'ads', 'manual');

-- =====================================================================
-- Партія (хвиля 9/N): "Публікації", "Чат-боти" (Текст та Чат-боти),
-- "Тренди" (SEO та контент), "Візуалізація даних" (Дизайн та креатив).
--
-- Частина великого проєкту "жодної підкатегорії <10 продуктів" —
-- буде ще кілька таких партій, кожна перезаписує цей файл: беріть
-- свіжу версію перед кожною публікацією на хостингу.
--
-- ДЕДУП: "Beehiiv" (id 420, був лише в "Email-маркетинг"), "Polymer"
-- (id 513, був лише в "Аналіз даних") та "Rows" (id 516, був лише
-- в "Аналіз даних") вже в базі — нових записів не створено, лише
-- додано відповідні категорії/підкатегорії. "BuzzSumo" (id 17) вже
-- прив'язаний і до "Публікації", і до "Тренди" — повторної прив'язки
-- не робилося. "Ada" (customer-service AI, ada.cx) НЕ дублює наявний
-- "Ada Health" (id 44, ada.com, медичний симптом-чекер) — різні
-- компанії й продукти; новий запис названо "Ada CX" для уникнення
-- плутанини в каталозі.
--
-- ЧЕСНО ПРО НЕДОСЯГНЕННЯ МІНІМУМУ: "Тренди" — знайдено 5 нових
-- (BuzzSumo вже враховано раніше, TrendSpottr офіційно закритий,
-- Glimpse/Meltwater не вдалося перевірити — 404 на обох спробуваних
-- URL і вичерпаний пошуковий бюджет).
--
-- Антидубль: усі 26 кандидатських назв перевірено проти products.name.
--
-- id категорій/підкатегорій НЕ хардкодяться — підхоплюються за slug.
-- Локальні id: products 596-617, pricing_plans 1183-1237.
-- Усі запити INSERT IGNORE — повторний імпорт нічого не дублює.
-- Жодних DROP / DELETE / ALTER.
-- created_by = 3, status = 'published' — автоматично.
-- partnership_status — за реальним дослідженням; НЕ критерій відбору.
--
-- ПІДСУМОК ХВИЛІ 9:
--   Публікації          — 7 нових + Beehiiv(лінк) + 2 наявні = 10  ✓
--   Чат-боти            — 6 нових + 4 наявні = 10  ✓
--   Візуалізація даних  — 4 нових + Polymer(лінк) + Rows(лінк) + 4 наявні = 10  ✓
--   Тренди              — 5 нових + 4 наявні = 9   (нижче мінімуму на 1, чесно)
--
-- Публікація: phpMyAdmin бази хостингу -> вкладка SQL -> вставити вміст
-- файлу -> Вперёд.
-- =====================================================================

SET @cat_text   := (SELECT `id` FROM `categories` WHERE `slug` = 'text-chatbots' LIMIT 1);
SET @cat_seo    := (SELECT `id` FROM `categories` WHERE `slug` = 'seo-content' LIMIT 1);
SET @cat_design := (SELECT `id` FROM `categories` WHERE `slug` = 'design-creative' LIMIT 1);

SET @sub_pub     := (SELECT `id` FROM `subcategories` WHERE `slug`='publications'        AND `category_id`=@cat_text   LIMIT 1);
SET @sub_chatbot := (SELECT `id` FROM `subcategories` WHERE `slug`='chatbots'             AND `category_id`=@cat_text   LIMIT 1);
SET @sub_trends  := (SELECT `id` FROM `subcategories` WHERE `slug`='trends'               AND `category_id`=@cat_seo    LIMIT 1);
SET @sub_dataviz := (SELECT `id` FROM `subcategories` WHERE `slug`='data-visualization'   AND `category_id`=@cat_design LIMIT 1);

-- ---------------------------------------------------------------------
-- Дублі — лише нова прив'язка категорії/підкатегорії до вже наявних
-- продуктів (Beehiiv id 420, Polymer id 513, Rows id 516)
-- ---------------------------------------------------------------------
INSERT IGNORE INTO `product_categories` (`product_id`,`category_id`) VALUES
(420, @cat_text);

INSERT IGNORE INTO `product_subcategories` (`product_id`,`subcategory_id`) VALUES
(420, @sub_pub),
(513, @sub_dataviz),
(516, @sub_dataviz);

-- ---------------------------------------------------------------------
-- products (596-617)
-- ---------------------------------------------------------------------
INSERT IGNORE INTO `products`
(`id`,`name`,`logo_url`,`official_url`,`internal_registration_url`,`affiliate_url`,`short_description`,`full_description`,`main_features`,`target_audience`,`platform`,`skill_level`,`status`,`partnership_status`,`created_by`,`created_at`,`updated_at`)
VALUES
-- === Публікації ===
(596,'Taplio',NULL,'https://taplio.com',NULL,NULL,
'AI-коуч для зростання на LinkedIn — генерація постів, прогноз охоплення, автоматизація коментарів.',
'Taplio навчений на понад 3 млн постів LinkedIn і генерує контент у стилі користувача, переписує заголовки, прогнозує охоплення перед публікацією та пропонує AI-відповіді на коментарі. Інтегрується з Claude та ChatGPT через MCP.',
'AI-генерація постів у власному стилі автора\nПрогноз охоплення перед публікацією\nAI-коментарі та відповіді на повідомлення\nПланування публікацій і аналітика LinkedIn',
'LinkedIn-креатори, консультанти, B2B-маркетологи',
'web','none','published','no_partnership',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

(597,'Tweet Hunter',NULL,'https://tweethunter.io',NULL,NULL,
'AI-інструмент для зростання на X (Twitter) — генерація твітів, тредів і автоматизація публікацій.',
'Tweet Hunter дає доступ до бібліотеки 2М+ вірусних твітів, генерує та переписує твіти й треди за допомогою AI, автоматизує планування публікацій і DM-відповіді, відстежує залучення аудиторії.',
'AI-генерація та переписування твітів і тредів\nБібліотека 2М+ вірусних твітів для натхнення\nАвтоматизація публікацій і авто-DM\nАналітика залучення й найкращих твітів',
'X (Twitter) креатори та особисті бренди',
'web','none','published','no_partnership',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

(598,'Ocoya',NULL,'https://www.ocoya.com',NULL,NULL,
'AI-платформа керування соцмережами — генерація підписів, зображень і відео, публікація на 19+ платформах.',
'Ocoya генерує підписи 37 мовами, зображення й відео за допомогою AI, автоматизує розклад публікацій і веде єдиний контент-календар для 19+ соцмереж. Підтримує інтеграцію з AI-асистентами через MCP.',
'AI-генерація підписів, зображень і відео\nПублікація на 19+ соцмережах з єдиного календаря\nАвтоматизація брендового стилю (шрифти, кольори, тон)\nREST API та MCP-інтеграція з AI-асистентами',
'SMM-менеджери, агенції, малий бізнес',
'web','none','published','found',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

(599,'Simplified',NULL,'https://simplified.com',NULL,NULL,
'AI-агент-платформа маркетингу — AI-агент Riley планує, створює й публікує кампанії наскрізно.',
'Simplified поєднує дизайн, відео, копірайтинг, рекламу й соцмережі в одному AI-агенті Riley, який планує кампанію, генерує контент з дотриманням бренд-гайду та публікує на 10+ каналах з чергою затвердження.',
'AI-агент Riley для наскрізного планування кампаній\nГенерація дизайну, відео та копірайтингу\nПублікація на 10+ соцмережах з чергою затвердження\n30+ інтеграцій (Notion, Google Analytics, Slack)',
'Маркетингові команди й малий бізнес',
'web','none','published','no_partnership',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

(600,'ContentStudio',NULL,'https://contentstudio.io',NULL,NULL,
'Платформа керування соцмережами й контентом з AI-генерацією підписів, зображень і хештегів.',
'ContentStudio об''єднує планування, публікацію, аналітику й моніторинг соцмереж в одному календарі. AI генерує підписи, зображення й хештеги, а RSS-агрегація допомагає знаходити контент для публікації.',
'AI-генерація підписів, зображень і хештегів\nЄдиний контент-календар для кількох платформ\nRSS-агрегація контенту та бібліотека матеріалів\nКомандна співпраця із затвердженням постів',
'SMM-команди, агенції, медіа-редакції',
'web','none','published','found',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

(601,'SocialBee',NULL,'https://socialbee.com',NULL,NULL,
'Платформа керування соцмережами з AI-генератором постів і AI-копілотом для стратегії контенту.',
'SocialBee створює, планує й публікує контент на 10 соцмережах з єдиного дашборду. AI Post Generator генерує підписи, візуали й хештеги, а Copilot будує персоналізовану стратегію та готовий до редагування контент.',
'AI Post Generator для підписів, візуалів і хештегів\nAI Copilot для стратегії контенту\nЄдина скринька для коментарів і повідомлень\nКомандна співпраця й черга затвердження постів',
'SMM-менеджери, малий і середній бізнес',
'web','none','published','found',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

(602,'Postwise',NULL,'https://postwise.ai',NULL,NULL,
'AI-платформа для контенту й планування публікацій на X, LinkedIn і Threads.',
'Postwise перетворює ідеї користувача на готові пости для X, LinkedIn і Threads за допомогою AI, допомагає долати "письменницький блок", планує публікації на пів року вперед і відстежує залучення.',
'AI-генерація постів з ідей користувача\nПланування публікацій на до 6 місяців наперед\nПідтримка X, LinkedIn і Threads\nВідстеження залучення аудиторії',
'Особисті бренди та контент-креатори в X/LinkedIn',
'web','none','published','found',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

-- === Чат-боти ===
(603,'Chatbase',NULL,'https://www.chatbase.co',NULL,NULL,
'AI-платформа для створення підтримкових, продажних і продуктових агентів у чаті, email, голосом, WhatsApp і Slack.',
'Chatbase дозволяє підключити джерела даних, визначити роль агента, встановити обмеження та розгорнути AI-агента одним кліком у кількох каналах. Backstage-аналітика підсумовує звернення клієнтів і відстежує тональність і теми розмов.',
'Три типи агентів — підтримка, продажі, продуктові консультації\nРозгортання в чаті, email, голосом, WhatsApp і Slack\nУніфікований інбокс для AI та людей-операторів\nПідтримка кількох LLM (Claude, GPT, Gemini)',
'Компанії, що автоматизують клієнтську підтримку й продажі',
'web','basic','published','found',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

(604,'Voiceflow',NULL,'https://www.voiceflow.com',NULL,NULL,
'Enterprise-платформа для побудови й розгортання AI-агентів у веб, застосунках, WhatsApp, SMS і голосових каналах.',
'Voiceflow поєднує агентні сценарії з детермінованими робочими процесами через глобальні інструкції й обмеження, дозволяючи командам CX створювати, тестувати й розгортати одного агента одразу в кількох каналах. Підтримує кілька LLM (GPT, Claude, Gemini, Llama, Grok) і власні моделі.',
'Побудова агентів через playbooks і воркфлоу\nОдночасне розгортання в кількох каналах\nСпостережуваність з LLM-оцінками якості відповідей\nГотові інтеграції з Salesforce, Zendesk, Shopify, HubSpot',
'Enterprise CX-команди, що автоматизують підтримку клієнтів',
'web','basic','published','found',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

(605,'Landbot',NULL,'https://landbot.io',NULL,NULL,
'No-code платформа для створення AI-чатботів і агентів для сайтів і WhatsApp з автоматизацією кваліфікації лідів.',
'Landbot поєднує структуровані сценарії чат-бота з AI-агентним мисленням; AI Copilot перетворює текстовий опис на готовий воркфлоу за ~15 хвилин. Інтегрується з HubSpot, Salesforce та 500+ інструментами через Zapier/n8n, автоматично кваліфікує лідів на основі даних CRM.',
'AI Copilot — генерація сценарію з тексту\nГібридний підхід: сценарії + AI-міркування\nМультиканальність — сайт і WhatsApp Business\nПередача складних випадків живому оператору зі збереженням контексту',
'Маркетингові та sales-команди для автоматизації лідогенерації й підтримки',
'web','basic','published','found',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

(606,'Tidio',NULL,'https://www.tidio.com',NULL,NULL,
'Платформа клієнтської підтримки, що поєднує AI-агента Lyro з живим чатом і хелпдеском.',
'Tidio пропонує AI-агента Lyro, навчений на перевірених джерелах даних компанії, для обробки звернень людською мовою з дотриманням тону бренду. Включає хелпдеск, живий чат, автоматизацію Flows і понад 120 інтеграцій (Shopify, HubSpot, Zendesk).',
'AI-агент Lyro з людяними відповідями\nХелпдеск і тікет-система\nАвтоматизація Flows для лідів і продажів\n120+ готових інтеграцій',
'Малий і середній бізнес, що автоматизує підтримку клієнтів',
'web,mobile','none','published','found',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

(607,'Crisp',NULL,'https://crisp.chat',NULL,NULL,
'Омніканальна платформа підтримки з AI-агентом Hugo, що автоматизує до 50% звернень клієнтів.',
'Crisp консолідує повідомлення з чат-віджета, email, WhatsApp, Messenger, Instagram та інших каналів у спільному інбоксі. AI-агент Hugo будується за 4 кроки (навчання, воркфлоу, розгортання, вимірювання) без коду, доповнюючись розумними відповідями й авто-підсумками.',
'AI-агент Hugo — no-code побудова за 4 кроки\nСпільний інбокс з 10+ каналами\nБаза знань для самообслуговування клієнтів\nAI-інструменти: розумні відповіді, авто-підсумки',
'Малий і середній бізнес, що автоматизує клієнтську підтримку',
'web,mobile','none','published','found',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

(608,'Ada CX',NULL,'https://www.ada.cx',NULL,NULL,
'Agentic-платформа клієнтської підтримки з AI-агентами, що самостійно вирішують звернення й виконують дії.',
'Ada CX надає AI-агентів для омніканальної підтримки (голос, месенджери, email), що автоматизують складні бізнес-процеси через "playbooks" і інтегруються з корпоративними системами для персоналізації. Має enterprise-рівень комплаєнсу (HIPAA, SOC 2, GDPR, PCI DSS). Не плутати з наявним у каталозі "Ada Health" — інша компанія й інший продукт (медичний симптом-чекер).',
'Агентний AI, що виконує дії, а не лише відповідає\nPlaybooks для автоматизації складних процесів\nОмніканальність — голос, месенджери, email\nEnterprise-комплаєнс (HIPAA, SOC 2, GDPR, PCI DSS)',
'Enterprise-компанії з високими вимогами до комплаєнсу підтримки',
'web','basic','published','found',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

-- === Тренди ===
(609,'Exploding Topics',NULL,'https://explodingtopics.com',NULL,NULL,
'AI-платформа виявлення трендів — знаходить продукти й теми до того, як вони стануть мейнстрімом.',
'Exploding Topics аналізує мільйони точок даних із соцмереж, пошукових систем, форумів, новин, e-commerce та подкастів за допомогою власних ML-моделей, щоб виявляти ринкові зрушення на ранній стадії та прогнозувати зростання інтересу.',
'Виявлення трендових тем і продуктів на основі ML\nАналіз "мета-трендів" — ширших ринкових зрушень\nРаннє виявлення вірусних трендів у TikTok\nTrends API для інтеграції даних у власні інструменти',
'Маркетологи, підприємці та інвестори, що шукають ранні тренди',
'web','none','published','no_partnership',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

(610,'Brand24',NULL,'https://brand24.com',NULL,NULL,
'AI-платформа соціального моніторингу — відстежує згадки бренду й тренди у понад 25 млн джерел у реальному часі.',
'Brand24 моніторить згадки бренду в соцмережах, новинах, блогах, відео, форумах і подкастах 108 мовами, застосовуючи AI-аналіз тональності, виявлення подій (AI Events Detection) та AI-асистента для інсайтів.',
'Моніторинг згадок у реальному часі (25+ млн джерел)\nAI-аналіз тональності 108 мовами\nAI Events Detection та AI Brand Assistant\nВідстеження хештегів і охоплення кампаній',
'Маркетологи та бренд-менеджери, що відстежують репутацію й тренди',
'web','none','published','found',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

(611,'Klue',NULL,'https://klue.com',NULL,NULL,
'AI-платформа конкурентної розвідки — автоматично збирає інтел про конкурентів і генерує контент для продажів.',
'Klue (Compete Agent) автоматично збирає й поширює конкурентну аналітику по організації, генерує контент для дослідження ринку та надає продавцям рекомендації в реальному часі під час угод; Win-Loss Suite аналізує причини перемог/поразок у угодах.',
'Автоматичний збір конкурентної розвідки (Compete Agent)\nAI-генерація battlecards та контенту для продажів\nWin-Loss аналіз на основі AI-інтерв''ю та записів дзвінків\nРекомендації продавцям у реальному часі під час угод',
'Команди продажів і продуктового маркетингу, що відстежують ринкові тренди й конкурентів',
'web','basic','published','no_partnership',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

(612,'Crayon',NULL,'https://www.crayon.co',NULL,NULL,
'AI-платформа конкурентної розвідки — моніторить конкурентів і ринкові зрушення, генерує інсайти й контент для продажів.',
'Crayon AI автоматично моніторить конкурентів, агрегує ринкові інсайти з оцінкою важливості, генерує battlecards і newsletter для команд продажів та інтегрується з CRM/Slack для розповсюдження трендової аналітики.',
'Автоматичний моніторинг конкурентів з AI-скорингом важливості\nAI-генерація battlecards, анонсів і newsletter\nІнтеграції з Salesforce, Slack, Highspot\nАналітика win/loss та впливу на дохід',
'Команди продажів і маркетингу, що відстежують ринкові тренди й конкурентів',
'web','basic','published','no_partnership',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

(613,'Signal AI',NULL,'https://www.signal-ai.com',NULL,NULL,
'AI-платформа медіа- та трендової аналітики для репутаційного менеджменту й виявлення ризиків у реальному часі.',
'Signal AI моніторить 5.5 млн+ статей на день у 226 країнах і 120+ мовах, поєднуючи AI з експертизою людей-аналітиків для виявлення трендів репутації, PR-вимірювання та раннього попередження про ризики й кризи.',
'Моніторинг медіа в реальному часі (5.5 млн+ статей/день)\nAI-виявлення репутаційних і ринкових трендів\nРаннє попередження про кризи (horizon scanning)\nІнтеграції з Claude, ChatGPT, Microsoft Copilot',
'Enterprise-компанії, що відстежують репутацію й ринкові ризики',
'web','basic','published','no_partnership',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

-- === Візуалізація даних ===
(614,'Flourish',NULL,'https://flourish.studio',NULL,NULL,
'No-code платформа інтерактивної візуалізації даних з AI-асистентом Flourish Assistant для швидшого створення графіків.',
'Flourish перетворює дані на інтерактивні графіки, карти й сторітелінг-візуалізації без коду. Flourish Assistant допомагає редагувати й покращувати графіки через AI-підказки, а Flourish Connector інтегрується з MCP-сумісними AI-інструментами для початку роботи над візуалізацією прямо в AI-чаті.',
'AI-асистент для редагування й покращення графіків\nІнтеграція з MCP-сумісними AI-інструментами (Flourish Connector)\nГотові шаблони інтерактивних графіків, карт і сторітелінгу\nПублікація та вбудовування візуалізацій на будь-якому сайті',
'Журналісти, аналітики та команди, що публікують дані для широкої аудиторії',
'web','none','published','no_partnership',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

(615,'Toucan',NULL,'https://www.toucantoco.com',NULL,NULL,
'AI-платформа аналітики для створення дашбордів і data apps — запити природною мовою через "Ask your data".',
'Toucan дозволяє будувати кастомні дашборди самостійно або доручити це AI-агентам ("Crew"). Семантичний шар визначає метрики один раз для використання всюди, а система запам''ятовує бізнес-правила й виправлення користувача для точніших відповідей.',
'Запити до даних природною мовою ("Ask your data")\nAI-агенти ("Crew"), що будують дашборди за запитом\nСемантичний шар для єдиних метрик у всіх дашбордах\nВбудована аналітика з row-level безпекою для SaaS',
'Бізнес-команди та SaaS-компанії, що вбудовують аналітику для клієнтів',
'web','basic','published','no_partnership',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

(616,'Visme',NULL,'https://www.visme.co',NULL,NULL,
'AI-платформа візуального контенту — перетворює текстові запити на інфографіку, графіки й дашборди (Visme AI Designer).',
'Visme дозволяє створювати презентації, інфографіку, графіки з даними, соцмедіа-графіку та відео без дизайнерського досвіду. Visme AI Designer перетворює текстові промпти на готові дизайни, а окремі AI-інструменти перетворюють статистику й цифри на візуально привабливі графіки.',
'AI Designer — текстовий промпт перетворюється на дизайн\nАвтоматичне перетворення статистики на графіки й інфографіку\nГотові шаблони презентацій, дашбордів та інфографіки\nBrand Kit та контроль приватності для команд (платні плани)',
'Маркетологи, освітяни та команди без дизайнерського досвіду',
'web,mobile','none','published','found',3,'2026-09-16 00:00:00','2026-09-16 00:00:00'),

(617,'Infogram',NULL,'https://infogram.com',NULL,NULL,
'AI-генератор інфографіки й графіків — автоматично створює візуали, пропонує типи графіків і перетворює зображення на дані.',
'Infogram дозволяє створювати інтерактивну інфографіку, графіки, звіти, карти й дашборди без коду. AI Infographic Maker і AI Chart & Graph Generator автоматично генерують візуали за даними, а AI Chart Recommendations пропонує оптимальний тип графіка для конкретного набору даних.',
'AI-генератор інфографіки та графіків за даними\nAI-рекомендації типу графіка під конкретні дані\nПеретворення зображень на структуровані дані через AI\nВбудовування інтерактивних візуалізацій на сайти без коду',
'Маркетологи, медіа та аналітики, що публікують дані для вебу',
'web','none','published','no_partnership',3,'2026-09-16 00:00:00','2026-09-16 00:00:00');

-- ---------------------------------------------------------------------
-- product_categories
-- ---------------------------------------------------------------------
INSERT IGNORE INTO `product_categories` (`product_id`,`category_id`) VALUES
(596,@cat_text),(597,@cat_text),(598,@cat_text),(599,@cat_text),(600,@cat_text),(601,@cat_text),(602,@cat_text),
(603,@cat_text),(604,@cat_text),(605,@cat_text),(606,@cat_text),(607,@cat_text),(608,@cat_text),
(609,@cat_seo),(610,@cat_seo),(611,@cat_seo),(612,@cat_seo),(613,@cat_seo),
(614,@cat_design),(615,@cat_design),(616,@cat_design),(617,@cat_design);

-- ---------------------------------------------------------------------
-- product_subcategories
-- ---------------------------------------------------------------------
INSERT IGNORE INTO `product_subcategories` (`product_id`,`subcategory_id`) VALUES
(596,@sub_pub),(597,@sub_pub),(598,@sub_pub),(599,@sub_pub),(600,@sub_pub),(601,@sub_pub),(602,@sub_pub),
(603,@sub_chatbot),(604,@sub_chatbot),(605,@sub_chatbot),(606,@sub_chatbot),(607,@sub_chatbot),(608,@sub_chatbot),
(609,@sub_trends),(610,@sub_trends),(611,@sub_trends),(612,@sub_trends),(613,@sub_trends),
(614,@sub_dataviz),(615,@sub_dataviz),(616,@sub_dataviz),(617,@sub_dataviz);

-- ---------------------------------------------------------------------
-- pricing_plans (1183-1237)
-- ---------------------------------------------------------------------
INSERT IGNORE INTO `pricing_plans` (`id`,`product_id`,`plan_name`,`price`,`period`,`description`) VALUES
-- Taplio
(1183,596,'Стартовий',39.00,'month','базовий доступ до AI-написання й планування'),
-- Tweet Hunter
(1184,597,'Базовий',49.00,'month','планування й аналітика без AI-написання'),
(1185,597,'Преміум',99.00,'month','з AI-генерацією контенту'),
-- Ocoya
(1186,598,'Starter',29.00,'month','1 користувач, 5 профілів, 300 кредитів'),
(1187,598,'Team',79.00,'month','5 користувачів, 20 профілів, 1500 кредитів'),
(1188,598,'Agency',199.00,'month','20 користувачів, 100 профілів, 5000 кредитів'),
-- Simplified
(1189,599,'Free',0.00,'free','без картки, обмежені кредити'),
(1190,599,'Pro',20.00,'month','розширені AI-кредити'),
(1191,599,'Growth',85.00,'month','максимальний обсяг генерації'),
-- ContentStudio
(1192,600,'Standard',29.00,'month','базовий доступ (19 при річній оплаті)'),
(1193,600,'Advanced',69.00,'month','розширена аналітика (49 при річній оплаті)'),
(1194,600,'Agency Unlimited',139.00,'month','необмежені клієнти (99 при річній оплаті)'),
-- SocialBee
(1195,601,'Bootstrap',29.00,'month','5 профілів, 1 користувач'),
(1196,601,'Accelerate',49.00,'month','10 профілів'),
(1197,601,'Pro',99.00,'month','25 профілів, 3 користувачі'),
-- Postwise
(1198,602,'Basic',37.00,'month','400 AI-кредитів, до 5 акаунтів'),
(1199,602,'Unlimited',97.00,'month','необмежені кредити (річна оплата)'),
-- Chatbase
(1200,603,'Free',0.00,'free','50 повідомлень/міс, 1 учасник'),
(1201,603,'Hobby',40.00,'month','700 кредитів/міс, 2 учасники, базова аналітика'),
(1202,603,'Standard',150.00,'month','4000 кредитів/міс, хелпдеск, голос, телефонія, API'),
(1203,603,'Pro',500.00,'month','15000 кредитів/міс, розширена аналітика'),
-- Voiceflow
(1204,604,'Free trial',0.00,'free','без кредитної картки, usage-based тарифікація далі'),
(1205,604,'Business/Enterprise',0.00,'free','ціна за запитом, точні тарифи не розкриті публічно'),
-- Landbot
(1206,605,'Free',0.00,'free','100 чатів/міс, 1 місце'),
(1207,605,'Starter',40.00,'month','500 чатів/міс, 100 AI-чатів, 2 місця'),
(1208,605,'Professional',100.00,'month','2500 чатів/міс, 300 AI-чатів, 3 місця'),
(1209,605,'Professional WhatsApp',160.00,'month','+1 номер WhatsApp, 10000 повідомлень'),
-- Tidio
(1210,606,'Free',0.00,'free','50 розмов з Lyro, 100 відвідувачів Flows'),
(1211,606,'Starter',24.17,'month','100 оплачуваних розмов, базова аналітика'),
(1212,606,'Growth',49.17,'month','від 250 розмов, розширена аналітика'),
(1213,606,'Plus',300.00,'month','від 300/міс + оплата за використання, персональний менеджер'),
-- Crisp
(1214,607,'Free',0.00,'free','2 місця, чат-віджет, спільний інбокс'),
(1215,607,'Mini',45.00,'month','4 місця, ~$5 AI-кредитів (~90 розмов)'),
(1216,607,'Essentials',95.00,'month','10 місць, ~$25 AI-кредитів, AI-чатбот, база знань'),
(1217,607,'Plus',295.00,'month','20+ місць, ~$75 AI-кредитів, білий лейбл'),
-- Ada CX
(1218,608,'Enterprise',0.00,'free','ціна не розкрита публічно, лише за запитом'),
-- Exploding Topics
(1219,609,'Pro',39.00,'month','орієнтовно $39/міс (від $1.29/день), 7-денний безкоштовний пробний період'),
-- Brand24
(1220,610,'Individual',199.00,'month','3 ключових слова, 2К згадок/міс, AI Sentiment (річна оплата)'),
(1221,610,'Team',299.00,'month','7 ключових слів, 10К згадок/міс'),
(1222,610,'Pro',399.00,'month','12 ключових слів, повний набір AI-функцій'),
(1223,610,'Business',599.00,'month','25 ключових слів, 100К згадок/міс'),
-- Klue
(1224,611,'Enterprise',0.00,'free','ціна не розкрита, лише за запитом'),
-- Crayon
(1225,612,'Enterprise',0.00,'free','ціна не розкрита, лише за запитом'),
-- Signal AI
(1226,613,'Enterprise',0.00,'free','ціна не розкрита, лише за запитом'),
-- Flourish
(1227,614,'Free',0.00,'free','для навчання й дослідження інтерактивного сторітелінгу'),
(1228,614,'Publisher/Enterprise',0.00,'free','кастомна ціна за запитом до відділу продажів'),
-- Toucan
(1229,615,'Стандартний план',0.00,'free','точна ціна не розкрита, залежить від плану'),
(1230,615,'Custom Apps',0.00,'free','кастомна ціна за запитом'),
-- Visme
(1231,616,'Basic',0.00,'free','необмежені проєкти, обмежені шаблони, з водяним знаком'),
(1232,616,'Starter',12.25,'month','річна оплата $147/рік, преміум-шаблони й повний доступ'),
(1233,616,'Pro',24.75,'month','річна оплата $297/рік, експорт PPTX/відео/GIF, Brand Kit, аналітика'),
-- Infogram
(1234,617,'Basic',0.00,'free','базовий безкоштовний доступ'),
(1235,617,'Pro',19.00,'month','річна оплата, преміум-шаблони й HD-експорт'),
(1236,617,'Business',67.00,'month','річна оплата, брендування логотипом/кольорами, аналітика'),
(1237,617,'Team',149.00,'month','річна оплата, 3-10 користувачів, спільна робота');

-- =====================================================================
-- Оновлення картки "Learna AI" (id 339, education-knowledge/tutoring).
--
-- Запис уже існував локально (створений раніше), але жодного разу не
-- потрапляв у increment_latest.sql — на хостингу його ще немає, тому
-- цей блок додає його вперше (а не оновлює). Антидубль за назвою
-- "Learna" перевірено — інших збігів немає.
--
-- Оновлено short/full_description, main_features, target_audience,
-- platform (додано web) і partnership_status (found) під час підготовки
-- статті блогу "AI для вивчення мов".
--
-- Тарифні плани НЕ актуалізовано: ailearna.com — SPA на Nuxt.js, ціни
-- рендеряться JS-ом і недоступні звичайним HTTP-запитом (WebFetch/curl
-- бачать порожній каркас); лишено попередні орієнтовні значення, поки
-- хтось не перевірить сайт вручну в браузері.
--
-- INSERT IGNORE — повторний імпорт нічого не дублює.
-- =====================================================================

SET @cat_edu      := (SELECT `id` FROM `categories`    WHERE `slug` = 'education-knowledge' LIMIT 1);
SET @sub_tutoring := (SELECT `id` FROM `subcategories` WHERE `slug` = 'tutoring' AND `category_id` = @cat_edu LIMIT 1);

INSERT IGNORE INTO `products`
(`id`,`name`,`logo_url`,`official_url`,`internal_registration_url`,`affiliate_url`,`short_description`,`full_description`,`main_features`,`target_audience`,`platform`,`skill_level`,`status`,`partnership_status`,`created_by`,`created_at`,`updated_at`)
VALUES
(339,'Learna AI',NULL,'https://ailearna.com',NULL,NULL,
'AI-тьютор для розмовної практики англійської та іспанської мов: віртуальний співрозмовник, миттєвий фідбек з граматики та вимови, персоналізовані уроки під рівень і цілі користувача.',
'Learna — застосунок, що поєднує структуровані уроки граматики, словниковий запас, читання й вимову з розмовною практикою через AI-персонажа. Підлаштовується під рівень, цілі та вільний час учня з першого заняття. Підходить для підготовки до реальних розмов (робота, подорожі, повсякденне спілкування) та для базових форматів на кшталт IELTS speaking-практики.',
'розмовна практика з AI-персонажем\nмиттєвий фідбек по граматиці й вимові\nуроки граматики під рівень\nщоденна словникова практика\nперевірка орфографії\nперсоналізовані цілі та відстеження прогресу',
'для початківців і середнього рівня, хто хоче почати говорити англійською (і іспанською) без страху помилитись, у власному темпі.',
'web,mobile','none','published','found',3,'2026-09-15 12:00:00','2026-09-15 12:00:00');

INSERT IGNORE INTO `product_categories` (`product_id`,`category_id`) VALUES
(339,@cat_edu);

INSERT IGNORE INTO `product_subcategories` (`product_id`,`subcategory_id`) VALUES
(339,@sub_tutoring);

INSERT IGNORE INTO `pricing_plans` (`id`,`product_id`,`plan_name`,`price`,`period`,`description`) VALUES
(641,339,'Безкоштовний доступ',0.00,'free','обмежений доступ до розмовної практики'),
(642,339,'Learna Pro',9.99,'month','необмежена розмовна практика, тарифи варіюються $7.39-17.99/міс');
