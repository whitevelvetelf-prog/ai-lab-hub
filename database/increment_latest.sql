SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — 2026-10-30: 1 новий продукт для статті «Програма для запису ігор: Insights Capture і альтернативи»
--   Xbox Game Bar — Мультимедіа → Для геймерів (там само, де OBS Studio)
-- Факти — з офіційної довідки Xbox (support.xbox.com, «Get to know Game Bar on Windows» і «Using Game Bar Widgets»),
--   звірено 2026-10-30. Безкоштовний, вбудований у Windows 10/11.
-- NVIDIA ShadowPlay окремою карткою НЕ додано: це функція запису в NVIDIA App (стара адреса
--   nvidia.com/…/shadowplay/ переадресовує на сторінку NVIDIA App, картка якої вже є в каталозі).
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою. Повторний запуск безпечний.
-- Застосування: phpMyAdmin → БД → «Импорт».
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'multimedia' LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'for-gamers' LIMIT 1);

SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.microsoft.com/detail/9nzkpstsnw4p' OR LOWER(`name`) = 'xbox game bar'), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`)
SELECT 'Xbox Game Bar', NULL, 'https://apps.microsoft.com/detail/9nzkpstsnw4p', NULL, NULL,
 'Вбудована у Windows 10/11 ігрова панель: запис кліпів і скриншотів, лічильник FPS, звук і чат Xbox поверх гри.',
 'The game overlay built into Windows 10/11: record clips and screenshots, FPS counter, audio and Xbox chat on top of your game.',
 'Xbox Game Bar — безкоштовна панель від Microsoft, яка вже є у Windows 10 і 11, тож нічого встановлювати не потрібно. Вона відкривається поверх гри, програми чи робочого столу клавішами Windows + G. У віджеті «Запис» можна почати запис, зробити скриншот або зберегти останні хвилини гри як кліп, якщо в налаштуваннях увімкнено фоновий запис (тривалість задається в «Параметри → Ігри → Записи»). Кліпи й скриншоти зберігаються в «Галереї». Інші віджети показують FPS і навантаження на систему, дають налаштувати гучність гри й чату, слухати Spotify, переглядати досягнення Xbox, спілкуватися з друзями й шукати гравців для мультиплеєра. Для частини функцій Xbox потрібні застосунок Xbox для Windows і вхід в обліковий запис; у деяких іграх у повноекранному режимі панель не з''являється.',
 'Xbox Game Bar is a free Microsoft overlay that already ships with Windows 10 and 11, so there is nothing to install. It opens over a game, app or the desktop with Windows + G. In the Capture widget you can start recording, take a screenshot, or save the last moments of play as a clip when background recording is turned on (the length is set in Settings → Gaming → Captures). Clips and screenshots are kept in the Gallery. Other widgets show FPS and system resource use, let you balance game and chat volume, play Spotify, check Xbox achievements, chat with friends and find players for multiplayer games. Some Xbox features need the Xbox app for Windows and a signed-in account; in some full-screen PC games the overlay does not appear.',
 'Запис кліпів і скриншотів (Windows + G)\nЗбереження останніх хвилин гри у фоновому режимі\nГалерея записів\nЛічильник FPS і моніторинг ресурсів\nМікшер звуку гри та чату\nЧат і друзі Xbox, пошук гравців, Spotify',
 'Clip and screenshot capture (Windows + G)\nSave the last moments of play with background recording\nGallery of captures\nFPS counter and resource monitor\nGame and chat audio mixer\nXbox chat and friends, Looking for Group, Spotify',
 'Гравцям на ПК з Windows, яким потрібні епізодичні кліпи й скриншоти без встановлення окремих програм.',
 'Windows PC gamers who want occasional clips and screenshots without installing extra software.',
 'desktop', 'none', 'published', 0, 'found', @uid, '2026-10-30 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.microsoft.com/detail/9nzkpstsnw4p' OR LOWER(`name`) = 'xbox game bar' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', `short_description_en`, 'manual' FROM `products` WHERE `id` = @pid AND @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', `full_description_en`, 'manual' FROM `products` WHERE `id` = @pid AND @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', `main_features_en`, 'manual' FROM `products` WHERE `id` = @pid AND @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', `target_audience_en`, 'manual' FROM `products` WHERE `id` = @pid AND @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно, вбудовано у Windows 10 і 11.', 'Free, built into Windows 10 and 11.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free, built into Windows 10 and 11.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
