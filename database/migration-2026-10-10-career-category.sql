SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — міграція 2026-10-10: нова категорія «Кар'єра та робота» / «Career & Jobs» (slug career) з підкатегоріями:
--   * Резюме та супровідні листи / Resumes & Cover Letters (slug resume-builders)
--   * Підготовка до співбесід / Interview Preparation (slug interview-prep)
--   * Пошук вакансій / Job Search (slug job-search)
--   * Фриланс / Freelancing (slug freelance)
--   * Кар'єрний розвиток / Career Growth (slug career-growth)
--   Без DROP/CREATE і без фіксованих id. Безпечно повторювати (WHERE NOT EXISTS).
--   Партія batches/2026-10-10-career-67.sql містить ці ж рядки, тож окремо застосовувати не обов'язково.
-- =====================================================================

INSERT INTO `categories` (`name`, `name_en`, `slug`) SELECT 'Кар''єра та робота', 'Career & Jobs', 'career' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `categories` WHERE `slug` = 'career');
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'career' LIMIT 1);
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Резюме та супровідні листи', 'Resumes & Cover Letters', 'resume-builders' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'resume-builders');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Підготовка до співбесід', 'Interview Preparation', 'interview-prep' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'interview-prep');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Пошук вакансій', 'Job Search', 'job-search' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'job-search');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Фриланс', 'Freelancing', 'freelance' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'freelance');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Кар''єрний розвиток', 'Career Growth', 'career-growth' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'career-growth');
