-- =====================================================================
-- AI LAB HUB — increment 2026-10-20: реклама всередині маркетплейсу (1 міграція).
--   migration-2026-10-20-promo-marketplace-placements.sql — 5 місць маркетплейсу замість marketplace_listing,
--     ad_targets.mp_section, нові значення ENUM placement, page_views.page_type для маркетплейсу,
--     ad_settings.ad_allow_marketplace_preselect = 1.
-- Потрібні вже застосовані 2026-10-18 (місця показу) і 2026-10-19 (маркетплейс) — на проді є.
-- Безпечно для повторного запуску. Застосування: phpMyAdmin → gu621051_ailabhublive → «Импорт» → цей файл.
-- =====================================================================

-- >>> database/migration-2026-10-20-promo-marketplace-placements.sql
-- =====================================================================
-- AI LAB HUB — міграція 2026-10-20: місця показу реклами всередині маркетплейсу.
--
--   ad_placements            — 5 нових місць групи «Маркетплейс» замість marketplace_listing:
--                              marketplace_home, marketplace_feed, marketplace_category,
--                              marketplace_search, marketplace_listing_page. Залежать від
--                              site_settings.marketplace_public; БЕЗ ціни (адмін задає сам).
--                              Рядок marketplace_listing лишається в таблиці (код його ігнорує).
--   placement (ENUM)         — у ad_targets, ad_events, ad_stats_daily, ad_rate_card В КІНЕЦЬ
--                              дописуються нові значення; старі лишаються.
--   ad_targets.mp_section    — таргетинг за розділом маркетплейсу (NULL — усі розділи):
--                              board, board:<id категорії оголошень>, solutions, job, course, service.
--   marketplace_listing      → marketplace_feed: копії рядків ad_targets (без категорій каталогу —
--                              вони до маркетплейсу не застосовуються) і цін ad_rate_card.
--                              Старі рядки не видаляються; код і так зараховує старий ключ до
--                              marketplace_feed (PROMO_LEGACY_PLACEMENTS).
--   page_views.page_type     — + marketplace_home, marketplace_category, marketplace_search,
--                              marketplace_listing (ємність місць і прайс-калькулятор).
--   ad_settings              — ad_allow_marketplace_preselect = 1: місця маркетплейсу можна обрати
--                              ще до відкриття маркетплейсу (кошти до відкриття не списуються).
--
-- Лише CREATE / умовні ALTER (information_schema + PREPARE) / INSERT IGNORE /
-- INSERT … SELECT … WHERE NOT EXISTS. Жодних DROP / DELETE / TRUNCATE.
-- Повторний запуск безпечний (налаштування місць, змінені адміном, не перезаписуються).
-- Потрібна попередня міграція 2026-10-18-promo-placements.sql (таблиця ad_placements).
-- =====================================================================

SET NAMES utf8mb4;

-- 1) Нові місця ---------------------------------------------------------
INSERT IGNORE INTO ad_placements
    (placement_key, title_uk, title_en, description_uk, description_en, group_key, enabled, slots_per_page, position_rule, requires_setting, sort_order)
VALUES
    ('marketplace_home', 'Головна маркетплейсу', 'Marketplace home',
     'Один блок на головній сторінці маркетплейсу — над списком оголошень.', 'One block on the marketplace home page — above the list of listings.',
     'marketplace', 1, 1, '{"before":"list"}', 'marketplace_public', 70),
    ('marketplace_feed', 'Стрічка оголошень', 'Listings feed',
     'Рекламна картка на 4-й позиції в стрічці оголошень і далі не частіше ніж кожні 10 карток.', 'An ad card in 4th position in the listings feed, then no more often than every 10 cards.',
     'marketplace', 1, 1, '{"position":4,"every":10}', 'marketplace_public', 71),
    ('marketplace_category', 'Розділи маркетплейсу', 'Marketplace sections',
     'Один блок на початку списку в розділах: вакансії, курси, послуги, оголошення, готові рішення.', 'One block at the start of the list in sections: jobs, courses, services, listings, ready-made solutions.',
     'marketplace', 1, 1, '{"before":"list"}', 'marketplace_public', 72),
    ('marketplace_search', 'Пошук і фільтри маркетплейсу', 'Marketplace search and filters',
     'Рекламна картка на 4-й позиції в результатах пошуку й фільтрів маркетплейсу.', 'An ad card in 4th position in marketplace search and filter results.',
     'marketplace', 1, 1, '{"position":4}', 'marketplace_public', 73),
    ('marketplace_listing_page', 'Сторінка оголошення', 'Listing page',
     'Один блок під описом і нижче кнопки «Перейти» чи контактів — окремо від самого оголошення.', 'One block below the description and below the “Go” button or contacts — separate from the listing itself.',
     'marketplace', 1, 1, '{"after":"actions"}', 'marketplace_public', 74);

-- 2) Нові значення ENUM placement (дописуються в кінець) ----------------
SET @pl_enum := '''catalog_card'',''product_page'',''blog_inline'',''category_page'',''subcategory_list'',''search_results'',''blog_list'',''blog_article'',''marketplace_listing'',''marketplace_home'',''marketplace_feed'',''marketplace_category'',''marketplace_search'',''marketplace_listing_page''';

SET @s := IF((SELECT COLUMN_TYPE FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_targets' AND COLUMN_NAME='placement') NOT LIKE '%marketplace_listing_page%',
  CONCAT('ALTER TABLE ad_targets MODIFY placement ENUM(', @pl_enum, ') NOT NULL'), 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COLUMN_TYPE FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_events' AND COLUMN_NAME='placement') NOT LIKE '%marketplace_listing_page%',
  CONCAT('ALTER TABLE ad_events MODIFY placement ENUM(', @pl_enum, ') NOT NULL'), 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COLUMN_TYPE FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_stats_daily' AND COLUMN_NAME='placement') NOT LIKE '%marketplace_listing_page%',
  CONCAT('ALTER TABLE ad_stats_daily MODIFY placement ENUM(', @pl_enum, ') NOT NULL'), 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COLUMN_TYPE FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_rate_card' AND COLUMN_NAME='placement') NOT LIKE '%marketplace_listing_page%',
  CONCAT('ALTER TABLE ad_rate_card MODIFY placement ENUM(', @pl_enum, ') NOT NULL'), 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- 3) Розділ маркетплейсу в таргетингу -----------------------------------
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_targets' AND COLUMN_NAME='mp_section')=0,
  'ALTER TABLE ad_targets ADD COLUMN mp_section VARCHAR(32) NULL DEFAULT NULL AFTER subcategory_id','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- 4) marketplace_listing → marketplace_feed (копії, старі рядки лишаються) ---
INSERT INTO ad_targets (campaign_id, placement, category_id, subcategory_id, mp_section, language, device, unit_price)
SELECT t.campaign_id, 'marketplace_feed', NULL, NULL, NULL, t.language, t.device, MAX(t.unit_price)
FROM ad_targets t
WHERE t.placement = 'marketplace_listing'
  AND NOT EXISTS (
      SELECT 1 FROM (SELECT * FROM ad_targets) x
      WHERE x.campaign_id = t.campaign_id AND x.placement = 'marketplace_feed'
        AND x.language <=> t.language AND x.device <=> t.device
  )
GROUP BY t.campaign_id, t.language, t.device;

INSERT IGNORE INTO ad_rate_card (placement, pricing_model, price, currency, active)
SELECT 'marketplace_feed', r.pricing_model, r.price, r.currency, r.active
FROM ad_rate_card r WHERE r.placement = 'marketplace_listing';

-- 5) Типи сторінок маркетплейсу в аналітиці переглядів --------------------
SET @s := IF((SELECT COLUMN_TYPE FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='page_views' AND COLUMN_NAME='page_type') NOT LIKE '%marketplace_home%',
  'ALTER TABLE page_views MODIFY page_type ENUM(''product'',''article'',''category'',''home'',''other'',''marketplace_home'',''marketplace_category'',''marketplace_search'',''marketplace_listing'') NOT NULL','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- 6) Дозвіл обирати місця маркетплейсу до його відкриття ------------------
INSERT IGNORE INTO ad_settings (setting_key, setting_value) VALUES ('ad_allow_marketplace_preselect', '1');
