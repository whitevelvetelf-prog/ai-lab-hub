-- =====================================================================
-- AI LAB HUB — міграція: добірка продуктів у кабінеті («Моя добірка»)
--
--   * saved_products — які продукти користувач зберіг у свою добірку.
--       UNIQUE (user_id, product_id) — один продукт у добірці лише раз;
--       toggle-ендпоінт (public/api-saved-products.php) додає/прибирає рядок.
--       FK ON DELETE CASCADE — рядок зникає разом з користувачем/продуктом.
--
-- Існуючі таблиці users / products НЕ змінюються.
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити ЯК Є у вкладку SQL (база вже обрана).
--   * локально через CLI — розкоментувати рядок USE нижче, або:
--       mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-08-saved-products.sql
-- =====================================================================

-- USE ailabhub_db;   -- розкоментуй для локального запуску через CLI; для phpMyAdmin на хостингу не потрібно

CREATE TABLE IF NOT EXISTS saved_products (
    id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id    INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_saved_user_product (user_id, product_id),
    KEY idx_saved_user (user_id),
    KEY idx_saved_product (product_id),
    CONSTRAINT fk_saved_user
        FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_saved_product
        FOREIGN KEY (product_id) REFERENCES products (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
