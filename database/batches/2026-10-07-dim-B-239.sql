SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-10-07: 239 нових продуктів для нових підгруп категорії «Мій дім» .
-- Платні й безкоштовні застосунки, сервіси й онлайн-ресурси за підкатегоріями:
--   Розумний дім (smart-home): 0
--   Безпека дому (home-security): 0
--   Ремонт і будівництво (renovation): 0
--   Нерухомість і оренда (real-estate): 0
--   Домашнє господарство (household): 0
--   Енергія та резервне живлення (home-energy): 0
--   Домашні рослини (houseplants): 16
--   Сад (garden): 20
--   Город (kitchen-garden): 12
--   Домашні тварини (pets): 21
--   Худоба (livestock): 9
--   Птахівництво (poultry): 7
--   Риба (fish): 12
--   Бджоли (beekeeping): 6
--   Кулінарія (cooking): 24
--   Грумінг та ветеринарні сервіси (pet-grooming-vet): 16
--   Рукоділля (handicraft): 17
--   Авто (auto): 26
--   Дизайн інтер'єру (interior-design): 22
--   Покупки (shopping): 31
-- Лише справжні сервіси: сайти перевірено (відповідають, назва на сторінці). Відкинуто неробочі,
-- припарковані й захоплені домени, Cloudflare-перевірки, новинні сайти, благодійні фонди,
-- інвестиційні сервіси, астрологію, знайомства, продаж БАДів, сайти з медичними твердженнями. Тексти описові, без маркетингових оцінок.
-- Тексти, функції й тарифи (UA + EN) — лише з офіційних сайтів, звірено 2026-10-07.
-- Потребує міграції database/migration-2026-10-07-dim-subcategories.sql (нові підкатегорії).
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт» (файл .sql або .sql.zip). Повторний запуск безпечний.
--   AeroGarden — Домашні рослини
--   Agrio — Домашні рослини
--   Bloomscape — Домашні рослини
--   Click & Grow — Домашні рослини
--   Flora Incognita — Домашні рослини
--   Florish — Домашні рослини
--   Gardyn — Домашні рослини
--   Happy Plant — Домашні рослини
--   iNaturalist — Домашні рослини
--   Lettuce Grow — Домашні рослини
--   Plantora — Домашні рослини
--   Rise Gardens — Домашні рослини
--   Seek by iNaturalist — Домашні рослини
--   The Sill — Домашні рослини
--   Vera by Bloomscape — Домашні рослини
--   WaterBot — Домашні рослини
--   BBC Gardeners' World Magazine — Сад
--   Bird Buddy — Сад
--   GARDENA smart system — Сад
--   Gardenia.net — Сад
--   Husqvarna Automower — Сад
--   Hydrawise — Сад
--   Lawn Love — Сад
--   LawnStarter — Сад
--   MAMMOTION — Сад
--   Merlin Bird ID — Сад
--   Moasure — Сад
--   Orbit B-hyve — Сад
--   Picture Insect — Сад
--   Rachio — Сад
--   Rain Bird — Сад
--   RHS — Сад
--   Scotts — Сад
--   Segway Navimow — Сад
--   Sunday Lawn Care — Сад
--   Worx Landroid — Сад
--   AGROHUB — Город
--   Bonnie Plants — Город
--   Burpee — Город
--   Farmonaut — Город
--   From Seed to Spoon — Город
--   Gardenate — Город
--   GardenManager — Город
--   Johnny's Selected Seeds — Город
--   Plantix — Город
--   Seed Savers Exchange — Город
--   Tend — Город
--   The Old Farmer's Almanac — Город
--   11pets — Домашні тварини
--   Adopt-a-Pet — Домашні тварини
--   BarkBox — Домашні тварини
--   Embark — Домашні тварини
--   Furbo — Домашні тварини
--   Halo Collar — Домашні тварини
--   Lemonade Pet — Домашні тварини
--   Litter-Robot — Домашні тварини
--   MasterZoo — Домашні тварини
--   Ollie — Домашні тварини
--   PawBoost — Домашні тварини
--   Petfinder — Домашні тварини
--   PETLIBRO — Домашні тварини
--   PetLink — Домашні тварини
--   Pupford — Домашні тварини
--   Puppr — Домашні тварини
--   Sure Petcare — Домашні тварини
--   The Farmer's Dog — Домашні тварини
--   Trupanion — Домашні тварини
--   Wisdom Panel — Домашні тварини
--   Woofz — Домашні тварини
--   DeLaval — Худоба
--   Equilab — Худоба
--   HerdDogg — Худоба
--   Lely — Худоба
--   Mobble — Худоба
--   Moonsyst — Худоба
--   Nofence — Худоба
--   smaXtec — Худоба
--   Vence — Худоба
--   BackYard Chickens — Птахівництво
--   Brinsea — Птахівництво
--   ChickenGuard — Птахівництво
--   My Pet Chicken — Птахівництво
--   Omlet — Птахівництво
--   RUN-CHICKEN — Птахівництво
--   The Chicken Coop Company — Птахівництво
--   ANGLR — Риба
--   Aquarium Advice — Риба
--   Aquascape — Риба
--   Deeper — Риба
--   Eruvaka — Риба
--   FishAngler — Риба
--   Fishbrain — Риба
--   Fishidy — Риба
--   Fishing Points — Риба
--   Garmin ActiveCaptain — Риба
--   Navionics — Риба
--   Umitron — Риба
--   Apiary Book — Бджоли
--   Bee Culture — Бджоли
--   Beewise — Бджоли
--   HiveKeepers — Бджоли
--   Honey Bee Health Coalition — Бджоли
--   Pollenity — Бджоли
--   Allrecipes — Кулінарія
--   Anova — Кулінарія
--   BBC Good Food — Кулінарія
--   Budget Bytes — Кулінарія
--   Cookidoo — Кулінарія
--   Crouton — Кулінарія
--   Eat This Much — Кулінарія
--   Epicurious — Кулінарія
--   Food Network — Кулінарія
--   HelloFresh — Кулінарія
--   Jow — Кулінарія
--   Kitchen Stories — Кулінарія
--   Mealie — Кулінарія
--   Mealime — Кулінарія
--   MEATER — Кулінарія
--   Mela — Кулінарія
--   NYT Cooking — Кулінарія
--   Plan to Eat — Кулінарія
--   ReciMe — Кулінарія
--   Serious Eats — Кулінарія
--   Supercook — Кулінарія
--   Tandoor Recipes — Кулінарія
--   Tasty — Кулінарія
--   Пательня — Кулінарія
--   Airvet — Грумінг та ветеринарні сервіси
--   Bond Vet — Грумінг та ветеринарні сервіси
--   Digitail — Грумінг та ветеринарні сервіси
--   Dutch — Грумінг та ветеринарні сервіси
--   ezyVet — Грумінг та ветеринарні сервіси
--   FirstVet — Грумінг та ветеринарні сервіси
--   Gingr — Грумінг та ветеринарні сервіси
--   Joii Pet Care — Грумінг та ветеринарні сервіси
--   Modern Animal — Грумінг та ветеринарні сервіси
--   MoeGo — Грумінг та ветеринарні сервіси
--   PetDesk — Грумінг та ветеринарні сервіси
--   Petriage — Грумінг та ветеринарні сервіси
--   PetsApp — Грумінг та ветеринарні сервіси
--   ScribbleVet — Грумінг та ветеринарні сервіси
--   Small Door Veterinary — Грумінг та ветеринарні сервіси
--   Vetster — Грумінг та ветеринарні сервіси
--   Craftsy — Рукоділля
--   Cricut Design Space — Рукоділля
--   Domestika — Рукоділля
--   DROPS Design — Рукоділля
--   Hatch Embroidery — Рукоділля
--   Instructables — Рукоділля
--   knitCompanion — Рукоділля
--   LoveCrafts — Рукоділля
--   Mood Fabrics — Рукоділля
--   Pattern Keeper — Рукоділля
--   Printables — Рукоділля
--   Seamly2D — Рукоділля
--   Silhouette Studio — Рукоділля
--   Tailornova — Рукоділля
--   The Fold Line — Рукоділля
--   Valentina — Рукоділля
--   Yarnspirations — Рукоділля
--   Android Auto — Авто
--   Apple CarPlay — Авто
--   AUTO.RIA — Авто
--   AUTODOC — Авто
--   AutoMoto.ua — Авто
--   BlaBlaCar — Авто
--   CARFAX — Авто
--   CarGurus — Авто
--   Carvana — Авто
--   carVertical — Авто
--   Electrify America — Авто
--   Electromaps — Авто
--   Getaround — Авто
--   Kelley Blue Book — Авто
--   My BMW — Авто
--   Nexar — Авто
--   Openbay — Авто
--   Parkopedia — Авто
--   RockAuto — Авто
--   SpotHero — Авто
--   Turo — Авто
--   Uklon — Авто
--   WOG — Авто
--   YourMechanic — Авто
--   Zapmap — Авто
--   ОККО — Авто
--   Apartment Therapy — Дизайн інтер'єру
--   ArchiVinci — Дизайн інтер'єру
--   Chief Architect — Дизайн інтер'єру
--   Coohom — Дизайн інтер'єру
--   Coolors — Дизайн інтер'єру
--   Decorilla — Дизайн інтер'єру
--   DecorMatters — Дизайн інтер'єру
--   DesignFiles — Дизайн інтер'єру
--   Foyr Neo — Дизайн інтер'єру
--   Havenly — Дизайн інтер'єру
--   Hutch — Дизайн інтер'єру
--   IKEA Kreativ — Дизайн інтер'єру
--   Live Home 3D — Дизайн інтер'єру
--   Mattoboard — Дизайн інтер'єру
--   Morpholio Board — Дизайн інтер'єру
--   Paintit.ai — Дизайн інтер'єру
--   Programa — Дизайн інтер'єру
--   RoomGPT — Дизайн інтер'єру
--   Spacejoy — Дизайн інтер'єру
--   Spacely AI — Дизайн інтер'єру
--   Spoak — Дизайн інтер'єру
--   Wayfair — Дизайн інтер'єру
--   camelcamelcamel — Покупки
--   Capital One Shopping — Покупки
--   Depop — Покупки
--   Fetch — Покупки
--   Flipp — Покупки
--   Glovo — Покупки
--   Google Shopping — Покупки
--   Honey — Покупки
--   Hotline.ua — Покупки
--   idealo — Покупки
--   Instacart — Покупки
--   Karma — Покупки
--   Keepa — Покупки
--   Lyst — Покупки
--   Meest — Покупки
--   OLX.ua — Покупки
--   Poshmark — Покупки
--   Price.ua — Покупки
--   PriceRunner — Покупки
--   Prom — Покупки
--   Rakuten — Покупки
--   ROZETKA — Покупки
--   SHAFA — Покупки
--   Shop — Покупки
--   ShopSavvy — Покупки
--   thredUP — Покупки
--   Vinted — Покупки
--   Zakaz.ua — Покупки
--   Нова пошта — Покупки
--   Сільпо — Покупки
--   Укрпошта — Покупки
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);

-- AeroGarden — Домашні рослини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aerogarden.com' OR LOWER(`name`) = LOWER('AeroGarden'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AeroGarden', NULL, 'https://www.aerogarden.com', NULL, NULL, 'AeroGarden (Scotts Miracle-Gro) — домашні гідропонні сади з LED-освітленням для вирощування зелені й овочів цілий рік.', 'AeroGarden (Scotts Miracle-Gro) makes indoor hydroponic gardens with LED lighting to grow herbs and vegetables year-round.', 'Кухонні гідропонні системи різних розмірів з лампами й нагадуваннями про воду та добрива; Wi-Fi-моделі керуються через застосунок. Набори насіння зелені, салатів, томатів і квітів.', 'Kitchen hydroponic systems of various sizes with lights and water and nutrient reminders; Wi-Fi models are app-controlled. Seed kits for herbs, salads, tomatoes and flowers.', 'Гідропоніка
LED-освітлення
Набори насіння
Wi-Fi-моделі', 'Hydroponics
LED lighting
Seed kits
Wi-Fi models', 'Домашні садівники.', 'Home growers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aerogarden.com' OR LOWER(`name`) = LOWER('AeroGarden')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'houseplants' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AeroGarden (Scotts Miracle-Gro) makes indoor hydroponic gardens with LED lighting to grow herbs and vegetables year-round.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Kitchen hydroponic systems of various sizes with lights and water and nutrient reminders; Wi-Fi models are app-controlled. Seed kits for herbs, salads, tomatoes and flowers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hydroponics
LED lighting
Seed kits
Wi-Fi models', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Home growers.', 'manual' FROM DUAL WHERE @new = 1;

-- Agrio — Домашні рослини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'agrio.app' OR LOWER(`name`) = LOWER('Agrio'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Agrio', NULL, 'https://agrio.app', NULL, NULL, 'Agrio — AI-діагностика хвороб і шкідників рослин за фото для садівників і фермерів, з рекомендаціями лікування й сповіщеннями.', 'Agrio offers AI diagnosis of plant diseases and pests from photos for gardeners and farmers, with treatment advice and alerts.', 'Застосунок розпізнає хвороби, шкідників і дефіцит поживних речовин за фото, радить методи захисту, надсилає ранні попередження про загрози в регіоні й має інструменти моніторингу полів.', 'The app recognizes diseases, pests and nutrient deficiencies from photos, recommends protection methods, sends early regional threat alerts and has field monitoring tools.', 'Діагностика за фото
Шкідники й хвороби
Регіональні попередження', 'Photo diagnosis
Pests and diseases
Regional alerts', 'Садівники й фермери.', 'Gardeners and farmers.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'agrio.app' OR LOWER(`name`) = LOWER('Agrio')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'houseplants' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Agrio offers AI diagnosis of plant diseases and pests from photos for gardeners and farmers, with treatment advice and alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app recognizes diseases, pests and nutrient deficiencies from photos, recommends protection methods, sends early regional threat alerts and has field monitoring tools.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Photo diagnosis
Pests and diseases
Regional alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gardeners and farmers.', 'manual' FROM DUAL WHERE @new = 1;

-- Bloomscape — Домашні рослини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bloomscape.com' OR LOWER(`name`) = LOWER('Bloomscape'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bloomscape', NULL, 'https://bloomscape.com', NULL, NULL, 'Bloomscape — доставка кімнатних рослин у горщиках просто з теплиці з посібниками з догляду й підтримкою.', 'Bloomscape delivers potted houseplants straight from the greenhouse with care guides and support.', 'Інтернет-магазин рослин у США, що вирощує й відправляє рослини у керамічних горщиках, пропонує подарунки, посібники з догляду та застосунок Vera для нагадувань.', 'A US online plant shop that grows and ships plants in ceramic pots and offers gifts, care guides and the Vera app for reminders.', 'Рослини в горщиках
Доставка
Посібники з догляду', 'Potted plants
Delivery
Care guides', 'Покупці рослин у США.', 'US plant shoppers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bloomscape.com' OR LOWER(`name`) = LOWER('Bloomscape')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'houseplants' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Bloomscape delivers potted houseplants straight from the greenhouse with care guides and support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A US online plant shop that grows and ships plants in ceramic pots and offers gifts, care guides and the Vera app for reminders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Potted plants
Delivery
Care guides', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US plant shoppers.', 'manual' FROM DUAL WHERE @new = 1;

-- Click & Grow — Домашні рослини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'clickandgrow.com' OR LOWER(`name`) = LOWER('Click & Grow'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Click & Grow', NULL, 'https://www.clickandgrow.com', NULL, NULL, 'Click & Grow — розумні домашні гідропонні сади для зелені, овочів і квітів з картриджами насіння та застосунком.', 'Click & Grow makes smart indoor gardens for herbs, veggies and flowers with seed pods and an app.', 'Естонський бренд «розумних садів» із LED-лампами й автоматичним поливом. Достатньо вставити картриджі з насінням і долити воду; застосунок підказує етапи росту й нагадує доливати воду. Є підписка на картриджі.', 'An Estonian smart garden brand with LED lights and automatic watering. Insert seed pods and add water; the app guides growth stages and reminds you to refill. Pod subscriptions are available.', 'Гідропоніка вдома
Картриджі насіння
LED-світло
Застосунок', 'Indoor hydroponics
Seed pods
LED light
App', 'Мешканці квартир.', 'Apartment dwellers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'clickandgrow.com' OR LOWER(`name`) = LOWER('Click & Grow')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'houseplants' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Click & Grow makes smart indoor gardens for herbs, veggies and flowers with seed pods and an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An Estonian smart garden brand with LED lights and automatic watering. Insert seed pods and add water; the app guides growth stages and reminds you to refill. Pod subscriptions are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Indoor hydroponics
Seed pods
LED light
App', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Apartment dwellers.', 'manual' FROM DUAL WHERE @new = 1;

-- Flora Incognita — Домашні рослини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'floraincognita.de' OR LOWER(`name`) = LOWER('Flora Incognita'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Flora Incognita', NULL, 'https://floraincognita.de', NULL, NULL, 'Flora Incognita — безкоштовний науковий застосунок для визначення дикорослих рослин за фото від Технічного університету Ільменау.', 'Flora Incognita is a free science app for identifying wild plants from photos, by TU Ilmenau.', 'Дослідницький проєкт німецьких університетів: застосунок визначає тисячі видів рослин за кількома фото, показує описи й зберігає спостереження, що використовуються в наукових дослідженнях.', 'A German university research project: the app identifies thousands of plant species from a few photos, shows descriptions and stores observations used in scientific research.', 'Визначення рослин
Науковий проєкт
Описи видів
Безкоштовно', 'Plant ID
Research project
Species info
Free', 'Любителі природи.', 'Nature lovers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'floraincognita.de' OR LOWER(`name`) = LOWER('Flora Incognita')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'houseplants' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Flora Incognita is a free science app for identifying wild plants from photos, by TU Ilmenau.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A German university research project: the app identifies thousands of plant species from a few photos, shows descriptions and stores observations used in scientific research.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Plant ID
Research project
Species info
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Nature lovers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Florish — Домашні рослини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'florish.app' OR LOWER(`name`) = LOWER('Florish'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Florish', NULL, 'https://florish.app', NULL, NULL, 'Florish — голосовий садовий щоденник без рук: розкажіть про рослини, і застосунок веде записи, нагадування й відстежує ріст.', 'Florish is a hands-free voice garden journal: talk about your plants and the app keeps notes, reminders and growth tracking.', 'Застосунок, у якому садівник надиктовує спостереження, а AI перетворює їх на структуровані записи про рослини, завдання й нагадування, показує історію та відзначає досягнення.', 'An app where gardeners dictate observations and AI turns them into structured plant records, tasks and reminders, showing history and celebrating milestones.', 'Голосовий щоденник
AI-записи
Нагадування
Історія росту', 'Voice journal
AI notes
Reminders
Growth history', 'Садівники й власники рослин.', 'Gardeners and plant owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'florish.app' OR LOWER(`name`) = LOWER('Florish')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'houseplants' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Florish is a hands-free voice garden journal: talk about your plants and the app keeps notes, reminders and growth tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app where gardeners dictate observations and AI turns them into structured plant records, tasks and reminders, showing history and celebrating milestones.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Voice journal
AI notes
Reminders
Growth history', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gardeners and plant owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Gardyn — Домашні рослини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mygardyn.com' OR LOWER(`name`) = LOWER('Gardyn'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Gardyn', NULL, 'https://mygardyn.com', NULL, NULL, 'Gardyn — вертикальна гідропонна ферма для дому з камерами й AI-асистентом Kelby, що доглядає за рослинами.', 'Gardyn is a vertical indoor hydroponic farm with cameras and the AI assistant Kelby that looks after your plants.', 'Компактна система на 16–30 рослин з освітленням, поливом і вбудованими камерами. AI-асистент Kelby аналізує стан рослин і дає поради в застосунку; членство включає картриджі.', 'A compact 16–30 plant system with lighting, watering and built-in cameras. The AI assistant Kelby analyzes plant health and gives advice in the app; membership includes pods.', 'Вертикальна ферма
Камери
AI-асистент Kelby
Членство', 'Vertical farm
Cameras
AI assistant Kelby
Membership', 'Мешканці міст.', 'City dwellers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mygardyn.com' OR LOWER(`name`) = LOWER('Gardyn')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'houseplants' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Gardyn is a vertical indoor hydroponic farm with cameras and the AI assistant Kelby that looks after your plants.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A compact 16–30 plant system with lighting, watering and built-in cameras. The AI assistant Kelby analyzes plant health and gives advice in the app; membership includes pods.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Vertical farm
Cameras
AI assistant Kelby
Membership', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'City dwellers.', 'manual' FROM DUAL WHERE @new = 1;

-- Happy Plant — Домашні рослини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'happyplant.app' OR LOWER(`name`) = LOWER('Happy Plant'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Happy Plant', NULL, 'https://happyplant.app', NULL, NULL, 'Happy Plant — застосунок для поливу й щоденника кімнатних рослин з фото-таймлайном росту.', 'Happy Plant is a watering and journal app for houseplants with a photo growth timeline.', 'Застосунок для iOS, що нагадує про полив, дає змогу фотографувати рослини й бачити їхній ріст у часі, вести нотатки й відзначати пересадки та підживлення.', 'An iOS app that reminds you to water, lets you photograph plants and see them grow over time, keep notes and log repotting and feeding.', 'Нагадування про полив
Фото-таймлайн
Нотатки', 'Watering reminders
Photo timeline
Notes', 'Любителі кімнатних рослин.', 'Houseplant lovers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'happyplant.app' OR LOWER(`name`) = LOWER('Happy Plant')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'houseplants' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Happy Plant is a watering and journal app for houseplants with a photo growth timeline.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An iOS app that reminds you to water, lets you photograph plants and see them grow over time, keep notes and log repotting and feeding.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Watering reminders
Photo timeline
Notes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Houseplant lovers.', 'manual' FROM DUAL WHERE @new = 1;

-- iNaturalist — Домашні рослини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'inaturalist.org' OR LOWER(`name`) = LOWER('iNaturalist'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'iNaturalist', NULL, 'https://www.inaturalist.org', NULL, NULL, 'iNaturalist — спільнота натуралістів: визначення рослин і тварин за фото, спостереження й внесок у науку.', 'iNaturalist is a naturalist community: identify plants and animals from photos, record observations and contribute to science.', 'Безкоштовний проєкт California Academy of Sciences і National Geographic. Користувачі публікують фото рослин, грибів і тварин, AI пропонує вид, а спільнота підтверджує; дані використовують дослідники.', 'A free project of the California Academy of Sciences and National Geographic. Users post photos of plants, fungi and animals, AI suggests a species and the community confirms; researchers use the data.', 'Визначення за фото
Спільнота експертів
Наукові дані
Безкоштовно', 'Photo ID
Expert community
Science data
Free', 'Любителі природи й садівники.', 'Nature lovers and gardeners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'inaturalist.org' OR LOWER(`name`) = LOWER('iNaturalist')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'houseplants' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'iNaturalist is a naturalist community: identify plants and animals from photos, record observations and contribute to science.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A free project of the California Academy of Sciences and National Geographic. Users post photos of plants, fungi and animals, AI suggests a species and the community confirms; researchers use the data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Photo ID
Expert community
Science data
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Nature lovers and gardeners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Некомерційний проєкт', 'Nonprofit project' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Nonprofit project', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Lettuce Grow — Домашні рослини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lettucegrow.com' OR LOWER(`name`) = LOWER('Lettuce Grow'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lettuce Grow', NULL, 'https://www.lettucegrow.com', NULL, NULL, 'Lettuce Grow — гідропонні «фермстенди» для дому й балкона з доставкою розсади щомісяця.', 'Lettuce Grow makes hydroponic Farmstands for indoors and patios with monthly seedling delivery.', 'Вертикальна гідропонна башта для вулиці чи приміщення (з лампами), куди вставляють готову розсаду, що доставляється за підпискою. Застосунок нагадує про догляд.', 'A vertical hydroponic tower for outdoors or indoors (with lights) where you plug in ready seedlings delivered by subscription. The app reminds you of care tasks.', 'Вертикальна башта
Розсада за підпискою
Для вулиці й дому', 'Vertical tower
Seedling subscription
Indoor and outdoor', 'Садівники на балконі.', 'Patio gardeners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lettucegrow.com' OR LOWER(`name`) = LOWER('Lettuce Grow')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'houseplants' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Lettuce Grow makes hydroponic Farmstands for indoors and patios with monthly seedling delivery.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A vertical hydroponic tower for outdoors or indoors (with lights) where you plug in ready seedlings delivered by subscription. The app reminds you of care tasks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Vertical tower
Seedling subscription
Indoor and outdoor', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Patio gardeners.', 'manual' FROM DUAL WHERE @new = 1;

-- Plantora — Домашні рослини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'plantora.app' OR LOWER(`name`) = LOWER('Plantora'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Plantora', NULL, 'https://plantora.app', NULL, NULL, 'Plantora — безкоштовний визначник рослин і застосунок для догляду: розпізнавання за фото, діагностика й нагадування.', 'Plantora is a free plant identifier and care app: photo ID, diagnosis and reminders.', 'Застосунок, що за фотографією визначає рослину, підказує причини проблем із листям і нагадує про полив і підживлення; позиціонується як повністю безкоштовний.', 'An app that identifies plants from a photo, suggests causes of leaf problems and reminds you to water and feed; positioned as completely free.', 'Визначення за фото
Діагностика
Нагадування
Безкоштовно', 'Photo ID
Diagnosis
Reminders
Free', 'Власники рослин.', 'Plant owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'plantora.app' OR LOWER(`name`) = LOWER('Plantora')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'houseplants' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Plantora is a free plant identifier and care app: photo ID, diagnosis and reminders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app that identifies plants from a photo, suggests causes of leaf problems and reminds you to water and feed; positioned as completely free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Photo ID
Diagnosis
Reminders
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Plant owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Rise Gardens — Домашні рослини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'risegardens.com' OR LOWER(`name`) = LOWER('Rise Gardens'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Rise Gardens', NULL, 'https://risegardens.com', NULL, NULL, 'Rise Gardens — модульні домашні гідропонні сади для овочів, фруктів і зелені з застосунком-наставником.', 'Rise Gardens makes modular indoor hydroponic gardens for vegetables, fruit and herbs with a coaching app.', 'Вертикальні гідропонні системи, що масштабуються поличками. Застосунок стежить за рівнем води, нагадує про поживні речовини й підказує, коли збирати врожай.', 'Vertical hydroponic systems that scale by shelves. The app tracks water level, reminds you about nutrients and tells you when to harvest.', 'Модульні полиці
Моніторинг води
Нагадування
Збір урожаю', 'Modular shelves
Water monitoring
Reminders
Harvest tips', 'Домашні садівники.', 'Home growers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'risegardens.com' OR LOWER(`name`) = LOWER('Rise Gardens')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'houseplants' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Rise Gardens makes modular indoor hydroponic gardens for vegetables, fruit and herbs with a coaching app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Vertical hydroponic systems that scale by shelves. The app tracks water level, reminds you about nutrients and tells you when to harvest.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Modular shelves
Water monitoring
Reminders
Harvest tips', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Home growers.', 'manual' FROM DUAL WHERE @new = 1;

-- Seek by iNaturalist — Домашні рослини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'inaturalist.org/pages/seek_app' OR LOWER(`name`) = LOWER('Seek by iNaturalist'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Seek by iNaturalist', NULL, 'https://www.inaturalist.org/pages/seek_app', NULL, NULL, 'Seek — безкоштовний застосунок від iNaturalist для визначення рослин і тварин камерою в реальному часі, без реєстрації.', 'Seek is iNaturalist''s free app to identify plants and animals live with your camera, no sign-up required.', 'Наводите камеру на рослину чи тварину — і застосунок поступово уточнює вид. Без облікового запису й зі збереженням приватності, з ігровими завданнями для дітей і сімей.', 'Point the camera at a plant or animal and the app progressively narrows down the species. No account, privacy-friendly, with challenges for kids and families.', 'Визначення камерою
Без реєстрації
Завдання для дітей', 'Live camera ID
No sign-up
Kids'' challenges', 'Сім''ї та діти.', 'Families and kids.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'inaturalist.org/pages/seek_app' OR LOWER(`name`) = LOWER('Seek by iNaturalist')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'houseplants' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Seek is iNaturalist''s free app to identify plants and animals live with your camera, no sign-up required.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Point the camera at a plant or animal and the app progressively narrows down the species. No account, privacy-friendly, with challenges for kids and families.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Live camera ID
No sign-up
Kids'' challenges', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families and kids.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- The Sill — Домашні рослини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thesill.com' OR LOWER(`name`) = LOWER('The Sill'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Sill', NULL, 'https://www.thesill.com', NULL, NULL, 'The Sill — доставка кімнатних і вуличних рослин, горщиків і аксесуарів з посібниками догляду й майстер-класами.', 'The Sill delivers indoor and outdoor plants, pots and accessories with care guides and workshops.', 'Американський магазин рослин для початківців і досвідчених: добірки за рівнем освітлення й складністю догляду, горщики, подарунки, підписка й освітній контент.', 'A US plant shop for beginners and pros: picks by light level and care difficulty, pots, gifts, a subscription and educational content.', 'Підбір за освітленням
Горшики
Підписка
Посібники', 'Picks by light
Pots
Subscription
Guides', 'Покупці рослин у США.', 'US plant shoppers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thesill.com' OR LOWER(`name`) = LOWER('The Sill')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'houseplants' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Sill delivers indoor and outdoor plants, pots and accessories with care guides and workshops.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A US plant shop for beginners and pros: picks by light level and care difficulty, pots, gifts, a subscription and educational content.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Picks by light
Pots
Subscription
Guides', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US plant shoppers.', 'manual' FROM DUAL WHERE @new = 1;

-- Vera by Bloomscape — Домашні рослини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bloomscape.com/vera' OR LOWER(`name`) = LOWER('Vera by Bloomscape'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Vera by Bloomscape', NULL, 'https://bloomscape.com/vera/', NULL, NULL, 'Vera — безкоштовний застосунок догляду за кімнатними рослинами від Bloomscape: нагадування про полив і підживлення, поради й журнал рослин.', 'Vera is Bloomscape''s free houseplant care app: watering and feeding reminders, tips and a plant journal.', 'Застосунок допомагає вести колекцію рослин: додаєте рослину, отримуєте персональні нагадування про полив, обприскування й підживлення, поради з догляду від експертів Bloomscape і журнал з фото росту.', 'The app helps manage your plant collection: add a plant and get personalized watering, misting and feeding reminders, care tips from Bloomscape experts and a photo growth journal.', 'Нагадування про полив
Поради експертів
Журнал рослин', 'Watering reminders
Expert tips
Plant journal', 'Власники кімнатних рослин.', 'Houseplant owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bloomscape.com/vera' OR LOWER(`name`) = LOWER('Vera by Bloomscape')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'houseplants' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Vera is Bloomscape''s free houseplant care app: watering and feeding reminders, tips and a plant journal.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app helps manage your plant collection: add a plant and get personalized watering, misting and feeding reminders, care tips from Bloomscape experts and a photo growth journal.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Watering reminders
Expert tips
Plant journal', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Houseplant owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- WaterBot — Домашні рослини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'waterbot.app' OR LOWER(`name`) = LOWER('WaterBot'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'WaterBot', NULL, 'https://waterbot.app', NULL, NULL, 'WaterBot — простий застосунок-нагадувач про полив кімнатних рослин з розкладом для кожної рослини.', 'WaterBot is a simple app reminding you to water houseplants with a schedule for each plant.', 'Додаєте рослини з фото, задаєте частоту поливу й отримуєте сповіщення; застосунок показує, що треба полити сьогодні, і веде історію догляду.', 'Add plants with photos, set watering frequency and get notifications; the app shows what needs water today and keeps a care history.', 'Розклад поливу
Сповіщення
Фото рослин', 'Watering schedule
Notifications
Plant photos', 'Власники кімнатних рослин.', 'Houseplant owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'waterbot.app' OR LOWER(`name`) = LOWER('WaterBot')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'houseplants' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'WaterBot is a simple app reminding you to water houseplants with a schedule for each plant.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Add plants with photos, set watering frequency and get notifications; the app shows what needs water today and keeps a care history.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Watering schedule
Notifications
Plant photos', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Houseplant owners.', 'manual' FROM DUAL WHERE @new = 1;

-- BBC Gardeners' World Magazine — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gardenersworld.com' OR LOWER(`name`) = LOWER('BBC Gardeners'' World Magazine'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BBC Gardeners'' World Magazine', NULL, 'https://www.gardenersworld.com', NULL, NULL, 'Gardeners'' World — сайт журналу BBC з порадами з садівництва, сезонними завданнями, енциклопедією рослин і проєктами.', 'Gardeners'' World is the BBC magazine site with gardening advice, seasonal jobs, a plant finder and projects.', 'Британське видання з практичними порадами, «що робити цього місяця», вирощуванням овочів, довідником рослин, оглядами інструментів і підпискою на журнал.', 'A British publication with practical advice, what-to-do-this-month guides, vegetable growing, a plant finder, tool reviews and a magazine subscription.', 'Сезонні завдання
Довідник рослин
Огляди інструментів', 'Seasonal jobs
Plant finder
Tool reviews', 'Садівники.', 'Gardeners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gardenersworld.com' OR LOWER(`name`) = LOWER('BBC Gardeners'' World Magazine')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Gardeners'' World is the BBC magazine site with gardening advice, seasonal jobs, a plant finder and projects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A British publication with practical advice, what-to-do-this-month guides, vegetable growing, a plant finder, tool reviews and a magazine subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Seasonal jobs
Plant finder
Tool reviews', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gardeners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bird Buddy — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mybirdbuddy.com' OR LOWER(`name`) = LOWER('Bird Buddy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bird Buddy', NULL, 'https://mybirdbuddy.com', NULL, NULL, 'Bird Buddy — розумна годівничка з камерою й AI, що фотографує птахів і визначає вид у застосунку.', 'Bird Buddy is a smart bird feeder with a camera and AI that photographs birds and identifies species in the app.', 'Годівничка з камерою, яка надсилає «листівки» з фото й відео відвідувачів, визначає понад тисячу видів птахів і веде колекцію спостережень; є версії для колібрі.', 'A camera feeder that sends postcards with photos and videos of visitors, identifies over a thousand bird species and keeps a collection; there are hummingbird versions.', 'Камера в годівничці
AI-визначення птахів
Колекція фото', 'Feeder camera
AI bird ID
Photo collection', 'Любителі птахів.', 'Bird lovers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mybirdbuddy.com' OR LOWER(`name`) = LOWER('Bird Buddy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Bird Buddy is a smart bird feeder with a camera and AI that photographs birds and identifies species in the app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A camera feeder that sends postcards with photos and videos of visitors, identifies over a thousand bird species and keeps a collection; there are hummingbird versions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Feeder camera
AI bird ID
Photo collection', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Bird lovers.', 'manual' FROM DUAL WHERE @new = 1;

-- GARDENA smart system — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gardena.com/int/products/smart-system' OR LOWER(`name`) = LOWER('GARDENA smart system'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GARDENA smart system', NULL, 'https://www.gardena.com/int/products/smart-system', NULL, NULL, 'GARDENA smart system — розумний полив, датчики ґрунту, роботи-косарки й розетки для саду з керуванням у застосунку.', 'GARDENA smart system offers smart watering, soil sensors, robotic mowers and plugs for the garden, controlled in an app.', 'Екосистема садових пристроїв GARDENA: контролери поливу, датчики вологості ґрунту, насоси, роботи-газонокосарки й розумні розетки, об''єднані шлюзом і застосунком.', 'GARDENA''s garden device ecosystem: watering controllers, soil moisture sensors, pumps, robotic mowers and smart plugs connected via a gateway and app.', 'Розумний полив
Датчики ґрунту
Роботи-косарки
Застосунок', 'Smart watering
Soil sensors
Robotic mowers
App', 'Садівники в Європі.', 'Gardeners in Europe.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gardena.com/int/products/smart-system' OR LOWER(`name`) = LOWER('GARDENA smart system')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'GARDENA smart system offers smart watering, soil sensors, robotic mowers and plugs for the garden, controlled in an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'GARDENA''s garden device ecosystem: watering controllers, soil moisture sensors, pumps, robotic mowers and smart plugs connected via a gateway and app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Smart watering
Soil sensors
Robotic mowers
App', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gardeners in Europe.', 'manual' FROM DUAL WHERE @new = 1;

-- Gardenia.net — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gardenia.net' OR LOWER(`name`) = LOWER('Gardenia.net'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Gardenia.net', NULL, 'https://www.gardenia.net', NULL, NULL, 'Gardenia — довідник рослин, садівництва й ландшафту з добірками рослин, ідеями садів і планами посадок.', 'Gardenia is a guide to plants, gardening and landscaping with plant collections, garden ideas and planting plans.', 'Сайт з тисячами описів рослин, фільтрами за умовами (тінь, посуха, зона морозостійкості), ідеями садових композицій і готовими планами клумб.', 'A site with thousands of plant profiles, filters by conditions (shade, drought, hardiness zone), garden design ideas and ready-made border plans.', 'Довідник рослин
Фільтри за умовами
Плани клумб', 'Plant guide
Condition filters
Border plans', 'Садівники.', 'Gardeners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gardenia.net' OR LOWER(`name`) = LOWER('Gardenia.net')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Gardenia is a guide to plants, gardening and landscaping with plant collections, garden ideas and planting plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site with thousands of plant profiles, filters by conditions (shade, drought, hardiness zone), garden design ideas and ready-made border plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Plant guide
Condition filters
Border plans', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gardeners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Husqvarna Automower — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'husqvarna.com/us/robotic-lawn-mowers' OR LOWER(`name`) = LOWER('Husqvarna Automower'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Husqvarna Automower', NULL, 'https://www.husqvarna.com/us/robotic-lawn-mowers/', NULL, NULL, 'Husqvarna Automower — роботи-газонокосарки з керуванням через Automower Connect: розклад, зони й GPS-трекінг.', 'Husqvarna Automower robotic mowers are controlled via Automower Connect: schedules, zones and GPS tracking.', 'Роботи-газонокосарки для ділянок різної площі, зокрема моделі без периметрального дроту (EPOS). Застосунок задає розклад і зони, показує положення робота й надсилає сповіщення про крадіжку.', 'Robotic mowers for lawns of various sizes, including wire-free EPOS models. The app sets schedules and zones, shows the mower''s location and sends theft alerts.', 'Роботи-косарки
Без дроту (EPOS)
GPS-трекінг
Зони', 'Robotic mowers
Wire-free (EPOS)
GPS tracking
Zones', 'Власники газонів.', 'Lawn owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'husqvarna.com/us/robotic-lawn-mowers' OR LOWER(`name`) = LOWER('Husqvarna Automower')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Husqvarna Automower robotic mowers are controlled via Automower Connect: schedules, zones and GPS tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Robotic mowers for lawns of various sizes, including wire-free EPOS models. The app sets schedules and zones, shows the mower''s location and sends theft alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Robotic mowers
Wire-free (EPOS)
GPS tracking
Zones', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Lawn owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Hydrawise — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hydrawise.com' OR LOWER(`name`) = LOWER('Hydrawise'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hydrawise', NULL, 'https://www.hydrawise.com', NULL, NULL, 'Hydrawise (Hunter) — хмарне керування Wi-Fi контролерами поливу з погодною оптимізацією та моніторингом.', 'Hydrawise (Hunter) offers cloud control of Wi-Fi irrigation controllers with weather optimization and monitoring.', 'Платформа Hunter Industries для контролерів поливу: прогнозне коригування за погодою, датчики витрати, сповіщення про протікання й віддалене керування для власників і підрядників.', 'Hunter Industries'' platform for irrigation controllers: predictive weather adjustments, flow sensors, leak alerts and remote control for owners and contractors.', 'Погодна оптимізація
Датчики витрати
Сповіщення про протікання', 'Weather optimization
Flow sensors
Leak alerts', 'Власники садів і підрядники.', 'Garden owners and contractors.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hydrawise.com' OR LOWER(`name`) = LOWER('Hydrawise')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Hydrawise (Hunter) offers cloud control of Wi-Fi irrigation controllers with weather optimization and monitoring.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hunter Industries'' platform for irrigation controllers: predictive weather adjustments, flow sensors, leak alerts and remote control for owners and contractors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Weather optimization
Flow sensors
Leak alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Garden owners and contractors.', 'manual' FROM DUAL WHERE @new = 1;

-- Lawn Love — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lawnlove.com' OR LOWER(`name`) = LOWER('Lawn Love'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lawn Love', NULL, 'https://lawnlove.com', NULL, NULL, 'Lawn Love — бронювання місцевих послуг з косіння й догляду за газоном онлайн із миттєвою ціною.', 'Lawn Love books local lawn mowing and care services online with instant pricing.', 'Американський сервіс: вводите адресу, отримуєте ціну за супутниковими знімками ділянки та бронюєте косіння, аерацію, прибирання листя й інші роботи з місцевими фахівцями.', 'A US service: enter your address, get a price from satellite imagery of your lawn and book mowing, aeration, leaf removal and other work with local pros.', 'Миттєва ціна
Косіння
Аерація
Місцеві фахівці', 'Instant pricing
Mowing
Aeration
Local pros', 'Власники будинків у США.', 'US homeowners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lawnlove.com' OR LOWER(`name`) = LOWER('Lawn Love')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Lawn Love books local lawn mowing and care services online with instant pricing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A US service: enter your address, get a price from satellite imagery of your lawn and book mowing, aeration, leaf removal and other work with local pros.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Instant pricing
Mowing
Aeration
Local pros', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- LawnStarter — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lawnstarter.com' OR LOWER(`name`) = LOWER('LawnStarter'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LawnStarter', NULL, 'https://www.lawnstarter.com', NULL, NULL, 'LawnStarter — замовлення косіння й догляду за газоном у США від 19 $ з онлайн-бронюванням і оплатою.', 'LawnStarter books US lawn mowing and care from $19 with online booking and payment.', 'Платформа для пошуку й оплати місцевих служб догляду за газоном: косіння, прибирання листя, аерація, ландшафтні роботи. Ціни відображаються одразу, оплата в застосунку.', 'A platform to find and pay local lawn services: mowing, leaf removal, aeration and landscaping. Prices show instantly and payment is in the app.', 'Косіння від 19 $
Онлайн-бронювання
Оплата в застосунку', 'Mowing from $19
Online booking
In-app payment', 'Власники будинків у США.', 'US homeowners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lawnstarter.com' OR LOWER(`name`) = LOWER('LawnStarter')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'LawnStarter books US lawn mowing and care from $19 with online booking and payment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform to find and pay local lawn services: mowing, leaf removal, aeration and landscaping. Prices show instantly and payment is in the app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Mowing from $19
Online booking
In-app payment', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US homeowners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Косіння', 'Mowing', 19.00, 'one_time', 'Від 19 $', 'From $19' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Косіння' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Mowing', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'From $19', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MAMMOTION — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mammotion.com' OR LOWER(`name`) = LOWER('MAMMOTION'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MAMMOTION', NULL, 'https://mammotion.com', NULL, NULL, 'MAMMOTION — повнопривідні роботи-газонокосарки LUBA і YUKA з RTK і баченням для великих і складних ділянок.', 'MAMMOTION makes all-wheel-drive LUBA and YUKA robotic mowers with RTK and vision for large, complex lawns.', 'Роботи без дроту для великих ділянок і схилів, з RTK-навігацією, камерами для уникнення перешкод і застосунком з картою, зонами та розкладом.', 'Wire-free robots for large lawns and slopes, with RTK navigation, cameras for obstacle avoidance and an app with map, zones and schedules.', 'Великі ділянки
Схили
RTK і камери
Застосунок', 'Large lawns
Slopes
RTK and cameras
App', 'Власники великих ділянок.', 'Owners of large lawns.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mammotion.com' OR LOWER(`name`) = LOWER('MAMMOTION')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'MAMMOTION makes all-wheel-drive LUBA and YUKA robotic mowers with RTK and vision for large, complex lawns.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Wire-free robots for large lawns and slopes, with RTK navigation, cameras for obstacle avoidance and an app with map, zones and schedules.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Large lawns
Slopes
RTK and cameras
App', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Owners of large lawns.', 'manual' FROM DUAL WHERE @new = 1;

-- Merlin Bird ID — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'merlin.allaboutbirds.org' OR LOWER(`name`) = LOWER('Merlin Bird ID'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Merlin Bird ID', NULL, 'https://merlin.allaboutbirds.org', NULL, NULL, 'Merlin Bird ID (Cornell Lab) — безкоштовне визначення птахів за звуком, фото чи відповідями на питання.', 'Merlin Bird ID (Cornell Lab) identifies birds free by sound, photo or by answering questions.', 'Застосунок Корнельської лабораторії орнітології визначає птахів у реальному часі за співом, за фото чи через майстер з кількох питань, працює офлайн з регіональними пакетами.', 'The Cornell Lab of Ornithology''s app identifies birds live by song, by photo or via a short question wizard, and works offline with regional packs.', 'Визначення за звуком
За фото
Офлайн-пакети
Безкоштовно', 'Sound ID
Photo ID
Offline packs
Free', 'Садівники й любителі птахів.', 'Gardeners and birders.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'merlin.allaboutbirds.org' OR LOWER(`name`) = LOWER('Merlin Bird ID')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Merlin Bird ID (Cornell Lab) identifies birds free by sound, photo or by answering questions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Cornell Lab of Ornithology''s app identifies birds live by song, by photo or via a short question wizard, and works offline with regional packs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sound ID
Photo ID
Offline packs
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gardeners and birders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Moasure — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moasure.com' OR LOWER(`name`) = LOWER('Moasure'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Moasure', NULL, 'https://www.moasure.com', NULL, NULL, 'Moasure — вимірювальний інструмент на основі руху: обміри ділянок, площ, периметрів і ухилів для ландшафтних проєктів.', 'Moasure is a motion-based measuring tool: measure plots, areas, perimeters and slopes for landscaping.', 'Пристрій, яким обходять ділянку, а застосунок будує план з площею, периметром, перепадами висот і кутами. Використовують ландшафтні дизайнери, будівельники й садівники.', 'A device you walk around a site with while the app builds a plan with area, perimeter, elevation changes and angles. Used by landscapers, builders and gardeners.', 'Обміри ходою
Площа й периметр
Перепади висот
План у застосунку', 'Walk-to-measure
Area and perimeter
Elevation
Plan in app', 'Ландшафтні дизайнери.', 'Landscapers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moasure.com' OR LOWER(`name`) = LOWER('Moasure')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Moasure is a motion-based measuring tool: measure plots, areas, perimeters and slopes for landscaping.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A device you walk around a site with while the app builds a plan with area, perimeter, elevation changes and angles. Used by landscapers, builders and gardeners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Walk-to-measure
Area and perimeter
Elevation
Plan in app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Landscapers.', 'manual' FROM DUAL WHERE @new = 1;

-- Orbit B-hyve — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bhyve.orbitonline.com' OR LOWER(`name`) = LOWER('Orbit B-hyve'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Orbit B-hyve', NULL, 'https://bhyve.orbitonline.com', NULL, NULL, 'B-hyve від Orbit — розумні Wi-Fi таймери поливу для зон і шлангів з погодними коригуваннями й керуванням із телефона.', 'Orbit B-hyve makes smart Wi-Fi watering timers for zones and hoses with weather adjustments and phone control.', 'Контролери поливу й шлангові таймери, що налаштовуються в застосунку, використовують дані погоди для коригування графіка й працюють з Alexa та Google.', 'Sprinkler controllers and hose timers set up in the app, using weather data to adjust schedules and working with Alexa and Google.', 'Wi-Fi таймери
Погодні коригування
Alexa й Google', 'Wi-Fi timers
Weather adjustments
Alexa and Google', 'Садівники.', 'Gardeners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bhyve.orbitonline.com' OR LOWER(`name`) = LOWER('Orbit B-hyve')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Orbit B-hyve makes smart Wi-Fi watering timers for zones and hoses with weather adjustments and phone control.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sprinkler controllers and hose timers set up in the app, using weather data to adjust schedules and working with Alexa and Google.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Wi-Fi timers
Weather adjustments
Alexa and Google', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gardeners.', 'manual' FROM DUAL WHERE @new = 1;

-- Picture Insect — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pictureinsect.com' OR LOWER(`name`) = LOWER('Picture Insect'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Picture Insect', NULL, 'https://pictureinsect.com', NULL, NULL, 'Picture Insect — визначник комах і павуків за фото з онлайн-енциклопедією, порадами щодо шкідників для саду.', 'Picture Insect identifies insects and spiders from photos with an online encyclopedia and garden pest advice.', 'Застосунок і сайт від розробників PictureThis: розпізнає комаху за фото, показує опис, чи є вона шкідником і як із нею боротися; Premium за підпискою.', 'An app and site from the PictureThis makers: identifies an insect from a photo, shows a description, whether it''s a pest and how to control it; Premium by subscription.', 'Визначення комах
Енциклопедія
Поради щодо шкідників', 'Insect ID
Encyclopedia
Pest advice', 'Садівники.', 'Gardeners.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pictureinsect.com' OR LOWER(`name`) = LOWER('Picture Insect')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Picture Insect identifies insects and spiders from photos with an online encyclopedia and garden pest advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app and site from the PictureThis makers: identifies an insect from a photo, shows a description, whether it''s a pest and how to control it; Premium by subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Insect ID
Encyclopedia
Pest advice', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gardeners.', 'manual' FROM DUAL WHERE @new = 1;

-- Rachio — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rachio.com' OR LOWER(`name`) = LOWER('Rachio'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Rachio', NULL, 'https://rachio.com', NULL, NULL, 'Rachio — розумні контролери поливу, що коригують графік за погодою й економлять воду.', 'Rachio makes smart irrigation controllers that adjust schedules to the weather and save water.', 'Wi-Fi-контролер замінює звичайний таймер поливу, враховує прогноз, опади й тип ґрунту та рослин у кожній зоні, пропускає полив перед дощем; також є розумні шлангові таймери.', 'A Wi-Fi controller replaces your sprinkler timer and accounts for forecast, rain and soil and plant type per zone, skipping watering before rain; smart hose timers are also available.', 'Погодний полив
Зони
Економія води
Шлангові таймери', 'Weather-based watering
Zones
Water savings
Hose timers', 'Власники газонів і садів.', 'Lawn and garden owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rachio.com' OR LOWER(`name`) = LOWER('Rachio')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Rachio makes smart irrigation controllers that adjust schedules to the weather and save water.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Wi-Fi controller replaces your sprinkler timer and accounts for forecast, rain and soil and plant type per zone, skipping watering before rain; smart hose timers are also available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Weather-based watering
Zones
Water savings
Hose timers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Lawn and garden owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Rain Bird — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rainbird.com' OR LOWER(`name`) = LOWER('Rain Bird'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Rain Bird', NULL, 'https://www.rainbird.com', NULL, NULL, 'Rain Bird — глобальна компанія систем зрошення: дощувачі, крапельний полив і Wi-Fi контролери з застосунком.', 'Rain Bird is a global irrigation company: sprinklers, drip irrigation and Wi-Fi controllers with an app.', 'Виробник обладнання для поливу дому, ландшафту й агросектору. Контролери з модулем LNK Wi-Fi керуються з застосунку, а погодні налаштування коригують полив.', 'A maker of irrigation equipment for homes, landscapes and agriculture. Controllers with the LNK Wi-Fi module are app-controlled, and weather settings adjust watering.', 'Дощувачі й крапельний полив
Wi-Fi контролери
Погодні налаштування', 'Sprinklers and drip
Wi-Fi controllers
Weather adjustments', 'Садівники й ландшафтники.', 'Gardeners and landscapers.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rainbird.com' OR LOWER(`name`) = LOWER('Rain Bird')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Rain Bird is a global irrigation company: sprinklers, drip irrigation and Wi-Fi controllers with an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A maker of irrigation equipment for homes, landscapes and agriculture. Controllers with the LNK Wi-Fi module are app-controlled, and weather settings adjust watering.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sprinklers and drip
Wi-Fi controllers
Weather adjustments', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gardeners and landscapers.', 'manual' FROM DUAL WHERE @new = 1;

-- RHS — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rhs.org.uk' OR LOWER(`name`) = LOWER('RHS'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'RHS', NULL, 'https://www.rhs.org.uk', NULL, NULL, 'Королівське садівниче товариство (RHS) — поради, довідник рослин, сади, шоу й членство; провідна садова благодійна організація Британії.', 'The Royal Horticultural Society (RHS) offers advice, a plant finder, gardens, shows and membership; the UK''s leading gardening charity.', 'Сайт RHS з детальними порадами з садівництва, базою рослин RHS Find a Plant, діагностикою проблем, інформацією про сади й шоу (зокрема Chelsea) та членством.', 'The RHS site with detailed gardening advice, the RHS Find a Plant database, problem diagnosis, information on gardens and shows (including Chelsea) and membership.', 'Поради експертів
RHS Find a Plant
Сади й шоу
Членство', 'Expert advice
RHS Find a Plant
Gardens and shows
Membership', 'Садівники.', 'Gardeners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rhs.org.uk' OR LOWER(`name`) = LOWER('RHS')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Royal Horticultural Society (RHS) offers advice, a plant finder, gardens, shows and membership; the UK''s leading gardening charity.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The RHS site with detailed gardening advice, the RHS Find a Plant database, problem diagnosis, information on gardens and shows (including Chelsea) and membership.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Expert advice
RHS Find a Plant
Gardens and shows
Membership', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Gardeners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Поради й довідник', 'Advice and plant finder' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Advice and plant finder', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Scotts — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scotts.com' OR LOWER(`name`) = LOWER('Scotts'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Scotts', NULL, 'https://scotts.com', NULL, NULL, 'Scotts (ScottsMiracle-Gro) — засоби догляду за газоном і план My Lawn з персональним графіком внесення добрив.', 'Scotts (ScottsMiracle-Gro) offers lawn care products and the My Lawn plan with a personalized feeding schedule.', 'Американський бренд добрив, насіння трави й засобів боротьби з бур''янами. Сайт і застосунок My Lawn підбирають продукти за регіоном і типом трави, складають сезонний план і нагадують про обробки.', 'A US brand of fertilizers, grass seed and weed control. The site and My Lawn app recommend products by region and grass type, build a seasonal plan and send treatment reminders.', 'Сезонний план газону
Підбір продуктів
Нагадування', 'Seasonal lawn plan
Product picks
Reminders', 'Власники газонів у США.', 'US lawn owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scotts.com' OR LOWER(`name`) = LOWER('Scotts')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Scotts (ScottsMiracle-Gro) offers lawn care products and the My Lawn plan with a personalized feeding schedule.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A US brand of fertilizers, grass seed and weed control. The site and My Lawn app recommend products by region and grass type, build a seasonal plan and send treatment reminders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Seasonal lawn plan
Product picks
Reminders', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US lawn owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Segway Navimow — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'navimow.segway.com' OR LOWER(`name`) = LOWER('Segway Navimow'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Segway Navimow', NULL, 'https://navimow.segway.com', NULL, NULL, 'Segway Navimow — роботи-газонокосарки без периметрального дроту з RTK-навігацією й керуванням у застосунку.', 'Segway Navimow makes wire-free robotic mowers with RTK navigation and app control.', 'Роботи використовують супутникове позиціонування RTK і камеру для точного косіння без дроту. Межі ділянки малюються в застосунку, де також задаються розклад і зони.', 'The robots use RTK satellite positioning and a camera for precise wire-free mowing. Boundaries are drawn in the app, which also sets schedules and zones.', 'Без дроту
RTK-навігація
Межі в застосунку', 'Wire-free
RTK navigation
In-app boundaries', 'Власники газонів.', 'Lawn owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'navimow.segway.com' OR LOWER(`name`) = LOWER('Segway Navimow')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Segway Navimow makes wire-free robotic mowers with RTK navigation and app control.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The robots use RTK satellite positioning and a camera for precise wire-free mowing. Boundaries are drawn in the app, which also sets schedules and zones.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Wire-free
RTK navigation
In-app boundaries', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Lawn owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Sunday Lawn Care — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getsunday.com' OR LOWER(`name`) = LOWER('Sunday Lawn Care'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sunday Lawn Care', NULL, 'https://www.getsunday.com', NULL, NULL, 'Sunday — персоналізовані набори для догляду за газоном і садом за аналізом ґрунту та кліматом ділянки з доставкою.', 'Sunday sends personalized lawn and garden care kits based on soil testing and your local climate.', 'Сервіс аналізує ґрунт і погоду за адресою, підбирає добрива й засоби в зручних флаконах для шланга й надсилає їх за сезонним планом.', 'The service analyzes soil and weather for your address, picks fertilizers and treatments in easy hose-end packs and ships them on a seasonal plan.', 'Аналіз ґрунту
Персональний план
Доставка', 'Soil analysis
Personal plan
Delivery', 'Власники газонів у США.', 'US lawn owners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getsunday.com' OR LOWER(`name`) = LOWER('Sunday Lawn Care')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sunday sends personalized lawn and garden care kits based on soil testing and your local climate.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The service analyzes soil and weather for your address, picks fertilizers and treatments in easy hose-end packs and ships them on a seasonal plan.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Soil analysis
Personal plan
Delivery', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US lawn owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Worx Landroid — Сад
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'worx.com/landroid-robotic-lawn-mower' OR LOWER(`name`) = LOWER('Worx Landroid'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Worx Landroid', NULL, 'https://www.worx.com/landroid-robotic-lawn-mower', NULL, NULL, 'Worx Landroid — роботи-газонокосарки з Wi-Fi та застосунком: розклад, AI-уникнення перешкод і моделі без дроту.', 'Worx Landroid robotic mowers with Wi-Fi and an app: schedules, AI obstacle avoidance and wire-free models.', 'Лінійка роботів-косарок від Worx. Застосунок дозволяє задавати розклад і зони, а модулі розширення додають уникнення перешкод і GPS; новіші моделі працюють без периметрального дроту.', 'Worx''s robotic mower line. The app sets schedules and zones, add-on modules provide obstacle avoidance and GPS, and newer models work without a boundary wire.', 'Розклад і зони
Уникнення перешкод
Без дроту
Застосунок', 'Schedules and zones
Obstacle avoidance
Wire-free
App', 'Власники газонів.', 'Lawn owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'worx.com/landroid-robotic-lawn-mower' OR LOWER(`name`) = LOWER('Worx Landroid')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Worx Landroid robotic mowers with Wi-Fi and an app: schedules, AI obstacle avoidance and wire-free models.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Worx''s robotic mower line. The app sets schedules and zones, add-on modules provide obstacle avoidance and GPS, and newer models work without a boundary wire.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Schedules and zones
Obstacle avoidance
Wire-free
App', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Lawn owners.', 'manual' FROM DUAL WHERE @new = 1;

-- AGROHUB — Город
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'agrohub.ua' OR LOWER(`name`) = LOWER('AGROHUB'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AGROHUB', NULL, 'https://agrohub.ua', NULL, NULL, 'AGROHUB — українська платформа агроінновацій: стартапи, сервіси й події для аграріїв.', 'AGROHUB is a Ukrainian agri-innovation platform: startups, services and events for farmers.', 'Екосистема, що об''єднує аграріїв, агротех-стартапи й інвесторів в Україні: каталог рішень, освітні програми, події й консультації з впровадження технологій.', 'An ecosystem linking farmers, agritech startups and investors in Ukraine: a solutions catalog, education programs, events and technology adoption advice.', 'Каталог агротех-рішень
Події
Освіта', 'Agritech catalog
Events
Education', 'Українські аграрії.', 'Ukrainian farmers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'agrohub.ua' OR LOWER(`name`) = LOWER('AGROHUB')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'kitchen-garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AGROHUB is a Ukrainian agri-innovation platform: startups, services and events for farmers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An ecosystem linking farmers, agritech startups and investors in Ukraine: a solutions catalog, education programs, events and technology adoption advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Agritech catalog
Events
Education', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Ukrainian farmers.', 'manual' FROM DUAL WHERE @new = 1;

-- Bonnie Plants — Город
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bonnieplants.com' OR LOWER(`name`) = LOWER('Bonnie Plants'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bonnie Plants', NULL, 'https://bonnieplants.com', NULL, NULL, 'Bonnie Plants — розсада овочів і зелені для домашніх городів у США з гідами з вирощування.', 'Bonnie Plants sells vegetable and herb plants for US home gardens with growing guides.', 'Американський виробник розсади, що продається в садових центрах і онлайн; сайт містить детальні гіди з вирощування кожної культури та поради для початківців.', 'A US plant grower sold in garden centers and online; the site has detailed growing guides for each crop and beginner tips.', 'Розсада
Гіди з вирощування
Поради', 'Plants
Growing guides
Tips', 'Городники в США.', 'US gardeners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bonnieplants.com' OR LOWER(`name`) = LOWER('Bonnie Plants')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'kitchen-garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Bonnie Plants sells vegetable and herb plants for US home gardens with growing guides.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A US plant grower sold in garden centers and online; the site has detailed growing guides for each crop and beginner tips.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Plants
Growing guides
Tips', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US gardeners.', 'manual' FROM DUAL WHERE @new = 1;

-- Burpee — Город
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'burpee.com' OR LOWER(`name`) = LOWER('Burpee'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Burpee', NULL, 'https://www.burpee.com', NULL, NULL, 'Burpee — насіння й розсада овочів, зелені та квітів для домашнього городу з порадами з вирощування.', 'Burpee sells vegetable, herb and flower seeds and plants for home gardens with growing advice.', 'Один з найстаріших американських брендів насіння з онлайн-магазином сортів, розсадою, садовими приладдям і навчальними статтями.', 'One of America''s oldest seed brands with an online store of varieties, plants, garden supplies and how-to articles.', 'Насіння й розсада
Поради
Садове приладдя', 'Seeds and plants
Advice
Supplies', 'Городники.', 'Home gardeners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'burpee.com' OR LOWER(`name`) = LOWER('Burpee')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'kitchen-garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Burpee sells vegetable, herb and flower seeds and plants for home gardens with growing advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'One of America''s oldest seed brands with an online store of varieties, plants, garden supplies and how-to articles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Seeds and plants
Advice
Supplies', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Home gardeners.', 'manual' FROM DUAL WHERE @new = 1;

-- Farmonaut — Город
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'farmonaut.com' OR LOWER(`name`) = LOWER('Farmonaut'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Farmonaut', NULL, 'https://farmonaut.com', NULL, NULL, 'Farmonaut — супутниковий моніторинг посівів: індекси вегетації, вологість ґрунту й AI-рекомендації.', 'Farmonaut offers satellite crop monitoring: vegetation indices, soil moisture and AI advice.', 'Платформа, що за супутниковими знімками розраховує NDVI та інші індекси, показує стрес рослин і вологість, надсилає AI-поради для фермерів і агрономів.', 'A platform computing NDVI and other indices from satellite imagery, showing plant stress and moisture and sending AI advice to farmers and agronomists.', 'Супутникові знімки
NDVI
Вологість ґрунту
AI-поради', 'Satellite imagery
NDVI
Soil moisture
AI advice', 'Фермери.', 'Farmers.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'farmonaut.com' OR LOWER(`name`) = LOWER('Farmonaut')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'kitchen-garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Farmonaut offers satellite crop monitoring: vegetation indices, soil moisture and AI advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform computing NDVI and other indices from satellite imagery, showing plant stress and moisture and sending AI advice to farmers and agronomists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Satellite imagery
NDVI
Soil moisture
AI advice', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Farmers.', 'manual' FROM DUAL WHERE @new = 1;

-- From Seed to Spoon — Город
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'seedtospoon.net' OR LOWER(`name`) = LOWER('From Seed to Spoon'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'From Seed to Spoon', NULL, 'https://www.seedtospoon.net', NULL, NULL, 'From Seed to Spoon — застосунок-планувальник городу: календар посадок за місцем, нагадування й поради щодо сусідства рослин.', 'From Seed to Spoon is a vegetable garden planner app: location-based planting calendar, reminders and companion advice.', 'Визначає дати посадок за вашими датами заморозків, нагадує про посів, полив і збір, дає довідку з понад сотні культур і рецепти з урожаю.', 'It sets planting dates from your frost dates, reminds you to sow, water and harvest, offers info on 100+ crops and recipes from your harvest.', 'Календар за заморозками
Нагадування
Довідка з культур', 'Frost-date calendar
Reminders
Crop info', 'Городники-початківці.', 'Beginner gardeners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'seedtospoon.net' OR LOWER(`name`) = LOWER('From Seed to Spoon')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'kitchen-garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'From Seed to Spoon is a vegetable garden planner app: location-based planting calendar, reminders and companion advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It sets planting dates from your frost dates, reminds you to sow, water and harvest, offers info on 100+ crops and recipes from your harvest.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Frost-date calendar
Reminders
Crop info', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner gardeners.', 'manual' FROM DUAL WHERE @new = 1;

-- Gardenate — Город
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gardenate.com' OR LOWER(`name`) = LOWER('Gardenate'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Gardenate', NULL, 'https://www.gardenate.com', NULL, NULL, 'Gardenate — гід з посадок і нагадування для городу за кліматичною зоною: що сіяти цього місяця.', 'Gardenate is a planting guide with reminders for your kitchen garden by climate zone: what to plant this month.', 'Сайт і застосунок, що показують, які овочі й зелень сіяти цього місяця у вашій кліматичній зоні, з порадами з вирощування та нагадуваннями поштою.', 'A site and app showing which vegetables and herbs to sow this month in your climate zone, with growing tips and email reminders.', 'Що сіяти зараз
Кліматичні зони
Нагадування', 'What to plant now
Climate zones
Reminders', 'Городники.', 'Vegetable gardeners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gardenate.com' OR LOWER(`name`) = LOWER('Gardenate')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'kitchen-garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Gardenate is a planting guide with reminders for your kitchen garden by climate zone: what to plant this month.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site and app showing which vegetables and herbs to sow this month in your climate zone, with growing tips and email reminders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'What to plant now
Climate zones
Reminders', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Vegetable gardeners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- GardenManager — Город
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gardenmanager.app' OR LOWER(`name`) = LOWER('GardenManager'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'GardenManager', NULL, 'https://gardenmanager.app', NULL, NULL, 'GardenManager — розумний менеджер городу: план грядок, календар посівів, сумісність рослин і журнал врожаю.', 'GardenManager is a smart vegetable garden manager: bed plans, sowing calendar, companion planting and harvest log.', 'Застосунок для планування грядок і сівозміни, підказок щодо сусідства культур, нагадувань про посів і пересадку та обліку врожаю.', 'An app for planning beds and crop rotation, companion planting hints, sowing and transplant reminders and harvest tracking.', 'План грядок
Сівозміна
Календар посівів', 'Bed plans
Crop rotation
Sowing calendar', 'Городники.', 'Vegetable gardeners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gardenmanager.app' OR LOWER(`name`) = LOWER('GardenManager')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'kitchen-garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'GardenManager is a smart vegetable garden manager: bed plans, sowing calendar, companion planting and harvest log.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app for planning beds and crop rotation, companion planting hints, sowing and transplant reminders and harvest tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Bed plans
Crop rotation
Sowing calendar', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Vegetable gardeners.', 'manual' FROM DUAL WHERE @new = 1;

-- Johnny's Selected Seeds — Город
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'johnnyseeds.com' OR LOWER(`name`) = LOWER('Johnny''s Selected Seeds'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Johnny''s Selected Seeds', NULL, 'https://www.johnnyseeds.com', NULL, NULL, 'Johnny''s Selected Seeds — насіння, інструменти й калькулятори для фермерів і городників з 1973 року.', 'Johnny''s Selected Seeds offers seeds, tools and calculators for farmers and gardeners since 1973.', 'Американський постачальник насіння овочів, квітів і зелені з детальними характеристиками сортів, інструментами та корисними калькуляторами (норми висіву, графіки посівів).', 'A US supplier of vegetable, flower and herb seeds with detailed variety data, tools and handy calculators (seeding rates, planting schedules).', 'Насіння
Калькулятори посівів
Інструменти', 'Seeds
Planting calculators
Tools', 'Фермери й городники.', 'Farmers and gardeners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'johnnyseeds.com' OR LOWER(`name`) = LOWER('Johnny''s Selected Seeds')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'kitchen-garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Johnny''s Selected Seeds offers seeds, tools and calculators for farmers and gardeners since 1973.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A US supplier of vegetable, flower and herb seeds with detailed variety data, tools and handy calculators (seeding rates, planting schedules).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Seeds
Planting calculators
Tools', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Farmers and gardeners.', 'manual' FROM DUAL WHERE @new = 1;

-- Plantix — Город
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'plantix.net' OR LOWER(`name`) = LOWER('Plantix'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Plantix', NULL, 'https://plantix.net', NULL, NULL, 'Plantix — безкоштовний застосунок діагностики хвороб культур за фото з рекомендаціями лікування.', 'Plantix is a free app to diagnose crop diseases from photos with treatment advice.', 'Застосунок розпізнає сотні хвороб, шкідників і дефіцитів поживних речовин для десятків культур, радить заходи та має спільноту агрономів і фермерів.', 'The app recognizes hundreds of diseases, pests and nutrient deficiencies across dozens of crops, recommends measures and has a community of agronomists and farmers.', 'Діагностика за фото
Десятки культур
Спільнота', 'Photo diagnosis
Dozens of crops
Community', 'Фермери й городники.', 'Farmers and gardeners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'plantix.net' OR LOWER(`name`) = LOWER('Plantix')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'kitchen-garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Plantix is a free app to diagnose crop diseases from photos with treatment advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app recognizes hundreds of diseases, pests and nutrient deficiencies across dozens of crops, recommends measures and has a community of agronomists and farmers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Photo diagnosis
Dozens of crops
Community', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Farmers and gardeners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Seed Savers Exchange — Город
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'seedsavers.org' OR LOWER(`name`) = LOWER('Seed Savers Exchange'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Seed Savers Exchange', NULL, 'https://seedsavers.org', NULL, NULL, 'Seed Savers Exchange — некомерційний банк і магазин сортового насіння старовинних сортів з обміном між садівниками.', 'Seed Savers Exchange is a nonprofit seed bank and shop of heirloom varieties with gardener-to-gardener exchange.', 'Організація, що зберігає тисячі старовинних сортів овочів, продає насіння, веде обмін насінням між членами й навчає збереженню насіння.', 'An organization preserving thousands of heirloom vegetable varieties, selling seed, running a member seed exchange and teaching seed saving.', 'Старовинні сорти
Обмін насінням
Навчання', 'Heirloom varieties
Seed exchange
Education', 'Городники.', 'Vegetable gardeners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'seedsavers.org' OR LOWER(`name`) = LOWER('Seed Savers Exchange')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'kitchen-garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Seed Savers Exchange is a nonprofit seed bank and shop of heirloom varieties with gardener-to-gardener exchange.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An organization preserving thousands of heirloom vegetable varieties, selling seed, running a member seed exchange and teaching seed saving.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Heirloom varieties
Seed exchange
Education', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Vegetable gardeners.', 'manual' FROM DUAL WHERE @new = 1;

-- Tend — Город
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tend.com' OR LOWER(`name`) = LOWER('Tend'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tend', NULL, 'https://www.tend.com', NULL, NULL, 'Tend — ПЗ для малих ферм: планування посівів, облік урожаю, продажі та сертифікація.', 'Tend is software for small farms: crop planning, harvest records, sales and certification.', 'Платформа для овочевих і різнопрофільних ферм: план посівів, завдання, облік урожаю, продаж через CSA й онлайн-магазин та документи для органічної сертифікації.', 'A platform for vegetable and diversified farms: planting plans, tasks, harvest records, CSA and online store sales and records for organic certification.', 'План посівів
Облік урожаю
Продажі
Сертифікація', 'Crop planning
Harvest records
Sales
Certification', 'Малі фермери.', 'Small farmers.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tend.com' OR LOWER(`name`) = LOWER('Tend')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'kitchen-garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tend is software for small farms: crop planning, harvest records, sales and certification.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform for vegetable and diversified farms: planting plans, tasks, harvest records, CSA and online store sales and records for organic certification.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Crop planning
Harvest records
Sales
Certification', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Small farmers.', 'manual' FROM DUAL WHERE @new = 1;

-- The Old Farmer's Almanac — Город
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'almanac.com' OR LOWER(`name`) = LOWER('The Old Farmer''s Almanac'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Old Farmer''s Almanac', NULL, 'https://www.almanac.com', NULL, NULL, 'Old Farmer''s Almanac — садівництво, погода, фази Місяця й календар посадок; онлайн-планувальник городу.', 'The Old Farmer''s Almanac covers gardening, weather, Moon phases and planting calendars, plus an online garden planner.', 'Американське видання з багаторічною історією: календарі посадок за датами заморозків, гіди з вирощування овочів, довгострокові прогнози погоди й інформація про фази Місяця.', 'A long-running American publication: planting calendars by frost dates, vegetable growing guides, long-range weather forecasts and Moon phase information.', 'Календар посадок
Дати заморозків
Гіди з овочів
Прогнози', 'Planting calendar
Frost dates
Vegetable guides
Forecasts', 'Городники.', 'Vegetable gardeners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'almanac.com' OR LOWER(`name`) = LOWER('The Old Farmer''s Almanac')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'kitchen-garden' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Old Farmer''s Almanac covers gardening, weather, Moon phases and planting calendars, plus an online garden planner.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A long-running American publication: planting calendars by frost dates, vegetable growing guides, long-range weather forecasts and Moon phase information.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Planting calendar
Frost dates
Vegetable guides
Forecasts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Vegetable gardeners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- 11pets — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '11pets.com' OR LOWER(`name`) = LOWER('11pets'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT '11pets', NULL, 'https://www.11pets.com', NULL, NULL, '11pets — застосунок для догляду за тваринами: медична картка, вакцинації, нагадування й витрати.', '11pets is a pet care app: health records, vaccinations, reminders and expenses.', 'Дозволяє вести профілі тварин із щепленнями, ліками, візитами до ветеринара, вагою, документами й витратами, отримувати нагадування та ділитися даними з родиною чи ветеринаром.', 'Keep pet profiles with vaccinations, medications, vet visits, weight, documents and expenses, get reminders and share data with family or your vet.', 'Медична картка
Нагадування
Облік витрат', 'Health record
Reminders
Expense tracking', 'Власники тварин.', 'Pet owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = '11pets.com' OR LOWER(`name`) = LOWER('11pets')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', '11pets is a pet care app: health records, vaccinations, reminders and expenses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Keep pet profiles with vaccinations, medications, vet visits, weight, documents and expenses, get reminders and share data with family or your vet.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Health record
Reminders
Expense tracking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Pet owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базова версія', 'Basic version' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic version', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Adopt-a-Pet — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'adoptapet.com' OR LOWER(`name`) = LOWER('Adopt-a-Pet'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Adopt-a-Pet', NULL, 'https://www.adoptapet.com', NULL, NULL, 'Adopt-a-Pet — пошук собак, котів та інших тварин для усиновлення з притулків США.', 'Adopt-a-Pet searches dogs, cats and other pets for adoption from US shelters.', 'Некомерційна платформа, що об''єднує тисячі притулків і рятувальних організацій. Пошук за видом, породою, віком і розташуванням, сповіщення та сервіс Rehome для передачі тварини.', 'A nonprofit platform uniting thousands of shelters and rescues. Search by species, breed, age and location, with alerts and the Rehome service for rehoming a pet.', 'Тисячі притулків
Фільтри пошуку
Сповіщення
Rehome', 'Thousands of shelters
Search filters
Alerts
Rehome', 'Ті, хто хоче взяти тварину.', 'People adopting a pet.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'adoptapet.com' OR LOWER(`name`) = LOWER('Adopt-a-Pet')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Adopt-a-Pet searches dogs, cats and other pets for adoption from US shelters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A nonprofit platform uniting thousands of shelters and rescues. Search by species, breed, age and location, with alerts and the Rehome service for rehoming a pet.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Thousands of shelters
Search filters
Alerts
Rehome', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People adopting a pet.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- BarkBox — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bark.co' OR LOWER(`name`) = LOWER('BarkBox'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BarkBox', NULL, 'https://bark.co', NULL, NULL, 'BARK (BarkBox) — щомісячні тематичні коробки з іграшками й ласощами для собак за підпискою.', 'BARK (BarkBox) delivers monthly themed boxes of dog toys and treats by subscription.', 'Підписковий сервіс для собак з коробками BarkBox і Super Chewer для активних гризунів, а також ласощами, кормом і аксесуарами. Підбирає вміст за розміром собаки й алергіями.', 'A dog subscription service with BarkBox and Super Chewer boxes for heavy chewers, plus treats, food and accessories. Contents are tailored to dog size and allergies.', 'Щомісячні коробки
Іграшки й ласощі
Підбір за розміром', 'Monthly boxes
Toys and treats
Size-based picks', 'Власники собак у США.', 'US dog owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bark.co' OR LOWER(`name`) = LOWER('BarkBox')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'BARK (BarkBox) delivers monthly themed boxes of dog toys and treats by subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A dog subscription service with BarkBox and Super Chewer boxes for heavy chewers, plus treats, food and accessories. Contents are tailored to dog size and allergies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Monthly boxes
Toys and treats
Size-based picks', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US dog owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Embark — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'embarkvet.com' OR LOWER(`name`) = LOWER('Embark'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Embark', NULL, 'https://embarkvet.com', NULL, NULL, 'Embark — ДНК-тест для собак: породи, понад 200 генетичних ризиків здоров''я, риси й родичі.', 'Embark is a dog DNA test: breeds, 200+ genetic health risks, traits and relatives.', 'Тест, розроблений разом з Корнельським університетом ветеринарної медицини: визначає породи, перевіряє на сотні генетичних станів, прогнозує розмір і показує собак-родичів.', 'A test developed with Cornell''s College of Veterinary Medicine: identifies breeds, screens hundreds of genetic conditions, predicts size and shows dog relatives.', 'Породи
200+ генетичних ризиків
Собаки-родичі', 'Breeds
200+ genetic risks
Dog relatives', 'Власники собак.', 'Dog owners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'embarkvet.com' OR LOWER(`name`) = LOWER('Embark')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Embark is a dog DNA test: breeds, 200+ genetic health risks, traits and relatives.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A test developed with Cornell''s College of Veterinary Medicine: identifies breeds, screens hundreds of genetic conditions, predicts size and shows dog relatives.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Breeds
200+ genetic risks
Dog relatives', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dog owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Furbo — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'furbo.com' OR LOWER(`name`) = LOWER('Furbo'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Furbo', NULL, 'https://furbo.com', NULL, NULL, 'Furbo — інтерактивні камери для собак і котів з метанням ласощів, двостороннім звуком і AI-сповіщеннями.', 'Furbo makes interactive dog and cat cameras with treat tossing, two-way audio and AI alerts.', 'Камера з ширококутним об''єктивом і нічним баченням, через яку власник бачить улюбленця, говорить з ним і кидає ласощі. Підписка Furbo Nanny додає сповіщення про гавкіт, людей і небезпеку.', 'A wide-angle camera with night vision through which owners see their pet, talk and toss treats. The Furbo Nanny subscription adds barking, person and emergency alerts.', 'Метання ласощів
Двосторонній звук
AI-сповіщення', 'Treat tossing
Two-way audio
AI alerts', 'Власники собак і котів.', 'Dog and cat owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'furbo.com' OR LOWER(`name`) = LOWER('Furbo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Furbo makes interactive dog and cat cameras with treat tossing, two-way audio and AI alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A wide-angle camera with night vision through which owners see their pet, talk and toss treats. The Furbo Nanny subscription adds barking, person and emergency alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Treat tossing
Two-way audio
AI alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dog and cat owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Halo Collar — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'halocollar.com' OR LOWER(`name`) = LOWER('Halo Collar'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Halo Collar', NULL, 'https://www.halocollar.com', NULL, NULL, 'Halo Collar — GPS-нашийник для собак з бездротовим віртуальним парканом, трекінгом і програмою дресирування.', 'Halo Collar is a GPS dog collar with a wireless virtual fence, tracking and a training program.', 'Розумний нашийник, де межі «паркану» малюються в застосунку на карті. Повідомляє власника, якщо собака виходить, відстежує активність і місцезнаходження; включає програму тренування за методикою Сезара Міллана.', 'A smart collar where fence boundaries are drawn on a map in the app. It alerts you if the dog leaves, tracks activity and location and includes a Cesar Millan training program.', 'Віртуальний паркан
GPS-трекінг
Програма дресирування', 'Virtual fence
GPS tracking
Training program', 'Власники собак.', 'Dog owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'halocollar.com' OR LOWER(`name`) = LOWER('Halo Collar')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Halo Collar is a GPS dog collar with a wireless virtual fence, tracking and a training program.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A smart collar where fence boundaries are drawn on a map in the app. It alerts you if the dog leaves, tracks activity and location and includes a Cesar Millan training program.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Virtual fence
GPS tracking
Training program', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dog owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Lemonade Pet — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lemonade.com/pet' OR LOWER(`name`) = LOWER('Lemonade Pet'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lemonade Pet', NULL, 'https://www.lemonade.com/pet', NULL, NULL, 'Lemonade Pet — страхування собак і котів з оформленням і врегулюванням претензій у застосунку.', 'Lemonade Pet insures dogs and cats with sign-up and claims handled in the app.', 'Цифрове страхування тварин у США та Європі: поліс за хвилини, AI-обробка претензій, опції для профілактики, ветеринарної телемедицини й лікування.', 'Digital pet insurance in the US and Europe: a policy in minutes, AI claims handling and add-ons for wellness, vet telehealth and treatment.', 'Поліс за хвилини
AI-претензії
Опції профілактики', 'Policy in minutes
AI claims
Wellness add-ons', 'Власники тварин.', 'Pet owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lemonade.com/pet' OR LOWER(`name`) = LOWER('Lemonade Pet')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Lemonade Pet insures dogs and cats with sign-up and claims handled in the app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Digital pet insurance in the US and Europe: a policy in minutes, AI claims handling and add-ons for wellness, vet telehealth and treatment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Policy in minutes
AI claims
Wellness add-ons', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Pet owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Litter-Robot — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'litter-robot.com' OR LOWER(`name`) = LOWER('Litter-Robot'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Litter-Robot', NULL, 'https://www.litter-robot.com', NULL, NULL, 'Litter-Robot (Whisker) — самоочисні котячі туалети з застосунком, що стежить за вагою й звичками кота.', 'Litter-Robot (Whisker) makes self-cleaning litter boxes with an app tracking cat weight and habits.', 'Автоматичний лоток, що просіює наповнювач після кожного візиту. Застосунок Whisker показує рівень заповнення, відвідування, вагу кота й попереджає про зміни, які можуть вказувати на проблеми зі здоров''ям.', 'An automatic box that sifts litter after each visit. The Whisker app shows waste drawer level, visits and cat weight and flags changes that may signal health issues.', 'Самоочищення
Вага кота
Історія відвідувань', 'Self-cleaning
Cat weight
Visit history', 'Власники котів.', 'Cat owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'litter-robot.com' OR LOWER(`name`) = LOWER('Litter-Robot')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Litter-Robot (Whisker) makes self-cleaning litter boxes with an app tracking cat weight and habits.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An automatic box that sifts litter after each visit. The Whisker app shows waste drawer level, visits and cat weight and flags changes that may signal health issues.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Self-cleaning
Cat weight
Visit history', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Cat owners.', 'manual' FROM DUAL WHERE @new = 1;

-- MasterZoo — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'masterzoo.ua' OR LOWER(`name`) = LOWER('MasterZoo'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MasterZoo', NULL, 'https://masterzoo.ua', NULL, NULL, 'MasterZoo — українська мережа зоомагазинів з онлайн-каталогом кормів і товарів для тварин, доставкою та бонусною програмою.', 'MasterZoo is a Ukrainian pet store chain with an online catalog of food and supplies, delivery and a bonus program.', 'Мережа зоомагазинів по Україні з інтернет-магазином і застосунком: корми, ветаптека, аксесуари для собак, котів, птахів, гризунів і риб, доставка, самовивіз і програма лояльності.', 'A pet store chain across Ukraine with an online store and app: food, vet pharmacy and accessories for dogs, cats, birds, rodents and fish, delivery, pickup and a loyalty program.', 'Корми й аксесуари
Ветаптека
Доставка
Бонуси', 'Food and accessories
Vet pharmacy
Delivery
Bonuses', 'Власники тварин в Україні.', 'Pet owners in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'masterzoo.ua' OR LOWER(`name`) = LOWER('MasterZoo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'MasterZoo is a Ukrainian pet store chain with an online catalog of food and supplies, delivery and a bonus program.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A pet store chain across Ukraine with an online store and app: food, vet pharmacy and accessories for dogs, cats, birds, rodents and fish, delivery, pickup and a loyalty program.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Food and accessories
Vet pharmacy
Delivery
Bonuses', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Pet owners in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;

-- Ollie — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myollie.com' OR LOWER(`name`) = LOWER('Ollie'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ollie', NULL, 'https://www.myollie.com', NULL, NULL, 'Ollie — доставка свіжого корму людського рівня для собак з персональним планом порцій.', 'Ollie delivers fresh human-grade dog food with a personalized portion plan.', 'Сервіс готує свіжі, запечені й комбіновані рецепти, розраховує порції за вагою, віком і активністю собаки та доставляє за підпискою; має панель відстеження здоров''я.', 'The service makes fresh, baked and mixed recipes, calculates portions by weight, age and activity and delivers by subscription; it has a health tracking dashboard.', 'Свіжий корм
Персональні порції
Підписка', 'Fresh food
Personal portions
Subscription', 'Власники собак у США.', 'US dog owners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'myollie.com' OR LOWER(`name`) = LOWER('Ollie')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ollie delivers fresh human-grade dog food with a personalized portion plan.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The service makes fresh, baked and mixed recipes, calculates portions by weight, age and activity and delivers by subscription; it has a health tracking dashboard.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Fresh food
Personal portions
Subscription', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US dog owners.', 'manual' FROM DUAL WHERE @new = 1;

-- PawBoost — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pawboost.com' OR LOWER(`name`) = LOWER('PawBoost'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PawBoost', NULL, 'https://www.pawboost.com', NULL, NULL, 'PawBoost — база загублених і знайдених тварин з розсилкою сповіщень і публікаціями в місцевих групах.', 'PawBoost is a lost and found pets database with alert emails and posts in local groups.', 'Власник публікує оголошення про загублену чи знайдену тварину, а сервіс розсилає його місцевим підписникам і публікує в локальних спільнотах у соцмережах; платні опції збільшують охоплення.', 'Owners post lost or found pets, and the service emails local subscribers and posts in local social media groups; paid options increase reach.', 'Оголошення про загублених
Місцеві сповіщення
Соцмережі', 'Lost pet posts
Local alerts
Social media', 'Власники тварин.', 'Pet owners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pawboost.com' OR LOWER(`name`) = LOWER('PawBoost')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'PawBoost is a lost and found pets database with alert emails and posts in local groups.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Owners post lost or found pets, and the service emails local subscribers and posts in local social media groups; paid options increase reach.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Lost pet posts
Local alerts
Social media', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Pet owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базове оголошення', 'Basic post' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic post', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Petfinder — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petfinder.com' OR LOWER(`name`) = LOWER('Petfinder'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Petfinder', NULL, 'https://www.petfinder.com', NULL, NULL, 'Petfinder — найбільша база тварин для усиновлення з притулків США, Канади й Мексики.', 'Petfinder is the largest database of adoptable pets from shelters in the US, Canada and Mexico.', 'Платформа (Purina) з оголошеннями тисяч притулків, фільтрами, порадами з усиновлення й догляду та збереженими пошуками.', 'A platform (Purina) with listings from thousands of shelters, filters, adoption and care advice and saved searches.', 'Тисячі притулків
Фільтри
Поради з усиновлення', 'Thousands of shelters
Filters
Adoption advice', 'Ті, хто хоче взяти тварину.', 'People adopting a pet.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petfinder.com' OR LOWER(`name`) = LOWER('Petfinder')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Petfinder is the largest database of adoptable pets from shelters in the US, Canada and Mexico.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform (Purina) with listings from thousands of shelters, filters, adoption and care advice and saved searches.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Thousands of shelters
Filters
Adoption advice', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People adopting a pet.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PETLIBRO — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petlibro.com' OR LOWER(`name`) = LOWER('PETLIBRO'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PETLIBRO', NULL, 'https://petlibro.com', NULL, NULL, 'PETLIBRO — автоматичні годівниці й фонтани для тварин з камерами, розкладом і застосунком.', 'PETLIBRO makes automatic pet feeders and fountains with cameras, schedules and an app.', 'Розумні годівниці з порціями за розкладом, моделями з камерою й розпізнаванням тварини, питні фонтани з фільтрацією. Застосунок показує, скільки з''їдено й випито.', 'Smart feeders with scheduled portions, camera models with pet recognition and filtered water fountains. The app shows how much was eaten and drunk.', 'Годівниці за розкладом
Камери
Фонтани', 'Scheduled feeders
Cameras
Fountains', 'Власники котів і собак.', 'Cat and dog owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petlibro.com' OR LOWER(`name`) = LOWER('PETLIBRO')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'PETLIBRO makes automatic pet feeders and fountains with cameras, schedules and an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Smart feeders with scheduled portions, camera models with pet recognition and filtered water fountains. The app shows how much was eaten and drunk.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Scheduled feeders
Cameras
Fountains', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Cat and dog owners.', 'manual' FROM DUAL WHERE @new = 1;

-- PetLink — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petlink.net' OR LOWER(`name`) = LOWER('PetLink'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PetLink', NULL, 'https://www.petlink.net', NULL, NULL, 'PetLink — реєстр мікрочипів тварин і GPS-трекери для собак для пошуку загублених улюбленців.', 'PetLink is a pet microchip registry and dog GPS tracker service for finding lost pets.', 'Сервіс реєстрації мікрочипів (Datamars), що допомагає повернути знайдену тварину власнику, а також GPS-трекери з відстеженням у застосунку.', 'A microchip registration service (Datamars) that helps return found pets to owners, plus GPS trackers with app tracking.', 'Реєстр мікрочипів
GPS-трекери
Пошук загублених', 'Microchip registry
GPS trackers
Lost pet recovery', 'Власники тварин.', 'Pet owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petlink.net' OR LOWER(`name`) = LOWER('PetLink')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'PetLink is a pet microchip registry and dog GPS tracker service for finding lost pets.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A microchip registration service (Datamars) that helps return found pets to owners, plus GPS trackers with app tracking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Microchip registry
GPS trackers
Lost pet recovery', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Pet owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Pupford — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pupford.com' OR LOWER(`name`) = LOWER('Pupford'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Pupford', NULL, 'https://pupford.com', NULL, NULL, 'Pupford — ласощі для дресирування й безкоштовний онлайн-курс «30 днів дресирування цуценя».', 'Pupford sells training treats and offers a free online "30 Day Perfect Pup" course.', 'Бренд ласощів і жувальних для собак з навчальним застосунком та безкоштовним курсом дресирування цуценят, а також платною академією з поглибленими курсами.', 'A brand of dog treats and chews with a training app and a free puppy course, plus a paid academy with advanced courses.', 'Ласощі для дресирування
Безкоштовний курс
Застосунок', 'Training treats
Free course
App', 'Власники цуценят.', 'Puppy owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pupford.com' OR LOWER(`name`) = LOWER('Pupford')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Pupford sells training treats and offers a free online "30 Day Perfect Pup" course.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A brand of dog treats and chews with a training app and a free puppy course, plus a paid academy with advanced courses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Training treats
Free course
App', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Puppy owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Puppr — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'puppr.app' OR LOWER(`name`) = LOWER('Puppr'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Puppr', NULL, 'https://www.puppr.app', NULL, NULL, 'Puppr — застосунок дресирування собак з відеоуроками трюків і команд, клікером і порадами тренерів.', 'Puppr is a dog training app with video lessons on tricks and commands, a clicker and trainer tips.', 'Покрокові відеоуроки від професійних тренерів: базові команди, послух, трюки; вбудований клікер, відстеження прогресу й підписка для повного доступу.', 'Step-by-step video lessons from professional trainers: basic commands, obedience and tricks, with a built-in clicker, progress tracking and a subscription for full access.', 'Відеоуроки
Вбудований клікер
Прогрес', 'Video lessons
Built-in clicker
Progress', 'Власники собак.', 'Dog owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'puppr.app' OR LOWER(`name`) = LOWER('Puppr')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Puppr is a dog training app with video lessons on tricks and commands, a clicker and trainer tips.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Step-by-step video lessons from professional trainers: basic commands, obedience and tricks, with a built-in clicker, progress tracking and a subscription for full access.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Video lessons
Built-in clicker
Progress', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dog owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Sure Petcare — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'surepetcare.com' OR LOWER(`name`) = LOWER('Sure Petcare'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Sure Petcare', NULL, 'https://www.surepetcare.com', NULL, NULL, 'Sure Petcare — дверцята й годівниці з розпізнаванням мікрочипа тварини та застосунком Sure Petcare.', 'Sure Petcare makes microchip-recognizing pet doors and feeders with the Sure Petcare app.', 'Котячі дверцята, що впускають лише своїх тварин за мікрочипом, годівниці, які відкриваються конкретному коту, й поїлки з моніторингом. Застосунок показує, коли тварина виходила, їла й пила.', 'Cat flaps that admit only your pets by microchip, feeders that open for a specific cat and monitored water stations. The app shows when the pet went out, ate and drank.', 'Дверцята за мікрочипом
Годівниці
Моніторинг харчування', 'Microchip flaps
Feeders
Feeding monitoring', 'Власники котів.', 'Cat owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'surepetcare.com' OR LOWER(`name`) = LOWER('Sure Petcare')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sure Petcare makes microchip-recognizing pet doors and feeders with the Sure Petcare app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Cat flaps that admit only your pets by microchip, feeders that open for a specific cat and monitored water stations. The app shows when the pet went out, ate and drank.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Microchip flaps
Feeders
Feeding monitoring', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Cat owners.', 'manual' FROM DUAL WHERE @new = 1;

-- The Farmer's Dog — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thefarmersdog.com' OR LOWER(`name`) = LOWER('The Farmer''s Dog'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Farmer''s Dog', NULL, 'https://www.thefarmersdog.com', NULL, NULL, 'The Farmer''s Dog — свіжий корм для собак, приготований за рецептами ветеринарів, з порціонуванням і доставкою.', 'The Farmer''s Dog delivers fresh, vet-developed dog food pre-portioned to your dog.', 'Підписковий сервіс свіжого корму з м''ясом і овочами, порції розраховані під конкретну собаку, доставляються замороженими у зручних пакетах.', 'A fresh food subscription with meat and vegetables, portions calculated for your dog and delivered frozen in convenient packs.', 'Рецепти ветеринарів
Порціонування
Доставка', 'Vet-developed recipes
Pre-portioned
Delivery', 'Власники собак у США.', 'US dog owners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thefarmersdog.com' OR LOWER(`name`) = LOWER('The Farmer''s Dog')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Farmer''s Dog delivers fresh, vet-developed dog food pre-portioned to your dog.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A fresh food subscription with meat and vegetables, portions calculated for your dog and delivered frozen in convenient packs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Vet-developed recipes
Pre-portioned
Delivery', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US dog owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Trupanion — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trupanion.com' OR LOWER(`name`) = LOWER('Trupanion'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Trupanion', NULL, 'https://www.trupanion.com', NULL, NULL, 'Trupanion — медичне страхування собак і котів з прямою оплатою ветеринару.', 'Trupanion offers dog and cat medical insurance with direct payment to the vet.', 'Страхування на випадок хвороб і травм, де клініки з ПЗ Trupanion отримують оплату напряму під час візиту. Покриває 90 % відповідних витрат без лімітів виплат.', 'Illness and injury coverage where clinics with Trupanion software get paid directly at checkout. It covers 90% of eligible costs with no payout limits.', 'Пряма оплата ветеринару
90 % покриття
Без лімітів', 'Direct vet payment
90% coverage
No payout limits', 'Власники тварин у США й Канаді.', 'Pet owners in the US and Canada.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trupanion.com' OR LOWER(`name`) = LOWER('Trupanion')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Trupanion offers dog and cat medical insurance with direct payment to the vet.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Illness and injury coverage where clinics with Trupanion software get paid directly at checkout. It covers 90% of eligible costs with no payout limits.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Direct vet payment
90% coverage
No payout limits', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Pet owners in the US and Canada.', 'manual' FROM DUAL WHERE @new = 1;

-- Wisdom Panel — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wisdompanel.com' OR LOWER(`name`) = LOWER('Wisdom Panel'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Wisdom Panel', NULL, 'https://www.wisdompanel.com', NULL, NULL, 'Wisdom Panel — ДНК-тести для собак і котів: породи, генетичні ризики здоров''я й риси.', 'Wisdom Panel offers dog and cat DNA tests: breeds, genetic health risks and traits.', 'Набір для мазка з щоки визначає породний склад, тестує на генетичні захворювання й риси, показує родичів; результати в онлайн-кабінеті й застосунку.', 'A cheek swab kit determines breed makeup, screens for genetic conditions and traits and finds relatives; results in an online account and app.', 'Породний склад
Генетичні ризики
Родичі', 'Breed makeup
Genetic risks
Relatives', 'Власники собак і котів.', 'Dog and cat owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wisdompanel.com' OR LOWER(`name`) = LOWER('Wisdom Panel')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Wisdom Panel offers dog and cat DNA tests: breeds, genetic health risks and traits.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A cheek swab kit determines breed makeup, screens for genetic conditions and traits and finds relatives; results in an online account and app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Breed makeup
Genetic risks
Relatives', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dog and cat owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Woofz — Домашні тварини
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'woofz.com' OR LOWER(`name`) = LOWER('Woofz'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Woofz', NULL, 'https://www.woofz.com', NULL, NULL, 'Woofz — застосунок дресирування цуценят і собак: персональний план, ігри, вирішення поведінкових проблем.', 'Woofz is a puppy and dog training app: personal plan, games and behaviour problem solving.', 'Застосунок складає програму за віком і характером собаки, пропонує щоденні уроки, клікер, трекер прогулянок і поради з проблем поведінки; доступ за підпискою.', 'The app builds a program by age and temperament, offers daily lessons, a clicker, walk tracker and behaviour tips; access by subscription.', 'Персональний план
Щоденні уроки
Проблеми поведінки', 'Personal plan
Daily lessons
Behaviour help', 'Власники цуценят.', 'Puppy owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'woofz.com' OR LOWER(`name`) = LOWER('Woofz')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pets' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Woofz is a puppy and dog training app: personal plan, games and behaviour problem solving.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app builds a program by age and temperament, offers daily lessons, a clicker, walk tracker and behaviour tips; access by subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Personal plan
Daily lessons
Behaviour help', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Puppy owners.', 'manual' FROM DUAL WHERE @new = 1;

-- DeLaval — Худоба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'delaval.com' OR LOWER(`name`) = LOWER('DeLaval'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DeLaval', NULL, 'https://www.delaval.com', NULL, NULL, 'DeLaval — доїльні системи, роботи VMS і ПЗ DelPro для керування молочним стадом.', 'DeLaval makes milking systems, VMS robots and DelPro herd management software for dairy farms.', 'Шведський виробник обладнання для молочних ферм: доїльні роботи, ротаційні зали, кормові системи й програмне забезпечення DelPro з мобільним застосунком для обліку здоров''я, надоїв і відтворення.', 'A Swedish maker of dairy equipment: milking robots, rotary parlors, feeding systems and DelPro software with a mobile app for health, yield and reproduction records.', 'Доїльні роботи
DelPro
Облік надоїв', 'Milking robots
DelPro
Yield records', 'Молочні ферми.', 'Dairy farms.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'delaval.com' OR LOWER(`name`) = LOWER('DeLaval')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'livestock' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'DeLaval makes milking systems, VMS robots and DelPro herd management software for dairy farms.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Swedish maker of dairy equipment: milking robots, rotary parlors, feeding systems and DelPro software with a mobile app for health, yield and reproduction records.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Milking robots
DelPro
Yield records', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dairy farms.', 'manual' FROM DUAL WHERE @new = 1;

-- Equilab — Худоба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'equilab.horse' OR LOWER(`name`) = LOWER('Equilab'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Equilab', NULL, 'https://www.equilab.horse', NULL, NULL, 'Equilab — застосунок для вершників: трекінг тренувань і прогулянок, аналіз ходи, журнал коня й безпека.', 'Equilab is an app for riders: training and ride tracking, gait analysis, horse journal and safety.', 'Відстежує тренування й прогулянки верхи, розподіл алюрів і поворотів, веде журнал здоров''я й догляду за конем і пропонує функцію безпеки з повідомленням контактам.', 'It tracks rides and training, gait and turn distribution, keeps a horse health and care journal and offers a safety feature that notifies contacts.', 'Трекінг тренувань
Аналіз алюрів
Журнал коня
Безпека', 'Ride tracking
Gait analysis
Horse journal
Safety', 'Вершники й власники коней.', 'Riders and horse owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'equilab.horse' OR LOWER(`name`) = LOWER('Equilab')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'livestock' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Equilab is an app for riders: training and ride tracking, gait analysis, horse journal and safety.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It tracks rides and training, gait and turn distribution, keeps a horse health and care journal and offers a safety feature that notifies contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Ride tracking
Gait analysis
Horse journal
Safety', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Riders and horse owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базова версія', 'Basic version' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic version', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- HerdDogg — Худоба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'herddogg.com' OR LOWER(`name`) = LOWER('HerdDogg'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HerdDogg', NULL, 'https://herddogg.com', NULL, NULL, 'HerdDogg — смарт-бирки й сенсори для худоби: моніторинг здоров''я, температури й активності тварин.', 'HerdDogg offers smart ear tags and sensors for livestock: monitoring animal health, temperature and activity.', 'Bluetooth-бирки передають дані про температуру й рух тварин на зчитувачі біля поїлок, а платформа виявляє хворих тварин і тічку, веде облік стада й простежуваність.', 'Bluetooth tags send temperature and movement data to readers near water troughs, and the platform flags sick animals and heat, keeps herd records and traceability.', 'Смарт-бирки
Температура й активність
Облік стада', 'Smart tags
Temperature and activity
Herd records', 'Скотарі.', 'Cattle producers.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'herddogg.com' OR LOWER(`name`) = LOWER('HerdDogg')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'livestock' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'HerdDogg offers smart ear tags and sensors for livestock: monitoring animal health, temperature and activity.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Bluetooth tags send temperature and movement data to readers near water troughs, and the platform flags sick animals and heat, keeps herd records and traceability.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Smart tags
Temperature and activity
Herd records', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Cattle producers.', 'manual' FROM DUAL WHERE @new = 1;

-- Lely — Худоба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lely.com' OR LOWER(`name`) = LOWER('Lely'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lely', NULL, 'https://www.lely.com', NULL, NULL, 'Lely — роботи для доїння, годування й прибирання гною та система керування стадом Horizon.', 'Lely makes robots for milking, feeding and manure cleaning and the Horizon herd management system.', 'Нідерландський виробник автоматизації ферм: доїльні роботи Astronaut, роботи Juno й Vector для кормів, Discovery для прибирання та ПЗ Lely Horizon для аналізу даних стада.', 'A Dutch farm automation maker: Astronaut milking robots, Juno and Vector feed robots, Discovery for barn cleaning and Lely Horizon software for herd data.', 'Доїльні роботи Astronaut
Кормові роботи
Lely Horizon', 'Astronaut milking robots
Feed robots
Lely Horizon', 'Молочні ферми.', 'Dairy farms.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lely.com' OR LOWER(`name`) = LOWER('Lely')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'livestock' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Lely makes robots for milking, feeding and manure cleaning and the Horizon herd management system.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Dutch farm automation maker: Astronaut milking robots, Juno and Vector feed robots, Discovery for barn cleaning and Lely Horizon software for herd data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Astronaut milking robots
Feed robots
Lely Horizon', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dairy farms.', 'manual' FROM DUAL WHERE @new = 1;

-- Mobble — Худоба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mobble.io' OR LOWER(`name`) = LOWER('Mobble'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mobble', NULL, 'https://www.mobble.io', NULL, NULL, 'Mobble — ПЗ для тваринницьких ферм: облік отар і стад, пасовищ, обробок і продажів з мапою.', 'Mobble is livestock farm software: mob and herd records, paddocks, treatments and sales on a map.', 'Австралійська платформа для овече- й скотарства: записи про групи тварин на мапі пасовищ, переміщення, ветеринарні обробки, вагу, продажі й командна робота з телефона.', 'An Australian platform for sheep and cattle: mob records on a paddock map, movements, treatments, weights, sales and team work from the phone.', 'Мапа пасовищ
Облік обробок
Продажі
Командна робота', 'Paddock map
Treatment records
Sales
Team work', 'Вівчарі й скотарі.', 'Sheep and cattle farmers.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mobble.io' OR LOWER(`name`) = LOWER('Mobble')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'livestock' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mobble is livestock farm software: mob and herd records, paddocks, treatments and sales on a map.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An Australian platform for sheep and cattle: mob records on a paddock map, movements, treatments, weights, sales and team work from the phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Paddock map
Treatment records
Sales
Team work', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sheep and cattle farmers.', 'manual' FROM DUAL WHERE @new = 1;

-- Moonsyst — Худоба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moonsyst.com' OR LOWER(`name`) = LOWER('Moonsyst'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Moonsyst', NULL, 'https://moonsyst.com', NULL, NULL, 'Moonsyst — болюси в рубці для моніторингу здоров''я, тічки й отелу корів з хмарною аналітикою.', 'Moonsyst rumen boluses monitor cow health, heat and calving with cloud analytics.', 'Литовська розробка: болюс вимірює температуру й активність у рубці, а застосунок сповіщає фермера про хвороби, тічку, отел і проблеми з годуванням.', 'A Lithuanian solution: the bolus measures rumen temperature and activity, and the app alerts the farmer to disease, heat, calving and feeding issues.', 'Болюси
Сповіщення про хвороби
Тічка й отел', 'Boluses
Disease alerts
Heat and calving', 'Молочні ферми.', 'Dairy farms.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moonsyst.com' OR LOWER(`name`) = LOWER('Moonsyst')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'livestock' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Moonsyst rumen boluses monitor cow health, heat and calving with cloud analytics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Lithuanian solution: the bolus measures rumen temperature and activity, and the app alerts the farmer to disease, heat, calving and feeding issues.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Boluses
Disease alerts
Heat and calving', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dairy farms.', 'manual' FROM DUAL WHERE @new = 1;

-- Nofence — Худоба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nofence.com' OR LOWER(`name`) = LOWER('Nofence'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nofence', NULL, 'https://www.nofence.com', NULL, NULL, 'Nofence — норвезькі віртуальні паркани для великої рогатої худоби, овець і кіз на GPS-нашийниках.', 'Nofence makes Norwegian virtual fences for cattle, sheep and goats with GPS collars.', 'Фермер малює пасовище в застосунку, а нашийник звуком і слабким імпульсом утримує тварину в межах; застосунок показує положення й активність стада.', 'The farmer draws the pasture in the app and the collar keeps the animal within bounds by sound and a mild pulse; the app shows herd location and activity.', 'Віртуальне пасовище
GPS-нашийники
Вівці, кози, ВРХ', 'Virtual pasture
GPS collars
Sheep, goats, cattle', 'Фермери в Європі.', 'European farmers.', 'mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nofence.com' OR LOWER(`name`) = LOWER('Nofence')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'livestock' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Nofence makes Norwegian virtual fences for cattle, sheep and goats with GPS collars.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The farmer draws the pasture in the app and the collar keeps the animal within bounds by sound and a mild pulse; the app shows herd location and activity.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Virtual pasture
GPS collars
Sheep, goats, cattle', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'European farmers.', 'manual' FROM DUAL WHERE @new = 1;

-- smaXtec — Худоба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'smaxtec.com' OR LOWER(`name`) = LOWER('smaXtec'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'smaXtec', NULL, 'https://www.smaxtec.com', NULL, NULL, 'smaXtec — болюси в рубці для раннього виявлення хвороб, тічки й отелу у молочних корів.', 'smaXtec rumen boluses detect disease, heat and calving early in dairy cows.', 'Внутрішній болюс вимірює температуру, пиття й активність рубця корови, а хмарна аналітика надсилає сповіщення про захворювання, оптимальний час осіменіння й отелу.', 'An internal bolus measures the cow''s temperature, drinking and rumen activity, and cloud analytics sends alerts on illness, optimal insemination timing and calving.', 'Болюси в рубці
Раннє виявлення хвороб
Тічка й отел', 'Rumen boluses
Early disease detection
Heat and calving', 'Молочні ферми.', 'Dairy farms.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'smaxtec.com' OR LOWER(`name`) = LOWER('smaXtec')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'livestock' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'smaXtec rumen boluses detect disease, heat and calving early in dairy cows.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An internal bolus measures the cow''s temperature, drinking and rumen activity, and cloud analytics sends alerts on illness, optimal insemination timing and calving.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Rumen boluses
Early disease detection
Heat and calving', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Dairy farms.', 'manual' FROM DUAL WHERE @new = 1;

-- Vence — Худоба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'merck-animal-health-usa.com/hub/vence' OR LOWER(`name`) = LOWER('Vence'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Vence', NULL, 'https://www.merck-animal-health-usa.com/hub/vence/', NULL, NULL, 'Vence (Merck Animal Health) — віртуальні паркани для худоби на нашийниках з GPS і керуванням випасом.', 'Vence (Merck Animal Health) provides virtual fencing for cattle with GPS collars and grazing management.', 'Система керування випасом, у якій межі пасовищ задаються віртуально, а нашийники звуковими й легкими сигналами утримують тварин; дозволяє переганяти худобу та стежити за нею дистанційно.', 'A grazing management system where pasture boundaries are virtual and collars use sound and mild cues to keep animals in; it allows moving cattle and monitoring them remotely.', 'Віртуальні паркани
GPS-нашийники
Керування випасом', 'Virtual fences
GPS collars
Grazing management', 'Скотарі.', 'Cattle ranchers.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'merck-animal-health-usa.com/hub/vence' OR LOWER(`name`) = LOWER('Vence')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'livestock' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Vence (Merck Animal Health) provides virtual fencing for cattle with GPS collars and grazing management.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A grazing management system where pasture boundaries are virtual and collars use sound and mild cues to keep animals in; it allows moving cattle and monitoring them remotely.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Virtual fences
GPS collars
Grazing management', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Cattle ranchers.', 'manual' FROM DUAL WHERE @new = 1;

-- BackYard Chickens — Птахівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'backyardchickens.com' OR LOWER(`name`) = LOWER('BackYard Chickens'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BackYard Chickens', NULL, 'https://www.backyardchickens.com', NULL, NULL, 'BackYard Chickens — найбільша онлайн-спільнота курівників: форум, статті про породи, курники й здоров''я птиці.', 'BackYard Chickens is the largest online chicken keeping community: forum, articles on breeds, coops and bird health.', 'Сайт з форумом, базою порід, проєктами курників, статтями про інкубацію, годування й хвороби птиці та галереями учасників.', 'A site with a forum, breed database, coop projects, articles on incubation, feeding and poultry diseases and member galleries.', 'Форум
База порід
Проєкти курників', 'Forum
Breed database
Coop projects', 'Курівники.', 'Chicken keepers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'backyardchickens.com' OR LOWER(`name`) = LOWER('BackYard Chickens')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'poultry' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'BackYard Chickens is the largest online chicken keeping community: forum, articles on breeds, coops and bird health.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site with a forum, breed database, coop projects, articles on incubation, feeding and poultry diseases and member galleries.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Forum
Breed database
Coop projects', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Chicken keepers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Спільнота', 'Community' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Community', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Brinsea — Птахівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brinsea.com' OR LOWER(`name`) = LOWER('Brinsea'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Brinsea', NULL, 'https://www.brinsea.com', NULL, NULL, 'Brinsea — інкубатори, брудери й товари для птахівництва від британського виробника.', 'Brinsea makes egg incubators, brooders and poultry products, from a British manufacturer.', 'Інкубатори для домашніх і професійних птахівників з автоматичним перевертанням і контролем вологості, брудери для пташенят, овоскопи й навчальні матеріали.', 'Incubators for hobby and professional keepers with automatic turning and humidity control, chick brooders, candlers and educational content.', 'Інкубатори
Брудери
Контроль вологості', 'Incubators
Brooders
Humidity control', 'Птахівники.', 'Poultry keepers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'brinsea.com' OR LOWER(`name`) = LOWER('Brinsea')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'poultry' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Brinsea makes egg incubators, brooders and poultry products, from a British manufacturer.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Incubators for hobby and professional keepers with automatic turning and humidity control, chick brooders, candlers and educational content.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Incubators
Brooders
Humidity control', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Poultry keepers.', 'manual' FROM DUAL WHERE @new = 1;

-- ChickenGuard — Птахівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chickenguard.com' OR LOWER(`name`) = LOWER('ChickenGuard'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ChickenGuard', NULL, 'https://www.chickenguard.com', NULL, NULL, 'ChickenGuard — автоматичні відкривачі дверцят курника від хижаків з таймером і датчиком світла.', 'ChickenGuard makes automatic coop door openers with timer and light sensor to protect against predators.', 'Британський виробник автоматичних дверцят і відкривачів, що закривають курник на ніч і відкривають зранку, захищаючи птицю від лисиць та інших хижаків.', 'A British maker of automatic doors and openers that close the coop at night and open in the morning, protecting birds from foxes and other predators.', 'Автозакриття на ніч
Таймер
Датчик світла', 'Auto-close at night
Timer
Light sensor', 'Власники курей.', 'Chicken keepers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chickenguard.com' OR LOWER(`name`) = LOWER('ChickenGuard')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'poultry' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ChickenGuard makes automatic coop door openers with timer and light sensor to protect against predators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A British maker of automatic doors and openers that close the coop at night and open in the morning, protecting birds from foxes and other predators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Auto-close at night
Timer
Light sensor', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Chicken keepers.', 'manual' FROM DUAL WHERE @new = 1;

-- My Pet Chicken — Птахівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mypetchicken.com' OR LOWER(`name`) = LOWER('My Pet Chicken'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'My Pet Chicken', NULL, 'https://www.mypetchicken.com', NULL, NULL, 'My Pet Chicken — курчата, водоплавна птиця й товари для домашнього птахівництва з поштовою доставкою та порадами.', 'My Pet Chicken sells chicks, waterfowl and backyard poultry supplies by mail with advice.', 'Американський магазин, що відправляє добових курчат і каченят поштою, продає корми, курники, інкубатори й має навчальні матеріали та підбирач порід.', 'A US store that ships day-old chicks and ducklings by mail and sells feed, coops and incubators, with educational content and a breed selector.', 'Курчата поштою
Підбирач порід
Товари для птиці', 'Chicks by mail
Breed selector
Poultry supplies', 'Домашні птахівники в США.', 'US backyard poultry keepers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mypetchicken.com' OR LOWER(`name`) = LOWER('My Pet Chicken')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'poultry' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'My Pet Chicken sells chicks, waterfowl and backyard poultry supplies by mail with advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A US store that ships day-old chicks and ducklings by mail and sells feed, coops and incubators, with educational content and a breed selector.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Chicks by mail
Breed selector
Poultry supplies', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US backyard poultry keepers.', 'manual' FROM DUAL WHERE @new = 1;

-- Omlet — Птахівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'omlet.co.uk' OR LOWER(`name`) = LOWER('Omlet'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Omlet', NULL, 'https://www.omlet.co.uk', NULL, NULL, 'Omlet — сучасні курники Eglu, вольєри й автоматичні дверцята для курей, а також товари для інших тварин.', 'Omlet makes modern Eglu chicken coops, runs and automatic coop doors, plus products for other pets.', 'Британський бренд пластикових курників, які легко мити, вольєрів, автоматичних дверцят із розумним керуванням і товарів для кролів, котів та собак, а також порад з птахівництва.', 'A British brand of easy-clean plastic coops, runs, smart automatic doors and products for rabbits, cats and dogs, plus poultry keeping advice.', 'Курники Eglu
Автоматичні дверцята
Поради', 'Eglu coops
Automatic doors
Advice', 'Домашні птахівники.', 'Backyard poultry keepers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'omlet.co.uk' OR LOWER(`name`) = LOWER('Omlet')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'poultry' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Omlet makes modern Eglu chicken coops, runs and automatic coop doors, plus products for other pets.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A British brand of easy-clean plastic coops, runs, smart automatic doors and products for rabbits, cats and dogs, plus poultry keeping advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Eglu coops
Automatic doors
Advice', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Backyard poultry keepers.', 'manual' FROM DUAL WHERE @new = 1;

-- RUN-CHICKEN — Птахівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'run-chicken.com' OR LOWER(`name`) = LOWER('RUN-CHICKEN'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'RUN-CHICKEN', NULL, 'https://www.run-chicken.com', NULL, NULL, 'RUN-CHICKEN — автоматичні дверцята для курника з таймером, датчиком світла й Bluetooth-керуванням.', 'RUN-CHICKEN makes automatic coop doors with timer, light sensor and Bluetooth control.', 'Автоматичні дверцята для курника, що відкриваються й закриваються за розкладом чи освітленням, працюють від батарей або сонячних панелей і керуються з телефона.', 'Automatic coop doors that open and close on schedule or by light, run on batteries or solar and are phone-controlled.', 'Таймер і датчик світла
Bluetooth
Сонячне живлення', 'Timer and light sensor
Bluetooth
Solar power', 'Власники курей.', 'Chicken keepers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'run-chicken.com' OR LOWER(`name`) = LOWER('RUN-CHICKEN')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'poultry' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'RUN-CHICKEN makes automatic coop doors with timer, light sensor and Bluetooth control.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Automatic coop doors that open and close on schedule or by light, run on batteries or solar and are phone-controlled.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Timer and light sensor
Bluetooth
Solar power', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Chicken keepers.', 'manual' FROM DUAL WHERE @new = 1;

-- The Chicken Coop Company — Птахівництво
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chickencoopcompany.com' OR LOWER(`name`) = LOWER('The Chicken Coop Company'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Chicken Coop Company', NULL, 'https://www.chickencoopcompany.com', NULL, NULL, 'The Chicken Coop Company — готові курники й вольєри для домашніх курей з доставкою по США.', 'The Chicken Coop Company sells pre-made backyard chicken coops and runs shipped across the US.', 'Магазин курників різних розмірів, вольєрів і аксесуарів для домашнього птахівництва з порадами з вибору та догляду.', 'A store of coops in various sizes, runs and accessories for backyard poultry with buying and care advice.', 'Готові курники
Вольєри
Аксесуари', 'Pre-made coops
Runs
Accessories', 'Власники домашніх курей.', 'Backyard chicken keepers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chickencoopcompany.com' OR LOWER(`name`) = LOWER('The Chicken Coop Company')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'poultry' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Chicken Coop Company sells pre-made backyard chicken coops and runs shipped across the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A store of coops in various sizes, runs and accessories for backyard poultry with buying and care advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Pre-made coops
Runs
Accessories', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Backyard chicken keepers.', 'manual' FROM DUAL WHERE @new = 1;

-- ANGLR — Риба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'anglr.com' OR LOWER(`name`) = LOWER('ANGLR'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ANGLR', NULL, 'https://anglr.com', NULL, NULL, 'ANGLR — журнал риболовлі й трекер з даними погоди, мапами і аналізом уловів.', 'ANGLR is a fishing log and tracker with weather data, maps and catch analysis.', 'Застосунок записує поїздки, місця, приманки й умови (погода, тиск, приплив), аналізує, що працює найкраще, і дозволяє планувати наступну риболовлю.', 'The app records trips, spots, lures and conditions (weather, pressure, tide), analyzes what works and lets you plan the next trip.', 'Журнал поїздок
Умови й погода
Аналіз уловів', 'Trip log
Conditions and weather
Catch analysis', 'Рибалки.', 'Anglers.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'anglr.com' OR LOWER(`name`) = LOWER('ANGLR')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'fish' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ANGLR is a fishing log and tracker with weather data, maps and catch analysis.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app records trips, spots, lures and conditions (weather, pressure, tide), analyzes what works and lets you plan the next trip.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Trip log
Conditions and weather
Catch analysis', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anglers.', 'manual' FROM DUAL WHERE @new = 1;

-- Aquarium Advice — Риба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aquariumadvice.com' OR LOWER(`name`) = LOWER('Aquarium Advice'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Aquarium Advice', NULL, 'https://www.aquariumadvice.com', NULL, NULL, 'Aquarium Advice — форум-спільнота акваріумістів: прісноводні й морські акваріуми, хвороби риб, обладнання.', 'Aquarium Advice is an aquarium hobby forum: freshwater and marine tanks, fish diseases and equipment.', 'Великий форум, де акваріумісти обговорюють запуск акваріума, азотний цикл, сумісність риб, хвороби, рифові системи й обладнання.', 'A large forum where aquarists discuss tank setup, the nitrogen cycle, fish compatibility, diseases, reef systems and equipment.', 'Форум
Хвороби риб
Рифові акваріуми', 'Forum
Fish diseases
Reef tanks', 'Акваріумісти.', 'Aquarists.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aquariumadvice.com' OR LOWER(`name`) = LOWER('Aquarium Advice')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'fish' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Aquarium Advice is an aquarium hobby forum: freshwater and marine tanks, fish diseases and equipment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A large forum where aquarists discuss tank setup, the nitrogen cycle, fish compatibility, diseases, reef systems and equipment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Forum
Fish diseases
Reef tanks', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Aquarists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Спільнота', 'Community' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Community', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Aquascape — Риба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aquascapeinc.com' OR LOWER(`name`) = LOWER('Aquascape'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Aquascape', NULL, 'https://www.aquascapeinc.com', NULL, NULL, 'Aquascape — водні об''єкти для саду: ставки, фонтани, насоси, фільтри й поради з догляду за ставком і рибою кої.', 'Aquascape makes garden water features: ponds, fountains, pumps, filters and pond and koi care advice.', 'Американський виробник обладнання для садових ставків і фонтанів з мережею сертифікованих монтажників, навчальними матеріалами й порадами з утримання риб у ставку.', 'A US maker of pond and fountain equipment with a network of certified installers, educational content and tips on keeping fish in ponds.', 'Ставки й фонтани
Насоси й фільтри
Догляд за кої', 'Ponds and fountains
Pumps and filters
Koi care', 'Власники садових ставків.', 'Garden pond owners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'aquascapeinc.com' OR LOWER(`name`) = LOWER('Aquascape')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'fish' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Aquascape makes garden water features: ponds, fountains, pumps, filters and pond and koi care advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A US maker of pond and fountain equipment with a network of certified installers, educational content and tips on keeping fish in ponds.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Ponds and fountains
Pumps and filters
Koi care', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Garden pond owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Deeper — Риба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'deepersonar.com' OR LOWER(`name`) = LOWER('Deeper'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Deeper', NULL, 'https://deepersonar.com', NULL, NULL, 'Deeper — бездротові ехолоти, що закидаються, для пошуку риби й побудови карт глибин у застосунку Fish Deeper.', 'Deeper makes wireless castable sonars for finding fish and mapping depth in the Fish Deeper app.', 'Литовський виробник ехолотів, які закидаються з берега чи використовуються з човна й на льоду. Застосунок показує рибу, рельєф дна, будує батиметричні карти й зберігає їх у хмарі.', 'A Lithuanian maker of castable sonars used from shore, boat or ice. The app shows fish and bottom structure, builds bathymetric maps and stores them in the cloud.', 'Закидний ехолот
Карти глибин
Зимова риболовля', 'Castable sonar
Depth maps
Ice fishing', 'Рибалки.', 'Anglers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'deepersonar.com' OR LOWER(`name`) = LOWER('Deeper')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'fish' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Deeper makes wireless castable sonars for finding fish and mapping depth in the Fish Deeper app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Lithuanian maker of castable sonars used from shore, boat or ice. The app shows fish and bottom structure, builds bathymetric maps and stores them in the cloud.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Castable sonar
Depth maps
Ice fishing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anglers.', 'manual' FROM DUAL WHERE @new = 1;

-- Eruvaka — Риба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eruvaka.com' OR LOWER(`name`) = LOWER('Eruvaka'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eruvaka', NULL, 'https://eruvaka.com', NULL, NULL, 'Eruvaka — IoT для аквакультури: датчики якості води, автоматизація аераторів і годування на ставках.', 'Eruvaka offers aquaculture IoT: water quality sensors, aerator and feeder automation for ponds.', 'Рішення для креветкових і рибних ферм: плавучі датчики кисню й температури, автоматичне керування аераторами, розумні годівниці й застосунок для фермера.', 'Solutions for shrimp and fish farms: floating oxygen and temperature sensors, automatic aerator control, smart feeders and a farmer app.', 'Датчики води
Керування аераторами
Розумні годівниці', 'Water sensors
Aerator control
Smart feeders', 'Аквафермери.', 'Aquaculture farmers.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eruvaka.com' OR LOWER(`name`) = LOWER('Eruvaka')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'fish' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Eruvaka offers aquaculture IoT: water quality sensors, aerator and feeder automation for ponds.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Solutions for shrimp and fish farms: floating oxygen and temperature sensors, automatic aerator control, smart feeders and a farmer app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Water sensors
Aerator control
Smart feeders', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Aquaculture farmers.', 'manual' FROM DUAL WHERE @new = 1;

-- FishAngler — Риба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fishangler.com' OR LOWER(`name`) = LOWER('FishAngler'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'FishAngler', NULL, 'https://www.fishangler.com', NULL, NULL, 'FishAngler — безкоштовний застосунок для рибалок: мапи, прогнози, звіти про улов і журнал риболовлі.', 'FishAngler is a free fishing app: maps, forecasts, catch reports and a fishing log.', 'Застосунок показує місця риболовлі, прогнози погоди й активності риби, звіти спільноти, мапи глибин і веде особистий журнал уловів.', 'The app shows fishing spots, weather and fish activity forecasts, community reports and depth maps and keeps a personal catch log.', 'Мапи місць
Прогнози
Звіти спільноти', 'Spot maps
Forecasts
Community reports', 'Рибалки.', 'Anglers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fishangler.com' OR LOWER(`name`) = LOWER('FishAngler')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'fish' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'FishAngler is a free fishing app: maps, forecasts, catch reports and a fishing log.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app shows fishing spots, weather and fish activity forecasts, community reports and depth maps and keeps a personal catch log.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Spot maps
Forecasts
Community reports', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anglers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Fishbrain — Риба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fishbrain.com' OR LOWER(`name`) = LOWER('Fishbrain'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fishbrain', NULL, 'https://fishbrain.com', NULL, NULL, 'Fishbrain — соціальна мережа й застосунок для рибалок: мапи місць, прогнози кльову, улови спільноти й глибини.', 'Fishbrain is a social network and app for anglers: spot maps, bite forecasts, community catches and depth maps.', 'Найбільша спільнота рибалок із мільйонами записаних уловів: показує, де й на що ловлять, прогнози активності риби, мапи глибин і журнал риболовлі; Pro відкриває точні місця.', 'The largest angler community with millions of logged catches: shows where and on what fish are caught, bite forecasts, depth maps and a fishing log; Pro unlocks exact spots.', 'Мапа уловів
Прогноз кльову
Мапи глибин
Журнал', 'Catch map
Bite forecast
Depth maps
Log', 'Рибалки.', 'Anglers.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fishbrain.com' OR LOWER(`name`) = LOWER('Fishbrain')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'fish' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fishbrain is a social network and app for anglers: spot maps, bite forecasts, community catches and depth maps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The largest angler community with millions of logged catches: shows where and on what fish are caught, bite forecasts, depth maps and a fishing log; Pro unlocks exact spots.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Catch map
Bite forecast
Depth maps
Log', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anglers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базова версія', 'Basic version' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic version', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Fishidy — Риба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fishidy.com' OR LOWER(`name`) = LOWER('Fishidy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fishidy', NULL, 'https://www.fishidy.com', NULL, NULL, 'Fishidy — місцеві звіти про риболовлю, мапи місць і соціальна мережа рибалок.', 'Fishidy offers local fishing reports, spot maps and an anglers'' social network.', 'Сервіс з мапами водойм, «гарячими точками», звітами рибалок і порадами для конкретних озер і річок; Premium додає розширені карти.', 'A service with waterbody maps, hotspots, angler reports and tips for specific lakes and rivers; Premium adds advanced maps.', 'Звіти рибалок
Гарячі точки
Мапи водойм', 'Angler reports
Hotspots
Waterbody maps', 'Рибалки в США.', 'US anglers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fishidy.com' OR LOWER(`name`) = LOWER('Fishidy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'fish' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fishidy offers local fishing reports, spot maps and an anglers'' social network.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service with waterbody maps, hotspots, angler reports and tips for specific lakes and rivers; Premium adds advanced maps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Angler reports
Hotspots
Waterbody maps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US anglers.', 'manual' FROM DUAL WHERE @new = 1;

-- Fishing Points — Риба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fishingpoints.app' OR LOWER(`name`) = LOWER('Fishing Points'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fishing Points', NULL, 'https://fishingpoints.app', NULL, NULL, 'Fishing Points — мапи, прогнози кльову, припливи й журнал уловів для рибалок.', 'Fishing Points offers maps, bite forecasts, tides and a catch log for anglers.', 'Застосунок для збереження рибних місць, перегляду морських карт, прогнозів активності риби, погоди, сонця й місяця, припливів і ведення журналу уловів.', 'An app for saving fishing spots, viewing nautical charts, fish activity forecasts, weather, sun and moon, tides and keeping a catch log.', 'Рибні місця
Прогноз кльову
Припливи
Журнал', 'Fishing spots
Bite forecast
Tides
Log', 'Рибалки.', 'Anglers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fishingpoints.app' OR LOWER(`name`) = LOWER('Fishing Points')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'fish' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fishing Points offers maps, bite forecasts, tides and a catch log for anglers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app for saving fishing spots, viewing nautical charts, fish activity forecasts, weather, sun and moon, tides and keeping a catch log.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Fishing spots
Bite forecast
Tides
Log', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anglers.', 'manual' FROM DUAL WHERE @new = 1;

-- Garmin ActiveCaptain — Риба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'garmin.com/en-us/p/573254' OR LOWER(`name`) = LOWER('Garmin ActiveCaptain'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Garmin ActiveCaptain', NULL, 'https://www.garmin.com/en-US/p/573254', NULL, NULL, 'Garmin ActiveCaptain — застосунок для човнярів: карти, синхронізація з картплотером, Quickdraw-карти глибин і спільнота.', 'Garmin ActiveCaptain is a boating app: charts, chartplotter sync, Quickdraw depth maps and community.', 'Безкоштовний застосунок, що з''єднується з картплотерами Garmin, оновлює карти, передає маршрути, дає доступ до спільнотних точок інтересу й карт глибин Quickdraw.', 'A free app that connects to Garmin chartplotters, updates charts, transfers routes and gives access to community points of interest and Quickdraw depth maps.', 'Синхронізація з картплотером
Карти глибин
Спільнота', 'Chartplotter sync
Depth maps
Community', 'Човнярі й рибалки.', 'Boaters and anglers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'garmin.com/en-us/p/573254' OR LOWER(`name`) = LOWER('Garmin ActiveCaptain')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'fish' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Garmin ActiveCaptain is a boating app: charts, chartplotter sync, Quickdraw depth maps and community.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A free app that connects to Garmin chartplotters, updates charts, transfers routes and gives access to community points of interest and Quickdraw depth maps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Chartplotter sync
Depth maps
Community', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Boaters and anglers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Navionics — Риба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'navionics.com' OR LOWER(`name`) = LOWER('Navionics'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Navionics', NULL, 'https://www.navionics.com', NULL, NULL, 'Navionics (Garmin) — морські й озерні карти з глибинами для човнярів і рибалок у застосунку Boating.', 'Navionics (Garmin) offers marine and lake charts with depths for boaters and anglers in the Boating app.', 'Детальні навігаційні карти морів, озер і річок з ізобатами високої роздільності, маршрутами, даними спільноти й оновленнями; підписка для повних карт і офлайн-режиму.', 'Detailed charts of seas, lakes and rivers with high-resolution depth contours, routes, community data and updates; a subscription unlocks full charts and offline use.', 'Карти глибин
Маршрути
Офлайн-режим', 'Depth charts
Routes
Offline mode', 'Рибалки й човнярі.', 'Anglers and boaters.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'navionics.com' OR LOWER(`name`) = LOWER('Navionics')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'fish' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Navionics (Garmin) offers marine and lake charts with depths for boaters and anglers in the Boating app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Detailed charts of seas, lakes and rivers with high-resolution depth contours, routes, community data and updates; a subscription unlocks full charts and offline use.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Depth charts
Routes
Offline mode', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Anglers and boaters.', 'manual' FROM DUAL WHERE @new = 1;

-- Umitron — Риба
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'umitron.com' OR LOWER(`name`) = LOWER('Umitron'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Umitron', NULL, 'https://umitron.com', NULL, NULL, 'UMITRON — технології для аквакультури: розумні годівниці з AI, моніторинг апетиту риб і океанічні дані.', 'UMITRON offers aquaculture tech: AI smart feeders, fish appetite monitoring and ocean data.', 'Японська компанія, що пропонує рибним фермам розумні годівниці з дистанційним керуванням, AI-аналіз апетиту риби за відео та супутникові дані про стан океану для сталого виробництва.', 'A Japanese company offering fish farms remotely controlled smart feeders, AI analysis of fish appetite from video and satellite ocean data for sustainable production.', 'Розумні годівниці
AI-аналіз апетиту
Океанічні дані', 'Smart feeders
AI appetite analysis
Ocean data', 'Рибні ферми.', 'Fish farms.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'umitron.com' OR LOWER(`name`) = LOWER('Umitron')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'fish' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'UMITRON offers aquaculture tech: AI smart feeders, fish appetite monitoring and ocean data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Japanese company offering fish farms remotely controlled smart feeders, AI analysis of fish appetite from video and satellite ocean data for sustainable production.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Smart feeders
AI appetite analysis
Ocean data', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Fish farms.', 'manual' FROM DUAL WHERE @new = 1;

-- Apiary Book — Бджоли
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apiarybook.com' OR LOWER(`name`) = LOWER('Apiary Book'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Apiary Book', NULL, 'https://www.apiarybook.com', NULL, NULL, 'Apiary Book — застосунок для пасічників: облік вуликів і оглядів, обробок, медозбору й голосові нотатки.', 'Apiary Book is a beekeeping app: hive and inspection records, treatments, honey harvests and voice notes.', 'Електронний журнал пасіки: вулики й сім''ї, огляди з голосовим введенням, обробки від кліща, годування, медозбори, нагадування й звіти; працює офлайн, кількома мовами.', 'An electronic apiary log: hives and colonies, voice-entry inspections, mite treatments, feeding, harvests, reminders and reports; works offline in several languages.', 'Журнал оглядів
Голосове введення
Обробки й медозбір
Офлайн', 'Inspection log
Voice entry
Treatments and harvests
Offline', 'Пасічники.', 'Beekeepers.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apiarybook.com' OR LOWER(`name`) = LOWER('Apiary Book')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'beekeeping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Apiary Book is a beekeeping app: hive and inspection records, treatments, honey harvests and voice notes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An electronic apiary log: hives and colonies, voice-entry inspections, mite treatments, feeding, harvests, reminders and reports; works offline in several languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Inspection log
Voice entry
Treatments and harvests
Offline', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beekeepers.', 'manual' FROM DUAL WHERE @new = 1;

-- Bee Culture — Бджоли
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'beeculture.com' OR LOWER(`name`) = LOWER('Bee Culture'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bee Culture', NULL, 'https://beeculture.com', NULL, NULL, 'Bee Culture — американський журнал бджільництва з порадами, дослідженнями й новинами галузі.', 'Bee Culture is an American beekeeping magazine with advice, research and industry news.', 'Одне з найстаріших видань для пасічників: практичні поради з утримання бджіл, огляди досліджень про здоров''я бджіл, події й підписка на друкований та цифровий журнал.', 'One of the oldest publications for beekeepers: practical beekeeping advice, bee health research, events and print and digital subscriptions.', 'Практичні поради
Дослідження
Підписка', 'Practical advice
Research
Subscription', 'Пасічники.', 'Beekeepers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'beeculture.com' OR LOWER(`name`) = LOWER('Bee Culture')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'beekeeping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Bee Culture is an American beekeeping magazine with advice, research and industry news.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'One of the oldest publications for beekeepers: practical beekeeping advice, bee health research, events and print and digital subscriptions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Practical advice
Research
Subscription', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beekeepers.', 'manual' FROM DUAL WHERE @new = 1;

-- Beewise — Бджоли
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'beewise.ag' OR LOWER(`name`) = LOWER('Beewise'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Beewise', NULL, 'https://beewise.ag', NULL, NULL, 'Beewise — роботизовані вулики BeeHome з AI, що доглядають за бджолиними сім''ями й рятують бджіл.', 'Beewise makes AI-powered robotic BeeHome hives that care for colonies and save bees.', 'Автономні «бджолині будинки» з роботами й комп''ютерним зором, що відстежують стан сімей, борються з кліщем, годують і запобігають ройінню; пасічник керує дистанційно.', 'Autonomous bee homes with robotics and computer vision that track colony health, treat mites, feed and prevent swarming, managed remotely by the beekeeper.', 'Роботизовані вулики
Комп''ютерний зір
Дистанційне керування', 'Robotic hives
Computer vision
Remote management', 'Комерційні пасічники.', 'Commercial beekeepers.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'beewise.ag' OR LOWER(`name`) = LOWER('Beewise')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'beekeeping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Beewise makes AI-powered robotic BeeHome hives that care for colonies and save bees.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Autonomous bee homes with robotics and computer vision that track colony health, treat mites, feed and prevent swarming, managed remotely by the beekeeper.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Robotic hives
Computer vision
Remote management', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Commercial beekeepers.', 'manual' FROM DUAL WHERE @new = 1;

-- HiveKeepers — Бджоли
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hivekeepers.com' OR LOWER(`name`) = LOWER('HiveKeepers'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HiveKeepers', NULL, 'https://hivekeepers.com', NULL, NULL, 'HiveKeepers — мікромедогонка: відкачування меду з вулика в банку за хвилини без складного обладнання.', 'HiveKeepers offers a micro honey harvester: hive to jar in minutes without complex equipment.', 'Компактний пристрій для дрібних пасічників, що дозволяє швидко відкачати мед із рамок без великої медогонки, з інструкціями й підтримкою.', 'A compact device for small beekeepers that quickly extracts honey from frames without a large extractor, with instructions and support.', 'Мікромедогонка
Для малих пасік
Швидке відкачування', 'Micro harvester
For small apiaries
Fast extraction', 'Пасічники-аматори.', 'Hobby beekeepers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hivekeepers.com' OR LOWER(`name`) = LOWER('HiveKeepers')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'beekeeping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'HiveKeepers offers a micro honey harvester: hive to jar in minutes without complex equipment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A compact device for small beekeepers that quickly extracts honey from frames without a large extractor, with instructions and support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Micro harvester
For small apiaries
Fast extraction', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Hobby beekeepers.', 'manual' FROM DUAL WHERE @new = 1;

-- Honey Bee Health Coalition — Бджоли
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'honeybeehealthcoalition.org' OR LOWER(`name`) = LOWER('Honey Bee Health Coalition'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Honey Bee Health Coalition', NULL, 'https://honeybeehealthcoalition.org', NULL, NULL, 'Honey Bee Health Coalition — коаліція за здоров''я бджіл з безкоштовними посібниками з контролю кліща варроа.', 'The Honey Bee Health Coalition promotes bee health with free guides on varroa mite control.', 'Об''єднання пасічників, науковців і організацій, що публікує практичні посібники (Tools for Varroa Management), рекомендації щодо харчування бджіл і безпечного використання пестицидів.', 'A coalition of beekeepers, scientists and organizations publishing practical guides (Tools for Varroa Management) and advice on bee nutrition and safe pesticide use.', 'Посібник з варроа
Харчування бджіл
Безкоштовно', 'Varroa guide
Bee nutrition
Free', 'Пасічники.', 'Beekeepers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'honeybeehealthcoalition.org' OR LOWER(`name`) = LOWER('Honey Bee Health Coalition')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'beekeeping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Honey Bee Health Coalition promotes bee health with free guides on varroa mite control.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A coalition of beekeepers, scientists and organizations publishing practical guides (Tools for Varroa Management) and advice on bee nutrition and safe pesticide use.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Varroa guide
Bee nutrition
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beekeepers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Посібники', 'Guides' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Guides', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Pollenity — Бджоли
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pollenity.com' OR LOWER(`name`) = LOWER('Pollenity'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Pollenity', NULL, 'https://pollenity.com', NULL, NULL, 'Pollenity — «усиновлення» вулика й мед напряму від пасічника з підтримкою збереження бджіл.', 'Pollenity lets you adopt a hive and get honey directly from the beekeeper while supporting bee conservation.', 'Болгарський проєкт, де покупці «усиновлюють» вулик у пасічника, отримують його мед і новини про сім''ю, а пасічники — стабільний дохід.', 'A Bulgarian project where buyers adopt a hive from a beekeeper, receive its honey and colony updates, and beekeepers get stable income.', 'Усиновлення вулика
Мед від пасічника
Новини про сім''ю', 'Adopt a hive
Honey from the beekeeper
Colony updates', 'Любителі меду й бджіл.', 'Honey and bee lovers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pollenity.com' OR LOWER(`name`) = LOWER('Pollenity')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'beekeeping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Pollenity lets you adopt a hive and get honey directly from the beekeeper while supporting bee conservation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Bulgarian project where buyers adopt a hive from a beekeeper, receive its honey and colony updates, and beekeepers get stable income.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Adopt a hive
Honey from the beekeeper
Colony updates', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Honey and bee lovers.', 'manual' FROM DUAL WHERE @new = 1;

-- Allrecipes — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'allrecipes.com' OR LOWER(`name`) = LOWER('Allrecipes'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Allrecipes', NULL, 'https://www.allrecipes.com', NULL, NULL, 'Allrecipes — величезна база рецептів від домашніх кухарів з відгуками, фото й відеоінструкціями.', 'Allrecipes is a huge database of home cooks'' recipes with reviews, photos and how-to videos.', 'Один з найпопулярніших кулінарних сайтів світу: десятки тисяч рецептів з оцінками й порадами користувачів, добірки на свята, інгредієнтний пошук і збереження рецептів.', 'One of the world''s most popular cooking sites: tens of thousands of recipes with user ratings and tips, holiday collections, ingredient search and saved recipes.', 'Відгуки кухарів
Відеоінструкції
Пошук за інгредієнтами', 'Cook reviews
How-to videos
Ingredient search', 'Домашні кухарі.', 'Home cooks.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'allrecipes.com' OR LOWER(`name`) = LOWER('Allrecipes')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Allrecipes is a huge database of home cooks'' recipes with reviews, photos and how-to videos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'One of the world''s most popular cooking sites: tens of thousands of recipes with user ratings and tips, holiday collections, ingredient search and saved recipes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cook reviews
How-to videos
Ingredient search', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Home cooks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Anova — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'anovaculinary.com' OR LOWER(`name`) = LOWER('Anova'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Anova', NULL, 'https://anovaculinary.com', NULL, NULL, 'Anova — су-від занурювальні циркулятори й парова піч Precision Oven з керуванням і рецептами в застосунку.', 'Anova makes sous vide immersion circulators and the Precision Oven, with app control and recipes.', 'Пристрої для готування су-від з точним контролем температури через Wi-Fi та комбі-піч з парою. Застосунок містить сотні рецептів і керує приладом дистанційно.', 'Sous vide devices with precise Wi-Fi temperature control and a combi steam oven. The app holds hundreds of recipes and controls the device remotely.', 'Су-від
Парова піч
Рецепти в застосунку', 'Sous vide
Steam oven
In-app recipes', 'Кулінари-ентузіасти.', 'Cooking enthusiasts.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'anovaculinary.com' OR LOWER(`name`) = LOWER('Anova')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Anova makes sous vide immersion circulators and the Precision Oven, with app control and recipes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Sous vide devices with precise Wi-Fi temperature control and a combi steam oven. The app holds hundreds of recipes and controls the device remotely.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sous vide
Steam oven
In-app recipes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Cooking enthusiasts.', 'manual' FROM DUAL WHERE @new = 1;

-- BBC Good Food — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bbcgoodfood.com' OR LOWER(`name`) = LOWER('BBC Good Food'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BBC Good Food', NULL, 'https://www.bbcgoodfood.com', NULL, NULL, 'BBC Good Food — тисячі перевірених рецептів, поради з готування, харчування й плани меню від британського журналу.', 'BBC Good Food offers thousands of tested recipes, cooking tips, nutrition and meal plans from the British magazine.', 'Сайт журналу з рецептами, протестованими на кухні редакції, добірками за сезонами й дієтами, гідами з техніки та здорового харчування; Good Food Premium без реклами.', 'The magazine site with recipes tested in its kitchen, seasonal and diet collections, technique and healthy eating guides; Good Food Premium is ad-free.', 'Перевірені рецепти
Сезонні добірки
Гіди з харчування', 'Tested recipes
Seasonal collections
Nutrition guides', 'Домашні кухарі.', 'Home cooks.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bbcgoodfood.com' OR LOWER(`name`) = LOWER('BBC Good Food')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'BBC Good Food offers thousands of tested recipes, cooking tips, nutrition and meal plans from the British magazine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The magazine site with recipes tested in its kitchen, seasonal and diet collections, technique and healthy eating guides; Good Food Premium is ad-free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tested recipes
Seasonal collections
Nutrition guides', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Home cooks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'З рекламою', 'With ads' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'With ads', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Budget Bytes — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'budgetbytes.com' OR LOWER(`name`) = LOWER('Budget Bytes'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Budget Bytes', NULL, 'https://www.budgetbytes.com', NULL, NULL, 'Budget Bytes — смачні рецепти для економного бюджету з розрахунком вартості кожної страви й порції.', 'Budget Bytes offers tasty budget recipes with the cost of each dish and serving.', 'Сайт і застосунок з рецептами, де вказано вартість страви й порції, плани харчування на тиждень і поради з економного готування.', 'A site and app with recipes showing cost per recipe and per serving, weekly meal plans and budget cooking tips.', 'Вартість порції
Плани меню
Економні поради', 'Cost per serving
Meal plans
Budget tips', 'Студенти й сім''ї з обмеженим бюджетом.', 'Students and budget-minded families.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'budgetbytes.com' OR LOWER(`name`) = LOWER('Budget Bytes')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Budget Bytes offers tasty budget recipes with the cost of each dish and serving.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A site and app with recipes showing cost per recipe and per serving, weekly meal plans and budget cooking tips.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cost per serving
Meal plans
Budget tips', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Students and budget-minded families.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Cookidoo — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cookidoo.international' OR LOWER(`name`) = LOWER('Cookidoo'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Cookidoo', NULL, 'https://cookidoo.international', NULL, NULL, 'Cookidoo — офіційна платформа рецептів Thermomix: десятки тисяч рецептів із покроковим керуванням приладом.', 'Cookidoo is the official Thermomix recipe platform: tens of thousands of guided recipes.', 'Сервіс Vorwerk для власників Thermomix: рецепти з керованим готуванням на приладі, план тижня, список покупок і власні рецепти; повний доступ за підпискою.', 'Vorwerk''s service for Thermomix owners: guided cooking recipes sent to the device, weekly plans, shopping lists and custom recipes; full access by subscription.', 'Керовані рецепти
План тижня
Список покупок', 'Guided recipes
Weekly plan
Shopping list', 'Власники Thermomix.', 'Thermomix owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cookidoo.international' OR LOWER(`name`) = LOWER('Cookidoo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Cookidoo is the official Thermomix recipe platform: tens of thousands of guided recipes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Vorwerk''s service for Thermomix owners: guided cooking recipes sent to the device, weekly plans, shopping lists and custom recipes; full access by subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Guided recipes
Weekly plan
Shopping list', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Thermomix owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Crouton — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'crouton.app' OR LOWER(`name`) = LOWER('Crouton'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Crouton', NULL, 'https://crouton.app', NULL, NULL, 'Crouton — кулінарний менеджер рецептів для iOS: імпорт, план меню, список покупок і покрокове готування.', 'Crouton is an iOS recipe manager: import, meal planning, shopping list and step-by-step cooking.', 'Застосунок, що зберігає рецепти з сайтів, фото й нотатків, планує тиждень, формує список покупок і показує кроки великим шрифтом під час готування з таймерами.', 'An app that saves recipes from websites, photos and notes, plans the week, builds the shopping list and shows steps in large type while cooking, with timers.', 'Збереження рецептів
План тижня
Список покупок', 'Recipe saving
Weekly plan
Shopping list', 'Користувачі iPhone.', 'iPhone users.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'crouton.app' OR LOWER(`name`) = LOWER('Crouton')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Crouton is an iOS recipe manager: import, meal planning, shopping list and step-by-step cooking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app that saves recipes from websites, photos and notes, plans the week, builds the shopping list and shows steps in large type while cooking, with timers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Recipe saving
Weekly plan
Shopping list', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'iPhone users.', 'manual' FROM DUAL WHERE @new = 1;

-- Eat This Much — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eatthismuch.com' OR LOWER(`name`) = LOWER('Eat This Much'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Eat This Much', NULL, 'https://www.eatthismuch.com', NULL, NULL, 'Eat This Much — автоматичний планувальник харчування за калоріями, бюджетом і розкладом зі списками покупок.', 'Eat This Much is an automatic meal planner by calories, budget and schedule with grocery lists.', 'Генерує денні й тижневі плани харчування під цільові калорії та макроелементи, дієту (кето, веганство тощо), бюджет і час на готування, формує списки покупок; Premium додає тижневі плани й доставку.', 'It generates daily and weekly meal plans for target calories and macros, diet (keto, vegan and more), budget and cooking time and builds grocery lists; Premium adds weekly plans and delivery.', 'Плани за калоріями
Дієти
Бюджет
Списки покупок', 'Calorie-based plans
Diets
Budget
Grocery lists', 'Ті, хто стежить за харчуванням.', 'People tracking nutrition.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'eatthismuch.com' OR LOWER(`name`) = LOWER('Eat This Much')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Eat This Much is an automatic meal planner by calories, budget and schedule with grocery lists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It generates daily and weekly meal plans for target calories and macros, diet (keto, vegan and more), budget and cooking time and builds grocery lists; Premium adds weekly plans and delivery.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Calorie-based plans
Diets
Budget
Grocery lists', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People tracking nutrition.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Денні плани', 'Daily plans' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Daily plans', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Epicurious — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'epicurious.com' OR LOWER(`name`) = LOWER('Epicurious'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Epicurious', NULL, 'https://www.epicurious.com', NULL, NULL, 'Epicurious (Condé Nast) — рецепти, ідеї меню, відео й кулінарні поради з архівом Bon Appétit і Gourmet.', 'Epicurious (Condé Nast) offers recipes, menu ideas, videos and cooking tips with the Bon Appétit and Gourmet archive.', 'Великий кулінарний сайт з рецептами, оглядами інструментів, ідеями на свята та архівом рецептів журналів; частина контенту за підпискою.', 'A large cooking site with recipes, tool reviews, holiday ideas and magazine recipe archives; some content requires a subscription.', 'Архів журналів
Ідеї меню
Огляди інструментів', 'Magazine archives
Menu ideas
Tool reviews', 'Любителі кулінарії.', 'Cooking enthusiasts.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'epicurious.com' OR LOWER(`name`) = LOWER('Epicurious')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Epicurious (Condé Nast) offers recipes, menu ideas, videos and cooking tips with the Bon Appétit and Gourmet archive.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A large cooking site with recipes, tool reviews, holiday ideas and magazine recipe archives; some content requires a subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Magazine archives
Menu ideas
Tool reviews', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Cooking enthusiasts.', 'manual' FROM DUAL WHERE @new = 1;

-- Food Network — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'foodnetwork.com' OR LOWER(`name`) = LOWER('Food Network'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Food Network', NULL, 'https://www.foodnetwork.com', NULL, NULL, 'Food Network — рецепти від шеф-кухарів телеканалу, кулінарні шоу та відеокласи Food Network Kitchen.', 'Food Network offers recipes from TV chefs, cooking shows and Food Network Kitchen video classes.', 'Сайт телеканалу з рецептами зірок, відео з шоу, порадами й добірками на свята; застосунок Food Network Kitchen пропонує живі й записані кулінарні класи за підпискою.', 'The channel''s site with celebrity chef recipes, show videos, tips and holiday roundups; the Food Network Kitchen app offers live and on-demand classes by subscription.', 'Рецепти шефів
Відео шоу
Кулінарні класи', 'Chef recipes
Show videos
Cooking classes', 'Глядачі кулінарних шоу.', 'Cooking show fans.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'foodnetwork.com' OR LOWER(`name`) = LOWER('Food Network')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Food Network offers recipes from TV chefs, cooking shows and Food Network Kitchen video classes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The channel''s site with celebrity chef recipes, show videos, tips and holiday roundups; the Food Network Kitchen app offers live and on-demand classes by subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Chef recipes
Show videos
Cooking classes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Cooking show fans.', 'manual' FROM DUAL WHERE @new = 1;

-- HelloFresh — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hellofresh.com' OR LOWER(`name`) = LOWER('HelloFresh'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HelloFresh', NULL, 'https://www.hellofresh.com', NULL, NULL, 'HelloFresh — набори для приготування страв з рецептами й порційними інгредієнтами за підпискою.', 'HelloFresh delivers meal kits with recipes and pre-portioned ingredients by subscription.', 'Найбільший сервіс meal-kit: щотижня обираєте страви з меню, отримуєте коробку з інгредієнтами й картками рецептів; є готові страви й добавки, підписку легко пауза.', 'The largest meal-kit service: pick dishes from a weekly menu and get a box with ingredients and recipe cards; ready meals and add-ons are available and subscriptions are easy to pause.', 'Набори для страв
Щотижневе меню
Готові страви', 'Meal kits
Weekly menu
Ready meals', 'Зайняті сім''ї.', 'Busy families.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hellofresh.com' OR LOWER(`name`) = LOWER('HelloFresh')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'HelloFresh delivers meal kits with recipes and pre-portioned ingredients by subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The largest meal-kit service: pick dishes from a weekly menu and get a box with ingredients and recipe cards; ready meals and add-ons are available and subscriptions are easy to pause.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Meal kits
Weekly menu
Ready meals', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Busy families.', 'manual' FROM DUAL WHERE @new = 1;

-- Jow — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jow.com' OR LOWER(`name`) = LOWER('Jow'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Jow', NULL, 'https://jow.com', NULL, NULL, 'Jow — меню на тиждень і продуктовий кошик за хвилину: застосунок підбирає рецепти й передає список у супермаркет.', 'Jow builds a weekly menu and grocery basket in a minute: the app picks recipes and sends the list to a supermarket.', 'Французький застосунок, що пропонує прості рецепти, формує кошик і відправляє його в партнерські супермаркети для доставки чи самовивозу.', 'A French app that suggests simple recipes, builds a basket and sends it to partner supermarkets for delivery or pickup.', 'Меню на тиждень
Кошик за хвилину
Партнерські супермаркети', 'Weekly menu
Basket in a minute
Partner supermarkets', 'Зайняті сім''ї в Європі.', 'Busy families in Europe.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'jow.com' OR LOWER(`name`) = LOWER('Jow')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Jow builds a weekly menu and grocery basket in a minute: the app picks recipes and sends the list to a supermarket.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A French app that suggests simple recipes, builds a basket and sends it to partner supermarkets for delivery or pickup.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Weekly menu
Basket in a minute
Partner supermarkets', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Busy families in Europe.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kitchen Stories — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kitchenstories.com' OR LOWER(`name`) = LOWER('Kitchen Stories'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kitchen Stories', NULL, 'https://www.kitchenstories.com', NULL, NULL, 'Kitchen Stories — рецепти з покроковими фото й відео, кулінарні техніки та спільнота кухарів.', 'Kitchen Stories offers recipes with step-by-step photos and videos, cooking techniques and a community.', 'Берлінська платформа з рецептами, що мають фото кожного кроку, відеоуроки з технік, список покупок і рецепти від спільноти; доступна кількома мовами.', 'A Berlin platform with recipes illustrated at every step, technique videos, a shopping list and community recipes; available in several languages.', 'Покрокові фото
Відеоуроки технік
Список покупок', 'Step photos
Technique videos
Shopping list', 'Кухарі-початківці.', 'Beginner cooks.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kitchenstories.com' OR LOWER(`name`) = LOWER('Kitchen Stories')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Kitchen Stories offers recipes with step-by-step photos and videos, cooking techniques and a community.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Berlin platform with recipes illustrated at every step, technique videos, a shopping list and community recipes; available in several languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Step photos
Technique videos
Shopping list', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Beginner cooks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mealie — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mealie.io' OR LOWER(`name`) = LOWER('Mealie'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mealie', NULL, 'https://mealie.io', NULL, NULL, 'Mealie — відкритий самостійно розміщуваний менеджер рецептів і планувальник харчування для сім''ї.', 'Mealie is an open-source self-hosted recipe manager and meal planner for families.', 'Веб-застосунок з імпортом рецептів за посиланням, плануванням меню, списками покупок, групами користувачів і API; розгортається через Docker.', 'A web app with recipe import by URL, meal planning, shopping lists, user groups and an API; deployed via Docker.', 'Імпорт за посиланням
План меню
Docker
Open source', 'URL import
Meal plans
Docker
Open source', 'Технічно підковані сім''ї.', 'Tech-savvy families.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mealie.io' OR LOWER(`name`) = LOWER('Mealie')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mealie is an open-source self-hosted recipe manager and meal planner for families.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A web app with recipe import by URL, meal planning, shopping lists, user groups and an API; deployed via Docker.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'URL import
Meal plans
Docker
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tech-savvy families.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Self-hosted', 'Self-hosted' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Self-hosted', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Mealime — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mealime.com' OR LOWER(`name`) = LOWER('Mealime'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mealime', NULL, 'https://www.mealime.com', NULL, NULL, 'Mealime — безкоштовний планувальник здорового харчування: персональні плани страв, прості рецепти й розумний список покупок.', 'Mealime is a free healthy meal planner: personal meal plans, easy recipes and a smart grocery list.', 'Застосунок складає план страв з урахуванням дієти, алергій і нелюбимих продуктів, генерує список покупок, впорядкований за відділами, і дає покрокові рецепти на 30 хвилин. Mealime Pro додає розширені функції й підрахунок поживних речовин.', 'The app builds a meal plan around diet, allergies and disliked foods, generates a grocery list sorted by aisle and gives step-by-step 30-minute recipes. Mealime Pro adds advanced features and nutrition info.', 'Персональні плани
Список покупок
Рецепти на 30 хв', 'Personal plans
Grocery list
30-minute recipes', 'Ті, хто готує вдома.', 'Home cooks.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mealime.com' OR LOWER(`name`) = LOWER('Mealime')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mealime is a free healthy meal planner: personal meal plans, easy recipes and a smart grocery list.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app builds a meal plan around diet, allergies and disliked foods, generates a grocery list sorted by aisle and gives step-by-step 30-minute recipes. Mealime Pro adds advanced features and nutrition info.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Personal plans
Grocery list
30-minute recipes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Home cooks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базова версія', 'Basic version' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic version', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MEATER — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'meater.com' OR LOWER(`name`) = LOWER('MEATER'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MEATER', NULL, 'https://meater.com', NULL, NULL, 'MEATER — бездротовий розумний термометр для м''яса з застосунком, що прогнозує готовність і час відпочинку.', 'MEATER is a wireless smart meat thermometer with an app predicting doneness and rest time.', 'Щуп без дротів вимірює внутрішню температуру м''яса й навколишнього середовища, а застосунок показує прогноз часу до готовності, сповіщає й пропонує керовані рецепти.', 'A wire-free probe measures internal meat and ambient temperature, and the app shows estimated time to doneness, sends alerts and offers guided recipes.', 'Бездротовий щуп
Прогноз готовності
Сповіщення', 'Wire-free probe
Doneness estimate
Alerts', 'Любителі гриля й барбекю.', 'Grill and BBQ fans.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'meater.com' OR LOWER(`name`) = LOWER('MEATER')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'MEATER is a wireless smart meat thermometer with an app predicting doneness and rest time.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A wire-free probe measures internal meat and ambient temperature, and the app shows estimated time to doneness, sends alerts and offers guided recipes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Wire-free probe
Doneness estimate
Alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Grill and BBQ fans.', 'manual' FROM DUAL WHERE @new = 1;

-- Mela — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mela.recipes' OR LOWER(`name`) = LOWER('Mela'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mela', NULL, 'https://mela.recipes', NULL, NULL, 'Mela — менеджер рецептів для Apple-пристроїв: імпорт із сайтів, план страв, список покупок і режим готування.', 'Mela is a recipe manager for Apple devices: web import, meal planning, shopping list and cook mode.', 'Застосунок для iPhone, iPad і Mac, що зберігає рецепти без реклами, розпізнає їх зі сторінок і фото, синхронізує через iCloud, додає інгредієнти до Нагадувань і має режим готування з таймерами.', 'An iPhone, iPad and Mac app that stores recipes ad-free, extracts them from pages and photos, syncs via iCloud, adds ingredients to Reminders and has a cook mode with timers.', 'Імпорт рецептів
Синхронізація iCloud
Режим готування', 'Recipe import
iCloud sync
Cook mode', 'Користувачі Apple.', 'Apple users.', 'mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mela.recipes' OR LOWER(`name`) = LOWER('Mela')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mela is a recipe manager for Apple devices: web import, meal planning, shopping list and cook mode.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An iPhone, iPad and Mac app that stores recipes ad-free, extracts them from pages and photos, syncs via iCloud, adds ingredients to Reminders and has a cook mode with timers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Recipe import
iCloud sync
Cook mode', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Apple users.', 'manual' FROM DUAL WHERE @new = 1;

-- NYT Cooking — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cooking.nytimes.com' OR LOWER(`name`) = LOWER('NYT Cooking'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NYT Cooking', NULL, 'https://cooking.nytimes.com', NULL, NULL, 'NYT Cooking — рецепти The New York Times з перевіреними інструкціями, нотатками читачів і підпискою.', 'NYT Cooking offers The New York Times'' tested recipes with reader notes and a subscription.', 'Колекція понад 20 000 рецептів від редакції NYT з відео, порадами з техніки, нотатками спільноти, «рецептною скринькою» й плануванням. Повний доступ — за підпискою.', 'A collection of 20,000+ recipes from the NYT food desk with videos, technique guides, community notes, a recipe box and planning. Full access requires a subscription.', '20 000+ рецептів
Нотатки читачів
Відео
Підписка', '20,000+ recipes
Reader notes
Videos
Subscription', 'Любителі кулінарії.', 'Cooking enthusiasts.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cooking.nytimes.com' OR LOWER(`name`) = LOWER('NYT Cooking')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'NYT Cooking offers The New York Times'' tested recipes with reader notes and a subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A collection of 20,000+ recipes from the NYT food desk with videos, technique guides, community notes, a recipe box and planning. Full access requires a subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '20,000+ recipes
Reader notes
Videos
Subscription', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Cooking enthusiasts.', 'manual' FROM DUAL WHERE @new = 1;

-- Plan to Eat — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'plantoeat.com' OR LOWER(`name`) = LOWER('Plan to Eat'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Plan to Eat', NULL, 'https://www.plantoeat.com', NULL, NULL, 'Plan to Eat — організатор рецептів, планувальник меню й автоматичні списки покупок; 5,95 $ на місяць або 49 $ на рік.', 'Plan to Eat is a recipe organizer, meal planner and automatic grocery list; $5.95 a month or $49 a year.', 'Сервіс імпортує рецепти з будь-яких сайтів, дозволяє перетягувати їх у календар меню й автоматично формує список покупок. Пробний період 14 днів без картки.', 'The service imports recipes from any website, lets you drag them onto a meal calendar and builds the grocery list automatically. 14-day free trial, no card needed.', 'Імпорт рецептів
Календар меню
Автосписок покупок
14 днів безкоштовно', 'Recipe import
Meal calendar
Auto grocery list
14-day trial', 'Сім''ї, що планують харчування.', 'Families planning meals.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'plantoeat.com' OR LOWER(`name`) = LOWER('Plan to Eat')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Plan to Eat is a recipe organizer, meal planner and automatic grocery list; $5.95 a month or $49 a year.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The service imports recipes from any website, lets you drag them onto a meal calendar and builds the grocery list automatically. 14-day free trial, no card needed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Recipe import
Meal calendar
Auto grocery list
14-day trial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Families planning meals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Щомісяця', 'Monthly', 5.95, 'month', 'Після 14-денного пробного періоду', 'After 14-day trial' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Щомісяця' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Monthly', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'After 14-day trial', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Щороку', 'Yearly', 49.00, 'year', 'Оплата за рік', 'Billed yearly' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Щороку' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Yearly', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Billed yearly', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ReciMe — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'recime.app' OR LOWER(`name`) = LOWER('ReciMe'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ReciMe', NULL, 'https://www.recime.app', NULL, NULL, 'ReciMe — збереження рецептів з Instagram, TikTok і сайтів в одному місці з планом меню й списком покупок.', 'ReciMe saves recipes from Instagram, TikTok and websites in one place with meal planning and shopping lists.', 'Застосунок імпортує рецепти з соцмереж і сайтів, автоматично витягує інгредієнти й кроки, дозволяє планувати страви, підраховує калорії й формує список покупок.', 'The app imports recipes from social media and websites, extracts ingredients and steps automatically, plans meals, counts calories and builds a shopping list.', 'Імпорт із соцмереж
План меню
Калорії
Список покупок', 'Social media import
Meal plans
Calories
Shopping list', 'Любителі рецептів із соцмереж.', 'Social media recipe fans.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'recime.app' OR LOWER(`name`) = LOWER('ReciMe')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ReciMe saves recipes from Instagram, TikTok and websites in one place with meal planning and shopping lists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app imports recipes from social media and websites, extracts ingredients and steps automatically, plans meals, counts calories and builds a shopping list.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Social media import
Meal plans
Calories
Shopping list', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Social media recipe fans.', 'manual' FROM DUAL WHERE @new = 1;

-- Serious Eats — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'seriouseats.com' OR LOWER(`name`) = LOWER('Serious Eats'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Serious Eats', NULL, 'https://www.seriouseats.com', NULL, NULL, 'Serious Eats — наукові пояснення кулінарних технік, перевірені рецепти й огляди кухонного обладнання.', 'Serious Eats explains cooking science, tested recipes and kitchen equipment reviews.', 'Видання, що пояснює, чому рецепти працюють: глибокі статті про техніки, тестування способів готування, огляди ножів, сковорідок і техніки.', 'A publication explaining why recipes work: deep technique articles, method testing and reviews of knives, pans and appliances.', 'Наука кулінарії
Перевірені рецепти
Огляди обладнання', 'Food science
Tested recipes
Equipment reviews', 'Кулінари-ентузіасти.', 'Cooking enthusiasts.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'seriouseats.com' OR LOWER(`name`) = LOWER('Serious Eats')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Serious Eats explains cooking science, tested recipes and kitchen equipment reviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A publication explaining why recipes work: deep technique articles, method testing and reviews of knives, pans and appliances.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Food science
Tested recipes
Equipment reviews', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Cooking enthusiasts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Supercook — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'supercook.com' OR LOWER(`name`) = LOWER('Supercook'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Supercook', NULL, 'https://www.supercook.com', NULL, NULL, 'Supercook — пошук рецептів за продуктами, які вже є вдома: вкажіть інгредієнти й отримайте страви.', 'Supercook searches recipes by ingredients you already have at home.', 'Вводите продукти з холодильника й комори (вручну чи голосом), і сервіс знаходить рецепти з найбільшою кількістю збігів з тисяч кулінарних сайтів, допомагаючи менше викидати їжі.', 'Enter what''s in your fridge and pantry (typed or by voice) and the service finds recipes with the most matches from thousands of cooking sites, helping reduce food waste.', 'Пошук за продуктами
Голосове введення
Тисячі сайтів', 'Ingredient search
Voice input
Thousands of sites', 'Домашні кухарі.', 'Home cooks.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'supercook.com' OR LOWER(`name`) = LOWER('Supercook')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Supercook searches recipes by ingredients you already have at home.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Enter what''s in your fridge and pantry (typed or by voice) and the service finds recipes with the most matches from thousands of cooking sites, helping reduce food waste.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Ingredient search
Voice input
Thousands of sites', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Home cooks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт і застосунок', 'Site and app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Site and app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tandoor Recipes — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tandoor.dev' OR LOWER(`name`) = LOWER('Tandoor Recipes'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tandoor Recipes', NULL, 'https://tandoor.dev', NULL, NULL, 'Tandoor — самостійно розміщуваний менеджер рецептів з відкритим кодом: імпорт, план харчування й списки покупок.', 'Tandoor is a self-hosted open-source recipe manager: import, meal planning and shopping lists.', 'Веб-застосунок для власного сервера: імпорт рецептів із сайтів, розподіл за книгами, планування харчування, списки покупок, спільний доступ для родини та підтримка багатьох мов. Є також хмарна версія.', 'A web app for your own server: recipe import from websites, cookbooks, meal planning, shopping lists, family sharing and many languages. A hosted version is also available.', 'Self-hosted
Імпорт рецептів
План харчування
Open source', 'Self-hosted
Recipe import
Meal planning
Open source', 'Технічно підковані кухарі.', 'Tech-savvy cooks.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tandoor.dev' OR LOWER(`name`) = LOWER('Tandoor Recipes')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tandoor is a self-hosted open-source recipe manager: import, meal planning and shopping lists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A web app for your own server: recipe import from websites, cookbooks, meal planning, shopping lists, family sharing and many languages. A hosted version is also available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Self-hosted
Recipe import
Meal planning
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tech-savvy cooks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Open source', 'Open source', 0.00, 'free', 'Self-hosted', 'Self-hosted' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Open source' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Self-hosted', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Tasty — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tasty.co' OR LOWER(`name`) = LOWER('Tasty'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tasty', NULL, 'https://tasty.co', NULL, NULL, 'Tasty (BuzzFeed) — короткі відеорецепти, покрокові інструкції й добірки страв у застосунку.', 'Tasty (BuzzFeed) offers short recipe videos, step-by-step instructions and dish collections in an app.', 'Популярний бренд кулінарних відео з тисячами рецептів, режимом покрокового готування, пошуком за інгредієнтами й добірками на кожен день.', 'A popular cooking video brand with thousands of recipes, step-by-step cook mode, ingredient search and everyday collections.', 'Відеорецепти
Покроковий режим
Пошук за інгредієнтами', 'Recipe videos
Step-by-step mode
Ingredient search', 'Молоді кухарі.', 'Young cooks.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tasty.co' OR LOWER(`name`) = LOWER('Tasty')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tasty (BuzzFeed) offers short recipe videos, step-by-step instructions and dish collections in an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A popular cooking video brand with thousands of recipes, step-by-step cook mode, ingredient search and everyday collections.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Recipe videos
Step-by-step mode
Ingredient search', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Young cooks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок і сайт', 'App and site' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App and site', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Пательня — Кулінарія
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'patelnya.com.ua' OR LOWER(`name`) = LOWER('Пательня'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Пательня', NULL, 'https://patelnya.com.ua', NULL, NULL, 'Пательня — український кулінарний сайт з рецептами з фото, покроковими інструкціями й добірками страв.', 'Patelnya is a Ukrainian cooking site with photo recipes, step-by-step instructions and collections.', 'Сайт українською мовою з тисячами рецептів із фотографіями: перші й другі страви, випічка, заготовки, десерти, з пошуком і рубриками.', 'A Ukrainian-language site with thousands of photo recipes: soups, mains, baking, preserves and desserts, with search and categories.', 'Рецепти з фото
Українською
Пошук і рубрики', 'Photo recipes
In Ukrainian
Search and categories', 'Домашні кухарі в Україні.', 'Home cooks in Ukraine.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'patelnya.com.ua' OR LOWER(`name`) = LOWER('Пательня')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'cooking' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Patelnya is a Ukrainian cooking site with photo recipes, step-by-step instructions and collections.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Ukrainian-language site with thousands of photo recipes: soups, mains, baking, preserves and desserts, with search and categories.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Photo recipes
In Ukrainian
Search and categories', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Home cooks in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Airvet — Грумінг та ветеринарні сервіси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'airvet.com' OR LOWER(`name`) = LOWER('Airvet'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Airvet', NULL, 'https://www.airvet.com', NULL, NULL, 'Airvet — ветеринарна телемедицина: відеодзвінок з ветеринаром за хвилини 24/7.', 'Airvet is vet telehealth: video call a vet within minutes, 24/7.', 'Застосунок з''єднує власника з ліцензованим ветеринаром за відеозв''язком у будь-який час доби; часто пропонується як пільга від роботодавця.', 'The app connects owners to a licensed vet by video at any hour; often offered as an employer benefit.', 'Відео 24/7
Ліцензовані ветеринари
Пільга від роботодавця', '24/7 video
Licensed vets
Employer benefit', 'Власники тварин у США.', 'US pet owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'airvet.com' OR LOWER(`name`) = LOWER('Airvet')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pet-grooming-vet' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Airvet is vet telehealth: video call a vet within minutes, 24/7.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app connects owners to a licensed vet by video at any hour; often offered as an employer benefit.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '24/7 video
Licensed vets
Employer benefit', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US pet owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Bond Vet — Грумінг та ветеринарні сервіси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bondvet.com' OR LOWER(`name`) = LOWER('Bond Vet'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bond Vet', NULL, 'https://bondvet.com', NULL, NULL, 'Bond Vet — мережа клінік первинної й невідкладної допомоги для тварин з онлайн-записом і застосунком.', 'Bond Vet is a network of primary and urgent pet care clinics with online booking and an app.', 'Клініки на Північному Сході США, що працюють сім днів на тиждень, приймають і планові, і термінові візити, мають онлайн-запис і медкартки в застосунку.', 'Clinics in the US Northeast open seven days a week for routine and urgent visits, with online booking and records in the app.', 'Первинна й невідкладна
Онлайн-запис
Медкартки', 'Primary and urgent
Online booking
Records', 'Власники тварин у США.', 'US pet owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bondvet.com' OR LOWER(`name`) = LOWER('Bond Vet')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pet-grooming-vet' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Bond Vet is a network of primary and urgent pet care clinics with online booking and an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Clinics in the US Northeast open seven days a week for routine and urgent visits, with online booking and records in the app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Primary and urgent
Online booking
Records', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US pet owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Digitail — Грумінг та ветеринарні сервіси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'digitail.com' OR LOWER(`name`) = LOWER('Digitail'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Digitail', NULL, 'https://digitail.com', NULL, NULL, 'Digitail — ПЗ для ветклінік з AI-асистентом, онлайн-записом, клієнтським застосунком і телемедициною.', 'Digitail is vet practice software with an AI assistant, online booking, a client app and telemedicine.', 'Хмарна система керування практикою: медкартки з AI-підказками й записами, розклад, рахунки, застосунок для власників з чатом і відеоконсультаціями.', 'A cloud practice management system: medical records with AI suggestions and notes, scheduling, invoicing and an owner app with chat and video visits.', 'AI-асистент
Онлайн-запис
Клієнтський застосунок
Телемедицина', 'AI assistant
Online booking
Client app
Telemedicine', 'Ветеринарні клініки.', 'Vet clinics.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'digitail.com' OR LOWER(`name`) = LOWER('Digitail')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pet-grooming-vet' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Digitail is vet practice software with an AI assistant, online booking, a client app and telemedicine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A cloud practice management system: medical records with AI suggestions and notes, scheduling, invoicing and an owner app with chat and video visits.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI assistant
Online booking
Client app
Telemedicine', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Vet clinics.', 'manual' FROM DUAL WHERE @new = 1;

-- Dutch — Грумінг та ветеринарні сервіси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dutch.com' OR LOWER(`name`) = LOWER('Dutch'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dutch', NULL, 'https://www.dutch.com', NULL, NULL, 'Dutch — онлайн-ветеринарна допомога й рецепти для собак і котів за членством з доставкою ліків.', 'Dutch offers online vet care and prescriptions for dogs and cats by membership with medication delivery.', 'Сервіс членства з необмеженими відеоконсультаціями ветеринарів, планами лікування, рецептами й доставкою ліків до дверей.', 'A membership service with unlimited vet video visits, treatment plans, prescriptions and medication delivered to your door.', 'Необмежені консультації
Рецепти
Доставка ліків', 'Unlimited visits
Prescriptions
Medication delivery', 'Власники тварин у США.', 'US pet owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dutch.com' OR LOWER(`name`) = LOWER('Dutch')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pet-grooming-vet' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Dutch offers online vet care and prescriptions for dogs and cats by membership with medication delivery.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A membership service with unlimited vet video visits, treatment plans, prescriptions and medication delivered to your door.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Unlimited visits
Prescriptions
Medication delivery', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US pet owners.', 'manual' FROM DUAL WHERE @new = 1;

-- ezyVet — Грумінг та ветеринарні сервіси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ezyvet.com' OR LOWER(`name`) = LOWER('ezyVet'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ezyVet', NULL, 'https://www.ezyvet.com', NULL, NULL, 'ezyVet — хмарне ПЗ для керування ветеринарною клінікою: медкартки, розклад, рахунки й аналітика.', 'ezyVet is cloud veterinary practice management software: records, scheduling, invoicing and analytics.', 'Система (IDEXX) для клінік загальної практики, спеціалізованих і невідкладних: електронні медкартки, розклад, склад, рахунки, інтеграції з лабораторіями та звіти.', 'A system (IDEXX) for general, specialty and emergency clinics: electronic records, scheduling, inventory, invoicing, lab integrations and reports.', 'Медкартки
Розклад
Склад
Лабораторні інтеграції', 'Medical records
Scheduling
Inventory
Lab integrations', 'Ветеринарні клініки.', 'Vet clinics.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ezyvet.com' OR LOWER(`name`) = LOWER('ezyVet')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pet-grooming-vet' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ezyVet is cloud veterinary practice management software: records, scheduling, invoicing and analytics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A system (IDEXX) for general, specialty and emergency clinics: electronic records, scheduling, inventory, invoicing, lab integrations and reports.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Medical records
Scheduling
Inventory
Lab integrations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Vet clinics.', 'manual' FROM DUAL WHERE @new = 1;

-- FirstVet — Грумінг та ветеринарні сервіси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'firstvet.com' OR LOWER(`name`) = LOWER('FirstVet'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'FirstVet', NULL, 'https://firstvet.com', NULL, NULL, 'FirstVet — онлайн-ветеринар у застосунку: відеоконсультація за хвилини в Європі та США.', 'FirstVet is an online vet in an app: video consultation within minutes in Europe and the US.', 'Шведський сервіс ветеринарної телемедицини, що працює в кількох європейських країнах і США; часто включений у страховку тварин. Ветеринари оцінюють стан і радять, чи потрібен візит до клініки.', 'A Swedish vet telehealth service in several European countries and the US, often included in pet insurance. Vets assess the condition and advise whether a clinic visit is needed.', 'Відео за хвилини
Європа й США
Через страхування', 'Video in minutes
Europe and US
Via insurance', 'Власники тварин.', 'Pet owners.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'firstvet.com' OR LOWER(`name`) = LOWER('FirstVet')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pet-grooming-vet' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'FirstVet is an online vet in an app: video consultation within minutes in Europe and the US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Swedish vet telehealth service in several European countries and the US, often included in pet insurance. Vets assess the condition and advise whether a clinic visit is needed.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Video in minutes
Europe and US
Via insurance', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Pet owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Gingr — Грумінг та ветеринарні сервіси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gingrapp.com' OR LOWER(`name`) = LOWER('Gingr'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Gingr', NULL, 'https://www.gingrapp.com', NULL, NULL, 'Gingr — ПЗ для грумінгу, дресирування, денного догляду й готелів для собак: бронювання, оплата, звіти.', 'Gingr is software for grooming, training, dog daycare and kennels: bookings, payments and reports.', 'Платформа для бізнесу догляду за тваринами: онлайн-бронювання для клієнтів, розклад, облік вакцинацій, POS, звіти, фото-оновлення для власників.', 'A platform for pet care businesses: client online booking, scheduling, vaccination tracking, POS, reports and photo updates for owners.', 'Онлайн-бронювання
Облік вакцинацій
POS
Звіти', 'Online booking
Vaccination tracking
POS
Reports', 'Грумери й зоготелі.', 'Groomers and kennels.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'gingrapp.com' OR LOWER(`name`) = LOWER('Gingr')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pet-grooming-vet' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Gingr is software for grooming, training, dog daycare and kennels: bookings, payments and reports.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform for pet care businesses: client online booking, scheduling, vaccination tracking, POS, reports and photo updates for owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online booking
Vaccination tracking
POS
Reports', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Groomers and kennels.', 'manual' FROM DUAL WHERE @new = 1;

-- Joii Pet Care — Грумінг та ветеринарні сервіси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'joiipetcare.com' OR LOWER(`name`) = LOWER('Joii Pet Care'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Joii Pet Care', NULL, 'https://www.joiipetcare.com', NULL, NULL, 'Joii — британський застосунок онлайн-ветеринарних консультацій, перевірки симптомів і порад із харчування.', 'Joii is a UK app for online vet consultations, symptom checks and nutrition advice.', 'Сервіс з відеоконсультаціями ветеринарів і ветмедсестер, перевіркою симптомів, програмами контролю ваги й порадами; часто доступний через страховиків.', 'A service with video consultations with vets and vet nurses, a symptom checker, weight programs and advice; often available through insurers.', 'Відеоконсультації
Перевірка симптомів
Контроль ваги', 'Video consults
Symptom checker
Weight programs', 'Власники тварин у Британії.', 'UK pet owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'joiipetcare.com' OR LOWER(`name`) = LOWER('Joii Pet Care')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pet-grooming-vet' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Joii is a UK app for online vet consultations, symptom checks and nutrition advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service with video consultations with vets and vet nurses, a symptom checker, weight programs and advice; often available through insurers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Video consults
Symptom checker
Weight programs', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'UK pet owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Modern Animal — Грумінг та ветеринарні сервіси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'modernanimal.com' OR LOWER(`name`) = LOWER('Modern Animal'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Modern Animal', NULL, 'https://www.modernanimal.com', NULL, NULL, 'Modern Animal — мережа ветклінік за членством з необмеженим чатом з ветеринаром у застосунку.', 'Modern Animal is a membership vet clinic network with unlimited in-app vet chat.', 'Американські клініки з членством, що включає необмежені огляди, цілодобовий чат з командою ветеринарів і запис через застосунок.', 'US clinics with a membership including unlimited exams, 24/7 chat with the vet team and booking via the app.', 'Членство
Чат 24/7
Запис у застосунку', 'Membership
24/7 chat
App booking', 'Власники тварин у США.', 'US pet owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'modernanimal.com' OR LOWER(`name`) = LOWER('Modern Animal')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pet-grooming-vet' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Modern Animal is a membership vet clinic network with unlimited in-app vet chat.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'US clinics with a membership including unlimited exams, 24/7 chat with the vet team and booking via the app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Membership
24/7 chat
App booking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US pet owners.', 'manual' FROM DUAL WHERE @new = 1;

-- MoeGo — Грумінг та ветеринарні сервіси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moego.pet' OR LOWER(`name`) = LOWER('MoeGo'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MoeGo', NULL, 'https://www.moego.pet', NULL, NULL, 'MoeGo — універсальне ПЗ для грумерів і зообізнесу: запис, маршрути мобільного грумінгу, оплата й маркетинг.', 'MoeGo is all-in-one software for groomers and pet businesses: booking, mobile grooming routes, payments and marketing.', 'Платформа для салонів і мобільних грумерів, денного догляду та готелів: онлайн-запис, оптимізація маршрутів, автоматичні нагадування, оплата, відгуки й маркетинг.', 'A platform for salons and mobile groomers, daycares and boarding: online booking, route optimization, automated reminders, payments, reviews and marketing.', 'Онлайн-запис
Маршрути
Нагадування
Оплата', 'Online booking
Routes
Reminders
Payments', 'Грумери.', 'Groomers.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moego.pet' OR LOWER(`name`) = LOWER('MoeGo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pet-grooming-vet' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'MoeGo is all-in-one software for groomers and pet businesses: booking, mobile grooming routes, payments and marketing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform for salons and mobile groomers, daycares and boarding: online booking, route optimization, automated reminders, payments, reviews and marketing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online booking
Routes
Reminders
Payments', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Groomers.', 'manual' FROM DUAL WHERE @new = 1;

-- PetDesk — Грумінг та ветеринарні сервіси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petdesk.com' OR LOWER(`name`) = LOWER('PetDesk'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PetDesk', NULL, 'https://petdesk.com', NULL, NULL, 'PetDesk — комунікація ветклінік з клієнтами: застосунок для власників, нагадування, запис і повідомлення.', 'PetDesk handles vet clinic client communication: owner app, reminders, booking and messaging.', 'ПЗ для ветеринарних практик, що автоматизує нагадування про вакцинації, онлайн-запис, двосторонні повідомлення й програми лояльності, а власники користуються безкоштовним застосунком PetDesk.', 'Software for vet practices automating vaccination reminders, online booking, two-way messaging and loyalty programs, while owners use the free PetDesk app.', 'Нагадування
Онлайн-запис
Повідомлення
Застосунок для власників', 'Reminders
Online booking
Messaging
Owner app', 'Ветклініки та їхні клієнти.', 'Vet clinics and clients.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petdesk.com' OR LOWER(`name`) = LOWER('PetDesk')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pet-grooming-vet' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'PetDesk handles vet clinic client communication: owner app, reminders, booking and messaging.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Software for vet practices automating vaccination reminders, online booking, two-way messaging and loyalty programs, while owners use the free PetDesk app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Reminders
Online booking
Messaging
Owner app', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Vet clinics and clients.', 'manual' FROM DUAL WHERE @new = 1;

-- Petriage — Грумінг та ветеринарні сервіси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petriage.com' OR LOWER(`name`) = LOWER('Petriage'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Petriage', NULL, 'https://petriage.com', NULL, NULL, 'Petriage — ветеринарна телемедицина й перевірка симптомів тварини з рекомендацією, наскільки терміново до лікаря.', 'Petriage offers vet telehealth and a pet symptom checker recommending how urgently to see a vet.', 'Платформа для власників і клінік: оцінка симптомів, рекомендації щодо терміновості, відеоконсультації й інтеграція з місцевими ветклініками.', 'A platform for owners and clinics: symptom assessment, urgency advice, video consultations and integration with local clinics.', 'Перевірка симптомів
Терміновість
Відеоконсультації', 'Symptom checker
Urgency advice
Video visits', 'Власники тварин і клініки.', 'Pet owners and clinics.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petriage.com' OR LOWER(`name`) = LOWER('Petriage')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pet-grooming-vet' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Petriage offers vet telehealth and a pet symptom checker recommending how urgently to see a vet.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform for owners and clinics: symptom assessment, urgency advice, video consultations and integration with local clinics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Symptom checker
Urgency advice
Video visits', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Pet owners and clinics.', 'manual' FROM DUAL WHERE @new = 1;

-- PetsApp — Грумінг та ветеринарні сервіси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petsapp.com' OR LOWER(`name`) = LOWER('PetsApp'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PetsApp', NULL, 'https://petsapp.com', NULL, NULL, 'PetsApp — платформа залучення клієнтів для ветклінік: застосунок, чат, відеоконсультації, оплата й плани здоров''я.', 'PetsApp is a client engagement platform for vet clinics: app, chat, video consults, payments and health plans.', 'Брендований застосунок клініки для власників тварин з повідомленнями, записом, відеоконсультаціями, оплатою й підписковими планами профілактики.', 'A clinic-branded app for pet owners with messaging, booking, video consults, payments and subscription wellness plans.', 'Брендований застосунок
Чат і відео
Плани профілактики', 'Branded app
Chat and video
Wellness plans', 'Ветклініки.', 'Vet clinics.', 'web,mobile', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'petsapp.com' OR LOWER(`name`) = LOWER('PetsApp')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pet-grooming-vet' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'PetsApp is a client engagement platform for vet clinics: app, chat, video consults, payments and health plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A clinic-branded app for pet owners with messaging, booking, video consults, payments and subscription wellness plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Branded app
Chat and video
Wellness plans', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Vet clinics.', 'manual' FROM DUAL WHERE @new = 1;

-- ScribbleVet — Грумінг та ветеринарні сервіси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scribblevet.com' OR LOWER(`name`) = LOWER('ScribbleVet'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ScribbleVet', NULL, 'https://www.scribblevet.com', NULL, NULL, 'ScribbleVet — AI-скрайб для ветеринарів, що з запису прийому готує медичні нотатки SOAP.', 'ScribbleVet is an AI scribe for vets that turns appointment recordings into SOAP notes.', 'Ветеринар записує прийом на телефон, а AI формує структуровані медичні нотатки, виписки для клієнта й листи, заощаджуючи години документування.', 'The vet records the visit on a phone and AI produces structured medical notes, client discharge summaries and letters, saving hours of documentation.', 'AI-нотатки SOAP
Запис з телефона
Виписки для клієнтів', 'AI SOAP notes
Phone recording
Client summaries', 'Ветеринари.', 'Veterinarians.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'scribblevet.com' OR LOWER(`name`) = LOWER('ScribbleVet')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pet-grooming-vet' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ScribbleVet is an AI scribe for vets that turns appointment recordings into SOAP notes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The vet records the visit on a phone and AI produces structured medical notes, client discharge summaries and letters, saving hours of documentation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI SOAP notes
Phone recording
Client summaries', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Veterinarians.', 'manual' FROM DUAL WHERE @new = 1;

-- Small Door Veterinary — Грумінг та ветеринарні сервіси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'smalldoorvet.com' OR LOWER(`name`) = LOWER('Small Door Veterinary'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Small Door Veterinary', NULL, 'https://www.smalldoorvet.com', NULL, NULL, 'Small Door — ветеринарні клініки за членством у Нью-Йорку, Бостоні й Вашингтоні з телемедициною.', 'Small Door runs membership vet clinics in New York, Boston and DC with telemedicine.', 'Клініки, що поєднують первинну й невідкладну допомогу, членство з відеоконсультаціями й чатом 24/7 та запис через застосунок.', 'Clinics combining primary and urgent care, a membership with 24/7 video and chat and app booking.', 'Членство
Телемедицина
Невідкладна допомога', 'Membership
Telemedicine
Urgent care', 'Власники тварин у містах США.', 'US city pet owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'smalldoorvet.com' OR LOWER(`name`) = LOWER('Small Door Veterinary')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pet-grooming-vet' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Small Door runs membership vet clinics in New York, Boston and DC with telemedicine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Clinics combining primary and urgent care, a membership with 24/7 video and chat and app booking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Membership
Telemedicine
Urgent care', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US city pet owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Vetster — Грумінг та ветеринарні сервіси
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vetster.com' OR LOWER(`name`) = LOWER('Vetster'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Vetster', NULL, 'https://vetster.com', NULL, NULL, 'Vetster — онлайн-консультації ветеринарів 24/7 відеозв''язком і в чаті, з рецептами.', 'Vetster offers 24/7 online vet consultations by video and chat, with prescriptions.', 'Маркетплейс ліцензованих ветеринарів у США й Канаді: запис на відеоприйом у будь-який час, питання ветеринару в чаті, рецепти й подальший догляд.', 'A marketplace of licensed vets in the US and Canada: book video visits anytime, ask a vet by chat, prescriptions and follow-up care.', 'Відеоприйом 24/7
Чат з ветеринаром
Рецепти', '24/7 video visits
Vet chat
Prescriptions', 'Власники тварин.', 'Pet owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vetster.com' OR LOWER(`name`) = LOWER('Vetster')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'pet-grooming-vet' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Vetster offers 24/7 online vet consultations by video and chat, with prescriptions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A marketplace of licensed vets in the US and Canada: book video visits anytime, ask a vet by chat, prescriptions and follow-up care.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '24/7 video visits
Vet chat
Prescriptions', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Pet owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Craftsy — Рукоділля
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'craftsy.com' OR LOWER(`name`) = LOWER('Craftsy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Craftsy', NULL, 'https://www.craftsy.com', NULL, NULL, 'Craftsy — онлайн-класи з рукоділля: в''язання, шиття, квілтинг, випічка, малювання й інше за підпискою.', 'Craftsy offers online craft classes: knitting, sewing, quilting, baking, art and more by subscription.', 'Платформа відеокурсів від викладачів-майстрів з тисячами уроків, схемами для завантаження й питаннями інструкторам; доступ за підпискою.', 'A video course platform with master instructors, thousands of lessons, downloadable patterns and Q&A; access by subscription.', 'Відеокурси
Схеми
Питання інструктору', 'Video courses
Patterns
Instructor Q&A', 'Рукодільники.', 'Crafters.', 'web,mobile', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'craftsy.com' OR LOWER(`name`) = LOWER('Craftsy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'handicraft' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Craftsy offers online craft classes: knitting, sewing, quilting, baking, art and more by subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A video course platform with master instructors, thousands of lessons, downloadable patterns and Q&A; access by subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Video courses
Patterns
Instructor Q&A', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Crafters.', 'manual' FROM DUAL WHERE @new = 1;

-- Cricut Design Space — Рукоділля
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'design.cricut.com' OR LOWER(`name`) = LOWER('Cricut Design Space'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Cricut Design Space', NULL, 'https://design.cricut.com', NULL, NULL, 'Cricut Design Space — програма для проєктів на ріжучих плотерах Cricut: наклейки, листівки, декор, термотрансфер.', 'Cricut Design Space is software for Cricut cutting machine projects: stickers, cards, decor and iron-on.', 'Застосунок для дизайну й надсилання проєктів на машини Cricut: шрифти, зображення, готові проєкти, друк і вирізання; Cricut Access відкриває тисячі шрифтів і зображень за підпискою.', 'An app to design and send projects to Cricut machines: fonts, images, ready projects, print-then-cut; Cricut Access unlocks thousands of fonts and images by subscription.', 'Дизайн проєктів
Готові проєкти
Підписка Access', 'Project design
Ready projects
Access subscription', 'Власники Cricut.', 'Cricut owners.', 'web,desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'design.cricut.com' OR LOWER(`name`) = LOWER('Cricut Design Space')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'handicraft' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Cricut Design Space is software for Cricut cutting machine projects: stickers, cards, decor and iron-on.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app to design and send projects to Cricut machines: fonts, images, ready projects, print-then-cut; Cricut Access unlocks thousands of fonts and images by subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Project design
Ready projects
Access subscription', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Cricut owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базовий застосунок', 'Basic app' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic app', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Domestika — Рукоділля
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'domestika.org' OR LOWER(`name`) = LOWER('Domestika'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Domestika', NULL, 'https://www.domestika.org', NULL, NULL, 'Domestika — онлайн-курси від творчих професіоналів: ілюстрація, рукоділля, вишивка, кераміка, дизайн.', 'Domestika offers online courses by creative professionals: illustration, crafts, embroidery, ceramics and design.', 'Платформа креативних курсів з тисячами відеокурсів кількома мовами, зокрема з в''язання, вишивки, макраме, кераміки й шиття; курси купуються окремо або за підпискою Plus.', 'A creative course platform with thousands of video courses in several languages, including knitting, embroidery, macramé, ceramics and sewing; buy individually or via Plus.', 'Креативні курси
Кілька мов
Сертифікати', 'Creative courses
Several languages
Certificates', 'Творчі люди й рукодільники.', 'Creatives and crafters.', 'web,mobile', 'course', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'domestika.org' OR LOWER(`name`) = LOWER('Domestika')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'handicraft' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Domestika offers online courses by creative professionals: illustration, crafts, embroidery, ceramics and design.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A creative course platform with thousands of video courses in several languages, including knitting, embroidery, macramé, ceramics and sewing; buy individually or via Plus.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Creative courses
Several languages
Certificates', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Creatives and crafters.', 'manual' FROM DUAL WHERE @new = 1;

-- DROPS Design — Рукоділля
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'garnstudio.com' OR LOWER(`name`) = LOWER('DROPS Design'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DROPS Design', NULL, 'https://www.garnstudio.com', NULL, NULL, 'DROPS Design — норвезька пряжа й тисячі безкоштовних схем в''язання й гачка багатьма мовами, зокрема українською.', 'DROPS Design offers Norwegian yarn and thousands of free knitting and crochet patterns in many languages, including Ukrainian.', 'Garnstudio публікує понад 10 000 безкоштовних схем з відеоуроками та продає пряжу через мережу магазинів; сайт доступний десятками мов.', 'Garnstudio publishes over 10,000 free patterns with video tutorials and sells yarn through a store network; the site is in dozens of languages.', '10 000+ безкоштовних схем
Відеоуроки
Українською', '10,000+ free patterns
Video tutorials
Ukrainian language', 'В''язальниці.', 'Knitters.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'garnstudio.com' OR LOWER(`name`) = LOWER('DROPS Design')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'handicraft' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'DROPS Design offers Norwegian yarn and thousands of free knitting and crochet patterns in many languages, including Ukrainian.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Garnstudio publishes over 10,000 free patterns with video tutorials and sells yarn through a store network; the site is in dozens of languages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '10,000+ free patterns
Video tutorials
Ukrainian language', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Knitters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовні схеми', 'Free patterns', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовні схеми' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free patterns', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hatch Embroidery — Рукоділля
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hatchembroidery.com' OR LOWER(`name`) = LOWER('Hatch Embroidery'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hatch Embroidery', NULL, 'https://hatchembroidery.com', NULL, NULL, 'Hatch Embroidery — програма для створення й редагування дизайнів машинної вишивки з автодигіталізацією.', 'Hatch Embroidery is software for creating and editing machine embroidery designs with auto-digitizing.', 'ПЗ від Wilcom для домашніх і напівпрофесійних вишивальниць: автоперетворення зображень у вишивку, шрифти, редагування стібків і підтримка форматів більшості машин.', 'Wilcom software for home and semi-pro embroiderers: auto-converting images to embroidery, fonts, stitch editing and support for most machine formats.', 'Автодигіталізація
Шрифти вишивки
Формати машин', 'Auto-digitizing
Embroidery fonts
Machine formats', 'Вишивальниці на машинах.', 'Machine embroiderers.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hatchembroidery.com' OR LOWER(`name`) = LOWER('Hatch Embroidery')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'handicraft' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Hatch Embroidery is software for creating and editing machine embroidery designs with auto-digitizing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Wilcom software for home and semi-pro embroiderers: auto-converting images to embroidery, fonts, stitch editing and support for most machine formats.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Auto-digitizing
Embroidery fonts
Machine formats', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Machine embroiderers.', 'manual' FROM DUAL WHERE @new = 1;

-- Instructables — Рукоділля
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'instructables.com' OR LOWER(`name`) = LOWER('Instructables'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Instructables', NULL, 'https://www.instructables.com', NULL, NULL, 'Instructables (Autodesk) — покрокові DIY-проєкти: майстрування, рукоділля, кулінарія, електроніка.', 'Instructables (Autodesk) hosts step-by-step DIY projects: making, crafts, cooking and electronics.', 'Спільнота, де автори публікують інструкції з фото для виготовлення речей своїми руками — від меблів і рукоділля до електроніки й рецептів; конкурси з призами.', 'A community where makers publish photo instructions for making things — from furniture and crafts to electronics and recipes — with prize contests.', 'Покрокові проєкти
Різні теми
Конкурси', 'Step-by-step projects
Many topics
Contests', 'Майстри й DIY-ентузіасти.', 'Makers and DIYers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'instructables.com' OR LOWER(`name`) = LOWER('Instructables')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'handicraft' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Instructables (Autodesk) hosts step-by-step DIY projects: making, crafts, cooking and electronics.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A community where makers publish photo instructions for making things — from furniture and crafts to electronics and recipes — with prize contests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Step-by-step projects
Many topics
Contests', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Makers and DIYers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- knitCompanion — Рукоділля
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'knitcompanion.com' OR LOWER(`name`) = LOWER('knitCompanion'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'knitCompanion', NULL, 'https://www.knitcompanion.com', NULL, NULL, 'knitCompanion — застосунок для в''язання за схемами PDF: лічильники рядів, виділення рядків, ключ символів.', 'knitCompanion is an app for knitting from PDF patterns: row counters, line highlighters and chart key.', 'Відкриває схеми в PDF, дозволяє підсвічувати поточний ряд, мати кілька лічильників, нотатки й ключ символів поруч; синхронізується між пристроями.', 'It opens PDF patterns, highlights the current row, offers multiple counters, notes and the chart key alongside, and syncs between devices.', 'PDF-схеми
Лічильники рядів
Підсвічування', 'PDF patterns
Row counters
Highlighting', 'В''язальниці.', 'Knitters.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'knitcompanion.com' OR LOWER(`name`) = LOWER('knitCompanion')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'handicraft' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'knitCompanion is an app for knitting from PDF patterns: row counters, line highlighters and chart key.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It opens PDF patterns, highlights the current row, offers multiple counters, notes and the chart key alongside, and syncs between devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'PDF patterns
Row counters
Highlighting', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Knitters.', 'manual' FROM DUAL WHERE @new = 1;

-- LoveCrafts — Рукоділля
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lovecrafts.com' OR LOWER(`name`) = LOWER('LoveCrafts'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'LoveCrafts', NULL, 'https://www.lovecrafts.com', NULL, NULL, 'LoveCrafts — інтернет-магазин пряжі й товарів для рукоділля з тисячами безкоштовних схем в''язання й гачка.', 'LoveCrafts is an online store for yarn and craft supplies with thousands of free knitting and crochet patterns.', 'Великий магазин для в''язальниць і рукодільниць: пряжа, спиці, гачки, тканини, набори, платні й безкоштовні схеми від дизайнерів та спільнота.', 'A large store for knitters and crafters: yarn, needles, hooks, fabrics, kits, paid and free designer patterns and a community.', 'Пряжа й набори
Безкоштовні схеми
Спільнота', 'Yarn and kits
Free patterns
Community', 'В''язальниці й рукодільниці.', 'Knitters and crafters.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lovecrafts.com' OR LOWER(`name`) = LOWER('LoveCrafts')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'handicraft' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'LoveCrafts is an online store for yarn and craft supplies with thousands of free knitting and crochet patterns.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A large store for knitters and crafters: yarn, needles, hooks, fabrics, kits, paid and free designer patterns and a community.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Yarn and kits
Free patterns
Community', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Knitters and crafters.', 'manual' FROM DUAL WHERE @new = 1;

-- Mood Fabrics — Рукоділля
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moodfabrics.com' OR LOWER(`name`) = LOWER('Mood Fabrics'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mood Fabrics', NULL, 'https://www.moodfabrics.com', NULL, NULL, 'Mood Fabrics — магазин тканин на метраж з Нью-Йорка, безкоштовні викрійки й блог для кравчинь.', 'Mood Fabrics is a New York fabric-by-the-yard store with free sewing patterns and a blog.', 'Відомий з шоу Project Runway магазин тканин, фурнітури й пряжі, який також публікує безкоштовні викрійки й навчальні статті.', 'The fabric store known from Project Runway, selling fabric, notions and yarn and publishing free patterns and tutorials.', 'Тканини на метраж
Безкоштовні викрійки
Блог', 'Fabric by the yard
Free patterns
Blog', 'Кравчині.', 'Sewists.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moodfabrics.com' OR LOWER(`name`) = LOWER('Mood Fabrics')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'handicraft' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mood Fabrics is a New York fabric-by-the-yard store with free sewing patterns and a blog.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The fabric store known from Project Runway, selling fabric, notions and yarn and publishing free patterns and tutorials.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Fabric by the yard
Free patterns
Blog', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sewists.', 'manual' FROM DUAL WHERE @new = 1;

-- Pattern Keeper — Рукоділля
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'patternkeeper.app' OR LOWER(`name`) = LOWER('Pattern Keeper'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Pattern Keeper', NULL, 'https://patternkeeper.app', NULL, NULL, 'Pattern Keeper — застосунок для вишивки хрестиком за PDF-схемами: позначення стібків, фільтр кольорів, прогрес.', 'Pattern Keeper is an app for cross-stitch PDF charts: mark stitches, filter colors and track progress.', 'Імпортує схеми з PDF, розпізнає символи, дає змогу підсвічувати один колір, позначати вишиті хрестики й бачити прогрес.', 'It imports PDF charts, recognizes symbols, highlights one color at a time, marks completed stitches and shows progress.', 'Імпорт PDF-схем
Фільтр кольорів
Прогрес', 'PDF import
Color filter
Progress', 'Вишивальниці.', 'Cross-stitchers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'patternkeeper.app' OR LOWER(`name`) = LOWER('Pattern Keeper')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'handicraft' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Pattern Keeper is an app for cross-stitch PDF charts: mark stitches, filter colors and track progress.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It imports PDF charts, recognizes symbols, highlights one color at a time, marks completed stitches and shows progress.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'PDF import
Color filter
Progress', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Cross-stitchers.', 'manual' FROM DUAL WHERE @new = 1;

-- Printables — Рукоділля
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'printables.com' OR LOWER(`name`) = LOWER('Printables'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Printables', NULL, 'https://www.printables.com', NULL, NULL, 'Printables (Prusa) — бібліотека безкоштовних 3D-моделей для друку з конкурсами й спільнотою.', 'Printables (Prusa) is a library of free 3D-printable models with contests and a community.', 'Платформа Prusa Research, де користувачі діляться моделями для 3D-друку — домашніх корисних речей, іграшок, інструментів — і отримують бали за завантаження.', 'A Prusa Research platform where users share 3D-printable models — home gadgets, toys, tools — and earn points for downloads.', 'Безкоштовні 3D-моделі
Конкурси
Спільнота', 'Free 3D models
Contests
Community', 'Власники 3D-принтерів.', '3D printer owners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'printables.com' OR LOWER(`name`) = LOWER('Printables')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'handicraft' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Printables (Prusa) is a library of free 3D-printable models with contests and a community.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Prusa Research platform where users share 3D-printable models — home gadgets, toys, tools — and earn points for downloads.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free 3D models
Contests
Community', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', '3D printer owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Бібліотека', 'Library' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Library', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Seamly2D — Рукоділля
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'seamly.io' OR LOWER(`name`) = LOWER('Seamly2D'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Seamly2D', NULL, 'https://seamly.io', NULL, NULL, 'Seamly2D — відкрита програма для конструювання викрійок одягу за вимірами.', 'Seamly2D is open-source software for drafting clothing patterns from measurements.', 'Параметричне ПЗ для створення викрійок, які автоматично перебудовуються під нові мірки; використовується домашніми кравцями й малими ательє.', 'Parametric software for drafting patterns that automatically re-draft to new measurements; used by home sewists and small studios.', 'Викрійки за мірками
Параметричність
Open source', 'Made-to-measure patterns
Parametric
Open source', 'Кравчині.', 'Sewists.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'seamly.io' OR LOWER(`name`) = LOWER('Seamly2D')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'handicraft' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Seamly2D is open-source software for drafting clothing patterns from measurements.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Parametric software for drafting patterns that automatically re-draft to new measurements; used by home sewists and small studios.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Made-to-measure patterns
Parametric
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sewists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Open source', 'Open source' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Silhouette Studio — Рукоділля
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'silhouetteamerica.com' OR LOWER(`name`) = LOWER('Silhouette Studio'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Silhouette Studio', NULL, 'https://www.silhouetteamerica.com', NULL, NULL, 'Silhouette — ріжучі плотери та програма Silhouette Studio для проєктів з паперу, вінілу й тканини.', 'Silhouette makes cutting machines and Silhouette Studio software for paper, vinyl and fabric projects.', 'Виробник ріжучих машин Cameo і Portrait із програмою Silhouette Studio для дизайну, трасування й вирізання та магазином дизайнів.', 'A maker of Cameo and Portrait cutting machines with Silhouette Studio software for design, tracing and cutting and a design store.', 'Ріжучі плотери
Silhouette Studio
Магазин дизайнів', 'Cutting machines
Silhouette Studio
Design store', 'Рукодільники.', 'Crafters.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'silhouetteamerica.com' OR LOWER(`name`) = LOWER('Silhouette Studio')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'handicraft' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Silhouette makes cutting machines and Silhouette Studio software for paper, vinyl and fabric projects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A maker of Cameo and Portrait cutting machines with Silhouette Studio software for design, tracing and cutting and a design store.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cutting machines
Silhouette Studio
Design store', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Crafters.', 'manual' FROM DUAL WHERE @new = 1;

-- Tailornova — Рукоділля
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tailornova.com' OR LOWER(`name`) = LOWER('Tailornova'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Tailornova', NULL, 'https://tailornova.com', NULL, NULL, 'Tailornova — онлайн-конструктор одягу з 3D-переглядом і викрійками за індивідуальними мірками.', 'Tailornova is an online clothing designer with 3D preview and made-to-measure patterns.', 'Сервіс, де можна скомбінувати фасон із деталей, побачити його в 3D і завантажити PDF-викрійку під свої мірки; за підпискою.', 'A service to mix and match garment elements, preview in 3D and download a PDF pattern fitted to your measurements; by subscription.', 'Конструктор фасонів
3D-перегляд
Викрійки за мірками', 'Style builder
3D preview
Made-to-measure patterns', 'Кравчині.', 'Sewists.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tailornova.com' OR LOWER(`name`) = LOWER('Tailornova')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'handicraft' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Tailornova is an online clothing designer with 3D preview and made-to-measure patterns.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service to mix and match garment elements, preview in 3D and download a PDF pattern fitted to your measurements; by subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Style builder
3D preview
Made-to-measure patterns', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sewists.', 'manual' FROM DUAL WHERE @new = 1;

-- The Fold Line — Рукоділля
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thefoldline.com' OR LOWER(`name`) = LOWER('The Fold Line'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'The Fold Line', NULL, 'https://thefoldline.com', NULL, NULL, 'The Fold Line — онлайн-магазин викрійок від незалежних дизайнерів, тканин і спільнота кравчинь.', 'The Fold Line is an online shop of indie sewing patterns, fabrics and a sewing community.', 'Британський сервіс з тисячами паперових і PDF-викрійок від незалежних дизайнерів, тканинами, оглядами пошиву й подкастом.', 'A UK service with thousands of paper and PDF patterns from indie designers, fabrics, sewing reviews and a podcast.', 'Викрійки інді-дизайнерів
PDF і папір
Подкаст', 'Indie patterns
PDF and paper
Podcast', 'Кравчині.', 'Sewists.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thefoldline.com' OR LOWER(`name`) = LOWER('The Fold Line')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'handicraft' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The Fold Line is an online shop of indie sewing patterns, fabrics and a sewing community.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A UK service with thousands of paper and PDF patterns from indie designers, fabrics, sewing reviews and a podcast.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Indie patterns
PDF and paper
Podcast', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sewists.', 'manual' FROM DUAL WHERE @new = 1;

-- Valentina — Рукоділля
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'valentinaproject.bitbucket.io' OR LOWER(`name`) = LOWER('Valentina'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Valentina', NULL, 'https://valentinaproject.bitbucket.io', NULL, NULL, 'Valentina — безкоштовна відкрита програма конструювання викрійок одягу.', 'Valentina is free open-source clothing pattern-making software.', 'Програма для Windows, macOS і Linux для параметричного креслення викрійок з таблицями мірок, розкладкою й експортом.', 'Software for Windows, macOS and Linux for parametric pattern drafting with measurement tables, layout and export.', 'Параметричні викрійки
Таблиці мірок
Open source', 'Parametric patterns
Measurement tables
Open source', 'Кравчині.', 'Sewists.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'valentinaproject.bitbucket.io' OR LOWER(`name`) = LOWER('Valentina')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'handicraft' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Valentina is free open-source clothing pattern-making software.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Software for Windows, macOS and Linux for parametric pattern drafting with measurement tables, layout and export.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Parametric patterns
Measurement tables
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Sewists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Open source', 'Open source' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Open source', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Yarnspirations — Рукоділля
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yarnspirations.com' OR LOWER(`name`) = LOWER('Yarnspirations'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Yarnspirations', NULL, 'https://www.yarnspirations.com', NULL, NULL, 'Yarnspirations — пряжа брендів Caron, Bernat, Red Heart і тисячі безкоштовних схем в''язання й гачка.', 'Yarnspirations offers Caron, Bernat and Red Heart yarn and thousands of free knitting and crochet patterns.', 'Сайт виробника пряжі зі схемами для всіх рівнів, відеоуроками, наборами й CAL/KAL-проєктами спільноти.', 'A yarn maker''s site with patterns for all levels, video tutorials, kits and community CAL/KAL projects.', 'Безкоштовні схеми
Відеоуроки
Пряжа', 'Free patterns
Video tutorials
Yarn', 'В''язальниці.', 'Knitters and crocheters.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yarnspirations.com' OR LOWER(`name`) = LOWER('Yarnspirations')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'handicraft' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Yarnspirations offers Caron, Bernat and Red Heart yarn and thousands of free knitting and crochet patterns.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A yarn maker''s site with patterns for all levels, video tutorials, kits and community CAL/KAL projects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Free patterns
Video tutorials
Yarn', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Knitters and crocheters.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовні схеми', 'Free patterns', 0.00, 'free', 'Тисячі схем', 'Thousands of patterns' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовні схеми' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free patterns', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Thousands of patterns', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Android Auto — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'android.com/auto' OR LOWER(`name`) = LOWER('Android Auto'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Android Auto', NULL, 'https://www.android.com/auto/', NULL, NULL, 'Android Auto — навігація, музика, повідомлення й Google Assistant на екрані автомобіля з телефона Android.', 'Android Auto brings navigation, music, messages and Google Assistant from an Android phone to the car display.', 'Режим, що виводить спрощений інтерфейс телефона на мультимедійну систему авто: Google Maps і Waze, музичні застосунки, дзвінки й повідомлення голосом, бездротове підключення в сумісних машинах.', 'A mode projecting a simplified phone interface onto the car''s infotainment: Google Maps and Waze, music apps, voice calls and messages, wireless in compatible cars.', 'Навігація на екрані авто
Музика
Голосові повідомлення', 'In-car navigation
Music
Voice messaging', 'Водії зі смартфонами Android.', 'Drivers with Android phones.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'android.com/auto' OR LOWER(`name`) = LOWER('Android Auto')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Android Auto brings navigation, music, messages and Google Assistant from an Android phone to the car display.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A mode projecting a simplified phone interface onto the car''s infotainment: Google Maps and Waze, music apps, voice calls and messages, wireless in compatible cars.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'In-car navigation
Music
Voice messaging', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Drivers with Android phones.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Вбудовано в Android', 'Built into Android' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Built into Android', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Apple CarPlay — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apple.com/ios/carplay' OR LOWER(`name`) = LOWER('Apple CarPlay'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Apple CarPlay', NULL, 'https://www.apple.com/ios/carplay/', NULL, NULL, 'Apple CarPlay — інтерфейс iPhone на екрані авто: Карти, музика, дзвінки, повідомлення й Siri.', 'Apple CarPlay puts an iPhone interface on the car display: Maps, music, calls, messages and Siri.', 'Система, що підключає iPhone до мультимедіа автомобіля (дротом чи бездротово), дає доступ до навігації, аудіозастосунків, зарядних станцій EV і керування голосом через Siri.', 'A system connecting iPhone to the car''s infotainment (wired or wireless) for navigation, audio apps, EV charging stations and Siri voice control.', 'Карти й навігація
Музика
Siri', 'Maps and navigation
Music
Siri', 'Водії з iPhone.', 'Drivers with iPhones.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apple.com/ios/carplay' OR LOWER(`name`) = LOWER('Apple CarPlay')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Apple CarPlay puts an iPhone interface on the car display: Maps, music, calls, messages and Siri.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A system connecting iPhone to the car''s infotainment (wired or wireless) for navigation, audio apps, EV charging stations and Siri voice control.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Maps and navigation
Music
Siri', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Drivers with iPhones.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Вбудовано в iOS', 'Built into iOS' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Built into iOS', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AUTO.RIA — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'auto.ria.com' OR LOWER(`name`) = LOWER('AUTO.RIA'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AUTO.RIA', NULL, 'https://auto.ria.com', NULL, NULL, 'AUTO.RIA — найбільший автобазар України: купівля й продаж перевірених авто, перевірка VIN і ціни ринку.', 'AUTO.RIA is Ukraine''s largest car marketplace: buying and selling verified cars, VIN checks and market prices.', 'Платформа оголошень про продаж нових і вживаних авто з перевіркою VIN, історією по реєстрах МВС, середніми цінами, новими авто від дилерів і застосунком.', 'A listings platform for new and used cars with VIN checks, Ministry of Interior registry history, average prices, new cars from dealers and an app.', 'Перевірені авто
Перевірка VIN
Середні ціни
Застосунок', 'Verified cars
VIN check
Average prices
App', 'Покупці й продавці авто в Україні.', 'Car buyers and sellers in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'auto.ria.com' OR LOWER(`name`) = LOWER('AUTO.RIA')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AUTO.RIA is Ukraine''s largest car marketplace: buying and selling verified cars, VIN checks and market prices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A listings platform for new and used cars with VIN checks, Ministry of Interior registry history, average prices, new cars from dealers and an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Verified cars
VIN check
Average prices
App', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Car buyers and sellers in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AUTODOC — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'autodoc.co.uk' OR LOWER(`name`) = LOWER('AUTODOC'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AUTODOC', NULL, 'https://www.autodoc.co.uk', NULL, NULL, 'AUTODOC — онлайн-магазин автозапчастин з понад 7,8 млн позицій, підбором за авто й відеоінструкціями заміни.', 'AUTODOC is an online car parts store with 7.8M+ items, parts finder by vehicle and replacement videos.', 'Європейський магазин запчастин, мастил і аксесуарів з підбором за моделлю чи номером, застосунком AUTODOC з гаражем і порадами та відеоуроками з самостійного ремонту.', 'A European store for parts, oils and accessories with lookup by model or registration, the AUTODOC app with a garage and tips, and DIY repair video tutorials.', '7,8 млн запчастин
Підбір за авто
Відеоінструкції', '7.8M parts
Vehicle lookup
Video tutorials', 'Водії, що ремонтують самі.', 'DIY car owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'autodoc.co.uk' OR LOWER(`name`) = LOWER('AUTODOC')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AUTODOC is an online car parts store with 7.8M+ items, parts finder by vehicle and replacement videos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A European store for parts, oils and accessories with lookup by model or registration, the AUTODOC app with a garage and tips, and DIY repair video tutorials.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '7.8M parts
Vehicle lookup
Video tutorials', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'DIY car owners.', 'manual' FROM DUAL WHERE @new = 1;

-- AutoMoto.ua — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'automoto.ua' OR LOWER(`name`) = LOWER('AutoMoto.ua'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AutoMoto.ua', NULL, 'https://automoto.ua', NULL, NULL, 'AutoMoto.ua — український автобазар: оголошення про продаж авто й мото, пошук за параметрами.', 'AutoMoto.ua is a Ukrainian car marketplace: car and motorcycle listings with parameter search.', 'Сайт оголошень, що збирає пропозиції про продаж легкових авто, мотоциклів і вантажівок з усієї України, з фільтрами, фото й контактами продавців.', 'A listings site aggregating cars, motorcycles and trucks for sale across Ukraine, with filters, photos and seller contacts.', 'Авто й мото
Фільтри
По всій Україні', 'Cars and bikes
Filters
Across Ukraine', 'Покупці авто в Україні.', 'Car buyers in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'automoto.ua' OR LOWER(`name`) = LOWER('AutoMoto.ua')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'AutoMoto.ua is a Ukrainian car marketplace: car and motorcycle listings with parameter search.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A listings site aggregating cars, motorcycles and trucks for sale across Ukraine, with filters, photos and seller contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cars and bikes
Filters
Across Ukraine', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Car buyers in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- BlaBlaCar — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'blablacar.com' OR LOWER(`name`) = LOWER('BlaBlaCar'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BlaBlaCar', NULL, 'https://www.blablacar.com', NULL, NULL, 'BlaBlaCar — спільні поїздки між містами й автобусні квитки: знаходьте попутників і діліть витрати.', 'BlaBlaCar offers intercity carpooling and bus tickets: find travel companions and share costs.', 'Найбільша платформа карпулінгу: водії пропонують вільні місця, пасажири бронюють і ділять витрати на пальне; також продаж квитків на автобуси BlaBlaCar Bus.', 'The largest carpooling platform: drivers offer free seats, passengers book and share fuel costs; it also sells BlaBlaCar Bus tickets.', 'Спільні поїздки
Розподіл витрат
Автобусні квитки', 'Carpooling
Cost sharing
Bus tickets', 'Мандрівники між містами.', 'Intercity travellers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'blablacar.com' OR LOWER(`name`) = LOWER('BlaBlaCar')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'BlaBlaCar offers intercity carpooling and bus tickets: find travel companions and share costs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The largest carpooling platform: drivers offer free seats, passengers book and share fuel costs; it also sells BlaBlaCar Bus tickets.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Carpooling
Cost sharing
Bus tickets', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Intercity travellers.', 'manual' FROM DUAL WHERE @new = 1;

-- CARFAX — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'carfax.com' OR LOWER(`name`) = LOWER('CARFAX'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CARFAX', NULL, 'https://www.carfax.com', NULL, NULL, 'CARFAX — історія вживаних авто за VIN: ДТП, власники, обслуговування; а також пошук авто й нагадування про сервіс.', 'CARFAX provides used car history by VIN: accidents, owners, service; plus car search and service reminders.', 'Звіти про історію автомобіля в США й Канаді з даними про аварії, пробіг, кількість власників і сервісні записи, оголошення з безкоштовними звітами та застосунок Car Care.', 'Vehicle history reports in the US and Canada with accidents, mileage, number of owners and service records, listings with free reports and the Car Care app.', 'Історія за VIN
Оголошення
Car Care', 'VIN history
Listings
Car Care', 'Покупці вживаних авто.', 'Used car buyers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'carfax.com' OR LOWER(`name`) = LOWER('CARFAX')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'CARFAX provides used car history by VIN: accidents, owners, service; plus car search and service reminders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Vehicle history reports in the US and Canada with accidents, mileage, number of owners and service records, listings with free reports and the Car Care app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'VIN history
Listings
Car Care', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Used car buyers.', 'manual' FROM DUAL WHERE @new = 1;

-- CarGurus — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cargurus.com' OR LOWER(`name`) = LOWER('CarGurus'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CarGurus', NULL, 'https://www.cargurus.com', NULL, NULL, 'CarGurus — пошук авто з рейтингом угод: мільйони оголошень, аналіз ринкової ціни й продаж свого авто.', 'CarGurus searches cars with deal ratings: millions of listings, market price analysis and selling your car.', 'Платформа, що оцінює кожне оголошення від «чудова угода» до «переплата» за аналізом ринку, показує історію ціни й дилерські відгуки та пропонує миттєву пропозицію за ваше авто.', 'A platform rating each listing from great deal to overpriced based on market analysis, showing price history and dealer reviews, and offering instant offers on your car.', 'Рейтинг угод
Історія ціни
Відгуки дилерів
Продаж авто', 'Deal ratings
Price history
Dealer reviews
Sell your car', 'Покупці авто.', 'Car buyers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'cargurus.com' OR LOWER(`name`) = LOWER('CarGurus')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'CarGurus searches cars with deal ratings: millions of listings, market price analysis and selling your car.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform rating each listing from great deal to overpriced based on market analysis, showing price history and dealer reviews, and offering instant offers on your car.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Deal ratings
Price history
Dealer reviews
Sell your car', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Car buyers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Carvana — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'carvana.com' OR LOWER(`name`) = LOWER('Carvana'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Carvana', NULL, 'https://www.carvana.com', NULL, NULL, 'Carvana — купівля й продаж вживаних авто онлайн у США з доставкою, фінансуванням і 7-денним поверненням.', 'Carvana buys and sells used cars online in the US with delivery, financing and a 7-day return.', 'Онлайн-дилер: 360°-огляд авто, кредит і обмін онлайн, доставка до дому або видача з «автомата-вежі», тест-драйв протягом 7 днів з поверненням; також миттєвий викуп вашого авто.', 'An online dealer: 360° car views, online financing and trade-in, home delivery or pickup from a car vending machine, a 7-day test-own with returns; plus instant offers for your car.', '360°-огляд
Доставка додому
7 днів на повернення
Миттєвий викуп', '360° views
Home delivery
7-day returns
Instant offers', 'Покупці й продавці авто в США.', 'US car buyers and sellers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'carvana.com' OR LOWER(`name`) = LOWER('Carvana')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Carvana buys and sells used cars online in the US with delivery, financing and a 7-day return.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An online dealer: 360° car views, online financing and trade-in, home delivery or pickup from a car vending machine, a 7-day test-own with returns; plus instant offers for your car.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '360° views
Home delivery
7-day returns
Instant offers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US car buyers and sellers.', 'manual' FROM DUAL WHERE @new = 1;

-- carVertical — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'carvertical.com' OR LOWER(`name`) = LOWER('carVertical'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'carVertical', NULL, 'https://www.carvertical.com', NULL, NULL, 'carVertical — перевірка історії авто й мотоциклів за VIN: пробіг, пошкодження, викрадення, фото з минулих оголошень.', 'carVertical checks car and motorcycle history by VIN: mileage, damage, theft and past listing photos.', 'Литовський сервіс, що збирає дані з реєстрів і баз багатьох країн (зокрема України), щоб виявити скручений пробіг, ДТП, викрадення, ремонти й фото авто з минулих продажів.', 'A Lithuanian service gathering data from registries and databases in many countries (including Ukraine) to reveal rolled-back mileage, accidents, theft, repairs and photos from past sales.', 'Перевірка VIN
Скручений пробіг
Фото з оголошень
Багато країн', 'VIN check
Mileage rollback
Listing photos
Many countries', 'Покупці вживаних авто.', 'Used car buyers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'carvertical.com' OR LOWER(`name`) = LOWER('carVertical')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'carVertical checks car and motorcycle history by VIN: mileage, damage, theft and past listing photos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Lithuanian service gathering data from registries and databases in many countries (including Ukraine) to reveal rolled-back mileage, accidents, theft, repairs and photos from past sales.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'VIN check
Mileage rollback
Listing photos
Many countries', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Used car buyers.', 'manual' FROM DUAL WHERE @new = 1;

-- Electrify America — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'electrifyamerica.com' OR LOWER(`name`) = LOWER('Electrify America'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Electrify America', NULL, 'https://www.electrifyamerica.com', NULL, NULL, 'Electrify America — мережа швидких зарядних станцій для електромобілів у США з застосунком і планами Pass+.', 'Electrify America is a US fast-charging network for EVs with an app and Pass+ plans.', 'Мережа надшвидких зарядок до 350 кВт уздовж трас і в містах. Застосунок знаходить станції, показує доступність, запускає й оплачує зарядку; Pass+ знижує ціну за кВт·год.', 'A network of ultra-fast chargers up to 350 kW along highways and in cities. The app finds stations, shows availability, starts and pays for sessions; Pass+ lowers the price per kWh.', 'Зарядки до 350 кВт
Застосунок
Pass+', 'Up to 350 kW
App
Pass+', 'Власники електромобілів у США.', 'US EV drivers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'electrifyamerica.com' OR LOWER(`name`) = LOWER('Electrify America')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Electrify America is a US fast-charging network for EVs with an app and Pass+ plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A network of ultra-fast chargers up to 350 kW along highways and in cities. The app finds stations, shows availability, starts and pays for sessions; Pass+ lowers the price per kWh.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Up to 350 kW
App
Pass+', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US EV drivers.', 'manual' FROM DUAL WHERE @new = 1;

-- Electromaps — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'electromaps.com' OR LOWER(`name`) = LOWER('Electromaps'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Electromaps', NULL, 'https://www.electromaps.com', NULL, NULL, 'Electromaps — мапа зарядних станцій EV у Європі з оплатою зарядки в застосунку й спільнотою водіїв.', 'Electromaps maps EV charging stations across Europe with in-app payment and a driver community.', 'Європейська платформа з сотнями тисяч точок зарядки, фільтрами, коментарями, оплатою через застосунок на станціях партнерів і плануванням маршрутів.', 'A European platform with hundreds of thousands of charge points, filters, comments, in-app payment at partner stations and route planning.', 'Мапа Європи
Оплата в застосунку
Коментарі водіїв', 'Europe-wide map
In-app payment
Driver comments', 'Водії EV у Європі.', 'EV drivers in Europe.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'electromaps.com' OR LOWER(`name`) = LOWER('Electromaps')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Electromaps maps EV charging stations across Europe with in-app payment and a driver community.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A European platform with hundreds of thousands of charge points, filters, comments, in-app payment at partner stations and route planning.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Europe-wide map
In-app payment
Driver comments', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'EV drivers in Europe.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Getaround — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getaround.com' OR LOWER(`name`) = LOWER('Getaround'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Getaround', NULL, 'https://getaround.com', NULL, NULL, 'Getaround — оренда авто в сусідів і каршеринг з відмиканням через телефон.', 'Getaround offers peer-to-peer car hire and carsharing with phone unlocking.', 'Платформа, де власники здають свої авто, а клієнти бронюють їх на години чи дні й відмикають застосунком без зустрічі; працює в Європі.', 'A platform where owners rent out their cars and customers book them by the hour or day and unlock them with the app without meeting; operates in Europe.', 'Оренда в сусідів
Відмикання з телефона
Погодинно', 'Peer-to-peer rental
Phone unlock
Hourly', 'Мешканці міст.', 'City residents.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getaround.com' OR LOWER(`name`) = LOWER('Getaround')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Getaround offers peer-to-peer car hire and carsharing with phone unlocking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform where owners rent out their cars and customers book them by the hour or day and unlock them with the app without meeting; operates in Europe.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Peer-to-peer rental
Phone unlock
Hourly', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'City residents.', 'manual' FROM DUAL WHERE @new = 1;

-- Kelley Blue Book — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kbb.com' OR LOWER(`name`) = LOWER('Kelley Blue Book'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kelley Blue Book', NULL, 'https://www.kbb.com', NULL, NULL, 'Kelley Blue Book — оцінка вартості нових і вживаних авто в США, огляди експертів і миттєва пропозиція.', 'Kelley Blue Book values new and used cars in the US, with expert reviews and instant cash offers.', 'Джерело ринкових цін на автомобілі: вартість при обміні й приватному продажу, справедлива ціна купівлі, огляди моделей, порівняння та Instant Cash Offer від дилерів.', 'A source of car market prices: trade-in and private-party values, fair purchase price, model reviews, comparisons and an Instant Cash Offer from dealers.', 'Оцінка вартості
Огляди моделей
Миттєва пропозиція', 'Car values
Model reviews
Instant offer', 'Покупці й продавці авто в США.', 'US car buyers and sellers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kbb.com' OR LOWER(`name`) = LOWER('Kelley Blue Book')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Kelley Blue Book values new and used cars in the US, with expert reviews and instant cash offers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A source of car market prices: trade-in and private-party values, fair purchase price, model reviews, comparisons and an Instant Cash Offer from dealers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Car values
Model reviews
Instant offer', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US car buyers and sellers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Оцінки', 'Valuations' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Valuations', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- My BMW — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bmw.com/en/topics/offers-and-services/mybmw-app.html' OR LOWER(`name`) = LOWER('My BMW'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'My BMW', NULL, 'https://www.bmw.com/en/topics/offers-and-services/mybmw-app.html', NULL, NULL, 'My BMW — застосунок власника BMW: дистанційне керування авто, стан, навігація, зарядка EV і сервіс.', 'My BMW is the BMW owner app: remote vehicle control, status, navigation, EV charging and service.', 'Дозволяє замикати й відмикати авто, вмикати клімат-контроль, бачити заряд і запас ходу, надсилати маршрути в навігацію, знаходити зарядки й записуватися на сервіс.', 'It locks and unlocks the car, starts climate control, shows charge and range, sends routes to navigation, finds chargers and books service.', 'Дистанційне керування
Клімат-контроль
Зарядка EV
Запис на сервіс', 'Remote control
Climate
EV charging
Service booking', 'Власники BMW.', 'BMW owners.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bmw.com/en/topics/offers-and-services/mybmw-app.html' OR LOWER(`name`) = LOWER('My BMW')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'My BMW is the BMW owner app: remote vehicle control, status, navigation, EV charging and service.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It locks and unlocks the car, starts climate control, shows charge and range, sends routes to navigation, finds chargers and books service.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Remote control
Climate
EV charging
Service booking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'BMW owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для власників', 'For owners' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For owners', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Nexar — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getnexar.com' OR LOWER(`name`) = LOWER('Nexar'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nexar', NULL, 'https://www.getnexar.com', NULL, NULL, 'Nexar — відеореєстратори з LTE, 4K і хмарним зберіганням записів, сповіщеннями про удари на парковці.', 'Nexar makes LTE dashcams with 4K and cloud backup, plus parking impact alerts.', 'Розумні відеореєстратори, що автоматично завантажують важливі відео в хмару, фіксують інциденти на парковці, генерують звіти для страхових і мають застосунок.', 'Smart dashcams that auto-upload important clips to the cloud, capture parking incidents, generate insurer reports and come with an app.', 'LTE і 4K
Хмарні записи
Сповіщення на парковці', 'LTE and 4K
Cloud backup
Parking alerts', 'Водії.', 'Drivers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'getnexar.com' OR LOWER(`name`) = LOWER('Nexar')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Nexar makes LTE dashcams with 4K and cloud backup, plus parking impact alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Smart dashcams that auto-upload important clips to the cloud, capture parking incidents, generate insurer reports and come with an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'LTE and 4K
Cloud backup
Parking alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Drivers.', 'manual' FROM DUAL WHERE @new = 1;

-- Openbay — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'openbay.com' OR LOWER(`name`) = LOWER('Openbay'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Openbay', NULL, 'https://www.openbay.com', NULL, NULL, 'Openbay — порівняння пропозицій місцевих автосервісів і онлайн-запис на ремонт.', 'Openbay compares quotes from local auto repair shops and books repairs online.', 'Описуєте потрібну роботу, отримуєте кілька цінових пропозицій від автосервісів поруч, порівнюєте відгуки й бронюєте онлайн.', 'Describe the needed work, get several quotes from nearby shops, compare reviews and book online.', 'Порівняння цін
Відгуки
Онлайн-запис', 'Quote comparison
Reviews
Online booking', 'Водії в США.', 'US drivers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'openbay.com' OR LOWER(`name`) = LOWER('Openbay')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Openbay compares quotes from local auto repair shops and books repairs online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Describe the needed work, get several quotes from nearby shops, compare reviews and book online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Quote comparison
Reviews
Online booking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US drivers.', 'manual' FROM DUAL WHERE @new = 1;

-- Parkopedia — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'parkopedia.com' OR LOWER(`name`) = LOWER('Parkopedia'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Parkopedia', NULL, 'https://www.parkopedia.com', NULL, NULL, 'Parkopedia — глобальна база паркувань з цінами, доступністю й бронюванням у 90+ країнах.', 'Parkopedia is a global parking database with prices, availability and booking in 90+ countries.', 'Сервіс, що містить дані про десятки мільйонів паркомісць, ціни й години роботи та дозволяє бронювати місця; інтегрований у навігацію багатьох автовиробників.', 'A service with data on tens of millions of parking spaces, prices and hours, with reservations; it''s integrated into many carmakers'' navigation.', 'Ціни паркувань
Доступність
Бронювання', 'Parking prices
Availability
Reservations', 'Водії й мандрівники.', 'Drivers and travellers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'parkopedia.com' OR LOWER(`name`) = LOWER('Parkopedia')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Parkopedia is a global parking database with prices, availability and booking in 90+ countries.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service with data on tens of millions of parking spaces, prices and hours, with reservations; it''s integrated into many carmakers'' navigation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Parking prices
Availability
Reservations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Drivers and travellers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- RockAuto — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rockauto.com' OR LOWER(`name`) = LOWER('RockAuto'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'RockAuto', NULL, 'https://www.rockauto.com', NULL, NULL, 'RockAuto — інтернет-каталог автозапчастин з величезним вибором і порівнянням цін виробників.', 'RockAuto is an online auto parts catalog with a huge selection and manufacturer price comparison.', 'Американський магазин з деревом каталогу за маркою, моделлю й роком, де одна деталь пропонується від різних виробників за різними цінами; доставка по США та в інші країни.', 'A US store with a catalog tree by make, model and year, offering each part from several manufacturers at different prices; ships in the US and abroad.', 'Каталог за маркою
Порівняння виробників
Міжнародна доставка', 'Catalog by make
Manufacturer comparison
International shipping', 'Водії та механіки.', 'Drivers and mechanics.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rockauto.com' OR LOWER(`name`) = LOWER('RockAuto')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'RockAuto is an online auto parts catalog with a huge selection and manufacturer price comparison.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A US store with a catalog tree by make, model and year, offering each part from several manufacturers at different prices; ships in the US and abroad.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Catalog by make
Manufacturer comparison
International shipping', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Drivers and mechanics.', 'manual' FROM DUAL WHERE @new = 1;

-- SpotHero — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'spothero.com' OR LOWER(`name`) = LOWER('SpotHero'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SpotHero', NULL, 'https://spothero.com', NULL, NULL, 'SpotHero — бронювання паркування в містах США й Канади наперед зі знижками.', 'SpotHero books parking in US and Canadian cities in advance with discounts.', 'Сервіс для пошуку й оплати місць у гаражах і на майданчиках поблизу подій, аеропортів і офісів зі знижками порівняно з ціною на місці.', 'A service for finding and paying for spots in garages and lots near events, airports and offices at discounts versus drive-up rates.', 'Бронювання паркування
Знижки
Аеропорти й події', 'Parking reservations
Discounts
Airports and events', 'Водії в містах.', 'City drivers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'spothero.com' OR LOWER(`name`) = LOWER('SpotHero')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SpotHero books parking in US and Canadian cities in advance with discounts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service for finding and paying for spots in garages and lots near events, airports and offices at discounts versus drive-up rates.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Parking reservations
Discounts
Airports and events', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'City drivers.', 'manual' FROM DUAL WHERE @new = 1;

-- Turo — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'turo.com' OR LOWER(`name`) = LOWER('Turo'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Turo', NULL, 'https://turo.com', NULL, NULL, 'Turo — маркетплейс оренди авто від приватних власників для поїздок будь-якої тривалості.', 'Turo is a marketplace for renting cars from private owners for trips of any length.', 'Сервіс у США, Канаді, Великій Британії, Франції та Австралії з широким вибором авто, доставкою до аеропорту чи дому, страховими планами й заробітком для власників.', 'A service in the US, Canada, UK, France and Australia with a wide car choice, delivery to airport or home, protection plans and earnings for hosts.', 'Авто від власників
Доставка
Страхові плани', 'Cars from owners
Delivery
Protection plans', 'Мандрівники й власники авто.', 'Travellers and car owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'turo.com' OR LOWER(`name`) = LOWER('Turo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Turo is a marketplace for renting cars from private owners for trips of any length.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service in the US, Canada, UK, France and Australia with a wide car choice, delivery to airport or home, protection plans and earnings for hosts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cars from owners
Delivery
Protection plans', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Travellers and car owners.', 'manual' FROM DUAL WHERE @new = 1;

-- Uklon — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'uklon.com.ua' OR LOWER(`name`) = LOWER('Uklon'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Uklon', NULL, 'https://uklon.com.ua', NULL, NULL, 'Uklon — український сервіс замовлення таксі й доставки з різними класами авто та оплатою в застосунку.', 'Uklon is a Ukrainian ride-hailing and delivery service with multiple car classes and in-app payment.', 'Застосунок для замовлення поїздок у містах України й інших країн: класи від економ до бізнес, доставка посилок, попереднє замовлення, оплата карткою й готівкою.', 'An app for booking rides in Ukrainian and other cities: classes from economy to business, parcel delivery, advance booking and card or cash payment.', 'Таксі
Доставка
Класи авто
Оплата в застосунку', 'Rides
Delivery
Car classes
In-app payment', 'Мешканці міст України.', 'City residents in Ukraine.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'uklon.com.ua' OR LOWER(`name`) = LOWER('Uklon')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Uklon is a Ukrainian ride-hailing and delivery service with multiple car classes and in-app payment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app for booking rides in Ukrainian and other cities: classes from economy to business, parcel delivery, advance booking and card or cash payment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Rides
Delivery
Car classes
In-app payment', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'City residents in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;

-- WOG — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wog.ua' OR LOWER(`name`) = LOWER('WOG'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'WOG', NULL, 'https://wog.ua', NULL, NULL, 'WOG — мережа АЗС України з застосунком: оплата пального, програма лояльності, акції й кава.', 'WOG is a Ukrainian fuel station chain with an app: fuel payment, loyalty program, promotions and coffee.', 'Застосунок WOG дозволяє оплачувати пальне й товари без каси, накопичувати бонуси, купувати пальне наперед, знаходити АЗС і замовляти автопослуги.', 'The WOG app lets you pay for fuel and goods without the till, earn bonuses, prepay fuel, find stations and book car services.', 'Оплата пального
Бонуси
Пальне наперед
Мапа АЗС', 'Fuel payment
Bonuses
Prepaid fuel
Station map', 'Водії в Україні.', 'Drivers in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wog.ua' OR LOWER(`name`) = LOWER('WOG')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'WOG is a Ukrainian fuel station chain with an app: fuel payment, loyalty program, promotions and coffee.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The WOG app lets you pay for fuel and goods without the till, earn bonuses, prepay fuel, find stations and book car services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Fuel payment
Bonuses
Prepaid fuel
Station map', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Drivers in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;

-- YourMechanic — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yourmechanic.com' OR LOWER(`name`) = LOWER('YourMechanic'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'YourMechanic', NULL, 'https://www.yourmechanic.com', NULL, NULL, 'YourMechanic — виїзні механіки для ремонту й обслуговування авто вдома чи на роботі з фіксованою ціною.', 'YourMechanic sends mobile mechanics to repair and service your car at home or work at a fixed price.', 'Сервіс у США, що підбирає перевіреного механіка, показує ціну наперед і виконує ремонт на місці, з гарантією на роботу.', 'A US service that matches a vetted mechanic, shows the price upfront and performs repairs on site, with a work warranty.', 'Виїзні механіки
Ціна наперед
Гарантія', 'Mobile mechanics
Upfront price
Warranty', 'Водії в США.', 'US drivers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'yourmechanic.com' OR LOWER(`name`) = LOWER('YourMechanic')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'YourMechanic sends mobile mechanics to repair and service your car at home or work at a fixed price.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A US service that matches a vetted mechanic, shows the price upfront and performs repairs on site, with a work warranty.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Mobile mechanics
Upfront price
Warranty', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US drivers.', 'manual' FROM DUAL WHERE @new = 1;

-- Zapmap — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zapmap.com' OR LOWER(`name`) = LOWER('Zapmap'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Zapmap', NULL, 'https://www.zapmap.com', NULL, NULL, 'Zapmap — мапа зарядних станцій EV у Великій Британії з оплатою, плануванням маршрутів і відгуками.', 'Zapmap maps EV charging stations in the UK with payment, route planning and reviews.', 'Найповніша британська карта зарядок зі статусом у реальному часі, фільтрами за роз''ємом і потужністю, плануванням маршрутів, оплатою Zapmap Pay і відгуками водіїв.', 'The most complete UK charger map with live status, connector and power filters, route planning, Zapmap Pay and driver reviews.', 'Мапа зарядок
Статус у реальному часі
Зapmap Pay
Маршрути', 'Charger map
Live status
Zapmap Pay
Routes', 'Водії EV у Великій Британії.', 'UK EV drivers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zapmap.com' OR LOWER(`name`) = LOWER('Zapmap')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Zapmap maps EV charging stations in the UK with payment, route planning and reviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The most complete UK charger map with live status, connector and power filters, route planning, Zapmap Pay and driver reviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Charger map
Live status
Zapmap Pay
Routes', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'UK EV drivers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базова мапа', 'Basic map' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic map', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ОККО — Авто
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'okko.ua' OR LOWER(`name`) = LOWER('ОККО'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ОККО', NULL, 'https://www.okko.ua', NULL, NULL, 'ОККО — мережа АЗК України з застосунком: картка Fishka, оплата пального, талони й акції.', 'OKKO is a Ukrainian fuel station chain with an app: Fishka card, fuel payment, vouchers and offers.', 'Застосунок мережі дає оплату пального й кави, програму лояльності Fishka, електронні талони, мапу АЗК і пропозиції для водіїв.', 'The chain''s app offers fuel and coffee payment, the Fishka loyalty program, e-vouchers, a station map and driver offers.', 'Програма Fishka
Оплата пального
Електронні талони
Мапа АЗК', 'Fishka program
Fuel payment
E-vouchers
Station map', 'Водії в Україні.', 'Drivers in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'okko.ua' OR LOWER(`name`) = LOWER('ОККО')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'auto' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'OKKO is a Ukrainian fuel station chain with an app: Fishka card, fuel payment, vouchers and offers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The chain''s app offers fuel and coffee payment, the Fishka loyalty program, e-vouchers, a station map and driver offers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Fishka program
Fuel payment
E-vouchers
Station map', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Drivers in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;

-- Apartment Therapy — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apartmenttherapy.com' OR LOWER(`name`) = LOWER('Apartment Therapy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Apartment Therapy', NULL, 'https://www.apartmenttherapy.com', NULL, NULL, 'Apartment Therapy — ідеї оформлення житла, тури квартирами, поради з організації й ремонту для орендарів і власників.', 'Apartment Therapy offers home decor ideas, house tours and organizing and renovation tips for renters and owners.', 'Популярне медіа про дім із реальними турами квартирами, ідеями для малих просторів, порадами з декору, прибирання й організації та оглядами товарів.', 'A popular home publication with real house tours, small-space ideas, decor, cleaning and organizing tips and product reviews.', 'Тури квартирами
Ідеї для малих просторів
Поради з організації', 'House tours
Small-space ideas
Organizing tips', 'Орендарі й власники житла.', 'Renters and homeowners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apartmenttherapy.com' OR LOWER(`name`) = LOWER('Apartment Therapy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Apartment Therapy offers home decor ideas, house tours and organizing and renovation tips for renters and owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A popular home publication with real house tours, small-space ideas, decor, cleaning and organizing tips and product reviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'House tours
Small-space ideas
Organizing tips', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Renters and homeowners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт', 'Website' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ArchiVinci — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'archivinci.com' OR LOWER(`name`) = LOWER('ArchiVinci'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ArchiVinci', NULL, 'https://www.archivinci.com', NULL, NULL, 'ArchiVinci — AI-генератор архітектурних і інтер''єрних рендерів зі скетчів, фото й 3D-моделей.', 'ArchiVinci is an AI generator of architecture and interior renders from sketches, photos and 3D models.', 'Сервіс для архітекторів і дизайнерів, що перетворює ескізи, моделі й фото на реалістичні рендери, змінює стилі, матеріали й освітлення; за кредитами чи підпискою.', 'A service for architects and designers turning sketches, models and photos into realistic renders and changing styles, materials and lighting; by credits or subscription.', 'Рендери зі скетчів
Зміна стилів
Екстер''єри й інтер''єри', 'Sketch to render
Style changes
Exteriors and interiors', 'Архітектори й дизайнери.', 'Architects and designers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'archivinci.com' OR LOWER(`name`) = LOWER('ArchiVinci')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ArchiVinci is an AI generator of architecture and interior renders from sketches, photos and 3D models.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service for architects and designers turning sketches, models and photos into realistic renders and changing styles, materials and lighting; by credits or subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sketch to render
Style changes
Exteriors and interiors', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Architects and designers.', 'manual' FROM DUAL WHERE @new = 1;

-- Chief Architect — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chiefarchitect.com' OR LOWER(`name`) = LOWER('Chief Architect'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Chief Architect', NULL, 'https://www.chiefarchitect.com', NULL, NULL, 'Chief Architect — професійна програма архітектурного проєктування будинків з 3D, кошторисами й робочими кресленнями.', 'Chief Architect is professional home design software with 3D, cost estimates and construction drawings.', 'ПЗ для будівельників, ремонтників і дизайнерів: автоматичне створення стін, дахів і сходів, 3D-перегляд, кошториси матеріалів і креслення; також Home Designer для власників.', 'Software for builders, remodelers and designers: automatic walls, roofs and stairs, 3D views, material estimates and drawings; plus Home Designer for homeowners.', 'Автоматичні дахи й стіни
3D
Кошториси
Креслення', 'Auto roofs and walls
3D
Estimates
Drawings', 'Будівельники й дизайнери.', 'Builders and designers.', 'desktop', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'chiefarchitect.com' OR LOWER(`name`) = LOWER('Chief Architect')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Chief Architect is professional home design software with 3D, cost estimates and construction drawings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Software for builders, remodelers and designers: automatic walls, roofs and stairs, 3D views, material estimates and drawings; plus Home Designer for homeowners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Auto roofs and walls
3D
Estimates
Drawings', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Builders and designers.', 'manual' FROM DUAL WHERE @new = 1;

-- Coohom — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coohom.com' OR LOWER(`name`) = LOWER('Coohom'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Coohom', NULL, 'https://www.coohom.com', NULL, NULL, 'Coohom — безкоштовне онлайн 3D-проєктування житла: плани, меблі, швидкі рендери й 360°-панорами.', 'Coohom is free online 3D home design: floor plans, furniture, fast renders and 360° panoramas.', 'Браузерний сервіс з плануванням кімнат, великою бібліотекою 3D-моделей, хмарним рендерингом за секунди та панорамами 360°; професійні тарифи для дизайнерів.', 'A browser service with room planning, a large 3D model library, cloud rendering in seconds and 360° panoramas; pro plans for designers.', '3D-планування
Швидкі рендери
360°-панорами', '3D planning
Fast renders
360° panoramas', 'Дизайнери й власники.', 'Designers and owners.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coohom.com' OR LOWER(`name`) = LOWER('Coohom')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Coohom is free online 3D home design: floor plans, furniture, fast renders and 360° panoramas.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A browser service with room planning, a large 3D model library, cloud rendering in seconds and 360° panoramas; pro plans for designers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '3D planning
Fast renders
360° panoramas', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Designers and owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базовий план', 'Basic plan' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic plan', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Coolors — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coolors.co' OR LOWER(`name`) = LOWER('Coolors'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Coolors', NULL, 'https://coolors.co', NULL, NULL, 'Coolors — швидкий генератор кольорових палітр для інтер''єру й дизайну з витягуванням кольорів із фото.', 'Coolors is a fast color palette generator for interiors and design with color extraction from photos.', 'Натискаєте пробіл — і отримуєте нову палітру; можна фіксувати кольори, витягувати палітру з фото інтер''єру, перевіряти контраст і зберігати колекції.', 'Press space for a new palette; lock colors, extract a palette from an interior photo, check contrast and save collections.', 'Генератор палітр
Кольори з фото
Колекції', 'Palette generator
Colors from photos
Collections', 'Дизайнери й декоратори.', 'Designers and decorators.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'coolors.co' OR LOWER(`name`) = LOWER('Coolors')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Coolors is a fast color palette generator for interiors and design with color extraction from photos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Press space for a new palette; lock colors, extract a palette from an interior photo, check contrast and save collections.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Palette generator
Colors from photos
Collections', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Designers and decorators.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базова версія', 'Basic version' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic version', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Decorilla — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'decorilla.com' OR LOWER(`name`) = LOWER('Decorilla'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Decorilla', NULL, 'https://www.decorilla.com', NULL, NULL, 'Decorilla — персоналізований онлайн-дизайн інтер''єру з концепціями від кількох дизайнерів і фотореалістичними 3D.', 'Decorilla offers personalized online interior design with concepts from several designers and photorealistic 3D.', 'Клієнт отримує концепції від двох дизайнерів, обирає одну, а далі — фотореалістичні 3D-рендери, план і список покупок зі знижками партнерів.', 'Clients receive concepts from two designers, choose one and then get photorealistic 3D renders, a floor plan and a shopping list with partner discounts.', 'Концепції від 2 дизайнерів
Фотореалістичні 3D
Знижки партнерів', 'Concepts from 2 designers
Photorealistic 3D
Partner discounts', 'Власники житла.', 'Homeowners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'decorilla.com' OR LOWER(`name`) = LOWER('Decorilla')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Decorilla offers personalized online interior design with concepts from several designers and photorealistic 3D.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Clients receive concepts from two designers, choose one and then get photorealistic 3D renders, a floor plan and a shopping list with partner discounts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Concepts from 2 designers
Photorealistic 3D
Partner discounts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- DecorMatters — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'decormatters.com' OR LOWER(`name`) = LOWER('DecorMatters'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DecorMatters', NULL, 'https://decormatters.com', NULL, NULL, 'DecorMatters — застосунок дизайну кімнат з AR, іграми-челенджами й реальними меблями від брендів.', 'DecorMatters is a room design app with AR, design challenges and real furniture from brands.', 'Користувачі оформлюють кімнати з 3D-меблів реальних брендів, приміряють їх через AR у своєму приміщенні, беруть участь у дизайн-челенджах і голосують за проєкти інших.', 'Users design rooms with 3D furniture from real brands, preview items in AR in their space, join design challenges and vote on others'' projects.', 'AR-примірка
Дизайн-челенджі
Реальні меблі', 'AR preview
Design challenges
Real furniture', 'Любителі дизайну.', 'Design enthusiasts.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'decormatters.com' OR LOWER(`name`) = LOWER('DecorMatters')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'DecorMatters is a room design app with AR, design challenges and real furniture from brands.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Users design rooms with 3D furniture from real brands, preview items in AR in their space, join design challenges and vote on others'' projects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AR preview
Design challenges
Real furniture', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Design enthusiasts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- DesignFiles — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'designfiles.co' OR LOWER(`name`) = LOWER('DesignFiles'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DesignFiles', NULL, 'https://www.designfiles.co', NULL, NULL, 'DesignFiles — ПЗ для бізнесу дизайнерів інтер''єру: 2D/3D-дизайни, клієнтський портал, закупівлі й рахунки.', 'DesignFiles is interior design business software: 2D/3D designs, client portal, procurement and invoicing.', 'Платформа, що поєднує створення дизайнів кімнат, презентацію клієнтам, погодження, замовлення товарів, облік закупівель і виставлення рахунків.', 'A platform combining room design creation, client presentation, approvals, product ordering, procurement tracking and invoicing.', '2D/3D-дизайни
Клієнтський портал
Закупівлі
Рахунки', '2D/3D designs
Client portal
Procurement
Invoicing', 'Дизайнери інтер''єру.', 'Interior designers.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'designfiles.co' OR LOWER(`name`) = LOWER('DesignFiles')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'DesignFiles is interior design business software: 2D/3D designs, client portal, procurement and invoicing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform combining room design creation, client presentation, approvals, product ordering, procurement tracking and invoicing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '2D/3D designs
Client portal
Procurement
Invoicing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Interior designers.', 'manual' FROM DUAL WHERE @new = 1;

-- Foyr Neo — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'foyr.com' OR LOWER(`name`) = LOWER('Foyr Neo'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Foyr Neo', NULL, 'https://foyr.com', NULL, NULL, 'Foyr Neo — онлайн 3D-дизайн житла: плани, розстановка меблів і рендери для дизайнерів.', 'Foyr Neo is online 3D home design: floor plans, furniture layout and renders for designers.', 'Браузерне ПЗ для дизайнерів інтер''єру: від плану до фотореалістичного рендера за годину, бібліотека моделей, мудборди й презентації для клієнтів.', 'Browser software for interior designers: from floor plan to photorealistic render in an hour, a model library, moodboards and client presentations.', 'Від плану до рендера
Бібліотека моделей
Презентації', 'Plan to render
Model library
Presentations', 'Дизайнери інтер''єру.', 'Interior designers.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'foyr.com' OR LOWER(`name`) = LOWER('Foyr Neo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Foyr Neo is online 3D home design: floor plans, furniture layout and renders for designers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Browser software for interior designers: from floor plan to photorealistic render in an hour, a model library, moodboards and client presentations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Plan to render
Model library
Presentations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Interior designers.', 'manual' FROM DUAL WHERE @new = 1;

-- Havenly — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'havenly.com' OR LOWER(`name`) = LOWER('Havenly'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Havenly', NULL, 'https://havenly.com', NULL, NULL, 'Havenly — онлайн-дизайн інтер''єру від професійних дизайнерів з 3D-візуалізаціями й списком покупок.', 'Havenly offers online interior design by professional designers with 3D renders and shoppable lists.', 'Сервіс, де дизайнер створює концепцію кімнати за вашим стилем і бюджетом, готує 3D-візуалізації, план і список меблів, які можна купити через платформу.', 'A service where a designer creates a room concept for your style and budget, with 3D renders, a floor plan and a shoppable furniture list.', 'Професійні дизайнери
3D-візуалізації
Список покупок', 'Professional designers
3D renders
Shoppable list', 'Власники житла.', 'Homeowners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'havenly.com' OR LOWER(`name`) = LOWER('Havenly')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Havenly offers online interior design by professional designers with 3D renders and shoppable lists.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service where a designer creates a room concept for your style and budget, with 3D renders, a floor plan and a shoppable furniture list.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Professional designers
3D renders
Shoppable list', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- Hutch — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hutch.io' OR LOWER(`name`) = LOWER('Hutch'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hutch', NULL, 'https://www.hutch.io', NULL, NULL, 'Hutch — AI-застосунок, що за фото кімнати пропонує дизайни з реальними меблями для покупки.', 'Hutch is an AI app that suggests room designs with real, shoppable furniture from a photo.', 'Фотографуєте кімнату, обираєте стиль, і застосунок за допомогою AI розміщує меблі й декор реальних брендів, які можна купити.', 'Photograph your room, choose a style and the app uses AI to place real-brand furniture and decor you can buy.', 'AI-дизайн за фото
Реальні меблі
Покупки', 'AI design from photo
Real furniture
Shopping', 'Власники й орендарі житла.', 'Homeowners and renters.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hutch.io' OR LOWER(`name`) = LOWER('Hutch')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Hutch is an AI app that suggests room designs with real, shoppable furniture from a photo.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Photograph your room, choose a style and the app uses AI to place real-brand furniture and decor you can buy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'AI design from photo
Real furniture
Shopping', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners and renters.', 'manual' FROM DUAL WHERE @new = 1;

-- IKEA Kreativ — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ikea.com/us/en/home-design' OR LOWER(`name`) = LOWER('IKEA Kreativ'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'IKEA Kreativ', NULL, 'https://www.ikea.com/us/en/home-design/', NULL, NULL, 'IKEA Kreativ — AI-інструмент, що сканує вашу кімнату, прибирає наявні меблі й дозволяє розставити 3D-меблі IKEA.', 'IKEA Kreativ is an AI tool that scans your room, erases existing furniture and lets you place IKEA 3D furniture.', 'Знімаєте кімнату на телефон, AI будує точну 3D-сцену, видаляє ваші меблі, а ви розставляєте речі IKEA в масштабі й бачите, як вони виглядатимуть, з переходом до покупки.', 'Capture your room with your phone, AI builds an accurate 3D scene and removes your furniture, and you place IKEA items to scale to see how they look, then shop.', 'Сканування кімнати
Видалення меблів
3D-меблі IKEA', 'Room scan
Furniture erase
IKEA 3D furniture', 'Покупці IKEA.', 'IKEA shoppers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ikea.com/us/en/home-design' OR LOWER(`name`) = LOWER('IKEA Kreativ')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'IKEA Kreativ is an AI tool that scans your room, erases existing furniture and lets you place IKEA 3D furniture.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Capture your room with your phone, AI builds an accurate 3D scene and removes your furniture, and you place IKEA items to scale to see how they look, then shop.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Room scan
Furniture erase
IKEA 3D furniture', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'IKEA shoppers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Онлайн-інструмент', 'Online tool' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Online tool', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Live Home 3D — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'livehome3d.com' OR LOWER(`name`) = LOWER('Live Home 3D'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Live Home 3D', NULL, 'https://www.livehome3d.com', NULL, NULL, 'Live Home 3D — програма дизайну будинку й інтер''єру для iPhone, iPad, Android, Mac і Windows з 2D/3D і рендерами.', 'Live Home 3D is home and interior design software for iPhone, iPad, Android, Mac and Windows with 2D/3D and renders.', 'Дозволяє креслити плани, розставляти меблі з бібліотеки, змінювати матеріали, переглядати проєкт у 3D та AR і робити фотореалістичні рендери та відео-обльоти.', 'It lets you draw floor plans, place library furniture, change materials, view in 3D and AR and create photorealistic renders and fly-through videos.', '2D/3D-плани
AR-перегляд
Рендери й відео', '2D/3D plans
AR view
Renders and videos', 'Власники житла й дизайнери.', 'Homeowners and designers.', 'desktop,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'livehome3d.com' OR LOWER(`name`) = LOWER('Live Home 3D')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Live Home 3D is home and interior design software for iPhone, iPad, Android, Mac and Windows with 2D/3D and renders.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It lets you draw floor plans, place library furniture, change materials, view in 3D and AR and create photorealistic renders and fly-through videos.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '2D/3D plans
AR view
Renders and videos', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners and designers.', 'manual' FROM DUAL WHERE @new = 1;

-- Mattoboard — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mattoboard.com' OR LOWER(`name`) = LOWER('Mattoboard'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Mattoboard', NULL, 'https://www.mattoboard.com', NULL, NULL, 'Mattoboard — конструктор 3D-мудбордів для дизайнерів інтер''єру з реальними матеріалами брендів.', 'Mattoboard is a 3D mood board maker for interior designers with real brand materials.', 'Браузерний інструмент, де дизайнери складають фотореалістичні дошки матеріалів — плитка, тканини, фарби, метали — з реалістичним освітленням і посиланнями на постачальників.', 'A browser tool where designers compose photorealistic material boards — tile, fabrics, paints, metals — with realistic lighting and supplier links.', '3D-мудборди
Реальні матеріали
Посилання на постачальників', '3D mood boards
Real materials
Supplier links', 'Дизайнери інтер''єру.', 'Interior designers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mattoboard.com' OR LOWER(`name`) = LOWER('Mattoboard')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mattoboard is a 3D mood board maker for interior designers with real brand materials.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A browser tool where designers compose photorealistic material boards — tile, fabrics, paints, metals — with realistic lighting and supplier links.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '3D mood boards
Real materials
Supplier links', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Interior designers.', 'manual' FROM DUAL WHERE @new = 1;

-- Morpholio Board — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'morpholioapps.com' OR LOWER(`name`) = LOWER('Morpholio Board'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Morpholio Board', NULL, 'https://www.morpholioapps.com', NULL, NULL, 'Morpholio — застосунки для дизайнерів і архітекторів: Board для мудбордів і Trace для ескізів на iPad.', 'Morpholio makes apps for designers and architects: Board for moodboards and Trace for iPad sketching.', 'Набір інструментів, серед яких Morpholio Board для мудбордів і специфікацій інтер''єру з товарами брендів та Trace для креслення й ескізів поверх планів.', 'A toolset including Morpholio Board for interior moodboards and specs with brand products and Trace for drawing and sketching over plans.', 'Мудборди
Специфікації
Ескізи на iPad', 'Moodboards
Specifications
iPad sketching', 'Дизайнери й архітектори.', 'Designers and architects.', 'mobile,desktop', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'morpholioapps.com' OR LOWER(`name`) = LOWER('Morpholio Board')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Morpholio makes apps for designers and architects: Board for moodboards and Trace for iPad sketching.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A toolset including Morpholio Board for interior moodboards and specs with brand products and Trace for drawing and sketching over plans.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Moodboards
Specifications
iPad sketching', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Designers and architects.', 'manual' FROM DUAL WHERE @new = 1;

-- Paintit.ai — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'paintit.ai' OR LOWER(`name`) = LOWER('Paintit.ai'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Paintit.ai', NULL, 'https://paintit.ai', NULL, NULL, 'Paintit.ai — безкоштовний AI-інструмент редизайну кімнати за фото з вибором стилю.', 'Paintit.ai is a free AI tool to redesign any room from a photo with a chosen style.', 'Онлайн-сервіс, що генерує варіанти інтер''єру за фото: стилі, типи кімнат і заміна елементів; базове використання безкоштовне.', 'An online service that generates interior variants from a photo: styles, room types and element swaps; basic use is free.', 'Редизайн за фото
Стилі
Безкоштовно', 'Photo redesign
Styles
Free', 'Власники житла.', 'Homeowners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'paintit.ai' OR LOWER(`name`) = LOWER('Paintit.ai')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Paintit.ai is a free AI tool to redesign any room from a photo with a chosen style.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An online service that generates interior variants from a photo: styles, room types and element swaps; basic use is free.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Photo redesign
Styles
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базове використання', 'Basic use' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic use', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Programa — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'programa.design' OR LOWER(`name`) = LOWER('Programa'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Programa', NULL, 'https://programa.design', NULL, NULL, 'Programa — ПЗ для керування проєктами дизайну інтер''єру: специфікації, бібліотека товарів, клієнти й рахунки.', 'Programa is interior design project management software: specs, product library, clients and invoicing.', 'Австралійська платформа для дизайн-студій: збір товарів з будь-якого сайту, специфікації, бюджети, погодження з клієнтами, облік часу й фінанси.', 'An Australian platform for design studios: clip products from any site, specifications, budgets, client approvals, time tracking and finances.', 'Бібліотека товарів
Специфікації
Бюджети
Погодження', 'Product library
Specifications
Budgets
Approvals', 'Дизайн-студії.', 'Design studios.', 'web', 'basic', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'programa.design' OR LOWER(`name`) = LOWER('Programa')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Programa is interior design project management software: specs, product library, clients and invoicing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An Australian platform for design studios: clip products from any site, specifications, budgets, client approvals, time tracking and finances.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Product library
Specifications
Budgets
Approvals', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Design studios.', 'manual' FROM DUAL WHERE @new = 1;

-- RoomGPT — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'roomgpt.io' OR LOWER(`name`) = LOWER('RoomGPT'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'RoomGPT', NULL, 'https://www.roomgpt.io', NULL, NULL, 'RoomGPT — AI-редизайн кімнати за фото: оберіть стиль і отримайте варіанти інтер''єру.', 'RoomGPT redesigns your room from a photo with AI: pick a style and get interior variants.', 'Відкритий AI-сервіс: завантажуєте фото кімнати, обираєте тип приміщення й стиль, а модель генерує редизайн; кредити для генерацій купуються.', 'An open AI service: upload a room photo, choose the room type and style, and the model generates a redesign; generation credits are purchased.', 'Редизайн за фото
Стилі
Кредити', 'Photo redesign
Styles
Credits', 'Власники житла.', 'Homeowners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'roomgpt.io' OR LOWER(`name`) = LOWER('RoomGPT')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'RoomGPT redesigns your room from a photo with AI: pick a style and get interior variants.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An open AI service: upload a room photo, choose the room type and style, and the model generates a redesign; generation credits are purchased.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Photo redesign
Styles
Credits', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners.', 'manual' FROM DUAL WHERE @new = 1;

-- Spacejoy — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'spacejoy.com' OR LOWER(`name`) = LOWER('Spacejoy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Spacejoy', NULL, 'https://www.spacejoy.com', NULL, NULL, 'Spacejoy — онлайн-дизайн інтер''єру з 3D-візуалізаціями кімнат і покупкою меблів в одному кошику.', 'Spacejoy offers online interior design with 3D room renders and furniture shopping in one cart.', 'Дизайнери створюють 3D-проєкт вашої кімнати з реальними меблями з різних магазинів, які можна купити в один клік; також застосунок з готовими дизайнами.', 'Designers create a 3D design of your room using real furniture from various stores, purchasable in one click; plus an app with ready designs.', '3D-дизайн кімнат
Реальні меблі
Один кошик', '3D room design
Real furniture
One cart', 'Власники й орендарі житла.', 'Homeowners and renters.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'spacejoy.com' OR LOWER(`name`) = LOWER('Spacejoy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Spacejoy offers online interior design with 3D room renders and furniture shopping in one cart.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Designers create a 3D design of your room using real furniture from various stores, purchasable in one click; plus an app with ready designs.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '3D room design
Real furniture
One cart', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Homeowners and renters.', 'manual' FROM DUAL WHERE @new = 1;

-- Spacely AI — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'spacely.ai' OR LOWER(`name`) = LOWER('Spacely AI'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Spacely AI', NULL, 'https://www.spacely.ai', NULL, NULL, 'Spacely AI — AI-дизайн інтер''єрів і фасадів: рендери зі скетчів, віртуальний стейджинг і стилі.', 'Spacely AI does AI interior and exterior design: renders from sketches, virtual staging and styles.', 'Онлайн-інструмент для дизайнерів, архітекторів і власників: перетворює фото, 3D-моделі чи ескізи на реалістичні рендери, змінює стилі й матеріали; є безкоштовний старт.', 'An online tool for designers, architects and owners: turns photos, 3D models or sketches into realistic renders and swaps styles and materials; free start available.', 'Рендери зі скетчів
Віртуальний стейджинг
Заміна матеріалів', 'Sketch to render
Virtual staging
Material swaps', 'Дизайнери й власники.', 'Designers and owners.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'spacely.ai' OR LOWER(`name`) = LOWER('Spacely AI')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Spacely AI does AI interior and exterior design: renders from sketches, virtual staging and styles.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An online tool for designers, architects and owners: turns photos, 3D models or sketches into realistic renders and swaps styles and materials; free start available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sketch to render
Virtual staging
Material swaps', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Designers and owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Старт', 'Starter' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Starter', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Spoak — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'spoak.com' OR LOWER(`name`) = LOWER('Spoak'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Spoak', NULL, 'https://www.spoak.com', NULL, NULL, 'Spoak — цифрова студія для любителів дизайну інтер''єру: мудборди, плани кімнат, курси й спільнота.', 'Spoak is a digital studio for interior design lovers: moodboards, room plans, courses and community.', 'Платформа, де можна створювати мудборди й плани з реальних товарів, проходити курси дизайнерів і отримувати фідбек спільноти; за підпискою.', 'A platform to create moodboards and plans with real products, take designer courses and get community feedback; by subscription.', 'Мудборди
Плани кімнат
Курси
Спільнота', 'Moodboards
Room plans
Courses
Community', 'Аматори дизайну.', 'Design hobbyists.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'spoak.com' OR LOWER(`name`) = LOWER('Spoak')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Spoak is a digital studio for interior design lovers: moodboards, room plans, courses and community.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform to create moodboards and plans with real products, take designer courses and get community feedback; by subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Moodboards
Room plans
Courses
Community', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Design hobbyists.', 'manual' FROM DUAL WHERE @new = 1;

-- Wayfair — Дизайн інтер'єру
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wayfair.com' OR LOWER(`name`) = LOWER('Wayfair'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Wayfair', NULL, 'https://www.wayfair.com', NULL, NULL, 'Wayfair — онлайн-магазин меблів і декору з AR-переглядом у кімнаті, безкоштовними дизайн-консультаціями й доставкою.', 'Wayfair is an online furniture and decor store with AR room view, free design help and delivery.', 'Каталог мільйонів товарів для дому: меблі, освітлення, текстиль, декор, техніка. Застосунок має «View in Room 3D», візуальний пошук за фото й сервіс дизайн-порад.', 'A catalog of millions of home items: furniture, lighting, textiles, decor and appliances. The app has View in Room 3D, visual search by photo and design advice.', 'Мільйони товарів
AR-перегляд
Візуальний пошук', 'Millions of items
AR preview
Visual search', 'Покупці меблів у США й Європі.', 'Furniture shoppers in the US and Europe.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wayfair.com' OR LOWER(`name`) = LOWER('Wayfair')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'interior-design' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Wayfair is an online furniture and decor store with AR room view, free design help and delivery.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A catalog of millions of home items: furniture, lighting, textiles, decor and appliances. The app has View in Room 3D, visual search by photo and design advice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Millions of items
AR preview
Visual search', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Furniture shoppers in the US and Europe.', 'manual' FROM DUAL WHERE @new = 1;

-- camelcamelcamel — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'camelcamelcamel.com' OR LOWER(`name`) = LOWER('camelcamelcamel'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'camelcamelcamel', NULL, 'https://camelcamelcamel.com', NULL, NULL, 'camelcamelcamel — трекер цін Amazon: графіки історії ціни й сповіщення про зниження.', 'camelcamelcamel is an Amazon price tracker: price history charts and price drop alerts.', 'Безкоштовний сервіс, що показує історію цін на товари Amazon у кількох країнах і надсилає листи, коли ціна падає до бажаного рівня; є розширення Camelizer.', 'A free service showing Amazon price history in several countries and emailing you when the price drops to your target; the Camelizer extension is available.', 'Історія цін Amazon
Сповіщення
Розширення Camelizer', 'Amazon price history
Alerts
Camelizer extension', 'Покупці на Amazon.', 'Amazon shoppers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'camelcamelcamel.com' OR LOWER(`name`) = LOWER('camelcamelcamel')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'camelcamelcamel is an Amazon price tracker: price history charts and price drop alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A free service showing Amazon price history in several countries and emailing you when the price drops to your target; the Camelizer extension is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Amazon price history
Alerts
Camelizer extension', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Amazon shoppers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сайт і розширення', 'Site and extension' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Site and extension', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Capital One Shopping — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'capitaloneshopping.com' OR LOWER(`name`) = LOWER('Capital One Shopping'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Capital One Shopping', NULL, 'https://capitaloneshopping.com', NULL, NULL, 'Capital One Shopping — безкоштовне розширення, що порівнює ціни в сотнях продавців і застосовує купони.', 'Capital One Shopping is a free extension comparing prices across hundreds of sellers and applying coupons.', 'Під час покупки показує дешевші пропозиції в інших магазинах, автоматично застосовує промокоди й нараховує бонуси; не вимагає картки Capital One.', 'While you shop it shows cheaper offers elsewhere, applies coupon codes and earns rewards; no Capital One card required.', 'Порівняння цін
Купони
Бонуси', 'Price comparison
Coupons
Rewards', 'Онлайн-покупці в США.', 'US online shoppers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'capitaloneshopping.com' OR LOWER(`name`) = LOWER('Capital One Shopping')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Capital One Shopping is a free extension comparing prices across hundreds of sellers and applying coupons.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'While you shop it shows cheaper offers elsewhere, applies coupon codes and earns rewards; no Capital One card required.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Price comparison
Coupons
Rewards', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US online shoppers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Розширення', 'Extension' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Extension', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Depop — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'depop.com' OR LOWER(`name`) = LOWER('Depop'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Depop', NULL, 'https://www.depop.com', NULL, NULL, 'Depop (Etsy) — маркетплейс унікальної та вінтажної моди для покоління Z.', 'Depop (Etsy) is a marketplace for unique and vintage fashion popular with Gen Z.', 'Соціальний застосунок для продажу й купівлі вживаного, вінтажного та дизайнерського одягу з профілями продавців, стрічкою та захистом покупок.', 'A social app for buying and selling second-hand, vintage and designer clothing with seller profiles, a feed and purchase protection.', 'Вінтаж
Соціальна стрічка
Захист покупок', 'Vintage
Social feed
Purchase protection', 'Молодь.', 'Young people.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'depop.com' OR LOWER(`name`) = LOWER('Depop')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Depop (Etsy) is a marketplace for unique and vintage fashion popular with Gen Z.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A social app for buying and selling second-hand, vintage and designer clothing with seller profiles, a feed and purchase protection.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Vintage
Social feed
Purchase protection', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Young people.', 'manual' FROM DUAL WHERE @new = 1;

-- Fetch — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fetch.com' OR LOWER(`name`) = LOWER('Fetch'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Fetch', NULL, 'https://fetch.com', NULL, NULL, 'Fetch — застосунок, що нараховує бали за скановані чеки з будь-яких магазинів і обмінює їх на подарункові картки.', 'Fetch awards points for scanned receipts from any store, redeemable for gift cards.', 'Скануєте паперові чи електронні чеки, отримуєте бали, особливо за товари партнерських брендів, і обмінюєте їх на подарункові картки.', 'Scan paper or e-receipts, earn points, especially on partner brands, and redeem them for gift cards.', 'Сканування чеків
Бали
Подарункові картки', 'Receipt scanning
Points
Gift cards', 'Покупці в США.', 'US shoppers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'fetch.com' OR LOWER(`name`) = LOWER('Fetch')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fetch awards points for scanned receipts from any store, redeemable for gift cards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Scan paper or e-receipts, earn points, especially on partner brands, and redeem them for gift cards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Receipt scanning
Points
Gift cards', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US shoppers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Flipp — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'flipp.com' OR LOWER(`name`) = LOWER('Flipp'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Flipp', NULL, 'https://flipp.com', NULL, NULL, 'Flipp — цифрові каталоги акцій магазинів США й Канади, список покупок і купони.', 'Flipp shows digital weekly ads from US and Canadian stores, a shopping list and coupons.', 'Застосунок збирає тижневі флаєри місцевих магазинів, дозволяє шукати товар серед акцій, додавати в список покупок і порівнювати ціни.', 'The app gathers local stores'' weekly flyers, lets you search deals, add items to a shopping list and compare prices.', 'Флаєри магазинів
Пошук акцій
Список покупок', 'Store flyers
Deal search
Shopping list', 'Покупці в Північній Америці.', 'North American shoppers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'flipp.com' OR LOWER(`name`) = LOWER('Flipp')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Flipp shows digital weekly ads from US and Canadian stores, a shopping list and coupons.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app gathers local stores'' weekly flyers, lets you search deals, add items to a shopping list and compare prices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Store flyers
Deal search
Shopping list', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'North American shoppers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Glovo — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'glovoapp.com' OR LOWER(`name`) = LOWER('Glovo'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Glovo', NULL, 'https://glovoapp.com', NULL, NULL, 'Glovo — доставка їжі, продуктів, ліків і покупок з магазинів за хвилини в Україні та інших країнах.', 'Glovo delivers food, groceries, pharmacy items and shop goods in minutes in Ukraine and other countries.', 'Застосунок доставки з ресторанів, супермаркетів, аптек і магазинів з відстеженням кур''єра, підпискою Glovo Prime і оплатою карткою.', 'A delivery app from restaurants, supermarkets, pharmacies and shops with courier tracking, Glovo Prime subscription and card payment.', 'Доставка за хвилини
Супермаркети й аптеки
Glovo Prime', 'Delivery in minutes
Supermarkets and pharmacies
Glovo Prime', 'Мешканці міст.', 'City residents.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'glovoapp.com' OR LOWER(`name`) = LOWER('Glovo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Glovo delivers food, groceries, pharmacy items and shop goods in minutes in Ukraine and other countries.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A delivery app from restaurants, supermarkets, pharmacies and shops with courier tracking, Glovo Prime subscription and card payment.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Delivery in minutes
Supermarkets and pharmacies
Glovo Prime', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'City residents.', 'manual' FROM DUAL WHERE @new = 1;

-- Google Shopping — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shopping.google.com' OR LOWER(`name`) = LOWER('Google Shopping'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Google Shopping', NULL, 'https://shopping.google.com', NULL, NULL, 'Google Покупки — пошук товарів, порівняння цін у магазинах, відстеження знижок і AI-примірка одягу.', 'Google Shopping searches products, compares store prices, tracks deals and offers AI virtual try-on.', 'Сервіс Google, що збирає пропозиції тисяч магазинів, показує історію цін і знижки, дозволяє відстежувати товари й приміряти одяг на моделях за допомогою AI.', 'Google''s service aggregating offers from thousands of stores, showing price history and deals, tracking items and letting you try on clothes on models with AI.', 'Порівняння цін
Історія цін
Відстеження
AI-примірка', 'Price comparison
Price history
Tracking
AI try-on', 'Онлайн-покупці.', 'Online shoppers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shopping.google.com' OR LOWER(`name`) = LOWER('Google Shopping')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Google Shopping searches products, compares store prices, tracks deals and offers AI virtual try-on.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Google''s service aggregating offers from thousands of stores, showing price history and deals, tracking items and letting you try on clothes on models with AI.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Price comparison
Price history
Tracking
AI try-on', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Online shoppers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс Google', 'Google service' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Google service', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Honey — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'joinhoney.com' OR LOWER(`name`) = LOWER('Honey'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Honey', NULL, 'https://www.joinhoney.com', NULL, NULL, 'Honey (PayPal) — розширення браузера, що автоматично шукає й застосовує промокоди та повертає бонуси.', 'Honey (PayPal) is a browser extension that finds and applies coupon codes automatically and gives rewards.', 'Безкоштовне розширення, яке на сторінці оформлення замовлення перебирає купони, показує історію цін на Amazon і нараховує бали PayPal Rewards у партнерських магазинах.', 'A free extension that tries coupons at checkout, shows Amazon price history and earns PayPal Rewards points at partner stores.', 'Автопромокоди
Історія цін
Бонуси', 'Auto coupons
Price history
Rewards', 'Онлайн-покупці.', 'Online shoppers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'joinhoney.com' OR LOWER(`name`) = LOWER('Honey')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Honey (PayPal) is a browser extension that finds and applies coupon codes automatically and gives rewards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A free extension that tries coupons at checkout, shows Amazon price history and earns PayPal Rewards points at partner stores.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Auto coupons
Price history
Rewards', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Online shoppers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Розширення', 'Extension' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Extension', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hotline.ua — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hotline.ua' OR LOWER(`name`) = LOWER('Hotline.ua'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hotline.ua', NULL, 'https://hotline.ua', NULL, NULL, 'Hotline — порівняння цін в інтернет-магазинах України: каталог товарів, графіки цін і відгуки.', 'Hotline compares prices across Ukrainian online stores: product catalog, price charts and reviews.', 'Сервіс, що показує ціни на товар у різних магазинах, історію цін, характеристики, відгуки користувачів і рейтинги магазинів.', 'A service showing a product''s price in various stores, price history, specs, user reviews and store ratings.', 'Порівняння цін
Історія цін
Відгуки', 'Price comparison
Price history
Reviews', 'Покупці в Україні.', 'Shoppers in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hotline.ua' OR LOWER(`name`) = LOWER('Hotline.ua')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Hotline compares prices across Ukrainian online stores: product catalog, price charts and reviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service showing a product''s price in various stores, price history, specs, user reviews and store ratings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Price comparison
Price history
Reviews', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Shoppers in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс', 'Service' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Service', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- idealo — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'idealo.de' OR LOWER(`name`) = LOWER('idealo'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'idealo', NULL, 'https://www.idealo.de', NULL, NULL, 'idealo — провідний європейський сервіс порівняння цін з історією цін і сповіщеннями.', 'idealo is a leading European price comparison service with price history and alerts.', 'Німецький сервіс з мільйонами пропозицій, порівнянням цін магазинів, графіками історії, тестами й застосунком; працює в кількох країнах ЄС.', 'A German service with millions of offers, store price comparison, history charts, tests and an app; operates in several EU countries.', 'Порівняння цін
Графіки історії
Сповіщення', 'Price comparison
History charts
Alerts', 'Покупці в Європі.', 'Shoppers in Europe.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'idealo.de' OR LOWER(`name`) = LOWER('idealo')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'idealo is a leading European price comparison service with price history and alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A German service with millions of offers, store price comparison, history charts, tests and an app; operates in several EU countries.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Price comparison
History charts
Alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Shoppers in Europe.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс', 'Service' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Service', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Instacart — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'instacart.com' OR LOWER(`name`) = LOWER('Instacart'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Instacart', NULL, 'https://www.instacart.com', NULL, NULL, 'Instacart — доставка продуктів або самовивіз із місцевих магазинів у США й Канаді; підписка Instacart+.', 'Instacart delivers groceries or pickup from local stores in the US and Canada; Instacart+ subscription.', 'Сервіс, де персональні покупці збирають замовлення в обраних супермаркетах і привозять за годину; є планування, заміни товарів і підписка Instacart+ з безкоштовною доставкою.', 'A service where personal shoppers pick orders at chosen supermarkets and deliver within an hour; scheduling, replacements and Instacart+ with free delivery.', 'Доставка за годину
Місцеві магазини
Instacart+', 'Delivery in an hour
Local stores
Instacart+', 'Покупці в Північній Америці.', 'North American shoppers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'instacart.com' OR LOWER(`name`) = LOWER('Instacart')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Instacart delivers groceries or pickup from local stores in the US and Canada; Instacart+ subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service where personal shoppers pick orders at chosen supermarkets and deliver within an hour; scheduling, replacements and Instacart+ with free delivery.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Delivery in an hour
Local stores
Instacart+', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'North American shoppers.', 'manual' FROM DUAL WHERE @new = 1;

-- Karma — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'karmanow.com' OR LOWER(`name`) = LOWER('Karma'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Karma', NULL, 'https://www.karmanow.com', NULL, NULL, 'Karma — розширення й застосунок з купонами, кешбеком і сповіщеннями про зниження ціни на збережені товари.', 'Karma is an extension and app with coupons, cash rewards and price drop alerts on saved items.', 'Дозволяє зберігати товари з будь-якого магазину, отримувати сповіщення про знижки й повернення в наявності, автоматично застосовує купони й нараховує кешбек.', 'It saves items from any store, alerts you to price drops and restocks, applies coupons automatically and pays cash rewards.', 'Збереження товарів
Сповіщення про знижки
Купони й кешбек', 'Saved items
Price drop alerts
Coupons and cash back', 'Онлайн-покупці.', 'Online shoppers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'karmanow.com' OR LOWER(`name`) = LOWER('Karma')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Karma is an extension and app with coupons, cash rewards and price drop alerts on saved items.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It saves items from any store, alerts you to price drops and restocks, applies coupons automatically and pays cash rewards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Saved items
Price drop alerts
Coupons and cash back', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Online shoppers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Розширення', 'Extension' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Extension', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Keepa — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'keepa.com' OR LOWER(`name`) = LOWER('Keepa'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Keepa', NULL, 'https://keepa.com', NULL, NULL, 'Keepa — трекер цін Amazon з детальними графіками, сповіщеннями й розширенням для браузера.', 'Keepa is an Amazon price tracker with detailed charts, alerts and a browser extension.', 'Відстежує ціни, рейтинги продажів і пропозиції на всіх майданчиках Amazon, показує графіки прямо на сторінці товару; платна підписка дає дані для продавців.', 'It tracks prices, sales ranks and offers across all Amazon marketplaces and shows charts on product pages; a paid subscription provides seller data.', 'Графіки цін
Сповіщення
Розширення
Дані для продавців', 'Price charts
Alerts
Extension
Seller data', 'Покупці й продавці Amazon.', 'Amazon buyers and sellers.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'keepa.com' OR LOWER(`name`) = LOWER('Keepa')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Keepa is an Amazon price tracker with detailed charts, alerts and a browser extension.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It tracks prices, sales ranks and offers across all Amazon marketplaces and shows charts on product pages; a paid subscription provides seller data.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Price charts
Alerts
Extension
Seller data', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Amazon buyers and sellers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Базове відстеження', 'Basic tracking' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Basic tracking', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Lyst — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lyst.com' OR LOWER(`name`) = LOWER('Lyst'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Lyst', NULL, 'https://www.lyst.com', NULL, NULL, 'Lyst — пошуковик моди: мільйони товарів тисяч брендів і магазинів, сповіщення про знижки.', 'Lyst is a fashion search platform: millions of items from thousands of brands and stores, with sale alerts.', 'Агрегатор люкс- і масової моди, що дозволяє шукати одяг, взуття й аксесуари в багатьох магазинах одночасно, порівнювати ціни й отримувати сповіщення про розпродажі.', 'An aggregator of luxury and mainstream fashion for searching clothes, shoes and accessories across many stores at once, comparing prices and getting sale alerts.', 'Тисячі брендів
Порівняння цін
Сповіщення про розпродажі', 'Thousands of brands
Price comparison
Sale alerts', 'Любителі моди.', 'Fashion shoppers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lyst.com' OR LOWER(`name`) = LOWER('Lyst')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Lyst is a fashion search platform: millions of items from thousands of brands and stores, with sale alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An aggregator of luxury and mainstream fashion for searching clothes, shoes and accessories across many stores at once, comparing prices and getting sale alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Thousands of brands
Price comparison
Sale alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Fashion shoppers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Пошук', 'Search' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Search', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Meest — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'meest.com' OR LOWER(`name`) = LOWER('Meest'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Meest', NULL, 'https://meest.com', NULL, NULL, 'Meest — міжнародна й внутрішня доставка посилок, покупки в зарубіжних магазинах через Meest Shopping.', 'Meest offers international and domestic parcel delivery and overseas shopping via Meest Shopping.', 'Логістична група, що доставляє посилки по Україні та з/до багатьох країн, має відділення й поштомати, сервіс доставки покупок із закордонних інтернет-магазинів і застосунок.', 'A logistics group delivering parcels within Ukraine and to and from many countries, with branches and lockers, an overseas shopping forwarding service and an app.', 'Міжнародна доставка
Покупки за кордоном
Поштомати', 'International delivery
Overseas shopping
Lockers', 'Покупці й відправники.', 'Shoppers and senders.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'meest.com' OR LOWER(`name`) = LOWER('Meest')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Meest offers international and domestic parcel delivery and overseas shopping via Meest Shopping.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A logistics group delivering parcels within Ukraine and to and from many countries, with branches and lockers, an overseas shopping forwarding service and an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'International delivery
Overseas shopping
Lockers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Shoppers and senders.', 'manual' FROM DUAL WHERE @new = 1;

-- OLX.ua — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'olx.ua' OR LOWER(`name`) = LOWER('OLX.ua'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OLX.ua', NULL, 'https://www.olx.ua', NULL, NULL, 'OLX — найбільший сервіс оголошень України: купівля й продаж нових і вживаних товарів з OLX Доставкою.', 'OLX is Ukraine''s largest classifieds service: buying and selling new and used goods with OLX Delivery.', 'Платформа оголошень у всіх категоріях — від техніки й меблів до одягу й речей для дому, з чатом, безпечною оплатою й доставкою OLX та застосунком.', 'A classifieds platform in every category — from electronics and furniture to clothing and home goods — with chat, safe payment, OLX Delivery and an app.', 'Оголошення
OLX Доставка
Чат
Застосунок', 'Classifieds
OLX Delivery
Chat
App', 'Мешканці України.', 'People in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'olx.ua' OR LOWER(`name`) = LOWER('OLX.ua')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'OLX is Ukraine''s largest classifieds service: buying and selling new and used goods with OLX Delivery.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A classifieds platform in every category — from electronics and furniture to clothing and home goods — with chat, safe payment, OLX Delivery and an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Classifieds
OLX Delivery
Chat
App', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Для покупців', 'For buyers' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'For buyers', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Poshmark — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'poshmark.com' OR LOWER(`name`) = LOWER('Poshmark'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Poshmark', NULL, 'https://poshmark.com', NULL, NULL, 'Poshmark — соціальний маркетплейс одягу, декору й косметики, нових і вживаних, у США та Канаді.', 'Poshmark is a social marketplace for new and used fashion, home decor and beauty in the US and Canada.', 'Платформа, де користувачі продають речі зі своєї шафи, проводять онлайн-«вечірки» та прямі ефіри; передплачена етикетка доставки спрощує відправлення.', 'A platform where users sell from their closets, host online parties and live shows; a prepaid shipping label simplifies sending.', 'Продаж із шафи
Прямі ефіри
Передплачена доставка', 'Sell from your closet
Live shows
Prepaid shipping', 'Покупці й продавці в США.', 'US buyers and sellers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'poshmark.com' OR LOWER(`name`) = LOWER('Poshmark')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Poshmark is a social marketplace for new and used fashion, home decor and beauty in the US and Canada.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform where users sell from their closets, host online parties and live shows; a prepaid shipping label simplifies sending.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Sell from your closet
Live shows
Prepaid shipping', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US buyers and sellers.', 'manual' FROM DUAL WHERE @new = 1;

-- Price.ua — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'price.ua' OR LOWER(`name`) = LOWER('Price.ua'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Price.ua', NULL, 'https://price.ua', NULL, NULL, 'Price.ua — порівняння цін інтернет-магазинів України з каталогом і оглядами товарів.', 'Price.ua compares prices of Ukrainian online stores with a catalog and product reviews.', 'Каталог товарів із пропозиціями багатьох магазинів, сортуванням за ціною, характеристиками, порівнянням моделей і відгуками.', 'A product catalog with offers from many stores, price sorting, specs, model comparison and reviews.', 'Порівняння цін
Порівняння моделей
Відгуки', 'Price comparison
Model comparison
Reviews', 'Покупці в Україні.', 'Shoppers in Ukraine.', 'web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'price.ua' OR LOWER(`name`) = LOWER('Price.ua')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Price.ua compares prices of Ukrainian online stores with a catalog and product reviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A product catalog with offers from many stores, price sorting, specs, model comparison and reviews.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Price comparison
Model comparison
Reviews', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Shoppers in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс', 'Service' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Service', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PriceRunner — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pricerunner.com' OR LOWER(`name`) = LOWER('PriceRunner'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PriceRunner', NULL, 'https://www.pricerunner.com', NULL, NULL, 'PriceRunner — порівняння цін у тисячах магазинів Великої Британії та Скандинавії з історією цін.', 'PriceRunner compares prices across thousands of UK and Nordic stores with price history.', 'Сервіс (Klarna) з каталогом мільйонів товарів, порівнянням цін у понад 4 900 магазинах, історією цін, тестами й сповіщеннями.', 'A service (Klarna) with millions of products, price comparison across 4,900+ stores, price history, tests and alerts.', 'Порівняння цін
Історія цін
Сповіщення', 'Price comparison
Price history
Alerts', 'Покупці у Британії.', 'UK shoppers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pricerunner.com' OR LOWER(`name`) = LOWER('PriceRunner')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'PriceRunner compares prices across thousands of UK and Nordic stores with price history.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service (Klarna) with millions of products, price comparison across 4,900+ stores, price history, tests and alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Price comparison
Price history
Alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'UK shoppers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Сервіс', 'Service' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Service', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Prom — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prom.ua' OR LOWER(`name`) = LOWER('Prom'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Prom', NULL, 'https://prom.ua', NULL, NULL, 'Prom — найбільший маркетплейс України з товарами тисяч продавців і програмою захисту покупок.', 'Prom is Ukraine''s largest marketplace with goods from thousands of sellers and purchase protection.', 'Платформа, де малий і середній бізнес продає товари в усіх категоріях, з оплатою Prom-оплата, захистом покупця, доставкою Новою поштою й Укрпоштою та застосунком.', 'A platform where small and mid-sized businesses sell goods in every category, with Prom payment, buyer protection, Nova Poshta and Ukrposhta delivery and an app.', 'Тисячі продавців
Захист покупця
Доставка', 'Thousands of sellers
Buyer protection
Delivery', 'Покупці в Україні.', 'Shoppers in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'prom.ua' OR LOWER(`name`) = LOWER('Prom')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Prom is Ukraine''s largest marketplace with goods from thousands of sellers and purchase protection.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform where small and mid-sized businesses sell goods in every category, with Prom payment, buyer protection, Nova Poshta and Ukrposhta delivery and an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Thousands of sellers
Buyer protection
Delivery', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Shoppers in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;

-- Rakuten — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rakuten.com' OR LOWER(`name`) = LOWER('Rakuten'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Rakuten', NULL, 'https://www.rakuten.com', NULL, NULL, 'Rakuten — кешбек за покупки в тисячах онлайн-магазинів, подорожах і ресторанах.', 'Rakuten gives cash back on purchases at thousands of online stores, travel and dining.', 'Сервіс кешбеку в США: переходите в магазин через Rakuten чи розширення, а відсоток від покупки повертається на рахунок PayPal або чеком щокварталу.', 'A US cash-back service: shop via Rakuten or its extension and a percentage of the purchase is paid quarterly to PayPal or by check.', 'Кешбек
Тисячі магазинів
Розширення', 'Cash back
Thousands of stores
Extension', 'Онлайн-покупці в США.', 'US online shoppers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rakuten.com' OR LOWER(`name`) = LOWER('Rakuten')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Rakuten gives cash back on purchases at thousands of online stores, travel and dining.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A US cash-back service: shop via Rakuten or its extension and a percentage of the purchase is paid quarterly to PayPal or by check.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Cash back
Thousands of stores
Extension', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'US online shoppers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Членство', 'Membership' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Membership', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ROZETKA — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rozetka.com.ua' OR LOWER(`name`) = LOWER('ROZETKA'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ROZETKA', NULL, 'https://rozetka.com.ua', NULL, NULL, 'ROZETKA — найбільший онлайн-гіпермаркет України: техніка, товари для дому, маркетплейс, доставка й ROZETKA Premium.', 'ROZETKA is Ukraine''s largest online hypermarket: electronics, home goods, a marketplace, delivery and ROZETKA Premium.', 'Інтернет-магазин і маркетплейс з мільйонами товарів, власною мережею пунктів видачі, доставкою по країні, розстрочкою й підпискою Premium з безкоштовною доставкою.', 'An online store and marketplace with millions of products, its own pickup network, nationwide delivery, installments and a Premium subscription with free delivery.', 'Мільйони товарів
Пункти видачі
Розстрочка
Premium', 'Millions of items
Pickup points
Installments
Premium', 'Покупці в Україні.', 'Shoppers in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'rozetka.com.ua' OR LOWER(`name`) = LOWER('ROZETKA')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ROZETKA is Ukraine''s largest online hypermarket: electronics, home goods, a marketplace, delivery and ROZETKA Premium.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An online store and marketplace with millions of products, its own pickup network, nationwide delivery, installments and a Premium subscription with free delivery.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Millions of items
Pickup points
Installments
Premium', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Shoppers in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;

-- SHAFA — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shafa.ua' OR LOWER(`name`) = LOWER('SHAFA'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SHAFA', NULL, 'https://shafa.ua', NULL, NULL, 'SHAFA — український маркетплейс одягу, взуття, аксесуарів, косметики й товарів для дому, нових і вживаних.', 'SHAFA is a Ukrainian marketplace for new and used clothing, shoes, accessories, beauty and home goods.', 'Платформа для продажу речей між людьми й від магазинів з захищеною оплатою, доставкою й чатом, популярна для вживаного одягу.', 'A platform for selling items peer-to-peer and from shops with protected payment, delivery and chat, popular for second-hand clothing.', 'Одяг і взуття
Вживані речі
Захищена оплата', 'Clothes and shoes
Second-hand
Protected payment', 'Покупці й продавці в Україні.', 'Buyers and sellers in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shafa.ua' OR LOWER(`name`) = LOWER('SHAFA')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SHAFA is a Ukrainian marketplace for new and used clothing, shoes, accessories, beauty and home goods.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A platform for selling items peer-to-peer and from shops with protected payment, delivery and chat, popular for second-hand clothing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Clothes and shoes
Second-hand
Protected payment', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Buyers and sellers in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;

-- Shop — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shop.app' OR LOWER(`name`) = LOWER('Shop'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Shop', NULL, 'https://shop.app', NULL, NULL, 'Shop (Shopify) — застосунок для покупок у тисячах магазинів Shopify з відстеженням посилок і Shop Pay.', 'Shop (Shopify) is an app for shopping thousands of Shopify stores with package tracking and Shop Pay.', 'Дозволяє знаходити бренди на Shopify, оплачувати в один клік через Shop Pay, автоматично відстежувати всі посилки й отримувати персональні рекомендації та кешбек Shop Cash.', 'It lets you discover Shopify brands, pay in one tap with Shop Pay, auto-track all packages and get personalized picks and Shop Cash rewards.', 'Магазини Shopify
Shop Pay
Відстеження посилок', 'Shopify stores
Shop Pay
Package tracking', 'Онлайн-покупці.', 'Online shoppers.', 'mobile,web', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shop.app' OR LOWER(`name`) = LOWER('Shop')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Shop (Shopify) is an app for shopping thousands of Shopify stores with package tracking and Shop Pay.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'It lets you discover Shopify brands, pay in one tap with Shop Pay, auto-track all packages and get personalized picks and Shop Cash rewards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Shopify stores
Shop Pay
Package tracking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Online shoppers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ShopSavvy — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shopsavvy.com' OR LOWER(`name`) = LOWER('ShopSavvy'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ShopSavvy', NULL, 'https://shopsavvy.com', NULL, NULL, 'ShopSavvy — сканер штрихкодів і порівняння цін у магазинах та онлайн зі сповіщеннями про знижки.', 'ShopSavvy scans barcodes and compares prices in stores and online with deal alerts.', 'Застосунок сканує штрихкод товару в магазині й показує ціни в інших продавців, дозволяє відстежувати товари й отримувати сповіщення про знижки.', 'The app scans a product barcode in store and shows prices at other sellers, tracks items and sends deal alerts.', 'Сканер штрихкодів
Порівняння цін
Сповіщення', 'Barcode scanner
Price comparison
Alerts', 'Покупці.', 'Shoppers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shopsavvy.com' OR LOWER(`name`) = LOWER('ShopSavvy')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'ShopSavvy scans barcodes and compares prices in stores and online with deal alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The app scans a product barcode in store and shows prices at other sellers, tracks items and sends deal alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Barcode scanner
Price comparison
Alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Shoppers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Безкоштовно', 'Free', 0.00, 'free', 'Застосунок', 'App' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Безкоштовно' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'App', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- thredUP — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thredup.com' OR LOWER(`name`) = LOWER('thredUP'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'thredUP', NULL, 'https://www.thredup.com', NULL, NULL, 'thredUP — онлайн-комісійний магазин вживаного одягу: купівля зі знижкою й здача речей на продаж.', 'thredUP is an online consignment and thrift store: buy used clothes at a discount and send in items to sell.', 'Один із найбільших онлайн-магазинів вживаного одягу: тисячі брендів, «Clean Out Kit» для відправлення речей на продаж і сервіс стилістів.', 'One of the largest online used clothing stores: thousands of brands, a Clean Out Kit to send items for resale and stylist boxes.', 'Вживаний одяг
Clean Out Kit
Стилісти', 'Used clothing
Clean Out Kit
Stylists', 'Економні покупці.', 'Budget shoppers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'thredup.com' OR LOWER(`name`) = LOWER('thredUP')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'thredUP is an online consignment and thrift store: buy used clothes at a discount and send in items to sell.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'One of the largest online used clothing stores: thousands of brands, a Clean Out Kit to send items for resale and stylist boxes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Used clothing
Clean Out Kit
Stylists', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Budget shoppers.', 'manual' FROM DUAL WHERE @new = 1;

-- Vinted — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vinted.com' OR LOWER(`name`) = LOWER('Vinted'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Vinted', NULL, 'https://www.vinted.com', NULL, NULL, 'Vinted — маркетплейс вживаного одягу, взуття й речей для дому з продажем без комісії для продавців.', 'Vinted is a marketplace for second-hand clothes, shoes and home items with no seller fees.', 'Європейська платформа, де приватні особи продають і купують вживані речі; покупець сплачує захист і доставку, а продавець не платить комісію. Працює в багатьох країнах ЄС, Великій Британії та США.', 'A European platform where individuals buy and sell second-hand items; buyers pay protection and shipping while sellers pay no fees. Available in many EU countries, the UK and US.', 'Вживані речі
Без комісії для продавців
Захист покупця', 'Second-hand items
No seller fees
Buyer protection', 'Покупці й продавці вживаного.', 'Second-hand buyers and sellers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vinted.com' OR LOWER(`name`) = LOWER('Vinted')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Vinted is a marketplace for second-hand clothes, shoes and home items with no seller fees.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A European platform where individuals buy and sell second-hand items; buyers pay protection and shipping while sellers pay no fees. Available in many EU countries, the UK and US.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Second-hand items
No seller fees
Buyer protection', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Second-hand buyers and sellers.', 'manual' FROM DUAL WHERE @new = 1;

-- Zakaz.ua — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zakaz.ua' OR LOWER(`name`) = LOWER('Zakaz.ua'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Zakaz.ua', NULL, 'https://zakaz.ua', NULL, NULL, 'Zakaz.ua — доставка продуктів із різних супермаркетів України в одному застосунку.', 'Zakaz.ua delivers groceries from various Ukrainian supermarkets in one app.', 'Сервіс, що дає змогу замовити продукти в мережах на кшталт METRO, Novus, Auchan чи Varus із доставкою в обраний інтервал або самовивозом.', 'A service to order groceries from chains like METRO, Novus, Auchan or Varus with delivery in a chosen slot or pickup.', 'Кілька супермаркетів
Доставка в інтервал
Самовивіз', 'Multiple supermarkets
Time-slot delivery
Pickup', 'Покупці в Україні.', 'Shoppers in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'zakaz.ua' OR LOWER(`name`) = LOWER('Zakaz.ua')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Zakaz.ua delivers groceries from various Ukrainian supermarkets in one app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A service to order groceries from chains like METRO, Novus, Auchan or Varus with delivery in a chosen slot or pickup.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Multiple supermarkets
Time-slot delivery
Pickup', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Shoppers in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;

-- Нова пошта — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'novaposhta.ua' OR LOWER(`name`) = LOWER('Нова пошта'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Нова пошта', NULL, 'https://novaposhta.ua', NULL, NULL, 'Нова пошта — служба доставки посилок в Україні й світі з поштоматами, кур''єрами й застосунком.', 'Nova Poshta delivers parcels in Ukraine and worldwide with parcel lockers, couriers and an app.', 'Найбільший український логістичний оператор: відділення й поштомати, адресна доставка, міжнародні відправлення, відстеження, оплата й переадресація в застосунку.', 'Ukraine''s largest logistics operator: branches and parcel lockers, home delivery, international shipping, tracking, payment and redirection in the app.', 'Поштомати
Кур''єрська доставка
Відстеження
Міжнародні відправлення', 'Parcel lockers
Courier delivery
Tracking
International shipping', 'Усі в Україні.', 'Everyone in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'novaposhta.ua' OR LOWER(`name`) = LOWER('Нова пошта')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Nova Poshta delivers parcels in Ukraine and worldwide with parcel lockers, couriers and an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ukraine''s largest logistics operator: branches and parcel lockers, home delivery, international shipping, tracking, payment and redirection in the app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Parcel lockers
Courier delivery
Tracking
International shipping', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Everyone in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;

-- Сільпо — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'silpo.ua' OR LOWER(`name`) = LOWER('Сільпо'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Сільпо', NULL, 'https://silpo.ua', NULL, NULL, 'Сільпо — онлайн-супермаркет з доставкою продуктів до дверей, програмою «Власний рахунок» і застосунком.', 'Silpo is an online supermarket with grocery delivery, the Vlasnyi Rakhunok loyalty program and an app.', 'Українська мережа супермаркетів з онлайн-замовленням, доставкою чи самовивозом, персональними пропозиціями, бонусною програмою й рецептами.', 'A Ukrainian supermarket chain with online ordering, delivery or pickup, personal offers, a bonus program and recipes.', 'Доставка продуктів
Бонусна програма
Персональні пропозиції', 'Grocery delivery
Bonus program
Personal offers', 'Покупці в Україні.', 'Shoppers in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'silpo.ua' OR LOWER(`name`) = LOWER('Сільпо')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Silpo is an online supermarket with grocery delivery, the Vlasnyi Rakhunok loyalty program and an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A Ukrainian supermarket chain with online ordering, delivery or pickup, personal offers, a bonus program and recipes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Grocery delivery
Bonus program
Personal offers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Shoppers in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;

-- Укрпошта — Покупки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ukrposhta.ua' OR LOWER(`name`) = LOWER('Укрпошта'))), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Укрпошта', NULL, 'https://www.ukrposhta.ua', NULL, NULL, 'Укрпошта — національний поштовий оператор України: посилки, листи, міжнародні відправлення й застосунок.', 'Ukrposhta is Ukraine''s national postal operator: parcels, letters, international shipping and an app.', 'Мережа відділень по всій країні, зокрема в селах, доставка посилок і листів, міжнародні відправлення, відстеження й оформлення відправлень онлайн.', 'A branch network across the country, including villages, parcel and letter delivery, international shipping, tracking and online shipment creation.', 'Відділення по всій країні
Міжнародна пошта
Відстеження', 'Nationwide branches
International mail
Tracking', 'Усі в Україні.', 'Everyone in Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-10-07 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ukrposhta.ua' OR LOWER(`name`) = LOWER('Укрпошта')) ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, c.`id` FROM `categories` c WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' LIMIT 1;
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, s.`id` FROM `subcategories` s JOIN `categories` c ON c.`id` = s.`category_id` WHERE @pid IS NOT NULL AND c.`slug` = 'my-home' AND s.`slug` = 'shopping' LIMIT 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Ukrposhta is Ukraine''s national postal operator: parcels, letters, international shipping and an app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'A branch network across the country, including villages, parcel and letter delivery, international shipping, tracking and online shipment creation.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Nationwide branches
International mail
Tracking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Everyone in Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
