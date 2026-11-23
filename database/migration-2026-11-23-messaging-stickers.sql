-- =====================================================================
-- AI LAB HUB — міграція 2026-11-23 (Marketplace, № 32): стікери «Еля» в повідомленнях — EN-написи.
-- UA-тексти — app/translations.php. Таблиць і колонок не додає: стікер зберігається в mp_messages.body як «[[sticker:elya/<id>]]»,
-- картинки — public/assets/stickers/elya/*.png. Без цієї міграції EN-сторінка покаже автопереклад або українські підписи.
-- Безпечно й ідемпотентно: лише INSERT IGNORE. DROP / DELETE / TRUNCATE / UPDATE немає.
-- Виконати у phpMyAdmin → база gu621051_ailabhublive → Імпорт цього файлу.
-- =====================================================================

SET NAMES utf8mb4;

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('msg_stickers', 'en', 'Stickers with Elya', 'manual'),
('msg_sticker_send', 'en', 'Send sticker: %s', 'manual'),
('msg_sticker_alt', 'en', 'Elya sticker: %s', 'manual'),
('msg_sticker_copy', 'en', 'Copy', 'manual'),
('msg_sticker_copied', 'en', 'Copied ✓', 'manual'),
('msg_sticker_share', 'en', 'Share', 'manual'),
('msg_sticker_link_copied', 'en', 'Link copied ✓', 'manual'),
('msg_sticker_hello', 'en', 'Hi!', 'manual'),
('msg_sticker_thanks', 'en', 'Thank you!', 'manual'),
('msg_sticker_agreed', 'en', 'Deal!', 'manual'),
('msg_sticker_ok', 'en', 'Yes, agreed', 'manual'),
('msg_sticker_paid', 'en', 'Paid', 'manual'),
('msg_sticker_sent', 'en', 'Shipped', 'manual'),
('msg_sticker_received', 'en', 'Got it!', 'manual'),
('msg_sticker_wait', 'en', 'One moment…', 'manual'),
('msg_sticker_thinking', 'en', 'Let me think', 'manual'),
('msg_sticker_question', 'en', 'I have a question', 'manual'),
('msg_sticker_wow', 'en', 'Wow!', 'manual'),
('msg_sticker_love', 'en', 'Awesome!', 'manual'),
('msg_sticker_haha', 'en', 'Haha!', 'manual'),
('msg_sticker_sorry', 'en', 'Sorry', 'manual'),
('msg_sticker_working', 'en', 'Working on it', 'manual'),
('msg_sticker_call', 'en', 'I''ll call you', 'manual'),
('msg_sticker_bye', 'en', 'Talk soon!', 'manual'),
('msg_sticker_sleepy', 'en', 'I''ll reply tomorrow', 'manual');

-- Контроль (очікуване — у дужках):
--   SELECT COUNT(*) FROM ui_translations WHERE lang = 'en' AND key_name LIKE 'msg\_sticker%';  -- 25
