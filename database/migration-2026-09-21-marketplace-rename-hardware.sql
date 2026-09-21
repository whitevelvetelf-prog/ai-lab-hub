-- =====================================================================
-- AI LAB HUB — Marketplace: перейменування категорії board 'accounts-equipment' -> 'hardware'
--
-- Для БД, де вже застосовано СТАРЕ насіння (локально). На новій БД насіння з 06/07 одразу створює 'hardware',
-- тож тут усе — без змін. Ідемпотентно, лише UPDATE (без DROP/DELETE/ALTER); id категорії й прив'язки
-- оголошень (mp_listing_categories) не змінюються.
--   slug  : accounts-equipment -> hardware   (лише якщо 'hardware' у board ще немає — унікальний ключ)
--   uk    : «Обладнання та техніка»
--   en    : «Hardware and equipment»
-- =====================================================================

SET NAMES utf8mb4;

UPDATE mp_categories
SET slug = 'hardware'
WHERE section = 'board' AND slug = 'accounts-equipment'
  AND NOT EXISTS (SELECT 1 FROM (SELECT id FROM mp_categories WHERE section = 'board' AND slug = 'hardware') x);

UPDATE mp_category_translations t
JOIN mp_categories c ON c.id = t.category_id
SET t.name = 'Обладнання та техніка'
WHERE c.section = 'board' AND c.slug = 'hardware' AND t.lang = 'uk' AND t.name <> 'Обладнання та техніка';

UPDATE mp_category_translations t
JOIN mp_categories c ON c.id = t.category_id
SET t.name = 'Hardware and equipment'
WHERE c.section = 'board' AND c.slug = 'hardware' AND t.lang = 'en' AND t.name <> 'Hardware and equipment';
