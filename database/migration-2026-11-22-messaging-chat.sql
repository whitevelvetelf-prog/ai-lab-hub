-- =====================================================================
-- AI LAB HUB — міграція 2026-11-22 (Marketplace, № 30): повідомлення як чат у кабінеті.
-- Доповнює № 22 (migration-2026-11-18-marketplace-messaging.sql): ті самі таблиці mp_conversations, mp_messages,
-- mp_user_blocks, mp_message_reports — нових таблиць-дублікатів немає, лише нові колонки й індекс.
--
--   mp_messages.attachment_*  — одне вкладення на повідомлення (jpg / png / webp / pdf, до 5 МБ). Файл лежить ПОЗА коренем
--                               сайту, у тексті БД — лише відносне ім'я (рік/місяць/випадкові 32 hex + розширення).
--   mp_messages.read_at       — коли отримувач відкрив розмову (позначка «Прочитано» у відправника).
--   mp_message_reports.reported_user_id — на кого скарга (раніше обчислювалась зі знімка розмови).
--
-- Код працює й ДО цієї міграції (вкладення й «Прочитано» тоді приховано), тож порядок «код → SQL» не важливий.
-- Безпечно й ідемпотентно: ADD COLUMN / ADD INDEX лише за перевіркою в information_schema (MySQL не знає
-- ADD COLUMN IF NOT EXISTS). DROP / DELETE / TRUNCATE / MODIFY немає. Наявні дані не змінюються.
-- Виконати у phpMyAdmin → база gu621051_ailabhublive → вкладка SQL (або Імпорт цього файлу).
-- =====================================================================

SET NAMES utf8mb4;

-- На проді phpMyAdmin інколи не бачить information_schema за DATABASE(); тоді — явна назва бази.
SET @db = IF((SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_messages') > 0,
             DATABASE(), 'gu621051_ailabhublive');

-- ---------------------------------------------------------------------
-- 1. Вкладення й позначка прочитання в mp_messages
-- ---------------------------------------------------------------------
SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_messages ADD COLUMN attachment_path VARCHAR(80) NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'mp_messages' AND COLUMN_NAME = 'attachment_path');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_messages ADD COLUMN attachment_name VARCHAR(160) NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'mp_messages' AND COLUMN_NAME = 'attachment_name');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_messages ADD COLUMN attachment_mime VARCHAR(40) NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'mp_messages' AND COLUMN_NAME = 'attachment_mime');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_messages ADD COLUMN attachment_size INT UNSIGNED NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'mp_messages' AND COLUMN_NAME = 'attachment_size');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_messages ADD COLUMN read_at DATETIME NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'mp_messages' AND COLUMN_NAME = 'read_at');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- Ліміт «не більше N повідомлень за хвилину» рахує mp_messages за (sender_id, created_at) — індекс idx_sender_created уже є (№ 22).
-- Вибірка діалогів користувача — idx_buyer_last / idx_seller_last (№ 22); нові повідомлення після id — idx_conv_id (№ 22).

-- ---------------------------------------------------------------------
-- 2. Скарги: на кого
-- ---------------------------------------------------------------------
SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_message_reports ADD COLUMN reported_user_id INT UNSIGNED NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'mp_message_reports' AND COLUMN_NAME = 'reported_user_id');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_message_reports ADD INDEX idx_reported (reported_user_id, status)', 'DO 0')
  FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'mp_message_reports' AND INDEX_NAME = 'idx_reported');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- Наявні скарги: заповнити «на кого» (співрозмовник автора скарги). Лише рядки, де поле ще порожнє.
UPDATE mp_message_reports r JOIN mp_conversations c ON c.id = r.conversation_id
SET r.reported_user_id = IF(r.reporter_id = c.buyer_id, c.seller_user_id, c.buyer_id)
WHERE r.reported_user_id IS NULL;

-- ---------------------------------------------------------------------
-- 3. EN-написи чату й розділу 3.6 Політики (UA — app/translations.php). INSERT IGNORE — повторне виконання нічого не змінює.
-- ---------------------------------------------------------------------
INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('msg_err_minute', 'en', 'Too many messages in a minute. Please wait a little and try again.', 'manual'),
('msg_err_file_upload', 'en', 'The file could not be uploaded. Please try again.', 'manual'),
('msg_err_file_size', 'en', 'The file is too large: the limit is 5 MB.', 'manual'),
('msg_err_file_type', 'en', 'You can only send a JPG, PNG or WebP image or a PDF document.', 'manual'),
('msg_attach', 'en', 'Attach a file', 'manual'),
('msg_attach_hint', 'en', 'Image (JPG, PNG, WebP) or PDF up to 5 MB', 'manual'),
('msg_attach_remove', 'en', 'Remove the file', 'manual'),
('msg_placeholder_chat', 'en', 'Message… (Enter to send, Shift+Enter for a new line)', 'manual'),
('msg_read', 'en', 'Read', 'manual'),
('msg_sent', 'en', 'Sent', 'manual'),
('msg_actions', 'en', 'Conversation actions', 'manual'),
('msg_conversations', 'en', 'Conversations', 'manual'),
('msg_list_new', 'en', 'There are new conversations — refresh the list', 'manual'),
('msg_pick_conversation', 'en', 'Choose a conversation on the left.', 'manual'),
('msg_start_from_listing', 'en', 'A conversation starts from a listing: open a listing in the Marketplace and click “Message the author”.', 'manual'),
('msg_account_text', 'en', 'Conversations with Marketplace listing authors and with people who wrote to you.', 'manual'),
('msg_account_unread', 'en', 'Unread: %d', 'manual'),
('msg_account_none', 'en', 'No new messages.', 'manual'),
('msg_account_open', 'en', 'Open messages', 'manual'),
('msg_account_settings', 'en', 'Blocked users and other settings', 'manual'),
('msg_email_toggle_long', 'en', 'Receive emails about new messages', 'manual'),
('legal_privacy_msg_h', 'en', '3.6. Messages between users — DRAFT', 'manual'),
('legal_privacy_msg_store', 'en', 'What we store. A conversation can only start from a Marketplace listing. We store: the participants and the listing, the text of messages, attachments (JPG/PNG/WebP images are re-encoded without camera metadata or location; PDFs are stored as sent), the time a message was sent and the time the recipient read it, as well as your list of blocked users and your email settings. Message texts are not translated, not passed to external services and do not appear in search or statistics.', 'manual'),
('legal_privacy_msg_access', 'en', 'Who has access. Messages and attachments are visible only to the participants of the conversation; files are served only to them after a login check. Messages about the platform’s own listings are answered by AI LAB HUB staff. The administration views a conversation only when reviewing a complaint: a copy of the last 30 messages is attached to the complaint, and a full view is possible only with a recorded reason (access log).', 'manual'),
('legal_privacy_msg_email', 'en', 'Emails. If you turn on emails about new messages, we send at most one email per conversation every 30 minutes and only about an unread message. The email does not contain the message text — only the listing title and a link. We store the time of sent emails to respect these limits.', 'manual'),
('legal_privacy_msg_delete', 'en', 'Deletion. You can hide a conversation from your list (the other participant keeps their copy). Conversations with no new messages for more than 365 days are deleted automatically together with attachments; conversations with an unreviewed complaint are kept until it is reviewed. To fully delete your conversations earlier, write to us via the “Contacts” page.', 'manual');

-- Рядок «Останнє оновлення» Політики вже є в ui_translations (№ 28): оновлюємо лише його текст (додано пункт 3.6).
INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES ('legal_privacy_updated', 'en', 'Last updated: October 11, 2026; section 3.4 (draft) — October 22, 2026; section 3.5 (cookies) — November 3, 2026, updated November 19, 2026; section 3.6 (draft) — November 22, 2026.', 'manual')
  ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';


-- Контроль (очікуване — у дужках):
--   SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'mp_messages'
--     AND COLUMN_NAME IN ('attachment_path','attachment_name','attachment_mime','attachment_size','read_at');        -- 5
--   SHOW COLUMNS FROM mp_message_reports LIKE 'reported_user_id';                                                    -- 1 рядок
--   SELECT COUNT(*) FROM ui_translations WHERE lang = 'en' AND key_name IN ('msg_err_minute', 'msg_err_file_upload', 'msg_err_file_size', 'msg_err_file_type', 'msg_attach', 'msg_attach_hint', 'msg_attach_remove', 'msg_placeholder_chat', 'msg_read', 'msg_sent', 'msg_actions', 'msg_conversations', 'msg_list_new', 'msg_pick_conversation', 'msg_start_from_listing', 'msg_account_text', 'msg_account_unread', 'msg_account_none', 'msg_account_open', 'msg_account_settings', 'msg_email_toggle_long', 'legal_privacy_msg_h', 'legal_privacy_msg_store', 'legal_privacy_msg_access', 'legal_privacy_msg_email', 'legal_privacy_msg_delete'); -- 26
