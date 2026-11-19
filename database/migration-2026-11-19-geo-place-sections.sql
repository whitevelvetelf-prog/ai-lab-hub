-- =====================================================================
-- AI LAB HUB — міграція 2026-11-19 (№ 27): частини міст (райони, округи) з геодовідника GeoNames.
--
-- geo_place_sections — id місць типу city, що в GeoNames є частиною більшого міста (feature code PPLX:
-- «Lyon 03», «Оболонь», «Hollywood»). Автопідказка не показує частину міста, якщо саме місто вже є серед
-- підказок поруч (до 25 км); окремо (напр. «Оболонь») частини знаходяться як і раніше.
-- Дані: hosting-upload/marketplace-geo-local/geo-sections-01.sql (scripts/geo-sections.php), імпорт ПІСЛЯ цієї міграції.
--
-- Лише CREATE TABLE IF NOT EXISTS. Без FOREIGN KEY / DROP / DELETE / TRUNCATE. Повторний запуск безпечний.
-- Код без цієї таблиці працює як раніше.
-- =====================================================================

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS geo_place_sections (
  place_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (place_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
