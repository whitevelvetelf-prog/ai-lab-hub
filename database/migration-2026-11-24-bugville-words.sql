-- =====================================================================
-- AI LAB HUB — міграція 2026-11-24 (Багвіль, № 37): Книга чарівних слів (MAIN_TASK, розділи 3 і 6).
-- Лише НОВІ таблиці (CREATE TABLE IF NOT EXISTS), без FOREIGN KEY, ENUM, DROP, DELETE, TRUNCATE, ALTER, USE.
-- Слова Етапу 1 (15) — сид tools/bugville-seed.php. Вивчене — лише в акаунтів із підтвердженим віком.
-- Виконати на живій базі лише після «так» власниці; на проді — по одному CREATE.
-- =====================================================================

SET NAMES utf8mb4;

-- Слово: word_key = саме слово (англійською), мова пояснень — lang. mission_id — місія, після якої слово відкривається.
CREATE TABLE IF NOT EXISTS bv_words (
    word_key      VARCHAR(32)  NOT NULL,
    lang          VARCHAR(5)   NOT NULL DEFAULT 'uk',
    say           VARCHAR(64)  NOT NULL,
    meaning       VARCHAR(255) NOT NULL,
    example_en    VARCHAR(255) NOT NULL,
    example_tr    VARCHAR(255) NOT NULL,
    mission_id    INT UNSIGNED NOT NULL,
    sort          SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    status        VARCHAR(16)  NOT NULL DEFAULT 'active',
    updated_at    DATETIME     NULL,
    PRIMARY KEY (word_key, lang)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Вивчені слова (правильна вправа), один раз на слово.
CREATE TABLE IF NOT EXISTS bv_user_words (
    user_id       INT UNSIGNED NOT NULL,
    word_key      VARCHAR(32)  NOT NULL,
    learned_at    DATETIME     NOT NULL,
    PRIMARY KEY (user_id, word_key)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Контроль (очікується 2):
--   SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = '<назва бази>'
--     AND TABLE_NAME IN ('bv_words','bv_user_words');
