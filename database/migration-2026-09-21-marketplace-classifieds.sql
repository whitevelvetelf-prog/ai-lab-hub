-- =====================================================================
-- AI LAB HUB — Marketplace, етап 4: дошка оголошень (публікують користувачі)
--
-- Безпечна ідемпотентна міграція (MySQL і MariaDB), можна запускати повторно:
--   * CREATE TABLE IF NOT EXISTS — нові таблиці;
--   * єдиний дозволений ALTER: ALTER TABLE mp_listings ... ADD COLUMN, лише якщо
--     колонки ще немає (перевірка через information_schema + PREPARE/EXECUTE);
--   * індекси — CREATE INDEX, лише якщо індексу ще немає (той самий прийом);
--   * стартові категорії розділу 'board' — INSERT ... WHERE NOT EXISTS (без фіксованих id).
-- DROP / DELETE / TRUNCATE немає; таблиці каталогу (products, categories, ...) не чіпаються.
-- Зв'язки без FOREIGN KEY (цілісність — у PHP).
--
-- Статуси mp_listings.status (VARCHAR, змін схеми не потребує):
--   draft | pending | published | rejected | archived | expired  (expired — новий)
-- pricing_model лишається 'free' (платформа грошей не бере); price_type — ціна між сторонами.
-- =====================================================================

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------
-- 1. Нові колонки mp_listings (по одній, кожна — лише якщо ще не існує)
-- ---------------------------------------------------------------------

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN price_type VARCHAR(20) NOT NULL DEFAULT ''free''',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'price_type');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN is_remote TINYINT(1) NOT NULL DEFAULT 1',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'is_remote');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN city VARCHAR(120) NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'city');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN expires_at DATETIME NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'expires_at');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN views_count INT UNSIGNED NOT NULL DEFAULT 0',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'views_count');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN reject_reason VARCHAR(500) NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'reject_reason');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN rules_accepted_at DATETIME NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'rules_accepted_at');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN contact_name VARCHAR(100) NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'contact_name');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN contact_phone VARCHAR(40) NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'contact_phone');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN contact_telegram VARCHAR(80) NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'contact_telegram');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN contact_email VARCHAR(190) NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'contact_email');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- ---------------------------------------------------------------------
-- 2. Індекси для фільтрів (створюються лише якщо ще немає)
-- ---------------------------------------------------------------------

SET @s = (SELECT IF(COUNT(*) = 0,
  'CREATE INDEX idx_section_status_exp ON mp_listings (section, status, expires_at)',
  'DO 0') FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND INDEX_NAME = 'idx_section_status_exp');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'CREATE INDEX idx_city ON mp_listings (city)',
  'DO 0') FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND INDEX_NAME = 'idx_city');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'CREATE INDEX idx_price ON mp_listings (price_type, price_amount)',
  'DO 0') FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND INDEX_NAME = 'idx_price');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- ---------------------------------------------------------------------
-- 3. Нові таблиці
-- ---------------------------------------------------------------------

-- Фото оголошення (файли лежать у public/uploads/marketplace/, тут лише імена).
-- Перше за sort_order — обкладинка.
CREATE TABLE IF NOT EXISTS mp_listing_photos (
  id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  listing_id  INT UNSIGNED NOT NULL,
  file_name   VARCHAR(80)  NOT NULL,
  thumb_name  VARCHAR(80)  NOT NULL,
  sort_order  INT          NOT NULL DEFAULT 0,
  created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_listing_sort (listing_id, sort_order)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Скарги: одна на пару (оголошення, користувач)
CREATE TABLE IF NOT EXISTS mp_reports (
  id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  listing_id  INT UNSIGNED NOT NULL,
  reporter_id INT UNSIGNED NOT NULL,
  reason      VARCHAR(30)  NOT NULL,
  note        VARCHAR(500) NULL,
  created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_listing_reporter (listing_id, reporter_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Вибране
CREATE TABLE IF NOT EXISTS mp_favorites (
  user_id     INT UNSIGNED NOT NULL,
  listing_id  INT UNSIGNED NOT NULL,
  created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (user_id, listing_id),
  KEY idx_listing (listing_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Журнал розкриття контактів (ліміт на користувача за добу)
CREATE TABLE IF NOT EXISTS mp_contact_reveals (
  id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  listing_id  INT UNSIGNED NOT NULL,
  user_id     INT UNSIGNED NOT NULL,
  created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_user_created (user_id, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 4. Категорії дошки оголошень (окремий розділ 'board'; ЧЕРНЕТКА — потребує затвердження)
--    Без фіксованих id: вставка за (section, slug) лише якщо ще немає.
-- ---------------------------------------------------------------------
INSERT INTO mp_categories (section, slug, sort_order)
SELECT 'board', s.slug, s.sort_order FROM (
  SELECT 'ai-services'      AS slug, 1 AS sort_order UNION ALL
  SELECT 'automation-setup',          2 UNION ALL
  SELECT 'prompts-templates',         3 UNION ALL
  SELECT 'training-lessons',          4 UNION ALL
  SELECT 'content-design',            5 UNION ALL
  SELECT 'development',               6 UNION ALL
  SELECT 'jobs-gigs',                 7 UNION ALL
  SELECT 'accounts-equipment',        8 UNION ALL
  SELECT 'other',                     9
) s
WHERE NOT EXISTS (
  SELECT 1 FROM mp_categories c WHERE c.section = 'board' AND c.slug = s.slug
);

INSERT INTO mp_category_translations (category_id, lang, name)
SELECT c.id, 'uk', t.name FROM mp_categories c
JOIN (
  SELECT 'ai-services' AS slug, 'AI-послуги та консультації' AS name UNION ALL
  SELECT 'automation-setup',    'Автоматизація та налаштування' UNION ALL
  SELECT 'prompts-templates',   'Промпти та шаблони' UNION ALL
  SELECT 'training-lessons',    'Навчання та уроки' UNION ALL
  SELECT 'content-design',      'Контент і дизайн' UNION ALL
  SELECT 'development',         'Розробка та боти' UNION ALL
  SELECT 'jobs-gigs',           'Робота та підробіток' UNION ALL
  SELECT 'accounts-equipment',  'Акаунти, підписки, обладнання' UNION ALL
  SELECT 'other',               'Інше'
) t ON t.slug = c.slug
WHERE c.section = 'board'
  AND NOT EXISTS (
    SELECT 1 FROM mp_category_translations x
    WHERE x.category_id = c.id AND x.lang = 'uk'
  );
