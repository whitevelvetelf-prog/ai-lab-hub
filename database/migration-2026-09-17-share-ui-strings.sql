-- =====================================================================
-- AI LAB HUB — міграція: EN-написи кнопки «Поділитися»
--
--   Нові ключі t() (app/translations.php: share_button, share_copy_link,
--   share_copied, share_email, share_product_text) — готовий людський
--   переклад одразу в ui_translations, source='manual'. Google Translate
--   API тут НЕ витрачається (рядки короткі й прості, автопереклад не
--   потрібен).
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити ЯК Є у вкладку SQL.
--   * локально: mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-17-share-ui-strings.sql
--
--   Безпечно повторно застосовувати: INSERT IGNORE (унікальний ключ
--   (key_name, lang) не дає дублів). Таблиця ui_translations сама
--   створюється в migration-2026-09-17-translation-tables.sql — якщо її
--   ще нема, застосуйте той файл першим.
-- =====================================================================

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('share_button', 'en', 'Share', 'manual'),
('share_copy_link', 'en', 'Copy link', 'manual'),
('share_copied', 'en', 'Link copied', 'manual'),
('share_email', 'en', 'Email', 'manual'),
('share_product_text', 'en', 'Check out %s on AI LAB HUB', 'manual');
