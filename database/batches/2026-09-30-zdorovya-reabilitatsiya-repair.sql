SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — доповнення до партії 2026-09-29 (PosturaZen, ScolioEx): тарифи й англійські переклади.
-- На хостингу 2026-09-30 картки створились, але тарифи/переклади пропущено: @new = ROW_COUNT() не спрацював.
-- Тут «новизна» визначається без ROW_COUNT(): тарифи й переклади додаються лише продукту, в якого ще немає тарифів.
-- Повторний запуск безпечний.
-- =====================================================================


-- PosturaZen — Здоров'я та краса › Реабілітація та фізіотерапія
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'posturazen.com' OR LOWER(`name`) = LOWER('PosturaZen')) ORDER BY `id` LIMIT 1);
SET @new = IF(@pid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `pricing_plans` WHERE `product_id` = @pid), 1, 0);
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Scans posture with your phone camera: estimates the Cobb angle, shoulder height difference and pelvic position without an X-ray and shows changes over time. It is a screening and monitoring tool, not a replacement for an X-ray or a doctor''s diagnosis.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PosturaZen is an AI-powered mobile app that helps you spot and track posture problems and signs of spinal curvature. All it needs is your phone camera: the app analyses body position and estimates the Cobb angle, shoulder height difference, pelvic position, shoulder blade projection and other measurements — without an X-ray. Results are saved in reports with 3D modelling, so you can see how your posture changes over time and share a report with a doctor or physiotherapist. The AI Workout Companion watches your form during prescribed exercises in real time and guides you to do them correctly. Important: PosturaZen is a screening and monitoring tool; it does not replace an X-ray or give a medical diagnosis, and treatment decisions are made by a doctor. The app is preparing to launch on iOS and Android and is currently in beta testing. Pricing is not published on the website.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI posture scanning and Cobb angle estimation with your phone camera
Shoulder height difference and pelvic position measured without an X-ray
Progress tracking over time with reports and 3D modelling
Real-time AI feedback on exercise form
Reports to share with a doctor or physiotherapist', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents keeping an eye on their child''s posture, adults who suspect scoliosis, and patients with a confirmed diagnosis who want to monitor their condition between doctor visits.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна за запитом', 'Price on request', NULL, 'month', 'За запитом: вартість на сайті не опублікована — див. posturazen.com', 'On request: pricing is not published — see posturazen.com' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна за запитом' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price on request', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'On request: pricing is not published — see posturazen.com', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ScolioEx — Здоров'я та краса › Реабілітація та фізіотерапія
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/us/app/scolioex-scoliosis-exercises/id6755197741' OR LOWER(`name`) = LOWER('ScolioEx')) ORDER BY `id` LIMIT 1);
SET @new = IF(@pid IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `pricing_plans` WHERE `product_id` = @pid), 1, 0);
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Scoliosis exercise videos from a physiotherapist who lives with scoliosis: posture, balance, mobility and core strength at home with no equipment. The app presents itself as a personal movement guide, not medical treatment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ScolioEx is an exercise video app for people with scoliosis, created by a physiotherapist who lives with the condition. Sessions focus on posture, balance, mobility and core strength, helping to ease tension and improve alignment. Every exercise comes with clear video guidance and cues, so you can train at home at your own pace — with no equipment and no clinic visits. You can build personal exercise collections, track your progress and set reminders to keep a regular routine. The app runs on iPhone, iPad and Mac and syncs through iCloud. Important: ScolioEx itself states that it is not medical treatment but a personal movement guide; a scoliosis treatment plan should be agreed with a doctor. The app is free to download: 5 exercises are available to everyone, the full library is unlocked with a one-time purchase with no subscription, and there is a 14-day free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Video exercises for posture, balance and mobility
Personalised exercise collections
Progress tracking and reminders
Home workouts with no equipment
iCloud sync across iPhone, iPad and Mac', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People with scoliosis who want a regular home exercise routine with no equipment and no clinic visits.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', '5 вправ для всіх і 14-денний пробний період Premium без банківської картки', '5 exercises for everyone and a 14-day Premium trial with no credit card' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', '5 exercises for everyone and a 14-day Premium trial with no credit card', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium Lifetime', 'Premium Lifetime', 9.99, 'one_time', 'Одноразова покупка без підписки: повна бібліотека вправ (ціна в App Store США)', 'One-time purchase, no subscription: the full exercise library (US App Store price)' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium Lifetime' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium Lifetime', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'One-time purchase, no subscription: the full exercise library (US App Store price)', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
