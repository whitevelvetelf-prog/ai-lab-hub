-- =====================================================================
-- AI LAB HUB — міграція 2026-10-19: оголошення компаній (вакансії, курси, послуги), блок M1.
--
-- Будується НА ОСНОВІ наявного маркетплейсу, нічого не дублює:
--   * оголошення — ті самі рядки mp_listings з section = 'job' | 'course' | 'service'
--     (значення section — VARCHAR, ядро маркетплейсу їх і передбачало);
--   * тексти — mp_listing_translations (title ≤120, short_desc ≤300, full_desc ≤3000 — перевіряє PHP);
--   * посилання на вакансію/курс/послугу — mp_listings.delivery_url (delivery_type = 'link');
--   * «віддалено» — is_remote; причина відхилення — reject_reason; термін — expires_at;
--   * власник — mp_sellers.user_id; скарги — mp_reports; журнал — mp_moderation_log;
--   * теги «AI-спрямування» — mp_categories (section = 'focus') + mp_listing_categories.
-- Статуси (VARCHAR, змін схеми не потребує): draft | pending | published (= «approved») |
--   rejected | expired | archived (= «removed», зняте власником або модератором).
-- Дані наявних оголошень (board / solution) не змінюються й не переносяться.
--
-- Лише безпечні ALTER ... ADD COLUMN / CREATE INDEX (за перевіркою information_schema),
-- CREATE TABLE IF NOT EXISTS, INSERT ... WHERE NOT EXISTS / INSERT IGNORE.
-- Жодних DROP / DELETE / TRUNCATE. Повторний запуск безпечний (MySQL 5.7+ / MariaDB 10.3+).
-- =====================================================================

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------
-- 1. Нові колонки mp_listings (кожна — лише якщо ще не існує)
-- ---------------------------------------------------------------------

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN company_name VARCHAR(150) NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'company_name');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN country CHAR(2) NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'country');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- Мова вакансії / курсу / послуги (uk | en | other) — не плутати з source_lang (мова тексту оголошення)
SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN offer_lang VARCHAR(10) NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'offer_lang');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- Специфічні поля типу (JSON-рядок; TEXT, а не JSON — сумісність зі старими MariaDB)
SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN details TEXT NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'details');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN slug VARCHAR(140) NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'slug');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- Дата «безкоштовно до», що діяла на момент подачі (site_settings.marketplace_free_until)
SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN free_until DATE NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'free_until');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- Результат перевірки посилання (app/promo-linkcheck.php): ok | flagged | error | skipped; деталі — JSON
SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN link_check_status VARCHAR(20) NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'link_check_status');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN link_check_json TEXT NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'link_check_json');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN link_checked_at DATETIME NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'link_checked_at');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- Листи «скоро спливає термін» і «звіт за 30 днів» — щоб не надсилати двічі
SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN expiry_notified_at DATETIME NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'expiry_notified_at');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0,
  'ALTER TABLE mp_listings ADD COLUMN report_sent_at DATETIME NULL',
  'DO 0') FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'report_sent_at');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- Індекси для фільтрів публічних списків
SET @s = (SELECT IF(COUNT(*) = 0,
  'CREATE INDEX idx_country_lang ON mp_listings (country, offer_lang)',
  'DO 0') FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND INDEX_NAME = 'idx_country_lang');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- Індекс idx_section_status_exp (section, status, expires_at) уже створено міграцією classifieds.
SET @s = (SELECT IF(COUNT(*) = 0,
  'CREATE INDEX idx_section_status_exp ON mp_listings (section, status, expires_at)',
  'DO 0') FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings' AND INDEX_NAME = 'idx_section_status_exp');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- ---------------------------------------------------------------------
-- 2. Добова статистика оголошення: перегляди сторінки й переходи (listing-go.php).
--    Без персональних даних: лише лічильники; боти не рахуються, повтори в межах сесії — теж.
--    (page_views не підходить: його page_type — ENUM без маркетплейсу, і там ~95% ботів.)
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS mp_listing_stats_daily (
  listing_id INT UNSIGNED NOT NULL,
  day        DATE         NOT NULL,
  views      INT UNSIGNED NOT NULL DEFAULT 0,
  clicks     INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (listing_id, day),
  KEY idx_day (day)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 3. Теги «AI-спрямування» (section = 'focus'); 8 значень — ЧЕРНЕТКА, потребує підтвердження.
-- ---------------------------------------------------------------------
INSERT INTO mp_categories (section, slug, sort_order)
SELECT 'focus', s.slug, s.sort_order FROM (
  SELECT 'genai-llm'         AS slug, 1 AS sort_order UNION ALL
  SELECT 'ml-data',                   2 UNION ALL
  SELECT 'computer-vision',           3 UNION ALL
  SELECT 'nlp-speech',                4 UNION ALL
  SELECT 'automation-agents',         5 UNION ALL
  SELECT 'mlops-dev',                 6 UNION ALL
  SELECT 'ai-content-design',         7 UNION ALL
  SELECT 'ai-business',               8
) s
WHERE NOT EXISTS (SELECT 1 FROM mp_categories c WHERE c.section = 'focus' AND c.slug = s.slug);

INSERT INTO mp_category_translations (category_id, lang, name)
SELECT c.id, t.lang, t.name FROM mp_categories c
JOIN (
  SELECT 'genai-llm' AS slug, 'uk' AS lang, 'Генеративний AI та LLM' AS name UNION ALL
  SELECT 'genai-llm',         'en', 'Generative AI & LLMs' UNION ALL
  SELECT 'ml-data',           'uk', 'Машинне навчання та дані' UNION ALL
  SELECT 'ml-data',           'en', 'Machine learning & data' UNION ALL
  SELECT 'computer-vision',   'uk', 'Комп''ютерний зір' UNION ALL
  SELECT 'computer-vision',   'en', 'Computer vision' UNION ALL
  SELECT 'nlp-speech',        'uk', 'Мова, текст і голос (NLP)' UNION ALL
  SELECT 'nlp-speech',        'en', 'Language, text & speech (NLP)' UNION ALL
  SELECT 'automation-agents', 'uk', 'Автоматизація та AI-агенти' UNION ALL
  SELECT 'automation-agents', 'en', 'Automation & AI agents' UNION ALL
  SELECT 'mlops-dev',         'uk', 'Розробка й MLOps' UNION ALL
  SELECT 'mlops-dev',         'en', 'AI engineering & MLOps' UNION ALL
  SELECT 'ai-content-design', 'uk', 'AI для контенту й дизайну' UNION ALL
  SELECT 'ai-content-design', 'en', 'AI for content & design' UNION ALL
  SELECT 'ai-business',       'uk', 'AI у бізнесі та продукті' UNION ALL
  SELECT 'ai-business',       'en', 'AI in business & product'
) t ON t.slug = c.slug
WHERE c.section = 'focus'
  AND NOT EXISTS (SELECT 1 FROM mp_category_translations x WHERE x.category_id = c.id AND x.lang = t.lang);

-- ---------------------------------------------------------------------
-- 4. Налаштування (site_settings): наявні значення не змінюються.
--    marketplace_free_until    — дата «безкоштовне розміщення до» (порожньо = напис не показується);
--    marketplace_listing_days  — строк оголошення, днів;
--    marketplace_review_hours  — мета терміну розгляду модерацією, годин.
-- ---------------------------------------------------------------------
INSERT IGNORE INTO site_settings (setting_key, setting_value) VALUES
('marketplace_free_until', ''),
('marketplace_listing_days', '60'),
('marketplace_review_hours', '48');
