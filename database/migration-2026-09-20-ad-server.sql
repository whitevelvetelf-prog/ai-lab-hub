SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — міграція: ad server (реклама) 2026-09-20
--
-- Винесено з increment_latest.sql, щоб перезапис файлу новою партією
-- продуктів не знищив SQL реклами. Вставити ЯК Є у вкладку SQL
-- phpMyAdmin (один раз; безпечно повторювати).
--
-- Що входить:
--   * таблиці ad_zones, ad_campaigns, ads, ad_impressions, ad_clicks;
--   * колонки ads.headline / ads.subtext (лише якщо їх ще немає);
--   * таблиця ad_translations (переклад тексту оголошень);
--   * зони 1-2, внутрішня кампанія AI LAB HUB, оголошення 1-4 з текстом;
--   * ручний EN-переклад оголошень;
--   * EN-підпис ui_translations.account_crm_ads_link.
-- Лише CREATE TABLE IF NOT EXISTS / INSERT IGNORE / UPDATE наповнення —
-- жодних DROP / DELETE / TRUNCATE.
-- =====================================================================

-- =====================================================================
-- Ad server (зони, кампанії, оголошення, покази, кліки).
-- Лише CREATE TABLE IF NOT EXISTS — безпечно для повторного запуску.
-- Не плутати зі старою таблицею campaigns (банер головної сторінки).
-- =====================================================================
CREATE TABLE IF NOT EXISTS ad_zones (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    page_type ENUM('category', 'subcategory', 'global') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ad_campaigns (
    id INT AUTO_INCREMENT PRIMARY KEY,
    campaign_type ENUM('paid', 'internal') NOT NULL DEFAULT 'paid',
    advertiser_name VARCHAR(255) NOT NULL,
    contact_email VARCHAR(255) NULL,
    payment_type ENUM('fixed_period') NULL,
    paid_amount DECIMAL(10,2) NULL,
    status ENUM('active', 'paused', 'expired') NOT NULL DEFAULT 'active',
    start_date DATE NOT NULL,
    end_date DATE NULL,
    notes TEXT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ads (
    id INT AUTO_INCREMENT PRIMARY KEY,
    campaign_id INT NOT NULL,
    zone_id INT NOT NULL,
    image_url VARCHAR(500) NOT NULL,
    target_url VARCHAR(500) NOT NULL,
    category_id INT NULL,
    subcategory_id INT NULL,
    status ENUM('active', 'inactive') NOT NULL DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (campaign_id) REFERENCES ad_campaigns(id),
    FOREIGN KEY (zone_id) REFERENCES ad_zones(id)
);

CREATE TABLE IF NOT EXISTS ad_impressions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    ad_id INT NOT NULL,
    session_id VARCHAR(100) NULL,
    shown_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ad_id) REFERENCES ads(id)
);

CREATE TABLE IF NOT EXISTS ad_clicks (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    ad_id INT NOT NULL,
    session_id VARCHAR(100) NULL,
    clicked_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ad_id) REFERENCES ads(id)
);

-- Текст оголошення (headline/subtext) живе в БД, а не в зображенні, щоб
-- перекладатись як решта контенту. Колонки додаються лише якщо їх ще нема
-- (information_schema + PREPARE — працює і на MySQL, і на MariaDB).
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ads' AND COLUMN_NAME='headline')=0,
  'ALTER TABLE ads ADD COLUMN headline VARCHAR(255) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ads' AND COLUMN_NAME='subtext')=0,
  'ALTER TABLE ads ADD COLUMN subtext VARCHAR(500) NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- ad_translations — переклад headline/subtext (за зразком product_translations;
-- рушій app/translation-cache.php: cached_translation / localized_field).
CREATE TABLE IF NOT EXISTS ad_translations (
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    ad_id           INT NOT NULL,
    field_name      VARCHAR(50) NOT NULL,
    lang            VARCHAR(5) NOT NULL,
    translated_text MEDIUMTEXT NOT NULL,
    source          ENUM('auto', 'manual') NOT NULL DEFAULT 'auto',
    updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uniq_ad_field_lang (ad_id, field_name, lang),
    CONSTRAINT fk_ad_translations_ad
        FOREIGN KEY (ad_id) REFERENCES ads (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Зони та внутрішні оголошення AI LAB HUB (промо Елі й підтримки проєкту)
-- для сторінок категорії (зона 1) і підкатегорії (зона 2). Показуються, коли
-- немає активної платної кампанії. UPDATE — щоб оновити рядок 1, якщо раніше
-- застосовано попередню версію блоку (INSERT IGNORE наявні рядки не змінює).
INSERT IGNORE INTO ad_zones (id, name, page_type) VALUES
(1, 'Сторінка категорії - верх', 'category'),
(2, 'Сторінка підкатегорії - верх', 'subcategory');

INSERT IGNORE INTO ad_campaigns (id, campaign_type, advertiser_name, status, start_date, notes) VALUES
(1, 'internal', 'AI LAB HUB', 'active', CURDATE(), 'Внутрішнє промо: Еля та підтримка проєкту');

INSERT IGNORE INTO ads (id, campaign_id, zone_id, image_url, target_url, headline, subtext, category_id, subcategory_id, status) VALUES
(1, 1, 1, '/assets/images/ads/eli-promo.svg', 'eli.php', 'Не знаєте, який AI-інструмент обрати?', 'Спитайте Елю — вона підбере інструмент під вашу задачу та бюджет', NULL, NULL, 'active'),
(2, 1, 1, '/assets/images/ads/support-promo.svg', 'donate.php', 'Підтримайте AI LAB HUB', 'Проєкт розвивається завдяки вам — кожен внесок наближає нові інструменти', NULL, NULL, 'active'),
(3, 1, 2, '/assets/images/ads/eli-promo.svg', 'eli.php', 'Не знаєте, який AI-інструмент обрати?', 'Спитайте Елю — вона підбере інструмент під вашу задачу та бюджет', NULL, NULL, 'active'),
(4, 1, 2, '/assets/images/ads/support-promo.svg', 'donate.php', 'Підтримайте AI LAB HUB', 'Проєкт розвивається завдяки вам — кожен внесок наближає нові інструменти', NULL, NULL, 'active');

UPDATE ads SET image_url = '/assets/images/ads/eli-promo.svg', target_url = 'eli.php' WHERE id = 1 AND image_url LIKE '%marketplace-promo%';
UPDATE ad_campaigns SET notes = 'Внутрішнє промо: Еля та підтримка проєкту' WHERE id = 1 AND notes LIKE 'Промо Marketplace%';

-- Оголошення, створені до появи headline/subtext: заповнюємо текстом
-- (зображення тепер лише фон без тексту).
UPDATE ads SET headline = 'Не знаєте, який AI-інструмент обрати?', subtext = 'Спитайте Елю — вона підбере інструмент під вашу задачу та бюджет'
 WHERE id IN (1, 3) AND headline IS NULL;
UPDATE ads SET headline = 'Підтримайте AI LAB HUB', subtext = 'Проєкт розвивається завдяки вам — кожен внесок наближає нові інструменти'
 WHERE id IN (2, 4) AND headline IS NULL;

-- Готовий EN-переклад (вручну, source='manual' — без витрат Google Translate).
INSERT IGNORE INTO ad_translations (ad_id, field_name, lang, translated_text, source) VALUES
(1, 'headline', 'en', 'Not sure which AI tool to choose?', 'manual'),
(1, 'subtext',  'en', 'Ask Eli — she will find a tool that fits your task and budget', 'manual'),
(2, 'headline', 'en', 'Support AI LAB HUB', 'manual'),
(2, 'subtext',  'en', 'The project grows thanks to you — every contribution brings new tools closer', 'manual'),
(3, 'headline', 'en', 'Not sure which AI tool to choose?', 'manual'),
(3, 'subtext',  'en', 'Ask Eli — she will find a tool that fits your task and budget', 'manual'),
(4, 'headline', 'en', 'Support AI LAB HUB', 'manual'),
(4, 'subtext',  'en', 'The project grows thanks to you — every contribution brings new tools closer', 'manual');

-- EN-підпис посилання «реклама» у меню CRM кабінету (admin).
INSERT IGNORE INTO ui_translations (key_name, lang, translated_text, source) VALUES
('account_crm_ads_link', 'en', 'ads', 'manual');
