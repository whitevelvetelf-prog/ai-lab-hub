-- =====================================================================
-- AI LAB HUB — міграція: нумерація працівників
--   * users: first_name / last_name / employee_number
--   * нова таблиця employee_requests (заявки «Стати працівником»)
--
-- Застосувати на «живій» базі (schema.sql перезаписувати не потрібно):
--   mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-01-employee-numbers.sql
-- =====================================================================

USE ailabhub_db;

ALTER TABLE users
    ADD COLUMN first_name      VARCHAR(255) NULL AFTER role,
    ADD COLUMN last_name       VARCHAR(255) NULL AFTER first_name,
    ADD COLUMN employee_number INT UNSIGNED NULL AFTER last_name,
    ADD UNIQUE KEY uq_users_employee_number (employee_number);

CREATE TABLE IF NOT EXISTS employee_requests (
    id          INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id     INT UNSIGNED NOT NULL,
    last_name   VARCHAR(255) NOT NULL,
    first_name  VARCHAR(255) NOT NULL,
    status      ENUM('pending', 'approved', 'rejected') NOT NULL DEFAULT 'pending',
    created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reviewed_at TIMESTAMP NULL,
    reviewed_by INT UNSIGNED NULL,
    PRIMARY KEY (id),
    KEY idx_employee_requests_user (user_id),
    KEY idx_employee_requests_status (status),
    CONSTRAINT fk_employee_requests_user
        FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_employee_requests_reviewed_by
        FOREIGN KEY (reviewed_by) REFERENCES users (id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
