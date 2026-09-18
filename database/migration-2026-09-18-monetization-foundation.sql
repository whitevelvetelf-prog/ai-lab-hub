-- =====================================================================
-- AI LAB HUB — міграція: фундамент монетизації
--
--   1. campaigns — рекламні кампанії (внутрішні заповнювачі й, у
--      майбутньому, платні). campaign_type='paid' має пріоритет над
--      'internal' на однаковому placement; для 'internal' starts_at/
--      ends_at лишаються NULL (без дедлайну). Адмінки для керування
--      кампаніями поки нема — рядки додаються вручну через SQL
--      (id 1-3 нижче — три internal-заповнювачі для placement
--      'homepage_banner', unique за primary key, тож повторний запуск
--      цього файлу нічого не дублює).
--   2. newsletter_subscribers — базовий збір email на розсилку
--      (без інтеграції з сервісом розсилок — це на майбутнє).
--
-- Застосування:
--   * phpMyAdmin на хостингу — вставити цей файл ЯК Є у вкладку SQL.
--   * локально: mysql -h 127.0.0.1 -u root ailabhub_db < database/migration-2026-09-18-monetization-foundation.sql
--
--   Безпечно повторно застосовувати: CREATE TABLE IF NOT EXISTS +
--   INSERT IGNORE з фіксованими id / унікальним ключем. Жодних
--   DROP / DELETE / ALTER існуючих таблиць чи колонок.
-- =====================================================================

-- ---------------------------------------------------------------------
-- campaigns
--   placement — слот показу. Для MVP: homepage_banner (реалізовано
--               на public/index.php), category_sidebar (зарезервовано
--               на майбутнє, поки ніде не рендериться).
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS campaigns (
    id            INT UNSIGNED NOT NULL AUTO_INCREMENT,
    campaign_type ENUM('paid', 'internal') NOT NULL DEFAULT 'internal',
    title         VARCHAR(255) NOT NULL,
    description   VARCHAR(500) NULL,
    image_url     VARCHAR(512) NULL,
    target_url    VARCHAR(512) NOT NULL,
    placement     ENUM('homepage_banner', 'category_sidebar') NOT NULL DEFAULT 'homepage_banner',
    is_active     TINYINT(1) NOT NULL DEFAULT 1,
    starts_at     DATETIME NULL,
    ends_at       DATETIME NULL,
    created_at    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_campaigns_placement_active (placement, is_active),
    KEY idx_campaigns_type (campaign_type)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- newsletter_subscribers
-- ---------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS newsletter_subscribers (
    id             INT UNSIGNED NOT NULL AUTO_INCREMENT,
    email          VARCHAR(255) NOT NULL,
    subscribed_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    is_active      TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (id),
    UNIQUE KEY uniq_newsletter_email (email)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- ---------------------------------------------------------------------
-- Три internal-заповнювачі для homepage_banner (id фіксовані — INSERT
-- IGNORE не додасть дублів при повторному запуску).
-- ---------------------------------------------------------------------
INSERT IGNORE INTO campaigns (id, campaign_type, title, description, image_url, target_url, placement, is_active, starts_at, ends_at) VALUES
(1, 'internal', 'Здоров''я та краса — новий напрямок!', 'Ми щойно наповнили розділ AI-інструментами для здоров''я та краси. Загляньте, поки він новенький.', NULL, 'category.php?id=12', 'homepage_banner', 1, NULL, NULL),
(2, 'internal', 'Незабаром: готові AI-рішення', 'Ми готуємо Marketplace — готові AI-рішення під ключ для вашого бізнесу. Слідкуйте за оновленнями.', NULL, '#', 'homepage_banner', 1, NULL, NULL),
(3, 'internal', 'Підтримайте AI LAB HUB', 'Проєкт розвивається завдяки вашій підтримці. Кожен внесок наближає нові функції та інструменти.', NULL, 'donate.php', 'homepage_banner', 1, NULL, NULL);

-- ---------------------------------------------------------------------
-- EN-переклади нових написів UI (готовий людський переклад, source='manual' —
-- Google Translate API тут не витрачається).
-- ---------------------------------------------------------------------
INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('footer_disclaimer', 'en', 'AI LAB HUB may earn a commission on purchases made through some links on this site — this does not affect the price you pay.', 'manual'),
('product_affiliate_badge', 'en', 'affiliate link', 'manual'),
('product_affiliate_tooltip', 'en', 'This is an affiliate link: if you use it, AI LAB HUB may earn a small commission.', 'manual'),
('ad_label', 'en', 'Ad', 'manual'),
('newsletter_title', 'en', 'Be the first to know about new AI tools', 'manual'),
('newsletter_placeholder', 'en', 'Your email', 'manual'),
('newsletter_submit', 'en', 'Subscribe', 'manual'),
('newsletter_success', 'en', 'Thank you! You are subscribed.', 'manual'),
('newsletter_already', 'en', 'You are already subscribed.', 'manual'),
('newsletter_error_invalid', 'en', 'Invalid email.', 'manual'),
('newsletter_error_generic', 'en', 'Could not subscribe. Please try again later.', 'manual');
