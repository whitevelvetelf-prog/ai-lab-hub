-- =====================================================================
-- AI LAB HUB — міграція: EN-напис «Забагато запитів» (IP-ліміти Marketplace; ключ mpb_rate_limited)
-- Українська — у app/translations.php. Безпечно повторювати: INSERT IGNORE. Тільки INSERT.
-- =====================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('mpb_rate_limited', 'en', 'Too many requests, please try again later.', 'manual');
