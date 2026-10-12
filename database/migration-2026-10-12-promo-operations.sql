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

-- =====================================================================
-- G) Перевірка посилань рекламних креативів (app/promo-linkcheck.php).
-- =====================================================================

-- G1) Журнал перевірок адрес переходу. Час — UTC.
CREATE TABLE IF NOT EXISTS ad_link_checks (
    id                   INT UNSIGNED NOT NULL AUTO_INCREMENT,
    creative_id          INT NOT NULL,
    checked_at           DATETIME NOT NULL,
    url                  VARCHAR(500) NOT NULL,
    final_url            VARCHAR(1000) NULL,
    final_host           VARCHAR(255) NULL,
    http_status          SMALLINT UNSIGNED NULL,
    redirect_count       TINYINT UNSIGNED NOT NULL DEFAULT 0,
    response_ms          INT UNSIGNED NOT NULL DEFAULT 0,
    safe_browsing_status ENUM('ok', 'flagged', 'unknown', 'skipped') NOT NULL DEFAULT 'skipped',
    flags                VARCHAR(255) NOT NULL DEFAULT '',
    notes                TEXT NULL,
    PRIMARY KEY (id),
    KEY idx_ad_link_checks_creative (creative_id, id),
    KEY idx_ad_link_checks_checked (checked_at)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- G2) Чорний список доменів (керує адмін; батьківський домен блокує й піддомени).
CREATE TABLE IF NOT EXISTS ad_domain_blocklist (
    id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    domain     VARCHAR(255) NOT NULL,
    reason     VARCHAR(255) NULL,
    created_by INT UNSIGNED NULL,
    created_at DATETIME NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uniq_ad_domain_blocklist (domain)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- G3) Журнал подій реклами (автопауза, повторні перевірки, схвалення з підтвердженням тощо).
CREATE TABLE IF NOT EXISTS promo_event_log (
    id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    created_at  DATETIME NOT NULL,
    event       VARCHAR(40) NOT NULL,
    creative_id INT NULL,
    campaign_id INT NULL,
    user_id     INT UNSIGNED NULL,
    details     TEXT NULL,
    PRIMARY KEY (id),
    KEY idx_promo_event_log_created (created_at),
    KEY idx_promo_event_log_campaign (campaign_id, id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- G4) Стан перевірки на креативі. link_final_host — кінцевий домен, зафіксований
--     під час модерації (для виявлення підміни); link_fail_streak — помилки поспіль;
--     recheck_reason — чому креатив повернуто на повторну модерацію.
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_creatives' AND COLUMN_NAME='link_check_status')=0,
  'ALTER TABLE ad_creatives ADD COLUMN link_check_status VARCHAR(10) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_creatives' AND COLUMN_NAME='link_checked_at')=0,
  'ALTER TABLE ad_creatives ADD COLUMN link_checked_at DATETIME NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_creatives' AND COLUMN_NAME='link_final_host')=0,
  'ALTER TABLE ad_creatives ADD COLUMN link_final_host VARCHAR(255) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_creatives' AND COLUMN_NAME='link_fail_streak')=0,
  'ALTER TABLE ad_creatives ADD COLUMN link_fail_streak TINYINT UNSIGNED NOT NULL DEFAULT 0','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_creatives' AND COLUMN_NAME='recheck_reason')=0,
  'ALTER TABLE ad_creatives ADD COLUMN recheck_reason VARCHAR(255) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- G5) Список доменів-скорочувачів (рядок на домен; редагує адмін). INSERT IGNORE не
--     перезаписує вже змінений список.
INSERT IGNORE INTO ad_settings (setting_key, setting_value) VALUES
('shortener_domains', 'bit.ly\ntinyurl.com\nt.co\ngoo.gl\now.ly\nis.gd\nbuff.ly\ncutt.ly\nrebrand.ly\nshorturl.at\nt.ly\ntiny.cc\nrb.gy\nbitly.com\ns.id\nclck.ru\nv.gd\nlnkd.in\nshort.io\nqr.ae');
