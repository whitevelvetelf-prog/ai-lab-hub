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
