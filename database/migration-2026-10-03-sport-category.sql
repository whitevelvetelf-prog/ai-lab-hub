-- =====================================================================
-- AI LAB HUB — міграція: нова категорія «Спорт» (14-та в списку)
--
--   * Нова категорія «Спорт» (slug sports).
--   * Підкатегорія «Спорт та фітнес» (slug sports-fitness) перейменовується
--     на «Масовий фітнес і тренування» і переходить зі «Здоров'я та краса»
--     до «Спорту». Продукти лишаються прив'язані до неї (product_subcategories
--     не чіпаємо); slug не змінюється, тож посилання й іконка зберігаються.
--   * product_categories: усі продукти підкатегорії отримують категорію
--     «Спорт»; зв'язок зі «Здоров'я та краса» знімається лише в тих, у кого
--     немає жодної іншої підкатегорії «Здоров'я та краса».
--   * 4 нові підкатегорії «Спорту».
--   * Google Health лишається і в «Здоров'я та краса» (підкатегорія «Медицина»);
--     Whoop — ще й у «Моніторинг навантаження та відновлення».
--
--   Без DROP/CREATE і без фіксованих id — усе за slug. Безпечно повторювати:
--   INSERT … WHERE NOT EXISTS / INSERT IGNORE, UPDATE ідемпотентний.
--   Застосування: phpMyAdmin → «Импорт» (як *.sql.zip) або вкладка SQL.
-- =====================================================================

SET NAMES utf8mb4;

START TRANSACTION;

-- 1. Категорія «Спорт»
INSERT INTO categories (name, name_en, slug)
SELECT 'Спорт', 'Sports', 'sports' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM categories WHERE slug = 'sports');

SET @sport  := (SELECT id FROM categories WHERE slug = 'sports');
SET @health := (SELECT id FROM categories WHERE slug = 'health-beauty');

-- 2. «Спорт та фітнес» → «Масовий фітнес і тренування», у категорію «Спорт»
UPDATE subcategories
SET category_id = @sport,
    name        = 'Масовий фітнес і тренування',
    name_en     = 'Fitness & Training'
WHERE slug = 'sports-fitness'
  AND category_id IN (@health, @sport);

SET @fitness := (SELECT id FROM subcategories WHERE category_id = @sport AND slug = 'sports-fitness');

-- Google Health лишається у «Здоров'я та краса» — через підкатегорію «Медицина»
-- (до кроку нижче, щоб зв'язок зі «Здоров'ям» не зняло).
INSERT IGNORE INTO product_subcategories (product_id, subcategory_id)
SELECT p.id, s.id
FROM products p
JOIN subcategories s ON s.slug = 'medicine' AND s.category_id = @health
WHERE p.name = 'Google Health';

-- 3. Продукти підкатегорії → категорія «Спорт»
INSERT IGNORE INTO product_categories (product_id, category_id)
SELECT ps.product_id, @sport
FROM product_subcategories ps
WHERE ps.subcategory_id = @fitness;

-- …і без «Здоров'я та краса», якщо інших підкатегорій звідти в продукту немає
DELETE pc
FROM product_categories pc
JOIN product_subcategories ps
  ON ps.product_id = pc.product_id AND ps.subcategory_id = @fitness
WHERE pc.category_id = @health
  AND NOT EXISTS (
      SELECT 1
      FROM product_subcategories x
      JOIN subcategories s ON s.id = x.subcategory_id
      WHERE x.product_id = pc.product_id
        AND s.category_id = @health
  );

-- 4. Нові підкатегорії «Спорту»
INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @sport, 'Для тренерів', 'For Coaches', 'coaching-tools' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @sport AND slug = 'coaching-tools');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @sport, 'Аналіз техніки та біомеханіка', 'Technique Analysis & Biomechanics', 'technique-biomechanics' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @sport AND slug = 'technique-biomechanics');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @sport, 'Моніторинг навантаження та відновлення', 'Load & Recovery Monitoring', 'load-recovery-monitoring' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @sport AND slug = 'load-recovery-monitoring');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @sport, 'Аналітика, скаутинг та суддівство', 'Analytics, Scouting & Officiating', 'sports-analytics-scouting' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @sport AND slug = 'sports-analytics-scouting');

-- 5. Whoop — ще й у «Моніторинг навантаження та відновлення»
INSERT IGNORE INTO product_subcategories (product_id, subcategory_id)
SELECT p.id, s.id
FROM products p
JOIN subcategories s ON s.slug = 'load-recovery-monitoring' AND s.category_id = @sport
WHERE p.name = 'Whoop';

COMMIT;

-- Перевірка
SELECT s.name, COUNT(ps.product_id) AS products
FROM subcategories s
LEFT JOIN product_subcategories ps ON ps.subcategory_id = s.id
WHERE s.category_id = @sport
GROUP BY s.id, s.name
ORDER BY s.id;
