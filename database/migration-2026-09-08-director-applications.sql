-- =====================================================================
-- AI LAB HUB — міграція: контактні поля заявок на посади директорів
-- Доповнює migration-2026-09-08-admin-positions.sql (колонки position).
--
--   * admin_requests.first_name / last_name / phone / email
--       контакт кандидата на момент подачі заявки. Заповнюють форми
--       public/apply-ceo.php (position = 'ceo') та
--       public/apply-exec-director.php (position = 'exec_director').
--       NULL — заявка на роль Адміністратора (public/apply-admin.php),
--       яка контактів не збирає.
--   * users.phone
--       телефон, копіюється із заявки при підтвердженні (так само, як
--       first_name / last_name для працівників).
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити цей файл ЯК Є у вкладку SQL
--     (база вже обрана в інтерфейсі; рядок USE нижче лишити закоментованим).
--   * локально через CLI — розкоментувати рядок USE нижче, або передати
--     базу аргументом:
--       mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-08-director-applications.sql
-- =====================================================================

-- USE ailabhub_db;   -- розкоментуй для локального запуску через CLI; для phpMyAdmin на хостингу не потрібно

ALTER TABLE users
    ADD COLUMN phone VARCHAR(32) NULL AFTER last_name;

ALTER TABLE admin_requests
    ADD COLUMN first_name VARCHAR(255) NULL AFTER `position`,
    ADD COLUMN last_name  VARCHAR(255) NULL AFTER first_name,
    ADD COLUMN phone      VARCHAR(32)  NULL AFTER last_name,
    ADD COLUMN email      VARCHAR(255) NULL AFTER phone;
