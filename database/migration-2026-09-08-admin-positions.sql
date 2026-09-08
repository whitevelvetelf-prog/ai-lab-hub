-- =====================================================================
-- AI LAB HUB — міграція: посади в приватній системі заявок
--
--   * admin_requests.position — технічний ключ обраної посади
--       ceo / exec_director_1 / exec_director_2
--       NULL — «стара» заявка, подана до появи посад (обробляється як
--       звичайна заявка на роль admin).
--   * users.position          — людський підпис посади для відображення
--       у кабінеті («Генеральний директор» тощо). Роль лишається 'admin'
--       (технічний рівень доступу до CRM), посада — окрема мітка.
--
-- Посади одномісні: підтвердження заявки на вже зайняту посаду
-- блокується на рівні коду (public/account.php), не в БД.
--
-- Застосувати на «живій» базі (schema.sql перезаписувати не потрібно):
--   mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-08-admin-positions.sql
-- =====================================================================

USE ailabhub_db;

ALTER TABLE users
    ADD COLUMN `position` VARCHAR(255) NULL AFTER employee_number;

ALTER TABLE admin_requests
    ADD COLUMN `position` VARCHAR(32) NULL AFTER user_id,
    ADD KEY idx_admin_requests_position (`position`);
