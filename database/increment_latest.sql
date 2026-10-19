-- =====================================================================
-- AI LAB HUB — increment 2026-10-19: маркетплейс — оголошення компаній, ліди, керований аутріч (3 міграції).
--   migration-2026-10-19-marketplace-listings.sql — M1: колонки mp_listings для вакансій/курсів/послуг,
--     mp_listing_stats_daily, 8 тегів «AI-спрямування» (section='focus'), налаштування marketplace_free_until /
--     marketplace_listing_days / marketplace_review_hours.
--   migration-2026-10-20-outreach-leads.sql — M2: outreach_sources (усі джерела ВИМКНЕНІ), outreach_leads,
--     outreach_ai_cache, налаштування лідів.
--   migration-2026-10-21-outreach-mail.sql — M3: outreach_templates (UA/EN), outreach_messages,
--     outreach_suppression, outreach_tokens, outreach_log, outreach_leads + listing_id/replied_at,
--     mail_queue + headers_json/channel, налаштування аутрічу (outreach_enabled = 0).
-- Наявні дані маркетплейсу (board / solution) не змінюються й не переносяться.
-- Лише CREATE TABLE IF NOT EXISTS / безпечні ALTER ... ADD COLUMN і CREATE INDEX за перевіркою information_schema /
-- INSERT IGNORE / INSERT ... WHERE NOT EXISTS. Жодних DROP / DELETE / TRUNCATE. Повторний запуск безпечний.
-- marketplace_public і outreach_enabled не змінюються (наявні значення лишаються; нові — 0).
-- Застосування: phpMyAdmin → БД gu621051_ailabhublive → «Импорт» → цей файл → Вперёд.
-- =====================================================================

-- >>> database/migration-2026-10-19-marketplace-listings.sql
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

-- >>> database/migration-2026-10-20-outreach-leads.sql
-- =====================================================================
-- AI LAB HUB — міграція 2026-10-20: пошук потенційних партнерів (ліди), блок M2.
--
--   outreach_sources — джерела (офіційні публічні API/RSS) з перемикачем, примітками про умови,
--                      станом останнього запуску й кешем (ETag / Last-Modified).
--   outreach_leads   — ліди рівня КОМПАНІЇ: назва, сайт, публічна сторінка контактів, ДІЛОВА публічна адреса
--                      (info@, jobs@ …). Жодних імен людей і особистих адрес (фільтр у PHP).
--   outreach_ai_cache — кеш класифікації AI-релевантності моделлю (хеш тексту → оцінка), без персональних даних.
--   Налаштування (site_settings): outreach_excluded_countries, outreach_excluded_domains, outreach_ats_boards,
--                      outreach_ai_classify, outreach_ai_daily_cap.
--
-- Аутріч (листи) — окремий блок M3; тут нічого не надсилається.
-- Лише CREATE TABLE IF NOT EXISTS / INSERT IGNORE / INSERT ... WHERE NOT EXISTS. Жодних DROP / DELETE / TRUNCATE.
-- Повторний запуск безпечний.
-- =====================================================================

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS outreach_sources (
  source_key           VARCHAR(40)  NOT NULL,
  type                 VARCHAR(20)  NOT NULL DEFAULT 'job',
  name                 VARCHAR(120) NOT NULL,
  endpoint             VARCHAR(500) NOT NULL,
  enabled              TINYINT(1)   NOT NULL DEFAULT 0,
  terms_note           TEXT         NULL,
  attribution_required TINYINT(1)   NOT NULL DEFAULT 0,
  min_interval_min     INT UNSIGNED NOT NULL DEFAULT 1440,
  etag                 VARCHAR(255) NULL,
  last_modified        VARCHAR(100) NULL,
  last_run_at          DATETIME     NULL,
  last_status          VARCHAR(500) NULL,
  last_found           INT UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (source_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS outreach_leads (
  id                 INT UNSIGNED NOT NULL AUTO_INCREMENT,
  source_key         VARCHAR(40)  NOT NULL,
  source_name        VARCHAR(120) NULL,
  source_url         VARCHAR(500) NULL,
  company_name       VARCHAR(190) NOT NULL,
  company_domain     VARCHAR(190) NULL,
  title              VARCHAR(255) NULL,
  lead_type          VARCHAR(20)  NOT NULL DEFAULT 'job',
  country            CHAR(2)      NULL,
  language           VARCHAR(10)  NULL,
  found_at           DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  relevance_score    TINYINT UNSIGNED NOT NULL DEFAULT 0,
  relevance_method   VARCHAR(20)  NULL,
  status             VARCHAR(20)  NOT NULL DEFAULT 'new',
  in_catalog         TINYINT(1)   NOT NULL DEFAULT 0,
  company_website    VARCHAR(500) NULL,
  contact_url        VARCHAR(500) NULL,
  contact_email      VARCHAR(190) NULL,
  contact_source_url VARCHAR(500) NULL,
  contacts_checked_at DATETIME    NULL,
  notes              TEXT         NULL,
  last_action_at     DATETIME     NULL,
  PRIMARY KEY (id),
  KEY idx_status (status, relevance_score),
  KEY idx_domain (company_domain),
  KEY idx_source (source_key, found_at),
  KEY idx_type (lead_type, country, language)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS outreach_ai_cache (
  text_hash  CHAR(64)         NOT NULL,
  score      TINYINT UNSIGNED NOT NULL,
  created_at DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (text_hash)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Джерела. Усі ВИМКНЕНІ за замовчуванням: адмін вмикає кожне свідомо після перегляду умов.
-- Remotive — вимкнений і позначений «не вмикати без окремого рішення» (умови просять не передавати їхні вакансії стороннім сайтам).
INSERT IGNORE INTO outreach_sources (source_key, type, name, endpoint, enabled, terms_note, attribution_required, min_interval_min) VALUES
('arbeitnow', 'job', 'Arbeitnow', 'https://www.arbeitnow.com/api/job-board-api', 0,
 'Офіційний безкоштовний Job Board API. Беремо лише назву компанії, назву вакансії й посилання на оригінал; тексти вакансій на сайті не публікуються.', 1, 1440),
('remoteok', 'job', 'Remote OK', 'https://remoteok.com/api', 0,
 'Офіційний публічний JSON API. Умови API: вказувати Remote OK як джерело з посиланням на оригінал. Тексти не публікуються; посилання на оригінал зберігається.', 1, 1440),
('himalayas', 'job', 'Himalayas', 'https://himalayas.app/jobs/api?limit=100', 0,
 'Публічний Jobs API. Умови: посилання на Himalayas як джерело; не копіювати вакансії на інші дошки. Ми зберігаємо лише назву компанії й посилання.', 1, 1440),
('weworkremotely', 'job', 'We Work Remotely', 'https://weworkremotely.com/remote-jobs.rss', 0,
 'Публічна RSS-стрічка. Лише назва компанії, вакансії й посилання на оригінал.', 1, 1440),
('hn_hiring', 'job', 'Hacker News — Who is hiring', 'https://hn.algolia.com/api/v1/search_by_date?tags=story,author_whoishiring&hitsPerPage=5', 0,
 'Офіційний HN Search API (Algolia). Зберігаємо лише назву компанії з першого рядка коментаря й посилання на коментар; імена авторів не зберігаються.', 0, 1440),
('ats_boards', 'job', 'Greenhouse / Lever (список компаній)', 'outreach_ats_boards', 0,
 'Публічні сторінки вакансій Greenhouse (boards-api.greenhouse.io) і Lever (api.lever.co) лише для компаній зі списку в налаштуваннях.', 0, 1440),
('remotive', 'job', 'Remotive (НЕ вмикати без окремого рішення)', 'https://remotive.com/api/remote-jobs', 0,
 'Умови Remotive просять не передавати їхні вакансії стороннім сайтам/дошкам. Вимкнено за замовчуванням; вмикати лише за окремим рішенням власника сайту.', 1, 1440);

INSERT IGNORE INTO site_settings (setting_key, setting_value) VALUES
('outreach_excluded_countries', ''),
('outreach_excluded_domains', ''),
('outreach_ats_boards', ''),
('outreach_ai_classify', '0'),
('outreach_ai_daily_cap', '50');

-- >>> database/migration-2026-10-21-outreach-mail.sql
-- =====================================================================
-- AI LAB HUB — міграція 2026-10-21: керований аутріч (блок M3). КОЖЕН лист схвалює людина.
--
--   outreach_templates   — шаблони листів (UA/EN): запрошення й одне нагадування; редагуються в адмінці.
--   outreach_messages    — чернетки й листи: draft → queued (після схвалення людиною) → sent / sent_manual / failed / cancelled.
--   outreach_suppression — список заборон (адреса або домен; причини: відписка, відмова, відскок, скарга, ручне
--                          блокування, видалення на прохання). Перевіряється перед КОЖНОЮ відправкою.
--   outreach_tokens      — токени відписки (одноразові, з терміном дії) і запрошення (marketplace-join.php), лише хеші.
--   outreach_log         — журнал: хто схвалив, коли відправлено, зміни статусів.
--   outreach_leads       — + listing_id (оголошення, створене за запрошенням), replied_at.
--   mail_queue           — + headers_json (List-Unsubscribe, Reply-To, From для листів аутрічу), channel.
--   site_settings        — outreach_enabled = 0 (вимкнено) і решта налаштувань аутрічу (порожні — заповнює власник).
--
-- Лише CREATE TABLE IF NOT EXISTS / безпечні ALTER ... ADD COLUMN (за перевіркою) / INSERT IGNORE.
-- Жодних DROP / DELETE / TRUNCATE. Повторний запуск безпечний.
-- =====================================================================

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS outreach_templates (
  id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
  template_key VARCHAR(30)  NOT NULL,
  lang         CHAR(2)      NOT NULL,
  subject      VARCHAR(200) NOT NULL,
  body         TEXT         NOT NULL,
  updated_by   INT UNSIGNED NULL,
  updated_at   DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_key_lang (template_key, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS outreach_messages (
  id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
  lead_id       INT UNSIGNED NOT NULL,
  kind          VARCHAR(20)  NOT NULL DEFAULT 'initial',
  template_key  VARCHAR(30)  NOT NULL DEFAULT 'invite',
  lang          CHAR(2)      NOT NULL DEFAULT 'en',
  to_email      VARCHAR(190) NULL,
  subject       VARCHAR(200) NOT NULL,
  body          TEXT         NOT NULL,
  paraphrased   TINYINT(1)   NOT NULL DEFAULT 0,
  status        VARCHAR(20)  NOT NULL DEFAULT 'draft',
  created_by    INT UNSIGNED NULL,
  approved_by   INT UNSIGNED NULL,
  approved_at   DATETIME     NULL,
  sent_at       DATETIME     NULL,
  mail_queue_id INT UNSIGNED NULL,
  error         VARCHAR(500) NULL,
  created_at    DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_lead (lead_id, kind),
  KEY idx_status (status, approved_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS outreach_suppression (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
  kind       VARCHAR(10)  NOT NULL,
  value      VARCHAR(190) NOT NULL,
  reason     VARCHAR(20)  NOT NULL,
  note       VARCHAR(500) NULL,
  created_by INT UNSIGNED NULL,
  created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_kind_value (kind, value)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS outreach_tokens (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
  token_hash CHAR(64)     NOT NULL,
  purpose    VARCHAR(10)  NOT NULL,
  lead_id    INT UNSIGNED NOT NULL,
  message_id INT UNSIGNED NULL,
  expires_at DATETIME     NOT NULL,
  used_at    DATETIME     NULL,
  created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE KEY uq_hash (token_hash),
  KEY idx_lead (lead_id, purpose)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS outreach_log (
  id         BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  lead_id    INT UNSIGNED NULL,
  message_id INT UNSIGNED NULL,
  actor_id   INT UNSIGNED NULL,
  action     VARCHAR(30)  NOT NULL,
  note       VARCHAR(500) NULL,
  created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY idx_lead (lead_id),
  KEY idx_action (action, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Нові колонки (кожна — лише якщо ще не існує)
SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE outreach_leads ADD COLUMN listing_id INT UNSIGNED NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'outreach_leads' AND COLUMN_NAME = 'listing_id');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE outreach_leads ADD COLUMN replied_at DATETIME NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'outreach_leads' AND COLUMN_NAME = 'replied_at');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mail_queue ADD COLUMN headers_json TEXT NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mail_queue' AND COLUMN_NAME = 'headers_json');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mail_queue ADD COLUMN channel VARCHAR(20) NULL', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mail_queue' AND COLUMN_NAME = 'channel');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- Початкові шаблони (нейтральні, без цифр аудиторії й обіцянок результату). Наявні не перезаписуються.
INSERT IGNORE INTO outreach_templates (template_key, lang, subject, body) VALUES
('invite', 'uk', 'Безкоштовне розміщення на AI LAB HUB',
'Добрий день!

Мене звати {sender_name}, я представляю AI LAB HUB ({site_url}), каталог AI-інструментів. Ми запускаємо розділ, де компанії можуть безкоштовно публікувати вакансії, курси й послуги у сфері AI.

{context_sentence}

Якщо це вам цікаво, ви можете розмістити оголошення безкоштовно до {free_until}: {join_url}. Через 30 днів ми надішлемо вам звіт про перегляди й переходи за вашим оголошенням.

Якщо це не цікаво, просто проігноруйте лист або відпишіться: {unsubscribe_url}, і ми більше не писатимемо.

З повагою,
{sender_name}, {sender_role}
{legal_address}'),
('invite', 'en', 'Free listing on AI LAB HUB',
'Hello,

My name is {sender_name} and I represent AI LAB HUB ({site_url}), a directory of AI tools. We are launching a section where companies can post AI-related jobs, courses and services for free.

{context_sentence}

If this is of interest, you can post a listing for free until {free_until}: {join_url}. After 30 days we will send you a report on the views and clicks your listing received.

If it is not of interest, simply ignore this email or unsubscribe: {unsubscribe_url}, and we will not write again.

Best regards,
{sender_name}, {sender_role}
{legal_address}'),
('followup', 'uk', 'Нагадування: безкоштовне розміщення на AI LAB HUB',
'Добрий день!

Коротко нагадую про мій попередній лист: на AI LAB HUB ({site_url}) можна безкоштовно розмістити вакансію, курс чи послугу у сфері AI до {free_until}: {join_url}.

Це останній лист від нас на цю тему. Відписатися: {unsubscribe_url}

З повагою,
{sender_name}, {sender_role}
{legal_address}'),
('followup', 'en', 'Reminder: free listing on AI LAB HUB',
'Hello,

A short reminder about my previous email: on AI LAB HUB ({site_url}) you can post an AI-related job, course or service for free until {free_until}: {join_url}.

This is our last email on this topic. Unsubscribe: {unsubscribe_url}

Best regards,
{sender_name}, {sender_role}
{legal_address}');

INSERT IGNORE INTO site_settings (setting_key, setting_value) VALUES
('outreach_enabled', '0'),
('outreach_sender_name', ''),
('outreach_sender_role', ''),
('outreach_legal_address', ''),
('outreach_unsubscribe_email', ''),
('outreach_reply_to', 'partners@ailabhub-directory.com'),
('outreach_from_email', 'partners@ailabhub-directory.com'),
('outreach_rules_ack', ''),
('outreach_daily_cap', '10'),
('outreach_rampup', '10,15,20,30,40'),
('outreach_ramp_start', ''),
('outreach_pause_min', '3'),
('outreach_pause_max', '9'),
('outreach_window_start', '9'),
('outreach_window_end', '18'),
('outreach_followup_days', '7'),
('outreach_paraphrase', '0'),
('outreach_next_send_at', '');

-- Перевірка: має повернути 1 рядок з mp_tables=2, outreach_tables=6, focus_tags=8, outreach_enabled=0
SELECT (SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME IN ('mp_listing_stats_daily','mp_listings')) AS mp_tables,
       (SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME IN ('outreach_sources','outreach_leads','outreach_templates','outreach_messages','outreach_suppression','outreach_tokens')) AS outreach_tables,
       (SELECT COUNT(*) FROM mp_categories WHERE section = 'focus') AS focus_tags,
       (SELECT setting_value FROM site_settings WHERE setting_key = 'outreach_enabled') AS outreach_enabled;
