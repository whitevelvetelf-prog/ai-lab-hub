-- =====================================================================
-- AI LAB HUB — схема бази даних
-- MySQL 8.x / InnoDB / utf8mb4
-- =====================================================================

CREATE DATABASE IF NOT EXISTS ailabhub_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE ailabhub_db;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS pricing_plans;
DROP TABLE IF EXISTS product_subcategories;
DROP TABLE IF EXISTS product_categories;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS subcategories;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS users;

SET FOREIGN_KEY_CHECKS = 1;

-- ---------------------------------------------------------------------
-- users
-- «guest» — це неавторизований відвідувач, у таблиці не зберігається.
-- Зберігаються лише реальні акаунти: user / employee / admin.
-- ---------------------------------------------------------------------
CREATE TABLE users (
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name          VARCHAR(255) NOT NULL,
    email         VARCHAR(255) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    role          ENUM('user', 'employee', 'admin') NOT NULL DEFAULT 'user',
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_users_email (email)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- categories
-- ---------------------------------------------------------------------
CREATE TABLE categories (
    id   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_categories_slug (slug)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- subcategories
-- ---------------------------------------------------------------------
CREATE TABLE subcategories (
    id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    category_id INT UNSIGNED NOT NULL,
    name        VARCHAR(255) NOT NULL,
    slug        VARCHAR(255) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_subcategories_cat_slug (category_id, slug),
    KEY idx_subcategories_category (category_id),
    CONSTRAINT fk_subcategories_category
        FOREIGN KEY (category_id) REFERENCES categories (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- products
--   platform           — SET, бо продукт може працювати на кількох платформах
--   skill_level        — none / basic / course
--   status             — none / in_progress / published (виставляється автоматично)
--   partnership_status — етап роботи з партнеркою:
--       found                 — інструмент знайдено, партнерки ще немає
--       pending_registration  — очікує реєстрації в партнерській програмі
--       partner_connected     — партнерку підключено
--       no_partnership        — партнерська програма відсутня / не потрібна
--   internal_registration_url / affiliate_url — службові посилання, лише для admin
-- ---------------------------------------------------------------------
CREATE TABLE products (
    id                        INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name                      VARCHAR(255) NOT NULL,
    logo_url                  VARCHAR(512) NULL,
    official_url              VARCHAR(512) NULL,
    internal_registration_url TEXT NULL,
    affiliate_url             TEXT NULL,
    short_description         VARCHAR(500) NULL,
    full_description          TEXT NULL,
    main_features             TEXT NULL,
    target_audience           TEXT NULL,
    platform                  SET('web', 'mobile', 'desktop') NULL,
    skill_level               ENUM('none', 'basic', 'course') NOT NULL DEFAULT 'none',
    status                    ENUM('none', 'in_progress', 'published') NOT NULL DEFAULT 'none',
    partnership_status        ENUM('found', 'pending_registration', 'partner_connected', 'no_partnership') NOT NULL DEFAULT 'found',
    created_by                INT UNSIGNED NULL,
    created_at                TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at                TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_products_created_by (created_by),
    KEY idx_products_status (status),
    CONSTRAINT fk_products_created_by
        FOREIGN KEY (created_by) REFERENCES users (id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- product_categories — many-to-many products <-> categories
-- ---------------------------------------------------------------------
CREATE TABLE product_categories (
    product_id  INT UNSIGNED NOT NULL,
    category_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (product_id, category_id),
    KEY idx_pc_category (category_id),
    CONSTRAINT fk_pc_product
        FOREIGN KEY (product_id) REFERENCES products (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_pc_category
        FOREIGN KEY (category_id) REFERENCES categories (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- product_subcategories — many-to-many products <-> subcategories
-- ---------------------------------------------------------------------
CREATE TABLE product_subcategories (
    product_id     INT UNSIGNED NOT NULL,
    subcategory_id INT UNSIGNED NOT NULL,
    PRIMARY KEY (product_id, subcategory_id),
    KEY idx_psc_subcategory (subcategory_id),
    CONSTRAINT fk_psc_product
        FOREIGN KEY (product_id) REFERENCES products (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_psc_subcategory
        FOREIGN KEY (subcategory_id) REFERENCES subcategories (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- pricing_plans
--   period — free / week / month / year / one_time
-- ---------------------------------------------------------------------
CREATE TABLE pricing_plans (
    id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    product_id  INT UNSIGNED NOT NULL,
    plan_name   VARCHAR(255) NOT NULL,
    price       DECIMAL(10, 2) NULL,
    period      ENUM('free', 'week', 'month', 'year', 'one_time') NOT NULL DEFAULT 'free',
    description TEXT NULL,
    PRIMARY KEY (id),
    KEY idx_pricing_plans_product (product_id),
    CONSTRAINT fk_pricing_plans_product
        FOREIGN KEY (product_id) REFERENCES products (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- =====================================================================
-- Довідкові дані: повний список напрямків (categories) та їхніх
-- підкатегорій (subcategories). Продукти додаються окремо через CRM.
-- =====================================================================

INSERT INTO categories (id, name, slug) VALUES
(1,  'Мультимедіа',                  'multimedia'),
(2,  'Текст та Чат-боти',            'text-chatbots'),
(3,  'Розробка та IT',               'development-it'),
(4,  'Бізнес та маркетинг',          'business-marketing'),
(5,  'Дані та аналітика',            'data-analytics'),
(6,  'Продуктивність',               'productivity'),
(7,  'SEO та контент',               'seo-content'),
(8,  'Дизайн та креатив',            'design-creative'),
(9,  'Освіта та знання',             'education-knowledge'),
(10, 'Переклад та мови',             'translation-languages'),
(11, 'Фінанси та юридичні',          'finance-legal'),
(12, 'Здоров''я та краса',           'health-beauty'),
(13, 'Інструменти та автоматизація', 'tools-automation');

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
(10, 4, 'Реклама',                'advertising'),
(11, 4, 'Резюме зустрічей',       'meeting-summaries'),
(12, 4, 'SMM',                    'smm'),
(28, 4, 'Аналітика',              'analytics'),
(29, 4, 'Лідогенерація',          'lead-generation'),
(30, 4, 'Email-маркетинг',        'email-marketing'),
(31, 4, 'E-commerce',             'e-commerce'),
(32, 4, 'CRM',                    'crm'),
-- Дані та аналітика (5)
(13, 5, 'SQL-запити',             'sql-queries'),
(14, 5, 'Візуалізація даних',     'data-visualization'),
(15, 5, 'Звіти',                  'reports'),
-- Продуктивність (6)
(22, 6, 'Планування',             'planning'),
(23, 6, 'Управління цілями',      'goal-management'),
(24, 6, 'Зберігання',             'storage'),
(25, 6, 'Календар',               'calendar'),
(26, 6, 'Нотатки',                'notes'),
(27, 6, 'Тайм-менеджмент',        'time-management'),
-- SEO та контент (7)
(39, 7, 'SEO',                    'seo'),
(40, 7, 'Хештеги',                'hashtags'),
(41, 7, 'Лінкбілдинг',            'link-building'),
(42, 7, 'Тренди',                 'trends'),
-- Дизайн та креатив (8)
(43, 8, 'Графічний дизайн',       'graphic-design'),
(44, 8, 'UI/UX',                  'ui-ux'),
(45, 8, 'Типографіка',            'typography'),
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
(56, 10, 'Словник',               'dictionary'),
(57, 10, 'Розпізнавання мови',    'speech-recognition'),
(58, 10, 'Субтитри',              'subtitles'),
-- Фінанси та юридичні (11)
(59, 11, 'Фінанси',              'finance'),
(60, 11, 'Інвестиції',           'investments'),
(61, 11, 'Платежі',              'payments'),
(62, 11, 'Юридичні послуги',     'legal-services'),
(63, 11, 'Документи',            'documents'),
(64, 11, 'Безпека даних',        'data-security'),
-- Здоров''я та краса (12)
(65, 12, 'Медицина',            'medicine'),
(66, 12, 'Краса та стиль',      'beauty-style'),
(67, 12, 'Спорт та фітнес',     'sports-fitness'),
-- Інструменти та автоматизація (13)
(68, 13, 'Плагіни',             'plugins'),
(69, 13, 'Автоматизація',       'automation'),
(70, 13, 'Інтеграції',          'integrations'),
(71, 13, 'Навігація',           'navigation');
