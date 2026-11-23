-- =====================================================================
-- AI LAB HUB — міграція 2026-11-23 (Багвіль, № 33): основа варіантів поломок і спроб.
-- Лише НОВІ таблиці (CREATE TABLE IF NOT EXISTS). Наявні таблиці не змінюються; ADD COLUMN до bv_missions —
-- окремою міграцією разом з основними таблицями гри (docs/bugville/MAIN_TASK.md).
-- Без ENUM: режими, типи й статуси — VARCHAR, допустимі значення перевіряє PHP (app/bugville/bv-config.php).
-- Час у bv_* — UTC (пише PHP, gmdate), щоб веб і cron рахували строки однаково.
-- Безпечно й ідемпотентно: DROP / DELETE / TRUNCATE / ALTER немає.
-- Виконати у phpMyAdmin → база gu621051_ailabhublive → Імпорт цього файлу (лише після погодження власника).
-- =====================================================================

SET NAMES utf8mb4;

-- Пул рукописних варіантів місії. answer_json / explain_json ніколи не віддаються в браузер до перевірки.
-- mission_id — без зовнішнього ключа, доки немає таблиці місій.
CREATE TABLE IF NOT EXISTS bv_mission_variants (
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    mission_id    INT UNSIGNED NOT NULL,
    lang          VARCHAR(5)   NOT NULL DEFAULT 'uk',
    skill         VARCHAR(64)  NULL,
    payload_json  MEDIUMTEXT   NOT NULL,
    answer_json   TEXT         NOT NULL,
    explain_json  TEXT         NULL,
    status        VARCHAR(16)  NOT NULL DEFAULT 'draft',
    created_at    DATETIME     NOT NULL,
    updated_at    DATETIME     NULL,
    PRIMARY KEY (id),
    KEY idx_mission_lang_status (mission_id, lang, status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Спроба = одноразовий токен. Гість: user_id NULL + session_hash (хеш випадкового ключа гостя з сесії).
-- ip_hash — HMAC-SHA256(IP, сіль з config); без солі NULL. IP відкритим текстом не зберігається.
CREATE TABLE IF NOT EXISTS bv_attempts (
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    token         CHAR(43)     NOT NULL,
    user_id       INT UNSIGNED NULL,
    session_hash  CHAR(64)     NULL,
    mission_id    INT UNSIGNED NOT NULL,
    variant_id    INT UNSIGNED NULL,
    seed          VARCHAR(32)  NULL,
    variant_key   VARCHAR(48)  NOT NULL,
    kind          VARCHAR(8)   NOT NULL DEFAULT 'mission',
    lang          VARCHAR(5)   NOT NULL DEFAULT 'uk',
    opt_map_json  TEXT         NULL,
    started_at    DATETIME     NOT NULL,
    finished_at   DATETIME     NULL,
    score         SMALLINT UNSIGNED NULL,
    stars         TINYINT UNSIGNED  NULL,
    hint_used     TINYINT(1)   NOT NULL DEFAULT 0,
    used          TINYINT(1)   NOT NULL DEFAULT 0,
    credited      TINYINT(1)   NOT NULL DEFAULT 0,
    credited_at   DATETIME     NULL,
    ip_hash       CHAR(64)     NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_token (token),
    KEY idx_user_mission (user_id, mission_id),
    KEY idx_session (session_hash),
    KEY idx_guest_cleanup (user_id, credited, started_at),
    KEY idx_variant_started (variant_id, started_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Бачені варіанти зареєстрованих гравців (у гостя — лише в сесії). variant_key: «v:<id>» або «g:<відбиток параметрів>».
CREATE TABLE IF NOT EXISTS bv_seen_variants (
    user_id       INT UNSIGNED NOT NULL,
    mission_id    INT UNSIGNED NOT NULL,
    variant_key   VARCHAR(48)  NOT NULL,
    seen_at       DATETIME     NOT NULL,
    PRIMARY KEY (user_id, mission_id, variant_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Пул завдань іспиту (пул ≥ 3 × кількість завдань в іспиті — перевіряє PHP / CRM).
CREATE TABLE IF NOT EXISTS bv_exam_items (
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    exam_id       INT UNSIGNED NOT NULL,
    mission_id    INT UNSIGNED NULL,
    template_key  VARCHAR(64)  NULL,
    lang          VARCHAR(5)   NOT NULL DEFAULT 'uk',
    weight        TINYINT UNSIGNED NOT NULL DEFAULT 1,
    status        VARCHAR(16)  NOT NULL DEFAULT 'active',
    created_at    DATETIME     NOT NULL,
    PRIMARY KEY (id),
    KEY idx_exam_lang_status (exam_id, lang, status)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Словники рядків гри за мовами (предмети, місця, персонажі, кольори, написи) для генераторів і сцен. Поки лише uk.
CREATE TABLE IF NOT EXISTS bv_strings (
    dict          VARCHAR(32)  NOT NULL,
    str_key       VARCHAR(64)  NOT NULL,
    lang          VARCHAR(5)   NOT NULL DEFAULT 'uk',
    text          VARCHAR(500) NOT NULL,
    PRIMARY KEY (dict, str_key, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Гравці з акаунтом: підтвердження віку (config bugville_min_age_for_account, 16+).
CREATE TABLE IF NOT EXISTS bv_players (
    user_id           INT UNSIGNED NOT NULL,
    age_confirmed_at  DATETIME     NULL,
    created_at        DATETIME     NOT NULL,
    PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Журнал нагород акаунтів (bv_xp_log, крок 2; назва з основного завдання): одна спроба — не більше одного запису (UNIQUE attempt_id), тож повторне
-- надсилання чи повторне зарахування балів не дає. Пишуться ПРИРІСТ XP, зірок і монет (за покращення результату місії),
-- тож підсумки гравця = сума журналу, а найкращі зірки місії = сума її зірок. Гостям нічого не пишеться.
CREATE TABLE IF NOT EXISTS bv_xp_log (
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id       INT UNSIGNED NOT NULL,
    attempt_id    INT UNSIGNED NOT NULL,
    mission_id    INT UNSIGNED NOT NULL,
    xp            SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    stars         TINYINT UNSIGNED  NOT NULL DEFAULT 0,
    coins         SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    source        VARCHAR(16)  NOT NULL DEFAULT 'play',
    created_at    DATETIME     NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_attempt (attempt_id),
    KEY idx_user (user_id, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Контроль (очікуване — у дужках):
--   SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE()
--     AND TABLE_NAME IN ('bv_mission_variants','bv_attempts','bv_seen_variants','bv_exam_items','bv_strings','bv_players','bv_xp_log');  -- 7

-- hint_used у bv_attempts: якщо таблицю створено ранішою редакцією цього файлу (лише локально) — додати за перевіркою.
SET @db = DATABASE();
SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE bv_attempts ADD COLUMN hint_used TINYINT(1) NOT NULL DEFAULT 0 AFTER ip_hash', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'bv_attempts' AND COLUMN_NAME = 'hint_used');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;
