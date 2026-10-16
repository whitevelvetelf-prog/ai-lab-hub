-- =====================================================================
-- AI LAB HUB — міграція 2026-10-17: діагностика з'єднання Елі й журнал запасного режиму
--
--   eli_api_log.source += 'diag'      — рядки кнопки «Перевірити з'єднання з AI» (admin-stats.php);
--                                        у показники відповідей не входять.
--   eli_api_log.used_fallback_model   — відповіла запасна модель (раніше це було в used_fallback).
--   eli_api_log.used_fallback         — відтепер: відповідь запасним режимом без AI (добірка з бази).
--   eli_api_log.fallback_empty        — запасна добірка не знайшла нічого впевненого (прогалини каталогу).
--   Наявні рядки перераховуються один раз — лише тоді, коли колонку used_fallback_model щойно додано.
--
-- Безпечно повторно (перевірки через information_schema + PREPARE). Жодних DROP / TRUNCATE.
-- Застосування: phpMyAdmin → БД → «Импорт» або вкладка SQL → цей файл → Вперёд.
-- =====================================================================

SET NAMES utf8mb4;
SET @db := DATABASE();

SET @sql := (SELECT IF(
    (SELECT COLUMN_TYPE FROM information_schema.COLUMNS
      WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'eli_api_log' AND COLUMN_NAME = 'source') LIKE '%''diag''%',
    'SELECT 1',
    'ALTER TABLE eli_api_log MODIFY source ENUM(''ai'', ''cache'', ''fallback'', ''fail'', ''limited'', ''diag'') NOT NULL DEFAULT ''ai'''
));
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @had_fbm := (SELECT COUNT(*) FROM information_schema.COLUMNS
                  WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'eli_api_log' AND COLUMN_NAME = 'used_fallback_model');

SET @sql := IF(@had_fbm > 0, 'SELECT 1',
    'ALTER TABLE eli_api_log ADD COLUMN used_fallback_model TINYINT(1) NOT NULL DEFAULT 0 AFTER used_fallback');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql := IF(@had_fbm > 0, 'SELECT 1',
    'UPDATE eli_api_log SET used_fallback_model = used_fallback, used_fallback = (source = ''fallback'')');
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql := (SELECT IF(
    (SELECT COUNT(*) FROM information_schema.COLUMNS
      WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'eli_api_log' AND COLUMN_NAME = 'fallback_empty') > 0,
    'SELECT 1',
    'ALTER TABLE eli_api_log ADD COLUMN fallback_empty TINYINT(1) NOT NULL DEFAULT 0 AFTER used_fallback_model'
));
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
