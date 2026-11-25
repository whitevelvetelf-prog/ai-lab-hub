-- =====================================================================
-- AI LAB HUB — міграція 2026-11-25 (Багвіль, № 38): інтерактивні сцени Розділу 1 (Автомат, Пошта, Бібліотека).
-- (№ 36 і 37 зайняті гілкою bugville-progress: звання/значки й Книга слів.)
--
-- Лише ADD COLUMN до bv_attempts за перевіркою через information_schema. Без DROP / TRUNCATE / DELETE / FOREIGN KEY,
-- нових таблиць немає. Повторний запуск нічого не змінює.
--   scene_state_json — серверний стан сцени спроби: дії гравця (до 50, кожен ввід до 30 символів), знайдені поломки,
--                      гаманець сцени. Правила варіанту тут НЕ зберігаються: їх відновлює сервер із seed.
--   act_count        — скільки дій уже прийнято; оптимістичне блокування (UPDATE … WHERE act_count = :old AND used = 0).
-- Нові колонки належать bv_attempts, тож видалення даних гравця (bv_delete_player_data) і прибирання гостьових
-- спроб охоплюють їх без нових DELETE.
--
-- УВАГА для хостингу (phpMyAdmin): там information_schema з DATABASE() повертає 0 рядків — у копії для проду
-- замінити DATABASE() на явну назву бази. На живу базу — лише після «так» власниці.
-- =====================================================================

SET NAMES utf8mb4;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'bv_attempts'
              AND COLUMN_NAME = 'scene_state_json') = 0,
  'ALTER TABLE bv_attempts ADD COLUMN scene_state_json MEDIUMTEXT NULL', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'bv_attempts'
              AND COLUMN_NAME = 'act_count') = 0,
  'ALTER TABLE bv_attempts ADD COLUMN act_count SMALLINT UNSIGNED NOT NULL DEFAULT 0', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- Контроль (очікується 2):
--   SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'bv_attempts'
--     AND COLUMN_NAME IN ('scene_state_json', 'act_count');
