-- =====================================================================
-- AI LAB HUB — міграція 2026-10-25: журнал пошукових запитів (app/search-log.php)
--
--   search_queries — тексти запитів з пошуку в шапці (api-search.php, source = header), сторінки
--     результатів (catalog.php?search=, source = catalog) і Елі (api-eli-chat.php, source = eli).
--     Анонімно: session_hash (як у page_views), без IP і User-Agent; боти й перегляди співробітників
--     не пишуться. Пошта, телефони й посилання в тексті маскуються, довжина — до 160 символів.
--     Рядки старші за 180 днів видаляються самим логером.
--   Звіт — admin-stats.php, блок «Пошукові запити».
--
-- Лише CREATE TABLE IF NOT EXISTS. Повторний запуск безпечний.
-- Застосування: phpMyAdmin → БД → «Импорт» → цей файл → Вперёд.
-- =====================================================================

SET NAMES utf8mb4;

CREATE TABLE IF NOT EXISTS search_queries (
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    query_text    VARCHAR(160) NOT NULL,
    query_norm    VARCHAR(160) NOT NULL,
    source        ENUM('header', 'catalog', 'eli') NOT NULL,
    results_count SMALLINT UNSIGNED NOT NULL DEFAULT 0,
    session_hash  CHAR(64) NOT NULL,
    lang          VARCHAR(5) NOT NULL DEFAULT '',
    created_at    DATETIME NOT NULL,
    PRIMARY KEY (id),
    KEY idx_search_queries_created (created_at),
    KEY idx_search_queries_norm (query_norm),
    KEY idx_search_queries_session (session_hash, created_at)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
