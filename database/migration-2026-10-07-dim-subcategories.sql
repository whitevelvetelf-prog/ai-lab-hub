SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — міграція 2026-10-07: нові підгрупи категорії «Мій дім» (slug my-home):
--   * Розумний дім / Smart Home (slug smart-home)
--   * Безпека дому / Home Security (slug home-security)
--   * Ремонт і будівництво / Renovation & Construction (slug renovation)
--   * Нерухомість і оренда / Real Estate & Rentals (slug real-estate)
--   * Домашнє господарство / Household Management (slug household)
--   * Енергія та резервне живлення / Energy & Backup Power (slug home-energy)
--   Без DROP/CREATE і без фіксованих id. Безпечно повторювати.
--   Застосування: phpMyAdmin → «Импорт» — ДО партії batches/2026-10-07-dim-*.sql.
-- =====================================================================

SET @rel := (SELECT id FROM categories WHERE slug = 'my-home');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Розумний дім', 'Smart Home', 'smart-home' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'smart-home');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Безпека дому', 'Home Security', 'home-security' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'home-security');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Ремонт і будівництво', 'Renovation & Construction', 'renovation' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'renovation');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Нерухомість і оренда', 'Real Estate & Rentals', 'real-estate' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'real-estate');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Домашнє господарство', 'Household Management', 'household' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'household');

INSERT INTO subcategories (category_id, name, name_en, slug)
SELECT @rel, 'Енергія та резервне живлення', 'Energy & Backup Power', 'home-energy' FROM DUAL
WHERE @rel IS NOT NULL AND NOT EXISTS (SELECT 1 FROM subcategories WHERE category_id = @rel AND slug = 'home-energy');

