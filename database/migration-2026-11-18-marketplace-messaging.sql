-- =====================================================================
-- AI LAB HUB — міграція 2026-11-18 (Marketplace, № 22): внутрішні повідомлення між користувачами (етап 2 після показу контактів).
-- Код: app/mp-messages.php, public/mp-messages.php, mp-thread.php, mp-messages-poll.php, mp-notify-settings.php,
-- mp-inbox-admin.php, mp-message-reports.php, mp-cron-messages.php. Функція вимкнена (config 'messaging_enabled' => false).
--
-- Безпечно й ідемпотентно (можна виконати повторно):
--   * нові таблиці — CREATE TABLE IF NOT EXISTS, COLLATE=utf8mb4_unicode_ci, без FOREIGN KEY;
--   * mp_listings — лише ADD COLUMN contact_mode за перевіркою в information_schema (MySQL не знає ADD COLUMN IF NOT EXISTS).
-- DROP / DELETE / TRUNCATE / MODIFY немає. Наявні дані не змінюються.
-- Оголошення компаній (вакансії / курси / послуги) — ті самі рядки mp_listings (section job|course|service), тож окремої
-- таблиці модуля немає й колонка одна.
-- =====================================================================

SET NAMES utf8mb4;

-- На проді phpMyAdmin інколи не бачить information_schema за DATABASE(); тоді — явна назва бази.
SET @db = IF((SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'mp_listings') > 0,
             DATABASE(), 'gu621051_ailabhublive');

-- ---------------------------------------------------------------------
-- 1. Режим звʼязку з автором оголошення: both (контакти й повідомлення) | messages_only | contacts_only
-- ---------------------------------------------------------------------
SET @s = (SELECT IF(COUNT(*) = 0, 'ALTER TABLE mp_listings ADD COLUMN contact_mode VARCHAR(16) NOT NULL DEFAULT ''both''', 'DO 0')
  FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = @db AND TABLE_NAME = 'mp_listings' AND COLUMN_NAME = 'contact_mode');
PREPARE st FROM @s; EXECUTE st; DEALLOCATE PREPARE st;

-- ---------------------------------------------------------------------
-- 2. Розмови: одна на пару «оголошення + покупець». seller_user_id NULL — оголошення платформи (спільна скринька).
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS mp_conversations (
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    listing_source  VARCHAR(20)  NOT NULL DEFAULT 'mp',
    listing_id      INT UNSIGNED NOT NULL,
    buyer_id        INT UNSIGNED NOT NULL,
    seller_user_id  INT UNSIGNED NULL,
    status          VARCHAR(10)  NOT NULL DEFAULT 'open',
    last_message_id INT UNSIGNED NULL,
    last_message_at DATETIME     NULL,
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_listing_buyer (listing_source, listing_id, buyer_id),
    KEY idx_buyer_last (buyer_id, last_message_at),
    KEY idx_seller_last (seller_user_id, last_message_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Повідомлення: лише звичайний текст. sender_id NULL — системне повідомлення або відповідь платформи (sender_label 'AI LAB HUB').
CREATE TABLE IF NOT EXISTS mp_messages (
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    conversation_id INT UNSIGNED NOT NULL,
    sender_id       INT UNSIGNED NULL,
    sender_label    VARCHAR(40)  NULL,
    body            TEXT         NOT NULL,
    is_system       TINYINT(1)   NOT NULL DEFAULT 0,
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_conv_id (conversation_id, id),
    KEY idx_sender_created (sender_id, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Стан розмови для кожного учасника: прочитане, «сховано до», без сповіщень.
CREATE TABLE IF NOT EXISTS mp_conversation_state (
    conversation_id         INT UNSIGNED NOT NULL,
    user_id                 INT UNSIGNED NOT NULL,
    last_read_message_id    INT UNSIGNED NOT NULL DEFAULT 0,
    hidden_up_to_message_id INT UNSIGNED NOT NULL DEFAULT 0,
    is_muted                TINYINT(1)   NOT NULL DEFAULT 0,
    PRIMARY KEY (conversation_id, user_id),
    KEY idx_user (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Блокування: blocker не отримує повідомлень від blocked.
CREATE TABLE IF NOT EXISTS mp_user_blocks (
    blocker_id INT UNSIGNED NOT NULL,
    blocked_id INT UNSIGNED NOT NULL,
    created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (blocker_id, blocked_id),
    KEY idx_blocked (blocked_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Скарги на повідомлення: знімок до 30 останніх повідомлень розмови (JSON) на момент скарги.
CREATE TABLE IF NOT EXISTS mp_message_reports (
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    conversation_id INT UNSIGNED NOT NULL,
    message_id      INT UNSIGNED NULL,
    reporter_id     INT UNSIGNED NOT NULL,
    reason          VARCHAR(20)  NOT NULL,
    note            VARCHAR(500) NULL,
    snapshot        MEDIUMTEXT   NULL,
    status          VARCHAR(10)  NOT NULL DEFAULT 'new',
    handled_by      INT UNSIGNED NULL,
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_status (status, id),
    KEY idx_conv (conversation_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Журнал повного перегляду розмов адміністрацією (обов'язкова причина). Бачить лише admin.
CREATE TABLE IF NOT EXISTS mp_admin_access_log (
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    admin_id        INT UNSIGNED NOT NULL,
    conversation_id INT UNSIGNED NOT NULL,
    action          VARCHAR(30)  NOT NULL,
    reason          VARCHAR(300) NOT NULL,
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_conv (conversation_id),
    KEY idx_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Налаштування листів про нові повідомлення (за замовчуванням вимкнено).
CREATE TABLE IF NOT EXISTS mp_notify_prefs (
    user_id           INT UNSIGNED NOT NULL,
    email_new_message TINYINT(1)   NOT NULL DEFAULT 0,
    last_email_at     DATETIME     NULL,
    PRIMARY KEY (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Облік листів про нові повідомлення (ліміти: 1 на розмову за 30 хв, 5 на добу на користувача).
CREATE TABLE IF NOT EXISTS mp_message_emails (
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id         INT UNSIGNED NOT NULL,
    conversation_id INT UNSIGNED NOT NULL,
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_user_created (user_id, created_at),
    KEY idx_conv_user (conversation_id, user_id, created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Прапори користувача в повідомленнях: обмеження надсилання (адміністрація) і тимчасове обмеження нових розмов
-- (автопрапор «Підозріла активність»). Акаунт автоматично не блокується.
CREATE TABLE IF NOT EXISTS mp_user_flags (
    id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
    user_id    INT UNSIGNED NOT NULL,
    flag       VARCHAR(30)  NOT NULL,
    until_at   DATETIME     NULL,
    note       VARCHAR(300) NULL,
    created_by INT UNSIGNED NULL,
    is_active  TINYINT(1)   NOT NULL DEFAULT 1,
    created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_user_flag (user_id, flag, is_active),
    KEY idx_created (created_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Контроль (очікуване — у дужках):
--   SHOW COLUMNS FROM mp_listings LIKE 'contact_mode';                                                    -- 1 рядок
--   SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_SCHEMA = @db AND TABLE_NAME IN ('mp_conversations','mp_messages',
--     'mp_conversation_state','mp_user_blocks','mp_message_reports','mp_admin_access_log','mp_notify_prefs','mp_message_emails','mp_user_flags'); -- 9
