-- =====================================================================
-- AI LAB HUB — Правила Marketplace і юридичні механізми (2026-11-17). ОДИН файл для вкладки SQL / «Импорт» phpMyAdmin.
--
-- Безпечно й ідемпотентно (можна виконати двічі поспіль без помилок):
--   * нові таблиці — CREATE TABLE IF NOT EXISTS;
--   * нові колонки й індекси — лише якщо їх ще немає. MySQL (на відміну від MariaDB) не знає
--     «ADD COLUMN IF NOT EXISTS», тому перевірка робиться через information_schema + PREPARE/EXECUTE
--     (той самий прийом, що в інших міграціях проєкту).
-- DROP / DELETE / TRUNCATE / MODIFY немає. Наявні дані не змінюються.
--
-- Статуси mp_listings.status — VARCHAR(20), нові значення змін схеми не потребують:
--   pending | published | needs_changes (на доопрацюванні) | rejected | hidden (приховано на час розгляду скарги)
--   | removed (знято адміністрацією) | expired | archived (видалено автором) | draft
-- =====================================================================

SET NAMES utf8mb4;

-- На проді phpMyAdmin інколи не бачить information_schema за DATABASE(); тоді — явна назва бази.
SET @db = IF((SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings') > 0,
             DATABASE(), 'gu621051_ailabhublive');

-- ---------------------------------------------------------------------
-- 1. Оголошення: AI-медіа (п. 4.5), умови використання (п. 9.5), код причини рішення, дата зміни статусу
-- ---------------------------------------------------------------------
SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_listings ADD COLUMN ai_generated_media TINYINT(1) NOT NULL DEFAULT 0', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'ai_generated_media');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_listings ADD COLUMN usage_terms VARCHAR(20) NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'usage_terms');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_listings ADD COLUMN usage_terms_note VARCHAR(200) NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'usage_terms_note');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_listings ADD COLUMN reject_code VARCHAR(20) NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'reject_code');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_listings ADD COLUMN status_changed_at DATETIME NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'status_changed_at');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- Лист «строк закінчується» (п. 7.6) — колонка вже є в оголошень компаній; для дошки оголошень та сама.
SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_listings ADD COLUMN expiry_notified_at DATETIME NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'expiry_notified_at');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- ---------------------------------------------------------------------
-- 2. Облік переглядів контактів (п. 12.3): + хеш IP (IP у відкритому вигляді не зберігається)
-- ---------------------------------------------------------------------
SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_contact_reveals ADD COLUMN ip_hash CHAR(64) NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'mp_contact_reveals' AND COLUMN_NAME = 'ip_hash');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'CREATE INDEX idx_listing_created ON mp_contact_reveals (listing_id, created_at)', 'DO 0')
  FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'mp_contact_reveals' AND INDEX_NAME = 'idx_listing_created');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- ---------------------------------------------------------------------
-- 3. Користувачі: попередження й обмеження подачі (п. 7.3–7.4, 10.5)
--    posting_banned_until: NULL — без обмежень; дата в майбутньому — заборона подачі до неї; 9999-12-31 — безстроково.
--    blocked_at: акаунт заблоковано (не NULL) — подача, контакти й скарги недоступні.
-- ---------------------------------------------------------------------
SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE users ADD COLUMN warnings_count INT UNSIGNED NOT NULL DEFAULT 0', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'users' AND COLUMN_NAME = 'warnings_count');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE users ADD COLUMN posting_banned_until DATETIME NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'users' AND COLUMN_NAME = 'posting_banned_until');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE users ADD COLUMN blocked_at DATETIME NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'users' AND COLUMN_NAME = 'blocked_at');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- ---------------------------------------------------------------------
-- 4. Нові таблиці
-- ---------------------------------------------------------------------

-- Скарги на оголошення (розділи 10–11). Від зареєстрованих (reporter_id) або гостей з email (reporter_email).
-- Поля правовласника (claimant_*, infringed_work, evidence_*, good_faith) — лише для reason = 'copyright'.
-- Заперечення автора (п. 10.3) — counter_*.
CREATE TABLE IF NOT EXISTS mp_complaints (
  id                   INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  listing_id           INT UNSIGNED  NOT NULL,
  reporter_id          INT UNSIGNED  NULL,
  reporter_email       VARCHAR(190)  NULL,
  reason               VARCHAR(30)   NOT NULL,
  note                 TEXT          NULL,
  claimant_name        VARCHAR(200)  NULL,
  claimant_contact     VARCHAR(300)  NULL,
  infringed_work       TEXT          NULL,
  evidence_url         VARCHAR(500)  NULL,
  evidence_file        VARCHAR(80)   NULL,
  good_faith           TINYINT(1)    NOT NULL DEFAULT 0,
  ip_hash              CHAR(64)      NULL,
  status               VARCHAR(20)   NOT NULL DEFAULT 'new',
  admin_note           VARCHAR(1000) NULL,
  counter_text         TEXT          NULL,
  counter_evidence_url VARCHAR(500)  NULL,
  counter_at           DATETIME      NULL,
  created_at           DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at           DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  resolved_at          DATETIME      NULL,
  resolved_by          INT UNSIGNED  NULL,
  PRIMARY KEY (id),
  KEY idx_listing (listing_id),
  KEY idx_status_created (status, created_at),
  KEY idx_reporter_created (reporter_id, created_at),
  KEY idx_ip_created (ip_hash, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Оскарження рішень модерації (п. 7.5): з кабінету автора або внесене admin за листом.
CREATE TABLE IF NOT EXISTS mp_appeals (
  id              INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  listing_id      INT UNSIGNED  NOT NULL,
  user_id         INT UNSIGNED  NOT NULL,
  decision_status VARCHAR(20)   NOT NULL,
  text            TEXT          NOT NULL,
  source          VARCHAR(10)   NOT NULL DEFAULT 'cabinet',
  status          VARCHAR(20)   NOT NULL DEFAULT 'open',
  admin_comment   VARCHAR(1000) NULL,
  created_by      INT UNSIGNED  NULL,
  created_at      DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  resolved_at     DATETIME      NULL,
  resolved_by     INT UNSIGNED  NULL,
  PRIMARY KEY (id),
  KEY idx_listing (listing_id),
  KEY idx_status_created (status, created_at),
  KEY idx_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Повідомлення автору (крок 12): показуються в кабінеті; email — якщо пошта сайту працює (emailed_at).
CREATE TABLE IF NOT EXISTS mp_notifications (
  id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id     INT UNSIGNED NOT NULL,
  listing_id  INT UNSIGNED NULL,
  event       VARCHAR(30)  NOT NULL,
  params      TEXT         NULL,
  created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  read_at     DATETIME     NULL,
  emailed_at  DATETIME     NULL,
  PRIMARY KEY (id),
  KEY idx_user_created (user_id, created_at),
  KEY idx_listing_event (listing_id, event)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Журнал санкцій щодо користувачів (попередження, заборона подачі, блокування, зняття).
CREATE TABLE IF NOT EXISTS mp_user_sanctions (
  id          INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  user_id     INT UNSIGNED  NOT NULL,
  action      VARCHAR(20)   NOT NULL,
  days        INT UNSIGNED  NULL,
  note        VARCHAR(1000) NULL,
  actor_id    INT UNSIGNED  NULL,
  created_at  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_user_created (user_id, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Контроль (необов'язково): має бути 4 таблиці і 9 колонок.
-- SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = @db
--   AND TABLE_NAME IN ('mp_complaints','mp_appeals','mp_notifications','mp_user_sanctions');
-- SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND COLUMN_NAME IN
--   ('ai_generated_media','usage_terms','usage_terms_note','reject_code','status_changed_at','ip_hash',
--    'warnings_count','posting_banned_until','blocked_at');
-- ---------------------------------------------------------------------
