-- =====================================================================
-- AI LAB HUB — міграція 2026-11-06: підтвердження пошти з поверненням + чернетки форм подачі.
--
--   1) mp_email_verifications.next_path — куди повернути користувача після підтвердження
--      (внутрішня сторінка, перевіряє PHP: auth_safe_next()). Код працює і без колонки.
--   2) mp_form_drafts — автозбереження незавершених форм подачі (вакансія / курс / послуга / дошка):
--      одна чернетка на (користувач, форма). Показується в «Мої оголошення», відновлюється у формі.
--
-- Лише ALTER TABLE mp_* ADD COLUMN за перевіркою information_schema і CREATE TABLE IF NOT EXISTS.
-- Жодних DROP / DELETE / TRUNCATE; дані не змінюються. Повторний запуск безпечний (MySQL 5.7+ / MariaDB 10.3+).
-- =====================================================================

SET NAMES utf8mb4;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_email_verifications ADD COLUMN next_path VARCHAR(300) NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_email_verifications' AND COLUMN_NAME = 'next_path');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

CREATE TABLE IF NOT EXISTS mp_form_drafts (
  id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id     INT UNSIGNED NOT NULL,
  form_key    VARCHAR(40)  NOT NULL,          -- listing:job | listing:course | listing:service | board
  title       VARCHAR(200) NOT NULL DEFAULT '',
  data_json   MEDIUMTEXT   NOT NULL,
  created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_mp_form_drafts_user_form (user_id, form_key),
  KEY idx_mp_form_drafts_updated (updated_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Контроль (очікується: 1 і 1)
SELECT COUNT(*) AS next_path_column FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_email_verifications' AND COLUMN_NAME = 'next_path';
SELECT COUNT(*) AS drafts_table FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_form_drafts';
