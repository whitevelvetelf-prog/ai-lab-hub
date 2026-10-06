SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — міграція 2026-10-06: нова підкатегорія «Кіберспорт» (slug esports) у категорії «Спорт».
--   * Підкатегорія «Кіберспорт» / «Esports».
--   * До неї прив'язуються вже наявні кіберспортивні продукти (за нормалізованою адресою, без id):
--     aimlabs.com, blitz.gg, gameleap.com, insights.gg, itero.gg, kovaaks.com, metafy.gg, mobalytics.gg, omnic.ai, playvs.com, refrag.gg, leetify.com, op.gg, porofessor.gg, scope.gg, trophi.ai.
--     Їхні інші підкатегорії не змінюються.
--   Без DROP/CREATE і без фіксованих id. Безпечно повторювати (WHERE NOT EXISTS / INSERT IGNORE).
--   Застосування: phpMyAdmin → «Импорт» або вкладка SQL — ДО партії batches/2026-10-06-esports-*.sql.
-- =====================================================================

SET @sport := (SELECT id FROM categories WHERE slug = 'sports');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @sport, 'Кіберспорт', 'Esports', 'esports' FROM DUAL
WHERE @sport IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @sport AND slug = 'esports');

SET @esports := (SELECT id FROM subcategories WHERE category_id = @sport AND slug = 'esports');

INSERT IGNORE INTO product_subcategories (product_id, subcategory_id)
SELECT p.id, @esports
FROM products p
WHERE @esports IS NOT NULL
  AND LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(p.official_url, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) IN ('aimlabs.com', 'blitz.gg', 'gameleap.com', 'insights.gg', 'itero.gg', 'kovaaks.com', 'metafy.gg', 'mobalytics.gg', 'omnic.ai', 'playvs.com', 'refrag.gg', 'leetify.com', 'op.gg', 'porofessor.gg', 'scope.gg', 'trophi.ai');

INSERT IGNORE INTO product_categories (product_id, category_id)
SELECT ps.product_id, @sport FROM product_subcategories ps WHERE ps.subcategory_id = @esports;
