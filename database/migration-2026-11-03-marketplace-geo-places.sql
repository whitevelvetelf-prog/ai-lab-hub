-- =====================================================================
-- AI LAB HUB — міграція 2026-11-03 (Marketplace, етап 6, № 15): геодовідник.
--
--   geo_places      — країни, регіони першого рівня, міста (GeoNames cities5000). id = geonameid
--                     (однакові id локально й на хостингу → place_id в оголошеннях переносяться як є).
--   geo_place_names — назви місць мовами uk / en (основна is_primary = 1; додаткові — для пошуку).
--
-- Дані НЕ тут: їх генерує scripts/geo-import.php у hosting-upload/marketplace-geo/geo-data-NN.sql
-- (частини ≤ 2 МБ, INSERT IGNORE) — імпортувати ПІСЛЯ цієї міграції, по номерах.
-- Джерело даних — GeoNames, ліцензія CC BY 4.0 (атрибуція на сторінці пошуку Marketplace).
--
-- Лише CREATE TABLE IF NOT EXISTS і CREATE INDEX за перевіркою information_schema.
-- Жодних DROP / DELETE / TRUNCATE / FOREIGN KEY. Повторний запуск безпечний.
-- =====================================================================

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS geo_places (
  id           INT UNSIGNED NOT NULL,
  geoname_id   INT UNSIGNED NOT NULL,
  type         VARCHAR(10)  NOT NULL,            -- country | region | city
  country_code CHAR(2)      NOT NULL,
  parent_id    INT UNSIGNED NULL,                -- місто → регіон (або країна), регіон → країна
  lat          DECIMAL(9,6) NULL,                -- у країн і регіонів координат немає
  lon          DECIMAL(9,6) NULL,
  population   INT UNSIGNED NOT NULL DEFAULT 0,
  timezone     VARCHAR(40)  NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_geoname (geoname_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS geo_place_names (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
  place_id   INT UNSIGNED NOT NULL,
  lang       VARCHAR(5)   NOT NULL,              -- uk | en
  name       VARCHAR(200) NOT NULL,
  is_primary TINYINT(1)   NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE KEY uq_place_lang_name (place_id, lang, name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Індекси (кожен — лише якщо його ще немає)
SET @s = (SELECT IF(COUNT(*) = 0, 'CREATE INDEX idx_country_type ON geo_places (country_code, type)', 'DO 0')
  FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'geo_places' AND INDEX_NAME = 'idx_country_type');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'CREATE INDEX idx_lat_lon ON geo_places (lat, lon)', 'DO 0')
  FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'geo_places' AND INDEX_NAME = 'idx_lat_lon');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'CREATE INDEX idx_parent ON geo_places (parent_id)', 'DO 0')
  FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'geo_places' AND INDEX_NAME = 'idx_parent');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- Пошук за початком назви певною мовою
SET @s = (SELECT IF(COUNT(*) = 0, 'CREATE INDEX idx_lang_name ON geo_place_names (lang, name)', 'DO 0')
  FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'geo_place_names' AND INDEX_NAME = 'idx_lang_name');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- Пошук за початком назви будь-якою мовою (автопідказка: «Льв…» і «Lv…» → одне місце)
SET @s = (SELECT IF(COUNT(*) = 0, 'CREATE INDEX idx_name ON geo_place_names (name)', 'DO 0')
  FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'geo_place_names' AND INDEX_NAME = 'idx_name');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- Контроль після імпорту даних (geo-data-NN.sql):
--   SELECT type, COUNT(*) FROM geo_places GROUP BY type;            -- country ≈ 252, region ≈ 3865, city ≈ 70 000
--   SELECT COUNT(*) FROM geo_place_names;                           -- ≈ 112 000
--   SELECT p.id, n.lang, n.name FROM geo_place_names n JOIN geo_places p ON p.id = n.place_id
--    WHERE n.name IN ('Львів', 'Lviv') AND p.type = 'city';          -- обидва рядки з одним id (702550)
