SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — 2026-10-30: тарифи Altegio в гривнях (замість плану «Ціна: див. сайт»)
-- Джерело: alteg.io/uk/pricing/ (регіон Україна), звірено 2026-10-30. Ціни без ПДВ.
-- Ціна залежить від кількості співробітників: 300 ₴ за співробітника на місяць при помісячній оплаті.
-- product.php показує ціну з «$», тому price = NULL («За запитом»), точна сума в гривнях — в описі плану.
-- Без фіксованих id: продукт шукається за адресою alteg.io/uk. Повторний запуск безпечний.
-- Застосування: phpMyAdmin → БД → «Импорт».
-- =====================================================================

SET @pid = (SELECT `id` FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'alteg.io/uk' ORDER BY `id` LIMIT 1);

-- Прибрати заглушку «Ціна: див. сайт» і попередні версії цих тарифів (для повторного запуску)
DELETE t FROM `pricing_plan_translations` t JOIN `pricing_plans` p ON p.`id` = t.`plan_id`
WHERE p.`product_id` = @pid AND p.`plan_name` IN ('Ціна: див. сайт', 'Пробний період', 'До 2 співробітників', '5 співробітників', '10 співробітників', 'До 20 співробітників', 'Без обмежень');
DELETE FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` IN ('Ціна: див. сайт', 'Пробний період', 'До 2 співробітників', '5 співробітників', '10 співробітників', 'До 20 співробітників', 'Без обмежень');

INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пробний період', 'Free trial', 0.00, 'free', '7 днів безкоштовно, без банківської картки, онбординг з експертом.', '7 days free, no bank card required, onboarding with an expert.' FROM DUAL WHERE @pid IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'До 2 співробітників', 'Up to 2 staff', NULL, 'month', '600 ₴/міс при оплаті щомісяця; 3 міс + 1 у подарунок — 1 800 ₴ (450 ₴/міс); 6 міс + 3 — 3 600 ₴ (400 ₴/міс); 12 міс + 9 — 7 200 ₴ (343 ₴/міс). Без ПДВ.', 'UAH 600/month billed monthly; 3 months + 1 free — UAH 1,800 (UAH 450/month); 6 + 3 — UAH 3,600 (UAH 400/month); 12 + 9 — UAH 7,200 (UAH 343/month). Excl. VAT.' FROM DUAL WHERE @pid IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, '5 співробітників', '5 staff', NULL, 'month', '1 500 ₴/міс при оплаті щомісяця; 3 міс + 1 — 4 500 ₴ (1 125 ₴/міс); 6 міс + 3 — 9 000 ₴ (1 000 ₴/міс); 12 міс + 9 — 18 000 ₴ (857 ₴/міс). Без ПДВ.', 'UAH 1,500/month billed monthly; 3 + 1 months — UAH 4,500 (UAH 1,125/month); 6 + 3 — UAH 9,000 (UAH 1,000/month); 12 + 9 — UAH 18,000 (UAH 857/month). Excl. VAT.' FROM DUAL WHERE @pid IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, '10 співробітників', '10 staff', NULL, 'month', '3 000 ₴/міс при оплаті щомісяця; 3 міс + 1 — 9 000 ₴; 6 міс + 3 — 18 000 ₴; 12 міс + 9 — 36 000 ₴ (1 714 ₴/міс). Без ПДВ.', 'UAH 3,000/month billed monthly; 3 + 1 months — UAH 9,000; 6 + 3 — UAH 18,000; 12 + 9 — UAH 36,000 (UAH 1,714/month). Excl. VAT.' FROM DUAL WHERE @pid IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'До 20 співробітників', 'Up to 20 staff', NULL, 'month', '6 000 ₴/міс при оплаті щомісяця; 3 міс + 1 — 18 000 ₴ (4 500 ₴/міс); 6 міс + 3 — 36 000 ₴ (4 000 ₴/міс); 12 міс + 9 — 72 000 ₴ (3 429 ₴/міс). Без ПДВ.', 'UAH 6,000/month billed monthly; 3 + 1 months — UAH 18,000 (UAH 4,500/month); 6 + 3 — UAH 36,000 (UAH 4,000/month); 12 + 9 — UAH 72,000 (UAH 3,429/month). Excl. VAT.' FROM DUAL WHERE @pid IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Без обмежень', 'Unlimited staff', NULL, 'month', '7 500 ₴/міс при оплаті щомісяця; 3 міс + 1 — 22 500 ₴ (5 625 ₴/міс); 6 міс + 3 — 45 000 ₴ (5 000 ₴/міс); 12 міс + 9 — 90 000 ₴ (4 286 ₴/міс). Без ПДВ.', 'UAH 7,500/month billed monthly; 3 + 1 months — UAH 22,500 (UAH 5,625/month); 6 + 3 — UAH 45,000 (UAH 5,000/month); 12 + 9 — UAH 90,000 (UAH 4,286/month). Excl. VAT.' FROM DUAL WHERE @pid IS NOT NULL;

INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`)
SELECT `id`, 'plan_name', 'en', `plan_name_en`, 'manual' FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name_en` IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`)
SELECT `id`, 'description', 'en', `description_en`, 'manual' FROM `pricing_plans` WHERE `product_id` = @pid AND `description_en` IS NOT NULL;
