-- =====================================================================
-- AI LAB HUB — міграція 2026-10-23: власна реклама платформи (картки без відео, варіанти A/B, умови показу).
--
--   ad_creatives  + creative_type ('video' | 'card'), card_layout ('wide' | 'compact'), тексти EN,
--                   запасний опис без дати (UA/EN), власний текст кнопки (UA/EN), ref_code (напр. house-A1).
--   ad_campaigns  + house_key (засіяні кампанії: house_A, house_B), house_rules (JSON умов показу),
--                   acquisition_ref (джерело першої кампанії рекламодавця).
--   mp_listings   + acquisition_ref (джерело першого оголошення).
--   ad_settings   ad_allow_card_creatives = 0 (рекламодавцям картки вимкнені), house_frequency_cap = 2.
--   Засів: кампанія A «Рекламуйтесь у нас» (2 варіанти, усі місця) і B «Marketplace: оголошення»
--          (2 варіанти, лише місця сайту й блогу, requires_setting marketplace_public). ОБИДВІ — paused:
--          адмін активує їх в адмінці після перевірки. Реклама загалом — лише за ad_settings.enabled.
--
-- Лише умовні ALTER (information_schema + PREPARE) / INSERT IGNORE / INSERT … WHERE NOT EXISTS.
-- Без DROP / DELETE / TRUNCATE. Повторний запуск безпечний (засів не дублюється — за house_key).
-- Потрібні попередні міграції реклами (2026-10-11, 2026-10-18, 2026-10-20).
-- =====================================================================

SET NAMES utf8mb4;

-- 1) Креативи: картка ----------------------------------------------------
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_creatives' AND COLUMN_NAME='creative_type')=0,
  'ALTER TABLE ad_creatives
     ADD COLUMN creative_type VARCHAR(10) NOT NULL DEFAULT ''video'' AFTER campaign_id,
     ADD COLUMN card_layout VARCHAR(10) NULL AFTER creative_type,
     ADD COLUMN title_en VARCHAR(60) NULL AFTER title,
     ADD COLUMN description_en VARCHAR(150) NULL AFTER description,
     ADD COLUMN description_fallback VARCHAR(150) NULL AFTER description_en,
     ADD COLUMN description_fallback_en VARCHAR(150) NULL AFTER description_fallback,
     ADD COLUMN cta_text VARCHAR(40) NULL AFTER cta_key,
     ADD COLUMN cta_text_en VARCHAR(40) NULL AFTER cta_text,
     ADD COLUMN ref_code VARCHAR(20) NULL AFTER cta_text_en', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- 2) Кампанії: власна реклама й джерело ----------------------------------
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='house_key')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN house_key VARCHAR(20) NULL, ADD COLUMN house_rules VARCHAR(500) NULL, ADD COLUMN acquisition_ref VARCHAR(20) NULL', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='mp_listings' AND COLUMN_NAME='acquisition_ref')=0,
  'ALTER TABLE mp_listings ADD COLUMN acquisition_ref VARCHAR(20) NULL', 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- 3) Налаштування ---------------------------------------------------------
INSERT IGNORE INTO ad_settings (setting_key, setting_value) VALUES
('ad_allow_card_creatives', '0'),
('house_frequency_cap', '2');

-- 4) Засів кампанії A «Рекламуйтесь у нас» (paused) -----------------------
INSERT INTO ad_campaigns (campaign_type, format, user_id, name, advertiser_name, status, start_date, currency, house_key, house_rules, notes)
SELECT 'internal', 'video', NULL, 'Рекламуйтесь у нас', 'AI LAB HUB', 'paused', CURDATE(), 'USD', 'house_A',
       '{"hide_if_campaign":1,"exclude_pages":["advertise","cabinet"]}',
       'Власна реклама (засів 2026-10-23). Платні кампанії мають пріоритет.'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM ad_campaigns WHERE house_key = 'house_A');
SET @ca := (SELECT id FROM ad_campaigns WHERE house_key = 'house_A' ORDER BY id LIMIT 1);

INSERT INTO ad_creatives (campaign_id, creative_type, card_layout, title, title_en, description, description_en, cta_key, cta_text, cta_text_en, ref_code, destination_url, status)
SELECT @ca, 'card', 'wide', 'Ваша реклама на AI LAB HUB', 'Advertise on AI LAB HUB',
       'Покажіть своє відео чи оголошення на сайті, у блозі й маркетплейсі. Самі обираєте місця, мову й бюджет.',
       'Show your video or listing across the site, the blog and the marketplace. You choose placements, language and budget.',
       'learn_more', 'Розмістити рекламу', 'Place an ad', 'house-A1', '/advertise.php?ref=house-A1', 'approved'
FROM DUAL WHERE @ca IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ad_creatives WHERE ref_code = 'house-A1');

INSERT INTO ad_creatives (campaign_id, creative_type, card_layout, title, title_en, description, description_en, cta_key, cta_text, cta_text_en, ref_code, destination_url, status)
SELECT @ca, 'card', 'wide', 'Потрібні клієнти? Покажіть себе тут', 'Need customers? Show up here',
       'Реклама на сайті, у блозі й маркетплейсі: створіть кампанію за кілька кроків, самі налаштуйте показ і слідкуйте за результатами.',
       'Ads on the site, the blog and the marketplace: create a campaign in a few steps, set up your targeting and track the results.',
       'learn_more', 'Створити кампанію', 'Create a campaign', 'house-A2', '/advertise.php?ref=house-A2', 'approved'
FROM DUAL WHERE @ca IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ad_creatives WHERE ref_code = 'house-A2');

INSERT INTO ad_targets (campaign_id, placement, category_id, subcategory_id, mp_section, language, device, unit_price)
SELECT @ca, p.pl, NULL, NULL, NULL, NULL, NULL, NULL
FROM (SELECT 'category_page' AS pl UNION ALL SELECT 'subcategory_list' UNION ALL SELECT 'search_results' UNION ALL SELECT 'product_page'
      UNION ALL SELECT 'blog_list' UNION ALL SELECT 'blog_article' UNION ALL SELECT 'marketplace_home' UNION ALL SELECT 'marketplace_feed'
      UNION ALL SELECT 'marketplace_category' UNION ALL SELECT 'marketplace_search' UNION ALL SELECT 'marketplace_listing_page') p
WHERE @ca IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ad_targets t WHERE t.campaign_id = @ca);

-- 5) Засів кампанії B «Marketplace: оголошення» (paused) -------------------
INSERT INTO ad_campaigns (campaign_type, format, user_id, name, advertiser_name, status, start_date, currency, house_key, house_rules, notes)
SELECT 'internal', 'video', NULL, 'Marketplace: оголошення', 'AI LAB HUB', 'paused', CURDATE(), 'USD', 'house_B',
       '{"hide_if_listing":1,"requires_setting":"marketplace_public","site_only":1}',
       'Власна реклама (засів 2026-10-23). Показується лише на сторінках сайту й блогу, коли marketplace_public = 1.'
FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM ad_campaigns WHERE house_key = 'house_B');
SET @cb := (SELECT id FROM ad_campaigns WHERE house_key = 'house_B' ORDER BY id LIMIT 1);

INSERT INTO ad_creatives (campaign_id, creative_type, card_layout, title, title_en, description, description_en, description_fallback, description_fallback_en,
                          cta_key, cta_text, cta_text_en, ref_code, destination_url, status)
SELECT @cb, 'card', 'wide', 'Marketplace: розмістіть оголошення', 'Marketplace: post your listing',
       'Вакансії, курси, послуги й цифрові матеріали. Розміщення безкоштовне до {free_until}, оголошення проходить швидку модерацію.',
       'Jobs, courses, services and digital assets. Free to post until {free_until}; every listing goes through a quick review.',
       'Вакансії, курси, послуги й цифрові матеріали. Розміщення безкоштовне на старті, оголошення проходить швидку модерацію.',
       'Jobs, courses, services and digital assets. Free to post at launch; every listing goes through a quick review.',
       'learn_more', 'Розмістити оголошення', 'Post a listing', 'house-B1', '/marketplace.php?ref=house-B1', 'approved'
FROM DUAL WHERE @cb IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ad_creatives WHERE ref_code = 'house-B1');

INSERT INTO ad_creatives (campaign_id, creative_type, card_layout, title, title_en, description, description_en, description_fallback, description_fallback_en,
                          cta_key, cta_text, cta_text_en, ref_code, destination_url, status)
SELECT @cb, 'card', 'wide', 'Є що запропонувати? Опублікуйте оголошення', 'Got something to offer? Post a listing',
       'Створіть оголошення в маркетплейсі за кілька хвилин. Розміщення безкоштовне до {free_until}.',
       'Create a marketplace listing in a few minutes. Free to post until {free_until}.',
       'Створіть оголошення в маркетплейсі за кілька хвилин. Розміщення безкоштовне на старті.',
       'Create a marketplace listing in a few minutes. Free to post at launch.',
       'learn_more', 'Створити оголошення', 'Create a listing', 'house-B2', '/marketplace.php?ref=house-B2', 'approved'
FROM DUAL WHERE @cb IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ad_creatives WHERE ref_code = 'house-B2');

INSERT INTO ad_targets (campaign_id, placement, category_id, subcategory_id, mp_section, language, device, unit_price)
SELECT @cb, p.pl, NULL, NULL, NULL, NULL, NULL, NULL
FROM (SELECT 'category_page' AS pl UNION ALL SELECT 'subcategory_list' UNION ALL SELECT 'search_results' UNION ALL SELECT 'product_page'
      UNION ALL SELECT 'blog_list' UNION ALL SELECT 'blog_article') p
WHERE @cb IS NOT NULL AND NOT EXISTS (SELECT 1 FROM ad_targets t WHERE t.campaign_id = @cb);
