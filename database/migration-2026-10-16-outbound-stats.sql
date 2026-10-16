-- =====================================================================
-- AI LAB HUB — міграція 2026-10-16: переходи на сайти продуктів (етап 0, блок 3)
--
--   link_clicks.lang — мова інтерфейсу в момент кліку (uk / en), для частки UA/EN
--   у звіті для сервісу (public/admin-vendor-report.php). Старі рядки — NULL («немає даних»).
--   Індекс (product_id, session_hash, clicked_at) — для дедуплікації повторних кліків
--   одного сеансу (app/analytics.php: analytics_log_click()).
--
-- Безпечно повторно: колонка й індекс додаються лише якщо їх ще немає (MySQL не має
-- ADD COLUMN IF NOT EXISTS — той самий ефект через information_schema + PREPARE).
-- Жодних DROP / TRUNCATE.
-- Застосування: phpMyAdmin → БД → вкладка SQL → вставити файл → Вперёд.
-- =====================================================================

SET NAMES utf8mb4;
SET @db := DATABASE();

SET @sql := (SELECT IF(
    (SELECT COUNT(*) FROM information_schema.COLUMNS
      WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'link_clicks' AND COLUMN_NAME = 'lang') > 0,
    'SELECT 1',
    'ALTER TABLE link_clicks ADD COLUMN lang VARCHAR(5) NULL AFTER session_hash'
));
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

SET @sql := (SELECT IF(
    (SELECT COUNT(*) FROM information_schema.STATISTICS
      WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'link_clicks' AND INDEX_NAME = 'idx_link_clicks_dedup') > 0,
    'SELECT 1',
    'ALTER TABLE link_clicks ADD INDEX idx_link_clicks_dedup (product_id, session_hash, clicked_at)'
));
PREPARE stmt FROM @sql;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

-- EN-підписи нових посилань у кабінеті адміна (account.php → «Статистика сайту»).
INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('account_outbound_link', 'en', 'Clicks to product sites →', 'manual'),
('account_summary_link', 'en', 'Media kit summary →', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';
