SET NAMES utf8mb4;

-- =====================================================================
-- AI LAB HUB — партія 2026-11-04: «Розробка та IT» → «Тестування» / «Тренажери для тестувальників» і «Кібербезпека» → «Безпека коду та застосунків» (slug appsec).
-- Партія 6: 28 нових продуктів — тестування безпеки (для статті про тестування безпеки); також «Кібербезпека» → «Безпека коду та застосунків».
-- Тексти UA/EN написано за офіційними сторінками, звірено 2026-11-04. Якщо продукт з такою адресою чи назвою вже є — лише прив’язка.
-- Без фіксованих id: @new рахується ДО INSERT, @pid — за нормалізованою адресою або назвою. Повторний запуск безпечний.
--   Nmap
--   Nuclei
--   Nikto
--   sqlmap
--   Metasploit
--   Kali Linux
--   Wireshark
--   SonarQube
--   Trivy
--   Gitleaks
--   TruffleHog
--   OWASP Dependency-Check
--   Invicti
--   Detectify
--   Intruder
--   Nessus
--   OpenVAS
--   Caido
--   ffuf
--   HTTP Observatory
--   SSL Labs
--   Security Headers
--   HackerOne
--   Bugcrowd
--   Hack The Box
--   TryHackMe
--   DVWA
--   OWASP crAPI
-- =====================================================================

SET @uid = (SELECT `id` FROM `users` WHERE `email` = 'whitevelvetelf@gmail.com' LIMIT 1);
SET @cat = (SELECT `id` FROM `categories` WHERE `slug` = 'development-it' LIMIT 1);

-- Nmap — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nmap.org' OR LOWER(`name`) = 'nmap')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nmap', NULL, 'https://nmap.org', NULL, NULL, 'Безкоштовний відкритий сканер мереж і портів: які хости доступні, які порти відкриті й які сервіси на них працюють.', 'Free open-source network and port scanner: which hosts are up, which ports are open and what services run on them.', 'Nmap досліджує мережу: знаходить активні хости, відкриті порти, визначає сервіси, їхні версії й операційну систему. Скриптовий рушій NSE додає сотні перевірок, зокрема на відомі вразливості. Є графічна оболонка Zenmap. Працює на Linux, Windows і macOS. Один із базових інструментів будь-якого тестування безпеки інфраструктури.', 'Nmap explores a network: it finds live hosts and open ports and identifies services, their versions and the operating system. The NSE scripting engine adds hundreds of checks, including for known vulnerabilities. Zenmap provides a graphical interface. It runs on Linux, Windows and macOS. One of the basic tools of any infrastructure security test.', 'Сканування портів і хостів
Визначення сервісів, версій і ОС
Скрипти NSE
Графічна оболонка Zenmap', 'Port and host scanning
Service, version and OS detection
NSE scripts
Zenmap GUI', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'nmap.org' OR LOWER(`name`) = 'nmap') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free open-source network and port scanner: which hosts are up, which ports are open and what services run on them.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Nmap explores a network: it finds live hosts and open ports and identifies services, their versions and the operating system. The NSE scripting engine adds hundreds of checks, including for known vulnerabilities. Zenmap provides a graphical interface. It runs on Linux, Windows and macOS. One of the basic tools of any infrastructure security test.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Port and host scanning
Service, version and OS detection
NSE scripts
Zenmap GUI', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Nuclei — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/projectdiscovery/nuclei' OR LOWER(`name`) = 'nuclei')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nuclei', NULL, 'https://github.com/projectdiscovery/nuclei', NULL, NULL, 'Швидкий відкритий сканер вразливостей на шаблонах YAML, які пише й оновлює спільнота.', 'Fast open-source vulnerability scanner driven by community-maintained YAML templates.', 'Nuclei перевіряє сайти, API, мережеві сервіси й хмарні конфігурації за тисячами готових шаблонів: відомі CVE, неправильні налаштування, відкриті адмінки, витоки файлів. Шаблон — це простий YAML-файл, тож команда може описати власні перевірки. Зручно запускати в CI. Відкритий код від ProjectDiscovery.', 'Nuclei checks websites, APIs, network services and cloud configurations against thousands of ready-made templates: known CVEs, misconfigurations, exposed admin panels and leaked files. A template is a simple YAML file, so a team can write its own checks. Easy to run in CI. Open source from ProjectDiscovery.', 'Тисячі шаблонів від спільноти
Власні перевірки в YAML
Веб, API, мережа, хмара
Запуск у CI', 'Thousands of community templates
Custom checks in YAML
Web, API, network, cloud
Runs in CI', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/projectdiscovery/nuclei' OR LOWER(`name`) = 'nuclei') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fast open-source vulnerability scanner driven by community-maintained YAML templates.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Nuclei checks websites, APIs, network services and cloud configurations against thousands of ready-made templates: known CVEs, misconfigurations, exposed admin panels and leaked files. A template is a simple YAML file, so a team can write its own checks. Easy to run in CI. Open source from ProjectDiscovery.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Thousands of community templates
Custom checks in YAML
Web, API, network, cloud
Runs in CI', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Nikto — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/sullo/nikto' OR LOWER(`name`) = 'nikto')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nikto', NULL, 'https://github.com/sullo/nikto', NULL, NULL, 'Класичний відкритий сканер вебсерверів: небезпечні файли, застарілі версії й помилки конфігурації.', 'Classic open-source web server scanner for dangerous files, outdated versions and misconfigurations.', 'Nikto швидко перевіряє вебсервер на тисячі відомих проблем: потенційно небезпечні файли й скрипти, застарілі версії серверного ПЗ, небезпечні HTTP-методи, відсутні заголовки безпеки. Працює з командного рядка й формує звіт. Сканує «гучно», тож підходить для власних тестових середовищ, а не для прихованих перевірок. Відкритий код.', 'Nikto quickly checks a web server for thousands of known issues: potentially dangerous files and scripts, outdated server software, risky HTTP methods and missing security headers. It runs from the command line and produces a report. It scans "loudly", so it suits your own test environments rather than stealthy assessments. Open source.', 'Небезпечні файли й скрипти
Застарілі версії ПЗ
Помилки конфігурації
Звіти з командного рядка', 'Dangerous files and scripts
Outdated software versions
Misconfigurations
Command-line reports', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/sullo/nikto' OR LOWER(`name`) = 'nikto') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Classic open-source web server scanner for dangerous files, outdated versions and misconfigurations.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Nikto quickly checks a web server for thousands of known issues: potentially dangerous files and scripts, outdated server software, risky HTTP methods and missing security headers. It runs from the command line and produces a report. It scans "loudly", so it suits your own test environments rather than stealthy assessments. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Dangerous files and scripts
Outdated software versions
Misconfigurations
Command-line reports', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- sqlmap — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sqlmap.org' OR LOWER(`name`) = 'sqlmap')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'sqlmap', NULL, 'https://sqlmap.org', NULL, NULL, 'Відкритий інструмент, що автоматично знаходить і підтверджує SQL-ін’єкції у вебзастосунках.', 'Open-source tool that automatically detects and confirms SQL injection in web applications.', 'sqlmap перевіряє параметри запитів, форми, cookies і заголовки на SQL-ін’єкції різних типів, визначає СУБД і показує, які дані можна отримати через вразливість. Підтримує MySQL, PostgreSQL, Microsoft SQL Server, Oracle, SQLite та інші. Використовуйте лише на власних системах або з дозволом власника. Відкритий код (GPLv2).', 'sqlmap tests request parameters, forms, cookies and headers for various types of SQL injection, identifies the DBMS and shows what data could be reached through the flaw. It supports MySQL, PostgreSQL, Microsoft SQL Server, Oracle, SQLite and more. Use it only on your own systems or with the owner''s permission. Open source (GPLv2).', 'Автоматичний пошук SQL-ін’єкцій
Визначення СУБД
Параметри, форми, cookies, заголовки
Відкритий код', 'Automatic SQL injection detection
DBMS fingerprinting
Parameters, forms, cookies, headers
Open source', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sqlmap.org' OR LOWER(`name`) = 'sqlmap') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source tool that automatically detects and confirms SQL injection in web applications.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'sqlmap tests request parameters, forms, cookies and headers for various types of SQL injection, identifies the DBMS and shows what data could be reached through the flaw. It supports MySQL, PostgreSQL, Microsoft SQL Server, Oracle, SQLite and more. Use it only on your own systems or with the owner''s permission. Open source (GPLv2).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Automatic SQL injection detection
DBMS fingerprinting
Parameters, forms, cookies, headers
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Metasploit — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'metasploit.com' OR LOWER(`name`) = 'metasploit')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Metasploit', NULL, 'https://www.metasploit.com', NULL, NULL, 'Платформа для тестування на проникнення від Rapid7: перевірка вразливостей готовими модулями.', 'Rapid7 penetration testing platform for verifying vulnerabilities with ready-made modules.', 'Metasploit містить тисячі модулів для сканування, перевірки й експлуатації відомих вразливостей, а також інструменти для подальших кроків пентесту. Безкоштовний відкритий Metasploit Framework працює з командного рядка; комерційний Metasploit Pro додає графічний інтерфейс, автоматизацію й звіти. Інструмент для досвідчених пентестерів і лише для систем, на тестування яких є дозвіл.', 'Metasploit contains thousands of modules for scanning, verifying and exploiting known vulnerabilities, plus tools for later pentest stages. The free open-source Metasploit Framework runs from the command line; the commercial Metasploit Pro adds a GUI, automation and reports. A tool for experienced pentesters, and only for systems you are authorised to test.', 'Тисячі модулів
Перевірка відомих вразливостей
Безкоштовний Metasploit Framework
Metasploit Pro зі звітами', 'Thousands of modules
Verification of known vulnerabilities
Free Metasploit Framework
Metasploit Pro with reports', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'metasploit.com' OR LOWER(`name`) = 'metasploit') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Rapid7 penetration testing platform for verifying vulnerabilities with ready-made modules.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Metasploit contains thousands of modules for scanning, verifying and exploiting known vulnerabilities, plus tools for later pentest stages. The free open-source Metasploit Framework runs from the command line; the commercial Metasploit Pro adds a GUI, automation and reports. A tool for experienced pentesters, and only for systems you are authorised to test.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Thousands of modules
Verification of known vulnerabilities
Free Metasploit Framework
Metasploit Pro with reports', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовний тариф або версія з обмеженнями.', 'A free plan or limited free version is available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free plan or limited free version is available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Kali Linux — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kali.org' OR LOWER(`name`) = 'kali linux')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Kali Linux', NULL, 'https://www.kali.org', NULL, NULL, 'Безкоштовний дистрибутив Linux для тестування на проникнення з сотнями встановлених інструментів безпеки.', 'Free Linux distribution for penetration testing with hundreds of security tools preinstalled.', 'Kali Linux від Offensive Security містить готовий набір інструментів для тестування безпеки: сканери мереж і вебзастосунків, проксі, інструменти аналізу паролів, бездротових мереж і криміналістики. Його можна встановити як основну систему, у віртуальну машину, WSL на Windows або запускати з флешки. Популярне середовище для навчання й роботи пентестерів.', 'Kali Linux from Offensive Security comes with a ready set of security testing tools: network and web application scanners, proxies, password analysis, wireless and forensics tools. You can install it as a main system, in a virtual machine, in WSL on Windows or run it from a USB stick. A popular environment for pentesters to learn and work in.', 'Сотні інструментів безпеки
Віртуальна машина, WSL, USB
Регулярні оновлення
Безкоштовно', 'Hundreds of security tools
Virtual machine, WSL, USB
Regular updates
Free', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'kali.org' OR LOWER(`name`) = 'kali linux') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free Linux distribution for penetration testing with hundreds of security tools preinstalled.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Kali Linux from Offensive Security comes with a ready set of security testing tools: network and web application scanners, proxies, password analysis, wireless and forensics tools. You can install it as a main system, in a virtual machine, in WSL on Windows or run it from a USB stick. A popular environment for pentesters to learn and work in.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hundreds of security tools
Virtual machine, WSL, USB
Regular updates
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Wireshark — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wireshark.org' OR LOWER(`name`) = 'wireshark')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Wireshark', NULL, 'https://www.wireshark.org', NULL, NULL, 'Найпопулярніший відкритий аналізатор мережевого трафіку: перехоплення й розбір пакетів сотень протоколів.', 'The most popular open-source network protocol analyser for capturing and inspecting packets of hundreds of protocols.', 'Wireshark перехоплює мережеві пакети й показує їх у зрозумілому вигляді: хто з ким з’єднується, якими протоколами і які дані передаються. У тестуванні безпеки допомагає перевірити, чи не передаються паролі й особисті дані відкритим текстом, а в загальному тестуванні — розібратися з мережевими збоями. Працює на Windows, macOS і Linux.', 'Wireshark captures network packets and shows them in readable form: who connects to whom, over which protocols and with what data. In security testing it helps check that passwords and personal data are not sent in plain text, and in general testing it helps investigate network failures. Runs on Windows, macOS and Linux.', 'Перехоплення пакетів
Розбір сотень протоколів
Фільтри й статистика
Відкритий код', 'Packet capture
Hundreds of protocol dissectors
Filters and statistics
Open source', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'wireshark.org' OR LOWER(`name`) = 'wireshark') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'The most popular open-source network protocol analyser for capturing and inspecting packets of hundreds of protocols.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Wireshark captures network packets and shows them in readable form: who connects to whom, over which protocols and with what data. In security testing it helps check that passwords and personal data are not sent in plain text, and in general testing it helps investigate network failures. Runs on Windows, macOS and Linux.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Packet capture
Hundreds of protocol dissectors
Filters and statistics
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SonarQube — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sonarsource.com/products/sonarqube' OR LOWER(`name`) = 'sonarqube')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SonarQube', NULL, 'https://www.sonarsource.com/products/sonarqube/', NULL, NULL, 'Платформа Sonar для статичного аналізу коду: баги, вразливості, «запахи» коду й перевірка коду, написаного АІ.', 'Sonar platform for static code analysis: bugs, vulnerabilities, code smells and checks for AI-generated code.', 'SonarQube аналізує код понад 30 мов програмування й знаходить баги, вразливості, проблемні з погляду безпеки місця й надмірну складність. «Ворота якості» (quality gate) не дають злити в основну гілку код, що не відповідає вимогам. Працює як серверна версія (зокрема безкоштовна Community Build), хмарна SonarQube Cloud і плагін для IDE.', 'SonarQube analyses code in over 30 programming languages and finds bugs, vulnerabilities, security hotspots and excessive complexity. A quality gate blocks code that doesn''t meet the requirements from being merged. It is available as a server (including the free Community Build), as SonarQube Cloud and as an IDE plugin.', 'Статичний аналіз 30+ мов
Вразливості й security hotspots
Quality gate у CI
Безкоштовна Community Build', 'Static analysis for 30+ languages
Vulnerabilities and security hotspots
Quality gate in CI
Free Community Build', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'web,desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'sonarsource.com/products/sonarqube' OR LOWER(`name`) = 'sonarqube') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Sonar platform for static code analysis: bugs, vulnerabilities, code smells and checks for AI-generated code.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'SonarQube analyses code in over 30 programming languages and finds bugs, vulnerabilities, security hotspots and excessive complexity. A quality gate blocks code that doesn''t meet the requirements from being merged. It is available as a server (including the free Community Build), as SonarQube Cloud and as an IDE plugin.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Static analysis for 30+ languages
Vulnerabilities and security hotspots
Quality gate in CI
Free Community Build', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовний тариф або версія з обмеженнями.', 'A free plan or limited free version is available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free plan or limited free version is available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Trivy — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trivy.dev' OR LOWER(`name`) = 'trivy')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Trivy', NULL, 'https://trivy.dev', NULL, NULL, 'Відкритий сканер безпеки від Aqua: вразливості в контейнерах, залежностях, Kubernetes і конфігураціях IaC.', 'Open-source security scanner from Aqua for vulnerabilities in containers, dependencies, Kubernetes and IaC.', 'Trivy однією командою перевіряє образи Docker, файлові системи, Git-репозиторії й кластери Kubernetes на відомі вразливості пакетів, секрети в коді й небезпечні налаштування Terraform, Dockerfile чи Kubernetes-маніфестів. Також генерує SBOM. Легко вбудовується в CI. Відкритий код.', 'Trivy checks Docker images, file systems, Git repositories and Kubernetes clusters with a single command for known package vulnerabilities, secrets in code and risky Terraform, Dockerfile or Kubernetes manifest settings. It also generates SBOMs. Easy to plug into CI. Open source.', 'Сканування контейнерів і залежностей
Секрети в коді
Конфігурації IaC і Kubernetes
SBOM', 'Container and dependency scanning
Secrets in code
IaC and Kubernetes configs
SBOM', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'trivy.dev' OR LOWER(`name`) = 'trivy') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source security scanner from Aqua for vulnerabilities in containers, dependencies, Kubernetes and IaC.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Trivy checks Docker images, file systems, Git repositories and Kubernetes clusters with a single command for known package vulnerabilities, secrets in code and risky Terraform, Dockerfile or Kubernetes manifest settings. It also generates SBOMs. Easy to plug into CI. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Container and dependency scanning
Secrets in code
IaC and Kubernetes configs
SBOM', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Gitleaks — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/gitleaks/gitleaks' OR LOWER(`name`) = 'gitleaks')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Gitleaks', NULL, 'https://github.com/gitleaks/gitleaks', NULL, NULL, 'Відкритий інструмент для пошуку паролів, ключів API й токенів у коді та історії Git.', 'Open-source tool for finding passwords, API keys and tokens in code and Git history.', 'Gitleaks сканує репозиторій, зокрема всю історію комітів, і знаходить випадково закомічені секрети: ключі хмарних сервісів, токени, паролі, приватні ключі. Можна запускати перед комітом (pre-commit hook) або в CI, щоб секрет не потрапив у репозиторій. Відкритий код.', 'Gitleaks scans a repository, including its full commit history, and finds accidentally committed secrets: cloud keys, tokens, passwords and private keys. It can run as a pre-commit hook or in CI so that a secret never reaches the repository. Open source.', 'Пошук секретів у коді й історії Git
Pre-commit hook
Запуск у CI
Відкритий код', 'Secrets in code and Git history
Pre-commit hook
Runs in CI
Open source', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/gitleaks/gitleaks' OR LOWER(`name`) = 'gitleaks') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source tool for finding passwords, API keys and tokens in code and Git history.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Gitleaks scans a repository, including its full commit history, and finds accidentally committed secrets: cloud keys, tokens, passwords and private keys. It can run as a pre-commit hook or in CI so that a secret never reaches the repository. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Secrets in code and Git history
Pre-commit hook
Runs in CI
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TruffleHog — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/trufflesecurity/trufflehog' OR LOWER(`name`) = 'trufflehog')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TruffleHog', NULL, 'https://github.com/trufflesecurity/trufflehog', NULL, NULL, 'Відкритий пошук витоків облікових даних, який ще й перевіряє, чи знайдений ключ досі дійсний.', 'Open-source leaked credential finder that also checks whether a found key is still valid.', 'TruffleHog шукає секрети в Git-репозиторіях, файлах, хмарних сховищах, Slack, Jira та інших джерелах і розпізнає сотні типів ключів. Головна особливість — перевірка: інструмент звертається до відповідного сервісу й показує, чи ключ досі працює, тож команда спершу відкликає справді небезпечні. Відкритий код від Truffle Security.', 'TruffleHog searches for secrets in Git repositories, files, cloud storage, Slack, Jira and other sources and recognises hundreds of key types. Its key feature is verification: it calls the relevant service and shows whether a key still works, so the team can revoke the truly dangerous ones first. Open source from Truffle Security.', 'Сотні типів секретів
Перевірка, чи ключ дійсний
Git, файли, хмара, Slack, Jira
Відкритий код', 'Hundreds of secret types
Checks whether a key is live
Git, files, cloud, Slack, Jira
Open source', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/trufflesecurity/trufflehog' OR LOWER(`name`) = 'trufflehog') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source leaked credential finder that also checks whether a found key is still valid.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TruffleHog searches for secrets in Git repositories, files, cloud storage, Slack, Jira and other sources and recognises hundreds of key types. Its key feature is verification: it calls the relevant service and shows whether a key still works, so the team can revoke the truly dangerous ones first. Open source from Truffle Security.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hundreds of secret types
Checks whether a key is live
Git, files, cloud, Slack, Jira
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- OWASP Dependency-Check — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'owasp.org/www-project-dependency-check' OR LOWER(`name`) = 'owasp dependency-check')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OWASP Dependency-Check', NULL, 'https://owasp.org/www-project-dependency-check/', NULL, NULL, 'Відкритий інструмент OWASP, що знаходить у проєкті бібліотеки з відомими вразливостями (SCA).', 'Open-source OWASP tool that finds libraries with known vulnerabilities in a project (SCA).', 'Dependency-Check визначає залежності проєкту (Java, .NET, JavaScript, Python, Ruby та інших) і звіряє їх із базами відомих вразливостей. Звіт показує, які бібліотеки оновити. Працює з командного рядка й як плагін для Maven, Gradle, Jenkins. Безкоштовна альтернатива комерційним SCA-сервісам.', 'Dependency-Check identifies a project''s dependencies (Java, .NET, JavaScript, Python, Ruby and more) and matches them against databases of known vulnerabilities. The report shows which libraries to update. It runs from the command line and as a plugin for Maven, Gradle and Jenkins. A free alternative to commercial SCA services.', 'Аналіз залежностей (SCA)
Бази відомих вразливостей
Maven, Gradle, Jenkins
Відкритий код', 'Software composition analysis
Known vulnerability databases
Maven, Gradle, Jenkins
Open source', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'owasp.org/www-project-dependency-check' OR LOWER(`name`) = 'owasp dependency-check') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source OWASP tool that finds libraries with known vulnerabilities in a project (SCA).', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Dependency-Check identifies a project''s dependencies (Java, .NET, JavaScript, Python, Ruby and more) and matches them against databases of known vulnerabilities. The report shows which libraries to update. It runs from the command line and as a plugin for Maven, Gradle and Jenkins. A free alternative to commercial SCA services.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Software composition analysis
Known vulnerability databases
Maven, Gradle, Jenkins
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Invicti — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'invicti.com' OR LOWER(`name`) = 'invicti')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Invicti', NULL, 'https://www.invicti.com', NULL, NULL, 'Корпоративна платформа безпеки вебзастосунків і API з DAST-сканером, що підтверджує знайдені вразливості.', 'Enterprise web application and API security platform with a DAST scanner that confirms findings.', 'Invicti (до складу якої входить Acunetix) автоматично сканує тисячі сайтів і API на вразливості на кшталт SQL-ін’єкцій і XSS і для частини знахідок безпечно доводить, що вразливість реальна, — так команда менше витрачає часу на хибні спрацювання. Платформа також має SAST, аналіз залежностей і пошук секретів. Ціни — за запитом.', 'Invicti (which includes Acunetix) automatically scans thousands of websites and APIs for vulnerabilities such as SQL injection and XSS and, for many findings, safely proves that the flaw is real, so the team spends less time on false positives. The platform also offers SAST, dependency analysis and secret detection. Pricing on request.', 'DAST-сканування сайтів і API
Підтвердження вразливостей
SAST, SCA, секрети
Інтеграція з CI', 'DAST for websites and APIs
Proof of exploitability
SAST, SCA, secrets
CI integration', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'invicti.com' OR LOWER(`name`) = 'invicti') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Enterprise web application and API security platform with a DAST scanner that confirms findings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Invicti (which includes Acunetix) automatically scans thousands of websites and APIs for vulnerabilities such as SQL injection and XSS and, for many findings, safely proves that the flaw is real, so the team spends less time on false positives. The platform also offers SAST, dependency analysis and secret detection. Pricing on request.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'DAST for websites and APIs
Proof of exploitability
SAST, SCA, secrets
CI integration', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Detectify — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'detectify.com' OR LOWER(`name`) = 'detectify')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Detectify', NULL, 'https://detectify.com', NULL, NULL, 'Хмарний сканер безпеки вебзастосунків і API на основі досліджень спільноти етичних хакерів.', 'Cloud web application and API security scanner built on research from a community of ethical hackers.', 'Detectify постійно стежить за зовнішньою поверхнею атаки компанії — доменами, піддоменами, сайтами й API — і перевіряє їх на вразливості, які знаходять учасники його спільноти етичних хакерів. Не потребує встановлення. Є тариф Starter для невеликих команд, пробний період і платні тарифи для бізнесу.', 'Detectify continuously monitors a company''s external attack surface (domains, subdomains, websites and APIs) and tests it for vulnerabilities found by its community of ethical hackers. Nothing to install. A Starter plan for small teams, a trial and paid business plans are available.', 'Сканування сайтів і API
Моніторинг піддоменів
Перевірки від спільноти хакерів
Хмарний сервіс', 'Website and API scanning
Subdomain monitoring
Checks from a hacker community
Cloud service', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'detectify.com' OR LOWER(`name`) = 'detectify') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Cloud web application and API security scanner built on research from a community of ethical hackers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Detectify continuously monitors a company''s external attack surface (domains, subdomains, websites and APIs) and tests it for vulnerabilities found by its community of ethical hackers. Nothing to install. A Starter plan for small teams, a trial and paid business plans are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Website and API scanning
Subdomain monitoring
Checks from a hacker community
Cloud service', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовний тариф або версія з обмеженнями.', 'A free plan or limited free version is available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free plan or limited free version is available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Intruder — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'intruder.io' OR LOWER(`name`) = 'intruder')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Intruder', NULL, 'https://www.intruder.io', NULL, NULL, 'Хмарне управління вразливостями для невеликих команд безпеки: інфраструктура, вебзастосунки, хмара.', 'Cloud vulnerability management for lean security teams: infrastructure, web apps and cloud.', 'Intruder регулярно сканує зовнішні й внутрішні сервери, вебзастосунки, API та хмарні акаунти, пріоритезує знайдені вразливості й пояснює, як їх виправити. Стежить за появою нових сервісів, доступних з інтернету. Розрахований на компанії без великого відділу безпеки. Є пробний період.', 'Intruder regularly scans external and internal servers, web apps, APIs and cloud accounts, prioritises the vulnerabilities it finds and explains how to fix them. It watches for new internet-facing services. Built for companies without a large security team. A free trial is available.', 'Сканування інфраструктури й вебзастосунків
Хмарні акаунти
Пріоритети й поради з виправлення
Моніторинг поверхні атаки', 'Infrastructure and web app scanning
Cloud accounts
Prioritised fixes
Attack surface monitoring', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'intruder.io' OR LOWER(`name`) = 'intruder') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Cloud vulnerability management for lean security teams: infrastructure, web apps and cloud.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Intruder regularly scans external and internal servers, web apps, APIs and cloud accounts, prioritises the vulnerabilities it finds and explains how to fix them. It watches for new internet-facing services. Built for companies without a large security team. A free trial is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Infrastructure and web app scanning
Cloud accounts
Prioritised fixes
Attack surface monitoring', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Nessus — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tenable.com/products/nessus' OR LOWER(`name`) = 'nessus')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Nessus', NULL, 'https://www.tenable.com/products/nessus', NULL, NULL, 'Один із найвідоміших сканерів вразливостей від Tenable: перевірка серверів, ОС, мережевого обладнання.', 'One of the best-known vulnerability scanners, from Tenable, for servers, operating systems and network devices.', 'Nessus перевіряє хости на десятки тисяч відомих вразливостей, слабкі налаштування й відсутні оновлення, зокрема з автентифікацією в системі для глибшої перевірки. Звіти групують знахідки за критичністю. Є безкоштовна версія Nessus Essentials для навчання й невеликих мереж та платна Nessus Professional.', 'Nessus checks hosts for tens of thousands of known vulnerabilities, weak configurations and missing patches, including authenticated scans for deeper checks. Reports group findings by severity. A free Nessus Essentials version for learning and small networks and the paid Nessus Professional are available.', 'Десятки тисяч перевірок
Сканування з автентифікацією
Звіти за критичністю
Безкоштовна Nessus Essentials', 'Tens of thousands of checks
Authenticated scanning
Severity-based reports
Free Nessus Essentials', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tenable.com/products/nessus' OR LOWER(`name`) = 'nessus') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'One of the best-known vulnerability scanners, from Tenable, for servers, operating systems and network devices.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Nessus checks hosts for tens of thousands of known vulnerabilities, weak configurations and missing patches, including authenticated scans for deeper checks. Reports group findings by severity. A free Nessus Essentials version for learning and small networks and the paid Nessus Professional are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Tens of thousands of checks
Authenticated scanning
Severity-based reports
Free Nessus Essentials', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовний тариф або версія з обмеженнями.', 'A free plan or limited free version is available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free plan or limited free version is available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- OpenVAS — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'openvas.org' OR LOWER(`name`) = 'openvas')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OpenVAS', NULL, 'https://www.openvas.org', NULL, NULL, 'Відкритий сканер вразливостей від Greenbone зі щоденно оновлюваною базою перевірок.', 'Open-source vulnerability scanner from Greenbone with a daily updated feed of checks.', 'OpenVAS — повнофункціональний сканер вразливостей: перевіряє системи без автентифікації та з нею, підтримує багато інтернет- і промислових протоколів, а тести отримує зі щоденно оновлюваного фіду Greenbone. Безкоштовна альтернатива комерційним сканерам на кшталт Nessus. Відкритий код.', 'OpenVAS is a full-featured vulnerability scanner: it tests systems with and without authentication, supports many internet and industrial protocols and gets its tests from a daily updated Greenbone feed. A free alternative to commercial scanners such as Nessus. Open source.', 'Сканування з автентифікацією й без
Щоденний фід перевірок
Інтернет- і промислові протоколи
Відкритий код', 'Authenticated and unauthenticated scans
Daily updated feed
Internet and industrial protocols
Open source', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'openvas.org' OR LOWER(`name`) = 'openvas') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Open-source vulnerability scanner from Greenbone with a daily updated feed of checks.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'OpenVAS is a full-featured vulnerability scanner: it tests systems with and without authentication, supports many internet and industrial protocols and gets its tests from a daily updated Greenbone feed. A free alternative to commercial scanners such as Nessus. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Authenticated and unauthenticated scans
Daily updated feed
Internet and industrial protocols
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Caido — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'caido.io' OR LOWER(`name`) = 'caido')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Caido', NULL, 'https://caido.io', NULL, NULL, 'Сучасний набір інструментів для ручного тестування безпеки вебзастосунків — легка альтернатива Burp Suite.', 'Modern toolkit for manual web application security testing, a lightweight alternative to Burp Suite.', 'Caido працює як перехоплювальний проксі: показує HTTP-історію з фільтрами на мові HTTPQL, дає змогу змінювати й повторювати запити, автоматизувати перевірки воркфлоу й розширювати плагінами. Платні тарифи додають АІ-асистента й необмежені проєкти. Безкоштовний тариф Basic — 2 проєкти й основні HTTP-інструменти.', 'Caido works as an intercepting proxy: it shows HTTP history with HTTPQL filters and lets you modify and replay requests, automate checks with workflows and extend it with plugins. Paid plans add an AI assistant and unlimited projects. The free Basic plan includes 2 projects and the core HTTP tools.', 'Перехоплювальний проксі
Фільтри HTTPQL
Повтор і зміна запитів
Безкоштовний тариф Basic', 'Intercepting proxy
HTTPQL filters
Replay and modify requests
Free Basic plan', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'caido.io' OR LOWER(`name`) = 'caido') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Modern toolkit for manual web application security testing, a lightweight alternative to Burp Suite.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Caido works as an intercepting proxy: it shows HTTP history with HTTPQL filters and lets you modify and replay requests, automate checks with workflows and extend it with plugins. Paid plans add an AI assistant and unlimited projects. The free Basic plan includes 2 projects and the core HTTP tools.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Intercepting proxy
HTTPQL filters
Replay and modify requests
Free Basic plan', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовний тариф або версія з обмеженнями.', 'A free plan or limited free version is available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free plan or limited free version is available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- ffuf — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/ffuf/ffuf' OR LOWER(`name`) = 'ffuf')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'ffuf', NULL, 'https://github.com/ffuf/ffuf', NULL, NULL, 'Швидкий відкритий веб-фазер на Go: пошук прихованих сторінок, файлів, параметрів і піддоменів.', 'Fast open-source web fuzzer written in Go for finding hidden pages, files, parameters and subdomains.', 'ffuf підставляє значення зі словника в будь-яку частину запиту — шлях, параметр, заголовок, тіло — і за кодом відповіді, розміром чи вмістом показує цікаві результати. Так знаходять забуті адмінки, резервні копії, тестові сторінки й незадокументовані параметри API. Відкритий код.', 'ffuf substitutes wordlist values into any part of a request (path, parameter, header or body) and highlights interesting results by status code, size or content. That is how forgotten admin panels, backups, test pages and undocumented API parameters are found. Open source.', 'Фазинг шляхів, параметрів, заголовків
Фільтри за кодом і розміром
Дуже швидкий
Відкритий код', 'Fuzzing paths, parameters, headers
Filters by status and size
Very fast
Open source', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/ffuf/ffuf' OR LOWER(`name`) = 'ffuf') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Fast open-source web fuzzer written in Go for finding hidden pages, files, parameters and subdomains.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'ffuf substitutes wordlist values into any part of a request (path, parameter, header or body) and highlights interesting results by status code, size or content. That is how forgotten admin panels, backups, test pages and undocumented API parameters are found. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Fuzzing paths, parameters, headers
Filters by status and size
Very fast
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- HTTP Observatory — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'developer.mozilla.org/en-us/observatory' OR LOWER(`name`) = 'http observatory')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HTTP Observatory', NULL, 'https://developer.mozilla.org/en-US/observatory', NULL, NULL, 'Безкоштовна перевірка заголовків безпеки сайту від MDN (Mozilla): CSP, HSTS, cookies та інші.', 'Free website security header check from MDN (Mozilla): CSP, HSTS, cookies and more.', 'HTTP Observatory перевіряє, чи правильно сайт налаштував заголовки безпеки — Content-Security-Policy, Strict-Transport-Security, X-Frame-Options, атрибути cookies тощо, — ставить оцінку й дає конкретні рекомендації з виправлення. Достатньо ввести адресу сайту.', 'HTTP Observatory checks whether a site has configured its security headers correctly (Content-Security-Policy, Strict-Transport-Security, X-Frame-Options, cookie attributes and more), gives a grade and offers concrete fixes. Just enter the site address.', 'Перевірка CSP, HSTS, cookies
Оцінка сайту
Рекомендації з виправлення
Безкоштовно', 'CSP, HSTS and cookie checks
Site grade
Actionable recommendations
Free', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'developer.mozilla.org/en-us/observatory' OR LOWER(`name`) = 'http observatory') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free website security header check from MDN (Mozilla): CSP, HSTS, cookies and more.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'HTTP Observatory checks whether a site has configured its security headers correctly (Content-Security-Policy, Strict-Transport-Security, X-Frame-Options, cookie attributes and more), gives a grade and offers concrete fixes. Just enter the site address.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'CSP, HSTS and cookie checks
Site grade
Actionable recommendations
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- SSL Labs — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ssllabs.com/ssltest' OR LOWER(`name`) = 'ssl labs')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'SSL Labs', NULL, 'https://www.ssllabs.com/ssltest/', NULL, NULL, 'Безкоштовна перевірка налаштувань HTTPS вебсервера від Qualys: сертифікат, протоколи, шифри.', 'Free Qualys check of a web server''s HTTPS setup: certificate, protocols and ciphers.', 'SSL Server Test від Qualys SSL Labs аналізує HTTPS публічного сервера: дійсність і ланцюжок сертифіката, підтримувані версії TLS, набори шифрів, відомі вразливості протоколу — і ставить оцінку від A+ до F. Стандартний інструмент, щоб переконатися, що сайт не використовує застарілих налаштувань.', 'The Qualys SSL Labs SSL Server Test analyses a public server''s HTTPS: certificate validity and chain, supported TLS versions, cipher suites and known protocol vulnerabilities, and gives a grade from A+ to F. The standard way to make sure a site isn''t using outdated settings.', 'Перевірка сертифіката й ланцюжка
Версії TLS і шифри
Оцінка від A+ до F
Безкоштовно', 'Certificate and chain check
TLS versions and ciphers
A+ to F grade
Free', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'ssllabs.com/ssltest' OR LOWER(`name`) = 'ssl labs') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Free Qualys check of a web server''s HTTPS setup: certificate, protocols and ciphers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'The Qualys SSL Labs SSL Server Test analyses a public server''s HTTPS: certificate validity and chain, supported TLS versions, cipher suites and known protocol vulnerabilities, and gives a grade from A+ to F. The standard way to make sure a site isn''t using outdated settings.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Certificate and chain check
TLS versions and ciphers
A+ to F grade
Free', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Security Headers — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'securityheaders.com' OR LOWER(`name`) = 'security headers')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Security Headers', NULL, 'https://securityheaders.com', NULL, NULL, 'Швидкий онлайн-аналіз HTTP-заголовків безпеки сайту з оцінкою від A+ до F.', 'Quick online analysis of a website''s HTTP security headers with an A+ to F grade.', 'Security Headers за кілька секунд показує, які заголовки безпеки сайт надсилає, а яких бракує (Content-Security-Policy, Strict-Transport-Security, Referrer-Policy, Permissions-Policy та інші), і ставить загальну оцінку. Зручно для швидкої перевірки після релізу чи зміни налаштувань сервера. Є API.', 'Security Headers shows in seconds which security headers a site sends and which are missing (Content-Security-Policy, Strict-Transport-Security, Referrer-Policy, Permissions-Policy and others) and gives an overall grade. Handy for a quick check after a release or server change. An API is available.', 'Аналіз заголовків безпеки
Оцінка від A+ до F
Пояснення кожного заголовка
API', 'Security header analysis
A+ to F grade
Explanation of each header
API', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'securityheaders.com' OR LOWER(`name`) = 'security headers') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Quick online analysis of a website''s HTTP security headers with an A+ to F grade.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Security Headers shows in seconds which security headers a site sends and which are missing (Content-Security-Policy, Strict-Transport-Security, Referrer-Policy, Permissions-Policy and others) and gives an overall grade. Handy for a quick check after a release or server change. An API is available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Security header analysis
A+ to F grade
Explanation of each header
API', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- HackerOne — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hackerone.com' OR LOWER(`name`) = 'hackerone')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'HackerOne', NULL, 'https://www.hackerone.com', NULL, NULL, 'Платформа bug bounty й тестування безпеки за участю найбільшої спільноти дослідників безпеки.', 'Bug bounty and security testing platform powered by the largest community of security researchers.', 'HackerOne допомагає компаніям запускати програми bug bounty, приймати звіти про вразливості (vulnerability disclosure) і замовляти пентести в спільноти етичних хакерів, а також тестувати безпеку АІ-систем. Для дослідників це легальний спосіб шукати вразливості в продуктах, власники яких дозволили це, і отримувати винагороди.', 'HackerOne helps companies run bug bounty programmes, receive vulnerability reports (vulnerability disclosure) and order pentests from a community of ethical hackers, as well as test the security of AI systems. For researchers it is a legal way to look for vulnerabilities in products whose owners allow it and to earn rewards.', 'Програми bug bounty
Приймання звітів про вразливості
Пентести від спільноти
Тестування безпеки АІ', 'Bug bounty programmes
Vulnerability disclosure
Community pentests
AI security testing', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hackerone.com' OR LOWER(`name`) = 'hackerone') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Bug bounty and security testing platform powered by the largest community of security researchers.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'HackerOne helps companies run bug bounty programmes, receive vulnerability reports (vulnerability disclosure) and order pentests from a community of ethical hackers, as well as test the security of AI systems. For researchers it is a legal way to look for vulnerabilities in products whose owners allow it and to earn rewards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Bug bounty programmes
Vulnerability disclosure
Community pentests
AI security testing', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Bugcrowd — Тестування, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bugcrowd.com' OR LOWER(`name`) = 'bugcrowd')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Bugcrowd', NULL, 'https://www.bugcrowd.com', NULL, NULL, 'Краудсорсингова платформа кібербезпеки: bug bounty, пентести й програми розкриття вразливостей.', 'Crowdsourced cybersecurity platform: bug bounty, pentesting and vulnerability disclosure programmes.', 'Bugcrowd з’єднує компанії з дослідниками безпеки: програми bug bounty, пентести як сервіс і програми розкриття вразливостей, через які будь-хто може повідомити компанії про знайдену проблему. Для дослідників — легальні цілі для пошуку вразливостей і винагороди.', 'Bugcrowd connects companies with security researchers through bug bounty programmes, pentesting as a service and vulnerability disclosure programmes that let anyone report a problem to the company. For researchers it offers legal targets and rewards.', 'Bug bounty
Пентести як сервіс
Програми розкриття вразливостей
Спільнота дослідників', 'Bug bounty
Pentesting as a service
Vulnerability disclosure programmes
Researcher community', 'QA-інженери, пентестери, DevSecOps-інженери й розробники, що перевіряють захищеність застосунків і інфраструктури', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'bugcrowd.com' OR LOWER(`name`) = 'bugcrowd') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'testing' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Crowdsourced cybersecurity platform: bug bounty, pentesting and vulnerability disclosure programmes.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Bugcrowd connects companies with security researchers through bug bounty programmes, pentesting as a service and vulnerability disclosure programmes that let anyone report a problem to the company. For researchers it offers legal targets and rewards.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Bug bounty
Pentesting as a service
Vulnerability disclosure programmes
Researcher community', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'QA engineers, pentesters, DevSecOps engineers and developers checking the security of applications and infrastructure', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Hack The Box — Тренажери для тестувальників, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hackthebox.com' OR LOWER(`name`) = 'hack the box')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'Hack The Box', NULL, 'https://www.hackthebox.com', NULL, NULL, 'Платформа для практики кібербезпеки: тисячі хакерських лабораторій, курси Academy й змагання.', 'Cybersecurity practice platform with thousands of hacking labs, Academy courses and competitions.', 'Hack The Box дає легальні вразливі машини й завдання, на яких тренуються тестувати безпеку вебзастосунків, мереж і систем. HTB Academy пропонує курси від основ до просунутого рівня, є змагання CTF і сертифікації. Почати можна безкоштовно, розширений доступ — за підпискою.', 'Hack The Box provides legal vulnerable machines and challenges to practise testing the security of web apps, networks and systems. HTB Academy offers courses from the basics to advanced level, plus CTF competitions and certifications. You can start for free; extended access requires a subscription.', 'Тисячі лабораторій
Курси HTB Academy
CTF-змагання
Сертифікації', 'Thousands of labs
HTB Academy courses
CTF competitions
Certifications', 'Тестувальники й студенти, які вчаться тестуванню безпеки та етичному хакінгу на легальних тренажерах', 'Testers and students learning security testing and ethical hacking on legal practice platforms', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'hackthebox.com' OR LOWER(`name`) = 'hack the box') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Cybersecurity practice platform with thousands of hacking labs, Academy courses and competitions.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'Hack The Box provides legal vulnerable machines and challenges to practise testing the security of web apps, networks and systems. HTB Academy offers courses from the basics to advanced level, plus CTF competitions and certifications. You can start for free; extended access requires a subscription.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Thousands of labs
HTB Academy courses
CTF competitions
Certifications', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers and students learning security testing and ethical hacking on legal practice platforms', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовний тариф або версія з обмеженнями.', 'A free plan or limited free version is available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free plan or limited free version is available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- TryHackMe — Тренажери для тестувальників, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tryhackme.com' OR LOWER(`name`) = 'tryhackme')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'TryHackMe', NULL, 'https://tryhackme.com', NULL, NULL, 'Онлайн-платформа для навчання кібербезпеці через практичні лабораторії прямо в браузері.', 'Online platform for learning cybersecurity through hands-on labs right in the browser.', 'TryHackMe веде від основ до професійних навичок через гейміфіковані «кімнати» й навчальні шляхи: вебвразливості, мережі, Linux, пентест, захист. Віртуальні машини запускаються в браузері, тож нічого не потрібно встановлювати. Підходить для повних новачків. Є безкоштовний доступ і преміум-підписка.', 'TryHackMe takes you from the basics to professional skills through gamified rooms and learning paths: web vulnerabilities, networking, Linux, pentesting and defence. Virtual machines run in the browser, so there''s nothing to install. Suitable for complete beginners. Free access and a premium subscription are available.', 'Практичні лабораторії в браузері
Навчальні шляхи
Для новачків
Безкоштовний доступ', 'Hands-on labs in the browser
Learning paths
Beginner-friendly
Free access', 'Тестувальники й студенти, які вчаться тестуванню безпеки та етичному хакінгу на легальних тренажерах', 'Testers and students learning security testing and ethical hacking on legal practice platforms', 'web', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'tryhackme.com' OR LOWER(`name`) = 'tryhackme') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Online platform for learning cybersecurity through hands-on labs right in the browser.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'TryHackMe takes you from the basics to professional skills through gamified rooms and learning paths: web vulnerabilities, networking, Linux, pentesting and defence. Virtual machines run in the browser, so there''s nothing to install. Suitable for complete beginners. Free access and a premium subscription are available.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Hands-on labs in the browser
Learning paths
Beginner-friendly
Free access', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers and students learning security testing and ethical hacking on legal practice platforms', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Є безкоштовний тариф або версія з обмеженнями.', 'A free plan or limited free version is available.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'A free plan or limited free version is available.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- DVWA — Тренажери для тестувальників, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/digininja/dvwa' OR LOWER(`name`) = 'dvwa')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'DVWA', NULL, 'https://github.com/digininja/DVWA', NULL, NULL, 'Damn Vulnerable Web Application — навмисно вразливий PHP-застосунок для локальної практики тестування безпеки.', 'Damn Vulnerable Web Application: a deliberately vulnerable PHP app for practising security testing locally.', 'DVWA містить типові вебвразливості — SQL-ін’єкції, XSS, CSRF, завантаження файлів, ін’єкції команд — із кількома рівнями складності захисту. Його розгортають локально (наприклад, у Docker) і тренуються, зокрема з Burp Suite, ZAP чи sqlmap, не порушуючи закону. Не можна розміщувати в інтернеті. Відкритий код.', 'DVWA contains common web vulnerabilities (SQL injection, XSS, CSRF, file upload and command injection) with several security difficulty levels. You deploy it locally (for example in Docker) and practise legally, including with Burp Suite, ZAP or sqlmap. It must not be exposed to the internet. Open source.', 'Типові вебвразливості
Рівні складності
Локальне розгортання
Відкритий код', 'Common web vulnerabilities
Difficulty levels
Local deployment
Open source', 'Тестувальники й студенти, які вчаться тестуванню безпеки та етичному хакінгу на легальних тренажерах', 'Testers and students learning security testing and ethical hacking on legal practice platforms', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/digininja/dvwa' OR LOWER(`name`) = 'dvwa') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Damn Vulnerable Web Application: a deliberately vulnerable PHP app for practising security testing locally.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'DVWA contains common web vulnerabilities (SQL injection, XSS, CSRF, file upload and command injection) with several security difficulty levels. You deploy it locally (for example in Docker) and practise legally, including with Burp Suite, ZAP or sqlmap. It must not be exposed to the internet. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'Common web vulnerabilities
Difficulty levels
Local deployment
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers and students learning security testing and ethical hacking on legal practice platforms', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- OWASP crAPI — Тренажери для тестувальників, Безпека коду та застосунків
SET @new = IF(NOT EXISTS (SELECT 1 FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/owasp/crapi' OR LOWER(`name`) = 'owasp crapi')), 1, 0);
INSERT INTO `products` (`name`, `logo_url`, `official_url`, `internal_registration_url`, `affiliate_url`, `short_description`, `short_description_en`, `full_description`, `full_description_en`, `main_features`, `main_features_en`, `target_audience`, `target_audience_en`, `platform`, `skill_level`, `status`, `is_archived`, `partnership_status`, `created_by`, `created_at`) SELECT 'OWASP crAPI', NULL, 'https://github.com/OWASP/crAPI', NULL, NULL, 'Completely Ridiculous API — навмисно вразливий API від OWASP для практики тестування безпеки API.', 'Completely Ridiculous API: a deliberately vulnerable API from OWASP for practising API security testing.', 'crAPI імітує сервіс для власників автомобілів із мікросервісами, мобільним і веб-клієнтом і містить вразливості зі списку OWASP API Security Top 10: доступ до чужих об’єктів, слабку автентифікацію, надмірне розкриття даних тощо. Розгортається локально в Docker. Відкритий код.', 'crAPI simulates a service for car owners with microservices and mobile and web clients and contains vulnerabilities from the OWASP API Security Top 10: access to other users'' objects, broken authentication, excessive data exposure and more. Deployed locally in Docker. Open source.', 'Вразливості OWASP API Top 10
Мікросервісна архітектура
Локально в Docker
Відкритий код', 'OWASP API Top 10 vulnerabilities
Microservice architecture
Local Docker deployment
Open source', 'Тестувальники й студенти, які вчаться тестуванню безпеки та етичному хакінгу на легальних тренажерах', 'Testers and students learning security testing and ethical hacking on legal practice platforms', 'desktop', 'none', 'published', 0, 'found', @uid, '2026-11-04 00:00:00' FROM DUAL WHERE @new = 1;
SET @pid = (SELECT `id` FROM `products` WHERE (LOWER(TRIM(TRAILING '/' FROM REPLACE(REPLACE(REPLACE(REPLACE(`official_url`, 'https://www.', ''), 'http://www.', ''), 'https://', ''), 'http://', ''))) = 'github.com/owasp/crapi' OR LOWER(`name`) = 'owasp crapi') ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, @cat FROM DUAL WHERE @pid IS NOT NULL AND @cat IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'qa-practice' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'short_description', 'en', 'Completely Ridiculous API: a deliberately vulnerable API from OWASP for practising API security testing.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'full_description', 'en', 'crAPI simulates a service for car owners with microservices and mobile and web clients and contains vulnerabilities from the OWASP API Security Top 10: access to other users'' objects, broken authentication, excessive data exposure and more. Deployed locally in Docker. Open source.', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'main_features', 'en', 'OWASP API Top 10 vulnerabilities
Microservice architecture
Local Docker deployment
Open source', 'manual' FROM DUAL WHERE @new = 1;
INSERT IGNORE INTO `product_translations` (`product_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @pid, 'target_audience', 'en', 'Testers and students learning security testing and ethical hacking on legal practice platforms', 'manual' FROM DUAL WHERE @new = 1;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Ціна: див. сайт', 'Price: see website', 0.00, 'one_time', 'Актуальні ціни — на офіційному сайті.', 'Current prices are on the official website.' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Ціна: див. сайт' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Price: see website', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Current prices are on the official website.', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT INTO `pricing_plans` (`product_id`, `plan_name`, `plan_name_en`, `price`, `period`, `description`, `description_en`) SELECT @pid, 'Free', 'Free', 0.00, 'free', 'Безкоштовно (безкоштовний продукт або відкритий код).', 'Free (free product or open source).' FROM DUAL WHERE @new = 1;
SET @plan = IF(@new = 1, (SELECT `id` FROM `pricing_plans` WHERE `product_id` = @pid AND `plan_name` = 'Free' ORDER BY `id` DESC LIMIT 1), NULL);
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'plan_name', 'en', 'Free', 'manual' FROM DUAL WHERE @plan IS NOT NULL;
INSERT IGNORE INTO `pricing_plan_translations` (`plan_id`, `field_name`, `lang`, `translated_text`, `source`) SELECT @plan, 'description', 'en', 'Free (free product or open source).', 'manual' FROM DUAL WHERE @plan IS NOT NULL;

-- Наявні продукти → «Безпека коду та застосунків»
SET @sub = (SELECT `id` FROM `subcategories` WHERE `slug` = 'appsec' LIMIT 1);
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'OWASP Juice Shop' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'PortSwigger Web Security Academy' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'MobSF' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'Frida' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
SET @pid = (SELECT `id` FROM `products` WHERE `name` = 'mitmproxy' ORDER BY `id` LIMIT 1);
INSERT IGNORE INTO `product_subcategories` (`product_id`, `subcategory_id`) SELECT @pid, @sub FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
INSERT IGNORE INTO `product_categories` (`product_id`, `category_id`) SELECT @pid, (SELECT `category_id` FROM `subcategories` WHERE `id` = @sub) FROM DUAL WHERE @pid IS NOT NULL AND @sub IS NOT NULL;
