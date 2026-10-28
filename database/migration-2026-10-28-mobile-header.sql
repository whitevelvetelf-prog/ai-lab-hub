-- =====================================================================
-- AI LAB HUB — 2026-10-28: мобільна шапка (кнопка «Спитати Елю», іконка пошуку).
-- Англійські тексти нових ключів; український текст — у app/translations.php.
-- Безпечно для повторного запуску (INSERT … ON DUPLICATE KEY UPDATE, лише рядки ui_translations).
-- =====================================================================
SET NAMES utf8mb4;
INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('nav_eli_ask', 'en', 'Ask Elya', 'manual'),
('nav_eli_tiny', 'en', 'Elya', 'manual'),
('search_open_aria', 'en', 'Open search', 'manual'),
('search_close_aria', 'en', 'Close search', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';
