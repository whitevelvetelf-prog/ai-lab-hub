-- =====================================================================
-- AI LAB HUB — довідкові дані (seed)
-- Виконувати ПІСЛЯ database/schema.sql:
--   mysql -h 127.0.0.1 -u root < database/seed.sql
-- Скрипт ідемпотентний — очищає таблиці й наповнює їх заново.
-- Наповнює лише напрямки (categories) та підкатегорії (subcategories).
-- Реальні продукти додаються по одному через CRM.
-- =====================================================================

USE ailabhub_db;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE pricing_plans;
TRUNCATE TABLE product_subcategories;
TRUNCATE TABLE product_categories;
TRUNCATE TABLE products;
TRUNCATE TABLE subcategories;
TRUNCATE TABLE categories;
SET FOREIGN_KEY_CHECKS = 1;

-- ---------------------------------------------------------------------
-- categories — затверджений список: 12 напрямків.
-- «Дані та аналітика» згорнуто у «Дизайн та креатив» (2026-09-06),
-- id 5 більше не використовується.
-- ---------------------------------------------------------------------
INSERT INTO categories (id, name, slug) VALUES
(1,  'Мультимедіа',                  'multimedia'),
(2,  'Текст та Чат-боти',            'text-chatbots'),
(3,  'Розробка та IT',               'development-it'),
(4,  'Бізнес та маркетинг',          'business-marketing'),
(6,  'Продуктивність',               'productivity'),
(7,  'SEO та контент',               'seo-content'),
(8,  'Дизайн та креатив',            'design-creative'),
(9,  'Освіта та знання',             'education-knowledge'),
(10, 'Переклад та мови',             'translation-languages'),
(11, 'Фінанси та юридичні',          'finance-legal'),
(12, 'Здоров''я та краса',           'health-beauty'),
(13, 'Інструменти та автоматизація', 'tools-automation');

-- ---------------------------------------------------------------------
-- subcategories
-- ---------------------------------------------------------------------
-- Затверджений список: 54 підкатегорії. Порожні (0 продуктів)
-- прибрано 2026-09-06; трійку «Дані та аналітика» злито з наявними
-- відповідниками в «Дизайн та креатив».
INSERT INTO subcategories (id, category_id, name, slug) VALUES
-- Мультимедіа (1)
(1,  1, 'Генерація відео',        'video-generation'),
(2,  1, 'Генерація зображень',    'image-generation'),
(3,  1, 'Озвучення',              'voiceover'),
(16, 1, 'Аудіо',                  'audio'),
(17, 1, 'Фотографія',             'photography'),
(18, 1, 'Відеомонтаж',            'video-editing'),
(19, 1, 'Музика',                 'music'),
(20, 1, '3D та анімація',         '3d-animation'),
-- Текст та Чат-боти (2)
(4,  2, 'Нотатки та організація', 'notes'),
(5,  2, 'Чат-боти',               'chatbots'),
(6,  2, 'Копірайтинг',            'copywriting'),
(21, 2, 'Публікації',             'publications'),
-- Розробка та IT (3)
(7,  3, 'Асистенти коду',         'code-assistants'),
(8,  3, 'Рефакторинг',            'refactoring'),
(9,  3, 'Автодоповнення коду',    'code-autocomplete'),
(33, 3, 'Веб-розробка',           'web-development'),
(34, 3, 'Мобільна розробка',      'mobile-development'),
(35, 3, 'Бази даних',             'databases'),
(36, 3, 'Хмарні сервіси',         'cloud-services'),
(37, 3, 'Тестування',             'testing'),
(38, 3, 'API',                    'api'),
-- Бізнес та маркетинг (4)
(12, 4, 'SMM',                    'smm'),
(28, 4, 'Аналітика',              'analytics'),
(29, 4, 'Лідогенерація',          'lead-generation'),
(30, 4, 'Email-маркетинг',        'email-marketing'),
(32, 4, 'CRM',                    'crm'),
-- Продуктивність (6)
(22, 6, 'Планування',             'planning'),
(26, 6, 'Нотатки',                'notes'),
(27, 6, 'Тайм-менеджмент',        'time-management'),
-- SEO та контент (7)
(39, 7, 'SEO',                    'seo'),
(42, 7, 'Тренди',                 'trends'),
-- Дизайн та креатив (8) — містить напрямки колишньої «Дані та аналітика»
(43, 8, 'Графічний дизайн',       'graphic-design'),
(44, 8, 'UI/UX',                  'ui-ux'),
(46, 8, 'Кольори',                'colors'),
(47, 8, 'Візуалізація даних',     'data-visualization'),
(48, 8, 'Аналіз даних',           'data-analysis'),
(49, 8, 'Звіти',                  'reports'),
-- Освіта та знання (9)
(50, 9, 'Курси',                  'courses'),
(51, 9, 'Сертифікати',            'certificates'),
(52, 9, 'Менторство',             'mentorship'),
(53, 9, 'Бібліотека',             'library'),
(54, 9, 'Тести',                  'tests'),
-- Переклад та мови (10)
(55, 10, 'Переклад',              'translation'),
(57, 10, 'Розпізнавання мови',    'speech-recognition'),
-- Фінанси та юридичні (11)
(59, 11, 'Фінанси',              'finance'),
(60, 11, 'Інвестиції',           'investments'),
(62, 11, 'Юридичні послуги',     'legal-services'),
(63, 11, 'Документи',            'documents'),
-- Здоров''я та краса (12)
(65, 12, 'Медицина',            'medicine'),
(66, 12, 'Краса та стиль',      'beauty-style'),
(67, 12, 'Спорт та фітнес',     'sports-fitness'),
-- Інструменти та автоматизація (13)
(68, 13, 'Плагіни',             'plugins'),
(69, 13, 'Автоматизація',       'automation'),
(70, 13, 'Інтеграції',          'integrations');

-- ---------------------------------------------------------------------
-- products / product_categories / product_subcategories / pricing_plans
-- Тестові продукти прибрано. Реальні продукти додаються по одному
-- через CRM (public/crm-add-product.php).
-- ---------------------------------------------------------------------

-- ---------------------------------------------------------------------
-- Підсумок: скільки записів у кожній таблиці
-- ---------------------------------------------------------------------
SELECT 'categories'            AS table_name, COUNT(*) AS record_count FROM categories
UNION ALL SELECT 'subcategories',         COUNT(*) FROM subcategories
UNION ALL SELECT 'products',              COUNT(*) FROM products
UNION ALL SELECT 'product_categories',    COUNT(*) FROM product_categories
UNION ALL SELECT 'product_subcategories', COUNT(*) FROM product_subcategories
UNION ALL SELECT 'pricing_plans',         COUNT(*) FROM pricing_plans;
