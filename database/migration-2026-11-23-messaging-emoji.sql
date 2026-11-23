-- =====================================================================
-- AI LAB HUB — міграція 2026-11-23 (Marketplace, № 31): панель емодзі в повідомленнях — EN-написи.
-- UA-тексти — app/translations.php. Таблиць і колонок не додає: емодзі — звичайні символи в mp_messages.body (utf8mb4).
-- Без цієї міграції EN-сторінка покаже автопереклад або українські написи — код працює в будь-якому порядку.
-- Безпечно й ідемпотентно: лише INSERT IGNORE. DROP / DELETE / TRUNCATE / UPDATE немає.
-- Виконати у phpMyAdmin → база gu621051_ailabhublive → Імпорт цього файлу.
-- =====================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('msg_emoji', 'en', 'Emoji', 'manual'),
('msg_emoji_recent', 'en', 'Recent', 'manual'),
('msg_emoji_smileys', 'en', 'Smileys', 'manual'),
('msg_emoji_gestures', 'en', 'Gestures', 'manual'),
('msg_emoji_hearts', 'en', 'Hearts & celebrations', 'manual'),
('msg_emoji_work', 'en', 'Work & deals', 'manual'),
('msg_emoji_symbols', 'en', 'Symbols', 'manual');

-- Контроль (очікуване — у дужках):
--   SELECT COUNT(*) FROM ui_translations WHERE lang = 'en' AND key_name IN ('msg_emoji', 'msg_emoji_recent', 'msg_emoji_smileys', 'msg_emoji_gestures', 'msg_emoji_hearts', 'msg_emoji_work', 'msg_emoji_symbols'); -- 7
