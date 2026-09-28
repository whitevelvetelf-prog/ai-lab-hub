SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — міграція 2026-09-28: об'єднання підкатегорій «Мій дім»
-- «Шиття» (sewing), «В'язання» (knitting), «Вишивання» (embroidery), «Бісер» (beading)
-- → одна підкатегорія «Рукоділля» (handicraft). «Макраме» (macrame) не чіпаємо.
--
-- Застосування (phpMyAdmin хостингу, БД gu621051_ailabhublive): вкладка SQL → вставити вміст файлу → Вперёд.
-- БЕЗ ФІКСОВАНИХ id: усе шукається за slug категорії та підкатегорій. Безпечно повторювати:
--   1) «Рукоділля» створюється, лише якщо її ще немає;
--   2) прив'язки продуктів копіюються через INSERT IGNORE (PK product_id+subcategory_id не дає дублікатів),
--      потім старі прив'язки видаляються — лише для продуктів, які вже мають «Рукоділля»;
--   3) рекламні кампанії (ads.subcategory_id) переводяться на «Рукоділля»;
--   4) стара підкатегорія видаляється, лише якщо в неї не лишилось жодного продукту
--      (FK product_subcategories — ON DELETE CASCADE, тож ця перевірка захищає від тихої втрати зв'язків).
-- Наприкінці — SELECT із підсумком: має бути old_subcategories_left = 0 і orphan_products = 0.
-- =====================================================================

START TRANSACTION;

SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'my-home' LIMIT 1);

INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`)
SELECT @cat, 'Рукоділля', 'Handicraft', 'handicraft' FROM DUAL
WHERE @cat IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'handicraft');

SET @hc = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'handicraft' LIMIT 1);

INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`)
SELECT ps.`product_id`, @hc
FROM `product_subcategories` ps
JOIN `subcategories` s ON s.`id` = ps.`subcategory_id`
WHERE @hc IS NOT NULL AND s.`category_id` = @cat AND s.`slug` IN ('sewing', 'knitting', 'embroidery', 'beading');

DELETE ps FROM `product_subcategories` ps
JOIN `subcategories` s ON s.`id` = ps.`subcategory_id`
WHERE @hc IS NOT NULL AND s.`category_id` = @cat AND s.`slug` IN ('sewing', 'knitting', 'embroidery', 'beading')
  AND EXISTS (SELECT 1 FROM (SELECT `product_id` FROM `product_subcategories` WHERE `subcategory_id` = @hc) h
              WHERE h.`product_id` = ps.`product_id`);

UPDATE `ads` a
JOIN `subcategories` s ON s.`id` = a.`subcategory_id`
SET a.`subcategory_id` = @hc
WHERE @hc IS NOT NULL AND s.`category_id` = @cat AND s.`slug` IN ('sewing', 'knitting', 'embroidery', 'beading');

DELETE s FROM `subcategories` s
WHERE @hc IS NOT NULL AND s.`category_id` = @cat AND s.`slug` IN ('sewing', 'knitting', 'embroidery', 'beading')
  AND NOT EXISTS (SELECT 1 FROM `product_subcategories` ps WHERE ps.`subcategory_id` = s.`id`);

COMMIT;

SELECT
    (SELECT COUNT(*) FROM `product_subcategories` WHERE `subcategory_id` = @hc) AS handicraft_products,
    (SELECT COUNT(*) FROM `subcategories`
      WHERE `category_id` = @cat AND `slug` IN ('sewing', 'knitting', 'embroidery', 'beading')) AS old_subcategories_left,
    (SELECT COUNT(*) FROM `product_categories` pc
      WHERE pc.`category_id` = @cat
        AND NOT EXISTS (SELECT 1 FROM `product_subcategories` ps
                        JOIN `subcategories` s ON s.`id` = ps.`subcategory_id`
                        WHERE ps.`product_id` = pc.`product_id` AND s.`category_id` = @cat)) AS orphan_products;
