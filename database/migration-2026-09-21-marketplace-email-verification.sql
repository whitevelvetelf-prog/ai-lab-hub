-- =====================================================================
-- AI LAB HUB — Marketplace, етап 5: підтвердження email (лише для дій у Marketplace)
--
-- Безпечна міграція: тільки CREATE TABLE IF NOT EXISTS. Можна запускати повторно.
-- Без FOREIGN KEY, таблицю users не чіпає, DROP/DELETE/TRUNCATE/ALTER немає.
--
-- Токен: 32 випадкових байти (hex у листі), у БД лише sha256 (token_hash), дійсний 24 години,
-- одноразовий (verified_at). Підтвердження чинне, поки email у записі збігається з поточним
-- email користувача (users.email) — зміна email робить його недійсним.
-- =====================================================================

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS mp_email_verifications (
  id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id     INT UNSIGNED NOT NULL,
  email       VARCHAR(190) NOT NULL,
  token_hash  CHAR(64)     NOT NULL,
  created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  expires_at  DATETIME     NOT NULL,
  verified_at DATETIME     NULL,
  PRIMARY KEY (id),
  KEY idx_user (user_id),
  KEY idx_token_hash (token_hash)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
