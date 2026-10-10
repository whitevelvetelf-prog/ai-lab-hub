-- =====================================================================
-- AI LAB HUB — міграція: EN-напис позначки Готового AI-рішення в спільному списку Marketplace (app/mpb-card.php)
-- Українські тексти — у app/translations.php. Безпечно повторювати: INSERT IGNORE. Тільки INSERT.
-- Дані оголошень і рішень НЕ змінюються: рішення вже лежать у mp_listings (section='solution').
-- =====================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('mp_solution_tag', 'en', 'Ready-made AI solution · AI LAB HUB', 'manual');
