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

-- =====================================================================
-- H) Виключення чутливих сторінок і категорії рекламодавців.
-- =====================================================================

-- H1) Прапорець «без реклами» (no_promo). Сторінка без реклами, якщо прапорець має
--     вона сама або її категорія/підкатегорія. Статті блогу — файли, тож для них
--     окрема таблиця за slug.
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='categories' AND COLUMN_NAME='no_promo')=0,
  'ALTER TABLE categories ADD COLUMN no_promo TINYINT(1) NOT NULL DEFAULT 0','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='subcategories' AND COLUMN_NAME='no_promo')=0,
  'ALTER TABLE subcategories ADD COLUMN no_promo TINYINT(1) NOT NULL DEFAULT 0','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='products' AND COLUMN_NAME='no_promo')=0,
  'ALTER TABLE products ADD COLUMN no_promo TINYINT(1) NOT NULL DEFAULT 0','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

CREATE TABLE IF NOT EXISTS promo_blog_flags (
    slug       VARCHAR(191) NOT NULL,
    no_promo   TINYINT(1) NOT NULL DEFAULT 0,
    updated_at DATETIME NULL,
    PRIMARY KEY (slug)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- H2) Значення за замовчуванням — ЛИШЕ при першому застосуванні (маркер у ad_settings),
--     щоб повторний запуск не повертав прапорці, які адмін потім зняв.
--     Підкатегорія «Ментальне здоров'я та харчова поведінка» (slug
--     mental-health-eating-behavior у категорії health-beauty), усі її продукти,
--     статті ai-and-eating-behavior-support і ai-for-psychology-and-mental-health.
SET @h2 := (SELECT COUNT(*) FROM ad_settings WHERE setting_key = 'no_promo_defaults_2026_10_12');
SET @sub_meb := (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id
                 WHERE s.slug = 'mental-health-eating-behavior' AND c.slug = 'health-beauty' LIMIT 1);

UPDATE subcategories SET no_promo = 1 WHERE @h2 = 0 AND id = @sub_meb;

UPDATE products p JOIN product_subcategories ps ON ps.product_id = p.id
SET p.no_promo = 1
WHERE @h2 = 0 AND ps.subcategory_id = @sub_meb;

INSERT INTO promo_blog_flags (slug, no_promo, updated_at)
SELECT x.slug, 1, UTC_TIMESTAMP() FROM (
    SELECT 'ai-and-eating-behavior-support' AS slug UNION ALL SELECT 'ai-for-psychology-and-mental-health'
) x
WHERE @h2 = 0
ON DUPLICATE KEY UPDATE no_promo = 1;

INSERT IGNORE INTO ad_settings (setting_key, setting_value) VALUES ('no_promo_defaults_2026_10_12', '1');

-- H3) Категорія реклами (обирає рекламодавець у майстрі, перевіряє модератор):
--     ai_tools, education, dev_it, business_marketing, finance, health_wellness,
--     food_nutrition, gambling, adult, other.
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='advertiser_category')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN advertiser_category VARCHAR(30) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- H4) Правила: яка категорія реклами заборонена де. scope_type all — всюди;
--     category / subcategory — на сторінках цієї категорії/підкатегорії (scope_id).
CREATE TABLE IF NOT EXISTS promo_category_rules (
    id                  INT UNSIGNED NOT NULL AUTO_INCREMENT,
    scope_type          ENUM('category', 'subcategory', 'all') NOT NULL,
    scope_id            INT UNSIGNED NULL,
    advertiser_category VARCHAR(30) NOT NULL,
    rule                ENUM('block') NOT NULL DEFAULT 'block',
    note                VARCHAR(255) NULL,
    created_at          DATETIME NOT NULL,
    PRIMARY KEY (id),
    KEY idx_promo_category_rules (advertiser_category, scope_type, scope_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Початкові правила (лише якщо такого правила ще немає).
INSERT INTO promo_category_rules (scope_type, scope_id, advertiser_category, rule, note, created_at)
SELECT 'all', NULL, 'gambling', 'block', 'Ставки й азартні ігри заборонені всюди (модерація відхиляє)', UTC_TIMESTAMP() FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM promo_category_rules WHERE scope_type = 'all' AND advertiser_category = 'gambling');

INSERT INTO promo_category_rules (scope_type, scope_id, advertiser_category, rule, note, created_at)
SELECT 'all', NULL, 'adult', 'block', 'Контент для дорослих заборонений всюди (модерація відхиляє)', UTC_TIMESTAMP() FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM promo_category_rules WHERE scope_type = 'all' AND advertiser_category = 'adult');

SET @cat_health := (SELECT id FROM categories WHERE slug = 'health-beauty' LIMIT 1);
INSERT INTO promo_category_rules (scope_type, scope_id, advertiser_category, rule, note, created_at)
SELECT 'category', @cat_health, 'food_nutrition', 'block', 'Реклама їжі й харчування не показується на сторінках здоров''я', UTC_TIMESTAMP() FROM DUAL
WHERE @cat_health IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM promo_category_rules WHERE scope_type = 'category' AND scope_id = @cat_health AND advertiser_category = 'food_nutrition');
