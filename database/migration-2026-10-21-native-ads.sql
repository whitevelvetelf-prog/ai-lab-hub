SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — міграція: нативна реклама в списках 2026-10-21
--
-- Вставити ЯК Є у phpMyAdmin (вкладка SQL або «Импорт»). Безпечно повторювати:
-- лише CREATE TABLE IF NOT EXISTS, додавання колонок/індексів через
-- information_schema + PREPARE (працює і на MySQL, і на MariaDB), UPDATE
-- налаштувань та INSERT ... ON DUPLICATE KEY UPDATE. Жодних DROP / TRUNCATE.
-- =====================================================================

-- ---------------------------------------------------------------------
-- Етап 1. Нативні картки в списках.
-- ---------------------------------------------------------------------

-- Переклад заголовка й підпису креативів (система перекладу сайту,
-- app/translation-cache.php). ad_translations прив'язана зовнішнім ключем
-- до старої таблиці ads, тож для ad_creatives — окрема таблиця тієї ж будови.
CREATE TABLE IF NOT EXISTS ad_creative_translations (
    id              INT UNSIGNED NOT NULL AUTO_INCREMENT,
    creative_id     INT NOT NULL,
    field_name      VARCHAR(50) NOT NULL,
    lang            VARCHAR(5) NOT NULL,
    translated_text MEDIUMTEXT NOT NULL,
    source          ENUM('auto', 'manual') NOT NULL DEFAULT 'auto',
    updated_at      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uniq_creative_field_lang (creative_id, field_name, lang),
    CONSTRAINT fk_ad_creative_translations_creative
        FOREIGN KEY (creative_id) REFERENCES ad_creatives (id)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Місця-списки: нативна картка на 3-й позиції, далі кожні 8 елементів, до 2 на сторінку
-- (app/ad-card.php → promo_placement_positions). Розділи маркетплейсу — теж у списку,
-- а не окремим блоком над ним.
UPDATE ad_placements SET position_rule = '{"position":3,"every":8}', slots_per_page = 2,
    description_uk = 'Нативна картка в сітці підкатегорій: 3-тя позиція, далі кожні 8 карток, до 2 на сторінку.',
    description_en = 'A native card in the subcategory grid: 3rd position, then every 8 cards, up to 2 per page.'
 WHERE placement_key = 'category_page';
UPDATE ad_placements SET position_rule = '{"position":3,"every":8}', slots_per_page = 2,
    description_uk = 'Нативна картка серед продуктів підкатегорії: 3-тя позиція, далі кожні 8 карток, до 2 на сторінку.',
    description_en = 'A native card among the subcategory products: 3rd position, then every 8 cards, up to 2 per page.'
 WHERE placement_key = 'subcategory_list';
UPDATE ad_placements SET position_rule = '{"position":3,"every":8}', slots_per_page = 2,
    description_uk = 'Нативна картка в результатах пошуку й добірках каталогу: 3-тя позиція, далі кожні 8 карток, до 2 на сторінку.',
    description_en = 'A native card in search results and catalog collections: 3rd position, then every 8 cards, up to 2 per page.'
 WHERE placement_key = 'search_results';
UPDATE ad_placements SET position_rule = '{"position":3,"every":8}', slots_per_page = 2,
    description_uk = 'Нативна картка в стрічці оголошень: 3-тя позиція, далі кожні 8 карток, до 2 на сторінку.',
    description_en = 'A native card in the listings feed: 3rd position, then every 8 cards, up to 2 per page.'
 WHERE placement_key = 'marketplace_feed';
UPDATE ad_placements SET position_rule = '{"position":3,"every":8}', slots_per_page = 2,
    description_uk = 'Нативна картка в результатах пошуку й фільтрів маркетплейсу: 3-тя позиція, далі кожні 8 карток, до 2 на сторінку.',
    description_en = 'A native card in marketplace search and filter results: 3rd position, then every 8 cards, up to 2 per page.'
 WHERE placement_key = 'marketplace_search';
UPDATE ad_placements SET position_rule = '{"position":3,"every":8}', slots_per_page = 2,
    description_uk = 'Нативна картка в списках розділів (вакансії, курси, послуги, оголошення, готові рішення): 3-тя позиція, далі кожні 8 карток, до 2 на сторінку.',
    description_en = 'A native card in section lists (jobs, courses, services, listings, ready-made solutions): 3rd position, then every 8 cards, up to 2 per page.'
 WHERE placement_key = 'marketplace_category';

-- ---------------------------------------------------------------------
-- Етап 2. Зображення й короткі відео.
-- ---------------------------------------------------------------------

-- Тип медіа креативу — наявна колонка ad_creatives.creative_type (VARCHAR):
-- 'video' (відео: video_type upload/youtube, video_path, video_url, poster_path),
-- 'image' (зображення в poster_path, без відео), 'card' (власна реклама без медіа).
-- Вага для зваженого вибору серед платних (на старті всі = 1).
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'ad_creatives' AND COLUMN_NAME = 'weight') = 0,
  'ALTER TABLE ad_creatives ADD COLUMN weight INT NOT NULL DEFAULT 1 AFTER creative_type', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- Короткі ролики: до 15 с і до 5 МБ (перевірка при завантаженні, app/promo-advertiser.php).
INSERT INTO ad_settings (setting_key, setting_value) VALUES ('max_video_sec', '15'), ('max_video_mb', '5')
  ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value);

-- ---------------------------------------------------------------------
-- Етап 4. Масштаб: індекси для відбору й агрегати статистики.
-- ---------------------------------------------------------------------

-- Індекси (додаються лише якщо їх ще немає).
SET @s := IF((SELECT COUNT(*) FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'ad_campaigns' AND INDEX_NAME = 'idx_ad_campaigns_pick') = 0,
  'ALTER TABLE ad_campaigns ADD INDEX idx_ad_campaigns_pick (status, campaign_type, start_date, end_date)', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'ads' AND INDEX_NAME = 'idx_ads_pick') = 0,
  'ALTER TABLE ads ADD INDEX idx_ads_pick (status, zone_id, category_id, subcategory_id)', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'ad_creatives' AND INDEX_NAME = 'idx_ad_creatives_campaign_status') = 0,
  'ALTER TABLE ad_creatives ADD INDEX idx_ad_creatives_campaign_status (campaign_id, status)', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.STATISTICS WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'ad_targets' AND INDEX_NAME = 'idx_ad_targets_campaign_placement') = 0,
  'ALTER TABLE ad_targets ADD INDEX idx_ad_targets_campaign_placement (campaign_id, placement, category_id, subcategory_id)', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- Агрегати старих банерів зон (ads): ad_stats_daily вже зайнята статистикою promo-системи
-- (день × кампанія × креатив × місце, з витратами), тож для ads — окрема таблиця тієї ж ідеї.
-- Сирі покази в ad_impressions більше не пишуться; кліки, як і раніше, — в ad_clicks.
CREATE TABLE IF NOT EXISTS ad_zone_stats_daily (
    ad_id       INT NOT NULL,
    stat_date   DATE NOT NULL,
    impressions INT UNSIGNED NOT NULL DEFAULT 0,
    clicks      INT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (ad_id, stat_date)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- Перенесення наявних сирих даних агрегатом (повторний запуск нічого не подвоює — GREATEST).
INSERT INTO ad_zone_stats_daily (ad_id, stat_date, impressions)
SELECT ad_id, DATE(shown_at), COUNT(*) FROM ad_impressions GROUP BY ad_id, DATE(shown_at)
ON DUPLICATE KEY UPDATE impressions = GREATEST(impressions, VALUES(impressions));

INSERT INTO ad_zone_stats_daily (ad_id, stat_date, clicks)
SELECT ad_id, DATE(clicked_at), COUNT(*) FROM ad_clicks GROUP BY ad_id, DATE(clicked_at)
ON DUPLICATE KEY UPDATE clicks = GREATEST(clicks, VALUES(clicks));

-- ---------------------------------------------------------------------
-- Етап 5. Тексти про рекламу (новий формат).
-- ---------------------------------------------------------------------

-- «Умови використання» 3.3, «Політика конфіденційності» 3.3, «Про проєкт»: оригінал (UA) —
-- у коді (app/translations.php), ручний EN — тут (source = 'manual', автопереклад не затирає).
INSERT INTO ui_translations (key_name, lang, translated_text, source) VALUES
('legal_terms_ads_title', 'en', '3.3. Advertising and advertisers', 'manual'),
('legal_terms_ads_format', 'en', 'The platform shows advertising labelled “Ad”. Ads appear as native cards inside lists — in categories, subcategories, search results and the Marketplace (the advertiser chooses the placements) — and as separate blocks on product pages and in the blog. Accepted formats are images and short videos up to 15 seconds; videos start without sound and visitors turn the sound on themselves. Ads from different advertisers are shown in turn.', 'manual'),
('legal_terms_ads_rules', 'en', 'Advertising is governed by the %s, which form an integral part of these Terms for advertisers. The advertiser is solely responsible for the ad content and the page it leads to; the platform may reject or stop any ad that breaks the Rules.', 'manual'),
('legal_ads_rules_link', 'en', 'Advertising rules', 'manual'),
('legal_privacy_ads_title', 'en', '3.3. Ad measurement', 'manual'),
('legal_privacy_ads_counts', 'en', 'To account for advertising we count impressions, video views and clicks. An impression is counted when an ad card has been visible on the screen for at least 1 second. Impressions and views are stored only as anonymised daily counters (how many times each ad was shown), not linked to any visitor. Clicks are stored with an anonymous session identifier (a hash from which neither the IP address nor the person can be recovered) for up to 30 days to protect against click fraud; after that only aggregated statistics remain. Known bots are not counted.', 'manual'),
('legal_privacy_ads_session', 'en', 'To avoid showing the same ad over and over and to limit how often one ad is shown, the site keeps in your session (on the server, only for the duration of the visit) a short list of recently shown ads and their daily impression counters. This is not personal data and it is not used for profiling.', 'manual'),
('legal_privacy_ads_targeting', 'en', 'IP addresses are not stored in plain form. Advertisers only see aggregated statistics (numbers of impressions, views and clicks). There is no personal targeting: ads are selected only by site language, device type and page topic.', 'manual'),
('about_ads_text', 'en', 'The site shows advertising: it is always labelled “Ad” and appears as native cards in category, subcategory and Marketplace lists — images or short videos up to 15 seconds that start without sound. Ads from different advertisers take turns. You can place your own ad yourself in your account — see %s for details.', 'manual'),
('about_ads_link', 'en', '“Advertise on the site”', 'manual')
ON DUPLICATE KEY UPDATE translated_text = VALUES(translated_text), source = 'manual';

-- Власна реклама A («Рекламуйтесь у нас»): описи під новий формат (за ref_code, не за id).
UPDATE ad_creatives SET description = 'Картка з фото або коротким відео прямо в списках каталогу й Marketplace. Самі обираєте місця, мову й бюджет.', description_en = 'A card with an image or a short video right inside catalog and Marketplace lists. You choose placements, language and budget.' WHERE ref_code = 'house-A1';
UPDATE ad_creatives SET description = 'Нативна реклама в категоріях, підкатегоріях і Marketplace: зображення або відео до 15 с. Кампанія — за кілька кроків.', description_en = 'Native ads in categories, subcategories and the Marketplace: an image or a video up to 15 s. Set up a campaign in a few steps.' WHERE ref_code = 'house-A2';

-- Оголошення в Marketplace «Розміщення реклами …» (шукаємо за назвою — id на хостингу інший).
SET @lid := (SELECT listing_id FROM mp_listing_translations
             WHERE lang = 'uk' AND title IN ('Розміщення реклами AI-продуктів на AI LAB HUB', 'Розміщення реклами на AI LAB HUB')
             ORDER BY listing_id LIMIT 1);
UPDATE mp_listing_translations SET title = 'Розміщення реклами на AI LAB HUB', short_desc = 'Нативна реклама на AI LAB HUB: картка із зображенням або коротким відео (до 15 с) у списках категорій, підкатегорій і Marketplace. Кампанію ви створюєте й оплачуєте самостійно в кабінеті.', full_desc = 'Реклама на AI LAB HUB показується нативними картками прямо в списках — у категоріях, підкатегоріях, результатах пошуку й у Marketplace, а також окремими блоками на сторінках продуктів і в блозі. Місця показу ви обираєте самі.

Формати:
— зображення (JPG, PNG або WebP, 16:9);
— коротке відео до 15 секунд (MP4 або WebM) чи посилання на YouTube. Відео стартує саме без звуку, коли картка на екрані; звук глядач вмикає сам.

Заголовок і підпис оголошення зберігаються окремо від зображення й перекладаються мовою відвідувача. Кожне рекламне місце позначене написом «Реклама». Оголошення різних рекламодавців показуються по черзі, одне оголошення не повторюється на сторінці.

Як розмістити:
1. Зареєструйтеся й відкрийте в кабінеті розділ «Реклама».
2. Створіть кампанію: формат і тексти, місця показу, мова, пристрій, бюджет і дати.
3. Поповніть баланс; модератор перевіряє оголошення й сторінку, куди веде посилання.
4. Після схвалення кампанія стартує в обрану дату; статистика показів і кліків — у кабінеті.

Ціни й вимоги — на сторінці «Реклама на сайті» (оплата за покази або кліки з балансу, без абонплати). Приймаємо рекламу будь-якої тематики, якщо вона не порушує законодавство й правила реклами. Конкретної кількості показів чи кліків ми не гарантуємо.'
 WHERE listing_id = @lid AND lang = 'uk';
INSERT INTO mp_listing_translations (listing_id, lang, title, short_desc, full_desc, is_auto)
SELECT @lid, 'en', 'Advertising on AI LAB HUB', 'Native advertising on AI LAB HUB: a card with an image or a short video (up to 15 s) in category, subcategory and Marketplace lists. You create and pay for the campaign yourself in your account.', 'Ads on AI LAB HUB appear as native cards right inside the lists — in categories, subcategories, search results and the Marketplace — and as separate blocks on product pages and in the blog. You choose the placements yourself.

Formats:
— an image (JPG, PNG or WebP, 16:9);
— a short video up to 15 seconds (MP4 or WebM) or a YouTube link. The video starts by itself without sound when the card is on screen; viewers turn the sound on themselves.

The ad title and description are stored separately from the image and are translated into the visitor''s language. Every ad placement is labelled “Ad”. Ads from different advertisers are shown in turn; the same ad is not repeated on a page.

How to place an ad:
1. Sign up and open the “Advertising” section in your account.
2. Create a campaign: format and texts, placements, language, device, budget and dates.
3. Top up your balance; a moderator checks the ad and the page it links to.
4. Once approved, the campaign starts on the chosen date; impression and click statistics are in your account.

Prices and specs are on the “Advertise on the site” page (you pay for impressions or clicks from a prepaid balance, no subscription). We accept ads on any topic as long as they comply with the law and the advertising rules. We do not guarantee any specific number of impressions or clicks.', 0 FROM DUAL WHERE @lid IS NOT NULL
ON DUPLICATE KEY UPDATE title = VALUES(title), short_desc = VALUES(short_desc), full_desc = VALUES(full_desc), is_auto = 0;
-- Ціни тепер у прайсі кабінету — рядок «Ціна договірна» не показуємо.
UPDATE mp_listings SET price_type = 'none' WHERE id = @lid AND price_type = 'negotiable';
