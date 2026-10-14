SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — міграція 2026-10-14: нова категорія «Доступність» / «Accessibility» (slug accessibility) з 6 підкатегоріями.
--   Без DROP/CREATE і без фіксованих id. Безпечно повторювати (WHERE NOT EXISTS).
--   Партія batches/2026-10-14-accessibility-64.sql містить ці ж рядки, тож окремо застосовувати не обов'язково.
-- =====================================================================

INSERT INTO `categories` (`name`, `name_en`, `slug`) SELECT 'Доступність', 'Accessibility', 'accessibility' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `categories` WHERE `slug` = 'accessibility');
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'accessibility' LIMIT 1);
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Для незрячих і слабозорих', 'Blind & Low Vision', 'blind-low-vision' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'blind-low-vision');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Для глухих і слабочуючих', 'Deaf & Hard of Hearing', 'deaf-hard-of-hearing' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'deaf-hard-of-hearing');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Мовлення та альтернативна комунікація', 'Speech & AAC', 'speech-aac' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'speech-aac');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Читання та нейровідмінності', 'Reading & Neurodiversity', 'reading-neurodiversity' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'reading-neurodiversity');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Керування без рук', 'Hands-free Access', 'hands-free' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'hands-free');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Цифрова доступність для бізнесу', 'Digital Accessibility for Business', 'digital-accessibility' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'digital-accessibility');
