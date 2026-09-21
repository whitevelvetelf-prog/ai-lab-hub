-- =====================================================================
-- AI LAB HUB — Marketplace: IP-ліміти (другий шар захисту; основні ліміти — на акаунт)
--
-- Безпечна міграція: лише CREATE TABLE IF NOT EXISTS (можна запускати повторно). Без FOREIGN KEY,
-- ALTER/DROP/TRUNCATE немає. IP у відкритому вигляді НЕ зберігається: key_hash = sha256(IP + сіль з config).
-- Вікно — доба (window_start = початок доби), hits — кількість дій у ній.
-- Старі рядки (window_start > 3 діб) видаляє mp-cron-expire.php.
-- =====================================================================

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS mp_rate_limits (
  id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
  key_hash     CHAR(64)     NOT NULL,
  action       VARCHAR(30)  NOT NULL,
  window_start DATETIME     NOT NULL,
  hits         INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE KEY uq_key_action_window (key_hash, action, window_start),
  KEY idx_window (window_start)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
