-- =====================================================================
-- AI LAB HUB — міграція 2026-11-24 (Багвіль, № 34): іспити рівнів і грамоти (крок 4 плану).
-- Лише НОВІ таблиці (CREATE TABLE IF NOT EXISTS), без FOREIGN KEY, ENUM, DROP, DELETE, TRUNCATE, ALTER, USE.
-- Іспит = рядок bv_attempts з kind = 'exam' і mission_id = id іспиту (9000 + номер рівня); його завдання — тут.
-- Нагорода іспиту — запис у bv_xp_log (source = 'exam', attempt_id = спроба іспиту): один раз на спробу.
-- Час — UTC (пише PHP). Виконати у phpMyAdmin на живій базі лише після «так» власниці; на проді — по одному CREATE.
-- =====================================================================

SET NAMES utf8mb4;

-- Завдання іспиту: n-те завдання спроби, варіант місії (seed / variant_id), карта одноразових id і відповідь гравця.
-- user_id — для видалення даних гравця (BV_PLAYER_TABLES); гості іспитів не складають.
CREATE TABLE IF NOT EXISTS bv_exam_tasks (
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    attempt_id    INT UNSIGNED NOT NULL,
    user_id       INT UNSIGNED NOT NULL,
    n             TINYINT UNSIGNED NOT NULL,
    mission_id    INT UNSIGNED NOT NULL,
    variant_id    INT UNSIGNED NULL,
    seed          VARCHAR(32)  NULL,
    variant_key   VARCHAR(48)  NOT NULL,
    opt_map_json  TEXT         NULL,
    answered      TINYINT(1)   NOT NULL DEFAULT 0,
    correct       TINYINT(1)   NOT NULL DEFAULT 0,
    answered_at   DATETIME     NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_attempt_n (attempt_id, n),
    KEY idx_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Грамоти: одна на складений іспит акаунта (перше складання). code — випадковий, для посилання на сторінку друку
-- (бачить лише власник). display_name вводить гравець (радимо псевдонім); NULL — «Помічник майстра».
CREATE TABLE IF NOT EXISTS bv_certificates (
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id       INT UNSIGNED NOT NULL,
    exam_id       INT UNSIGNED NOT NULL,
    attempt_id    INT UNSIGNED NOT NULL,
    code          CHAR(20)     NOT NULL,
    display_name  VARCHAR(60)  NULL,
    score         TINYINT UNSIGNED NOT NULL DEFAULT 0,
    lang          VARCHAR(5)   NOT NULL DEFAULT 'uk',
    created_at    DATETIME     NOT NULL,
    updated_at    DATETIME     NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_code (code),
    UNIQUE KEY uq_user_exam (user_id, exam_id),
    UNIQUE KEY uq_attempt (attempt_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Контроль (очікується 2):
--   SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = '<назва бази>'
--     AND TABLE_NAME IN ('bv_exam_tasks','bv_certificates');
