-- =====================================================================
-- AI LAB HUB — міграція 2026-11-25 (Багвіль, № 39): Майстерня (MAIN_TASK, розділ 7).
-- Лише НОВІ таблиці (CREATE TABLE IF NOT EXISTS), без FOREIGN KEY, ENUM, DROP, DELETE, TRUNCATE, ALTER, USE.
-- Каталог (12 предметів) — сид tools/bugville-seed.php; малюнки предметів — код (app/bugville/bv-workshop.php, SVG).
-- Монети гри не мають окремого гаманця: баланс = зароблене (bv_xp_log.coins) − витрачене (bv_user_items.price_paid).
-- Таблиці з user_id входять у BV_PLAYER_TABLES (видалення даних гравця на запит).
-- На живій базі — лише після «так» власниці; на проді — по одному CREATE.
-- =====================================================================

SET NAMES utf8mb4;

-- Каталог: kind — 'frame' (рамка аватара), 'sticker' (наклейка), 'background' (фон карти); VARCHAR + перевірка в PHP.
CREATE TABLE IF NOT EXISTS bv_workshop_items (
    item_key      VARCHAR(32)  NOT NULL,
    lang          VARCHAR(5)   NOT NULL DEFAULT 'uk',
    kind          VARCHAR(16)  NOT NULL,
    title         VARCHAR(80)  NOT NULL,
    description   VARCHAR(255) NOT NULL,
    price         SMALLINT UNSIGNED NOT NULL,
    sort          SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    status        VARCHAR(16)  NOT NULL DEFAULT 'active',
    updated_at    DATETIME     NULL,
    PRIMARY KEY (item_key, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Куплені предмети: один предмет — один раз (PRIMARY KEY), ціна на момент купівлі.
CREATE TABLE IF NOT EXISTS bv_user_items (
    user_id       INT UNSIGNED NOT NULL,
    item_key      VARCHAR(32)  NOT NULL,
    price_paid    SMALLINT UNSIGNED NOT NULL,
    bought_at     DATETIME     NOT NULL,
    PRIMARY KEY (user_id, item_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Вигляд гравця: аватар (з набору, безкоштовно) і вдягнуте — по одному предмету кожного виду.
CREATE TABLE IF NOT EXISTS bv_user_look (
    user_id       INT UNSIGNED NOT NULL,
    avatar        VARCHAR(16)  NULL,
    frame         VARCHAR(32)  NULL,
    sticker       VARCHAR(32)  NULL,
    background    VARCHAR(32)  NULL,
    updated_at    DATETIME     NOT NULL,
    PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Контроль (очікується 3):
--   SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = '<назва бази>'
--     AND TABLE_NAME IN ('bv_workshop_items','bv_user_items','bv_user_look');
