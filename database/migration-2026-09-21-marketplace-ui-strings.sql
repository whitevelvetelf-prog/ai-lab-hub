-- =====================================================================
-- AI LAB HUB — міграція: EN-написи публічної частини Marketplace (+ EN-назви категорій)
--
--   Ключі t() з app/translations.php (nav_marketplace, mp_*, footer_marketplace).
--   Готовий людський переклад одразу в ui_translations, source='manual' —
--   Google Translate API для них не витрачається.
--
--   Назви 7 стартових категорій розділу — англійською в mp_category_translations (lang='en').
--
--   Безпечно повторювати: INSERT IGNORE (унікальний ключ (key_name, lang)).
--   Потребує таблиці ui_translations (migration-2026-09-17-translation-tables.sql).
--   Тільки INSERT: жодних DROP/DELETE/TRUNCATE/ALTER.
-- =====================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('nav_marketplace', 'en', 'Marketplace', 'manual'),
('footer_marketplace', 'en', 'Marketplace', 'manual'),
('title_marketplace', 'en', 'AI LAB HUB — Marketplace', 'manual'),
('mp_heading', 'en', 'Marketplace', 'manual'),
('mp_subtitle', 'en', 'Ready-made solutions: prompts, automation templates, guides and scripts — free of charge.', 'manual'),
('mp_search_placeholder', 'en', 'Search by title…', 'manual'),
('mp_search_btn', 'en', 'Search', 'manual'),
('mp_search_reset', 'en', 'Reset', 'manual'),
('mp_categories_title', 'en', 'Categories', 'manual'),
('mp_offers_title', 'en', 'Offers', 'manual'),
('mp_all_categories', 'en', 'All', 'manual'),
('mp_empty', 'en', 'There are no published offers yet.', 'manual'),
('mp_empty_search', 'en', 'Nothing was found for your search.', 'manual'),
('mp_empty_category', 'en', 'There are no offers in this category yet.', 'manual'),
('mp_back', 'en', '← Back to Marketplace', 'manual'),
('mp_details', 'en', 'Details', 'manual'),
('mp_get', 'en', 'Get', 'manual'),
('mp_license_label', 'en', 'License', 'manual'),
('mp_categories_label', 'en', 'Categories', 'manual'),
('mp_seller_label', 'en', 'Seller', 'manual'),
('mp_original_lang', 'en', 'Text in the original language: %s', 'manual'),
('mp_get_hint_file', 'en', 'The file is available to registered users.', 'manual'),
('mp_login_title', 'en', 'Sign in required', 'manual'),
('mp_login_text', 'en', 'Files are available to registered users only. Sign in or create an account to get the file.', 'manual'),
('mp_register', 'en', 'Create account', 'manual'),
('mp_contact_title', 'en', 'Contact to get this solution', 'manual'),
('mp_contact_text', 'en', 'To get this solution, use this contact:', 'manual'),
('mp_unavailable_title', 'en', 'Currently unavailable', 'manual'),
('mp_unavailable_text', 'en', 'This offer cannot be received right now. Please try again later.', 'manual'),
('mp_home_title', 'en', 'Marketplace: ready-made solutions', 'manual'),
('mp_home_text', 'en', 'Prompts, automation templates, guides and scripts — free of charge.', 'manual'),
('mp_home_all', 'en', 'All offers', 'manual');

INSERT INTO mp_category_translations (category_id, lang, name)
SELECT c.id, 'en', t.name FROM mp_categories c
JOIN (
  SELECT 'prompts' AS slug, 'Prompts and prompt packs' AS name UNION ALL
  SELECT 'workflows',          'Automation templates' UNION ALL
  SELECT 'custom-assistants',  'Custom assistants' UNION ALL
  SELECT 'scripts',            'Scripts and code' UNION ALL
  SELECT 'guides',             'Guides and checklists' UNION ALL
  SELECT 'design-resources',   'Design resources' UNION ALL
  SELECT 'datasets',           'Data and datasets'
) t ON t.slug = c.slug
WHERE c.section = 'solution'
  AND NOT EXISTS (
    SELECT 1 FROM mp_category_translations x
    WHERE x.category_id = c.id AND x.lang = 'en'
  );
