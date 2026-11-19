-- =====================================================================
-- AI LAB HUB — міграція 2026-11-19 (№ 24): географія показу реклами (країни й міста).
--
--   ad_campaign_geo           — правила кампанії: include / exclude, місце з geo_places (країна або місто),
--                               радіус для міста (NULL → 25 км). place_type і country_code — копія з geo_places
--                               при збереженні (швидкий SQL-відбір кандидатів за країною без JOIN).
--   ad_campaign_geo_settings  — режим збігу кампанії: soft (типово) | strict.
--
-- Кампанія без активних рядків (is_active = 1) у ad_campaign_geo показується всім (як до цієї міграції).
-- Таблиці реклами (ad_campaigns, ad_targets, …), користувачів і каталогу НЕ змінюються: лише нові таблиці з
-- посиланням на id кампанії. Без FOREIGN KEY, без DROP / DELETE / TRUNCATE. Повторний запуск безпечний.
-- Потребує геодовідника (migration-2026-11-03-marketplace-geo-places.sql + geo-data-NN.sql).
-- =====================================================================

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS ad_campaign_geo (
  id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
  campaign_id  INT UNSIGNED NOT NULL,
  mode         VARCHAR(7)   NOT NULL,              -- include | exclude
  place_id     INT UNSIGNED NOT NULL,              -- geo_places.id (type country або city)
  place_type   VARCHAR(10)  NOT NULL,              -- country | city (копія geo_places.type)
  country_code CHAR(2)      NOT NULL,              -- копія geo_places.country_code
  radius_km    SMALLINT UNSIGNED NULL,             -- лише для міста; NULL → 25 км
  is_active    TINYINT(1)   NOT NULL DEFAULT 1,    -- 0 — правило прибрано у формі (без DELETE; повторне додавання вмикає)
  created_at   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_campaign_mode_place (campaign_id, mode, place_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS ad_campaign_geo_settings (
  campaign_id INT UNSIGNED NOT NULL,
  match_mode  VARCHAR(6)   NOT NULL DEFAULT 'soft',  -- soft | strict
  updated_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (campaign_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Індекси (кожен — лише якщо його ще немає)
SET @s = (SELECT IF(COUNT(*) = 0, 'CREATE INDEX idx_campaign ON ad_campaign_geo (campaign_id)', 'DO 0')
  FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'ad_campaign_geo' AND INDEX_NAME = 'idx_campaign');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'CREATE INDEX idx_place ON ad_campaign_geo (place_id)', 'DO 0')
  FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'ad_campaign_geo' AND INDEX_NAME = 'idx_place');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- Відбір кандидатів: EXISTS / NOT EXISTS (campaign_id, is_active, mode, country_code)
SET @s = (SELECT IF(COUNT(*) = 0, 'CREATE INDEX idx_campaign_mode_cc ON ad_campaign_geo (campaign_id, is_active, mode, country_code, place_type)', 'DO 0')
  FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'ad_campaign_geo' AND INDEX_NAME = 'idx_campaign_mode_cc');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- Правила країни відвідувача для перевірки радіуса в PHP (adgeo_country_rules): WHERE country_code = ? AND is_active = 1
SET @s = (SELECT IF(COUNT(*) = 0, 'CREATE INDEX idx_cc_active ON ad_campaign_geo (country_code, is_active)', 'DO 0')
  FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'ad_campaign_geo' AND INDEX_NAME = 'idx_cc_active');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;
