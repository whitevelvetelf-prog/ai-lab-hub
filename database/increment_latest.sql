SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-18: «Українські додатки» / «Ukrainian Apps» (slug ukrainian-apps): банки, страхові компанії, нерухомість, оренда житла, ЖК та ОСББ.
-- Нові підкатегорії:
--   * Нерухомість, оренда та ЖК / Real Estate, Rentals & Housing (slug ua-realty)
-- + 34 продуктів (якщо продукт із такою адресою чи назвою вже є — лише прив'язка, тексти не змінюються).
-- Тексти UA/EN написано за офіційними описами застосунків в App Store (регіон UA) та сайтами, звірено 2026-11-18.
-- Ціни не вказано: план «Ціна: див. сайт» (0, one_time); Free — застосунок безкоштовний у магазині застосунків.
-- Пропущено: Смарт-Грант (російськомовний опис), MyBank365 (реєстрацію нових клієнтів зупинено), VARTO (з 2023), СК Перша (з 2020), Reelee (з 2021),
--   KAN Home (російськомовний опис), ZARS (з 2023), Click і «Ідеальний варіант» (походження не підтверджено), Korter (не для ринку України).
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою.
-- Застосування: phpMyAdmin → БД → «Импорт». Повторний запуск безпечний.
--   SkyBank — Банки
--   Smart Bank 3/4 — Банки
--   MTB360 — Банки
--   Industrial24 — Банки
--   PINbank Online — Банки
--   CAPIbank — Банки
--   amobank — Банки
--   AP Bank (Агропросперіс Банк) — Банки
--   Winbank Ukraine — Банки
--   BIS24 — Банки
--   Банк Власний Рахунок — Банки
--   ІНГО — Страхування, Медицина й аптеки
--   lilo — Страхування, Медицина й аптеки
--   Країна — страхова компанія — Страхування
--   КД Життя mobile — Страхування
--   Штрафи UA — Страхування, АЗС і водіям
--   IZI Polis Агент — Страхування, Для бізнесу та ФОП
--   Insurance Ukraine — Страхування, Транспорт і квитки
--   bird — Нерухомість, оренда та ЖК
--   HataHub — Нерухомість, оренда та ЖК
--   Dexby — Нерухомість, оренда та ЖК
--   Josti — Нерухомість, оренда та ЖК
--   Qvico — Нерухомість, оренда та ЖК
--   Мій ЖК: Новобудови — Нерухомість, оренда та ЖК
--   Home Rate — Нерухомість, оренда та ЖК
--   Реєстр нерухомості — Нерухомість, оренда та ЖК
--   База — для рієлторів — Нерухомість, оренда та ЖК, Для бізнесу та ФОП
--   Вдома — Нерухомість, оренда та ЖК, Платежі та комуналка
--   My IGB — Нерухомість, оренда та ЖК
--   TRIIINITY — Нерухомість, оренда та ЖК
--   Моє містечко (Svitlo Development) — Нерухомість, оренда та ЖК
--   Дах — Нерухомість, оренда та ЖК, Платежі та комуналка
--   Моє ОСББ — Нерухомість, оренда та ЖК, Платежі та комуналка
--   proOSBB — Вінниця — Нерухомість, оренда та ЖК, Міські застосунки
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'ukrainian-apps' LIMIT 1);
INSERT INTO `subcategories` (`category_id`, `name`, `name_en`, `slug`) SELECT @cat, 'Нерухомість, оренда та ЖК', 'Real Estate, Rentals & Housing', 'ua-realty' FROM DUAL WHERE @cat IS NOT NULL AND NOT EXISTS (SELECT 1 FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty');

-- SkyBank — Банки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sky.bank' OR LOWER(`name`) = 'skybank')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SkyBank', NULL, 'https://sky.bank', NULL, NULL, 'Мобільний банк СкайБанку: картки, депозити, платежі й автоплатежі для фізичних і юридичних осіб.', 'SkyBank mobile banking: cards, deposits, payments and auto-payments for individuals and businesses.', 'SkyBank — український онлайн-банк у смартфоні. Застосунок дає фізичним і юридичним особам доступ до дебетових і кредитних карток, депозитів і платежів, дозволяє стежити за витратами й переказувати гроші. Можна налаштувати автоплатежі та шаблони, знайти відділення й банкомати; вхід захищено кодом і біометрією, підтримка працює в онлайн-чаті.', 'SkyBank is a Ukrainian online bank on your phone. The app gives individuals and businesses access to debit and credit cards, deposits and payments, and lets you track spending and transfer money. You can set up auto-payments and templates and find branches and ATMs; login is protected by a code and biometrics, and support is available in online chat.', 'Дебетові та кредитні картки
Депозити
Платежі, автоплатежі й шаблони
Відділення та банкомати на мапі
Підтримка в чаті', 'Debit and credit cards
Deposits
Payments, auto-payments and templates
Branches and ATMs on a map
Chat support', 'Клієнтам банку, які хочуть керувати рахунками й картками зі смартфона.', 'Bank customers who want to manage accounts and cards from their phone.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sky.bank' OR LOWER(`name`) = 'skybank') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-banks' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'SkyBank mobile banking: cards, deposits, payments and auto-payments for individuals and businesses.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SkyBank is a Ukrainian online bank on your phone. The app gives individuals and businesses access to debit and credit cards, deposits and payments, and lets you track spending and transfer money. You can set up auto-payments and templates and find branches and ATMs; login is protected by a code and biometrics, and support is available in online chat.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Debit and credit cards
Deposits
Payments, auto-payments and templates
Branches and ATMs on a map
Chat support', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Bank customers who want to manage accounts and cards from their phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Smart Bank 3/4 — Банки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bank34.ua' OR LOWER(`name`) = 'smart bank 3/4')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Smart Bank 3/4', NULL, 'https://bank34.ua', NULL, NULL, 'Мобільний банкінг АТ «Банк 3/4»: віртуальна картка, перекази P2P та за IBAN, ліміти й Apple Pay.', 'Mobile banking of JSC Bank 3/4: virtual card, P2P and IBAN transfers, limits and Apple Pay.', 'Smart Bank 3/4 — мобільний банкінг українського комерційного банку АТ «Банк 3/4». У застосунку можна відкрити поточний рахунок із віртуальною карткою, стежити за картковими, поточними й депозитними рахунками, робити миттєві перекази за номером картки та платежі за IBAN, створювати шаблони, блокувати картку й встановлювати ліміти, платити через Apple Pay. Вхід — за Touch ID чи Face ID, підтримка 24/7.', 'Smart Bank 3/4 is the mobile banking app of the Ukrainian commercial bank JSC Bank 3/4. You can open a current account with a virtual card, track card, current and deposit accounts, make instant card-to-card transfers and IBAN payments, create templates, block cards and set limits, and pay with Apple Pay. Login uses Touch ID or Face ID, with 24/7 support.', 'Віртуальна картка онлайн
Перекази P2P і за IBAN
Шаблони платежів
Керування лімітами й блокуванням
Apple Pay', 'Virtual card online
P2P and IBAN transfers
Payment templates
Limits and card blocking
Apple Pay', 'Клієнтам банку, які хочуть керувати рахунками й картками зі смартфона.', 'Bank customers who want to manage accounts and cards from their phone.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bank34.ua' OR LOWER(`name`) = 'smart bank 3/4') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-banks' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mobile banking of JSC Bank 3/4: virtual card, P2P and IBAN transfers, limits and Apple Pay.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Smart Bank 3/4 is the mobile banking app of the Ukrainian commercial bank JSC Bank 3/4. You can open a current account with a virtual card, track card, current and deposit accounts, make instant card-to-card transfers and IBAN payments, create templates, block cards and set limits, and pay with Apple Pay. Login uses Touch ID or Face ID, with 24/7 support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Virtual card online
P2P and IBAN transfers
Payment templates
Limits and card blocking
Apple Pay', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Bank customers who want to manage accounts and cards from their phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- MTB360 — Банки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mtb.ua' OR LOWER(`name`) = 'mtb360')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'MTB360', NULL, 'https://mtb.ua', NULL, NULL, 'Онлайн-банк МТБ БАНКу: усі основні фінансові операції цілодобово в одному застосунку.', 'MTB BANK online banking: all essential financial operations 24/7 in one app.', 'MTB360 — онлайн-банк від МТБ БАНКу. Застосунок дає змогу керувати фінансами цілодобово без черг, паперів і привʼязки до міста: усі основні банківські операції зібрано в одному інтерфейсі.', 'MTB360 is the online bank from MTB BANK. The app lets you manage your finances around the clock without queues, paperwork or being tied to one city, with all essential banking operations in a single interface.', 'Керування рахунками й картками
Перекази та платежі
Цілодобовий доступ', 'Account and card management
Transfers and payments
24/7 access', 'Клієнтам банку, які хочуть керувати рахунками й картками зі смартфона.', 'Bank customers who want to manage accounts and cards from their phone.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mtb.ua' OR LOWER(`name`) = 'mtb360') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-banks' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'MTB BANK online banking: all essential financial operations 24/7 in one app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MTB360 is the online bank from MTB BANK. The app lets you manage your finances around the clock without queues, paperwork or being tied to one city, with all essential banking operations in a single interface.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Account and card management
Transfers and payments
24/7 access', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Bank customers who want to manage accounts and cards from their phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Industrial24 — Банки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'industrialbank.ua' OR LOWER(`name`) = 'industrial24')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Industrial24', NULL, 'https://industrialbank.ua', NULL, NULL, 'Мобільний банк Індустріалбанку: перекази, керування картками, шаблони й виписки.', 'Industrialbank mobile banking: transfers, card management, templates and statements.', 'Industrial24 — мобільний застосунок Індустріалбанку. Безкоштовні перекази між своїми рахунками й усередині банку, керування картками онлайн (блокування, ліміти), шаблони й клонування платежів, квитанції та виписки, курси валют, новини банку й відділення на мапі.', 'Industrial24 is Industrialbank’s mobile app. It offers free transfers between your accounts and within the bank, online card management (blocking, limits), payment templates and cloning, receipts and statements, exchange rates, bank news and branches on a map.', 'Перекази між рахунками
Керування картками й лімітами
Шаблони платежів
Виписки й квитанції
Відділення на мапі', 'Transfers between accounts
Card and limit management
Payment templates
Statements and receipts
Branches on a map', 'Клієнтам банку, які хочуть керувати рахунками й картками зі смартфона.', 'Bank customers who want to manage accounts and cards from their phone.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'industrialbank.ua' OR LOWER(`name`) = 'industrial24') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-banks' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Industrialbank mobile banking: transfers, card management, templates and statements.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Industrial24 is Industrialbank’s mobile app. It offers free transfers between your accounts and within the bank, online card management (blocking, limits), payment templates and cloning, receipts and statements, exchange rates, bank news and branches on a map.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Transfers between accounts
Card and limit management
Payment templates
Statements and receipts
Branches on a map', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Bank customers who want to manage accounts and cards from their phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- PINbank Online — Банки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pinbank.ua' OR LOWER(`name`) = 'pinbank online')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'PINbank Online', NULL, 'https://www.pinbank.ua', NULL, NULL, 'Мобільний банк Першого Інвестиційного Банку: картки, рахунки, ліміти й платежі 24/7.', 'First Investment Bank mobile banking: cards, accounts, limits and payments 24/7.', 'PINbank Online — застосунок Першого Інвестиційного Банку для цілодобового доступу до рахунків і банківських продуктів. У ньому можна переглядати залишки й рух коштів, змінювати ліміти, блокувати й розблоковувати картки та виконувати операції, які раніше були доступні лише у відділенні.', 'PINbank Online is First Investment Bank’s app for 24/7 access to accounts and banking products. You can view balances and transactions, change limits, block and unblock cards and carry out operations that were previously only available at a branch.', 'Залишки й рух коштів
Керування лімітами
Блокування карток
Платежі й перекази', 'Balances and transactions
Limit management
Card blocking
Payments and transfers', 'Клієнтам банку, які хочуть керувати рахунками й картками зі смартфона.', 'Bank customers who want to manage accounts and cards from their phone.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'pinbank.ua' OR LOWER(`name`) = 'pinbank online') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-banks' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'First Investment Bank mobile banking: cards, accounts, limits and payments 24/7.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'PINbank Online is First Investment Bank’s app for 24/7 access to accounts and banking products. You can view balances and transactions, change limits, block and unblock cards and carry out operations that were previously only available at a branch.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Balances and transactions
Limit management
Card blocking
Payments and transfers', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Bank customers who want to manage accounts and cards from their phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- CAPIbank — Банки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1567532308' OR LOWER(`name`) = 'capibank')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'CAPIbank', NULL, 'https://apps.apple.com/ua/app/id1567532308', NULL, NULL, 'Цифровий банк АТ «Банк Український Капітал»: рахунок через Дію, кредит, перекази й комуналка.', 'Digital bank of JSC Bank Ukrainian Capital: account via Diia, loans, transfers and utility payments.', 'CAPIbank — цифровий банк АТ «Банк Український Капітал». Рахунок відкривається без відвідування відділення — через Дію або відеоверифікацію. У застосунку доступні кредит, перекази з картки на картку й за реквізитами, обмін валют, оплата комунальних послуг, історія платежів і пошук найближчих банкоматів і відділень.', 'CAPIbank is the digital bank of JSC Bank Ukrainian Capital. You open an account without visiting a branch, via Diia or video verification. The app offers loans, card-to-card and IBAN transfers, currency exchange, utility payments, payment history and the nearest ATMs and branches.', 'Відкриття рахунку через Дію
Кредит онлайн
Перекази й обмін валют
Оплата комуналки
Банкомати й відділення', 'Account opening via Diia
Online loans
Transfers and currency exchange
Utility payments
ATMs and branches', 'Клієнтам банку, які хочуть керувати рахунками й картками зі смартфона.', 'Bank customers who want to manage accounts and cards from their phone.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1567532308' OR LOWER(`name`) = 'capibank') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-banks' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Digital bank of JSC Bank Ukrainian Capital: account via Diia, loans, transfers and utility payments.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'CAPIbank is the digital bank of JSC Bank Ukrainian Capital. You open an account without visiting a branch, via Diia or video verification. The app offers loans, card-to-card and IBAN transfers, currency exchange, utility payments, payment history and the nearest ATMs and branches.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Account opening via Diia
Online loans
Transfers and currency exchange
Utility payments
ATMs and branches', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Bank customers who want to manage accounts and cards from their phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- amobank — Банки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'asviobank.ua' OR LOWER(`name`) = 'amobank')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'amobank', NULL, 'https://www.asviobank.ua', NULL, NULL, 'Мобільний банк Асвіо Банку: рахунок через Дію, гривневі й валютні віртуальні картки.', 'Asvio Bank mobile bank: account via Diia, hryvnia and foreign-currency virtual cards.', 'amobank — мобільний банк від Асвіо Банку. Рахунок відкривається в застосунку за кілька хвилин через Дію. Одразу доступний пакет віртуальних карток: дебетова й кредитна в гривні та валютні в доларах і євро. Можна поповнювати мобільний, платити через Apple Pay і Google Pay; підтримка працює 24/7.', 'amobank is Asvio Bank’s mobile bank. You open an account in the app in minutes via Diia and immediately get a set of virtual cards: hryvnia debit and credit cards plus USD and EUR cards. You can top up mobile phones and pay with Apple Pay and Google Pay; support is available 24/7.', 'Рахунок через Дію
Дебетова й кредитна картки
Картки в доларах і євро
Apple Pay і Google Pay
Підтримка 24/7', 'Account via Diia
Debit and credit cards
USD and EUR cards
Apple Pay and Google Pay
24/7 support', 'Клієнтам банку, які хочуть керувати рахунками й картками зі смартфона.', 'Bank customers who want to manage accounts and cards from their phone.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'asviobank.ua' OR LOWER(`name`) = 'amobank') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-banks' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Asvio Bank mobile bank: account via Diia, hryvnia and foreign-currency virtual cards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'amobank is Asvio Bank’s mobile bank. You open an account in the app in minutes via Diia and immediately get a set of virtual cards: hryvnia debit and credit cards plus USD and EUR cards. You can top up mobile phones and pay with Apple Pay and Google Pay; support is available 24/7.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Account via Diia
Debit and credit cards
USD and EUR cards
Apple Pay and Google Pay
24/7 support', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Bank customers who want to manage accounts and cards from their phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AP Bank (Агропросперіс Банк) — Банки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1496604539' OR LOWER(`name`) = 'ap bank (агропросперіс банк)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AP Bank (Агропросперіс Банк)', NULL, 'https://apps.apple.com/ua/app/id1496604539', NULL, NULL, 'Мобільний банкінг Агропросперіс Банку: перекази, депозити, валюта й віртуальна картка.', 'Agroprosperis Bank mobile banking: transfers, deposits, currency and virtual card.', 'AP Bank — мобільний банкінг від Агропросперіс Банку. У застосунку можна переказувати кошти між картками й за IBAN, зокрема миттєво, перевіряти залишки й виписки, відкрити віртуальну картку, відкривати й поповнювати депозити, обмінювати валюту онлайн і подати запит на кредитний ліміт.', 'AP Bank is the mobile banking app of Agroprosperis Bank. You can transfer money between cards and by IBAN, including instant transfers, check balances and statements, open a virtual card, open and top up deposits, exchange currency online and request a credit limit.', 'Перекази між картками й за IBAN
Віртуальна картка
Депозити
Обмін валют
Кредитний ліміт', 'Card and IBAN transfers
Virtual card
Deposits
Currency exchange
Credit limit', 'Клієнтам банку, які хочуть керувати рахунками й картками зі смартфона.', 'Bank customers who want to manage accounts and cards from their phone.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1496604539' OR LOWER(`name`) = 'ap bank (агропросперіс банк)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-banks' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Agroprosperis Bank mobile banking: transfers, deposits, currency and virtual card.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'AP Bank is the mobile banking app of Agroprosperis Bank. You can transfer money between cards and by IBAN, including instant transfers, check balances and statements, open a virtual card, open and top up deposits, exchange currency online and request a credit limit.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Card and IBAN transfers
Virtual card
Deposits
Currency exchange
Credit limit', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Bank customers who want to manage accounts and cards from their phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Winbank Ukraine — Банки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6444044783' OR LOWER(`name`) = 'winbank ukraine')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Winbank Ukraine', NULL, 'https://apps.apple.com/ua/app/id6444044783', NULL, NULL, 'Мобільний банк Піреус Банку в Україні: рахунки, картки, депозити, платежі й обмін валют.', 'Piraeus Bank Ukraine mobile banking: accounts, cards, deposits, payments and currency exchange.', 'Winbank — мобільний застосунок Піреус Банку в Україні. Він дозволяє керувати рахунками, картками й депозитами, безпечно платити й переказувати гроші, поповнювати мобільний, відкривати нові продукти та обмінювати валюту з будь-якої точки світу.', 'Winbank is Piraeus Bank Ukraine’s mobile app. It lets you manage accounts, cards and deposits, make secure payments and transfers, top up mobile phones, open new products and exchange currency from anywhere in the world.', 'Рахунки й картки
Депозити
Платежі та перекази
Обмін валют
Поповнення мобільного', 'Accounts and cards
Deposits
Payments and transfers
Currency exchange
Mobile top-ups', 'Клієнтам банку, які хочуть керувати рахунками й картками зі смартфона.', 'Bank customers who want to manage accounts and cards from their phone.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6444044783' OR LOWER(`name`) = 'winbank ukraine') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-banks' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Piraeus Bank Ukraine mobile banking: accounts, cards, deposits, payments and currency exchange.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Winbank is Piraeus Bank Ukraine’s mobile app. It lets you manage accounts, cards and deposits, make secure payments and transfers, top up mobile phones, open new products and exchange currency from anywhere in the world.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Accounts and cards
Deposits
Payments and transfers
Currency exchange
Mobile top-ups', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Bank customers who want to manage accounts and cards from their phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- BIS24 — Банки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6670791255' OR LOWER(`name`) = 'bis24')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'BIS24', NULL, 'https://apps.apple.com/ua/app/id6670791255', NULL, NULL, 'Мобільний застосунок БІЗБАНКу: віртуальна картка, перекази, комуналка й обмін валют.', 'BIZBANK mobile app: virtual card, transfers, utility payments and currency exchange.', 'BIS 24 — мобільний застосунок БІЗБАНКу (Банк інвестицій та заощаджень). Можна оформити віртуальну картку без відвідування відділення, керувати рахунками, робити перекази, оплачувати комунальні послуги, поповнювати мобільний і обмінювати валюту.', 'BIS 24 is the mobile app of BIZBANK (Bank of Investments and Savings). You can get a virtual card without visiting a branch, manage accounts, make transfers, pay utilities, top up mobile phones and exchange currency.', 'Віртуальна картка онлайн
Перекази
Оплата комуналки
Обмін валют', 'Online virtual card
Transfers
Utility payments
Currency exchange', 'Клієнтам банку, які хочуть керувати рахунками й картками зі смартфона.', 'Bank customers who want to manage accounts and cards from their phone.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6670791255' OR LOWER(`name`) = 'bis24') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-banks' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'BIZBANK mobile app: virtual card, transfers, utility payments and currency exchange.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'BIS 24 is the mobile app of BIZBANK (Bank of Investments and Savings). You can get a virtual card without visiting a branch, manage accounts, make transfers, pay utilities, top up mobile phones and exchange currency.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Online virtual card
Transfers
Utility payments
Currency exchange', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Bank customers who want to manage accounts and cards from their phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Банк Власний Рахунок — Банки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1499995681' OR LOWER(`name`) = 'банк власний рахунок')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Банк Власний Рахунок', NULL, 'https://apps.apple.com/ua/app/id1499995681', NULL, NULL, 'Цифровий банк для покупців «Сільпо»: віртуальна картка за 5 хвилин і бонуси за покупки.', 'Digital bank for Silpo shoppers: virtual card in 5 minutes and bonus points on purchases.', 'Банк Власний Рахунок — цифровий банк для гостей «Сільпо». Віртуальну картку можна відкрити в застосунку за 5 хвилин. З карткою нараховується більше балобонусів за покупки в «Сільпо», а поповнювати картку й знімати готівку можна на касах супермаркету.', 'Bank Vlasnyi Rakhunok is a digital bank for Silpo shoppers. You can open a virtual card in the app in 5 minutes. The card earns extra Silpo bonus points, and you can top it up and withdraw cash at Silpo checkouts.', 'Віртуальна картка за 5 хвилин
Балобонуси в «Сільпо»
Поповнення й зняття готівки на касах
Власні й кредитні кошти', 'Virtual card in 5 minutes
Silpo bonus points
Top-ups and cash withdrawal at checkouts
Own and credit funds', 'Покупцям «Сільпо».', 'Silpo shoppers.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1499995681' OR LOWER(`name`) = 'банк власний рахунок') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-banks' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Digital bank for Silpo shoppers: virtual card in 5 minutes and bonus points on purchases.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Bank Vlasnyi Rakhunok is a digital bank for Silpo shoppers. You can open a virtual card in the app in 5 minutes. The card earns extra Silpo bonus points, and you can top it up and withdraw cash at Silpo checkouts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Virtual card in 5 minutes
Silpo bonus points
Top-ups and cash withdrawal at checkouts
Own and credit funds', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Silpo shoppers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ІНГО — Страхування, Медицина й аптеки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ingo.ua' OR LOWER(`name`) = 'інго')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ІНГО', NULL, 'https://ingo.ua', NULL, NULL, 'Застосунок страхової ІНГО: запис до лікаря за страховкою, поліси й дії при страховому випадку.', 'INGO insurance app: doctor booking under your policy, policies and claims guidance.', 'Застосунок страхової компанії ІНГО збирає всі страховки в одному місці. Клієнти з медичним страхуванням можуть записатися до лікаря без дзвінків, обрати один із 11 000 медзакладів та аптек, що покриваються полісом, отримати підказку, до якого лікаря звернутися, і замовити доставку ліків. Також тут є договори, нагадування про платежі, дії при страховому випадку й швидкий звʼязок.', 'The INGO insurance app keeps all your policies in one place. Customers with health insurance can book a doctor without calling, choose from 11,000 covered clinics and pharmacies, get a hint on which doctor to see and order medicine delivery. It also holds contracts, payment reminders, claims guidance and quick contact with the insurer.', 'Запис до лікаря за полісом
11 000 медзакладів і аптек
Усі договори в застосунку
Нагадування про платежі
Дії при страховому випадку', 'Doctor booking under your policy
11,000 clinics and pharmacies
All contracts in the app
Payment reminders
Claims guidance', 'Клієнтам страхової компанії ІНГО.', 'INGO insurance customers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ingo.ua' OR LOWER(`name`) = 'інго') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-insurance' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-health' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'INGO insurance app: doctor booking under your policy, policies and claims guidance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The INGO insurance app keeps all your policies in one place. Customers with health insurance can book a doctor without calling, choose from 11,000 covered clinics and pharmacies, get a hint on which doctor to see and order medicine delivery. It also holds contracts, payment reminders, claims guidance and quick contact with the insurer.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Doctor booking under your policy
11,000 clinics and pharmacies
All contracts in the app
Payment reminders
Claims guidance', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'INGO insurance customers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- lilo — Страхування, Медицина й аптеки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lilo.ua' OR LOWER(`name`) = 'lilo')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'lilo', NULL, 'https://lilo.ua', NULL, NULL, 'Медична підписка замість класичного страхування: особистий лікар, чекап і запис у клініки.', 'A health subscription instead of classic insurance: personal doctor, check-up and clinic booking.', 'lilo — медична підписка, яка замінює традиційне страхування. Особистий лікар приймає офлайн і онлайн, знає медичну історію й координує лікування. Залежно від програми доступний персональний чекап. У застосунку можна записатися до вузьких спеціалістів, на аналізи й діагностику в клініки-партнери (Добробут, Медіком, Oxford Medical, Діла та інші), користуватися 8000+ аптек і тривожною кнопкою виклику швидкої.', 'lilo is a health subscription that replaces traditional insurance. A personal doctor sees you in person and online, knows your history and coordinates treatment. Depending on the plan, a personal check-up is included. In the app you can book specialists, tests and diagnostics at partner clinics (Dobrobut, Medikom, Oxford Medical, Dila and others), use 8,000+ pharmacies and an emergency button to call an ambulance.', 'Особистий лікар онлайн і офлайн
Персональний чекап
Запис у клініки-партнери
Медична історія в одному місці
Кнопка виклику швидкої', 'Personal doctor online and offline
Personal check-up
Booking at partner clinics
Medical history in one place
Ambulance button', 'Тим, хто хоче постійного лікаря й профілактику замість класичного полісу.', 'People who want a regular doctor and prevention instead of a classic policy.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'lilo.ua' OR LOWER(`name`) = 'lilo') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-insurance' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-health' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'A health subscription instead of classic insurance: personal doctor, check-up and clinic booking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'lilo is a health subscription that replaces traditional insurance. A personal doctor sees you in person and online, knows your history and coordinates treatment. Depending on the plan, a personal check-up is included. In the app you can book specialists, tests and diagnostics at partner clinics (Dobrobut, Medikom, Oxford Medical, Dila and others), use 8,000+ pharmacies and an emergency button to call an ambulance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Personal doctor online and offline
Personal check-up
Booking at partner clinics
Medical history in one place
Ambulance button', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People who want a regular doctor and prevention instead of a classic policy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Країна — страхова компанія — Страхування
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'krayina.com' OR LOWER(`name`) = 'країна — страхова компанія')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Країна — страхова компанія', NULL, 'https://krayina.com', NULL, NULL, 'Мобільний кабінет клієнта страхової компанії «Країна»: поліси, медичні звернення й підтримка.', 'Customer app of Krayina insurance company: policies, medical claims and support.', '«Країна» — мобільний кабінет клієнта страхової компанії «Країна». Вхід — за номером телефону й одноразовим кодом. У застосунку можна переглядати свої поліси та їхні деталі, стежити за медичними зверненнями й швидко знайти контакти підтримки.', 'Krayina is the customer app of Krayina insurance company. You log in with your phone number and a one-time code, view your policies and their details, track medical claims and quickly find support contacts.', 'Вхід за номером телефону
Перегляд полісів
Медичні звернення
Контакти підтримки', 'Phone-number login
Policy overview
Medical claims
Support contacts', 'Клієнтам страхової компанії «Країна».', 'Krayina insurance customers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'krayina.com' OR LOWER(`name`) = 'країна — страхова компанія') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-insurance' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Customer app of Krayina insurance company: policies, medical claims and support.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Krayina is the customer app of Krayina insurance company. You log in with your phone number and a one-time code, view your policies and their details, track medical claims and quickly find support contacts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Phone-number login
Policy overview
Medical claims
Support contacts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Krayina insurance customers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- КД Життя mobile — Страхування
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kd-life.com.ua' OR LOWER(`name`) = 'кд життя mobile')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'КД Життя mobile', NULL, 'https://kd-life.com.ua', NULL, NULL, 'Застосунок страхової компанії «КД Життя»: поліси страхування життя, розрахунки й страхові випадки.', 'KD Life insurance app: life insurance policies, calculations and claims.', '«КД Життя mobile» — застосунок страхової компанії зі страхування життя «КД Життя» для клієнтів і фінансових консультантів. У ньому можна розрахувати страхову суму до виплати з урахуванням додаткового інвестиційного доходу, обрати страхові продукти, повідомити про страховий випадок, звʼязатися зі спеціалістами й знайти офіс на мапі.', 'KD Life mobile is the app of the KD Life life insurance company for customers and financial advisers. You can calculate the payout amount including additional investment income, choose insurance products, report a claim, contact specialists and find an office on the map.', 'Розрахунок страхової виплати
Вибір страхових продуктів
Повідомлення про страховий випадок
Офіси на мапі', 'Payout calculation
Insurance product selection
Claim reporting
Offices on a map', 'Клієнтам і консультантам зі страхування життя.', 'Life insurance customers and advisers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kd-life.com.ua' OR LOWER(`name`) = 'кд життя mobile') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-insurance' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'KD Life insurance app: life insurance policies, calculations and claims.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'KD Life mobile is the app of the KD Life life insurance company for customers and financial advisers. You can calculate the payout amount including additional investment income, choose insurance products, report a claim, contact specialists and find an office on the map.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Payout calculation
Insurance product selection
Claim reporting
Offices on a map', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Life insurance customers and advisers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Штрафи UA — Страхування, АЗС і водіям
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shtrafua.com' OR LOWER(`name`) = 'штрафи ua')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Штрафи UA', NULL, 'https://shtrafua.com', NULL, NULL, 'Перевірка й оплата штрафів ПДР, боргів у виконавчій службі та купівля електронної автоцивілки.', 'Check and pay traffic fines and enforcement debts, and buy electronic motor liability insurance.', 'Штрафи UA — застосунок для онлайн-перевірки та оплати штрафів ПДР і боргів у виконавчій службі, а також купівлі електронних полісів автоцивілки (ОСЦПВ). Розвиває онлайн-послуги для водіїв з 2016 року.', 'Shtrafy UA is an app for checking and paying traffic fines and enforcement debts online and for buying electronic motor third-party liability (OSCPV) policies. It has been developing online services for drivers since 2016.', 'Перевірка й оплата штрафів ПДР
Борги у виконавчій службі
Електронна автоцивілка', 'Check and pay traffic fines
Enforcement debts
Electronic motor liability insurance', 'Водіям і власникам авто.', 'Drivers and car owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'shtrafua.com' OR LOWER(`name`) = 'штрафи ua') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-insurance' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-auto' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Check and pay traffic fines and enforcement debts, and buy electronic motor liability insurance.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Shtrafy UA is an app for checking and paying traffic fines and enforcement debts online and for buying electronic motor third-party liability (OSCPV) policies. It has been developing online services for drivers since 2016.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Check and pay traffic fines
Enforcement debts
Electronic motor liability insurance', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Drivers and car owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- IZI Polis Агент — Страхування, Для бізнесу та ФОП
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6807850863' OR LOWER(`name`) = 'izi polis агент')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'IZI Polis Агент', NULL, 'https://apps.apple.com/ua/app/id6807850863', NULL, NULL, 'Застосунок для страхових агентів: розрахунок вартості, оформлення й контроль договорів зі смартфона.', 'App for insurance agents: price calculation, policy issuing and contract tracking from a phone.', 'IZI Polis Агент — мобільний застосунок для страхових агентів, який спрощує щоденну роботу зі страховими продуктами: від розрахунку вартості страхування до оформлення та контролю укладених договорів безпосередньо зі смартфона.', 'IZI Polis Agent is a mobile app for insurance agents that simplifies daily work with insurance products, from calculating the price of cover to issuing and tracking contracts directly from a smartphone.', 'Розрахунок вартості страхування
Оформлення договорів
Контроль укладених договорів', 'Insurance price calculation
Contract issuing
Contract tracking', 'Страховим агентам.', 'Insurance agents.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6807850863' OR LOWER(`name`) = 'izi polis агент') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-insurance' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-business' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'App for insurance agents: price calculation, policy issuing and contract tracking from a phone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'IZI Polis Agent is a mobile app for insurance agents that simplifies daily work with insurance products, from calculating the price of cover to issuing and tracking contracts directly from a smartphone.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Insurance price calculation
Contract issuing
Contract tracking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Insurance agents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Insurance Ukraine — Страхування, Транспорт і квитки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'insurance-ukraine.com' OR LOWER(`name`) = 'insurance ukraine')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Insurance Ukraine', NULL, 'https://insurance-ukraine.com', NULL, NULL, 'Обовʼязкове медичне страхування для в’їзду іноземців в Україну: поліс PDF приблизно за 5 хвилин.', 'Mandatory travel health insurance for foreigners entering Ukraine: PDF policy in about 5 minutes.', 'Insurance Ukraine — швидкий спосіб купити офіційне медичне страхування, обовʼязкове для в’їзду іноземців в Україну. Поліс із покриттям до €30 000 (включно з воєнними ризиками) відповідає вимогам МЗС і приймається на кордоні. Страховик — ліцензована компанія «Євроінс Україна». Поліс надходить на пошту приблизно за 5 хвилин і зберігається в застосунку офлайн.', 'Insurance Ukraine is a fast way to buy the official health insurance foreigners need to enter Ukraine. The policy covers up to €30,000 (war risks included), meets Ministry of Foreign Affairs requirements and is accepted at the border. It is underwritten by the licensed insurer Euroins Ukraine, emailed in about 5 minutes and stored in the app for offline use.', 'Поліс для вʼїзду в Україну
Покриття до €30 000
Воєнні ризики включено
PDF приблизно за 5 хвилин
Доступ офлайн', 'Policy for entering Ukraine
Cover up to €30,000
War risks included
PDF in about 5 minutes
Offline access', 'Іноземцям, які їдуть в Україну.', 'Foreigners travelling to Ukraine.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'insurance-ukraine.com' OR LOWER(`name`) = 'insurance ukraine') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-insurance' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-transport' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mandatory travel health insurance for foreigners entering Ukraine: PDF policy in about 5 minutes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Insurance Ukraine is a fast way to buy the official health insurance foreigners need to enter Ukraine. The policy covers up to €30,000 (war risks included), meets Ministry of Foreign Affairs requirements and is accepted at the border. It is underwritten by the licensed insurer Euroins Ukraine, emailed in about 5 minutes and stored in the app for offline use.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Policy for entering Ukraine
Cover up to €30,000
War risks included
PDF in about 5 minutes
Offline access', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Foreigners travelling to Ukraine.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- bird — Нерухомість, оренда та ЖК
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bird.rent' OR LOWER(`name`) = 'bird')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'bird', NULL, 'https://bird.rent', NULL, NULL, 'Пошук оренди житла на 3D-мапі: 70 000 оголошень із різних сайтів, спільний пошук і bird AI.', 'Rental search on a 3D map: 70,000 listings from many sites, shared search and bird AI.', 'bird — застосунок для пошуку квартир в оренду в Києві, Львові, Одесі, Харкові й Дніпрі (а також у Лондоні та Варшаві). Він збирає 70 000 оголошень із популярних сайтів на 3D-мапі, а bird AI розпізнає адреси й дублікати. Можна шукати разом із партнером і бачити квартири, звідки до роботи чи школи 20 хвилин.', 'bird is an app for finding rental apartments in Kyiv, Lviv, Odesa, Kharkiv and Dnipro (as well as London and Warsaw). It gathers 70,000 listings from popular sites on a 3D map, and bird AI recognises addresses and duplicates. You can search together with a partner and see flats within 20 minutes of work or school.', '3D-мапа будинків
70 000 оголошень з різних сайтів
bird AI: адреси й дублікати
Спільний пошук із партнером
Пошук за часом дороги', '3D building map
70,000 listings from many sites
bird AI: addresses and duplicates
Shared search with a partner
Search by commute time', 'Тим, хто шукає квартиру в оренду.', 'People looking for an apartment to rent.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bird.rent' OR LOWER(`name`) = 'bird') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Rental search on a 3D map: 70,000 listings from many sites, shared search and bird AI.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'bird is an app for finding rental apartments in Kyiv, Lviv, Odesa, Kharkiv and Dnipro (as well as London and Warsaw). It gathers 70,000 listings from popular sites on a 3D map, and bird AI recognises addresses and duplicates. You can search together with a partner and see flats within 20 minutes of work or school.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '3D building map
70,000 listings from many sites
bird AI: addresses and duplicates
Shared search with a partner
Search by commute time', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People looking for an apartment to rent.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- HataHub — Нерухомість, оренда та ЖК
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hatahub.com.ua' OR LOWER(`name`) = 'hatahub')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HataHub', NULL, 'https://www.hatahub.com.ua', NULL, NULL, 'Перевірена нерухомість без посередників: пошук на мапі, чат із власником і цифровий договір.', 'Verified real estate without middlemen: map search, chat with owners and digital contracts.', 'HataHub допомагає знаходити й публікувати перевірену нерухомість в Україні без посередників. Житло можна шукати на мапі, переглядати фото, спілкуватися з власниками напряму й пройти весь шлях від першого перегляду до цифрового договору в одному застосунку.', 'HataHub helps you find and list verified real estate in Ukraine without middlemen. Search on a map, view photos, talk to owners directly and go from the first viewing to a digital contract in one app.', 'Перевірені оголошення
Пошук на мапі
Чат із власником
Цифровий договір', 'Verified listings
Map search
Chat with owners
Digital contract', 'Орендарям, покупцям і власникам житла.', 'Tenants, buyers and property owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hatahub.com.ua' OR LOWER(`name`) = 'hatahub') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Verified real estate without middlemen: map search, chat with owners and digital contracts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'HataHub helps you find and list verified real estate in Ukraine without middlemen. Search on a map, view photos, talk to owners directly and go from the first viewing to a digital contract in one app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Verified listings
Map search
Chat with owners
Digital contract', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tenants, buyers and property owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Dexby — Нерухомість, оренда та ЖК
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dexby.app' OR LOWER(`name`) = 'dexby')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Dexby', NULL, 'https://dexby.app', NULL, NULL, 'Оренда й продаж нерухомості напряму від власників по всій Україні — без рієлторів і комісій.', 'Rent and buy property directly from owners across Ukraine — no realtors or commissions.', 'Dexby — платформа для оренди й продажу нерухомості без рієлторів. Квартири, будинки, кімнати й комерційну нерухомість можна знайти напряму від власників по всій Україні: без комісій, із прямим звʼязком і безкоштовним розміщенням оголошень.', 'Dexby is a platform for renting and selling property without realtors. Find apartments, houses, rooms and commercial property directly from owners across Ukraine, with no commissions, direct contact and free listings.', 'Пошук без комісій
Прямий звʼязок із власником
Безкоштовні оголошення
Квартири, будинки, кімнати, комерція', 'No-commission search
Direct contact with owners
Free listings
Flats, houses, rooms, commercial', 'Орендарям, покупцям і власникам житла.', 'Tenants, buyers and property owners.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dexby.app' OR LOWER(`name`) = 'dexby') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Rent and buy property directly from owners across Ukraine — no realtors or commissions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Dexby is a platform for renting and selling property without realtors. Find apartments, houses, rooms and commercial property directly from owners across Ukraine, with no commissions, direct contact and free listings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'No-commission search
Direct contact with owners
Free listings
Flats, houses, rooms, commercial', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Tenants, buyers and property owners.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Josti — Нерухомість, оренда та ЖК
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'josti.com.ua' OR LOWER(`name`) = 'josti')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Josti', NULL, 'https://josti.com.ua', NULL, NULL, 'Довгострокова оренда житла без комісії рієлтора: лише актуальні квартири й бронювання перегляду.', 'Long-term rentals with no realtor fee: only current listings and viewing booking.', 'Josti — застосунок для довгострокової оренди житла без комісії рієлтора. У ньому показано лише актуальні квартири, а перегляд можна забронювати прямо в застосунку.', 'Josti is an app for long-term home rentals with no realtor fee. It shows only current listings, and you can book a viewing right in the app.', 'Оренда без комісії
Актуальні квартири
Бронювання перегляду', 'No-fee rentals
Current listings only
Viewing booking', 'Тим, хто шукає житло в довгострокову оренду.', 'People looking for long-term rentals.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'josti.com.ua' OR LOWER(`name`) = 'josti') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Long-term rentals with no realtor fee: only current listings and viewing booking.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Josti is an app for long-term home rentals with no realtor fee. It shows only current listings, and you can book a viewing right in the app.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'No-fee rentals
Current listings only
Viewing booking', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People looking for long-term rentals.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Qvico — Нерухомість, оренда та ЖК
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6760317403' OR LOWER(`name`) = 'qvico')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Qvico', NULL, 'https://apps.apple.com/ua/app/id6760317403', NULL, NULL, 'Безпечна оренда з договором через Дія.Підпис, перевіркою сторін за держреєстрами й графіком платежів.', 'Safe renting with a Diia.Signature contract, registry checks of both sides and a payment schedule.', 'Qvico — застосунок для оренди житла з юридично чинним договором. Власник і орендар підтверджують особу через Дію, а договір та акт приймання-передачі підписують онлайн через Дія.Підпис. Орендаря можна перевірити за державними реєстрами, а обʼєкти з підтвердженим правом власності позначено окремо. Також є графік платежів, показники лічильників із фото та страхування квартири від ІНГО без огляду. Комісії рієлтору немає.', 'Qvico is an app for renting with a legally binding contract. Owner and tenant verify their identity via Diia and sign the contract and handover act online with Diia.Signature. Tenants can be checked against state registries, and listings with verified ownership are marked. There is also a payment schedule, meter readings with photos and apartment insurance from INGO without inspection, with no realtor fee.', 'Перевірка особи через Дію
Договір через Дія.Підпис
Перевірка орендаря за реєстрами
Графік платежів і лічильники
Страхування квартири', 'Identity check via Diia
Contract via Diia.Signature
Tenant registry checks
Payment schedule and meters
Apartment insurance', 'Власникам житла й орендарям.', 'Landlords and tenants.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6760317403' OR LOWER(`name`) = 'qvico') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Safe renting with a Diia.Signature contract, registry checks of both sides and a payment schedule.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Qvico is an app for renting with a legally binding contract. Owner and tenant verify their identity via Diia and sign the contract and handover act online with Diia.Signature. Tenants can be checked against state registries, and listings with verified ownership are marked. There is also a payment schedule, meter readings with photos and apartment insurance from INGO without inspection, with no realtor fee.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Identity check via Diia
Contract via Diia.Signature
Tenant registry checks
Payment schedule and meters
Apartment insurance', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Landlords and tenants.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Мій ЖК: Новобудови — Нерухомість, оренда та ЖК
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'novobudova.dp.ua' OR LOWER(`name`) = 'мій жк: новобудови')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Мій ЖК: Новобудови', NULL, 'https://novobudova.dp.ua', NULL, NULL, 'Каталог новобудов і кабінет покупця: квартира, документи, графік платежів та етапи будівництва.', 'New-build catalog and buyer portal: apartment, documents, payment schedule and construction stages.', '«Мій ЖК: Новобудови» — застосунок для покупців новобудов і забудовників. Каталог ЖК доступний без реєстрації: фото, опис, характеристики й контакти відділу продажів. Покупці отримують кабінет за запрошенням забудовника: квартира, документи за договором, графік платежів і етапи будівництва. Забудовники керують покупцями, договорами, новинами й зверненнями.', 'My Residential Complex: New Builds is an app for new-build buyers and developers. The catalog is open without registration, with photos, descriptions, specs and sales contacts. Buyers get a portal by developer invitation with their apartment, contract documents, payment schedule and construction stages. Developers manage buyers, contracts, news and requests.', 'Каталог ЖК без реєстрації
Кабінет покупця
Документи й графік платежів
Етапи будівництва
Кабінет забудовника', 'Catalog without registration
Buyer portal
Documents and payment schedule
Construction stages
Developer dashboard', 'Покупцям квартир у новобудовах і забудовникам.', 'New-build buyers and developers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'novobudova.dp.ua' OR LOWER(`name`) = 'мій жк: новобудови') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'New-build catalog and buyer portal: apartment, documents, payment schedule and construction stages.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'My Residential Complex: New Builds is an app for new-build buyers and developers. The catalog is open without registration, with photos, descriptions, specs and sales contacts. Buyers get a portal by developer invitation with their apartment, contract documents, payment schedule and construction stages. Developers manage buyers, contracts, news and requests.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Catalog without registration
Buyer portal
Documents and payment schedule
Construction stages
Developer dashboard', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'New-build buyers and developers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Home Rate — Нерухомість, оренда та ЖК
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'homerate.app' OR LOWER(`name`) = 'home rate')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Home Rate', NULL, 'https://homerate.app', NULL, NULL, 'Відгуки мешканців про будинки й ЖК на мапі — щоб знати, про що питати перед орендою чи купівлею.', 'Residents’ reviews of buildings and complexes on a map — know what to ask before renting or buying.', 'Home Rate допомагає дізнатися, як живеться в будинку, ще до переїзду. На мапі можна знайти адресу, почитати відгуки мешканців, переглянути оцінки й фото та обговорити деталі в коментарях. Сервіс тільки збирає перші відгуки, тож для деяких адрес їх ще немає.', 'Home Rate helps you learn what living in a building is like before you move. Find an address on the map, read residents’ reviews, check ratings and photos and discuss details in comments. The service is still collecting its first reviews, so some addresses have none yet.', 'Відгуки мешканців
Оцінки й фото будинків
Коментарі та обговорення
Пошук на мапі', 'Residents’ reviews
Building ratings and photos
Comments and discussion
Map search', 'Тим, хто обирає житло для оренди чи купівлі.', 'People choosing a home to rent or buy.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'homerate.app' OR LOWER(`name`) = 'home rate') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Residents’ reviews of buildings and complexes on a map — know what to ask before renting or buying.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Home Rate helps you learn what living in a building is like before you move. Find an address on the map, read residents’ reviews, check ratings and photos and discuss details in comments. The service is still collecting its first reviews, so some addresses have none yet.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Residents’ reviews
Building ratings and photos
Comments and discussion
Map search', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'People choosing a home to rent or buy.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Реєстр нерухомості — Нерухомість, оренда та ЖК
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'drrp.app' OR LOWER(`name`) = 'реєстр нерухомості')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Реєстр нерухомості', NULL, 'https://drrp.app', NULL, NULL, 'Пошук у Державному реєстрі речових прав на нерухоме майно за особою чи обʼєктом і моніторинг змін.', 'Search the State Register of Real Property Rights by person or property and monitor changes.', '«Реєстр нерухомості» дає доступ до інформації з Державного реєстру речових прав на нерухоме майно. Шукати можна за ПІБ чи кодом фізичної особи, назвою чи кодом ЄДРПОУ юридичної особи або за обʼєктом нерухомості (зокрема за кадастровим номером). Можна стежити за появою нової нерухомості в осіб і змінами в обʼєктах.', 'Real Estate Register gives access to the State Register of Real Property Rights. You can search by an individual’s name or tax code, a company’s name or EDRPOU code, or by property (including cadastral number), and monitor new property and changes to objects.', 'Пошук за особою чи компанією
Пошук за обʼєктом
Моніторинг змін
Дані держреєстру', 'Search by person or company
Search by property
Change monitoring
State register data', 'Покупцям нерухомості, юристам і рієлторам.', 'Property buyers, lawyers and realtors.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'drrp.app' OR LOWER(`name`) = 'реєстр нерухомості') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Search the State Register of Real Property Rights by person or property and monitor changes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Real Estate Register gives access to the State Register of Real Property Rights. You can search by an individual’s name or tax code, a company’s name or EDRPOU code, or by property (including cadastral number), and monitor new property and changes to objects.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Search by person or company
Search by property
Change monitoring
State register data', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Property buyers, lawyers and realtors.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- База — для рієлторів — Нерухомість, оренда та ЖК, Для бізнесу та ФОП
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'baza.ua' OR LOWER(`name`) = 'база — для рієлторів')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'База — для рієлторів', NULL, 'https://baza.ua', NULL, NULL, 'Застосунок для рієлторів: обʼєкти від власників і колег, фільтр-канали та сповіщення про нові обʼєкти.', 'App for realtors: listings from owners and colleagues, filter channels and new-listing alerts.', '«База» — застосунок для рієлторів, де зібрано обʼєкти від власників і рієлторів. Можна переглядати нові обʼєкти, транслювати свої ексклюзиви й стежити за ексклюзивами колег, створювати фільтр-канали й отримувати сповіщення про нові обʼєкти за обраними параметрами.', 'Baza is an app for realtors that gathers listings from owners and other agents. You can browse new listings, share your exclusives and follow colleagues’ exclusives, create filter channels and get alerts about new listings matching your criteria.', 'Обʼєкти від власників і рієлторів
Ексклюзиви колег
Фільтр-канали
Сповіщення про нові обʼєкти', 'Listings from owners and agents
Colleagues’ exclusives
Filter channels
New-listing alerts', 'Рієлторам і агентствам нерухомості.', 'Realtors and real estate agencies.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'baza.ua' OR LOWER(`name`) = 'база — для рієлторів') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-business' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'App for realtors: listings from owners and colleagues, filter channels and new-listing alerts.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Baza is an app for realtors that gathers listings from owners and other agents. You can browse new listings, share your exclusives and follow colleagues’ exclusives, create filter channels and get alerts about new listings matching your criteria.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Listings from owners and agents
Colleagues’ exclusives
Filter channels
New-listing alerts', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Realtors and real estate agencies.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Вдома — Нерухомість, оренда та ЖК, Платежі та комуналка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vdo.ma' OR LOWER(`name`) = 'вдома')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Вдома', NULL, 'https://vdo.ma', NULL, NULL, 'Застосунок для мешканців ЖК і ОСББ: заявки на ремонт, рахунки, голосування через Дія.Підпис і камери.', 'App for residents of housing complexes and HOAs: repair requests, bills, Diia votes and cameras.', '«Вдома» — цифровий помічник для мешканців багатоквартирних будинків. Тут можна створювати заявки на ремонт і стежити за ними, переглядати квитанції, борги й переплати, отримувати новини від ОСББ чи керуючої компанії, голосувати онлайн через Дія.Підпис, зберігати документи будинку, додавати орендарів і дивитися відеоспостереження.', 'Vdoma is a digital assistant for apartment building residents. You can create and track repair requests, view bills, debts and overpayments, get news from your HOA or management company, vote online via Diia.Signature, store building documents, add tenants and view CCTV.', 'Заявки на ремонт
Квитанції та борги
Голосування через Дія.Підпис
Документи будинку
Відеоспостереження', 'Repair requests
Bills and debts
Voting via Diia.Signature
Building documents
CCTV access', 'Мешканцям ЖК, ОСББ і керуючим компаніям.', 'Residents, HOAs and property managers.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'vdo.ma' OR LOWER(`name`) = 'вдома') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-payments' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'App for residents of housing complexes and HOAs: repair requests, bills, Diia votes and cameras.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Vdoma is a digital assistant for apartment building residents. You can create and track repair requests, view bills, debts and overpayments, get news from your HOA or management company, vote online via Diia.Signature, store building documents, add tenants and view CCTV.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Repair requests
Bills and debts
Voting via Diia.Signature
Building documents
CCTV access', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Residents, HOAs and property managers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- My IGB — Нерухомість, оренда та ЖК
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'intergal-bud.com.ua' OR LOWER(`name`) = 'my igb')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'My IGB', NULL, 'https://intergal-bud.com.ua', NULL, NULL, 'Застосунок для мешканців будинків «Інтергал-Буд»: заявки в керуючу компанію та цифрові сервіси ЖК.', 'App for Intergal-Bud residents: management company requests and digital housing services.', 'MY IGB обʼєднує цифрові сервіси для мешканців будинків «Інтергал-Буд» в одному застосунку: заявки до керуючої компанії, новини, рахунки та інші сервіси житлового комплексу.', 'MY IGB brings Intergal-Bud residents’ digital services together in one app: requests to the management company, news, bills and other housing complex services.', 'Заявки в керуючу компанію
Новини ЖК
Сервіси для мешканців', 'Management company requests
Complex news
Resident services', 'Мешканцям будинків «Інтергал-Буд».', 'Intergal-Bud residents.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'intergal-bud.com.ua' OR LOWER(`name`) = 'my igb') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'App for Intergal-Bud residents: management company requests and digital housing services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'MY IGB brings Intergal-Bud residents’ digital services together in one app: requests to the management company, news, bills and other housing complex services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Management company requests
Complex news
Resident services', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Intergal-Bud residents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TRIIINITY — Нерухомість, оренда та ЖК
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1601529013' OR LOWER(`name`) = 'triiinity')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TRIIINITY', NULL, 'https://apps.apple.com/ua/app/id1601529013', NULL, NULL, 'Застосунок мешканців ЖК TRIIINITY: спілкування, контакти та онлайн-трансляція будівництва.', 'App for TRIIINITY residents: communication, contacts and live construction view.', 'Застосунок для мешканців житлового комплексу TRIIINITY: зручне спілкування, пошук потрібних контактів і спостереження за будівництвом у режимі онлайн.', 'An app for residents of the TRIIINITY residential complex: easy communication, useful contacts and a live view of construction.', 'Спілкування мешканців
Контакти служб
Онлайн-трансляція будівництва', 'Resident communication
Service contacts
Live construction view', 'Мешканцям ЖК TRIIINITY.', 'TRIIINITY residents.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1601529013' OR LOWER(`name`) = 'triiinity') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'App for TRIIINITY residents: communication, contacts and live construction view.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'An app for residents of the TRIIINITY residential complex: easy communication, useful contacts and a live view of construction.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Resident communication
Service contacts
Live construction view', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'TRIIINITY residents.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Моє містечко (Svitlo Development) — Нерухомість, оренда та ЖК
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6744968292' OR LOWER(`name`) = 'моє містечко (svitlo development)')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Моє містечко (Svitlo Development)', NULL, 'https://apps.apple.com/ua/app/id6744968292', NULL, NULL, 'Застосунок для мешканців котеджних містечок Svitlo Development: спільнота, новини й сервіси.', 'App for residents of Svitlo Development cottage towns: community, news and services.', '«Моє містечко» — застосунок для мешканців котеджних містечок від Svitlo Development. Він допомагає підтримувати звʼязок між сусідами, отримувати новини та користуватися сервісами містечка в одному місці.', 'My Town is an app for residents of Svitlo Development cottage towns. It helps neighbours stay connected, get news and use the town’s services in one place.', 'Спільнота мешканців
Новини містечка
Сервіси для мешканців', 'Resident community
Town news
Resident services', 'Мешканцям котеджних містечок Svitlo Development.', 'Residents of Svitlo Development towns.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id6744968292' OR LOWER(`name`) = 'моє містечко (svitlo development)') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'App for residents of Svitlo Development cottage towns: community, news and services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'My Town is an app for residents of Svitlo Development cottage towns. It helps neighbours stay connected, get news and use the town’s services in one place.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Resident community
Town news
Resident services', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Residents of Svitlo Development towns.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Дах — Нерухомість, оренда та ЖК, Платежі та комуналка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dah-online.com' OR LOWER(`name`) = 'дах')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Дах', NULL, 'https://dah-online.com', NULL, NULL, 'Керування ОСББ: новини, опитування й голосування, автоматичні нарахування та звʼязок із правлінням.', 'HOA management: news, polls and voting, automatic charges and contact with the board.', '«Дах» — інструмент комунікації та управління обʼєднанням співвласників. Мешканці отримують новини, беруть участь в опитуваннях, голосуваннях і обговореннях, а правління веде автоматичні нарахування внесків і спілкується з власниками онлайн.', 'Dakh is a communication and management tool for homeowners’ associations. Residents get news and take part in polls, votes and discussions, while the board runs automatic charges and talks to owners online.', 'Новини для мешканців
Опитування й голосування
Автоматичні нарахування
Звʼязок із правлінням', 'Resident news
Polls and voting
Automatic charges
Contact with the board', 'Мешканцям і правлінням ОСББ.', 'HOA residents and boards.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'dah-online.com' OR LOWER(`name`) = 'дах') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-payments' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'HOA management: news, polls and voting, automatic charges and contact with the board.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Dakh is a communication and management tool for homeowners’ associations. Residents get news and take part in polls, votes and discussions, while the board runs automatic charges and talks to owners online.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Resident news
Polls and voting
Automatic charges
Contact with the board', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'HOA residents and boards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Моє ОСББ — Нерухомість, оренда та ЖК, Платежі та комуналка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moeosbb.com' OR LOWER(`name`) = 'моє осбб')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Моє ОСББ', NULL, 'https://moeosbb.com', NULL, NULL, 'Кабінет мешканця ОСББ: борг чи переплата, нарахування за послугами, історія та оплата комуналки.', 'HOA resident portal: debt or overpayment, service charges, history and utility payments.', '«Моє ОСББ» — кабінет мешканця будинку, чиє обʼєднання співвласників підключене до сервісу. Одразу видно стан розрахунків по квартирі (борг чи переплату), нарахування за послугами та історію оплат; комунальні послуги можна оплатити карткою.', 'Moie OSBB is a resident portal for buildings whose homeowners’ association uses the service. It shows the apartment’s balance (debt or overpayment), service charges and payment history, and lets you pay utilities by card.', 'Стан розрахунків по квартирі
Нарахування за послугами
Історія оплат
Оплата карткою', 'Apartment balance
Service charges
Payment history
Card payments', 'Мешканцям будинків з ОСББ.', 'Residents of HOA buildings.', 'web,mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'moeosbb.com' OR LOWER(`name`) = 'моє осбб') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-payments' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'HOA resident portal: debt or overpayment, service charges, history and utility payments.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Moie OSBB is a resident portal for buildings whose homeowners’ association uses the service. It shows the apartment’s balance (debt or overpayment), service charges and payment history, and lets you pay utilities by card.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Apartment balance
Service charges
Payment history
Card payments', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Residents of HOA buildings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- proOSBB — Вінниця — Нерухомість, оренда та ЖК, Міські застосунки
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1385502270' OR LOWER(`name`) = 'proosbb — вінниця')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'proOSBB — Вінниця', NULL, 'https://apps.apple.com/ua/app/id1385502270', NULL, NULL, 'Застосунок для мешканців будинків Вінниці: тарифи, оплата рахунків і звʼязок з ОСББ.', 'App for Vinnytsia residents: tariffs, bill payments and contact with the HOA.', 'proOSBB допомагає мешканцям житлових будинків Вінниці контролювати якість послуг ОСББ, отримувати актуальну інформацію про тарифи на житлово-комунальні послуги, швидше оплачувати рахунки й підтримувати звʼязок між сусідами.', 'proOSBB helps residents of apartment buildings in Vinnytsia monitor the quality of HOA services, get current information on housing and utility tariffs, pay bills faster and stay in touch with neighbours.', 'Контроль послуг ОСББ
Тарифи на комуналку
Оплата рахунків
Звʼязок між мешканцями', 'HOA service monitoring
Utility tariffs
Bill payments
Resident communication', 'Мешканцям багатоквартирних будинків Вінниці.', 'Apartment residents in Vinnytsia.', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-18 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apps.apple.com/ua/app/id1385502270' OR LOWER(`name`) = 'proosbb — вінниця') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-city' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'App for Vinnytsia residents: tariffs, bill payments and contact with the HOA.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'proOSBB helps residents of apartment buildings in Vinnytsia monitor the quality of HOA services, get current information on housing and utility tariffs, pay bills faster and stay in touch with neighbours.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'HOA service monitoring
Utility tariffs
Bill payments
Resident communication', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Apartment residents in Vinnytsia.', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовний застосунок.', 'Free app.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free app.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Прив'язка наявних продуктів (за назвою) до нових підкатегорій; тексти не змінюються

-- ЛУН — Нерухомість, оренда та ЖК
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'лун' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- DIM.RIA — Нерухомість, оренда та ЖК
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'dim.ria' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Rieltor.ua — Нерухомість, оренда та ЖК
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'rieltor.ua' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Flatfy — Нерухомість, оренда та ЖК
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'flatfy' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- OLX Нерухомість — Нерухомість, оренда та ЖК
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'olx нерухомість' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Мій ЖК — Нерухомість, оренда та ЖК
SET @pid = (SELECT `id` FROM `products` WHERE LOWER(`name`) = 'мій жк' ORDER BY `id` LIMIT 1);
SET @sub = (SELECT `id` FROM `subcategories` WHERE `category_id` = @cat AND `slug` = 'ua-realty' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

-- Інтенти запасного пошуку Елі (tools/eli-intents.php, нові підкатегорії ukrainian-apps)
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'страховк', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'страховк' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'страх', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'страх' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'автоцивілк', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'автоцивілк' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'осцпв', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'осцпв' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'зелена карт', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'зелена карт' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'insuranc', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'insuranc' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'нерухоміс', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'нерухоміс' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'оренда квартир', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'оренда квартир' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'зняти квартир', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'зняти квартир' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'оренда жит', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'оренда жит' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'купити квартир', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'купити квартир' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'новобудов', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'новобудов' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'житловий комплекс', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'житловий комплекс' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'забудовник', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'забудовник' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'ріелтор', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'ріелтор' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'рієлтор', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'рієлтор' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'осбб', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'осбб' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'real estate', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'real estate' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'flat rent', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'flat rent' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'apartment rent', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'apartment rent' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-realty' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'страхова компан', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'страхова компан' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'медичне страх', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'медичне страх' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'страхування житт', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'страхування житт' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1));
INSERT INTO search_intents (term_stem, category_id, subcategory_id, weight) SELECT 'поліс', (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1), (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1), 1 FROM DUAL WHERE (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) IS NOT NULL AND (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1) IS NOT NULL AND NOT EXISTS (SELECT 1 FROM search_intents si WHERE si.term_stem = 'поліс' AND si.category_id <=> (SELECT id FROM categories WHERE slug = 'ukrainian-apps' LIMIT 1) AND si.subcategory_id <=> (SELECT s.id FROM subcategories s JOIN categories c ON c.id = s.category_id WHERE c.slug = 'ukrainian-apps' AND s.slug = 'ua-insurance' LIMIT 1));
