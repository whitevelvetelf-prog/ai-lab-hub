-- =====================================================================
-- AI LAB HUB — міграція 2026-10-22: маркетплейс — «Цифрові матеріали» (зображення, ілюстрації, персонажі).
--
--   mp_listings.section = 'asset'  — нове значення (колонка VARCHAR, ALTER не потрібен); тексти — у
--                                    mp_listing_translations, як в інших оголошеннях.
--   mp_assets               — поля активу: вид, походження (human / ai_assisted / ai_generated), декларація
--                             прав (дата + користувач), ліцензія, приватний оригінал (лише ім'я файлу в
--                             приватному сховищі), sha256, dHash, превʼю, водяний знак, noimageindex.
--   asset_license_types     — ліцензії (тексти UA/EN — ЧЕРНЕТКИ для юриста).
--   asset_download_tokens   — одноразові токени завантаження оригіналу.
--   asset_downloads         — журнал виданих оригіналів (download_id, sha256 виданого файлу, хеш IP — не IP).
--   asset_access_log        — запити превʼю (анонімний хеш, без IP) для лімітів і «Підозрілої активності».
--   asset_suspicious        — записи підозрілої активності; asset_blocked_hashes — ручні/тимчасові блокування.
--   copyright_claims, copyright_claim_log, copyright_strikes — скарги на порушення авторських прав.
--   site_settings           — ліміти й перемикачі (див. п. 9).
--
-- Лише CREATE TABLE IF NOT EXISTS / INSERT IGNORE. Жодних DROP / DELETE / TRUNCATE.
-- Повторний запуск безпечний. Наявні оголошення не змінюються. marketplace_public не змінюється.
-- =====================================================================

SET NAMES utf8mb4;

-- 1) Поля активу ---------------------------------------------------------
CREATE TABLE IF NOT EXISTS mp_assets (
    listing_id            INT UNSIGNED NOT NULL,
    asset_kind            VARCHAR(20)  NOT NULL DEFAULT 'image',
    origin                VARCHAR(20)  NOT NULL DEFAULT 'human',
    ownership_user_id     INT UNSIGNED NOT NULL,
    ownership_declared_at DATETIME     NOT NULL,
    license_code          VARCHAR(30)  NOT NULL DEFAULT 'view_only',
    license_custom        TEXT         NULL,
    allow_download        TINYINT(1)   NOT NULL DEFAULT 0,
    alt_text              VARCHAR(300) NOT NULL DEFAULT '',
    tags                  VARCHAR(300) NULL,
    character_name        VARCHAR(120) NULL,
    character_desc        VARCHAR(500) NULL,
    character_terms       TEXT         NULL,
    orig_name             VARCHAR(80)  NOT NULL,
    orig_mime             VARCHAR(30)  NOT NULL,
    orig_size             INT UNSIGNED NOT NULL DEFAULT 0,
    orig_sha256           CHAR(64)     NOT NULL,
    width                 INT UNSIGNED NOT NULL DEFAULT 0,
    height                INT UNSIGNED NOT NULL DEFAULT 0,
    preview_name          VARCHAR(80)  NULL,
    preview_w             INT UNSIGNED NOT NULL DEFAULT 0,
    preview_h             INT UNSIGNED NOT NULL DEFAULT 0,
    watermark_density     VARCHAR(10)  NOT NULL DEFAULT 'normal',
    dhash                 CHAR(16)     NULL,
    similar_json          TEXT         NULL,
    meta_json             TEXT         NULL,
    noimageindex          TINYINT(1)   NOT NULL DEFAULT 1,
    uploaded_at           DATETIME     NOT NULL,
    updated_at            DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (listing_id),
    KEY idx_mp_assets_sha (orig_sha256),
    KEY idx_mp_assets_owner (ownership_user_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- 2) Ліцензії (ЧЕРНЕТКИ текстів для юриста) --------------------------------
CREATE TABLE IF NOT EXISTS asset_license_types (
    code             VARCHAR(30)  NOT NULL,
    icon             VARCHAR(8)   NOT NULL DEFAULT '',
    allows_download  TINYINT(1)   NOT NULL DEFAULT 0,
    sort_order       SMALLINT     NOT NULL DEFAULT 0,
    active           TINYINT(1)   NOT NULL DEFAULT 1,
    title_uk         VARCHAR(120) NOT NULL,
    title_en         VARCHAR(120) NOT NULL,
    summary_uk       VARCHAR(400) NOT NULL DEFAULT '',
    summary_en       VARCHAR(400) NOT NULL DEFAULT '',
    text_uk          TEXT         NULL,
    text_en          TEXT         NULL,
    PRIMARY KEY (code)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

INSERT IGNORE INTO asset_license_types (code, icon, allows_download, sort_order, title_uk, title_en, summary_uk, summary_en, text_uk, text_en) VALUES
('view_only', '👁', 0, 10, 'Лише перегляд', 'View only',
 'Можна лише переглядати на сайті. Оригінал не завантажується; будь-яке використання — тільки з письмового дозволу автора.',
 'Viewing on the site only. The original cannot be downloaded; any use requires the author’s written permission.',
 'ЧЕРНЕТКА ДЛЯ ЮРИСТА. Автор зберігає всі права. Користувачам дозволено лише переглядати зображення на сторінках AI LAB HUB. Копіювання, завантаження, зміна, поширення чи будь-яке інше використання без письмового дозволу автора не дозволені.',
 'DRAFT FOR LEGAL REVIEW. The author reserves all rights. Users may only view the image on AI LAB HUB pages. Copying, downloading, modifying, distributing or any other use without the author’s written permission is not permitted.'),
('personal_free', '🏠', 1, 20, 'Особисте некомерційне', 'Personal, non-commercial',
 'Безкоштовно для особистого некомерційного використання з обов’язковим зазначенням автора.',
 'Free for personal non-commercial use with mandatory attribution.',
 'ЧЕРНЕТКА ДЛЯ ЮРИСТА. Автор надає невиключну безоплатну ліцензію на використання зображення в особистих некомерційних цілях за умови зазначення імені автора й посилання на сторінку оголошення. Комерційне використання, перепродаж, поширення як окремого файлу, використання в логотипах чи товарних знаках і навчання моделей штучного інтелекту без окремого дозволу автора не дозволені.',
 'DRAFT FOR LEGAL REVIEW. The author grants a non-exclusive, free licence to use the image for personal non-commercial purposes, provided the author’s name and a link to the listing page are given. Commercial use, resale, redistribution as a standalone file, use in logos or trademarks and AI model training without the author’s separate permission are not permitted.'),
('cc_by', '©', 1, 30, 'CC BY 4.0', 'CC BY 4.0',
 'Вільна ліцензія Creative Commons Attribution 4.0: можна використовувати й змінювати, зокрема комерційно, із зазначенням автора.',
 'Creative Commons Attribution 4.0: free to use and adapt, including commercially, with attribution.',
 'Зображення поширюється за ліцензією Creative Commons Attribution 4.0 International (CC BY 4.0): https://creativecommons.org/licenses/by/4.0/deed.uk. Потрібно зазначити автора, дати посилання на ліцензію й вказати, чи були внесені зміни. Офіційний текст ліцензії має перевагу над цим описом.',
 'The image is licensed under Creative Commons Attribution 4.0 International (CC BY 4.0): https://creativecommons.org/licenses/by/4.0/. You must give appropriate credit, link to the licence and indicate if changes were made. The official licence text prevails over this summary.'),
('commercial_paid', '💼', 0, 40, 'Комерційна за домовленістю', 'Commercial by agreement',
 'Комерційне використання — за домовленістю з автором (зокрема платно). Оригінал передає автор після домовленості.',
 'Commercial use by agreement with the author (including paid). The author provides the original after agreement.',
 'ЧЕРНЕТКА ДЛЯ ЮРИСТА. Будь-яке використання можливе лише за окремою угодою з автором. AI LAB HUB не є стороною такої угоди й не приймає оплату. Оригінал на сайті не завантажується.',
 'DRAFT FOR LEGAL REVIEW. Any use is possible only under a separate agreement with the author. AI LAB HUB is not a party to such an agreement and does not take payment. The original cannot be downloaded on the site.'),
('custom', '✎', 1, 50, 'Власні умови автора', 'Author’s own terms',
 'Умови використання задає автор (текст перевіряє модератор).',
 'The author sets the terms of use (the text is reviewed by a moderator).',
 NULL, NULL);

-- 3) Токени й журнал завантажень оригіналу -----------------------------
CREATE TABLE IF NOT EXISTS asset_download_tokens (
    token       CHAR(64)     NOT NULL,
    asset_id    INT UNSIGNED NOT NULL,
    user_id     INT UNSIGNED NOT NULL,
    expires_at  DATETIME     NOT NULL,
    used_at     DATETIME     NULL,
    created_at  DATETIME     NOT NULL,
    PRIMARY KEY (token),
    KEY idx_adt_user (user_id, created_at)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS asset_downloads (
    id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
    download_id  CHAR(32)     NOT NULL,
    asset_id     INT UNSIGNED NOT NULL,
    user_id      INT UNSIGNED NOT NULL,
    license_code VARCHAR(30)  NOT NULL,
    sha256       CHAR(64)     NOT NULL,
    anon_hash    CHAR(64)     NOT NULL,
    created_at   DATETIME     NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_asset_downloads_did (download_id),
    KEY idx_asset_downloads_asset (asset_id),
    KEY idx_asset_downloads_user (user_id, created_at)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- 4) Антискрапінг ----------------------------------------------------------
CREATE TABLE IF NOT EXISTS asset_access_log (
    id         BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    anon_hash  CHAR(64)     NOT NULL,
    asset_id   INT UNSIGNED NOT NULL,
    sig        VARCHAR(20)  NULL,
    created_at DATETIME     NOT NULL,
    PRIMARY KEY (id),
    KEY idx_asset_access (anon_hash, created_at),
    KEY idx_asset_access_time (created_at)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS asset_suspicious (
    id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    anon_hash  CHAR(64)     NOT NULL,
    reason     VARCHAR(40)  NOT NULL,
    detail     VARCHAR(255) NULL,
    created_at DATETIME     NOT NULL,
    PRIMARY KEY (id),
    KEY idx_asset_susp (anon_hash, created_at)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS asset_blocked_hashes (
    anon_hash  CHAR(64)     NOT NULL,
    reason     VARCHAR(255) NULL,
    blocked_by INT UNSIGNED NULL,
    expires_at DATETIME     NULL,
    created_at DATETIME     NOT NULL,
    PRIMARY KEY (anon_hash)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- 5) Скарги на порушення авторських прав --------------------------------
CREATE TABLE IF NOT EXISTS copyright_claims (
    id               INT UNSIGNED NOT NULL AUTO_INCREMENT,
    listing_id       INT UNSIGNED NULL,
    listing_ref      VARCHAR(500) NOT NULL,
    what_infringed   TEXT         NOT NULL,
    evidence         TEXT         NULL,
    claimant_name    VARCHAR(150) NOT NULL,
    claimant_email   VARCHAR(190) NOT NULL,
    claimant_contact VARCHAR(255) NULL,
    good_faith_at    DATETIME     NOT NULL,
    status           VARCHAR(20)  NOT NULL DEFAULT 'new',
    auto_hidden      TINYINT(1)   NOT NULL DEFAULT 0,
    counter_text     TEXT         NULL,
    counter_at       DATETIME     NULL,
    counter_deadline DATETIME     NULL,
    decision_note    TEXT         NULL,
    anon_hash        CHAR(64)     NULL,
    created_at       DATETIME     NOT NULL,
    updated_at       DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_cc_status (status, created_at),
    KEY idx_cc_listing (listing_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS copyright_claim_log (
    id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    claim_id   INT UNSIGNED NOT NULL,
    actor_id   INT UNSIGNED NULL,
    action     VARCHAR(40)  NOT NULL,
    note       TEXT         NULL,
    created_at DATETIME     NOT NULL,
    PRIMARY KEY (id),
    KEY idx_ccl_claim (claim_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS copyright_strikes (
    id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id    INT UNSIGNED NOT NULL,
    claim_id   INT UNSIGNED NOT NULL,
    created_at DATETIME     NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_cs_claim (claim_id),
    KEY idx_cs_user (user_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- 6) Налаштування (змінюються в адмінці «Маркетплейс: оголошення» → «Активи») ---
INSERT IGNORE INTO site_settings (setting_key, setting_value) VALUES
('assets_max_mb', '20'),
('assets_preview_px', '1000'),
('assets_preview_ttl_min', '15'),
('assets_preview_per_min', '60'),
('assets_unique_burst', '40'),
('assets_block_minutes', '30'),
('assets_downloads_per_day', '20'),
('assets_download_token_min', '5'),
('assets_similarity_threshold', '10'),
('assets_context_guard', '1'),
('assets_listing_days', '365'),
('copyright_auto_hide', '1'),
('copyright_counter_days', '10'),
('copyright_strikes_limit', '3');
