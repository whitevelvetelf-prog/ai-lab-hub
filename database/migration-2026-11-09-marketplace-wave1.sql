-- =====================================================================
-- AI LAB HUB — міграція 2026-11-09 (Marketplace, Хвиля 1, № 20): фільтри вакансій, популярні запити,
-- збережені пошуки, сторінка продавця й статистика переглядів.
--
--   * mp_listings ADD COLUMN salary_min_usd, salary_max_usd — зарплата вакансії, нормалізована до USD за курсом
--     (той самий механізм, що price_usd: app/mp-geo.php → mpg_usd_rate, НБУ); NULL — зарплати чи курсу немає.
--     Період (місяць / година / проєкт) не конвертується — лишається в details.salary_period.
--   * mp_sellers ADD COLUMN bio, logo, page_public — публічна сторінка продавця mp-seller.php.
--   * mp_listing_tags — нейтральні позначки «Підходить» (перелік — config 'suitable_for', перевірка на сервері).
--   * search_query_stats / search_query_overrides — агреговані популярні запити (без IP і без користувачів).
--   * mp_saved_searches — збережені пошуки (видалення — is_active = 0, рядки не видаляються).
--   * mp_listing_views_daily — перегляди оголошень по днях (усі види оголошень); очищення > 90 днів — mp-cron-expire.php.
--
-- Лише CREATE TABLE IF NOT EXISTS і ALTER ... ADD COLUMN (за перевіркою information_schema; індекси наявних таблиць не змінюються).
-- Жодних DROP / DELETE / TRUNCATE / зміни типів. FOREIGN KEY не використовуються. Повторний запуск безпечний.
-- MySQL 5.7+ / MariaDB 10.3+.
-- =====================================================================

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------
-- 1. mp_listings: зарплата в USD
-- ---------------------------------------------------------------------
SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN salary_min_usd DECIMAL(12,2) NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'salary_min_usd');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN salary_max_usd DECIMAL(12,2) NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'salary_max_usd');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- ---------------------------------------------------------------------
-- 2. mp_sellers: сторінка продавця
-- ---------------------------------------------------------------------
SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_sellers ADD COLUMN bio VARCHAR(500) NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_sellers' AND COLUMN_NAME = 'bio');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_sellers ADD COLUMN logo VARCHAR(255) NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_sellers' AND COLUMN_NAME = 'logo');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_sellers ADD COLUMN page_public TINYINT(1) NOT NULL DEFAULT 1',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_sellers' AND COLUMN_NAME = 'page_public');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- ---------------------------------------------------------------------
-- 3. Позначки «Підходить» (нейтральні; перелік — config 'suitable_for')
-- ---------------------------------------------------------------------
-- is_active = 0 — позначку знято під час редагування (рядки не видаляються).
CREATE TABLE IF NOT EXISTS mp_listing_tags (
  listing_id INT UNSIGNED NOT NULL,
  tag        VARCHAR(40)  NOT NULL,
  is_active  TINYINT(1)   NOT NULL DEFAULT 1,
  PRIMARY KEY (listing_id, tag),
  KEY idx_tag (tag)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listing_tags ADD COLUMN is_active TINYINT(1) NOT NULL DEFAULT 1',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listing_tags' AND COLUMN_NAME = 'is_active');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- ---------------------------------------------------------------------
-- 4. Популярні запити: агрегати по днях (без IP і користувачів) і ручні закріплення / приховування
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS search_query_stats (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
  scope      VARCHAR(20)  NOT NULL,
  query_norm VARCHAR(60)  NOT NULL,
  stat_date  DATE         NOT NULL,
  hits       INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (id),
  UNIQUE KEY uq_scope_query_date (scope, query_norm, stat_date),
  KEY idx_scope_date (scope, stat_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- status: 'pin' | 'hide' | '' (без ручного рішення — замість видалення рядка)
CREATE TABLE IF NOT EXISTS search_query_overrides (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
  scope      VARCHAR(20)  NOT NULL,
  query_norm VARCHAR(60)  NOT NULL,
  status     VARCHAR(10)  NOT NULL DEFAULT '',
  sort_order SMALLINT     NOT NULL DEFAULT 0,
  label_uk   VARCHAR(60)  NULL,
  label_en   VARCHAR(60)  NULL,
  updated_at DATETIME     NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_scope_query (scope, query_norm)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 5. Збережені пошуки
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS mp_saved_searches (
  id               INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  user_id          INT UNSIGNED  NOT NULL,
  title            VARCHAR(150)  NOT NULL,
  params           VARCHAR(1000) NOT NULL,
  params_hash      CHAR(64)      NOT NULL,
  notify_email     TINYINT(1)    NOT NULL DEFAULT 0,
  is_active        TINYINT(1)    NOT NULL DEFAULT 1,
  last_seen_at     DATETIME      NOT NULL,
  last_notified_at DATETIME      NULL,
  created_at       DATETIME      NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY uq_user_params (user_id, params_hash),
  KEY idx_notify (notify_email, is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 6. Перегляди оголошень по днях (усі види: оголошення користувачів, вакансії/курси/послуги, рішення)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS mp_listing_views_daily (
  listing_id INT UNSIGNED NOT NULL,
  stat_date  DATE         NOT NULL,
  views      INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (listing_id, stat_date),
  KEY idx_stat_date (stat_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Контроль (очікується: 5 рядків таблиць, 5 колонок)
-- SELECT TABLE_NAME FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE()
--   AND TABLE_NAME IN ('mp_listing_tags','search_query_stats','search_query_overrides','mp_saved_searches','mp_listing_views_daily');
-- SELECT TABLE_NAME, COLUMN_NAME FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE()
--   AND ((TABLE_NAME = 'mp_listings' AND COLUMN_NAME IN ('salary_min_usd','salary_max_usd'))
--     OR (TABLE_NAME = 'mp_sellers' AND COLUMN_NAME IN ('bio','logo','page_public')));
