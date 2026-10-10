SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — міграція 2026-10-07: нові підгрупи категорії «Релігія» (slug religion):
--   * Ахмадія / Ahmadiyya (slug ahmadiyya)
--   * Ісмаїліти / Ismailis (slug ismailis)
--   * Християнська наука / Christian Science (slug christian-science)
--   * Isha Foundation (Садгуру) / Isha Foundation (Sadhguru) (slug isha-foundation)
--   * Self-Realization Fellowship (Йогананда) / Self-Realization Fellowship (Yogananda) (slug self-realization-fellowship)
--   * Мистецтво життя (Art of Living) / Art of Living (slug art-of-living)
--   * Сахаджа-йога / Sahaja Yoga (slug sahaja-yoga)
--   * Еканкар / Eckankar (slug eckankar)
--   * Бахаї / Bahá’í Faith (slug bahai)
--   * Даосизм і конфуціанство / Taoism & Confucianism (slug taoism-confucianism)
--   * Синтоїзм / Shinto (slug shinto)
--   * Джайнізм / Jainism (slug jainism)
--   * Сикхізм / Sikhism (slug sikhism)
-- + перенесення 4 наявних карток з «Індуїзму» в Isha / SRF / Art of Living. Існуючі підгрупи (bahai…sikhism) не дублюються.
--   Без DROP/CREATE і без фіксованих id. Безпечно повторювати.
--   Застосування: phpMyAdmin → «Импорт» — ДО партії batches/2026-10-07-religion-3-*.sql.
-- =====================================================================

SET @rel := (SELECT id FROM categories WHERE slug = 'religion');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Ахмадія', 'Ahmadiyya', 'ahmadiyya' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'ahmadiyya');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Ісмаїліти', 'Ismailis', 'ismailis' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'ismailis');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Християнська наука', 'Christian Science', 'christian-science' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'christian-science');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Isha Foundation (Садгуру)', 'Isha Foundation (Sadhguru)', 'isha-foundation' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'isha-foundation');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Self-Realization Fellowship (Йогананда)', 'Self-Realization Fellowship (Yogananda)', 'self-realization-fellowship' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'self-realization-fellowship');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Мистецтво життя (Art of Living)', 'Art of Living', 'art-of-living' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'art-of-living');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Сахаджа-йога', 'Sahaja Yoga', 'sahaja-yoga' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'sahaja-yoga');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Еканкар', 'Eckankar', 'eckankar' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'eckankar');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Бахаї', 'Bahá’í Faith', 'bahai' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'bahai');

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
SELECT @rel, 'Сикхізм', 'Sikhism', 'sikhism' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'sikhism');

UPDATE product_subcategories ps JOIN products p ON p.id = ps.product_id
JOIN subcategories so ON so.id = ps.subcategory_id AND so.category_id = @rel AND so.slug = 'hinduism'
SET ps.subcategory_id = (SELECT id FROM (SELECT id FROM subcategories WHERE category_id = @rel AND slug = 'isha-foundation') t)
WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(p.official_url, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'isha.sadhguru.org';

UPDATE product_subcategories ps JOIN products p ON p.id = ps.product_id
JOIN subcategories so ON so.id = ps.subcategory_id AND so.category_id = @rel AND so.slug = 'hinduism'
SET ps.subcategory_id = (SELECT id FROM (SELECT id FROM subcategories WHERE category_id = @rel AND slug = 'isha-foundation') t)
WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(p.official_url, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ishakriya.com';

UPDATE product_subcategories ps JOIN products p ON p.id = ps.product_id
JOIN subcategories so ON so.id = ps.subcategory_id AND so.category_id = @rel AND so.slug = 'hinduism'
SET ps.subcategory_id = (SELECT id FROM (SELECT id FROM subcategories WHERE category_id = @rel AND slug = 'self-realization-fellowship') t)
WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(p.official_url, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yogananda.org';

UPDATE product_subcategories ps JOIN products p ON p.id = ps.product_id
JOIN subcategories so ON so.id = ps.subcategory_id AND so.category_id = @rel AND so.slug = 'hinduism'
SET ps.subcategory_id = (SELECT id FROM (SELECT id FROM subcategories WHERE category_id = @rel AND slug = 'art-of-living') t)
WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(p.official_url, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'artofliving.org';
