-- =====================================================================
-- AI LAB HUB — схема бази даних
-- MySQL 8.x / InnoDB / utf8mb4
-- =====================================================================

CREATE DATABASE IF NOT EXISTS ailabhub_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE ailabhub_db;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS saved_products;
DROP TABLE IF EXISTS pricing_plans;
DROP TABLE IF EXISTS product_subcategories;
DROP TABLE IF EXISTS product_categories;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS subcategories;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS admin_requests;
DROP TABLE IF EXISTS employee_requests;
DROP TABLE IF EXISTS users;

SET FOREIGN_KEY_CHECKS = 1;

-- ---------------------------------------------------------------------
-- users
-- «guest» — це неавторизований відвідувач, у таблиці не зберігається.
-- Зберігаються лише реальні акаунти: user / employee / admin.
-- ---------------------------------------------------------------------
CREATE TABLE users (
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name            VARCHAR(255) NOT NULL,
    email           VARCHAR(255) NOT NULL,
    password_hash   VARCHAR(255) NOT NULL,
    role            ENUM('user', 'employee', 'admin') NOT NULL DEFAULT 'user',
    first_name      VARCHAR(255) NULL,
    last_name       VARCHAR(255) NULL,
    phone           VARCHAR(32) NULL,
    employee_number INT UNSIGNED NULL,
    -- Посада директора (людський підпис: «Генеральний директор» /
    -- «Виконавчий директор»). Роль лишається 'admin' — це технічний
    -- рівень доступу до CRM; посада — окрема мітка для кабінету/CRM.
    `position`      VARCHAR(255) NULL,
    created_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_users_email (email),
    UNIQUE KEY uq_users_employee_number (employee_number)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- employee_requests — заявки «Стати працівником».
-- Користувач подає заявку з кабінету (last_name / first_name
-- обов'язкові). Admin схвалює: користувачу присвоюється роль
-- employee, наступний послідовний employee_number і зберігаються
-- прізвище / ім'я в users.
-- ---------------------------------------------------------------------
CREATE TABLE employee_requests (
    id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id     INT UNSIGNED NOT NULL,
    last_name   VARCHAR(255) NOT NULL,
    first_name  VARCHAR(255) NOT NULL,
    status      ENUM('pending', 'approved', 'rejected') NOT NULL DEFAULT 'pending',
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reviewed_at TIMESTAMP NULL,
    reviewed_by INT UNSIGNED NULL,
    PRIMARY KEY (id),
    KEY idx_employee_requests_user (user_id),
    KEY idx_employee_requests_status (status),
    CONSTRAINT fk_employee_requests_user
        FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_employee_requests_reviewed_by
        FOREIGN KEY (reviewed_by) REFERENCES users (id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- admin_requests — приватні заявки на призначення.
-- Окремо від employee_requests: доступ лише за прямим посиланням, ніде
-- на сайті не рекламується. Три незалежні форми пишуть сюди:
--   * public/apply-admin.php          -> position = NULL  (роль Адміністратора)
--   * public/apply-ceo.php            -> position = 'ceo'
--   * public/apply-exec-director.php  -> position = 'exec_director'
-- first_name / last_name / phone / email — контакт кандидата на момент
-- подачі (лише форми директорів; для apply-admin.php лишаються NULL).
-- Заявки з посадою підтверджує ВИКЛЮЧНО власниця проєкту (перевірка на
-- email у public/account.php). Ліміт: Генеральний — 1, Виконавчий — 2
-- (контролюється кодом, не БД). Заявки без посади — будь-який чинний admin.
-- ---------------------------------------------------------------------
CREATE TABLE admin_requests (
    id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id      INT UNSIGNED NOT NULL,
    `position`   VARCHAR(32) NULL,
    first_name   VARCHAR(255) NULL,
    last_name    VARCHAR(255) NULL,
    phone        VARCHAR(32) NULL,
    email        VARCHAR(255) NULL,
    status       ENUM('pending', 'approved', 'rejected') NOT NULL DEFAULT 'pending',
    requested_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reviewed_by  INT UNSIGNED NULL,
    reviewed_at  TIMESTAMP NULL,
    PRIMARY KEY (id),
    KEY idx_admin_requests_user (user_id),
    KEY idx_admin_requests_status (status),
    KEY idx_admin_requests_position (`position`),
    CONSTRAINT fk_admin_requests_user
        FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_admin_requests_reviewed_by
        FOREIGN KEY (reviewed_by) REFERENCES users (id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- categories
-- ---------------------------------------------------------------------
CREATE TABLE categories (
    id      INT UNSIGNED NOT NULL AUTO_INCREMENT,
    name    VARCHAR(255) NOT NULL,
    name_en VARCHAR(255) NULL,
    slug    VARCHAR(255) NOT NULL,
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
    name_en     VARCHAR(255) NULL,
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
    short_description_en      VARCHAR(500) NULL,
    full_description          TEXT NULL,
    full_description_en       TEXT NULL,
    main_features             TEXT NULL,
    main_features_en          TEXT NULL,
    target_audience           TEXT NULL,
    target_audience_en        TEXT NULL,
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
    KEY idx_products_name (name),
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
    plan_name_en VARCHAR(255) NULL,
    price       DECIMAL(10, 2) NULL,
    period      ENUM('free', 'week', 'month', 'year', 'one_time') NOT NULL DEFAULT 'free',
    description TEXT NULL,
    description_en TEXT NULL,
    PRIMARY KEY (id),
    KEY idx_pricing_plans_product (product_id),
    CONSTRAINT fk_pricing_plans_product
        FOREIGN KEY (product_id) REFERENCES products (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- saved_products — «Моя добірка»: продукти, які користувач зберіг у
-- кабінеті. UNIQUE (user_id, product_id) — один продукт лише раз;
-- toggle-ендпоінт public/api-saved-products.php додає/прибирає рядок.
-- ---------------------------------------------------------------------
CREATE TABLE saved_products (
    id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id    INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_saved_user_product (user_id, product_id),
    KEY idx_saved_user (user_id),
    KEY idx_saved_product (product_id),
    CONSTRAINT fk_saved_user
        FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_saved_product
        FOREIGN KEY (product_id) REFERENCES products (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- login_tokens — одноразові токени входу без пароля (magic link),
-- public/forgot-password.php видає, public/login-via-token.php приймає.
-- token = bin2hex(random_bytes(32)), 15 хв на використання, одноразовий.
-- ---------------------------------------------------------------------
CREATE TABLE login_tokens (
    id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id    INT UNSIGNED NOT NULL,
    token      CHAR(64) NOT NULL,
    expires_at DATETIME NOT NULL,
    used_at    DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_login_tokens_token (token),
    KEY idx_login_tokens_user (user_id),
    CONSTRAINT fk_login_tokens_user
        FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- position_applications — універсальна система заявок на посаду (заміна
-- окремих форм apply-ceo.php/apply-exec-director.php). Власниця вписує
-- position_title і створює посилання (public/account.php); кандидат
-- заповнює контакти за токеном (public/apply-position.php); підтвердження
-- (будь-який admin) виставляє users.role='admin' і users.position.
-- Кандидат має вже мати акаунт з тим email — новий акаунт не створюється.
-- ---------------------------------------------------------------------
CREATE TABLE position_applications (
    id             INT UNSIGNED NOT NULL AUTO_INCREMENT,
    position_title VARCHAR(255) NOT NULL,
    token          CHAR(64) NOT NULL,
    last_name      VARCHAR(255) NULL,
    first_name     VARCHAR(255) NULL,
    email          VARCHAR(255) NULL,
    phone          VARCHAR(32) NULL,
    status         ENUM('pending', 'submitted', 'confirmed') NOT NULL DEFAULT 'pending',
    created_by     INT UNSIGNED NOT NULL,
    created_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    submitted_at   DATETIME NULL,
    confirmed_at   DATETIME NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_position_applications_token (token),
    KEY idx_position_applications_status (status),
    KEY idx_position_applications_created_by (created_by),
    CONSTRAINT fk_position_applications_created_by
        FOREIGN KEY (created_by) REFERENCES users (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- =====================================================================
-- Довідкові дані: затверджений список напрямків (categories, 12) та
-- їхніх підкатегорій (subcategories, 54). Продукти додаються окремо
-- через CRM.
-- 2026-09-06: прибрано порожні підкатегорії; категорію «Дані та
-- аналітика» (id 5) згорнуто у «Дизайн та креатив» — див.
-- database/migration-2026-09-06-taxonomy-reconcile.sql. id 5 та id
-- прибраних підкатегорій більше не використовуються.
-- =====================================================================

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
-- Дизайн та креатив (8) — вбирає напрямки колишньої «Дані та аналітика»
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
