SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-07: 173 нових продуктів для нових підгруп категорії «Мій дім» .
-- Платні й безкоштовні застосунки, сервіси й онлайн-ресурси за підкатегоріями:
--   Розумний дім (smart-home): 32
--   Безпека дому (home-security): 31
--   Ремонт і будівництво (renovation): 30
--   Нерухомість і оренда (real-estate): 35
--   Домашнє господарство (household): 23
--   Енергія та резервне живлення (home-energy): 22
--   Домашні рослини (houseplants): 0
--   Сад (garden): 0
--   Город (kitchen-garden): 0
--   Домашні тварини (pets): 0
--   Худоба (livestock): 0
--   Птахівництво (poultry): 0
--   Риба (fish): 0
--   Бджоли (beekeeping): 0
--   Кулінарія (cooking): 0
--   Грумінг та ветеринарні сервіси (pet-grooming-vet): 0
--   Рукоділля (handicraft): 0
--   Авто (auto): 0
--   Дизайн інтер'єру (interior-design): 0
--   Покупки (shopping): 0
-- Лише справжні сервіси: сайти перевірено (відповідають, назва на сторінці). Відкинуто неробочі,
-- припарковані й захоплені домени, Cloudflare-перевірки, новинні сайти, благодійні фонди,
-- інвестиційні сервіси, астрологію, знайомства, продаж БАДів, сайти з медичними твердженнями. Тексти описові, без маркетингових оцінок.
-- Тексти, функції й тарифи (UA + EN) — лише з офіційних сайтів, звірено 2026-10-07.
-- Потребує міграції database/migration-2026-10-07-dim-subcategories.sql (нові підкатегорії).
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт» (файл .sql або .sql.zip). Повторний запуск безпечний.
--   Apple Home — Розумний дім
--   Aqara — Розумний дім
--   Brilliant — Розумний дім
--   Control4 — Розумний дім
--   Dreame — Розумний дім
--   ecobee — Розумний дім
--   ECOVACS — Розумний дім
--   Eve Home — Розумний дім
--   eWeLink — Розумний дім
--   FIBARO — Розумний дім
--   Google Home — Розумний дім
--   Govee — Розумний дім
--   Home Assistant — Розумний дім
--   Homebridge — Розумний дім
--   Homey — Розумний дім
--   Hubitat Elevation — Розумний дім
--   iRobot (Roomba) — Розумний дім
--   Josh.ai — Розумний дім
--   Kasa Smart — Розумний дім
--   LIFX — Розумний дім
--   Meross — Розумний дім
--   Nanoleaf — Розумний дім
--   Netatmo — Розумний дім
--   openHAB — Розумний дім
--   Philips Hue — Розумний дім
--   Roborock — Розумний дім
--   Shelly — Розумний дім
--   SmartThings — Розумний дім
--   SwitchBot — Розумний дім
--   tado° — Розумний дім
--   TP-Link Tapo — Розумний дім
--   WiZ — Розумний дім
--   abode — Безпека дому
--   ADT — Безпека дому
--   Ajax Systems — Безпека дому
--   Arlo — Безпека дому
--   August Home — Безпека дому
--   Blink — Безпека дому
--   Canary — Безпека дому
--   Cove — Безпека дому
--   Deep Sentinel — Безпека дому
--   eufy Security — Безпека дому
--   EZVIZ — Безпека дому
--   Flo by Moen — Безпека дому
--   Frontpoint — Безпека дому
--   Hik-Connect — Безпека дому
--   Imou — Безпека дому
--   Kangaroo — Безпека дому
--   Level Lock — Безпека дому
--   Lockly — Безпека дому
--   Lorex — Безпека дому
--   Minut — Безпека дому
--   Noonlight — Безпека дому
--   Nuki — Безпека дому
--   Phyn — Безпека дому
--   Reolink — Безпека дому
--   Ring — Безпека дому
--   Ring Neighbors — Безпека дому
--   SimpliSafe — Безпека дому
--   Ting — Безпека дому
--   Verisure — Безпека дому
--   Wyze — Безпека дому
--   Yale Home — Безпека дому
--   Angi — Ремонт і будівництво
--   Bark — Ремонт і будівництво
--   Bob Vila — Ремонт і будівництво
--   BuildBook — Ремонт і будівництво
--   Buildertrend — Ремонт і будівництво
--   Cedreo — Ремонт і будівництво
--   Checkatrade — Ремонт і будівництво
--   Family Handyman — Ремонт і будівництво
--   Fixr — Ремонт і будівництво
--   Floorplanner — Ремонт і будівництво
--   Handy — Ремонт і будівництво
--   HomeAdvisor — Ремонт і будівництво
--   HomeDesignsAI — Ремонт і будівництво
--   Houzz — Ремонт і будівництво
--   IKEA Planners — Ремонт і будівництво
--   Leroy Merlin — Ремонт і будівництво
--   Lowe's — Ремонт і будівництво
--   magicplan — Ремонт і будівництво
--   MyBuilder — Ремонт і будівництво
--   Remodel AI — Ремонт і будівництво
--   ReRoom — Ремонт і будівництво
--   RoomSketcher — Ремонт і будівництво
--   SketchUp — Ремонт і будівництво
--   Sweet Home 3D — Ремонт і будівництво
--   Taskrabbit — Ремонт і будівництво
--   The Home Depot — Ремонт і будівництво
--   This Old House — Ремонт і будівництво
--   Thumbtack — Ремонт і будівництво
--   Twindo — Ремонт і будівництво
--   Епіцентр К — Ремонт і будівництво
--   Apartment List — Нерухомість і оренда
--   Apartments.com — Нерухомість і оренда
--   Avail — Нерухомість і оренда
--   DIM.RIA — Нерухомість і оренда
--   Domain — Нерухомість і оренда
--   Flatfy — Нерухомість і оренда
--   Funda — Нерухомість і оренда
--   HouseCanary — Нерухомість і оренда
--   HousingAnywhere — Нерухомість і оренда
--   idealista — Нерухомість і оренда
--   ImmoScout24 — Нерухомість і оренда
--   immowelt — Нерухомість і оренда
--   Landlord Studio — Нерухомість і оренда
--   OLX Нерухомість — Нерухомість і оренда
--   Opendoor — Нерухомість і оренда
--   Otodom — Нерухомість і оренда
--   realestate.com.au — Нерухомість і оренда
--   Realtor.com — Нерухомість і оренда
--   Redfin — Нерухомість і оренда
--   RentRedi — Нерухомість і оренда
--   Rieltor.ua — Нерухомість і оренда
--   Rightmove — Нерухомість і оренда
--   Roomies.com — Нерухомість і оренда
--   SeLoger — Нерухомість і оренда
--   SpareRoom — Нерухомість і оренда
--   Spotahome — Нерухомість і оренда
--   StreetEasy — Нерухомість і оренда
--   TIDY — Нерухомість і оренда
--   Trulia — Нерухомість і оренда
--   TurboTenant — Нерухомість і оренда
--   Virtual Staging AI — Нерухомість і оренда
--   Zillow — Нерухомість і оренда
--   Zoopla — Нерухомість і оренда
--   Zumper — Нерухомість і оренда
--   ЛУН — Нерухомість і оренда
--   AnyList — Домашнє господарство
--   Bring! — Домашнє господарство
--   Cozi Family Organizer — Домашнє господарство
--   FamilyWall — Домашнє господарство
--   Flatastic — Домашнє господарство
--   Grocy — Домашнє господарство
--   Hearth Display — Домашнє господарство
--   Helpling — Домашнє господарство
--   Homey (chores & allowance) — Домашнє господарство
--   HomeZada — Домашнє господарство
--   Listonic — Домашнє господарство
--   Maple — Домашнє господарство
--   Molly Maid — Домашнє господарство
--   Nipto — Домашнє господарство
--   NoWaste — Домашнє господарство
--   Olio — Домашнє господарство
--   OurGroceries — Домашнє господарство
--   S'moresUp — Домашнє господарство
--   Skylight — Домашнє господарство
--   Splitwise — Домашнє господарство
--   Sweepy — Домашнє господарство
--   Tody — Домашнє господарство
--   Too Good To Go — Домашнє господарство
--   Anker SOLIX — Енергія та резервне живлення
--   BLUETTI — Енергія та резервне живлення
--   EcoFlow — Енергія та резервне живлення
--   Emporia Energy — Енергія та резервне живлення
--   EnergySage — Енергія та резервне живлення
--   Enphase — Енергія та резервне живлення
--   Hive — Енергія та резервне живлення
--   Jackery — Енергія та резервне живлення
--   Loop — Енергія та резервне живлення
--   myenergi — Енергія та резервне живлення
--   Octopus Energy — Енергія та резервне живлення
--   OhmConnect — Енергія та резервне живлення
--   Project Sunroof — Енергія та резервне живлення
--   Rewiring America — Енергія та резервне живлення
--   Sense — Енергія та резервне живлення
--   SolarEdge — Енергія та резервне живлення
--   SPAN — Енергія та резервне живлення
--   Tesla Powerwall — Енергія та резервне живлення
--   Tibber — Енергія та резервне живлення
--   Victron Energy — Енергія та резервне живлення
--   WattBuy — Енергія та резервне живлення
--   YASNO — Енергія та резервне живлення
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);

-- Apple Home — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apple.com/home-app' OR LOWER(`name`) = LOWER('Apple Home'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Apple Home', NULL, 'https://www.apple.com/home-app/', NULL, NULL, 'Apple Home — застосунок «Дім» для iPhone, iPad, Mac і Apple Watch: керування пристроями HomeKit і Matter, сценарії, автоматизації й Siri.', 'Apple Home is the Home app for iPhone, iPad, Mac and Apple Watch: control HomeKit and Matter devices, scenes, automations and Siri.', 'Застосунок «Дім» від Apple дає змогу додавати пристрої HomeKit і Matter, групувати їх за кімнатами, створювати сцени й автоматизації, керувати ними через Siri та Пункт керування. Є захищене відео HomeKit для камер, гостьовий доступ і спільне керування домом для членів родини.', 'Apple''s Home app lets you add HomeKit and Matter devices, group them by room, create scenes and automations and control them via Siri and Control Center. It offers HomeKit Secure Video for cameras, guest access and shared home control for family members.', 'HomeKit і Matter
Сцени й автоматизації
Керування через Siri
HomeKit Secure Video', 'HomeKit and Matter
Scenes and automations
Siri control
HomeKit Secure Video', 'Користувачі пристроїв Apple.', 'Apple device users.', 'mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apple.com/home-app' OR LOWER(`name`) = LOWER('Apple Home')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Apple Home is the Home app for iPhone, iPad, Mac and Apple Watch: control HomeKit and Matter devices, scenes, automations and Siri.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Apple''s Home app lets you add HomeKit and Matter devices, group them by room, create scenes and automations and control them via Siri and Control Center. It offers HomeKit Secure Video for cameras, guest access and shared home control for family members.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'HomeKit and Matter
Scenes and automations
Siri control
HomeKit Secure Video', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Apple device users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Вбудований застосунок', 'Built-in app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Built-in app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Aqara — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aqara.com' OR LOWER(`name`) = LOWER('Aqara'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Aqara', NULL, 'https://www.aqara.com', NULL, NULL, 'Aqara — пристрої домашньої автоматизації: датчики, хаби, вимикачі, замки й камери, сумісні з Apple Home, Google, Alexa і Matter.', 'Aqara makes home automation devices: sensors, hubs, switches, locks and cameras compatible with Apple Home, Google, Alexa and Matter.', 'Виробник доступних Zigbee/Thread-датчиків (рух, двері, температура, протікання), хабів, розумних вимикачів, штор, замків і камер. Застосунок Aqara Home дозволяє створювати автоматизації, а пристрої працюють із головними платформами розумного дому та Matter.', 'A maker of affordable Zigbee/Thread sensors (motion, door, temperature, leak), hubs, smart switches, curtains, locks and cameras. The Aqara Home app builds automations, and devices work with the major smart home platforms and Matter.', 'Датчики й хаби
Розумні вимикачі
Замки й камери
Matter', 'Sensors and hubs
Smart switches
Locks and cameras
Matter', 'Ті, хто будує розумний дім на датчиках.', 'People building sensor-based smart homes.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aqara.com' OR LOWER(`name`) = LOWER('Aqara')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Aqara makes home automation devices: sensors, hubs, switches, locks and cameras compatible with Apple Home, Google, Alexa and Matter.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A maker of affordable Zigbee/Thread sensors (motion, door, temperature, leak), hubs, smart switches, curtains, locks and cameras. The Aqara Home app builds automations, and devices work with the major smart home platforms and Matter.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sensors and hubs
Smart switches
Locks and cameras
Matter', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People building sensor-based smart homes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок Aqara Home', 'Aqara Home app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Aqara Home app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Brilliant — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brilliant.tech' OR LOWER(`name`) = LOWER('Brilliant'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Brilliant', NULL, 'https://www.brilliant.tech', NULL, NULL, 'Brilliant — сенсорні панелі-вимикачі для керування світлом, безпекою й усім розумним домом із стіни.', 'Brilliant makes touchscreen switch panels to control lighting, security and the whole smart home from the wall.', 'Brilliant NextGen пропонує розумні панелі, що замінюють звичайні вимикачі: керують освітленням, камерами, замками, музикою й термостатами, мають датчик руху та інтеграції з Alexa, Google, Ring і Sonos. Є застосунок для керування з телефона.', 'Brilliant NextGen offers smart panels that replace light switches: they control lighting, cameras, locks, music and thermostats, include a motion sensor and integrate with Alexa, Google, Ring and Sonos. A phone app is also available.', 'Сенсорні вимикачі
Керування всім домом
Датчик руху
Інтеграції', 'Touchscreen switches
Whole-home control
Motion sensor
Integrations', 'Власники будинків.', 'Homeowners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brilliant.tech' OR LOWER(`name`) = LOWER('Brilliant')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Brilliant makes touchscreen switch panels to control lighting, security and the whole smart home from the wall.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Brilliant NextGen offers smart panels that replace light switches: they control lighting, cameras, locks, music and thermostats, include a motion sensor and integrate with Alexa, Google, Ring and Sonos. A phone app is also available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Touchscreen switches
Whole-home control
Motion sensor
Integrations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- Control4 — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'control4.com' OR LOWER(`name`) = LOWER('Control4'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Control4', NULL, 'https://www.control4.com', NULL, NULL, 'Control4 (Snap One) — професійні системи автоматизації будинку: освітлення, мультимедіа, клімат і безпека в одному інтерфейсі.', 'Control4 (Snap One) provides professional home automation: lighting, entertainment, climate and security in one interface.', 'Платформа для комплексної автоматизації будинку, яку проєктують і встановлюють сертифіковані дилери. Об''єднує освітлення, аудіо- й відеосистеми, клімат, замки, камери та сенсорні панелі; керування через застосунок, пульти й голос.', 'A whole-home automation platform designed and installed by certified dealers. It unifies lighting, audio-video, climate, locks, cameras and touch panels, controlled via app, remotes and voice.', 'Комплексна автоматизація
Мультимедіа
Сенсорні панелі
Через дилерів', 'Whole-home automation
Entertainment
Touch panels
Via dealers', 'Власники будинків, що замовляють інсталяцію.', 'Homeowners commissioning installs.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'control4.com' OR LOWER(`name`) = LOWER('Control4')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Control4 (Snap One) provides professional home automation: lighting, entertainment, climate and security in one interface.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A whole-home automation platform designed and installed by certified dealers. It unifies lighting, audio-video, climate, locks, cameras and touch panels, controlled via app, remotes and voice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Whole-home automation
Entertainment
Touch panels
Via dealers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners commissioning installs.', 'manual' FROM DUAL WHERE @new = 1;

-- Dreame — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dreametech.com' OR LOWER(`name`) = LOWER('Dreame'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dreame', NULL, 'https://www.dreametech.com', NULL, NULL, 'Dreame — роботи-пилососи, мийні пилососи, бездротові пилососи, роботи-газонокосарки й для басейнів з AI та застосунком Dreamehome.', 'Dreame makes robot vacuums, wet-dry vacuums, cordless vacuums, lawn and pool robots with AI and the Dreamehome app.', 'Бренд техніки для прибирання та догляду. Пропонує роботи-пилососи з мийкою і самоочищенням, вертикальні та мийні пилососи, роботи-газонокосарки, роботи для басейнів, очищувачі повітря й фени. Застосунок Dreamehome керує картами, режимами й графіками.', 'A cleaning and care appliance brand offering robot vacuums with mopping and self-cleaning, stick and wet-dry vacuums, robotic lawn mowers, pool robots, air purifiers and hair dryers. The Dreamehome app manages maps, modes and schedules.', 'Роботи-пилососи
Роботи-газонокосарки
Роботи для басейнів
Застосунок Dreamehome', 'Robot vacuums
Robotic mowers
Pool robots
Dreamehome app', 'Власники домів і ділянок.', 'Home and yard owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dreametech.com' OR LOWER(`name`) = LOWER('Dreame')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Dreame makes robot vacuums, wet-dry vacuums, cordless vacuums, lawn and pool robots with AI and the Dreamehome app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A cleaning and care appliance brand offering robot vacuums with mopping and self-cleaning, stick and wet-dry vacuums, robotic lawn mowers, pool robots, air purifiers and hair dryers. The Dreamehome app manages maps, modes and schedules.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Robot vacuums
Robotic mowers
Pool robots
Dreamehome app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Home and yard owners.', 'manual' FROM DUAL WHERE @new = 1;

-- ecobee — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ecobee.com' OR LOWER(`name`) = LOWER('ecobee'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ecobee', NULL, 'https://www.ecobee.com', NULL, NULL, 'ecobee — розумні термостати, камери й датчики, що разом економлять енергію і пильнують дім; застосунок і моніторинг.', 'ecobee makes smart thermostats, cameras and sensors that work together to save energy and protect the home; app and monitoring.', 'Канадський виробник розумних термостатів із виносними датчиками SmartSensor, що враховують присутність і температуру в кімнатах. Також пропонує камери, відеодзвінки й датчики безпеки з підпискою Haven. Застосунок дає звіти про енергоспоживання та керування з будь-якого місця.', 'A Canadian maker of smart thermostats with SmartSensor room sensors that account for occupancy and temperature. It also offers cameras, video doorbells and security sensors with a Haven subscription. The app provides energy reports and control from anywhere.', 'Розумні термостати
Кімнатні датчики
Звіти енергоспоживання
Камери й безпека', 'Smart thermostats
Room sensors
Energy reports
Cameras and security', 'Власники будинків у Північній Америці.', 'Homeowners in North America.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ecobee.com' OR LOWER(`name`) = LOWER('ecobee')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ecobee makes smart thermostats, cameras and sensors that work together to save energy and protect the home; app and monitoring.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Canadian maker of smart thermostats with SmartSensor room sensors that account for occupancy and temperature. It also offers cameras, video doorbells and security sensors with a Haven subscription. The app provides energy reports and control from anywhere.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Smart thermostats
Room sensors
Energy reports
Cameras and security', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners in North America.', 'manual' FROM DUAL WHERE @new = 1;

-- ECOVACS — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ecovacs.com' OR LOWER(`name`) = LOWER('ECOVACS'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ECOVACS', NULL, 'https://www.ecovacs.com', NULL, NULL, 'ECOVACS — домашні роботи DEEBOT (пилососи й мийні), WINBOT (мийники вікон) та інші з застосунком ECOVACS HOME.', 'ECOVACS makes DEEBOT vacuum-mop robots, WINBOT window cleaners and other home robots with the ECOVACS HOME app.', 'Виробник домашньої робототехніки. DEEBOT пилососять і миють підлогу з AI-уникненням перешкод і станціями самоочищення, WINBOT миє вікна, є роботи для газону. Застосунок ECOVACS HOME керує картами, зонами й розкладами та має голосовий асистент YIKO.', 'A home robotics maker. DEEBOT vacuums and mops with AI obstacle avoidance and self-cleaning stations, WINBOT cleans windows, and there are lawn robots. The ECOVACS HOME app manages maps, zones and schedules and includes the YIKO voice assistant.', 'DEEBOT
WINBOT для вікон
AI-уникнення перешкод
Асистент YIKO', 'DEEBOT
WINBOT window robot
AI obstacle avoidance
YIKO assistant', 'Ті, хто автоматизує прибирання.', 'People automating cleaning.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ecovacs.com' OR LOWER(`name`) = LOWER('ECOVACS')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ECOVACS makes DEEBOT vacuum-mop robots, WINBOT window cleaners and other home robots with the ECOVACS HOME app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A home robotics maker. DEEBOT vacuums and mops with AI obstacle avoidance and self-cleaning stations, WINBOT cleans windows, and there are lawn robots. The ECOVACS HOME app manages maps, zones and schedules and includes the YIKO voice assistant.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'DEEBOT
WINBOT window robot
AI obstacle avoidance
YIKO assistant', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People automating cleaning.', 'manual' FROM DUAL WHERE @new = 1;

-- Eve Home — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'evehome.com' OR LOWER(`name`) = LOWER('Eve Home'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eve Home', NULL, 'https://www.evehome.com', NULL, NULL, 'Eve — екосистема розумних аксесуарів для Apple Home і Matter: термостати, датчики, розетки, камери, без хмари й реєстрації.', 'Eve is an ecosystem of smart accessories for Apple Home and Matter: thermostats, sensors, plugs and cameras, no cloud or sign-up.', 'Німецький виробник аксесуарів для розумного дому, створених для HomeKit, а тепер і Matter. Лінійка включає термостатичні голівки, датчики дверей і вікон, руху, якості повітря, розумні розетки з енергомоніторингом і камери. Застосунок Eve дає детальну статистику й автоматизації без облікового запису.', 'A German maker of smart home accessories built for HomeKit and now Matter. The line includes thermostatic radiator valves, door/window, motion and air-quality sensors, smart plugs with energy monitoring and cameras. The Eve app provides detailed stats and automations without an account.', 'HomeKit і Matter
Термостати
Датчики якості повітря
Без облікового запису', 'HomeKit and Matter
Thermostats
Air-quality sensors
No account needed', 'Користувачі Apple Home.', 'Apple Home users.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'evehome.com' OR LOWER(`name`) = LOWER('Eve Home')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Eve is an ecosystem of smart accessories for Apple Home and Matter: thermostats, sensors, plugs and cameras, no cloud or sign-up.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A German maker of smart home accessories built for HomeKit and now Matter. The line includes thermostatic radiator valves, door/window, motion and air-quality sensors, smart plugs with energy monitoring and cameras. The Eve app provides detailed stats and automations without an account.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'HomeKit and Matter
Thermostats
Air-quality sensors
No account needed', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Apple Home users.', 'manual' FROM DUAL WHERE @new = 1;

-- eWeLink — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ewelink.cc' OR LOWER(`name`) = LOWER('eWeLink'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'eWeLink', NULL, 'https://ewelink.cc', NULL, NULL, 'eWeLink — застосунок і хмара для пристроїв SONOFF та тисяч сумісних брендів: сцени, Android Auto й CarPlay, веб-доступ.', 'eWeLink is the app and cloud for SONOFF devices and thousands of compatible brands: scenes, Android Auto and CarPlay, web access.', 'Платформа для керування реле, вимикачами, датчиками й камерами SONOFF та інших виробників. Дає змогу запускати сцени з Android Auto та CarPlay, керувати домом з браузера (eWeLink Web), транслювати дашборд на планшет (eWeLink CAST). Є платна підписка з розширеними функціями.', 'A platform for controlling SONOFF and other brands'' relays, switches, sensors and cameras. It runs scenes from Android Auto and CarPlay, controls the home from a browser (eWeLink Web) and casts a dashboard to a tablet (eWeLink CAST). A paid subscription adds advanced features.', 'Пристрої SONOFF
Сцени в авто
Веб-доступ
Дашборд CAST', 'SONOFF devices
In-car scenes
Web access
CAST dashboard', 'Власники пристроїв SONOFF.', 'SONOFF device owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ewelink.cc' OR LOWER(`name`) = LOWER('eWeLink')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'eWeLink is the app and cloud for SONOFF devices and thousands of compatible brands: scenes, Android Auto and CarPlay, web access.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform for controlling SONOFF and other brands'' relays, switches, sensors and cameras. It runs scenes from Android Auto and CarPlay, controls the home from a browser (eWeLink Web) and casts a dashboard to a tablet (eWeLink CAST). A paid subscription adds advanced features.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'SONOFF devices
In-car scenes
Web access
CAST dashboard', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'SONOFF device owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базові функції', 'Core features' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Core features', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- FIBARO — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fibaro.com' OR LOWER(`name`) = LOWER('FIBARO'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'FIBARO', NULL, 'https://www.fibaro.com', NULL, NULL, 'FIBARO — бездротові системи домашньої автоматизації: контролери Home Center, датчики, реле й модулі, сумісні з HomeKit і Siri.', 'FIBARO offers wireless home automation: Home Center controllers, sensors, relays and modules compatible with HomeKit and Siri.', 'Польський бренд (Nice Group) з центральними контролерами Home Center, датчиками руху, диму, протікання, модулями для освітлення й рольставень. Застосунок FIBARO Home дає керування й сценарії; частина пристроїв підтримує Apple HomeKit. Систему часто встановлюють інсталятори.', 'A Polish brand (Nice Group) with Home Center controllers, motion, smoke and leak sensors and modules for lighting and shutters. The FIBARO Home app provides control and scenes; some devices support Apple HomeKit. Systems are often installed by integrators.', 'Контролери Home Center
Датчики безпеки
Модулі освітлення
HomeKit', 'Home Center controllers
Safety sensors
Lighting modules
HomeKit', 'Власники будинків та інсталятори.', 'Homeowners and installers.', 'mobile,web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fibaro.com' OR LOWER(`name`) = LOWER('FIBARO')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'FIBARO offers wireless home automation: Home Center controllers, sensors, relays and modules compatible with HomeKit and Siri.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Polish brand (Nice Group) with Home Center controllers, motion, smoke and leak sensors and modules for lighting and shutters. The FIBARO Home app provides control and scenes; some devices support Apple HomeKit. Systems are often installed by integrators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Home Center controllers
Safety sensors
Lighting modules
HomeKit', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners and installers.', 'manual' FROM DUAL WHERE @new = 1;

-- Google Home — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'home.google.com' OR LOWER(`name`) = LOWER('Google Home'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Google Home', NULL, 'https://home.google.com', NULL, NULL, 'Google Home — застосунок і платформа розумного дому з Gemini: керування тисячами пристроїв, автоматизації, камери й голосові команди.', 'Google Home is a smart home app and platform powered by Gemini: control thousands of devices, automations, cameras and voice commands.', 'Google Home об''єднує світло, термостати, камери, дзвінки, колонки й інші пристрої в одному застосунку. Gemini допомагає створювати автоматизації звичайною мовою, шукати події в записах камер і керувати домом голосом. Підтримує Matter і тисячі сумісних пристроїв різних брендів.', 'Google Home brings lights, thermostats, cameras, doorbells, speakers and other devices into one app. Gemini helps create automations in plain language, search camera events and control the home by voice. It supports Matter and thousands of compatible devices from many brands.', 'Керування пристроями
Автоматизації з Gemini
Пошук у записах камер
Підтримка Matter', 'Device control
Gemini automations
Camera event search
Matter support', 'Власники розумних пристроїв Google і сумісних брендів.', 'Owners of Google and compatible smart devices.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'home.google.com' OR LOWER(`name`) = LOWER('Google Home')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Google Home is a smart home app and platform powered by Gemini: control thousands of devices, automations, cameras and voice commands.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Google Home brings lights, thermostats, cameras, doorbells, speakers and other devices into one app. Gemini helps create automations in plain language, search camera events and control the home by voice. It supports Matter and thousands of compatible devices from many brands.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Device control
Gemini automations
Camera event search
Matter support', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Owners of Google and compatible smart devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок Google Home', 'Google Home app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Google Home app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Govee — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'govee.com' OR LOWER(`name`) = LOWER('Govee'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Govee', NULL, 'https://www.govee.com', NULL, NULL, 'Govee — розумне RGBIC-освітлення: стрічки, вуличні гірлянди, торшери, підсвітка ТВ і геймерське світло з застосунком Govee Home.', 'Govee makes RGBIC smart lighting: strips, outdoor lights, floor lamps, TV backlights and gaming lights with the Govee Home app.', 'Бренд недорогого декоративного освітлення з технологією RGBIC (кілька кольорів на одній стрічці). Пропонує постійні вуличні гірлянди, торшери, підсвітку ТВ із камерою, стрічки, лампи та датчики. Застосунок Govee Home має сотні сцен, синхронізацію з музикою й працює з Alexa і Google.', 'A budget decorative lighting brand using RGBIC (multiple colors on one strip). It offers permanent outdoor lights, floor lamps, camera-based TV backlights, strips, bulbs and sensors. The Govee Home app has hundreds of scenes, music sync and works with Alexa and Google.', 'RGBIC-стрічки
Підсвітка ТВ
Вуличне світло
Сотні сцен', 'RGBIC strips
TV backlights
Outdoor lights
Hundreds of scenes', 'Любителі декоративного освітлення.', 'Decorative lighting fans.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'govee.com' OR LOWER(`name`) = LOWER('Govee')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Govee makes RGBIC smart lighting: strips, outdoor lights, floor lamps, TV backlights and gaming lights with the Govee Home app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A budget decorative lighting brand using RGBIC (multiple colors on one strip). It offers permanent outdoor lights, floor lamps, camera-based TV backlights, strips, bulbs and sensors. The Govee Home app has hundreds of scenes, music sync and works with Alexa and Google.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'RGBIC strips
TV backlights
Outdoor lights
Hundreds of scenes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Decorative lighting fans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок Govee Home', 'Govee Home app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Govee Home app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Home Assistant — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'home-assistant.io' OR LOWER(`name`) = LOWER('Home Assistant'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Home Assistant', NULL, 'https://www.home-assistant.io', NULL, NULL, 'Home Assistant — відкрита платформа домашньої автоматизації з локальним керуванням і приватністю: тисячі інтеграцій, автоматизації, голосовий асистент.', 'Home Assistant is open-source home automation focused on local control and privacy: thousands of integrations, automations and a voice assistant.', 'Безкоштовна платформа з відкритим кодом, яку підтримує світова спільнота. Працює локально на Raspberry Pi, мініпк чи пристрої Home Assistant Green, інтегрує тисячі пристроїв і сервісів, дозволяє будувати дашборди, автоматизації, енергомоніторинг і власний голосовий асистент. Віддалений доступ і хмарні функції — за підпискою Home Assistant Cloud.', 'A free, open-source platform backed by a worldwide community. It runs locally on a Raspberry Pi, mini PC or Home Assistant Green, integrates thousands of devices and services and lets you build dashboards, automations, energy monitoring and your own voice assistant. Remote access and cloud features come with a Home Assistant Cloud subscription.', 'Локальне керування
Тисячі інтеграцій
Енергомоніторинг
Власний голосовий асистент', 'Local control
Thousands of integrations
Energy monitoring
Own voice assistant', 'Ентузіасти розумного дому.', 'Smart home enthusiasts.', 'web,mobile,desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'home-assistant.io' OR LOWER(`name`) = LOWER('Home Assistant')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Home Assistant is open-source home automation focused on local control and privacy: thousands of integrations, automations and a voice assistant.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A free, open-source platform backed by a worldwide community. It runs locally on a Raspberry Pi, mini PC or Home Assistant Green, integrates thousands of devices and services and lets you build dashboards, automations, energy monitoring and your own voice assistant. Remote access and cloud features come with a Home Assistant Cloud subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local control
Thousands of integrations
Energy monitoring
Own voice assistant', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Smart home enthusiasts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовне ПЗ', 'Free software' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free software', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Homebridge — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'homebridge.io' OR LOWER(`name`) = LOWER('Homebridge'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Homebridge', NULL, 'https://homebridge.io', NULL, NULL, 'Homebridge — відкритий сервер, що додає до Apple Home пристрої без підтримки HomeKit через тисячі плагінів спільноти.', 'Homebridge is an open-source server that brings non-HomeKit devices into Apple Home through thousands of community plugins.', 'Легкий сервер на Node.js, що працює на Raspberry Pi, NAS чи комп''ютері й емулює HomeKit API. Плагіни спільноти підключають камери, кондиціонери, пилососи та інші пристрої, яких офіційно немає в Apple Home. Має веб-інтерфейс для налаштування й безкоштовний.', 'A lightweight Node.js server that runs on a Raspberry Pi, NAS or computer and emulates the HomeKit API. Community plugins connect cameras, air conditioners, vacuums and other devices not officially in Apple Home. It has a web UI for setup and is free.', 'Тисячі плагінів
Веб-інтерфейс
Raspberry Pi
Open source', 'Thousands of plugins
Web UI
Raspberry Pi
Open source', 'Користувачі Apple Home з «несумісними» пристроями.', 'Apple Home users with unsupported devices.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'homebridge.io' OR LOWER(`name`) = LOWER('Homebridge')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Homebridge is an open-source server that brings non-HomeKit devices into Apple Home through thousands of community plugins.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A lightweight Node.js server that runs on a Raspberry Pi, NAS or computer and emulates the HomeKit API. Community plugins connect cameras, air conditioners, vacuums and other devices not officially in Apple Home. It has a web UI for setup and is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Thousands of plugins
Web UI
Raspberry Pi
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Apple Home users with unsupported devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовно', 'Free' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Homey — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'homey.app' OR LOWER(`name`) = LOWER('Homey'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Homey', NULL, 'https://homey.app', NULL, NULL, 'Homey (Athom/LG) — керування, автоматизація й моніторинг усього розумного дому з одного місця: понад 70 000 пристроїв тисяч брендів.', 'Homey (Athom/LG) controls, automates and monitors the whole smart home from one place: 70,000+ devices from thousands of brands.', 'Homey підтримує понад 70 000 пристроїв і пропонує візуальні автоматизації Flows, енергомоніторинг і дашборди. Є хаб Homey Pro (одноразова покупка, без підписок) і хмарний Homey Cloud: безкоштовно до 5 пристроїв, далі Premium за підпискою; Homey Bridge продається окремо.', 'Homey supports over 70,000 devices and offers visual Flows automations, energy monitoring and dashboards. There is the Homey Pro hub (one-time purchase, no subscriptions) and Homey Cloud: free up to 5 devices, then Premium by subscription; Homey Bridge is sold separately.', '70 000+ пристроїв
Візуальні автоматизації Flows
Енергомоніторинг
Без підписки на Pro', '70,000+ devices
Visual Flows automations
Energy monitoring
No subscription on Pro', 'Власники пристроїв різних брендів.', 'Owners of devices from many brands.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'homey.app' OR LOWER(`name`) = LOWER('Homey')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Homey (Athom/LG) controls, automates and monitors the whole smart home from one place: 70,000+ devices from thousands of brands.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Homey supports over 70,000 devices and offers visual Flows automations, energy monitoring and dashboards. There is the Homey Pro hub (one-time purchase, no subscriptions) and Homey Cloud: free up to 5 devices, then Premium by subscription; Homey Bridge is sold separately.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '70,000+ devices
Visual Flows automations
Energy monitoring
No subscription on Pro', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Owners of devices from many brands.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Homey Cloud', 'Homey Cloud', 0.00, 'free', 'До 5 пристроїв', 'Up to 5 devices' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Homey Cloud' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Homey Cloud', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Up to 5 devices', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium', 'Premium', 2.99, 'month', 'Більше пристроїв у Homey Cloud', 'More devices in Homey Cloud' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'More devices in Homey Cloud', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Homey Pro', 'Homey Pro', 449.00, 'one_time', 'Хаб, без підписок (€)', 'Hub, no subscriptions (€)' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Homey Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Homey Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Hub, no subscriptions (€)', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hubitat Elevation — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hubitat.com' OR LOWER(`name`) = LOWER('Hubitat Elevation'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hubitat Elevation', NULL, 'https://hubitat.com', NULL, NULL, 'Hubitat Elevation — локальний хаб домашньої автоматизації без залежності від хмари: Z-Wave, Zigbee, Matter, правила й дашборди.', 'Hubitat Elevation is a local home automation hub that doesn''t depend on the cloud: Z-Wave, Zigbee, Matter, rules and dashboards.', 'Hubitat — це апаратний хаб, що виконує автоматизації локально, тому працює швидко, надійно й приватно навіть без інтернету. Підключає пристрої Z-Wave, Zigbee, Matter і Wi-Fi, має конструктор правил, дашборди, мобільний застосунок і спільноту з власними інтеграціями.', 'Hubitat is a hardware hub that runs automations locally, so it is fast, reliable and private even without internet. It connects Z-Wave, Zigbee, Matter and Wi-Fi devices and offers a rule builder, dashboards, a mobile app and a community with custom integrations.', 'Локальне виконання
Z-Wave, Zigbee, Matter
Конструктор правил
Дашборди', 'Local processing
Z-Wave, Zigbee, Matter
Rule builder
Dashboards', 'Ті, хто хоче приватний і надійний розумний дім.', 'People wanting a private, reliable smart home.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hubitat.com' OR LOWER(`name`) = LOWER('Hubitat Elevation')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Hubitat Elevation is a local home automation hub that doesn''t depend on the cloud: Z-Wave, Zigbee, Matter, rules and dashboards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hubitat is a hardware hub that runs automations locally, so it is fast, reliable and private even without internet. It connects Z-Wave, Zigbee, Matter and Wi-Fi devices and offers a rule builder, dashboards, a mobile app and a community with custom integrations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local processing
Z-Wave, Zigbee, Matter
Rule builder
Dashboards', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People wanting a private, reliable smart home.', 'manual' FROM DUAL WHERE @new = 1;

-- iRobot (Roomba) — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'irobot.com' OR LOWER(`name`) = LOWER('iRobot (Roomba)'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'iRobot (Roomba)', NULL, 'https://www.irobot.com', NULL, NULL, 'iRobot — роботи-пилососи Roomba й мийні роботи Braava з застосунком iRobot Home: карти, розклади й самоспорожнення.', 'iRobot makes Roomba robot vacuums and Braava mops with the iRobot Home app: maps, schedules and self-emptying.', 'Піонер роботів-прибиральників. Roomba та комбіновані моделі з мийкою прибирають за розкладом, будують карти кімнат, уникають перешкод і спорожнюються на базі. Застосунок iRobot Home дозволяє обирати кімнати, режими й працює з Alexa та Google.', 'A pioneer of cleaning robots. Roomba and combo mop models clean on schedule, map rooms, avoid obstacles and auto-empty at the base. The iRobot Home app selects rooms and modes and works with Alexa and Google.', 'Roomba і Braava
Карти кімнат
Самоспорожнення
Голосові асистенти', 'Roomba and Braava
Room maps
Self-emptying
Voice assistants', 'Ті, хто хоче робота-пилососа.', 'People wanting a robot vacuum.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'irobot.com' OR LOWER(`name`) = LOWER('iRobot (Roomba)')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'iRobot makes Roomba robot vacuums and Braava mops with the iRobot Home app: maps, schedules and self-emptying.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A pioneer of cleaning robots. Roomba and combo mop models clean on schedule, map rooms, avoid obstacles and auto-empty at the base. The iRobot Home app selects rooms and modes and works with Alexa and Google.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Roomba and Braava
Room maps
Self-emptying
Voice assistants', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People wanting a robot vacuum.', 'manual' FROM DUAL WHERE @new = 1;

-- Josh.ai — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'josh.ai' OR LOWER(`name`) = LOWER('Josh.ai'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Josh.ai', NULL, 'https://www.josh.ai', NULL, NULL, 'Josh.ai — преміальна система керування розумним домом з AI і природною мовою, що встановлюється інтеграторами.', 'Josh.ai is a premium AI smart home control system with natural language, installed by integrators.', 'Система для елітних будинків, яка поєднує освітлення, клімат, мультимедіа, штори й безпеку і керує ними природною мовою з фокусом на приватності. Працює з мікрофонами Josh Nano, застосунками й панелями; продається та налаштовується через сертифікованих дилерів.', 'A system for luxury homes combining lighting, climate, media, shades and security, controlled by natural language with a privacy focus. It works with Josh Nano microphones, apps and panels and is sold and configured through certified dealers.', 'Керування природною мовою
Приватність
Інтеграція мультимедіа
Через дилерів', 'Natural-language control
Privacy
Media integration
Via dealers', 'Власники преміальних будинків.', 'Owners of premium homes.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'josh.ai' OR LOWER(`name`) = LOWER('Josh.ai')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Josh.ai is a premium AI smart home control system with natural language, installed by integrators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A system for luxury homes combining lighting, climate, media, shades and security, controlled by natural language with a privacy focus. It works with Josh Nano microphones, apps and panels and is sold and configured through certified dealers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Natural-language control
Privacy
Media integration
Via dealers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Owners of premium homes.', 'manual' FROM DUAL WHERE @new = 1;

-- Kasa Smart — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kasasmart.com' OR LOWER(`name`) = LOWER('Kasa Smart'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kasa Smart', NULL, 'https://www.kasasmart.com', NULL, NULL, 'Kasa Smart від TP-Link — розумні вимикачі, розетки, лампи й відеодзвінки в одному застосунку Kasa.', 'Kasa Smart by TP-Link offers smart switches, plugs, bulbs and video doorbells in one Kasa app.', 'Лінійка TP-Link для ринку США: розумні вимикачі й димери, розетки, лампи, камери та відеодзвінки. Застосунок Kasa керує пристроями з будь-якого місця, налаштовує розклади, сцени й режим «відсутності» та працює з Alexa і Google Assistant.', 'TP-Link''s US line of smart switches and dimmers, plugs, bulbs, cameras and video doorbells. The Kasa app controls devices from anywhere, sets schedules, scenes and away mode and works with Alexa and Google Assistant.', 'Вимикачі й розетки
Відеодзвінки
Розклади й сцени
Режим відсутності', 'Switches and plugs
Video doorbells
Schedules and scenes
Away mode', 'Власники домів у США.', 'US homeowners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kasasmart.com' OR LOWER(`name`) = LOWER('Kasa Smart')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Kasa Smart by TP-Link offers smart switches, plugs, bulbs and video doorbells in one Kasa app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TP-Link''s US line of smart switches and dimmers, plugs, bulbs, cameras and video doorbells. The Kasa app controls devices from anywhere, sets schedules, scenes and away mode and works with Alexa and Google Assistant.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Switches and plugs
Video doorbells
Schedules and scenes
Away mode', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US homeowners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок Kasa', 'Kasa app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Kasa app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- LIFX — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lifx.com' OR LOWER(`name`) = LOWER('LIFX'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LIFX', NULL, 'https://www.lifx.com', NULL, NULL, 'LIFX — розумні Wi-Fi лампи, стрічки, стельові й вуличні світильники без хаба, з мільярдами кольорів і підтримкою Alexa, Google, Apple Home.', 'LIFX makes Wi-Fi smart bulbs, strips, ceiling and outdoor lights with no hub, billions of colors and Alexa, Google and Apple Home support.', 'Освітлення, що підключається напряму до Wi-Fi без хаба. Лампи, стрічки, стельові світильники, спот-лампи й вуличні серії з багатозонними кольорами. Застосунок LIFX пропонує ефекти, розклади й сцени; є інтеграції з Alexa, Google і Apple Home.', 'Lighting that connects straight to Wi-Fi without a hub. Bulbs, strips, ceiling lights, spotlights and outdoor series with multi-zone color. The LIFX app offers effects, schedules and scenes, with Alexa, Google and Apple Home integrations.', 'Без хаба
Багатозонний колір
Ефекти й сцени
Apple, Google, Alexa', 'No hub
Multi-zone color
Effects and scenes
Apple, Google, Alexa', 'Ті, хто хоче кольорове світло без хаба.', 'People wanting color lighting without a hub.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lifx.com' OR LOWER(`name`) = LOWER('LIFX')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'LIFX makes Wi-Fi smart bulbs, strips, ceiling and outdoor lights with no hub, billions of colors and Alexa, Google and Apple Home support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Lighting that connects straight to Wi-Fi without a hub. Bulbs, strips, ceiling lights, spotlights and outdoor series with multi-zone color. The LIFX app offers effects, schedules and scenes, with Alexa, Google and Apple Home integrations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'No hub
Multi-zone color
Effects and scenes
Apple, Google, Alexa', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People wanting color lighting without a hub.', 'manual' FROM DUAL WHERE @new = 1;

-- Meross — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'meross.com' OR LOWER(`name`) = LOWER('Meross'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Meross', NULL, 'https://www.meross.com', NULL, NULL, 'Meross — розумні розетки, вимикачі, лампи, датчики й гаражні контролери, сумісні з HomeKit, Google Home, Alexa та Matter.', 'Meross makes smart plugs, switches, bulbs, sensors and garage openers compatible with HomeKit, Google Home, Alexa and Matter.', 'Виробник доступних розумних пристроїв: розеток з енергомоніторингом, вимикачів, ламп, термостатів, датчиків і контролерів гаражних воріт. Застосунок Meross керує ними, а підтримка HomeKit, Google, Alexa й Matter дозволяє інтегрувати їх у будь-яку екосистему.', 'A maker of affordable smart devices: plugs with energy monitoring, switches, bulbs, thermostats, sensors and garage door openers. The Meross app controls them, and HomeKit, Google, Alexa and Matter support fits them into any ecosystem.', 'Розетки з моніторингом
Гаражні контролери
HomeKit і Matter
Недорого', 'Energy-monitoring plugs
Garage openers
HomeKit and Matter
Affordable', 'Ті, хто збирає розумний дім недорого.', 'People building a smart home affordably.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'meross.com' OR LOWER(`name`) = LOWER('Meross')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Meross makes smart plugs, switches, bulbs, sensors and garage openers compatible with HomeKit, Google Home, Alexa and Matter.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A maker of affordable smart devices: plugs with energy monitoring, switches, bulbs, thermostats, sensors and garage door openers. The Meross app controls them, and HomeKit, Google, Alexa and Matter support fits them into any ecosystem.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Energy-monitoring plugs
Garage openers
HomeKit and Matter
Affordable', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People building a smart home affordably.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок Meross', 'Meross app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Meross app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Nanoleaf — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nanoleaf.me' OR LOWER(`name`) = LOWER('Nanoleaf'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nanoleaf', NULL, 'https://nanoleaf.me', NULL, NULL, 'Nanoleaf — декоративні світлові панелі, стрічки й лампи з AI-сценами, синхронізацією з музикою та іграми й підтримкою Matter.', 'Nanoleaf makes decorative light panels, strips and bulbs with AI scenes, music and game sync and Matter support.', 'Модульні світлові панелі (Shapes, Lines, Canvas), стрічки, лампи й гірлянди. Застосунок Nanoleaf генерує сцени, синхронізує світло з музикою, екраном і іграми, підтримує Matter і Thread. Бренд також пропонує дисплеї й пристрої для добробуту.', 'Modular light panels (Shapes, Lines, Canvas), strips, bulbs and string lights. The Nanoleaf app generates scenes, syncs light with music, screen and games and supports Matter and Thread. The brand also offers displays and wellness devices.', 'Модульні панелі
AI-сцени
Синхронізація з музикою
Matter і Thread', 'Modular panels
AI scenes
Music sync
Matter and Thread', 'Геймери та любителі декоративного світла.', 'Gamers and decorative lighting fans.', 'mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nanoleaf.me' OR LOWER(`name`) = LOWER('Nanoleaf')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Nanoleaf makes decorative light panels, strips and bulbs with AI scenes, music and game sync and Matter support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Modular light panels (Shapes, Lines, Canvas), strips, bulbs and string lights. The Nanoleaf app generates scenes, syncs light with music, screen and games and supports Matter and Thread. The brand also offers displays and wellness devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Modular panels
AI scenes
Music sync
Matter and Thread', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gamers and decorative lighting fans.', 'manual' FROM DUAL WHERE @new = 1;

-- Netatmo — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'netatmo.com' OR LOWER(`name`) = LOWER('Netatmo'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Netatmo', NULL, 'https://www.netatmo.com', NULL, NULL, 'Netatmo (Legrand) — розумні термостати, камери, дзвінки, датчики диму й метеостанції з застосунками Home+Control, Security та Weather.', 'Netatmo (Legrand) makes smart thermostats, cameras, doorbells, smoke alarms and weather stations with Home+Control, Security and Weather apps.', 'Французький бренд розумних пристроїв для комфорту й безпеки. Камери з розпізнаванням облич і локальним зберіганням без підписки, розумні термостати й термоголівки, датчики диму й CO, а також популярна домашня метеостанція. Працює з Apple Home, Google і Alexa.', 'A French smart device brand for comfort and safety. Cameras with face recognition and local storage without a subscription, smart thermostats and radiator valves, smoke and CO alarms, plus a popular home weather station. Works with Apple Home, Google and Alexa.', 'Камери без підписки
Розумні термостати
Датчики диму
Метеостанція', 'No-subscription cameras
Smart thermostats
Smoke alarms
Weather station', 'Власники квартир і будинків.', 'Apartment and house owners.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'netatmo.com' OR LOWER(`name`) = LOWER('Netatmo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Netatmo (Legrand) makes smart thermostats, cameras, doorbells, smoke alarms and weather stations with Home+Control, Security and Weather apps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A French smart device brand for comfort and safety. Cameras with face recognition and local storage without a subscription, smart thermostats and radiator valves, smoke and CO alarms, plus a popular home weather station. Works with Apple Home, Google and Alexa.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'No-subscription cameras
Smart thermostats
Smoke alarms
Weather station', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Apartment and house owners.', 'manual' FROM DUAL WHERE @new = 1;

-- openHAB — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'openhab.org' OR LOWER(`name`) = LOWER('openHAB'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'openHAB', NULL, 'https://www.openhab.org', NULL, NULL, 'openHAB — відкрите програмне забезпечення домашньої автоматизації, незалежне від виробників і технологій, з локальною роботою.', 'openHAB is open-source home automation software that is vendor- and technology-agnostic and runs locally.', 'Java-платформа з відкритим кодом, що об''єднує сотні технологій і брендів через «біндинги». Підтримує правила, сценарії, графіки, інтерфейси для браузера й мобільних застосунків і віддалений доступ через myopenHAB. Розробляється спільнотою.', 'An open-source Java platform unifying hundreds of technologies and brands via bindings. It supports rules, scripts, charts, browser and mobile UIs and remote access via myopenHAB. It is community-developed.', 'Сотні біндингів
Правила й скрипти
Мобільні застосунки
Open source', 'Hundreds of bindings
Rules and scripts
Mobile apps
Open source', 'Технічно підковані власники домів.', 'Tech-savvy homeowners.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'openhab.org' OR LOWER(`name`) = LOWER('openHAB')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'openHAB is open-source home automation software that is vendor- and technology-agnostic and runs locally.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An open-source Java platform unifying hundreds of technologies and brands via bindings. It supports rules, scripts, charts, browser and mobile UIs and remote access via myopenHAB. It is community-developed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hundreds of bindings
Rules and scripts
Mobile apps
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tech-savvy homeowners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовно', 'Free' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Philips Hue — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'philips-hue.com' OR LOWER(`name`) = LOWER('Philips Hue'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Philips Hue', NULL, 'https://www.philips-hue.com', NULL, NULL, 'Philips Hue — розумне освітлення й домашня безпека: лампи, стрічки, вуличні світильники, сцени, синхронізація з ТВ і застосунок Hue.', 'Philips Hue offers smart lighting and home security: bulbs, strips, outdoor lights, scenes, TV sync and the Hue app.', 'Екосистема розумного світла з мільйонами кольорів і відтінків білого. Застосунок Hue керує сценами, розкладами, автоматизаціями й синхронізацією світла з ТВ, музикою та іграми; працює з Alexa, Google, Apple Home і Matter. Також пропонує камери, датчики й систему безпеки Hue Secure.', 'A smart lighting ecosystem with millions of colors and shades of white. The Hue app handles scenes, schedules, automations and syncing light with TV, music and games; it works with Alexa, Google, Apple Home and Matter. It also offers cameras, sensors and the Hue Secure security system.', 'Мільйони кольорів
Сцени й розклади
Синхронізація з ТВ
Hue Secure', 'Millions of colors
Scenes and schedules
TV sync
Hue Secure', 'Ті, хто хоче розумне освітлення.', 'People wanting smart lighting.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'philips-hue.com' OR LOWER(`name`) = LOWER('Philips Hue')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Philips Hue offers smart lighting and home security: bulbs, strips, outdoor lights, scenes, TV sync and the Hue app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A smart lighting ecosystem with millions of colors and shades of white. The Hue app handles scenes, schedules, automations and syncing light with TV, music and games; it works with Alexa, Google, Apple Home and Matter. It also offers cameras, sensors and the Hue Secure security system.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Millions of colors
Scenes and schedules
TV sync
Hue Secure', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People wanting smart lighting.', 'manual' FROM DUAL WHERE @new = 1;

-- Roborock — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'global.roborock.com' OR LOWER(`name`) = LOWER('Roborock'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Roborock', NULL, 'https://global.roborock.com', NULL, NULL, 'Roborock — роботи-пилососи й мийні роботи з картографуванням, розпізнаванням перешкод і станціями самоочищення; застосунок Roborock.', 'Roborock makes robot vacuums and mops with mapping, obstacle recognition and self-cleaning docks; Roborock app.', 'Виробник роботів-пилососів і миючих пилососів. Роботи будують карти кількох поверхів, розпізнають перешкоди камерою й AI, автоматично спорожнюються та миють швабри на док-станції. Застосунок Roborock дає змогу задавати зони, графіки й режими прибирання та працює з голосовими асистентами.', 'A maker of robot vacuums and wet-dry vacuums. Robots map multiple floors, recognize obstacles with camera and AI and auto-empty and wash mops at the dock. The Roborock app sets zones, schedules and cleaning modes and works with voice assistants.', 'Картографування
AI-розпізнавання перешкод
Самоочищення
Зони й графіки', 'Mapping
AI obstacle recognition
Self-cleaning dock
Zones and schedules', 'Ті, хто автоматизує прибирання.', 'People automating cleaning.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'global.roborock.com' OR LOWER(`name`) = LOWER('Roborock')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Roborock makes robot vacuums and mops with mapping, obstacle recognition and self-cleaning docks; Roborock app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A maker of robot vacuums and wet-dry vacuums. Robots map multiple floors, recognize obstacles with camera and AI and auto-empty and wash mops at the dock. The Roborock app sets zones, schedules and cleaning modes and works with voice assistants.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Mapping
AI obstacle recognition
Self-cleaning dock
Zones and schedules', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People automating cleaning.', 'manual' FROM DUAL WHERE @new = 1;

-- Shelly — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shelly.com' OR LOWER(`name`) = LOWER('Shelly'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Shelly', NULL, 'https://www.shelly.com', NULL, NULL, 'Shelly — компактні Wi-Fi/Bluetooth реле, вимикачі, лічильники енергії й датчики для автоматизації освітлення, опалення та енергії.', 'Shelly makes compact Wi-Fi/Bluetooth relays, switches, energy meters and sensors to automate lighting, heating and energy.', 'Європейський виробник модулів, що встановлюються за наявні вимикачі чи в щиток: реле, димери, контролери штор, лічильники енергії, датчики. Пристрої працюють локально, мають відкритий API і застосунок Shelly Smart Control, інтегруються з Home Assistant, Alexa й Google.', 'A European maker of modules installed behind existing switches or in the panel: relays, dimmers, shutter controllers, energy meters and sensors. Devices work locally, have an open API and the Shelly Smart Control app and integrate with Home Assistant, Alexa and Google.', 'Реле за вимикачем
Лічильники енергії
Локальна робота
Відкритий API', 'Behind-switch relays
Energy meters
Local operation
Open API', 'Ті, хто модернізує електрику дому.', 'People upgrading home electrics.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shelly.com' OR LOWER(`name`) = LOWER('Shelly')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Shelly makes compact Wi-Fi/Bluetooth relays, switches, energy meters and sensors to automate lighting, heating and energy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A European maker of modules installed behind existing switches or in the panel: relays, dimmers, shutter controllers, energy meters and sensors. Devices work locally, have an open API and the Shelly Smart Control app and integrate with Home Assistant, Alexa and Google.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Behind-switch relays
Energy meters
Local operation
Open API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People upgrading home electrics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок Shelly', 'Shelly app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Shelly app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SmartThings — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'smartthings.com' OR LOWER(`name`) = LOWER('SmartThings'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SmartThings', NULL, 'https://www.smartthings.com', NULL, NULL, 'Samsung SmartThings — платформа розумного дому: керування технікою Samsung і сумісними пристроями, автоматизації, енергоменеджмент.', 'Samsung SmartThings is a smart home platform: control Samsung appliances and compatible devices, automations and energy management.', 'SmartThings об''єднує телевізори, побутову техніку Samsung, освітлення, датчики й камери інших брендів в одному застосунку. Дає змогу створювати автоматизації та сценарії, стежити за енергоспоживанням, отримувати сповіщення та керувати домом з телефона, телевізора чи холодильника. Підтримує Matter, Zigbee й Thread.', 'SmartThings brings TVs, Samsung appliances, lighting, sensors and cameras from other brands into one app. You can create automations and scenes, monitor energy use, get notifications and control the home from a phone, TV or fridge. It supports Matter, Zigbee and Thread.', 'Техніка Samsung і інші бренди
Автоматизації
Енергоменеджмент
Matter, Zigbee, Thread', 'Samsung and other brands
Automations
Energy management
Matter, Zigbee, Thread', 'Власники техніки Samsung і розумних пристроїв.', 'Owners of Samsung appliances and smart devices.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'smartthings.com' OR LOWER(`name`) = LOWER('SmartThings')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Samsung SmartThings is a smart home platform: control Samsung appliances and compatible devices, automations and energy management.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SmartThings brings TVs, Samsung appliances, lighting, sensors and cameras from other brands into one app. You can create automations and scenes, monitor energy use, get notifications and control the home from a phone, TV or fridge. It supports Matter, Zigbee and Thread.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Samsung and other brands
Automations
Energy management
Matter, Zigbee, Thread', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Owners of Samsung appliances and smart devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок SmartThings', 'SmartThings app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'SmartThings app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SwitchBot — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'switch-bot.com' OR LOWER(`name`) = LOWER('SwitchBot'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SwitchBot', NULL, 'https://www.switch-bot.com', NULL, NULL, 'SwitchBot — пристрої, що роблять «розумною» наявну техніку: натискачі кнопок, приводи штор, хаби, замки, датчики й роботи-пилососи.', 'SwitchBot makes existing appliances smart: button pushers, curtain motors, hubs, locks, sensors and robot vacuums.', 'Бренд прославився мініатюрним «Bot», що фізично натискає кнопки, і приводами для штор. Зараз пропонує хаби з ІЧ-керуванням техніки, замки, датчики, освітлення й роботи-пилососи. Застосунок дає змогу керувати з телефона чи голосом і створювати сцени.', 'The brand is known for the tiny Bot that physically presses buttons and for curtain motors. It now offers hubs with IR appliance control, locks, sensors, lighting and robot vacuums. The app controls everything from a phone or by voice and creates scenes.', 'Натискач кнопок Bot
Приводи штор
ІЧ-хаб
Сцени', 'Bot button pusher
Curtain motors
IR hub
Scenes', 'Орендарі та ті, хто не хоче міняти техніку.', 'Renters and people keeping existing appliances.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'switch-bot.com' OR LOWER(`name`) = LOWER('SwitchBot')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SwitchBot makes existing appliances smart: button pushers, curtain motors, hubs, locks, sensors and robot vacuums.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The brand is known for the tiny Bot that physically presses buttons and for curtain motors. It now offers hubs with IR appliance control, locks, sensors, lighting and robot vacuums. The app controls everything from a phone or by voice and creates scenes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Bot button pusher
Curtain motors
IR hub
Scenes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Renters and people keeping existing appliances.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок SwitchBot', 'SwitchBot app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'SwitchBot app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- tado° — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tado.com' OR LOWER(`name`) = LOWER('tado°'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'tado°', NULL, 'https://www.tado.com', NULL, NULL, 'tado° — розумне керування опаленням і кондиціонерами: термостати, термоголівки, геолокація, виявлення відкритих вікон і звіти економії.', 'tado° offers smart heating and AC control: thermostats, radiator valves, geofencing, open-window detection and savings reports.', 'Європейський сервіс керування кліматом. Термостати й розумні термоголівки знижують температуру, коли всі пішли (геолокація), виявляють відкриті вікна й враховують погоду. Застосунок показує звіти енергоспоживання; розширені функції — за підпискою Auto-Assist.', 'A European climate control service. Thermostats and smart radiator valves lower the temperature when everyone leaves (geofencing), detect open windows and factor in the weather. The app shows energy reports; advanced features come with an Auto-Assist subscription.', 'Геолокація
Виявлення відкритих вікон
Керування кондиціонером
Звіти економії', 'Geofencing
Open-window detection
AC control
Savings reports', 'Ті, хто хоче економити на опаленні.', 'People saving on heating.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tado.com' OR LOWER(`name`) = LOWER('tado°')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'tado° offers smart heating and AC control: thermostats, radiator valves, geofencing, open-window detection and savings reports.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A European climate control service. Thermostats and smart radiator valves lower the temperature when everyone leaves (geofencing), detect open windows and factor in the weather. The app shows energy reports; advanced features come with an Auto-Assist subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Geofencing
Open-window detection
AC control
Savings reports', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People saving on heating.', 'manual' FROM DUAL WHERE @new = 1;

-- TP-Link Tapo — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tapo.com' OR LOWER(`name`) = LOWER('TP-Link Tapo'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TP-Link Tapo', NULL, 'https://www.tapo.com', NULL, NULL, 'Tapo від TP-Link — доступні розумні розетки, камери, лампи, датчики й роботи-пилососи з одним застосунком Tapo.', 'Tapo by TP-Link offers affordable smart plugs, cameras, bulbs, sensors and robot vacuums with a single Tapo app.', 'Лінійка розумних пристроїв для дому: Wi-Fi розетки з моніторингом енергії, камери спостереження, лампи й стрічки, датчики, хаби та роботи-пилососи. Застосунок Tapo дозволяє керувати ними, налаштовувати розклади й автоматизації та працює з Alexa і Google Assistant.', 'A line of home smart devices: Wi-Fi plugs with energy monitoring, security cameras, bulbs and strips, sensors, hubs and robot vacuums. The Tapo app controls them, sets schedules and automations and works with Alexa and Google Assistant.', 'Розумні розетки
Камери
Автоматизації
Alexa й Google', 'Smart plugs
Cameras
Automations
Alexa and Google', 'Ті, хто починає розумний дім з недорогих пристроїв.', 'People starting a smart home on a budget.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tapo.com' OR LOWER(`name`) = LOWER('TP-Link Tapo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tapo by TP-Link offers affordable smart plugs, cameras, bulbs, sensors and robot vacuums with a single Tapo app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A line of home smart devices: Wi-Fi plugs with energy monitoring, security cameras, bulbs and strips, sensors, hubs and robot vacuums. The Tapo app controls them, sets schedules and automations and works with Alexa and Google Assistant.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Smart plugs
Cameras
Automations
Alexa and Google', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People starting a smart home on a budget.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок Tapo', 'Tapo app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Tapo app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- WiZ — Розумний дім
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wizconnected.com' OR LOWER(`name`) = LOWER('WiZ'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'WiZ', NULL, 'https://www.wizconnected.com', NULL, NULL, 'WiZ (Signify) — доступне Wi-Fi освітлення без хаба: лампи, стрічки, вуличні світильники, сцени й керування голосом.', 'WiZ (Signify) offers affordable Wi-Fi lighting with no hub: bulbs, strips, outdoor lights, scenes and voice control.', 'Бренд розумного освітлення від Signify (виробника Philips Hue), що підключається напряму до Wi-Fi. Застосунок WiZ V2 пропонує динамічні сцени, розклади, режими циркадного ритму, групи й автоматизації; працює з Alexa, Google і Matter.', 'A smart lighting brand from Signify (maker of Philips Hue) that connects straight to Wi-Fi. The WiZ V2 app offers dynamic scenes, schedules, circadian modes, groups and automations and works with Alexa, Google and Matter.', 'Без хаба
Динамічні сцени
Циркадні режими
Matter', 'No hub
Dynamic scenes
Circadian modes
Matter', 'Ті, хто шукає недороге розумне світло.', 'People seeking affordable smart lighting.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wizconnected.com' OR LOWER(`name`) = LOWER('WiZ')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'smart-home' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'WiZ (Signify) offers affordable Wi-Fi lighting with no hub: bulbs, strips, outdoor lights, scenes and voice control.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A smart lighting brand from Signify (maker of Philips Hue) that connects straight to Wi-Fi. The WiZ V2 app offers dynamic scenes, schedules, circadian modes, groups and automations and works with Alexa, Google and Matter.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'No hub
Dynamic scenes
Circadian modes
Matter', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People seeking affordable smart lighting.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок WiZ', 'WiZ app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'WiZ app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- abode — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'goabode.com' OR LOWER(`name`) = LOWER('abode'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'abode', NULL, 'https://goabode.com', NULL, NULL, 'abode — розумні системи безпеки й Wi-Fi камери з самостійним монтажем, автоматизаціями й опційним професійним моніторингом.', 'abode offers DIY smart security systems and Wi-Fi cameras with automations and optional professional monitoring.', 'Система безпеки, що поєднує сигналізацію і розумний дім: хаб, датчики, камери й сирени, правила автоматизації та сумісність із Zigbee, Z-Wave, Alexa, Google і HomeKit. Моніторинг можна вмикати за потреби, наприклад на час відпустки.', 'A security system combining alarm and smart home: hub, sensors, cameras and sirens, automation rules and compatibility with Zigbee, Z-Wave, Alexa, Google and HomeKit. Monitoring can be switched on when needed, such as during vacations.', 'Сигналізація + розумний дім
Zigbee й Z-Wave
Моніторинг за потреби
Самостійний монтаж', 'Alarm + smart home
Zigbee and Z-Wave
On-demand monitoring
DIY install', 'Власники будинків.', 'Homeowners.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'goabode.com' OR LOWER(`name`) = LOWER('abode')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'abode offers DIY smart security systems and Wi-Fi cameras with automations and optional professional monitoring.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A security system combining alarm and smart home: hub, sensors, cameras and sirens, automation rules and compatibility with Zigbee, Z-Wave, Alexa, Google and HomeKit. Monitoring can be switched on when needed, such as during vacations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Alarm + smart home
Zigbee and Z-Wave
On-demand monitoring
DIY install', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- ADT — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'adt.com' OR LOWER(`name`) = LOWER('ADT'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ADT', NULL, 'https://www.adt.com', NULL, NULL, 'ADT — велика американська компанія охоронних систем: сигналізації, камери, розумні замки й професійний моніторинг з застосунком ADT+.', 'ADT is a major US security company: alarm systems, cameras, smart locks and professional monitoring with the ADT+ app.', 'Провайдер домашньої безпеки з професійним і самостійним монтажем, цілодобовим моніторингом, камерами, відеодзвінками, датчиками диму й CO та розумними замками. Застосунок ADT+ дає керування й сповіщення; часто працює з пристроями Google Nest.', 'A home security provider with professional and DIY installation, 24/7 monitoring, cameras, video doorbells, smoke and CO detectors and smart locks. The ADT+ app provides control and alerts and often works with Google Nest devices.', 'Професійний моніторинг
Камери й замки
Датчики диму й CO
Застосунок ADT+', 'Professional monitoring
Cameras and locks
Smoke and CO
ADT+ app', 'Власники домів у США.', 'US homeowners.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'adt.com' OR LOWER(`name`) = LOWER('ADT')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ADT is a major US security company: alarm systems, cameras, smart locks and professional monitoring with the ADT+ app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A home security provider with professional and DIY installation, 24/7 monitoring, cameras, video doorbells, smoke and CO detectors and smart locks. The ADT+ app provides control and alerts and often works with Google Nest devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Professional monitoring
Cameras and locks
Smoke and CO
ADT+ app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- Ajax Systems — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ajax.systems' OR LOWER(`name`) = LOWER('Ajax Systems'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ajax Systems', NULL, 'https://ajax.systems', NULL, NULL, 'Ajax — українська бездротова система безпеки: охоронна й пожежна сигналізація, датчики протікання, камери й автоматизація з застосунком Ajax.', 'Ajax is a Ukrainian wireless security system: intrusion and fire alarms, leak sensors, cameras and automation with the Ajax app.', 'Система безпеки українського виробника, що поєднує охоронну сигналізацію, датчики диму й протікання, відеоспостереження та автоматизацію (реле, розетки, вимикачі). Пристрої з''єднуються захищеним радіопротоколом Jeweller, керуються з застосунку Ajax і можуть підключатися до пульта охоронної компанії.', 'A security system from a Ukrainian manufacturer combining intrusion alarms, smoke and leak sensors, video surveillance and automation (relays, sockets, switches). Devices connect via the secure Jeweller radio protocol, are managed in the Ajax app and can link to a monitoring company.', 'Охоронна сигналізація
Пожежні й датчики протікання
Відеоспостереження
Підключення до пульта', 'Intrusion alarm
Fire and leak sensors
Video surveillance
Monitoring connection', 'Власники квартир, будинків і бізнесу.', 'Apartment, house and business owners.', 'mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ajax.systems' OR LOWER(`name`) = LOWER('Ajax Systems')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ajax is a Ukrainian wireless security system: intrusion and fire alarms, leak sensors, cameras and automation with the Ajax app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A security system from a Ukrainian manufacturer combining intrusion alarms, smoke and leak sensors, video surveillance and automation (relays, sockets, switches). Devices connect via the secure Jeweller radio protocol, are managed in the Ajax app and can link to a monitoring company.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Intrusion alarm
Fire and leak sensors
Video surveillance
Monitoring connection', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Apartment, house and business owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок Ajax', 'Ajax app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Ajax app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Arlo — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'arlo.com' OR LOWER(`name`) = LOWER('Arlo'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Arlo', NULL, 'https://www.arlo.com', NULL, NULL, 'Arlo — бездротові камери спостереження, відеодзвінки й прожектори з нічним баченням; підписка Arlo Secure від 5,99 € на місяць.', 'Arlo makes wireless security cameras, video doorbells and floodlights with night vision; Arlo Secure subscription from €5.99 a month.', 'Камери для дому й вулиці з 2K/4K-відео, кольоровим нічним баченням, прожекторами й сиреною, а також відеодзвінки. Підписка Arlo Secure додає хмарні записи, AI-розпізнавання людей, тварин і авто та розширені сповіщення.', 'Indoor and outdoor cameras with 2K/4K video, color night vision, spotlights and sirens, plus video doorbells. An Arlo Secure subscription adds cloud recordings, AI detection of people, animals and vehicles and richer alerts.', '2K/4K-камери
Кольорове нічне бачення
AI-розпізнавання
Хмарні записи', '2K/4K cameras
Color night vision
AI detection
Cloud recordings', 'Власники будинків і ділянок.', 'Home and property owners.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'arlo.com' OR LOWER(`name`) = LOWER('Arlo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Arlo makes wireless security cameras, video doorbells and floodlights with night vision; Arlo Secure subscription from €5.99 a month.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Indoor and outdoor cameras with 2K/4K video, color night vision, spotlights and sirens, plus video doorbells. An Arlo Secure subscription adds cloud recordings, AI detection of people, animals and vehicles and richer alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '2K/4K cameras
Color night vision
AI detection
Cloud recordings', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Home and property owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Arlo Secure', 'Arlo Secure', 5.99, 'month', 'Від 5,99 € на місяць', 'From €5.99 a month' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Arlo Secure' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Arlo Secure', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'From €5.99 a month', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- August Home — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'august.com' OR LOWER(`name`) = LOWER('August Home'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'August Home', NULL, 'https://august.com', NULL, NULL, 'August — розумні замки для входу без ключа: Wi-Fi Smart Lock, клавіатури, автоблокування, гостьові ключі й журнал дверей.', 'August makes smart locks for keyless entry: Wi-Fi Smart Lock, keypads, auto-lock, guest keys and door activity log.', 'Замки, що встановлюються на наявний засув усередині дверей. Відчиняються з телефона чи автоматично при наближенні, замикаються самі, дають тимчасові ключі гостям і ведуть журнал подій. Працюють з Alexa, Google, Apple Home.', 'Locks that fit over the existing deadbolt on the inside of the door. They unlock from your phone or automatically as you approach, lock themselves, give temporary keys to guests and keep an activity log. They work with Alexa, Google and Apple Home.', 'Автовідчинення
Автоблокування
Гостьові ключі
Журнал подій', 'Auto-unlock
Auto-lock
Guest keys
Activity log', 'Власники та орендарі житла.', 'Homeowners and renters.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'august.com' OR LOWER(`name`) = LOWER('August Home')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'August makes smart locks for keyless entry: Wi-Fi Smart Lock, keypads, auto-lock, guest keys and door activity log.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Locks that fit over the existing deadbolt on the inside of the door. They unlock from your phone or automatically as you approach, lock themselves, give temporary keys to guests and keep an activity log. They work with Alexa, Google and Apple Home.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Auto-unlock
Auto-lock
Guest keys
Activity log', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners and renters.', 'manual' FROM DUAL WHERE @new = 1;

-- Blink — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'blinkforhome.com' OR LOWER(`name`) = LOWER('Blink'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Blink', NULL, 'https://blinkforhome.com', NULL, NULL, 'Blink (Amazon) — доступні бездротові та мережеві камери й дзвінки з довгою роботою від батарей і застосунком Blink Home Monitor.', 'Blink (Amazon) offers affordable wireless and plug-in cameras and doorbells with long battery life and the Blink Home Monitor app.', 'Камери, що працюють до двох років від батарейок, вуличні та внутрішні моделі, відеодзвінки й прожектори. Записи можна зберігати локально на модулі синхронізації з USB або в хмарі за підпискою; інтеграція з Alexa.', 'Cameras that run up to two years on batteries, indoor and outdoor models, video doorbells and floodlights. Recordings can be stored locally on a Sync Module with USB or in the cloud by subscription; Alexa integration.', 'Робота від батарей
Локальні або хмарні записи
Відеодзвінки
Alexa', 'Battery-powered
Local or cloud recordings
Video doorbells
Alexa', 'Ті, хто шукає недорогі камери.', 'People seeking affordable cameras.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'blinkforhome.com' OR LOWER(`name`) = LOWER('Blink')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Blink (Amazon) offers affordable wireless and plug-in cameras and doorbells with long battery life and the Blink Home Monitor app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Cameras that run up to two years on batteries, indoor and outdoor models, video doorbells and floodlights. Recordings can be stored locally on a Sync Module with USB or in the cloud by subscription; Alexa integration.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Battery-powered
Local or cloud recordings
Video doorbells
Alexa', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People seeking affordable cameras.', 'manual' FROM DUAL WHERE @new = 1;

-- Canary — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'canary.is' OR LOWER(`name`) = LOWER('Canary'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Canary', NULL, 'https://canary.is', NULL, NULL, 'Canary — система безпеки в одному пристрої: HD-камера, сирена й датчики клімату, нічне бачення та сповіщення про рух.', 'Canary is a security system in one device: HD camera, siren and climate sensors, night vision and motion alerts.', 'Камери Canary (View, Flex, Pro) поєднують відео 1080p, нічне бачення, сирену й датчики температури, вологості та якості повітря. Застосунок надсилає сповіщення про рух і дає змогу зв''язатися з екстреними службами; розширені записи — за підпискою.', 'Canary cameras (View, Flex, Pro) combine 1080p video, night vision, a siren and temperature, humidity and air-quality sensors. The app sends motion alerts and lets you contact emergency services; extended recordings require a subscription.', 'Все в одному
Сирена
Датчики клімату
Сповіщення про рух', 'All-in-one
Siren
Climate sensors
Motion alerts', 'Мешканці квартир.', 'Apartment dwellers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'canary.is' OR LOWER(`name`) = LOWER('Canary')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Canary is a security system in one device: HD camera, siren and climate sensors, night vision and motion alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Canary cameras (View, Flex, Pro) combine 1080p video, night vision, a siren and temperature, humidity and air-quality sensors. The app sends motion alerts and lets you contact emergency services; extended recordings require a subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'All-in-one
Siren
Climate sensors
Motion alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Apartment dwellers.', 'manual' FROM DUAL WHERE @new = 1;

-- Cove — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'covesmart.com' OR LOWER(`name`) = LOWER('Cove'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Cove', NULL, 'https://www.covesmart.com', NULL, NULL, 'Cove — доступна домашня сигналізація з самостійним монтажем, сенсорною панеллю й цілодобовим моніторингом без контрактів.', 'Cove is affordable DIY home security with a touchscreen panel and 24/7 monitoring without contracts.', 'Система безпеки, яку можна встановити самостійно: сенсорна панель, датчики дверей, руху, диму та протікання, камери. Пропонує цілодобовий професійний моніторинг без довгострокових контрактів і застосунок для керування.', 'A security system you can install yourself: touchscreen panel, door, motion, smoke and leak sensors and cameras. It offers 24/7 professional monitoring without long-term contracts and an app for control.', 'Сенсорна панель
Датчики протікання й диму
Моніторинг 24/7
Без контрактів', 'Touchscreen panel
Leak and smoke sensors
24/7 monitoring
No contracts', 'Власники домів у США.', 'US homeowners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'covesmart.com' OR LOWER(`name`) = LOWER('Cove')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Cove is affordable DIY home security with a touchscreen panel and 24/7 monitoring without contracts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A security system you can install yourself: touchscreen panel, door, motion, smoke and leak sensors and cameras. It offers 24/7 professional monitoring without long-term contracts and an app for control.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Touchscreen panel
Leak and smoke sensors
24/7 monitoring
No contracts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- Deep Sentinel — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'deepsentinel.com' OR LOWER(`name`) = LOWER('Deep Sentinel'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Deep Sentinel', NULL, 'https://www.deepsentinel.com', NULL, NULL, 'Deep Sentinel — камери з AI і живою охороною: оператори втручаються в реальному часі через динамік і викликають поліцію.', 'Deep Sentinel combines AI cameras with live guards who intervene in real time via speaker and call police.', 'Система відеоспостереження, де AI фільтрує події, а живі охоронці переглядають підозрілу активність за секунди, звертаються до порушника через динамік і сирену та за потреби викликають поліцію. Для домів і бізнесу; працює за підпискою.', 'A surveillance system where AI filters events and live guards review suspicious activity within seconds, speak to intruders via speaker and siren and call police if needed. For homes and businesses; subscription-based.', 'AI-фільтрація
Жива охорона
Втручання через динамік
Виклик поліції', 'AI filtering
Live guards
Speaker intervention
Police dispatch', 'Власники будинків і бізнесу.', 'Home and business owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'deepsentinel.com' OR LOWER(`name`) = LOWER('Deep Sentinel')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Deep Sentinel combines AI cameras with live guards who intervene in real time via speaker and call police.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A surveillance system where AI filters events and live guards review suspicious activity within seconds, speak to intruders via speaker and siren and call police if needed. For homes and businesses; subscription-based.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI filtering
Live guards
Speaker intervention
Police dispatch', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Home and business owners.', 'manual' FROM DUAL WHERE @new = 1;

-- eufy Security — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eufy.com' OR LOWER(`name`) = LOWER('eufy Security'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'eufy Security', NULL, 'https://www.eufy.com', NULL, NULL, 'eufy Security (Anker) — камери, дзвінки й замки з локальним AI і сховищем до 16 ТБ без щомісячної плати.', 'eufy Security (Anker) offers cameras, doorbells and locks with local AI and up to 16 TB storage with no monthly fees.', 'Лінійка безпеки від Anker, що робить ставку на локальне зберігання: базова станція HomeBase із жорстким диском до 16 ТБ, локальне AI-розпізнавання та відсутність обов''язкової підписки. Пропонує камери, відеодзвінки, замки й систему ProSecure.', 'Anker''s security line built around local storage: a HomeBase with up to 16 TB of disk, local AI detection and no required subscription. It offers cameras, video doorbells, locks and the ProSecure system.', 'Локальне сховище
Локальний AI
Без щомісячної плати
Замки й дзвінки', 'Local storage
Local AI
No monthly fees
Locks and doorbells', 'Ті, хто цінує приватність записів.', 'People valuing recording privacy.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eufy.com' OR LOWER(`name`) = LOWER('eufy Security')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'eufy Security (Anker) offers cameras, doorbells and locks with local AI and up to 16 TB storage with no monthly fees.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Anker''s security line built around local storage: a HomeBase with up to 16 TB of disk, local AI detection and no required subscription. It offers cameras, video doorbells, locks and the ProSecure system.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local storage
Local AI
No monthly fees
Locks and doorbells', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People valuing recording privacy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Без підписки', 'No subscription', 0.00, 'free', 'Локальне зберігання', 'Local storage' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Без підписки' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'No subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Local storage', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- EZVIZ — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ezviz.com' OR LOWER(`name`) = LOWER('EZVIZ'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'EZVIZ', NULL, 'https://www.ezviz.com', NULL, NULL, 'EZVIZ — глобальний бренд камер, відеодзвінків, замків і роботів-пилососів із хмарною платформою та застосунком EZVIZ.', 'EZVIZ is a global brand of cameras, video doorbells, locks and robot vacuums with a cloud platform and the EZVIZ app.', 'Бренд розумної безпеки для дому: Wi-Fi та 4G камери, моделі з сонячними панелями, дзвінки, замки й роботи-пилососи. Застосунок EZVIZ дає живе відео, запис на картку чи в хмару CloudPlay та AI-розпізнавання людей.', 'A home smart security brand: Wi-Fi and 4G cameras, solar models, doorbells, locks and robot vacuums. The EZVIZ app offers live video, recording to card or CloudPlay and AI person detection.', 'Wi-Fi і 4G камери
Сонячні моделі
CloudPlay
AI-розпізнавання', 'Wi-Fi and 4G cameras
Solar models
CloudPlay
AI detection', 'Власники квартир, будинків і дач.', 'Apartment, house and cottage owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ezviz.com' OR LOWER(`name`) = LOWER('EZVIZ')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'EZVIZ is a global brand of cameras, video doorbells, locks and robot vacuums with a cloud platform and the EZVIZ app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A home smart security brand: Wi-Fi and 4G cameras, solar models, doorbells, locks and robot vacuums. The EZVIZ app offers live video, recording to card or CloudPlay and AI person detection.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Wi-Fi and 4G cameras
Solar models
CloudPlay
AI detection', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Apartment, house and cottage owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Flo by Moen — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moen.com/flo' OR LOWER(`name`) = LOWER('Flo by Moen'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Flo by Moen', NULL, 'https://www.moen.com/flo', NULL, NULL, 'Flo by Moen — розумний монітор і запірний кран води: виявлення протікань, автоматичне перекриття й моніторинг споживання.', 'Flo by Moen is a smart water monitor and shutoff: leak detection, automatic shutoff and usage monitoring.', 'Пристрій встановлюється на головну трубу, аналізує тиск і потік, виявляє протікання, зокрема приховані, і автоматично перекриває воду. Застосунок показує споживання води; план Protect додає розширену гарантію та покриття франшизи страховки.', 'The device installs on the main water line, analyzes pressure and flow, detects leaks including hidden ones and shuts off water automatically. The app shows water use; the Protect plan adds extended warranty and insurance deductible coverage.', 'Виявлення протікань
Автоперекриття
Споживання води
План Protect', 'Leak detection
Auto shutoff
Water usage
Protect plan', 'Власники будинків.', 'Homeowners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moen.com/flo' OR LOWER(`name`) = LOWER('Flo by Moen')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Flo by Moen is a smart water monitor and shutoff: leak detection, automatic shutoff and usage monitoring.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The device installs on the main water line, analyzes pressure and flow, detects leaks including hidden ones and shuts off water automatically. The app shows water use; the Protect plan adds extended warranty and insurance deductible coverage.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Leak detection
Auto shutoff
Water usage
Protect plan', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- Frontpoint — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'frontpointsecurity.com' OR LOWER(`name`) = LOWER('Frontpoint'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Frontpoint', NULL, 'https://www.frontpointsecurity.com', NULL, NULL, 'Frontpoint — домашня безпека з самостійним монтажем: камери, прожектори, датчики, AI-функції й професійний моніторинг; 30 днів на пробу.', 'Frontpoint offers DIY home security: cameras, floodlights, sensors, AI features and professional monitoring; 30-day risk-free trial.', 'Американська система безпеки з самостійним монтажем і професійним моніторингом. Комплекти включають датчики, камери, прожектори й розумні пристрої; є AI-функції відео та пробний період 30 днів без ризику.', 'A US DIY security system with professional monitoring. Kits include sensors, cameras, floodlights and smart devices; it offers AI video features and a 30-day risk-free trial.', 'Самостійний монтаж
Професійний моніторинг
AI-відео
30 днів на пробу', 'DIY install
Professional monitoring
AI video
30-day trial', 'Власники домів у США.', 'US homeowners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'frontpointsecurity.com' OR LOWER(`name`) = LOWER('Frontpoint')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Frontpoint offers DIY home security: cameras, floodlights, sensors, AI features and professional monitoring; 30-day risk-free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A US DIY security system with professional monitoring. Kits include sensors, cameras, floodlights and smart devices; it offers AI video features and a 30-day risk-free trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'DIY install
Professional monitoring
AI video
30-day trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- Hik-Connect — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hik-connect.com' OR LOWER(`name`) = LOWER('Hik-Connect'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hik-Connect', NULL, 'https://www.hik-connect.com', NULL, NULL, 'Hik-Connect — застосунок і хмарний сервіс Hikvision для віддаленого перегляду камер, реєстраторів і домофонів.', 'Hik-Connect is Hikvision''s app and cloud service for remote viewing of cameras, recorders and intercoms.', 'Сервіс для власників обладнання Hikvision: дає змогу підключити камери й NVR/DVR через хмару, переглядати відео наживо й записи, отримувати сповіщення про події та відповідати на дзвінки домофона. Є веб-клієнт і мобільні застосунки.', 'A service for Hikvision equipment owners: connect cameras and NVR/DVR via the cloud, view live and recorded video, get event alerts and answer intercom calls. Web client and mobile apps are available.', 'Віддалений перегляд
Записи NVR/DVR
Сповіщення
Домофони', 'Remote viewing
NVR/DVR recordings
Alerts
Intercoms', 'Власники систем Hikvision.', 'Hikvision system owners.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hik-connect.com' OR LOWER(`name`) = LOWER('Hik-Connect')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Hik-Connect is Hikvision''s app and cloud service for remote viewing of cameras, recorders and intercoms.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service for Hikvision equipment owners: connect cameras and NVR/DVR via the cloud, view live and recorded video, get event alerts and answer intercom calls. Web client and mobile apps are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Remote viewing
NVR/DVR recordings
Alerts
Intercoms', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Hikvision system owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базовий доступ', 'Basic access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Imou — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'imou.com' OR LOWER(`name`) = LOWER('Imou'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Imou', NULL, 'https://www.imou.com', NULL, NULL, 'Imou — камери спостереження й відеодзвінки для дому та бізнесу: нічне бачення, двосторонній звук, PIR-датчики, хмара або локальне сховище.', 'Imou makes security cameras and video doorbells for home and business: night vision, two-way audio, PIR, cloud or local storage.', 'Споживчий IoT-бренд з камерами 1080p і вище, нічним баченням, двостороннім аудіо, PIR-виявленням руху та вибором між хмарним і локальним зберіганням. Застосунок Imou Life дає перегляд і сповіщення.', 'A consumer IoT brand with 1080p-and-up cameras, night vision, two-way audio, PIR motion detection and a choice of cloud or local storage. The Imou Life app provides viewing and alerts.', 'Нічне бачення
Двосторонній звук
PIR-датчики
Хмара або карта пам''яті', 'Night vision
Two-way audio
PIR
Cloud or SD card', 'Ті, хто шукає бюджетні камери.', 'People seeking budget cameras.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'imou.com' OR LOWER(`name`) = LOWER('Imou')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Imou makes security cameras and video doorbells for home and business: night vision, two-way audio, PIR, cloud or local storage.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A consumer IoT brand with 1080p-and-up cameras, night vision, two-way audio, PIR motion detection and a choice of cloud or local storage. The Imou Life app provides viewing and alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Night vision
Two-way audio
PIR
Cloud or SD card', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People seeking budget cameras.', 'manual' FROM DUAL WHERE @new = 1;

-- Kangaroo — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'heykangaroo.com' OR LOWER(`name`) = LOWER('Kangaroo'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kangaroo', NULL, 'https://heykangaroo.com', NULL, NULL, 'Kangaroo — проста й доступна домашня сигналізація: датчики на батарейках, дзвінки-камери, плани без контрактів і знижки на страховку.', 'Kangaroo is simple, affordable home security: battery sensors, doorbell cameras, contract-free plans and insurance savings.', 'Датчики, що клеяться без інструментів і працюють від батарейок, камери й відеодзвінки. Плани без контрактів, недорогий професійний моніторинг і допомога в отриманні знижок на страхування житла.', 'Peel-and-stick, battery-powered sensors, cameras and video doorbells. Contract-free plans, affordable professional monitoring and help getting home insurance savings.', 'Датчики без інструментів
Відеодзвінки
Без контрактів
Знижки на страховку', 'Tool-free sensors
Video doorbells
No contracts
Insurance savings', 'Орендарі й власники квартир.', 'Renters and apartment owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'heykangaroo.com' OR LOWER(`name`) = LOWER('Kangaroo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Kangaroo is simple, affordable home security: battery sensors, doorbell cameras, contract-free plans and insurance savings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Peel-and-stick, battery-powered sensors, cameras and video doorbells. Contract-free plans, affordable professional monitoring and help getting home insurance savings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tool-free sensors
Video doorbells
No contracts
Insurance savings', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Renters and apartment owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Level Lock — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'level.co' OR LOWER(`name`) = LOWER('Level Lock'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Level Lock', NULL, 'https://level.co', NULL, NULL, 'Level — «невидимі» розумні замки, що ховають механіку всередині дверей і зберігають дизайн та ключі; Level Bolt від 249 $.', 'Level makes invisible smart locks that hide the mechanism inside the door and keep your design and keys; Level Bolt from $249.', 'Розумні замки, що ззовні виглядають як звичайні. Level Bolt замінює лише засув, зберігаючи ручки й ключі; Level Lock+ додає NFC-картки, Apple Home Key і визначення стану дверей. Керування через застосунок і голосові асистенти.', 'Smart locks that look ordinary from outside. Level Bolt replaces only the deadbolt, keeping handles and keys; Level Lock+ adds NFC cards, Apple Home Key and door-status detection. Control via the app and voice assistants.', 'Невидимий дизайн
Збереження ключів
Apple Home Key
Стан дверей', 'Invisible design
Keeps existing keys
Apple Home Key
Door status', 'Власники житла, що цінують дизайн.', 'Design-minded homeowners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'level.co' OR LOWER(`name`) = LOWER('Level Lock')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Level makes invisible smart locks that hide the mechanism inside the door and keep your design and keys; Level Bolt from $249.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Smart locks that look ordinary from outside. Level Bolt replaces only the deadbolt, keeping handles and keys; Level Lock+ adds NFC cards, Apple Home Key and door-status detection. Control via the app and voice assistants.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Invisible design
Keeps existing keys
Apple Home Key
Door status', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Design-minded homeowners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Level Bolt', 'Level Bolt', 249.00, 'one_time', 'Заміна засуву', 'Deadbolt retrofit' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Level Bolt' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Level Bolt', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Deadbolt retrofit', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Lockly — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lockly.com' OR LOWER(`name`) = LOWER('Lockly'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lockly', NULL, 'https://lockly.com', NULL, NULL, 'Lockly — розумні замки з технологією PIN Genie, 3D-відбитком пальця, розпізнаванням обличчя, відеодомофоном і віддаленим відчиненням.', 'Lockly makes smart locks with PIN Genie, 3D fingerprint, facial recognition, video intercom and remote unlocking.', 'Замки з запатентованою клавіатурою PIN Genie, що перемішує цифри проти підглядання, 3D-сканером відбитків, моделями з розпізнаванням обличчя та відео. Дозволяють відчиняти двері віддалено, видавати разові коди та бачити журнал входів.', 'Locks with the patented PIN Genie keypad that shuffles digits against peeking, a 3D fingerprint reader and models with facial recognition and video. They allow remote unlocking, one-time codes and an entry log.', 'PIN Genie
3D-відбиток
Розпізнавання обличчя
Разові коди', 'PIN Genie
3D fingerprint
Facial recognition
One-time codes', 'Власники житла й хости.', 'Homeowners and hosts.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lockly.com' OR LOWER(`name`) = LOWER('Lockly')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Lockly makes smart locks with PIN Genie, 3D fingerprint, facial recognition, video intercom and remote unlocking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Locks with the patented PIN Genie keypad that shuffles digits against peeking, a 3D fingerprint reader and models with facial recognition and video. They allow remote unlocking, one-time codes and an entry log.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'PIN Genie
3D fingerprint
Facial recognition
One-time codes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners and hosts.', 'manual' FROM DUAL WHERE @new = 1;

-- Lorex — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lorex.com' OR LOWER(`name`) = LOWER('Lorex'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lorex', NULL, 'https://www.lorex.com', NULL, NULL, 'Lorex — камери, відеодзвінки й системи відеоспостереження з локальним зберіганням без щомісячної плати.', 'Lorex offers cameras, video doorbells and surveillance systems with local storage and no monthly fees.', 'Бренд з понад 30-річною історією, що пропонує NVR-системи, Wi-Fi та PoE камери до 4K, прожекторні камери й відеодзвінки. Записи зберігаються локально без обов''язкової підписки; застосунок Lorex дає перегляд і розумні сповіщення.', 'A brand with 30+ years of history offering NVR systems, Wi-Fi and PoE cameras up to 4K, floodlight cameras and video doorbells. Recordings are stored locally without a required subscription; the Lorex app provides viewing and smart alerts.', 'Локальне зберігання
4K-камери
NVR-системи
Без щомісячної плати', 'Local storage
4K cameras
NVR systems
No monthly fees', 'Власники будинків і малий бізнес.', 'Homeowners and small businesses.', 'mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lorex.com' OR LOWER(`name`) = LOWER('Lorex')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Lorex offers cameras, video doorbells and surveillance systems with local storage and no monthly fees.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A brand with 30+ years of history offering NVR systems, Wi-Fi and PoE cameras up to 4K, floodlight cameras and video doorbells. Recordings are stored locally without a required subscription; the Lorex app provides viewing and smart alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Local storage
4K cameras
NVR systems
No monthly fees', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners and small businesses.', 'manual' FROM DUAL WHERE @new = 1;

-- Minut — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'minut.com' OR LOWER(`name`) = LOWER('Minut'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Minut', NULL, 'https://www.minut.com', NULL, NULL, 'Minut — датчики шуму, присутності й клімату з дотриманням приватності для орендного житла та короткострокової оренди.', 'Minut offers privacy-safe noise, occupancy and climate sensors for rentals and short-term lets.', 'Платформа для власників і менеджерів орендного житла. Датчики без камер відстежують рівень шуму, кількість людей, куріння, температуру й вологість і попереджають про вечірки чи ризик пошкоджень. Інтегрується з Airbnb та системами керування нерухомістю.', 'A platform for rental owners and managers. Camera-free sensors track noise, occupancy, smoking, temperature and humidity and warn about parties or damage risks. It integrates with Airbnb and property management systems.', 'Моніторинг шуму
Присутність без камер
Датчик куріння
Інтеграція з Airbnb', 'Noise monitoring
Camera-free occupancy
Smoking detection
Airbnb integration', 'Орендодавці та хости.', 'Landlords and hosts.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'minut.com' OR LOWER(`name`) = LOWER('Minut')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Minut offers privacy-safe noise, occupancy and climate sensors for rentals and short-term lets.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform for rental owners and managers. Camera-free sensors track noise, occupancy, smoking, temperature and humidity and warn about parties or damage risks. It integrates with Airbnb and property management systems.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Noise monitoring
Camera-free occupancy
Smoking detection
Airbnb integration', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Landlords and hosts.', 'manual' FROM DUAL WHERE @new = 1;

-- Noonlight — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'noonlight.com' OR LOWER(`name`) = LOWER('Noonlight'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Noonlight', NULL, 'https://www.noonlight.com', NULL, NULL, 'Noonlight — сервіс екстреного реагування: кнопка безпеки в застосунку, інтеграції з розумним домом і моніторинг сигналізацій.', 'Noonlight is an emergency response service: in-app safety button, smart home integrations and alarm monitoring.', 'Платформа, яка з''єднує людину чи пристрій з екстреними службами. Застосунок дає кнопку тривоги, що передає локацію диспетчерам; сервіс інтегрується з розумними пристроями й сигналізаціями та пропонує недорогий професійний моніторинг.', 'A platform connecting people or devices to emergency services. The app offers a panic button that shares location with dispatchers; the service integrates with smart devices and alarms and offers affordable professional monitoring.', 'Кнопка тривоги
Передача локації
Інтеграції з пристроями
Моніторинг', 'Panic button
Location sharing
Device integrations
Monitoring', 'Люди, що дбають про особисту безпеку.', 'People focused on personal safety.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'noonlight.com' OR LOWER(`name`) = LOWER('Noonlight')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Noonlight is an emergency response service: in-app safety button, smart home integrations and alarm monitoring.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform connecting people or devices to emergency services. The app offers a panic button that shares location with dispatchers; the service integrates with smart devices and alarms and offers affordable professional monitoring.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Panic button
Location sharing
Device integrations
Monitoring', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People focused on personal safety.', 'manual' FROM DUAL WHERE @new = 1;

-- Nuki — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nuki.io' OR LOWER(`name`) = LOWER('Nuki'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nuki', NULL, 'https://nuki.io', NULL, NULL, 'Nuki — австрійські розумні замки для легкого встановлення на наявні двері: відчинення з телефона, автоматика й доступ для гостей.', 'Nuki makes Austrian smart locks that retrofit to existing doors: phone unlocking, automation and guest access.', 'Nuki Smart Lock кріпиться на внутрішній бік європейського циліндра без заміни замка. Відчиняє двері автоматично при наближенні, дає цифрові ключі на час, працює з клавіатурою й датчиком дверей, підтримує Matter і основні платформи розумного дому.', 'Nuki Smart Lock mounts on the inside of a European cylinder without replacing the lock. It opens automatically as you approach, issues timed digital keys, works with a keypad and door sensor and supports Matter and major smart home platforms.', 'Без заміни замка
Автовідчинення
Цифрові ключі
Matter', 'No lock replacement
Auto-unlock
Digital keys
Matter', 'Власники квартир у Європі.', 'Apartment owners in Europe.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nuki.io' OR LOWER(`name`) = LOWER('Nuki')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Nuki makes Austrian smart locks that retrofit to existing doors: phone unlocking, automation and guest access.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Nuki Smart Lock mounts on the inside of a European cylinder without replacing the lock. It opens automatically as you approach, issues timed digital keys, works with a keypad and door sensor and supports Matter and major smart home platforms.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'No lock replacement
Auto-unlock
Digital keys
Matter', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Apartment owners in Europe.', 'manual' FROM DUAL WHERE @new = 1;

-- Phyn — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'phyn.com' OR LOWER(`name`) = LOWER('Phyn'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Phyn', NULL, 'https://www.phyn.com', NULL, NULL, 'Phyn Protect — розумний запірний кран, що за тиском води виявляє протікання й замерзання труб та автоматично перекриває воду.', 'Phyn Protect is a smart shutoff that uses water pressure to detect leaks and frozen pipes and shuts off water automatically.', 'Пристрій від Uponor і Belkin, що аналізує мікрозміни тиску у водопроводі. Виявляє протікання, точкові пробоїни мідних труб і ризик замерзання, автоматично перекриває воду й показує споживання по приладах у застосунку.', 'A device from Uponor and Belkin that analyzes micro-changes in water pressure. It detects leaks, pinhole leaks in copper pipes and freeze risk, shuts off water automatically and shows per-fixture usage in the app.', 'Аналіз тиску
Ризик замерзання
Автоперекриття
Споживання по приладах', 'Pressure analysis
Freeze risk
Auto shutoff
Per-fixture usage', 'Власники будинків.', 'Homeowners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'phyn.com' OR LOWER(`name`) = LOWER('Phyn')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Phyn Protect is a smart shutoff that uses water pressure to detect leaks and frozen pipes and shuts off water automatically.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A device from Uponor and Belkin that analyzes micro-changes in water pressure. It detects leaks, pinhole leaks in copper pipes and freeze risk, shuts off water automatically and shows per-fixture usage in the app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Pressure analysis
Freeze risk
Auto shutoff
Per-fixture usage', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- Reolink — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'reolink.com' OR LOWER(`name`) = LOWER('Reolink'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Reolink', NULL, 'https://reolink.com', NULL, NULL, 'Reolink — камери й системи відеоспостереження для дому та бізнесу: PoE, Wi-Fi, 4G, сонячні моделі, NVR і локальне зберігання.', 'Reolink makes security cameras and systems for home and business: PoE, Wi-Fi, 4G, solar models, NVRs and local storage.', 'Виробник відеоспостереження з понад 2 млн користувачів. Пропонує 4K-камери, моделі з живленням від сонячних панелей і 4G, PTZ, відеодзвінки, реєстратори NVR і локальне зберігання без обов''язкової підписки. Застосунок і клієнт для ПК дають перегляд і пошук подій.', 'A surveillance maker with over 2 million users. It offers 4K cameras, solar- and 4G-powered models, PTZ, video doorbells, NVR recorders and local storage with no required subscription. Its app and desktop client provide viewing and event search.', '4K-камери
Сонячні й 4G-моделі
NVR
Без обов''язкової підписки', '4K cameras
Solar and 4G models
NVR
No required subscription', 'Власники будинків і малий бізнес.', 'Homeowners and small businesses.', 'mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'reolink.com' OR LOWER(`name`) = LOWER('Reolink')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Reolink makes security cameras and systems for home and business: PoE, Wi-Fi, 4G, solar models, NVRs and local storage.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A surveillance maker with over 2 million users. It offers 4K cameras, solar- and 4G-powered models, PTZ, video doorbells, NVR recorders and local storage with no required subscription. Its app and desktop client provide viewing and event search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '4K cameras
Solar and 4G models
NVR
No required subscription', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners and small businesses.', 'manual' FROM DUAL WHERE @new = 1;

-- Ring — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ring.com' OR LOWER(`name`) = LOWER('Ring'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ring', NULL, 'https://ring.com', NULL, NULL, 'Ring (Amazon) — відеодзвінки, камери, сигналізація й прожектори з застосунком Ring і підпискою Ring Home для записів.', 'Ring (Amazon) offers video doorbells, cameras, alarm systems and floodlights with the Ring app and Ring Home subscription for recordings.', 'Бренд домашньої безпеки від Amazon: відеодзвінки, внутрішні й вуличні камери, прожектори та сигналізація Ring Alarm. Застосунок дає живе відео, сповіщення й двосторонній звук; підписка Ring Home зберігає записи, а професійний моніторинг доступний окремо.', 'Amazon''s home security brand: video doorbells, indoor and outdoor cameras, floodlights and the Ring Alarm system. The app offers live video, alerts and two-way talk; a Ring Home subscription stores recordings, and professional monitoring is available separately.', 'Відеодзвінки
Камери й прожектори
Ring Alarm
Записи за підпискою', 'Video doorbells
Cameras and floodlights
Ring Alarm
Recordings by subscription', 'Власники будинків.', 'Homeowners.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ring.com' OR LOWER(`name`) = LOWER('Ring')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ring (Amazon) offers video doorbells, cameras, alarm systems and floodlights with the Ring app and Ring Home subscription for recordings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Amazon''s home security brand: video doorbells, indoor and outdoor cameras, floodlights and the Ring Alarm system. The app offers live video, alerts and two-way talk; a Ring Home subscription stores recordings, and professional monitoring is available separately.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Video doorbells
Cameras and floodlights
Ring Alarm
Recordings by subscription', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- Ring Neighbors — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ring.com/neighbors' OR LOWER(`name`) = LOWER('Ring Neighbors'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ring Neighbors', NULL, 'https://ring.com/neighbors', NULL, NULL, 'Neighbors від Ring — безкоштовний застосунок сповіщень про безпеку в районі: повідомлення сусідів, служб і відео.', 'Neighbors by Ring is a free app for local safety alerts: posts from neighbours, agencies and videos.', 'Соціальний застосунок, де мешканці діляться інформацією про інциденти, загублених тварин і підозрілу активність, а місцеві служби публікують оголошення. Не вимагає пристроїв Ring.', 'A social app where residents share incidents, lost pets and suspicious activity, and local agencies post updates. No Ring device required.', 'Сповіщення в районі
Повідомлення служб
Відео сусідів
Безкоштовно', 'Neighbourhood alerts
Agency posts
Neighbour videos
Free', 'Мешканці районів у США.', 'US neighbourhood residents.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ring.com/neighbors' OR LOWER(`name`) = LOWER('Ring Neighbors')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Neighbors by Ring is a free app for local safety alerts: posts from neighbours, agencies and videos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A social app where residents share incidents, lost pets and suspicious activity, and local agencies post updates. No Ring device required.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Neighbourhood alerts
Agency posts
Neighbour videos
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US neighbourhood residents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SimpliSafe — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'simplisafe.com' OR LOWER(`name`) = LOWER('SimpliSafe'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SimpliSafe', NULL, 'https://simplisafe.com', NULL, NULL, 'SimpliSafe — бездротова сигналізація з самостійним монтажем, камерами й цілодобовим професійним моніторингом без довгих контрактів.', 'SimpliSafe is a DIY wireless alarm system with cameras and 24/7 professional monitoring without long contracts.', 'Американська система домашньої безпеки, яку встановлюють самостійно: базова станція, датчики дверей і руху, камери, дзвінки й замки. Плани моніторингу з живими агентами, які можуть перевірити відео й викликати допомогу; без довгострокових контрактів.', 'A US DIY home security system: base station, door and motion sensors, cameras, doorbells and locks. Monitoring plans include live agents who can verify video and dispatch help, without long-term contracts.', 'Самостійний монтаж
Цілодобовий моніторинг
Відеоверифікація
Без контрактів', 'DIY install
24/7 monitoring
Video verification
No contracts', 'Власники домів у США та Великій Британії.', 'Homeowners in the US and UK.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'simplisafe.com' OR LOWER(`name`) = LOWER('SimpliSafe')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SimpliSafe is a DIY wireless alarm system with cameras and 24/7 professional monitoring without long contracts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A US DIY home security system: base station, door and motion sensors, cameras, doorbells and locks. Monitoring plans include live agents who can verify video and dispatch help, without long-term contracts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'DIY install
24/7 monitoring
Video verification
No contracts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners in the US and UK.', 'manual' FROM DUAL WHERE @new = 1;

-- Ting — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tingfire.com' OR LOWER(`name`) = LOWER('Ting'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ting', NULL, 'https://www.tingfire.com', NULL, NULL, 'Ting (Whisker Labs) — розумний датчик у розетці, що виявляє електричні несправності до пожежі й сповіщає про відключення світла.', 'Ting (Whisker Labs) is a plug-in sensor that detects electrical hazards before a fire and alerts about power outages.', 'Датчик вмикається в розетку й аналізує електромережу всього будинку, виявляючи мікродуги та інші ознаки небезпеки. Сервіс включає перевірку фахівцями та кредит до 1 000 $ на усунення несправності; часто надається безкоштовно через страхові компанії.', 'The sensor plugs into an outlet and analyzes the whole home''s wiring, detecting micro-arcs and other hazards. The service includes expert follow-up and up to $1,000 credit for repairs and is often provided free through insurers.', 'Виявлення мікродуг
Сповіщення про відключення
Кредит на ремонт
Через страховиків', 'Micro-arc detection
Outage alerts
Repair credit
Via insurers', 'Власники будинків у США.', 'US homeowners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tingfire.com' OR LOWER(`name`) = LOWER('Ting')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ting (Whisker Labs) is a plug-in sensor that detects electrical hazards before a fire and alerts about power outages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The sensor plugs into an outlet and analyzes the whole home''s wiring, detecting micro-arcs and other hazards. The service includes expert follow-up and up to $1,000 credit for repairs and is often provided free through insurers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Micro-arc detection
Outage alerts
Repair credit
Via insurers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- Verisure — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'verisure.com' OR LOWER(`name`) = LOWER('Verisure'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Verisure', NULL, 'https://www.verisure.com', NULL, NULL, 'Verisure — європейська компанія охоронних систем з професійним монтажем, центром моніторингу й застосунком My Verisure.', 'Verisure is a European security company with professional installation, a monitoring centre and the My Verisure app.', 'Провайдер охоронних систем для домів і малого бізнесу в Європі та Латинській Америці. Включає датчики, камери з фотоверифікацією, туманогенератор ZeroVision, розумні замки й цілодобовий центр реагування; керування через застосунок.', 'A security provider for homes and small businesses in Europe and Latin America. It includes sensors, photo-verification cameras, the ZeroVision fog generator, smart locks and a 24/7 response centre, managed via the app.', 'Професійний монтаж
Фотоверифікація
ZeroVision
Центр реагування 24/7', 'Professional install
Photo verification
ZeroVision
24/7 response centre', 'Власники житла в Європі.', 'Homeowners in Europe.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'verisure.com' OR LOWER(`name`) = LOWER('Verisure')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Verisure is a European security company with professional installation, a monitoring centre and the My Verisure app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A security provider for homes and small businesses in Europe and Latin America. It includes sensors, photo-verification cameras, the ZeroVision fog generator, smart locks and a 24/7 response centre, managed via the app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Professional install
Photo verification
ZeroVision
24/7 response centre', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners in Europe.', 'manual' FROM DUAL WHERE @new = 1;

-- Wyze — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wyze.com' OR LOWER(`name`) = LOWER('Wyze'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Wyze', NULL, 'https://www.wyze.com', NULL, NULL, 'Wyze — доступні камери від 1080p до 4K, замки, датчики, лампи й домашня сигналізація з підписками Cam Plus і Home Monitoring.', 'Wyze makes affordable 1080p–4K cameras, locks, sensors, bulbs and home alarm with Cam Plus and Home Monitoring subscriptions.', 'Бренд недорогих розумних пристроїв: внутрішні, вуличні та поворотні камери, відеодзвінки, замки з відбитком пальця, датчики й лампи. Застосунок дає живе відео й сповіщення; підписка Cam Plus додає AI-розпізнавання та безперервний запис, Home Monitoring — професійний моніторинг.', 'A budget smart device brand: indoor, outdoor and pan cameras, video doorbells, fingerprint locks, sensors and bulbs. The app offers live video and alerts; Cam Plus adds AI detection and continuous recording, and Home Monitoring adds professional monitoring.', 'Недорогі камери
Замки з відбитком
AI-розпізнавання
Домашній моніторинг', 'Affordable cameras
Fingerprint locks
AI detection
Home monitoring', 'Ті, хто шукає бюджетну безпеку.', 'People seeking budget security.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wyze.com' OR LOWER(`name`) = LOWER('Wyze')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Wyze makes affordable 1080p–4K cameras, locks, sensors, bulbs and home alarm with Cam Plus and Home Monitoring subscriptions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A budget smart device brand: indoor, outdoor and pan cameras, video doorbells, fingerprint locks, sensors and bulbs. The app offers live video and alerts; Cam Plus adds AI detection and continuous recording, and Home Monitoring adds professional monitoring.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Affordable cameras
Fingerprint locks
AI detection
Home monitoring', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People seeking budget security.', 'manual' FROM DUAL WHERE @new = 1;

-- Yale Home — Безпека дому
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yalehome.com' OR LOWER(`name`) = LOWER('Yale Home'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Yale Home', NULL, 'https://www.yalehome.com', NULL, NULL, 'Yale Home — розумні замки, сейфи й відеодзвінки Yale з застосунком Yale Access/Home: ключі на телефоні й доступ гостям.', 'Yale Home offers Yale smart locks, safes and video doorbells with the Yale Access/Home app: phone keys and guest access.', 'Один з найстаріших виробників замків пропонує розумні засуви, замки з клавіатурою й відбитком пальця, сейфи й дзвінки. Застосунок дозволяє відчиняти двері з телефона, видавати доступ гостям і отримувати сповіщення; підтримка Matter, Apple Home, Google і Alexa.', 'One of the oldest lock makers offers smart deadbolts, keypad and fingerprint locks, safes and doorbells. The app unlocks doors from a phone, grants guest access and sends alerts, with Matter, Apple Home, Google and Alexa support.', 'Розумні засуви
Відбиток пальця
Доступ гостям
Matter', 'Smart deadbolts
Fingerprint
Guest access
Matter', 'Власники житла.', 'Homeowners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yalehome.com' OR LOWER(`name`) = LOWER('Yale Home')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-security' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Yale Home offers Yale smart locks, safes and video doorbells with the Yale Access/Home app: phone keys and guest access.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'One of the oldest lock makers offers smart deadbolts, keypad and fingerprint locks, safes and doorbells. The app unlocks doors from a phone, grants guest access and sends alerts, with Matter, Apple Home, Google and Alexa support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Smart deadbolts
Fingerprint
Guest access
Matter', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- Angi — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'angi.com' OR LOWER(`name`) = LOWER('Angi'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Angi', NULL, 'https://www.angi.com', NULL, NULL, 'Angi (колишній Angie''s List) — пошук і бронювання майстрів для ремонту й обслуговування дому з відгуками та фіксованими цінами.', 'Angi (formerly Angie''s List) helps find and book home repair and maintenance pros with reviews and upfront prices.', 'Американський маркетплейс домашніх послуг: сантехніки, електрики, покрівельники, прибирання, ландшафт і ремонт. Можна порівнювати відгуки, отримувати пропозиції, бронювати послуги з фіксованою ціною й переглядати гіди з вартості робіт.', 'A US home services marketplace: plumbers, electricians, roofers, cleaning, landscaping and remodeling. You can compare reviews, get quotes, book fixed-price services and read cost guides.', 'Відгуки про майстрів
Бронювання послуг
Фіксовані ціни
Гіди з вартості', 'Pro reviews
Service booking
Upfront prices
Cost guides', 'Власники житла в США.', 'US homeowners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'angi.com' OR LOWER(`name`) = LOWER('Angi')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Angi (formerly Angie''s List) helps find and book home repair and maintenance pros with reviews and upfront prices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A US home services marketplace: plumbers, electricians, roofers, cleaning, landscaping and remodeling. You can compare reviews, get quotes, book fixed-price services and read cost guides.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Pro reviews
Service booking
Upfront prices
Cost guides', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US homeowners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для замовників', 'For customers' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For customers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bark — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bark.com' OR LOWER(`name`) = LOWER('Bark'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bark', NULL, 'https://www.bark.com', NULL, NULL, 'Bark — пошук місцевих фахівців і сервісів: опишіть завдання й отримайте пропозиції від майстрів, будівельників, прибиральників тощо.', 'Bark finds local professionals and services: describe the job and get quotes from tradespeople, builders, cleaners and more.', 'Міжнародна платформа (Велика Британія, США та інші країни): користувач заповнює запит, а відповідні фахівці надсилають пропозиції. Для замовників сервіс безкоштовний; категорії охоплюють ремонт, будівництво, прибирання, сад, переїзд і багато іншого.', 'An international platform (UK, US and more): the customer fills in a request and matching pros send quotes. It is free for customers; categories cover repairs, building, cleaning, gardening, moving and much more.', 'Один запит — кілька пропозицій
Багато категорій
Безкоштовно для клієнтів', 'One request, multiple quotes
Many categories
Free for customers', 'Ті, хто шукає майстрів.', 'People looking for pros.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bark.com' OR LOWER(`name`) = LOWER('Bark')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Bark finds local professionals and services: describe the job and get quotes from tradespeople, builders, cleaners and more.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An international platform (UK, US and more): the customer fills in a request and matching pros send quotes. It is free for customers; categories cover repairs, building, cleaning, gardening, moving and much more.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'One request, multiple quotes
Many categories
Free for customers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People looking for pros.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для замовників', 'For customers' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For customers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bob Vila — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bobvila.com' OR LOWER(`name`) = LOWER('Bob Vila'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bob Vila', NULL, 'https://www.bobvila.com', NULL, NULL, 'Bob Vila — ідеї та експертні поради з ремонту, облаштування й DIY: гіди, огляди інструментів і проєкти для дому.', 'Bob Vila offers ideas and expert advice on home improvement, repair and DIY: guides, tool reviews and home projects.', 'Медіа від відомого американського ведучого телепрограм про ремонт. Публікує покрокові інструкції, ідеї ремонту, поради з обслуговування дому, тести інструментів і техніки та добірки товарів.', 'Media from the well-known American home improvement TV host. It publishes step-by-step guides, renovation ideas, home maintenance tips, tool and appliance tests and product roundups.', 'Покрокові гіди
Тести інструментів
Поради з обслуговування
Ідеї ремонту', 'Step-by-step guides
Tool tests
Maintenance tips
Renovation ideas', 'DIY-ентузіасти.', 'DIY enthusiasts.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bobvila.com' OR LOWER(`name`) = LOWER('Bob Vila')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Bob Vila offers ideas and expert advice on home improvement, repair and DIY: guides, tool reviews and home projects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Media from the well-known American home improvement TV host. It publishes step-by-step guides, renovation ideas, home maintenance tips, tool and appliance tests and product roundups.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Step-by-step guides
Tool tests
Maintenance tips
Renovation ideas', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'DIY enthusiasts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- BuildBook — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'buildbook.co' OR LOWER(`name`) = LOWER('BuildBook'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BuildBook', NULL, 'https://buildbook.co', NULL, NULL, 'BuildBook — просте ПЗ для керування житловим будівництвом і ремонтом: ліди, кошториси, графіки й клієнтський досвід.', 'BuildBook is simple residential construction management software: leads, estimates, schedules and client experience.', 'Інструмент для невеликих будівельних і ремонтних компаній: облік лідів, кошториси й пропозиції, графіки робіт, задачі, фото та спільний простір для клієнтів, щоб тримати їх у курсі проєкту.', 'A tool for small builders and remodelers: lead tracking, estimates and proposals, job schedules, tasks, photos and a shared client space to keep clients informed.', 'Облік лідів
Кошториси
Графіки
Простір для клієнтів', 'Lead tracking
Estimates
Schedules
Client space', 'Малі будівельні компанії.', 'Small builders.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'buildbook.co' OR LOWER(`name`) = LOWER('BuildBook')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'BuildBook is simple residential construction management software: leads, estimates, schedules and client experience.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A tool for small builders and remodelers: lead tracking, estimates and proposals, job schedules, tasks, photos and a shared client space to keep clients informed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Lead tracking
Estimates
Schedules
Client space', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Small builders.', 'manual' FROM DUAL WHERE @new = 1;

-- Buildertrend — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'buildertrend.com' OR LOWER(`name`) = LOWER('Buildertrend'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Buildertrend', NULL, 'https://buildertrend.com', NULL, NULL, 'Buildertrend — ПЗ для керування будівельними й ремонтними проєктами: графіки, кошториси, фінанси, клієнтський портал і застосунок.', 'Buildertrend is construction project management software: schedules, estimates, financials, a client portal and an app.', 'Платформа для житлових будівельників і ремонтних компаній. Об''єднує продажі (CRM, пропозиції), планування, щоденники, кошториси, бюджети, закупівлі, рахунки й комунікацію з клієнтами в порталі; є мобільний застосунок для бригад.', 'A platform for residential builders and remodelers. It unifies sales (CRM, proposals), scheduling, daily logs, estimates, budgets, purchasing, invoicing and client communication via a portal, with a mobile app for crews.', 'CRM і пропозиції
Графіки
Бюджети
Клієнтський портал', 'CRM and proposals
Scheduling
Budgets
Client portal', 'Будівельні й ремонтні компанії.', 'Builders and remodelers.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'buildertrend.com' OR LOWER(`name`) = LOWER('Buildertrend')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Buildertrend is construction project management software: schedules, estimates, financials, a client portal and an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform for residential builders and remodelers. It unifies sales (CRM, proposals), scheduling, daily logs, estimates, budgets, purchasing, invoicing and client communication via a portal, with a mobile app for crews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'CRM and proposals
Scheduling
Budgets
Client portal', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Builders and remodelers.', 'manual' FROM DUAL WHERE @new = 1;

-- Cedreo — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cedreo.com' OR LOWER(`name`) = LOWER('Cedreo'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Cedreo', NULL, 'https://cedreo.com', NULL, NULL, 'Cedreo — 3D-проєктування будинків для будівельників і ремонтників: 2D/3D-плани й фотореалістичні рендери інтер''єру та фасадів за 2 години.', 'Cedreo is 3D home design for builders and remodelers: 2D/3D plans and photorealistic interior and exterior renders in 2 hours.', 'Браузерне ПЗ для швидкого створення поверхових планів, 3D-моделей і реалістичних рендерів для продажу проєктів клієнтам. Орієнтоване на будівельників, ремонтні компанії, архітекторів і дизайнерів; можна почати безкоштовно.', 'Browser software for quickly creating floor plans, 3D models and realistic renders to sell projects to clients. Aimed at builders, remodelers, architects and designers; you can start free.', '2D/3D-плани
Фотореалістичні рендери
Фасади й інтер''єри
Старт безкоштовно', '2D/3D plans
Photorealistic renders
Exteriors and interiors
Free start', 'Будівельники й ремонтники.', 'Builders and remodelers.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cedreo.com' OR LOWER(`name`) = LOWER('Cedreo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Cedreo is 3D home design for builders and remodelers: 2D/3D plans and photorealistic interior and exterior renders in 2 hours.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Browser software for quickly creating floor plans, 3D models and realistic renders to sell projects to clients. Aimed at builders, remodelers, architects and designers; you can start free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '2D/3D plans
Photorealistic renders
Exteriors and interiors
Free start', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Builders and remodelers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Пробний проєкт', 'Trial project' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Trial project', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Checkatrade — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'checkatrade.com' OR LOWER(`name`) = LOWER('Checkatrade'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Checkatrade', NULL, 'https://www.checkatrade.com', NULL, NULL, 'Checkatrade — британський каталог перевірених майстрів з мільйонами відгуків і гарантією на роботу до 1 000 £.', 'Checkatrade is a UK directory of vetted tradespeople with millions of reviews and a work guarantee up to £1,000.', 'Сервіс пошуку будівельників, сантехніків, електриків і ландшафтних дизайнерів у Великій Британії. Майстри проходять перевірку, мають рейтинги з відгуків клієнтів, а на сайті є орієнтовні ціни робіт (патіо, прибудови тощо) та гарантія Checkatrade.', 'A service for finding builders, plumbers, electricians and landscapers in the UK. Trades are vetted and rated from customer reviews, and the site shows typical job prices (patios, extensions and more) and the Checkatrade guarantee.', 'Перевірені майстри
Мільйони відгуків
Орієнтовні ціни
Гарантія', 'Vetted trades
Millions of reviews
Typical prices
Guarantee', 'Власники житла у Великій Британії.', 'UK homeowners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'checkatrade.com' OR LOWER(`name`) = LOWER('Checkatrade')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Checkatrade is a UK directory of vetted tradespeople with millions of reviews and a work guarantee up to £1,000.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service for finding builders, plumbers, electricians and landscapers in the UK. Trades are vetted and rated from customer reviews, and the site shows typical job prices (patios, extensions and more) and the Checkatrade guarantee.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Vetted trades
Millions of reviews
Typical prices
Guarantee', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'UK homeowners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для замовників', 'For customers' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For customers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Family Handyman — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'familyhandyman.com' OR LOWER(`name`) = LOWER('Family Handyman'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Family Handyman', NULL, 'https://www.familyhandyman.com', NULL, NULL, 'Family Handyman — журнал і сайт DIY: інструкції з ремонту, обслуговування дому, роботи з деревом, інструментів і садових проєктів.', 'Family Handyman is a DIY magazine and site: how-tos on repairs, home maintenance, woodworking, tools and yard projects.', 'Видання з багаторічною історією, яке публікує перевірені інструкції для самостійного ремонту, проєкти з дерева, поради з інструментів і обслуговування будинку та двору.', 'A long-running publication with tested instructions for DIY repairs, woodworking projects and advice on tools and home and yard maintenance.', 'Інструкції ремонту
Проєкти з дерева
Поради з інструментів', 'Repair how-tos
Woodworking projects
Tool advice', 'DIY-ентузіасти.', 'DIY enthusiasts.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'familyhandyman.com' OR LOWER(`name`) = LOWER('Family Handyman')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Family Handyman is a DIY magazine and site: how-tos on repairs, home maintenance, woodworking, tools and yard projects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A long-running publication with tested instructions for DIY repairs, woodworking projects and advice on tools and home and yard maintenance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Repair how-tos
Woodworking projects
Tool advice', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'DIY enthusiasts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Fixr — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fixr.com' OR LOWER(`name`) = LOWER('Fixr'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fixr', NULL, 'https://www.fixr.com', NULL, NULL, 'Fixr — гіди вартості ремонтних робіт у США та пошук підрядників: ванні, кухні, каміни, покрівля тощо.', 'Fixr offers US home improvement cost guides and contractor search: bathrooms, kitchens, fireplaces, roofing and more.', 'Сайт з детальними гідами вартості сотень видів робіт (ремонт ванної 5x10, встановлення каміна, обшивка тощо) з діапазонами цін і факторами вартості, а також пошуком місцевих підрядників.', 'A site with detailed cost guides for hundreds of projects (5x10 bathroom remodel, fireplace installation, siding and more) with price ranges and cost factors, plus local contractor search.', 'Гіди вартості
Діапазони цін
Пошук підрядників', 'Cost guides
Price ranges
Contractor search', 'Власники житла, що планують бюджет.', 'Homeowners budgeting projects.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fixr.com' OR LOWER(`name`) = LOWER('Fixr')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fixr offers US home improvement cost guides and contractor search: bathrooms, kitchens, fireplaces, roofing and more.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site with detailed cost guides for hundreds of projects (5x10 bathroom remodel, fireplace installation, siding and more) with price ranges and cost factors, plus local contractor search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cost guides
Price ranges
Contractor search', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners budgeting projects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Floorplanner — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'floorplanner.com' OR LOWER(`name`) = LOWER('Floorplanner'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Floorplanner', NULL, 'https://floorplanner.com', NULL, NULL, 'Floorplanner — онлайн-планувальник 2D/3D: поверхові плани, розстановка меблів і візуалізації для особистих і професійних проєктів.', 'Floorplanner is an online 2D/3D planner: floor plans, furniture layout and renders for personal and professional projects.', 'Браузерний інструмент для креслення стін, дверей і вікон, розстановки меблів з бібліотеки й перегляду кімнат у 3D. Підходить для особистого використання, ритейлу й нерухомості; є безкоштовний базовий рівень і платні можливості для рендерів та експорту.', 'A browser tool for drawing walls, doors and windows, placing furniture from a library and viewing rooms in 3D. Suited to personal use, retail and real estate; a free basic tier plus paid options for renders and export.', '2D-плани
3D-перегляд
Бібліотека меблів
У браузері', '2D plans
3D view
Furniture library
In the browser', 'Власники житла й ріелтори.', 'Homeowners and realtors.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'floorplanner.com' OR LOWER(`name`) = LOWER('Floorplanner')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Floorplanner is an online 2D/3D planner: floor plans, furniture layout and renders for personal and professional projects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A browser tool for drawing walls, doors and windows, placing furniture from a library and viewing rooms in 3D. Suited to personal use, retail and real estate; a free basic tier plus paid options for renders and export.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '2D plans
3D view
Furniture library
In the browser', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners and realtors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базовий рівень', 'Basic tier' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic tier', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Handy — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'handy.com' OR LOWER(`name`) = LOWER('Handy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Handy', NULL, 'https://www.handy.com', NULL, NULL, 'Handy — бронювання прибирання та послуг майстра за 60 секунд: збирання меблів, монтаж ТВ і дрібний ремонт.', 'Handy books house cleaning and handyman services in 60 seconds: furniture assembly, TV mounting and small repairs.', 'Сервіс (належить Angi) у США, Канаді й Великій Британії для бронювання прибирання, збирання меблів, монтажу телевізорів та інших домашніх послуг із перевіреними місцевими фахівцями й гарантією задоволення Handy.', 'A service (owned by Angi) in the US, Canada and UK for booking cleaning, furniture assembly, TV mounting and other home services with vetted local pros and the Handy Happiness Guarantee.', 'Прибирання
Збирання меблів
Монтаж ТВ
Гарантія', 'Cleaning
Furniture assembly
TV mounting
Guarantee', 'Зайняті мешканці міст.', 'Busy city residents.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'handy.com' OR LOWER(`name`) = LOWER('Handy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Handy books house cleaning and handyman services in 60 seconds: furniture assembly, TV mounting and small repairs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service (owned by Angi) in the US, Canada and UK for booking cleaning, furniture assembly, TV mounting and other home services with vetted local pros and the Handy Happiness Guarantee.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cleaning
Furniture assembly
TV mounting
Guarantee', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Busy city residents.', 'manual' FROM DUAL WHERE @new = 1;

-- HomeAdvisor — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'homeadvisor.com' OR LOWER(`name`) = LOWER('HomeAdvisor'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HomeAdvisor', NULL, 'https://www.homeadvisor.com', NULL, NULL, 'HomeAdvisor — пошук місцевих фахівців з ремонту й поліпшення житла з відгуками та калькуляторами вартості (частина Angi).', 'HomeAdvisor finds local home repair and improvement pros with reviews and cost calculators (part of Angi).', 'Американський сервіс, що підбирає перевірених майстрів під проєкт, публікує відгуки та гіди «скільки коштує» для ремонтних робіт. Для власників житла безкоштовний.', 'A US service that matches screened pros to your project and publishes reviews and "how much does it cost" guides for home projects. Free for homeowners.', 'Підбір майстрів
Гіди вартості
Відгуки
Безкоштовно', 'Pro matching
Cost guides
Reviews
Free', 'Власники житла в США.', 'US homeowners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'homeadvisor.com' OR LOWER(`name`) = LOWER('HomeAdvisor')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'HomeAdvisor finds local home repair and improvement pros with reviews and cost calculators (part of Angi).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A US service that matches screened pros to your project and publishes reviews and "how much does it cost" guides for home projects. Free for homeowners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Pro matching
Cost guides
Reviews
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US homeowners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для власників', 'For homeowners' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For homeowners', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- HomeDesignsAI — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'homedesigns.ai' OR LOWER(`name`) = LOWER('HomeDesignsAI'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HomeDesignsAI', NULL, 'https://homedesigns.ai', NULL, NULL, 'HomeDesignsAI — AI-дизайн інтер''єрів, фасадів і садів за секунди: понад 200 стилів, 2,79 млн користувачів.', 'HomeDesignsAI is AI design for interiors, exteriors and gardens in seconds: 200+ styles, 2.79M users.', 'Онлайн-інструмент, що за фотографією кімнати, фасаду чи саду генерує редизайн у вибраному стилі. Пропонує понад 200 стилів, заміну меблів і матеріалів, віртуальне декорування для ріелторів.', 'An online tool that generates a redesign in a chosen style from a photo of a room, exterior or garden. It offers 200+ styles, furniture and material swaps and virtual staging for realtors.', '200+ стилів
Інтер''єри, фасади, сади
Заміна матеріалів
Віртуальне декорування', '200+ styles
Interiors, exteriors, gardens
Material swaps
Virtual staging', 'Власники житла й ріелтори.', 'Homeowners and realtors.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'homedesigns.ai' OR LOWER(`name`) = LOWER('HomeDesignsAI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'HomeDesignsAI is AI design for interiors, exteriors and gardens in seconds: 200+ styles, 2.79M users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An online tool that generates a redesign in a chosen style from a photo of a room, exterior or garden. It offers 200+ styles, furniture and material swaps and virtual staging for realtors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '200+ styles
Interiors, exteriors, gardens
Material swaps
Virtual staging', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners and realtors.', 'manual' FROM DUAL WHERE @new = 1;

-- Houzz — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'houzz.com' OR LOWER(`name`) = LOWER('Houzz'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Houzz', NULL, 'https://www.houzz.com', NULL, NULL, 'Houzz — платформа для власників житла й професіоналів: ідеї інтер''єрів, каталог товарів, пошук підрядників і ПЗ для дизайнерів і будівельників.', 'Houzz is a platform for homeowners and pros: interior ideas, a product catalog, contractor search and software for designers and builders.', 'Власникам житла Houzz дає мільйони фото інтер''єрів, каталог меблів і матеріалів, пошук і відгуки про архітекторів, дизайнерів і бригади. Професіоналам — Houzz Pro: CRM, кошториси, проєкти, 3D-плани й рахунки з пробним періодом 30 днів.', 'For homeowners Houzz offers millions of interior photos, a furniture and materials catalog and search and reviews for architects, designers and contractors. For pros, Houzz Pro provides CRM, estimates, projects, 3D plans and invoicing with a 30-day trial.', 'Мільйони фото ідей
Пошук підрядників
Каталог товарів
Houzz Pro для фахівців', 'Millions of idea photos
Contractor search
Product catalog
Houzz Pro for pros', 'Власники житла, дизайнери й будівельники.', 'Homeowners, designers and builders.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'houzz.com' OR LOWER(`name`) = LOWER('Houzz')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Houzz is a platform for homeowners and pros: interior ideas, a product catalog, contractor search and software for designers and builders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'For homeowners Houzz offers millions of interior photos, a furniture and materials catalog and search and reviews for architects, designers and contractors. For pros, Houzz Pro provides CRM, estimates, projects, 3D plans and invoicing with a 30-day trial.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Millions of idea photos
Contractor search
Product catalog
Houzz Pro for pros', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners, designers and builders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Для власників', 'For homeowners', 0.00, 'free', 'Ідеї й пошук фахівців', 'Ideas and pro search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Для власників' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'For homeowners', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Ideas and pro search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- IKEA Planners — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ikea.com/us/en/planners' OR LOWER(`name`) = LOWER('IKEA Planners'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'IKEA Planners', NULL, 'https://www.ikea.com/us/en/planners/', NULL, NULL, 'Планувальники IKEA — онлайн-інструменти для проєктування кухні, ванної, офісу, систем зберігання й модульних диванів.', 'IKEA Planners are online tools for designing kitchens, bathrooms, offices, storage systems and modular sofas.', 'Набір безкоштовних 3D-планувальників IKEA: кухні METOD, шафи PAX, системи зберігання, ванні, робочі місця й модульні дивани. Дозволяють задати розміри приміщення, підібрати модулі, побачити ціну й список товарів для замовлення.', 'A set of free IKEA 3D planners: METOD kitchens, PAX wardrobes, storage systems, bathrooms, workspaces and modular sofas. They let you set room dimensions, pick modules and see the price and shopping list.', 'Планувальник кухні
Шафи PAX
3D-перегляд
Список товарів і ціна', 'Kitchen planner
PAX wardrobes
3D view
Shopping list and price', 'Покупці IKEA.', 'IKEA shoppers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ikea.com/us/en/planners' OR LOWER(`name`) = LOWER('IKEA Planners')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'IKEA Planners are online tools for designing kitchens, bathrooms, offices, storage systems and modular sofas.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A set of free IKEA 3D planners: METOD kitchens, PAX wardrobes, storage systems, bathrooms, workspaces and modular sofas. They let you set room dimensions, pick modules and see the price and shopping list.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Kitchen planner
PAX wardrobes
3D view
Shopping list and price', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'IKEA shoppers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Онлайн-планувальники', 'Online planners' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Online planners', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Leroy Merlin — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'leroymerlin.fr' OR LOWER(`name`) = LOWER('Leroy Merlin'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Leroy Merlin', NULL, 'https://www.leroymerlin.fr', NULL, NULL, 'Leroy Merlin — європейська мережа товарів для ремонту, облаштування й саду з онлайн-магазином, планувальниками й порадами.', 'Leroy Merlin is a European home improvement and garden chain with an online store, planners and advice.', 'Французький рітейлер, присутній у багатьох країнах. Сайт і застосунок пропонують каталог будматеріалів, інструментів, кухонь і ванних, 3D-планувальники, послуги монтажу, оренду інструментів і покрокові інструкції.', 'A French retailer present in many countries. The site and app offer a catalog of building materials, tools, kitchens and bathrooms, 3D planners, installation services, tool rental and step-by-step guides.', 'Каталог для ремонту
3D-планувальники
Послуги монтажу
Інструкції', 'Renovation catalog
3D planners
Installation services
How-tos', 'Мешканці Європи, що роблять ремонт.', 'People renovating in Europe.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'leroymerlin.fr' OR LOWER(`name`) = LOWER('Leroy Merlin')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Leroy Merlin is a European home improvement and garden chain with an online store, planners and advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A French retailer present in many countries. The site and app offer a catalog of building materials, tools, kitchens and bathrooms, 3D planners, installation services, tool rental and step-by-step guides.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Renovation catalog
3D planners
Installation services
How-tos', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People renovating in Europe.', 'manual' FROM DUAL WHERE @new = 1;

-- Lowe's — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lowes.com' OR LOWER(`name`) = LOWER('Lowe''s'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lowe''s', NULL, 'https://www.lowes.com', NULL, NULL, 'Lowe''s — американська мережа товарів для дому й ремонту: інструменти, матеріали, техніка, сад, послуги монтажу та застосунок.', 'Lowe''s is a US home improvement chain: tools, materials, appliances, garden, installation services and an app.', 'Інтернет-магазин і мобільний застосунок мережі з пошуком наявності в магазинах, самовивозом і доставкою, програмою лояльності MyLowe''s Rewards, послугами встановлення та порадами для DIY-проєктів.', 'The chain''s online store and mobile app with store availability search, pickup and delivery, the MyLowe''s Rewards program, installation services and DIY project advice.', 'Наявність у магазинах
MyLowe''s Rewards
Послуги встановлення
Поради DIY', 'Store availability
MyLowe''s Rewards
Installation services
DIY advice', 'Власники житла в США.', 'US homeowners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lowes.com' OR LOWER(`name`) = LOWER('Lowe''s')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Lowe''s is a US home improvement chain: tools, materials, appliances, garden, installation services and an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The chain''s online store and mobile app with store availability search, pickup and delivery, the MyLowe''s Rewards program, installation services and DIY project advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Store availability
MyLowe''s Rewards
Installation services
DIY advice', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- magicplan — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'magicplan.app' OR LOWER(`name`) = LOWER('magicplan'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'magicplan', NULL, 'https://www.magicplan.app', NULL, NULL, 'magicplan — створення поверхових планів зі смартфона й ПЗ для документування та кошторисів ремонтно-відновлювальних робіт з інтеграцією Xactimate.', 'magicplan creates floor plans from a smartphone and is software for documenting and estimating restoration work with Xactimate integration.', 'Застосунок сканує приміщення камерою чи LiDAR і будує плани з розмірами. Зараз орієнтований на підрядників відновлювальних робіт: фіксація обсягів, фото й документів на об''єкті, автоматична передача в офіс і кошторис у Xactimate без повторного введення.', 'The app scans rooms with camera or LiDAR to build dimensioned floor plans. It now targets restoration contractors: capturing scopes, photos and documents on site, syncing to the office and estimating in Xactimate without re-entry.', 'Плани зі смартфона
LiDAR-сканування
Фото й документи
Інтеграція Xactimate', 'Plans from a phone
LiDAR scanning
Photos and documents
Xactimate integration', 'Підрядники ремонту й відновлення.', 'Renovation and restoration contractors.', 'mobile,web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'magicplan.app' OR LOWER(`name`) = LOWER('magicplan')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'magicplan creates floor plans from a smartphone and is software for documenting and estimating restoration work with Xactimate integration.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app scans rooms with camera or LiDAR to build dimensioned floor plans. It now targets restoration contractors: capturing scopes, photos and documents on site, syncing to the office and estimating in Xactimate without re-entry.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Plans from a phone
LiDAR scanning
Photos and documents
Xactimate integration', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Renovation and restoration contractors.', 'manual' FROM DUAL WHERE @new = 1;

-- MyBuilder — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mybuilder.com' OR LOWER(`name`) = LOWER('MyBuilder'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MyBuilder', NULL, 'https://www.mybuilder.com', NULL, NULL, 'MyBuilder — британський сервіс для розміщення завдань і отримання пропозицій від місцевих будівельників і майстрів з відгуками.', 'MyBuilder is a UK service to post jobs and get quotes from local builders and tradespeople with reviews.', 'Платформа (частина Checkatrade), де власник житла безкоштовно публікує завдання — від дрібного ремонту до прибудов, — отримує зацікавлення від майстрів і обирає за відгуками та портфоліо.', 'A platform (part of Checkatrade) where homeowners post jobs for free — from small repairs to extensions — receive interest from tradespeople and choose by reviews and portfolio.', 'Публікація завдань
Відгуки й портфоліо
Безкоштовно для власників', 'Job posting
Reviews and portfolios
Free for homeowners', 'Власники житла у Великій Британії.', 'UK homeowners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mybuilder.com' OR LOWER(`name`) = LOWER('MyBuilder')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'MyBuilder is a UK service to post jobs and get quotes from local builders and tradespeople with reviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform (part of Checkatrade) where homeowners post jobs for free — from small repairs to extensions — receive interest from tradespeople and choose by reviews and portfolio.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Job posting
Reviews and portfolios
Free for homeowners', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'UK homeowners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для власників житла', 'For homeowners' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For homeowners', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Remodel AI — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'remodelai.app' OR LOWER(`name`) = LOWER('Remodel AI'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Remodel AI', NULL, 'https://www.remodelai.app', NULL, NULL, 'Remodel AI — застосунок, що за фото приміщення миттєво показує варіант ремонту: нова підлога, стіни, стиль кухні чи ванної.', 'Remodel AI is an app that turns a room photo into an instant renovation preview: new flooring, walls, kitchen or bath style.', 'Мобільний AI-застосунок для візуалізації ремонту: фотографуєте кімнату, кухню, ванну чи фасад і обираєте стиль, підлогу, кольори стін — застосунок генерує оновлений вигляд.', 'A mobile AI app for renovation previews: photograph a room, kitchen, bathroom or exterior and choose style, flooring and wall colors — the app generates the updated look.', 'Візуалізація з фото
Стилі ремонту
Підлога й стіни
Фасади', 'Photo-based preview
Renovation styles
Floors and walls
Exteriors', 'Власники житла, що планують ремонт.', 'Homeowners planning a remodel.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'remodelai.app' OR LOWER(`name`) = LOWER('Remodel AI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Remodel AI is an app that turns a room photo into an instant renovation preview: new flooring, walls, kitchen or bath style.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A mobile AI app for renovation previews: photograph a room, kitchen, bathroom or exterior and choose style, flooring and wall colors — the app generates the updated look.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Photo-based preview
Renovation styles
Floors and walls
Exteriors', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners planning a remodel.', 'manual' FROM DUAL WHERE @new = 1;

-- ReRoom — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'reroom.ai' OR LOWER(`name`) = LOWER('ReRoom'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ReRoom', NULL, 'https://reroom.ai', NULL, NULL, 'ReRoom — AI-рендеринг інтер''єрів: завантажте скриншот моделі й отримайте фотореалістичну візуалізацію зі збереженням дизайну й матеріалів.', 'ReRoom is AI interior rendering: upload a model screenshot and get a photorealistic render that keeps your design and materials.', 'Сервіс для дизайнерів інтер''єрів і архітекторів, що перетворює скриншот 3D-моделі (SketchUp, Revit тощо) на фотореалістичний рендер за допомогою AI, не змінюючи планування й матеріали.', 'A service for interior designers and architects that turns a 3D model screenshot (SketchUp, Revit and others) into a photorealistic render with AI, without changing layout or materials.', 'AI-рендеринг
Збереження дизайну
Зі скриншота моделі', 'AI rendering
Keeps your design
From a model screenshot', 'Дизайнери інтер''єру.', 'Interior designers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'reroom.ai' OR LOWER(`name`) = LOWER('ReRoom')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ReRoom is AI interior rendering: upload a model screenshot and get a photorealistic render that keeps your design and materials.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service for interior designers and architects that turns a 3D model screenshot (SketchUp, Revit and others) into a photorealistic render with AI, without changing layout or materials.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI rendering
Keeps your design
From a model screenshot', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Interior designers.', 'manual' FROM DUAL WHERE @new = 1;

-- RoomSketcher — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'roomsketcher.com' OR LOWER(`name`) = LOWER('RoomSketcher'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'RoomSketcher', NULL, 'https://www.roomsketcher.com', NULL, NULL, 'RoomSketcher — створення професійних 2D і 3D поверхових планів за хвилини, з меблями, матеріалами й 3D-оглядом.', 'RoomSketcher creates professional 2D and 3D floor plans in minutes, with furniture, materials and 3D walkthroughs.', 'Програма для швидкого креслення планів, додавання меблів, кольорів і матеріалів та отримання 2D/3D-зображень і 360°-оглядів. Використовують власники житла, ріелтори та дизайнери; є безкоштовна версія й платні підписки.', 'Software for quickly drawing plans, adding furniture, colors and materials and producing 2D/3D images and 360° views. Used by homeowners, realtors and designers; free version plus paid subscriptions.', '2D/3D-плани
360°-огляд
Меблі й матеріали
Безкоштовна версія', '2D/3D plans
360° views
Furniture and materials
Free version', 'Власники житла, ріелтори, дизайнери.', 'Homeowners, realtors, designers.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'roomsketcher.com' OR LOWER(`name`) = LOWER('RoomSketcher')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'RoomSketcher creates professional 2D and 3D floor plans in minutes, with furniture, materials and 3D walkthroughs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Software for quickly drawing plans, adding furniture, colors and materials and producing 2D/3D images and 360° views. Used by homeowners, realtors and designers; free version plus paid subscriptions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '2D/3D plans
360° views
Furniture and materials
Free version', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners, realtors, designers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базова версія', 'Basic version' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic version', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SketchUp — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sketchup.com' OR LOWER(`name`) = LOWER('SketchUp'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SketchUp', NULL, 'https://www.sketchup.com', NULL, NULL, 'SketchUp (Trimble) — 3D-моделювання для архітекторів, дизайнерів і будівельників; плани Go, Pro і Studio.', 'SketchUp (Trimble) is 3D modeling for architects, designers and builders; Go, Pro and Studio plans.', 'Популярний інструмент 3D-моделювання від концепції до будівництва: моделі будинків, інтер''єрів і меблів, бібліотека 3D Warehouse, LayOut для креслень. Є безкоштовна веб-версія для особистого використання та підписки Go (від 10,75 $/міс), Pro (від 33,25 $/міс) і Studio.', 'A popular 3D modeling tool from concept to construction: house, interior and furniture models, the 3D Warehouse library and LayOut for drawings. There is a free web version for personal use and Go (from $10.75/mo), Pro (from $33.25/mo) and Studio subscriptions.', '3D-моделювання
3D Warehouse
Креслення LayOut
Безкоштовна веб-версія', '3D modeling
3D Warehouse
LayOut drawings
Free web version', 'Архітектори, дизайнери, DIY-ентузіасти.', 'Architects, designers, DIY enthusiasts.', 'desktop,web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sketchup.com' OR LOWER(`name`) = LOWER('SketchUp')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SketchUp (Trimble) is 3D modeling for architects, designers and builders; Go, Pro and Studio plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A popular 3D modeling tool from concept to construction: house, interior and furniture models, the 3D Warehouse library and LayOut for drawings. There is a free web version for personal use and Go (from $10.75/mo), Pro (from $33.25/mo) and Studio subscriptions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '3D modeling
3D Warehouse
LayOut drawings
Free web version', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Architects, designers, DIY enthusiasts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Go', 'Go', 10.75, 'month', 'Оплата за рік', 'Billed annually' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Go' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Go', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Billed annually', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Pro', 'Pro', 33.25, 'month', 'Оплата за рік', 'Billed annually' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Pro' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Pro', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Billed annually', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sweet Home 3D — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sweethome3d.com' OR LOWER(`name`) = LOWER('Sweet Home 3D'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sweet Home 3D', NULL, 'https://www.sweethome3d.com', NULL, NULL, 'Sweet Home 3D — безкоштовна програма дизайну інтер''єру: план приміщень, розстановка меблів і реалістичний 3D-перегляд.', 'Sweet Home 3D is free interior design software: room plans, furniture placement and realistic 3D views.', 'Відкрита програма для Windows, macOS і Linux, а також онлайн-версія. Дає змогу накреслити план, розставити меблі з каталогу, імпортувати 3D-моделі, створити фотореалістичні зображення та відео-огляди. Перекладена десятками мов, зокрема українською.', 'Open-source software for Windows, macOS and Linux, plus an online version. It lets you draw a plan, place catalog furniture, import 3D models and produce photorealistic images and video tours. Translated into dozens of languages, including Ukrainian.', 'План і меблі
3D-перегляд
Фотореалістичні рендери
Open source', 'Plans and furniture
3D view
Photorealistic renders
Open source', 'Власники житла, що планують ремонт.', 'Homeowners planning renovations.', 'desktop,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sweethome3d.com' OR LOWER(`name`) = LOWER('Sweet Home 3D')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sweet Home 3D is free interior design software: room plans, furniture placement and realistic 3D views.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Open-source software for Windows, macOS and Linux, plus an online version. It lets you draw a plan, place catalog furniture, import 3D models and produce photorealistic images and video tours. Translated into dozens of languages, including Ukrainian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Plans and furniture
3D view
Photorealistic renders
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners planning renovations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Open source', 'Open source' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Taskrabbit — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'taskrabbit.com' OR LOWER(`name`) = LOWER('Taskrabbit'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Taskrabbit', NULL, 'https://www.taskrabbit.com', NULL, NULL, 'Taskrabbit — майстри на годину того ж дня: збирання меблів, монтаж ТВ і полиць, допомога з переїздом, дрібний ремонт.', 'Taskrabbit offers same-day handymen: furniture assembly, TV and shelf mounting, moving help and small repairs.', 'Сервіс (належить IKEA) для швидкого найму виконавців у США, Великій Британії, Канаді та Європі. Ціни на задачі стартують приблизно від 49 $ (збирання меблів), монтаж ТВ — від 69 $. Можна обрати виконавця за відгуками й ціною та оплатити в застосунку.', 'A service (owned by IKEA) for quickly hiring helpers in the US, UK, Canada and Europe. Tasks start around $49 (furniture assembly), TV mounting from $69. You choose a Tasker by reviews and price and pay in the app.', 'Збирання меблів
Монтаж ТВ
Допомога з переїздом
Того ж дня', 'Furniture assembly
TV mounting
Moving help
Same day', 'Зайняті власники й орендарі житла.', 'Busy homeowners and renters.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'taskrabbit.com' OR LOWER(`name`) = LOWER('Taskrabbit')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Taskrabbit offers same-day handymen: furniture assembly, TV and shelf mounting, moving help and small repairs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service (owned by IKEA) for quickly hiring helpers in the US, UK, Canada and Europe. Tasks start around $49 (furniture assembly), TV mounting from $69. You choose a Tasker by reviews and price and pay in the app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Furniture assembly
TV mounting
Moving help
Same day', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Busy homeowners and renters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Збирання меблів', 'Furniture assembly', 49.00, 'one_time', 'Від 49 $ за задачу', 'From $49 per task' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Збирання меблів' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Furniture assembly', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'From $49 per task', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- The Home Depot — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'homedepot.com' OR LOWER(`name`) = LOWER('The Home Depot'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Home Depot', NULL, 'https://www.homedepot.com', NULL, NULL, 'The Home Depot — найбільша мережа товарів для дому й ремонту в США: інструменти, матеріали, техніка, оренда інструменту й послуги монтажу.', 'The Home Depot is the largest US home improvement chain: tools, materials, appliances, tool rental and installation services.', 'Онлайн-магазин і застосунок мережі: пошук товарів з наявністю в найближчому магазині, навігація проходами, самовивіз і доставка, оренда інструментів, послуги монтажу та гіди «як зробити».', 'The chain''s online store and app: product search with nearby store stock, aisle navigation, pickup and delivery, tool rental, installation services and how-to guides.', 'Наявність у магазині
Оренда інструменту
Послуги монтажу
Гіди DIY', 'In-store availability
Tool rental
Installation services
DIY guides', 'Власники житла й підрядники в США.', 'US homeowners and contractors.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'homedepot.com' OR LOWER(`name`) = LOWER('The Home Depot')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Home Depot is the largest US home improvement chain: tools, materials, appliances, tool rental and installation services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The chain''s online store and app: product search with nearby store stock, aisle navigation, pickup and delivery, tool rental, installation services and how-to guides.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'In-store availability
Tool rental
Installation services
DIY guides', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US homeowners and contractors.', 'manual' FROM DUAL WHERE @new = 1;

-- This Old House — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thisoldhouse.com' OR LOWER(`name`) = LOWER('This Old House'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'This Old House', NULL, 'https://www.thisoldhouse.com', NULL, NULL, 'This Old House — американський бренд порад із ремонту: інструкції DIY, відео, огляди й поради експертів.', 'This Old House is a US home improvement brand: DIY how-tos, videos, reviews and expert advice.', 'Сайт легендарної телепрограми про ремонт будинків. Містить інструкції та відео з ремонту, сантехніки, електрики, покрівлі, саду, а також огляди товарів і послуг для дому.', 'The site of the legendary home renovation TV show. It contains how-tos and videos on renovation, plumbing, electrical, roofing and gardening, plus reviews of home products and services.', 'Інструкції DIY
Відео
Огляди
Поради експертів', 'DIY how-tos
Videos
Reviews
Expert advice', 'Власники будинків і DIY-ентузіасти.', 'Homeowners and DIYers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thisoldhouse.com' OR LOWER(`name`) = LOWER('This Old House')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'This Old House is a US home improvement brand: DIY how-tos, videos, reviews and expert advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The site of the legendary home renovation TV show. It contains how-tos and videos on renovation, plumbing, electrical, roofing and gardening, plus reviews of home products and services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'DIY how-tos
Videos
Reviews
Expert advice', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners and DIYers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Thumbtack — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thumbtack.com' OR LOWER(`name`) = LOWER('Thumbtack'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Thumbtack', NULL, 'https://www.thumbtack.com', NULL, NULL, 'Thumbtack — сервіс догляду за домом: пошук місцевих фахівців для ремонту, прибирання й проєктів, порівняння цін і гарантія до 2 500 $.', 'Thumbtack is a home care service: find local pros for repairs, cleaning and projects, compare prices, with a guarantee up to $2,500.', 'Платформа для пошуку майстрів у США: опишіть завдання, порівняйте ціни й відгуки та найміть фахівця. Застосунок також допомагає планувати обслуговування дому, а гарантія Thumbtack повертає до 2 500 $, якщо роботу виконано не за домовленістю.', 'A US platform to find pros: describe the job, compare prices and reviews and hire. The app also helps plan home maintenance, and the Thumbtack Guarantee refunds up to $2,500 if work isn''t done as agreed.', 'Порівняння цін
Відгуки
План обслуговування дому
Гарантія до 2 500 $', 'Price comparison
Reviews
Home maintenance plan
Guarantee up to $2,500', 'Власники житла в США.', 'US homeowners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thumbtack.com' OR LOWER(`name`) = LOWER('Thumbtack')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Thumbtack is a home care service: find local pros for repairs, cleaning and projects, compare prices, with a guarantee up to $2,500.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A US platform to find pros: describe the job, compare prices and reviews and hire. The app also helps plan home maintenance, and the Thumbtack Guarantee refunds up to $2,500 if work isn''t done as agreed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Price comparison
Reviews
Home maintenance plan
Guarantee up to $2,500', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US homeowners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для замовників', 'For customers' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For customers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Twindo — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'twindo.com' OR LOWER(`name`) = LOWER('Twindo'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Twindo', NULL, 'https://www.twindo.com', NULL, NULL, 'Twindo (колишній Canvas) — LiDAR-сканування приміщень у точні CAD-моделі для Revit, AutoCAD і SketchUp.', 'Twindo (formerly Canvas) turns LiDAR room scans into accurate CAD models for Revit, AutoCAD and SketchUp.', 'Платформа просторового інтелекту: користувач сканує приміщення iPhone чи iPad з LiDAR, а сервіс створює as-built CAD-моделі з точністю близько 99 %. Економить час на обмірах для ремонтів, дизайнерів і підрядників.', 'A spatial intelligence platform: users scan a space with a LiDAR iPhone or iPad and the service produces as-built CAD models with about 99% accuracy. It saves measuring time for remodelers, designers and contractors.', 'LiDAR-сканування
CAD-моделі
Revit, AutoCAD
Точні обміри', 'LiDAR scanning
CAD models
Revit, AutoCAD
Accurate measurements', 'Підрядники й дизайнери.', 'Contractors and designers.', 'mobile,web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'twindo.com' OR LOWER(`name`) = LOWER('Twindo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Twindo (formerly Canvas) turns LiDAR room scans into accurate CAD models for Revit, AutoCAD and SketchUp.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A spatial intelligence platform: users scan a space with a LiDAR iPhone or iPad and the service produces as-built CAD models with about 99% accuracy. It saves measuring time for remodelers, designers and contractors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'LiDAR scanning
CAD models
Revit, AutoCAD
Accurate measurements', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Contractors and designers.', 'manual' FROM DUAL WHERE @new = 1;

-- Епіцентр К — Ремонт і будівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'epicentrk.ua' OR LOWER(`name`) = LOWER('Епіцентр К'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Епіцентр К', NULL, 'https://epicentrk.ua', NULL, NULL, 'Епіцентр — українська мережа гіпермаркетів для дому, ремонту й саду з інтернет-магазином, маркетплейсом і доставкою по країні.', 'Epicentr is a Ukrainian chain of home, renovation and garden hypermarkets with an online store, marketplace and nationwide delivery.', 'Національна мережа торговельних центрів з великим онлайн-каталогом будматеріалів, інструментів, сантехніки, меблів, побутової техніки й товарів для саду. Сайт і застосунок пропонують доставку чи самовивіз, програму лояльності та маркетплейс сторонніх продавців.', 'A national retail chain with a large online catalog of building materials, tools, plumbing, furniture, appliances and garden goods. The site and app offer delivery or pickup, a loyalty program and a third-party marketplace.', 'Будматеріали й інструменти
Доставка або самовивіз
Програма лояльності
Маркетплейс', 'Building materials and tools
Delivery or pickup
Loyalty program
Marketplace', 'Мешканці України, що роблять ремонт.', 'People renovating in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'epicentrk.ua' OR LOWER(`name`) = LOWER('Епіцентр К')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'renovation' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Epicentr is a Ukrainian chain of home, renovation and garden hypermarkets with an online store, marketplace and nationwide delivery.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A national retail chain with a large online catalog of building materials, tools, plumbing, furniture, appliances and garden goods. The site and app offer delivery or pickup, a loyalty program and a third-party marketplace.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Building materials and tools
Delivery or pickup
Loyalty program
Marketplace', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People renovating in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;

-- Apartment List — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apartmentlist.com' OR LOWER(`name`) = LOWER('Apartment List'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Apartment List', NULL, 'https://www.apartmentlist.com', NULL, NULL, 'Apartment List — персоналізований пошук квартир в оренду в США: понад 7 млн квартир, підбір за вподобаннями й дані про ціни.', 'Apartment List personalizes US apartment search: 7M+ apartments, matching by preferences and rent data.', 'Сервіс, що ставить питання про бюджет, район і зручності та підбирає квартири з понад 7 млн варіантів. Публікує щомісячні звіти про ціни оренди в містах США.', 'A service that asks about budget, location and amenities and matches apartments from 7M+ options. It publishes monthly rent reports for US cities.', 'Персоналізований підбір
7 млн+ квартир
Звіти про ціни', 'Personalized matching
7M+ apartments
Rent reports', 'Орендарі в США.', 'US renters.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apartmentlist.com' OR LOWER(`name`) = LOWER('Apartment List')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Apartment List personalizes US apartment search: 7M+ apartments, matching by preferences and rent data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service that asks about budget, location and amenities and matches apartments from 7M+ options. It publishes monthly rent reports for US cities.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Personalized matching
7M+ apartments
Rent reports', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US renters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для орендарів', 'For renters' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For renters', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Apartments.com — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apartments.com' OR LOWER(`name`) = LOWER('Apartments.com'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Apartments.com', NULL, 'https://www.apartments.com', NULL, NULL, 'Apartments.com — пошук квартир і будинків в оренду в США з відео-турами, фільтрами, онлайн-заявками й оплатою.', 'Apartments.com searches US apartments and homes for rent with video tours, filters, online applications and payments.', 'Портал оренди від CoStar з мільйонами оголошень, детальними фільтрами (ціна, тварини, зручності), 3D- і відео-турами, картою поїздок і можливістю подати заявку та сплатити оренду онлайн. Для орендодавців — розміщення й скринінг орендарів.', 'CoStar''s rental portal with millions of listings, detailed filters (price, pets, amenities), 3D and video tours, a commute map and online applications and rent payments. Landlords can list and screen tenants.', 'Детальні фільтри
Відео-тури
Онлайн-заявки
Інструменти для орендодавців', 'Detailed filters
Video tours
Online applications
Landlord tools', 'Орендарі та орендодавці в США.', 'US renters and landlords.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apartments.com' OR LOWER(`name`) = LOWER('Apartments.com')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Apartments.com searches US apartments and homes for rent with video tours, filters, online applications and payments.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'CoStar''s rental portal with millions of listings, detailed filters (price, pets, amenities), 3D and video tours, a commute map and online applications and rent payments. Landlords can list and screen tenants.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Detailed filters
Video tours
Online applications
Landlord tools', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US renters and landlords.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для орендарів', 'For renters' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For renters', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Avail — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'avail.co' OR LOWER(`name`) = LOWER('Avail'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Avail', NULL, 'https://www.avail.co', NULL, NULL, 'Avail (Realtor.com) — ПЗ для приватних орендодавців: оголошення, скринінг, договори, оплата оренди й заявки на ремонт.', 'Avail (Realtor.com) is landlord software: listings, screening, leases, rent collection and maintenance requests.', 'Інструмент керування орендою для дрібних орендодавців: розміщення оголошень на кількох сайтах, перевірка орендарів, шаблони договорів, онлайн-оплата й облік ремонтів. Тариф Unlimited безкоштовний для будь-якої кількості об''єктів, Unlimited Plus — 9 $ за об''єкт на місяць.', 'A rental management tool for small landlords: syndicated listings, tenant screening, lease templates, online rent payments and maintenance tracking. Unlimited is free for any number of units, Unlimited Plus is $9 per unit per month.', 'Розміщення оголошень
Скринінг
Онлайн-оплата
Заявки на ремонт', 'Listing syndication
Screening
Online payments
Maintenance requests', 'Приватні орендодавці в США.', 'US independent landlords.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'avail.co' OR LOWER(`name`) = LOWER('Avail')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Avail (Realtor.com) is landlord software: listings, screening, leases, rent collection and maintenance requests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A rental management tool for small landlords: syndicated listings, tenant screening, lease templates, online rent payments and maintenance tracking. Unlimited is free for any number of units, Unlimited Plus is $9 per unit per month.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Listing syndication
Screening
Online payments
Maintenance requests', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US independent landlords.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Unlimited', 'Unlimited', 0.00, 'free', 'Будь-яка кількість об''єктів', 'Unlimited units' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Unlimited' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Unlimited', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Unlimited units', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Unlimited Plus', 'Unlimited Plus', 9.00, 'month', 'За об''єкт', 'Per unit' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Unlimited Plus' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Unlimited Plus', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Per unit', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- DIM.RIA — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dom.ria.com' OR LOWER(`name`) = LOWER('DIM.RIA'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DIM.RIA', NULL, 'https://dom.ria.com', NULL, NULL, 'DIM.RIA — сайт перевірених оголошень про нерухомість України: продаж і оренда квартир, будинків, новобудови й агентства.', 'DIM.RIA is a Ukrainian site of verified property listings: sale and rent of flats, houses, new builds and agencies.', 'Портал групи RIA з оголошеннями з усієї України, які проходять перевірку. Містить новобудови й забудовників, агентства нерухомості, фільтри, карту та сповіщення про нові пропозиції.', 'An RIA group portal with verified listings from all over Ukraine. It includes new builds and developers, real estate agencies, filters, a map and new-listing alerts.', 'Перевірені оголошення
Новобудови
Агентства
Сповіщення', 'Verified listings
New builds
Agencies
Alerts', 'Покупці й орендарі в Україні.', 'Buyers and renters in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dom.ria.com' OR LOWER(`name`) = LOWER('DIM.RIA')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'DIM.RIA is a Ukrainian site of verified property listings: sale and rent of flats, houses, new builds and agencies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An RIA group portal with verified listings from all over Ukraine. It includes new builds and developers, real estate agencies, filters, a map and new-listing alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Verified listings
New builds
Agencies
Alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Buyers and renters in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Domain — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'domain.com.au' OR LOWER(`name`) = LOWER('Domain'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Domain', NULL, 'https://www.domain.com.au', NULL, NULL, 'Domain — австралійський портал нерухомості: продаж, оренда, аукціони, оцінка вартості й дані ринку.', 'Domain is an Australian property portal: sales, rentals, auctions, valuations and market data.', 'Один з двох головних порталів Австралії з оголошеннями, результатами аукціонів, оцінками вартості, даними про передмістя й інструментами для власників та орендарів.', 'One of Australia''s two major portals with listings, auction results, valuations, suburb data and tools for owners and renters.', 'Продаж і оренда
Аукціони
Оцінки
Дані про передмістя', 'Sale and rent
Auctions
Valuations
Suburb data', 'Покупці й орендарі в Австралії.', 'Buyers and renters in Australia.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'domain.com.au' OR LOWER(`name`) = LOWER('Domain')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Domain is an Australian property portal: sales, rentals, auctions, valuations and market data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'One of Australia''s two major portals with listings, auction results, valuations, suburb data and tools for owners and renters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sale and rent
Auctions
Valuations
Suburb data', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Buyers and renters in Australia.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Flatfy — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'flatfy.ua' OR LOWER(`name`) = LOWER('Flatfy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Flatfy', NULL, 'https://flatfy.ua', NULL, NULL, 'Flatfy від ЛУН — агрегатор оголошень про оренду й продаж нерухомості України з різних сайтів.', 'Flatfy by LUN aggregates Ukrainian property rental and sale listings from many sites.', 'Пошуковик житла, що збирає оголошення з різних українських майданчиків в одній стрічці, з фільтрами за ціною, районом і параметрами, сповіщеннями та переходом на джерело оголошення.', 'A home search engine collecting listings from various Ukrainian platforms in one feed, with filters by price, district and features, alerts and links to the original listing.', 'Агрегація оголошень
Фільтри
Сповіщення', 'Listing aggregation
Filters
Alerts', 'Орендарі й покупці в Україні.', 'Renters and buyers in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'flatfy.ua' OR LOWER(`name`) = LOWER('Flatfy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Flatfy by LUN aggregates Ukrainian property rental and sale listings from many sites.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A home search engine collecting listings from various Ukrainian platforms in one feed, with filters by price, district and features, alerts and links to the original listing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Listing aggregation
Filters
Alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Renters and buyers in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Funda — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'funda.nl' OR LOWER(`name`) = LOWER('Funda'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Funda', NULL, 'https://www.funda.nl', NULL, NULL, 'Funda — головний портал нерухомості Нідерландів: будинки й квартири на продаж і в оренду з фото, планами й цінами.', 'Funda is the main Dutch property portal: houses and flats for sale and rent with photos, floor plans and prices.', 'Нідерландський портал, де агентства розміщують майже всі об''єкти країни. Пропонує фільтри, карту, поверхові плани, сповіщення й історію пошуку.', 'The Dutch portal where agencies list nearly all of the country''s properties. It offers filters, a map, floor plans, alerts and saved searches.', 'Продаж і оренда
Поверхові плани
Карта
Сповіщення', 'Sale and rent
Floor plans
Map
Alerts', 'Покупці й орендарі в Нідерландах.', 'Buyers and renters in the Netherlands.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'funda.nl' OR LOWER(`name`) = LOWER('Funda')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Funda is the main Dutch property portal: houses and flats for sale and rent with photos, floor plans and prices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Dutch portal where agencies list nearly all of the country''s properties. It offers filters, a map, floor plans, alerts and saved searches.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sale and rent
Floor plans
Map
Alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Buyers and renters in the Netherlands.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- HouseCanary — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'housecanary.com' OR LOWER(`name`) = LOWER('HouseCanary'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HouseCanary', NULL, 'https://www.housecanary.com', NULL, NULL, 'HouseCanary — AI-аналітика нерухомості: оцінки, прогнози й дані про 136+ млн об''єктів у США.', 'HouseCanary offers AI real estate analytics: valuations, forecasts and data on 136M+ US properties.', 'Платформа даних для інвесторів, кредиторів і агентів: автоматизовані оцінки вартості, прогнози цін, ризики, порівняльні продажі та аналітика ринку по понад 136 млн об''єктах.', 'A data platform for investors, lenders and agents: automated valuations, price forecasts, risk, comparable sales and market analytics on 136M+ properties.', 'AI-оцінки
Прогнози цін
Порівняльні продажі
Аналітика ринку', 'AI valuations
Price forecasts
Comparable sales
Market analytics', 'Інвестори й кредитори.', 'Investors and lenders.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'housecanary.com' OR LOWER(`name`) = LOWER('HouseCanary')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'HouseCanary offers AI real estate analytics: valuations, forecasts and data on 136M+ US properties.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A data platform for investors, lenders and agents: automated valuations, price forecasts, risk, comparable sales and market analytics on 136M+ properties.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI valuations
Price forecasts
Comparable sales
Market analytics', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Investors and lenders.', 'manual' FROM DUAL WHERE @new = 1;

-- HousingAnywhere — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'housinganywhere.com' OR LOWER(`name`) = LOWER('HousingAnywhere'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HousingAnywhere', NULL, 'https://housinganywhere.com', NULL, NULL, 'HousingAnywhere — середньо- і довгострокова оренда в 400+ містах: кімнати, студії й квартири з онлайн-бронюванням.', 'HousingAnywhere offers mid- to long-term rentals in 400+ cities: rooms, studios and apartments with online booking.', 'Платформа оренди для студентів, експатів і тих, хто переїжджає: житло в Європі та інших регіонах, яке можна забронювати онлайн без огляду, із захистом платежу до заселення.', 'A rental platform for students, expats and movers: housing across Europe and beyond, bookable online without viewing, with payment protection until move-in.', '400+ міст
Онлайн-бронювання
Захист платежу
Для студентів', '400+ cities
Online booking
Payment protection
For students', 'Студенти й експати.', 'Students and expats.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'housinganywhere.com' OR LOWER(`name`) = LOWER('HousingAnywhere')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'HousingAnywhere offers mid- to long-term rentals in 400+ cities: rooms, studios and apartments with online booking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A rental platform for students, expats and movers: housing across Europe and beyond, bookable online without viewing, with payment protection until move-in.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '400+ cities
Online booking
Payment protection
For students', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students and expats.', 'manual' FROM DUAL WHERE @new = 1;

-- idealista — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'idealista.com' OR LOWER(`name`) = LOWER('idealista'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'idealista', NULL, 'https://www.idealista.com', NULL, NULL, 'idealista — провідний портал нерухомості Іспанії, Португалії та Італії: продаж, оренда, кімнати, новобудови.', 'idealista is the leading property portal in Spain, Portugal and Italy: sale, rent, rooms and new builds.', 'Портал з оголошеннями про квартири, будинки, кімнати, офіси й гаражі в Іспанії, Португалії та Італії. Має карту пошуку, сповіщення, оцінку вартості й інструменти для агентств.', 'A portal with listings of flats, houses, rooms, offices and garages in Spain, Portugal and Italy. It has map search, alerts, valuations and agency tools.', 'Іспанія, Португалія, Італія
Кімнати й квартири
Пошук на карті
Оцінка вартості', 'Spain, Portugal, Italy
Rooms and flats
Map search
Valuations', 'Покупці, орендарі й переселенці в Південній Європі.', 'Buyers, renters and movers in Southern Europe.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'idealista.com' OR LOWER(`name`) = LOWER('idealista')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'idealista is the leading property portal in Spain, Portugal and Italy: sale, rent, rooms and new builds.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A portal with listings of flats, houses, rooms, offices and garages in Spain, Portugal and Italy. It has map search, alerts, valuations and agency tools.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Spain, Portugal, Italy
Rooms and flats
Map search
Valuations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Buyers, renters and movers in Southern Europe.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ImmoScout24 — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'immobilienscout24.de' OR LOWER(`name`) = LOWER('ImmoScout24'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ImmoScout24', NULL, 'https://www.immobilienscout24.de', NULL, NULL, 'ImmoScout24 — найбільший портал нерухомості Німеччини: оренда й купівля квартир і будинків, оцінка й послуги для переїзду.', 'ImmoScout24 is Germany''s largest property portal: renting and buying flats and houses, valuations and moving services.', 'Німецький портал оголошень про оренду й продаж, з фільтрами, сповіщеннями, профілем орендаря, перевіркою платоспроможності (SCHUFA), оцінкою вартості й послугами для переїзду. Преміум-членство MieterPlus/PlusPaket дає пріоритет у заявках.', 'A German listings portal for rent and sale with filters, alerts, tenant profile, credit check (SCHUFA), valuations and moving services. Premium MieterPlus/PlusPaket membership gives priority in applications.', 'Оренда й купівля
Профіль орендаря
Оцінка вартості
Преміум-членство', 'Rent and buy
Tenant profile
Valuations
Premium membership', 'Орендарі й покупці в Німеччині.', 'Renters and buyers in Germany.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'immobilienscout24.de' OR LOWER(`name`) = LOWER('ImmoScout24')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ImmoScout24 is Germany''s largest property portal: renting and buying flats and houses, valuations and moving services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A German listings portal for rent and sale with filters, alerts, tenant profile, credit check (SCHUFA), valuations and moving services. Premium MieterPlus/PlusPaket membership gives priority in applications.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Rent and buy
Tenant profile
Valuations
Premium membership', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Renters and buyers in Germany.', 'manual' FROM DUAL WHERE @new = 1;

-- immowelt — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'immowelt.de' OR LOWER(`name`) = LOWER('immowelt'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'immowelt', NULL, 'https://www.immowelt.de', NULL, NULL, 'immowelt — німецький портал нерухомості: квартири й будинки в оренду та на продаж, ціни й оцінка вартості.', 'immowelt is a German property portal: flats and houses for rent and sale, prices and valuations.', 'Один з великих порталів Німеччини (AVIV Group) з оголошеннями про оренду й продаж, картою цін, оцінкою вартості й порадами щодо оренди та купівлі.', 'One of Germany''s major portals (AVIV Group) with rental and sale listings, a price map, valuations and renting and buying advice.', 'Оренда й продаж
Карта цін
Оцінка вартості
Поради', 'Rent and sale
Price map
Valuations
Advice', 'Орендарі й покупці в Німеччині.', 'Renters and buyers in Germany.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'immowelt.de' OR LOWER(`name`) = LOWER('immowelt')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'immowelt is a German property portal: flats and houses for rent and sale, prices and valuations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'One of Germany''s major portals (AVIV Group) with rental and sale listings, a price map, valuations and renting and buying advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Rent and sale
Price map
Valuations
Advice', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Renters and buyers in Germany.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Landlord Studio — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'landlordstudio.com' OR LOWER(`name`) = LOWER('Landlord Studio'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Landlord Studio', NULL, 'https://www.landlordstudio.com', NULL, NULL, 'Landlord Studio — ПЗ для орендодавців: облік доходів і витрат, звіти для податків, збір оренди й безкоштовний скринінг.', 'Landlord Studio is landlord software: income and expense tracking, tax reports, rent collection and free screening.', 'Застосунок для дрібних інвесторів у нерухомість (США, Велика Британія, Австралія, Канада): бухгалтерія оренди, сканування чеків, звіти, онлайн-оплата й перевірка орендарів, яка для орендодавця безкоштовна.', 'An app for small property investors (US, UK, Australia, Canada): rental bookkeeping, receipt scanning, reports, online payments and tenant screening that is free for landlords.', 'Облік доходів і витрат
Сканування чеків
Звіти для податків
Скринінг', 'Income and expenses
Receipt scanning
Tax reports
Screening', 'Дрібні інвестори в нерухомість.', 'Small property investors.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'landlordstudio.com' OR LOWER(`name`) = LOWER('Landlord Studio')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Landlord Studio is landlord software: income and expense tracking, tax reports, rent collection and free screening.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app for small property investors (US, UK, Australia, Canada): rental bookkeeping, receipt scanning, reports, online payments and tenant screening that is free for landlords.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Income and expenses
Receipt scanning
Tax reports
Screening', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Small property investors.', 'manual' FROM DUAL WHERE @new = 1;

-- OLX Нерухомість — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'olx.ua/uk/nedvizhimost' OR LOWER(`name`) = LOWER('OLX Нерухомість'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OLX Нерухомість', NULL, 'https://www.olx.ua/uk/nedvizhimost/', NULL, NULL, 'OLX Нерухомість — розділ OLX.ua з оголошеннями про продаж, купівлю й оренду квартир, будинків, кімнат і ділянок в Україні.', 'OLX Real Estate is the OLX.ua section with listings to sell, buy and rent flats, houses, rooms and plots in Ukraine.', 'Один з найбільших майданчиків оголошень про нерухомість в Україні: довгострокова й подобова оренда, продаж квартир і будинків, кімнати, ділянки, комерційні приміщення. Є чат з продавцем, фільтри й застосунок.', 'One of Ukraine''s largest real estate listing platforms: long-term and daily rentals, flat and house sales, rooms, plots and commercial premises. Seller chat, filters and an app.', 'Оренда й продаж
Подобова оренда
Чат з продавцем
Застосунок', 'Rent and sale
Daily rentals
Seller chat
App', 'Мешканці України.', 'People in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'olx.ua/uk/nedvizhimost' OR LOWER(`name`) = LOWER('OLX Нерухомість')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'OLX Real Estate is the OLX.ua section with listings to sell, buy and rent flats, houses, rooms and plots in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'One of Ukraine''s largest real estate listing platforms: long-term and daily rentals, flat and house sales, rooms, plots and commercial premises. Seller chat, filters and an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Rent and sale
Daily rentals
Seller chat
App', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для покупців', 'For buyers' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For buyers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Opendoor — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'opendoor.com' OR LOWER(`name`) = LOWER('Opendoor'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Opendoor', NULL, 'https://www.opendoor.com', NULL, NULL, 'Opendoor — швидкий продаж житла в США: миттєва пропозиція викупу, без показів і з вибором дати закриття угоди.', 'Opendoor sells US homes fast: an instant purchase offer, no showings and your choice of closing date.', 'iBuyer-сервіс, що на основі даних ринку дає власнику безкоштовну пропозицію викупу будинку, дозволяє уникнути показів і ремонту та закрити угоду у зручний час. Також показує оцінки вартості й ринкову статистику.', 'An iBuyer service that uses market data to give owners a free offer to buy their home, avoiding showings and repairs and closing on their timeline. It also shows value estimates and market stats.', 'Миттєва пропозиція
Без показів
Вибір дати закриття
Оцінки вартості', 'Instant offer
No showings
Choose closing date
Value estimates', 'Продавці житла в США.', 'US home sellers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'opendoor.com' OR LOWER(`name`) = LOWER('Opendoor')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Opendoor sells US homes fast: an instant purchase offer, no showings and your choice of closing date.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An iBuyer service that uses market data to give owners a free offer to buy their home, avoiding showings and repairs and closing on their timeline. It also shows value estimates and market stats.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Instant offer
No showings
Choose closing date
Value estimates', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US home sellers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Пропозиція', 'Offer', 0.00, 'free', 'Безкоштовна оцінка', 'Free offer' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Пропозиція' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Offer', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free offer', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Otodom — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'otodom.pl' OR LOWER(`name`) = LOWER('Otodom'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Otodom', NULL, 'https://www.otodom.pl', NULL, NULL, 'Otodom — найпопулярніший польський портал нерухомості: квартири, будинки, ділянки й комерція на продаж і в оренду.', 'Otodom is Poland''s most popular property portal: flats, houses, plots and commercial space for sale and rent.', 'Портал (OLX Group) з оголошеннями від забудовників, агентств і приватних осіб. Категорії: квартири, будинки, ділянки, комерційні приміщення; є фільтри, карта й сповіщення.', 'A portal (OLX Group) with listings from developers, agencies and private owners. Categories: flats, houses, plots, commercial premises; filters, map and alerts.', 'Квартири й будинки
Ділянки
Від власників і забудовників
Сповіщення', 'Flats and houses
Plots
From owners and developers
Alerts', 'Покупці й орендарі в Польщі, зокрема українці.', 'Buyers and renters in Poland, including Ukrainians.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'otodom.pl' OR LOWER(`name`) = LOWER('Otodom')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Otodom is Poland''s most popular property portal: flats, houses, plots and commercial space for sale and rent.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A portal (OLX Group) with listings from developers, agencies and private owners. Categories: flats, houses, plots, commercial premises; filters, map and alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Flats and houses
Plots
From owners and developers
Alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Buyers and renters in Poland, including Ukrainians.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- realestate.com.au — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'realestate.com.au' OR LOWER(`name`) = LOWER('realestate.com.au'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'realestate.com.au', NULL, 'https://www.realestate.com.au', NULL, NULL, 'realestate.com.au (REA Group) — найбільший австралійський портал нерухомості: продаж, оренда, новобудови й оцінки.', 'realestate.com.au (REA Group) is Australia''s largest property portal: sales, rentals, new homes and valuations.', 'Портал з оголошеннями про продаж, оренду й новобудови, оцінками вартості, даними про передмістя, профілем орендаря для заявок і інструментами іпотеки.', 'A portal with sale, rental and new-home listings, valuations, suburb data, a renter profile for applications and mortgage tools.', 'Продаж і оренда
Профіль орендаря
Оцінки
Іпотека', 'Sale and rent
Renter profile
Valuations
Mortgage tools', 'Покупці й орендарі в Австралії.', 'Buyers and renters in Australia.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'realestate.com.au' OR LOWER(`name`) = LOWER('realestate.com.au')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'realestate.com.au (REA Group) is Australia''s largest property portal: sales, rentals, new homes and valuations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A portal with sale, rental and new-home listings, valuations, suburb data, a renter profile for applications and mortgage tools.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sale and rent
Renter profile
Valuations
Mortgage tools', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Buyers and renters in Australia.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Realtor.com — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'realtor.com' OR LOWER(`name`) = LOWER('Realtor.com'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Realtor.com', NULL, 'https://www.realtor.com', NULL, NULL, 'Realtor.com — американський портал нерухомості з оголошеннями з MLS, орендою, оцінками й пошуком агентів.', 'Realtor.com is a US real estate portal with MLS listings, rentals, home values and agent search.', 'Офіційний портал Національної асоціації ріелторів (оператор Move, Inc.). Пропонує оголошення про продаж і оренду, дані про райони й школи, оцінки вартості, калькулятори іпотеки та зв''язок з агентами.', 'The official portal of the National Association of Realtors (operated by Move, Inc.). It offers sale and rental listings, neighbourhood and school data, home value estimates, mortgage calculators and agent contact.', 'Оголошення MLS
Дані про райони
Оцінки вартості
Пошук агентів', 'MLS listings
Neighbourhood data
Home values
Agent search', 'Покупці й орендарі в США.', 'US buyers and renters.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'realtor.com' OR LOWER(`name`) = LOWER('Realtor.com')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Realtor.com is a US real estate portal with MLS listings, rentals, home values and agent search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The official portal of the National Association of Realtors (operated by Move, Inc.). It offers sale and rental listings, neighbourhood and school data, home value estimates, mortgage calculators and agent contact.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'MLS listings
Neighbourhood data
Home values
Agent search', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US buyers and renters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Redfin — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'redfin.com' OR LOWER(`name`) = LOWER('Redfin'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Redfin', NULL, 'https://www.redfin.com', NULL, NULL, 'Redfin — пошук житла на продаж і в оренду в США з агентами Redfin, турами, оцінками вартості й іпотекою.', 'Redfin searches US homes for sale and rent with Redfin agents, tours, home value estimates and mortgages.', 'Брокерська компанія з власним порталом: оголошення з MLS, швидкі сповіщення про нові об''єкти, оцінки Redfin Estimate, тури з агентами, подання пропозицій, а також оренда квартир і будинків.', 'A brokerage with its own portal: MLS listings, fast new-listing alerts, Redfin Estimate valuations, agent tours, making offers, plus apartment and home rentals.', 'Оголошення з MLS
Redfin Estimate
Тури з агентом
Оренда', 'MLS listings
Redfin Estimate
Agent tours
Rentals', 'Покупці й продавці житла в США.', 'US home buyers and sellers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'redfin.com' OR LOWER(`name`) = LOWER('Redfin')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Redfin searches US homes for sale and rent with Redfin agents, tours, home value estimates and mortgages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A brokerage with its own portal: MLS listings, fast new-listing alerts, Redfin Estimate valuations, agent tours, making offers, plus apartment and home rentals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'MLS listings
Redfin Estimate
Agent tours
Rentals', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US home buyers and sellers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- RentRedi — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rentredi.com' OR LOWER(`name`) = LOWER('RentRedi'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'RentRedi', NULL, 'https://rentredi.com', NULL, NULL, 'RentRedi — ПЗ для орендодавців: збір оренди, скринінг орендарів і обслуговування в одному дашборді; можна почати безкоштовно.', 'RentRedi is landlord software: rent collection, tenant screening and maintenance in one dashboard; free to start.', 'Платформа для керування орендою: онлайн-оплати, скринінг через TransUnion, оголошення, підписання договорів, заявки на ремонт і облік. Позиціонується як дешевша альтернатива керуючим компаніям.', 'A rental management platform: online payments, TransUnion screening, listings, lease signing, maintenance requests and accounting. Positioned as a cheaper alternative to property managers.', 'Збір оренди
Скринінг TransUnion
Заявки на ремонт
Договори', 'Rent collection
TransUnion screening
Maintenance requests
Leases', 'Орендодавці в США.', 'US landlords.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rentredi.com' OR LOWER(`name`) = LOWER('RentRedi')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'RentRedi is landlord software: rent collection, tenant screening and maintenance in one dashboard; free to start.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A rental management platform: online payments, TransUnion screening, listings, lease signing, maintenance requests and accounting. Positioned as a cheaper alternative to property managers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Rent collection
TransUnion screening
Maintenance requests
Leases', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US landlords.', 'manual' FROM DUAL WHERE @new = 1;

-- Rieltor.ua — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rieltor.ua' OR LOWER(`name`) = LOWER('Rieltor.ua'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Rieltor.ua', NULL, 'https://rieltor.ua', NULL, NULL, 'Rieltor.ua — портал нерухомості України: продаж і оренда, новобудови, агентства, ціни за районами.', 'Rieltor.ua is a Ukrainian property portal: sale and rent, new builds, agencies and prices by district.', 'Сайт оголошень про нерухомість із базою об''єктів, новобудовами, агентствами й статистикою цін за районами міст (зокрема Львова та Києва) та зручним пошуком із фото.', 'A real estate listings site with a property database, new builds, agencies, price statistics by city district (including Lviv and Kyiv) and photo-based search.', 'Ціни за районами
Новобудови
Агентства
Пошук із фото', 'Prices by district
New builds
Agencies
Photo search', 'Покупці й орендарі в Україні.', 'Buyers and renters in Ukraine.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rieltor.ua' OR LOWER(`name`) = LOWER('Rieltor.ua')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Rieltor.ua is a Ukrainian property portal: sale and rent, new builds, agencies and prices by district.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A real estate listings site with a property database, new builds, agencies, price statistics by city district (including Lviv and Kyiv) and photo-based search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Prices by district
New builds
Agencies
Photo search', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Buyers and renters in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Rightmove — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rightmove.co.uk' OR LOWER(`name`) = LOWER('Rightmove'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Rightmove', NULL, 'https://www.rightmove.co.uk', NULL, NULL, 'Rightmove — найбільший британський портал нерухомості: житло на продаж і в оренду, ціни продажів і пошук агентів.', 'Rightmove is the UK''s largest property portal: homes for sale and rent, sold prices and agent search.', 'Портал з оголошеннями агентств усієї Великої Британії, фільтрами за ціною, типом і районом, малюванням зони пошуку на карті, історією проданих цін, оцінкою вартості та пошуком агентів.', 'A portal with agency listings across the UK, filters by price, type and area, draw-a-search on the map, sold price history, valuations and agent search.', 'Продаж і оренда
Пошук на карті
Історія цін
Оцінка вартості', 'Sale and rent
Map search
Sold prices
Valuations', 'Покупці й орендарі у Великій Британії.', 'UK buyers and renters.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rightmove.co.uk' OR LOWER(`name`) = LOWER('Rightmove')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Rightmove is the UK''s largest property portal: homes for sale and rent, sold prices and agent search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A portal with agency listings across the UK, filters by price, type and area, draw-a-search on the map, sold price history, valuations and agent search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sale and rent
Map search
Sold prices
Valuations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'UK buyers and renters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Roomies.com — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'roomies.com' OR LOWER(`name`) = LOWER('Roomies.com'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Roomies.com', NULL, 'https://www.roomies.com', NULL, NULL, 'Roomies.com — безкоштовний пошук сусіда по квартирі: профілі з бюджетом, оголошення кімнат і безпечний чат.', 'Roomies.com is a free roommate finder: profiles with budgets, room listings and safe chat.', 'Сервіс для пошуку сусідів і кімнат у США та інших країнах. Користувачі створюють профілі з бюджетом і вподобаннями, публікують кімнати й спілкуються в захищеному чаті.', 'A service for finding roommates and rooms in the US and other countries. Users create profiles with budgets and preferences, list rooms and talk in secure chat.', 'Профілі з бюджетом
Оголошення кімнат
Безпечний чат
Безкоштовно', 'Budget profiles
Room listings
Safe chat
Free', 'Ті, хто шукає сусіда.', 'People seeking roommates.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'roomies.com' OR LOWER(`name`) = LOWER('Roomies.com')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Roomies.com is a free roommate finder: profiles with budgets, room listings and safe chat.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service for finding roommates and rooms in the US and other countries. Users create profiles with budgets and preferences, list rooms and talk in secure chat.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Budget profiles
Room listings
Safe chat
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People seeking roommates.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базові функції', 'Core features' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Core features', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SeLoger — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'seloger.com' OR LOWER(`name`) = LOWER('SeLoger'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SeLoger', NULL, 'https://www.seloger.com', NULL, NULL, 'SeLoger — провідний французький портал нерухомості: купівля, оренда, новобудови й оцінка вартості.', 'SeLoger is a leading French property portal: buying, renting, new builds and valuations.', 'Французький портал (AVIV Group) з оголошеннями агентств і забудовників, сповіщеннями, оцінкою вартості житла й калькуляторами кредиту.', 'A French portal (AVIV Group) with agency and developer listings, alerts, home valuations and loan calculators.', 'Купівля й оренда
Новобудови
Оцінка вартості
Калькулятори', 'Buy and rent
New builds
Valuations
Calculators', 'Покупці й орендарі у Франції.', 'Buyers and renters in France.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'seloger.com' OR LOWER(`name`) = LOWER('SeLoger')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SeLoger is a leading French property portal: buying, renting, new builds and valuations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A French portal (AVIV Group) with agency and developer listings, alerts, home valuations and loan calculators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Buy and rent
New builds
Valuations
Calculators', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Buyers and renters in France.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SpareRoom — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'spareroom.co.uk' OR LOWER(`name`) = LOWER('SpareRoom'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SpareRoom', NULL, 'https://www.spareroom.co.uk', NULL, NULL, 'SpareRoom — пошук кімнат і сусідів для спільного житла у Великій Британії та США; безкоштовне розміщення оголошень.', 'SpareRoom finds rooms and flatmates for house shares in the UK and US; free listings.', 'Найбільший британський сайт спільного житла: тисячі кімнат у Лондоні, Манчестері, Бірмінгемі та інших містах, профілі сусідів, вечірки знайомств «Speed flatmating» і безкоштовне розміщення оголошень; є платні опції для швидшого контакту.', 'The UK''s largest flatshare site: thousands of rooms in London, Manchester, Birmingham and other cities, flatmate profiles, Speed Flatmating events and free listings; paid options for faster contact.', 'Кімнати в оренду
Пошук сусідів
Speed Flatmating
Безкоштовні оголошення', 'Rooms for rent
Flatmate search
Speed Flatmating
Free listings', 'Студенти й молоді спеціалісти.', 'Students and young professionals.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'spareroom.co.uk' OR LOWER(`name`) = LOWER('SpareRoom')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SpareRoom finds rooms and flatmates for house shares in the UK and US; free listings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The UK''s largest flatshare site: thousands of rooms in London, Manchester, Birmingham and other cities, flatmate profiles, Speed Flatmating events and free listings; paid options for faster contact.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Rooms for rent
Flatmate search
Speed Flatmating
Free listings', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students and young professionals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базові оголошення', 'Basic listings' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic listings', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Spotahome — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'spotahome.com' OR LOWER(`name`) = LOWER('Spotahome'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Spotahome', NULL, 'https://www.spotahome.com', NULL, NULL, 'Spotahome — оренда помебльованих квартир, кімнат і студентських резиденцій 100 % онлайн з перевіреними відео-оглядами.', 'Spotahome rents furnished apartments, rooms and student residences 100% online with verified video tours.', 'Сервіс середньо- і довгострокової оренди в містах Європи. Кожне житло перевіряють «хоумчекери» з відео й фото, тож орендувати можна без особистого огляду.', 'A mid- to long-term rental service in European cities. Each home is checked by homecheckers with video and photos, so you can rent without visiting.', 'Перевірені відео-огляди
Онлайн-оренда
Помебльоване житло', 'Verified video tours
Online renting
Furnished homes', 'Студенти й експати в Європі.', 'Students and expats in Europe.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'spotahome.com' OR LOWER(`name`) = LOWER('Spotahome')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Spotahome rents furnished apartments, rooms and student residences 100% online with verified video tours.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A mid- to long-term rental service in European cities. Each home is checked by homecheckers with video and photos, so you can rent without visiting.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Verified video tours
Online renting
Furnished homes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students and expats in Europe.', 'manual' FROM DUAL WHERE @new = 1;

-- StreetEasy — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'streeteasy.com' OR LOWER(`name`) = LOWER('StreetEasy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'StreetEasy', NULL, 'https://streeteasy.com', NULL, NULL, 'StreetEasy — пошуковик нерухомості Нью-Йорка: квартири в оренду й на продаж, кондомініуми, кооперативи й дані ринку.', 'StreetEasy is New York City''s real estate search: apartments for rent and sale, condos, co-ops and market data.', 'Спеціалізований портал Нью-Йорка (Zillow Group) з оголошеннями в Мангеттені та інших районах, історією цін будинків, даними про ринок і статтями про райони. Є застосунок і сповіщення.', 'A specialized NYC portal (Zillow Group) with listings in Manhattan and other boroughs, building price history, market data and neighbourhood articles. App and alerts are available.', 'Нью-Йорк
Історія цін будинків
Дані ринку
Сповіщення', 'New York City
Building price history
Market data
Alerts', 'Мешканці й покупці в Нью-Йорку.', 'NYC residents and buyers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'streeteasy.com' OR LOWER(`name`) = LOWER('StreetEasy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'StreetEasy is New York City''s real estate search: apartments for rent and sale, condos, co-ops and market data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A specialized NYC portal (Zillow Group) with listings in Manhattan and other boroughs, building price history, market data and neighbourhood articles. App and alerts are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'New York City
Building price history
Market data
Alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'NYC residents and buyers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TIDY — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tidy.com' OR LOWER(`name`) = LOWER('TIDY'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TIDY', NULL, 'https://www.tidy.com', NULL, NULL, 'TIDY — AI-менеджер нерухомості для короткострокової оренди: маркетинг, ціни, прибирання, обслуговування й гості за 3,9 %.', 'TIDY is an AI property manager for short-term rentals: marketing, pricing, cleaning, maintenance and guests for 3.9%.', 'Сервіс автоматизує роботу хоста: оголошення й динамічне ціноутворення, комунікацію з гостями, планування прибирань і ремонтів, відповідність правилам. Комісія 3,9 % замість 20–35 % у традиційних керуючих.', 'The service automates host work: listings and dynamic pricing, guest messaging, cleaning and maintenance scheduling and compliance. Fee of 3.9% versus 20–35% for traditional managers.', 'Динамічні ціни
Комунікація з гостями
Планування прибирань
Комісія 3,9 %', 'Dynamic pricing
Guest messaging
Cleaning scheduling
3.9% fee', 'Хости короткострокової оренди.', 'Short-term rental hosts.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tidy.com' OR LOWER(`name`) = LOWER('TIDY')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'TIDY is an AI property manager for short-term rentals: marketing, pricing, cleaning, maintenance and guests for 3.9%.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The service automates host work: listings and dynamic pricing, guest messaging, cleaning and maintenance scheduling and compliance. Fee of 3.9% versus 20–35% for traditional managers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Dynamic pricing
Guest messaging
Cleaning scheduling
3.9% fee', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Short-term rental hosts.', 'manual' FROM DUAL WHERE @new = 1;

-- Trulia — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trulia.com' OR LOWER(`name`) = LOWER('Trulia'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Trulia', NULL, 'https://www.trulia.com', NULL, NULL, 'Trulia — пошук житла на продаж і в оренду в США з інформацією про школи, райони та відгуками мешканців.', 'Trulia searches US homes for sale and rent with school info, neighbourhood data and resident reviews.', 'Портал (частина Zillow Group), що допомагає обрати не лише житло, а й район: карти злочинності, шкіл, поїздок, відгуки місцевих мешканців і дані про ціни. Є застосунок і сповіщення про нові оголошення.', 'A portal (part of Zillow Group) that helps choose not only a home but a neighbourhood: crime, school and commute maps, local resident reviews and price data. App and new-listing alerts are available.', 'Карти районів
Дані про школи
Відгуки мешканців
Сповіщення', 'Neighbourhood maps
School data
Resident reviews
Alerts', 'Покупці й орендарі в США.', 'US buyers and renters.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trulia.com' OR LOWER(`name`) = LOWER('Trulia')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Trulia searches US homes for sale and rent with school info, neighbourhood data and resident reviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A portal (part of Zillow Group) that helps choose not only a home but a neighbourhood: crime, school and commute maps, local resident reviews and price data. App and new-listing alerts are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Neighbourhood maps
School data
Resident reviews
Alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US buyers and renters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TurboTenant — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'turbotenant.com' OR LOWER(`name`) = LOWER('TurboTenant'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TurboTenant', NULL, 'https://www.turbotenant.com', NULL, NULL, 'TurboTenant — ПЗ для орендодавців: скринінг орендарів, генерація договорів, збір оренди; понад 1 млн користувачів.', 'TurboTenant is landlord software: tenant screening, lease generation and rent collection; over 1M users.', 'Платформа для самостійних орендодавців у США: маркетинг оголошень, онлайн-заявки, перевірка орендарів, юридично актуальні договори, збір оренди, облік витрат і ремонтів. Можна почати безкоштовно.', 'A platform for US self-managing landlords: listing marketing, online applications, tenant screening, state-specific leases, rent collection and expense and maintenance tracking. You can start free.', 'Онлайн-заявки
Скринінг
Договори
Збір оренди', 'Online applications
Screening
Leases
Rent collection', 'Приватні орендодавці в США.', 'US independent landlords.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'turbotenant.com' OR LOWER(`name`) = LOWER('TurboTenant')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'TurboTenant is landlord software: tenant screening, lease generation and rent collection; over 1M users.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform for US self-managing landlords: listing marketing, online applications, tenant screening, state-specific leases, rent collection and expense and maintenance tracking. You can start free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online applications
Screening
Leases
Rent collection', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US independent landlords.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базовий план', 'Basic plan' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic plan', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Virtual Staging AI — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'virtualstagingai.app' OR LOWER(`name`) = LOWER('Virtual Staging AI'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Virtual Staging AI', NULL, 'https://www.virtualstagingai.app', NULL, NULL, 'Virtual Staging AI — віртуальне облаштування порожніх кімнат меблями за 10 секунд; від 16 $ на місяць, розроблено в Harvard Innovation Lab.', 'Virtual Staging AI furnishes empty rooms virtually in 10 seconds; from $16 a month, developed at Harvard Innovation Lab.', 'Сервіс для ріелторів і власників, що за фото порожньої кімнати генерує реалістичні меблі в обраному стилі, з необмеженими перегенераціями. Значно дешевше й швидше за ручний стейджинг; є безкоштовна проба.', 'A service for realtors and owners that generates realistic furniture in a chosen style from a photo of an empty room, with unlimited regenerations. Far cheaper and faster than manual staging; free trial available.', 'Стейджинг за 10 секунд
Стилі меблів
Необмежені перегенерації
Безкоштовна проба', 'Staging in 10 seconds
Furniture styles
Unlimited regenerations
Free trial', 'Ріелтори й продавці житла.', 'Realtors and home sellers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'virtualstagingai.app' OR LOWER(`name`) = LOWER('Virtual Staging AI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Virtual Staging AI furnishes empty rooms virtually in 10 seconds; from $16 a month, developed at Harvard Innovation Lab.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service for realtors and owners that generates realistic furniture in a chosen style from a photo of an empty room, with unlimited regenerations. Far cheaper and faster than manual staging; free trial available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Staging in 10 seconds
Furniture styles
Unlimited regenerations
Free trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Realtors and home sellers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Підписка', 'Subscription', 16.00, 'month', 'Від 16 $', 'From $16' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Підписка' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Subscription', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'From $16', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Zillow — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zillow.com' OR LOWER(`name`) = LOWER('Zillow'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Zillow', NULL, 'https://www.zillow.com', NULL, NULL, 'Zillow — найбільший американський маркетплейс нерухомості: продаж і оренда, оцінки Zestimate, іпотека та агенти.', 'Zillow is the leading US real estate marketplace: homes for sale and rent, Zestimate valuations, mortgages and agents.', 'Мільйони оголошень про продаж і оренду житла в США з фото, 3D-турами й історією цін. Оцінка вартості Zestimate, калькулятори іпотеки, пошук агентів, подання заявок на оренду й оплата оренди онлайн.', 'Millions of US for-sale and rental listings with photos, 3D tours and price history. Zestimate valuations, mortgage calculators, agent search, rental applications and online rent payments.', 'Мільйони оголошень
Zestimate
3D-тури
Онлайн-заявки на оренду', 'Millions of listings
Zestimate
3D tours
Online rental applications', 'Покупці, продавці й орендарі в США.', 'US buyers, sellers and renters.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zillow.com' OR LOWER(`name`) = LOWER('Zillow')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Zillow is the leading US real estate marketplace: homes for sale and rent, Zestimate valuations, mortgages and agents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Millions of US for-sale and rental listings with photos, 3D tours and price history. Zestimate valuations, mortgage calculators, agent search, rental applications and online rent payments.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Millions of listings
Zestimate
3D tours
Online rental applications', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US buyers, sellers and renters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук і оцінки', 'Search and estimates' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search and estimates', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Zoopla — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zoopla.co.uk' OR LOWER(`name`) = LOWER('Zoopla'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Zoopla', NULL, 'https://www.zoopla.co.uk', NULL, NULL, 'Zoopla — британський портал нерухомості: купівля, оренда, ціни будинків і пошук агентів.', 'Zoopla is a UK property portal: buying, renting, house prices and estate agent search.', 'Портал з оголошеннями про продаж і оренду, оцінками вартості житла, історією цін, сповіщеннями й інструментами для власників (відстеження вартості свого будинку).', 'A portal with sale and rental listings, home value estimates, price history, alerts and homeowner tools (tracking your home''s value).', 'Продаж і оренда
Оцінки вартості
Історія цін
Сповіщення', 'Sale and rent
Value estimates
Price history
Alerts', 'Покупці й орендарі у Великій Британії.', 'UK buyers and renters.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zoopla.co.uk' OR LOWER(`name`) = LOWER('Zoopla')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Zoopla is a UK property portal: buying, renting, house prices and estate agent search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A portal with sale and rental listings, home value estimates, price history, alerts and homeowner tools (tracking your home''s value).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sale and rent
Value estimates
Price history
Alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'UK buyers and renters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Zumper — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zumper.com' OR LOWER(`name`) = LOWER('Zumper'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Zumper', NULL, 'https://www.zumper.com', NULL, NULL, 'Zumper — пошук квартир і будинків в оренду в США й Канаді з онлайн-заявками та перевіркою орендарів.', 'Zumper searches houses, condos and apartments for rent in the US and Canada with online applications and tenant screening.', 'Платформа оренди з мільйонами оголошень, швидкими сповіщеннями, онлайн-заявками й звітами про кредитну історію; орендодавці отримують інструменти розміщення та скринінгу.', 'A rental platform with millions of listings, instant alerts, online applications and credit reports; landlords get listing and screening tools.', 'Мільйони оголошень
Онлайн-заявки
Скринінг орендарів', 'Millions of listings
Online applications
Tenant screening', 'Орендарі й орендодавці в Північній Америці.', 'Renters and landlords in North America.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zumper.com' OR LOWER(`name`) = LOWER('Zumper')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Zumper searches houses, condos and apartments for rent in the US and Canada with online applications and tenant screening.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A rental platform with millions of listings, instant alerts, online applications and credit reports; landlords get listing and screening tools.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Millions of listings
Online applications
Tenant screening', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Renters and landlords in North America.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для орендарів', 'For renters' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For renters', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ЛУН — Нерухомість і оренда
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lun.ua' OR LOWER(`name`) = LOWER('ЛУН'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ЛУН', NULL, 'https://lun.ua', NULL, NULL, 'ЛУН — вся нерухомість України: новобудови й вторинка, оренда, ціни за м² і аналітика ринку.', 'LUN shows all Ukrainian real estate: new builds and resale, rentals, prices per m² and market analytics.', 'Український сервіс пошуку житла, що збирає оголошення про продаж і оренду, має детальну базу новобудов з оцінками, статистику цін за квадратний метр за класами житла, карти й аналітику ринку.', 'A Ukrainian home search service aggregating sale and rental listings, with a detailed new-build database and ratings, price-per-square-metre statistics by housing class, maps and market analytics.', 'База новобудов
Ціни за м²
Оренда
Аналітика', 'New-build database
Price per m²
Rentals
Analytics', 'Покупці й орендарі в Україні.', 'Buyers and renters in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lun.ua' OR LOWER(`name`) = LOWER('ЛУН')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'real-estate' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'LUN shows all Ukrainian real estate: new builds and resale, rentals, prices per m² and market analytics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Ukrainian home search service aggregating sale and rental listings, with a detailed new-build database and ratings, price-per-square-metre statistics by housing class, maps and market analytics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'New-build database
Price per m²
Rentals
Analytics', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Buyers and renters in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AnyList — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'anylist.com' OR LOWER(`name`) = LOWER('AnyList'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AnyList', NULL, 'https://www.anylist.com', NULL, NULL, 'AnyList — спільний список покупок і менеджер рецептів: синхронізація з родиною, планування меню й Siri, Alexa.', 'AnyList is a shared grocery list and recipe manager: family sync, meal planning and Siri, Alexa support.', 'Застосунок для iOS, Android і вебу. Списки сортуються за відділами магазину, синхронізуються з членами родини, рецепти імпортуються з сайтів, а інгредієнти додаються в список одним дотиком. AnyList Complete додає календар страв і розширені функції.', 'An app for iOS, Android and web. Lists sort by store aisle and sync with family members, recipes import from websites and ingredients go to the list in one tap. AnyList Complete adds a meal calendar and advanced features.', 'Спільні списки
Рецепти з сайтів
Календар страв
Siri й Alexa', 'Shared lists
Recipe import
Meal calendar
Siri and Alexa', 'Сім''ї, що планують покупки.', 'Families planning groceries.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'anylist.com' OR LOWER(`name`) = LOWER('AnyList')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AnyList is a shared grocery list and recipe manager: family sync, meal planning and Siri, Alexa support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app for iOS, Android and web. Lists sort by store aisle and sync with family members, recipes import from websites and ingredients go to the list in one tap. AnyList Complete adds a meal calendar and advanced features.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Shared lists
Recipe import
Meal calendar
Siri and Alexa', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families planning groceries.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базові списки', 'Basic lists' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic lists', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bring! — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getbring.com' OR LOWER(`name`) = LOWER('Bring!'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bring!', NULL, 'https://www.getbring.com', NULL, NULL, 'Bring! — безкоштовний спільний список покупок зі Швейцарії з іконками товарів, рецептами й підтримкою Alexa та годинників.', 'Bring! is a free shared shopping list from Switzerland with item icons, recipes and Alexa and smartwatch support.', 'Застосунок для спільних покупок з партнером чи родиною: товари відображаються іконками, список оновлюється в реальному часі, є рецепти з автододаванням інгредієнтів, акції магазинів і версії для браузера, годинників та Alexa.', 'An app for shopping together with a partner or family: items appear as icons, the list updates in real time, recipes add ingredients automatically, and there are store offers and versions for browser, watches and Alexa.', 'Іконки товарів
Рецепти
Синхронізація
Alexa й годинники', 'Item icons
Recipes
Sync
Alexa and watches', 'Пари й сім''ї.', 'Couples and families.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getbring.com' OR LOWER(`name`) = LOWER('Bring!')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Bring! is a free shared shopping list from Switzerland with item icons, recipes and Alexa and smartwatch support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app for shopping together with a partner or family: items appear as icons, the list updates in real time, recipes add ingredients automatically, and there are store offers and versions for browser, watches and Alexa.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Item icons
Recipes
Sync
Alexa and watches', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Couples and families.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Основні функції', 'Core features' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Core features', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Cozi Family Organizer — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cozi.com' OR LOWER(`name`) = LOWER('Cozi Family Organizer'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Cozi Family Organizer', NULL, 'https://www.cozi.com', NULL, NULL, 'Cozi — сімейний органайзер: спільний календар, списки покупок і справ, нагадування й планувальник страв; безкоштовна базова версія.', 'Cozi is a family organizer: shared calendar, shopping and to-do lists, reminders and a meal planner; free basic version.', 'Застосунок для всієї родини з кольоровими календарями для кожного члена сім''ї, спільними списками покупок, які оновлюються в реальному часі, списками справ, рецептами й плануванням меню. Базова версія безкоштовна, Cozi Gold прибирає рекламу й додає функції.', 'An app for the whole family with color-coded calendars per member, shared shopping lists that update in real time, to-do lists, recipes and meal planning. The basic version is free; Cozi Gold removes ads and adds features.', 'Спільний календар
Списки покупок
Планування меню
Нагадування', 'Shared calendar
Shopping lists
Meal planning
Reminders', 'Сім''ї з дітьми.', 'Families with children.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cozi.com' OR LOWER(`name`) = LOWER('Cozi Family Organizer')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Cozi is a family organizer: shared calendar, shopping and to-do lists, reminders and a meal planner; free basic version.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app for the whole family with color-coded calendars per member, shared shopping lists that update in real time, to-do lists, recipes and meal planning. The basic version is free; Cozi Gold removes ads and adds features.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Shared calendar
Shopping lists
Meal planning
Reminders', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families with children.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'З рекламою', 'With ads' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'With ads', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- FamilyWall — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'familywall.com' OR LOWER(`name`) = LOWER('FamilyWall'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'FamilyWall', NULL, 'https://www.familywall.com', NULL, NULL, 'FamilyWall — сімейний органайзер: календар, списки, планувальник страв, бюджет, локація членів родини й приватний чат.', 'FamilyWall is a family organizer: calendar, lists, meal planner, budget, family locator and private chat.', 'Єдиний простір для організації сімейного життя: спільний календар і завдання, списки покупок, Premium-планувальник страв, облік витрат, геолокація членів родини, фотоальбоми й захищений чат.', 'One place to organize family life: shared calendar and tasks, shopping lists, a Premium meal planner, expense tracking, family location, photo albums and secure chat.', 'Календар і завдання
Планувальник страв
Сімейний бюджет
Геолокація', 'Calendar and tasks
Meal planner
Family budget
Location', 'Сім''ї.', 'Families.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'familywall.com' OR LOWER(`name`) = LOWER('FamilyWall')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'FamilyWall is a family organizer: calendar, lists, meal planner, budget, family locator and private chat.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'One place to organize family life: shared calendar and tasks, shopping lists, a Premium meal planner, expense tracking, family location, photo albums and secure chat.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Calendar and tasks
Meal planner
Family budget
Location', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базові функції', 'Core features' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Core features', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Flatastic — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'flatastic-app.com' OR LOWER(`name`) = LOWER('Flatastic'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Flatastic', NULL, 'https://www.flatastic-app.com', NULL, NULL, 'Flatastic — застосунок для спільного побуту: графік обов''язків, список покупок, спільні витрати й дошка повідомлень.', 'Flatastic is an app for shared households: chore schedule, shopping list, shared expenses and a pinboard.', 'Організовує життя в спільних квартирах, сім''ях і парах: черговість прибирання з балами, спільний список покупок, облік і розподіл витрат, дошка оголошень для повідомлень.', 'It organizes life in flatshares, families and couples: chore rotation with points, a shared shopping list, expense tracking and splitting and a message pinboard.', 'Графік обов''язків
Спільні витрати
Список покупок
Дошка повідомлень', 'Chore schedule
Shared expenses
Shopping list
Pinboard', 'Сусіди по квартирі й сім''ї.', 'Flatmates and families.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'flatastic-app.com' OR LOWER(`name`) = LOWER('Flatastic')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Flatastic is an app for shared households: chore schedule, shopping list, shared expenses and a pinboard.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It organizes life in flatshares, families and couples: chore rotation with points, a shared shopping list, expense tracking and splitting and a message pinboard.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Chore schedule
Shared expenses
Shopping list
Pinboard', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Flatmates and families.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базова версія', 'Basic version' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic version', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Grocy — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'grocy.info' OR LOWER(`name`) = LOWER('Grocy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Grocy', NULL, 'https://grocy.info', NULL, NULL, 'Grocy — «ERP для холодильника»: самостійно розміщуване відкрите ПЗ для обліку продуктів, термінів придатності, покупок і хатніх справ.', 'Grocy is "ERP beyond your fridge": self-hosted open-source software for groceries, expiry dates, shopping and chores.', 'Веб-застосунок з відкритим кодом для дому: облік запасів і терміну придатності, автоматичний список покупок, рецепти й план харчування, графік хатніх справ, батарейки й обслуговування техніки. Розгортається на власному сервері чи Raspberry Pi.', 'An open-source web app for the household: stock and expiry tracking, automatic shopping list, recipes and meal planning, chore schedule, batteries and appliance maintenance. Self-hosted on your own server or Raspberry Pi.', 'Облік запасів
Терміни придатності
Автосписок покупок
Хатні справи', 'Stock tracking
Expiry dates
Auto shopping list
Chores', 'Технічно підковані господарі.', 'Tech-savvy households.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'grocy.info' OR LOWER(`name`) = LOWER('Grocy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Grocy is "ERP beyond your fridge": self-hosted open-source software for groceries, expiry dates, shopping and chores.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An open-source web app for the household: stock and expiry tracking, automatic shopping list, recipes and meal planning, chore schedule, batteries and appliance maintenance. Self-hosted on your own server or Raspberry Pi.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Stock tracking
Expiry dates
Auto shopping list
Chores', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tech-savvy households.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Безкоштовно', 'Free' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hearth Display — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hearthdisplay.com' OR LOWER(`name`) = LOWER('Hearth Display'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hearth Display', NULL, 'https://hearthdisplay.com', NULL, NULL, 'Hearth Display — настінний сімейний дисплей-органайзер: розпорядок для малюків, розклади підлітків, завдання й календар.', 'Hearth Display is a wall-mounted family organizer: toddler routines, teen schedules, chores and calendar.', 'Сенсорний дисплей і застосунок, що адаптуються до різних етапів сімейного життя: візуальні розпорядки для малюків, завдання й винагороди, спільний календар, плани харчування та розклади підлітків.', 'A touchscreen display and app that adapt to every stage of family life: visual routines for toddlers, chores and rewards, a shared calendar, meal plans and teen schedules.', 'Розпорядки для дітей
Завдання й винагороди
Спільний календар', 'Kids'' routines
Chores and rewards
Shared calendar', 'Сім''ї з дітьми.', 'Families with kids.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hearthdisplay.com' OR LOWER(`name`) = LOWER('Hearth Display')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Hearth Display is a wall-mounted family organizer: toddler routines, teen schedules, chores and calendar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A touchscreen display and app that adapt to every stage of family life: visual routines for toddlers, chores and rewards, a shared calendar, meal plans and teen schedules.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Kids'' routines
Chores and rewards
Shared calendar', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families with kids.', 'manual' FROM DUAL WHERE @new = 1;

-- Helpling — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'helpling.com' OR LOWER(`name`) = LOWER('Helpling'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Helpling', NULL, 'https://www.helpling.com', NULL, NULL, 'Helpling — онлайн-бронювання прибиральників у Європі: разове чи регулярне прибирання, рейтинги й страхування.', 'Helpling books house cleaners online in Europe: one-off or regular cleaning, ratings and insurance.', 'Платформа, що з''єднує клієнтів із незалежними прибиральниками в містах Німеччини, Франції, Нідерландів та інших країн. Дає змогу обрати дату й тривалість, переглянути відгуки та оплатити онлайн.', 'A platform connecting customers with independent cleaners in cities in Germany, France, the Netherlands and other countries. Choose date and duration, read reviews and pay online.', 'Бронювання онлайн
Регулярне прибирання
Відгуки
Оплата онлайн', 'Online booking
Regular cleaning
Reviews
Online payment', 'Зайняті мешканці європейських міст.', 'Busy residents of European cities.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'helpling.com' OR LOWER(`name`) = LOWER('Helpling')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Helpling books house cleaners online in Europe: one-off or regular cleaning, ratings and insurance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform connecting customers with independent cleaners in cities in Germany, France, the Netherlands and other countries. Choose date and duration, read reviews and pay online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online booking
Regular cleaning
Reviews
Online payment', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Busy residents of European cities.', 'manual' FROM DUAL WHERE @new = 1;

-- Homey (chores & allowance) — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'homeyapp.net' OR LOWER(`name`) = LOWER('Homey (chores & allowance)'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Homey (chores & allowance)', NULL, 'https://www.homeyapp.net', NULL, NULL, 'Homey — застосунок домашніх обов''язків, винагород і кишенькових грошей для дітей, що вчить фінансової грамотності.', 'Homey is a chores, rewards and allowance app for kids that teaches money skills.', 'Батьки призначають дітям завдання по дому, діти позначають виконання й заробляють кишенькові гроші чи бали, відкладають на цілі та бачать свій «баланс». Підходить для всієї родини.', 'Parents assign household chores, kids mark them done and earn allowance or points, save toward goals and see their balance. Designed for the whole family.', 'Завдання для дітей
Кишенькові гроші
Цілі заощаджень', 'Kids'' chores
Allowance
Savings goals', 'Батьки з дітьми.', 'Parents with kids.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'homeyapp.net' OR LOWER(`name`) = LOWER('Homey (chores & allowance)')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Homey is a chores, rewards and allowance app for kids that teaches money skills.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Parents assign household chores, kids mark them done and earn allowance or points, save toward goals and see their balance. Designed for the whole family.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Kids'' chores
Allowance
Savings goals', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents with kids.', 'manual' FROM DUAL WHERE @new = 1;

-- HomeZada — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'homezada.com' OR LOWER(`name`) = LOWER('HomeZada'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HomeZada', NULL, 'https://www.homezada.com', NULL, NULL, 'HomeZada — цифровий менеджер дому: інвентар речей, графік обслуговування, проєкти ремонту й фінанси житла.', 'HomeZada is a digital home manager: inventory, maintenance schedules, renovation projects and home finances.', 'Система для власників житла: опис майна для страхування, нагадування про обслуговування техніки й будинку, бюджети ремонтних проєктів, облік вартості житла й витрат.', 'A system for homeowners: an inventory for insurance, reminders for appliance and home maintenance, renovation project budgets and tracking home value and expenses.', 'Інвентар майна
Графік обслуговування
Бюджети ремонту
Фінанси житла', 'Home inventory
Maintenance schedule
Project budgets
Home finances', 'Власники будинків.', 'Homeowners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'homezada.com' OR LOWER(`name`) = LOWER('HomeZada')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'HomeZada is a digital home manager: inventory, maintenance schedules, renovation projects and home finances.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A system for homeowners: an inventory for insurance, reminders for appliance and home maintenance, renovation project budgets and tracking home value and expenses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Home inventory
Maintenance schedule
Project budgets
Home finances', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- Listonic — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'listonic.com' OR LOWER(`name`) = LOWER('Listonic'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Listonic', NULL, 'https://listonic.com', NULL, NULL, 'Listonic — розумний список покупок для Android, iOS і вебу українською: автокатегорії, спільні списки й підказки цін.', 'Listonic is a smart shopping list for Android, iOS and web in Ukrainian: auto-categories, shared lists and price hints.', 'Безкоштовний застосунок списків покупок з автоматичним сортуванням товарів за категоріями, спільними списками, голосовим введенням, підказками на основі історії та поясненнями цін. Має українську локалізацію.', 'A free shopping list app with automatic sorting by category, shared lists, voice input, history-based suggestions and price notes. Localized in Ukrainian.', 'Автокатегорії
Спільні списки
Голосове введення
Українською', 'Auto-categories
Shared lists
Voice input
In Ukrainian', 'Усі, хто ходить по продукти.', 'Anyone doing grocery runs.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'listonic.com' OR LOWER(`name`) = LOWER('Listonic')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Listonic is a smart shopping list for Android, iOS and web in Ukrainian: auto-categories, shared lists and price hints.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A free shopping list app with automatic sorting by category, shared lists, voice input, history-based suggestions and price notes. Localized in Ukrainian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Auto-categories
Shared lists
Voice input
In Ukrainian', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anyone doing grocery runs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Android, iOS, веб', 'Android, iOS, web' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Android, iOS, web', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Maple — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'growmaple.com' OR LOWER(`name`) = LOWER('Maple'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Maple', NULL, 'https://www.growmaple.com', NULL, NULL, 'Maple — AI-асистент для сімейної логістики: розклади, завдання, плани харчування й розподіл домашнього навантаження.', 'Maple is an AI assistant for family logistics: schedules, tasks, meal plans and sharing the household mental load.', 'Застосунок, що допомагає батькам розподіляти невидиму домашню роботу: перетворює листи зі школи й повідомлення на події та завдання, планує харчування, веде спільний календар і списки.', 'An app that helps parents share invisible household work: it turns school emails and messages into events and tasks, plans meals and keeps a shared calendar and lists.', 'AI-розбір листів
Спільний календар
План харчування
Розподіл завдань', 'AI email parsing
Shared calendar
Meal plans
Task sharing', 'Батьки.', 'Parents.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'growmaple.com' OR LOWER(`name`) = LOWER('Maple')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Maple is an AI assistant for family logistics: schedules, tasks, meal plans and sharing the household mental load.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app that helps parents share invisible household work: it turns school emails and messages into events and tasks, plans meals and keeps a shared calendar and lists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI email parsing
Shared calendar
Meal plans
Task sharing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Parents.', 'manual' FROM DUAL WHERE @new = 1;

-- Molly Maid — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mollymaid.com' OR LOWER(`name`) = LOWER('Molly Maid'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Molly Maid', NULL, 'https://www.mollymaid.com', NULL, NULL, 'Molly Maid — мережа професійного прибирання будинків у США: регулярне, разове й генеральне прибирання.', 'Molly Maid is a US network of professional house cleaning: regular, one-time and deep cleaning.', 'Франчайзингова служба прибирання (Neighborly) з місцевими командами по США. Пропонує регулярне, разове, генеральне прибирання й прибирання при переїзді з онлайн-запитом ціни.', 'A franchise cleaning service (Neighborly) with local teams across the US. It offers recurring, one-time, deep and move-in/move-out cleaning with online quotes.', 'Регулярне прибирання
Генеральне прибирання
При переїзді
Онлайн-запит ціни', 'Recurring cleaning
Deep cleaning
Move-in/out
Online quotes', 'Власники житла в США.', 'US homeowners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mollymaid.com' OR LOWER(`name`) = LOWER('Molly Maid')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Molly Maid is a US network of professional house cleaning: regular, one-time and deep cleaning.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A franchise cleaning service (Neighborly) with local teams across the US. It offers recurring, one-time, deep and move-in/move-out cleaning with online quotes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Recurring cleaning
Deep cleaning
Move-in/out
Online quotes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- Nipto — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nipto.app' OR LOWER(`name`) = LOWER('Nipto'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nipto', NULL, 'https://www.nipto.app', NULL, NULL, 'Nipto — гра з хатніх справ для сімей, пар і сусідів: графік прибирання, щотижнева «гонка» й самоцвіти, які обмінюють на реальні винагороди.', 'Nipto turns chores into a game for families, couples and roommates: cleaning schedule, weekly race and gems traded for real rewards.', 'Безкоштовний застосунок для iPhone і Android, що робить прибирання змаганням: завдання приносять бали, учасники змагаються щотижня, а зароблені самоцвіти обмінюються на домовлені нагороди.', 'A free iPhone and Android app that makes cleaning a competition: tasks earn points, members race weekly and earned gems are traded for agreed rewards.', 'Графік прибирання
Щотижневе змагання
Винагороди
Безкоштовно', 'Cleaning schedule
Weekly race
Rewards
Free', 'Сім''ї, пари, сусіди.', 'Families, couples, roommates.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nipto.app' OR LOWER(`name`) = LOWER('Nipto')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Nipto turns chores into a game for families, couples and roommates: cleaning schedule, weekly race and gems traded for real rewards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A free iPhone and Android app that makes cleaning a competition: tasks earn points, members race weekly and earned gems are traded for agreed rewards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cleaning schedule
Weekly race
Rewards
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families, couples, roommates.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'iPhone і Android', 'iPhone and Android' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'iPhone and Android', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- NoWaste — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nowasteapp.com' OR LOWER(`name`) = LOWER('NoWaste'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NoWaste', NULL, 'https://www.nowasteapp.com', NULL, NULL, 'NoWaste — облік продуктів удома з AI: терміни придатності, нагадування й зменшення харчових відходів.', 'NoWaste is AI food inventory for the home: expiry dates, reminders and less food waste.', 'Застосунок для обліку продуктів у холодильнику, морозилці й коморі: додавання сканом або фото, нагадування про терміни придатності, списки покупок і статистика викинутих продуктів, щоб економити гроші.', 'An app for tracking food in the fridge, freezer and pantry: add items by scan or photo, expiry reminders, shopping lists and wasted-food stats to save money.', 'Облік продуктів
Нагадування про терміни
Списки покупок
Статистика відходів', 'Food inventory
Expiry reminders
Shopping lists
Waste stats', 'Ті, хто хоче менше викидати їжі.', 'People reducing food waste.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nowasteapp.com' OR LOWER(`name`) = LOWER('NoWaste')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'NoWaste is AI food inventory for the home: expiry dates, reminders and less food waste.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app for tracking food in the fridge, freezer and pantry: add items by scan or photo, expiry reminders, shopping lists and wasted-food stats to save money.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Food inventory
Expiry reminders
Shopping lists
Waste stats', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People reducing food waste.', 'manual' FROM DUAL WHERE @new = 1;

-- Olio — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'olioapp.com' OR LOWER(`name`) = LOWER('Olio'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Olio', NULL, 'https://olioapp.com', NULL, NULL, 'Olio — безкоштовна їжа й речі від сусідів і супермаркетів: обмін надлишками в громаді, щоб зменшити відходи.', 'Olio offers free food and items from neighbours and supermarkets: sharing surplus in the community to cut waste.', 'Застосунок для обміну зайвою їжею та речами з сусідами. Волонтери також забирають надлишки з супермаркетів і розповсюджують через застосунок. Працює в Британії та інших країнах.', 'An app for sharing surplus food and items with neighbours. Volunteers also collect supermarket surplus and distribute it via the app. Works in the UK and other countries.', 'Обмін їжею
Безкоштовні речі
Волонтери
Менше відходів', 'Food sharing
Free items
Volunteers
Less waste', 'Мешканці громад.', 'Community residents.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'olioapp.com' OR LOWER(`name`) = LOWER('Olio')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Olio offers free food and items from neighbours and supermarkets: sharing surplus in the community to cut waste.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app for sharing surplus food and items with neighbours. Volunteers also collect supermarket surplus and distribute it via the app. Works in the UK and other countries.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Food sharing
Free items
Volunteers
Less waste', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Community residents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- OurGroceries — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ourgroceries.com' OR LOWER(`name`) = LOWER('OurGroceries'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OurGroceries', NULL, 'https://www.ourgroceries.com', NULL, NULL, 'OurGroceries — простий спільний список покупок для всієї родини з миттєвою синхронізацією між телефонами.', 'OurGroceries is a simple shared grocery list for the whole family with instant sync between phones.', 'Застосунок, у якому кілька людей ведуть один список покупок: зміни з''являються в усіх одразу. Є кілька списків, рецепти, сканування штрихкодів і підтримка Alexa та Google Assistant; безкоштовна версія з рекламою.', 'An app where several people share one grocery list with instant updates for everyone. It supports multiple lists, recipes, barcode scanning and Alexa and Google Assistant; free version with ads.', 'Миттєва синхронізація
Кілька списків
Штрихкоди
Alexa й Google', 'Instant sync
Multiple lists
Barcodes
Alexa and Google', 'Сім''ї й пари.', 'Families and couples.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ourgroceries.com' OR LOWER(`name`) = LOWER('OurGroceries')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'OurGroceries is a simple shared grocery list for the whole family with instant sync between phones.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app where several people share one grocery list with instant updates for everyone. It supports multiple lists, recipes, barcode scanning and Alexa and Google Assistant; free version with ads.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Instant sync
Multiple lists
Barcodes
Alexa and Google', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families and couples.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'З рекламою', 'With ads' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'With ads', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- S'moresUp — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'smoresup.com' OR LOWER(`name`) = LOWER('S''moresUp'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'S''moresUp', NULL, 'https://smoresup.com', NULL, NULL, 'S''moresUp — сімейний застосунок завдань і винагород, яким користуються понад 300 000 сімей: обов''язки, розклад і нагороди.', 'S''moresUp is a family chore and rewards app used by 300,000+ families: chores, schedules and rewards.', 'Допомагає розподілити хатню роботу між членами родини, вести розклад, мотивувати дітей винагородами й зменшити ментальне навантаження батьків.', 'It helps share housework among family members, keep schedules, motivate kids with rewards and reduce parents'' mental load.', 'Обов''язки
Винагороди
Сімейний розклад', 'Chores
Rewards
Family schedule', 'Сім''ї з дітьми.', 'Families with kids.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'smoresup.com' OR LOWER(`name`) = LOWER('S''moresUp')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'S''moresUp is a family chore and rewards app used by 300,000+ families: chores, schedules and rewards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It helps share housework among family members, keep schedules, motivate kids with rewards and reduce parents'' mental load.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Chores
Rewards
Family schedule', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families with kids.', 'manual' FROM DUAL WHERE @new = 1;

-- Skylight — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'skylightframe.com' OR LOWER(`name`) = LOWER('Skylight'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Skylight', NULL, 'https://www.skylightframe.com', NULL, NULL, 'Skylight — розумний настінний календар і цифрова фоторамка для сім''ї: спільні розклади, завдання, меню й фото.', 'Skylight makes a smart wall calendar and digital photo frame for families: shared schedules, chores, meals and photos.', 'Сенсорний дисплей Skylight Calendar синхронізується з Google, Apple й Outlook календарями, показує розклад кожного члена сім''ї, списки, завдання з винагородами для дітей і план меню. Skylight Frame показує фото, надіслані родичами. Розширені функції — за підпискою Plus.', 'The Skylight Calendar touchscreen syncs with Google, Apple and Outlook calendars, showing each family member''s schedule, lists, chores with rewards for kids and meal plans. Skylight Frame displays photos sent by relatives. Advanced features require a Plus subscription.', 'Настінний календар
Завдання для дітей
План меню
Фоторамка', 'Wall calendar
Kids'' chores
Meal plans
Photo frame', 'Сім''ї з дітьми.', 'Families with kids.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'skylightframe.com' OR LOWER(`name`) = LOWER('Skylight')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Skylight makes a smart wall calendar and digital photo frame for families: shared schedules, chores, meals and photos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Skylight Calendar touchscreen syncs with Google, Apple and Outlook calendars, showing each family member''s schedule, lists, chores with rewards for kids and meal plans. Skylight Frame displays photos sent by relatives. Advanced features require a Plus subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Wall calendar
Kids'' chores
Meal plans
Photo frame', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families with kids.', 'manual' FROM DUAL WHERE @new = 1;

-- Splitwise — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'splitwise.com' OR LOWER(`name`) = LOWER('Splitwise'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Splitwise', NULL, 'https://www.splitwise.com', NULL, NULL, 'Splitwise — облік і розподіл спільних витрат між сусідами, друзями й парами: хто кому скільки винен.', 'Splitwise tracks and splits shared expenses among roommates, friends and couples: who owes whom.', 'Безкоштовний інструмент для спільних рахунків за житло, комуналку, продукти й подорожі. Розподіляє суми порівну чи у відсотках, підсумовує борги, нагадує й дозволяє позначати розрахунки. Splitwise Pro додає сканування чеків і валюти.', 'A free tool for shared bills for rent, utilities, groceries and trips. It splits amounts equally or by percentage, totals debts, sends reminders and records settle-ups. Splitwise Pro adds receipt scanning and currencies.', 'Розподіл витрат
Підсумок боргів
Нагадування
Веб і мобільні', 'Expense splitting
Debt totals
Reminders
Web and mobile', 'Сусіди по житлу, пари.', 'Roommates and couples.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'splitwise.com' OR LOWER(`name`) = LOWER('Splitwise')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Splitwise tracks and splits shared expenses among roommates, friends and couples: who owes whom.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A free tool for shared bills for rent, utilities, groceries and trips. It splits amounts equally or by percentage, totals debts, sends reminders and records settle-ups. Splitwise Pro adds receipt scanning and currencies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Expense splitting
Debt totals
Reminders
Web and mobile', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Roommates and couples.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Основні функції', 'Core features' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Core features', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sweepy — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sweepy.com' OR LOWER(`name`) = LOWER('Sweepy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sweepy', NULL, 'https://sweepy.com', NULL, NULL, 'Sweepy — розклад прибирання дому з розподілом обов''язків між членами сім''ї та ігровою механікою балів.', 'Sweepy builds a home cleaning schedule, splits chores among the family and gamifies cleaning with points.', 'Застосунок допомагає скласти графік прибирання по кімнатах, розподілити завдання між членами родини чи сусідами й перетворити прибирання на гру з балами та рейтингом. Показує, які зони потребують уваги.', 'The app helps create a room-by-room cleaning schedule, split tasks among family or flatmates and turn cleaning into a game with points and a leaderboard. It shows which areas need attention.', 'Графік по кімнатах
Розподіл обов''язків
Бали й рейтинг', 'Room-by-room schedule
Chore splitting
Points and leaderboard', 'Сім''ї та сусіди по квартирі.', 'Families and flatmates.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sweepy.com' OR LOWER(`name`) = LOWER('Sweepy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sweepy builds a home cleaning schedule, splits chores among the family and gamifies cleaning with points.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app helps create a room-by-room cleaning schedule, split tasks among family or flatmates and turn cleaning into a game with points and a leaderboard. It shows which areas need attention.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Room-by-room schedule
Chore splitting
Points and leaderboard', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families and flatmates.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базова версія', 'Basic version' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic version', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tody — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'todyapp.com' OR LOWER(`name`) = LOWER('Tody'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tody', NULL, 'https://todyapp.com', NULL, NULL, 'Tody — розклад прибирання на автопілоті: застосунок відстежує, що й коли треба прибрати; Premium 9,99 $ на рік.', 'Tody puts your cleaning schedule on autopilot: the app tracks what needs cleaning and when; Premium $9.99 a year.', 'Застосунок для iPhone, iPad і Android, що показує стан кожного завдання з прибирання (від «чисто» до «пора») і нагадує вчасно. Premium за 9,99 $ на рік додає кілька будинків і теми, Premium+ (від 25 $ на рік залежно від кількості членів) — спільне користування родиною.', 'An app for iPhone, iPad and Android showing each cleaning task''s status (from clean to due) and reminding you in time. Premium at $9.99 a year adds multiple homes and themes; Premium+ (from $25 a year by household size) adds family sharing.', 'Стан кожного завдання
Нагадування
Кілька будинків
Спільне користування', 'Status per task
Reminders
Multiple homes
Family sharing', 'Ті, хто хоче системне прибирання.', 'People wanting a cleaning routine.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'todyapp.com' OR LOWER(`name`) = LOWER('Tody')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tody puts your cleaning schedule on autopilot: the app tracks what needs cleaning and when; Premium $9.99 a year.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app for iPhone, iPad and Android showing each cleaning task''s status (from clean to due) and reminding you in time. Premium at $9.99 a year adds multiple homes and themes; Premium+ (from $25 a year by household size) adds family sharing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Status per task
Reminders
Multiple homes
Family sharing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People wanting a cleaning routine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базова версія', 'Basic version' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic version', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium', 'Premium', 9.99, 'year', 'Кілька будинків і теми', 'Multiple homes and themes' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Multiple homes and themes', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Premium+', 'Premium+', 25.00, 'year', 'Для родини, від 25 $', 'For households, from $25' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Premium+' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Premium+', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For households, from $25', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Too Good To Go — Домашнє господарство
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'toogoodtogo.com' OR LOWER(`name`) = LOWER('Too Good To Go'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Too Good To Go', NULL, 'https://www.toogoodtogo.com', NULL, NULL, 'Too Good To Go — застосунок для порятунку їжі: «чарівні пакунки» з надлишками ресторанів і магазинів за знижкою.', 'Too Good To Go is a food-rescue app: Surprise Bags of surplus food from restaurants and shops at a discount.', 'Сервіс у багатьох країнах Європи й Північної Америки, де кафе, пекарні й супермаркети продають непродану за день їжу у пакунках-сюрпризах значно дешевше. Користувач бронює й оплачує в застосунку та забирає у визначений час.', 'A service in many European and North American countries where cafes, bakeries and supermarkets sell unsold food in surprise bags at a big discount. Users reserve and pay in the app and pick up at a set time.', 'Пакунки-сюрпризи
Знижки на їжу
Менше відходів', 'Surprise Bags
Discounted food
Less waste', 'Економні мешканці міст.', 'Budget-minded city dwellers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'toogoodtogo.com' OR LOWER(`name`) = LOWER('Too Good To Go')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'household' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Too Good To Go is a food-rescue app: Surprise Bags of surplus food from restaurants and shops at a discount.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service in many European and North American countries where cafes, bakeries and supermarkets sell unsold food in surprise bags at a big discount. Users reserve and pay in the app and pick up at a set time.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Surprise Bags
Discounted food
Less waste', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Budget-minded city dwellers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовний застосунок', 'Free app', 0.00, 'free', 'Оплата за пакунки', 'Pay per bag' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовний застосунок' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Pay per bag', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Anker SOLIX — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ankersolix.com' OR LOWER(`name`) = LOWER('Anker SOLIX'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Anker SOLIX', NULL, 'https://www.ankersolix.com', NULL, NULL, 'Anker SOLIX — зарядні станції, сонячні генератори й балконні сонячні системи з функцією UPS і застосунком Anker.', 'Anker SOLIX makes power stations, solar generators and balcony solar systems with UPS function and the Anker app.', 'Енергетичний напрям Anker: портативні станції з перемиканням на батарею за 10 мс (UPS), сонячні генератори, домашні батареї й балконні сонячні системи. Застосунок показує генерацію, заряд і споживання.', 'Anker''s energy line: portable stations with 10 ms UPS switchover, solar generators, home batteries and balcony solar systems. The app shows generation, charge and consumption.', 'UPS 10 мс
Балконні сонячні системи
Домашні батареї
Застосунок', '10 ms UPS
Balcony solar
Home batteries
App', 'Мешканці квартир і будинків.', 'Apartment and house residents.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ankersolix.com' OR LOWER(`name`) = LOWER('Anker SOLIX')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Anker SOLIX makes power stations, solar generators and balcony solar systems with UPS function and the Anker app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Anker''s energy line: portable stations with 10 ms UPS switchover, solar generators, home batteries and balcony solar systems. The app shows generation, charge and consumption.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '10 ms UPS
Balcony solar
Home batteries
App', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Apartment and house residents.', 'manual' FROM DUAL WHERE @new = 1;

-- BLUETTI — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bluettipower.com' OR LOWER(`name`) = LOWER('BLUETTI'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BLUETTI', NULL, 'https://www.bluettipower.com', NULL, NULL, 'BLUETTI — портативні зарядні станції, сонячні генератори й домашні батареї для автономного й резервного живлення.', 'BLUETTI makes portable power stations, solar generators and home batteries for off-grid and backup power.', 'Виробник накопичувачів енергії: від компактних станцій до домашніх систем Apex із розширенням ємності до десятків кВт·год, сонячні панелі. Застосунок BLUETTI дає моніторинг і керування.', 'An energy storage maker: from compact stations to Apex home systems expandable to tens of kWh, plus solar panels. The BLUETTI app provides monitoring and control.', 'Портативні станції
Домашні системи Apex
Сонячні генератори
Застосунок', 'Portable stations
Apex home systems
Solar generators
App', 'Власники домів і дач.', 'Home and cabin owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bluettipower.com' OR LOWER(`name`) = LOWER('BLUETTI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'BLUETTI makes portable power stations, solar generators and home batteries for off-grid and backup power.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An energy storage maker: from compact stations to Apex home systems expandable to tens of kWh, plus solar panels. The BLUETTI app provides monitoring and control.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Portable stations
Apex home systems
Solar generators
App', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Home and cabin owners.', 'manual' FROM DUAL WHERE @new = 1;

-- EcoFlow — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ecoflow.com' OR LOWER(`name`) = LOWER('EcoFlow'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'EcoFlow', NULL, 'https://www.ecoflow.com', NULL, NULL, 'EcoFlow — портативні зарядні станції, домашні батареї й сонячні панелі для резервного живлення з керуванням у застосунку.', 'EcoFlow makes portable power stations, home batteries and solar panels for backup power with app control.', 'Бренд накопичувачів енергії: станції DELTA і RIVER, домашні системи резервного живлення, сонячні панелі й генератори. Застосунок EcoFlow показує заряд і споживання, керує режимами й оновленнями. Популярний в Україні як рішення на час відключень.', 'An energy storage brand: DELTA and RIVER stations, home backup systems, solar panels and generators. The EcoFlow app shows charge and consumption and manages modes and updates. Popular in Ukraine for outages.', 'Зарядні станції
Домашні батареї
Сонячні панелі
Застосунок', 'Power stations
Home batteries
Solar panels
App', 'Ті, хто готується до відключень світла.', 'People preparing for outages.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ecoflow.com' OR LOWER(`name`) = LOWER('EcoFlow')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'EcoFlow makes portable power stations, home batteries and solar panels for backup power with app control.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An energy storage brand: DELTA and RIVER stations, home backup systems, solar panels and generators. The EcoFlow app shows charge and consumption and manages modes and updates. Popular in Ukraine for outages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Power stations
Home batteries
Solar panels
App', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People preparing for outages.', 'manual' FROM DUAL WHERE @new = 1;

-- Emporia Energy — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'emporiaenergy.com' OR LOWER(`name`) = LOWER('Emporia Energy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Emporia Energy', NULL, 'https://www.emporiaenergy.com', NULL, NULL, 'Emporia — доступний енергомоніторинг по кожному колу щитка, розумні розетки, зарядки для електромобілів і керування батареями.', 'Emporia offers affordable circuit-level energy monitoring, smart plugs, EV chargers and battery management.', 'Монітор Vue встановлюється в щиток і показує споживання по кожному автомату. Платформа Emporia об''єднує розумні розетки, зарядні станції EV і домашні батареї, щоб переносити навантаження на дешеві тарифи й економити.', 'The Vue monitor installs in the panel and shows usage per circuit. The Emporia platform ties in smart plugs, EV chargers and home batteries to shift load to cheaper rates and save money.', 'Моніторинг по колах
Розумні розетки
Зарядки EV
Керування батареєю', 'Circuit-level monitoring
Smart plugs
EV chargers
Battery control', 'Власники будинків.', 'Homeowners.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'emporiaenergy.com' OR LOWER(`name`) = LOWER('Emporia Energy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Emporia offers affordable circuit-level energy monitoring, smart plugs, EV chargers and battery management.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Vue monitor installs in the panel and shows usage per circuit. The Emporia platform ties in smart plugs, EV chargers and home batteries to shift load to cheaper rates and save money.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Circuit-level monitoring
Smart plugs
EV chargers
Battery control', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- EnergySage — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'energysage.com' OR LOWER(`name`) = LOWER('EnergySage'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'EnergySage', NULL, 'https://www.energysage.com', NULL, NULL, 'EnergySage — маркетплейс чистої енергії для дому: порівняння пропозицій на сонячні панелі, батареї, теплові насоси та зарядки.', 'EnergySage is a clean home energy marketplace: compare quotes for solar, batteries, heat pumps and chargers.', 'Сервіс, що дозволяє отримати й порівняти пропозиції від перевірених установників сонячних систем, батарей і теплових насосів у США, має калькулятори, гіди з цін і консультантів. Понад 50 000 власників уже електрифікували будинки через платформу.', 'A service to get and compare quotes from vetted US installers of solar, batteries and heat pumps, with calculators, price guides and advisers. Over 50,000 homeowners have electrified their homes through it.', 'Порівняння пропозицій
Перевірені установники
Гіди з цін
Консультанти', 'Quote comparison
Vetted installers
Price guides
Advisers', 'Власники будинків у США.', 'US homeowners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'energysage.com' OR LOWER(`name`) = LOWER('EnergySage')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'EnergySage is a clean home energy marketplace: compare quotes for solar, batteries, heat pumps and chargers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service to get and compare quotes from vetted US installers of solar, batteries and heat pumps, with calculators, price guides and advisers. Over 50,000 homeowners have electrified their homes through it.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Quote comparison
Vetted installers
Price guides
Advisers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US homeowners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для власників', 'For homeowners' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For homeowners', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Enphase — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'enphase.com' OR LOWER(`name`) = LOWER('Enphase'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Enphase', NULL, 'https://enphase.com', NULL, NULL, 'Enphase — мікроінвертори, батареї, зарядки EV і застосунок Enlighten для моніторингу домашньої сонячної системи.', 'Enphase makes microinverters, batteries, EV chargers and the Enlighten app for home solar monitoring.', 'Виробник домашніх енергосистем: мікроінвертори для кожної панелі, батареї IQ, зарядки й менеджмент енергії. Застосунок Enphase показує генерацію, споживання й заряд батареї в реальному часі, режими резервного живлення під час відключень.', 'A maker of home energy systems: per-panel microinverters, IQ batteries, chargers and energy management. The Enphase app shows production, consumption and battery state in real time and backup modes during outages.', 'Мікроінвертори
Батареї IQ
Моніторинг генерації
Резервне живлення', 'Microinverters
IQ batteries
Production monitoring
Backup power', 'Власники сонячних станцій.', 'Home solar owners.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'enphase.com' OR LOWER(`name`) = LOWER('Enphase')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Enphase makes microinverters, batteries, EV chargers and the Enlighten app for home solar monitoring.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A maker of home energy systems: per-panel microinverters, IQ batteries, chargers and energy management. The Enphase app shows production, consumption and battery state in real time and backup modes during outages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Microinverters
IQ batteries
Production monitoring
Backup power', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Home solar owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Hive — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hivehome.com' OR LOWER(`name`) = LOWER('Hive'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hive', NULL, 'https://www.hivehome.com', NULL, NULL, 'Hive (Centrica) — розумні термостати, сонячні панелі, теплові насоси й зарядки EV для зниження рахунків у Великій Британії.', 'Hive (Centrica) offers smart thermostats, solar panels, heat pumps and EV chargers to cut UK bills.', 'Британський бренд «еко-технологій» для дому: термостат, що вчиться розкладу й економить до ~180 £ на рік (за оцінкою компанії), сонячні системи з батареями, теплові насоси та зарядки EV з керуванням у застосунку Hive.', 'A UK home eco-tech brand: a thermostat that learns your schedule and saves up to ~£180 a year (company estimate), solar with batteries, heat pumps and EV chargers, all controlled in the Hive app.', 'Розумний термостат
Сонячні системи
Теплові насоси
Зарядки EV', 'Smart thermostat
Solar systems
Heat pumps
EV chargers', 'Власники житла у Великій Британії.', 'UK homeowners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hivehome.com' OR LOWER(`name`) = LOWER('Hive')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Hive (Centrica) offers smart thermostats, solar panels, heat pumps and EV chargers to cut UK bills.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A UK home eco-tech brand: a thermostat that learns your schedule and saves up to ~£180 a year (company estimate), solar with batteries, heat pumps and EV chargers, all controlled in the Hive app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Smart thermostat
Solar systems
Heat pumps
EV chargers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'UK homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- Jackery — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jackery.com' OR LOWER(`name`) = LOWER('Jackery'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Jackery', NULL, 'https://www.jackery.com', NULL, NULL, 'Jackery — портативні зарядні станції й сонячні генератори для резервного живлення дому та відпочинку на природі.', 'Jackery makes portable power stations and solar generators for home backup and outdoor use.', 'Лінійки Explorer і Solar Generator з літій-залізо-фосфатними батареями, швидкою зарядкою й сонячними панелями SolarSaga. Застосунок дозволяє стежити за зарядом і налаштовувати станцію.', 'Explorer and Solar Generator lines with LiFePO4 batteries, fast charging and SolarSaga panels. The app tracks charge and configures the station.', 'Портативні станції
Сонячні панелі
LiFePO4
Застосунок', 'Portable stations
Solar panels
LiFePO4
App', 'Ті, хто потребує резервного живлення.', 'People needing backup power.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jackery.com' OR LOWER(`name`) = LOWER('Jackery')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Jackery makes portable power stations and solar generators for home backup and outdoor use.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Explorer and Solar Generator lines with LiFePO4 batteries, fast charging and SolarSaga panels. The app tracks charge and configures the station.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Portable stations
Solar panels
LiFePO4
App', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People needing backup power.', 'manual' FROM DUAL WHERE @new = 1;

-- Loop — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'loop.homes' OR LOWER(`name`) = LOWER('Loop'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Loop', NULL, 'https://loop.homes', NULL, NULL, 'Loop — безкоштовний британський застосунок для моніторингу споживання й вартості енергії за даними розумного лічильника.', 'Loop is a free UK app monitoring energy use and costs from smart meter data.', 'Застосунок підключається до даних розумного лічильника й показує споживання та витрати, порівняння з подібними будинками, вуглецевий слід і поради з економії; користувачі заробляють винагороди за зменшення споживання.', 'The app connects to smart meter data and shows usage and costs, comparisons with similar homes, carbon footprint and saving tips; users earn rewards for cutting consumption.', 'Дані розумного лічильника
Порівняння з сусідами
Вуглецевий слід
Винагороди', 'Smart meter data
Neighbour comparison
Carbon footprint
Rewards', 'Власники розумних лічильників у Великій Британії.', 'UK smart meter owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'loop.homes' OR LOWER(`name`) = LOWER('Loop')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Loop is a free UK app monitoring energy use and costs from smart meter data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app connects to smart meter data and shows usage and costs, comparisons with similar homes, carbon footprint and saving tips; users earn rewards for cutting consumption.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Smart meter data
Neighbour comparison
Carbon footprint
Rewards', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'UK smart meter owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- myenergi — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myenergi.com' OR LOWER(`name`) = LOWER('myenergi'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'myenergi', NULL, 'https://www.myenergi.com', NULL, NULL, 'myenergi — британські зарядки EV zappi, перенаправлювачі надлишків eddi та батареї для максимального самоспоживання сонячної енергії.', 'myenergi makes UK zappi EV chargers, eddi surplus diverters and batteries to maximize solar self-consumption.', 'Виробник пристроїв, що спрямовують надлишок сонячної генерації в електромобіль (zappi), бойлер (eddi) чи батарею замість мережі. Застосунок myenergi показує потоки енергії й керує режимами.', 'A maker of devices that send surplus solar into the EV (zappi), water heater (eddi) or battery instead of the grid. The myenergi app shows energy flows and controls modes.', 'Зарядка EV від сонця
Перенаправлення надлишків
Батареї
Застосунок', 'Solar EV charging
Surplus diversion
Batteries
App', 'Власники сонячних панелей.', 'Solar owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myenergi.com' OR LOWER(`name`) = LOWER('myenergi')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'myenergi makes UK zappi EV chargers, eddi surplus diverters and batteries to maximize solar self-consumption.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A maker of devices that send surplus solar into the EV (zappi), water heater (eddi) or battery instead of the grid. The myenergi app shows energy flows and controls modes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Solar EV charging
Surplus diversion
Batteries
App', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Solar owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Octopus Energy — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'octopus.energy' OR LOWER(`name`) = LOWER('Octopus Energy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Octopus Energy', NULL, 'https://octopus.energy', NULL, NULL, 'Octopus Energy — британський постачальник енергії з розумними тарифами для EV, батарей і теплових насосів, винагородами за економію й застосунком.', 'Octopus Energy is a UK energy supplier with smart tariffs for EVs, batteries and heat pumps, savings rewards and an app.', 'Постачальник електроенергії й газу з тарифами, що змінюються погодинно (Agile, Go, Cosy), винагородами за зменшення споживання під час піків, встановленням зарядок EV і теплових насосів. Застосунок показує споживання й витрати.', 'An electricity and gas supplier with time-of-use tariffs (Agile, Go, Cosy), rewards for cutting use during peaks and installation of EV chargers and heat pumps. The app shows usage and costs.', 'Погодинні тарифи
Винагороди за економію
Теплові насоси
Застосунок', 'Time-of-use tariffs
Saving rewards
Heat pumps
App', 'Споживачі у Великій Британії.', 'UK consumers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'octopus.energy' OR LOWER(`name`) = LOWER('Octopus Energy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Octopus Energy is a UK energy supplier with smart tariffs for EVs, batteries and heat pumps, savings rewards and an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An electricity and gas supplier with time-of-use tariffs (Agile, Go, Cosy), rewards for cutting use during peaks and installation of EV chargers and heat pumps. The app shows usage and costs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Time-of-use tariffs
Saving rewards
Heat pumps
App', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'UK consumers.', 'manual' FROM DUAL WHERE @new = 1;

-- OhmConnect — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ohmconnect.com' OR LOWER(`name`) = LOWER('OhmConnect'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OhmConnect', NULL, 'https://www.ohmconnect.com', NULL, NULL, 'OhmConnect — винагороди за економію електроенергії в години пікового навантаження, автоматизація розумних пристроїв.', 'OhmConnect rewards saving electricity during peak hours and automates smart devices.', 'Сервіс у Каліфорнії й інших штатах, що повідомляє про «OhmHours» — періоди пікового навантаження, — і платить за зменшення споживання в цей час. Може автоматично вимикати підключені розумні розетки й термостати.', 'A service in California and other states that announces OhmHours — peak demand periods — and pays you for cutting use then. It can automatically switch off connected smart plugs and thermostats.', 'Винагороди за економію
OhmHours
Автоматизація пристроїв', 'Saving rewards
OhmHours
Device automation', 'Споживачі в США.', 'US consumers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ohmconnect.com' OR LOWER(`name`) = LOWER('OhmConnect')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'OhmConnect rewards saving electricity during peak hours and automates smart devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service in California and other states that announces OhmHours — peak demand periods — and pays you for cutting use then. It can automatically switch off connected smart plugs and thermostats.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Saving rewards
OhmHours
Device automation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US consumers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Участь безкоштовна', 'Free to join' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free to join', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Project Sunroof — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sunroof.withgoogle.com' OR LOWER(`name`) = LOWER('Project Sunroof'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Project Sunroof', NULL, 'https://sunroof.withgoogle.com', NULL, NULL, 'Project Sunroof від Google — калькулятор сонячного потенціалу даху за 3D-моделлю: годин сонця, розмір системи й економія.', 'Google''s Project Sunroof estimates a roof''s solar potential from 3D modeling: sun hours, system size and savings.', 'Безкоштовний інструмент: вводите адресу, і сервіс за аерознімками та 3D-моделлю даху й дерев оцінює кількість сонячних годин, придатну площу, рекомендований розмір системи та орієнтовну економію; може передати запит установникам.', 'A free tool: enter an address and, using aerial imagery and 3D modeling of the roof and trees, it estimates sun hours, usable area, recommended system size and approximate savings, and can connect you with installers.', '3D-модель даху
Сонячні години
Розмір системи
Оцінка економії', '3D roof model
Sun hours
System size
Savings estimate', 'Власники будинків, що думають про сонячні панелі.', 'Homeowners considering solar.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sunroof.withgoogle.com' OR LOWER(`name`) = LOWER('Project Sunroof')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Google''s Project Sunroof estimates a roof''s solar potential from 3D modeling: sun hours, system size and savings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A free tool: enter an address and, using aerial imagery and 3D modeling of the roof and trees, it estimates sun hours, usable area, recommended system size and approximate savings, and can connect you with installers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '3D roof model
Sun hours
System size
Savings estimate', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners considering solar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Онлайн-калькулятор', 'Online calculator' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Online calculator', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Rewiring America — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rewiringamerica.org' OR LOWER(`name`) = LOWER('Rewiring America'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Rewiring America', NULL, 'https://www.rewiringamerica.org', NULL, NULL, 'Rewiring America — некомерційна організація з електрифікації домів: калькулятор податкових пільг і знижок на теплові насоси, сонце й EV.', 'Rewiring America is a nonprofit for home electrification: a calculator of tax credits and rebates for heat pumps, solar and EVs.', 'Організація, що допомагає американським домогосподарствам переходити на електричні рішення. Пропонує калькулятор пільг, гіди з теплових насосів, індукційних плит, сонячних систем та електромобілів.', 'An organization helping US households switch to electric solutions. It offers an incentives calculator and guides on heat pumps, induction stoves, solar and EVs.', 'Калькулятор пільг
Гіди з електрифікації
Теплові насоси', 'Incentives calculator
Electrification guides
Heat pumps', 'Власники будинків у США.', 'US homeowners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rewiringamerica.org' OR LOWER(`name`) = LOWER('Rewiring America')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Rewiring America is a nonprofit for home electrification: a calculator of tax credits and rebates for heat pumps, solar and EVs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An organization helping US households switch to electric solutions. It offers an incentives calculator and guides on heat pumps, induction stoves, solar and EVs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Incentives calculator
Electrification guides
Heat pumps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US homeowners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Відкритий доступ', 'Open access' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open access', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Sense — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sense.com' OR LOWER(`name`) = LOWER('Sense'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sense', NULL, 'https://sense.com', NULL, NULL, 'Sense — монітор домашньої енергії в щитку: споживання в реальному часі, розпізнавання приладів і звіти для зменшення рахунків.', 'Sense is a panel-installed home energy monitor: real-time use, device detection and reports to lower bills.', 'Датчики встановлюються в електрощиток і за допомогою машинного навчання розпізнають окремі прилади, показують споживання й генерацію сонячних панелей у реальному часі, попереджають про незвичну роботу техніки. Також інтегрований у розумні лічильники деяких енергокомпаній.', 'Sensors installed in the electrical panel use machine learning to identify individual devices, show real-time consumption and solar production and alert you to unusual appliance behaviour. It is also built into some utilities'' smart meters.', 'Споживання в реальному часі
Розпізнавання приладів
Моніторинг сонячної генерації', 'Real-time usage
Device detection
Solar monitoring', 'Власники будинків.', 'Homeowners.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sense.com' OR LOWER(`name`) = LOWER('Sense')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sense is a panel-installed home energy monitor: real-time use, device detection and reports to lower bills.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sensors installed in the electrical panel use machine learning to identify individual devices, show real-time consumption and solar production and alert you to unusual appliance behaviour. It is also built into some utilities'' smart meters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Real-time usage
Device detection
Solar monitoring', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- SolarEdge — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'solaredge.com' OR LOWER(`name`) = LOWER('SolarEdge'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SolarEdge', NULL, 'https://www.solaredge.com', NULL, NULL, 'SolarEdge — інвертори, оптимізатори й батареї для сонячних станцій із застосунком mySolarEdge для моніторингу.', 'SolarEdge makes inverters, optimizers and batteries for solar with the mySolarEdge monitoring app.', 'Виробник обладнання для домашніх і комерційних сонячних систем: інвертори з оптимізаторами на кожну панель, батареї й зарядки EV. Застосунок mySolarEdge показує виробництво й споживання, стан панелей і дозволяє керувати пристроями.', 'A maker of equipment for home and commercial solar: inverters with per-panel optimizers, batteries and EV chargers. The mySolarEdge app shows production and consumption, panel status and device control.', 'Оптимізатори панелей
Інвертори
Батареї
Застосунок mySolarEdge', 'Panel optimizers
Inverters
Batteries
mySolarEdge app', 'Власники сонячних станцій.', 'Solar owners.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'solaredge.com' OR LOWER(`name`) = LOWER('SolarEdge')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SolarEdge makes inverters, optimizers and batteries for solar with the mySolarEdge monitoring app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A maker of equipment for home and commercial solar: inverters with per-panel optimizers, batteries and EV chargers. The mySolarEdge app shows production and consumption, panel status and device control.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Panel optimizers
Inverters
Batteries
mySolarEdge app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Solar owners.', 'manual' FROM DUAL WHERE @new = 1;

-- SPAN — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'span.io' OR LOWER(`name`) = LOWER('SPAN'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SPAN', NULL, 'https://www.span.io', NULL, NULL, 'SPAN — розумний електрощиток: керування кожним колом із застосунку, пріоритет навантажень під час відключень і інтеграція сонця та батарей.', 'SPAN is a smart electrical panel: per-circuit control from an app, load priority during outages and solar and battery integration.', 'Замість звичайного щитка SPAN дає змогу бачити й вимикати кожне коло з телефона, задавати пріоритети навантажень під час роботи від батареї, уникати дорогої модернізації вводу при встановленні EV-зарядки й теплових насосів.', 'Replacing a standard panel, SPAN lets you see and switch every circuit from your phone, prioritize loads on battery backup and avoid costly service upgrades when adding EV chargers and heat pumps.', 'Керування кожним колом
Пріоритети під час відключень
Інтеграція батарей', 'Per-circuit control
Outage priorities
Battery integration', 'Власники будинків з сонцем і EV.', 'Homeowners with solar and EVs.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'span.io' OR LOWER(`name`) = LOWER('SPAN')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SPAN is a smart electrical panel: per-circuit control from an app, load priority during outages and solar and battery integration.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Replacing a standard panel, SPAN lets you see and switch every circuit from your phone, prioritize loads on battery backup and avoid costly service upgrades when adding EV chargers and heat pumps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Per-circuit control
Outage priorities
Battery integration', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners with solar and EVs.', 'manual' FROM DUAL WHERE @new = 1;

-- Tesla Powerwall — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tesla.com/powerwall' OR LOWER(`name`) = LOWER('Tesla Powerwall'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tesla Powerwall', NULL, 'https://www.tesla.com/powerwall', NULL, NULL, 'Tesla Powerwall — домашня батарея для резервного живлення й накопичення сонячної енергії з керуванням у застосунку Tesla.', 'Tesla Powerwall is a home battery for backup power and solar storage, managed in the Tesla app.', 'Акумуляторна система, що зберігає енергію від сонячних панелей чи мережі та автоматично живить будинок під час відключень. Застосунок Tesla показує потоки енергії, дозволяє обрати режими (резерв, самоспоживання, тарифна оптимізація) й отримувати сповіщення про відключення.', 'A battery system that stores energy from solar or the grid and automatically powers the home during outages. The Tesla app shows energy flows, lets you choose modes (backup, self-powered, time-based control) and sends outage alerts.', 'Резервне живлення
Накопичення сонячної енергії
Режими роботи
Сповіщення', 'Backup power
Solar storage
Operating modes
Alerts', 'Власники будинків.', 'Homeowners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tesla.com/powerwall' OR LOWER(`name`) = LOWER('Tesla Powerwall')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tesla Powerwall is a home battery for backup power and solar storage, managed in the Tesla app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A battery system that stores energy from solar or the grid and automatically powers the home during outages. The Tesla app shows energy flows, lets you choose modes (backup, self-powered, time-based control) and sends outage alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Backup power
Solar storage
Operating modes
Alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- Tibber — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tibber.com' OR LOWER(`name`) = LOWER('Tibber'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tibber', NULL, 'https://tibber.com', NULL, NULL, 'Tibber — постачальник електроенергії з погодинною ціною та застосунком, що розумно керує зарядкою EV, опаленням і батареями.', 'Tibber is an electricity supplier with hourly pricing and an app that smartly controls EV charging, heating and batteries.', 'Цифровий енергопостачальник (Скандинавія, Німеччина, Нідерланди), що продає електроенергію за біржовою ціною без націнки й пропонує розумне керування: заряджання авто й нагрів у найдешевші години, датчик Pulse для лічильника та інтеграції з пристроями.', 'A digital electricity supplier (Nordics, Germany, Netherlands) selling power at spot price without markup and offering smart control: charging cars and heating in the cheapest hours, the Pulse meter sensor and device integrations.', 'Погодинна ціна
Розумна зарядка EV
Датчик Pulse
Інтеграції', 'Hourly pricing
Smart EV charging
Pulse sensor
Integrations', 'Споживачі в Європі.', 'Consumers in Europe.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tibber.com' OR LOWER(`name`) = LOWER('Tibber')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tibber is an electricity supplier with hourly pricing and an app that smartly controls EV charging, heating and batteries.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A digital electricity supplier (Nordics, Germany, Netherlands) selling power at spot price without markup and offering smart control: charging cars and heating in the cheapest hours, the Pulse meter sensor and device integrations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hourly pricing
Smart EV charging
Pulse sensor
Integrations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Consumers in Europe.', 'manual' FROM DUAL WHERE @new = 1;

-- Victron Energy — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'victronenergy.com' OR LOWER(`name`) = LOWER('Victron Energy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Victron Energy', NULL, 'https://www.victronenergy.com', NULL, NULL, 'Victron Energy — інвертори, контролери заряду й батареї для автономних і резервних систем із порталом моніторингу VRM.', 'Victron Energy makes inverters, charge controllers and batteries for off-grid and backup systems with the VRM monitoring portal.', 'Нідерландський виробник з понад 50-річною історією. Обладнання для автономного живлення будинків, човнів і автодомів; безкоштовний портал і застосунок VRM дає віддалений моніторинг, історію й налаштування системи.', 'A Dutch manufacturer with over 50 years of history. Equipment for off-grid power in homes, boats and RVs; the free VRM portal and app provide remote monitoring, history and system configuration.', 'Інвертори й контролери
Батареї
Портал VRM
Автономні системи', 'Inverters and controllers
Batteries
VRM portal
Off-grid systems', 'Власники автономних систем і монтажники.', 'Off-grid owners and installers.', 'mobile,web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'victronenergy.com' OR LOWER(`name`) = LOWER('Victron Energy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Victron Energy makes inverters, charge controllers and batteries for off-grid and backup systems with the VRM monitoring portal.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Dutch manufacturer with over 50 years of history. Equipment for off-grid power in homes, boats and RVs; the free VRM portal and app provide remote monitoring, history and system configuration.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Inverters and controllers
Batteries
VRM portal
Off-grid systems', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Off-grid owners and installers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'VRM', 'VRM', 0.00, 'free', 'Портал моніторингу', 'Monitoring portal' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'VRM' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'VRM', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Monitoring portal', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- WattBuy — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wattbuy.com' OR LOWER(`name`) = LOWER('WattBuy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'WattBuy', NULL, 'https://www.wattbuy.com', NULL, NULL, 'WattBuy — порівняння електротарифів і переходу на відновлювану енергію та сонце для американських домогосподарств.', 'WattBuy compares electricity plans and helps US households switch to renewables and solar.', 'Сервіс, що показує персоналізовані варіанти електропостачання за адресою: дешевші тарифи на дерегульованих ринках, зелені плани, сонячні системи й інші способи зменшити рахунки.', 'A service showing personalized power options by address: cheaper plans in deregulated markets, green plans, solar and other ways to cut bills.', 'Порівняння тарифів
Зелені плани
Сонячні системи', 'Plan comparison
Green plans
Solar', 'Споживачі в США.', 'US consumers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wattbuy.com' OR LOWER(`name`) = LOWER('WattBuy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'WattBuy compares electricity plans and helps US households switch to renewables and solar.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service showing personalized power options by address: cheaper plans in deregulated markets, green plans, solar and other ways to cut bills.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Plan comparison
Green plans
Solar', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US consumers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Порівняння', 'Comparison' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Comparison', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- YASNO — Енергія та резервне живлення
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yasno.ua' OR LOWER(`name`) = LOWER('YASNO'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'YASNO', NULL, 'https://yasno.ua', NULL, NULL, 'YASNO — постачальник електроенергії й газу для 3,3 млн клієнтів в Україні: особистий кабінет, оплата, показники й графіки відключень.', 'YASNO supplies electricity and gas to 3.3 million customers in Ukraine: personal account, payments, readings and outage schedules.', 'Енергопостачальник (група ДТЕК) у Києві, Дніпрі й інших регіонах. Сайт і застосунок дозволяють передавати показники, сплачувати рахунки, переглядати графіки стабілізаційних відключень і отримувати енергоефективні рішення (сонячні станції, батареї).', 'An energy supplier (DTEK group) in Kyiv, Dnipro and other regions. The site and app let you submit readings, pay bills, view outage schedules and get energy-efficiency solutions (solar, batteries).', 'Особистий кабінет
Оплата рахунків
Графіки відключень
Енергорішення', 'Personal account
Bill payment
Outage schedules
Energy solutions', 'Споживачі в Україні.', 'Consumers in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yasno.ua' OR LOWER(`name`) = LOWER('YASNO')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'home-energy' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'YASNO supplies electricity and gas to 3.3 million customers in Ukraine: personal account, payments, readings and outage schedules.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An energy supplier (DTEK group) in Kyiv, Dnipro and other regions. The site and app let you submit readings, pay bills, view outage schedules and get energy-efficiency solutions (solar, batteries).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Personal account
Bill payment
Outage schedules
Energy solutions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Consumers in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Кабінет і застосунок', 'Account and app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Account and app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
