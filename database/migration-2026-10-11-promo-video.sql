-- =====================================================================
-- AI LAB HUB — міграція: система відеореклами (promo), етап A (2026-10-11).
--
-- Будується НА ОСНОВІ наявного ad server (migration-2026-09-20-ad-server.sql):
--   * ad_campaigns розширюється (а не дублюється): нові колонки додаються лише
--     якщо їх ще немає; ENUM status лише доповнюється новими значеннями;
--     start_date стає NULL-допустимою (чернетка без дат). Наявні рядки
--     (внутрішні банерні кампанії) отримують format='banner' і працюють як раніше.
--     is_house у новій системі = campaign_type='internal'.
--   * старі ads / ad_zones / ad_impressions / ad_clicks не змінюються.
--   * нові таблиці: ad_creatives, ad_targets, ad_events, ad_stats_daily,
--     ad_balances, ad_transactions, ad_rate_card, ad_settings, ad_reports.
--
-- Гроші — цілі числа в копійках (UAH). ad_campaigns.cpm_accrual — накопичувач
-- часток копійки для CPM (тисячні копійки), щоб списання лишалось цілочисельним.
--
-- ad_settings: enabled=0 — після застосування на сайті НЕ з'являється жодної
-- нової реклами, доки адмін не ввімкне систему й не задасть прайс
-- (ad_rate_card початково порожня).
--
-- Лише CREATE TABLE IF NOT EXISTS / умовні ALTER / INSERT IGNORE.
-- Жодних DROP / DELETE / TRUNCATE. Безпечно застосовувати повторно.
-- =====================================================================

SET NAMES utf8mb4;

-- ---------------------------------------------------------------------
-- 1) ad_campaigns: нові колонки (лише якщо їх ще нема; information_schema +
--    PREPARE працює і на MySQL, і на MariaDB).
-- ---------------------------------------------------------------------
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='format')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN format ENUM(''banner'',''video'') NOT NULL DEFAULT ''banner'' AFTER campaign_type','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='user_id')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN user_id INT UNSIGNED NULL AFTER format','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='name')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN name VARCHAR(120) NULL AFTER user_id','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='objective')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN objective ENUM(''awareness'',''clicks'') NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='pricing_model')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN pricing_model ENUM(''cpm'',''cpc'') NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- Знімок ціни з ad_rate_card на момент запуску (копійки: за 1000 показів для cpm, за клік для cpc).
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='unit_price')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN unit_price INT UNSIGNED NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='currency')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN currency CHAR(3) NOT NULL DEFAULT ''UAH''','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='daily_budget')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN daily_budget INT UNSIGNED NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='total_budget')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN total_budget INT UNSIGNED NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='spent')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN spent BIGINT UNSIGNED NOT NULL DEFAULT 0','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- Витрачено за поточний день (spent_today_date) — для атомарної перевірки денного бюджету.
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='spent_today')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN spent_today INT UNSIGNED NOT NULL DEFAULT 0','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='spent_today_date')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN spent_today_date DATE NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- Тисячні копійки, накопичені CPM-показами й ще не списані цілою копійкою (0..999).
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='cpm_accrual')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN cpm_accrual INT UNSIGNED NOT NULL DEFAULT 0','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='rejection_reason')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN rejection_reason VARCHAR(500) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- Чому кампанія зупинилась сама (budget / balance / end_date) — щоб рекламодавець бачив причину.
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='stop_reason')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN stop_reason VARCHAR(30) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='rules_accepted_at')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN rules_accepted_at DATETIME NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='submitted_at')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN submitted_at DATETIME NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='updated_at')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- status: дописуємо нові значення В КІНЕЦЬ наявного ENUM (старі значення й порядок не змінюються).
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='status' AND COLUMN_TYPE LIKE '%pending_review%')=0,
  'ALTER TABLE ad_campaigns MODIFY status ENUM(''active'',''paused'',''expired'',''draft'',''pending_review'',''rejected'',''completed'') NOT NULL DEFAULT ''active''','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- start_date: чернетка кампанії ще не має дат.
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='start_date' AND IS_NULLABLE='NO')=1,
  'ALTER TABLE ad_campaigns MODIFY start_date DATE NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.STATISTICS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND INDEX_NAME='idx_ad_campaigns_user')=0,
  'ALTER TABLE ad_campaigns ADD KEY idx_ad_campaigns_user (user_id)','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.STATISTICS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND INDEX_NAME='idx_ad_campaigns_format_status')=0,
  'ALTER TABLE ad_campaigns ADD KEY idx_ad_campaigns_format_status (format, status)','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- ---------------------------------------------------------------------
-- 2) ad_creatives — відеокреативи кампанії.
--    cta_key — ключ зі списку (learn_more, try, go, download); текст кнопки
--    береться з перекладів мовою інтерфейсу.
--    status: draft (майстер ще не надіслано), pending, approved, rejected,
--    suspended (призупинено адміном, напр. після скарг).
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ad_creatives (
    id               INT NOT NULL AUTO_INCREMENT,
    campaign_id      INT NOT NULL,
    title            VARCHAR(60) NOT NULL DEFAULT '',
    description      VARCHAR(150) NOT NULL DEFAULT '',
    cta_key          VARCHAR(20) NOT NULL DEFAULT 'learn_more',
    destination_url  VARCHAR(500) NOT NULL DEFAULT '',
    video_type       ENUM('upload', 'youtube') NULL,
    video_path       VARCHAR(255) NULL,
    video_url        VARCHAR(500) NULL,
    youtube_id       VARCHAR(20) NULL,
    poster_path      VARCHAR(255) NULL,
    duration_sec     SMALLINT UNSIGNED NULL,
    size_bytes       INT UNSIGNED NULL,
    mime             VARCHAR(50) NULL,
    status           ENUM('draft', 'pending', 'approved', 'rejected', 'suspended') NOT NULL DEFAULT 'draft',
    rejection_reason VARCHAR(500) NULL,
    reviewed_by      INT UNSIGNED NULL,
    reviewed_at      DATETIME NULL,
    created_at       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at       TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_ad_creatives_campaign (campaign_id),
    KEY idx_ad_creatives_status (status),
    CONSTRAINT fk_ad_creatives_campaign
        FOREIGN KEY (campaign_id) REFERENCES ad_campaigns (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 3) ad_targets — таргетинг без персональних даних: розміщення × категорія/
--    підкатегорія сторінки × мова × пристрій. NULL = «усі».
--    Один рядок на розміщення × обрану категорію/підкатегорію.
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ad_targets (
    id             INT NOT NULL AUTO_INCREMENT,
    campaign_id    INT NOT NULL,
    placement      ENUM('catalog_card', 'product_page', 'blog_inline') NOT NULL,
    category_id    INT UNSIGNED NULL,
    subcategory_id INT UNSIGNED NULL,
    language       ENUM('uk', 'en') NULL,
    device         ENUM('mobile', 'desktop') NULL,
    PRIMARY KEY (id),
    KEY idx_ad_targets_campaign (campaign_id),
    KEY idx_ad_targets_match (placement, category_id, subcategory_id),
    CONSTRAINT fk_ad_targets_campaign
        FOREIGN KEY (campaign_id) REFERENCES ad_campaigns (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 4) ad_events — сирі події (зберігаються 30 днів, потім агрегуються в
--    ad_stats_daily і видаляються скриптом очищення). Без FK — велика
--    частота запису. session_hash — анонімний (app/analytics.php), без IP.
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ad_events (
    id           BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    creative_id  INT NOT NULL,
    campaign_id  INT NOT NULL,
    type         ENUM('impression', 'view', 'click') NOT NULL,
    placement    ENUM('catalog_card', 'product_page', 'blog_inline') NOT NULL,
    session_hash CHAR(64) NOT NULL,
    created_at   DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_ad_events_created (created_at),
    KEY idx_ad_events_campaign (campaign_id, type, created_at),
    KEY idx_ad_events_session (session_hash, creative_id, type, created_at)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 5) ad_stats_daily — агрегати для швидкої статистики (spend у копійках).
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ad_stats_daily (
    stat_date   DATE NOT NULL,
    campaign_id INT NOT NULL,
    creative_id INT NOT NULL,
    placement   ENUM('catalog_card', 'product_page', 'blog_inline') NOT NULL,
    impressions INT UNSIGNED NOT NULL DEFAULT 0,
    views       INT UNSIGNED NOT NULL DEFAULT 0,
    clicks      INT UNSIGNED NOT NULL DEFAULT 0,
    spend       BIGINT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (stat_date, campaign_id, creative_id, placement),
    KEY idx_ad_stats_campaign (campaign_id, stat_date)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 6) ad_balances — баланс рекламодавця (копійки).
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ad_balances (
    user_id    INT UNSIGNED NOT NULL,
    balance    BIGINT NOT NULL DEFAULT 0,
    currency   CHAR(3) NOT NULL DEFAULT 'UAH',
    updated_at TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 7) ad_transactions — журнал руху коштів. amount зі знаком (копійки):
--    topup/refund — плюс, spend — мінус, adjust — будь-який.
--    reference — унікальне призначення платежу (містить ID заявки).
--    Номери карток НІКОЛИ не зберігаються.
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ad_transactions (
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id       INT UNSIGNED NOT NULL,
    campaign_id   INT NULL,
    type          ENUM('topup', 'spend', 'refund', 'adjust') NOT NULL,
    amount        BIGINT NOT NULL,
    currency      CHAR(3) NOT NULL DEFAULT 'UAH',
    status        ENUM('pending', 'confirmed', 'rejected') NOT NULL DEFAULT 'pending',
    method        ENUM('manual', 'provider') NOT NULL DEFAULT 'manual',
    provider      VARCHAR(30) NULL,
    reference     VARCHAR(100) NULL,
    note          VARCHAR(500) NULL,
    reject_reason VARCHAR(500) NULL,
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    confirmed_by  INT UNSIGNED NULL,
    confirmed_at  DATETIME NULL,
    PRIMARY KEY (id),
    KEY idx_ad_tx_user (user_id, created_at),
    KEY idx_ad_tx_status (type, status),
    KEY idx_ad_tx_campaign (campaign_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 8) ad_rate_card — прайс (копійки: за 1000 показів для cpm, за клік для cpc).
--    ПОЧАТКОВО ПОРОЖНЯ: ціни задає адмін; без ціни кампанія не стартує.
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ad_rate_card (
    id            INT NOT NULL AUTO_INCREMENT,
    placement     ENUM('catalog_card', 'product_page', 'blog_inline') NOT NULL,
    pricing_model ENUM('cpm', 'cpc') NOT NULL,
    price         INT UNSIGNED NOT NULL,
    currency      CHAR(3) NOT NULL DEFAULT 'UAH',
    active        TINYINT(1) NOT NULL DEFAULT 1,
    updated_at    TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uniq_ad_rate (placement, pricing_model, currency)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- 9) ad_settings — ключ-значення. INSERT IGNORE не перезаписує значення,
--    які адмін уже змінив. Порожні рядки = рішення ще не ухвалене.
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ad_settings (
    setting_key   VARCHAR(64) NOT NULL,
    setting_value TEXT NOT NULL,
    updated_at    TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (setting_key)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

INSERT IGNORE INTO ad_settings (setting_key, setting_value) VALUES
('enabled', '0'),
('max_video_mb', '30'),
('max_video_sec', '30'),
('min_topup', ''),
('frequency_cap_per_session', '3'),
('payment_instructions_uk', ''),
('payment_instructions_en', ''),
('prohibited_categories_text_uk', ''),
('prohibited_categories_text_en', '');

-- ---------------------------------------------------------------------
-- 10) ad_reports — скарги відвідувачів (одна скарга на креатив від сеансу).
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS ad_reports (
    id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
    creative_id  INT NOT NULL,
    session_hash CHAR(64) NOT NULL,
    reason       VARCHAR(40) NOT NULL,
    details      VARCHAR(500) NULL,
    status       ENUM('new', 'reviewed') NOT NULL DEFAULT 'new',
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uniq_ad_report_session (creative_id, session_hash),
    KEY idx_ad_reports_status (status, created_at)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
