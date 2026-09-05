-- =====================================================================
-- AI LAB HUB — міграція: приватна система заявок на роль Адміністратора
--   * нова таблиця admin_requests (окремо від employee_requests)
--
-- Застосувати на «живій» базі (schema.sql перезаписувати не потрібно):
--   mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-05-admin-requests.sql
-- =====================================================================

USE ailabhub_db;

CREATE TABLE IF NOT EXISTS admin_requests (
    id           INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id      INT UNSIGNED NOT NULL,
    status       ENUM('pending', 'approved', 'rejected') NOT NULL DEFAULT 'pending',
    requested_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    reviewed_by  INT UNSIGNED NULL,
    reviewed_at  TIMESTAMP NULL,
    PRIMARY KEY (id),
    KEY idx_admin_requests_user (user_id),
    KEY idx_admin_requests_status (status),
    CONSTRAINT fk_admin_requests_user
        FOREIGN KEY (user_id) REFERENCES users (id)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_admin_requests_reviewed_by
        FOREIGN KEY (reviewed_by) REFERENCES users (id)
        ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
