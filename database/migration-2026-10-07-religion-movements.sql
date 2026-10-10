SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — міграція 2026-10-07: нові підгрупи категорії «Релігія» (slug religion):
--   * Кабала / Kabbalah (slug kabbalah)
--   * Свідки Єгови / Jehovah's Witnesses (slug jehovahs-witnesses)
--   * Церква святих останніх днів (мормони) / Latter-day Saints (Mormons) (slug latter-day-saints)
--   * Адвентисти сьомого дня / Seventh-day Adventists (slug seventh-day-adventists)
--   * Харе Крішна (ISKCON) / Hare Krishna (ISKCON) (slug hare-krishna)
--   * Саєнтологія / Scientology (slug scientology)
--   * Брахма Кумаріс / Brahma Kumaris (slug brahma-kumaris)
--   * Сока Гаккай / Soka Gakkai (slug soka-gakkai)
--   * Трансцендентальна медитація / Transcendental Meditation (slug transcendental-meditation)
--   * Ошо / Osho (slug osho)
-- + перенесення 10 наявних карток із «Юдаїзм»/«Індуїзм» у «Кабала»/«Харе Крішна»/«Брахма Кумаріс».
--   Без DROP/CREATE і без фіксованих id. Безпечно повторювати.
--   Застосування: phpMyAdmin → «Импорт» — ДО партії batches/2026-10-07-religion-movements-*.sql.
-- =====================================================================

SET @rel := (SELECT id FROM categories WHERE slug = 'religion');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Кабала', 'Kabbalah', 'kabbalah' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'kabbalah');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Свідки Єгови', 'Jehovah''s Witnesses', 'jehovahs-witnesses' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'jehovahs-witnesses');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Церква святих останніх днів (мормони)', 'Latter-day Saints (Mormons)', 'latter-day-saints' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'latter-day-saints');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Адвентисти сьомого дня', 'Seventh-day Adventists', 'seventh-day-adventists' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'seventh-day-adventists');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Харе Крішна (ISKCON)', 'Hare Krishna (ISKCON)', 'hare-krishna' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'hare-krishna');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Саєнтологія', 'Scientology', 'scientology' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'scientology');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Брахма Кумаріс', 'Brahma Kumaris', 'brahma-kumaris' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'brahma-kumaris');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Сока Гаккай', 'Soka Gakkai', 'soka-gakkai' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'soka-gakkai');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Трансцендентальна медитація', 'Transcendental Meditation', 'transcendental-meditation' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'transcendental-meditation');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Ошо', 'Osho', 'osho' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'osho');

UPDATE product_subcategories ps JOIN products p ON p.id = ps.product_id
JOIN subcategories so ON so.id = ps.subcategory_id AND so.category_id = @rel AND so.slug = 'judaism'
SET ps.subcategory_id = (SELECT id FROM (SELECT id FROM subcategories WHERE category_id = @rel AND slug = 'kabbalah') t)
WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(p.official_url, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kabbalah.info';

UPDATE product_subcategories ps JOIN products p ON p.id = ps.product_id
JOIN subcategories so ON so.id = ps.subcategory_id AND so.category_id = @rel AND so.slug = 'hinduism'
SET ps.subcategory_id = (SELECT id FROM (SELECT id FROM subcategories WHERE category_id = @rel AND slug = 'hare-krishna') t)
WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(p.official_url, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'iskcon.org';

UPDATE product_subcategories ps JOIN products p ON p.id = ps.product_id
JOIN subcategories so ON so.id = ps.subcategory_id AND so.category_id = @rel AND so.slug = 'hinduism'
SET ps.subcategory_id = (SELECT id FROM (SELECT id FROM subcategories WHERE category_id = @rel AND slug = 'hare-krishna') t)
WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(p.official_url, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'iskconbangalore.org';

UPDATE product_subcategories ps JOIN products p ON p.id = ps.product_id
JOIN subcategories so ON so.id = ps.subcategory_id AND so.category_id = @rel AND so.slug = 'hinduism'
SET ps.subcategory_id = (SELECT id FROM (SELECT id FROM subcategories WHERE category_id = @rel AND slug = 'hare-krishna') t)
WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(p.official_url, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'iskcondesiretree.com';

UPDATE product_subcategories ps JOIN products p ON p.id = ps.product_id
JOIN subcategories so ON so.id = ps.subcategory_id AND so.category_id = @rel AND so.slug = 'hinduism'
SET ps.subcategory_id = (SELECT id FROM (SELECT id FROM subcategories WHERE category_id = @rel AND slug = 'hare-krishna') t)
WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(p.official_url, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'krishna.com';

UPDATE product_subcategories ps JOIN products p ON p.id = ps.product_id
JOIN subcategories so ON so.id = ps.subcategory_id AND so.category_id = @rel AND so.slug = 'hinduism'
SET ps.subcategory_id = (SELECT id FROM (SELECT id FROM subcategories WHERE category_id = @rel AND slug = 'hare-krishna') t)
WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(p.official_url, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vedabase.io';

UPDATE product_subcategories ps JOIN products p ON p.id = ps.product_id
JOIN subcategories so ON so.id = ps.subcategory_id AND so.category_id = @rel AND so.slug = 'hinduism'
SET ps.subcategory_id = (SELECT id FROM (SELECT id FROM subcategories WHERE category_id = @rel AND slug = 'hare-krishna') t)
WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(p.official_url, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prabhupada.com';

UPDATE product_subcategories ps JOIN products p ON p.id = ps.product_id
JOIN subcategories so ON so.id = ps.subcategory_id AND so.category_id = @rel AND so.slug = 'hinduism'
SET ps.subcategory_id = (SELECT id FROM (SELECT id FROM subcategories WHERE category_id = @rel AND slug = 'brahma-kumaris') t)
WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(p.official_url, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brahmakumaris.org';

UPDATE product_subcategories ps JOIN products p ON p.id = ps.product_id
JOIN subcategories so ON so.id = ps.subcategory_id AND so.category_id = @rel AND so.slug = 'hinduism'
SET ps.subcategory_id = (SELECT id FROM (SELECT id FROM subcategories WHERE category_id = @rel AND slug = 'hare-krishna') t)
WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(p.official_url, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'asitis.com';

UPDATE product_subcategories ps JOIN products p ON p.id = ps.product_id
JOIN subcategories so ON so.id = ps.subcategory_id AND so.category_id = @rel AND so.slug = 'hinduism'
SET ps.subcategory_id = (SELECT id FROM (SELECT id FROM subcategories WHERE category_id = @rel AND slug = 'hare-krishna') t)
WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(p.official_url, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mayapur.tv';
