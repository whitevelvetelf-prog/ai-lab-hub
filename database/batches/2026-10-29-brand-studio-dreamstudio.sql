SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-29: оновлення картки DreamStudio → «Brand Studio (DreamStudio)».
--   Stability AI замінила DreamStudio платформою Brand Studio (оголошення stability.ai/news-updates, 8 квітня 2026);
--   dreamstudio.ai → 301 на brandstudio.com. Оновлено назву, сайт, тексти UA/EN, тарифи (старі Free/Credits видалено).
-- Картка шукається за назвою або сайтом, без фіксованого id. Повторний запуск безпечний.
-- Застосування: phpMyAdmin → БД → «Импорт».
-- =====================================================================

SET @pid = (SELECT `id` FROM `products` WHERE `name` IN ('DreamStudio', 'Brand Studio (DreamStudio)') OR `official_url` LIKE '%dreamstudio.ai%' ORDER BY `id` LIMIT 1);

UPDATE `products` SET `name` = 'Brand Studio (DreamStudio)', `official_url` = 'https://brandstudio.com', `short_description` = 'Платформа Stability AI для зображень і рекламних візуалів у стилі бренду. Раніше — DreamStudio.', `full_description` = 'Brand Studio — платформа Stability AI для створення зображень і рекламних візуалів, яка замінила DreamStudio: адреса dreamstudio.ai тепер веде на brandstudio.com. Простого генератора з пакетами кредитів, яким був DreamStudio, більше немає. У Brand Studio можна навчити власну модель на фото, кольорах і розміщенні логотипа бренду (Brand ID), зібрати кампанію з референсів, точково змінити ділянку зображення за ескізом і вставити товар у сцену. Режим Producer Mode перетворює опис задачі на покроковий план і виконує його після вашого підтвердження. Модель під задачу платформа обирає сама (Stable Diffusion або сторонні, як-от Nano Banana і Seedream); автовибір можна вимкнути й указати модель вручну. Тариф Core для креативних фахівців можна спробувати безкоштовно. Enterprise для команд додає єдиний вхід (SSO), ролі доступу та рецензування з коментарями; ціну узгоджують з відділом продажів.', `main_features` = 'Власні моделі в стилі бренду (Brand ID)
Кампанії з референсних зображень
Producer Mode: покроковий план і виконання після підтвердження
Автовибір моделі (Stable Diffusion, Nano Banana, Seedream) або ручний
Точкове редагування ділянки зображення за ескізом
Вставлення товару в сцену
Для команд: SSO, ролі доступу, рецензування', `target_audience` = 'Дизайнери, маркетологи й команди брендів, яким потрібні зображення в єдиному фірмовому стилі.', `platform` = 'web', `skill_level` = 'basic', `updated_at` = NOW() WHERE `id` = @pid;

INSERT INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A Stability AI platform for on-brand images and ad visuals. Formerly DreamStudio.', 'manual' FROM DUAL WHERE @pid IS NOT NULL ON DUPLICATE KEY UPDATE `translated_text` = VALUES(`translated_text`), `source` = 'manual';
INSERT INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Brand Studio is the Stability AI platform for creating images and ad visuals that replaced DreamStudio: dreamstudio.ai now redirects to brandstudio.com. The simple credit-pack image generator that DreamStudio used to be is gone. In Brand Studio you can train your own model on a brand’s photography style, colors and logo placement (Brand ID), build campaigns from reference images, edit a specific area of an image using a sketch, and place a product into a scene. Producer Mode turns a description of the task into a step-by-step plan and runs it once you approve. The platform picks a model for each task (Stable Diffusion or third-party models such as Nano Banana and Seedream); you can switch routing off and choose a model yourself. The Core plan for creative professionals can be tried for free. Enterprise for teams adds single sign-on (SSO), role-based access and review with comments; pricing is agreed with sales.', 'manual' FROM DUAL WHERE @pid IS NOT NULL ON DUPLICATE KEY UPDATE `translated_text` = VALUES(`translated_text`), `source` = 'manual';
INSERT INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Custom on-brand models (Brand ID)
Campaigns from reference images
Producer Mode: step-by-step plan, run after approval
Automatic model routing (Stable Diffusion, Nano Banana, Seedream) or manual choice
Precision inpainting with a sketch
Product insertion into a scene
For teams: SSO, role-based access, review', 'manual' FROM DUAL WHERE @pid IS NOT NULL ON DUPLICATE KEY UPDATE `translated_text` = VALUES(`translated_text`), `source` = 'manual';
INSERT INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Designers, marketers and brand teams who need images in a consistent brand style.', 'manual' FROM DUAL WHERE @pid IS NOT NULL ON DUPLICATE KEY UPDATE `translated_text` = VALUES(`translated_text`), `source` = 'manual';

-- Тарифи: прибираємо застарілі (переклади видаляються каскадом), додаємо актуальні.
DELETE FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` NOT IN ('Core', 'Enterprise');
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Core', 'Core', 0.00, 'free', 'Безкоштовна спроба для креативних фахівців; умови платного тарифу — на сайті.', 'Free trial for creative professionals; paid terms are on the website.' FROM DUAL WHERE @pid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Core');
SET @plan = (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Core' ORDER BY `id` DESC LIMIT 1);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Core', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free trial for creative professionals; paid terms are on the website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Enterprise', 'Enterprise', NULL, 'month', 'Для команд: SSO, ролі доступу, рецензування; ціна за запитом.', 'For teams: SSO, role-based access, review; pricing on request.' FROM DUAL WHERE @pid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise');
SET @plan = (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Enterprise' ORDER BY `id` DESC LIMIT 1);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Enterprise', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For teams: SSO, role-based access, review; pricing on request.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
