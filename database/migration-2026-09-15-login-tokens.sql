-- =====================================================================
-- AI LAB HUB — міграція: одноразові токени входу без пароля (magic link)
--
--   «Забули пароль?» (public/forgot-password.php) — замість «скинути
--   пароль на новий» користувач отримує на email одноразове посилання,
--   клік по якому одразу авторизує його (public/login-via-token.php).
--
--   token      — bin2hex(random_bytes(32)), 64 hex-символи, не UUID
--                (криптографічно стійкий, непередбачуваний);
--   expires_at — NOW() + 15 хв на момент видачі;
--   used_at    — NULL, поки не використаний; виставляється або коли
--                токен реально використали для входу, або коли його
--                анулювали видачею нового (лишається чинним лише
--                останній надісланий лист — див. forgot-password.php).
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити цей файл ЯК Є у вкладку SQL
--     (база вже обрана в інтерфейсі; рядок USE нижче лишити закоментованим).
--   * локально через CLI — розкоментувати рядок USE нижче, або передати
--     базу аргументом:
--       mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-15-login-tokens.sql
--
--   Безпечно повторно застосовувати: CREATE TABLE IF NOT EXISTS.
-- =====================================================================

-- USE ailabhub_db;   -- розкоментуй для локального запуску через CLI; для phpMyAdmin на хостингу не потрібно

CREATE TABLE IF NOT EXISTS login_tokens (
    id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id    INT UNSIGNED NOT NULL,
    token      CHAR(64) NOT NULL,
    expires_at DATETIME NOT NULL,
    used_at    DATETIME NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_login_tokens_token (token),
    KEY idx_login_tokens_user (user_id),
    CONSTRAINT fk_login_tokens_user
        FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
