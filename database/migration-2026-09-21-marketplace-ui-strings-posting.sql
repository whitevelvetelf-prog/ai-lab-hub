-- =====================================================================
-- AI LAB HUB — міграція: EN-написи поетапного запуску Marketplace (подача оголошень закрита; ключі mpb_posting_*)
-- Українські тексти — у app/translations.php. Безпечно повторювати: INSERT IGNORE. Тільки INSERT.
-- =====================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('mpb_posting_closed', 'en', 'Listing submission will open soon.', 'manual'),
('mpb_posting_closed_title', 'en', 'Listing submission', 'manual'),
('mpb_posting_staff_login', 'en', 'Staff:', 'manual');
