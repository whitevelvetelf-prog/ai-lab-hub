-- AI LAB HUB — аудиторія рекламних кампаній і реєстрації з власної реклами (app/promo-internal.php, app/acquisition.php).
-- Лише нові таблиці (CREATE TABLE IF NOT EXISTS), наявні таблиці реклами не змінюються. Ідемпотентно.
-- Аудиторію наявних кампаній із посиланням на реєстрацію виставляє ОКРЕМА міграція
-- migration-2026-11-12-ad-audience-register-guests.sql (застосовувати після цієї).

-- Аудиторія кампанії: 'all' (за замовчуванням, коли рядка немає), 'guests' — лише гостям, 'logged_in' — лише тим, хто увійшов.
CREATE TABLE IF NOT EXISTS ad_campaign_audience (
    campaign_id INT UNSIGNED NOT NULL,
    audience    VARCHAR(20)  NOT NULL DEFAULT 'all',
    updated_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (campaign_id),
    KEY idx_ad_campaign_audience (audience)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Реєстрації, які принесла власна реклама (?ref=house-… у сесії на момент реєстрації). Один рядок на користувача.
CREATE TABLE IF NOT EXISTS ad_house_signups (
    user_id     INT UNSIGNED NOT NULL,
    ref_code    VARCHAR(40)  NOT NULL,
    creative_id INT UNSIGNED NULL,
    campaign_id INT UNSIGNED NULL,
    created_at  DATETIME     NOT NULL,
    PRIMARY KEY (user_id),
    KEY idx_ad_house_signups_ref (ref_code),
    KEY idx_ad_house_signups_campaign (campaign_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- EN-текст повідомлення в кабінеті для тих, хто вже увійшов і відкрив /register.php.
INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('register_already_logged_in', 'en', 'You are already signed in — there is no need to register again.', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';
