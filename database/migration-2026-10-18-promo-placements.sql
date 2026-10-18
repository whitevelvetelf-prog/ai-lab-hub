-- =====================================================================
-- AI LAB HUB — міграція 2026-10-18: місця показу реклами (ad_placements).
--
--   ad_placements           — список місць: назви й описи UA/EN, група (catalog / blog /
--                             marketplace), перемикач enabled, slots_per_page, правило позиції
--                             (JSON), залежність від налаштування (requires_setting).
--   placement (ENUM)        — у ad_targets, ad_events, ad_stats_daily, ad_rate_card В КІНЕЦЬ
--                             дописуються нові значення; старі (catalog_card, product_page,
--                             blog_inline) лишаються й далі працюють.
--   Наявні кампанії         — catalog_card → + subcategory_list і search_results,
--                             blog_inline → + blog_article (копії рядків ad_targets із тими самими
--                             категоріями, мовою, пристроєм і ціною). Старі рядки не видаляються.
--                             Показ не змінюється: ті самі сторінки, ті самі кампанії.
--   Прайс                   — ціни catalog_card копіюються в subcategory_list і search_results,
--                             blog_inline → blog_article. Нові місця (category_page, blog_list,
--                             marketplace_listing) БЕЗ ціни — адмін задає сам.
--   ad_campaigns.is_test    — тестова кампанія для адмін-перегляду місць (без обліку подій).
--   blog_post_categories    — категорії статей блогу, призначені в адмінці (додатково до тем
--                             у коді, BLOG_ARTICLE_TOPICS).
--
-- Лише CREATE TABLE IF NOT EXISTS / умовні ALTER (information_schema + PREPARE) /
-- INSERT IGNORE / INSERT … SELECT … WHERE NOT EXISTS. Жодних DROP / DELETE / TRUNCATE.
-- Повторний запуск безпечний (налаштування місць, змінені адміном, не перезаписуються).
-- Реклама лишається вимкненою, якщо була вимкнена (ad_settings.enabled не чіпаємо).
-- =====================================================================

SET NAMES utf8mb4;

-- 1) Список місць ------------------------------------------------------
CREATE TABLE IF NOT EXISTS ad_placements (
    placement_key    VARCHAR(32)  NOT NULL,
    title_uk         VARCHAR(120) NOT NULL,
    title_en         VARCHAR(120) NOT NULL,
    description_uk   VARCHAR(255) NOT NULL DEFAULT '',
    description_en   VARCHAR(255) NOT NULL DEFAULT '',
    group_key        ENUM('catalog', 'blog', 'marketplace') NOT NULL,
    enabled          TINYINT(1)   NOT NULL DEFAULT 1,
    slots_per_page   TINYINT UNSIGNED NOT NULL DEFAULT 1,
    position_rule    VARCHAR(255) NULL,
    requires_setting VARCHAR(64)  NULL,
    sort_order       SMALLINT     NOT NULL DEFAULT 0,
    updated_at       DATETIME     NULL,
    PRIMARY KEY (placement_key)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

INSERT IGNORE INTO ad_placements
    (placement_key, title_uk, title_en, description_uk, description_en, group_key, enabled, slots_per_page, position_rule, requires_setting, sort_order)
VALUES
    ('category_page', 'Сторінка категорії', 'Category page',
     'Один блок після вступу, перед сіткою підкатегорій.', 'One block after the intro, before the grid of subcategories.',
     'catalog', 1, 1, '{"after":"intro"}', NULL, 10),
    ('subcategory_list', 'Список продуктів підкатегорії', 'Subcategory product list',
     'Картка на 3-й позиції серед продуктів, одна на сторінку.', 'A card in 3rd position among the products, one per page.',
     'catalog', 1, 1, '{"position":3}', NULL, 20),
    ('search_results', 'Результати пошуку й добірки', 'Search results and collections',
     'Картка на 3-й позиції в результатах пошуку й добірках каталогу.', 'A card in 3rd position in search results and catalog collections.',
     'catalog', 1, 1, '{"position":3}', NULL, 30),
    ('product_page', 'Сторінка продукту', 'Product page',
     'Один блок під описом продукту.', 'One block below the product description.',
     'catalog', 1, 1, '{"after":"description"}', NULL, 40),
    ('blog_list', 'Список статей блогу', 'Blog article list',
     'Один блок після 3-ї статті у списку.', 'One block after the 3rd article in the list.',
     'blog', 1, 1, '{"after_item":3}', NULL, 50),
    ('blog_article', 'Усередині статті', 'Inside an article',
     'Один блок після першого розділу з достатньою кількістю тексту — не на початку й не в кінці.', 'One block after the first section with enough text — not at the very start or end.',
     'blog', 1, 1, '{"min_chars_before":600,"min_chars_after":400}', NULL, 60),
    ('marketplace_listing', 'Оголошення маркетплейсу', 'Marketplace listings',
     'Просунуте оголошення серед оголошень маркетплейсу.', 'A promoted listing among marketplace listings.',
     'marketplace', 0, 1, '{"position":3,"requires_feature":"featured_listings"}', 'marketplace_public', 70);

-- 2) Нові значення ENUM placement (дописуються в кінець) ----------------
SET @pl_enum := '''catalog_card'',''product_page'',''blog_inline'',''category_page'',''subcategory_list'',''search_results'',''blog_list'',''blog_article'',''marketplace_listing''';

SET @s := IF((SELECT COLUMN_TYPE FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_targets' AND COLUMN_NAME='placement') NOT LIKE '%marketplace_listing%',
  CONCAT('ALTER TABLE ad_targets MODIFY placement ENUM(', @pl_enum, ') NOT NULL'), 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COLUMN_TYPE FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_events' AND COLUMN_NAME='placement') NOT LIKE '%marketplace_listing%',
  CONCAT('ALTER TABLE ad_events MODIFY placement ENUM(', @pl_enum, ') NOT NULL'), 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COLUMN_TYPE FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_stats_daily' AND COLUMN_NAME='placement') NOT LIKE '%marketplace_listing%',
  CONCAT('ALTER TABLE ad_stats_daily MODIFY placement ENUM(', @pl_enum, ') NOT NULL'), 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

SET @s := IF((SELECT COLUMN_TYPE FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_rate_card' AND COLUMN_NAME='placement') NOT LIKE '%marketplace_listing%',
  CONCAT('ALTER TABLE ad_rate_card MODIFY placement ENUM(', @pl_enum, ') NOT NULL'), 'DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- 3) Наявні кампанії: нові місця з тими самими умовами -----------------
INSERT INTO ad_targets (campaign_id, placement, category_id, subcategory_id, language, device, unit_price)
SELECT t.campaign_id, m.new_pl, t.category_id, t.subcategory_id, t.language, t.device, t.unit_price
FROM ad_targets t
JOIN (SELECT 'catalog_card' AS old_pl, 'subcategory_list' AS new_pl
      UNION ALL SELECT 'catalog_card', 'search_results'
      UNION ALL SELECT 'blog_inline', 'blog_article') m ON m.old_pl = t.placement
WHERE NOT EXISTS (
    SELECT 1 FROM (SELECT * FROM ad_targets) x
    WHERE x.campaign_id = t.campaign_id AND x.placement = m.new_pl
      AND x.category_id <=> t.category_id AND x.subcategory_id <=> t.subcategory_id
      AND x.language <=> t.language AND x.device <=> t.device
);

-- 4) Прайс: наступники старих місць отримують ту саму ціну -------------
INSERT IGNORE INTO ad_rate_card (placement, pricing_model, price, currency, active)
SELECT m.new_pl, r.pricing_model, r.price, r.currency, r.active
FROM ad_rate_card r
JOIN (SELECT 'catalog_card' AS old_pl, 'subcategory_list' AS new_pl
      UNION ALL SELECT 'catalog_card', 'search_results'
      UNION ALL SELECT 'blog_inline', 'blog_article') m ON m.old_pl = r.placement;

-- 5) Тестова кампанія для адмін-перегляду ------------------------------
SET @s := IF((SELECT COUNT(*) FROM information_schema.COLUMNS WHERE TABLE_SCHEMA=DATABASE() AND TABLE_NAME='ad_campaigns' AND COLUMN_NAME='is_test')=0,
  'ALTER TABLE ad_campaigns ADD COLUMN is_test TINYINT(1) NOT NULL DEFAULT 0','DO 0');
PREPARE s FROM @s; EXECUTE s; DEALLOCATE PREPARE s;

-- 6) Категорії статей блогу (призначені в адмінці) ---------------------
--    subcategory_id = 0 — уся категорія.
CREATE TABLE IF NOT EXISTS blog_post_categories (
    slug           VARCHAR(191) NOT NULL,
    category_id    INT UNSIGNED NOT NULL,
    subcategory_id INT UNSIGNED NOT NULL DEFAULT 0,
    created_at     DATETIME     NULL,
    PRIMARY KEY (slug, category_id, subcategory_id),
    KEY idx_blog_post_categories_cat (category_id)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
