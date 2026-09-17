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
