-- =====================================================================
-- AI LAB HUB — міграція: власна аналітика (перегляди, кліки)
--
--   page_views  — перегляд сторінки (app/analytics.php: analytics_log_view()),
--                 викликається з product.php / catalog.php / category.php /
--                 index.php, blog-post.php (тип 'article', без page_id).
--   link_clicks — клік по кнопці «Перейти на сайт» через проміжний
--                 редirect public/go.php (analytics_log_click()).
--
--   session_hash — sha256(session_id + IP), не персональні дані:
--   сам IP у явному вигляді ніде не зберігається, лише як сіль для
--   лічильника унікальних сесій.
--
--   Видно лише admin, на public/admin-stats.php.
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити цей файл ЯК Є у вкладку SQL.
--   * локально: mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-18-analytics.sql
--
--   Безпечно повторно застосовувати: CREATE TABLE IF NOT EXISTS.
--   Жодних DROP / DELETE / ALTER існуючих таблиць чи колонок.
-- =====================================================================

CREATE TABLE IF NOT EXISTS page_views (
    id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
    page_type    ENUM('product', 'article', 'category', 'home', 'other') NOT NULL,
    page_id      INT UNSIGNED NULL,
    viewed_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    session_hash CHAR(64) NOT NULL,
    PRIMARY KEY (id),
    KEY idx_page_views_type_id (page_type, page_id),
    KEY idx_page_views_viewed_at (viewed_at)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS link_clicks (
    id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
    product_id   INT UNSIGNED NOT NULL,
    link_type    ENUM('official', 'affiliate') NOT NULL,
    clicked_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    session_hash CHAR(64) NOT NULL,
    PRIMARY KEY (id),
    KEY idx_link_clicks_product (product_id),
    KEY idx_link_clicks_clicked_at (clicked_at),
    CONSTRAINT fk_link_clicks_product
        FOREIGN KEY (product_id) REFERENCES products (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- EN-переклад нового посилання в кабінеті admin (готовий людський
-- переклад, source='manual' — Google Translate API тут не витрачається).
-- ---------------------------------------------------------------------
INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('account_site_stats_link', 'en', 'Site statistics →', 'manual');
