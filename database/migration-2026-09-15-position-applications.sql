-- =====================================================================
-- AI LAB HUB — міграція: універсальна система заявок на посаду
--
--   Замінює окремі форми під конкретні посади (apply-ceo.php,
--   apply-exec-director.php) на одну гнучку систему: власниця сама
--   вписує назву посади при створенні посилання, кандидат заповнює
--   контактні дані за посиланням.
--
--   Старі таблиці (admin_requests, employee_requests) і старі форми
--   НЕ чіпаємо — лишаються як є, з історичними даними. Новий функціонал
--   іде повністю через цю нову таблицю, паралельно зі старим.
--
--   Кандидат має вже мати акаунт на сайті з тим email, який вкаже у
--   формі (перевіряється і при поданні заявки, і при підтвердженні) —
--   акаунт для нього автоматично НЕ створюється.
--
--   token — bin2hex(random_bytes(32)), як і login_tokens.
--   status: pending (посилання створене, ще не заповнене) ->
--           submitted (кандидат заповнив контакти) ->
--           confirmed (власниця/адмін підтвердили — users.role='admin',
--           users.position = position_title цієї заявки).
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити цей файл ЯК Є у вкладку SQL
--     (база вже обрана в інтерфейсі; рядок USE нижче лишити закоментованим).
--   * локально через CLI — розкоментувати рядок USE нижче, або передати
--     базу аргументом:
--       mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-15-position-applications.sql
--
--   Безпечно повторно застосовувати: CREATE TABLE IF NOT EXISTS.
-- =====================================================================

-- USE ailabhub_db;   -- розкоментуй для локального запуску через CLI; для phpMyAdmin на хостингу не потрібно

CREATE TABLE IF NOT EXISTS position_applications (
    id             INT UNSIGNED NOT NULL AUTO_INCREMENT,
    position_title VARCHAR(255) NOT NULL,
    token          CHAR(64) NOT NULL,
    last_name      VARCHAR(255) NULL,
    first_name     VARCHAR(255) NULL,
    email          VARCHAR(255) NULL,
    phone          VARCHAR(32) NULL,
    status         ENUM('pending', 'submitted', 'confirmed') NOT NULL DEFAULT 'pending',
    created_by     INT UNSIGNED NOT NULL,
    created_at     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    submitted_at   DATETIME NULL,
    confirmed_at   DATETIME NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_position_applications_token (token),
    KEY idx_position_applications_status (status),
    KEY idx_position_applications_created_by (created_by),
    CONSTRAINT fk_position_applications_created_by
        FOREIGN KEY (created_by) REFERENCES users (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
