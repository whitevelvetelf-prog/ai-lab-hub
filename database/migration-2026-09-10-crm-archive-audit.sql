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
