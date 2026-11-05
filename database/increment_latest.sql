SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-05: «Розробка та IT» → «Тестування» і «Кібербезпека» → «Безпека коду та застосунків»; SDK захисту також у «Мобільна розробка», тренажери — у «Тренажери для тестувальників».
-- Партія 10: 18 нових продуктів — тестування безпеки мобільних застосунків (для статті про тестування безпеки мобільних застосунків).
-- Тексти UA/EN написано за офіційними сторінками, звірено 2026-11-05. Якщо продукт з такою адресою чи назвою вже є — лише прив’язка.
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою. Повторний запуск безпечний.
--   OWASP MAS  (+ тренажери)
--   objection
--   jadx
--   Apktool
--   Ghidra
--   drozer
--   APKLeaks
--   reFlutter
--   Magisk
--   Oversecured
--   NowSecure
--   Appknox
--   Ostorlab
--   Corellium
--   freeRASP
--   Approov
--   AndroGoat  (+ тренажери)
--   DVIA-v2  (+ тренажери)
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'development-it' LIMIT 1);

-- OWASP MAS — Тестування, Безпека коду та застосунків, Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mas.owasp.org' OR LOWER(`name`) = 'owasp mas')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OWASP MAS', NULL, 'https://mas.owasp.org', NULL, NULL, 'Відкритий проєкт OWASP з безпеки мобільних застосунків: стандарт MASVS, посібник з тестування MASTG, перелік слабких місць MASWE і чек-лист.', 'OWASP Mobile Application Security project: the MASVS standard, the MASTG testing guide, the MASWE weakness list and a checklist.', 'OWASP MAS — головне безкоштовне джерело знань про тестування безпеки мобільних застосунків. MASVS описує вимоги до безпеки у восьми групах: зберігання даних, криптографія, автентифікація, мережа, взаємодія з платформою, код, стійкість до зламу й приватність. MASTG пояснює, як перевірити кожну вимогу на Android та iOS, з тестами, демо й рекомендаціями, а MASWE перелічує типові слабкі місця. Є також чек-лист і навчальні завдання MAS Crackmes для практики реверс-інжинірингу.', 'OWASP MAS is the main free knowledge base for mobile app security testing. MASVS defines security requirements in eight groups: storage, cryptography, authentication, network, platform interaction, code, resilience and privacy. MASTG explains how to test each requirement on Android and iOS with tests, demos and best practices, and MASWE lists common weaknesses. There is also a checklist and MAS Crackmes challenges for reverse engineering practice.', 'Стандарт MASVS: 8 груп вимог
Посібник MASTG для Android та iOS
Перелік слабких місць MASWE
Чек-лист і завдання MAS Crackmes', 'MASVS standard: 8 control groups
MASTG testing guide for Android and iOS
MASWE weakness enumeration
Checklist and MAS Crackmes challenges', 'QA-інженери, пентестери й мобільні розробники, що перевіряють захищеність застосунків Android та iOS', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-05 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'mas.owasp.org' OR LOWER(`name`) = 'owasp mas') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'OWASP Mobile Application Security project: the MASVS standard, the MASTG testing guide, the MASWE weakness list and a checklist.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'OWASP MAS is the main free knowledge base for mobile app security testing. MASVS defines security requirements in eight groups: storage, cryptography, authentication, network, platform interaction, code, resilience and privacy. MASTG explains how to test each requirement on Android and iOS with tests, demos and best practices, and MASWE lists common weaknesses. There is also a checklist and MAS Crackmes challenges for reverse engineering practice.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'MASVS standard: 8 control groups
MASTG testing guide for Android and iOS
MASWE weakness enumeration
Checklist and MAS Crackmes challenges', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- objection — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/sensepost/objection' OR LOWER(`name`) = 'objection')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'objection', NULL, 'https://github.com/sensepost/objection', NULL, NULL, 'Відкритий набір інструментів на основі Frida для дослідження мобільних застосунків під час роботи: SSL pinning, файли, keychain, пам’ять.', 'Open-source Frida-powered runtime mobile exploration toolkit: SSL pinning, file system, keychain and memory.', 'objection від SensePost дозволяє дослідити застосунок Android чи iOS «зсередини» простими командами, без написання скриптів Frida. Можна переглядати файли в контейнері застосунку, обходити SSL pinning, вивантажувати вміст keychain, читати й змінювати пам’ять, досліджувати об’єкти й методи. Працює і без root чи jailbreak — через впакування агента Frida в застосунок. Ліцензія GPL-3.0.', 'SensePost objection lets you explore an Android or iOS app from the inside with simple commands, without writing Frida scripts. You can browse the app container file system, bypass SSL pinning, dump the keychain, dump and patch memory, and explore objects and methods. It also works without root or jailbreak by patching the Frida gadget into the app. GPL-3.0 license.', 'Обхід SSL pinning
Перегляд файлової системи застосунку
Вивантаження keychain і пам’яті
Без root чи jailbreak', 'SSL pinning bypass
App container file system browsing
Keychain and memory dumps
No root or jailbreak needed', 'QA-інженери, пентестери й мобільні розробники, що перевіряють захищеність застосунків Android та iOS', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-05 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/sensepost/objection' OR LOWER(`name`) = 'objection') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source Frida-powered runtime mobile exploration toolkit: SSL pinning, file system, keychain and memory.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SensePost objection lets you explore an Android or iOS app from the inside with simple commands, without writing Frida scripts. You can browse the app container file system, bypass SSL pinning, dump the keychain, dump and patch memory, and explore objects and methods. It also works without root or jailbreak by patching the Frida gadget into the app. GPL-3.0 license.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'SSL pinning bypass
App container file system browsing
Keychain and memory dumps
No root or jailbreak needed', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- jadx — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/skylot/jadx' OR LOWER(`name`) = 'jadx')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'jadx', NULL, 'https://github.com/skylot/jadx', NULL, NULL, 'Відкритий декомпілятор Android: перетворює APK, AAB і DEX на читабельний Java-код, має графічний інтерфейс із пошуком.', 'Open-source Android decompiler: turns APK, AAB and DEX into readable Java code, with a searchable GUI.', 'jadx декомпілює байт-код Dalvik із файлів APK, DEX, AAB, APKS, XAPK, а також JAR, AAR і smali у вихідний код Java і декодує AndroidManifest.xml та ресурси. У графічній версії jadx-gui є підсвітка синтаксису, перехід до оголошень, пошук використань і повнотекстовий пошук — зручно, щоб знайти в застосунку ключі API, адреси серверів чи логіку перевірок. Є й версія для командного рядка. Ліцензія Apache 2.0.', 'jadx decompiles Dalvik bytecode from APK, DEX, AAB, APKS and XAPK files, as well as JAR, AAR and smali, into Java source and decodes AndroidManifest.xml and resources. The jadx-gui version offers syntax highlighting, go to declaration, find usages and full-text search, handy for spotting API keys, server URLs or check logic in an app. A command-line version is also available. Apache 2.0 license.', 'APK, AAB, DEX, JAR, AAR → Java
Декодування маніфесту й ресурсів
GUI з пошуком і переходами
Налагоджувач smali', 'APK, AAB, DEX, JAR, AAR → Java
Manifest and resource decoding
GUI with search and navigation
smali debugger', 'QA-інженери, пентестери й мобільні розробники, що перевіряють захищеність застосунків Android та iOS', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-05 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/skylot/jadx' OR LOWER(`name`) = 'jadx') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source Android decompiler: turns APK, AAB and DEX into readable Java code, with a searchable GUI.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'jadx decompiles Dalvik bytecode from APK, DEX, AAB, APKS and XAPK files, as well as JAR, AAR and smali, into Java source and decodes AndroidManifest.xml and resources. The jadx-gui version offers syntax highlighting, go to declaration, find usages and full-text search, handy for spotting API keys, server URLs or check logic in an app. A command-line version is also available. Apache 2.0 license.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'APK, AAB, DEX, JAR, AAR → Java
Manifest and resource decoding
GUI with search and navigation
smali debugger', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Apktool — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apktool.org' OR LOWER(`name`) = 'apktool')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Apktool', NULL, 'https://apktool.org', NULL, NULL, 'Відкритий інструмент для розпакування й повторного збирання Android-застосунків: ресурси, маніфест і код smali.', 'Open-source tool for disassembling and rebuilding Android apps: resources, manifest and smali code.', 'Apktool розбирає APK майже до початкового вигляду: декодує ресурси й AndroidManifest.xml і перетворює код на smali. Після змін застосунок можна зібрати назад — так тестувальники безпеки перевіряють, чи помічає застосунок модифікацію, вмикають налагодження чи додають власну конфігурацію мережі для перехоплення трафіку. Режим аналізу витягує ресурси й маніфест без наміру збирати.', 'Apktool disassembles an APK almost to its original form: it decodes resources and AndroidManifest.xml and turns code into smali. After changes, the app can be rebuilt, which is how security testers check whether an app detects tampering, enable debugging or add their own network config for traffic interception. Analysis mode extracts resources and the manifest without rebuilding.', 'Декодування ресурсів і маніфесту
Код у форматі smali
Повторне збирання після змін
Режим аналізу без збирання', 'Resource and manifest decoding
Code as smali
Rebuilding after changes
Analysis mode without rebuild', 'QA-інженери, пентестери й мобільні розробники, що перевіряють захищеність застосунків Android та iOS', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-05 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'apktool.org' OR LOWER(`name`) = 'apktool') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source tool for disassembling and rebuilding Android apps: resources, manifest and smali code.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Apktool disassembles an APK almost to its original form: it decodes resources and AndroidManifest.xml and turns code into smali. After changes, the app can be rebuilt, which is how security testers check whether an app detects tampering, enable debugging or add their own network config for traffic interception. Analysis mode extracts resources and the manifest without rebuilding.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Resource and manifest decoding
Code as smali
Rebuilding after changes
Analysis mode without rebuild', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ghidra — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ghidra-sre.org' OR LOWER(`name`) = 'ghidra')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ghidra', NULL, 'https://ghidra-sre.org', NULL, NULL, 'Безкоштовний відкритий набір для реверс-інжинірингу від NSA: дизасемблер і декомпілятор для нативних бібліотек і бінарних файлів.', 'Free open-source reverse engineering suite from the NSA: disassembler and decompiler for native libraries and binaries.', 'Ghidra аналізує скомпільований код: дизасемблює, декомпілює в псевдокод C, будує графи викликів і підтримує скрипти на Java та Python. У мобільному тестуванні безпеки нею досліджують нативні бібліотеки .so в Android-застосунках і бінарні файли iOS, куди розробники часто ховають перевірки, ключі чи криптографію. Працює на Windows, macOS і Linux, ліцензія Apache 2.0.', 'Ghidra analyzes compiled code: it disassembles, decompiles to C-like pseudocode, builds call graphs and supports Java and Python scripts. In mobile security testing it is used to study native .so libraries in Android apps and iOS binaries, where developers often hide checks, keys or crypto. Runs on Windows, macOS and Linux, Apache 2.0 license.', 'Дизасемблер і декомпілятор
Багато архітектур процесорів
Скрипти на Java і Python
Windows, macOS, Linux', 'Disassembler and decompiler
Many processor architectures
Java and Python scripting
Windows, macOS, Linux', 'QA-інженери, пентестери й мобільні розробники, що перевіряють захищеність застосунків Android та iOS', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-05 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ghidra-sre.org' OR LOWER(`name`) = 'ghidra') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free open-source reverse engineering suite from the NSA: disassembler and decompiler for native libraries and binaries.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ghidra analyzes compiled code: it disassembles, decompiles to C-like pseudocode, builds call graphs and supports Java and Python scripts. In mobile security testing it is used to study native .so libraries in Android apps and iOS binaries, where developers often hide checks, keys or crypto. Runs on Windows, macOS and Linux, Apache 2.0 license.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Disassembler and decompiler
Many processor architectures
Java and Python scripting
Windows, macOS, Linux', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- drozer — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/withsecurelabs/drozer' OR LOWER(`name`) = 'drozer')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'drozer', NULL, 'https://github.com/WithSecureLabs/drozer', NULL, NULL, 'Відкритий фреймворк тестування безпеки Android: перевіряє експортовані компоненти, content providers і міжпроцесну взаємодію.', 'Open-source Android security testing framework: checks exported components, content providers and IPC.', 'drozer від WithSecure діє як окремий застосунок на пристрої й взаємодіє з іншими застосунками так, як це зробив би шкідливий: знаходить експортовані activities, services, broadcast receivers і content providers, перевіряє їх на витік даних, SQL-ін’єкції й обхід дозволів. Агент на пристрої підключається до консолі на комп’ютері через мережу чи USB. Версія 3 переписана для Python 3, ліцензія BSD.', 'WithSecure drozer acts as a separate app on the device and interacts with other apps the way a malicious one would: it finds exported activities, services, broadcast receivers and content providers and checks them for data leaks, SQL injection and permission bypasses. The on-device agent connects to a console on your computer over the network or USB. Version 3 is rewritten for Python 3, BSD license.', 'Пошук експортованих компонентів
Перевірка content providers
Модулі й власні скрипти
Підключення через мережу чи USB', 'Exported component discovery
Content provider testing
Modules and custom scripts
Network or USB connection', 'QA-інженери, пентестери й мобільні розробники, що перевіряють захищеність застосунків Android та iOS', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-05 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/withsecurelabs/drozer' OR LOWER(`name`) = 'drozer') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source Android security testing framework: checks exported components, content providers and IPC.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'WithSecure drozer acts as a separate app on the device and interacts with other apps the way a malicious one would: it finds exported activities, services, broadcast receivers and content providers and checks them for data leaks, SQL injection and permission bypasses. The on-device agent connects to a console on your computer over the network or USB. Version 3 is rewritten for Python 3, BSD license.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Exported component discovery
Content provider testing
Modules and custom scripts
Network or USB connection', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- APKLeaks — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/dwisiswant0/apkleaks' OR LOWER(`name`) = 'apkleaks')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'APKLeaks', NULL, 'https://github.com/dwisiswant0/apkleaks', NULL, NULL, 'Відкрита утиліта, що шукає в APK адреси, ендпоінти API й секрети (ключі, токени) за регулярними виразами.', 'Open-source utility that scans APKs for URLs, API endpoints and secrets (keys, tokens) using regex patterns.', 'APKLeaks декомпілює APK за допомогою jadx і проганяє код через набір регулярних виразів, щоб знайти адреси серверів, ендпоінти API, ключі хмарних сервісів і токени, прописані в застосунку. Можна додати власні шаблони, а результат зберегти в текстовому файлі чи JSON. Встановлюється через pip або Docker, ліцензія Apache 2.0.', 'APKLeaks decompiles an APK with jadx and runs the code through a set of regex patterns to find server URLs, API endpoints, cloud service keys and tokens hardcoded in the app. You can add custom patterns and save results as text or JSON. Installs via pip or Docker, Apache 2.0 license.', 'Пошук URL, ендпоінтів і секретів
Власні шаблони пошуку
Звіт у тексті чи JSON
pip або Docker', 'Finds URLs, endpoints and secrets
Custom search patterns
Text or JSON report
pip or Docker', 'QA-інженери, пентестери й мобільні розробники, що перевіряють захищеність застосунків Android та iOS', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-05 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/dwisiswant0/apkleaks' OR LOWER(`name`) = 'apkleaks') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source utility that scans APKs for URLs, API endpoints and secrets (keys, tokens) using regex patterns.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'APKLeaks decompiles an APK with jadx and runs the code through a set of regex patterns to find server URLs, API endpoints, cloud service keys and tokens hardcoded in the app. You can add custom patterns and save results as text or JSON. Installs via pip or Docker, Apache 2.0 license.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Finds URLs, endpoints and secrets
Custom search patterns
Text or JSON report
pip or Docker', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- reFlutter — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/impact-i/reflutter' OR LOWER(`name`) = 'reflutter')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'reFlutter', NULL, 'https://github.com/Impact-I/reFlutter', NULL, NULL, 'Відкритий фреймворк для дослідження застосунків на Flutter: перехоплення трафіку попри pinning і дамп функцій Dart.', 'Open-source framework for reverse engineering Flutter apps: traffic interception despite pinning and Dart function dumps.', 'Застосунки на Flutter не використовують системні налаштування проксі й сертифікатів, тому звичайні методи перехоплення трафіку на них не працюють. reFlutter замінює рушій Flutter у застосунку на пропатчений, щоб трафік було видно в Burp Suite чи іншому проксі, і вивантажує список функцій Dart з адресами для Frida, IDA чи Ghidra. Підтримує Android та iOS, ліцензія GPL-3.0.', 'Flutter apps ignore system proxy and certificate settings, so the usual traffic interception methods do not work. reFlutter swaps the app’s Flutter engine for a patched one so traffic shows up in Burp Suite or another proxy, and dumps Dart functions with offsets for Frida, IDA or Ghidra. Supports Android and iOS, GPL-3.0 license.', 'Перехоплення трафіку Flutter
Обхід перевірки сертифіката
Дамп функцій Dart
Android та iOS', 'Flutter traffic interception
Certificate check bypass
Dart function dump
Android and iOS', 'QA-інженери, пентестери й мобільні розробники, що перевіряють захищеність застосунків Android та iOS', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-05 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/impact-i/reflutter' OR LOWER(`name`) = 'reflutter') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source framework for reverse engineering Flutter apps: traffic interception despite pinning and Dart function dumps.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Flutter apps ignore system proxy and certificate settings, so the usual traffic interception methods do not work. reFlutter swaps the app’s Flutter engine for a patched one so traffic shows up in Burp Suite or another proxy, and dumps Dart functions with offsets for Frida, IDA or Ghidra. Supports Android and iOS, GPL-3.0 license.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Flutter traffic interception
Certificate check bypass
Dart function dump
Android and iOS', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Magisk — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/topjohnwu/magisk' OR LOWER(`name`) = 'magisk')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Magisk', NULL, 'https://github.com/topjohnwu/Magisk', NULL, NULL, 'Відкритий набір для отримання root-доступу й модифікації Android без зміни системного розділу — для тестових пристроїв.', 'Open-source suite for root access and Android customization without touching the system partition, for test devices.', 'Magisk дає root-доступ (MagiskSU), дозволяє ставити модулі, що змінюють систему, і запускати код у процесах застосунків через Zygisk. Тестувальники безпеки встановлюють його на окремий тестовий телефон, щоб читати приватні файли застосунку, ставити системні сертифікати для перехоплення трафіку й перевіряти, як застосунок виявляє root. Підтримує Android 7.0 і новіші, ліцензія GPL-3.0. Завантажувати лише з GitHub проєкту.', 'Magisk provides root access (MagiskSU), installs modules that modify the system and runs code inside app processes via Zygisk. Security testers install it on a dedicated test phone to read an app’s private files, add system certificates for traffic interception and check how the app detects root. Supports Android 7.0 and later, GPL-3.0 license. Download only from the project’s GitHub.', 'Root-доступ MagiskSU
Модулі системи
Zygisk для коду в процесах застосунків
Android 7.0+', 'MagiskSU root access
System modules
Zygisk to run code in app processes
Android 7.0+', 'QA-інженери, пентестери й мобільні розробники, що перевіряють захищеність застосунків Android та iOS', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-05 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/topjohnwu/magisk' OR LOWER(`name`) = 'magisk') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source suite for root access and Android customization without touching the system partition, for test devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Magisk provides root access (MagiskSU), installs modules that modify the system and runs code inside app processes via Zygisk. Security testers install it on a dedicated test phone to read an app’s private files, add system certificates for traffic interception and check how the app detects root. Supports Android 7.0 and later, GPL-3.0 license. Download only from the project’s GitHub.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'MagiskSU root access
System modules
Zygisk to run code in app processes
Android 7.0+', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Oversecured — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oversecured.com' OR LOWER(`name`) = 'oversecured')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Oversecured', NULL, 'https://oversecured.com', NULL, NULL, 'Платформа автоматичного пошуку вразливостей у застосунках Android та iOS: SAST, DAST, IAST і АІ-перевірка знахідок.', 'Automated vulnerability scanning platform for Android and iOS apps: SAST, DAST, IAST and AI validation of findings.', 'Oversecured аналізує Android-застосунки без вихідного коду (APK, AAB) і iOS за вихідним кодом. Статичний аналіз відстежує, чи потрапляють дані зловмисника в небезпечні функції, динамічний запускає застосунок і перевіряє deep links, експортовані компоненти й WebView, інтерактивний сканує розділи після входу. Кожна знахідка має доказ, кроки відтворення й поради з виправлення, зіставлені з OWASP Mobile Top 10. Є CLI, API, інтеграція з CI/CD і пробний період.', 'Oversecured analyzes Android apps without source code (APK, AAB) and iOS apps from source. Static analysis traces whether attacker data reaches dangerous functions, dynamic analysis runs the app and tests deep links, exported components and WebView, and interactive analysis scans logged-in areas. Each finding includes a proof of concept, repro steps and fix guidance mapped to OWASP Mobile Top 10. CLI, API, CI/CD integration and a free trial are available.', 'SAST, DAST та IAST
Android без вихідного коду
Доказ і кроки відтворення
CLI, API, CI/CD', 'SAST, DAST and IAST
Android without source code
Proof of concept and repro steps
CLI, API, CI/CD', 'QA-інженери, пентестери й мобільні розробники, що перевіряють захищеність застосунків Android та iOS', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-05 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'oversecured.com' OR LOWER(`name`) = 'oversecured') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Automated vulnerability scanning platform for Android and iOS apps: SAST, DAST, IAST and AI validation of findings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Oversecured analyzes Android apps without source code (APK, AAB) and iOS apps from source. Static analysis traces whether attacker data reaches dangerous functions, dynamic analysis runs the app and tests deep links, exported components and WebView, and interactive analysis scans logged-in areas. Each finding includes a proof of concept, repro steps and fix guidance mapped to OWASP Mobile Top 10. CLI, API, CI/CD integration and a free trial are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'SAST, DAST and IAST
Android without source code
Proof of concept and repro steps
CLI, API, CI/CD', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- NowSecure — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nowsecure.com' OR LOWER(`name`) = 'nowsecure')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'NowSecure', NULL, 'https://www.nowsecure.com', NULL, NULL, 'Корпоративна платформа безпеки мобільних застосунків: автоматичне тестування на реальних пристроях, пентест як сервіс і SBOM.', 'Enterprise mobile app security platform: automated testing on real devices, pentest as a service and SBOM.', 'NowSecure тестує скомпільовані застосунки на реальних пристроях: автоматичний SAST, DAST, IAST і перевірка API, аналіз потоків даних і динамічний SBOM, перевірка відповідності маніфестам приватності Apple і Google Play. Сервіс PTaaS поєднує автоматичне тестування з ручним пентестом експертів. Компанія — лабораторія Google MASA, співголова OWASP MAS і підтримує Frida та radare2. Ціни — за запитом.', 'NowSecure tests compiled apps on real devices: automated SAST, DAST, IAST and API testing, data flow analysis and a dynamic SBOM, and checks against Apple privacy manifests and Google Play Data Safety. PTaaS combines automated testing with expert-led pentesting. The company is a Google MASA lab, co-chair of OWASP MAS and maintains Frida and radare2. Pricing on request.', 'Тестування на реальних пристроях
SAST, DAST, IAST і API
Пентест як сервіс
Інтеграції з GitHub, GitLab, Azure DevOps', 'Testing on real devices
SAST, DAST, IAST and API
Pentest as a service
GitHub, GitLab, Azure DevOps integrations', 'QA-інженери, пентестери й мобільні розробники, що перевіряють захищеність застосунків Android та iOS', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-05 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nowsecure.com' OR LOWER(`name`) = 'nowsecure') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Enterprise mobile app security platform: automated testing on real devices, pentest as a service and SBOM.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'NowSecure tests compiled apps on real devices: automated SAST, DAST, IAST and API testing, data flow analysis and a dynamic SBOM, and checks against Apple privacy manifests and Google Play Data Safety. PTaaS combines automated testing with expert-led pentesting. The company is a Google MASA lab, co-chair of OWASP MAS and maintains Frida and radare2. Pricing on request.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Testing on real devices
SAST, DAST, IAST and API
Pentest as a service
GitHub, GitLab, Azure DevOps integrations', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Appknox — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'appknox.com' OR LOWER(`name`) = 'appknox')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Appknox', NULL, 'https://www.appknox.com', NULL, NULL, 'Платформа безпеки мобільних застосунків: бінарний SAST, DAST на реальних пристроях, перевірка API, SBOM і пошук підробок у магазинах.', 'Mobile app security platform: binary SAST, DAST on real devices, API testing, SBOM and fake app detection in stores.', 'Appknox перевіряє застосунки Android та iOS без вихідного коду: статичний аналіз скомпільованої збірки, динамічні тести на реальних пристроях, перевірку кожного API, який викликає застосунок, і перелік бібліотек та SDK (SBOM). Privacy Shield аналізує трекери й дозволи, а Storeknox шукає в магазинах підроблені чи перепаковані копії застосунку. Звіти зіставлено з OWASP MASVS, PCI DSS і HIPAA. Є пробний період і безкоштовна перевірка однієї збірки.', 'Appknox tests Android and iOS apps without source code: static analysis of the compiled build, dynamic tests on real devices, testing of every API the app calls, and a list of libraries and SDKs (SBOM). Privacy Shield reviews trackers and permissions, and Storeknox finds fake or repackaged copies in app stores. Reports map to OWASP MASVS, PCI DSS and HIPAA. A free trial and a free check of one build are available.', 'Бінарний SAST і DAST на пристроях
Тестування API
SBOM і перевірка приватності
Пошук підробок у магазинах', 'Binary SAST and on-device DAST
API testing
SBOM and privacy checks
Fake app detection in stores', 'QA-інженери, пентестери й мобільні розробники, що перевіряють захищеність застосунків Android та iOS', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-05 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'appknox.com' OR LOWER(`name`) = 'appknox') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mobile app security platform: binary SAST, DAST on real devices, API testing, SBOM and fake app detection in stores.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Appknox tests Android and iOS apps without source code: static analysis of the compiled build, dynamic tests on real devices, testing of every API the app calls, and a list of libraries and SDKs (SBOM). Privacy Shield reviews trackers and permissions, and Storeknox finds fake or repackaged copies in app stores. Reports map to OWASP MASVS, PCI DSS and HIPAA. A free trial and a free check of one build are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Binary SAST and on-device DAST
API testing
SBOM and privacy checks
Fake app detection in stores', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Ostorlab — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ostorlab.co' OR LOWER(`name`) = 'ostorlab')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Ostorlab', NULL, 'https://ostorlab.co', NULL, NULL, 'Сканер безпеки мобільних застосунків з АІ-агентами: статичний і динамічний аналіз APK, AAB, IPA та безкоштовний план Community.', 'Mobile app security scanner with AI agents: static and dynamic analysis of APK, AAB, IPA and a free Community plan.', 'Ostorlab сканує застосунки Android, iOS і HarmonyOS — із файлу збірки, TestFlight чи сторінки в магазині. Агенти входять у застосунок, обходять pinning і обфускацію, стежать за трафіком до API й підтверджують знахідки робочим експлойтом. Є SAST, DAST, SBOM, пошук секретів і перевірка приватності, інтеграції з GitHub, GitLab, Jenkins і Jira. Безкоштовний план Community дає необмежені сканування мобільних застосунків, платні плани — від 599 $ на застосунок на місяць.', 'Ostorlab scans Android, iOS and HarmonyOS apps from a build file, TestFlight or a store listing. Agents log into the app, bypass pinning and obfuscation, follow traffic into APIs and confirm findings with a working exploit. SAST, DAST, SBOM, secrets detection and privacy checks are included, with GitHub, GitLab, Jenkins and Jira integrations. The free Community plan offers unlimited mobile app scans; paid plans start at $599 per app per month.', 'APK, AAB, IPA, TestFlight, магазин
SAST, DAST, SBOM, секрети
Підтвердження знахідок експлойтом
Безкоштовний план Community', 'APK, AAB, IPA, TestFlight, store
SAST, DAST, SBOM, secrets
Exploit-backed findings
Free Community plan', 'QA-інженери, пентестери й мобільні розробники, що перевіряють захищеність застосунків Android та iOS', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-05 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ostorlab.co' OR LOWER(`name`) = 'ostorlab') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mobile app security scanner with AI agents: static and dynamic analysis of APK, AAB, IPA and a free Community plan.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Ostorlab scans Android, iOS and HarmonyOS apps from a build file, TestFlight or a store listing. Agents log into the app, bypass pinning and obfuscation, follow traffic into APIs and confirm findings with a working exploit. SAST, DAST, SBOM, secrets detection and privacy checks are included, with GitHub, GitLab, Jenkins and Jira integrations. The free Community plan offers unlimited mobile app scans; paid plans start at $599 per app per month.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'APK, AAB, IPA, TestFlight, store
SAST, DAST, SBOM, secrets
Exploit-backed findings
Free Community plan', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовний тариф або версія з обмеженнями.', 'A free plan or limited free version is available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free plan or limited free version is available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Corellium — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'corellium.com' OR LOWER(`name`) = 'corellium')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Corellium', NULL, 'https://www.corellium.com', NULL, NULL, 'Віртуальні пристрої iOS та Android з root-доступом у браузері для тестування безпеки й дослідження вразливостей.', 'Virtual iOS and Android devices with root access in the browser for security testing and vulnerability research.', 'Corellium запускає віртуальні iPhone та Android-пристрої на ARM-серверах: актуальні версії систем, root-доступ одразу, інструменти для аналізу файлів, мережі й процесів, CLI та API. Тестувальникам це заміняє окремі телефони з jailbreak чи root, які важко підтримувати для нових версій iOS. Модуль MATRIX автоматизує перевірки безпеки й звіти. Є плани Solo для дослідників і Viper для компаній, пробний період за запитом.', 'Corellium runs virtual iPhone and Android devices on ARM servers: current OS versions, instant root access, tools for analyzing files, network and processes, plus CLI and API. For testers it replaces dedicated jailbroken or rooted phones that are hard to keep up with new iOS releases. The MATRIX module automates security checks and reports. Solo for researchers and Viper for businesses; a trial is available on request.', 'Віртуальні iOS та Android
Root-доступ одразу
Аналіз мережі, файлів, процесів
Автоматичні перевірки MATRIX', 'Virtual iOS and Android
Instant root access
Network, file and process analysis
MATRIX automated testing', 'QA-інженери, пентестери й мобільні розробники, що перевіряють захищеність застосунків Android та iOS', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-05 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'corellium.com' OR LOWER(`name`) = 'corellium') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Virtual iOS and Android devices with root access in the browser for security testing and vulnerability research.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Corellium runs virtual iPhone and Android devices on ARM servers: current OS versions, instant root access, tools for analyzing files, network and processes, plus CLI and API. For testers it replaces dedicated jailbroken or rooted phones that are hard to keep up with new iOS releases. The MATRIX module automates security checks and reports. Solo for researchers and Viper for businesses; a trial is available on request.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Virtual iOS and Android
Instant root access
Network, file and process analysis
MATRIX automated testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters and mobile developers checking the security of Android and iOS apps', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- freeRASP — Тестування, Безпека коду та застосунків, Мобільна розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/talsec/free-rasp-community' OR LOWER(`name`) = 'freerasp')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'freeRASP', NULL, 'https://github.com/talsec/Free-RASP-Community', NULL, NULL, 'Безкоштовний SDK захисту застосунку під час роботи від Talsec: виявляє root, jailbreak, Frida, емулятори й підробку застосунку.', 'Free runtime app self-protection SDK by Talsec: detects root, jailbreak, Frida, emulators and app tampering.', 'freeRASP вбудовується в застосунок і повідомляє, коли той запущено на пристрої з root чи jailbreak, в емуляторі, під налагоджувачем, з Frida чи іншими інструментами перехоплення, або коли застосунок перепідписано й змінено. Розробник сам вирішує, як реагувати: попередити, обмежити функції чи завершити роботу. Є SDK для Android, iOS, Flutter, React Native, Cordova, Capacitor, Kotlin Multiplatform і Unity. Тестувальнику він цікавий і як об’єкт перевірки: чи справді захист спрацьовує.', 'freeRASP is embedded in an app and reports when it runs on a rooted or jailbroken device, in an emulator, under a debugger, with Frida or other hooking tools, or when the app has been re-signed and modified. The developer decides how to react: warn, limit features or exit. SDKs exist for Android, iOS, Flutter, React Native, Cordova, Capacitor, Kotlin Multiplatform and Unity. For testers it is also something to verify: does the protection actually trigger.', 'Виявлення root, jailbreak, емуляторів
Виявлення Frida й налагодження
Перевірка цілісності й підпису
Android, iOS, Flutter, React Native та ін.', 'Root, jailbreak and emulator detection
Frida and debugger detection
Integrity and signature checks
Android, iOS, Flutter, React Native and more', 'Мобільні розробники й команди безпеки, що захищають застосунки та їхні API від підробок і зламу', 'Mobile developers and security teams protecting apps and their APIs from tampering and attacks', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-05 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/talsec/free-rasp-community' OR LOWER(`name`) = 'freerasp') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'mobile-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free runtime app self-protection SDK by Talsec: detects root, jailbreak, Frida, emulators and app tampering.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'freeRASP is embedded in an app and reports when it runs on a rooted or jailbroken device, in an emulator, under a debugger, with Frida or other hooking tools, or when the app has been re-signed and modified. The developer decides how to react: warn, limit features or exit. SDKs exist for Android, iOS, Flutter, React Native, Cordova, Capacitor, Kotlin Multiplatform and Unity. For testers it is also something to verify: does the protection actually trigger.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Root, jailbreak and emulator detection
Frida and debugger detection
Integrity and signature checks
Android, iOS, Flutter, React Native and more', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Mobile developers and security teams protecting apps and their APIs from tampering and attacks', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Approov — Тестування, Безпека коду та застосунків, Мобільна розробка
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'approov.io' OR LOWER(`name`) = 'approov')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Approov', NULL, 'https://approov.io', NULL, NULL, 'Сервіс атестації мобільних застосунків і захисту API: доступ до API лише справжнім застосункам, динамічний pinning і захист секретів.', 'Mobile app attestation and API protection service: only genuine apps reach the API, dynamic pinning and secrets protection.', 'Approov перевіряє під час роботи, що запит до API надсилає справжній, незмінений застосунок на безпечному пристрої, а не скрипт, бот чи перепакована копія. Сертифікати для pinning оновлюються динамічно без випуску нової версії, а ключі API зберігаються в хмарі й видаються застосунку лише після успішної атестації — їх не знайти, розпакувавши APK. Підтримує Android, iOS і HarmonyOS Next, є пробний період.', 'Approov verifies at runtime that an API request comes from the genuine, unmodified app on a safe device, not a script, bot or repackaged copy. Pinning certificates update dynamically without a new release, and API keys are stored in the cloud and delivered to the app only after successful attestation, so they cannot be found by unpacking the APK. Supports Android, iOS and HarmonyOS Next; a free trial is available.', 'Атестація застосунку й пристрою
Захист API від ботів і підробок
Динамічний certificate pinning
Секрети видаються лише після атестації', 'App and device attestation
API protection from bots and fakes
Dynamic certificate pinning
Secrets delivered only after attestation', 'Мобільні розробники й команди безпеки, що захищають застосунки та їхні API від підробок і зламу', 'Mobile developers and security teams protecting apps and their APIs from tampering and attacks', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-05 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'approov.io' OR LOWER(`name`) = 'approov') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'mobile-development' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Mobile app attestation and API protection service: only genuine apps reach the API, dynamic pinning and secrets protection.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Approov verifies at runtime that an API request comes from the genuine, unmodified app on a safe device, not a script, bot or repackaged copy. Pinning certificates update dynamically without a new release, and API keys are stored in the cloud and delivered to the app only after successful attestation, so they cannot be found by unpacking the APK. Supports Android, iOS and HarmonyOS Next; a free trial is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'App and device attestation
API protection from bots and fakes
Dynamic certificate pinning
Secrets delivered only after attestation', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Mobile developers and security teams protecting apps and their APIs from tampering and attacks', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- AndroGoat — Тестування, Безпека коду та застосунків, Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/satishpatnayak/androgoat' OR LOWER(`name`) = 'androgoat')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'AndroGoat', NULL, 'https://github.com/satishpatnayak/AndroGoat', NULL, NULL, 'Навмисно вразливий Android-застосунок на Kotlin для легальної практики тестування безпеки: понад 30 завдань.', 'Intentionally vulnerable Kotlin Android app for legal security testing practice: 30+ challenges.', 'AndroGoat містить понад 30 навмисно залишених вразливостей: небезпечне зберігання даних у SharedPreferences, SQLite і тимчасових файлах, витоки через логи й буфер обміну, XSS і SQL-ін’єкції у WebView, незахищені компоненти Android, прописані в коді ключі, слабкий pinning, неправильна конфігурація (debuggable, allowBackup), обхід виявлення root і біометрії. Ідеальний полігон, щоб відпрацювати MASTG на практиці. Ліцензія MIT.', 'AndroGoat contains 30+ deliberately left vulnerabilities: insecure storage in SharedPreferences, SQLite and temp files, leaks via logs and clipboard, XSS and SQL injection in WebView, unprotected Android components, hardcoded keys, weak pinning, misconfiguration (debuggable, allowBackup), root and biometric bypass. A great playground to practice MASTG hands-on. MIT license.', '30+ навчальних вразливостей
Сховище, мережа, компоненти, WebView
Обхід root і біометрії
Написано на Kotlin', '30+ training vulnerabilities
Storage, network, components, WebView
Root and biometric bypass
Written in Kotlin', 'Тестувальники й студенти, які вчаться тестуванню безпеки мобільних застосунків на легальних тренажерах', 'Testers and students learning mobile app security testing on legal practice targets', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-05 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/satishpatnayak/androgoat' OR LOWER(`name`) = 'androgoat') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Intentionally vulnerable Kotlin Android app for legal security testing practice: 30+ challenges.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'AndroGoat contains 30+ deliberately left vulnerabilities: insecure storage in SharedPreferences, SQLite and temp files, leaks via logs and clipboard, XSS and SQL injection in WebView, unprotected Android components, hardcoded keys, weak pinning, misconfiguration (debuggable, allowBackup), root and biometric bypass. A great playground to practice MASTG hands-on. MIT license.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '30+ training vulnerabilities
Storage, network, components, WebView
Root and biometric bypass
Written in Kotlin', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers and students learning mobile app security testing on legal practice targets', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- DVIA-v2 — Тестування, Безпека коду та застосунків, Тренажери для тестувальників
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/prateek147/dvia-v2' OR LOWER(`name`) = 'dvia-v2')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DVIA-v2', NULL, 'https://github.com/prateek147/DVIA-v2', NULL, NULL, 'Damn Vulnerable iOS App — навмисно вразливий iOS-застосунок на Swift для практики тестування безпеки iOS.', 'Damn Vulnerable iOS App: an intentionally vulnerable Swift iOS app for practicing iOS security testing.', 'DVIA-v2 містить 15 розділів із вразливостями: локальне зберігання даних, виявлення jailbreak, маніпуляції під час роботи, обхід Touch ID і Face ID, витоки через побічні канали, помилки IPC, слабка криптографія, WebView, мережевий рівень, патчинг застосунку й чутливі дані в пам’яті. До завдань є розв’язки. Ліцензія MIT; завдання перевірялися на старших версіях iOS, тому частину вправ на новій iOS доведеться адаптувати.', 'DVIA-v2 has 15 vulnerability sections: local data storage, jailbreak detection, runtime manipulation, Touch ID and Face ID bypass, side-channel leaks, IPC issues, broken cryptography, WebView, network layer, app patching and sensitive data in memory. Solutions are available. MIT license; challenges were tested on older iOS versions, so some exercises may need adapting on current iOS.', '15 розділів вразливостей iOS
Jailbreak, runtime, біометрія
Розв’язки завдань
Написано на Swift', '15 iOS vulnerability sections
Jailbreak, runtime, biometrics
Challenge solutions
Written in Swift', 'Тестувальники й студенти, які вчаться тестуванню безпеки мобільних застосунків на легальних тренажерах', 'Testers and students learning mobile app security testing on legal practice targets', 'mobile', 'none', 'published', 0, 'found', @uid, '2026-11-05 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/prateek147/dvia-v2' OR LOWER(`name`) = 'dvia-v2') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Damn Vulnerable iOS App: an intentionally vulnerable Swift iOS app for practicing iOS security testing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'DVIA-v2 has 15 vulnerability sections: local data storage, jailbreak detection, runtime manipulation, Touch ID and Face ID bypass, side-channel leaks, IPC issues, broken cryptography, WebView, network layer, app patching and sensitive data in memory. Solutions are available. MIT license; challenges were tested on older iOS versions, so some exercises may need adapting on current iOS.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', '15 iOS vulnerability sections
Jailbreak, runtime, biometrics
Challenge solutions
Written in Swift', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers and students learning mobile app security testing on legal practice targets', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Наявні продукти MobSF і Frida → «Безпека коду та застосунків»
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'MobSF' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'Frida' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;

