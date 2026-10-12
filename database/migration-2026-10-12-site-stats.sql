-- =====================================================================
-- AI LAB HUB — міграція: добові агрегати переглядів сайту (2026-10-12).
--
--   page_views_daily — перегляди й унікальні сеанси за київську добу
--   (Europe/Kyiv). Звідси блок «Перегляди сайту» і рекорди за весь час на
--   public/admin-stats.php (app/site-stats.php). Сирі page_views не змінюються;
--   якщо їх колись почистять, агрегати лишаються.
--   updated_at — UTC; день вважається закритим, коли updated_at пізніше за його
--   київську північ — такий день більше не перераховується.
--
--   Backfill нижче — одноразове заповнення з наявних page_views (INSERT IGNORE:
--   наявні дні не змінюються, повторний запуск безпечний). Київська доба
--   рахується без таблиць часових поясів MySQL: UTC+3 від останньої неділі
--   березня 01:00 UTC до останньої неділі жовтня 01:00 UTC, інакше UTC+2.
--   Сьогоднішній і пропущені дні дораховує код при відкритті статистики.
--   Альтернатива з командного рядка: php cron/stats-backfill.php
--
--   Плюс EN-переклад написів блоку (ui_translations, source='manual').
--
-- Лише CREATE TABLE IF NOT EXISTS / INSERT IGNORE. Жодних DROP / DELETE / TRUNCATE.
-- =====================================================================

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS page_views_daily (
    day        DATE NOT NULL,
    views      INT UNSIGNED NOT NULL DEFAULT 0,
    sessions   INT UNSIGNED NOT NULL DEFAULT 0,
    updated_at DATETIME NOT NULL,
    PRIMARY KEY (day)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Backfill (сесія в UTC лише на час цього імпорту).
SET time_zone = '+00:00';
INSERT IGNORE INTO page_views_daily (day, views, sessions, updated_at)
SELECT kyiv_day, COUNT(*), COUNT(DISTINCT session_hash), UTC_TIMESTAMP()
FROM (
    SELECT session_hash,
           DATE(viewed_at + INTERVAL IF(
               viewed_at >= TIMESTAMP(DATE(CONCAT(YEAR(viewed_at), '-03-31')) - INTERVAL (DAYOFWEEK(CONCAT(YEAR(viewed_at), '-03-31')) - 1) DAY, '01:00:00')
               AND viewed_at < TIMESTAMP(DATE(CONCAT(YEAR(viewed_at), '-10-31')) - INTERVAL (DAYOFWEEK(CONCAT(YEAR(viewed_at), '-10-31')) - 1) DAY, '01:00:00'),
               3, 2) HOUR) AS kyiv_day
    FROM page_views
) v
GROUP BY kyiv_day;

-- Налаштування «Не рахувати перегляди адмінів» (типово увімкнено).
INSERT IGNORE INTO site_settings (setting_key, setting_value) VALUES ('stats_exclude_staff', '1');

INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('pv_block_title', 'en', 'Site views', 'manual'),
('pv_block_note', 'en', 'A view is an opened site page (home, catalog, categories, product pages, blog articles); the account area and admin pages are not counted. Days follow Kyiv time.', 'manual'),
('pv_card_today', 'en', 'Today', 'manual'),
('pv_card_week', 'en', 'Week', 'manual'),
('pv_card_month', 'en', 'Month', 'manual'),
('pv_period_today', 'en', 'today, {date}', 'manual'),
('pv_period_days', 'en', 'last {n} days, {from}–{to}', 'manual'),
('pv_views', 'en', 'views', 'manual'),
('pv_sessions', 'en', 'unique sessions', 'manual'),
('pv_vs_yesterday', 'en', 'vs yesterday at the same time', 'manual'),
('pv_vs_prev7', 'en', 'vs the previous 7 days', 'manual'),
('pv_vs_prev30', 'en', 'vs the previous 30 days', 'manual'),
('pv_no_compare', 'en', 'Comparison appears once a full previous period is available', 'manual'),
('pv_of_record', 'en', '{pct}% of the record', 'manual'),
('pv_new_record', 'en', 'New record', 'manual'),
('pv_record_title', 'en', 'All-time records', 'manual'),
('pv_record_day', 'en', 'Best day', 'manual'),
('pv_record_week', 'en', 'Best week', 'manual'),
('pv_record_month', 'en', 'Best month', 'manual'),
('pv_record_sessions', 'en', '{n} sessions', 'manual'),
('pv_few_data', 'en', 'not much data yet', 'manual'),
('pv_no_data', 'en', 'No data yet', 'manual'),
('pv_chart_title', 'en', 'Views over the last 30 days', 'manual'),
('pv_chart_record', 'en', 'record day', 'manual'),
('pv_migration_needed', 'en', 'Apply the migration database/migration-2026-10-12-site-stats.sql.', 'manual'),
('pv_settings_title', 'en', 'Statistics settings', 'manual'),
('pv_exclude_staff', 'en', 'Don’t count admin views', 'manual'),
('pv_exclude_staff_hint', 'en', 'Views by signed-in admins and employees are not recorded. Earlier admin views stay in the statistics.', 'manual'),
('pv_save', 'en', 'Save', 'manual'),
('pv_saved', 'en', 'Saved.', 'manual'),
('pv_save_failed', 'en', 'Could not save. The session expired or the site_settings table is missing.', 'manual'),
('pv_account_today', 'en', 'Today', 'manual'),
('pv_account_7d', 'en', '7 days', 'manual'),
('pv_account_30d', 'en', '30 days', 'manual'),
('pv_account_record', 'en', 'Best day', 'manual'),
('pv_account_more', 'en', 'Details', 'manual');
