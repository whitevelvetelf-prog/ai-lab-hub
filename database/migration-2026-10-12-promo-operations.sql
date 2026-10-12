-- =====================================================================
-- AI LAB HUB — міграція: відеореклама, блоки F–I (2026-10-12).
--   F  медіакіт (public/advertise.php): анонімні колонки page_views
--      (клас пристрою, мова) і кеш агрегатів аудиторії promo_audience_stats.
--   G  перевірка посилань креативів (додається нижче)
--   H  виключення чутливих сторінок і категорії рекламодавців (додається нижче)
--   I  e-mail і cron (додається нижче)
--
-- Працює поверх migration-2026-10-11-promo-video.sql (його треба застосувати раніше).
-- Лише CREATE TABLE IF NOT EXISTS / умовні ALTER / INSERT IGNORE / UPDATE прапорців.
-- Жодних DROP / TRUNCATE. Безпечно застосовувати повторно.
-- ad_settings.enabled НЕ змінюється.
-- Час у нових таблицях — UTC (DATETIME, пише код); межі «доби» — Europe/Kyiv.
-- =====================================================================

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------
-- F1) page_views: анонімний клас пристрою (mobile/tablet/desktop/bot) і мова
--     інтерфейсу для агрегованої статистики аудиторії. Без UA, без IP.
--     Старі рядки лишаються NULL (дані накопичуються лише для нових переглядів).
-- ---------------------------------------------------------------------
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='page_views' AND COLUMN_NAME='device_class')=0,
  'ALTER TABLE page_views ADD COLUMN device_class VARCHAR(10) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='page_views' AND COLUMN_NAME='lang')=0,
  'ALTER TABLE page_views ADD COLUMN lang VARCHAR(5) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- ---------------------------------------------------------------------
-- F2) promo_audience_stats — кеш агрегатів аудиторії за період (оновлює
--     cron/promo-daily.php). metric: page_views, sessions, lang, lang_known,
--     device, device_known, top_category (dim = id категорії).
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS promo_audience_stats (
    period_from DATE NOT NULL,
    period_to   DATE NOT NULL,
    metric      VARCHAR(32) NOT NULL,
    dim         VARCHAR(64) NOT NULL DEFAULT '',
    value       BIGINT NOT NULL DEFAULT 0,
    computed_at DATETIME NOT NULL,
    PRIMARY KEY (period_to, metric, dim)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- F3) Посилання «Реклама на сайті» в підвалі (українська — у app/translations.php).
INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('footer_advertise', 'en', 'Advertise', 'manual');

-- F4) Текст строку модерації для медіакіту (порожньо = «фіксованого строку немає»).
INSERT IGNORE INTO ad_settings (setting_key, setting_value) VALUES
('moderation_time_text_uk', ''),
('moderation_time_text_en', '');
