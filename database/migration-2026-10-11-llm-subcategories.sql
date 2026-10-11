SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — міграція 2026-10-11: нові підкатегорії в категорії «Розробка та IT» / «Development & IT» (slug development-it) з підкатегоріями:
--   * Локальні LLM / Local LLMs (slug local-llm)
--   * Інференс і GPU-хмари / LLM Inference & GPU Cloud (slug llm-inference)
--   * Фреймворки для LLM-застосунків / LLM App Frameworks (slug llm-frameworks)
--   * Моніторинг і оцінка LLM / LLMOps & Evaluation (slug llmops)
--   * Векторні бази даних / Vector Databases (slug vector-databases)
--   Категорія вже існує — створюються лише підкатегорії. Без DROP/CREATE і без фіксованих id. Безпечно повторювати (WHERE NOT EXISTS).
--   Партія batches/2026-10-11-llm-tools-44.sql містить ці ж рядки, тож окремо застосовувати не обов'язково.
-- =====================================================================

INSERT INTO `categories` (`name`, `name_en`, `slug`) SELECT 'Розробка та IT', 'Development & IT', 'development-it' FROM DUAL WHERE NOT EXISTS (SELECT 1 FROM `categories` WHERE `slug` = 'development-it');
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'development-it' LIMIT 1);
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Локальні LLM', 'Local LLMs', 'local-llm' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'local-llm');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Інференс і GPU-хмари', 'LLM Inference & GPU Cloud', 'llm-inference' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'llm-inference');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Фреймворки для LLM-застосунків', 'LLM App Frameworks', 'llm-frameworks' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'llm-frameworks');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Моніторинг і оцінка LLM', 'LLMOps & Evaluation', 'llmops' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'llmops');
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Векторні бази даних', 'Vector Databases', 'vector-databases' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'vector-databases');
