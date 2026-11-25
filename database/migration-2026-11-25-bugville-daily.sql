-- =====================================================================
-- AI LAB HUB — міграція 2026-11-25 (Багвіль, № 40): «Поломка дня» і мʼяка серія днів.
-- Лише НОВІ таблиці (CREATE TABLE IF NOT EXISTS), без FOREIGN KEY, ENUM, DROP, DELETE, TRUNCATE, ALTER, USE.
-- Серія днів — наявна таблиця bv_streaks (міграція № 36) без змін:
--   current_days = поточна серія, best_days = найкраща, last_day = останній зарахований день,
--   grace_week = ISO-тиждень, у якому вихідний уже використано (вихідний — один на тиждень, config).
-- Дата дня — за часовим поясом bugville_daily_timezone (Europe/Kyiv); час (created_at) — UTC, пише PHP.
-- Гостям нічого не пишеться в bv_daily_results. Таблиця з user_id — у BV_PLAYER_TABLES (видалення на запит).
-- На живій базі — лише після «так» власниці; на проді — по одному CREATE.
-- =====================================================================

SET NAMES utf8mb4;

-- Місія дня: один рядок на дату (PRIMARY KEY = день); перший запит дня пише INSERT IGNORE — гонитва не створить двох.
-- mission_type — тип сцени (input_machine / form_scene / table_scene), mission_ref — ключ генератора, seed — варіант дня.
CREATE TABLE IF NOT EXISTS bv_daily (
    day           DATE         NOT NULL,
    mission_type  VARCHAR(16)  NOT NULL,
    mission_ref   VARCHAR(32)  NOT NULL,
    seed          VARCHAR(64)  NOT NULL,
    created_at    DATETIME     NOT NULL,
    PRIMARY KEY (day)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Результат гравця за день: done — здано хоча б раз, rewarded — нагороду видано (UPDATE … WHERE done = 0 — один раз).
CREATE TABLE IF NOT EXISTS bv_daily_results (
    user_id       INT UNSIGNED NOT NULL,
    day           DATE         NOT NULL,
    stars         TINYINT UNSIGNED NOT NULL DEFAULT 0,
    found_count   TINYINT UNSIGNED NOT NULL DEFAULT 0,
    tries         SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    done          TINYINT(1)   NOT NULL DEFAULT 0,
    rewarded      TINYINT(1)   NOT NULL DEFAULT 0,
    created_at    DATETIME     NOT NULL,
    PRIMARY KEY (user_id, day)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Контроль (очікується 2):
--   SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = '<назва бази>'
--     AND TABLE_NAME IN ('bv_daily','bv_daily_results');
