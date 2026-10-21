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
