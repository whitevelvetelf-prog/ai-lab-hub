SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — міграція 2026-10-07: нові підгрупи категорії «Розробка та IT» (slug development-it):
--   * Розробка ігор / Game Development (slug game-development)
--   Без DROP/CREATE і без фіксованих id. Безпечно повторювати.
--   Застосування: phpMyAdmin → «Импорт» — ДО партії batches/2026-10-07-game-development-*.sql.
-- =====================================================================

SET @rel := (SELECT id FROM categories WHERE slug = 'development-it');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Розробка ігор', 'Game Development', 'game-development' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'game-development');


-- Додаткова прив'язка наявних продуктів (Unity, Cursor, GitHub Copilot, Suno) до «Розробка ігор»
SET @gd := (SELECT id FROM subcategories WHERE category_id = @rel AND slug = 'game-development' LIMIT 1);
INSERT IGNORE INTO product_subcategories (product_id, subcategory_id) SELECT p.id, @gd FROM products p WHERE @gd IS NOT NULL AND LOWER(p.name) IN ('unity', 'cursor', 'github copilot', 'suno');
INSERT IGNORE INTO product_categories (product_id, category_id) SELECT p.id, @rel FROM products p WHERE @rel IS NOT NULL AND LOWER(p.name) IN ('unity', 'cursor', 'github copilot', 'suno');
