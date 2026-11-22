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

-- @@EN_STRINGS@@

-- Контроль (очікуване — у дужках):
--   SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'mp_messages'
--     AND COLUMN_NAME IN ('attachment_path','attachment_name','attachment_mime','attachment_size','read_at');        -- 5
--   SHOW COLUMNS FROM mp_message_reports LIKE 'reported_user_id';                                                    -- 1 рядок
