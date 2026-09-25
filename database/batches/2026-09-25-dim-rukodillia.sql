SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія продуктів 2026-09-25: «Мій дім» → Рукоділля
-- 5 нових підкатегорій категорії «Мій дім» (my-home): В'язання (knitting), Вишивання (embroidery), Шиття (sewing), Макраме (macrame), Бісер (beading)
-- та 14 нових продуктів:
--   purlJam — В'язання
--   Knitsly — В'язання
--   Crochet Patterns AI — В'язання
--   Pic2Pat — Вишивання
--   Cross Stitch AI Pattern Maker — Вишивання
--   VEED AI Embroidery Generator — Вишивання
--   PatternGen — Шиття
--   Myaiart Sewing Pattern Generator — Шиття
--   LightX AI Macrame Pattern Generator — Макраме
--   KnotShot — Макраме
--   Loomerly — Бісер
--   Perlypop — Бісер
--   BeadPattern — Бісер
--   PlanBead — Бісер
-- (підкатегорію «Прядіння» свідомо не створено — спеціалізованих AI-продуктів не знайдено)
--
-- Застосування (phpMyAdmin хостингу, БД gu621051_ailabhublive): вкладка SQL → вставити вміст файлу → Вперёд.
-- БЕЗ ФІКСОВАНИХ id: підкатегорія додається, лише якщо в «Мій дім» ще немає такого slug; продукт —
-- лише якщо продукту з таким самим нормалізованим URL (без http(s)://, www., кінцевого слеша, регістру)
-- ще немає; його id береться через @pid. Безпечно повторювати; жодних DROP / DELETE / перестворення таблиць.
-- Дані — з постановки задачі (назва, URL, короткий опис, модель монетизації). Повний опис, функції,
-- аудиторія й ціни платних тарифів не підтверджені — лишено порожніми.
-- =====================================================================

-- ---------------------------------------------------------------------
-- Підкатегорії «Рукоділля» в категорії «Мій дім»
-- ---------------------------------------------------------------------
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT c.`id`, 'В''язання', 'Knitting', 'knitting' FROM `categories` c WHERE c.`slug` = 'my-home' AND NOT EXISTS (SELECT 1 FROM `subcategories` s WHERE s.`category_id` = c.`id` AND s.`slug` = 'knitting');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT c.`id`, 'Вишивання', 'Embroidery', 'embroidery' FROM `categories` c WHERE c.`slug` = 'my-home' AND NOT EXISTS (SELECT 1 FROM `subcategories` s WHERE s.`category_id` = c.`id` AND s.`slug` = 'embroidery');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT c.`id`, 'Шиття', 'Sewing', 'sewing' FROM `categories` c WHERE c.`slug` = 'my-home' AND NOT EXISTS (SELECT 1 FROM `subcategories` s WHERE s.`category_id` = c.`id` AND s.`slug` = 'sewing');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT c.`id`, 'Макраме', 'Macrame', 'macrame' FROM `categories` c WHERE c.`slug` = 'my-home' AND NOT EXISTS (SELECT 1 FROM `subcategories` s WHERE s.`category_id` = c.`id` AND s.`slug` = 'macrame');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT c.`id`, 'Бісер', 'Beading', 'beading' FROM `categories` c WHERE c.`slug` = 'my-home' AND NOT EXISTS (SELECT 1 FROM `subcategories` s WHERE s.`category_id` = c.`id` AND s.`slug` = 'beading');

-- purlJam — В'язання
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_at`) SELECT 'purlJam', NULL, 'https://purljam.uk', NULL, NULL, 'Безкоштовний AI-генератор схем в''язання та гачка рядок-за-рядком за описом проєкту', NULL, NULL, NULL, 'web', 'none', 'published', 'found', '2026-09-25 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'purljam.uk');
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'purljam.uk' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE c.`slug` = 'my-home' AND s.`slug` = 'knitting';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Безкоштовно' FROM DUAL WHERE @new = 1;

-- Knitsly — В'язання
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_at`) SELECT 'Knitsly', NULL, 'https://knitsly.com', NULL, NULL, 'AI-генератор схем в''язання й гачка з опису проєкту або фото', NULL, NULL, NULL, 'web', 'none', 'published', 'found', '2026-09-25 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'knitsly.com');
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'knitsly.com' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE c.`slug` = 'my-home' AND s.`slug` = 'knitting';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Безкоштовно' FROM DUAL WHERE @new = 1;

-- Crochet Patterns AI — В'язання
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_at`) SELECT 'Crochet Patterns AI', NULL, 'https://apps.apple.com/us/app/crochet-patterns-ai/id6770431527', NULL, NULL, 'Бібліотека схем в''язання гачком з AI-асистентом і перетворенням фото на схему', NULL, NULL, NULL, 'mobile', 'none', 'published', 'found', '2026-09-25 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/us/app/crochet-patterns-ai/id6770431527');
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/us/app/crochet-patterns-ai/id6770431527' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE c.`slug` = 'my-home' AND s.`slug` = 'knitting';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно; ціну платного тарифу не підтверджено' FROM DUAL WHERE @new = 1;

-- Pic2Pat — Вишивання
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_at`) SELECT 'Pic2Pat', NULL, 'https://pic2pat.com', NULL, NULL, 'Перетворює фото на схему вишивки хрестиком з розрахунком кольорів муліне й кількості мотків', NULL, NULL, NULL, 'web', 'none', 'published', 'found', '2026-09-25 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pic2pat.com');
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pic2pat.com' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE c.`slug` = 'my-home' AND s.`slug` = 'embroidery';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Безкоштовно' FROM DUAL WHERE @new = 1;

-- Cross Stitch AI Pattern Maker — Вишивання
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_at`) SELECT 'Cross Stitch AI Pattern Maker', NULL, 'https://play.google.com/store/apps/details?id=com.avk.stitch', NULL, NULL, 'Перетворює фото на готову схему вишивки хрестиком з підбором кольорів ниток', NULL, NULL, NULL, 'mobile', 'none', 'published', 'found', '2026-09-25 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.avk.stitch');
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'play.google.com/store/apps/details?id=com.avk.stitch' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE c.`slug` = 'my-home' AND s.`slug` = 'embroidery';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно; ціну платного тарифу не підтверджено' FROM DUAL WHERE @new = 1;

-- VEED AI Embroidery Generator — Вишивання
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_at`) SELECT 'VEED AI Embroidery Generator', NULL, 'https://www.veed.io/tools/ai-image-editor/embroidery-generator', NULL, NULL, 'Генерує дизайни вишивки (хрестик, гладь, ланцюжок) з тексту або фото', NULL, NULL, NULL, 'web', 'none', 'published', 'found', '2026-09-25 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'veed.io/tools/ai-image-editor/embroidery-generator');
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'veed.io/tools/ai-image-editor/embroidery-generator' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE c.`slug` = 'my-home' AND s.`slug` = 'embroidery';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно; ціну платного тарифу не підтверджено' FROM DUAL WHERE @new = 1;

-- PatternGen — Шиття
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_at`) SELECT 'PatternGen', NULL, 'https://pattern-gen.vercel.app', NULL, NULL, 'Перетворює фото одягу на готові SVG-викрійки з інструкціями пошиття', NULL, NULL, NULL, 'web', 'none', 'published', 'found', '2026-09-25 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pattern-gen.vercel.app');
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pattern-gen.vercel.app' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE c.`slug` = 'my-home' AND s.`slug` = 'sewing';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Безкоштовно' FROM DUAL WHERE @new = 1;

-- Myaiart Sewing Pattern Generator — Шиття
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_at`) SELECT 'Myaiart Sewing Pattern Generator', NULL, 'https://www.myaiart.io/features/ai-sewing-pattern-generator/', NULL, NULL, 'Генерує викрійки за мірками з градацією розмірів, друк у PDF/SVG/DXF', NULL, NULL, NULL, 'web', 'none', 'published', 'found', '2026-09-25 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myaiart.io/features/ai-sewing-pattern-generator');
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myaiart.io/features/ai-sewing-pattern-generator' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE c.`slug` = 'my-home' AND s.`slug` = 'sewing';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно; ціну платного тарифу не підтверджено' FROM DUAL WHERE @new = 1;

-- LightX AI Macrame Pattern Generator — Макраме
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_at`) SELECT 'LightX AI Macrame Pattern Generator', NULL, 'https://www.lightxeditor.com/photo-editing/ai-macrame-pattern-generator/', NULL, NULL, 'Генерує дизайни макраме (вузли, стилі) з текстового опису', NULL, NULL, NULL, 'web', 'none', 'published', 'found', '2026-09-25 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lightxeditor.com/photo-editing/ai-macrame-pattern-generator');
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lightxeditor.com/photo-editing/ai-macrame-pattern-generator' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE c.`slug` = 'my-home' AND s.`slug` = 'macrame';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно; ціну платного тарифу не підтверджено' FROM DUAL WHERE @new = 1;

-- KnotShot — Макраме
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_at`) SELECT 'KnotShot', NULL, 'https://knotshot.net', NULL, NULL, 'Візуалізація проєктів макраме у кольорі з покроковими інструкціями', NULL, NULL, NULL, 'web', 'none', 'published', 'found', '2026-09-25 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'knotshot.net');
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'knotshot.net' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE c.`slug` = 'my-home' AND s.`slug` = 'macrame';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно; ціну платного тарифу не підтверджено' FROM DUAL WHERE @new = 1;

-- Loomerly — Бісер
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_at`) SELECT 'Loomerly', NULL, 'https://loomerly.com', NULL, NULL, 'Перетворює фото на схеми ткання бісером (loom, peyote, brick stitch), Miyuki/Toho/Preciosa', NULL, NULL, NULL, 'web', 'none', 'published', 'found', '2026-09-25 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'loomerly.com');
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'loomerly.com' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE c.`slug` = 'my-home' AND s.`slug` = 'beading';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Разова покупка', NULL, 'one_time', 'Платний, разова оплата; ціну не підтверджено' FROM DUAL WHERE @new = 1;

-- Perlypop — Бісер
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_at`) SELECT 'Perlypop', NULL, 'https://perlypop.com', NULL, NULL, 'Перетворює фото й малюнки на схеми термомозаїки (Perler, Hama, Artkal, Nabbi)', NULL, NULL, NULL, 'web', 'none', 'published', 'found', '2026-09-25 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'perlypop.com');
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'perlypop.com' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE c.`slug` = 'my-home' AND s.`slug` = 'beading';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно; ціну платного тарифу не підтверджено' FROM DUAL WHERE @new = 1;

-- BeadPattern — Бісер
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_at`) SELECT 'BeadPattern', NULL, 'https://beadpattern.net', NULL, NULL, 'AI генерує схеми термомозаїки з тексту або фото з розрахунком кольорів і кількості намистин', NULL, NULL, NULL, 'web', 'none', 'published', 'found', '2026-09-25 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'beadpattern.net');
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'beadpattern.net' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE c.`slug` = 'my-home' AND s.`slug` = 'beading';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Базові можливості безкоштовно; ціну платного тарифу не підтверджено' FROM DUAL WHERE @new = 1;

-- PlanBead — Бісер
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `full_description`, `main_features`, `target_audience`, `platform`, `skill_level`, `status`, `partnership_status`, `created_at`) SELECT 'PlanBead', NULL, 'https://apps.apple.com/us/app/planbead/id6741919764', NULL, NULL, 'Студія дизайну прикрас з бісеру (loom, peyote, brick stitch) з AI-генерацією зображень', NULL, NULL, NULL, 'mobile', 'none', 'published', 'found', '2026-09-25 00:00:00' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/us/app/planbead/id6741919764');
SET @new = ROW_COUNT();
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/us/app/planbead/id6741919764' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE c.`slug` = 'my-home';
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE c.`slug` = 'my-home' AND s.`slug` = 'beading';
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `price`, `period`, `description`) SELECT @pid, 'Free', 0.00, 'free', 'Безкоштовно' FROM DUAL WHERE @new = 1;
