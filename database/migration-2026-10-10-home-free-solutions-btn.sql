-- =====================================================================
-- AI LAB HUB — міграція: EN-напис кнопки «Безкоштовні AI-рішення» в hero головної (public/index.php)
-- Українські тексти — у app/translations.php. Безпечно повторювати: INSERT IGNORE. Тільки INSERT.
-- =====================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('home_free_solutions_btn', 'en', 'Free AI solutions', 'manual');
