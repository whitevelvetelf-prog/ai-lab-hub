-- =====================================================================
-- AI LAB HUB — міграція: EN-написи єдиної навігації розділу Marketplace (app/mp-section-nav.php)
-- Українські тексти — у app/translations.php. Безпечно повторювати: INSERT IGNORE. Тільки INSERT.
-- =====================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('mp_nav_label', 'en', 'Marketplace section', 'manual'),
('mp_nav_board', 'en', 'Listings', 'manual'),
('mp_nav_solutions', 'en', 'Ready-made AI solutions', 'manual'),
('mp_nav_rules', 'en', 'Rules', 'manual');
