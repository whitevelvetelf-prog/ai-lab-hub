-- =====================================================================
-- AI LAB HUB — міграція 2026-10-16: надійність Елі (етап 0, блок 1)
--
--   eli_api_log — один рядок на запит до Елі (app/eli.php: eli_log()).
--     Лише технічні поля: провайдер, модель, HTTP-статус, тип помилки,
--     джерело відповіді (ai / cache / fallback / fail / limited), затримка,
--     кількість спроб, чи була запасна модель, мова, анонімний session_hash
--     (sha256(session_id|IP), як у page_views). ТЕКСТ ЗАПИТУ Й ВІДПОВІДІ
--     НЕ ЗБЕРІГАЄТЬСЯ. Зберігається 90 днів (очищення — cron/promo-daily.php).
--   eli_cache — кеш відповідей AI: key_hash = sha256(нормалізований запит |
--     мова | версія промпта | модель); сам текст запиту не зберігається.
--     response_json — лише reply_text і id продуктів у кроках.
--
--   Плюс EN-підписи нових фраз і заміна «Eli» → «Elya» в англійських
--   перекладах інтерфейсу (ui_translations, ad_translations).
--
-- Лише CREATE TABLE IF NOT EXISTS / INSERT … ON DUPLICATE KEY UPDATE / UPDATE
-- перекладів. Жодних DROP / TRUNCATE. Повторний запуск безпечний.
-- Застосування: phpMyAdmin → БД → вкладка SQL → вставити файл → Вперёд.
-- =====================================================================

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS eli_api_log (
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    created_at    DATETIME NOT NULL,
    provider      VARCHAR(20) NOT NULL DEFAULT '',
    model         VARCHAR(60) NOT NULL DEFAULT '',
    http_status   SMALLINT UNSIGNED NULL,
    error_type    VARCHAR(20) NOT NULL DEFAULT 'none',
    source        ENUM('ai', 'cache', 'fallback', 'fail', 'limited') NOT NULL DEFAULT 'ai',
    latency_ms    INT UNSIGNED NOT NULL DEFAULT 0,
    attempts      TINYINT UNSIGNED NOT NULL DEFAULT 0,
    used_fallback TINYINT(1) NOT NULL DEFAULT 0,
    lang          VARCHAR(5) NOT NULL DEFAULT '',
    session_hash  CHAR(64) NOT NULL DEFAULT '',
    PRIMARY KEY (id),
    KEY idx_eli_api_log_created (created_at)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS eli_cache (
    key_hash      CHAR(64) NOT NULL,
    response_json MEDIUMTEXT NOT NULL,
    created_at    DATETIME NOT NULL,
    hits          INT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (key_hash),
    KEY idx_eli_cache_created (created_at)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- EN-переклади: нові фрази + асистентка в англійській версії — «Elya».
INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('eli_fallback_intro', 'en', 'Smart matching is unavailable right now, but here is what we found for your request:', 'manual'),
('eli_fallback_step', 'en', 'Found in the catalog', 'manual'),
('eli_fallback_none', 'en', 'Smart matching is unavailable right now, and nothing in the catalog matched your request. Browse the popular sections or try again in a minute.', 'manual'),
('eli_fallback_links', 'en', 'Popular sections', 'manual'),
('eli_rate_limited', 'en', 'Please wait a minute and try again.', 'manual'),
('eli_empty_message', 'en', 'Please describe your task and I will pick a suitable AI tool.', 'manual'),
('eli_catalog_empty', 'en', 'There are no published tools in the catalog yet. Please come back a little later.', 'manual'),
('eli_nothing_found', 'en', 'Unfortunately, none of the available tools fit this task.', 'manual'),
('eli_client_timeout', 'en', 'The answer is taking longer than usual. Please try again.', 'manual'),
('eli_client_network', 'en', 'Could not reach the site. Check your connection and try again.', 'manual'),
('eli_tech_error', 'en', 'Sorry, we are having technical difficulties right now. Please try again in a minute.', 'manual'),
('nav_assistant_short', 'en', 'Ask Elya', 'manual'),
('title_eli', 'en', 'AI LAB HUB — Elya, AI Assistant', 'manual'),
('eli_title', 'en', 'Elya — your AI assistant', 'manual'),
('eli_subtitle', 'en', 'Describe your task — Elya will find the best AI tool', 'manual'),
('eli_video_alt', 'en', 'Elya video', 'manual'),
('eli_thinking', 'en', 'Elya is thinking…', 'manual'),
('search_ask_eli_link', 'en', 'ask Elya', 'manual'),
('account_text_guest', 'en', 'Log in to save favorite products and get personal recommendations from Elya.', 'manual'),
('register_subtitle', 'en', 'Create an account to save products and get recommendations from Elya.', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';

-- Решта англійських перекладів, де асистентку названо «Eli» (і автопереклади).
UPDATE ui_translations
   SET translated_text = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(translated_text,
       'Eli ', 'Elya '), 'Eli,', 'Elya,'), 'Eli.', 'Elya.'), 'Eli—', 'Elya—'), 'Eli’s', 'Elya’s'), 'Eli''s', 'Elya''s')
 WHERE lang = 'en' AND CAST(translated_text AS BINARY) LIKE BINARY '%Eli%';

UPDATE ui_translations
   SET translated_text = CONCAT(LEFT(translated_text, CHAR_LENGTH(translated_text) - 3), 'Elya')
 WHERE lang = 'en' AND CAST(translated_text AS BINARY) LIKE BINARY '% Eli';

UPDATE ad_translations
   SET translated_text = REPLACE(REPLACE(REPLACE(translated_text, 'Eli ', 'Elya '), 'Eli,', 'Elya,'), 'Eli.', 'Elya.')
 WHERE lang = 'en' AND CAST(translated_text AS BINARY) LIKE BINARY '%Eli%';
