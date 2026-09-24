-- =====================================================================
-- AI LAB HUB — міграція: EN-написи сторінки оголошення (тип ціни «Не вказано», підпис «Опубліковано»)
-- Українські тексти — у app/translations.php. Безпечно повторювати: INSERT IGNORE. Тільки INSERT.
-- =====================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('mpb_pt_none', 'en', 'Not specified', 'manual'),
('mpb_published_label', 'en', 'Published', 'manual');
