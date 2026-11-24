-- =====================================================================
-- AI LAB HUB — міграція 2026-11-24 (№ 35): англійські підписи меню «Власні продукти» → «Ігри» → «Багвіль».
-- Українські — у app/translations.php. Лише INSERT IGNORE у ui_translations (наявні рядки не змінюються).
-- Без USE / DROP / DELETE / TRUNCATE / ALTER.
-- =====================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
    ('nav_own_products', 'en', 'Our products', 'manual'),
    ('nav_games', 'en', 'Games', 'manual'),
    ('nav_bugville', 'en', 'Bugville', 'manual');

-- Контроль (очікується 3):
--   SELECT COUNT(*) FROM ui_translations WHERE lang = 'en' AND key_name IN ('nav_own_products', 'nav_games', 'nav_bugville');
