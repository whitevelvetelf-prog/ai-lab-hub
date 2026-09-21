-- =====================================================================
-- AI LAB HUB — Marketplace: версія Правил, з якою погодився автор (mp_listings.rules_version)
--
-- Ідемпотентна міграція (MySQL і MariaDB): єдиний ALTER — ALTER TABLE mp_listings ADD COLUMN, лише якщо
-- колонки ще немає (перевірка через information_schema + PREPARE/EXECUTE). DROP/DELETE/TRUNCATE немає.
-- Значення = config 'rules_version' на момент збереження; записується разом із rules_accepted_at.
-- Старі записи лишаються NULL. ЗАЛИВАТИ ДО коду (код пише в цю колонку).
-- =====================================================================

SET NAMES utf8mb4;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN rules_version VARCHAR(20) NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'rules_version');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;
