-- =====================================================================
-- AI LAB HUB — міграція 2026-11-24 (Багвіль, № 36): звання, значки, щоденна серія (MAIN_TASK, розділ 6).
-- Лише НОВІ таблиці (CREATE TABLE IF NOT EXISTS), без FOREIGN KEY, ENUM, DROP, DELETE, TRUNCATE, ALTER, USE.
-- Назви звань і значків та їхні пороги — у БД (редагуються в CRM), початкові значення — сид tools/bugville-seed.php.
-- Час — UTC (пише PHP), день серії — дата за Києвом. Гостям нічого не пишеться.
-- Виконати на живій базі лише після «так» власниці; на проді — по одному CREATE.
-- =====================================================================

SET NAMES utf8mb4;

-- Звання за XP: rank_key стабільний, назва й поріг редагуються. Звання гравця = найбільший min_xp ≤ його XP.
CREATE TABLE IF NOT EXISTS bv_ranks (
    rank_key      VARCHAR(32)  NOT NULL,
    lang          VARCHAR(5)   NOT NULL DEFAULT 'uk',
    title         VARCHAR(80)  NOT NULL,
    min_xp        INT UNSIGNED NOT NULL DEFAULT 0,
    status        VARCHAR(16)  NOT NULL DEFAULT 'active',
    updated_at    DATETIME     NULL,
    PRIMARY KEY (rank_key, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Значки: умова визначена кодом за badge_key (app/bugville/bv-progress.php), param — її поріг (напр. днів серії, слів).
CREATE TABLE IF NOT EXISTS bv_badges (
    badge_key     VARCHAR(32)  NOT NULL,
    lang          VARCHAR(5)   NOT NULL DEFAULT 'uk',
    title         VARCHAR(80)  NOT NULL,
    description   VARCHAR(255) NOT NULL,
    param         INT UNSIGNED NULL,
    sort          SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    status        VARCHAR(16)  NOT NULL DEFAULT 'active',
    updated_at    DATETIME     NULL,
    PRIMARY KEY (badge_key, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Отримані значки (один раз на значок).
CREATE TABLE IF NOT EXISTS bv_user_badges (
    user_id       INT UNSIGNED NOT NULL,
    badge_key     VARCHAR(32)  NOT NULL,
    earned_at     DATETIME     NOT NULL,
    PRIMARY KEY (user_id, badge_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Щоденна серія: last_day — останній день активності (дата за Києвом); grace_week — ISO-тиждень, у якому вже
-- пробачено пропуск (один на тиждень).
CREATE TABLE IF NOT EXISTS bv_streaks (
    user_id       INT UNSIGNED NOT NULL,
    current_days  SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    best_days     SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    last_day      DATE         NULL,
    grace_week    VARCHAR(8)   NULL,
    updated_at    DATETIME     NOT NULL,
    PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Контроль (очікується 4):
--   SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = '<назва бази>'
--     AND TABLE_NAME IN ('bv_ranks','bv_badges','bv_user_badges','bv_streaks');
