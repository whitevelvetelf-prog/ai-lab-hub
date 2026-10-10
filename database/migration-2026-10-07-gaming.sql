SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — міграція 2026-10-07: нові підгрупи категорії «Мультимедіа» (slug multimedia):
--   * Геймінг / Gaming (slug gaming)
--   Без DROP/CREATE і без фіксованих id. Безпечно повторювати.
--   Застосування: phpMyAdmin → «Импорт» — ДО партії batches/2026-10-07-gaming-*.sql.
-- =====================================================================

SET @rel := (SELECT id FROM categories WHERE slug = 'multimedia');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Геймінг', 'Gaming', 'gaming' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'gaming');


