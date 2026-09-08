-- =====================================================================
-- AI LAB HUB — терміновий фікс живої бази (хостинг, phpMyAdmin)
--
-- Один блок. Вставити ЯК Є у вкладку SQL phpMyAdmin (база вже обрана
-- в інтерфейсі — рядок USE не потрібен) і виконати ОДИН раз.
--
-- Що робить:
--   * створює таблицю admin_requests, якщо її ще немає;
--   * додає колонки position / first_name / last_name / phone / email
--     в admin_requests, якщо їх ще немає;
--   * додає індекс на admin_requests.position, якщо його ще немає;
--   * додає колонки position та phone в users, якщо їх ще немає.
--
-- Безпечний для повторного запуску: якщо щось уже додано — цей рядок
-- просто пропускається, помилки не буде.
-- =====================================================================

CREATE TABLE IF NOT EXISTS admin_requests (
  id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id      INT UNSIGNED NOT NULL,
  `position`   VARCHAR(32) NULL,
  first_name   VARCHAR(255) NULL,
  last_name    VARCHAR(255) NULL,
  phone        VARCHAR(32) NULL,
  email        VARCHAR(255) NULL,
  status       ENUM('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  requested_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  reviewed_by  INT UNSIGNED NULL,
  reviewed_at  TIMESTAMP NULL,
  PRIMARY KEY (id),
  KEY idx_admin_requests_user (user_id),
  KEY idx_admin_requests_status (status),
  KEY idx_admin_requests_position (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='admin_requests' AND COLUMN_NAME='position')=0,
  'ALTER TABLE admin_requests ADD COLUMN `position` VARCHAR(32) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='admin_requests' AND COLUMN_NAME='first_name')=0,
  'ALTER TABLE admin_requests ADD COLUMN first_name VARCHAR(255) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='admin_requests' AND COLUMN_NAME='last_name')=0,
  'ALTER TABLE admin_requests ADD COLUMN last_name VARCHAR(255) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='admin_requests' AND COLUMN_NAME='phone')=0,
  'ALTER TABLE admin_requests ADD COLUMN phone VARCHAR(32) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='admin_requests' AND COLUMN_NAME='email')=0,
  'ALTER TABLE admin_requests ADD COLUMN email VARCHAR(255) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.STATISTICS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='admin_requests' AND INDEX_NAME='idx_admin_requests_position')=0,
  'ALTER TABLE admin_requests ADD KEY idx_admin_requests_position (`position`)','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='users' AND COLUMN_NAME='position')=0,
  'ALTER TABLE users ADD COLUMN `position` VARCHAR(255) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='users' AND COLUMN_NAME='phone')=0,
  'ALTER TABLE users ADD COLUMN phone VARCHAR(32) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;
