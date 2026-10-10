SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — міграція 2026-10-07: нова категорія «Релігія» / «Religion» (slug religion)
-- з 11 підкатегоріями світових релігій:
--   * Християнство / Christianity (slug christianity)
--   * Іслам / Islam (slug islam)
--   * Юдаїзм / Judaism (slug judaism)
--   * Індуїзм / Hinduism (slug hinduism)
--   * Буддизм / Buddhism (slug buddhism)
--   * Сикхізм / Sikhism (slug sikhism)
--   * Даосизм і конфуціанство / Taoism & Confucianism (slug taoism-confucianism)
--   * Синтоїзм / Shinto (slug shinto)
--   * Джайнізм / Jainism (slug jainism)
--   * Бахаї / Bahá’í Faith (slug bahai)
--   * Міжрелігійні та загальні / Interfaith & General (slug interfaith)
--   Без DROP/CREATE і без фіксованих id. Безпечно повторювати (WHERE NOT EXISTS).
--   Застосування: phpMyAdmin → «Импорт» або вкладка SQL — ДО партії batches/2026-10-07-religion-*.sql.
-- =====================================================================

INSERT INTO categories (name, name_en, slug)
SELECT 'Релігія', 'Religion', 'religion' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE slug = 'religion');

SET @rel := (SELECT id FROM categories WHERE slug = 'religion');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Християнство', 'Christianity', 'christianity' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'christianity');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Іслам', 'Islam', 'islam' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'islam');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Юдаїзм', 'Judaism', 'judaism' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'judaism');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Індуїзм', 'Hinduism', 'hinduism' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'hinduism');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Буддизм', 'Buddhism', 'buddhism' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'buddhism');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Сикхізм', 'Sikhism', 'sikhism' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'sikhism');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Даосизм і конфуціанство', 'Taoism & Confucianism', 'taoism-confucianism' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'taoism-confucianism');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Синтоїзм', 'Shinto', 'shinto' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'shinto');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Джайнізм', 'Jainism', 'jainism' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'jainism');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Бахаї', 'Bahá’í Faith', 'bahai' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'bahai');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Міжрелігійні та загальні', 'Interfaith & General', 'interfaith' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'interfaith');
