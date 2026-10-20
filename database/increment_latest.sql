-- =====================================================================
-- AI LAB HUB — 2026-10-23: англійський текст кнопки «Виклик Асистента» → «Call Assistant»
-- (повний і короткий мобільний варіант). Український текст — у app/translations.php.
-- Безпечно для повторного запуску (INSERT … ON DUPLICATE KEY UPDATE, лише два рядки ui_translations).
-- =====================================================================
SET NAMES utf8mb4;
INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('nav_assistant', 'en', 'Call Assistant', 'manual'),
('nav_assistant_short', 'en', 'Call Assistant', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';
