SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — 2026-10-31: історія донатів (ручний облік)
--
-- Донати надходять повз сайт (банка / картка / IBAN за реквізитами з public/donate.php),
-- тож адмін вносить кожен донат вручну на сторінці CRM public/crm-donations.php.
-- Користувач бачить лише свої записи (user_id) у кабінеті → «Мої підтримки проєкту».
--
--   amount_minor           — сума в центах USD (валюта сайту), ціле число
--   original_amount_minor  — фактично сплачена сума в мінімальних одиницях (копійки тощо), якщо відома
--   original_currency      — її валюта (ISO 4217, напр. UAH)
--   note                   — службова примітка адміна; БЕЗ номерів карток і реквізитів
--
-- Жодних даних карток чи платіжних реквізитів у цій таблиці немає.
-- Лише CREATE TABLE IF NOT EXISTS / INSERT IGNORE. Жодних DROP / DELETE / TRUNCATE.
-- Повторний запуск безпечний. Застосування: phpMyAdmin → БД → «SQL» → вставити → «Вперёд».
-- =====================================================================

CREATE TABLE IF NOT EXISTS `donations` (
    `id`                    INT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user_id`               INT UNSIGNED NULL,
    `donor_name`            VARCHAR(100) NULL,
    `amount_minor`          INT UNSIGNED NOT NULL,
    `original_amount_minor` INT UNSIGNED NULL,
    `original_currency`     CHAR(3) NULL,
    `status`                ENUM('received', 'pending', 'refunded', 'cancelled') NOT NULL DEFAULT 'received',
    `method`                ENUM('jar', 'card', 'iban_uah', 'iban_intl', 'other') NOT NULL DEFAULT 'jar',
    `donated_at`            DATETIME NOT NULL,
    `note`                  VARCHAR(255) NULL,
    `created_by`            INT UNSIGNED NULL,
    `created_at`            DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at`            DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `idx_donations_user_date` (`user_id`, `donated_at`),
    KEY `idx_donations_status_date` (`status`, `donated_at`),
    CONSTRAINT `fk_donations_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Англійські тексти нових рядків інтерфейсу (manual — не покладаємось на автопереклад).
INSERT IGNORE INTO `ui_translations` (`key_name`, `lang`, `translated_text`, `source`) VALUES
('support_cta_btn', 'en', 'Support the project', 'manual'),
('support_home_title', 'en', 'Do you find AI LAB HUB useful?', 'manual'),
('support_home_text', 'en', 'The catalog is free and independent. A voluntary donation helps us add new tools and keep descriptions up to date.', 'manual'),
('support_account_title', 'en', 'Thank you for being with us!', 'manual'),
('support_account_text', 'en', 'If AI LAB HUB helps you, you can support its development with a donation of any size.', 'manual'),
('support_account_history_link', 'en', 'Support history', 'manual'),
('donhist_title', 'en', 'My support for the project', 'manual'),
('donhist_empty', 'en', 'There are no donations here yet. If you decide to support AI LAB HUB, your donation will appear in this list once we confirm it. Thank you for simply being here!', 'manual'),
('donhist_note', 'en', 'Donations arrive through the bank, so they appear here after manual confirmation, usually within a few days. If you donated and don''t see it, write to us via Contacts.', 'manual'),
('donhist_col_date', 'en', 'Date', 'manual'),
('donhist_col_amount', 'en', 'Amount', 'manual'),
('donhist_col_status', 'en', 'Status', 'manual'),
('donhist_col_method', 'en', 'Payment method', 'manual'),
('donhist_paid', 'en', 'paid', 'manual'),
('donhist_total', 'en', 'Received in total: %s', 'manual'),
('donhist_prev', 'en', '← Newer', 'manual'),
('donhist_next', 'en', 'Older →', 'manual'),
('donhist_page', 'en', 'Page %1$d of %2$d', 'manual'),
('donhist_status_received', 'en', 'Received', 'manual'),
('donhist_status_pending', 'en', 'Pending', 'manual'),
('donhist_status_refunded', 'en', 'Refunded', 'manual'),
('donhist_status_cancelled', 'en', 'Cancelled', 'manual'),
('donhist_method_jar', 'en', 'Monobank jar', 'manual'),
('donhist_method_card', 'en', 'Card transfer', 'manual'),
('donhist_method_iban_uah', 'en', 'Bank transfer (UAH)', 'manual'),
('donhist_method_iban_intl', 'en', 'International transfer', 'manual'),
('donhist_method_other', 'en', 'Other', 'manual'),
('account_crm_donations_link', 'en', 'donations', 'manual');
