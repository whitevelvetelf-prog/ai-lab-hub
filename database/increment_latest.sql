-- =====================================================================
-- AI LAB HUB — increment 2026-10-23: «Цифрова пам'ять і спадщина» + стаття ai-digital-memory-loved-ones
--   1) міграція database/migration-2026-10-23-digital-memory.sql (колонки, підкатегорія, no_promo, EN-примітки, інтенти Елі)
--   2) партія database/batches/2026-10-23-digital-memory-63.sql (23 нові продукти + 40 прив'язок)
-- Стаття зберігається у файлах content/blog/ (не в БД); тут для неї лише promo_blog_flags.no_promo = 1.
-- Лише безпечні ALTER / INSERT … WHERE NOT EXISTS / INSERT IGNORE / ON DUPLICATE KEY; без DROP/TRUNCATE/DELETE.
-- Повторне застосування безпечне. phpMyAdmin → БД → «Импорт» → цей файл → Вперёд (спершу резервна копія).
-- =====================================================================

-- =====================================================================
-- AI LAB HUB — міграція 2026-10-23: підкатегорія «Цифрова пам'ять і спадщина» (чутлива тема)
--
--   * subcategories.search_only_on_match — чутлива підкатегорія: Еля пропонує продукти, усі підкатегорії
--     яких чутливі, лише коли запит прямо про тему (інтенти нижче); app/eli.php, app/eli-search.php.
--   * products.note_key — додаткова примітка на картці продукту (app/subcategory-note.php, PRODUCT_NOTES).
--   * Підкатегорія my-home / digital-memory-legacy: no_promo = 1, search_only_on_match = 1.
--   * Стаття блогу ai-digital-memory-loved-ones — без реклами (promo_blog_flags.no_promo = 1).
--   * EN-тексти приміток (UA — app/translations.php).
--   * Інтенти Елі для підкатегорії (згенеровано: php tools/eli-intents.php sql | grep digital-memory-legacy).
--
-- Лише безпечні ALTER (information_schema + PREPARE) / INSERT … WHERE NOT EXISTS / INSERT IGNORE / UPDATE
-- однієї підкатегорії. Жодних DROP / TRUNCATE. Повторний запуск безпечний.
-- Застосування: phpMyAdmin → БД → «Импорт» → цей файл → Вперёд.
-- =====================================================================

SET NAMES utf8mb4;
SET @db := DATABASE();

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'subcategories' AND COLUMN_NAME = 'search_only_on_match') = 0,
  'ALTER TABLE subcategories ADD COLUMN search_only_on_match TINYINT(1) NOT NULL DEFAULT 0', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'products' AND COLUMN_NAME = 'note_key') = 0,
  'ALTER TABLE products ADD COLUMN note_key VARCHAR(64) NULL DEFAULT NULL', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @cat := (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1);
INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @cat, 'Цифрова пам''ять і спадщина', 'Digital memory and legacy', 'digital-memory-legacy' FROM DUAL
WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @cat AND slug = 'digital-memory-legacy');

UPDATE subcategories SET search_only_on_match = 1 WHERE category_id = @cat AND slug = 'digital-memory-legacy';
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'subcategories' AND COLUMN_NAME = 'no_promo') = 1,
  'UPDATE subcategories SET no_promo = 1 WHERE slug = ''digital-memory-legacy'' AND category_id = (SELECT id FROM categories WHERE slug = ''my-home'' LIMIT 1)', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'promo_blog_flags') = 1,
  'INSERT INTO promo_blog_flags (slug, no_promo, updated_at) VALUES (''ai-digital-memory-loved-ones'', 1, NOW()) ON DUPLICATE KEY UPDATE no_promo = 1', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- Примітки (EN).
INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES ('subcat_note_digital_memory', 'en', 'These tools work with memories of people who have died and can strongly affect how you feel. They do not replace support from a psychologist or from people close to you. Create digital copies of people only with that person''s consent or in line with their wishes as you know them, and within the law. If grief is getting in the way of your life or you have thoughts of harming yourself, contact a doctor, a psychotherapist or the emergency services in your country.', 'manual');
INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES ('product_note_simulation', 'en', 'A service like this creates a simulation: it may say things the person never said. Paid services may depend on the company continuing to exist.', 'manual');

-- Інтенти Елі.
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'помер', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'помер' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'померл', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'померл' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'померлих', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'померлих' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'покійн', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'покійн' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'загибл', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'загибл' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'загиблих', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'загиблих' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'меморіал', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'меморіал' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'меморіальн', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'меморіальн' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'поминк', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'поминк' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'горюв', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'горюв' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'ожив', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'ожив' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'оживл', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'оживл' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'deceas', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'deceas' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'died', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'died' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'memorial', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'memorial' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'griefbot', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'griefbot' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'deadbot', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'deadbot' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'afterlif', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'afterlif' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'bereavement', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'bereavement' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'bereav', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'bereav' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'mourn', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'mourn' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'памя', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 0.5 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'памя' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'памят', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 0.5 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'памят' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'двійник', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 0.5 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'двійник' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'remembranc', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 0.5 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'remembranc' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'memor', (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1), 0.5 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'memor' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'my-home' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'my-home' AND s.slug = 'digital-memory-legacy' LIMIT 1));

SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-23: «Цифрова пам'ять і спадщина» (my-home / digital-memory-legacy)
-- 23 нових продуктів + 40 наявних лише прив'язано (тексти наявних не змінюються).
-- Спершу застосуйте database/migration-2026-10-23-digital-memory.sql (підкатегорія, products.note_key).
-- Описи нейтральні, без обіцянок; факти — з офіційних сторінок, звірено 2026-10-23 (docs/ARTICLE_SOURCES.md).
-- Ціни не вказано: план «Ціна: див. сайт»; Free — лише де безкоштовність підтверджено.
-- note_key = product_note_simulation — додаткова примітка «симуляція» (розмовні копії й двійники).
-- Фото-, голосові й відеоінструменти без чутливого змісту додатково прив'язано до підкатегорій Мультимедіа,
-- щоб Еля пропонувала їх і на звичайні запити (чутлива підкатегорія сама їх не відкриває).
-- Пропущено:
--   HereAfter AI: головний сайт hereafter.ai повертає 404; за вторинними джерелами — закриття в липні–серпні 2026
--   Seance AI: домен seance.ai припаркований (сервер Parking/1.0)
--   MyHeritage DeepStory: адреса /deepstory перенаправляє на головну, функції немає в меню MyHeritage
--   Play.ht (наявний, прод id 185): домен play.ht не резолвиться; за вторинними джерелами сервіс закрито 31.12.2025 — картку варто заархівувати
--   Fish Audio: в умовах немає явної вимоги згоди власника голосу; публічна бібліотека з 2 млн+ голосових моделей користувачів
--   Ancestry: сайт блокує перевірку (HTTP 403), умови не прочитано
--   Ever Loved: сайт блокує перевірку (HTTP 403), умови не прочитано
--   Soul Machines: у receivership з 02.2026 (за NBR), B2B «цифрові працівники»
--   Sensay: змінив напрям: збереження знань співробітників, а не репліки людей
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   MyHeritage — нове
--   MyHeritage Photo Enhancer — нове
--   MyHeritage In Color — нове
--   MyHeritage Deep Nostalgia — нове
--   MyHeritage LiveMemory — нове
--   VanceAI — нове
--   Let's Enhance — нове
--   Photomyne — нове
--   PhotoScan by Google Photos — нове
--   Respeecher — нове
--   StoryCorps App — нове
--   Remento — нове
--   Storyworth — нове
--   Google Inactive Account Manager — нове
--   Apple Legacy Contact — нове
--   Facebook Legacy Contact — нове
--   Animoto — нове
--   Project December — нове (примітка «симуляція»)
--   You, Only Virtual (YOV) — нове (примітка «симуляція»)
--   Uare.ai — нове (примітка «симуляція»)
--   StoryFile — нове (примітка «симуляція»)
--   Delphi — нове (примітка «симуляція»)
--   Tavus — нове (примітка «симуляція»)
--   Remini — наявний, прив'язка
--   Topaz Labs — наявний, прив'язка
--   Adobe Photoshop — наявний, прив'язка
--   Fotor — наявний, прив'язка
--   Hotpot.ai — наявний, прив'язка
--   Upscayl — наявний, прив'язка
--   Palette.fm — наявний, прив'язка
--   Adobe Lightroom — наявний, прив'язка
--   D-ID — наявний, прив'язка
--   Hedra — наявний, прив'язка
--   HeyGen — наявний, прив'язка
--   Runway — наявний, прив'язка
--   Kling AI — наявний, прив'язка
--   Pika — наявний, прив'язка
--   Luma Dream Machine — наявний, прив'язка
--   Hailuo AI — наявний, прив'язка
--   Google Veo — наявний, прив'язка
--   Vidu — наявний, прив'язка
--   ElevenLabs — наявний, прив'язка
--   Resemble AI — наявний, прив'язка
--   Descript — наявний, прив'язка
--   Murf AI — наявний, прив'язка
--   Speechify — наявний, прив'язка
--   Adobe Podcast — наявний, прив'язка
--   Krisp — наявний, прив'язка
--   Auphonic — наявний, прив'язка
--   LALAL.AI — наявний, прив'язка
--   Audacity — наявний, прив'язка
--   FamilySearch — наявний, прив'язка
--   Canva — наявний, прив'язка
--   CapCut — наявний, прив'язка
--   Filmora — наявний, прив'язка
--   DaVinci Resolve — наявний, прив'язка
--   Kapwing — наявний, прив'язка
--   Suno — наявний, прив'язка
--   ChatGPT — наявний, прив'язка
--   Claude — наявний, прив'язка
--   Synthesia — наявний, прив'язка + примітка «симуляція»
--   Character.AI — наявний, прив'язка + примітка «симуляція»
--   Replika — наявний, прив'язка + примітка «симуляція»
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'my-home' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'digital-memory-legacy' LIMIT 1);
SET @hasnote = (SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'products' AND COLUMN_NAME = 'note_key');

-- =================== Нові продукти ===================

-- MyHeritage
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myheritage.com' OR LOWER(`name`) = 'myheritage')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MyHeritage', NULL, 'https://www.myheritage.com', NULL, NULL, 'Генеалогічна платформа: родинне дерево, пошук в історичних записах і ДНК-тести; тут же фото-інструменти на основі AI.', 'A genealogy platform: family trees, historical record search and DNA tests, with AI photo tools on the same site.', 'MyHeritage — сервіс для дослідження родоводу. Можна створити родинне дерево (зокрема імпортувати файл GEDCOM), шукати в архівах записів про народження, шлюби й смерть, переписах і газетах та замовити ДНК-тест. На сайті є фото-інструменти: поліпшення, колоризація, анімація облич (Deep Nostalgia) і LiveMemory. Пробний період і умови підписки — на сайті. Перш ніж завантажувати дані й фото родичів, перегляньте політику конфіденційності, особливо щодо ДНК.', 'MyHeritage is a family history service. You can build a family tree (including importing a GEDCOM file), search birth, marriage and death records, censuses and newspapers, and order a DNA test. The site also offers photo tools: enhancement, colorization, face animation (Deep Nostalgia) and LiveMemory. Trial and subscription terms are on the website. Before uploading relatives’ data and photos, review the privacy policy, especially for DNA.', 'Родинне дерево й імпорт GEDCOM
Пошук в історичних записах
ДНК-тести
Фото-інструменти на основі AI', 'Family tree and GEDCOM import
Historical record search
DNA tests
AI photo tools', 'Тим, хто досліджує історію своєї родини.', 'People researching their family history.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myheritage.com' OR LOWER(`name`) = 'myheritage') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A genealogy platform: family trees, historical record search and DNA tests, with AI photo tools on the same site.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MyHeritage is a family history service. You can build a family tree (including importing a GEDCOM file), search birth, marriage and death records, censuses and newspapers, and order a DNA test. The site also offers photo tools: enhancement, colorization, face animation (Deep Nostalgia) and LiveMemory. Trial and subscription terms are on the website. Before uploading relatives’ data and photos, review the privacy policy, especially for DNA.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Family tree and GEDCOM import
Historical record search
DNA tests
AI photo tools', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People researching their family history.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MyHeritage Photo Enhancer
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myheritage.com/photo-enhancer' OR LOWER(`name`) = 'myheritage photo enhancer')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MyHeritage Photo Enhancer', NULL, 'https://www.myheritage.com/photo-enhancer', NULL, NULL, 'Поліпшення розмитих і старих фотографій на основі AI, з фокусом на обличчях.', 'AI enhancement of blurry and old photos, with a focus on faces.', 'Інструмент MyHeritage для підвищення чіткості старих і розмитих фото, передусім облич. Результат створює модель: дрібні риси обличчя вона домальовує, тому вони можуть відрізнятися від справжніх. Зберігайте оригінал скану й порівнюйте з ним. Ліміти безкоштовного використання й умови підписки — на сайті.', 'A MyHeritage tool that sharpens old and blurry photos, especially faces. The result is generated by a model: it fills in fine facial details, so they may differ from the real ones. Keep the original scan and compare against it. Free-use limits and subscription terms are on the website.', 'Підвищення чіткості облич
Робота зі старими й розмитими фото
Веб і мобільний застосунок', 'Face sharpening
Works with old and blurry photos
Web and mobile app', 'Тим, хто оцифровує родинні фотоархіви.', 'People digitizing family photo archives.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myheritage.com/photo-enhancer' OR LOWER(`name`) = 'myheritage photo enhancer') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.id FROM `categories` c WHERE c.slug = 'multimedia' AND @pid IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.id FROM `subcategories` s JOIN `categories` c ON c.id = s.category_id WHERE c.slug = 'multimedia' AND s.slug = 'photography' AND @pid IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI enhancement of blurry and old photos, with a focus on faces.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A MyHeritage tool that sharpens old and blurry photos, especially faces. The result is generated by a model: it fills in fine facial details, so they may differ from the real ones. Keep the original scan and compare against it. Free-use limits and subscription terms are on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Face sharpening
Works with old and blurry photos
Web and mobile app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People digitizing family photo archives.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MyHeritage In Color
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myheritage.com/incolor' OR LOWER(`name`) = 'myheritage in color')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MyHeritage In Color', NULL, 'https://www.myheritage.com/incolor', NULL, NULL, 'Колоризація чорно-білих фото й відновлення вицвілих кольорів на основі AI.', 'AI colorization of black-and-white photos and restoration of faded colors.', 'MyHeritage In Color додає кольори до чорно-білих фотографій і відновлює вицвілі кольорові знімки. Кольори модель оцінює, а не знає: колір одягу, очей чи волосся може не відповідати дійсності. Варто підписувати такі фото як колоризовані за допомогою AI. Ліміти й умови — на сайті.', 'MyHeritage In Color adds color to black-and-white photos and restores faded color prints. The model estimates colors rather than knowing them: the color of clothes, eyes or hair may not match reality. It is worth labeling such photos as AI-colorized. Limits and terms are on the website.', 'Колоризація чорно-білих фото
Відновлення вицвілих кольорів
Веб і мобільний застосунок', 'Colorization of black-and-white photos
Restoration of faded colors
Web and mobile app', 'Тим, хто працює з історичними й родинними фото.', 'People working with historical and family photos.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myheritage.com/incolor' OR LOWER(`name`) = 'myheritage in color') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.id FROM `categories` c WHERE c.slug = 'multimedia' AND @pid IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.id FROM `subcategories` s JOIN `categories` c ON c.id = s.category_id WHERE c.slug = 'multimedia' AND s.slug = 'photography' AND @pid IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI colorization of black-and-white photos and restoration of faded colors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MyHeritage In Color adds color to black-and-white photos and restores faded color prints. The model estimates colors rather than knowing them: the color of clothes, eyes or hair may not match reality. It is worth labeling such photos as AI-colorized. Limits and terms are on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Colorization of black-and-white photos
Restoration of faded colors
Web and mobile app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People working with historical and family photos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MyHeritage Deep Nostalgia
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myheritage.com/deep-nostalgia' OR LOWER(`name`) = 'myheritage deep nostalgia')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MyHeritage Deep Nostalgia', NULL, 'https://www.myheritage.com/deep-nostalgia', NULL, NULL, 'Анімація облич на фотографіях: коротке відео з рухом голови, мімікою й поглядом.', 'Animates faces in photos: a short clip with head movement, facial expression and gaze.', 'Deep Nostalgia від MyHeritage створює з фото коротку анімацію обличчя: людина повертає голову, кліпає, усміхається. Рухи згенеровані за шаблонами, тож вони не показують, як рухалася саме ця людина. Реакції бувають різні: декому це приємно, а комусь тривожно, особливо коли йдеться про нещодавню втрату. Перш ніж показувати анімацію родині, варто спитати, чи хочуть цього рідні. Ліміти й умови — на сайті.', 'MyHeritage Deep Nostalgia turns a photo into a short face animation: the person turns their head, blinks, smiles. The movements are generated from templates, so they do not show how this particular person moved. Reactions vary: some people find it pleasant, others find it unsettling, especially after a recent loss. Before showing an animation to family, it is worth asking whether they want this. Limits and terms are on the website.', 'Анімація облич на фото
Короткі відео для перегляду й збереження
Веб і мобільний застосунок', 'Face animation in photos
Short clips to view and save
Web and mobile app', 'Дорослим, які працюють із родинними фото й усвідомлюють, що рух згенеровано.', 'Adults working with family photos who understand the motion is generated.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myheritage.com/deep-nostalgia' OR LOWER(`name`) = 'myheritage deep nostalgia') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Animates faces in photos: a short clip with head movement, facial expression and gaze.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MyHeritage Deep Nostalgia turns a photo into a short face animation: the person turns their head, blinks, smiles. The movements are generated from templates, so they do not show how this particular person moved. Reactions vary: some people find it pleasant, others find it unsettling, especially after a recent loss. Before showing an animation to family, it is worth asking whether they want this. Limits and terms are on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Face animation in photos
Short clips to view and save
Web and mobile app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adults working with family photos who understand the motion is generated.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MyHeritage LiveMemory
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myheritage.com/live-memory' OR LOWER(`name`) = 'myheritage livememory')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MyHeritage LiveMemory', NULL, 'https://www.myheritage.com/live-memory', NULL, NULL, 'Перетворення фотографії на коротке відео, згенероване AI, у застосунку MyHeritage.', 'Turns a photo into a short AI-generated video in the MyHeritage app.', 'LiveMemory від MyHeritage анімує фотографії: на основі знімка AI генерує коротке відео сцени. Усе, чого не було на фото (рухи, частини сцени), модель вигадує. Тому результат — це відтворення, а не запис події. Підписуйте такі відео як згенеровані AI. Ліміти й умови — на сайті.', 'MyHeritage LiveMemory animates photos: from a still image, AI generates a short video of the scene. Anything not in the photo (motion, parts of the scene) is invented by the model, so the result is a re-creation, not a record of the event. Label such videos as AI-generated. Limits and terms are on the website.', 'Відео з однієї фотографії
Генерація руху сцени
У застосунку й на сайті MyHeritage', 'Video from a single photo
Generated scene motion
In the MyHeritage app and website', 'Тим, хто хоче оживити родинні фото й розуміє, що це відтворення.', 'People who want to animate family photos and understand it is a re-creation.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myheritage.com/live-memory' OR LOWER(`name`) = 'myheritage livememory') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Turns a photo into a short AI-generated video in the MyHeritage app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MyHeritage LiveMemory animates photos: from a still image, AI generates a short video of the scene. Anything not in the photo (motion, parts of the scene) is invented by the model, so the result is a re-creation, not a record of the event. Label such videos as AI-generated. Limits and terms are on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Video from a single photo
Generated scene motion
In the MyHeritage app and website', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to animate family photos and understand it is a re-creation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- VanceAI
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vanceai.com' OR LOWER(`name`) = 'vanceai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'VanceAI', NULL, 'https://vanceai.com', NULL, NULL, 'Набір AI-інструментів для фото й відео: відновлення, колоризація, збільшення, усунення шуму.', 'AI tools for photos and video: restoration, colorization, upscaling and denoising.', 'VanceAI пропонує окремі інструменти для зображень (Restore, Colorize, Upscale, Denoise, Sharpen) і відео, а також настільні застосунки й API. Для старих фото корисні відновлення й колоризація. Як і в інших подібних сервісах, AI домальовує деталі, тож перевіряйте результат з оригіналом. Робота за кредитами; ціни й тарифи — на сайті.', 'VanceAI offers separate tools for images (Restore, Colorize, Upscale, Denoise, Sharpen) and video, plus desktop apps and an API. Restoration and colorization are useful for old photos. As with similar services, AI fills in details, so check the result against the original. It works on credits; prices and plans are on the website.', 'Відновлення й колоризація фото
Збільшення й усунення шуму
Настільні застосунки й API', 'Photo restoration and colorization
Upscaling and denoising
Desktop apps and API', 'Тим, хто відновлює старі фото й відео.', 'People restoring old photos and videos.', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vanceai.com' OR LOWER(`name`) = 'vanceai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.id FROM `categories` c WHERE c.slug = 'multimedia' AND @pid IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.id FROM `subcategories` s JOIN `categories` c ON c.id = s.category_id WHERE c.slug = 'multimedia' AND s.slug = 'photography' AND @pid IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AI tools for photos and video: restoration, colorization, upscaling and denoising.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'VanceAI offers separate tools for images (Restore, Colorize, Upscale, Denoise, Sharpen) and video, plus desktop apps and an API. Restoration and colorization are useful for old photos. As with similar services, AI fills in details, so check the result against the original. It works on credits; prices and plans are on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Photo restoration and colorization
Upscaling and denoising
Desktop apps and API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People restoring old photos and videos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Let's Enhance
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'letsenhance.io' OR LOWER(`name`) = 'let''s enhance')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Let''s Enhance', NULL, 'https://letsenhance.io', NULL, NULL, 'Онлайн-поліпшення зображень: збільшення до друкованої якості, різкість, відновлення пошкоджених фото.', 'Online image enhancement: upscaling to print quality, sharpening and restoration of damaged photos.', 'Let''s Enhance — веб-сервіс для поліпшення зображень. Є режими Enhancer, Upscaler (за описом, до 512 МП для друку) і Restorer для старих чи пошкоджених фото, можна обробляти кілька файлів одночасно. Для портретів пам''ятайте, що модель відновлює деталі на свій розсуд. Безкоштовний старт і тарифи — на сайті.', 'Let''s Enhance is a web service for improving images. It has Enhancer, Upscaler (described as up to 512 MP for print) and Restorer modes for old or damaged photos, and can process several files at once. For portraits, remember that the model reconstructs details at its own discretion. Free start and plans are on the website.', 'Відновлення пошкоджених фото
Збільшення для друку
Пакетна обробка', 'Restoration of damaged photos
Upscaling for print
Batch processing', 'Тим, хто готує старі фото до друку чи альбому.', 'People preparing old photos for print or an album.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'letsenhance.io' OR LOWER(`name`) = 'let''s enhance') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.id FROM `categories` c WHERE c.slug = 'multimedia' AND @pid IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.id FROM `subcategories` s JOIN `categories` c ON c.id = s.category_id WHERE c.slug = 'multimedia' AND s.slug = 'photography' AND @pid IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Online image enhancement: upscaling to print quality, sharpening and restoration of damaged photos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Let''s Enhance is a web service for improving images. It has Enhancer, Upscaler (described as up to 512 MP for print) and Restorer modes for old or damaged photos, and can process several files at once. For portraits, remember that the model reconstructs details at its own discretion. Free start and plans are on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Restoration of damaged photos
Upscaling for print
Batch processing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People preparing old photos for print or an album.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Photomyne
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'photomyne.com' OR LOWER(`name`) = 'photomyne')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Photomyne', NULL, 'https://photomyne.com', NULL, NULL, 'Застосунок для сканування паперових фото телефоном, з колоризацією, різкістю й меморіальними сторінками.', 'An app for scanning printed photos with your phone, with colorization, sharpening and memorial pages.', 'Photomyne допомагає оцифрувати фотоальбоми: застосунок сканує кілька знімків одночасно, обрізає їх і зберігає в архіві. Є функції колоризації, підвищення різкості й меморіальні сторінки для збереження фото про людину. Для річного плану, за описом на сайті, діє пробний період; умови й ціни — на сайті. Зберігайте копії сканів і поза сервісом.', 'Photomyne helps digitize photo albums: the app scans several prints at once, crops them and keeps them in an archive. It offers colorization, sharpening and memorial pages for keeping photos about a person. According to the website, the yearly plan comes with a trial; terms and prices are on the website. Keep copies of your scans outside the service as well.', 'Сканування кількох фото одночасно
Колоризація й різкість
Меморіальні сторінки
Фотоархів', 'Scan several photos at once
Colorization and sharpening
Memorial pages
Photo archive', 'Родинам, які оцифровують паперові фотоальбоми.', 'Families digitizing printed photo albums.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'photomyne.com' OR LOWER(`name`) = 'photomyne') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.id FROM `categories` c WHERE c.slug = 'multimedia' AND @pid IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.id FROM `subcategories` s JOIN `categories` c ON c.id = s.category_id WHERE c.slug = 'multimedia' AND s.slug = 'photography' AND @pid IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An app for scanning printed photos with your phone, with colorization, sharpening and memorial pages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Photomyne helps digitize photo albums: the app scans several prints at once, crops them and keeps them in an archive. It offers colorization, sharpening and memorial pages for keeping photos about a person. According to the website, the yearly plan comes with a trial; terms and prices are on the website. Keep copies of your scans outside the service as well.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Scan several photos at once
Colorization and sharpening
Memorial pages
Photo archive', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families digitizing printed photo albums.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PhotoScan by Google Photos
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.google.android.apps.photos.scanner' OR LOWER(`name`) = 'photoscan by google photos')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PhotoScan by Google Photos', NULL, 'https://play.google.com/store/apps/details?id=com.google.android.apps.photos.scanner', NULL, NULL, 'Безкоштовний сканер паперових фото від Google: знімки без відблисків, обрізання й вирівнювання.', 'A free scanner for printed photos from Google: glare-free scans, cropping and straightening.', 'PhotoScan — застосунок Google для сканування друкованих фотографій камерою телефона. Він прибирає відблиски за кілька кадрів, автоматично обрізає й вирівнює знімок, а скани можна зберегти в Google Фото. AI тут не домальовує обличчя, а лише покращує сам скан. Остання версія в Google Play датована 2023 роком, тож перевіряйте сумісність зі своїм пристроєм.', 'PhotoScan is a Google app for scanning printed photos with your phone camera. It removes glare by combining several shots, crops and straightens the image automatically, and scans can be backed up to Google Photos. It does not redraw faces; it only improves the scan itself. The latest version on Google Play dates from 2023, so check compatibility with your device.', 'Скани без відблисків
Автоматичне обрізання й вирівнювання
Збереження в Google Фото', 'Glare-free scans
Automatic cropping and straightening
Backup to Google Photos', 'Усім, хто хоче швидко оцифрувати паперові фото.', 'Anyone who wants to quickly digitize printed photos.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.google.android.apps.photos.scanner' OR LOWER(`name`) = 'photoscan by google photos') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.id FROM `categories` c WHERE c.slug = 'multimedia' AND @pid IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.id FROM `subcategories` s JOIN `categories` c ON c.id = s.category_id WHERE c.slug = 'multimedia' AND s.slug = 'photography' AND @pid IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A free scanner for printed photos from Google: glare-free scans, cropping and straightening.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PhotoScan is a Google app for scanning printed photos with your phone camera. It removes glare by combining several shots, crops and straightens the image automatically, and scans can be backed up to Google Photos. It does not redraw faces; it only improves the scan itself. The latest version on Google Play dates from 2023, so check compatibility with your device.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Glare-free scans
Automatic cropping and straightening
Backup to Google Photos', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone who wants to quickly digitize printed photos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно.', 'Free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Respeecher
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'respeecher.com' OR LOWER(`name`) = 'respeecher')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Respeecher', NULL, 'https://www.respeecher.com', NULL, NULL, 'Українська компанія з клонування голосу для кіно, ігор і медіа; працює лише з явною згодою власника голосу.', 'A Ukrainian voice cloning company for film, games and media; works only with the voice owner’s explicit consent.', 'Respeecher створює синтетичні голоси для професійних проєктів (кіно, телебачення, ігри, реклама), має бібліотеку голосів і API для синтезу мовлення. У розділі про етику компанія зазначає, що будь-яке відтворення голосу потребує явного дозволу, оформленого взаємно підписаною угодою. Це сервіс для студій і компаній, а не застосунок для приватного використання. Умови й вартість — за запитом.', 'Respeecher creates synthetic voices for professional projects (film, TV, games, advertising) and offers a voice library and a speech synthesis API. In its ethics section, the company states that any voice replication requires explicit permission secured through a mutually signed agreement. It is a service for studios and companies, not an app for private use. Terms and pricing are on request.', 'Клонування голосу для медіапроєктів
Бібліотека голосів
API синтезу мовлення
Згода власника голосу за угодою', 'Voice cloning for media projects
Voice library
Speech synthesis API
Voice owner consent by agreement', 'Студіям, продакшенам і медіакомпаніям.', 'Studios, production companies and media organizations.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'respeecher.com' OR LOWER(`name`) = 'respeecher') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.id FROM `categories` c WHERE c.slug = 'multimedia' AND @pid IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.id FROM `subcategories` s JOIN `categories` c ON c.id = s.category_id WHERE c.slug = 'multimedia' AND s.slug = 'voiceover' AND @pid IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Ukrainian voice cloning company for film, games and media; works only with the voice owner’s explicit consent.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Respeecher creates synthetic voices for professional projects (film, TV, games, advertising) and offers a voice library and a speech synthesis API. In its ethics section, the company states that any voice replication requires explicit permission secured through a mutually signed agreement. It is a service for studios and companies, not an app for private use. Terms and pricing are on request.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Voice cloning for media projects
Voice library
Speech synthesis API
Voice owner consent by agreement', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Studios, production companies and media organizations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- StoryCorps App
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'storycorps.org/participate/storycorps-app' OR LOWER(`name`) = 'storycorps app')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'StoryCorps App', NULL, 'https://storycorps.org/participate/storycorps-app/', NULL, NULL, 'Безкоштовний застосунок StoryCorps для запису розмови-інтерв''ю з близькою людиною й збереження в архіві.', 'StoryCorps’ free app for recording an interview-style conversation with someone close and archiving it.', 'Застосунок некомерційної організації StoryCorps допомагає записати змістовну розмову: підготувати запитання, записати аудіо на телефон і, за бажанням, завантажити запис в архів StoryCorps і Бібліотеку Конгресу США. Тут немає AI-копій: зберігається справжній голос людини. Перед публікацією в архіві обговоріть зі співрозмовником, чи згоден він на це.', 'The app from the nonprofit StoryCorps helps you record a meaningful conversation: prepare questions, record audio on your phone and, if you choose, upload it to the StoryCorps Archive and the US Library of Congress. There are no AI copies: it keeps the person’s real voice. Before publishing to the archive, discuss with the other person whether they agree.', 'Підготовка запитань для інтерв''ю
Запис розмови на телефон
Завантаження в архів StoryCorps', 'Interview question preparation
Recording on your phone
Upload to the StoryCorps Archive', 'Тим, хто хоче записати історії близьких за їхнього життя.', 'People who want to record loved ones’ stories while they are alive.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'storycorps.org/participate/storycorps-app' OR LOWER(`name`) = 'storycorps app') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'StoryCorps’ free app for recording an interview-style conversation with someone close and archiving it.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app from the nonprofit StoryCorps helps you record a meaningful conversation: prepare questions, record audio on your phone and, if you choose, upload it to the StoryCorps Archive and the US Library of Congress. There are no AI copies: it keeps the person’s real voice. Before publishing to the archive, discuss with the other person whether they agree.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Interview question preparation
Recording on your phone
Upload to the StoryCorps Archive', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to record loved ones’ stories while they are alive.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно.', 'Free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Remento
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'remento.co' OR LOWER(`name`) = 'remento')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Remento', NULL, 'https://www.remento.co', NULL, NULL, 'Сервіс, що щотижня надсилає людині запитання, записує її усні відповіді й робить з них книгу спогадів.', 'A service that sends a person weekly questions, records their spoken answers and turns them into a memoir book.', 'Remento надсилає людині запитання електронною поштою чи SMS, вона відповідає голосом без застосунку й пароля, а сервіс перетворює записи на текст розділів. Наприкінці виходить книга в твердій обкладинці, де кожен розділ має QR-код із записом голосу. Текст оброблено автоматично, тож перед друком його варто перечитати разом з автором. Ціни — на сайті.', 'Remento sends a person questions by email or text, they answer by voice without an app or password, and the service turns the recordings into written chapters. The result is a hardcover book where each chapter has a QR code that plays the voice recording. The text is processed automatically, so it is worth reviewing it with the storyteller before printing. Prices are on the website.', 'Щотижневі запитання e-mail чи SMS
Відповіді голосом без застосунку
Книга з QR-кодами на записи', 'Weekly questions by email or text
Voice answers without an app
Book with QR codes to recordings', 'Родинам, які хочуть зберегти історії старших близьких.', 'Families who want to preserve older relatives’ stories.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'remento.co' OR LOWER(`name`) = 'remento') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A service that sends a person weekly questions, records their spoken answers and turns them into a memoir book.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Remento sends a person questions by email or text, they answer by voice without an app or password, and the service turns the recordings into written chapters. The result is a hardcover book where each chapter has a QR code that plays the voice recording. The text is processed automatically, so it is worth reviewing it with the storyteller before printing. Prices are on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Weekly questions by email or text
Voice answers without an app
Book with QR codes to recordings', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families who want to preserve older relatives’ stories.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Storyworth
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'storyworth.com' OR LOWER(`name`) = 'storyworth')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Storyworth', NULL, 'https://www.storyworth.com', NULL, NULL, 'Щотижневі запитання про життя, на які людина відповідає текстом чи голосом, і книга спогадів наприкінці року.', 'Weekly life questions answered in writing or by voice, with a memoir book at the end of the year.', 'Storyworth надсилає людині щотижневі запитання, на які можна відповісти листом, записати голос телефоном або написати на сайті. Через рік з історій і фото складають книгу в твердій обкладинці. Сервіс зберігає власні слова людини, а не генерує нові. Тарифи й ціни — на сайті.', 'Storyworth sends a person weekly questions they can answer by email, by recording their voice over the phone or by writing on the website. After a year, the stories and photos are compiled into a hardcover book. The service keeps the person’s own words rather than generating new ones. Plans and prices are on the website.', 'Щотижневі запитання
Відповіді текстом, голосом чи на сайті
Книга в твердій обкладинці', 'Weekly questions
Answers by email, voice or website
Hardcover book', 'Тим, хто хоче записати спогади свої чи близької людини.', 'People who want to record their own or a loved one’s memories.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'storyworth.com' OR LOWER(`name`) = 'storyworth') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Weekly life questions answered in writing or by voice, with a memoir book at the end of the year.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Storyworth sends a person weekly questions they can answer by email, by recording their voice over the phone or by writing on the website. After a year, the stories and photos are compiled into a hardcover book. The service keeps the person’s own words rather than generating new ones. Plans and prices are on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Weekly questions
Answers by email, voice or website
Hardcover book', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to record their own or a loved one’s memories.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Google Inactive Account Manager
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'support.google.com/accounts/answer/3036546' OR LOWER(`name`) = 'google inactive account manager')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Google Inactive Account Manager', NULL, 'https://support.google.com/accounts/answer/3036546', NULL, NULL, 'Функція Google: що станеться з акаунтом після тривалої неактивності й кому передати вибрані дані.', 'A Google feature: what happens to your account after a long period of inactivity and who receives selected data.', 'Менеджер неактивних акаунтів дозволяє заздалегідь вибрати період неактивності, до 10 довірених людей, повідомлення для них і типи даних, які вони зможуть завантажити. Можна також налаштувати видалення акаунта. Без плану Google може видалити акаунт, неактивний щонайменше два роки. Налаштування безкоштовне й робиться власником акаунта за життя.', 'Inactive Account Manager lets you choose in advance an inactivity period, up to 10 trusted people, a message for them and the types of data they can download. You can also set the account to be deleted. Without a plan, Google may delete an account that has been inactive for at least two years. Setup is free and done by the account owner during their lifetime.', 'До 10 довірених контактів
Вибір даних для передачі
Власне повідомлення
Можливість видалення акаунта', 'Up to 10 trusted contacts
Choice of data to share
Custom message
Option to delete the account', 'Усім, хто користується акаунтом Google.', 'Anyone with a Google account.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'support.google.com/accounts/answer/3036546' OR LOWER(`name`) = 'google inactive account manager') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Google feature: what happens to your account after a long period of inactivity and who receives selected data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Inactive Account Manager lets you choose in advance an inactivity period, up to 10 trusted people, a message for them and the types of data they can download. You can also set the account to be deleted. Without a plan, Google may delete an account that has been inactive for at least two years. Setup is free and done by the account owner during their lifetime.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Up to 10 trusted contacts
Choice of data to share
Custom message
Option to delete the account', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone with a Google account.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно.', 'Free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Apple Legacy Contact
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'support.apple.com/en-us/102631' OR LOWER(`name`) = 'apple legacy contact')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Apple Legacy Contact', NULL, 'https://support.apple.com/en-us/102631', NULL, NULL, 'Функція Apple: довірена людина після вашої смерті отримує доступ до фото, повідомлень і файлів в Apple Account.', 'An Apple feature: after your death, a trusted person can access photos, messages and files in your Apple Account.', 'Legacy Contact (контакт для доступу до спадщини) налаштовується на iOS/iPadOS 15.2 чи macOS Monterey 12.1 або новіших. Ви створюєте ключ доступу й передаєте його довіреній людині; щоб отримати доступ, їй потрібні ключ і свідоцтво про смерть. Доступні, зокрема, фото, повідомлення, нотатки, файли й резервні копії; придбані фільми, музика й дані iCloud Keychain (паролі, платіжні дані) недоступні.', 'Legacy Contact is set up on iOS/iPadOS 15.2 or macOS Monterey 12.1 or later. You create an access key and give it to a trusted person; to get access they need the key and a death certificate. Accessible data include photos, messages, notes, files and backups; purchased movies, music and iCloud Keychain data (passwords, payment details) are not accessible.', 'Ключ доступу для довіреної людини
Доступ до фото, повідомлень, файлів
Налаштування власником за життя', 'Access key for a trusted person
Access to photos, messages, files
Set up by the owner during their lifetime', 'Користувачам пристроїв і акаунтів Apple.', 'Users of Apple devices and accounts.', 'mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'support.apple.com/en-us/102631' OR LOWER(`name`) = 'apple legacy contact') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'An Apple feature: after your death, a trusted person can access photos, messages and files in your Apple Account.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Legacy Contact is set up on iOS/iPadOS 15.2 or macOS Monterey 12.1 or later. You create an access key and give it to a trusted person; to get access they need the key and a death certificate. Accessible data include photos, messages, notes, files and backups; purchased movies, music and iCloud Keychain data (passwords, payment details) are not accessible.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Access key for a trusted person
Access to photos, messages, files
Set up by the owner during their lifetime', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Users of Apple devices and accounts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно.', 'Free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Facebook Legacy Contact
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'facebook.com/help/1568013990080948' OR LOWER(`name`) = 'facebook legacy contact')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Facebook Legacy Contact', NULL, 'https://www.facebook.com/help/1568013990080948', NULL, NULL, 'Функція Meta: людина, яка керуватиме меморіальною сторінкою Facebook після смерті власника акаунта.', 'A Meta feature: a person who will look after a memorialized Facebook profile after the account owner dies.', 'Власник акаунта Facebook (від 18 років) може заздалегідь вибрати контакт-спадкоємця. Після того як акаунт стає меморіальним, ця людина може, за оголошенням Meta, закріпити допис, змінити фото профілю, відповідати на запити в друзі й, якщо власник дозволив, завантажити архів. Входити в акаунт і читати приватні повідомлення вона не може. Можна також вибрати видалення акаунта після смерті. Актуальні умови — у довідці Meta.', 'A Facebook account holder (18+) can choose a legacy contact in advance. Once the account is memorialized, according to Meta’s announcement, this person can pin a post, change the profile photo, respond to friend requests and, if the owner allowed it, download an archive. They cannot log in to the account or read private messages. You can also choose to have the account deleted after death. Current terms are in Meta’s Help Center.', 'Контакт-спадкоємець
Меморіальний профіль
Вибір видалення акаунта після смерті', 'Legacy contact
Memorialized profile
Option to delete the account after death', 'Користувачам Facebook, які хочуть заздалегідь вирішити долю акаунта.', 'Facebook users who want to decide in advance what happens to their account.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'facebook.com/help/1568013990080948' OR LOWER(`name`) = 'facebook legacy contact') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Meta feature: a person who will look after a memorialized Facebook profile after the account owner dies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Facebook account holder (18+) can choose a legacy contact in advance. Once the account is memorialized, according to Meta’s announcement, this person can pin a post, change the profile photo, respond to friend requests and, if the owner allowed it, download an archive. They cannot log in to the account or read private messages. You can also choose to have the account deleted after death. Current terms are in Meta’s Help Center.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Legacy contact
Memorialized profile
Option to delete the account after death', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Facebook users who want to decide in advance what happens to their account.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно.', 'Free.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Animoto
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'animoto.com' OR LOWER(`name`) = 'animoto')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Animoto', NULL, 'https://animoto.com', NULL, NULL, 'Простий онлайн-редактор відео з шаблонами: слайд-шоу з фото, кліпів і музики.', 'A simple online video maker with templates: slideshows from photos, clips and music.', 'Animoto дозволяє зібрати відео з фото й коротких кліпів перетягуванням, додати текст, графіку, музику й голос за кадром. Підходить для фото-слайд-шоу, зокрема меморіальних, без навичок монтажу. Безкоштовний старт і тарифи — на сайті; перевірте, чи є водяний знак на безкоштовному тарифі.', 'Animoto lets you assemble a video from photos and short clips by drag and drop, and add text, graphics, music and voice-over. It suits photo slideshows, including memorial ones, without editing skills. Free start and plans are on the website; check whether the free plan adds a watermark.', 'Шаблони відео
Слайд-шоу з фото й кліпів
Музика й голос за кадром', 'Video templates
Slideshows from photos and clips
Music and voice-over', 'Тим, хто хоче швидко зробити відео з фото.', 'People who want to quickly make a video from photos.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'animoto.com' OR LOWER(`name`) = 'animoto') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.id FROM `categories` c WHERE c.slug = 'multimedia' AND @pid IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.id FROM `subcategories` s JOIN `categories` c ON c.id = s.category_id WHERE c.slug = 'multimedia' AND s.slug = 'video-editing' AND @pid IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A simple online video maker with templates: slideshows from photos, clips and music.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Animoto lets you assemble a video from photos and short clips by drag and drop, and add text, graphics, music and voice-over. It suits photo slideshows, including memorial ones, without editing skills. Free start and plans are on the website; check whether the free plan adds a watermark.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Video templates
Slideshows from photos and clips
Music and voice-over', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want to quickly make a video from photos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Project December
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'projectdecember.net' OR LOWER(`name`) = 'project december')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Project December', NULL, 'https://projectdecember.net', NULL, NULL, 'Текстовий чат зі «особистостями» на основі мовної моделі, зокрема створеними користувачем; генерує нові репліки.', 'A text chat with model-based “personalities”, including ones the user creates; it generates new replies.', 'Project December — проєкт розробника Джейсона Рорера: текстовий термінал для розмов з «матрицями особистості» на основі мовної моделі. Сервіс відомий тим, що користувачі створюють імітації конкретних людей, зокрема померлих. Відповіді генеруються заново, тож симуляція може казати те, чого людина ніколи не говорила. Доступ, за сторінкою покупки, відкривається разовою оплатою з пакетом обчислювальних кредитів; вікових обмежень і застережень на цій сторінці ми не знайшли. Ціни — на сайті.', 'Project December, by developer Jason Rohrer, is a text terminal for conversations with model-based “personality matrices”. It is known for users creating imitations of specific people, including people who have died. Replies are generated anew, so the simulation may say things the person never said. According to the purchase page, access is a one-time payment with a pack of compute credits; we did not find age limits or warnings on that page. Prices are on the website.', 'Текстовий чат на основі мовної моделі
Власні «особистості»
Оплата кредитами', 'Text chat based on a language model
Custom “personalities”
Credit-based payment', 'Дорослим, які розуміють, що це генеративна симуляція.', 'Adults who understand it is a generative simulation.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'projectdecember.net' OR LOWER(`name`) = 'project december') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A text chat with model-based “personalities”, including ones the user creates; it generates new replies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Project December, by developer Jason Rohrer, is a text terminal for conversations with model-based “personality matrices”. It is known for users creating imitations of specific people, including people who have died. Replies are generated anew, so the simulation may say things the person never said. According to the purchase page, access is a one-time payment with a pack of compute credits; we did not find age limits or warnings on that page. Prices are on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Text chat based on a language model
Custom “personalities”
Credit-based payment', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adults who understand it is a generative simulation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
SET @s := IF(@hasnote = 1 AND @pid IS NOT NULL, CONCAT('UPDATE products SET note_key = ''product_note_simulation'' WHERE id = ', @pid), 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- You, Only Virtual (YOV)
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myyov.com' OR LOWER(`name`) = 'you, only virtual (yov)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'You, Only Virtual (YOV)', NULL, 'https://www.myyov.com', NULL, NULL, 'Компанія, що створює «Versona» — AI-персону для продовження спілкування з людиною, якої не стало; доступ через лист очікування.', 'A company building “Versona”, an AI persona meant to continue communication with someone who has died; access via a waitlist.', 'You, Only Virtual описує свій продукт Versona як AI-персону, що відтворює ваші стосунки з близькою людиною й «навчається» в розмовах. На момент перевірки доступ відкривається через лист очікування. На головній сторінці немає інформації про згоду, видалення даних, ціни чи застереження щодо емоційного впливу; перш ніж передавати листування й записи, просіть ці умови письмово. Симуляція може говорити те, чого людина ніколи не казала.', 'You, Only Virtual describes its Versona product as an AI persona that recreates your relationship with a loved one and “learns” through conversations. At the time of checking, access is via a waitlist. The home page gives no information on consent, data deletion, pricing or warnings about emotional impact; before sharing messages and recordings, ask for these terms in writing. The simulation may say things the person never said.', 'AI-персона Versona
Лист очікування
Генеративна симуляція', 'Versona AI persona
Waitlist
Generative simulation', 'Дорослим, які свідомо розглядають такий формат.', 'Adults deliberately considering this format.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myyov.com' OR LOWER(`name`) = 'you, only virtual (yov)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A company building “Versona”, an AI persona meant to continue communication with someone who has died; access via a waitlist.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'You, Only Virtual describes its Versona product as an AI persona that recreates your relationship with a loved one and “learns” through conversations. At the time of checking, access is via a waitlist. The home page gives no information on consent, data deletion, pricing or warnings about emotional impact; before sharing messages and recordings, ask for these terms in writing. The simulation may say things the person never said.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Versona AI persona
Waitlist
Generative simulation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Adults deliberately considering this format.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
SET @s := IF(@hasnote = 1 AND @pid IS NOT NULL, CONCAT('UPDATE products SET note_key = ''product_note_simulation'' WHERE id = ', @pid), 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- Uare.ai
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'uare.ai' OR LOWER(`name`) = 'uare.ai')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Uare.ai', NULL, 'https://www.uare.ai', NULL, NULL, 'Персональний AI, який жива людина будує зі своїх історій, голосу й документів (колишній Eternos).', 'A personal AI that a living person builds from their own stories, voice and documents (formerly Eternos).', 'Uare.ai пропонує людині створити «індивідуальний AI» з власного голосу, досвіду й документів (компанія називає це Human Life Model). Сервіс орієнтований на живих людей і професіоналів: особу перевіряють перед публікацією, дані, за заявою компанії, не використовуються для навчання публічних моделей, їх можна експортувати й видалити. За повідомленнями преси, це ребрендинг сервісу цифрової спадщини Eternos (2025). Ціни — на сайті.', 'Uare.ai lets a person create an “individual AI” from their own voice, experience and documents (the company calls this a Human Life Model). It is aimed at living people and professionals: identity is verified before publishing, data, according to the company, are not used to train public models, and can be exported and deleted. According to press reports, it is a 2025 rebrand of the digital legacy service Eternos. Prices are on the website.', 'AI зі своїх історій і голосу
Верифікація особи
Експорт і видалення даних', 'AI from your own stories and voice
Identity verification
Data export and deletion', 'Живим людям, які створюють AI-версію себе за власною згодою.', 'Living people creating an AI version of themselves with their own consent.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'uare.ai' OR LOWER(`name`) = 'uare.ai') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A personal AI that a living person builds from their own stories, voice and documents (formerly Eternos).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Uare.ai lets a person create an “individual AI” from their own voice, experience and documents (the company calls this a Human Life Model). It is aimed at living people and professionals: identity is verified before publishing, data, according to the company, are not used to train public models, and can be exported and deleted. According to press reports, it is a 2025 rebrand of the digital legacy service Eternos. Prices are on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI from your own stories and voice
Identity verification
Data export and deletion', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Living people creating an AI version of themselves with their own consent.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
SET @s := IF(@hasnote = 1 AND @pid IS NOT NULL, CONCAT('UPDATE products SET note_key = ''product_note_simulation'' WHERE id = ', @pid), 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- StoryFile
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'storyfile.com' OR LOWER(`name`) = 'storyfile')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'StoryFile', NULL, 'https://www.storyfile.com', NULL, NULL, 'Інтерактивне відео: людина заздалегідь записує відповіді, а система показує найближчу до запитання.', 'Interactive video: a person records answers in advance, and the system plays the one closest to the question.', 'StoryFile — платформа «розмовного відео»: глядач ставить запитання, а система добирає відповідь із заздалегідь записаних відео людини, без генерації нових слів. Зараз компанія продає рішення переважно музеям і установам, а для родин згадує напрям Legacies; споживчого застосунку й цін на сайті немає. У 2024 році StoryFile подавала на банкрутство за главою 11 у США. Записи, зроблені за життя людини, залежать від того, чи працюватиме платформа далі, тож зберігайте копії відео.', 'StoryFile is a “conversational video” platform: a viewer asks a question and the system selects an answer from the person’s pre-recorded videos, without generating new words. The company now sells mainly to museums and institutions and mentions a Legacies offering for families; there is no consumer app or pricing on the website. In 2024, StoryFile filed for Chapter 11 bankruptcy in the US. Recordings made during a person’s life depend on the platform continuing to operate, so keep copies of the videos.', 'Відповіді з записаних відео
Без генерації нових слів
Рішення для установ', 'Answers from recorded videos
No generation of new words
Solutions for institutions', 'Установам і родинам, що записують інтерв''ю за життя людини.', 'Institutions and families recording interviews during a person’s lifetime.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'storyfile.com' OR LOWER(`name`) = 'storyfile') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Interactive video: a person records answers in advance, and the system plays the one closest to the question.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'StoryFile is a “conversational video” platform: a viewer asks a question and the system selects an answer from the person’s pre-recorded videos, without generating new words. The company now sells mainly to museums and institutions and mentions a Legacies offering for families; there is no consumer app or pricing on the website. In 2024, StoryFile filed for Chapter 11 bankruptcy in the US. Recordings made during a person’s life depend on the platform continuing to operate, so keep copies of the videos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Answers from recorded videos
No generation of new words
Solutions for institutions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Institutions and families recording interviews during a person’s lifetime.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
SET @s := IF(@hasnote = 1 AND @pid IS NOT NULL, CONCAT('UPDATE products SET note_key = ''product_note_simulation'' WHERE id = ', @pid), 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- Delphi
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'delphi.ai' OR LOWER(`name`) = 'delphi')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Delphi', NULL, 'https://www.delphi.ai', NULL, NULL, 'Платформа «цифрових розумів»: експерти й творці створюють AI-версію себе, з якою можуть спілкуватися інші.', 'A platform of “digital minds”: experts and creators build an AI version of themselves that others can talk to.', 'Delphi дозволяє живій людині (експерту, автору, коучу) створити AI-версію себе на основі власних матеріалів, а відвідувачам — ставити запитання й отримувати «перспективи» різних людей. Це сервіс для двійника за участі й згоди самої людини, а не для відтворення померлих. Відповіді генерує модель, тож вони можуть відрізнятися від того, що сказала б людина. Умови й ціни — на сайті.', 'Delphi lets a living person (an expert, author or coach) create an AI version of themselves from their own materials, while visitors ask questions and get “perspectives” from different people. It is a service for a twin created with the person’s own participation and consent, not for recreating people who have died. Answers are generated by a model, so they may differ from what the person would say. Terms and prices are on the website.', 'AI-версія експерта з його матеріалів
Запитання до різних «перспектив»
Створюється самою людиною', 'AI version of an expert from their own materials
Questions to different “perspectives”
Created by the person themselves', 'Експертам і творцям, а також тим, хто шукає їхні поради.', 'Experts and creators, and people seeking their advice.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'delphi.ai' OR LOWER(`name`) = 'delphi') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A platform of “digital minds”: experts and creators build an AI version of themselves that others can talk to.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Delphi lets a living person (an expert, author or coach) create an AI version of themselves from their own materials, while visitors ask questions and get “perspectives” from different people. It is a service for a twin created with the person’s own participation and consent, not for recreating people who have died. Answers are generated by a model, so they may differ from what the person would say. Terms and prices are on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI version of an expert from their own materials
Questions to different “perspectives”
Created by the person themselves', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Experts and creators, and people seeking their advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
SET @s := IF(@hasnote = 1 AND @pid IS NOT NULL, CONCAT('UPDATE products SET note_key = ''product_note_simulation'' WHERE id = ', @pid), 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- Tavus
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tavus.io' OR LOWER(`name`) = 'tavus')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tavus', NULL, 'https://www.tavus.io', NULL, NULL, 'Платформа відео-AI в реальному часі для розробників і компаній; репліки людей — лише за явною згодою зображеної людини.', 'A real-time video AI platform for developers and companies; replicas of people only with the depicted person’s explicit consent.', 'Tavus надає API й інструменти для створення відео-агентів, що розмовляють у реальному часі, а також застосунок AI-компаньйонів (PALs). Правила використання вимагають явної поінформованої згоди людини, чию подобу чи голос використано для репліки, можливості відкликати цю згоду й чіткого повідомлення користувачам, що вони спілкуються з AI. Створення реплік інших людей без згоди заборонено. Ціни — на сайті.', 'Tavus provides an API and tools for building video agents that talk in real time, as well as an AI companion app (PALs). Its usage policy requires the explicit, informed consent of the person whose likeness or voice is used for a replica, the ability to revoke that consent, and clear disclosure to users that they are talking to AI. Creating replicas of other people without consent is prohibited. Prices are on the website.', 'API відео-агентів у реальному часі
Репліки лише за згодою
Позначення взаємодії з AI', 'Real-time video agent API
Replicas only with consent
AI interaction disclosure', 'Розробникам і компаніям.', 'Developers and companies.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-23 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tavus.io' OR LOWER(`name`) = 'tavus') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A real-time video AI platform for developers and companies; replicas of people only with the depicted person’s explicit consent.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Tavus provides an API and tools for building video agents that talk in real time, as well as an AI companion app (PALs). Its usage policy requires the explicit, informed consent of the person whose likeness or voice is used for a replica, the ability to revoke that consent, and clear disclosure to users that they are talking to AI. Creating replicas of other people without consent is prohibited. Prices are on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time video agent API
Replicas only with consent
AI interaction disclosure', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Developers and companies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
SET @s := IF(@hasnote = 1 AND @pid IS NOT NULL, CONCAT('UPDATE products SET note_key = ''product_note_simulation'' WHERE id = ', @pid), 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- =================== Наявні продукти: лише прив'язка ===================

-- Remini
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'remini' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Topaz Labs
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'topaz labs' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Adobe Photoshop
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'adobe photoshop' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Fotor
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'fotor' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Hotpot.ai
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'hotpot.ai' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Upscayl
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'upscayl' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Palette.fm
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'palette.fm' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Adobe Lightroom
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'adobe lightroom' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- D-ID
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'd-id' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Hedra
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'hedra' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- HeyGen
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'heygen' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Runway
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'runway' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Kling AI
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'kling ai' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Pika
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'pika' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Luma Dream Machine
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'luma dream machine' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Hailuo AI
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'hailuo ai' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Google Veo
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'google veo' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Vidu
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'vidu' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- ElevenLabs
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'elevenlabs' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Resemble AI
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'resemble ai' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Descript
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'descript' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Murf AI
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'murf ai' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Speechify
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'speechify' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Adobe Podcast
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'adobe podcast' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Krisp
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'krisp' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Auphonic
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'auphonic' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- LALAL.AI
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'lalal.ai' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Audacity
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'audacity' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- FamilySearch
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'familysearch' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Canva
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'canva' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- CapCut
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'capcut' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Filmora
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'filmora' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- DaVinci Resolve
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'davinci resolve' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Kapwing
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'kapwing' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Suno
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'suno' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- ChatGPT
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'chatgpt' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Claude
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'claude' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Synthesia
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'synthesia' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @s := IF(@hasnote = 1 AND @pid IS NOT NULL, CONCAT('UPDATE products SET note_key = ''product_note_simulation'' WHERE id = ', @pid), 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- Character.AI
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'character.ai' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @s := IF(@hasnote = 1 AND @pid IS NOT NULL, CONCAT('UPDATE products SET note_key = ''product_note_simulation'' WHERE id = ', @pid), 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- Replika
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'replika' AND `status` = 'published' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @s := IF(@hasnote = 1 AND @pid IS NOT NULL, CONCAT('UPDATE products SET note_key = ''product_note_simulation'' WHERE id = ', @pid), 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

