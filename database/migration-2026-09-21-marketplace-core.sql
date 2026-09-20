-- =====================================================================
-- AI LAB HUB — Marketplace, ядро (етап 1: безкоштовні пропозиції)
-- Безпечна міграція: тільки CREATE TABLE IF NOT EXISTS / INSERT з перевіркою.
-- Можна виконувати на хостингу через phpMyAdmin (вкладка SQL).
-- Зв'язки з таблицею users навмисно БЕЗ FOREIGN KEY (тип users.id
-- може відрізнятись) — цілісність перевіряється в PHP.
-- =====================================================================

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------
-- 1. Категорії Marketplace (окреме дерево, не змішується з каталогом AI)
--    section: solution | course | job  (розширюване, не жорсткий enum)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS mp_categories (
  id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
  section     VARCHAR(20)  NOT NULL DEFAULT 'solution',
  parent_id   INT UNSIGNED NULL,
  slug        VARCHAR(80)  NOT NULL,
  icon        VARCHAR(60)  NULL,
  sort_order  INT          NOT NULL DEFAULT 0,
  is_active   TINYINT(1)   NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  UNIQUE KEY uq_section_slug (section, slug),
  KEY idx_parent (parent_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS mp_category_translations (
  category_id INT UNSIGNED NOT NULL,
  lang        VARCHAR(10)  NOT NULL,
  name        VARCHAR(150) NOT NULL,
  is_auto     TINYINT(1)   NOT NULL DEFAULT 0,
  PRIMARY KEY (category_id, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 2. Продавці / автори. user_id = NULL → "продавець" це сама платформа.
--    Окрема таблиця, щоб НЕ чіпати users.role (простий enum).
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS mp_sellers (
  id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id      INT UNSIGNED NULL,
  display_name VARCHAR(150) NOT NULL,
  slug         VARCHAR(100) NOT NULL,
  website_url  VARCHAR(500) NULL,
  is_platform  TINYINT(1)   NOT NULL DEFAULT 0,
  is_verified  TINYINT(1)   NOT NULL DEFAULT 0,
  status       VARCHAR(20)  NOT NULL DEFAULT 'active',
  created_at   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_slug (slug),
  KEY idx_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 3. Пропозиції (єдина таблиця для solution / course / job)
--    status: draft | pending | published | rejected | archived
--    pricing_model: free (зараз) | paid | subscription (майбутнє)
--    delivery_type: link | file | contact
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS mp_listings (
  id            INT UNSIGNED  NOT NULL AUTO_INCREMENT,
  section       VARCHAR(20)   NOT NULL DEFAULT 'solution',
  seller_id     INT UNSIGNED  NOT NULL,
  status        VARCHAR(20)   NOT NULL DEFAULT 'draft',
  pricing_model VARCHAR(20)   NOT NULL DEFAULT 'free',
  price_amount  DECIMAL(10,2) NULL,
  currency      CHAR(3)       NULL,
  delivery_type VARCHAR(20)   NOT NULL DEFAULT 'link',
  delivery_url  VARCHAR(500)  NULL,
  file_id       INT UNSIGNED  NULL,
  license       VARCHAR(40)   NULL,
  cover_image   VARCHAR(255)  NULL,
  source_lang   VARCHAR(10)   NOT NULL DEFAULT 'uk',
  platform      VARCHAR(100)  NULL,
  skill_level   VARCHAR(30)   NULL,
  claims_count  INT UNSIGNED  NOT NULL DEFAULT 0,
  created_by    INT UNSIGNED  NULL,
  moderated_by  INT UNSIGNED  NULL,
  moderated_at  DATETIME      NULL,
  published_at  DATETIME      NULL,
  created_at    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_section_status (section, status, published_at),
  KEY idx_seller (seller_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Тексти окремо від пропозиції — архітектура під 80+ мов
-- (нова мова = нові рядки, а не нові колонки)
CREATE TABLE IF NOT EXISTS mp_listing_translations (
  listing_id  INT UNSIGNED NOT NULL,
  lang        VARCHAR(10)  NOT NULL,
  title       VARCHAR(200) NOT NULL,
  short_desc  VARCHAR(500) NULL,
  full_desc   TEXT         NULL,
  features    TEXT         NULL,
  for_whom    TEXT         NULL,
  is_auto     TINYINT(1)   NOT NULL DEFAULT 0,
  updated_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (listing_id, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Many-to-many: пропозиція може бути в кількох категоріях
CREATE TABLE IF NOT EXISTS mp_listing_categories (
  listing_id  INT UNSIGNED NOT NULL,
  category_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (listing_id, category_id),
  KEY idx_category (category_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 4. Файли для завантаження (зберігаються ПОЗА webroot,
--    віддаються через PHP-скрипт download.php)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS mp_files (
  id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
  original_name VARCHAR(255) NOT NULL,
  stored_name   VARCHAR(255) NOT NULL,
  mime          VARCHAR(100) NULL,
  size_bytes    BIGINT UNSIGNED NOT NULL DEFAULT 0,
  sha256        CHAR(64)     NULL,
  scan_status   VARCHAR(20)  NOT NULL DEFAULT 'pending',
  uploaded_by   INT UNSIGNED NULL,
  created_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_sha (sha256)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 5. "Отримано" — лише лічильник/статистика (НЕ рейтинг і НЕ відгуки)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS mp_claims (
  id         BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  listing_id INT UNSIGNED NOT NULL,
  user_id    INT UNSIGNED NULL,
  created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_listing (listing_id, created_at),
  KEY idx_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 6. Журнал модерації
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS mp_moderation_log (
  id         BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  listing_id INT UNSIGNED NOT NULL,
  actor_id   INT UNSIGNED NULL,
  action     VARCHAR(30)  NOT NULL,
  note       VARCHAR(500) NULL,
  created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_listing (listing_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 7. Стартові дані: продавець "AI LAB HUB" (сама платформа)
-- ---------------------------------------------------------------------
INSERT INTO mp_sellers (user_id, display_name, slug, is_platform, is_verified)
SELECT NULL, 'AI LAB HUB', 'ailabhub', 1, 1 FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM mp_sellers WHERE slug = 'ailabhub');

-- Стартові категорії розділу "Готові рішення" (ЧЕРНЕТКА — потребує затвердження)
INSERT INTO mp_categories (section, slug, sort_order)
SELECT 'solution', s.slug, s.sort_order FROM (
  SELECT 'prompts'    AS slug, 1 AS sort_order UNION ALL
  SELECT 'workflows',          2 UNION ALL
  SELECT 'custom-assistants',  3 UNION ALL
  SELECT 'scripts',            4 UNION ALL
  SELECT 'guides',             5 UNION ALL
  SELECT 'design-resources',   6 UNION ALL
  SELECT 'datasets',           7
) s
WHERE NOT EXISTS (
  SELECT 1 FROM mp_categories c WHERE c.section = 'solution' AND c.slug = s.slug
);

INSERT INTO mp_category_translations (category_id, lang, name)
SELECT c.id, 'uk', t.name FROM mp_categories c
JOIN (
  SELECT 'prompts' AS slug, 'Промпти та набори промптів' AS name UNION ALL
  SELECT 'workflows',          'Шаблони автоматизацій' UNION ALL
  SELECT 'custom-assistants',  'Кастомні асистенти' UNION ALL
  SELECT 'scripts',            'Скрипти та код' UNION ALL
  SELECT 'guides',             'Гайди та чек-листи' UNION ALL
  SELECT 'design-resources',   'Дизайн-ресурси' UNION ALL
  SELECT 'datasets',           'Дані та датасети'
) t ON t.slug = c.slug
WHERE c.section = 'solution'
  AND NOT EXISTS (
    SELECT 1 FROM mp_category_translations x
    WHERE x.category_id = c.id AND x.lang = 'uk'
  );
