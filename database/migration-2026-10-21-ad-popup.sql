SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — міграція: реклама спливаючим вікном 2026-10-21 (замінює нативні картки в списках)
--
-- Вставити ЯК Є у phpMyAdmin. Безпечно повторювати: CREATE TABLE IF NOT EXISTS, колонки й
-- значення ENUM додаються лише якщо їх ще немає (information_schema + PREPARE), INSERT IGNORE /
-- ON DUPLICATE KEY UPDATE, UPDATE текстів. Жодних DROP / TRUNCATE. Потребує попередньої
-- міграції 2026-10-21 (нативні картки) — вона вже на хостингу.
-- =====================================================================

-- ---------------------------------------------------------------------
-- Етап 1. Місце 'popup' і затримка «Пропустити».
-- ---------------------------------------------------------------------

-- Значення 'popup' у ENUM місць (таргети, сирі кліки, денна статистика, прайс).
SET @t := 'ad_targets';
SET @ct := (SELECT COLUMN_TYPE FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @t AND COLUMN_NAME = 'placement');
SET @s := IF(@ct IS NULL OR @ct LIKE '%''popup''%', 'DO 0', CONCAT('ALTER TABLE ', @t, ' MODIFY placement ', REPLACE(@ct, ')', ',''popup'')'), ' NOT NULL'));
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;
SET @t := 'ad_events';
SET @ct := (SELECT COLUMN_TYPE FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @t AND COLUMN_NAME = 'placement');
SET @s := IF(@ct IS NULL OR @ct LIKE '%''popup''%', 'DO 0', CONCAT('ALTER TABLE ', @t, ' MODIFY placement ', REPLACE(@ct, ')', ',''popup'')'), ' NOT NULL'));
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;
SET @t := 'ad_stats_daily';
SET @ct := (SELECT COLUMN_TYPE FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @t AND COLUMN_NAME = 'placement');
SET @s := IF(@ct IS NULL OR @ct LIKE '%''popup''%', 'DO 0', CONCAT('ALTER TABLE ', @t, ' MODIFY placement ', REPLACE(@ct, ')', ',''popup'')'), ' NOT NULL'));
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;
SET @t := 'ad_rate_card';
SET @ct := (SELECT COLUMN_TYPE FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = @t AND COLUMN_NAME = 'placement');
SET @s := IF(@ct IS NULL OR @ct LIKE '%''popup''%', 'DO 0', CONCAT('ALTER TABLE ', @t, ' MODIFY placement ', REPLACE(@ct, ')', ',''popup'')'), ' NOT NULL'));
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- Група 'popup' для місця (ENUM ad_placements.group_key).
SET @ct := (SELECT COLUMN_TYPE FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'ad_placements' AND COLUMN_NAME = 'group_key');
SET @s := IF(@ct IS NULL OR @ct NOT LIKE 'enum%' OR @ct LIKE '%''popup''%', 'DO 0', CONCAT('ALTER TABLE ad_placements MODIFY group_key ', REPLACE(@ct, ')', ',''popup'')'), ' NOT NULL'));
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- Місце «Спливаюче вікно»; місця-списки вимкнено (картки зі списків прибрано).
INSERT INTO ad_placements (placement_key, title_uk, title_en, description_uk, description_en, group_key, enabled, slots_per_page, position_rule, requires_setting, sort_order)
VALUES ('popup', 'Спливаюче вікно', 'Pop-up window',
        'Вікно поверх сторінки з кнопкою «Пропустити» через 10–15 с; одному відвідувачу не частіше ніж раз на 10 хвилин, не на першій сторінці візиту й не раніше ніж через 30 с.',
        'A window over the page with a “Skip” button after 10–15 s; no more than once every 10 minutes per visitor, never on the first page of a visit and not earlier than 30 s in.',
        'popup', 1, 1, '{"popup":true}', NULL, 5)
ON DUPLICATE KEY UPDATE title_uk = VALUES(title_uk), title_en = VALUES(title_en), description_uk = VALUES(description_uk), description_en = VALUES(description_en), group_key = VALUES(group_key);
UPDATE ad_placements SET enabled = 0
 WHERE placement_key IN ('category_page', 'subcategory_list', 'search_results', 'marketplace_feed', 'marketplace_search', 'marketplace_category');

-- Зона «Спливаюча реклама» (довідково, page_type global; відбір іде через місце 'popup').
INSERT INTO ad_zones (name, page_type)
SELECT 'Спливаюча реклама', 'global' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM ad_zones WHERE name = 'Спливаюча реклама');

-- Затримка «Пропустити» для оголошення: 10–15 с, NULL — за замовчуванням (ad_popup_skip_delay_default).
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'ad_creatives' AND COLUMN_NAME = 'skip_delay_seconds') = 0,
  'ALTER TABLE ad_creatives ADD COLUMN skip_delay_seconds TINYINT UNSIGNED NULL', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- ---------------------------------------------------------------------
-- Етапи 2–3. Частота й де не показувати (налаштування; адмін може змінити).
-- ---------------------------------------------------------------------
INSERT IGNORE INTO ad_settings (setting_key, setting_value) VALUES
('ad_popup_min_interval_seconds', '600'),
('ad_popup_visit_delay_seconds', '30'),
('ad_popup_skip_delay_default', '12'),
('ad_popup_excluded_pages', 'terms.php\nprivacy.php\ncontacts.php\nlogin.php\nlogin-via-token.php\nregister.php\nforgot-password.php\ndonate.php\naccount.php\ncrm-*\nadmin-*\napply-*\n*-edit*\n*-post.php\nmp-add-offer.php\nmarketplace-my.php\nmp-my.php\nmp-moderation.php\nmp-list.php\nsaved.php\nunsubscribe.php\nadvertise.php\nadvertise-guide.php\npromo-rules.php');

-- ---------------------------------------------------------------------
-- Етап 5. Пропуски в статистиці.
-- ---------------------------------------------------------------------
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'ad_stats_daily' AND COLUMN_NAME = 'skips') = 0,
  'ALTER TABLE ad_stats_daily ADD COLUMN skips INT UNSIGNED NOT NULL DEFAULT 0 AFTER clicks', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'ad_zone_stats_daily' AND COLUMN_NAME = 'skips') = 0,
  'ALTER TABLE ad_zone_stats_daily ADD COLUMN skips INT UNSIGNED NOT NULL DEFAULT 0 AFTER clicks', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- ---------------------------------------------------------------------
-- Етап 6. Власна реклама A і B — у спливаючому вікні (таргет 'popup', усі категорії).
-- ---------------------------------------------------------------------
INSERT INTO ad_targets (campaign_id, placement)
SELECT c.id, 'popup' FROM ad_campaigns c
 WHERE c.house_key IN ('house_A', 'house_B')
   AND NOT EXISTS (SELECT 1 FROM ad_targets t WHERE t.campaign_id = c.id AND t.placement = 'popup');

-- ---------------------------------------------------------------------
-- Етап 6. Тексти про рекламу — під спливаюче вікно.
-- ---------------------------------------------------------------------
INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('legal_terms_ads_format', 'en', 'The platform shows advertising labelled “Ad”. It appears in a pop-up window over the page: an image or a short video that starts without sound (visitors turn the sound on themselves). The “Skip” button becomes available after 10–15 seconds. Each visitor sees the window no more than once every 10 minutes; ads from different advertisers take turns.', 'manual'),
('legal_privacy_ads_counts', 'en', 'To account for advertising we count impressions, video views, clicks and skips. An impression is counted when the ad window has been visible for at least 1 second. Impressions, views and skips are stored only as anonymised daily counters (how many times each ad was shown), not linked to any visitor. Clicks are stored with an anonymous session identifier (a hash from which neither the IP address nor the person can be recovered) for up to 30 days to protect against click fraud; after that only aggregated statistics remain. Known bots are not counted.', 'manual'),
('legal_privacy_ads_session', 'en', 'To show the ad window no more than once every 10 minutes and not repeat the same ad, the site stores the time the window was closed in your browser’s localStorage, and in the session (on the server, only for the duration of the visit) the start time of the visit, the number of pages viewed, the time of the last ad and a short list of recently shown ads. This is not personal data and it is not used for profiling; you can delete the localStorage entry in your browser settings.', 'manual'),
('about_ads_text', 'en', 'The site shows advertising: it is always labelled “Ad” and appears in a pop-up window — an image or a short video without sound, with a “Skip” button after 10–15 seconds, no more than once every 10 minutes. Ads from different advertisers take turns. You can place your own ad yourself in your account — see %s for details.', 'manual'),
('ad_popup_skip_in', 'en', 'Skip in %d s', 'manual'),
('ad_popup_skip', 'en', 'Skip', 'manual'),
('ad_popup_skip_ready', 'en', 'You can skip the ad now', 'manual'),
('ad_popup_dialog', 'en', 'Advertisement', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';

UPDATE ad_creatives SET description = 'Ваше зображення чи коротке відео — у вікні поверх сторінки сайту, блогу й Marketplace. Самі обираєте мову й бюджет.', description_en = 'Your image or short video in a window over the pages of the site, blog and Marketplace. You choose language and budget.' WHERE ref_code = 'house-A1';
UPDATE ad_creatives SET description = 'Реклама у спливаючому вікні: зображення або відео без звуку, «Пропустити» через 10–15 с. Кампанія — за кілька кроків.', description_en = 'Ads in a pop-up window: an image or a muted video, “Skip” after 10–15 s. Set up a campaign in a few steps.' WHERE ref_code = 'house-A2';

SET @lid := (SELECT listing_id FROM mp_listing_translations
             WHERE lang = 'uk' AND title IN ('Розміщення реклами AI-продуктів на AI LAB HUB', 'Розміщення реклами на AI LAB HUB')
             ORDER BY listing_id LIMIT 1);
UPDATE mp_listing_translations SET title = 'Розміщення реклами на AI LAB HUB', short_desc = 'Реклама на AI LAB HUB у спливаючому вікні: зображення або коротке відео з кнопкою «Пропустити» через 10–15 с, не частіше ніж раз на 10 хвилин для відвідувача. Кампанію ви створюєте й оплачуєте самостійно в кабінеті.', full_desc = 'Реклама на AI LAB HUB показується у спливаючому вікні поверх сторінки — одне оголошення за раз, з позначкою «Реклама».

Формати:
— зображення (JPG, PNG або WebP, 16:9);
— коротке відео до 15 секунд (MP4 або WebM) чи посилання на YouTube. Відео стартує саме без звуку; звук глядач вмикає сам.

Кнопка «Пропустити» стає доступною через 10–15 секунд. Одному відвідувачу вікно показується не частіше ніж раз на 10 хвилин, не на першій сторінці візиту й не раніше ніж через 30 секунд. Оголошення різних рекламодавців чергуються. Заголовок і підпис зберігаються окремо від зображення й перекладаються мовою відвідувача.

Як розмістити:
1. Зареєструйтеся й відкрийте в кабінеті розділ «Реклама».
2. Створіть кампанію: формат і тексти, мова, пристрій, бюджет і дати.
3. Поповніть баланс; модератор перевіряє оголошення й сторінку, куди веде посилання.
4. Після схвалення кампанія стартує в обрану дату; статистика показів, кліків і пропусків — у кабінеті.

Ціни й вимоги — на сторінці «Реклама на сайті» (оплата за покази або кліки з балансу, без абонплати). Приймаємо рекламу будь-якої тематики, якщо вона не порушує законодавство й правила реклами. Конкретної кількості показів чи кліків ми не гарантуємо.'
 WHERE listing_id = @lid AND lang = 'uk';
INSERT INTO mp_listing_translations (listing_id, lang, title, short_desc, full_desc, is_auto)
SELECT @lid, 'en', 'Advertising on AI LAB HUB', 'Advertising on AI LAB HUB in a pop-up window: an image or a short video with a “Skip” button after 10–15 s, no more than once every 10 minutes per visitor. You create and pay for the campaign yourself in your account.', 'Ads on AI LAB HUB are shown in a pop-up window over the page — one ad at a time, labelled “Ad”.

Formats:
— an image (JPG, PNG or WebP, 16:9);
— a short video up to 15 seconds (MP4 or WebM) or a YouTube link. The video starts by itself without sound; viewers turn the sound on themselves.

The “Skip” button becomes available after 10–15 seconds. Each visitor sees the window no more than once every 10 minutes, never on the first page of a visit and not earlier than 30 seconds in. Ads from different advertisers take turns. The title and description are stored separately from the image and are translated into the visitor''s language.

How to place an ad:
1. Sign up and open the “Advertising” section in your account.
2. Create a campaign: format and texts, language, device, budget and dates.
3. Top up your balance; a moderator checks the ad and the page it links to.
4. Once approved, the campaign starts on the chosen date; impression, click and skip statistics are in your account.

Prices and specs are on the “Advertise on the site” page (you pay for impressions or clicks from a prepaid balance, no subscription). We accept ads on any topic as long as they comply with the law and the advertising rules. We do not guarantee any specific number of impressions or clicks.', 0 FROM DUAL WHERE @lid IS NOT NULL
ON DUPLICATE KEY UPDATE title = VALUES(title), short_desc = VALUES(short_desc), full_desc = VALUES(full_desc), is_auto = 0;
UPDATE mp_listings SET price_type = 'none' WHERE id = @lid AND price_type = 'negotiable';
