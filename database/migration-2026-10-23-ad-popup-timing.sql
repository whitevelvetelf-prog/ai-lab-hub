-- =====================================================================
-- AI LAB HUB — міграція 2026-10-23: спливаюча реклама не раніше ніж через 5 хв на сайті,
-- «Пропустити» через 5 с; архів Play.ht (сервіс закрито, домен не працює).
--
--   * ad_settings: ad_popup_visit_delay_seconds = 300, ad_popup_skip_delay_default = 5.
--   * ad_creatives.skip_delay_seconds: власні затримки кампаній (10–15 за старими правилами) → NULL
--     (за замовчуванням, 5 с). Адмін може знову задати 5–15 у «Кампанії» → «Пропуск вікна».
--   * Опис місця popup (ad_placements) і EN-тексти правил реклами (ui_translations) — нові терміни.
--   * Play.ht: status = 'none' (зникає з каталогу, пошуку й Елі), is_archived = 1. Рядок не видаляється.
--
-- Лише UPDATE / INSERT … ON DUPLICATE KEY UPDATE; без DROP / TRUNCATE / DELETE. Повторний запуск безпечний.
-- Застосування: phpMyAdmin → БД → «Импорт» → цей файл → Вперёд (спершу резервна копія).
-- =====================================================================

SET NAMES utf8mb4;

INSERT INTO ad_settings (setting_key, setting_value) VALUES
('ad_popup_visit_delay_seconds', '300'),
('ad_popup_skip_delay_default', '5')
ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);

UPDATE ad_creatives SET skip_delay_seconds = NULL WHERE skip_delay_seconds IS NOT NULL;

UPDATE ad_placements
   SET description_uk = 'Вікно поверх сторінки з кнопкою «Пропустити» через 5 с; одному відвідувачу не частіше ніж раз на 10 хвилин, не на першій сторінці візиту й не раніше ніж через 5 хв на сайті.',
       description_en = 'A window over the page with a “Skip” button after 5 s; no more than once every 10 minutes per visitor, never on the first page of a visit and not earlier than 5 minutes into the visit.'
 WHERE placement_key = 'popup';

INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('legal_terms_ads_format', 'en', 'The platform shows advertising labelled “Ad”. It appears in a pop-up window over the page: an image or a short video that starts without sound (visitors turn the sound on themselves). The “Skip” button becomes available after 5 seconds. The window appears no earlier than 5 minutes into a visit, and each visitor sees it no more than once every 10 minutes; ads from different advertisers take turns.', 'manual'),
('about_ads_text', 'en', 'The site shows advertising: it is always labelled “Ad” and appears in a pop-up window — an image or a short video without sound, with a “Skip” button after 5 seconds, no earlier than 5 minutes into a visit and no more than once every 10 minutes. Ads from different advertisers take turns. You can place your own ad yourself in your account — see %s for details.', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = VALUES(source);

UPDATE products SET status = 'none', is_archived = 1
 WHERE status = 'published' AND (name = 'Play.ht' OR official_url LIKE '%play.ht%');
