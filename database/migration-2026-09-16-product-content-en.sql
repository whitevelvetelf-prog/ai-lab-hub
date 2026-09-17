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
