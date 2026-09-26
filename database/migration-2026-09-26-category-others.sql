-- =====================================================================
-- AI LAB HUB — міграція: EN-напис блоку «Інші категорії» на сторінці категорії
-- Український текст — у app/translations.php. Безпечно повторювати: INSERT IGNORE. Тільки INSERT.
-- =====================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('category_others', 'en', 'Other categories', 'manual');
