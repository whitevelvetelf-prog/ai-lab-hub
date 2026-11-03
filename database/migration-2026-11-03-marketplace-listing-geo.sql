-- =====================================================================
-- AI LAB HUB — міграція 2026-11-03 (Marketplace, етап 6, № 16): географія оголошень і налаштування відвідувача.
--
--   mp_listings ADD COLUMN:
--     work_format       online | offline | hybrid («Де надається»)
--     service_scope     local (місто з околицями) | country (вся країна / для онлайну — вибрані країни) | worldwide
--     primary_place_id  місто (geo_places.id) — обов'язкове для offline / hybrid
--     country_code, lat, lon — копія з місця при збереженні (для швидкого пошуку без JOIN)
--     service_radius_km радіус «місто з околицями», км (NULL — лише саме місто)
--     price_usd         ціна в USD за курсом НБУ на момент збереження (NULL — курсу немає / ціни немає)
--   mp_listing_places   додаткові місця охоплення (до 5; міста з радіусом або країни)
--   mp_user_prefs       налаштування пошуку залогіненого відвідувача (гість — cookie mp_loc з place_id)
--
-- Наявні city / is_remote лишаються для сумісності (код синхронізує is_remote з work_format).
-- Перенесення: is_remote = 1 → online + worldwide; інші (крім цифрових solution / asset) → offline.
--
-- Лише ALTER TABLE mp_listings ADD COLUMN і CREATE INDEX (за перевіркою information_schema),
-- CREATE TABLE IF NOT EXISTS, UPDATE лише нових колонок. Жодних DROP / DELETE / TRUNCATE / FOREIGN KEY.
-- Повторний запуск безпечний. Потребує migration-2026-11-03-marketplace-geo-places.sql (№ 15).
-- =====================================================================

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------
-- 1. Колонки mp_listings
-- ---------------------------------------------------------------------

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_listings ADD COLUMN work_format VARCHAR(10) NOT NULL DEFAULT ''online''', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'work_format');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_listings ADD COLUMN service_scope VARCHAR(10) NOT NULL DEFAULT ''local''', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'service_scope');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_listings ADD COLUMN primary_place_id INT UNSIGNED NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'primary_place_id');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_listings ADD COLUMN country_code CHAR(2) NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'country_code');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_listings ADD COLUMN lat DECIMAL(9,6) NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'lat');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_listings ADD COLUMN lon DECIMAL(9,6) NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'lon');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_listings ADD COLUMN service_radius_km SMALLINT UNSIGNED NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'service_radius_km');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_listings ADD COLUMN price_usd DECIMAL(12,2) NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'price_usd');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- ---------------------------------------------------------------------
-- 2. Нові таблиці
-- ---------------------------------------------------------------------

CREATE TABLE IF NOT EXISTS mp_listing_places (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
  listing_id INT UNSIGNED NOT NULL,
  place_id   INT UNSIGNED NOT NULL,              -- geo_places.id: місто або країна
  radius_km  SMALLINT UNSIGNED NULL,             -- для міста; NULL — лише саме місто
  sort_order TINYINT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE KEY uq_listing_place (listing_id, place_id),
  KEY idx_place (place_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS mp_user_prefs (
  user_id       INT UNSIGNED NOT NULL,
  country_code  CHAR(2)      NULL,
  place_id      INT UNSIGNED NULL,
  radius_km     SMALLINT UNSIGNED NULL,
  units         VARCHAR(2)   NOT NULL DEFAULT 'km',   -- km | mi
  listing_langs VARCHAR(100) NULL,                    -- через кому: uk,en
  show_online   TINYINT(1)   NOT NULL DEFAULT 1,
  updated_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 3. Індекси під пошук за місцем і ціною
-- ---------------------------------------------------------------------

SET @s = (SELECT IF(COUNT(*) = 0, 'CREATE INDEX idx_geo_format_country ON mp_listings (work_format, country_code)', 'DO 0')
  FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND INDEX_NAME = 'idx_geo_format_country');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'CREATE INDEX idx_geo_lat_lon ON mp_listings (lat, lon)', 'DO 0')
  FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND INDEX_NAME = 'idx_geo_lat_lon');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'CREATE INDEX idx_price_usd ON mp_listings (price_usd)', 'DO 0')
  FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND INDEX_NAME = 'idx_price_usd');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'CREATE INDEX idx_primary_place ON mp_listings (primary_place_id)', 'DO 0')
  FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND INDEX_NAME = 'idx_primary_place');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- ---------------------------------------------------------------------
-- 4. Перенесення наявних оголошень (лише нові колонки; повтор нічого не псує)
-- ---------------------------------------------------------------------

-- is_remote = 0 (і місця ще не вибрано) → офлайн. Цифрові «Готові рішення» й матеріали лишаються онлайн.
UPDATE mp_listings SET work_format = 'offline'
 WHERE is_remote = 0 AND work_format = 'online' AND primary_place_id IS NULL AND section NOT IN ('solution', 'asset');

-- Онлайн без вибраних країн — увесь світ.
UPDATE mp_listings l SET l.service_scope = 'worldwide'
 WHERE l.work_format = 'online' AND l.service_scope = 'local'
   AND NOT EXISTS (SELECT 1 FROM mp_listing_places p WHERE p.listing_id = l.id);

-- Ціна в USD: USD як є; UAH / EUR — за курсом з fx_rates (одиниць валюти за 1 USD), якщо він є.
UPDATE mp_listings SET price_usd = price_amount
 WHERE price_usd IS NULL AND price_amount IS NOT NULL AND currency = 'USD';

SET @s = (SELECT IF(COUNT(*) = 1,
  'UPDATE mp_listings l JOIN fx_rates r ON r.currency = l.currency AND r.rate > 0 SET l.price_usd = ROUND(l.price_amount / r.rate, 2) WHERE l.price_usd IS NULL AND l.price_amount IS NOT NULL AND l.currency IN (''UAH'', ''EUR'')',
  'DO 0') FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'fx_rates');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- Контроль:
--   SHOW COLUMNS FROM mp_listings LIKE 'work_format';                       -- 1 рядок
--   SELECT work_format, service_scope, COUNT(*) FROM mp_listings GROUP BY 1, 2;
--   SHOW TABLES LIKE 'mp_listing_places'; SHOW TABLES LIKE 'mp_user_prefs';  -- по 1 рядку
