-- =====================================================================
-- AI LAB HUB — міграція 2026-11-06 (Marketplace, № 19): EN-написи дерева категорій (головна Marketplace, сторінки
-- блока й підкатегорії, вибір блока у формі, позначки «Від AI LAB HUB» / «Від автора»). Ключі mpt_* — app/translations.php
-- (українські тексти — там). Готовий переклад одразу в ui_translations (source='manual').
-- Безпечно повторювати: INSERT IGNORE (унікальний ключ (key_name, lang)). Лише INSERT.
-- =====================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('mpt_home_title', 'en', 'Marketplace — AI jobs, courses, services and ready-made solutions', 'manual'),
('mpt_home_desc', 'en', 'AI listings: jobs, courses, services, ready-made solutions and hardware. Pick a section or use search.', 'manual'),
('mpt_home_subtitle', 'en', 'AI jobs, learning, services and ready-made solutions. Pick a section.', 'manual'),
('mpt_blocks_title', 'en', 'Sections', 'manual'),
('mpt_fresh', 'en', 'Latest listings', 'manual'),
('mpt_free_solutions', 'en', 'Free solutions', 'manual'),
('mpt_crumbs', 'en', 'Breadcrumbs', 'manual'),
('mpt_subcategories', 'en', 'Subcategories', 'manual'),
('mpt_subcategory', 'en', 'Subcategory', 'manual'),
('mpt_all_subcategories', 'en', 'All subcategories', 'manual'),
('mpt_empty_block', 'en', 'No listings yet. Be the first', 'manual'),
('mpt_empty_sub', 'en', 'There are no listings in this category yet.', 'manual'),
('mpt_search_in', 'en', 'Search in “%s”…', 'manual'),
('mpt_search_title', 'en', 'Search listings', 'manual'),
('mpt_search_title_q', 'en', 'Search: %s', 'manual'),
('mpt_page_n', 'en', 'page %d', 'manual'),
('mpt_block_desc', 'en', '%1$s on AI LAB HUB Marketplace: %2$d listings. Pick a subcategory or use search.', 'manual'),
('mpt_sub_desc', 'en', '%1$s (%3$s) on AI LAB HUB Marketplace: %2$d listings. Filter by format, city and price.', 'manual'),
('mpt_fmt_online', 'en', 'Online / remote', 'manual'),
('mpt_fmt_offline', 'en', 'On-site', 'manual'),
('mpt_from_platform', 'en', 'By AI LAB HUB', 'manual'),
('mpt_from_author', 'en', 'By the author', 'manual'),
('mpt_pick_block', 'en', 'Choose the section for your listing.', 'manual'),
('mpt_block_label', 'en', 'Section', 'manual'),
('mpt_change_block', 'en', 'Change section', 'manual'),
('mpt_optional', 'en', 'optional', 'manual');
