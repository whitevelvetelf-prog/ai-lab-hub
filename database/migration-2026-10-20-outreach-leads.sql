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
