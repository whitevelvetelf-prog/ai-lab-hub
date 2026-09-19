-- =====================================================================
-- AI LAB HUB — підсумкова синхронізація бази хостингу (hosting-sync.sql)
-- Згенеровано 2026-09-19 з готових міграцій; вставити ЯК Є у phpMyAdmin
-- (вкладка SQL) на базі хостингу. БЕЗ USE / CREATE DATABASE.
--
-- Безпечно: жодних DROP / DELETE / TRUNCATE. Таблиці — CREATE TABLE IF NOT
-- EXISTS; колонки та індекси додаються лише якщо їх ще немає
-- (information_schema + PREPARE); дані — INSERT IGNORE / UPDATE name_en.
-- Повторний запуск нічого не дублює й не затирає.
-- НЕ включено: migration-2026-09-01 (employee-numbers, без захисту від
-- повтору) і 09-06 (taxonomy-reconcile — містить DELETE); вони мали бути
-- застосовані раніше.
-- =====================================================================

SET NAMES utf8mb4;

-- ##################################################################
-- Крок 1: admin_requests + колонки position/phone/first_name/last_name/email  (fix-2026-09-08-hosting.sql)
-- ##################################################################

-- =====================================================================
-- AI LAB HUB — терміновий фікс живої бази (хостинг, phpMyAdmin)
--
-- Один блок. Вставити ЯК Є у вкладку SQL phpMyAdmin (база вже обрана
-- в інтерфейсі — рядок USE не потрібен) і виконати ОДИН раз.
--
-- Що робить:
--   * створює таблицю admin_requests, якщо її ще немає;
--   * додає колонки position / first_name / last_name / phone / email
--     в admin_requests, якщо їх ще немає;
--   * додає індекс на admin_requests.position, якщо його ще немає;
--   * додає колонки position та phone в users, якщо їх ще немає.
--
-- Безпечний для повторного запуску: якщо щось уже додано — цей рядок
-- просто пропускається, помилки не буде.
-- =====================================================================

CREATE TABLE IF NOT EXISTS admin_requests (
  id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id      INT UNSIGNED NOT NULL,
  `position`   VARCHAR(32) NULL,
  first_name   VARCHAR(255) NULL,
  last_name    VARCHAR(255) NULL,
  phone        VARCHAR(32) NULL,
  email        VARCHAR(255) NULL,
  status       ENUM('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  requested_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  reviewed_by  INT UNSIGNED NULL,
  reviewed_at  TIMESTAMP NULL,
  PRIMARY KEY (id),
  KEY idx_admin_requests_user (user_id),
  KEY idx_admin_requests_status (status),
  KEY idx_admin_requests_position (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='admin_requests' AND COLUMN_NAME='position')=0,
  'ALTER TABLE admin_requests ADD COLUMN `position` VARCHAR(32) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='admin_requests' AND COLUMN_NAME='first_name')=0,
  'ALTER TABLE admin_requests ADD COLUMN first_name VARCHAR(255) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='admin_requests' AND COLUMN_NAME='last_name')=0,
  'ALTER TABLE admin_requests ADD COLUMN last_name VARCHAR(255) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='admin_requests' AND COLUMN_NAME='phone')=0,
  'ALTER TABLE admin_requests ADD COLUMN phone VARCHAR(32) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='admin_requests' AND COLUMN_NAME='email')=0,
  'ALTER TABLE admin_requests ADD COLUMN email VARCHAR(255) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.STATISTICS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='admin_requests' AND INDEX_NAME='idx_admin_requests_position')=0,
  'ALTER TABLE admin_requests ADD KEY idx_admin_requests_position (`position`)','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='users' AND COLUMN_NAME='position')=0,
  'ALTER TABLE users ADD COLUMN `position` VARCHAR(255) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='users' AND COLUMN_NAME='phone')=0,
  'ALTER TABLE users ADD COLUMN phone VARCHAR(32) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- ##################################################################
-- Крок 2: saved_products  (migration-2026-09-08-saved-products.sql)
-- ##################################################################

-- =====================================================================
-- AI LAB HUB — міграція: добірка продуктів у кабінеті («Моя добірка»)
--
--   * saved_products — які продукти користувач зберіг у свою добірку.
--       UNIQUE (user_id, product_id) — один продукт у добірці лише раз;
--       toggle-ендпоінт (public/api-saved-products.php) додає/прибирає рядок.
--       FK ON DELETE CASCADE — рядок зникає разом з користувачем/продуктом.
--
-- Існуючі таблиці users / products НЕ змінюються.
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити ЯК Є у вкладку SQL (база вже обрана).
--   * локально через CLI — розкоментувати рядок USE нижче, або:
--       mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-08-saved-products.sql
-- =====================================================================

-- USE ailabhub_db;   -- розкоментуй для локального запуску через CLI; для phpMyAdmin на хостингу не потрібно

CREATE TABLE IF NOT EXISTS saved_products (
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

-- ##################################################################
-- Крок 3: products.is_archived / updated_by_user_id (CRM)  (migration-2026-09-10-crm-archive-audit.sql)
-- ##################################################################

-- =====================================================================
-- AI LAB HUB — міграція: авторство редагування + архівація продуктів у CRM
--
-- Додає дві колонки в `products`:
--   * updated_by_user_id — хто востаннє редагував продукт (FK -> users.id,
--     NULL, ON DELETE SET NULL). Заповнюється формою crm-edit-product.php
--     та діями архів/розархів у crm-list.php.
--   * is_archived — прапорець «завершений» продукт (TINYINT(1), 0/1,
--     default 0). Активний список — is_archived = 0, «Завершені» — = 1.
--     Ставиться ТІЛЬКИ вручну (кнопки в crm-list.php), не автоматично.
--
-- Індекси: idx_products_is_archived (фільтр active/archived на кожному
-- запиті списку), idx_products_updated_by.
--
-- Безпечно для повторного запуску: кожен ALTER обгорнуто в перевірку
-- information_schema — якщо колонка / індекс / FK уже є, рядок пропускається
-- (MySQL 8.4 не підтримує ADD COLUMN IF NOT EXISTS). Жодних DROP.
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити цей файл ЯК Є у вкладку SQL
--     (база вже обрана; рядок USE нижче лишити закоментованим).
--   * локально через CLI — розкоментувати USE або передати базу аргументом:
--       mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-10-crm-archive-audit.sql
-- =====================================================================

-- USE ailabhub_db;   -- розкоментуй для локального запуску через CLI; для phpMyAdmin не потрібно

-- --- products.updated_by_user_id --------------------------------------
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS
              WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'products'
                AND COLUMN_NAME = 'updated_by_user_id') = 0,
  'ALTER TABLE `products` ADD COLUMN `updated_by_user_id` INT UNSIGNED NULL AFTER `created_by`',
  'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.STATISTICS
              WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'products'
                AND INDEX_NAME = 'idx_products_updated_by') = 0,
  'ALTER TABLE `products` ADD KEY `idx_products_updated_by` (`updated_by_user_id`)',
  'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.TABLE_CONSTRAINTS
              WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'products'
                AND CONSTRAINT_NAME = 'fk_products_updated_by') = 0,
  'ALTER TABLE `products` ADD CONSTRAINT `fk_products_updated_by`
     FOREIGN KEY (`updated_by_user_id`) REFERENCES `users` (`id`)
     ON DELETE SET NULL ON UPDATE CASCADE',
  'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- --- products.is_archived -------------------------------------------------
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS
              WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'products'
                AND COLUMN_NAME = 'is_archived') = 0,
  'ALTER TABLE `products` ADD COLUMN `is_archived` TINYINT(1) NOT NULL DEFAULT 0 AFTER `status`',
  'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.STATISTICS
              WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'products'
                AND INDEX_NAME = 'idx_products_is_archived') = 0,
  'ALTER TABLE `products` ADD KEY `idx_products_is_archived` (`is_archived`)',
  'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- ##################################################################
-- Крок 4: categories/subcategories.name_en + переклади  (migration-2026-09-15-category-translations.sql)
-- ##################################################################

-- =====================================================================
-- AI LAB HUB — міграція: англійські назви категорій і підкатегорій
--
--   Причина: назви напрямків (categories.name) і підкатегорій
--   (subcategories.name) зберігались лише українською і виводились
--   напряму з БД в обхід app/translations.php, тож при перемиканні
--   інтерфейсу на EN лишались українською.
--
--   Рішення: додаємо колонку name_en в обидві таблиці й заповнюємо
--   готовим перекладом один раз (без виклику Google Translate API
--   "на льоту" — назв мало, майже не змінюються). Шаблони виводу
--   обирають name / name_en залежно від поточної мови інтерфейсу.
--
--   CRM (public/crm-*.php) лишається лише українською — внутрішній
--   інструмент без перемикача мови, name_en там не використовується.
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити цей файл ЯК Є у вкладку SQL
--     (база вже обрана в інтерфейсі; рядок USE нижче лишити закоментованим).
--   * локально через CLI — розкоментувати рядок USE нижче, або передати
--     базу аргументом:
--       mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-15-category-translations.sql
--
--   Безпечно повторно застосовувати: колонка додається лише якщо її ще
--   немає (реальний MySQL не підтримує синтаксис ADD COLUMN IF NOT EXISTS —
--   це розширення MariaDB; тут той самий ефект через information_schema
--   + підготовлений запит), UPDATE — ідемпотентний.
-- =====================================================================

-- USE ailabhub_db;   -- розкоментуй для локального запуску через CLI; для phpMyAdmin на хостингу не потрібно

SET @db := DATABASE();

SET @sql := (SELECT IF(
    (SELECT COUNT(*) FROM information_schema.COLUMNS
     WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'categories' AND COLUMN_NAME = 'name_en') > 0,
    'SELECT 1',
    'ALTER TABLE categories ADD COLUMN name_en VARCHAR(255) NULL AFTER name'
));
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql := (SELECT IF(
    (SELECT COUNT(*) FROM information_schema.COLUMNS
     WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'subcategories' AND COLUMN_NAME = 'name_en') > 0,
    'SELECT 1',
    'ALTER TABLE subcategories ADD COLUMN name_en VARCHAR(255) NULL AFTER name'
));
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ---------------------------------------------------------------------
-- categories.name_en (13 напрямків)
-- ---------------------------------------------------------------------
UPDATE categories SET name_en = 'Multimedia'                 WHERE id = 1;
UPDATE categories SET name_en = 'Text & Chatbots'             WHERE id = 2;
UPDATE categories SET name_en = 'Development & IT'            WHERE id = 3;
UPDATE categories SET name_en = 'Business & Marketing'        WHERE id = 4;
UPDATE categories SET name_en = 'Productivity'                WHERE id = 6;
UPDATE categories SET name_en = 'SEO & Content'                WHERE id = 7;
UPDATE categories SET name_en = 'Design & Creative'           WHERE id = 8;
UPDATE categories SET name_en = 'Education & Knowledge'       WHERE id = 9;
UPDATE categories SET name_en = 'Translation & Languages'     WHERE id = 10;
UPDATE categories SET name_en = 'Finance & Legal'             WHERE id = 11;
UPDATE categories SET name_en = 'Health & Beauty'             WHERE id = 12;
UPDATE categories SET name_en = 'Tools & Automation'          WHERE id = 13;
UPDATE categories SET name_en = 'My Home'                     WHERE id = 14;

-- ---------------------------------------------------------------------
-- subcategories.name_en (64 підкатегорії)
-- ---------------------------------------------------------------------

-- Мультимедіа (category_id = 1)
UPDATE subcategories SET name_en = 'Video Generation'    WHERE id = 1;
UPDATE subcategories SET name_en = 'Image Generation'    WHERE id = 2;
UPDATE subcategories SET name_en = 'Voiceover'           WHERE id = 3;
UPDATE subcategories SET name_en = 'Audio'               WHERE id = 16;
UPDATE subcategories SET name_en = 'Photography'         WHERE id = 17;
UPDATE subcategories SET name_en = 'Video Editing'       WHERE id = 18;
UPDATE subcategories SET name_en = 'Music'               WHERE id = 19;
UPDATE subcategories SET name_en = '3D & Animation'      WHERE id = 20;

-- Текст та Чат-боти (category_id = 2)
UPDATE subcategories SET name_en = 'Notes & Organization' WHERE id = 4;
UPDATE subcategories SET name_en = 'Chatbots'             WHERE id = 5;
UPDATE subcategories SET name_en = 'Copywriting'          WHERE id = 6;
UPDATE subcategories SET name_en = 'Publications'         WHERE id = 21;

-- Розробка та IT (category_id = 3)
UPDATE subcategories SET name_en = 'Code Assistants'      WHERE id = 7;
UPDATE subcategories SET name_en = 'Refactoring'          WHERE id = 8;
UPDATE subcategories SET name_en = 'Code Autocomplete'    WHERE id = 9;
UPDATE subcategories SET name_en = 'Web Development'      WHERE id = 33;
UPDATE subcategories SET name_en = 'Mobile Development'   WHERE id = 34;
UPDATE subcategories SET name_en = 'Databases'            WHERE id = 35;
UPDATE subcategories SET name_en = 'Cloud Services'       WHERE id = 36;
UPDATE subcategories SET name_en = 'Testing'              WHERE id = 37;
UPDATE subcategories SET name_en = 'API'                  WHERE id = 38;

-- Бізнес та маркетинг (category_id = 4)
UPDATE subcategories SET name_en = 'SMM'                  WHERE id = 12;
UPDATE subcategories SET name_en = 'Analytics'            WHERE id = 28;
UPDATE subcategories SET name_en = 'Lead Generation'      WHERE id = 29;
UPDATE subcategories SET name_en = 'Email Marketing'      WHERE id = 30;
UPDATE subcategories SET name_en = 'CRM'                  WHERE id = 32;

-- Продуктивність (category_id = 6)
UPDATE subcategories SET name_en = 'Planning'             WHERE id = 22;
UPDATE subcategories SET name_en = 'Notes'                WHERE id = 26;
UPDATE subcategories SET name_en = 'Time Management'      WHERE id = 27;

-- SEO та контент (category_id = 7)
UPDATE subcategories SET name_en = 'SEO'                  WHERE id = 39;
UPDATE subcategories SET name_en = 'Trends'               WHERE id = 42;

-- Дизайн та креатив (category_id = 8)
UPDATE subcategories SET name_en = 'Graphic Design'       WHERE id = 43;
UPDATE subcategories SET name_en = 'UI/UX'                WHERE id = 44;
UPDATE subcategories SET name_en = 'Colors'               WHERE id = 46;
UPDATE subcategories SET name_en = 'Data Visualization'   WHERE id = 47;
UPDATE subcategories SET name_en = 'Data Analysis'        WHERE id = 48;
UPDATE subcategories SET name_en = 'Reports'              WHERE id = 49;

-- Освіта та знання (category_id = 9)
UPDATE subcategories SET name_en = 'Courses'              WHERE id = 50;
UPDATE subcategories SET name_en = 'Certificates'         WHERE id = 51;
UPDATE subcategories SET name_en = 'Mentorship'           WHERE id = 52;
UPDATE subcategories SET name_en = 'Library'              WHERE id = 53;
UPDATE subcategories SET name_en = 'Tests'                WHERE id = 54;
UPDATE subcategories SET name_en = 'Tutoring'             WHERE id = 71;

-- Переклад та мови (category_id = 10)
UPDATE subcategories SET name_en = 'Translation'          WHERE id = 55;
UPDATE subcategories SET name_en = 'Speech Recognition'   WHERE id = 57;

-- Фінанси та юридичні (category_id = 11)
UPDATE subcategories SET name_en = 'Finance'              WHERE id = 59;
UPDATE subcategories SET name_en = 'Investments'          WHERE id = 60;
UPDATE subcategories SET name_en = 'Legal Services'       WHERE id = 62;
UPDATE subcategories SET name_en = 'Documents'            WHERE id = 63;

-- Здоров'я та краса (category_id = 12)
UPDATE subcategories SET name_en = 'Medicine'             WHERE id = 65;
UPDATE subcategories SET name_en = 'Beauty & Style'       WHERE id = 66;
UPDATE subcategories SET name_en = 'Sports & Fitness'     WHERE id = 67;

-- Інструменти та автоматизація (category_id = 13)
UPDATE subcategories SET name_en = 'Plugins'              WHERE id = 68;
UPDATE subcategories SET name_en = 'Automation'           WHERE id = 69;
UPDATE subcategories SET name_en = 'Integrations'         WHERE id = 70;

-- Мій дім (category_id = 14)
UPDATE subcategories SET name_en = 'Houseplants'          WHERE id = 75;
UPDATE subcategories SET name_en = 'Garden'               WHERE id = 76;
UPDATE subcategories SET name_en = 'Kitchen Garden'       WHERE id = 77;
UPDATE subcategories SET name_en = 'Pets'                 WHERE id = 78;
UPDATE subcategories SET name_en = 'Livestock'            WHERE id = 79;
UPDATE subcategories SET name_en = 'Poultry'              WHERE id = 80;
UPDATE subcategories SET name_en = 'Fish'                 WHERE id = 81;
UPDATE subcategories SET name_en = 'Beekeeping'           WHERE id = 82;
UPDATE subcategories SET name_en = 'Cooking'              WHERE id = 83;

-- ##################################################################
-- Крок 5: login_tokens  (migration-2026-09-15-login-tokens.sql)
-- ##################################################################

-- =====================================================================
-- AI LAB HUB — міграція: одноразові токени входу без пароля (magic link)
--
--   «Забули пароль?» (public/forgot-password.php) — замість «скинути
--   пароль на новий» користувач отримує на email одноразове посилання,
--   клік по якому одразу авторизує його (public/login-via-token.php).
--
--   token      — bin2hex(random_bytes(32)), 64 hex-символи, не UUID
--                (криптографічно стійкий, непередбачуваний);
--   expires_at — NOW() + 15 хв на момент видачі;
--   used_at    — NULL, поки не використаний; виставляється або коли
--                токен реально використали для входу, або коли його
--                анулювали видачею нового (лишається чинним лише
--                останній надісланий лист — див. forgot-password.php).
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити цей файл ЯК Є у вкладку SQL
--     (база вже обрана в інтерфейсі; рядок USE нижче лишити закоментованим).
--   * локально через CLI — розкоментувати рядок USE нижче, або передати
--     базу аргументом:
--       mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-15-login-tokens.sql
--
--   Безпечно повторно застосовувати: CREATE TABLE IF NOT EXISTS.
-- =====================================================================

-- USE ailabhub_db;   -- розкоментуй для локального запуску через CLI; для phpMyAdmin на хостингу не потрібно

CREATE TABLE IF NOT EXISTS login_tokens (
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

-- ##################################################################
-- Крок 6: position_applications  (migration-2026-09-15-position-applications.sql)
-- ##################################################################

-- =====================================================================
-- AI LAB HUB — міграція: універсальна система заявок на посаду
--
--   Замінює окремі форми під конкретні посади (apply-ceo.php,
--   apply-exec-director.php) на одну гнучку систему: власниця сама
--   вписує назву посади при створенні посилання, кандидат заповнює
--   контактні дані за посиланням.
--
--   Старі таблиці (admin_requests, employee_requests) і старі форми
--   НЕ чіпаємо — лишаються як є, з історичними даними. Новий функціонал
--   іде повністю через цю нову таблицю, паралельно зі старим.
--
--   Кандидат має вже мати акаунт на сайті з тим email, який вкаже у
--   формі (перевіряється і при поданні заявки, і при підтвердженні) —
--   акаунт для нього автоматично НЕ створюється.
--
--   token — bin2hex(random_bytes(32)), як і login_tokens.
--   status: pending (посилання створене, ще не заповнене) ->
--           submitted (кандидат заповнив контакти) ->
--           confirmed (власниця/адмін підтвердили — users.role='admin',
--           users.position = position_title цієї заявки).
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити цей файл ЯК Є у вкладку SQL
--     (база вже обрана в інтерфейсі; рядок USE нижче лишити закоментованим).
--   * локально через CLI — розкоментувати рядок USE нижче, або передати
--     базу аргументом:
--       mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-15-position-applications.sql
--
--   Безпечно повторно застосовувати: CREATE TABLE IF NOT EXISTS.
-- =====================================================================

-- USE ailabhub_db;   -- розкоментуй для локального запуску через CLI; для phpMyAdmin на хостингу не потрібно

CREATE TABLE IF NOT EXISTS position_applications (
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

-- ##################################################################
-- Крок 7: індекс пошуку products.name  (migration-2026-09-15-products-search-index.sql)
-- ##################################################################

-- =====================================================================
-- AI LAB HUB — міграція: індекс для пошуку продуктів за назвою
--
--   Пошукове поле в шапці (public/api-search.php) шукає за
--   products.name через LIKE '%query%'. При ~165+ рядках звичайний
--   повний скан таблиці і так миттєвий — FULLTEXT тут надлишковий
--   (і має свої мінуси: не шукає підрядки, ігнорує короткі слова).
--   Індекс додано на перспективу росту каталогу й для ORDER BY name.
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити цей файл ЯК Є у вкладку SQL
--     (база вже обрана в інтерфейсі; рядок USE нижче лишити закоментованим).
--   * локально через CLI — розкоментувати рядок USE нижче, або передати
--     базу аргументом:
--       mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-15-products-search-index.sql
--
--   Безпечно повторно застосовувати: індекс додається лише якщо його ще
--   немає (реальний MySQL не підтримує синтаксис ADD INDEX IF NOT EXISTS —
--   це розширення MariaDB; тут той самий ефект через information_schema
--   + підготовлений запит).
-- =====================================================================

-- USE ailabhub_db;   -- розкоментуй для локального запуску через CLI; для phpMyAdmin на хостингу не потрібно

SET @db := DATABASE();

SET @sql := (SELECT IF(
    (SELECT COUNT(*) FROM information_schema.STATISTICS
     WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'products' AND INDEX_NAME = 'idx_products_name') > 0,
    'SELECT 1',
    'ALTER TABLE products ADD INDEX idx_products_name (name)'
));
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- ##################################################################
-- Крок 8: англ. колонки products / pricing_plans  (migration-2026-09-16-product-content-en.sql)
-- ##################################################################

-- =====================================================================
-- AI LAB HUB — міграція: англомовний контент картки продукту
--
--   Причина: на product.php лейбли й кнопки перекладаються через
--   app/translations.php, але сам контент картки (short_description,
--   full_description, main_features, target_audience, а також
--   plan_name/description у pricing_plans) зберігався лише українською
--   і виводився напряму з БД в обхід перекладу — тому при EN лишався
--   українською.
--
--   Рішення: додаємо колонки *_en в обидві таблиці (той самий підхід,
--   що й name_en для categories/subcategories). products.name_en НЕ
--   додається — назви продуктів власні, перекладу не потребують.
--   Заповнення значень — окремим кроком (одноразовий batch-скрипт
--   scripts/translate-product-content.php через Google Translation API).
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити цей файл ЯК Є у вкладку SQL
--     (база вже обрана в інтерфейсі; рядок USE нижче лишити закоментованим).
--   * локально через CLI:
--       mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-16-product-content-en.sql
--
--   Безпечно повторно застосовувати: колонка додається лише якщо її ще
--   немає (через information_schema + підготовлений запит — реальний
--   MySQL не підтримує ADD COLUMN IF NOT EXISTS, це розширення MariaDB).
--   Жодних DROP / DELETE / ALTER існуючих колонок.
-- =====================================================================

-- USE ailabhub_db;   -- розкоментуй для локального запуску через CLI; для phpMyAdmin на хостингу не потрібно

SET @db := DATABASE();

-- ---------------------------------------------------------------------
-- products.short_description_en / full_description_en /
--          main_features_en / target_audience_en
-- ---------------------------------------------------------------------
SET @sql := (SELECT IF(
    (SELECT COUNT(*) FROM information_schema.COLUMNS
     WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'products' AND COLUMN_NAME = 'short_description_en') > 0,
    'SELECT 1',
    'ALTER TABLE products ADD COLUMN short_description_en VARCHAR(500) NULL AFTER short_description'
));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql := (SELECT IF(
    (SELECT COUNT(*) FROM information_schema.COLUMNS
     WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'products' AND COLUMN_NAME = 'full_description_en') > 0,
    'SELECT 1',
    'ALTER TABLE products ADD COLUMN full_description_en TEXT NULL AFTER full_description'
));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql := (SELECT IF(
    (SELECT COUNT(*) FROM information_schema.COLUMNS
     WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'products' AND COLUMN_NAME = 'main_features_en') > 0,
    'SELECT 1',
    'ALTER TABLE products ADD COLUMN main_features_en TEXT NULL AFTER main_features'
));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql := (SELECT IF(
    (SELECT COUNT(*) FROM information_schema.COLUMNS
     WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'products' AND COLUMN_NAME = 'target_audience_en') > 0,
    'SELECT 1',
    'ALTER TABLE products ADD COLUMN target_audience_en TEXT NULL AFTER target_audience'
));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- ---------------------------------------------------------------------
-- pricing_plans.plan_name_en / description_en
-- ---------------------------------------------------------------------
SET @sql := (SELECT IF(
    (SELECT COUNT(*) FROM information_schema.COLUMNS
     WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'pricing_plans' AND COLUMN_NAME = 'plan_name_en') > 0,
    'SELECT 1',
    'ALTER TABLE pricing_plans ADD COLUMN plan_name_en VARCHAR(255) NULL AFTER plan_name'
));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

SET @sql := (SELECT IF(
    (SELECT COUNT(*) FROM information_schema.COLUMNS
     WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'pricing_plans' AND COLUMN_NAME = 'description_en') > 0,
    'SELECT 1',
    'ALTER TABLE pricing_plans ADD COLUMN description_en TEXT NULL AFTER description'
));
PREPARE stmt FROM @sql; EXECUTE stmt; DEALLOCATE PREPARE stmt;

-- ##################################################################
-- Крок 9: product_translations, pricing_plan_translations, ui_translations  (migration-2026-09-17-translation-tables.sql)
-- ##################################################################

-- =====================================================================
-- AI LAB HUB — міграція: масштабована архітектура перекладу
--
--   Причина: попередній підхід (колонки *_en у products / pricing_plans,
--   const LANGS у app/translations.php) хардкодив мову прямо в структурі —
--   додавання нової мови означало нову колонку в кожній таблиці.
--
--   Рішення: три мовонезалежні таблиці перекладів, ключовані
--   (сутність, поле, lang). uk — мова оригіналу, завжди читається напряму
--   з products / pricing_plans / app/translations.php, БЕЗ звернення до
--   цих таблиць. Для будь-якої іншої активної мови (зараз лише en):
--   пошук перекладу в таблиці → якщо нема — автопереклад через Google
--   Translation API і кешування (source='auto') → ручна вичитка в CRM
--   позначається source='manual' і більше не перезаписується автопере-
--   кладом. Список активних мов інтерфейсу — config/languages.php,
--   єдине місце, куди дописувати нову мову.
--
--   Колонки *_en у products / pricing_plans (міграції 2026-09-15/16)
--   лишаються в БД незайманими (ADD COLUMN назад не відкатуємо), але
--   код більше їх не читає й не пише — картка продукту (public/product.php)
--   і CRM (public/crm-add-product.php) переведені на product_translations /
--   pricing_plan_translations.
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити цей файл ЯК Є у вкладку SQL
--     (база вже обрана в інтерфейсі; рядок USE нижче лишити закоментованим).
--   * локально через CLI:
--       mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-17-translation-tables.sql
--
--   Безпечно повторно застосовувати: CREATE TABLE IF NOT EXISTS +
--   INSERT IGNORE (унікальний ключ (key_name, lang) не дає дублів).
--   Жодних DROP / DELETE / ALTER існуючих таблиць чи колонок.
-- =====================================================================

-- USE ailabhub_db;   -- розкоментуй для локального запуску через CLI; для phpMyAdmin на хостингу не потрібно

-- ---------------------------------------------------------------------
-- product_translations — переклад полів картки продукту
--   field_name: short_description | full_description | main_features | target_audience
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS product_translations (
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    product_id      INT UNSIGNED NOT NULL,
    field_name      VARCHAR(50) NOT NULL,
    lang            VARCHAR(5) NOT NULL,
    translated_text MEDIUMTEXT NOT NULL,
    source          ENUM('auto', 'manual') NOT NULL DEFAULT 'auto',
    updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uniq_product_field_lang (product_id, field_name, lang),
    CONSTRAINT fk_product_translations_product
        FOREIGN KEY (product_id) REFERENCES products (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- pricing_plan_translations — переклад полів тарифного плану
--   field_name: plan_name | description
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS pricing_plan_translations (
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    plan_id         INT UNSIGNED NOT NULL,
    field_name      VARCHAR(50) NOT NULL,
    lang            VARCHAR(5) NOT NULL,
    translated_text MEDIUMTEXT NOT NULL,
    source          ENUM('auto', 'manual') NOT NULL DEFAULT 'auto',
    updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uniq_plan_field_lang (plan_id, field_name, lang),
    CONSTRAINT fk_pricing_plan_translations_plan
        FOREIGN KEY (plan_id) REFERENCES pricing_plans (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- ui_translations — переклад статичних написів інтерфейсу
--   (те, що раніше жило лише в масиві app/translations.php).
--   key_name — ключ t(), той самий, що й у $GLOBALS['TRANSLATIONS'].
--   Немає FK — ключі не з БД, а з namespace викликів t() у коді.
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ui_translations (
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    key_name        VARCHAR(100) NOT NULL,
    lang            VARCHAR(5) NOT NULL,
    translated_text MEDIUMTEXT NOT NULL,
    source          ENUM('auto', 'manual') NOT NULL DEFAULT 'auto',
    updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uniq_key_lang (key_name, lang)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Наповнення ui_translations готовими EN-перекладами, які вже існували
-- в app/translations.php (написані людиною, source='manual' — тобто
-- API Google Translate тут НЕ витрачається і надалі ці рядки не
-- будуть перезаписані автоперекладом).
-- ---------------------------------------------------------------------
INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('nav_home', 'en', 'Home', 'manual'),
('nav_account', 'en', 'Account', 'manual'),
('nav_saved', 'en', 'My collection', 'manual'),
('nav_login', 'en', 'Log In', 'manual'),
('nav_assistant', 'en', 'Call Assistant', 'manual'),
('nav_assistant_short', 'en', 'Ask Eli', 'manual'),
('nav_menu', 'en', 'Menu', 'manual'),
('lang_switch', 'en', 'Interface language', 'manual'),
('title_home', 'en', 'AI LAB HUB — Home', 'manual'),
('hero_title', 'en', 'AI LAB HUB', 'manual'),
('hero_subtitle', 'en', 'Find an AI tool for any task', 'manual'),
('hero_image_alt', 'en', 'Flask — AI LAB HUB', 'manual'),
('directions_title', 'en', 'AI Directions', 'manual'),
('footer_blog', 'en', 'Blog', 'manual'),
('footer_about', 'en', 'About', 'manual'),
('footer_contacts', 'en', 'Contacts', 'manual'),
('footer_terms', 'en', 'Terms of Use', 'manual'),
('footer_privacy', 'en', 'Privacy Policy', 'manual'),
('footer_support', 'en', 'Support the Project', 'manual'),
('footer_social', 'en', 'Social media', 'manual'),
('title_blog', 'en', 'AI LAB HUB — Blog', 'manual'),
('blog_heading', 'en', 'Blog', 'manual'),
('blog_subtitle', 'en', 'AI tool comparisons and tips on choosing what fits you best.', 'manual'),
('blog_empty', 'en', 'No articles yet.', 'manual'),
('blog_back', 'en', '← Back to blog', 'manual'),
('blog_not_found', 'en', 'Article not found', 'manual'),
('blog_not_found_text', 'en', 'No article exists at this address, or it is not published yet.', 'manual'),
('title_eli', 'en', 'AI LAB HUB — Eli, AI Assistant', 'manual'),
('eli_title', 'en', 'Eli — your AI assistant', 'manual'),
('eli_subtitle', 'en', 'Describe your task — Eli will find the best AI tool', 'manual'),
('eli_video_alt', 'en', 'Eli video', 'manual'),
('eli_greeting', 'en', 'Hello! Tell me what task you need to solve, and I will find the right AI tool for you.', 'manual'),
('eli_input_placeholder', 'en', 'Describe your task…', 'manual'),
('eli_input_aria', 'en', 'Message', 'manual'),
('eli_send', 'en', 'Send', 'manual'),
('eli_tech_error', 'en', 'Sorry, I am experiencing technical difficulties right now. Please try again in a minute.', 'manual'),
('eli_thinking', 'en', 'Eli is thinking…', 'manual'),
('eli_step_label', 'en', 'Step', 'manual'),
('eli_recommend', 'en', 'Recommended', 'manual'),
('eli_default_reply', 'en', 'Here is what I found for you.', 'manual'),
('eli_new_chat', 'en', 'New chat', 'manual'),
('search_placeholder', 'en', 'Search AI tools…', 'manual'),
('search_clear_aria', 'en', 'Clear search', 'manual'),
('search_no_results', 'en', 'Nothing found', 'manual'),
('search_no_results_hint', 'en', 'Try a different search, or', 'manual'),
('search_ask_eli_link', 'en', 'ask Eli', 'manual'),
('search_view_all', 'en', 'View all results', 'manual'),
('search_results_heading', 'en', 'Search results: “%s”', 'manual'),
('catalog_default_title', 'en', 'AI Tools Catalog', 'manual'),
('catalog_subcategory_not_found', 'en', 'Subcategory not found', 'manual'),
('category_not_found', 'en', 'Category not found', 'manual'),
('category_not_found_text', 'en', 'No direction exists with this identifier.', 'manual'),
('category_empty', 'en', 'This direction has no subcategories yet.', 'manual'),
('back_to_direction', 'en', '← Back to direction', 'manual'),
('back_to_all_directions', 'en', '← All directions', 'manual'),
('catalog_empty', 'en', 'There are no published products in this section yet.', 'manual'),
('btn_details', 'en', 'Details', 'manual'),
('price_free', 'en', 'Free', 'manual'),
('price_from', 'en', 'From', 'manual'),
('unit_week', 'en', 'wk', 'manual'),
('unit_month', 'en', 'mo', 'manual'),
('unit_year', 'en', 'yr', 'manual'),
('unit_one_time', 'en', 'one-time', 'manual'),
('product_not_found', 'en', 'Product not found', 'manual'),
('product_not_found_text', 'en', 'No product exists with this identifier, or it is not published yet.', 'manual'),
('back_to_directions', 'en', 'Back to AI directions', 'manual'),
('back_to_eli', 'en', 'Back to Elya\'s picks', 'manual'),
('product_visit_site', 'en', 'Visit website', 'manual'),
('product_features_title', 'en', 'Key features', 'manual'),
('product_audience_title', 'en', 'Who it is for', 'manual'),
('product_plans_title', 'en', 'Pricing plans', 'manual'),
('product_plan_select', 'en', 'Choose', 'manual'),
('product_platform_label', 'en', 'Platform', 'manual'),
('product_skill_label', 'en', 'Skill level', 'manual'),
('platform_web', 'en', 'Web', 'manual'),
('platform_mobile', 'en', 'Mobile', 'manual'),
('platform_desktop', 'en', 'Desktop', 'manual'),
('skill_basic', 'en', 'Basic knowledge required', 'manual'),
('skill_course', 'en', 'Dedicated training required (course)', 'manual'),
('skill_none', 'en', 'No special knowledge required', 'manual'),
('account_title_guest', 'en', 'Your account', 'manual'),
('account_text_guest', 'en', 'Log in to save favorite products and get personal recommendations from Eli.', 'manual'),
('account_create', 'en', 'Create account', 'manual'),
('account_welcome_prefix', 'en', 'Welcome,', 'manual'),
('role_user', 'en', 'User', 'manual'),
('role_employee', 'en', 'Employee', 'manual'),
('role_admin', 'en', 'Administrator', 'manual'),
('account_saved_title', 'en', 'My collection', 'manual'),
('account_saved_empty_prefix', 'en', 'No saved products yet. Check out', 'manual'),
('account_directions_link', 'en', 'AI directions on the homepage', 'manual'),
('account_saved_count', 'en', 'Products in your collection: %d.', 'manual'),
('account_saved_open_link', 'en', 'Open “My collection”', 'manual'),
('title_saved', 'en', 'AI LAB HUB — My collection', 'manual'),
('saved_page_title', 'en', 'My collection', 'manual'),
('saved_empty_text', 'en', 'Your collection is empty. Save tools you like with the paw on a card —', 'manual'),
('saved_empty_link', 'en', 'go to the catalog', 'manual'),
('saved_btn_save', 'en', 'Save to collection', 'manual'),
('saved_btn_unsave', 'en', 'Remove from collection', 'manual'),
('saved_hint_guest', 'en', 'Log in to save', 'manual'),
('saved_error', 'en', 'Something went wrong. Try again.', 'manual'),
('account_stats_title', 'en', 'User statistics', 'manual'),
('stats_total_label', 'en', 'Total', 'manual'),
('stats_users_label', 'en', 'Users', 'manual'),
('stats_employees_label', 'en', 'Employees', 'manual'),
('stats_admins_label', 'en', 'Admins', 'manual'),
('stats_pending_label', 'en', 'Pending requests:', 'manual'),
('account_staff_employees_title', 'en', 'Employees', 'manual'),
('account_staff_admins_title', 'en', 'Administrators', 'manual'),
('account_role_since_prefix', 'en', '· role since', 'manual'),
('account_crm_access_prefix', 'en', 'CRM access:', 'manual'),
('account_crm_list_link', 'en', 'product list', 'manual'),
('account_crm_add_link', 'en', 'add a new AI product', 'manual'),
('account_logout', 'en', 'Log out', 'manual'),
('title_login', 'en', 'AI LAB HUB — Log In', 'manual'),
('login_heading', 'en', 'Log In', 'manual'),
('login_subtitle', 'en', 'Log in to access your account.', 'manual'),
('login_error_invalid', 'en', 'Invalid email or password', 'manual'),
('login_no_account', 'en', 'Don\'t have an account?', 'manual'),
('title_register', 'en', 'AI LAB HUB — Sign Up', 'manual'),
('register_heading', 'en', 'Sign Up', 'manual'),
('register_subtitle', 'en', 'Create an account to save products and get recommendations from Eli.', 'manual'),
('register_have_account', 'en', 'Already have an account?', 'manual'),
('action_register', 'en', 'Sign up', 'manual'),
('field_name', 'en', 'Name', 'manual'),
('field_password', 'en', 'Password', 'manual'),
('field_password_confirm', 'en', 'Confirm password', 'manual'),
('pw_show', 'en', 'Show', 'manual'),
('pw_hide', 'en', 'Hide', 'manual'),
('pw_show_aria', 'en', 'Show password', 'manual'),
('pw_hide_aria', 'en', 'Hide password', 'manual'),
('err_name_required', 'en', 'Please enter your name.', 'manual'),
('err_name_too_long', 'en', 'Name is too long (255 characters max).', 'manual'),
('err_email_required', 'en', 'Please enter your email.', 'manual'),
('err_email_invalid', 'en', 'Invalid email.', 'manual'),
('err_password_short', 'en', 'Password must be at least 8 characters long.', 'manual'),
('err_password_mismatch', 'en', 'Passwords do not match.', 'manual'),
('err_email_taken', 'en', 'A user with this email is already registered.', 'manual'),
('err_register_failed', 'en', 'Could not create account. Please try again.', 'manual'),
('forgot_password_link', 'en', 'Forgot password?', 'manual'),
('title_forgot_password', 'en', 'AI LAB HUB — Forgot Password', 'manual'),
('forgot_heading', 'en', 'Forgot password?', 'manual'),
('forgot_subtitle', 'en', 'Enter your email — we’ll send you a link to log in without a password.', 'manual'),
('forgot_submit', 'en', 'Send login link', 'manual'),
('forgot_success', 'en', 'If this email is registered, a login link has been sent to it.', 'manual'),
('forgot_success_hint', 'en', 'Don\'t see the email after a few minutes — check your Spam folder.', 'manual'),
('forgot_back_login', 'en', '← Back to login', 'manual'),
('mail_login_subject', 'en', 'Log in to AI LAB HUB', 'manual'),
('mail_login_greeting', 'en', 'Hello, %s!', 'manual'),
('mail_login_intro', 'en', 'You (or someone on your behalf) requested passwordless login to AI LAB HUB. Click the button below to log in:', 'manual'),
('mail_login_button', 'en', 'Log in to your account', 'manual'),
('mail_login_fallback', 'en', 'If the button doesn\'t work, copy this link into your browser:', 'manual'),
('mail_login_expiry', 'en', 'This link is valid for %d minutes and works only once. If you didn\'t request this, just ignore this email.', 'manual'),
('token_invalid_title', 'en', 'Link is invalid', 'manual'),
('token_invalid_text', 'en', 'This login link is expired, already used, or invalid.', 'manual'),
('token_invalid_retry', 'en', 'Request a new link', 'manual'),
('flash_request_not_found', 'en', 'Request not found or already processed.', 'manual'),
('flash_request_approved', 'en', 'Request approved. The employee was assigned number #%d.', 'manual'),
('flash_request_approve_failed', 'en', 'Could not approve the request. Please try again.', 'manual'),
('title_apply_admin', 'en', 'AI LAB HUB — Admin Request', 'manual'),
('apply_admin_heading', 'en', 'Administrator Role Request', 'manual'),
('apply_admin_confirm_text', 'en', 'Submit a request for the Administrator role', 'manual'),
('apply_admin_submit', 'en', 'Submit request', 'manual'),
('apply_admin_already_admin', 'en', 'You already have the Administrator role.', 'manual'),
('apply_admin_pending_prefix', 'en', 'Your request is under review (submitted', 'manual'),
('apply_admin_pending_suffix', 'en', '). Please wait for a decision.', 'manual'),
('apply_admin_approved_text', 'en', 'Your request has already been approved.', 'manual'),
('apply_admin_back_account', 'en', 'Back to account', 'manual'),
('account_admin_requests_title', 'en', 'Administrator role requests', 'manual'),
('account_admin_requests_empty', 'en', 'No pending requests.', 'manual'),
('account_requested_prefix', 'en', '· submitted', 'manual'),
('action_approve', 'en', 'Approve', 'manual'),
('action_reject', 'en', 'Reject', 'manual'),
('flash_admin_request_approved', 'en', 'Administrator request approved. The user was granted the Administrator role.', 'manual'),
('flash_admin_request_rejected', 'en', 'Request rejected.', 'manual'),
('flash_admin_request_failed', 'en', 'Could not process the request. Please try again.', 'manual'),
('title_apply_ceo', 'en', 'AI LAB HUB — CEO Position Request', 'manual'),
('title_apply_exec', 'en', 'AI LAB HUB — Executive Director Position Request', 'manual'),
('apply_ceo_heading', 'en', 'CEO Position Request', 'manual'),
('apply_exec_heading', 'en', 'Executive Director Position Request', 'manual'),
('apply_director_intro', 'en', 'Fill in your contact details. The project owner decides personally.', 'manual'),
('apply_director_first_name', 'en', 'First name', 'manual'),
('apply_director_last_name', 'en', 'Last name', 'manual'),
('apply_director_phone', 'en', 'Phone', 'manual'),
('apply_director_email', 'en', 'Email', 'manual'),
('apply_director_email_hint', 'en', 'Must match your account email.', 'manual'),
('apply_director_submit', 'en', 'Submit request', 'manual'),
('apply_director_back_account', 'en', 'Back to account', 'manual'),
('apply_director_err_required', 'en', 'Fill in all fields.', 'manual'),
('apply_director_err_email_invalid', 'en', 'Invalid email.', 'manual'),
('apply_director_err_email_match', 'en', 'The email must match your account email.', 'manual'),
('apply_director_err_too_long', 'en', 'One of the fields is too long.', 'manual'),
('apply_director_pending', 'en', 'Your request for this position has already been submitted. Please wait for a decision.', 'manual'),
('apply_director_approved', 'en', 'Your request for this position has already been approved.', 'manual'),
('account_admin_request_role_label', 'en', 'Administrator role', 'manual'),
('account_admin_request_owner_only_note', 'en', 'Approved by the project owner', 'manual'),
('account_admin_position_full_note', 'en', 'All slots for this position are filled', 'manual'),
('flash_admin_request_owner_only', 'en', 'Only the project owner can approve this request.', 'manual'),
('flash_admin_position_taken', 'en', 'No open slots for the position "%s". The request was left pending.', 'manual'),
('flash_admin_director_approved', 'en', 'Request approved. The candidate was granted CRM access and the position "%s".', 'manual'),
('account_create_position_link_title', 'en', 'Create application link', 'manual'),
('position_title_field', 'en', 'Position title', 'manual'),
('err_position_title_required', 'en', 'Please enter a position title.', 'manual'),
('create_position_link_submit', 'en', 'Create link', 'manual'),
('flash_position_link_created', 'en', 'Link created: %s', 'manual'),
('account_position_apps_title', 'en', 'Position applications', 'manual'),
('account_position_apps_empty', 'en', 'No active applications.', 'manual'),
('position_apps_col_position', 'en', 'Position', 'manual'),
('position_apps_col_candidate', 'en', 'Candidate', 'manual'),
('position_apps_col_status', 'en', 'Status', 'manual'),
('position_apps_col_submitted', 'en', 'Submitted', 'manual'),
('position_apps_status_pending', 'en', 'Awaiting submission', 'manual'),
('position_apps_status_submitted', 'en', 'Under review', 'manual'),
('position_apps_status_confirmed', 'en', 'Confirmed', 'manual'),
('action_confirm_application', 'en', 'Confirm', 'manual'),
('flash_position_app_confirmed', 'en', 'Application confirmed. The user was granted the position "%s" and the Administrator role.', 'manual'),
('flash_position_app_no_user', 'en', 'Could not confirm: no account found for email "%s". The candidate must register before applying.', 'manual'),
('title_apply_position', 'en', 'AI LAB HUB — Position Application', 'manual'),
('apply_position_intro', 'en', 'Fill in your contact details to apply for this position.', 'manual'),
('apply_position_submit', 'en', 'Submit', 'manual'),
('apply_position_thanks_title', 'en', 'Thank you!', 'manual'),
('apply_position_thanks_text', 'en', 'Your application has been sent. We will contact you soon.', 'manual'),
('apply_position_no_account_error', 'en', 'No account found for this email. Please register on the site with this email first, then fill in the form again.', 'manual');

-- ##################################################################
-- Крок 10: UI-рядки кнопки «Поділитися»  (migration-2026-09-17-share-ui-strings.sql)
-- ##################################################################

-- =====================================================================
-- AI LAB HUB — міграція: EN-написи кнопки «Поділитися»
--
--   Нові ключі t() (app/translations.php: share_button, share_copy_link,
--   share_copied, share_email, share_product_text) — готовий людський
--   переклад одразу в ui_translations, source='manual'. Google Translate
--   API тут НЕ витрачається (рядки короткі й прості, автопереклад не
--   потрібен).
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити ЯК Є у вкладку SQL.
--   * локально: mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-17-share-ui-strings.sql
--
--   Безпечно повторно застосовувати: INSERT IGNORE (унікальний ключ
--   (key_name, lang) не дає дублів). Таблиця ui_translations сама
--   створюється в migration-2026-09-17-translation-tables.sql — якщо її
--   ще нема, застосуйте той файл першим.
-- =====================================================================

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('share_button', 'en', 'Share', 'manual'),
('share_copy_link', 'en', 'Copy link', 'manual'),
('share_copied', 'en', 'Link copied', 'manual'),
('share_email', 'en', 'Email', 'manual'),
('share_product_text', 'en', 'Check out %s on AI LAB HUB', 'manual');

-- ##################################################################
-- Крок 11: page_views, link_clicks  (migration-2026-09-18-analytics.sql)
-- ##################################################################

-- =====================================================================
-- AI LAB HUB — міграція: власна аналітика (перегляди, кліки)
--
--   page_views  — перегляд сторінки (app/analytics.php: analytics_log_view()),
--                 викликається з product.php / catalog.php / category.php /
--                 index.php.
--   link_clicks — клік по кнопці «Перейти на сайт» через проміжний
--                 редirect public/go.php (analytics_log_click()).
--
--   session_hash — sha256(session_id + IP), не персональні дані:
--   сам IP у явному вигляді ніде не зберігається, лише як сіль для
--   лічильника унікальних сесій.
--
--   Видно лише admin, на public/admin-stats.php.
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити цей файл ЯК Є у вкладку SQL.
--   * локально: mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-18-analytics.sql
--
--   Безпечно повторно застосовувати: CREATE TABLE IF NOT EXISTS.
--   Жодних DROP / DELETE / ALTER існуючих таблиць чи колонок.
-- =====================================================================

CREATE TABLE IF NOT EXISTS page_views (
    id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
    page_type    ENUM('product', 'article', 'category', 'home', 'other') NOT NULL,
    page_id      INT UNSIGNED NULL,
    viewed_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    session_hash CHAR(64) NOT NULL,
    PRIMARY KEY (id),
    KEY idx_page_views_type_id (page_type, page_id),
    KEY idx_page_views_viewed_at (viewed_at)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS link_clicks (
    id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
    product_id   INT UNSIGNED NOT NULL,
    link_type    ENUM('official', 'affiliate') NOT NULL,
    clicked_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    session_hash CHAR(64) NOT NULL,
    PRIMARY KEY (id),
    KEY idx_link_clicks_product (product_id),
    KEY idx_link_clicks_clicked_at (clicked_at),
    CONSTRAINT fk_link_clicks_product
        FOREIGN KEY (product_id) REFERENCES products (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- EN-переклад нового посилання в кабінеті admin (готовий людський
-- переклад, source='manual' — Google Translate API тут не витрачається).
-- ---------------------------------------------------------------------
INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('account_site_stats_link', 'en', 'Site statistics →', 'manual');

-- ##################################################################
-- Крок 12: campaigns, newsletter_subscribers  (migration-2026-09-18-monetization-foundation.sql)
-- ##################################################################

-- =====================================================================
-- AI LAB HUB — міграція: фундамент монетизації
--
--   1. campaigns — рекламні кампанії (внутрішні заповнювачі й, у
--      майбутньому, платні). campaign_type='paid' має пріоритет над
--      'internal' на однаковому placement; для 'internal' starts_at/
--      ends_at лишаються NULL (без дедлайну). Адмінки для керування
--      кампаніями поки нема — рядки додаються вручну через SQL
--      (id 1-3 нижче — три internal-заповнювачі для placement
--      'homepage_banner', unique за primary key, тож повторний запуск
--      цього файлу нічого не дублює).
--   2. newsletter_subscribers — базовий збір email на розсилку
--      (без інтеграції з сервісом розсилок — це на майбутнє).
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити цей файл ЯК Є у вкладку SQL.
--   * локально: mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-18-monetization-foundation.sql
--
--   Безпечно повторно застосовувати: CREATE TABLE IF NOT EXISTS +
--   INSERT IGNORE з фіксованими id / унікальним ключем. Жодних
--   DROP / DELETE / ALTER існуючих таблиць чи колонок.
-- =====================================================================

-- ---------------------------------------------------------------------
-- campaigns
--   placement — слот показу. Для MVP: homepage_banner (реалізовано
--               на public/index.php), category_sidebar (зарезервовано
--               на майбутнє, поки ніде не рендериться).
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS campaigns (
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    campaign_type ENUM('paid', 'internal') NOT NULL DEFAULT 'internal',
    title         VARCHAR(255) NOT NULL,
    description   VARCHAR(500) NULL,
    image_url     VARCHAR(512) NULL,
    target_url    VARCHAR(512) NOT NULL,
    placement     ENUM('homepage_banner', 'category_sidebar') NOT NULL DEFAULT 'homepage_banner',
    is_active     TINYINT(1) NOT NULL DEFAULT 1,
    starts_at     DATETIME NULL,
    ends_at       DATETIME NULL,
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_campaigns_placement_active (placement, is_active),
    KEY idx_campaigns_type (campaign_type)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- newsletter_subscribers
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS newsletter_subscribers (
    id             INT UNSIGNED NOT NULL AUTO_INCREMENT,
    email          VARCHAR(255) NOT NULL,
    subscribed_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_active      TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (id),
    UNIQUE KEY uniq_newsletter_email (email)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Три internal-заповнювачі для homepage_banner (id фіксовані — INSERT
-- IGNORE не додасть дублів при повторному запуску).
-- ---------------------------------------------------------------------
INSERT IGNORE INTO campaigns (id, campaign_type, title, description, image_url, target_url, placement, is_active, starts_at, ends_at) VALUES
(1, 'internal', 'Здоров''я та краса — новий напрямок!', 'Ми щойно наповнили розділ AI-інструментами для здоров''я та краси. Загляньте, поки він новенький.', NULL, 'category.php?id=12', 'homepage_banner', 1, NULL, NULL),
(2, 'internal', 'Незабаром: готові AI-рішення', 'Ми готуємо Marketplace — готові AI-рішення під ключ для вашого бізнесу. Слідкуйте за оновленнями.', NULL, '#', 'homepage_banner', 1, NULL, NULL),
(3, 'internal', 'Підтримайте AI LAB HUB', 'Проєкт розвивається завдяки вашій підтримці. Кожен внесок наближає нові функції та інструменти.', NULL, 'donate.php', 'homepage_banner', 1, NULL, NULL);

-- ---------------------------------------------------------------------
-- EN-переклади нових написів UI (готовий людський переклад, source='manual' —
-- Google Translate API тут не витрачається).
-- ---------------------------------------------------------------------
INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('footer_disclaimer', 'en', 'AI LAB HUB may earn a commission on purchases made through some links on this site — this does not affect the price you pay.', 'manual'),
('product_affiliate_badge', 'en', 'affiliate link', 'manual'),
('product_affiliate_tooltip', 'en', 'This is an affiliate link: if you use it, AI LAB HUB may earn a small commission.', 'manual'),
('ad_label', 'en', 'Ad', 'manual'),
('newsletter_title', 'en', 'Be the first to know about new AI tools', 'manual'),
('newsletter_placeholder', 'en', 'Your email', 'manual'),
('newsletter_submit', 'en', 'Subscribe', 'manual'),
('newsletter_success', 'en', 'Thank you! You are subscribed.', 'manual'),
('newsletter_already', 'en', 'You are already subscribed.', 'manual'),
('newsletter_error_invalid', 'en', 'Invalid email.', 'manual'),
('newsletter_error_generic', 'en', 'Could not subscribe. Please try again later.', 'manual');

-- ##################################################################
-- Крок 13: нові продукти (INSERT IGNORE)  (increment_latest.sql)
-- ##################################################################

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
